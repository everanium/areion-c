; Copyright (c) 2026 Andrey Kuvshinov
; SPDX-License-Identifier: Apache-2.0 OR MIT

EXTERN vistrutahRoundConstants:BYTE
EXTERN vistrutahConsts:BYTE

.code

PUBLIC vistrutah256EncryptBlockAsm
ALIGN 16
vistrutah256EncryptBlockAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 104
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    movdqu XMMWORD PTR [rsp + 64], xmm9
    movdqu XMMWORD PTR [rsp + 80], xmm10
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    movdqu xmm2, XMMWORD PTR [rdx]
    movdqu xmm3, XMMWORD PTR [rdx + 16]
    movdqa xmm4, xmm3
    movdqa xmm5, xmm2
    pxor xmm6, xmm6
    movdqu xmm7, XMMWORD PTR [vistrutahConsts]
    movdqu xmm8, XMMWORD PTR [vistrutahConsts + 16]
    movdqu xmm9, XMMWORD PTR [vistrutahConsts + 64]
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    aesenc xmm0, xmm2
    aesenc xmm1, xmm3
    aesenc xmm0, xmm6
    aesenc xmm1, xmm6
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm10, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm10, xmm1
    movdqa xmm1, xmm10
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    movdqu xmm10, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm0, xmm4
    pxor xmm0, xmm10
    pxor xmm1, xmm5
    aesenc xmm0, xmm2
    aesenc xmm1, xmm3
    aesenc xmm0, xmm6
    aesenc xmm1, xmm6
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm10, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm10, xmm1
    movdqa xmm1, xmm10
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    movdqu xmm10, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm0, xmm4
    pxor xmm0, xmm10
    pxor xmm1, xmm5
    aesenc xmm0, xmm2
    aesenc xmm1, xmm3
    aesenc xmm0, xmm6
    aesenc xmm1, xmm6
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm10, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm10, xmm1
    movdqa xmm1, xmm10
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    movdqu xmm10, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm0, xmm4
    pxor xmm0, xmm10
    pxor xmm1, xmm5
    aesenc xmm0, xmm2
    aesenc xmm1, xmm3
    aesenc xmm0, xmm6
    aesenc xmm1, xmm6
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm10, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm10, xmm1
    movdqa xmm1, xmm10
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    movdqu xmm10, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm0, xmm4
    pxor xmm0, xmm10
    pxor xmm1, xmm5
    cmp rcx, 10
    je v256_blk_aesni_final
    aesenc xmm0, xmm2
    aesenc xmm1, xmm3
    aesenc xmm0, xmm6
    aesenc xmm1, xmm6
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm10, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm10, xmm1
    movdqa xmm1, xmm10
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    movdqu xmm10, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm0, xmm4
    pxor xmm0, xmm10
    pxor xmm1, xmm5
    aesenc xmm0, xmm2
    aesenc xmm1, xmm3
    aesenc xmm0, xmm6
    aesenc xmm1, xmm6
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm10, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm10, xmm1
    movdqa xmm1, xmm10
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    movdqu xmm10, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm0, xmm4
    pxor xmm0, xmm10
    pxor xmm1, xmm5
v256_blk_aesni_final:
    aesenc xmm0, xmm2
    aesenc xmm1, xmm3
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    aesenclast xmm0, xmm4
    aesenclast xmm1, xmm5
    movdqu XMMWORD PTR [rdi], xmm0
    movdqu XMMWORD PTR [rdi + 16], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    movdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 104
    ret
vistrutah256EncryptBlockAsm ENDP

PUBLIC vistrutah256DecryptBlockAsm
ALIGN 16
vistrutah256DecryptBlockAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 72
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    movdqu xmm2, XMMWORD PTR [rdx]
    movdqu xmm3, XMMWORD PTR [rdx + 16]
    movdqa xmm4, xmm3
    movdqa xmm5, xmm2
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    movdqu xmm7, XMMWORD PTR [vistrutahConsts + 352]
    movdqu xmm8, XMMWORD PTR [vistrutahConsts + 368]
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    cmp rcx, 10
    je v256_dec_blk_aesni_init_done
    movdqu xmm7, XMMWORD PTR [vistrutahConsts]
    movdqu xmm8, XMMWORD PTR [vistrutahConsts + 16]
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
v256_dec_blk_aesni_init_done:
    movdqu xmm7, XMMWORD PTR [vistrutahConsts + 288]
    movdqu xmm8, XMMWORD PTR [vistrutahConsts + 304]
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    cmp rcx, 10
    je v256_dec_blk_aesni_step4
    aesdec xmm0, xmm2
    aesdec xmm1, xmm3
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    movdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm6, xmm4
    aesdeclast xmm0, xmm6
    aesdeclast xmm1, xmm5
    movdqa xmm6, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm6, xmm1
    movdqa xmm1, xmm6
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesdec xmm0, xmm2
    aesdec xmm1, xmm3
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    movdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm6, xmm4
    aesdeclast xmm0, xmm6
    aesdeclast xmm1, xmm5
    movdqa xmm6, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm6, xmm1
    movdqa xmm1, xmm6
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
v256_dec_blk_aesni_step4:
    aesdec xmm0, xmm2
    aesdec xmm1, xmm3
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    movdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm6, xmm4
    aesdeclast xmm0, xmm6
    aesdeclast xmm1, xmm5
    movdqa xmm6, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm6, xmm1
    movdqa xmm1, xmm6
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesdec xmm0, xmm2
    aesdec xmm1, xmm3
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    movdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm6, xmm4
    aesdeclast xmm0, xmm6
    aesdeclast xmm1, xmm5
    movdqa xmm6, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm6, xmm1
    movdqa xmm1, xmm6
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesdec xmm0, xmm2
    aesdec xmm1, xmm3
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    movdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm6, xmm4
    aesdeclast xmm0, xmm6
    aesdeclast xmm1, xmm5
    movdqa xmm6, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm6, xmm1
    movdqa xmm1, xmm6
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesdec xmm0, xmm2
    aesdec xmm1, xmm3
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    movdqu xmm6, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm6, xmm4
    aesdeclast xmm0, xmm6
    aesdeclast xmm1, xmm5
    movdqa xmm6, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm6, xmm1
    movdqa xmm1, xmm6
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesdec xmm0, xmm2
    aesdec xmm1, xmm3
    pshufb xmm4, xmm7
    pshufb xmm5, xmm8
    aesdeclast xmm0, xmm4
    aesdeclast xmm1, xmm5
    movdqu XMMWORD PTR [rdi], xmm0
    movdqu XMMWORD PTR [rdi + 16], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    movdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 72
    ret
vistrutah256DecryptBlockAsm ENDP

PUBLIC vistrutah256EncryptBlockVexAsm
ALIGN 16
vistrutah256EncryptBlockVexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 120
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rdx]
    vmovdqu xmm3, XMMWORD PTR [rdx + 16]
    vmovdqa xmm4, xmm3
    vmovdqa xmm5, xmm2
    vpxor xmm6, xmm6, xmm6
    vmovdqu xmm7, XMMWORD PTR [vistrutahConsts]
    vmovdqu xmm8, XMMWORD PTR [vistrutahConsts + 16]
    vmovdqu xmm9, XMMWORD PTR [vistrutahConsts + 64]
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vaesenc xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm3
    vaesenc xmm0, xmm0, xmm6
    vaesenc xmm1, xmm1, xmm6
    vpshufb xmm10, xmm0, xmm9
    vpshufb xmm11, xmm1, xmm9
    vpunpcklqdq xmm0, xmm10, xmm11
    vpunpckhqdq xmm1, xmm10, xmm11
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
    vpxor xmm10, xmm4, XMMWORD PTR [vistrutahRoundConstants]
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm5
    vaesenc xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm3
    vaesenc xmm0, xmm0, xmm6
    vaesenc xmm1, xmm1, xmm6
    vpshufb xmm10, xmm0, xmm9
    vpshufb xmm11, xmm1, xmm9
    vpunpcklqdq xmm0, xmm10, xmm11
    vpunpckhqdq xmm1, xmm10, xmm11
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
    vpxor xmm10, xmm4, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm5
    vaesenc xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm3
    vaesenc xmm0, xmm0, xmm6
    vaesenc xmm1, xmm1, xmm6
    vpshufb xmm10, xmm0, xmm9
    vpshufb xmm11, xmm1, xmm9
    vpunpcklqdq xmm0, xmm10, xmm11
    vpunpckhqdq xmm1, xmm10, xmm11
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
    vpxor xmm10, xmm4, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm5
    vaesenc xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm3
    vaesenc xmm0, xmm0, xmm6
    vaesenc xmm1, xmm1, xmm6
    vpshufb xmm10, xmm0, xmm9
    vpshufb xmm11, xmm1, xmm9
    vpunpcklqdq xmm0, xmm10, xmm11
    vpunpckhqdq xmm1, xmm10, xmm11
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
    vpxor xmm10, xmm4, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm5
    cmp rcx, 10
    je v256_blk_vex_final
    vaesenc xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm3
    vaesenc xmm0, xmm0, xmm6
    vaesenc xmm1, xmm1, xmm6
    vpshufb xmm10, xmm0, xmm9
    vpshufb xmm11, xmm1, xmm9
    vpunpcklqdq xmm0, xmm10, xmm11
    vpunpckhqdq xmm1, xmm10, xmm11
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
    vpxor xmm10, xmm4, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm5
    vaesenc xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm3
    vaesenc xmm0, xmm0, xmm6
    vaesenc xmm1, xmm1, xmm6
    vpshufb xmm10, xmm0, xmm9
    vpshufb xmm11, xmm1, xmm9
    vpunpcklqdq xmm0, xmm10, xmm11
    vpunpckhqdq xmm1, xmm10, xmm11
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
    vpxor xmm10, xmm4, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm5
v256_blk_vex_final:
    vaesenc xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm3
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
    vaesenclast xmm0, xmm0, xmm4
    vaesenclast xmm1, xmm1, xmm5
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 120
    ret
vistrutah256EncryptBlockVexAsm ENDP

PUBLIC vistrutah256DecryptBlockVexAsm
ALIGN 16
vistrutah256DecryptBlockVexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 72
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rdx]
    vmovdqu xmm3, XMMWORD PTR [rdx + 16]
    vmovdqa xmm4, xmm3
    vmovdqa xmm5, xmm2
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vpshufb xmm4, xmm4, XMMWORD PTR [vistrutahConsts + 352]
    vpshufb xmm5, xmm5, XMMWORD PTR [vistrutahConsts + 368]
    cmp rcx, 10
    je v256_dec_blk_vex_init_done
    vmovdqu xmm7, XMMWORD PTR [vistrutahConsts]
    vmovdqu xmm8, XMMWORD PTR [vistrutahConsts + 16]
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
v256_dec_blk_vex_init_done:
    vmovdqu xmm7, XMMWORD PTR [vistrutahConsts + 288]
    vmovdqu xmm8, XMMWORD PTR [vistrutahConsts + 304]
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    cmp rcx, 10
    je v256_dec_blk_vex_step4
    vaesdec xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm3
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
    vpxor xmm6, xmm4, XMMWORD PTR [vistrutahRoundConstants + 80]
    vaesdeclast xmm0, xmm0, xmm6
    vaesdeclast xmm1, xmm1, xmm5
    vpunpcklbw xmm6, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm6
    vaesimc xmm1, xmm1
    vaesdec xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm3
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
    vpxor xmm6, xmm4, XMMWORD PTR [vistrutahRoundConstants + 64]
    vaesdeclast xmm0, xmm0, xmm6
    vaesdeclast xmm1, xmm1, xmm5
    vpunpcklbw xmm6, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm6
    vaesimc xmm1, xmm1
v256_dec_blk_vex_step4:
    vaesdec xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm3
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
    vpxor xmm6, xmm4, XMMWORD PTR [vistrutahRoundConstants + 48]
    vaesdeclast xmm0, xmm0, xmm6
    vaesdeclast xmm1, xmm1, xmm5
    vpunpcklbw xmm6, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm6
    vaesimc xmm1, xmm1
    vaesdec xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm3
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
    vpxor xmm6, xmm4, XMMWORD PTR [vistrutahRoundConstants + 32]
    vaesdeclast xmm0, xmm0, xmm6
    vaesdeclast xmm1, xmm1, xmm5
    vpunpcklbw xmm6, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm6
    vaesimc xmm1, xmm1
    vaesdec xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm3
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
    vpxor xmm6, xmm4, XMMWORD PTR [vistrutahRoundConstants + 16]
    vaesdeclast xmm0, xmm0, xmm6
    vaesdeclast xmm1, xmm1, xmm5
    vpunpcklbw xmm6, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm6
    vaesimc xmm1, xmm1
    vaesdec xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm3
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
    vpxor xmm6, xmm4, XMMWORD PTR [vistrutahRoundConstants]
    vaesdeclast xmm0, xmm0, xmm6
    vaesdeclast xmm1, xmm1, xmm5
    vpunpcklbw xmm6, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm6
    vaesimc xmm1, xmm1
    vaesdec xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm3
    vpshufb xmm4, xmm4, xmm7
    vpshufb xmm5, xmm5, xmm8
    vaesdeclast xmm0, xmm0, xmm4
    vaesdeclast xmm1, xmm1, xmm5
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 72
    ret
vistrutah256DecryptBlockVexAsm ENDP

PUBLIC vistrutah256EncryptBlockYmmAsm
ALIGN 16
vistrutah256EncryptBlockYmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 40
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu ymm0, YMMWORD PTR [rsi]
    vmovdqu ymm1, YMMWORD PTR [rdx]
    vperm2i128 ymm2, ymm1, ymm1, 1
    vpxor xmm3, xmm3, xmm3
    vmovdqu ymm4, YMMWORD PTR [vistrutahConsts]
    vmovdqu ymm5, YMMWORD PTR [vistrutahConsts + 64]
    vpxor ymm0, ymm0, ymm2
    vaesenc ymm0, ymm0, ymm1
    vaesenc ymm0, ymm0, ymm3
    vpshufb ymm0, ymm0, ymm5
    vpermq ymm0, ymm0, 216
    vpshufb ymm2, ymm2, ymm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants]
    vpxor ymm6, ymm6, ymm2
    vpxor ymm0, ymm0, ymm6
    vaesenc ymm0, ymm0, ymm1
    vaesenc ymm0, ymm0, ymm3
    vpshufb ymm0, ymm0, ymm5
    vpermq ymm0, ymm0, 216
    vpshufb ymm2, ymm2, ymm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor ymm6, ymm6, ymm2
    vpxor ymm0, ymm0, ymm6
    vaesenc ymm0, ymm0, ymm1
    vaesenc ymm0, ymm0, ymm3
    vpshufb ymm0, ymm0, ymm5
    vpermq ymm0, ymm0, 216
    vpshufb ymm2, ymm2, ymm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor ymm6, ymm6, ymm2
    vpxor ymm0, ymm0, ymm6
    vaesenc ymm0, ymm0, ymm1
    vaesenc ymm0, ymm0, ymm3
    vpshufb ymm0, ymm0, ymm5
    vpermq ymm0, ymm0, 216
    vpshufb ymm2, ymm2, ymm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor ymm6, ymm6, ymm2
    vpxor ymm0, ymm0, ymm6
    cmp rcx, 10
    je v256_blk_ymm_final
    vaesenc ymm0, ymm0, ymm1
    vaesenc ymm0, ymm0, ymm3
    vpshufb ymm0, ymm0, ymm5
    vpermq ymm0, ymm0, 216
    vpshufb ymm2, ymm2, ymm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor ymm6, ymm6, ymm2
    vpxor ymm0, ymm0, ymm6
    vaesenc ymm0, ymm0, ymm1
    vaesenc ymm0, ymm0, ymm3
    vpshufb ymm0, ymm0, ymm5
    vpermq ymm0, ymm0, 216
    vpshufb ymm2, ymm2, ymm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor ymm6, ymm6, ymm2
    vpxor ymm0, ymm0, ymm6
v256_blk_ymm_final:
    vaesenc ymm0, ymm0, ymm1
    vpshufb ymm2, ymm2, ymm4
    vaesenclast ymm0, ymm0, ymm2
    vmovdqu YMMWORD PTR [rdi], ymm0
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 40
    vzeroupper
    ret
vistrutah256EncryptBlockYmmAsm ENDP

PUBLIC vistrutah256DecryptBlockYmmAsm
ALIGN 16
vistrutah256DecryptBlockYmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 40
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu ymm0, YMMWORD PTR [rsi]
    vmovdqu ymm1, YMMWORD PTR [rdx]
    vperm2i128 ymm2, ymm1, ymm1, 1
    vpxor xmm3, xmm3, xmm3
    vaesenclast ymm1, ymm1, ymm3
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm2, ymm2, YMMWORD PTR [vistrutahConsts + 352]
    cmp rcx, 10
    je v256_dec_blk_ymm_init_done
    vmovdqu ymm4, YMMWORD PTR [vistrutahConsts]
    vpshufb ymm2, ymm2, ymm4
    vpshufb ymm2, ymm2, ymm4
v256_dec_blk_ymm_init_done:
    vmovdqu ymm4, YMMWORD PTR [vistrutahConsts + 288]
    vmovdqu ymm5, YMMWORD PTR [vistrutahConsts + 416]
    vpxor ymm0, ymm0, ymm2
    cmp rcx, 10
    je v256_dec_blk_ymm_step4
    vaesdec ymm0, ymm0, ymm1
    vpshufb ymm2, ymm2, ymm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor ymm6, ymm6, ymm2
    vaesdeclast ymm0, ymm0, ymm6
    vpermq ymm0, ymm0, 216
    vpshufb ymm0, ymm0, ymm5
    vaesenclast ymm0, ymm0, ymm3
    vaesdec ymm0, ymm0, ymm3
    vaesdec ymm0, ymm0, ymm1
    vpshufb ymm2, ymm2, ymm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor ymm6, ymm6, ymm2
    vaesdeclast ymm0, ymm0, ymm6
    vpermq ymm0, ymm0, 216
    vpshufb ymm0, ymm0, ymm5
    vaesenclast ymm0, ymm0, ymm3
    vaesdec ymm0, ymm0, ymm3
v256_dec_blk_ymm_step4:
    vaesdec ymm0, ymm0, ymm1
    vpshufb ymm2, ymm2, ymm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor ymm6, ymm6, ymm2
    vaesdeclast ymm0, ymm0, ymm6
    vpermq ymm0, ymm0, 216
    vpshufb ymm0, ymm0, ymm5
    vaesenclast ymm0, ymm0, ymm3
    vaesdec ymm0, ymm0, ymm3
    vaesdec ymm0, ymm0, ymm1
    vpshufb ymm2, ymm2, ymm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor ymm6, ymm6, ymm2
    vaesdeclast ymm0, ymm0, ymm6
    vpermq ymm0, ymm0, 216
    vpshufb ymm0, ymm0, ymm5
    vaesenclast ymm0, ymm0, ymm3
    vaesdec ymm0, ymm0, ymm3
    vaesdec ymm0, ymm0, ymm1
    vpshufb ymm2, ymm2, ymm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor ymm6, ymm6, ymm2
    vaesdeclast ymm0, ymm0, ymm6
    vpermq ymm0, ymm0, 216
    vpshufb ymm0, ymm0, ymm5
    vaesenclast ymm0, ymm0, ymm3
    vaesdec ymm0, ymm0, ymm3
    vaesdec ymm0, ymm0, ymm1
    vpshufb ymm2, ymm2, ymm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants]
    vpxor ymm6, ymm6, ymm2
    vaesdeclast ymm0, ymm0, ymm6
    vpermq ymm0, ymm0, 216
    vpshufb ymm0, ymm0, ymm5
    vaesenclast ymm0, ymm0, ymm3
    vaesdec ymm0, ymm0, ymm3
    vaesdec ymm0, ymm0, ymm1
    vpshufb ymm2, ymm2, ymm4
    vaesdeclast ymm0, ymm0, ymm2
    vmovdqu YMMWORD PTR [rdi], ymm0
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 40
    vzeroupper
    ret
vistrutah256DecryptBlockYmmAsm ENDP

PUBLIC vistrutah256Encrypt4BlocksAesNiAsm
ALIGN 16
vistrutah256Encrypt4BlocksAesNiAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    movdqu XMMWORD PTR [rsp + 64], xmm9
    movdqu XMMWORD PTR [rsp + 80], xmm10
    movdqu XMMWORD PTR [rsp + 96], xmm11
    movdqu XMMWORD PTR [rsp + 112], xmm12
    movdqu XMMWORD PTR [rsp + 128], xmm13
    movdqu XMMWORD PTR [rsp + 144], xmm14
    movdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    movdqu xmm2, XMMWORD PTR [rsi + 32]
    movdqu xmm3, XMMWORD PTR [rsi + 48]
    movdqu xmm4, XMMWORD PTR [rsi + 64]
    movdqu xmm5, XMMWORD PTR [rsi + 80]
    movdqu xmm6, XMMWORD PTR [rsi + 96]
    movdqu xmm7, XMMWORD PTR [rsi + 112]
    movdqu xmm8, XMMWORD PTR [rdx]
    movdqu xmm9, XMMWORD PTR [rdx + 16]
    movdqa xmm10, xmm9
    movdqa xmm11, xmm8
    pxor xmm12, xmm12
    movdqu xmm13, XMMWORD PTR [vistrutahConsts + 64]
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    pxor xmm4, xmm10
    pxor xmm5, xmm11
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    aesenc xmm0, xmm8
    aesenc xmm1, xmm9
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    pshufb xmm0, xmm13
    pshufb xmm1, xmm13
    movdqa xmm14, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm14, xmm1
    movdqa xmm1, xmm14
    aesenc xmm2, xmm8
    aesenc xmm3, xmm9
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    pshufb xmm2, xmm13
    pshufb xmm3, xmm13
    movdqa xmm14, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm14, xmm3
    movdqa xmm3, xmm14
    aesenc xmm4, xmm8
    aesenc xmm5, xmm9
    aesenc xmm4, xmm12
    aesenc xmm5, xmm12
    pshufb xmm4, xmm13
    pshufb xmm5, xmm13
    movdqa xmm14, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm14, xmm5
    movdqa xmm5, xmm14
    aesenc xmm6, xmm8
    aesenc xmm7, xmm9
    aesenc xmm6, xmm12
    aesenc xmm7, xmm12
    pshufb xmm6, xmm13
    pshufb xmm7, xmm13
    movdqa xmm14, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm14, xmm7
    movdqa xmm7, xmm14
    movdqu xmm14, XMMWORD PTR [vistrutahConsts]
    movdqu xmm15, XMMWORD PTR [vistrutahConsts + 16]
    pshufb xmm10, xmm14
    pshufb xmm11, xmm15
    movdqu xmm14, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm14, xmm10
    pxor xmm0, xmm14
    pxor xmm1, xmm11
    pxor xmm2, xmm14
    pxor xmm3, xmm11
    pxor xmm4, xmm14
    pxor xmm5, xmm11
    pxor xmm6, xmm14
    pxor xmm7, xmm11
    aesenc xmm0, xmm8
    aesenc xmm1, xmm9
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    pshufb xmm0, xmm13
    pshufb xmm1, xmm13
    movdqa xmm14, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm14, xmm1
    movdqa xmm1, xmm14
    aesenc xmm2, xmm8
    aesenc xmm3, xmm9
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    pshufb xmm2, xmm13
    pshufb xmm3, xmm13
    movdqa xmm14, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm14, xmm3
    movdqa xmm3, xmm14
    aesenc xmm4, xmm8
    aesenc xmm5, xmm9
    aesenc xmm4, xmm12
    aesenc xmm5, xmm12
    pshufb xmm4, xmm13
    pshufb xmm5, xmm13
    movdqa xmm14, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm14, xmm5
    movdqa xmm5, xmm14
    aesenc xmm6, xmm8
    aesenc xmm7, xmm9
    aesenc xmm6, xmm12
    aesenc xmm7, xmm12
    pshufb xmm6, xmm13
    pshufb xmm7, xmm13
    movdqa xmm14, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm14, xmm7
    movdqa xmm7, xmm14
    movdqu xmm14, XMMWORD PTR [vistrutahConsts]
    movdqu xmm15, XMMWORD PTR [vistrutahConsts + 16]
    pshufb xmm10, xmm14
    pshufb xmm11, xmm15
    movdqu xmm14, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm14, xmm10
    pxor xmm0, xmm14
    pxor xmm1, xmm11
    pxor xmm2, xmm14
    pxor xmm3, xmm11
    pxor xmm4, xmm14
    pxor xmm5, xmm11
    pxor xmm6, xmm14
    pxor xmm7, xmm11
    aesenc xmm0, xmm8
    aesenc xmm1, xmm9
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    pshufb xmm0, xmm13
    pshufb xmm1, xmm13
    movdqa xmm14, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm14, xmm1
    movdqa xmm1, xmm14
    aesenc xmm2, xmm8
    aesenc xmm3, xmm9
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    pshufb xmm2, xmm13
    pshufb xmm3, xmm13
    movdqa xmm14, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm14, xmm3
    movdqa xmm3, xmm14
    aesenc xmm4, xmm8
    aesenc xmm5, xmm9
    aesenc xmm4, xmm12
    aesenc xmm5, xmm12
    pshufb xmm4, xmm13
    pshufb xmm5, xmm13
    movdqa xmm14, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm14, xmm5
    movdqa xmm5, xmm14
    aesenc xmm6, xmm8
    aesenc xmm7, xmm9
    aesenc xmm6, xmm12
    aesenc xmm7, xmm12
    pshufb xmm6, xmm13
    pshufb xmm7, xmm13
    movdqa xmm14, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm14, xmm7
    movdqa xmm7, xmm14
    movdqu xmm14, XMMWORD PTR [vistrutahConsts]
    movdqu xmm15, XMMWORD PTR [vistrutahConsts + 16]
    pshufb xmm10, xmm14
    pshufb xmm11, xmm15
    movdqu xmm14, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm14, xmm10
    pxor xmm0, xmm14
    pxor xmm1, xmm11
    pxor xmm2, xmm14
    pxor xmm3, xmm11
    pxor xmm4, xmm14
    pxor xmm5, xmm11
    pxor xmm6, xmm14
    pxor xmm7, xmm11
    aesenc xmm0, xmm8
    aesenc xmm1, xmm9
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    pshufb xmm0, xmm13
    pshufb xmm1, xmm13
    movdqa xmm14, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm14, xmm1
    movdqa xmm1, xmm14
    aesenc xmm2, xmm8
    aesenc xmm3, xmm9
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    pshufb xmm2, xmm13
    pshufb xmm3, xmm13
    movdqa xmm14, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm14, xmm3
    movdqa xmm3, xmm14
    aesenc xmm4, xmm8
    aesenc xmm5, xmm9
    aesenc xmm4, xmm12
    aesenc xmm5, xmm12
    pshufb xmm4, xmm13
    pshufb xmm5, xmm13
    movdqa xmm14, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm14, xmm5
    movdqa xmm5, xmm14
    aesenc xmm6, xmm8
    aesenc xmm7, xmm9
    aesenc xmm6, xmm12
    aesenc xmm7, xmm12
    pshufb xmm6, xmm13
    pshufb xmm7, xmm13
    movdqa xmm14, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm14, xmm7
    movdqa xmm7, xmm14
    movdqu xmm14, XMMWORD PTR [vistrutahConsts]
    movdqu xmm15, XMMWORD PTR [vistrutahConsts + 16]
    pshufb xmm10, xmm14
    pshufb xmm11, xmm15
    movdqu xmm14, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm14, xmm10
    pxor xmm0, xmm14
    pxor xmm1, xmm11
    pxor xmm2, xmm14
    pxor xmm3, xmm11
    pxor xmm4, xmm14
    pxor xmm5, xmm11
    pxor xmm6, xmm14
    pxor xmm7, xmm11
    cmp rcx, 10
    je v256_4blk_aesni_final
    aesenc xmm0, xmm8
    aesenc xmm1, xmm9
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    pshufb xmm0, xmm13
    pshufb xmm1, xmm13
    movdqa xmm14, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm14, xmm1
    movdqa xmm1, xmm14
    aesenc xmm2, xmm8
    aesenc xmm3, xmm9
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    pshufb xmm2, xmm13
    pshufb xmm3, xmm13
    movdqa xmm14, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm14, xmm3
    movdqa xmm3, xmm14
    aesenc xmm4, xmm8
    aesenc xmm5, xmm9
    aesenc xmm4, xmm12
    aesenc xmm5, xmm12
    pshufb xmm4, xmm13
    pshufb xmm5, xmm13
    movdqa xmm14, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm14, xmm5
    movdqa xmm5, xmm14
    aesenc xmm6, xmm8
    aesenc xmm7, xmm9
    aesenc xmm6, xmm12
    aesenc xmm7, xmm12
    pshufb xmm6, xmm13
    pshufb xmm7, xmm13
    movdqa xmm14, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm14, xmm7
    movdqa xmm7, xmm14
    movdqu xmm14, XMMWORD PTR [vistrutahConsts]
    movdqu xmm15, XMMWORD PTR [vistrutahConsts + 16]
    pshufb xmm10, xmm14
    pshufb xmm11, xmm15
    movdqu xmm14, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm14, xmm10
    pxor xmm0, xmm14
    pxor xmm1, xmm11
    pxor xmm2, xmm14
    pxor xmm3, xmm11
    pxor xmm4, xmm14
    pxor xmm5, xmm11
    pxor xmm6, xmm14
    pxor xmm7, xmm11
    aesenc xmm0, xmm8
    aesenc xmm1, xmm9
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    pshufb xmm0, xmm13
    pshufb xmm1, xmm13
    movdqa xmm14, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm14, xmm1
    movdqa xmm1, xmm14
    aesenc xmm2, xmm8
    aesenc xmm3, xmm9
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    pshufb xmm2, xmm13
    pshufb xmm3, xmm13
    movdqa xmm14, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm14, xmm3
    movdqa xmm3, xmm14
    aesenc xmm4, xmm8
    aesenc xmm5, xmm9
    aesenc xmm4, xmm12
    aesenc xmm5, xmm12
    pshufb xmm4, xmm13
    pshufb xmm5, xmm13
    movdqa xmm14, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm14, xmm5
    movdqa xmm5, xmm14
    aesenc xmm6, xmm8
    aesenc xmm7, xmm9
    aesenc xmm6, xmm12
    aesenc xmm7, xmm12
    pshufb xmm6, xmm13
    pshufb xmm7, xmm13
    movdqa xmm14, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm14, xmm7
    movdqa xmm7, xmm14
    movdqu xmm14, XMMWORD PTR [vistrutahConsts]
    movdqu xmm15, XMMWORD PTR [vistrutahConsts + 16]
    pshufb xmm10, xmm14
    pshufb xmm11, xmm15
    movdqu xmm14, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm14, xmm10
    pxor xmm0, xmm14
    pxor xmm1, xmm11
    pxor xmm2, xmm14
    pxor xmm3, xmm11
    pxor xmm4, xmm14
    pxor xmm5, xmm11
    pxor xmm6, xmm14
    pxor xmm7, xmm11
