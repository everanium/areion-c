#!/usr/bin/env python3
# Copyright (c) 2026 Andrey Kuvshinov
# Dual-licensed under Apache-2.0 OR MIT.
"""Generates GNU GAS (.S) and Microsoft MASM/armasm64 (msvc/*.asm) assembly files."""

import os
from pathlib import Path
import re
import sys

C_REPO = Path(__file__).resolve().parent.parent


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
        cand = (C_REPO / rel).resolve()
        if (cand / "go.mod").exists():
            return cand
    return (C_REPO / "../../go/src/areion").resolve()


GO_REPO = _resolve_go_repo()

X86_GPR_ATT = {
    "AX": "%rax",
    "BX": "%r10",  # Map Plan 9 BX to caller-saved %r10
    "CX": "%rcx",
    "DX": "%rdx",
    "SI": "%rsi",
    "DI": "%rdi",
    "R8": "%r8",
    "R9": "%r9",
    "R10": "%r10",
    "R11": "%r11",
    "R12": "%r12",
    "R13": "%r13",
    "R14": "%r14",
    "R15": "%r15",
}

X86_GPR_MASM = {
    "AX": "rax",
    "BX": "r10",
    "CX": "rcx",
    "DX": "rdx",
    "SI": "rsi",
    "DI": "rdi",
    "R8": "r8",
    "R9": "r9",
    "R10": "r10",
    "R11": "r11",
    "R12": "r12",
    "R13": "r13",
    "R14": "r14",
    "R15": "r15",
}

SYSV_ARGS = ["%rdi", "%rsi", "%rdx", "%rcx", "%r8", "%r9"]
WIN64_ARGS = ["%rcx", "%rdx", "%r8", "%r9"]
WIN64_ARGS_MASM = ["rcx", "rdx", "r8", "r9"]

X86_OP_ATT = {
    "MOVQ": "movq",
    "MOVL": "movl",
    "MOVBLZX": "movzbl",
    "MOVOA": "movdqa",
    "MOVOU": "movdqu",
    "PXOR": "pxor",
    "XORQ": "xorq",
    "TESTQ": "testq",
    "JZ": "jz",
    "RET": "ret",
    "VZEROUPPER": "vzeroupper",
    "AESENC": "aesenc",
    "AESENCLAST": "aesenclast",
    "AESDEC": "aesdec",
    "AESDECLAST": "aesdeclast",
    "AESIMC": "aesimc",
    "AESKEYGENASSIST": "aeskeygenassist",
    "VMOVDQA": "vmovdqa",
    "VMOVDQU": "vmovdqu",
    "VMOVDQU64": "vmovdqu64",
    "VPXOR": "vpxor",
    "VPXORD": "vpxord",
    "VPXORQ": "vpxorq",
    "VAESENC": "vaesenc",
    "VAESENCLAST": "vaesenclast",
    "VAESDEC": "vaesdec",
    "VAESDECLAST": "vaesdeclast",
    "VAESIMC": "vaesimc",
    "VBROADCASTI128": "vbroadcasti128",
    "VBROADCASTI32X4": "vbroadcasti32x4",
    "VEXTRACTI128": "vextracti128",
    "VINSERTI128": "vinserti128",
    "VEXTRACTI32X4": "vextracti32x4",
    "VINSERTI32X4": "vinserti32x4",
}


def solve_parallel_moves(moves: list[tuple[str, str]], scratch: str = "%r11") -> list[tuple[str, str]]:
    """Orders (src, dst) moves so no source register is clobbered before being read."""
    pending = [(s, d) for s, d in moves if s != d]
    result = []
    while pending:
        progressed = False
        for i, (s, d) in enumerate(pending):
            if not any(other_s == d for j, (other_s, _) in enumerate(pending) if j != i):
                result.append((s, d))
                pending.pop(i)
                progressed = True
                break
        if not progressed:
            s, d = pending[0]
            result.append((s, scratch))
            pending[0] = (scratch, d)

    # Symbolic verification
    init_state = {s: f"VAL_{idx}" for idx, (s, _) in enumerate(moves)}
    state = dict(init_state)
    for s, d in result:
        state[d] = state[s]
    for idx, (s, d) in enumerate(moves):
        assert state[d] == init_state[s], f"Move verification failed for {moves}: {result}"
    return result


def convert_x86_operand_att(op: str, gpr_map: dict[str, str]) -> str:
    op = op.strip()
    if op.startswith("$"):
        return op
    m_sym = re.match(r"^·(\w+)(?:\+(\d+))?\(SB\)$", op)
    if m_sym:
        sym, off = m_sym.group(1), m_sym.group(2)
        if off and int(off) != 0:
            return f"{off}+AREION_SYM({sym})(%rip)"
        return f"AREION_SYM({sym})(%rip)"
    m_mem = re.match(r"^(\d+)?\((\w+)\)$", op)
    if m_mem:
        off, reg = m_mem.group(1), m_mem.group(2)
        reg_att = gpr_map[reg]
        if off and int(off) != 0:
            return f"{off}({reg_att})"
        return f"({reg_att})"
    if re.match(r"^X(\d+)$", op):
        return f"%xmm{op[1:]}"
    if re.match(r"^Y(\d+)$", op):
        return f"%ymm{op[1:]}"
    if re.match(r"^Z(\d+)$", op):
        return f"%zmm{op[1:]}"
    if op in gpr_map:
        return gpr_map[op]
    return op


def convert_x86_operand_masm(op: str, gpr_map: dict[str, str], mem_bits: int = 128) -> str:
    op = op.strip()
    if op.startswith("$"):
        return op[1:]
    ptr_prefix = {
        64: "QWORD PTR ",
        128: "XMMWORD PTR ",
        256: "YMMWORD PTR ",
        512: "ZMMWORD PTR ",
    }[mem_bits]
    m_sym = re.match(r"^·(\w+)(?:\+(\d+))?\(SB\)$", op)
    if m_sym:
        sym, off = m_sym.group(1), m_sym.group(2)
        if off and int(off) != 0:
            return f"{ptr_prefix}[{sym} + {off}]"
        return f"{ptr_prefix}[{sym}]"
    m_mem = re.match(r"^(\d+)?\((\w+)\)$", op)
    if m_mem:
        off, reg = m_mem.group(1), m_mem.group(2)
        reg_masm = gpr_map[reg]
        if off and int(off) != 0:
            return f"{ptr_prefix}[{reg_masm} + {off}]"
        return f"{ptr_prefix}[{reg_masm}]"
    if re.match(r"^X(\d+)$", op):
        return f"xmm{op[1:]}"
    if re.match(r"^Y(\d+)$", op):
        return f"ymm{op[1:]}"
    if re.match(r"^Z(\d+)$", op):
        return f"zmm{op[1:]}"
    if op in gpr_map:
        return gpr_map[op]
    return op


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


