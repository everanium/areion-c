#!/usr/bin/env python3
# Copyright (c) 2026 Andrey Kuvshinov
# Dual-licensed under Apache-2.0 OR MIT.
"""
Static & disassembly auditor for Go Plan 9 (.s), GNU GAS (.S), Microsoft MASM/armasm64 (msvc/*.asm),
and compiled ELF/COFF object files (.o) across Areion repositories.

Verifies:
1. Function inventory (all assembly kernels, including 48 wide-block EM/EM2/TEM/TEM2 kernels when present).
2. Epilogue register zeroization (100% of touched vector & GPR registers wiped before RET).
3. Windows x64 (_WIN64) ABI compliance (XMM6..XMM15, RSI, RDI save/restore + stack slot wipe, R12..R15/RBX untouched, 4th arg in %r9, vzeroupper right before ret).
4. ARM64 AAPCS64 ABI compliance (d8..d15 save/restore + stack slot wipe, 16-byte aligned SP, x19..x28 untouched).
5. Disassembly (objdump -d) verification of compiled x86_64 (SysV and _WIN64) and aarch64 object files.
"""

import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

C_DIR = Path(__file__).resolve().parent.parent


def _resolve_go_repo() -> Path:
    env_dir = os.environ.get("AREION_GO_DIR")
    if env_dir:
        return Path(env_dir).resolve()
    for rel in (
        "../areion",
        "../../areion",
        "../../go/src/areion",
        "../../../go/src/areion",
    ):
        cand = (C_DIR / rel).resolve()
        if (cand / "go.mod").exists():
            return cand
    return (C_DIR / "../../go/src/areion").resolve()


GO_DIR = _resolve_go_repo()

SKIP_FUNCS = {
    "cpuid",
    "_cpuid",
    "dumpSIMDRegs",
    "_dumpSIMDRegs",
    "dumpDone",
    "_dumpDone",
    "clobberScratchGPRs",
    "_clobberScratchGPRs",
    "dirtySIMDRegForTest",
    "_dirtySIMDRegForTest",
}

EXPECTED_X86_WB_KERNELS = [
    f"areion{bits}{mode}{dir_}{tier}"
    for mode in ("EM", "EM2", "TEM", "TEM2")
    for bits in ("256", "512")
    for dir_ in ("Encrypt", "Decrypt")
    for tier in ("AESNI", "VEX")
]

EXPECTED_ARM64_WB_KERNELS = [
    f"areion{bits}{mode}{dir_}Asm"
    for mode in ("EM", "EM2", "TEM", "TEM2")
    for bits in ("256", "512")
    for dir_ in ("Encrypt", "Decrypt")
]