v256_4blk_aesni_final:
    aesenc xmm0, xmm8
    aesenc xmm1, xmm9
    aesenc xmm2, xmm8
    aesenc xmm3, xmm9
    aesenc xmm4, xmm8
    aesenc xmm5, xmm9
    aesenc xmm6, xmm8
    aesenc xmm7, xmm9
    movdqu xmm14, XMMWORD PTR [vistrutahConsts]
    movdqu xmm15, XMMWORD PTR [vistrutahConsts + 16]
    pshufb xmm10, xmm14
    pshufb xmm11, xmm15
    aesenclast xmm0, xmm10
    aesenclast xmm1, xmm11
    aesenclast xmm2, xmm10
    aesenclast xmm3, xmm11
    aesenclast xmm4, xmm10
    aesenclast xmm5, xmm11
    aesenclast xmm6, xmm10
    aesenclast xmm7, xmm11
    movdqu XMMWORD PTR [rdi], xmm0
    movdqu XMMWORD PTR [rdi + 16], xmm1
    movdqu XMMWORD PTR [rdi + 32], xmm2
    movdqu XMMWORD PTR [rdi + 48], xmm3
    movdqu XMMWORD PTR [rdi + 64], xmm4
    movdqu XMMWORD PTR [rdi + 80], xmm5
    movdqu XMMWORD PTR [rdi + 96], xmm6
    movdqu XMMWORD PTR [rdi + 112], xmm7
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm14, xmm14
    pxor xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    movdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    movdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    movdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah256Encrypt4BlocksAesNiAsm ENDP

PUBLIC vistrutah256Decrypt4BlocksAesNiAsm
ALIGN 16
vistrutah256Decrypt4BlocksAesNiAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    movdqu XMMWORD PTR [rsp + 64], xmm9
    movdqu XMMWORD PTR [rsp + 80], xmm10
    movdqu XMMWORD PTR [rsp + 96], xmm11
    movdqu XMMWORD PTR [rsp + 112], xmm12
    movdqu XMMWORD PTR [rsp + 128], xmm13
    movdqu XMMWORD PTR [rsp + 144], xmm14
    movdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    movdqu xmm2, XMMWORD PTR [rsi + 32]
    movdqu xmm3, XMMWORD PTR [rsi + 48]
    movdqu xmm4, XMMWORD PTR [rsi + 64]
    movdqu xmm5, XMMWORD PTR [rsi + 80]
    movdqu xmm6, XMMWORD PTR [rsi + 96]
    movdqu xmm7, XMMWORD PTR [rsi + 112]
    movdqu xmm8, XMMWORD PTR [rdx]
    movdqu xmm9, XMMWORD PTR [rdx + 16]
    movdqa xmm10, xmm9
    movdqa xmm11, xmm8
    aesimc xmm8, xmm8
    aesimc xmm9, xmm9
    movdqu xmm12, XMMWORD PTR [vistrutahConsts + 352]
    movdqu xmm13, XMMWORD PTR [vistrutahConsts + 368]
    pshufb xmm10, xmm12
    pshufb xmm11, xmm13
    cmp rcx, 10
    je v256_dec_4blk_aesni_init_done
    movdqu xmm12, XMMWORD PTR [vistrutahConsts]
    movdqu xmm13, XMMWORD PTR [vistrutahConsts + 16]
    pshufb xmm10, xmm12
    pshufb xmm11, xmm13
    pshufb xmm10, xmm12
    pshufb xmm11, xmm13
v256_dec_4blk_aesni_init_done:
    movdqu xmm12, XMMWORD PTR [vistrutahConsts + 288]
    movdqu xmm13, XMMWORD PTR [vistrutahConsts + 304]
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    pxor xmm4, xmm10
    pxor xmm5, xmm11
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    cmp rcx, 10
    je v256_dec_4blk_aesni_step4
    pshufb xmm10, xmm12
    pshufb xmm11, xmm13
    movdqu xmm14, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm14, xmm10
    aesdec xmm0, xmm8
    aesdec xmm1, xmm9
    aesdeclast xmm0, xmm14
    aesdeclast xmm1, xmm11
    movdqa xmm15, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm15, xmm1
    movdqa xmm1, xmm15
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesdec xmm2, xmm8
    aesdec xmm3, xmm9
    aesdeclast xmm2, xmm14
    aesdeclast xmm3, xmm11
    movdqa xmm15, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm15, xmm3
    movdqa xmm3, xmm15
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm4, xmm8
    aesdec xmm5, xmm9
    aesdeclast xmm4, xmm14
    aesdeclast xmm5, xmm11
    movdqa xmm15, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm15, xmm5
    movdqa xmm5, xmm15
    aesimc xmm4, xmm4
    aesimc xmm5, xmm5
    aesdec xmm6, xmm8
    aesdec xmm7, xmm9
    aesdeclast xmm6, xmm14
    aesdeclast xmm7, xmm11
    movdqa xmm15, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm15, xmm7
    movdqa xmm7, xmm15
    aesimc xmm6, xmm6
    aesimc xmm7, xmm7
    pshufb xmm10, xmm12
    pshufb xmm11, xmm13
    movdqu xmm14, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm14, xmm10
    aesdec xmm0, xmm8
    aesdec xmm1, xmm9
    aesdeclast xmm0, xmm14
    aesdeclast xmm1, xmm11
    movdqa xmm15, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm15, xmm1
    movdqa xmm1, xmm15
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesdec xmm2, xmm8
    aesdec xmm3, xmm9
    aesdeclast xmm2, xmm14
    aesdeclast xmm3, xmm11
    movdqa xmm15, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm15, xmm3
    movdqa xmm3, xmm15
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm4, xmm8
    aesdec xmm5, xmm9
    aesdeclast xmm4, xmm14
    aesdeclast xmm5, xmm11
    movdqa xmm15, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm15, xmm5
    movdqa xmm5, xmm15
    aesimc xmm4, xmm4
    aesimc xmm5, xmm5
    aesdec xmm6, xmm8
    aesdec xmm7, xmm9
    aesdeclast xmm6, xmm14
    aesdeclast xmm7, xmm11
    movdqa xmm15, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm15, xmm7
    movdqa xmm7, xmm15
    aesimc xmm6, xmm6
    aesimc xmm7, xmm7
v256_dec_4blk_aesni_step4:
    pshufb xmm10, xmm12
    pshufb xmm11, xmm13
    movdqu xmm14, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm14, xmm10
    aesdec xmm0, xmm8
    aesdec xmm1, xmm9
    aesdeclast xmm0, xmm14
    aesdeclast xmm1, xmm11
    movdqa xmm15, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm15, xmm1
    movdqa xmm1, xmm15
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesdec xmm2, xmm8
    aesdec xmm3, xmm9
    aesdeclast xmm2, xmm14
    aesdeclast xmm3, xmm11
    movdqa xmm15, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm15, xmm3
    movdqa xmm3, xmm15
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm4, xmm8
    aesdec xmm5, xmm9
    aesdeclast xmm4, xmm14
    aesdeclast xmm5, xmm11
    movdqa xmm15, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm15, xmm5
    movdqa xmm5, xmm15
    aesimc xmm4, xmm4
    aesimc xmm5, xmm5
    aesdec xmm6, xmm8
    aesdec xmm7, xmm9
    aesdeclast xmm6, xmm14
    aesdeclast xmm7, xmm11
    movdqa xmm15, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm15, xmm7
    movdqa xmm7, xmm15
    aesimc xmm6, xmm6
    aesimc xmm7, xmm7
    pshufb xmm10, xmm12
    pshufb xmm11, xmm13
    movdqu xmm14, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm14, xmm10
    aesdec xmm0, xmm8
    aesdec xmm1, xmm9
    aesdeclast xmm0, xmm14
    aesdeclast xmm1, xmm11
    movdqa xmm15, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm15, xmm1
    movdqa xmm1, xmm15
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesdec xmm2, xmm8
    aesdec xmm3, xmm9
    aesdeclast xmm2, xmm14
    aesdeclast xmm3, xmm11
    movdqa xmm15, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm15, xmm3
    movdqa xmm3, xmm15
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm4, xmm8
    aesdec xmm5, xmm9
    aesdeclast xmm4, xmm14
    aesdeclast xmm5, xmm11
    movdqa xmm15, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm15, xmm5
    movdqa xmm5, xmm15
    aesimc xmm4, xmm4
    aesimc xmm5, xmm5
    aesdec xmm6, xmm8
    aesdec xmm7, xmm9
    aesdeclast xmm6, xmm14
    aesdeclast xmm7, xmm11
    movdqa xmm15, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm15, xmm7
    movdqa xmm7, xmm15
    aesimc xmm6, xmm6
    aesimc xmm7, xmm7
    pshufb xmm10, xmm12
    pshufb xmm11, xmm13
    movdqu xmm14, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm14, xmm10
    aesdec xmm0, xmm8
    aesdec xmm1, xmm9
    aesdeclast xmm0, xmm14
    aesdeclast xmm1, xmm11
    movdqa xmm15, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm15, xmm1
    movdqa xmm1, xmm15
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesdec xmm2, xmm8
    aesdec xmm3, xmm9
    aesdeclast xmm2, xmm14
    aesdeclast xmm3, xmm11
    movdqa xmm15, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm15, xmm3
    movdqa xmm3, xmm15
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm4, xmm8
    aesdec xmm5, xmm9
    aesdeclast xmm4, xmm14
    aesdeclast xmm5, xmm11
    movdqa xmm15, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm15, xmm5
    movdqa xmm5, xmm15
    aesimc xmm4, xmm4
    aesimc xmm5, xmm5
    aesdec xmm6, xmm8
    aesdec xmm7, xmm9
    aesdeclast xmm6, xmm14
    aesdeclast xmm7, xmm11
    movdqa xmm15, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm15, xmm7
    movdqa xmm7, xmm15
    aesimc xmm6, xmm6
    aesimc xmm7, xmm7
    pshufb xmm10, xmm12
    pshufb xmm11, xmm13
    movdqu xmm14, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm14, xmm10
    aesdec xmm0, xmm8
    aesdec xmm1, xmm9
    aesdeclast xmm0, xmm14
    aesdeclast xmm1, xmm11
    movdqa xmm15, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm15, xmm1
    movdqa xmm1, xmm15
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesdec xmm2, xmm8
    aesdec xmm3, xmm9
    aesdeclast xmm2, xmm14
    aesdeclast xmm3, xmm11
    movdqa xmm15, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm15, xmm3
    movdqa xmm3, xmm15
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm4, xmm8
    aesdec xmm5, xmm9
    aesdeclast xmm4, xmm14
    aesdeclast xmm5, xmm11
    movdqa xmm15, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm15, xmm5
    movdqa xmm5, xmm15
    aesimc xmm4, xmm4
    aesimc xmm5, xmm5
    aesdec xmm6, xmm8
    aesdec xmm7, xmm9
    aesdeclast xmm6, xmm14
    aesdeclast xmm7, xmm11
    movdqa xmm15, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm15, xmm7
    movdqa xmm7, xmm15
    aesimc xmm6, xmm6
    aesimc xmm7, xmm7
    pshufb xmm10, xmm12
    pshufb xmm11, xmm13
    aesdec xmm0, xmm8
    aesdec xmm1, xmm9
    aesdeclast xmm0, xmm10
    aesdeclast xmm1, xmm11
    aesdec xmm2, xmm8
    aesdec xmm3, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    aesdec xmm4, xmm8
    aesdec xmm5, xmm9
    aesdeclast xmm4, xmm10
    aesdeclast xmm5, xmm11
    aesdec xmm6, xmm8
    aesdec xmm7, xmm9
    aesdeclast xmm6, xmm10
    aesdeclast xmm7, xmm11
    movdqu XMMWORD PTR [rdi], xmm0
    movdqu XMMWORD PTR [rdi + 16], xmm1
    movdqu XMMWORD PTR [rdi + 32], xmm2
    movdqu XMMWORD PTR [rdi + 48], xmm3
    movdqu XMMWORD PTR [rdi + 64], xmm4
    movdqu XMMWORD PTR [rdi + 80], xmm5
    movdqu XMMWORD PTR [rdi + 96], xmm6
    movdqu XMMWORD PTR [rdi + 112], xmm7
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm14, xmm14
    pxor xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    movdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    movdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    movdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah256Decrypt4BlocksAesNiAsm ENDP

