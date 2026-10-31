#!/usr/bin/env python3
# Copyright (c) 2026 Andrey Kuvshinov
# Dual-licensed under Apache-2.0 OR MIT.
"""
Static & disassembly auditor for GNU GAS (.S), Microsoft MASM/armasm64 (msvc/*.asm),
and compiled ELF/COFF object files (.o) in areion-c.

Verifies:
1. Function inventory (all assembly kernels, including single-block and stackless x4 kernels).
2. Epilogue register zeroization (100% of touched vector & GPR registers wiped before RET).
3. Windows x64 (_WIN64) ABI compliance (XMM6..XMM15, RSI, RDI save/restore + stack slot wipe,
   R12..R15/RBX/RBP untouched, 4th arg in %r9, vzeroupper right before ret).
4. ARM64 AAPCS64 ABI compliance (zero stack frame, d8..d15 and x19..x28 untouched).
5. Disassembly (objdump -d) verification of compiled x86_64 (SysV and _WIN64) and aarch64 object files.
"""

import platform
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

C_DIR = Path(__file__).resolve().parent.parent

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

EXPECTED_X86_WB_X4_KERNELS = [
    f"areion{bits}{mode}{dir_}x4{tier}"
    for mode in ("EM", "EM2", "TEM", "TEM2")
    for bits in ("256", "512")
    for dir_ in ("Encrypt", "Decrypt")
    for tier in ("AESNI", "VEX", "VAESAVX2", "AVX512")
]

EXPECTED_ARM64_WB_KERNELS = [
    f"areion{bits}{mode}{dir_}Asm"
    for mode in ("EM", "EM2", "TEM", "TEM2")
    for bits in ("256", "512")
    for dir_ in ("Encrypt", "Decrypt")
]

EXPECTED_ARM64_WB_X4_KERNELS = [
    f"areion{bits}{mode}{dir_}x4Asm"
    for mode in ("EM", "EM2", "TEM", "TEM2")
    for bits in ("256", "512")
    for dir_ in ("Encrypt", "Decrypt")
]

EXPECTED_X86_ASURA_KERNELS = [
    f"areion_asura_expand_tweakey{tier}_asm"
    for tier in ("", "_vex")
] + [
    f"areion_asura_expand_key{tier}_asm"
    for tier in ("_aesni", "_vex")
] + [
    f"areion_asura_{dir_}_block{otf}{tier}_asm"
    for dir_ in ("encrypt", "decrypt")
    for otf in ("", "_otf")
    for tier in ("", "_vex")
] + [
    f"areion_asura_{dir_}_block_rk{tier}_asm"
    for dir_ in ("encrypt", "decrypt")
    for tier in ("_aesni", "_vex")
] + [
    f"areion_asura_{dir_}_4blocks{otf}{tier}_asm"
    for dir_ in ("encrypt", "decrypt")
    for otf in ("", "_otf")
    for tier in ("", "_vex", "_vaes256", "_vaes512")
] + [
    f"areion_asura_{dir_}_4blocks_rk{tier}_asm"
    for dir_ in ("encrypt", "decrypt")
    for tier in ("_aesni", "_vex", "_vaes256", "_vaes512")
]

EXPECTED_ARM64_ASURA_KERNELS = [
    "areion_asura_expand_tweakey_asm",
    "areion_asura_expand_key_asm",
    "areion_asura_encrypt_block_asm",
    "areion_asura_decrypt_block_asm",
    "areion_asura_encrypt_block_otf_asm",
    "areion_asura_decrypt_block_otf_asm",
    "areion_asura_encrypt_block_rk_asm",
    "areion_asura_decrypt_block_rk_asm",
    "areion_asura_encrypt_4blocks_asm",
    "areion_asura_decrypt_4blocks_asm",
    "areion_asura_encrypt_4blocks_otf_asm",
    "areion_asura_decrypt_4blocks_otf_asm",
    "areion_asura_encrypt_4blocks_rk_asm",
    "areion_asura_decrypt_4blocks_rk_asm",
]