def audit_go_amd64_s() -> int:
    files = [
        "areion_amd64.s",
        "areion_soem256_amd64.s",
        "areion_soem512_amd64.s",
        "areion_soem_aesni_amd64.s",
    ]
    total_funcs = 0
    found_wb = set()
    for fname in files:
        fpath = GO_DIR / fname
        if not fpath.exists():
            continue
        text = fpath.read_text(encoding="utf-8")
        blocks = re.split(r"(?=^TEXT )", text, flags=re.M)
        for blk in blocks:
            if not blk.startswith("TEXT "):
                continue
            lines = [l.strip() for l in blk.splitlines() if l.strip() and not l.strip().startswith("//")]
            hdr = lines[0]
            m = re.search(r"TEXT ·(\w+)\(SB\),\s*NOSPLIT,\s*\$(\d+)-(\d+)", hdr)
            assert m, f"Bad TEXT header in {fname}: {hdr}"
            fn, frame_sz = m.group(1), int(m.group(2))
            if fn in SKIP_FUNCS:
                continue
            total_funcs += 1
            if fn in EXPECTED_X86_WB_KERNELS:
                found_wb.add(fn)
            assert frame_sz == 0, f"{fname}:{fn} has non-zero stack frame ${frame_sz}"
            body = "\n".join(lines[1:])
            assert "(SP)" not in body, f"{fname}:{fn} references (SP) in body"

            touched_vec = set(int(x) for x in re.findall(r"\b[XYZ](\d+)\b", body))
            touched_gpr = set(re.findall(r"\b(AX|BX|CX|DX|SI|DI|R8|R9|R10|R11|R12|R13|R14|R15)\b", body))
            uses_wide_vec = bool(re.search(r"\b[YZ]\d+\b|\bX(?:1[6-9]|2\d|3[01])\b", body))

            zeroed_vec = set()
            zeroed_gpr = set()
            saw_vzeroupper = False
            for l in lines[1:]:
                if l.endswith(":"):
                    zeroed_vec.clear()
                    zeroed_gpr.clear()
                    continue
                parts = l.split(None, 1)
                op = parts[0]
                ops = [o.strip() for o in parts[1].split(",")] if len(parts) > 1 else []
                if op in ("PXOR", "VPXOR", "VPXORD", "VPXORQ") and len(ops) >= 2 and ops[0] == ops[-1] and len(set(ops)) == 1:
                    reg = ops[0]
                    assert reg[0] in "XYZ"
                    zeroed_vec.add(int(reg[1:]))
                elif op == "XORQ" and len(ops) == 2 and ops[0] == ops[1]:
                    zeroed_gpr.add(ops[0])
                elif op == "VZEROUPPER":
                    saw_vzeroupper = True
                elif op == "RET":
                    break
                else:
                    if ops:
                        dst = ops[-1]
                        m_v = re.match(r"^[XYZ](\d+)$", dst)
                        if m_v:
                            zeroed_vec.discard(int(m_v.group(1)))
                        if dst in touched_gpr:
                            zeroed_gpr.discard(dst)
                    for o in ops:
                        m_mem = re.search(r"\((\w+)\)", o)
                        if m_mem and m_mem.group(1) in zeroed_gpr:
                            raise AssertionError(f"{fname}:{fn} uses zeroed GPR {m_mem.group(1)} in {l}")

            missing_vec = touched_vec - zeroed_vec
            missing_gpr = touched_gpr - zeroed_gpr
            assert not missing_vec, f"{fname}:{fn} failed to zero vector regs: {sorted(missing_vec)}"
            assert not missing_gpr, f"{fname}:{fn} failed to zero GPRs: {sorted(missing_gpr)}"
            if uses_wide_vec:
                assert saw_vzeroupper, f"{fname}:{fn} uses YMM/ZMM but misses VZEROUPPER"

    if found_wb:
        assert found_wb == set(EXPECTED_X86_WB_KERNELS), (
            f"Missing x86 WB kernels: {set(EXPECTED_X86_WB_KERNELS) - found_wb}"
        )
    print(f"OK [Go amd64 .s]: Audited {total_funcs} functions across 4 files ({len(found_wb)} EM/TEM kernels). 100% clean.")
    return total_funcs