PUBLIC vistrutah256Encrypt4BlocksVexAsm
ALIGN 16
vistrutah256Encrypt4BlocksVexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vmovdqu xmm4, XMMWORD PTR [rsi + 64]
    vmovdqu xmm5, XMMWORD PTR [rsi + 80]
    vmovdqu xmm6, XMMWORD PTR [rsi + 96]
    vmovdqu xmm7, XMMWORD PTR [rsi + 112]
    vmovdqu xmm8, XMMWORD PTR [rdx]
    vmovdqu xmm9, XMMWORD PTR [rdx + 16]
    vmovdqa xmm10, xmm9
    vmovdqa xmm11, xmm8
    vpxor xmm12, xmm12, xmm12
    vmovdqu xmm13, XMMWORD PTR [vistrutahConsts + 64]
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vpxor xmm4, xmm4, xmm10
    vpxor xmm5, xmm5, xmm11
    vpxor xmm6, xmm6, xmm10
    vpxor xmm7, xmm7, xmm11
    vaesenc xmm0, xmm0, xmm8
    vaesenc xmm1, xmm1, xmm9
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vpshufb xmm14, xmm0, xmm13
    vpshufb xmm15, xmm1, xmm13
    vpunpcklqdq xmm0, xmm14, xmm15
    vpunpckhqdq xmm1, xmm14, xmm15
    vaesenc xmm2, xmm2, xmm8
    vaesenc xmm3, xmm3, xmm9
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpshufb xmm14, xmm2, xmm13
    vpshufb xmm15, xmm3, xmm13
    vpunpcklqdq xmm2, xmm14, xmm15
    vpunpckhqdq xmm3, xmm14, xmm15
    vaesenc xmm4, xmm4, xmm8
    vaesenc xmm5, xmm5, xmm9
    vaesenc xmm4, xmm4, xmm12
    vaesenc xmm5, xmm5, xmm12
    vpshufb xmm14, xmm4, xmm13
    vpshufb xmm15, xmm5, xmm13
    vpunpcklqdq xmm4, xmm14, xmm15
    vpunpckhqdq xmm5, xmm14, xmm15
    vaesenc xmm6, xmm6, xmm8
    vaesenc xmm7, xmm7, xmm9
    vaesenc xmm6, xmm6, xmm12
    vaesenc xmm7, xmm7, xmm12
    vpshufb xmm14, xmm6, xmm13
    vpshufb xmm15, xmm7, xmm13
    vpunpcklqdq xmm6, xmm14, xmm15
    vpunpckhqdq xmm7, xmm14, xmm15
    vpshufb xmm10, xmm10, XMMWORD PTR [vistrutahConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [vistrutahConsts + 16]
    vpxor xmm14, xmm10, XMMWORD PTR [vistrutahRoundConstants]
    vpxor xmm0, xmm0, xmm14
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm14
    vpxor xmm3, xmm3, xmm11
    vpxor xmm4, xmm4, xmm14
    vpxor xmm5, xmm5, xmm11
    vpxor xmm6, xmm6, xmm14
    vpxor xmm7, xmm7, xmm11
    vaesenc xmm0, xmm0, xmm8
    vaesenc xmm1, xmm1, xmm9
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vpshufb xmm14, xmm0, xmm13
    vpshufb xmm15, xmm1, xmm13
    vpunpcklqdq xmm0, xmm14, xmm15
    vpunpckhqdq xmm1, xmm14, xmm15
    vaesenc xmm2, xmm2, xmm8
    vaesenc xmm3, xmm3, xmm9
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpshufb xmm14, xmm2, xmm13
    vpshufb xmm15, xmm3, xmm13
    vpunpcklqdq xmm2, xmm14, xmm15
    vpunpckhqdq xmm3, xmm14, xmm15
    vaesenc xmm4, xmm4, xmm8
    vaesenc xmm5, xmm5, xmm9
    vaesenc xmm4, xmm4, xmm12
    vaesenc xmm5, xmm5, xmm12
    vpshufb xmm14, xmm4, xmm13
    vpshufb xmm15, xmm5, xmm13
    vpunpcklqdq xmm4, xmm14, xmm15
    vpunpckhqdq xmm5, xmm14, xmm15
    vaesenc xmm6, xmm6, xmm8
    vaesenc xmm7, xmm7, xmm9
    vaesenc xmm6, xmm6, xmm12
    vaesenc xmm7, xmm7, xmm12
    vpshufb xmm14, xmm6, xmm13
    vpshufb xmm15, xmm7, xmm13
    vpunpcklqdq xmm6, xmm14, xmm15
    vpunpckhqdq xmm7, xmm14, xmm15
    vpshufb xmm10, xmm10, XMMWORD PTR [vistrutahConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [vistrutahConsts + 16]
    vpxor xmm14, xmm10, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor xmm0, xmm0, xmm14
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm14
    vpxor xmm3, xmm3, xmm11
    vpxor xmm4, xmm4, xmm14
    vpxor xmm5, xmm5, xmm11
    vpxor xmm6, xmm6, xmm14
    vpxor xmm7, xmm7, xmm11
    vaesenc xmm0, xmm0, xmm8
    vaesenc xmm1, xmm1, xmm9
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vpshufb xmm14, xmm0, xmm13
    vpshufb xmm15, xmm1, xmm13
    vpunpcklqdq xmm0, xmm14, xmm15
    vpunpckhqdq xmm1, xmm14, xmm15
    vaesenc xmm2, xmm2, xmm8
    vaesenc xmm3, xmm3, xmm9
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpshufb xmm14, xmm2, xmm13
    vpshufb xmm15, xmm3, xmm13
    vpunpcklqdq xmm2, xmm14, xmm15
    vpunpckhqdq xmm3, xmm14, xmm15
    vaesenc xmm4, xmm4, xmm8
    vaesenc xmm5, xmm5, xmm9
    vaesenc xmm4, xmm4, xmm12
    vaesenc xmm5, xmm5, xmm12
    vpshufb xmm14, xmm4, xmm13
    vpshufb xmm15, xmm5, xmm13
    vpunpcklqdq xmm4, xmm14, xmm15
    vpunpckhqdq xmm5, xmm14, xmm15
    vaesenc xmm6, xmm6, xmm8
    vaesenc xmm7, xmm7, xmm9
    vaesenc xmm6, xmm6, xmm12
    vaesenc xmm7, xmm7, xmm12
    vpshufb xmm14, xmm6, xmm13
    vpshufb xmm15, xmm7, xmm13
    vpunpcklqdq xmm6, xmm14, xmm15
    vpunpckhqdq xmm7, xmm14, xmm15
    vpshufb xmm10, xmm10, XMMWORD PTR [vistrutahConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [vistrutahConsts + 16]
    vpxor xmm14, xmm10, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor xmm0, xmm0, xmm14
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm14
    vpxor xmm3, xmm3, xmm11
    vpxor xmm4, xmm4, xmm14
    vpxor xmm5, xmm5, xmm11
    vpxor xmm6, xmm6, xmm14
    vpxor xmm7, xmm7, xmm11
    vaesenc xmm0, xmm0, xmm8
    vaesenc xmm1, xmm1, xmm9
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vpshufb xmm14, xmm0, xmm13
    vpshufb xmm15, xmm1, xmm13
    vpunpcklqdq xmm0, xmm14, xmm15
    vpunpckhqdq xmm1, xmm14, xmm15
    vaesenc xmm2, xmm2, xmm8
    vaesenc xmm3, xmm3, xmm9
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpshufb xmm14, xmm2, xmm13
    vpshufb xmm15, xmm3, xmm13
    vpunpcklqdq xmm2, xmm14, xmm15
    vpunpckhqdq xmm3, xmm14, xmm15
    vaesenc xmm4, xmm4, xmm8
    vaesenc xmm5, xmm5, xmm9
    vaesenc xmm4, xmm4, xmm12
    vaesenc xmm5, xmm5, xmm12
    vpshufb xmm14, xmm4, xmm13
    vpshufb xmm15, xmm5, xmm13
    vpunpcklqdq xmm4, xmm14, xmm15
    vpunpckhqdq xmm5, xmm14, xmm15
    vaesenc xmm6, xmm6, xmm8
    vaesenc xmm7, xmm7, xmm9
    vaesenc xmm6, xmm6, xmm12
    vaesenc xmm7, xmm7, xmm12
    vpshufb xmm14, xmm6, xmm13
    vpshufb xmm15, xmm7, xmm13
    vpunpcklqdq xmm6, xmm14, xmm15
    vpunpckhqdq xmm7, xmm14, xmm15
    vpshufb xmm10, xmm10, XMMWORD PTR [vistrutahConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [vistrutahConsts + 16]
    vpxor xmm14, xmm10, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor xmm0, xmm0, xmm14
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm14
    vpxor xmm3, xmm3, xmm11
    vpxor xmm4, xmm4, xmm14
    vpxor xmm5, xmm5, xmm11
    vpxor xmm6, xmm6, xmm14
    vpxor xmm7, xmm7, xmm11
    cmp rcx, 10
    je v256_4blk_vex_final
    vaesenc xmm0, xmm0, xmm8
    vaesenc xmm1, xmm1, xmm9
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vpshufb xmm14, xmm0, xmm13
    vpshufb xmm15, xmm1, xmm13
    vpunpcklqdq xmm0, xmm14, xmm15
    vpunpckhqdq xmm1, xmm14, xmm15
    vaesenc xmm2, xmm2, xmm8
    vaesenc xmm3, xmm3, xmm9
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpshufb xmm14, xmm2, xmm13
    vpshufb xmm15, xmm3, xmm13
    vpunpcklqdq xmm2, xmm14, xmm15
    vpunpckhqdq xmm3, xmm14, xmm15
    vaesenc xmm4, xmm4, xmm8
    vaesenc xmm5, xmm5, xmm9
    vaesenc xmm4, xmm4, xmm12
    vaesenc xmm5, xmm5, xmm12
    vpshufb xmm14, xmm4, xmm13
    vpshufb xmm15, xmm5, xmm13
    vpunpcklqdq xmm4, xmm14, xmm15
    vpunpckhqdq xmm5, xmm14, xmm15
    vaesenc xmm6, xmm6, xmm8
    vaesenc xmm7, xmm7, xmm9
    vaesenc xmm6, xmm6, xmm12
    vaesenc xmm7, xmm7, xmm12
    vpshufb xmm14, xmm6, xmm13
    vpshufb xmm15, xmm7, xmm13
    vpunpcklqdq xmm6, xmm14, xmm15
    vpunpckhqdq xmm7, xmm14, xmm15
    vpshufb xmm10, xmm10, XMMWORD PTR [vistrutahConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [vistrutahConsts + 16]
    vpxor xmm14, xmm10, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor xmm0, xmm0, xmm14
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm14
    vpxor xmm3, xmm3, xmm11
    vpxor xmm4, xmm4, xmm14
    vpxor xmm5, xmm5, xmm11
    vpxor xmm6, xmm6, xmm14
    vpxor xmm7, xmm7, xmm11
    vaesenc xmm0, xmm0, xmm8
    vaesenc xmm1, xmm1, xmm9
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vpshufb xmm14, xmm0, xmm13
    vpshufb xmm15, xmm1, xmm13
    vpunpcklqdq xmm0, xmm14, xmm15
    vpunpckhqdq xmm1, xmm14, xmm15
    vaesenc xmm2, xmm2, xmm8
    vaesenc xmm3, xmm3, xmm9
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpshufb xmm14, xmm2, xmm13
    vpshufb xmm15, xmm3, xmm13
    vpunpcklqdq xmm2, xmm14, xmm15
    vpunpckhqdq xmm3, xmm14, xmm15
    vaesenc xmm4, xmm4, xmm8
    vaesenc xmm5, xmm5, xmm9
    vaesenc xmm4, xmm4, xmm12
    vaesenc xmm5, xmm5, xmm12
    vpshufb xmm14, xmm4, xmm13
    vpshufb xmm15, xmm5, xmm13
    vpunpcklqdq xmm4, xmm14, xmm15
    vpunpckhqdq xmm5, xmm14, xmm15
    vaesenc xmm6, xmm6, xmm8
    vaesenc xmm7, xmm7, xmm9
    vaesenc xmm6, xmm6, xmm12
    vaesenc xmm7, xmm7, xmm12
    vpshufb xmm14, xmm6, xmm13
    vpshufb xmm15, xmm7, xmm13
    vpunpcklqdq xmm6, xmm14, xmm15
    vpunpckhqdq xmm7, xmm14, xmm15
    vpshufb xmm10, xmm10, XMMWORD PTR [vistrutahConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [vistrutahConsts + 16]
    vpxor xmm14, xmm10, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor xmm0, xmm0, xmm14
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm14
    vpxor xmm3, xmm3, xmm11
    vpxor xmm4, xmm4, xmm14
    vpxor xmm5, xmm5, xmm11
    vpxor xmm6, xmm6, xmm14
    vpxor xmm7, xmm7, xmm11
v256_4blk_vex_final:
    vaesenc xmm0, xmm0, xmm8
    vaesenc xmm1, xmm1, xmm9
    vaesenc xmm2, xmm2, xmm8
    vaesenc xmm3, xmm3, xmm9
    vaesenc xmm4, xmm4, xmm8
    vaesenc xmm5, xmm5, xmm9
    vaesenc xmm6, xmm6, xmm8
    vaesenc xmm7, xmm7, xmm9
    vpshufb xmm10, xmm10, XMMWORD PTR [vistrutahConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [vistrutahConsts + 16]
    vaesenclast xmm0, xmm0, xmm10
    vaesenclast xmm1, xmm1, xmm11
    vaesenclast xmm2, xmm2, xmm10
    vaesenclast xmm3, xmm3, xmm11
    vaesenclast xmm4, xmm4, xmm10
    vaesenclast xmm5, xmm5, xmm11
    vaesenclast xmm6, xmm6, xmm10
    vaesenclast xmm7, xmm7, xmm11
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vmovdqu XMMWORD PTR [rdi + 64], xmm4
    vmovdqu XMMWORD PTR [rdi + 80], xmm5
    vmovdqu XMMWORD PTR [rdi + 96], xmm6
    vmovdqu XMMWORD PTR [rdi + 112], xmm7
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah256Encrypt4BlocksVexAsm ENDP

PUBLIC vistrutah256Decrypt4BlocksVexAsm
ALIGN 16
vistrutah256Decrypt4BlocksVexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vmovdqu xmm4, XMMWORD PTR [rsi + 64]
    vmovdqu xmm5, XMMWORD PTR [rsi + 80]
    vmovdqu xmm6, XMMWORD PTR [rsi + 96]
    vmovdqu xmm7, XMMWORD PTR [rsi + 112]
    vmovdqu xmm8, XMMWORD PTR [rdx]
    vmovdqu xmm9, XMMWORD PTR [rdx + 16]
    vmovdqa xmm10, xmm9
    vmovdqa xmm11, xmm8
    vaesimc xmm8, xmm8
    vaesimc xmm9, xmm9
    vpshufb xmm10, xmm10, XMMWORD PTR [vistrutahConsts + 352]
    vpshufb xmm11, xmm11, XMMWORD PTR [vistrutahConsts + 368]
    cmp rcx, 10
    je v256_dec_4blk_vex_init_done
    vmovdqu xmm12, XMMWORD PTR [vistrutahConsts]
    vmovdqu xmm13, XMMWORD PTR [vistrutahConsts + 16]
    vpshufb xmm10, xmm10, xmm12
    vpshufb xmm11, xmm11, xmm13
    vpshufb xmm10, xmm10, xmm12
    vpshufb xmm11, xmm11, xmm13
v256_dec_4blk_vex_init_done:
    vmovdqu xmm12, XMMWORD PTR [vistrutahConsts + 288]
    vmovdqu xmm13, XMMWORD PTR [vistrutahConsts + 304]
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vpxor xmm4, xmm4, xmm10
    vpxor xmm5, xmm5, xmm11
    vpxor xmm6, xmm6, xmm10
    vpxor xmm7, xmm7, xmm11
    cmp rcx, 10
    je v256_dec_4blk_vex_step4
    vpshufb xmm10, xmm10, xmm12
    vpshufb xmm11, xmm11, xmm13
    vpxor xmm14, xmm10, XMMWORD PTR [vistrutahRoundConstants + 80]
    vaesdec xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm9
    vaesdeclast xmm0, xmm0, xmm14
    vaesdeclast xmm1, xmm1, xmm11
    vpunpcklbw xmm15, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm15
    vaesimc xmm1, xmm1
    vaesdec xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm9
    vaesdeclast xmm2, xmm2, xmm14
    vaesdeclast xmm3, xmm3, xmm11
    vpunpcklbw xmm15, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vaesimc xmm2, xmm15
    vaesimc xmm3, xmm3
    vaesdec xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm9
    vaesdeclast xmm4, xmm4, xmm14
    vaesdeclast xmm5, xmm5, xmm11
    vpunpcklbw xmm15, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vaesimc xmm4, xmm15
    vaesimc xmm5, xmm5
    vaesdec xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm9
    vaesdeclast xmm6, xmm6, xmm14
    vaesdeclast xmm7, xmm7, xmm11
    vpunpcklbw xmm15, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vaesimc xmm6, xmm15
    vaesimc xmm7, xmm7
    vpshufb xmm10, xmm10, xmm12
    vpshufb xmm11, xmm11, xmm13
    vpxor xmm14, xmm10, XMMWORD PTR [vistrutahRoundConstants + 64]
    vaesdec xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm9
    vaesdeclast xmm0, xmm0, xmm14
    vaesdeclast xmm1, xmm1, xmm11
    vpunpcklbw xmm15, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm15
    vaesimc xmm1, xmm1
    vaesdec xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm9
    vaesdeclast xmm2, xmm2, xmm14
    vaesdeclast xmm3, xmm3, xmm11
    vpunpcklbw xmm15, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vaesimc xmm2, xmm15
    vaesimc xmm3, xmm3
    vaesdec xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm9
    vaesdeclast xmm4, xmm4, xmm14
    vaesdeclast xmm5, xmm5, xmm11
    vpunpcklbw xmm15, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vaesimc xmm4, xmm15
    vaesimc xmm5, xmm5
    vaesdec xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm9
    vaesdeclast xmm6, xmm6, xmm14
    vaesdeclast xmm7, xmm7, xmm11
    vpunpcklbw xmm15, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vaesimc xmm6, xmm15
    vaesimc xmm7, xmm7
v256_dec_4blk_vex_step4:
    vpshufb xmm10, xmm10, xmm12
    vpshufb xmm11, xmm11, xmm13
    vpxor xmm14, xmm10, XMMWORD PTR [vistrutahRoundConstants + 48]
    vaesdec xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm9
    vaesdeclast xmm0, xmm0, xmm14
    vaesdeclast xmm1, xmm1, xmm11
    vpunpcklbw xmm15, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm15
    vaesimc xmm1, xmm1
    vaesdec xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm9
    vaesdeclast xmm2, xmm2, xmm14
    vaesdeclast xmm3, xmm3, xmm11
    vpunpcklbw xmm15, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vaesimc xmm2, xmm15
    vaesimc xmm3, xmm3
    vaesdec xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm9
    vaesdeclast xmm4, xmm4, xmm14
    vaesdeclast xmm5, xmm5, xmm11
    vpunpcklbw xmm15, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vaesimc xmm4, xmm15
    vaesimc xmm5, xmm5
    vaesdec xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm9
    vaesdeclast xmm6, xmm6, xmm14
    vaesdeclast xmm7, xmm7, xmm11
    vpunpcklbw xmm15, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vaesimc xmm6, xmm15
    vaesimc xmm7, xmm7
    vpshufb xmm10, xmm10, xmm12
    vpshufb xmm11, xmm11, xmm13
    vpxor xmm14, xmm10, XMMWORD PTR [vistrutahRoundConstants + 32]
    vaesdec xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm9
    vaesdeclast xmm0, xmm0, xmm14
    vaesdeclast xmm1, xmm1, xmm11
    vpunpcklbw xmm15, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm15
    vaesimc xmm1, xmm1
    vaesdec xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm9
    vaesdeclast xmm2, xmm2, xmm14
    vaesdeclast xmm3, xmm3, xmm11
    vpunpcklbw xmm15, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vaesimc xmm2, xmm15
    vaesimc xmm3, xmm3
    vaesdec xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm9
    vaesdeclast xmm4, xmm4, xmm14
    vaesdeclast xmm5, xmm5, xmm11
    vpunpcklbw xmm15, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vaesimc xmm4, xmm15
    vaesimc xmm5, xmm5
    vaesdec xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm9
    vaesdeclast xmm6, xmm6, xmm14
    vaesdeclast xmm7, xmm7, xmm11
    vpunpcklbw xmm15, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vaesimc xmm6, xmm15
    vaesimc xmm7, xmm7
    vpshufb xmm10, xmm10, xmm12
    vpshufb xmm11, xmm11, xmm13
    vpxor xmm14, xmm10, XMMWORD PTR [vistrutahRoundConstants + 16]
    vaesdec xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm9
    vaesdeclast xmm0, xmm0, xmm14
    vaesdeclast xmm1, xmm1, xmm11
    vpunpcklbw xmm15, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm15
    vaesimc xmm1, xmm1
    vaesdec xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm9
    vaesdeclast xmm2, xmm2, xmm14
    vaesdeclast xmm3, xmm3, xmm11
    vpunpcklbw xmm15, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vaesimc xmm2, xmm15
    vaesimc xmm3, xmm3
    vaesdec xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm9
    vaesdeclast xmm4, xmm4, xmm14
    vaesdeclast xmm5, xmm5, xmm11
    vpunpcklbw xmm15, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vaesimc xmm4, xmm15
    vaesimc xmm5, xmm5
    vaesdec xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm9
    vaesdeclast xmm6, xmm6, xmm14
    vaesdeclast xmm7, xmm7, xmm11
    vpunpcklbw xmm15, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vaesimc xmm6, xmm15
    vaesimc xmm7, xmm7
    vpshufb xmm10, xmm10, xmm12
    vpshufb xmm11, xmm11, xmm13
    vpxor xmm14, xmm10, XMMWORD PTR [vistrutahRoundConstants]
    vaesdec xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm9
    vaesdeclast xmm0, xmm0, xmm14
    vaesdeclast xmm1, xmm1, xmm11
    vpunpcklbw xmm15, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm15
    vaesimc xmm1, xmm1
    vaesdec xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm9
    vaesdeclast xmm2, xmm2, xmm14
    vaesdeclast xmm3, xmm3, xmm11
    vpunpcklbw xmm15, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vaesimc xmm2, xmm15
    vaesimc xmm3, xmm3
    vaesdec xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm9
    vaesdeclast xmm4, xmm4, xmm14
    vaesdeclast xmm5, xmm5, xmm11
    vpunpcklbw xmm15, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vaesimc xmm4, xmm15
    vaesimc xmm5, xmm5
    vaesdec xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm9
    vaesdeclast xmm6, xmm6, xmm14
    vaesdeclast xmm7, xmm7, xmm11
    vpunpcklbw xmm15, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vaesimc xmm6, xmm15
    vaesimc xmm7, xmm7
    vpshufb xmm10, xmm10, xmm12
    vpshufb xmm11, xmm11, xmm13
    vaesdec xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm9
    vaesdeclast xmm0, xmm0, xmm10
    vaesdeclast xmm1, xmm1, xmm11
    vaesdec xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vaesdec xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm9
    vaesdeclast xmm4, xmm4, xmm10
    vaesdeclast xmm5, xmm5, xmm11
    vaesdec xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm9
    vaesdeclast xmm6, xmm6, xmm10
    vaesdeclast xmm7, xmm7, xmm11
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vmovdqu XMMWORD PTR [rdi + 64], xmm4
    vmovdqu XMMWORD PTR [rdi + 80], xmm5
    vmovdqu XMMWORD PTR [rdi + 96], xmm6
    vmovdqu XMMWORD PTR [rdi + 112], xmm7
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah256Decrypt4BlocksVexAsm ENDP

PUBLIC vistrutah256Encrypt4BlocksYmmAsm
ALIGN 16
vistrutah256Encrypt4BlocksYmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu ymm0, YMMWORD PTR [rsi]
    vmovdqu ymm1, YMMWORD PTR [rsi + 32]
    vmovdqu ymm2, YMMWORD PTR [rsi + 64]
    vmovdqu ymm3, YMMWORD PTR [rsi + 96]
    vmovdqu ymm4, YMMWORD PTR [rdx]
    vperm2i128 ymm5, ymm4, ymm4, 1
    vpxor xmm6, xmm6, xmm6
    vmovdqu ymm7, YMMWORD PTR [vistrutahConsts]
    vmovdqu ymm8, YMMWORD PTR [vistrutahConsts + 64]
    vpxor ymm0, ymm0, ymm5
    vpxor ymm1, ymm1, ymm5
    vpxor ymm2, ymm2, ymm5
    vpxor ymm3, ymm3, ymm5
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vaesenc ymm2, ymm2, ymm6
    vaesenc ymm3, ymm3, ymm6
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpshufb ymm2, ymm2, ymm8
    vpshufb ymm3, ymm3, ymm8
    vpermq ymm0, ymm0, 216
    vpermq ymm1, ymm1, 216
    vpermq ymm2, ymm2, 216
    vpermq ymm3, ymm3, 216
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants]
    vpxor ymm9, ymm9, ymm5
    vpxor ymm0, ymm0, ymm9
    vpxor ymm1, ymm1, ymm9
    vpxor ymm2, ymm2, ymm9
    vpxor ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vaesenc ymm2, ymm2, ymm6
    vaesenc ymm3, ymm3, ymm6
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpshufb ymm2, ymm2, ymm8
    vpshufb ymm3, ymm3, ymm8
    vpermq ymm0, ymm0, 216
    vpermq ymm1, ymm1, 216
    vpermq ymm2, ymm2, 216
    vpermq ymm3, ymm3, 216
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor ymm9, ymm9, ymm5
    vpxor ymm0, ymm0, ymm9
    vpxor ymm1, ymm1, ymm9
    vpxor ymm2, ymm2, ymm9
    vpxor ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vaesenc ymm2, ymm2, ymm6
    vaesenc ymm3, ymm3, ymm6
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpshufb ymm2, ymm2, ymm8
    vpshufb ymm3, ymm3, ymm8
    vpermq ymm0, ymm0, 216
    vpermq ymm1, ymm1, 216
    vpermq ymm2, ymm2, 216
    vpermq ymm3, ymm3, 216
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor ymm9, ymm9, ymm5
    vpxor ymm0, ymm0, ymm9
    vpxor ymm1, ymm1, ymm9
    vpxor ymm2, ymm2, ymm9
    vpxor ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vaesenc ymm2, ymm2, ymm6
    vaesenc ymm3, ymm3, ymm6
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpshufb ymm2, ymm2, ymm8
    vpshufb ymm3, ymm3, ymm8
    vpermq ymm0, ymm0, 216
    vpermq ymm1, ymm1, 216
    vpermq ymm2, ymm2, 216
    vpermq ymm3, ymm3, 216
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor ymm9, ymm9, ymm5
    vpxor ymm0, ymm0, ymm9
    vpxor ymm1, ymm1, ymm9
    vpxor ymm2, ymm2, ymm9
    vpxor ymm3, ymm3, ymm9
    cmp rcx, 10
    je v256_4blk_ymm_final
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vaesenc ymm2, ymm2, ymm6
    vaesenc ymm3, ymm3, ymm6
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpshufb ymm2, ymm2, ymm8
    vpshufb ymm3, ymm3, ymm8
    vpermq ymm0, ymm0, 216
    vpermq ymm1, ymm1, 216
    vpermq ymm2, ymm2, 216
    vpermq ymm3, ymm3, 216
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor ymm9, ymm9, ymm5
    vpxor ymm0, ymm0, ymm9
    vpxor ymm1, ymm1, ymm9
    vpxor ymm2, ymm2, ymm9
    vpxor ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vaesenc ymm2, ymm2, ymm6
    vaesenc ymm3, ymm3, ymm6
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpshufb ymm2, ymm2, ymm8
    vpshufb ymm3, ymm3, ymm8
    vpermq ymm0, ymm0, 216
    vpermq ymm1, ymm1, 216
    vpermq ymm2, ymm2, 216
    vpermq ymm3, ymm3, 216
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor ymm9, ymm9, ymm5
    vpxor ymm0, ymm0, ymm9
    vpxor ymm1, ymm1, ymm9
    vpxor ymm2, ymm2, ymm9
    vpxor ymm3, ymm3, ymm9
v256_4blk_ymm_final:
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm4
    vpshufb ymm5, ymm5, ymm7
    vaesenclast ymm0, ymm0, ymm5
    vaesenclast ymm1, ymm1, ymm5
    vaesenclast ymm2, ymm2, ymm5
    vaesenclast ymm3, ymm3, ymm5
    vmovdqu YMMWORD PTR [rdi], ymm0
    vmovdqu YMMWORD PTR [rdi + 32], ymm1
    vmovdqu YMMWORD PTR [rdi + 64], ymm2
    vmovdqu YMMWORD PTR [rdi + 96], ymm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 88
    vzeroupper
    ret
vistrutah256Encrypt4BlocksYmmAsm ENDP

PUBLIC vistrutah256Decrypt4BlocksYmmAsm
ALIGN 16
vistrutah256Decrypt4BlocksYmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu ymm0, YMMWORD PTR [rsi]
    vmovdqu ymm1, YMMWORD PTR [rsi + 32]
    vmovdqu ymm2, YMMWORD PTR [rsi + 64]
    vmovdqu ymm3, YMMWORD PTR [rsi + 96]
    vmovdqu ymm4, YMMWORD PTR [rdx]
    vperm2i128 ymm5, ymm4, ymm4, 1
    vpxor xmm6, xmm6, xmm6
    vaesenclast ymm4, ymm4, ymm6
    vaesdec ymm4, ymm4, ymm6
    vpshufb ymm5, ymm5, YMMWORD PTR [vistrutahConsts + 352]
    cmp rcx, 10
    je v256_dec_4blk_ymm_init_done
    vmovdqu ymm7, YMMWORD PTR [vistrutahConsts]
    vpshufb ymm5, ymm5, ymm7
    vpshufb ymm5, ymm5, ymm7
v256_dec_4blk_ymm_init_done:
    vmovdqu ymm7, YMMWORD PTR [vistrutahConsts + 288]
    vmovdqu ymm8, YMMWORD PTR [vistrutahConsts + 416]
    vpxor ymm0, ymm0, ymm5
    vpxor ymm1, ymm1, ymm5
    vpxor ymm2, ymm2, ymm5
    vpxor ymm3, ymm3, ymm5
    cmp rcx, 10
    je v256_dec_4blk_ymm_step4
    vaesdec ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor ymm9, ymm9, ymm5
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm9
    vaesdeclast ymm2, ymm2, ymm9
    vaesdeclast ymm3, ymm3, ymm9
    vpermq ymm0, ymm0, 216
    vpermq ymm1, ymm1, 216
    vpermq ymm2, ymm2, 216
    vpermq ymm3, ymm3, 216
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpshufb ymm2, ymm2, ymm8
    vpshufb ymm3, ymm3, ymm8
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesenclast ymm2, ymm2, ymm6
    vaesdec ymm2, ymm2, ymm6
    vaesenclast ymm3, ymm3, ymm6
    vaesdec ymm3, ymm3, ymm6
    vaesdec ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor ymm9, ymm9, ymm5
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm9
    vaesdeclast ymm2, ymm2, ymm9
    vaesdeclast ymm3, ymm3, ymm9
    vpermq ymm0, ymm0, 216
    vpermq ymm1, ymm1, 216
    vpermq ymm2, ymm2, 216
    vpermq ymm3, ymm3, 216
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpshufb ymm2, ymm2, ymm8
    vpshufb ymm3, ymm3, ymm8
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesenclast ymm2, ymm2, ymm6
    vaesdec ymm2, ymm2, ymm6
    vaesenclast ymm3, ymm3, ymm6
    vaesdec ymm3, ymm3, ymm6
v256_dec_4blk_ymm_step4:
    vaesdec ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor ymm9, ymm9, ymm5
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm9
    vaesdeclast ymm2, ymm2, ymm9
    vaesdeclast ymm3, ymm3, ymm9
    vpermq ymm0, ymm0, 216
    vpermq ymm1, ymm1, 216
    vpermq ymm2, ymm2, 216
    vpermq ymm3, ymm3, 216
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpshufb ymm2, ymm2, ymm8
    vpshufb ymm3, ymm3, ymm8
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesenclast ymm2, ymm2, ymm6
    vaesdec ymm2, ymm2, ymm6
    vaesenclast ymm3, ymm3, ymm6
    vaesdec ymm3, ymm3, ymm6
    vaesdec ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor ymm9, ymm9, ymm5
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm9
    vaesdeclast ymm2, ymm2, ymm9
    vaesdeclast ymm3, ymm3, ymm9
    vpermq ymm0, ymm0, 216
    vpermq ymm1, ymm1, 216
    vpermq ymm2, ymm2, 216
    vpermq ymm3, ymm3, 216
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpshufb ymm2, ymm2, ymm8
    vpshufb ymm3, ymm3, ymm8
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesenclast ymm2, ymm2, ymm6
    vaesdec ymm2, ymm2, ymm6
    vaesenclast ymm3, ymm3, ymm6
    vaesdec ymm3, ymm3, ymm6
    vaesdec ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor ymm9, ymm9, ymm5
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm9
    vaesdeclast ymm2, ymm2, ymm9
    vaesdeclast ymm3, ymm3, ymm9
    vpermq ymm0, ymm0, 216
    vpermq ymm1, ymm1, 216
    vpermq ymm2, ymm2, 216
    vpermq ymm3, ymm3, 216
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpshufb ymm2, ymm2, ymm8
    vpshufb ymm3, ymm3, ymm8
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesenclast ymm2, ymm2, ymm6
    vaesdec ymm2, ymm2, ymm6
    vaesenclast ymm3, ymm3, ymm6
    vaesdec ymm3, ymm3, ymm6
    vaesdec ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants]
    vpxor ymm9, ymm9, ymm5
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm9
    vaesdeclast ymm2, ymm2, ymm9
    vaesdeclast ymm3, ymm3, ymm9
    vpermq ymm0, ymm0, 216
    vpermq ymm1, ymm1, 216
    vpermq ymm2, ymm2, 216
    vpermq ymm3, ymm3, 216
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpshufb ymm2, ymm2, ymm8
    vpshufb ymm3, ymm3, ymm8
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesenclast ymm2, ymm2, ymm6
    vaesdec ymm2, ymm2, ymm6
    vaesenclast ymm3, ymm3, ymm6
    vaesdec ymm3, ymm3, ymm6
    vaesdec ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm5, ymm5, ymm7
    vaesdeclast ymm0, ymm0, ymm5
    vaesdeclast ymm1, ymm1, ymm5
    vaesdeclast ymm2, ymm2, ymm5
    vaesdeclast ymm3, ymm3, ymm5
    vmovdqu YMMWORD PTR [rdi], ymm0
    vmovdqu YMMWORD PTR [rdi + 32], ymm1
    vmovdqu YMMWORD PTR [rdi + 64], ymm2
    vmovdqu YMMWORD PTR [rdi + 96], ymm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 88
    vzeroupper
    ret
vistrutah256Decrypt4BlocksYmmAsm ENDP

PUBLIC vistrutah256Encrypt4BlocksZmmAsm
ALIGN 16
vistrutah256Encrypt4BlocksZmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 120
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 32], 1
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 64], 2
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 96], 3
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 48], 1
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 80], 2
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 112], 3
    vbroadcasti32x4 zmm2, XMMWORD PTR [rdx]
    vbroadcasti32x4 zmm3, XMMWORD PTR [rdx + 16]
    vmovdqu64 zmm4, zmm3
    vmovdqu64 zmm5, zmm2
    vbroadcasti32x4 zmm6, XMMWORD PTR [vistrutahConsts]
    vbroadcasti32x4 zmm7, XMMWORD PTR [vistrutahConsts + 16]
    vbroadcasti32x4 zmm8, XMMWORD PTR [vistrutahConsts + 64]
    vpxord xmm9, xmm9, xmm9
    vpxorq zmm0, zmm0, zmm4
    vpxorq zmm1, zmm1, zmm5
    vaesenc zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm3
    vaesenc zmm0, zmm0, zmm9
    vaesenc zmm1, zmm1, zmm9
    vpshufb zmm10, zmm0, zmm8
    vpshufb zmm11, zmm1, zmm8
    vpunpcklqdq zmm0, zmm10, zmm11
    vpunpckhqdq zmm1, zmm10, zmm11
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    vbroadcasti32x4 zmm10, XMMWORD PTR [vistrutahRoundConstants]
    vpxorq zmm10, zmm10, zmm4
    vpxorq zmm0, zmm0, zmm10
    vpxorq zmm1, zmm1, zmm5
    vaesenc zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm3
    vaesenc zmm0, zmm0, zmm9
    vaesenc zmm1, zmm1, zmm9
    vpshufb zmm10, zmm0, zmm8
    vpshufb zmm11, zmm1, zmm8
    vpunpcklqdq zmm0, zmm10, zmm11
    vpunpckhqdq zmm1, zmm10, zmm11
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    vbroadcasti32x4 zmm10, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxorq zmm10, zmm10, zmm4
    vpxorq zmm0, zmm0, zmm10
    vpxorq zmm1, zmm1, zmm5
    vaesenc zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm3
    vaesenc zmm0, zmm0, zmm9
    vaesenc zmm1, zmm1, zmm9
    vpshufb zmm10, zmm0, zmm8
    vpshufb zmm11, zmm1, zmm8
    vpunpcklqdq zmm0, zmm10, zmm11
    vpunpckhqdq zmm1, zmm10, zmm11
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    vbroadcasti32x4 zmm10, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxorq zmm10, zmm10, zmm4
    vpxorq zmm0, zmm0, zmm10
    vpxorq zmm1, zmm1, zmm5
    vaesenc zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm3
    vaesenc zmm0, zmm0, zmm9
    vaesenc zmm1, zmm1, zmm9
    vpshufb zmm10, zmm0, zmm8
    vpshufb zmm11, zmm1, zmm8
    vpunpcklqdq zmm0, zmm10, zmm11
    vpunpckhqdq zmm1, zmm10, zmm11
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    vbroadcasti32x4 zmm10, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxorq zmm10, zmm10, zmm4
    vpxorq zmm0, zmm0, zmm10
    vpxorq zmm1, zmm1, zmm5
    cmp rcx, 10
    je v256_4blk_zmm_final
    vaesenc zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm3
    vaesenc zmm0, zmm0, zmm9
    vaesenc zmm1, zmm1, zmm9
    vpshufb zmm10, zmm0, zmm8
    vpshufb zmm11, zmm1, zmm8
    vpunpcklqdq zmm0, zmm10, zmm11
    vpunpckhqdq zmm1, zmm10, zmm11
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    vbroadcasti32x4 zmm10, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxorq zmm10, zmm10, zmm4
    vpxorq zmm0, zmm0, zmm10
    vpxorq zmm1, zmm1, zmm5
    vaesenc zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm3
    vaesenc zmm0, zmm0, zmm9
    vaesenc zmm1, zmm1, zmm9
    vpshufb zmm10, zmm0, zmm8
    vpshufb zmm11, zmm1, zmm8
    vpunpcklqdq zmm0, zmm10, zmm11
    vpunpckhqdq zmm1, zmm10, zmm11
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    vbroadcasti32x4 zmm10, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxorq zmm10, zmm10, zmm4
    vpxorq zmm0, zmm0, zmm10
    vpxorq zmm1, zmm1, zmm5