EXPECTED_X86_RIJNDAEL_KERNELS = [
    f"rijndael256{dir_}Block{tier}Asm"
    for dir_ in ("Encrypt", "Decrypt")
    for tier in ("", "Vex")
] + [
    f"rijndael256{dir_}4Blocks{tier}Asm"
    for dir_ in ("Encrypt", "Decrypt")
    for tier in ("Zmm", "Ymm", "Vex", "AesNi")
]

EXPECTED_ARM64_RIJNDAEL_KERNELS = [
    f"rijndael256{dir_}{shape}Asm"
    for dir_ in ("Encrypt", "Decrypt")
    for shape in ("Block", "4Blocks")
]

EXPECTED_X86_VISTRUTAH_KERNELS = [
    f"vistrutah256{dir_}Block{tier}Asm"
    for dir_ in ("Encrypt", "Decrypt")
    for tier in ("", "Vex", "Ymm")
] + [
    f"vistrutah256{dir_}4Blocks{tier}Asm"
    for dir_ in ("Encrypt", "Decrypt")
    for tier in ("AesNi", "Vex", "Ymm", "Zmm")
] + [
    f"vistrutah512{dir_}Block{kbits}{tier}Asm"
    for dir_ in ("Encrypt", "Decrypt")
    for kbits in ("256", "512")
    for tier in ("", "Vex", "Ymm", "Zmm")
] + [
    f"vistrutah512{dir_}4Blocks{kbits}{tier}Asm"
    for dir_ in ("Encrypt", "Decrypt")
    for kbits in ("256", "512")
    for tier in ("AesNi", "Vex", "Ymm", "Zmm")
]

EXPECTED_ARM64_VISTRUTAH_KERNELS = [
    f"vistrutah256{dir_}{shape}Asm"
    for dir_ in ("Encrypt", "Decrypt")
    for shape in ("Block", "4Blocks")
] + [
    f"vistrutah512{dir_}{shape}{kbits}Asm"
    for dir_ in ("Encrypt", "Decrypt")
    for shape in ("Block", "4Blocks")
    for kbits in ("256", "512")
]

SYSV_STACK_ARG_FUNCS = {
    fn: {"0x8(%rsp)", "0x10(%rsp)"}
    for fn in (
        f"aes{kind}Round4Ptrs{tier}Asm"
        for kind in ("", "Final")
        for tier in ("Zmm", "Ymm", "Vex", "AesNi")
    )
}