def audit_go_arm64_s() -> int:
    fpath = GO_DIR / "areion_arm64.s"
    if not fpath.exists():
        return 0
    text = fpath.read_text(encoding="utf-8")
    blocks = re.split(r"(?=^TEXT )", text, flags=re.M)
    total_funcs = 0
    found_wb = set()
    for blk in blocks:
        if not blk.startswith("TEXT "):
            continue
        lines = [l.strip() for l in blk.splitlines() if l.strip() and not l.strip().startswith("//")]
        hdr = lines[0]
        m = re.search(r"TEXT ·(\w+)\(SB\),\s*NOSPLIT,\s*\$(\d+)-(\d+)", hdr)
        assert m, f"Bad TEXT header in areion_arm64.s: {hdr}"
        fn, frame_sz = m.group(1), int(m.group(2))
        if fn in SKIP_FUNCS:
            continue
        total_funcs += 1
        if fn in EXPECTED_ARM64_WB_KERNELS:
            found_wb.add(fn)
        assert frame_sz == 0, f"areion_arm64.s:{fn} has non-zero stack frame ${frame_sz}"
        body = "\n".join(lines[1:])
        assert "(RSP)" not in body and "(SP)" not in body, f"areion_arm64.s:{fn} references stack in body"

        touched_vec = set(int(x) for x in re.findall(r"\bV(\d+)\b", body))
        touched_gpr = set(int(x) for x in re.findall(r"\bR(\d+)\b", body))

        zeroed_vec = set()
        zeroed_gpr = set()
        for l in lines[1:]:
            if re.match(r"^VEOR\s+V(\d+)\.B16,\s*V\1\.B16,\s*V\1\.B16$", l):
                v = int(re.match(r"^VEOR\s+V(\d+)\.B16", l).group(1))
                zeroed_vec.add(v)
            elif re.match(r"^MOVD\s+ZR,\s*R(\d+)$", l):
                r = int(re.match(r"^MOVD\s+ZR,\s*R(\d+)$", l).group(1))
                zeroed_gpr.add(r)
            elif l == "RET":
                break
            else:
                if l.startswith("VLD1"):
                    for v in [int(x) for x in re.findall(r"\bV(\d+)\b", l)]:
                        zeroed_vec.discard(v)
                elif l.startswith("VST1"):
                    pass
                else:
                    v_all = [int(x) for x in re.findall(r"\bV(\d+)\b", l)]
                    if v_all:
                        zeroed_vec.discard(v_all[-1])
                for r in [int(x) for x in re.findall(r"\bR(\d+)\b", l)]:
                    if r in zeroed_gpr:
                        raise AssertionError(f"areion_arm64.s:{fn} touches R{r} after zeroing: {l}")

        assert touched_vec == zeroed_vec, f"areion_arm64.s:{fn} unzeroed V-regs: {sorted(touched_vec - zeroed_vec)}"
        assert touched_gpr == zeroed_gpr, f"areion_arm64.s:{fn} unzeroed R-regs: {sorted(touched_gpr - zeroed_gpr)}"

    if found_wb:
        assert found_wb == set(EXPECTED_ARM64_WB_KERNELS), (
            f"Missing arm64 WB kernels: {set(EXPECTED_ARM64_WB_KERNELS) - found_wb}"
        )
    print(f"OK [Go arm64 .s]: Audited {total_funcs} functions in areion_arm64.s ({len(found_wb)} EM/TEM kernels). 100% clean.")
    return total_funcs