def translate_x86_file(go_filename: str, c_s_filename: str, msvc_filename: str):
    src = (GO_REPO / go_filename).read_text(encoding="utf-8")
    blocks = re.split(r"(?=^TEXT )", src, flags=re.M)

    att_lines = [
        "/*",
        " * Copyright (c) 2026 Andrey Kuvshinov",
        " *",
        " * Dual-licensed under Apache-2.0 OR MIT.",
        " * See LICENSE-APACHE and LICENSE-MIT for details.",
        " */",
        "",
        "#if defined(__x86_64__) || defined(_M_X64)",
        '#include "asm_abi.h"',
        "",
        ".text",
        "",
    ]

    masm_lines = [
        "; Copyright (c) 2026 Andrey Kuvshinov",
        "; SPDX-License-Identifier: Apache-2.0 OR MIT",
        "",
        "EXTERN roundConstantsP1:BYTE",
        "EXTERN roundConstantsP2:BYTE",
        "EXTERN areionRC4x:BYTE",
        "EXTERN areionRC4x2:BYTE",
        "",
        ".code",
        "",
    ]

    for block in blocks:
        if not block.startswith("TEXT "):
            continue
        lines = [l.strip() for l in block.splitlines() if l.strip() and not l.strip().startswith("//")]
        header = lines[0]
        fname = re.search(r"TEXT ·(\w+)\(SB\)", header).group(1)
        if fname == "cpuid":
            continue

        if fname in ("dumpSIMDRegs", "clobberScratchGPRs", "dirtySIMDRegForTest"):
            if fname == "clobberScratchGPRs":
                att_lines.extend([
                    "AREION_FUNC_START(clobberScratchGPRs)",
                    "    pxor %xmm0, %xmm0",
                    "    pxor %xmm1, %xmm1",
                    "    pxor %xmm2, %xmm2",
                    "    pxor %xmm3, %xmm3",
                    "    pxor %xmm4, %xmm4",
                    "    pxor %xmm5, %xmm5",
                    "#if !defined(_WIN64)",
                    "    pxor %xmm6, %xmm6",
                    "    pxor %xmm7, %xmm7",
                    "    pxor %xmm8, %xmm8",
                    "    pxor %xmm9, %xmm9",
                    "    pxor %xmm10, %xmm10",
                    "    pxor %xmm11, %xmm11",
                    "    pxor %xmm12, %xmm12",
                    "    pxor %xmm13, %xmm13",
                    "    pxor %xmm14, %xmm14",
                    "    pxor %xmm15, %xmm15",
                    "    xorq %rsi, %rsi",
                    "    xorq %rdi, %rdi",
                    "#endif",
                    "    xorq %rax, %rax",
                    "    xorq %rcx, %rcx",
                    "    xorq %rdx, %rdx",
                    "    xorq %r8, %r8",
                    "    xorq %r9, %r9",
                    "    xorq %r10, %r10",
                    "    xorq %r11, %r11",
                    "    ret",
                    "AREION_FUNC_END(clobberScratchGPRs)",
                    "",
                ])
                masm_lines.extend([
                    "PUBLIC clobberScratchGPRs",
                    "ALIGN 16",
                    "clobberScratchGPRs PROC",
                    "    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64",
                    "    pxor xmm0, xmm0",
                    "    pxor xmm1, xmm1",
                    "    pxor xmm2, xmm2",
                    "    pxor xmm3, xmm3",
                    "    pxor xmm4, xmm4",
                    "    pxor xmm5, xmm5",
                    "    xor rax, rax",
                    "    xor rcx, rcx",
                    "    xor rdx, rdx",
                    "    xor r8, r8",
                    "    xor r9, r9",
                    "    xor r10, r10",
                    "    xor r11, r11",
                    "    ret",
                    "clobberScratchGPRs ENDP",
                    "",
                ])
            elif fname == "dumpSIMDRegs":
                att_lines.extend([
                    "AREION_FUNC_START(dumpSIMDRegs)",
                    "#if !defined(_WIN64)",
                    "    movq %rax, 512(%rdi)",
                    "    movq %rcx, 520(%rdi)",
                    "    movq %rdx, 528(%rdi)",
                    "    movq $0, 536(%rdi)",
                    "    movq %r8, 544(%rdi)",
                    "    movq %r9, 552(%rdi)",
                    "    movq %r10, 560(%rdi)",
                    "    movq %r11, 568(%rdi)",
                    "    movq $0, 576(%rdi)",
                    "    movq $0, 584(%rdi)",
                    "    movq $0, 592(%rdi)",
                    "    movq %rdi, %rax",
                    "    movl %esi, %ecx",
                    "#else",
                    "    movq %rax, 512(%rcx)",
                    "    movq $0, 520(%rcx)",
                    "    movq $0, 528(%rcx)",
                    "    movq $0, 536(%rcx)",
                    "    movq %r8, 544(%rcx)",
                    "    movq %r9, 552(%rcx)",
                    "    movq %r10, 560(%rcx)",
                    "    movq %r11, 568(%rcx)",
                    "    movq $0, 576(%rcx)",
                    "    movq $0, 584(%rcx)",
                    "    movq $0, 592(%rcx)",
                    "    movq %rcx, %rax",
                    "    movl %edx, %ecx",
                    "#endif",
                    "    movdqu %xmm0, 0(%rax)",
                    "    movdqu %xmm1, 16(%rax)",
                    "    movdqu %xmm2, 32(%rax)",
                    "    movdqu %xmm3, 48(%rax)",
                    "    movdqu %xmm4, 64(%rax)",
                    "    movdqu %xmm5, 80(%rax)",
                    "    movdqu %xmm6, 96(%rax)",
                    "    movdqu %xmm7, 112(%rax)",
                    "    movdqu %xmm8, 128(%rax)",
                    "    movdqu %xmm9, 144(%rax)",
                    "    movdqu %xmm10, 160(%rax)",
                    "    movdqu %xmm11, 176(%rax)",
                    "    movdqu %xmm12, 192(%rax)",
                    "    movdqu %xmm13, 208(%rax)",
                    "    movdqu %xmm14, 224(%rax)",
                    "    movdqu %xmm15, 240(%rax)",
                    "    testl %ecx, %ecx",
                    "    jz dumpDone",
                    "    vmovdqu64 %xmm16, 256(%rax)",
                    "    vmovdqu64 %xmm17, 272(%rax)",
                    "    vmovdqu64 %xmm18, 288(%rax)",
                    "    vmovdqu64 %xmm19, 304(%rax)",
                    "    vmovdqu64 %xmm20, 320(%rax)",
                    "    vmovdqu64 %xmm21, 336(%rax)",
                    "    vmovdqu64 %xmm22, 352(%rax)",
                    "    vmovdqu64 %xmm23, 368(%rax)",
                    "    vmovdqu64 %xmm24, 384(%rax)",
                    "    vmovdqu64 %xmm25, 400(%rax)",
                    "    vmovdqu64 %xmm26, 416(%rax)",
                    "    vmovdqu64 %xmm27, 432(%rax)",
                    "    vmovdqu64 %xmm28, 448(%rax)",
                    "    vmovdqu64 %xmm29, 464(%rax)",
                    "    vmovdqu64 %xmm30, 480(%rax)",
                    "    vmovdqu64 %xmm31, 496(%rax)",
                    "    vpxord %xmm16, %xmm16, %xmm16",
                    "    vpxord %xmm17, %xmm17, %xmm17",
                    "    vpxord %xmm18, %xmm18, %xmm18",
                    "    vpxord %xmm19, %xmm19, %xmm19",
                    "    vpxord %xmm20, %xmm20, %xmm20",
                    "    vpxord %xmm21, %xmm21, %xmm21",
                    "    vpxord %xmm22, %xmm22, %xmm22",
                    "    vpxord %xmm23, %xmm23, %xmm23",
                    "    vpxord %xmm24, %xmm24, %xmm24",
                    "    vpxord %xmm25, %xmm25, %xmm25",
                    "    vpxord %xmm26, %xmm26, %xmm26",
                    "    vpxord %xmm27, %xmm27, %xmm27",
                    "    vpxord %xmm28, %xmm28, %xmm28",
                    "    vpxord %xmm29, %xmm29, %xmm29",
                    "    vpxord %xmm30, %xmm30, %xmm30",
                    "    vpxord %xmm31, %xmm31, %xmm31",
                    "    vzeroupper",
                    "dumpDone:",
                    "    pxor %xmm0, %xmm0",
                    "    pxor %xmm1, %xmm1",
                    "    pxor %xmm2, %xmm2",
                    "    pxor %xmm3, %xmm3",
                    "    pxor %xmm4, %xmm4",
                    "    pxor %xmm5, %xmm5",
                    "#if !defined(_WIN64)",
                    "    pxor %xmm6, %xmm6",
                    "    pxor %xmm7, %xmm7",
                    "    pxor %xmm8, %xmm8",
                    "    pxor %xmm9, %xmm9",
                    "    pxor %xmm10, %xmm10",
                    "    pxor %xmm11, %xmm11",
                    "    pxor %xmm12, %xmm12",
                    "    pxor %xmm13, %xmm13",
                    "    pxor %xmm14, %xmm14",
                    "    pxor %xmm15, %xmm15",
                    "    xorq %rsi, %rsi",
                    "    xorq %rdi, %rdi",
                    "#endif",
                    "    xorq %rax, %rax",
                    "    xorq %rcx, %rcx",
                    "    xorq %rdx, %rdx",
                    "    xorq %r8, %r8",
                    "    xorq %r9, %r9",
                    "    xorq %r10, %r10",
                    "    xorq %r11, %r11",
                    "    ret",
                    "AREION_FUNC_END(dumpSIMDRegs)",
                    "",
                ])
                masm_lines.extend([
                    "PUBLIC dumpSIMDRegs",
                    "ALIGN 16",
                    "dumpSIMDRegs PROC",
                    "    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64",
                    "    mov QWORD PTR [rcx + 512], rax",
                    "    mov QWORD PTR [rcx + 520], 0",
                    "    mov QWORD PTR [rcx + 528], 0",
                    "    mov QWORD PTR [rcx + 536], 0",
                    "    mov QWORD PTR [rcx + 544], r8",
                    "    mov QWORD PTR [rcx + 552], r9",
                    "    mov QWORD PTR [rcx + 560], r10",
                    "    mov QWORD PTR [rcx + 568], r11",
                    "    mov QWORD PTR [rcx + 576], 0",
                    "    mov QWORD PTR [rcx + 584], 0",
                    "    mov QWORD PTR [rcx + 592], 0",
                    "    mov rax, rcx",
                    "    mov ecx, edx",
                ])
                for r in range(16):
                    masm_lines.append(f"    movdqu XMMWORD PTR [rax + {r * 16}], xmm{r}")
                masm_lines.extend([
                    "    test ecx, ecx",
                    "    jz dumpDone",
                ])
                for r in range(16, 32):
                    masm_lines.append(f"    vmovdqu64 XMMWORD PTR [rax + {r * 16}], xmm{r}")
                for r in range(16, 32):
                    masm_lines.append(f"    vpxord xmm{r}, xmm{r}, xmm{r}")
                masm_lines.extend([
                    "    vzeroupper",
                    "dumpDone:",
                    "    pxor xmm0, xmm0",
                    "    pxor xmm1, xmm1",
                    "    pxor xmm2, xmm2",
                    "    pxor xmm3, xmm3",
                    "    pxor xmm4, xmm4",
                    "    pxor xmm5, xmm5",
                    "    xor rax, rax",
                    "    xor rcx, rcx",
                    "    xor rdx, rdx",
                    "    xor r8, r8",
                    "    xor r9, r9",
                    "    xor r10, r10",
                    "    xor r11, r11",
                    "    ret",
                    "dumpSIMDRegs ENDP",
                    "",
                ])
            elif fname == "dirtySIMDRegForTest":
                att_lines.extend([
                    "AREION_FUNC_START(dirtySIMDRegForTest)",
                    "#if !defined(_WIN64)",
                    "    movq %rdi, %r10",
                    "#else",
                    "    movq %rcx, %r10",
                    "#endif",
                    "    movabsq $0x5555555555555555, %rax",
                    "    xorq %rax, %r10",
                    "    movq %r10, %xmm2",
                    "    xorq %rax, %rax",
                    "    ret",
                    "AREION_FUNC_END(dirtySIMDRegForTest)",
                    "",
                ])
                masm_lines.extend([
                    "PUBLIC dirtySIMDRegForTest",
                    "ALIGN 16",
                    "dirtySIMDRegForTest PROC",
                    "    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64",
                    "    mov r10, rcx",
                    "    mov rax, 05555555555555555h",
                    "    xor r10, rax",
                    "    movq xmm2, r10",
                    "    xor rax, rax",
                    "    ret",
                    "dirtySIMDRegForTest ENDP",
                    "",
                ])
            continue
        c_fname = fname
        gpr_map_att = dict(X86_GPR_ATT)
        gpr_map_masm = dict(X86_GPR_MASM)

        arg_loads = []
        body_lines = []
        for l in lines[1:]:
            m_arg = re.match(r"^(MOVQ|MOVL|MOVBLZX)\s+\w+\+(\d+)\(FP\),\s*(\w+)$", l)
            if m_arg and not body_lines:
                op, off, dst = m_arg.group(1), int(m_arg.group(2)), m_arg.group(3)
                arg_loads.append((op, off, dst))
            else:
                body_lines.append(l)

        # Find used XMM/YMM/ZMM and GPRs in body for Win64 save/restore
        used_xmm_win64 = []
        used_gpr_win64 = []
        all_text = "\n".join(body_lines)
        is_vex_func = any(l.split()[0].startswith("V") for l in body_lines if not l.endswith(":"))
        has_vzeroupper = any(l.split()[0] == "VZEROUPPER" for l in body_lines if not l.endswith(":"))
        xmm_mov_op = "vmovdqu" if is_vex_func else "movdqu"
        for idx in range(6, 16):
            if re.search(rf"\b[XYZ]{idx}\b", all_text):
                used_xmm_win64.append(idx)
        for g in ("SI", "DI"):
            if re.search(rf"\b{g}\b", all_text) or any(dst == g for _, _, dst in arg_loads):
                used_gpr_win64.append(g)

        win64_gpr_bytes = len(used_gpr_win64) * 8
        win64_xmm_offset = (win64_gpr_bytes + 15) & ~15
        win64_frame_size = win64_xmm_offset + len(used_xmm_win64) * 16
        # Keep 16-byte stack alignment (at function entry rsp % 16 == 8; wait: we don't call subfunctions,
        # so any 8-byte aligned rsp is fine, or round to 16 + 8)
        if win64_frame_size % 16 == 0 and win64_frame_size > 0:
            win64_frame_size += 8

        att_lines.append(f"AREION_FUNC_START({c_fname})")
        masm_lines.append(f"PUBLIC {c_fname}")
        masm_lines.append(f"ALIGN 16")
        masm_lines.append(f"{c_fname} PROC")
        masm_lines.append("    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64")

        # SysV Prologue
        att_lines.append("#if !defined(_WIN64)")
        sysv_reg_moves = []
        sysv_stack_moves = []
        for idx, (op, off, dst) in enumerate(arg_loads):
            dst_reg = gpr_map_att[dst]
            if idx < 6:
                src_reg = SYSV_ARGS[idx]
                sysv_reg_moves.append((src_reg, dst_reg))
            else:
                stack_off = 8 + (idx - 6) * 8
                sysv_stack_moves.append(( f"{stack_off}(%rsp)", dst_reg))
        sysv_resolved = solve_parallel_moves(sysv_reg_moves)
        for src_reg, dst_reg in sysv_resolved:
            att_lines.append(f"    movq {src_reg}, {dst_reg}")
        for mem_src, dst_reg in sysv_stack_moves:
            att_lines.append(f"    movq {mem_src}, {dst_reg}")

        # Win64 Prologue
        att_lines.append("#else")
        if win64_frame_size > 0:
            att_lines.append(f"    subq ${win64_frame_size}, %rsp")
            masm_lines.append(f"    sub rsp, {win64_frame_size}")
            for i, g in enumerate(used_gpr_win64):
                att_lines.append(f"    movq {gpr_map_att[g]}, {i*8}(%rsp)")
                masm_lines.append(f"    mov QWORD PTR [rsp + {i*8}], {gpr_map_masm[g]}")
            for i, x in enumerate(used_xmm_win64):
                off = win64_xmm_offset + i * 16
                att_lines.append(f"    {xmm_mov_op} %xmm{x}, {off}(%rsp)")
                masm_lines.append(f"    {xmm_mov_op} XMMWORD PTR [rsp + {off}], xmm{x}")

        win_reg_moves = []
        win_stack_moves = []
        for idx, (op, off, dst) in enumerate(arg_loads):
            dst_reg = gpr_map_att[dst]
            if idx < 4:
                win_reg_moves.append((WIN64_ARGS[idx], dst_reg))
            else:
                stack_off = win64_frame_size + 40 + (idx - 4) * 8
                win_stack_moves.append((stack_off, dst_reg, gpr_map_masm[dst]))
        win_resolved = solve_parallel_moves(win_reg_moves)
        for src_reg, dst_reg in win_resolved:
            att_lines.append(f"    movq {src_reg}, {dst_reg}")
            masm_lines.append(f"    mov {dst_reg[1:]}, {src_reg[1:]}")
        for stack_off, dst_reg, dst_masm in win_stack_moves:
            att_lines.append(f"    movq {stack_off}(%rsp), {dst_reg}")
            masm_lines.append(f"    mov {dst_masm}, QWORD PTR [rsp + {stack_off}]")
        att_lines.append("#endif")

        prologue_uses_r11 = any(
            "%r11" in (s, d) for s, d in (sysv_resolved + win_resolved)
        )
        body_zeroes_r11 = any(
            l.startswith("XORQ") and "R11" in l for l in body_lines
        )

        # Body
        for l in body_lines:
            if l.endswith(":"):
                att_lines.append(l)
                masm_lines.append(l)
                continue
            parts = l.split(None, 1)
            op = parts[0]
            ops = split_operands(parts[1]) if len(parts) > 1 else []

            if fname == "clobberScratchGPRs" and op == "XORQ" and ops == ["BX", "BX"]:
                # Never clobber callee-saved %rbx in C ABI
                continue

            if op == "VZEROUPPER":
                # Deferred to immediately before ret (after Win64 XMM restore)
                continue

            if op == "RET":
                if prologue_uses_r11 and not body_zeroes_r11:
                    att_lines.append("    xorq %r11, %r11")
                    masm_lines.append("    xor r11, r11")
                if win64_frame_size > 0:
                    att_lines.append("#if defined(_WIN64)")
                    for i, x in enumerate(used_xmm_win64):
                        off = win64_xmm_offset + i * 16
                        att_lines.append(f"    {xmm_mov_op} {off}(%rsp), %xmm{x}")
                        att_lines.append(f"    movq $0, {off}(%rsp)")
                        att_lines.append(f"    movq $0, {off+8}(%rsp)")
                        masm_lines.append(f"    {xmm_mov_op} xmm{x}, XMMWORD PTR [rsp + {off}]")
                        masm_lines.append(f"    mov QWORD PTR [rsp + {off}], 0")
                        masm_lines.append(f"    mov QWORD PTR [rsp + {off+8}], 0")
                    for i, g in enumerate(used_gpr_win64):
                        att_lines.append(f"    movq {i*8}(%rsp), {gpr_map_att[g]}")
                        att_lines.append(f"    movq $0, {i*8}(%rsp)")
                        masm_lines.append(f"    mov {gpr_map_masm[g]}, QWORD PTR [rsp + {i*8}]")
                        masm_lines.append(f"    mov QWORD PTR [rsp + {i*8}], 0")
                    att_lines.append(f"    addq ${win64_frame_size}, %rsp")
                    att_lines.append("#endif")
                    masm_lines.append(f"    add rsp, {win64_frame_size}")
                if has_vzeroupper:
                    att_lines.append("    vzeroupper")
                    masm_lines.append("    vzeroupper")
                att_lines.append("    ret")
                masm_lines.append("    ret")
                continue

            op_att = X86_OP_ATT[op]
            ops_att = [convert_x86_operand_att(o, gpr_map_att) for o in ops]
            if op == "MOVBLZX" and ops_att[1] == "%rcx":
                ops_att[1] = "%ecx"
            if op == "MOVQ" and ops[0].startswith("$0x") and len(ops[0]) > 10:
                op_att = "movabsq"
            att_lines.append(f"    {op_att} {', '.join(ops_att)}" if ops_att else f"    {op_att}")

            # MASM translation (reversed operand order)
            mem_bits = 128
            if op in ("MOVQ", "XORQ", "TESTQ"):
                mem_bits = 64
            elif (op == "VMOVDQU64" or any(o.startswith("Z") for o in ops)) and op not in ("VBROADCASTI32X4", "VEXTRACTI32X4", "VINSERTI32X4"):
                mem_bits = 512
            elif any(o.startswith("Y") for o in ops) and op not in ("VBROADCASTI128", "VEXTRACTI128", "VINSERTI128"):
                mem_bits = 256
            ops_masm = [convert_x86_operand_masm(o, gpr_map_masm, mem_bits) for o in reversed(ops)]
            op_masm = op_att
            if op in ("MOVQ", "MOVL", "XORQ", "TESTQ"):
                op_masm = op[:-1].lower()
            elif op == "MOVBLZX":
                op_masm = "movzx"
            masm_lines.append(f"    {op_masm} {', '.join(ops_masm)}" if ops_masm else f"    {op_masm}")

        att_lines.append(f"AREION_FUNC_END({c_fname})")
        att_lines.append("")
        masm_lines.append(f"{c_fname} ENDP")
        masm_lines.append("")

    att_lines.extend([
        "#endif /* __x86_64__ || _M_X64 */",
        "",
        "#if defined(__linux__) && defined(__ELF__)",
        "#if defined(__x86_64__)",
        '.pushsection .note.gnu.property, "a"',
        ".p2align 3",
        ".long 4",
        ".long 16",
        ".long 5",
        '.asciz "GNU"',
        ".long 0xc0000002",
        ".long 4",
        ".long 3",
        ".long 0",
        ".popsection",
        "#elif defined(__aarch64__)",
        '.pushsection .note.gnu.property, "a"',
        ".p2align 3",
        ".long 4",
        ".long 16",
        ".long 5",
        '.asciz "GNU"',
        ".long 0xc0000000",
        ".long 4",
        ".long 3",
        ".long 0",
        ".popsection",
        "#endif",
        '.section .note.GNU-stack,"",%progbits',
        "#endif",
        "",
    ])
    masm_lines.append("END")
    masm_lines.append("")

    (C_REPO / c_s_filename).write_text("\n".join(att_lines), encoding="utf-8")
    (C_REPO / "msvc" / msvc_filename).write_text("\n".join(masm_lines), encoding="utf-8")