v256_4blk_zmm_final:
    vaesenc zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm3
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    vaesenclast zmm0, zmm0, zmm4
    vaesenclast zmm1, zmm1, zmm5
    vmovdqu XMMWORD PTR [rdi], xmm0
    vextracti32x4 XMMWORD PTR [rdi + 32], zmm0, 1
    vextracti32x4 XMMWORD PTR [rdi + 64], zmm0, 2
    vextracti32x4 XMMWORD PTR [rdi + 96], zmm0, 3
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vextracti32x4 XMMWORD PTR [rdi + 48], zmm1, 1
    vextracti32x4 XMMWORD PTR [rdi + 80], zmm1, 2
    vextracti32x4 XMMWORD PTR [rdi + 112], zmm1, 3
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm4, xmm4, xmm4
    vpxord xmm5, xmm5, xmm5
    vpxord xmm6, xmm6, xmm6
    vpxord xmm7, xmm7, xmm7
    vpxord xmm8, xmm8, xmm8
    vpxord xmm9, xmm9, xmm9
    vpxord xmm10, xmm10, xmm10
    vpxord xmm11, xmm11, xmm11
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 120
    vzeroupper
    ret
vistrutah256Encrypt4BlocksZmmAsm ENDP

PUBLIC vistrutah256Decrypt4BlocksZmmAsm
ALIGN 16
vistrutah256Decrypt4BlocksZmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 32], 1
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 64], 2
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 96], 3
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 48], 1
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 80], 2
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 112], 3
    vbroadcasti32x4 zmm2, XMMWORD PTR [rdx]
    vbroadcasti32x4 zmm3, XMMWORD PTR [rdx + 16]
    vmovdqu64 zmm4, zmm3
    vmovdqu64 zmm5, zmm2
    vpxord xmm8, xmm8, xmm8
    vaesenclast zmm2, zmm2, zmm8
    vaesdec zmm2, zmm2, zmm8
    vaesenclast zmm3, zmm3, zmm8
    vaesdec zmm3, zmm3, zmm8
    vbroadcasti32x4 zmm6, XMMWORD PTR [vistrutahConsts + 352]
    vbroadcasti32x4 zmm7, XMMWORD PTR [vistrutahConsts + 368]
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    cmp rcx, 10
    je v256_dec_4blk_zmm_init_done
    vbroadcasti32x4 zmm6, XMMWORD PTR [vistrutahConsts]
    vbroadcasti32x4 zmm7, XMMWORD PTR [vistrutahConsts + 16]
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
v256_dec_4blk_zmm_init_done:
    vbroadcasti32x4 zmm6, XMMWORD PTR [vistrutahConsts + 288]
    vbroadcasti32x4 zmm7, XMMWORD PTR [vistrutahConsts + 304]
    vpxorq zmm0, zmm0, zmm4
    vpxorq zmm1, zmm1, zmm5
    cmp rcx, 10
    je v256_dec_4blk_zmm_step4
    vaesdec zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm3
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    vbroadcasti32x4 zmm9, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxorq zmm9, zmm9, zmm4
    vaesdeclast zmm0, zmm0, zmm9
    vaesdeclast zmm1, zmm1, zmm5
    vpunpcklbw zmm9, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm9, zmm8
    vaesdec zmm0, zmm0, zmm8
    vaesenclast zmm1, zmm1, zmm8
    vaesdec zmm1, zmm1, zmm8
    vaesdec zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm3
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    vbroadcasti32x4 zmm9, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxorq zmm9, zmm9, zmm4
    vaesdeclast zmm0, zmm0, zmm9
    vaesdeclast zmm1, zmm1, zmm5
    vpunpcklbw zmm9, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm9, zmm8
    vaesdec zmm0, zmm0, zmm8
    vaesenclast zmm1, zmm1, zmm8
    vaesdec zmm1, zmm1, zmm8
v256_dec_4blk_zmm_step4:
    vaesdec zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm3
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    vbroadcasti32x4 zmm9, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxorq zmm9, zmm9, zmm4
    vaesdeclast zmm0, zmm0, zmm9
    vaesdeclast zmm1, zmm1, zmm5
    vpunpcklbw zmm9, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm9, zmm8
    vaesdec zmm0, zmm0, zmm8
    vaesenclast zmm1, zmm1, zmm8
    vaesdec zmm1, zmm1, zmm8
    vaesdec zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm3
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    vbroadcasti32x4 zmm9, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxorq zmm9, zmm9, zmm4
    vaesdeclast zmm0, zmm0, zmm9
    vaesdeclast zmm1, zmm1, zmm5
    vpunpcklbw zmm9, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm9, zmm8
    vaesdec zmm0, zmm0, zmm8
    vaesenclast zmm1, zmm1, zmm8
    vaesdec zmm1, zmm1, zmm8
    vaesdec zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm3
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    vbroadcasti32x4 zmm9, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxorq zmm9, zmm9, zmm4
    vaesdeclast zmm0, zmm0, zmm9
    vaesdeclast zmm1, zmm1, zmm5
    vpunpcklbw zmm9, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm9, zmm8
    vaesdec zmm0, zmm0, zmm8
    vaesenclast zmm1, zmm1, zmm8
    vaesdec zmm1, zmm1, zmm8
    vaesdec zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm3
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    vbroadcasti32x4 zmm9, XMMWORD PTR [vistrutahRoundConstants]
    vpxorq zmm9, zmm9, zmm4
    vaesdeclast zmm0, zmm0, zmm9
    vaesdeclast zmm1, zmm1, zmm5
    vpunpcklbw zmm9, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm9, zmm8
    vaesdec zmm0, zmm0, zmm8
    vaesenclast zmm1, zmm1, zmm8
    vaesdec zmm1, zmm1, zmm8
    vaesdec zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm3
    vpshufb zmm4, zmm4, zmm6
    vpshufb zmm5, zmm5, zmm7
    vaesdeclast zmm0, zmm0, zmm4
    vaesdeclast zmm1, zmm1, zmm5
    vmovdqu XMMWORD PTR [rdi], xmm0
    vextracti32x4 XMMWORD PTR [rdi + 32], zmm0, 1
    vextracti32x4 XMMWORD PTR [rdi + 64], zmm0, 2
    vextracti32x4 XMMWORD PTR [rdi + 96], zmm0, 3
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vextracti32x4 XMMWORD PTR [rdi + 48], zmm1, 1
    vextracti32x4 XMMWORD PTR [rdi + 80], zmm1, 2
    vextracti32x4 XMMWORD PTR [rdi + 112], zmm1, 3
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm4, xmm4, xmm4
    vpxord xmm5, xmm5, xmm5
    vpxord xmm6, xmm6, xmm6
    vpxord xmm7, xmm7, xmm7
    vpxord xmm8, xmm8, xmm8
    vpxord xmm9, xmm9, xmm9
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 88
    vzeroupper
    ret
vistrutah256Decrypt4BlocksZmmAsm ENDP

PUBLIC vistrutah512EncryptBlock256Asm
ALIGN 16
vistrutah512EncryptBlock256Asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    movdqu XMMWORD PTR [rsp + 64], xmm9
    movdqu XMMWORD PTR [rsp + 80], xmm10
    movdqu XMMWORD PTR [rsp + 96], xmm11
    movdqu XMMWORD PTR [rsp + 112], xmm12
    movdqu XMMWORD PTR [rsp + 128], xmm13
    movdqu XMMWORD PTR [rsp + 144], xmm14
    movdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    movdqu xmm2, XMMWORD PTR [rsi + 32]
    movdqu xmm3, XMMWORD PTR [rsi + 48]
    movdqu xmm4, XMMWORD PTR [rdx]
    movdqu xmm5, XMMWORD PTR [rdx + 16]
    movdqu xmm13, XMMWORD PTR [vistrutahConsts + 192]
    movdqu xmm14, XMMWORD PTR [vistrutahConsts + 224]
    movdqa xmm6, xmm4
    pshufb xmm6, xmm13
    movdqa xmm15, xmm5
    pshufb xmm15, xmm14
    pxor xmm6, xmm15
    movdqa xmm7, xmm5
    pshufb xmm7, xmm13
    movdqa xmm15, xmm4
    pshufb xmm15, xmm14
    pxor xmm7, xmm15
    movdqa xmm8, xmm5
    movdqa xmm9, xmm4
    movdqa xmm10, xmm7
    movdqa xmm11, xmm6
    pxor xmm12, xmm12
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_blk256_aesni_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 12
    je v512_blk256_aesni_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 14
    je v512_blk256_aesni_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
v512_blk256_aesni_final:
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    aesenclast xmm0, xmm8
    aesenclast xmm1, xmm9
    aesenclast xmm2, xmm10
    aesenclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi], xmm0
    movdqu XMMWORD PTR [rdi + 16], xmm1
    movdqu XMMWORD PTR [rdi + 32], xmm2
    movdqu XMMWORD PTR [rdi + 48], xmm3
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm14, xmm14
    pxor xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    movdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    movdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    movdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah512EncryptBlock256Asm ENDP

PUBLIC vistrutah512DecryptBlock256Asm
ALIGN 16
vistrutah512DecryptBlock256Asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    movdqu XMMWORD PTR [rsp + 64], xmm9
    movdqu XMMWORD PTR [rsp + 80], xmm10
    movdqu XMMWORD PTR [rsp + 96], xmm11
    movdqu XMMWORD PTR [rsp + 112], xmm12
    movdqu XMMWORD PTR [rsp + 128], xmm13
    movdqu XMMWORD PTR [rsp + 144], xmm14
    movdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    movdqu xmm4, XMMWORD PTR [rdx]
    movdqu xmm5, XMMWORD PTR [rdx + 16]
    movdqu xmm13, XMMWORD PTR [vistrutahConsts + 192]
    movdqu xmm14, XMMWORD PTR [vistrutahConsts + 224]
    movdqa xmm6, xmm4
    pshufb xmm6, xmm13
    movdqa xmm15, xmm5
    pshufb xmm15, xmm14
    pxor xmm6, xmm15
    movdqa xmm7, xmm5
    pshufb xmm7, xmm13
    movdqa xmm15, xmm4
    pshufb xmm15, xmm14
    pxor xmm7, xmm15
    movdqa xmm8, xmm5
    movdqa xmm9, xmm4
    movdqa xmm10, xmm7
    movdqa xmm11, xmm6
    aesimc xmm4, xmm4
    aesimc xmm5, xmm5
    aesimc xmm6, xmm6
    aesimc xmm7, xmm7
    movdqu xmm12, XMMWORD PTR [vistrutahConsts + 576]
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    movdqu xmm2, XMMWORD PTR [rsi + 32]
    movdqu xmm3, XMMWORD PTR [rsi + 48]
    palignr xmm8, xmm8, 9
    palignr xmm9, xmm9, 2
    palignr xmm10, xmm10, 9
    palignr xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_blk256_aesni_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_blk256_aesni_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_blk256_aesni_init_done
    palignr xmm8, xmm8, 10
    palignr xmm9, xmm9, 4
    palignr xmm10, xmm10, 10
    palignr xmm11, xmm11, 4
v512_dec_blk256_aesni_init_done:
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_dec_blk256_aesni_step4
    cmp rcx, 12
    je v512_dec_blk256_aesni_step5
    cmp rcx, 14
    je v512_dec_blk256_aesni_step6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_blk256_aesni_step6:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_blk256_aesni_step5:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_blk256_aesni_step4:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    aesdeclast xmm0, xmm8
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi], xmm0
    movdqu XMMWORD PTR [rdi + 16], xmm1
    movdqu XMMWORD PTR [rdi + 32], xmm2
    movdqu XMMWORD PTR [rdi + 48], xmm3
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm14, xmm14
    pxor xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    movdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    movdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    movdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah512DecryptBlock256Asm ENDP

PUBLIC vistrutah512EncryptBlock256VexAsm
ALIGN 16
vistrutah512EncryptBlock256VexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vmovdqu xmm4, XMMWORD PTR [rdx]
    vmovdqu xmm5, XMMWORD PTR [rdx + 16]
    vmovdqu xmm13, XMMWORD PTR [vistrutahConsts + 192]
    vmovdqu xmm14, XMMWORD PTR [vistrutahConsts + 224]
    vpshufb xmm6, xmm4, xmm13
    vpshufb xmm15, xmm5, xmm14
    vpxor xmm6, xmm6, xmm15
    vpshufb xmm7, xmm5, xmm13
    vpshufb xmm15, xmm4, xmm14
    vpxor xmm7, xmm7, xmm15
    vmovdqa xmm8, xmm5
    vmovdqa xmm9, xmm4
    vmovdqa xmm10, xmm7
    vmovdqa xmm11, xmm6
    vpxor xmm12, xmm12, xmm12
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_blk256_vex_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 12
    je v512_blk256_vex_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 14
    je v512_blk256_vex_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
v512_blk256_vex_final:
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vaesenclast xmm0, xmm0, xmm8
    vaesenclast xmm1, xmm1, xmm9
    vaesenclast xmm2, xmm2, xmm10
    vaesenclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah512EncryptBlock256VexAsm ENDP

PUBLIC vistrutah512DecryptBlock256VexAsm
ALIGN 16
vistrutah512DecryptBlock256VexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm4, XMMWORD PTR [rdx]
    vmovdqu xmm5, XMMWORD PTR [rdx + 16]
    vmovdqu xmm13, XMMWORD PTR [vistrutahConsts + 192]
    vmovdqu xmm14, XMMWORD PTR [vistrutahConsts + 224]
    vpshufb xmm6, xmm4, xmm13
    vpshufb xmm15, xmm5, xmm14
    vpxor xmm6, xmm6, xmm15
    vpshufb xmm7, xmm5, xmm13
    vpshufb xmm15, xmm4, xmm14
    vpxor xmm7, xmm7, xmm15
    vmovdqa xmm8, xmm5
    vmovdqa xmm9, xmm4
    vmovdqa xmm10, xmm7
    vmovdqa xmm11, xmm6
    vaesimc xmm4, xmm4
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vmovdqu xmm12, XMMWORD PTR [vistrutahConsts + 576]
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vpalignr xmm8, xmm8, xmm8, 9
    vpalignr xmm9, xmm9, xmm9, 2
    vpalignr xmm10, xmm10, xmm10, 9
    vpalignr xmm11, xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_blk256_vex_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_blk256_vex_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_blk256_vex_init_done
    vpalignr xmm8, xmm8, xmm8, 10
    vpalignr xmm9, xmm9, xmm9, 4
    vpalignr xmm10, xmm10, xmm10, 10
    vpalignr xmm11, xmm11, xmm11, 4
v512_dec_blk256_vex_init_done:
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_dec_blk256_vex_step4
    cmp rcx, 12
    je v512_dec_blk256_vex_step5
    cmp rcx, 14
    je v512_dec_blk256_vex_step6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_blk256_vex_step6:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_blk256_vex_step5:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_blk256_vex_step4:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vaesdeclast xmm0, xmm0, xmm8
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah512DecryptBlock256VexAsm ENDP

PUBLIC vistrutah512EncryptBlock256YmmAsm
ALIGN 16
vistrutah512EncryptBlock256YmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu ymm0, YMMWORD PTR [rsi]
    vmovdqu ymm1, YMMWORD PTR [rsi + 32]
    vmovdqu ymm2, YMMWORD PTR [rdx]
    vperm2i128 ymm4, ymm2, ymm2, 1
    vpshufb ymm3, ymm2, YMMWORD PTR [vistrutahConsts + 192]
    vpshufb ymm8, ymm4, YMMWORD PTR [vistrutahConsts + 224]
    vpxor ymm3, ymm3, ymm8
    vperm2i128 ymm5, ymm3, ymm3, 1
    vpxor xmm6, xmm6, xmm6
    vmovdqu ymm7, YMMWORD PTR [vistrutahConsts + 128]
    vpxor ymm0, ymm0, ymm4
    vpxor ymm1, ymm1, ymm5
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
    cmp rcx, 10
    je v512_blk256_ymm_final
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
    cmp rcx, 12
    je v512_blk256_ymm_final
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
    cmp rcx, 14
    je v512_blk256_ymm_final
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
v512_blk256_ymm_final:
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vaesenclast ymm0, ymm0, ymm4
    vaesenclast ymm1, ymm1, ymm5
    vmovdqu YMMWORD PTR [rdi], ymm0
    vmovdqu YMMWORD PTR [rdi + 32], ymm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 88
    vzeroupper
    ret
vistrutah512EncryptBlock256YmmAsm ENDP

PUBLIC vistrutah512DecryptBlock256YmmAsm
ALIGN 16
vistrutah512DecryptBlock256YmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu ymm0, YMMWORD PTR [rsi]
    vmovdqu ymm1, YMMWORD PTR [rsi + 32]
    vmovdqu ymm2, YMMWORD PTR [rdx]
    vperm2i128 ymm4, ymm2, ymm2, 1
    vpshufb ymm3, ymm2, YMMWORD PTR [vistrutahConsts + 192]
    vpshufb ymm8, ymm4, YMMWORD PTR [vistrutahConsts + 224]
    vpxor ymm3, ymm3, ymm8
    vperm2i128 ymm5, ymm3, ymm3, 1
    vpxor xmm6, xmm6, xmm6
    vaesenclast ymm2, ymm2, ymm6
    vaesdec ymm2, ymm2, ymm6
    vaesenclast ymm3, ymm3, ymm6
    vaesdec ymm3, ymm3, ymm6
    vmovdqu ymm7, YMMWORD PTR [vistrutahConsts + 512]
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    cmp rcx, 10
    je v512_dec_blk256_ymm_init_done
    vmovdqu ymm7, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    cmp rcx, 12
    je v512_dec_blk256_ymm_init_done
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    cmp rcx, 14
    je v512_dec_blk256_ymm_init_done
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
v512_dec_blk256_ymm_init_done:
    vmovdqu ymm7, YMMWORD PTR [vistrutahConsts + 448]
    vmovdqu ymm8, YMMWORD PTR [vistrutahConsts + 576]
    vpxor ymm0, ymm0, ymm4
    vpxor ymm1, ymm1, ymm5
    cmp rcx, 10
    je v512_dec_blk256_ymm_step4
    cmp rcx, 12
    je v512_dec_blk256_ymm_step5
    cmp rcx, 14
    je v512_dec_blk256_ymm_step6
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
v512_dec_blk256_ymm_step6:
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
v512_dec_blk256_ymm_step5:
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
v512_dec_blk256_ymm_step4:
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vaesdeclast ymm0, ymm0, ymm4
    vaesdeclast ymm1, ymm1, ymm5
    vmovdqu YMMWORD PTR [rdi], ymm0
    vmovdqu YMMWORD PTR [rdi + 32], ymm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 88
    vzeroupper
    ret
vistrutah512DecryptBlock256YmmAsm ENDP

PUBLIC vistrutah512EncryptBlock256ZmmAsm
ALIGN 16
vistrutah512EncryptBlock256ZmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 56
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu64 zmm0, ZMMWORD PTR [rsi]
    vmovdqu ymm1, YMMWORD PTR [rdx]
    vperm2i128 ymm5, ymm1, ymm1, 1
    vpshufb ymm6, ymm1, YMMWORD PTR [vistrutahConsts + 192]
    vpshufb ymm7, ymm5, YMMWORD PTR [vistrutahConsts + 224]
    vpxor ymm6, ymm6, ymm7
    vshufi32x4 zmm1, zmm1, zmm6, 68
    vshufi32x4 zmm2, zmm1, zmm1, 177
    vpxord xmm3, xmm3, xmm3
    vmovdqu64 zmm4, ZMMWORD PTR [vistrutahConsts + 128]
    vpxorq zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
    cmp rcx, 10
    je v512_blk256_zmm_final
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
    cmp rcx, 12
    je v512_blk256_zmm_final
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
    cmp rcx, 14
    je v512_blk256_zmm_final
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
v512_blk256_zmm_final:
    vaesenc zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vaesenclast zmm0, zmm0, zmm2
    vmovdqu64 ZMMWORD PTR [rdi], zmm0
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm4, xmm4, xmm4
    vpxord xmm5, xmm5, xmm5
    vpxord xmm6, xmm6, xmm6
    vpxord xmm7, xmm7, xmm7
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 56
    vzeroupper
    ret
vistrutah512EncryptBlock256ZmmAsm ENDP

PUBLIC vistrutah512DecryptBlock256ZmmAsm
ALIGN 16
vistrutah512DecryptBlock256ZmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 56
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu64 zmm0, ZMMWORD PTR [rsi]
    vmovdqu ymm1, YMMWORD PTR [rdx]
    vperm2i128 ymm5, ymm1, ymm1, 1
    vpshufb ymm6, ymm1, YMMWORD PTR [vistrutahConsts + 192]
    vpshufb ymm7, ymm5, YMMWORD PTR [vistrutahConsts + 224]
    vpxor ymm6, ymm6, ymm7
    vshufi32x4 zmm1, zmm1, zmm6, 68
    vshufi32x4 zmm2, zmm1, zmm1, 177
    vpxord xmm3, xmm3, xmm3
    vaesenclast zmm1, zmm1, zmm3
    vaesdec zmm1, zmm1, zmm3
    vmovdqu64 zmm4, ZMMWORD PTR [vistrutahConsts + 512]
    vpshufb zmm2, zmm2, zmm4
    cmp rcx, 10
    je v512_dec_blk256_zmm_init_done
    vmovdqu64 zmm4, ZMMWORD PTR [vistrutahConsts + 128]
    vpshufb zmm2, zmm2, zmm4
    cmp rcx, 12
    je v512_dec_blk256_zmm_init_done
    vpshufb zmm2, zmm2, zmm4
    cmp rcx, 14
    je v512_dec_blk256_zmm_init_done
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm2, zmm2, zmm4
v512_dec_blk256_zmm_init_done:
    vmovdqu64 zmm4, ZMMWORD PTR [vistrutahConsts + 448]
    vmovdqu64 zmm5, ZMMWORD PTR [vistrutahConsts + 576]
    vpxorq zmm0, zmm0, zmm2
    cmp rcx, 10
    je v512_dec_blk256_zmm_step4
    cmp rcx, 12
    je v512_dec_blk256_zmm_step5
    cmp rcx, 14
    je v512_dec_blk256_zmm_step6
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
v512_dec_blk256_zmm_step6:
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
v512_dec_blk256_zmm_step5:
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
v512_dec_blk256_zmm_step4:
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vaesdeclast zmm0, zmm0, zmm2
    vmovdqu64 ZMMWORD PTR [rdi], zmm0
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm4, xmm4, xmm4
    vpxord xmm5, xmm5, xmm5
    vpxord xmm6, xmm6, xmm6
    vpxord xmm7, xmm7, xmm7
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 56
    vzeroupper
    ret