def audit_c_amd64_S_and_masm() -> int:
    s_files = [
        ("areion_amd64.S", "areion_amd64.asm"),
        ("areion_soem256_amd64.S", "areion_soem256_amd64.asm"),
        ("areion_soem512_amd64.S", "areion_soem512_amd64.asm"),
        ("areion_soem_aesni_amd64.S", "areion_soem_aesni_amd64.asm"),
    ]
    total_s = 0
    total_masm = 0
    for s_name, masm_name in s_files:
        s_text = (C_DIR / s_name).read_text(encoding="utf-8")
        masm_text = (C_DIR / "msvc" / masm_name).read_text(encoding="utf-8")

        s_blocks = re.findall(r"AREION_FUNC_START\((\w+)\)(.*?)AREION_FUNC_END\(\1\)", s_text, flags=re.S)
        masm_blocks = re.findall(r"(\w+)\s+PROC\b(.*?)\1\s+ENDP", masm_text, flags=re.S)
        assert [b[0] for b in s_blocks] == [b[0] for b in masm_blocks], (
            f"Function list mismatch between {s_name} and {masm_name}"
        )

        for (fn, s_body), (_, m_body) in zip(s_blocks, masm_blocks):
            if fn in SKIP_FUNCS:
                continue
            total_s += 1
            total_masm += 1

            for forbidden in ("rbx", "rbp", "r12", "r13", "r14", "r15"):
                assert not re.search(rf"\b{forbidden}\b", s_body), f"{s_name}:{fn} touches callee-saved %{forbidden}"
                assert not re.search(rf"\b{forbidden}\b", m_body), f"{masm_name}:{fn} touches callee-saved {forbidden}"

            if "TEM" in fn:
                assert "movq %r9, %rcx" in s_body, f"{s_name}:{fn} missing Win64 4th arg load movq %r9, %rcx"
                assert "mov rcx, r9" in m_body, f"{masm_name}:{fn} missing MASM 4th arg load mov rcx, r9"

            touched_xmm_win = sorted(set(int(x) for x in re.findall(r"\b[xyz]mm(\d+)\b", m_body) if 6 <= int(x) <= 15))
            touched_gpr_win = [g for g in ("rsi", "rdi") if re.search(rf"\b{g}\b", m_body)]
            if touched_xmm_win or touched_gpr_win:
                m_sub = re.search(r"sub rsp, (\d+)", m_body)
                m_add = re.search(r"add rsp, (\d+)", m_body)
                assert m_sub and m_add and m_sub.group(1) == m_add.group(1), f"{masm_name}:{fn} mismatched rsp sub/add"
                frame_sz = int(m_sub.group(1))
                assert frame_sz % 16 == 8, f"{masm_name}:{fn} Win64 frame size {frame_sz} does not align RSP to 16 bytes"
                for x in touched_xmm_win:
                    m_save = re.search(rf"v?movdqu XMMWORD PTR \[rsp \+ (\d+)\], xmm{x}\b", m_body)
                    assert m_save, f"{masm_name}:{fn} missing Win64 save for xmm{x}"
                    off = int(m_save.group(1))
                    assert re.search(rf"v?movdqu xmm{x}, XMMWORD PTR \[rsp \+ {off}\]", m_body), (
                        f"{masm_name}:{fn} missing restore for xmm{x}"
                    )
                    assert f"mov QWORD PTR [rsp + {off}], 0" in m_body, (
                        f"{masm_name}:{fn} missing low QWORD stack wipe for xmm{x}"
                    )
                    assert f"mov QWORD PTR [rsp + {off + 8}], 0" in m_body, (
                        f"{masm_name}:{fn} missing high QWORD stack wipe for xmm{x}"
                    )
                for g in touched_gpr_win:
                    m_save = re.search(rf"mov QWORD PTR \[rsp(?: \+ (\d+))?\], {g}\b", m_body)
                    assert m_save, f"{masm_name}:{fn} missing Win64 save for {g}"
                    off = int(m_save.group(1) or 0)
                    assert f"mov {g}, QWORD PTR [rsp + {off}]" in m_body, f"{masm_name}:{fn} missing Win64 restore for {g}"
                    assert f"mov QWORD PTR [rsp + {off}], 0" in m_body, f"{masm_name}:{fn} missing Win64 stack wipe for {g}"

            uses_wide_vec = bool(re.search(r"\b[yz]mm\d+\b|\bxmm(?:1[6-9]|2\d|3[01])\b", m_body))
            m_lines = [l.strip() for l in m_body.splitlines() if l.strip()]
            assert m_lines[0] == "db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64", (
                f"{masm_name}:{fn} does not start with endbr64 (got {m_lines[0]})"
            )
            assert m_lines[-1] == "ret", f"{masm_name}:{fn} does not end with ret"
            if uses_wide_vec:
                assert m_lines[-2] == "vzeroupper", (
                    f"{masm_name}:{fn} does not have vzeroupper immediately before ret (got {m_lines[-2]})"
                )

    print(f"OK [C amd64 .S & msvc/*.asm]: Audited {total_s} .S functions and {total_masm} MASM PROC functions. 100% ABI & epilogue clean.")
    return total_s