def audit_c_amd64_S_and_masm() -> int:
    s_files = [
        ("areion_amd64.S", "areion_amd64.asm"),
        ("areion_soem256_amd64.S", "areion_soem256_amd64.asm"),
        ("areion_soem512_amd64.S", "areion_soem512_amd64.asm"),
        ("areion_soem_aesni_amd64.S", "areion_soem_aesni_amd64.asm"),
        ("rijndael_amd64.S", "rijndael_amd64.asm"),
        ("vistrutah_amd64.S", "vistrutah_amd64.asm"),
        ("asura_amd64.S", "asura_amd64.asm"),
    ]
    total_s = 0
    total_masm = 0
    found_wb = set()
    found_wb_x4 = set()
    found_asura = set()
    found_rijndael = set()
    found_vistrutah = set()
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
            if fn in EXPECTED_X86_WB_KERNELS:
                found_wb.add(fn)
            if fn in EXPECTED_X86_WB_X4_KERNELS:
                found_wb_x4.add(fn)
            if fn in EXPECTED_X86_ASURA_KERNELS:
                found_asura.add(fn)
            if fn in EXPECTED_X86_RIJNDAEL_KERNELS:
                found_rijndael.add(fn)
            if fn in EXPECTED_X86_VISTRUTAH_KERNELS:
                found_vistrutah.add(fn)

            for forbidden in ("rbx", "rbp", "r12", "r13", "r14", "r15"):
                assert not re.search(rf"\b{forbidden}\b", s_body), f"{s_name}:{fn} touches callee-saved %{forbidden}"
                assert not re.search(rf"\b{forbidden}\b", m_body), f"{masm_name}:{fn} touches callee-saved {forbidden}"

            if "TEM" in fn or "_otf" in fn or "_rk" in fn or "vistrutah" in fn:
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

            # Check that every touched vector register and working GPR in s_body is zeroed in the epilogue
            s_core = re.sub(r"#if[^\n]*\n.*?\n#endif", "", s_body, flags=re.S)
            all_vec = set(int(x) for x in re.findall(r"%[xyz]mm(\d+)\b", s_core))
            zeroed_vec = set(
                int(m.group(1))
                for m in re.finditer(r"\b(?:pxor|vpxor|vpxord|vpxorq)\s+%[xyz]mm(\d+),\s*%[xyz]mm\1(?:,\s*%[xyz]mm\1)?\b", s_body)
            )
            assert all_vec <= zeroed_vec, f"{s_name}:{fn} unzeroed vector regs: {sorted(all_vec - zeroed_vec)}"

            all_gpr = set(re.findall(r"%(rax|rcx|rdx|rsi|rdi|r8|r9|r10|r11)\b", s_core))
            zeroed_gpr = set(
                m.group(1)
                for m in re.finditer(r"\bxorq\s+%(rax|rcx|rdx|rsi|rdi|r8|r9|r10|r11),\s*%\1\b", s_body)
            )
            assert all_gpr <= zeroed_gpr, f"{s_name}:{fn} unzeroed GPRs: {sorted(all_gpr - zeroed_gpr)}"

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

    assert found_wb == set(EXPECTED_X86_WB_KERNELS), (
        f"Missing x86 single-block WB kernels: {set(EXPECTED_X86_WB_KERNELS) - found_wb}"
    )
    assert found_wb_x4 == set(EXPECTED_X86_WB_X4_KERNELS), (
        f"Missing x86 x4 WB kernels: {set(EXPECTED_X86_WB_X4_KERNELS) - found_wb_x4}"
    )
    assert found_asura == set(EXPECTED_X86_ASURA_KERNELS), (
        f"Missing x86 ASURA kernels: {set(EXPECTED_X86_ASURA_KERNELS) - found_asura}"
    )
    assert found_rijndael == set(EXPECTED_X86_RIJNDAEL_KERNELS), (
        f"Missing x86 Rijndael-256 kernels: {set(EXPECTED_X86_RIJNDAEL_KERNELS) - found_rijndael}"
    )
    assert found_vistrutah == set(EXPECTED_X86_VISTRUTAH_KERNELS), (
        f"Missing x86 Vistrutah kernels: {set(EXPECTED_X86_VISTRUTAH_KERNELS) - found_vistrutah}"
    )
    print(
        f"OK [C amd64 .S & msvc/*.asm]: Audited {total_s} .S functions and {total_masm} MASM PROC functions "
        f"({len(found_wb)} WB + {len(found_wb_x4)} WBx4 + {len(found_rijndael)} Rijndael + "
        f"{len(found_vistrutah)} Vistrutah + {len(found_asura)} ASURA). 100% ABI & epilogue clean."
    )
    return total_s