vistrutah512DecryptBlock256ZmmAsm ENDP

PUBLIC vistrutah512EncryptBlock512Asm
ALIGN 16
vistrutah512EncryptBlock512Asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 168
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    movdqu XMMWORD PTR [rsp + 64], xmm9
    movdqu XMMWORD PTR [rsp + 80], xmm10
    movdqu XMMWORD PTR [rsp + 96], xmm11
    movdqu XMMWORD PTR [rsp + 112], xmm12
    movdqu XMMWORD PTR [rsp + 128], xmm13
    movdqu XMMWORD PTR [rsp + 144], xmm14
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    movdqu xmm2, XMMWORD PTR [rsi + 32]
    movdqu xmm3, XMMWORD PTR [rsi + 48]
    movdqu xmm4, XMMWORD PTR [rdx]
    movdqu xmm5, XMMWORD PTR [rdx + 16]
    movdqu xmm6, XMMWORD PTR [rdx + 32]
    movdqu xmm7, XMMWORD PTR [rdx + 48]
    movdqa xmm8, xmm5
    movdqa xmm9, xmm4
    movdqa xmm10, xmm7
    movdqa xmm11, xmm6
    pxor xmm12, xmm12
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_blk512_aesni_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 12
    je v512_blk512_aesni_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 14
    je v512_blk512_aesni_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
v512_blk512_aesni_final:
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    aesenclast xmm0, xmm8
    aesenclast xmm1, xmm9
    aesenclast xmm2, xmm10
    aesenclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi], xmm0
    movdqu XMMWORD PTR [rdi + 16], xmm1
    movdqu XMMWORD PTR [rdi + 32], xmm2
    movdqu XMMWORD PTR [rdi + 48], xmm3
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm14, xmm14
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    movdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    movdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 168
    ret
vistrutah512EncryptBlock512Asm ENDP

PUBLIC vistrutah512DecryptBlock512Asm
ALIGN 16
vistrutah512DecryptBlock512Asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 168
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    movdqu XMMWORD PTR [rsp + 64], xmm9
    movdqu XMMWORD PTR [rsp + 80], xmm10
    movdqu XMMWORD PTR [rsp + 96], xmm11
    movdqu XMMWORD PTR [rsp + 112], xmm12
    movdqu XMMWORD PTR [rsp + 128], xmm13
    movdqu XMMWORD PTR [rsp + 144], xmm14
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    movdqu xmm4, XMMWORD PTR [rdx]
    movdqu xmm5, XMMWORD PTR [rdx + 16]
    movdqu xmm6, XMMWORD PTR [rdx + 32]
    movdqu xmm7, XMMWORD PTR [rdx + 48]
    movdqa xmm8, xmm5
    movdqa xmm9, xmm4
    movdqa xmm10, xmm7
    movdqa xmm11, xmm6
    aesimc xmm4, xmm4
    aesimc xmm5, xmm5
    aesimc xmm6, xmm6
    aesimc xmm7, xmm7
    movdqu xmm12, XMMWORD PTR [vistrutahConsts + 576]
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    movdqu xmm2, XMMWORD PTR [rsi + 32]
    movdqu xmm3, XMMWORD PTR [rsi + 48]
    palignr xmm8, xmm8, 9
    palignr xmm9, xmm9, 2
    palignr xmm10, xmm10, 9
    palignr xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_blk512_aesni_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_blk512_aesni_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_blk512_aesni_init_done
    palignr xmm8, xmm8, 10
    palignr xmm9, xmm9, 4
    palignr xmm10, xmm10, 10
    palignr xmm11, xmm11, 4
v512_dec_blk512_aesni_init_done:
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_dec_blk512_aesni_step4
    cmp rcx, 12
    je v512_dec_blk512_aesni_step5
    cmp rcx, 14
    je v512_dec_blk512_aesni_step6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_blk512_aesni_step6:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_blk512_aesni_step5:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_blk512_aesni_step4:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    aesdeclast xmm0, xmm8
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi], xmm0
    movdqu XMMWORD PTR [rdi + 16], xmm1
    movdqu XMMWORD PTR [rdi + 32], xmm2
    movdqu XMMWORD PTR [rdi + 48], xmm3
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm14, xmm14
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    movdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    movdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 168
    ret
vistrutah512DecryptBlock512Asm ENDP

PUBLIC vistrutah512EncryptBlock512VexAsm
ALIGN 16
vistrutah512EncryptBlock512VexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vmovdqu xmm4, XMMWORD PTR [rdx]
    vmovdqu xmm5, XMMWORD PTR [rdx + 16]
    vmovdqu xmm6, XMMWORD PTR [rdx + 32]
    vmovdqu xmm7, XMMWORD PTR [rdx + 48]
    vmovdqa xmm8, xmm5
    vmovdqa xmm9, xmm4
    vmovdqa xmm10, xmm7
    vmovdqa xmm11, xmm6
    vpxor xmm12, xmm12, xmm12
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_blk512_vex_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 12
    je v512_blk512_vex_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 14
    je v512_blk512_vex_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
v512_blk512_vex_final:
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vaesenclast xmm0, xmm0, xmm8
    vaesenclast xmm1, xmm1, xmm9
    vaesenclast xmm2, xmm2, xmm10
    vaesenclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah512EncryptBlock512VexAsm ENDP

PUBLIC vistrutah512DecryptBlock512VexAsm
ALIGN 16
vistrutah512DecryptBlock512VexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm4, XMMWORD PTR [rdx]
    vmovdqu xmm5, XMMWORD PTR [rdx + 16]
    vmovdqu xmm6, XMMWORD PTR [rdx + 32]
    vmovdqu xmm7, XMMWORD PTR [rdx + 48]
    vmovdqa xmm8, xmm5
    vmovdqa xmm9, xmm4
    vmovdqa xmm10, xmm7
    vmovdqa xmm11, xmm6
    vaesimc xmm4, xmm4
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vmovdqu xmm12, XMMWORD PTR [vistrutahConsts + 576]
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vpalignr xmm8, xmm8, xmm8, 9
    vpalignr xmm9, xmm9, xmm9, 2
    vpalignr xmm10, xmm10, xmm10, 9
    vpalignr xmm11, xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_blk512_vex_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_blk512_vex_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_blk512_vex_init_done
    vpalignr xmm8, xmm8, xmm8, 10
    vpalignr xmm9, xmm9, xmm9, 4
    vpalignr xmm10, xmm10, xmm10, 10
    vpalignr xmm11, xmm11, xmm11, 4
v512_dec_blk512_vex_init_done:
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_dec_blk512_vex_step4
    cmp rcx, 12
    je v512_dec_blk512_vex_step5
    cmp rcx, 14
    je v512_dec_blk512_vex_step6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_blk512_vex_step6:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_blk512_vex_step5:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_blk512_vex_step4:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vaesdeclast xmm0, xmm0, xmm8
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah512DecryptBlock512VexAsm ENDP

PUBLIC vistrutah512EncryptBlock512YmmAsm
ALIGN 16
vistrutah512EncryptBlock512YmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu ymm0, YMMWORD PTR [rsi]
    vmovdqu ymm1, YMMWORD PTR [rsi + 32]
    vmovdqu ymm2, YMMWORD PTR [rdx]
    vperm2i128 ymm4, ymm2, ymm2, 1
    vmovdqu ymm3, YMMWORD PTR [rdx + 32]
    vperm2i128 ymm5, ymm3, ymm3, 1
    vpxor xmm6, xmm6, xmm6
    vmovdqu ymm7, YMMWORD PTR [vistrutahConsts + 128]
    vpxor ymm0, ymm0, ymm4
    vpxor ymm1, ymm1, ymm5
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
    cmp rcx, 10
    je v512_blk512_ymm_final
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
    cmp rcx, 12
    je v512_blk512_ymm_final
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
    cmp rcx, 14
    je v512_blk512_ymm_final
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vaesenc ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm6
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm9, ymm0, ymm1
    vperm2i128 ymm0, ymm8, ymm9, 32
    vperm2i128 ymm1, ymm8, ymm9, 49
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor ymm9, ymm9, ymm4
    vpxor ymm0, ymm8, ymm9
    vpxor ymm1, ymm1, ymm5
v512_blk512_ymm_final:
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vaesenclast ymm0, ymm0, ymm4
    vaesenclast ymm1, ymm1, ymm5
    vmovdqu YMMWORD PTR [rdi], ymm0
    vmovdqu YMMWORD PTR [rdi + 32], ymm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 88
    vzeroupper
    ret
vistrutah512EncryptBlock512YmmAsm ENDP

PUBLIC vistrutah512DecryptBlock512YmmAsm
ALIGN 16
vistrutah512DecryptBlock512YmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu ymm0, YMMWORD PTR [rsi]
    vmovdqu ymm1, YMMWORD PTR [rsi + 32]
    vmovdqu ymm2, YMMWORD PTR [rdx]
    vperm2i128 ymm4, ymm2, ymm2, 1
    vmovdqu ymm3, YMMWORD PTR [rdx + 32]
    vperm2i128 ymm5, ymm3, ymm3, 1
    vpxor xmm6, xmm6, xmm6
    vaesenclast ymm2, ymm2, ymm6
    vaesdec ymm2, ymm2, ymm6
    vaesenclast ymm3, ymm3, ymm6
    vaesdec ymm3, ymm3, ymm6
    vmovdqu ymm7, YMMWORD PTR [vistrutahConsts + 512]
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    cmp rcx, 10
    je v512_dec_blk512_ymm_init_done
    vmovdqu ymm7, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    cmp rcx, 12
    je v512_dec_blk512_ymm_init_done
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    cmp rcx, 14
    je v512_dec_blk512_ymm_init_done
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
v512_dec_blk512_ymm_init_done:
    vmovdqu ymm7, YMMWORD PTR [vistrutahConsts + 448]
    vmovdqu ymm8, YMMWORD PTR [vistrutahConsts + 576]
    vpxor ymm0, ymm0, ymm4
    vpxor ymm1, ymm1, ymm5
    cmp rcx, 10
    je v512_dec_blk512_ymm_step4
    cmp rcx, 12
    je v512_dec_blk512_ymm_step5
    cmp rcx, 14
    je v512_dec_blk512_ymm_step6
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
v512_dec_blk512_ymm_step6:
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
v512_dec_blk512_ymm_step5:
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
v512_dec_blk512_ymm_step4:
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vmovdqu xmm9, XMMWORD PTR [vistrutahRoundConstants]
    vpxor ymm9, ymm9, ymm4
    vaesdeclast ymm0, ymm0, ymm9
    vaesdeclast ymm1, ymm1, ymm5
    vpshufb ymm0, ymm0, ymm8
    vpshufb ymm1, ymm1, ymm8
    vpunpckldq ymm9, ymm0, ymm1
    vpunpckhdq ymm1, ymm0, ymm1
    vpermq ymm0, ymm9, 216
    vpermq ymm1, ymm1, 216
    vaesenclast ymm0, ymm0, ymm6
    vaesdec ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm6
    vaesdec ymm1, ymm1, ymm6
    vaesdec ymm0, ymm0, ymm2
    vaesdec ymm1, ymm1, ymm3
    vpshufb ymm4, ymm4, ymm7
    vpshufb ymm5, ymm5, ymm7
    vaesdeclast ymm0, ymm0, ymm4
    vaesdeclast ymm1, ymm1, ymm5
    vmovdqu YMMWORD PTR [rdi], ymm0
    vmovdqu YMMWORD PTR [rdi + 32], ymm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 88
    vzeroupper
    ret
vistrutah512DecryptBlock512YmmAsm ENDP

PUBLIC vistrutah512EncryptBlock512ZmmAsm
ALIGN 16
vistrutah512EncryptBlock512ZmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 56
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu64 zmm0, ZMMWORD PTR [rsi]
    vmovdqu64 zmm1, ZMMWORD PTR [rdx]
    vshufi32x4 zmm2, zmm1, zmm1, 177
    vpxord xmm3, xmm3, xmm3
    vmovdqu64 zmm4, ZMMWORD PTR [vistrutahConsts + 128]
    vpxorq zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
    cmp rcx, 10
    je v512_blk512_zmm_final
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
    cmp rcx, 12
    je v512_blk512_zmm_final
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
    cmp rcx, 14
    je v512_blk512_zmm_final
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
    vaesenc zmm0, zmm0, zmm1
    vaesenc zmm0, zmm0, zmm3
    vpermq zmm5, zmm0, 216
    vshufi32x4 zmm6, zmm5, zmm5, 78
    vpunpcklbw zmm7, zmm5, zmm6
    vpunpckhbw zmm6, zmm5, zmm6
    vpunpcklbw zmm5, zmm7, zmm6
    vpunpckhbw zmm6, zmm7, zmm6
    vshufi32x4 zmm0, zmm5, zmm6, 68
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm5, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxorq zmm5, zmm5, zmm2
    vpxorq zmm0, zmm0, zmm5
v512_blk512_zmm_final:
    vaesenc zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vaesenclast zmm0, zmm0, zmm2
    vmovdqu64 ZMMWORD PTR [rdi], zmm0
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm4, xmm4, xmm4
    vpxord xmm5, xmm5, xmm5
    vpxord xmm6, xmm6, xmm6
    vpxord xmm7, xmm7, xmm7
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 56
    vzeroupper
    ret
vistrutah512EncryptBlock512ZmmAsm ENDP

PUBLIC vistrutah512DecryptBlock512ZmmAsm
ALIGN 16
vistrutah512DecryptBlock512ZmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 56
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu64 zmm0, ZMMWORD PTR [rsi]
    vmovdqu64 zmm1, ZMMWORD PTR [rdx]
    vshufi32x4 zmm2, zmm1, zmm1, 177
    vpxord xmm3, xmm3, xmm3
    vaesenclast zmm1, zmm1, zmm3
    vaesdec zmm1, zmm1, zmm3
    vmovdqu64 zmm4, ZMMWORD PTR [vistrutahConsts + 512]
    vpshufb zmm2, zmm2, zmm4
    cmp rcx, 10
    je v512_dec_blk512_zmm_init_done
    vmovdqu64 zmm4, ZMMWORD PTR [vistrutahConsts + 128]
    vpshufb zmm2, zmm2, zmm4
    cmp rcx, 12
    je v512_dec_blk512_zmm_init_done
    vpshufb zmm2, zmm2, zmm4
    cmp rcx, 14
    je v512_dec_blk512_zmm_init_done
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm2, zmm2, zmm4
v512_dec_blk512_zmm_init_done:
    vmovdqu64 zmm4, ZMMWORD PTR [vistrutahConsts + 448]
    vmovdqu64 zmm5, ZMMWORD PTR [vistrutahConsts + 576]
    vpxorq zmm0, zmm0, zmm2
    cmp rcx, 10
    je v512_dec_blk512_zmm_step4
    cmp rcx, 12
    je v512_dec_blk512_zmm_step5
    cmp rcx, 14
    je v512_dec_blk512_zmm_step6
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
v512_dec_blk512_zmm_step6:
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
v512_dec_blk512_zmm_step5:
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
v512_dec_blk512_zmm_step4:
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vmovdqu xmm6, XMMWORD PTR [vistrutahRoundConstants]
    vpxorq zmm6, zmm6, zmm2
    vaesdeclast zmm0, zmm0, zmm6
    vpshufb zmm0, zmm0, zmm5
    vshufi32x4 zmm6, zmm0, zmm0, 78
    vpunpckldq zmm7, zmm0, zmm6
    vpunpckhdq zmm6, zmm0, zmm6
    vshufi32x4 zmm0, zmm7, zmm6, 68
    vpermq zmm0, zmm0, 216
    vaesenclast zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm3
    vaesdec zmm0, zmm0, zmm1
    vpshufb zmm2, zmm2, zmm4
    vaesdeclast zmm0, zmm0, zmm2
    vmovdqu64 ZMMWORD PTR [rdi], zmm0
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm4, xmm4, xmm4
    vpxord xmm5, xmm5, xmm5
    vpxord xmm6, xmm6, xmm6
    vpxord xmm7, xmm7, xmm7
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 56
    vzeroupper
    ret
vistrutah512DecryptBlock512ZmmAsm ENDP

PUBLIC vistrutah512Encrypt4Blocks256AesNiAsm
ALIGN 16
vistrutah512Encrypt4Blocks256AesNiAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    movdqu XMMWORD PTR [rsp + 64], xmm9
    movdqu XMMWORD PTR [rsp + 80], xmm10
    movdqu XMMWORD PTR [rsp + 96], xmm11
    movdqu XMMWORD PTR [rsp + 112], xmm12
    movdqu XMMWORD PTR [rsp + 128], xmm13
    movdqu XMMWORD PTR [rsp + 144], xmm14
    movdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    movdqu xmm4, XMMWORD PTR [rdx]
    movdqu xmm5, XMMWORD PTR [rdx + 16]
    movdqu xmm13, XMMWORD PTR [vistrutahConsts + 192]
    movdqu xmm14, XMMWORD PTR [vistrutahConsts + 224]
    movdqa xmm6, xmm4
    pshufb xmm6, xmm13
    movdqa xmm15, xmm5
    pshufb xmm15, xmm14
    pxor xmm6, xmm15
    movdqa xmm7, xmm5
    pshufb xmm7, xmm13
    movdqa xmm15, xmm4
    pshufb xmm15, xmm14
    pxor xmm7, xmm15
    pxor xmm12, xmm12
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    movdqu xmm2, XMMWORD PTR [rsi + 32]
    movdqu xmm3, XMMWORD PTR [rsi + 48]
    movdqa xmm8, xmm5
    movdqa xmm9, xmm4
    movdqa xmm10, xmm7
    movdqa xmm11, xmm6
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_4blk256_aesni_b0_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 12
    je v512_4blk256_aesni_b0_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 14
    je v512_4blk256_aesni_b0_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
v512_4blk256_aesni_b0_final:
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    aesenclast xmm0, xmm8
    aesenclast xmm1, xmm9
    aesenclast xmm2, xmm10
    aesenclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi], xmm0
    movdqu XMMWORD PTR [rdi + 16], xmm1
    movdqu XMMWORD PTR [rdi + 32], xmm2
    movdqu XMMWORD PTR [rdi + 48], xmm3
    movdqu xmm0, XMMWORD PTR [rsi + 64]
    movdqu xmm1, XMMWORD PTR [rsi + 80]
    movdqu xmm2, XMMWORD PTR [rsi + 96]
    movdqu xmm3, XMMWORD PTR [rsi + 112]
    movdqa xmm8, xmm5
    movdqa xmm9, xmm4
    movdqa xmm10, xmm7
    movdqa xmm11, xmm6
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_4blk256_aesni_b1_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 12
    je v512_4blk256_aesni_b1_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 14
    je v512_4blk256_aesni_b1_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
v512_4blk256_aesni_b1_final:
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    aesenclast xmm0, xmm8
    aesenclast xmm1, xmm9
    aesenclast xmm2, xmm10
    aesenclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi + 64], xmm0
    movdqu XMMWORD PTR [rdi + 80], xmm1
    movdqu XMMWORD PTR [rdi + 96], xmm2
    movdqu XMMWORD PTR [rdi + 112], xmm3
    movdqu xmm0, XMMWORD PTR [rsi + 128]
    movdqu xmm1, XMMWORD PTR [rsi + 144]
    movdqu xmm2, XMMWORD PTR [rsi + 160]
    movdqu xmm3, XMMWORD PTR [rsi + 176]
    movdqa xmm8, xmm5
    movdqa xmm9, xmm4
    movdqa xmm10, xmm7
    movdqa xmm11, xmm6
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_4blk256_aesni_b2_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 12
    je v512_4blk256_aesni_b2_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 14
    je v512_4blk256_aesni_b2_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
v512_4blk256_aesni_b2_final:
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    aesenclast xmm0, xmm8
    aesenclast xmm1, xmm9
    aesenclast xmm2, xmm10
    aesenclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi + 128], xmm0
    movdqu XMMWORD PTR [rdi + 144], xmm1
    movdqu XMMWORD PTR [rdi + 160], xmm2
    movdqu XMMWORD PTR [rdi + 176], xmm3
    movdqu xmm0, XMMWORD PTR [rsi + 192]
    movdqu xmm1, XMMWORD PTR [rsi + 208]
    movdqu xmm2, XMMWORD PTR [rsi + 224]
    movdqu xmm3, XMMWORD PTR [rsi + 240]
    movdqa xmm8, xmm5
    movdqa xmm9, xmm4
    movdqa xmm10, xmm7
    movdqa xmm11, xmm6
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_4blk256_aesni_b3_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 12
    je v512_4blk256_aesni_b3_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 14
    je v512_4blk256_aesni_b3_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
v512_4blk256_aesni_b3_final:
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    aesenclast xmm0, xmm8
    aesenclast xmm1, xmm9
    aesenclast xmm2, xmm10
    aesenclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi + 192], xmm0
    movdqu XMMWORD PTR [rdi + 208], xmm1
    movdqu XMMWORD PTR [rdi + 224], xmm2
    movdqu XMMWORD PTR [rdi + 240], xmm3
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm14, xmm14
    pxor xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    movdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    movdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    movdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah512Encrypt4Blocks256AesNiAsm ENDP

PUBLIC vistrutah512Decrypt4Blocks256AesNiAsm
ALIGN 16
vistrutah512Decrypt4Blocks256AesNiAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    movdqu XMMWORD PTR [rsp + 64], xmm9
    movdqu XMMWORD PTR [rsp + 80], xmm10
    movdqu XMMWORD PTR [rsp + 96], xmm11
    movdqu XMMWORD PTR [rsp + 112], xmm12
    movdqu XMMWORD PTR [rsp + 128], xmm13
    movdqu XMMWORD PTR [rsp + 144], xmm14
    movdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    movdqu xmm4, XMMWORD PTR [rdx]
    movdqu xmm5, XMMWORD PTR [rdx + 16]
    movdqu xmm13, XMMWORD PTR [vistrutahConsts + 192]
    movdqu xmm14, XMMWORD PTR [vistrutahConsts + 224]
    movdqa xmm6, xmm4
    pshufb xmm6, xmm13
    movdqa xmm15, xmm5
    pshufb xmm15, xmm14
    pxor xmm6, xmm15
    movdqa xmm7, xmm5
    pshufb xmm7, xmm13
    movdqa xmm15, xmm4
    pshufb xmm15, xmm14
    pxor xmm7, xmm15
    movdqa xmm8, xmm5
    movdqa xmm9, xmm4
    movdqa xmm10, xmm7
    movdqa xmm11, xmm6
    aesimc xmm4, xmm4
    aesimc xmm5, xmm5
    aesimc xmm6, xmm6
    aesimc xmm7, xmm7
    movdqu xmm12, XMMWORD PTR [vistrutahConsts + 576]
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    movdqu xmm2, XMMWORD PTR [rsi + 32]
    movdqu xmm3, XMMWORD PTR [rsi + 48]
    palignr xmm8, xmm8, 9
    palignr xmm9, xmm9, 2
    palignr xmm10, xmm10, 9
    palignr xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk256_aesni_b0_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk256_aesni_b0_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk256_aesni_b0_init_done
    palignr xmm8, xmm8, 10
    palignr xmm9, xmm9, 4
    palignr xmm10, xmm10, 10
    palignr xmm11, xmm11, 4
v512_dec_4blk256_aesni_b0_init_done:
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk256_aesni_b0_step4
    cmp rcx, 12
    je v512_dec_4blk256_aesni_b0_step5
    cmp rcx, 14
    je v512_dec_4blk256_aesni_b0_step6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk256_aesni_b0_step6:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk256_aesni_b0_step5:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk256_aesni_b0_step4:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    aesdeclast xmm0, xmm8
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi], xmm0
    movdqu XMMWORD PTR [rdi + 16], xmm1
    movdqu XMMWORD PTR [rdi + 32], xmm2
    movdqu XMMWORD PTR [rdi + 48], xmm3
    movdqu xmm0, XMMWORD PTR [rsi + 64]
    movdqu xmm1, XMMWORD PTR [rsi + 80]
    movdqu xmm2, XMMWORD PTR [rsi + 96]
    movdqu xmm3, XMMWORD PTR [rsi + 112]
    palignr xmm8, xmm8, 9
    palignr xmm9, xmm9, 2
    palignr xmm10, xmm10, 9
    palignr xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk256_aesni_b1_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk256_aesni_b1_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk256_aesni_b1_init_done
    palignr xmm8, xmm8, 10
    palignr xmm9, xmm9, 4
    palignr xmm10, xmm10, 10
    palignr xmm11, xmm11, 4
v512_dec_4blk256_aesni_b1_init_done:
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk256_aesni_b1_step4
    cmp rcx, 12
    je v512_dec_4blk256_aesni_b1_step5
    cmp rcx, 14
    je v512_dec_4blk256_aesni_b1_step6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk256_aesni_b1_step6:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk256_aesni_b1_step5:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk256_aesni_b1_step4:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    aesdeclast xmm0, xmm8
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi + 64], xmm0
    movdqu XMMWORD PTR [rdi + 80], xmm1
    movdqu XMMWORD PTR [rdi + 96], xmm2
    movdqu XMMWORD PTR [rdi + 112], xmm3
    movdqu xmm0, XMMWORD PTR [rsi + 128]
    movdqu xmm1, XMMWORD PTR [rsi + 144]
    movdqu xmm2, XMMWORD PTR [rsi + 160]
    movdqu xmm3, XMMWORD PTR [rsi + 176]
    palignr xmm8, xmm8, 9
    palignr xmm9, xmm9, 2
    palignr xmm10, xmm10, 9
    palignr xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk256_aesni_b2_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk256_aesni_b2_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk256_aesni_b2_init_done
    palignr xmm8, xmm8, 10
    palignr xmm9, xmm9, 4
    palignr xmm10, xmm10, 10
    palignr xmm11, xmm11, 4
