#!/usr/bin/env python3
# Copyright (c) 2026 Andrey Kuvshinov
# Dual-licensed under Apache-2.0 OR MIT.
"""
Self-contained generator for Microsoft MASM (msvc/*_amd64.asm) and
ARMASM64 (msvc/areion_arm64.asm) assembly files directly from the C
repository's GNU GAS (.S) sources.
"""

from pathlib import Path
import re
import sys

C_REPO = Path(__file__).resolve().parent.parent

MASM_MNEMONIC_MAP = {
    "movabsq": "mov",
    "movl": "mov",
    "movzbl": "movzx",
    "xorq": "xor",
    "addq": "add",
    "subq": "sub",
    "cmpq": "cmp",
    "testq": "test",
    "testl": "test",
}


def split_operands(s: str) -> list[str]:
    out = []
    cur = []
    depth = 0
    for ch in s:
        if ch in "([":
            depth += 1
        elif ch in ")]":
            depth -= 1
        if ch == "," and depth == 0:
            out.append("".join(cur).strip())
            cur = []
        else:
            cur.append(ch)
    if cur:
        out.append("".join(cur).strip())
    return out


def eval_win64_lines(body: str) -> list[str]:
    """Extracts the lines active when _WIN64 is defined."""
    out = []
    state = "BOTH"  # BOTH, NOT_WIN64, WIN64
    for raw in body.splitlines():
        s = raw.strip()
        if not s:
            continue
        if s == "#if !defined(_WIN64)":
            state = "NOT_WIN64"
            continue
        if s == "#if defined(_WIN64)":
            state = "WIN64"
            continue
        if s == "#else":
            state = "WIN64" if state == "NOT_WIN64" else "NOT_WIN64"
            continue
        if s == "#endif":
            state = "BOTH"
            continue
        if state in ("BOTH", "WIN64"):
            out.append(s)
    return out


def infer_mem_ptr_prefix(mnem: str, ops: list[str]) -> str:
    if mnem == "movzbl":
        return "BYTE PTR "
    if mnem in ("movq", "xorq", "addq", "subq", "cmpq", "testq"):
        return "QWORD PTR "
    if mnem in ("movl", "testl"):
        return "DWORD PTR "
    if mnem in (
        "vinserti128",
        "vextracti128",
        "vinserti32x4",
        "vextracti32x4",
        "vbroadcasti128",
        "vbroadcasti32x4",
    ):
        return "XMMWORD PTR "
    if mnem in ("vinserti64x4", "vextracti64x4"):
        return "YMMWORD PTR "
    joined = " ".join(ops)
    if "%zmm" in joined:
        return "ZMMWORD PTR "
    if "%ymm" in joined:
        return "YMMWORD PTR "
    return "XMMWORD PTR "


def convert_att_op_to_masm(op: str, ptr_prefix: str) -> str:
    op = op.strip()
    if op.startswith("$"):
        val = int(op[1:], 0)
        return str(val)
    if op.startswith("%"):
        return op[1:]
    # RIP-relative symbol: [disp+]AREION_SYM(sym)(%rip)
    m_sym = re.match(r"^(?:(\d+)\+)?AREION_SYM\((\w+)\)\(%rip\)$", op)
    if m_sym:
        disp, sym = m_sym.group(1), m_sym.group(2)
        if disp and int(disp) != 0:
            return f"{ptr_prefix}[{sym} + {disp}]"
        return f"{ptr_prefix}[{sym}]"
    # Base/displacement memory: [disp](%reg)
    m_mem = re.match(r"^(\d+)?\(%(\w+)\)$", op)
    if m_mem:
        disp, reg = m_mem.group(1), m_mem.group(2)
        if disp and (int(disp) != 0 or reg == "rsp"):
            return f"{ptr_prefix}[{reg} + {disp}]"
        return f"{ptr_prefix}[{reg}]"
    return op