ARM64_VREG_REMAPS = {
    "areion256PermuteRCAsm": {15: 31},
    "areion256InversePermuteRCAsm": {15: 31},
    "areion512PermuteRCAsm": {15: 31},
    "areion512InversePermuteRCAsm": {15: 31},
    "areionSoEM256Asm": {8: 16, 9: 17, 10: 18, 11: 19, 15: 20},
    "areionSoEM512Asm": {8: 24, 9: 25, 10: 26, 11: 27, 12: 28, 13: 29, 15: 30},
    "areion256Permutex4RC": {8: 17, 9: 18, 10: 19, 11: 20, 15: 21},
    "areion256InversePermutex4RC": {8: 26, 9: 27, 10: 28, 11: 29, 15: 30},
    "areion512Permutex4RC": {
        8: 16, 9: 17, 10: 18, 11: 19,
        12: 20, 13: 21, 14: 22, 15: 23,
        16: 26, 17: 27, 18: 28, 19: 29, 20: 30, 21: 31,
        22: 8, 23: 9,
    },
    "areion512InversePermutex4RC": {
        8: 16, 9: 17, 10: 18, 11: 19,
        12: 20, 13: 21, 14: 22, 15: 23,
        16: 26, 17: 27, 18: 28, 19: 29, 20: 30, 21: 31,
        22: 8, 23: 9,
    },
    "areion256SoEMPermutex4NEON": {
        8: 16, 9: 17, 10: 18, 11: 19,
        12: 20, 13: 21, 14: 22, 15: 23,
        16: 27, 17: 28, 18: 29, 19: 30, 20: 31,
        21: 8, 22: 9, 23: 10,
    },
    "areion512SoEMPermutex4NEON": {
        8: 16, 9: 17, 10: 18, 11: 19,
        12: 20, 13: 21, 14: 22, 15: 23,
        16: 27, 17: 28, 18: 29, 19: 30, 20: 31,
        21: 8, 22: 9, 23: 10,
    },
    "areion256EMEncryptAsm": {8: 16, 9: 17, 10: 18, 11: 19, 15: 20},
    "areion256EMDecryptAsm": {8: 26, 9: 27, 10: 28, 11: 29, 15: 30},
    "areion512EMEncryptAsm": {6: 16, 7: 17, 8: 18, 9: 19, 10: 20, 11: 21, 12: 22, 13: 23, 15: 24},
    "areion512EMDecryptAsm": {15: 31},
    "areion256EM2EncryptAsm": {8: 16, 9: 17, 10: 18, 11: 19, 15: 20},
    "areion256EM2DecryptAsm": {8: 26, 9: 27, 10: 28, 11: 29, 15: 30},
    "areion512EM2EncryptAsm": {6: 16, 7: 17, 8: 18, 9: 19, 10: 20, 11: 21, 12: 22, 13: 23, 15: 24},
    "areion512EM2DecryptAsm": {15: 31},
    "areion256TEMEncryptAsm": {8: 16, 9: 17, 10: 18, 11: 19, 15: 20},
    "areion256TEMDecryptAsm": {8: 26, 9: 27, 10: 28, 11: 29, 15: 30},
    "areion512TEMEncryptAsm": {6: 16, 7: 17, 8: 18, 9: 19, 10: 20, 11: 21, 12: 22, 13: 23, 15: 24},
    "areion512TEMDecryptAsm": {15: 31},
    "areion256TEM2EncryptAsm": {8: 16, 9: 17, 10: 18, 11: 19, 15: 20},
    "areion256TEM2DecryptAsm": {8: 26, 9: 27, 10: 28, 11: 29, 15: 30},
    "areion512TEM2EncryptAsm": {8: 24, 9: 25, 10: 26, 11: 27, 12: 28, 13: 29, 15: 30},
    "areion512TEM2DecryptAsm": {15: 31},
}