v512_dec_4blk256_aesni_b2_init_done:
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk256_aesni_b2_step4
    cmp rcx, 12
    je v512_dec_4blk256_aesni_b2_step5
    cmp rcx, 14
    je v512_dec_4blk256_aesni_b2_step6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk256_aesni_b2_step6:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk256_aesni_b2_step5:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk256_aesni_b2_step4:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    aesdeclast xmm0, xmm8
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi + 128], xmm0
    movdqu XMMWORD PTR [rdi + 144], xmm1
    movdqu XMMWORD PTR [rdi + 160], xmm2
    movdqu XMMWORD PTR [rdi + 176], xmm3
    movdqu xmm0, XMMWORD PTR [rsi + 192]
    movdqu xmm1, XMMWORD PTR [rsi + 208]
    movdqu xmm2, XMMWORD PTR [rsi + 224]
    movdqu xmm3, XMMWORD PTR [rsi + 240]
    palignr xmm8, xmm8, 9
    palignr xmm9, xmm9, 2
    palignr xmm10, xmm10, 9
    palignr xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk256_aesni_b3_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk256_aesni_b3_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk256_aesni_b3_init_done
    palignr xmm8, xmm8, 10
    palignr xmm9, xmm9, 4
    palignr xmm10, xmm10, 10
    palignr xmm11, xmm11, 4
v512_dec_4blk256_aesni_b3_init_done:
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk256_aesni_b3_step4
    cmp rcx, 12
    je v512_dec_4blk256_aesni_b3_step5
    cmp rcx, 14
    je v512_dec_4blk256_aesni_b3_step6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk256_aesni_b3_step6:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk256_aesni_b3_step5:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk256_aesni_b3_step4:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    aesdeclast xmm0, xmm8
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi + 192], xmm0
    movdqu XMMWORD PTR [rdi + 208], xmm1
    movdqu XMMWORD PTR [rdi + 224], xmm2
    movdqu XMMWORD PTR [rdi + 240], xmm3
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm14, xmm14
    pxor xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    movdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    movdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    movdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah512Decrypt4Blocks256AesNiAsm ENDP

PUBLIC vistrutah512Encrypt4Blocks256VexAsm
ALIGN 16
vistrutah512Encrypt4Blocks256VexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm4, XMMWORD PTR [rdx]
    vmovdqu xmm5, XMMWORD PTR [rdx + 16]
    vmovdqu xmm13, XMMWORD PTR [vistrutahConsts + 192]
    vmovdqu xmm14, XMMWORD PTR [vistrutahConsts + 224]
    vpshufb xmm6, xmm4, xmm13
    vpshufb xmm15, xmm5, xmm14
    vpxor xmm6, xmm6, xmm15
    vpshufb xmm7, xmm5, xmm13
    vpshufb xmm15, xmm4, xmm14
    vpxor xmm7, xmm7, xmm15
    vpxor xmm12, xmm12, xmm12
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vmovdqa xmm8, xmm5
    vmovdqa xmm9, xmm4
    vmovdqa xmm10, xmm7
    vmovdqa xmm11, xmm6
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_4blk256_vex_b0_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 12
    je v512_4blk256_vex_b0_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 14
    je v512_4blk256_vex_b0_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
v512_4blk256_vex_b0_final:
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vaesenclast xmm0, xmm0, xmm8
    vaesenclast xmm1, xmm1, xmm9
    vaesenclast xmm2, xmm2, xmm10
    vaesenclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vmovdqu xmm0, XMMWORD PTR [rsi + 64]
    vmovdqu xmm1, XMMWORD PTR [rsi + 80]
    vmovdqu xmm2, XMMWORD PTR [rsi + 96]
    vmovdqu xmm3, XMMWORD PTR [rsi + 112]
    vmovdqa xmm8, xmm5
    vmovdqa xmm9, xmm4
    vmovdqa xmm10, xmm7
    vmovdqa xmm11, xmm6
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_4blk256_vex_b1_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 12
    je v512_4blk256_vex_b1_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 14
    je v512_4blk256_vex_b1_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
v512_4blk256_vex_b1_final:
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vaesenclast xmm0, xmm0, xmm8
    vaesenclast xmm1, xmm1, xmm9
    vaesenclast xmm2, xmm2, xmm10
    vaesenclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi + 64], xmm0
    vmovdqu XMMWORD PTR [rdi + 80], xmm1
    vmovdqu XMMWORD PTR [rdi + 96], xmm2
    vmovdqu XMMWORD PTR [rdi + 112], xmm3
    vmovdqu xmm0, XMMWORD PTR [rsi + 128]
    vmovdqu xmm1, XMMWORD PTR [rsi + 144]
    vmovdqu xmm2, XMMWORD PTR [rsi + 160]
    vmovdqu xmm3, XMMWORD PTR [rsi + 176]
    vmovdqa xmm8, xmm5
    vmovdqa xmm9, xmm4
    vmovdqa xmm10, xmm7
    vmovdqa xmm11, xmm6
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_4blk256_vex_b2_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 12
    je v512_4blk256_vex_b2_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 14
    je v512_4blk256_vex_b2_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
v512_4blk256_vex_b2_final:
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vaesenclast xmm0, xmm0, xmm8
    vaesenclast xmm1, xmm1, xmm9
    vaesenclast xmm2, xmm2, xmm10
    vaesenclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi + 128], xmm0
    vmovdqu XMMWORD PTR [rdi + 144], xmm1
    vmovdqu XMMWORD PTR [rdi + 160], xmm2
    vmovdqu XMMWORD PTR [rdi + 176], xmm3
    vmovdqu xmm0, XMMWORD PTR [rsi + 192]
    vmovdqu xmm1, XMMWORD PTR [rsi + 208]
    vmovdqu xmm2, XMMWORD PTR [rsi + 224]
    vmovdqu xmm3, XMMWORD PTR [rsi + 240]
    vmovdqa xmm8, xmm5
    vmovdqa xmm9, xmm4
    vmovdqa xmm10, xmm7
    vmovdqa xmm11, xmm6
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_4blk256_vex_b3_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 12
    je v512_4blk256_vex_b3_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 14
    je v512_4blk256_vex_b3_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
v512_4blk256_vex_b3_final:
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vaesenclast xmm0, xmm0, xmm8
    vaesenclast xmm1, xmm1, xmm9
    vaesenclast xmm2, xmm2, xmm10
    vaesenclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi + 192], xmm0
    vmovdqu XMMWORD PTR [rdi + 208], xmm1
    vmovdqu XMMWORD PTR [rdi + 224], xmm2
    vmovdqu XMMWORD PTR [rdi + 240], xmm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah512Encrypt4Blocks256VexAsm ENDP

PUBLIC vistrutah512Decrypt4Blocks256VexAsm
ALIGN 16
vistrutah512Decrypt4Blocks256VexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm4, XMMWORD PTR [rdx]
    vmovdqu xmm5, XMMWORD PTR [rdx + 16]
    vmovdqu xmm13, XMMWORD PTR [vistrutahConsts + 192]
    vmovdqu xmm14, XMMWORD PTR [vistrutahConsts + 224]
    vpshufb xmm6, xmm4, xmm13
    vpshufb xmm15, xmm5, xmm14
    vpxor xmm6, xmm6, xmm15
    vpshufb xmm7, xmm5, xmm13
    vpshufb xmm15, xmm4, xmm14
    vpxor xmm7, xmm7, xmm15
    vmovdqa xmm8, xmm5
    vmovdqa xmm9, xmm4
    vmovdqa xmm10, xmm7
    vmovdqa xmm11, xmm6
    vaesimc xmm4, xmm4
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vmovdqu xmm12, XMMWORD PTR [vistrutahConsts + 576]
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vpalignr xmm8, xmm8, xmm8, 9
    vpalignr xmm9, xmm9, xmm9, 2
    vpalignr xmm10, xmm10, xmm10, 9
    vpalignr xmm11, xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk256_vex_b0_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk256_vex_b0_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk256_vex_b0_init_done
    vpalignr xmm8, xmm8, xmm8, 10
    vpalignr xmm9, xmm9, xmm9, 4
    vpalignr xmm10, xmm10, xmm10, 10
    vpalignr xmm11, xmm11, xmm11, 4
v512_dec_4blk256_vex_b0_init_done:
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk256_vex_b0_step4
    cmp rcx, 12
    je v512_dec_4blk256_vex_b0_step5
    cmp rcx, 14
    je v512_dec_4blk256_vex_b0_step6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk256_vex_b0_step6:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk256_vex_b0_step5:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk256_vex_b0_step4:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vaesdeclast xmm0, xmm0, xmm8
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vmovdqu xmm0, XMMWORD PTR [rsi + 64]
    vmovdqu xmm1, XMMWORD PTR [rsi + 80]
    vmovdqu xmm2, XMMWORD PTR [rsi + 96]
    vmovdqu xmm3, XMMWORD PTR [rsi + 112]
    vpalignr xmm8, xmm8, xmm8, 9
    vpalignr xmm9, xmm9, xmm9, 2
    vpalignr xmm10, xmm10, xmm10, 9
    vpalignr xmm11, xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk256_vex_b1_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk256_vex_b1_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk256_vex_b1_init_done
    vpalignr xmm8, xmm8, xmm8, 10
    vpalignr xmm9, xmm9, xmm9, 4
    vpalignr xmm10, xmm10, xmm10, 10
    vpalignr xmm11, xmm11, xmm11, 4
v512_dec_4blk256_vex_b1_init_done:
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk256_vex_b1_step4
    cmp rcx, 12
    je v512_dec_4blk256_vex_b1_step5
    cmp rcx, 14
    je v512_dec_4blk256_vex_b1_step6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk256_vex_b1_step6:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk256_vex_b1_step5:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk256_vex_b1_step4:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vaesdeclast xmm0, xmm0, xmm8
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi + 64], xmm0
    vmovdqu XMMWORD PTR [rdi + 80], xmm1
    vmovdqu XMMWORD PTR [rdi + 96], xmm2
    vmovdqu XMMWORD PTR [rdi + 112], xmm3
    vmovdqu xmm0, XMMWORD PTR [rsi + 128]
    vmovdqu xmm1, XMMWORD PTR [rsi + 144]
    vmovdqu xmm2, XMMWORD PTR [rsi + 160]
    vmovdqu xmm3, XMMWORD PTR [rsi + 176]
    vpalignr xmm8, xmm8, xmm8, 9
    vpalignr xmm9, xmm9, xmm9, 2
    vpalignr xmm10, xmm10, xmm10, 9
    vpalignr xmm11, xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk256_vex_b2_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk256_vex_b2_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk256_vex_b2_init_done
    vpalignr xmm8, xmm8, xmm8, 10
    vpalignr xmm9, xmm9, xmm9, 4
    vpalignr xmm10, xmm10, xmm10, 10
    vpalignr xmm11, xmm11, xmm11, 4
v512_dec_4blk256_vex_b2_init_done:
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk256_vex_b2_step4
    cmp rcx, 12
    je v512_dec_4blk256_vex_b2_step5
    cmp rcx, 14
    je v512_dec_4blk256_vex_b2_step6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk256_vex_b2_step6:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk256_vex_b2_step5:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk256_vex_b2_step4:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vaesdeclast xmm0, xmm0, xmm8
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi + 128], xmm0
    vmovdqu XMMWORD PTR [rdi + 144], xmm1
    vmovdqu XMMWORD PTR [rdi + 160], xmm2
    vmovdqu XMMWORD PTR [rdi + 176], xmm3
    vmovdqu xmm0, XMMWORD PTR [rsi + 192]
    vmovdqu xmm1, XMMWORD PTR [rsi + 208]
    vmovdqu xmm2, XMMWORD PTR [rsi + 224]
    vmovdqu xmm3, XMMWORD PTR [rsi + 240]
    vpalignr xmm8, xmm8, xmm8, 9
    vpalignr xmm9, xmm9, xmm9, 2
    vpalignr xmm10, xmm10, xmm10, 9
    vpalignr xmm11, xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk256_vex_b3_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk256_vex_b3_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk256_vex_b3_init_done
    vpalignr xmm8, xmm8, xmm8, 10
    vpalignr xmm9, xmm9, xmm9, 4
    vpalignr xmm10, xmm10, xmm10, 10
    vpalignr xmm11, xmm11, xmm11, 4
v512_dec_4blk256_vex_b3_init_done:
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk256_vex_b3_step4
    cmp rcx, 12
    je v512_dec_4blk256_vex_b3_step5
    cmp rcx, 14
    je v512_dec_4blk256_vex_b3_step6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk256_vex_b3_step6:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk256_vex_b3_step5:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk256_vex_b3_step4:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vaesdeclast xmm0, xmm0, xmm8
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi + 192], xmm0
    vmovdqu XMMWORD PTR [rdi + 208], xmm1
    vmovdqu XMMWORD PTR [rdi + 224], xmm2
    vmovdqu XMMWORD PTR [rdi + 240], xmm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah512Decrypt4Blocks256VexAsm ENDP

PUBLIC vistrutah512Encrypt4Blocks256YmmAsm
ALIGN 16
vistrutah512Encrypt4Blocks256YmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vinserti128 ymm0, ymm0, XMMWORD PTR [rsi + 64], 1
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vinserti128 ymm1, ymm1, XMMWORD PTR [rsi + 80], 1
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vinserti128 ymm2, ymm2, XMMWORD PTR [rsi + 96], 1
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vinserti128 ymm3, ymm3, XMMWORD PTR [rsi + 112], 1
    vmovdqu xmm4, XMMWORD PTR [rsi + 128]
    vinserti128 ymm4, ymm4, XMMWORD PTR [rsi + 192], 1
    vmovdqu xmm5, XMMWORD PTR [rsi + 144]
    vinserti128 ymm5, ymm5, XMMWORD PTR [rsi + 208], 1
    vmovdqu xmm6, XMMWORD PTR [rsi + 160]
    vinserti128 ymm6, ymm6, XMMWORD PTR [rsi + 224], 1
    vmovdqu xmm7, XMMWORD PTR [rsi + 176]
    vinserti128 ymm7, ymm7, XMMWORD PTR [rsi + 240], 1
    vmovdqu ymm8, YMMWORD PTR [rdx]
    vperm2i128 ymm10, ymm8, ymm8, 1
    vpshufb ymm9, ymm8, YMMWORD PTR [vistrutahConsts + 192]
    vpshufb ymm13, ymm10, YMMWORD PTR [vistrutahConsts + 224]
    vpxor ymm9, ymm9, ymm13
    vperm2i128 ymm11, ymm9, ymm9, 1
    vpxor xmm12, xmm12, xmm12
    vperm2i128 ymm13, ymm10, ymm10, 0
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    cmp rcx, 10
    je v512_4blk256_ymm_final
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    cmp rcx, 12
    je v512_4blk256_ymm_final
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    cmp rcx, 14
    je v512_4blk256_ymm_final
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
v512_4blk256_ymm_final:
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesenclast ymm0, ymm0, ymm13
    vaesenclast ymm4, ymm4, ymm13
    vaesenclast ymm1, ymm1, ymm14
    vaesenclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesenclast ymm2, ymm2, ymm13
    vaesenclast ymm6, ymm6, ymm13
    vaesenclast ymm3, ymm3, ymm14
    vaesenclast ymm7, ymm7, ymm14
    vmovdqu XMMWORD PTR [rdi], xmm0
    vextracti128 XMMWORD PTR [rdi + 64], ymm0, 1
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vextracti128 XMMWORD PTR [rdi + 80], ymm1, 1
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vextracti128 XMMWORD PTR [rdi + 96], ymm2, 1
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vextracti128 XMMWORD PTR [rdi + 112], ymm3, 1
    vmovdqu XMMWORD PTR [rdi + 128], xmm4
    vextracti128 XMMWORD PTR [rdi + 192], ymm4, 1
    vmovdqu XMMWORD PTR [rdi + 144], xmm5
    vextracti128 XMMWORD PTR [rdi + 208], ymm5, 1
    vmovdqu XMMWORD PTR [rdi + 160], xmm6
    vextracti128 XMMWORD PTR [rdi + 224], ymm6, 1
    vmovdqu XMMWORD PTR [rdi + 176], xmm7
    vextracti128 XMMWORD PTR [rdi + 240], ymm7, 1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    vzeroupper
    ret
vistrutah512Encrypt4Blocks256YmmAsm ENDP

PUBLIC vistrutah512Decrypt4Blocks256YmmAsm
ALIGN 16
vistrutah512Decrypt4Blocks256YmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vinserti128 ymm0, ymm0, XMMWORD PTR [rsi + 64], 1
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vinserti128 ymm1, ymm1, XMMWORD PTR [rsi + 80], 1
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vinserti128 ymm2, ymm2, XMMWORD PTR [rsi + 96], 1
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vinserti128 ymm3, ymm3, XMMWORD PTR [rsi + 112], 1
    vmovdqu xmm4, XMMWORD PTR [rsi + 128]
    vinserti128 ymm4, ymm4, XMMWORD PTR [rsi + 192], 1
    vmovdqu xmm5, XMMWORD PTR [rsi + 144]
    vinserti128 ymm5, ymm5, XMMWORD PTR [rsi + 208], 1
    vmovdqu xmm6, XMMWORD PTR [rsi + 160]
    vinserti128 ymm6, ymm6, XMMWORD PTR [rsi + 224], 1
    vmovdqu xmm7, XMMWORD PTR [rsi + 176]
    vinserti128 ymm7, ymm7, XMMWORD PTR [rsi + 240], 1
    vmovdqu ymm8, YMMWORD PTR [rdx]
    vperm2i128 ymm10, ymm8, ymm8, 1
    vpshufb ymm9, ymm8, YMMWORD PTR [vistrutahConsts + 192]
    vpshufb ymm13, ymm10, YMMWORD PTR [vistrutahConsts + 224]
    vpxor ymm9, ymm9, ymm13
    vperm2i128 ymm11, ymm9, ymm9, 1
    vpxor xmm12, xmm12, xmm12
    vaesenclast ymm8, ymm8, ymm12
    vaesdec ymm8, ymm8, ymm12
    vaesenclast ymm9, ymm9, ymm12
    vaesdec ymm9, ymm9, ymm12
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 512]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    cmp rcx, 10
    je v512_dec_4blk256_ymm_init_done
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    cmp rcx, 12
    je v512_dec_4blk256_ymm_init_done
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    cmp rcx, 14
    je v512_dec_4blk256_ymm_init_done
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
v512_dec_4blk256_ymm_init_done:
    vperm2i128 ymm13, ymm10, ymm10, 0
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    cmp rcx, 10
    je v512_dec_4blk256_ymm_step4
    cmp rcx, 12
    je v512_dec_4blk256_ymm_step5
    cmp rcx, 14
    je v512_dec_4blk256_ymm_step6
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
v512_dec_4blk256_ymm_step6:
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
v512_dec_4blk256_ymm_step5:
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
v512_dec_4blk256_ymm_step4:
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu XMMWORD PTR [rdi], xmm0
    vextracti128 XMMWORD PTR [rdi + 64], ymm0, 1
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vextracti128 XMMWORD PTR [rdi + 80], ymm1, 1
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vextracti128 XMMWORD PTR [rdi + 96], ymm2, 1
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vextracti128 XMMWORD PTR [rdi + 112], ymm3, 1
    vmovdqu XMMWORD PTR [rdi + 128], xmm4
    vextracti128 XMMWORD PTR [rdi + 192], ymm4, 1
    vmovdqu XMMWORD PTR [rdi + 144], xmm5
    vextracti128 XMMWORD PTR [rdi + 208], ymm5, 1
    vmovdqu XMMWORD PTR [rdi + 160], xmm6
    vextracti128 XMMWORD PTR [rdi + 224], ymm6, 1
    vmovdqu XMMWORD PTR [rdi + 176], xmm7
    vextracti128 XMMWORD PTR [rdi + 240], ymm7, 1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    vzeroupper
    ret
vistrutah512Decrypt4Blocks256YmmAsm ENDP

PUBLIC vistrutah512Encrypt4Blocks256ZmmAsm
ALIGN 16
vistrutah512Encrypt4Blocks256ZmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 64], 1
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 128], 2
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 192], 3
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 80], 1
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 144], 2
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 208], 3
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vinserti32x4 zmm2, zmm2, XMMWORD PTR [rsi + 96], 1
    vinserti32x4 zmm2, zmm2, XMMWORD PTR [rsi + 160], 2
    vinserti32x4 zmm2, zmm2, XMMWORD PTR [rsi + 224], 3
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vinserti32x4 zmm3, zmm3, XMMWORD PTR [rsi + 112], 1
    vinserti32x4 zmm3, zmm3, XMMWORD PTR [rsi + 176], 2
    vinserti32x4 zmm3, zmm3, XMMWORD PTR [rsi + 240], 3
    vmovdqu ymm4, YMMWORD PTR [rdx]
    vperm2i128 ymm12, ymm4, ymm4, 1
    vpshufb ymm13, ymm4, YMMWORD PTR [vistrutahConsts + 192]
    vpshufb ymm14, ymm12, YMMWORD PTR [vistrutahConsts + 224]
    vpxor ymm13, ymm13, ymm14
    vshufi32x4 zmm4, zmm4, zmm13, 68
    vshufi32x4 zmm8, zmm4, zmm4, 0
    vshufi32x4 zmm9, zmm4, zmm4, 85
    vshufi32x4 zmm10, zmm4, zmm4, 170
    vshufi32x4 zmm11, zmm4, zmm4, 255
    vshufi32x4 zmm5, zmm4, zmm4, 177
    vmovdqu64 zmm6, ZMMWORD PTR [vistrutahConsts + 128]
    vpxord xmm7, xmm7, xmm7
    vpxorq zmm0, zmm0, zmm9
    vpxorq zmm1, zmm1, zmm8
    vpxorq zmm2, zmm2, zmm11
    vpxorq zmm3, zmm3, zmm10
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
    cmp rcx, 10
    je v512_4blk256_zmm_final
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
    cmp rcx, 12
    je v512_4blk256_zmm_final
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
    cmp rcx, 14
    je v512_4blk256_zmm_final
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
v512_4blk256_zmm_final:
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesenclast zmm0, zmm0, zmm12
    vaesenclast zmm1, zmm1, zmm13
    vaesenclast zmm2, zmm2, zmm14
    vaesenclast zmm3, zmm3, zmm15
    vmovdqu XMMWORD PTR [rdi], xmm0
    vextracti32x4 XMMWORD PTR [rdi + 64], zmm0, 1
    vextracti32x4 XMMWORD PTR [rdi + 128], zmm0, 2
    vextracti32x4 XMMWORD PTR [rdi + 192], zmm0, 3
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vextracti32x4 XMMWORD PTR [rdi + 80], zmm1, 1
    vextracti32x4 XMMWORD PTR [rdi + 144], zmm1, 2
    vextracti32x4 XMMWORD PTR [rdi + 208], zmm1, 3
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vextracti32x4 XMMWORD PTR [rdi + 96], zmm2, 1
    vextracti32x4 XMMWORD PTR [rdi + 160], zmm2, 2
    vextracti32x4 XMMWORD PTR [rdi + 224], zmm2, 3
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vextracti32x4 XMMWORD PTR [rdi + 112], zmm3, 1
    vextracti32x4 XMMWORD PTR [rdi + 176], zmm3, 2
    vextracti32x4 XMMWORD PTR [rdi + 240], zmm3, 3
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm4, xmm4, xmm4
    vpxord xmm5, xmm5, xmm5
    vpxord xmm6, xmm6, xmm6
    vpxord xmm7, xmm7, xmm7
    vpxord xmm8, xmm8, xmm8
    vpxord xmm9, xmm9, xmm9
    vpxord xmm10, xmm10, xmm10
    vpxord xmm11, xmm11, xmm11
    vpxord xmm12, xmm12, xmm12
    vpxord xmm13, xmm13, xmm13
    vpxord xmm14, xmm14, xmm14
    vpxord xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    vzeroupper
    ret
vistrutah512Encrypt4Blocks256ZmmAsm ENDP

PUBLIC vistrutah512Decrypt4Blocks256ZmmAsm
ALIGN 16
vistrutah512Decrypt4Blocks256ZmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 64], 1
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 128], 2
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 192], 3
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 80], 1
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 144], 2
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 208], 3
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vinserti32x4 zmm2, zmm2, XMMWORD PTR [rsi + 96], 1
    vinserti32x4 zmm2, zmm2, XMMWORD PTR [rsi + 160], 2
    vinserti32x4 zmm2, zmm2, XMMWORD PTR [rsi + 224], 3
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vinserti32x4 zmm3, zmm3, XMMWORD PTR [rsi + 112], 1
    vinserti32x4 zmm3, zmm3, XMMWORD PTR [rsi + 176], 2
    vinserti32x4 zmm3, zmm3, XMMWORD PTR [rsi + 240], 3
    vmovdqu ymm4, YMMWORD PTR [rdx]
    vperm2i128 ymm12, ymm4, ymm4, 1
    vpshufb ymm13, ymm4, YMMWORD PTR [vistrutahConsts + 192]
    vpshufb ymm14, ymm12, YMMWORD PTR [vistrutahConsts + 224]
    vpxor ymm13, ymm13, ymm14
    vshufi32x4 zmm4, zmm4, zmm13, 68
    vshufi32x4 zmm5, zmm4, zmm4, 177
    vpxord xmm7, xmm7, xmm7
    vaesenclast zmm4, zmm4, zmm7
    vaesdec zmm4, zmm4, zmm7
    vshufi32x4 zmm8, zmm4, zmm4, 0
    vshufi32x4 zmm9, zmm4, zmm4, 85
    vshufi32x4 zmm10, zmm4, zmm4, 170
    vshufi32x4 zmm11, zmm4, zmm4, 255
    vmovdqu64 zmm6, ZMMWORD PTR [vistrutahConsts + 512]
    vpshufb zmm5, zmm5, zmm6
    cmp rcx, 10
    je v512_dec_4blk256_zmm_init_done
    vmovdqu64 zmm6, ZMMWORD PTR [vistrutahConsts + 128]
    vpshufb zmm5, zmm5, zmm6
    cmp rcx, 12
    je v512_dec_4blk256_zmm_init_done
    vpshufb zmm5, zmm5, zmm6
    cmp rcx, 14
    je v512_dec_4blk256_zmm_init_done
    vpshufb zmm5, zmm5, zmm6
    vpshufb zmm5, zmm5, zmm6