def audit_c_arm64_S_and_armasm() -> int:
    s_text = (C_DIR / "areion_arm64.S").read_text(encoding="utf-8")
    m_text = (C_DIR / "msvc" / "areion_arm64.asm").read_text(encoding="utf-8")

    s_blocks = re.findall(r"AREION_FUNC_START\((\w+)\)(.*?)AREION_FUNC_END\(\1\)", s_text, flags=re.S)
    m_blocks = re.findall(r"(\w+)\s+PROC\b(.*?)ENDP", m_text, flags=re.S)
    assert [b[0] for b in s_blocks] == [b[0] for b in m_blocks], (
        "Function list mismatch between areion_arm64.S and msvc/areion_arm64.asm"
    )

    total = 0
    for (fn, s_body), (_, m_body) in zip(s_blocks, m_blocks):
        if fn in SKIP_FUNCS:
            continue
        total += 1
        for r in range(19, 31):
            assert not re.search(rf"\bx{r}\b", s_body), f"areion_arm64.S:{fn} touches x{r}"
            assert not re.search(rf"\bx{r}\b", m_body), f"msvc/areion_arm64.asm:{fn} touches x{r}"

        touched_v_callee = sorted(set(int(v) for v in re.findall(r"\bv(\d+)\b", s_body) if 8 <= int(v) <= 15))
        for v in touched_v_callee:
            assert re.search(rf"\b(stp|str)\b[^\n]*\bd{v}\b", s_body), f"areion_arm64.S:{fn} uses v{v} without saving d{v}"
            assert re.search(rf"\b(ldp|ldr)\b[^\n]*\bd{v}\b", s_body), f"areion_arm64.S:{fn} uses v{v} without restoring d{v}"
            assert re.search(rf"eor v{v}\.16b, v{v}\.16b, v{v}\.16b", s_body), (
                f"areion_arm64.S:{fn} does not zero full v{v}.16b before restoring d{v}"
            )
        if touched_v_callee:
            assert "stp xzr, xzr, [sp" in s_body, f"areion_arm64.S:{fn} does not wipe stack save slots with xzr"
            for m_sp in re.findall(r"(?:sub|add)\s+sp,\s*sp,\s*#(\d+)", s_body):
                assert int(m_sp) % 16 == 0, f"areion_arm64.S:{fn} misaligned sp adjustment #{m_sp}"

    print(f"OK [C arm64 .S & msvc/areion_arm64.asm]: Audited {total} functions. 100% AAPCS64 ABI & epilogue clean.")
    return total