def translate_s_to_masm(s_filename: str, msvc_filename: str):
    text = (C_REPO / s_filename).read_text(encoding="utf-8")
    funcs = re.findall(
        r"AREION_FUNC_START\((\w+)\)\n(.*?)AREION_FUNC_END\(\1\)",
        text,
        re.S,
    )

    masm_lines = [
        "; Copyright (c) 2026 Andrey Kuvshinov",
        "; SPDX-License-Identifier: Apache-2.0 OR MIT",
        "",
        "EXTERN roundConstantsP1:BYTE",
        "EXTERN roundConstantsP2:BYTE",
        "EXTERN areionRC4x:BYTE",
        "EXTERN areionRC4x2:BYTE",
        "EXTERN rijndael256Consts:BYTE",
        "EXTERN vistrutahRoundConstants:BYTE",
        "EXTERN vistrutahConsts:BYTE",
        "",
        ".code",
        "",
    ]

    for fname, body in funcs:
        win_lines = eval_win64_lines(body)
        masm_lines.extend([
            f"PUBLIC {fname}",
            "ALIGN 16",
            f"{fname} PROC",
            "    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64",
        ])
        for line in win_lines:
            if line.endswith(":"):
                lbl = line[:-1]
                if lbl.startswith(".L"):
                    lbl = lbl[2:]
                masm_lines.append(f"{lbl}:")
                continue
            parts = line.split(None, 1)
            mnem = parts[0]
            if len(parts) == 1:
                masm_lines.append(f"    {mnem}")
                continue
            ops_att = split_operands(parts[1])
            if mnem in ("jz", "je", "jne", "jmp"):
                target = ops_att[0]
                if target.startswith(".L"):
                    target = target[2:]
                masm_lines.append(f"    {mnem} {target}")
                continue
            ptr_prefix = infer_mem_ptr_prefix(mnem, ops_att)
            if mnem == "movq":
                masm_mnem = "movq" if any("%xmm" in o for o in ops_att) else "mov"
            else:
                masm_mnem = MASM_MNEMONIC_MAP.get(mnem, mnem)
            ops_masm = [convert_att_op_to_masm(o, ptr_prefix) for o in reversed(ops_att)]
            masm_lines.append(f"    {masm_mnem} {', '.join(ops_masm)}")

        masm_lines.extend([
            f"{fname} ENDP",
            "",
        ])

    masm_lines.append("END")
    masm_lines.append("")
    (C_REPO / "msvc" / msvc_filename).write_text("\n".join(masm_lines), encoding="utf-8")


def translate_arm64_s_to_armasm():
    text = (C_REPO / "areion_arm64.S").read_text(encoding="utf-8")
    funcs = re.findall(
        r"AREION_FUNC_START\((\w+)\)\n(.*?)AREION_FUNC_END\(\1\)",
        text,
        re.S,
    )

    armasm_lines = [
        "; Copyright (c) 2026 Andrey Kuvshinov",
        "; SPDX-License-Identifier: Apache-2.0 OR MIT",
        "",
        "    AREA |.text|, CODE, READONLY, ALIGN=4",
        "    IMPORT roundConstantsP1",
        "    IMPORT roundConstantsP2",
        "    IMPORT rijndael256Consts",
        "    IMPORT vistrutahRoundConstants",
        "    IMPORT vistrutahConsts",
        "",
    ]

    for fname, body in funcs:
        armasm_lines.extend([
            f"    EXPORT {fname}",
            f"{fname} PROC",
            "    hint #34 ; bti c",
        ])
        for raw in body.splitlines():
            s = raw.strip()
            if not s:
                continue
            if s.endswith(":"):
                lbl = s[:-1]
                if lbl.startswith(".L"):
                    lbl = lbl[2:]
                armasm_lines.append(f"{lbl}:")
                continue
            m_adr = re.match(r"^AREION_ARM64_ADR\((x\d+),\s*(\w+)\)$", s)
            if m_adr:
                reg, sym = m_adr.group(1), m_adr.group(2)
                armasm_lines.append(f"    adrp {reg}, {sym}")
                armasm_lines.append(f"    add {reg}, {reg}, {sym}")
                continue
            m_beq = re.match(r"^b\.eq\s+\.L(\w+)$", s)
            if m_beq:
                armasm_lines.append(f"    b.eq {m_beq.group(1)}")
                continue
            armasm_lines.append(f"    {s}")
        armasm_lines.extend([
            "    ENDP",
            "",
        ])

    armasm_lines.append("    END")
    armasm_lines.append("")
    (C_REPO / "msvc" / "areion_arm64.asm").write_text("\n".join(armasm_lines), encoding="utf-8")


def main() -> int:
    (C_REPO / "msvc").mkdir(parents=True, exist_ok=True)
    translate_s_to_masm("areion_amd64.S", "areion_amd64.asm")
    translate_s_to_masm("areion_soem256_amd64.S", "areion_soem256_amd64.asm")
    translate_s_to_masm("areion_soem512_amd64.S", "areion_soem512_amd64.asm")
    translate_s_to_masm("areion_soem_aesni_amd64.S", "areion_soem_aesni_amd64.asm")
    translate_arm64_s_to_armasm()
    print("OK: Generated all MSVC (msvc/*.asm) assembly files from .S sources.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