v512_dec_4blk256_zmm_init_done:
    vmovdqu64 zmm4, ZMMWORD PTR [vistrutahConsts + 576]
    vmovdqu64 zmm6, ZMMWORD PTR [vistrutahConsts + 448]
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vpxorq zmm0, zmm0, zmm12
    vpxorq zmm1, zmm1, zmm13
    vpxorq zmm2, zmm2, zmm14
    vpxorq zmm3, zmm3, zmm15
    cmp rcx, 10
    je v512_dec_4blk256_zmm_step4
    cmp rcx, 12
    je v512_dec_4blk256_zmm_step5
    cmp rcx, 14
    je v512_dec_4blk256_zmm_step6
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
v512_dec_4blk256_zmm_step6:
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
v512_dec_4blk256_zmm_step5:
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
v512_dec_4blk256_zmm_step4:
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vmovdqu XMMWORD PTR [rdi], xmm0
    vextracti32x4 XMMWORD PTR [rdi + 64], zmm0, 1
    vextracti32x4 XMMWORD PTR [rdi + 128], zmm0, 2
    vextracti32x4 XMMWORD PTR [rdi + 192], zmm0, 3
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vextracti32x4 XMMWORD PTR [rdi + 80], zmm1, 1
    vextracti32x4 XMMWORD PTR [rdi + 144], zmm1, 2
    vextracti32x4 XMMWORD PTR [rdi + 208], zmm1, 3
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vextracti32x4 XMMWORD PTR [rdi + 96], zmm2, 1
    vextracti32x4 XMMWORD PTR [rdi + 160], zmm2, 2
    vextracti32x4 XMMWORD PTR [rdi + 224], zmm2, 3
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vextracti32x4 XMMWORD PTR [rdi + 112], zmm3, 1
    vextracti32x4 XMMWORD PTR [rdi + 176], zmm3, 2
    vextracti32x4 XMMWORD PTR [rdi + 240], zmm3, 3
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm4, xmm4, xmm4
    vpxord xmm5, xmm5, xmm5
    vpxord xmm6, xmm6, xmm6
    vpxord xmm7, xmm7, xmm7
    vpxord xmm8, xmm8, xmm8
    vpxord xmm9, xmm9, xmm9
    vpxord xmm10, xmm10, xmm10
    vpxord xmm11, xmm11, xmm11
    vpxord xmm12, xmm12, xmm12
    vpxord xmm13, xmm13, xmm13
    vpxord xmm14, xmm14, xmm14
    vpxord xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    vzeroupper
    ret
vistrutah512Decrypt4Blocks256ZmmAsm ENDP

PUBLIC vistrutah512Encrypt4Blocks512AesNiAsm
ALIGN 16
vistrutah512Encrypt4Blocks512AesNiAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 168
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    movdqu XMMWORD PTR [rsp + 64], xmm9
    movdqu XMMWORD PTR [rsp + 80], xmm10
    movdqu XMMWORD PTR [rsp + 96], xmm11
    movdqu XMMWORD PTR [rsp + 112], xmm12
    movdqu XMMWORD PTR [rsp + 128], xmm13
    movdqu XMMWORD PTR [rsp + 144], xmm14
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    movdqu xmm4, XMMWORD PTR [rdx]
    movdqu xmm5, XMMWORD PTR [rdx + 16]
    movdqu xmm6, XMMWORD PTR [rdx + 32]
    movdqu xmm7, XMMWORD PTR [rdx + 48]
    pxor xmm12, xmm12
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    movdqu xmm2, XMMWORD PTR [rsi + 32]
    movdqu xmm3, XMMWORD PTR [rsi + 48]
    movdqa xmm8, xmm5
    movdqa xmm9, xmm4
    movdqa xmm10, xmm7
    movdqa xmm11, xmm6
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_4blk512_aesni_b0_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 12
    je v512_4blk512_aesni_b0_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 14
    je v512_4blk512_aesni_b0_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
v512_4blk512_aesni_b0_final:
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    aesenclast xmm0, xmm8
    aesenclast xmm1, xmm9
    aesenclast xmm2, xmm10
    aesenclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi], xmm0
    movdqu XMMWORD PTR [rdi + 16], xmm1
    movdqu XMMWORD PTR [rdi + 32], xmm2
    movdqu XMMWORD PTR [rdi + 48], xmm3
    movdqu xmm0, XMMWORD PTR [rsi + 64]
    movdqu xmm1, XMMWORD PTR [rsi + 80]
    movdqu xmm2, XMMWORD PTR [rsi + 96]
    movdqu xmm3, XMMWORD PTR [rsi + 112]
    movdqa xmm8, xmm5
    movdqa xmm9, xmm4
    movdqa xmm10, xmm7
    movdqa xmm11, xmm6
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_4blk512_aesni_b1_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 12
    je v512_4blk512_aesni_b1_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 14
    je v512_4blk512_aesni_b1_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
v512_4blk512_aesni_b1_final:
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    aesenclast xmm0, xmm8
    aesenclast xmm1, xmm9
    aesenclast xmm2, xmm10
    aesenclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi + 64], xmm0
    movdqu XMMWORD PTR [rdi + 80], xmm1
    movdqu XMMWORD PTR [rdi + 96], xmm2
    movdqu XMMWORD PTR [rdi + 112], xmm3
    movdqu xmm0, XMMWORD PTR [rsi + 128]
    movdqu xmm1, XMMWORD PTR [rsi + 144]
    movdqu xmm2, XMMWORD PTR [rsi + 160]
    movdqu xmm3, XMMWORD PTR [rsi + 176]
    movdqa xmm8, xmm5
    movdqa xmm9, xmm4
    movdqa xmm10, xmm7
    movdqa xmm11, xmm6
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_4blk512_aesni_b2_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 12
    je v512_4blk512_aesni_b2_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 14
    je v512_4blk512_aesni_b2_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
v512_4blk512_aesni_b2_final:
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    aesenclast xmm0, xmm8
    aesenclast xmm1, xmm9
    aesenclast xmm2, xmm10
    aesenclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi + 128], xmm0
    movdqu XMMWORD PTR [rdi + 144], xmm1
    movdqu XMMWORD PTR [rdi + 160], xmm2
    movdqu XMMWORD PTR [rdi + 176], xmm3
    movdqu xmm0, XMMWORD PTR [rsi + 192]
    movdqu xmm1, XMMWORD PTR [rsi + 208]
    movdqu xmm2, XMMWORD PTR [rsi + 224]
    movdqu xmm3, XMMWORD PTR [rsi + 240]
    movdqa xmm8, xmm5
    movdqa xmm9, xmm4
    movdqa xmm10, xmm7
    movdqa xmm11, xmm6
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_4blk512_aesni_b3_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 12
    je v512_4blk512_aesni_b3_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 14
    je v512_4blk512_aesni_b3_final
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    aesenc xmm0, xmm12
    aesenc xmm1, xmm12
    aesenc xmm2, xmm12
    aesenc xmm3, xmm12
    movdqa xmm13, xmm0
    punpcklbw xmm13, xmm2
    punpckhbw xmm0, xmm2
    movdqa xmm14, xmm1
    punpcklbw xmm14, xmm3
    punpckhbw xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklbw xmm13, xmm14
    punpckhbw xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm0
    movdqa xmm0, xmm13
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm0, xmm8
    pxor xmm0, xmm13
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
v512_4blk512_aesni_b3_final:
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    aesenclast xmm0, xmm8
    aesenclast xmm1, xmm9
    aesenclast xmm2, xmm10
    aesenclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi + 192], xmm0
    movdqu XMMWORD PTR [rdi + 208], xmm1
    movdqu XMMWORD PTR [rdi + 224], xmm2
    movdqu XMMWORD PTR [rdi + 240], xmm3
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm14, xmm14
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    movdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    movdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 168
    ret
vistrutah512Encrypt4Blocks512AesNiAsm ENDP

PUBLIC vistrutah512Decrypt4Blocks512AesNiAsm
ALIGN 16
vistrutah512Decrypt4Blocks512AesNiAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 168
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    movdqu XMMWORD PTR [rsp + 64], xmm9
    movdqu XMMWORD PTR [rsp + 80], xmm10
    movdqu XMMWORD PTR [rsp + 96], xmm11
    movdqu XMMWORD PTR [rsp + 112], xmm12
    movdqu XMMWORD PTR [rsp + 128], xmm13
    movdqu XMMWORD PTR [rsp + 144], xmm14
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    movdqu xmm4, XMMWORD PTR [rdx]
    movdqu xmm5, XMMWORD PTR [rdx + 16]
    movdqu xmm6, XMMWORD PTR [rdx + 32]
    movdqu xmm7, XMMWORD PTR [rdx + 48]
    movdqa xmm8, xmm5
    movdqa xmm9, xmm4
    movdqa xmm10, xmm7
    movdqa xmm11, xmm6
    aesimc xmm4, xmm4
    aesimc xmm5, xmm5
    aesimc xmm6, xmm6
    aesimc xmm7, xmm7
    movdqu xmm12, XMMWORD PTR [vistrutahConsts + 576]
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    movdqu xmm2, XMMWORD PTR [rsi + 32]
    movdqu xmm3, XMMWORD PTR [rsi + 48]
    palignr xmm8, xmm8, 9
    palignr xmm9, xmm9, 2
    palignr xmm10, xmm10, 9
    palignr xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk512_aesni_b0_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk512_aesni_b0_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk512_aesni_b0_init_done
    palignr xmm8, xmm8, 10
    palignr xmm9, xmm9, 4
    palignr xmm10, xmm10, 10
    palignr xmm11, xmm11, 4
v512_dec_4blk512_aesni_b0_init_done:
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk512_aesni_b0_step4
    cmp rcx, 12
    je v512_dec_4blk512_aesni_b0_step5
    cmp rcx, 14
    je v512_dec_4blk512_aesni_b0_step6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk512_aesni_b0_step6:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk512_aesni_b0_step5:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk512_aesni_b0_step4:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    aesdeclast xmm0, xmm8
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi], xmm0
    movdqu XMMWORD PTR [rdi + 16], xmm1
    movdqu XMMWORD PTR [rdi + 32], xmm2
    movdqu XMMWORD PTR [rdi + 48], xmm3
    movdqu xmm0, XMMWORD PTR [rsi + 64]
    movdqu xmm1, XMMWORD PTR [rsi + 80]
    movdqu xmm2, XMMWORD PTR [rsi + 96]
    movdqu xmm3, XMMWORD PTR [rsi + 112]
    palignr xmm8, xmm8, 9
    palignr xmm9, xmm9, 2
    palignr xmm10, xmm10, 9
    palignr xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk512_aesni_b1_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk512_aesni_b1_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk512_aesni_b1_init_done
    palignr xmm8, xmm8, 10
    palignr xmm9, xmm9, 4
    palignr xmm10, xmm10, 10
    palignr xmm11, xmm11, 4
v512_dec_4blk512_aesni_b1_init_done:
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk512_aesni_b1_step4
    cmp rcx, 12
    je v512_dec_4blk512_aesni_b1_step5
    cmp rcx, 14
    je v512_dec_4blk512_aesni_b1_step6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk512_aesni_b1_step6:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk512_aesni_b1_step5:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk512_aesni_b1_step4:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    aesdeclast xmm0, xmm8
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi + 64], xmm0
    movdqu XMMWORD PTR [rdi + 80], xmm1
    movdqu XMMWORD PTR [rdi + 96], xmm2
    movdqu XMMWORD PTR [rdi + 112], xmm3
    movdqu xmm0, XMMWORD PTR [rsi + 128]
    movdqu xmm1, XMMWORD PTR [rsi + 144]
    movdqu xmm2, XMMWORD PTR [rsi + 160]
    movdqu xmm3, XMMWORD PTR [rsi + 176]
    palignr xmm8, xmm8, 9
    palignr xmm9, xmm9, 2
    palignr xmm10, xmm10, 9
    palignr xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk512_aesni_b2_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk512_aesni_b2_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk512_aesni_b2_init_done
    palignr xmm8, xmm8, 10
    palignr xmm9, xmm9, 4
    palignr xmm10, xmm10, 10
    palignr xmm11, xmm11, 4
v512_dec_4blk512_aesni_b2_init_done:
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk512_aesni_b2_step4
    cmp rcx, 12
    je v512_dec_4blk512_aesni_b2_step5
    cmp rcx, 14
    je v512_dec_4blk512_aesni_b2_step6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk512_aesni_b2_step6:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk512_aesni_b2_step5:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk512_aesni_b2_step4:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    aesdeclast xmm0, xmm8
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi + 128], xmm0
    movdqu XMMWORD PTR [rdi + 144], xmm1
    movdqu XMMWORD PTR [rdi + 160], xmm2
    movdqu XMMWORD PTR [rdi + 176], xmm3
    movdqu xmm0, XMMWORD PTR [rsi + 192]
    movdqu xmm1, XMMWORD PTR [rsi + 208]
    movdqu xmm2, XMMWORD PTR [rsi + 224]
    movdqu xmm3, XMMWORD PTR [rsi + 240]
    palignr xmm8, xmm8, 9
    palignr xmm9, xmm9, 2
    palignr xmm10, xmm10, 9
    palignr xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk512_aesni_b3_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk512_aesni_b3_init_done
    palignr xmm8, xmm8, 5
    palignr xmm9, xmm9, 10
    palignr xmm10, xmm10, 5
    palignr xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk512_aesni_b3_init_done
    palignr xmm8, xmm8, 10
    palignr xmm9, xmm9, 4
    palignr xmm10, xmm10, 10
    palignr xmm11, xmm11, 4
v512_dec_4blk512_aesni_b3_init_done:
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk512_aesni_b3_step4
    cmp rcx, 12
    je v512_dec_4blk512_aesni_b3_step5
    cmp rcx, 14
    je v512_dec_4blk512_aesni_b3_step6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk512_aesni_b3_step6:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk512_aesni_b3_step5:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
v512_dec_4blk512_aesni_b3_step4:
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    movdqu xmm13, XMMWORD PTR [vistrutahRoundConstants]
    pxor xmm13, xmm8
    aesdeclast xmm0, xmm13
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    pshufb xmm0, xmm12
    pshufb xmm1, xmm12
    pshufb xmm2, xmm12
    pshufb xmm3, xmm12
    movdqa xmm13, xmm0
    punpckldq xmm13, xmm2
    punpckhdq xmm0, xmm2
    movdqa xmm14, xmm1
    punpckldq xmm14, xmm3
    punpckhdq xmm1, xmm3
    movdqa xmm2, xmm13
    punpcklqdq xmm13, xmm14
    punpckhqdq xmm2, xmm14
    movdqa xmm3, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm3, xmm1
    movdqa xmm1, xmm2
    movdqa xmm2, xmm0
    movdqa xmm0, xmm13
    aesimc xmm0, xmm0
    aesimc xmm1, xmm1
    aesimc xmm2, xmm2
    aesimc xmm3, xmm3
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesdec xmm2, xmm6
    aesdec xmm3, xmm7
    palignr xmm8, xmm8, 11
    palignr xmm9, xmm9, 6
    palignr xmm10, xmm10, 11
    palignr xmm11, xmm11, 6
    aesdeclast xmm0, xmm8
    aesdeclast xmm1, xmm9
    aesdeclast xmm2, xmm10
    aesdeclast xmm3, xmm11
    movdqu XMMWORD PTR [rdi + 192], xmm0
    movdqu XMMWORD PTR [rdi + 208], xmm1
    movdqu XMMWORD PTR [rdi + 224], xmm2
    movdqu XMMWORD PTR [rdi + 240], xmm3
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm14, xmm14
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    movdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    movdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 168
    ret
vistrutah512Decrypt4Blocks512AesNiAsm ENDP

PUBLIC vistrutah512Encrypt4Blocks512VexAsm
ALIGN 16
vistrutah512Encrypt4Blocks512VexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm4, XMMWORD PTR [rdx]
    vmovdqu xmm5, XMMWORD PTR [rdx + 16]
    vmovdqu xmm6, XMMWORD PTR [rdx + 32]
    vmovdqu xmm7, XMMWORD PTR [rdx + 48]
    vpxor xmm12, xmm12, xmm12
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vmovdqa xmm8, xmm5
    vmovdqa xmm9, xmm4
    vmovdqa xmm10, xmm7
    vmovdqa xmm11, xmm6
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_4blk512_vex_b0_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 12
    je v512_4blk512_vex_b0_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 14
    je v512_4blk512_vex_b0_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
v512_4blk512_vex_b0_final:
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vaesenclast xmm0, xmm0, xmm8
    vaesenclast xmm1, xmm1, xmm9
    vaesenclast xmm2, xmm2, xmm10
    vaesenclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vmovdqu xmm0, XMMWORD PTR [rsi + 64]
    vmovdqu xmm1, XMMWORD PTR [rsi + 80]
    vmovdqu xmm2, XMMWORD PTR [rsi + 96]
    vmovdqu xmm3, XMMWORD PTR [rsi + 112]
    vmovdqa xmm8, xmm5
    vmovdqa xmm9, xmm4
    vmovdqa xmm10, xmm7
    vmovdqa xmm11, xmm6
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_4blk512_vex_b1_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 12
    je v512_4blk512_vex_b1_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 14
    je v512_4blk512_vex_b1_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
v512_4blk512_vex_b1_final:
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vaesenclast xmm0, xmm0, xmm8
    vaesenclast xmm1, xmm1, xmm9
    vaesenclast xmm2, xmm2, xmm10
    vaesenclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi + 64], xmm0
    vmovdqu XMMWORD PTR [rdi + 80], xmm1
    vmovdqu XMMWORD PTR [rdi + 96], xmm2
    vmovdqu XMMWORD PTR [rdi + 112], xmm3
    vmovdqu xmm0, XMMWORD PTR [rsi + 128]
    vmovdqu xmm1, XMMWORD PTR [rsi + 144]
    vmovdqu xmm2, XMMWORD PTR [rsi + 160]
    vmovdqu xmm3, XMMWORD PTR [rsi + 176]
    vmovdqa xmm8, xmm5
    vmovdqa xmm9, xmm4
    vmovdqa xmm10, xmm7
    vmovdqa xmm11, xmm6
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_4blk512_vex_b2_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 12
    je v512_4blk512_vex_b2_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 14
    je v512_4blk512_vex_b2_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
v512_4blk512_vex_b2_final:
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vaesenclast xmm0, xmm0, xmm8
    vaesenclast xmm1, xmm1, xmm9
    vaesenclast xmm2, xmm2, xmm10
    vaesenclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi + 128], xmm0
    vmovdqu XMMWORD PTR [rdi + 144], xmm1
    vmovdqu XMMWORD PTR [rdi + 160], xmm2
    vmovdqu XMMWORD PTR [rdi + 176], xmm3
    vmovdqu xmm0, XMMWORD PTR [rsi + 192]
    vmovdqu xmm1, XMMWORD PTR [rsi + 208]
    vmovdqu xmm2, XMMWORD PTR [rsi + 224]
    vmovdqu xmm3, XMMWORD PTR [rsi + 240]
    vmovdqa xmm8, xmm5
    vmovdqa xmm9, xmm4
    vmovdqa xmm10, xmm7
    vmovdqa xmm11, xmm6
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_4blk512_vex_b3_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 12
    je v512_4blk512_vex_b3_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 14
    je v512_4blk512_vex_b3_final
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm3, xmm3, xmm12
    vpunpcklbw xmm13, xmm0, xmm2
    vpunpckhbw xmm14, xmm0, xmm2
    vpunpcklbw xmm15, xmm1, xmm3
    vpunpckhbw xmm1, xmm1, xmm3
    vpunpcklbw xmm0, xmm13, xmm15
    vpunpckhbw xmm2, xmm13, xmm15
    vpunpckhbw xmm3, xmm14, xmm1
    vpunpcklbw xmm1, xmm14, xmm1
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor xmm0, xmm0, xmm13
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
v512_4blk512_vex_b3_final:
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm5
    vaesenc xmm2, xmm2, xmm6
    vaesenc xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    vaesenclast xmm0, xmm0, xmm8
    vaesenclast xmm1, xmm1, xmm9
    vaesenclast xmm2, xmm2, xmm10
    vaesenclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi + 192], xmm0
    vmovdqu XMMWORD PTR [rdi + 208], xmm1
    vmovdqu XMMWORD PTR [rdi + 224], xmm2
    vmovdqu XMMWORD PTR [rdi + 240], xmm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah512Encrypt4Blocks512VexAsm ENDP

PUBLIC vistrutah512Decrypt4Blocks512VexAsm
ALIGN 16
vistrutah512Decrypt4Blocks512VexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm4, XMMWORD PTR [rdx]
    vmovdqu xmm5, XMMWORD PTR [rdx + 16]
    vmovdqu xmm6, XMMWORD PTR [rdx + 32]
    vmovdqu xmm7, XMMWORD PTR [rdx + 48]
    vmovdqa xmm8, xmm5
    vmovdqa xmm9, xmm4
    vmovdqa xmm10, xmm7
    vmovdqa xmm11, xmm6
    vaesimc xmm4, xmm4
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vmovdqu xmm12, XMMWORD PTR [vistrutahConsts + 576]
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vpalignr xmm8, xmm8, xmm8, 9
    vpalignr xmm9, xmm9, xmm9, 2
    vpalignr xmm10, xmm10, xmm10, 9
    vpalignr xmm11, xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk512_vex_b0_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk512_vex_b0_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk512_vex_b0_init_done
    vpalignr xmm8, xmm8, xmm8, 10
    vpalignr xmm9, xmm9, xmm9, 4
    vpalignr xmm10, xmm10, xmm10, 10
    vpalignr xmm11, xmm11, xmm11, 4
v512_dec_4blk512_vex_b0_init_done:
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk512_vex_b0_step4
    cmp rcx, 12
    je v512_dec_4blk512_vex_b0_step5
    cmp rcx, 14
    je v512_dec_4blk512_vex_b0_step6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk512_vex_b0_step6:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk512_vex_b0_step5:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk512_vex_b0_step4:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vaesdeclast xmm0, xmm0, xmm8
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vmovdqu xmm0, XMMWORD PTR [rsi + 64]
    vmovdqu xmm1, XMMWORD PTR [rsi + 80]
    vmovdqu xmm2, XMMWORD PTR [rsi + 96]
    vmovdqu xmm3, XMMWORD PTR [rsi + 112]
    vpalignr xmm8, xmm8, xmm8, 9
    vpalignr xmm9, xmm9, xmm9, 2
    vpalignr xmm10, xmm10, xmm10, 9
    vpalignr xmm11, xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk512_vex_b1_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk512_vex_b1_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk512_vex_b1_init_done
    vpalignr xmm8, xmm8, xmm8, 10
    vpalignr xmm9, xmm9, xmm9, 4
    vpalignr xmm10, xmm10, xmm10, 10
    vpalignr xmm11, xmm11, xmm11, 4
v512_dec_4blk512_vex_b1_init_done:
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk512_vex_b1_step4
    cmp rcx, 12
    je v512_dec_4blk512_vex_b1_step5
    cmp rcx, 14
    je v512_dec_4blk512_vex_b1_step6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk512_vex_b1_step6:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk512_vex_b1_step5:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk512_vex_b1_step4:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vaesdeclast xmm0, xmm0, xmm8
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi + 64], xmm0
    vmovdqu XMMWORD PTR [rdi + 80], xmm1
    vmovdqu XMMWORD PTR [rdi + 96], xmm2
    vmovdqu XMMWORD PTR [rdi + 112], xmm3
    vmovdqu xmm0, XMMWORD PTR [rsi + 128]
    vmovdqu xmm1, XMMWORD PTR [rsi + 144]
    vmovdqu xmm2, XMMWORD PTR [rsi + 160]
    vmovdqu xmm3, XMMWORD PTR [rsi + 176]
    vpalignr xmm8, xmm8, xmm8, 9
    vpalignr xmm9, xmm9, xmm9, 2
    vpalignr xmm10, xmm10, xmm10, 9
    vpalignr xmm11, xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk512_vex_b2_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk512_vex_b2_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk512_vex_b2_init_done
    vpalignr xmm8, xmm8, xmm8, 10
    vpalignr xmm9, xmm9, xmm9, 4
    vpalignr xmm10, xmm10, xmm10, 10
    vpalignr xmm11, xmm11, xmm11, 4
v512_dec_4blk512_vex_b2_init_done:
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk512_vex_b2_step4
    cmp rcx, 12
    je v512_dec_4blk512_vex_b2_step5
    cmp rcx, 14
    je v512_dec_4blk512_vex_b2_step6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk512_vex_b2_step6:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk512_vex_b2_step5:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk512_vex_b2_step4:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vaesdeclast xmm0, xmm0, xmm8
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi + 128], xmm0
    vmovdqu XMMWORD PTR [rdi + 144], xmm1
    vmovdqu XMMWORD PTR [rdi + 160], xmm2
    vmovdqu XMMWORD PTR [rdi + 176], xmm3
    vmovdqu xmm0, XMMWORD PTR [rsi + 192]
    vmovdqu xmm1, XMMWORD PTR [rsi + 208]
    vmovdqu xmm2, XMMWORD PTR [rsi + 224]
    vmovdqu xmm3, XMMWORD PTR [rsi + 240]
    vpalignr xmm8, xmm8, xmm8, 9
    vpalignr xmm9, xmm9, xmm9, 2
    vpalignr xmm10, xmm10, xmm10, 9
    vpalignr xmm11, xmm11, xmm11, 2
    cmp rcx, 10
    je v512_dec_4blk512_vex_b3_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 12
    je v512_dec_4blk512_vex_b3_init_done
    vpalignr xmm8, xmm8, xmm8, 5
    vpalignr xmm9, xmm9, xmm9, 10
    vpalignr xmm10, xmm10, xmm10, 5
    vpalignr xmm11, xmm11, xmm11, 10
    cmp rcx, 14
    je v512_dec_4blk512_vex_b3_init_done
    vpalignr xmm8, xmm8, xmm8, 10
    vpalignr xmm9, xmm9, xmm9, 4
    vpalignr xmm10, xmm10, xmm10, 10
    vpalignr xmm11, xmm11, xmm11, 4
v512_dec_4blk512_vex_b3_init_done:
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    cmp rcx, 10
    je v512_dec_4blk512_vex_b3_step4
    cmp rcx, 12
    je v512_dec_4blk512_vex_b3_step5
    cmp rcx, 14
    je v512_dec_4blk512_vex_b3_step6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 112]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 96]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk512_vex_b3_step6:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 80]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk512_vex_b3_step5:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 64]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