def remap_arm64_vregs(line: str, vmap: dict[int, int]) -> str:
    if not vmap:
        return line
    return re.sub(r"\bV(\d+)\b", lambda m: f"V{vmap.get(int(m.group(1)), int(m.group(1)))}", line)


def translate_arm64_file():
    src = (GO_REPO / "areion_arm64.s").read_text(encoding="utf-8")
    blocks = re.split(r"(?=^TEXT )", src, flags=re.M)

    gas_lines = [
        "/*",
        " * Copyright (c) 2026 Andrey Kuvshinov",
        " *",
        " * Dual-licensed under Apache-2.0 OR MIT.",
        " * See LICENSE-APACHE and LICENSE-MIT for details.",
        " */",
        "",
        "#if defined(__aarch64__) || defined(_M_ARM64)",
        '#include "asm_abi.h"',
        "",
        "#if !defined(__APPLE__)",
        ".arch armv8-a+crypto",
        "#endif",
        ".text",
        "",
    ]

    armasm_lines = [
        "; Copyright (c) 2026 Andrey Kuvshinov",
        "; SPDX-License-Identifier: Apache-2.0 OR MIT",
        "",
        "    AREA |.text|, CODE, READONLY, ALIGN=4",
        "    IMPORT roundConstantsP1",
        "    IMPORT roundConstantsP2",
        "",
    ]

    for block in blocks:
        if not block.startswith("TEXT "):
            continue
        lines = [l.strip() for l in block.splitlines() if l.strip() and not l.strip().startswith("//")]
        header = lines[0]
        fname = re.search(r"TEXT ·(\w+)\(SB\)", header).group(1)

        if fname in ("dumpSIMDRegs", "clobberScratchGPRs", "dirtySIMDRegForTest"):
            if fname == "clobberScratchGPRs":
                gas_lines.append("AREION_FUNC_START(clobberScratchGPRs)")
                armasm_lines.append("    EXPORT clobberScratchGPRs")
                armasm_lines.append("clobberScratchGPRs PROC")
                armasm_lines.append("    hint #34 ; bti c")
                for v in list(range(0, 8)) + list(range(16, 32)):
                    gas_lines.append(f"    eor v{v}.16b, v{v}.16b, v{v}.16b")
                    armasm_lines.append(f"    eor v{v}.16b, v{v}.16b, v{v}.16b")
                for v in range(8, 16):
                    gas_lines.append(f"    mov v{v}.d[1], xzr")
                    armasm_lines.append(f"    mov v{v}.d[1], xzr")
                for r in range(0, 18):
                    gas_lines.append(f"    mov x{r}, xzr")
                    armasm_lines.append(f"    mov x{r}, xzr")
                gas_lines.extend(["    ret", "AREION_FUNC_END(clobberScratchGPRs)", ""])
                armasm_lines.extend(["    ret", "    ENDP", ""])
            elif fname == "dumpSIMDRegs":
                gas_lines.append("AREION_FUNC_START(dumpSIMDRegs)")
                armasm_lines.append("    EXPORT dumpSIMDRegs")
                armasm_lines.append("dumpSIMDRegs PROC")
                armasm_lines.append("    hint #34 ; bti c")
                for r in range(1, 18):
                    off = 512 + (r - 1) * 8
                    gas_lines.append(f"    str x{r}, [x0, #{off}]")
                    armasm_lines.append(f"    str x{r}, [x0, #{off}]")
                for idx in range(17, 24):
                    off = 512 + idx * 8
                    gas_lines.append(f"    str xzr, [x0, #{off}]")
                    armasm_lines.append(f"    str xzr, [x0, #{off}]")
                for base in range(0, 28, 4):
                    ins = f"    st1 {{v{base}.16b, v{base+1}.16b, v{base+2}.16b, v{base+3}.16b}}, [x0], #64"
                    gas_lines.append(ins)
                    armasm_lines.append(ins)
                gas_lines.append("    st1 {v28.16b, v29.16b, v30.16b, v31.16b}, [x0]")
                armasm_lines.append("    st1 {v28.16b, v29.16b, v30.16b, v31.16b}, [x0]")
                for v in list(range(0, 8)) + list(range(16, 32)):
                    gas_lines.append(f"    eor v{v}.16b, v{v}.16b, v{v}.16b")
                    armasm_lines.append(f"    eor v{v}.16b, v{v}.16b, v{v}.16b")
                for v in range(8, 16):
                    gas_lines.append(f"    mov v{v}.d[1], xzr")
                    armasm_lines.append(f"    mov v{v}.d[1], xzr")
                for r in range(0, 18):
                    gas_lines.append(f"    mov x{r}, xzr")
                    armasm_lines.append(f"    mov x{r}, xzr")
                gas_lines.extend(["    ret", "AREION_FUNC_END(dumpSIMDRegs)", ""])
                armasm_lines.extend(["    ret", "    ENDP", ""])
            elif fname == "dirtySIMDRegForTest":
                gas_lines.extend([
                    "AREION_FUNC_START(dirtySIMDRegForTest)",
                    "    mov x12, x0",
                    "    mov x0, #0x5555555555555555",
                    "    eor x12, x12, x0",
                    "    mov v2.d[0], x12",
                    "    mov x0, xzr",
                    "    ret",
                    "AREION_FUNC_END(dirtySIMDRegForTest)",
                    "",
                ])
                armasm_lines.extend([
                    "    EXPORT dirtySIMDRegForTest",
                    "dirtySIMDRegForTest PROC",
                    "    hint #34 ; bti c",
                    "    mov x12, x0",
                    "    mov x0, #0x5555555555555555",
                    "    eor x12, x12, x0",
                    "    mov v2.d[0], x12",
                    "    mov x0, xzr",
                    "    ret",
                    "    ENDP",
                    "",
                ])
            continue
        c_fname = fname
        vmap = ARM64_VREG_REMAPS.get(fname, {})

        arg_loads = []
        body_lines = []
        for l in lines[1:]:
            m_arg = re.match(r"^MOVD\s+\w+\+(\d+)\(FP\),\s*R(\d+)$", l)
            if m_arg and not body_lines:
                arg_loads.append((int(m_arg.group(1)), int(m_arg.group(2))))
            else:
                body_lines.append(remap_arm64_vregs(l, vmap))

        # Check which callee-saved V8..V15 registers remain in body after remapping
        used_callee_v = []
        all_body = "\n".join(body_lines)
        for v in range(8, 16):
            if re.search(rf"\bV{v}\b", all_body):
                used_callee_v.append(v)
        assert used_callee_v in ([], [8, 9], [8, 9, 10], [8, 9, 10, 11, 12, 13]), f"{fname}: unexpected callee V-regs {used_callee_v}"

        gas_lines.append(f"AREION_FUNC_START({c_fname})")
        armasm_lines.append(f"    EXPORT {c_fname}")
        armasm_lines.append(f"{c_fname} PROC")
        armasm_lines.append("    hint #34 ; bti c")

        if used_callee_v == [8, 9]:
            gas_lines.append("    stp d8, d9, [sp, #-16]!")
            armasm_lines.append("    stp d8, d9, [sp, #-16]!")
        elif used_callee_v == [8, 9, 10]:
            gas_lines.append("    sub sp, sp, #32")
            gas_lines.append("    stp d8, d9, [sp]")
            gas_lines.append("    str d10, [sp, #16]")
            armasm_lines.append("    sub sp, sp, #32")
            armasm_lines.append("    stp d8, d9, [sp]")
            armasm_lines.append("    str d10, [sp, #16]")
        elif used_callee_v == [8, 9, 10, 11, 12, 13]:
            gas_lines.append("    sub sp, sp, #48")
            gas_lines.append("    stp d8, d9, [sp]")
            gas_lines.append("    stp d10, d11, [sp, #16]")
            gas_lines.append("    stp d12, d13, [sp, #32]")
            armasm_lines.append("    sub sp, sp, #48")
            armasm_lines.append("    stp d8, d9, [sp]")
            armasm_lines.append("    stp d10, d11, [sp, #16]")
            armasm_lines.append("    stp d12, d13, [sp, #32]")

        # Argument moves (AAPCS64 passes args 0..7 in x0..x7)
        arg_moves = [(f"x{idx}", f"x{dst}") for idx, (_, dst) in enumerate(arg_loads)]
        arm64_resolved = solve_parallel_moves(arg_moves, scratch="x16")
        for src_r, dst_r in arm64_resolved:
            gas_lines.append(f"    mov {dst_r}, {src_r}")
            armasm_lines.append(f"    mov {dst_r}, {src_r}")

        prologue_uses_x16 = any("x16" in (s, d) for s, d in arm64_resolved)
        body_zeroes_x16 = any(l == "MOVD ZR, R16" for l in body_lines)

        def fmt_vlist(vlist_str: str) -> str:
            regs = [r.strip().lower().replace(".b16", ".16b") for r in vlist_str.split(",")]
            return "{ " + ", ".join(regs) + " }"

        for l in body_lines:
            if l == "RET":
                if prologue_uses_x16 and not body_zeroes_x16:
                    gas_lines.append("    mov x16, xzr")
                    armasm_lines.append("    mov x16, xzr")
                if used_callee_v == [8, 9]:
                    gas_lines.append("    ldp d8, d9, [sp]")
                    gas_lines.append("    stp xzr, xzr, [sp], #16")
                    armasm_lines.append("    ldp d8, d9, [sp]")
                    armasm_lines.append("    stp xzr, xzr, [sp], #16")
                elif used_callee_v == [8, 9, 10]:
                    gas_lines.append("    ldp d8, d9, [sp]")
                    gas_lines.append("    ldr d10, [sp, #16]")
                    gas_lines.append("    stp xzr, xzr, [sp]")
                    gas_lines.append("    str xzr, [sp, #16]")
                    gas_lines.append("    add sp, sp, #32")
                    armasm_lines.append("    ldp d8, d9, [sp]")
                    armasm_lines.append("    ldr d10, [sp, #16]")
                    armasm_lines.append("    stp xzr, xzr, [sp]")
                    armasm_lines.append("    str xzr, [sp, #16]")
                    armasm_lines.append("    add sp, sp, #32")
                elif used_callee_v == [8, 9, 10, 11, 12, 13]:
                    gas_lines.append("    ldp d8, d9, [sp]")
                    gas_lines.append("    ldp d10, d11, [sp, #16]")
                    gas_lines.append("    ldp d12, d13, [sp, #32]")
                    gas_lines.append("    stp xzr, xzr, [sp]")
                    gas_lines.append("    stp xzr, xzr, [sp, #16]")
                    gas_lines.append("    stp xzr, xzr, [sp, #32]")
                    gas_lines.append("    add sp, sp, #48")
                    armasm_lines.append("    ldp d8, d9, [sp]")
                    armasm_lines.append("    ldp d10, d11, [sp, #16]")
                    armasm_lines.append("    ldp d12, d13, [sp, #32]")
                    armasm_lines.append("    stp xzr, xzr, [sp]")
                    armasm_lines.append("    stp xzr, xzr, [sp, #16]")
                    armasm_lines.append("    stp xzr, xzr, [sp, #32]")
                    armasm_lines.append("    add sp, sp, #48")
                gas_lines.append("    ret")
                armasm_lines.append("    ret")
                continue

            m = re.match(r"^VLD1\s+\(R(\d+)\),\s*\[([^\]]+)\]$", l)
            if m:
                ins = f"ld1 {fmt_vlist(m.group(2))}, [x{m.group(1)}]"
                gas_lines.append(f"    {ins}")
                armasm_lines.append(f"    {ins}")
                continue

            m = re.match(r"^VLD1\.P\s+(\d+)\(R(\d+)\),\s*\[([^\]]+)\]$", l)
            if m:
                ins = f"ld1 {fmt_vlist(m.group(3))}, [x{m.group(2)}], #{m.group(1)}"
                gas_lines.append(f"    {ins}")
                armasm_lines.append(f"    {ins}")
                continue

            m = re.match(r"^VST1\s+\[([^\]]+)\],\s*\(R(\d+)\)$", l)
            if m:
                ins = f"st1 {fmt_vlist(m.group(1))}, [x{m.group(2)}]"
                gas_lines.append(f"    {ins}")
                armasm_lines.append(f"    {ins}")
                continue

            m = re.match(r"^VST1\.P\s+\[([^\]]+)\],\s*(\d+)\(R(\d+)\)$", l)
            if m:
                ins = f"st1 {fmt_vlist(m.group(1))}, [x{m.group(3)}], #{m.group(2)}"
                gas_lines.append(f"    {ins}")
                armasm_lines.append(f"    {ins}")
                continue

            m = re.match(r"^(AESE|AESD|AESMC|AESIMC|VMOV)\s+V(\d+)\.B16,\s*V(\d+)\.B16$", l)
            if m:
                op_map = {"AESE": "aese", "AESD": "aesd", "AESMC": "aesmc", "AESIMC": "aesimc", "VMOV": "mov"}
                ins = f"{op_map[m.group(1)]} v{m.group(3)}.16b, v{m.group(2)}.16b"
                gas_lines.append(f"    {ins}")
                armasm_lines.append(f"    {ins}")
                continue

            m = re.match(r"^VEOR\s+V(\d+)\.B16,\s*V(\d+)\.B16,\s*V(\d+)\.B16$", l)
            if m:
                ins = f"eor v{m.group(3)}.16b, v{m.group(2)}.16b, v{m.group(1)}.16b"
                gas_lines.append(f"    {ins}")
                armasm_lines.append(f"    {ins}")
                continue

            m = re.match(r"^(ADD|SUB)\s+\$(\d+),\s*R(\d+),\s*R(\d+)$", l)
            if m:
                ins = f"{m.group(1).lower()} x{m.group(4)}, x{m.group(3)}, #{m.group(2)}"
                gas_lines.append(f"    {ins}")
                armasm_lines.append(f"    {ins}")
                continue

            m = re.match(r"^MOVD\s+\$·(\w+)\(SB\),\s*R(\d+)$", l)
            if m:
                sym, r = m.group(1), m.group(2)
                gas_lines.append(f"    AREION_ARM64_ADR(x{r}, {sym})")
                armasm_lines.append(f"    adrp x{r}, {sym}")
                armasm_lines.append(f"    add x{r}, x{r}, {sym}")
                continue

            m = re.match(r"^MOVD\s+ZR,\s*R(\d+)$", l)
            if m:
                ins = f"mov x{m.group(1)}, xzr"
                gas_lines.append(f"    {ins}")
                armasm_lines.append(f"    {ins}")
                continue

            m = re.match(r"^MOVD\s+R(\d+),\s*(\d+)\(R(\d+)\)$", l)
            if m:
                ins = f"str x{m.group(1)}, [x{m.group(3)}, #{m.group(2)}]"
                gas_lines.append(f"    {ins}")
                armasm_lines.append(f"    {ins}")
                continue

            m = re.match(r"^MOVD\s+\$0x5555555555555555,\s*R(\d+)$", l)
            if m:
                ins = f"mov x{m.group(1)}, #0x5555555555555555"
                gas_lines.append(f"    {ins}")
                armasm_lines.append(f"    {ins}")
                continue

            m = re.match(r"^EOR\s+R(\d+),\s*R(\d+),\s*R(\d+)$", l)
            if m:
                ins = f"eor x{m.group(3)}, x{m.group(2)}, x{m.group(1)}"
                gas_lines.append(f"    {ins}")
                armasm_lines.append(f"    {ins}")
                continue

            m = re.match(r"^VMOV\s+R(\d+),\s*V(\d+)\.D\[0\]$", l)
            if m:
                ins = f"mov v{m.group(2)}.d[0], x{m.group(1)}"
                gas_lines.append(f"    {ins}")
                armasm_lines.append(f"    {ins}")
                continue

            raise RuntimeError(f"Unhandled ARM64 instruction in {fname}: {l}")

        gas_lines.append(f"AREION_FUNC_END({c_fname})")
        gas_lines.append("")
        armasm_lines.append(f"    ENDP")
        armasm_lines.append("")

    gas_lines.extend([
        "#endif /* __aarch64__ || _M_ARM64 */",
        "",
        "#if defined(__linux__) && defined(__ELF__)",
        "#if defined(__x86_64__)",
        '.pushsection .note.gnu.property, "a"',
        ".p2align 3",
        ".long 4",
        ".long 16",
        ".long 5",
        '.asciz "GNU"',
        ".long 0xc0000002",
        ".long 4",
        ".long 3",
        ".long 0",
        ".popsection",
        "#elif defined(__aarch64__)",
        '.pushsection .note.gnu.property, "a"',
        ".p2align 3",
        ".long 4",
        ".long 16",
        ".long 5",
        '.asciz "GNU"',
        ".long 0xc0000000",
        ".long 4",
        ".long 3",
        ".long 0",
        ".popsection",
        "#endif",
        '.section .note.GNU-stack,"",%progbits',
        "#endif",
        "",
    ])
    armasm_lines.append("    END")
    armasm_lines.append("")

    (C_REPO / "areion_arm64.S").write_text("\n".join(gas_lines), encoding="utf-8")
    (C_REPO / "msvc" / "areion_arm64.asm").write_text("\n".join(armasm_lines), encoding="utf-8")


def main() -> int:
    (C_REPO / "msvc").mkdir(parents=True, exist_ok=True)
    translate_x86_file("areion_amd64.s", "areion_amd64.S", "areion_amd64.asm")
    translate_x86_file("areion_soem256_amd64.s", "areion_soem256_amd64.S", "areion_soem256_amd64.asm")
    translate_x86_file("areion_soem512_amd64.s", "areion_soem512_amd64.S", "areion_soem512_amd64.asm")
    translate_x86_file("areion_soem_aesni_amd64.s", "areion_soem_aesni_amd64.S", "areion_soem_aesni_amd64.asm")
    translate_arm64_file()
    print("OK: Generated all GNU GAS (.S) and MSVC (msvc/*.asm) assembly files.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