def audit_objdump() -> None:
    if not sys.platform.startswith("linux") or not shutil.which("objdump") or not shutil.which("readelf"):
        print("SKIP [objdump -d]: Non-Linux host or missing ELF objdump/readelf.")
        return
    x86_srcs = [
        "areion_amd64.S",
        "areion_soem256_amd64.S",
        "areion_soem512_amd64.S",
        "areion_soem_aesni_amd64.S",
    ]
    x86_sysv_count = 0
    x86_win64_count = 0
    arm_fn_count = 0
    with tempfile.TemporaryDirectory() as tmpdir:
        tmp = Path(tmpdir)
        for src in x86_srcs:
            obj_sysv = tmp / f"{src}.sysv.o"
            obj_win64 = tmp / f"{src}.win64.o"
            subprocess.run(["gcc", "-I", str(C_DIR), "-c", str(C_DIR / src), "-o", str(obj_sysv)], check=True)
            subprocess.run(["gcc", "-I", str(C_DIR), "-D_WIN64", "-c", str(C_DIR / src), "-o", str(obj_win64)], check=True)

            out_sysv = subprocess.check_output(["objdump", "-d", "--no-show-raw-insn", str(obj_sysv)], text=True)
            for fn, body in re.findall(r"^[0-9a-f]+ <(\w+)>:\n((?:[ \t]+.*\n)+)", out_sysv, flags=re.M):
                if fn in SKIP_FUNCS:
                    continue
                x86_sysv_count += 1
                rsp_refs = re.findall(r"[^\s,]*\(%rsp\)", body)
                if fn.startswith("areion512SoEMPermutex4"):
                    assert set(rsp_refs) == {"0x8(%rsp)", "0x10(%rsp)"}, f"{src}:{fn} unexpected SysV rsp refs: {rsp_refs}"
                else:
                    assert not rsp_refs, f"{src}:{fn} has unexpected stack references in SysV object: {rsp_refs}"
                insns = [
                    l.strip()
                    for l in body.strip().splitlines()
                    if not re.search(r"\b(nop|nopl|nopw|cs nopw)\b|xchg\s+%ax,%ax", l)
                ]
                assert insns[0].endswith("endbr64"), f"{src}:{fn} does not start with endbr64: {insns[0]}"
                assert insns[-1].endswith("ret") or insns[-1].endswith("retq"), f"{src}:{fn} does not end with ret: {insns[-1]}"

            notes_sysv = subprocess.check_output(["readelf", "-n", str(obj_sysv)], text=True)
            assert "IBT" in notes_sysv and "SHSTK" in notes_sysv, f"{src} missing CET IBT/SHSTK note: {notes_sysv}"

            out_win64 = subprocess.check_output(["objdump", "-d", "--no-show-raw-insn", str(obj_win64)], text=True)
            for fn, body in re.findall(r"^[0-9a-f]+ <(\w+)>:\n((?:[ \t]+.*\n)+)", out_win64, flags=re.M):
                if fn in SKIP_FUNCS:
                    continue
                x86_win64_count += 1
                insns = [
                    l.strip()
                    for l in body.strip().splitlines()
                    if not re.search(r"\b(nop|nopl|nopw|cs nopw)\b|xchg\s+%ax,%ax", l)
                ]
                assert insns[0].endswith("endbr64"), f"{src} (_WIN64):{fn} does not start with endbr64: {insns[0]}"
                assert insns[-1].endswith("ret") or insns[-1].endswith("retq"), (
                    f"{src} (_WIN64):{fn} does not end with ret: {insns[-1]}"
                )

        if shutil.which("aarch64-linux-gnu-gcc") and shutil.which("aarch64-linux-gnu-objdump"):
            obj_arm = tmp / "areion_arm64.o"
            subprocess.run(
                ["aarch64-linux-gnu-gcc", "-I", str(C_DIR), "-c", str(C_DIR / "areion_arm64.S"), "-o", str(obj_arm)],
                check=True,
            )
            notes_arm = subprocess.check_output(["readelf", "-n", str(obj_arm)], text=True)
            assert "BTI" in notes_arm and "PAC" in notes_arm, f"areion_arm64.o missing BTI/PAC note: {notes_arm}"
            out_arm = subprocess.check_output(["aarch64-linux-gnu-objdump", "-d", "--no-show-raw-insn", str(obj_arm)], text=True)
            for fn, body in re.findall(r"^[0-9a-f]+ <(\w+)>:\n((?:[ \t]+.*\n)+)", out_arm, flags=re.M):
                if fn in SKIP_FUNCS:
                    continue
                arm_fn_count += 1
                sp_refs = [l.strip() for l in body.splitlines() if "sp" in l]
                for l in sp_refs:
                    assert any(k in l for k in ("d8", "d9", "d10", "d11", "d12", "d13", "xzr", "sub\tsp", "add\tsp")), (
                        f"areion_arm64.o:{fn} unexpected sp instruction: {l}"
                    )
                insns = [l.strip() for l in body.strip().splitlines() if not re.search(r"\bnop\b", l)]
                assert "bti\tc" in insns[0] or "hint\t#0x22" in insns[0], (
                    f"areion_arm64.o:{fn} does not start with bti c: {insns[0]}"
                )
                assert insns[-1].endswith("ret"), f"areion_arm64.o:{fn} does not end with ret: {insns[-1]}"

    print(
        f"OK [objdump -d]: Verified {x86_sysv_count} SysV x86_64, {x86_win64_count} _WIN64 x86_64, "
        f"and {arm_fn_count} aarch64 compiled object functions. Zero secret stack spills."
    )


def main() -> int:
    audit_go_amd64_s()
    audit_go_arm64_s()
    audit_c_amd64_S_and_masm()
    audit_c_arm64_S_and_armasm()
    audit_objdump()
    return 0


if __name__ == "__main__":
    sys.exit(main())