v512_dec_4blk512_vex_b3_step4:
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 48]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 32]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants + 16]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vpxor xmm13, xmm8, XMMWORD PTR [vistrutahRoundConstants]
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vpshufb xmm0, xmm0, xmm12
    vpshufb xmm1, xmm1, xmm12
    vpshufb xmm2, xmm2, xmm12
    vpshufb xmm3, xmm3, xmm12
    vpunpckldq xmm13, xmm0, xmm2
    vpunpckhdq xmm14, xmm0, xmm2
    vpunpckldq xmm15, xmm1, xmm3
    vpunpckhdq xmm1, xmm1, xmm3
    vpunpcklqdq xmm0, xmm13, xmm15
    vpunpckhqdq xmm13, xmm13, xmm15
    vpunpcklqdq xmm2, xmm14, xmm1
    vpunpckhqdq xmm3, xmm14, xmm1
    vaesimc xmm0, xmm0
    vaesimc xmm1, xmm13
    vaesimc xmm2, xmm2
    vaesimc xmm3, xmm3
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesdec xmm2, xmm2, xmm6
    vaesdec xmm3, xmm3, xmm7
    vpalignr xmm8, xmm8, xmm8, 11
    vpalignr xmm9, xmm9, xmm9, 6
    vpalignr xmm10, xmm10, xmm10, 11
    vpalignr xmm11, xmm11, xmm11, 6
    vaesdeclast xmm0, xmm0, xmm8
    vaesdeclast xmm1, xmm1, xmm9
    vaesdeclast xmm2, xmm2, xmm10
    vaesdeclast xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi + 192], xmm0
    vmovdqu XMMWORD PTR [rdi + 208], xmm1
    vmovdqu XMMWORD PTR [rdi + 224], xmm2
    vmovdqu XMMWORD PTR [rdi + 240], xmm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    ret
vistrutah512Decrypt4Blocks512VexAsm ENDP

PUBLIC vistrutah512Encrypt4Blocks512YmmAsm
ALIGN 16
vistrutah512Encrypt4Blocks512YmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vinserti128 ymm0, ymm0, XMMWORD PTR [rsi + 64], 1
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vinserti128 ymm1, ymm1, XMMWORD PTR [rsi + 80], 1
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vinserti128 ymm2, ymm2, XMMWORD PTR [rsi + 96], 1
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vinserti128 ymm3, ymm3, XMMWORD PTR [rsi + 112], 1
    vmovdqu xmm4, XMMWORD PTR [rsi + 128]
    vinserti128 ymm4, ymm4, XMMWORD PTR [rsi + 192], 1
    vmovdqu xmm5, XMMWORD PTR [rsi + 144]
    vinserti128 ymm5, ymm5, XMMWORD PTR [rsi + 208], 1
    vmovdqu xmm6, XMMWORD PTR [rsi + 160]
    vinserti128 ymm6, ymm6, XMMWORD PTR [rsi + 224], 1
    vmovdqu xmm7, XMMWORD PTR [rsi + 176]
    vinserti128 ymm7, ymm7, XMMWORD PTR [rsi + 240], 1
    vmovdqu ymm8, YMMWORD PTR [rdx]
    vperm2i128 ymm10, ymm8, ymm8, 1
    vmovdqu ymm9, YMMWORD PTR [rdx + 32]
    vperm2i128 ymm11, ymm9, ymm9, 1
    vpxor xmm12, xmm12, xmm12
    vperm2i128 ymm13, ymm10, ymm10, 0
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    cmp rcx, 10
    je v512_4blk512_ymm_final
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    cmp rcx, 12
    je v512_4blk512_ymm_final
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    cmp rcx, 14
    je v512_4blk512_ymm_final
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vaesenc ymm0, ymm0, ymm12
    vaesenc ymm1, ymm1, ymm12
    vaesenc ymm2, ymm2, ymm12
    vaesenc ymm3, ymm3, ymm12
    vaesenc ymm4, ymm4, ymm12
    vaesenc ymm5, ymm5, ymm12
    vaesenc ymm6, ymm6, ymm12
    vaesenc ymm7, ymm7, ymm12
    vpunpcklbw ymm13, ymm0, ymm2
    vpunpckhbw ymm14, ymm0, ymm2
    vpunpcklbw ymm15, ymm1, ymm3
    vpunpckhbw ymm1, ymm1, ymm3
    vpunpcklbw ymm0, ymm13, ymm15
    vpunpckhbw ymm2, ymm13, ymm15
    vpunpckhbw ymm3, ymm14, ymm1
    vpunpcklbw ymm1, ymm14, ymm1
    vpunpcklbw ymm13, ymm4, ymm6
    vpunpckhbw ymm14, ymm4, ymm6
    vpunpcklbw ymm15, ymm5, ymm7
    vpunpckhbw ymm5, ymm5, ymm7
    vpunpcklbw ymm4, ymm13, ymm15
    vpunpckhbw ymm6, ymm13, ymm15
    vpunpckhbw ymm7, ymm14, ymm5
    vpunpcklbw ymm5, ymm14, ymm5
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
v512_4blk512_ymm_final:
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesenc ymm0, ymm0, ymm13
    vaesenc ymm4, ymm4, ymm13
    vaesenc ymm1, ymm1, ymm14
    vaesenc ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesenc ymm2, ymm2, ymm13
    vaesenc ymm6, ymm6, ymm13
    vaesenc ymm3, ymm3, ymm14
    vaesenc ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesenclast ymm0, ymm0, ymm13
    vaesenclast ymm4, ymm4, ymm13
    vaesenclast ymm1, ymm1, ymm14
    vaesenclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesenclast ymm2, ymm2, ymm13
    vaesenclast ymm6, ymm6, ymm13
    vaesenclast ymm3, ymm3, ymm14
    vaesenclast ymm7, ymm7, ymm14
    vmovdqu XMMWORD PTR [rdi], xmm0
    vextracti128 XMMWORD PTR [rdi + 64], ymm0, 1
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vextracti128 XMMWORD PTR [rdi + 80], ymm1, 1
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vextracti128 XMMWORD PTR [rdi + 96], ymm2, 1
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vextracti128 XMMWORD PTR [rdi + 112], ymm3, 1
    vmovdqu XMMWORD PTR [rdi + 128], xmm4
    vextracti128 XMMWORD PTR [rdi + 192], ymm4, 1
    vmovdqu XMMWORD PTR [rdi + 144], xmm5
    vextracti128 XMMWORD PTR [rdi + 208], ymm5, 1
    vmovdqu XMMWORD PTR [rdi + 160], xmm6
    vextracti128 XMMWORD PTR [rdi + 224], ymm6, 1
    vmovdqu XMMWORD PTR [rdi + 176], xmm7
    vextracti128 XMMWORD PTR [rdi + 240], ymm7, 1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    vzeroupper
    ret
vistrutah512Encrypt4Blocks512YmmAsm ENDP

PUBLIC vistrutah512Decrypt4Blocks512YmmAsm
ALIGN 16
vistrutah512Decrypt4Blocks512YmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vinserti128 ymm0, ymm0, XMMWORD PTR [rsi + 64], 1
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vinserti128 ymm1, ymm1, XMMWORD PTR [rsi + 80], 1
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vinserti128 ymm2, ymm2, XMMWORD PTR [rsi + 96], 1
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vinserti128 ymm3, ymm3, XMMWORD PTR [rsi + 112], 1
    vmovdqu xmm4, XMMWORD PTR [rsi + 128]
    vinserti128 ymm4, ymm4, XMMWORD PTR [rsi + 192], 1
    vmovdqu xmm5, XMMWORD PTR [rsi + 144]
    vinserti128 ymm5, ymm5, XMMWORD PTR [rsi + 208], 1
    vmovdqu xmm6, XMMWORD PTR [rsi + 160]
    vinserti128 ymm6, ymm6, XMMWORD PTR [rsi + 224], 1
    vmovdqu xmm7, XMMWORD PTR [rsi + 176]
    vinserti128 ymm7, ymm7, XMMWORD PTR [rsi + 240], 1
    vmovdqu ymm8, YMMWORD PTR [rdx]
    vperm2i128 ymm10, ymm8, ymm8, 1
    vmovdqu ymm9, YMMWORD PTR [rdx + 32]
    vperm2i128 ymm11, ymm9, ymm9, 1
    vpxor xmm12, xmm12, xmm12
    vaesenclast ymm8, ymm8, ymm12
    vaesdec ymm8, ymm8, ymm12
    vaesenclast ymm9, ymm9, ymm12
    vaesdec ymm9, ymm9, ymm12
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 512]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    cmp rcx, 10
    je v512_dec_4blk512_ymm_init_done
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 128]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    cmp rcx, 12
    je v512_dec_4blk512_ymm_init_done
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    cmp rcx, 14
    je v512_dec_4blk512_ymm_init_done
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
v512_dec_4blk512_ymm_init_done:
    vperm2i128 ymm13, ymm10, ymm10, 0
    vperm2i128 ymm14, ymm10, ymm10, 17
    vpxor ymm0, ymm0, ymm13
    vpxor ymm4, ymm4, ymm13
    vpxor ymm1, ymm1, ymm14
    vpxor ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vpxor ymm2, ymm2, ymm13
    vpxor ymm6, ymm6, ymm13
    vpxor ymm3, ymm3, ymm14
    vpxor ymm7, ymm7, ymm14
    cmp rcx, 10
    je v512_dec_4blk512_ymm_step4
    cmp rcx, 12
    je v512_dec_4blk512_ymm_step5
    cmp rcx, 14
    je v512_dec_4blk512_ymm_step6
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
v512_dec_4blk512_ymm_step6:
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
v512_dec_4blk512_ymm_step5:
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
v512_dec_4blk512_ymm_step4:
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vbroadcasti128 ymm15, XMMWORD PTR [vistrutahRoundConstants]
    vpxor ymm13, ymm13, ymm15
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 576]
    vpshufb ymm0, ymm0, ymm15
    vpshufb ymm1, ymm1, ymm15
    vpshufb ymm2, ymm2, ymm15
    vpshufb ymm3, ymm3, ymm15
    vpunpckldq ymm13, ymm0, ymm2
    vpunpckhdq ymm14, ymm0, ymm2
    vpunpckldq ymm2, ymm1, ymm3
    vpunpckhdq ymm3, ymm1, ymm3
    vpunpcklqdq ymm0, ymm13, ymm2
    vpunpckhqdq ymm1, ymm13, ymm2
    vpunpcklqdq ymm2, ymm14, ymm3
    vpunpckhqdq ymm3, ymm14, ymm3
    vpshufb ymm4, ymm4, ymm15
    vpshufb ymm5, ymm5, ymm15
    vpshufb ymm6, ymm6, ymm15
    vpshufb ymm7, ymm7, ymm15
    vpunpckldq ymm13, ymm4, ymm6
    vpunpckhdq ymm14, ymm4, ymm6
    vpunpckldq ymm6, ymm5, ymm7
    vpunpckhdq ymm7, ymm5, ymm7
    vpunpcklqdq ymm4, ymm13, ymm6
    vpunpckhqdq ymm5, ymm13, ymm6
    vpunpcklqdq ymm6, ymm14, ymm7
    vpunpckhqdq ymm7, ymm14, ymm7
    vaesenclast ymm0, ymm0, ymm12
    vaesdec ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesdec ymm1, ymm1, ymm12
    vaesenclast ymm2, ymm2, ymm12
    vaesdec ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesdec ymm3, ymm3, ymm12
    vaesenclast ymm4, ymm4, ymm12
    vaesdec ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesdec ymm5, ymm5, ymm12
    vaesenclast ymm6, ymm6, ymm12
    vaesdec ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesdec ymm7, ymm7, ymm12
    vperm2i128 ymm13, ymm8, ymm8, 0
    vperm2i128 ymm14, ymm8, ymm8, 17
    vaesdec ymm0, ymm0, ymm13
    vaesdec ymm4, ymm4, ymm13
    vaesdec ymm1, ymm1, ymm14
    vaesdec ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm9, ymm9, 0
    vperm2i128 ymm14, ymm9, ymm9, 17
    vaesdec ymm2, ymm2, ymm13
    vaesdec ymm6, ymm6, ymm13
    vaesdec ymm3, ymm3, ymm14
    vaesdec ymm7, ymm7, ymm14
    vmovdqu ymm15, YMMWORD PTR [vistrutahConsts + 448]
    vpshufb ymm10, ymm10, ymm15
    vpshufb ymm11, ymm11, ymm15
    vperm2i128 ymm13, ymm10, ymm10, 0
    vperm2i128 ymm14, ymm10, ymm10, 17
    vaesdeclast ymm0, ymm0, ymm13
    vaesdeclast ymm4, ymm4, ymm13
    vaesdeclast ymm1, ymm1, ymm14
    vaesdeclast ymm5, ymm5, ymm14
    vperm2i128 ymm13, ymm11, ymm11, 0
    vperm2i128 ymm14, ymm11, ymm11, 17
    vaesdeclast ymm2, ymm2, ymm13
    vaesdeclast ymm6, ymm6, ymm13
    vaesdeclast ymm3, ymm3, ymm14
    vaesdeclast ymm7, ymm7, ymm14
    vmovdqu XMMWORD PTR [rdi], xmm0
    vextracti128 XMMWORD PTR [rdi + 64], ymm0, 1
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vextracti128 XMMWORD PTR [rdi + 80], ymm1, 1
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vextracti128 XMMWORD PTR [rdi + 96], ymm2, 1
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vextracti128 XMMWORD PTR [rdi + 112], ymm3, 1
    vmovdqu XMMWORD PTR [rdi + 128], xmm4
    vextracti128 XMMWORD PTR [rdi + 192], ymm4, 1
    vmovdqu XMMWORD PTR [rdi + 144], xmm5
    vextracti128 XMMWORD PTR [rdi + 208], ymm5, 1
    vmovdqu XMMWORD PTR [rdi + 160], xmm6
    vextracti128 XMMWORD PTR [rdi + 224], ymm6, 1
    vmovdqu XMMWORD PTR [rdi + 176], xmm7
    vextracti128 XMMWORD PTR [rdi + 240], ymm7, 1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    vzeroupper
    ret
vistrutah512Decrypt4Blocks512YmmAsm ENDP

PUBLIC vistrutah512Encrypt4Blocks512ZmmAsm
ALIGN 16
vistrutah512Encrypt4Blocks512ZmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 64], 1
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 128], 2
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 192], 3
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 80], 1
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 144], 2
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 208], 3
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vinserti32x4 zmm2, zmm2, XMMWORD PTR [rsi + 96], 1
    vinserti32x4 zmm2, zmm2, XMMWORD PTR [rsi + 160], 2
    vinserti32x4 zmm2, zmm2, XMMWORD PTR [rsi + 224], 3
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vinserti32x4 zmm3, zmm3, XMMWORD PTR [rsi + 112], 1
    vinserti32x4 zmm3, zmm3, XMMWORD PTR [rsi + 176], 2
    vinserti32x4 zmm3, zmm3, XMMWORD PTR [rsi + 240], 3
    vmovdqu64 zmm4, ZMMWORD PTR [rdx]
    vshufi32x4 zmm8, zmm4, zmm4, 0
    vshufi32x4 zmm9, zmm4, zmm4, 85
    vshufi32x4 zmm10, zmm4, zmm4, 170
    vshufi32x4 zmm11, zmm4, zmm4, 255
    vshufi32x4 zmm5, zmm4, zmm4, 177
    vmovdqu64 zmm6, ZMMWORD PTR [vistrutahConsts + 128]
    vpxord xmm7, xmm7, xmm7
    vpxorq zmm0, zmm0, zmm9
    vpxorq zmm1, zmm1, zmm8
    vpxorq zmm2, zmm2, zmm11
    vpxorq zmm3, zmm3, zmm10
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
    cmp rcx, 10
    je v512_4blk512_zmm_final
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
    cmp rcx, 12
    je v512_4blk512_zmm_final
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
    cmp rcx, 14
    je v512_4blk512_zmm_final
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vaesenc zmm0, zmm0, zmm7
    vaesenc zmm1, zmm1, zmm7
    vaesenc zmm2, zmm2, zmm7
    vaesenc zmm3, zmm3, zmm7
    vpunpcklbw zmm12, zmm0, zmm2
    vpunpckhbw zmm13, zmm0, zmm2
    vpunpcklbw zmm14, zmm1, zmm3
    vpunpckhbw zmm15, zmm1, zmm3
    vpunpcklbw zmm0, zmm12, zmm14
    vpunpckhbw zmm2, zmm12, zmm14
    vpunpcklbw zmm1, zmm13, zmm15
    vpunpckhbw zmm3, zmm13, zmm15
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxorq zmm12, zmm12, zmm13
    vpxorq zmm0, zmm0, zmm12
    vshufi32x4 zmm12, zmm5, zmm5, 85
    vpxorq zmm1, zmm1, zmm12
    vshufi32x4 zmm13, zmm5, zmm5, 170
    vpxorq zmm2, zmm2, zmm13
    vshufi32x4 zmm14, zmm5, zmm5, 255
    vpxorq zmm3, zmm3, zmm14
v512_4blk512_zmm_final:
    vaesenc zmm0, zmm0, zmm8
    vaesenc zmm1, zmm1, zmm9
    vaesenc zmm2, zmm2, zmm10
    vaesenc zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesenclast zmm0, zmm0, zmm12
    vaesenclast zmm1, zmm1, zmm13
    vaesenclast zmm2, zmm2, zmm14
    vaesenclast zmm3, zmm3, zmm15
    vmovdqu XMMWORD PTR [rdi], xmm0
    vextracti32x4 XMMWORD PTR [rdi + 64], zmm0, 1
    vextracti32x4 XMMWORD PTR [rdi + 128], zmm0, 2
    vextracti32x4 XMMWORD PTR [rdi + 192], zmm0, 3
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vextracti32x4 XMMWORD PTR [rdi + 80], zmm1, 1
    vextracti32x4 XMMWORD PTR [rdi + 144], zmm1, 2
    vextracti32x4 XMMWORD PTR [rdi + 208], zmm1, 3
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vextracti32x4 XMMWORD PTR [rdi + 96], zmm2, 1
    vextracti32x4 XMMWORD PTR [rdi + 160], zmm2, 2
    vextracti32x4 XMMWORD PTR [rdi + 224], zmm2, 3
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vextracti32x4 XMMWORD PTR [rdi + 112], zmm3, 1
    vextracti32x4 XMMWORD PTR [rdi + 176], zmm3, 2
    vextracti32x4 XMMWORD PTR [rdi + 240], zmm3, 3
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm4, xmm4, xmm4
    vpxord xmm5, xmm5, xmm5
    vpxord xmm6, xmm6, xmm6
    vpxord xmm7, xmm7, xmm7
    vpxord xmm8, xmm8, xmm8
    vpxord xmm9, xmm9, xmm9
    vpxord xmm10, xmm10, xmm10
    vpxord xmm11, xmm11, xmm11
    vpxord xmm12, xmm12, xmm12
    vpxord xmm13, xmm13, xmm13
    vpxord xmm14, xmm14, xmm14
    vpxord xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    vzeroupper
    ret
vistrutah512Encrypt4Blocks512ZmmAsm ENDP

PUBLIC vistrutah512Decrypt4Blocks512ZmmAsm
ALIGN 16
vistrutah512Decrypt4Blocks512ZmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    vmovdqu XMMWORD PTR [rsp + 144], xmm14
    vmovdqu XMMWORD PTR [rsp + 160], xmm15
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 64], 1
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 128], 2
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rsi + 192], 3
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 80], 1
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 144], 2
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rsi + 208], 3
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vinserti32x4 zmm2, zmm2, XMMWORD PTR [rsi + 96], 1
    vinserti32x4 zmm2, zmm2, XMMWORD PTR [rsi + 160], 2
    vinserti32x4 zmm2, zmm2, XMMWORD PTR [rsi + 224], 3
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vinserti32x4 zmm3, zmm3, XMMWORD PTR [rsi + 112], 1
    vinserti32x4 zmm3, zmm3, XMMWORD PTR [rsi + 176], 2
    vinserti32x4 zmm3, zmm3, XMMWORD PTR [rsi + 240], 3
    vmovdqu64 zmm4, ZMMWORD PTR [rdx]
    vshufi32x4 zmm5, zmm4, zmm4, 177
    vpxord xmm7, xmm7, xmm7
    vaesenclast zmm4, zmm4, zmm7
    vaesdec zmm4, zmm4, zmm7
    vshufi32x4 zmm8, zmm4, zmm4, 0
    vshufi32x4 zmm9, zmm4, zmm4, 85
    vshufi32x4 zmm10, zmm4, zmm4, 170
    vshufi32x4 zmm11, zmm4, zmm4, 255
    vmovdqu64 zmm6, ZMMWORD PTR [vistrutahConsts + 512]
    vpshufb zmm5, zmm5, zmm6
    cmp rcx, 10
    je v512_dec_4blk512_zmm_init_done
    vmovdqu64 zmm6, ZMMWORD PTR [vistrutahConsts + 128]
    vpshufb zmm5, zmm5, zmm6
    cmp rcx, 12
    je v512_dec_4blk512_zmm_init_done
    vpshufb zmm5, zmm5, zmm6
    cmp rcx, 14
    je v512_dec_4blk512_zmm_init_done
    vpshufb zmm5, zmm5, zmm6
    vpshufb zmm5, zmm5, zmm6
v512_dec_4blk512_zmm_init_done:
    vmovdqu64 zmm4, ZMMWORD PTR [vistrutahConsts + 576]
    vmovdqu64 zmm6, ZMMWORD PTR [vistrutahConsts + 448]
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vpxorq zmm0, zmm0, zmm12
    vpxorq zmm1, zmm1, zmm13
    vpxorq zmm2, zmm2, zmm14
    vpxorq zmm3, zmm3, zmm15
    cmp rcx, 10
    je v512_dec_4blk512_zmm_step4
    cmp rcx, 12
    je v512_dec_4blk512_zmm_step5
    cmp rcx, 14
    je v512_dec_4blk512_zmm_step6
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 112]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 96]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
v512_dec_4blk512_zmm_step6:
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 80]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
v512_dec_4blk512_zmm_step5:
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 64]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
v512_dec_4blk512_zmm_step4:
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 48]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 32]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants + 16]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vbroadcasti32x4 zmm13, XMMWORD PTR [vistrutahRoundConstants]
    vpxorq zmm12, zmm12, zmm13
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vpshufb zmm0, zmm0, zmm4
    vpshufb zmm1, zmm1, zmm4
    vpshufb zmm2, zmm2, zmm4
    vpshufb zmm3, zmm3, zmm4
    vpunpckldq zmm12, zmm0, zmm2
    vpunpckhdq zmm13, zmm0, zmm2
    vpunpckldq zmm14, zmm1, zmm3
    vpunpckhdq zmm15, zmm1, zmm3
    vpunpcklqdq zmm0, zmm12, zmm14
    vpunpckhqdq zmm1, zmm12, zmm14
    vpunpcklqdq zmm2, zmm13, zmm15
    vpunpckhqdq zmm3, zmm13, zmm15
    vaesenclast zmm0, zmm0, zmm7
    vaesdec zmm0, zmm0, zmm7
    vaesenclast zmm1, zmm1, zmm7
    vaesdec zmm1, zmm1, zmm7
    vaesenclast zmm2, zmm2, zmm7
    vaesdec zmm2, zmm2, zmm7
    vaesenclast zmm3, zmm3, zmm7
    vaesdec zmm3, zmm3, zmm7
    vaesdec zmm0, zmm0, zmm8
    vaesdec zmm1, zmm1, zmm9
    vaesdec zmm2, zmm2, zmm10
    vaesdec zmm3, zmm3, zmm11
    vpshufb zmm5, zmm5, zmm6
    vshufi32x4 zmm12, zmm5, zmm5, 0
    vshufi32x4 zmm13, zmm5, zmm5, 85
    vshufi32x4 zmm14, zmm5, zmm5, 170
    vshufi32x4 zmm15, zmm5, zmm5, 255
    vaesdeclast zmm0, zmm0, zmm12
    vaesdeclast zmm1, zmm1, zmm13
    vaesdeclast zmm2, zmm2, zmm14
    vaesdeclast zmm3, zmm3, zmm15
    vmovdqu XMMWORD PTR [rdi], xmm0
    vextracti32x4 XMMWORD PTR [rdi + 64], zmm0, 1
    vextracti32x4 XMMWORD PTR [rdi + 128], zmm0, 2
    vextracti32x4 XMMWORD PTR [rdi + 192], zmm0, 3
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vextracti32x4 XMMWORD PTR [rdi + 80], zmm1, 1
    vextracti32x4 XMMWORD PTR [rdi + 144], zmm1, 2
    vextracti32x4 XMMWORD PTR [rdi + 208], zmm1, 3
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vextracti32x4 XMMWORD PTR [rdi + 96], zmm2, 1
    vextracti32x4 XMMWORD PTR [rdi + 160], zmm2, 2
    vextracti32x4 XMMWORD PTR [rdi + 224], zmm2, 3
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vextracti32x4 XMMWORD PTR [rdi + 112], zmm3, 1
    vextracti32x4 XMMWORD PTR [rdi + 176], zmm3, 2
    vextracti32x4 XMMWORD PTR [rdi + 240], zmm3, 3
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm4, xmm4, xmm4
    vpxord xmm5, xmm5, xmm5
    vpxord xmm6, xmm6, xmm6
    vpxord xmm7, xmm7, xmm7
    vpxord xmm8, xmm8, xmm8
    vpxord xmm9, xmm9, xmm9
    vpxord xmm10, xmm10, xmm10
    vpxord xmm11, xmm11, xmm11
    vpxord xmm12, xmm12, xmm12
    vpxord xmm13, xmm13, xmm13
    vpxord xmm14, xmm14, xmm14
    vpxord xmm15, xmm15, xmm15
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 144]
    mov QWORD PTR [rsp + 144], 0
    mov QWORD PTR [rsp + 152], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 160]
    mov QWORD PTR [rsp + 160], 0
    mov QWORD PTR [rsp + 168], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    vzeroupper
    ret
vistrutah512Decrypt4Blocks512ZmmAsm ENDP

END