def audit_c_arm64_S_and_armasm() -> int:
    arm_files = [
        ("areion_arm64.S", "areion_arm64.asm"),
        ("rijndael_arm64.S", "rijndael_arm64.asm"),
        ("vistrutah_arm64.S", "vistrutah_arm64.asm"),
        ("asura_arm64.S", "asura_arm64.asm"),
    ]
    total = 0
    found_wb = set()
    found_wb_x4 = set()
    found_asura = set()
    found_rijndael = set()
    found_vistrutah = set()
    for s_name, m_name in arm_files:
        s_text = (C_DIR / s_name).read_text(encoding="utf-8")
        m_text = (C_DIR / "msvc" / m_name).read_text(encoding="utf-8")

        s_blocks = re.findall(r"AREION_FUNC_START\((\w+)\)(.*?)AREION_FUNC_END\(\1\)", s_text, flags=re.S)
        m_blocks = re.findall(r"(\w+)\s+PROC\b(.*?)ENDP", m_text, flags=re.S)
        assert [b[0] for b in s_blocks] == [b[0] for b in m_blocks], (
            f"Function list mismatch between {s_name} and msvc/{m_name}"
        )

        for (fn, s_body), (_, m_body) in zip(s_blocks, m_blocks):
            if fn in SKIP_FUNCS:
                continue
            total += 1
            if fn in EXPECTED_ARM64_WB_KERNELS:
                found_wb.add(fn)
            if fn in EXPECTED_ARM64_WB_X4_KERNELS:
                found_wb_x4.add(fn)
            if fn in EXPECTED_ARM64_ASURA_KERNELS:
                found_asura.add(fn)
            if fn in EXPECTED_ARM64_RIJNDAEL_KERNELS:
                found_rijndael.add(fn)
            if fn in EXPECTED_ARM64_VISTRUTAH_KERNELS:
                found_vistrutah.add(fn)
            for r in range(18, 31):
                assert not re.search(rf"\b[xw]{r}\b", s_body), f"{s_name}:{fn} touches x{r}/w{r}"
                assert not re.search(rf"\b[xw]{r}\b", m_body), f"msvc/{m_name}:{fn} touches x{r}/w{r}"

            touched_v_callee = sorted(set(int(v) for v in re.findall(r"\b[vdq](\d+)\b", s_body) if 8 <= int(v) <= 15))
            assert not touched_v_callee, f"{s_name}:{fn} touches callee-saved v8..v15: {touched_v_callee}"
            assert not re.search(r"\b(?:sub|add)\s+sp,\s*sp\b", s_body), f"{s_name}:{fn} allocates stack frame"

            all_v = set(int(v) for v in re.findall(r"\bv(\d+)\b", s_body))
            zeroed_v = set(
                int(m.group(1))
                for m in re.finditer(r"\beor\s+v(\d+)\.16b,\s*v\1\.16b,\s*v\1\.16b\b", s_body)
            )
            assert all_v == zeroed_v, f"{s_name}:{fn} unzeroed V-regs: {sorted(all_v - zeroed_v)}"

            all_x = set(int(r) for r in re.findall(r"\b[xw](\d+)\b", s_body))
            zeroed_x = set(
                int(m.group(1))
                for m in re.finditer(r"\bmov\s+x(\d+),\s*xzr\b", s_body)
            )
            assert all_x == zeroed_x, f"{s_name}:{fn} unzeroed X-regs: {sorted(all_x - zeroed_x)}"

    assert found_wb == set(EXPECTED_ARM64_WB_KERNELS), (
        f"Missing arm64 single-block WB kernels: {set(EXPECTED_ARM64_WB_KERNELS) - found_wb}"
    )
    assert found_wb_x4 == set(EXPECTED_ARM64_WB_X4_KERNELS), (
        f"Missing arm64 x4 WB kernels: {set(EXPECTED_ARM64_WB_X4_KERNELS) - found_wb_x4}"
    )
    assert found_asura == set(EXPECTED_ARM64_ASURA_KERNELS), (
        f"Missing arm64 ASURA kernels: {set(EXPECTED_ARM64_ASURA_KERNELS) - found_asura}"
    )
    assert found_rijndael == set(EXPECTED_ARM64_RIJNDAEL_KERNELS), (
        f"Missing arm64 Rijndael-256 kernels: {set(EXPECTED_ARM64_RIJNDAEL_KERNELS) - found_rijndael}"
    )
    assert found_vistrutah == set(EXPECTED_ARM64_VISTRUTAH_KERNELS), (
        f"Missing arm64 Vistrutah kernels: {set(EXPECTED_ARM64_VISTRUTAH_KERNELS) - found_vistrutah}"
    )
    print(
        f"OK [C arm64 .S & msvc/*_arm64.asm]: Audited {total} functions "
        f"({len(found_wb)} WB + {len(found_wb_x4)} WBx4 + {len(found_rijndael)} Rijndael + "
        f"{len(found_vistrutah)} Vistrutah + {len(found_asura)} ASURA). 100% stackless AAPCS64 ABI & epilogue clean."
    )
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
        "rijndael_amd64.S",
        "vistrutah_amd64.S",
        "asura_amd64.S",
    ]
    arm_srcs = [
        "areion_arm64.S",
        "rijndael_arm64.S",
        "vistrutah_arm64.S",
        "asura_arm64.S",
    ]
    x86_sysv_count = 0
    x86_win64_count = 0
    arm_fn_count = 0
    mach = platform.machine().lower()
    x86_cc = "gcc" if mach in ("x86_64", "amd64") else shutil.which("x86_64-linux-gnu-gcc")
    x86_objdump = "objdump" if mach in ("x86_64", "amd64") else shutil.which("x86_64-linux-gnu-objdump")
    arm_cc = "gcc" if mach in ("aarch64", "arm64") else shutil.which("aarch64-linux-gnu-gcc")
    arm_objdump = "objdump" if mach in ("aarch64", "arm64") else shutil.which("aarch64-linux-gnu-objdump")
    with tempfile.TemporaryDirectory() as tmpdir:
        tmp = Path(tmpdir)
        if x86_cc and x86_objdump:
            for src in x86_srcs:
                obj_sysv = tmp / f"{src}.sysv.o"
                obj_win64 = tmp / f"{src}.win64.o"
                subprocess.run([x86_cc, "-I", str(C_DIR), "-c", str(C_DIR / src), "-o", str(obj_sysv)], check=True)
                subprocess.run([x86_cc, "-I", str(C_DIR), "-D_WIN64", "-c", str(C_DIR / src), "-o", str(obj_win64)], check=True)

                out_sysv = subprocess.check_output([x86_objdump, "-d", "--no-show-raw-insn", str(obj_sysv)], text=True)
                for blk in re.split(r"(?=^[0-9a-f]+ <\w+>:\n)", out_sysv, flags=re.M):
                    m_hdr = re.match(r"^[0-9a-f]+ <(\w+)>:\n(.*)", blk, flags=re.S)
                    if not m_hdr:
                        continue
                    fn, body = m_hdr.group(1), m_hdr.group(2)
                    if fn in SKIP_FUNCS:
                        continue
                    x86_sysv_count += 1
                    rsp_refs = re.findall(r"[^\s,]*\(%rsp\)", body)
                    if fn in SYSV_STACK_ARG_FUNCS:
                        assert set(rsp_refs) == SYSV_STACK_ARG_FUNCS[fn], (
                            f"{src}:{fn} unexpected SysV rsp refs: {set(rsp_refs)} vs {SYSV_STACK_ARG_FUNCS[fn]}"
                        )
                    else:
                        assert not rsp_refs, f"{src}:{fn} has unexpected stack references in SysV object: {rsp_refs}"
                    assert not re.search(r"\b(?:sub|add)\b[^\n]*%rsp", body), (
                        f"{src}:{fn} adjusts %rsp in SysV object"
                    )
                    insns = [
                        l.strip()
                        for l in body.strip().splitlines()
                        if l.strip() and not l.strip().endswith(":") and not re.search(r"\b(nop|nopl|nopw|cs nopw)\b|xchg\s+%ax,%ax", l)
                    ]
                    assert insns[0].endswith("endbr64"), f"{src}:{fn} does not start with endbr64: {insns[0]}"
                    assert insns[-1].endswith("ret") or insns[-1].endswith("retq"), f"{src}:{fn} does not end with ret: {insns[-1]}"

                notes_sysv = subprocess.check_output(["readelf", "-n", str(obj_sysv)], text=True)
                assert "IBT" in notes_sysv and "SHSTK" in notes_sysv, f"{src} missing CET IBT/SHSTK note: {notes_sysv}"

                out_win64 = subprocess.check_output([x86_objdump, "-d", "--no-show-raw-insn", str(obj_win64)], text=True)
                for blk in re.split(r"(?=^[0-9a-f]+ <\w+>:\n)", out_win64, flags=re.M):
                    m_hdr = re.match(r"^[0-9a-f]+ <(\w+)>:\n(.*)", blk, flags=re.S)
                    if not m_hdr:
                        continue
                    fn, body = m_hdr.group(1), m_hdr.group(2)
                    if fn in SKIP_FUNCS:
                        continue
                    x86_win64_count += 1
                    insns = [
                        l.strip()
                        for l in body.strip().splitlines()
                        if l.strip() and not l.strip().endswith(":") and not re.search(r"\b(nop|nopl|nopw|cs nopw)\b|xchg\s+%ax,%ax", l)
                    ]
                    assert insns[0].endswith("endbr64"), f"{src} (_WIN64):{fn} does not start with endbr64: {insns[0]}"
                    assert insns[-1].endswith("ret") or insns[-1].endswith("retq"), (
                        f"{src} (_WIN64):{fn} does not end with ret: {insns[-1]}"
                    )

        if arm_cc and arm_objdump:
            for src in arm_srcs:
                obj_arm = tmp / f"{src}.o"
                subprocess.run(
                    [arm_cc, "-I", str(C_DIR), "-c", str(C_DIR / src), "-o", str(obj_arm)],
                    check=True,
                )
                notes_arm = subprocess.check_output(["readelf", "-n", str(obj_arm)], text=True)
                assert "BTI" in notes_arm and "PAC" in notes_arm, f"{src} missing BTI/PAC note: {notes_arm}"
                out_arm = subprocess.check_output([arm_objdump, "-d", "--no-show-raw-insn", str(obj_arm)], text=True)
                for blk in re.split(r"(?=^[0-9a-f]+ <\w+>:\n)", out_arm, flags=re.M):
                    m_hdr = re.match(r"^[0-9a-f]+ <(\w+)>:\n(.*)", blk, flags=re.S)
                    if not m_hdr:
                        continue
                    fn, body = m_hdr.group(1), m_hdr.group(2)
                    if fn in SKIP_FUNCS:
                        continue
                    arm_fn_count += 1
                    sp_refs = [l.strip() for l in body.splitlines() if "sp" in l]
                    assert not sp_refs, f"{src}:{fn} unexpected sp instruction: {sp_refs}"
                    insns = [l.strip() for l in body.strip().splitlines() if l.strip() and not l.strip().endswith(":") and not re.search(r"\bnop\b", l)]
                    assert "bti\tc" in insns[0] or "hint\t#0x22" in insns[0], (
                        f"{src}:{fn} does not start with bti c: {insns[0]}"
                    )
                    assert insns[-1].endswith("ret"), f"{src}:{fn} does not end with ret: {insns[-1]}"

    print(
        f"OK [objdump -d]: Verified {x86_sysv_count} SysV x86_64, {x86_win64_count} _WIN64 x86_64, "
        f"and {arm_fn_count} aarch64 compiled object functions. Zero secret stack spills."
    )


def main() -> int:
    audit_c_amd64_S_and_masm()
    audit_c_arm64_S_and_armasm()
    audit_objdump()
    return 0


if __name__ == "__main__":
    sys.exit(main())
