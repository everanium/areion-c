; Copyright (c) 2026 Andrey Kuvshinov
; SPDX-License-Identifier: Apache-2.0 OR MIT

EXTERN asuraRoundConstants:BYTE
EXTERN areion_asura_rc:BYTE
EXTERN asuraConsts:BYTE
EXTERN asuraGFConsts:BYTE

.code

PUBLIC areion_asura_expand_tweakey_asm
ALIGN 16
areion_asura_expand_tweakey_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    movdqu xmm2, XMMWORD PTR [rdx]
    pxor xmm3, xmm3
    movdqa xmm4, xmm0
    pxor xmm4, xmm2
    pxor xmm4, XMMWORD PTR [asuraRoundConstants]
    movdqa xmm5, xmm1
    pxor xmm5, xmm2
    movdqu XMMWORD PTR [rdi], xmm4
    movdqu XMMWORD PTR [rdi + 16], xmm5
    aesenc xmm2, xmm3
    movdqa xmm4, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm4, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm4, xmm3
    movdqa xmm5, xmm3
    pcmpgtb xmm4, xmm0
    pcmpgtb xmm5, xmm1
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    pand xmm5, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqa xmm4, xmm0
    pxor xmm4, xmm2
    pxor xmm4, XMMWORD PTR [asuraRoundConstants + 16]
    movdqa xmm5, xmm1
    pxor xmm5, xmm2
    movdqu XMMWORD PTR [rdi + 32], xmm4
    movdqu XMMWORD PTR [rdi + 48], xmm5
    aesenc xmm2, xmm3
    movdqa xmm4, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm4, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm4, xmm3
    movdqa xmm5, xmm3
    pcmpgtb xmm4, xmm0
    pcmpgtb xmm5, xmm1
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    pand xmm5, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqa xmm4, xmm0
    pxor xmm4, xmm2
    pxor xmm4, XMMWORD PTR [asuraRoundConstants + 32]
    movdqa xmm5, xmm1
    pxor xmm5, xmm2
    movdqu XMMWORD PTR [rdi + 64], xmm4
    movdqu XMMWORD PTR [rdi + 80], xmm5
    aesenc xmm2, xmm3
    movdqa xmm4, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm4, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm4, xmm3
    movdqa xmm5, xmm3
    pcmpgtb xmm4, xmm0
    pcmpgtb xmm5, xmm1
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    pand xmm5, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqa xmm4, xmm0
    pxor xmm4, xmm2
    pxor xmm4, XMMWORD PTR [asuraRoundConstants + 48]
    movdqa xmm5, xmm1
    pxor xmm5, xmm2
    movdqu XMMWORD PTR [rdi + 96], xmm4
    movdqu XMMWORD PTR [rdi + 112], xmm5
    aesenc xmm2, xmm3
    movdqa xmm4, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm4, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm4, xmm3
    movdqa xmm5, xmm3
    pcmpgtb xmm4, xmm0
    pcmpgtb xmm5, xmm1
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    pand xmm5, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqa xmm4, xmm0
    pxor xmm4, xmm2
    pxor xmm4, XMMWORD PTR [asuraRoundConstants + 64]
    movdqa xmm5, xmm1
    pxor xmm5, xmm2
    movdqu XMMWORD PTR [rdi + 128], xmm4
    movdqu XMMWORD PTR [rdi + 144], xmm5
    aesenc xmm2, xmm3
    movdqa xmm4, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm4, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm4, xmm3
    movdqa xmm5, xmm3
    pcmpgtb xmm4, xmm0
    pcmpgtb xmm5, xmm1
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    pand xmm5, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqa xmm4, xmm0
    pxor xmm4, xmm2
    pxor xmm4, XMMWORD PTR [asuraRoundConstants + 80]
    movdqa xmm5, xmm1
    pxor xmm5, xmm2
    movdqu XMMWORD PTR [rdi + 160], xmm4
    movdqu XMMWORD PTR [rdi + 176], xmm5
    aesenc xmm2, xmm3
    movdqa xmm4, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm4, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm4, xmm3
    movdqa xmm5, xmm3
    pcmpgtb xmm4, xmm0
    pcmpgtb xmm5, xmm1
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    pand xmm5, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqa xmm4, xmm0
    pxor xmm4, xmm2
    pxor xmm4, XMMWORD PTR [asuraRoundConstants + 96]
    movdqa xmm5, xmm1
    pxor xmm5, xmm2
    movdqu XMMWORD PTR [rdi + 192], xmm4
    movdqu XMMWORD PTR [rdi + 208], xmm5
    aesenc xmm2, xmm3
    movdqa xmm4, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm4, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm4, xmm3
    movdqa xmm5, xmm3
    pcmpgtb xmm4, xmm0
    pcmpgtb xmm5, xmm1
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    pand xmm5, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqa xmm4, xmm0
    pxor xmm4, xmm2
    pxor xmm4, XMMWORD PTR [asuraRoundConstants + 112]
    movdqa xmm5, xmm1
    pxor xmm5, xmm2
    movdqu XMMWORD PTR [rdi + 224], xmm4
    movdqu XMMWORD PTR [rdi + 240], xmm5
    aesenc xmm2, xmm3
    movdqa xmm4, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm4, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm4, xmm3
    movdqa xmm5, xmm3
    pcmpgtb xmm4, xmm0
    pcmpgtb xmm5, xmm1
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    pand xmm5, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqa xmm4, xmm0
    pxor xmm4, xmm2
    pxor xmm4, XMMWORD PTR [asuraRoundConstants + 128]
    movdqa xmm5, xmm1
    pxor xmm5, xmm2
    movdqu XMMWORD PTR [rdi + 256], xmm4
    movdqu XMMWORD PTR [rdi + 272], xmm5
    aesenc xmm2, xmm3
    movdqa xmm4, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm4, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm4, xmm3
    movdqa xmm5, xmm3
    pcmpgtb xmm4, xmm0
    pcmpgtb xmm5, xmm1
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    pand xmm5, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqa xmm4, xmm0
    pxor xmm4, xmm2
    pxor xmm4, XMMWORD PTR [asuraRoundConstants + 144]
    movdqa xmm5, xmm1
    pxor xmm5, xmm2
    movdqu XMMWORD PTR [rdi + 288], xmm4
    movdqu XMMWORD PTR [rdi + 304], xmm5
    aesenc xmm2, xmm3
    movdqa xmm4, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm4, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm4, xmm3
    movdqa xmm5, xmm3
    pcmpgtb xmm4, xmm0
    pcmpgtb xmm5, xmm1
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    pand xmm5, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqa xmm4, xmm0
    pxor xmm4, xmm2
    pxor xmm4, XMMWORD PTR [asuraRoundConstants + 160]
    movdqa xmm5, xmm1
    pxor xmm5, xmm2
    movdqu XMMWORD PTR [rdi + 320], xmm4
    movdqu XMMWORD PTR [rdi + 336], xmm5
    aesenc xmm2, xmm3
    movdqa xmm4, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm4, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm4, xmm3
    movdqa xmm5, xmm3
    pcmpgtb xmm4, xmm0
    pcmpgtb xmm5, xmm1
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    pand xmm5, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqa xmm4, xmm0
    pxor xmm4, xmm2
    pxor xmm4, XMMWORD PTR [asuraRoundConstants + 176]
    movdqa xmm5, xmm1
    pxor xmm5, xmm2
    movdqu XMMWORD PTR [rdi + 352], xmm4
    movdqu XMMWORD PTR [rdi + 368], xmm5
    aesenc xmm2, xmm3
    movdqa xmm4, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm4, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm4, xmm3
    movdqa xmm5, xmm3
    pcmpgtb xmm4, xmm0
    pcmpgtb xmm5, xmm1
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    pand xmm5, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqa xmm4, xmm0
    pxor xmm4, xmm2
    pxor xmm4, XMMWORD PTR [asuraRoundConstants + 192]
    movdqa xmm5, xmm1
    pxor xmm5, xmm2
    movdqu XMMWORD PTR [rdi + 384], xmm4
    movdqu XMMWORD PTR [rdi + 400], xmm5
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    xor rdx, rdx
    ret
areion_asura_expand_tweakey_asm ENDP

PUBLIC areion_asura_encrypt_block_asm
ALIGN 16
areion_asura_encrypt_block_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    pxor xmm2, xmm2
    movdqa xmm3, XMMWORD PTR [asuraConsts + 64]
    movdqu xmm4, XMMWORD PTR [rdx]
    movdqu xmm5, XMMWORD PTR [rdx + 16]
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [rdx + 32]
    movdqu xmm5, XMMWORD PTR [rdx + 48]
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesenc xmm0, xmm2
    aesdec xmm1, xmm2
    pshufb xmm0, xmm3
    pshufb xmm1, xmm3
    movdqa xmm4, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm4, xmm1
    movdqa xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 64]
    movdqu xmm5, XMMWORD PTR [rdx + 80]
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [rdx + 96]
    movdqu xmm5, XMMWORD PTR [rdx + 112]
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesenc xmm0, xmm2
    aesdec xmm1, xmm2
    pshufb xmm0, xmm3
    pshufb xmm1, xmm3
    movdqa xmm4, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm4, xmm1
    movdqa xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 128]
    movdqu xmm5, XMMWORD PTR [rdx + 144]
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [rdx + 160]
    movdqu xmm5, XMMWORD PTR [rdx + 176]
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesenc xmm0, xmm2
    aesdec xmm1, xmm2
    pshufb xmm0, xmm3
    pshufb xmm1, xmm3
    movdqa xmm4, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm4, xmm1
    movdqa xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 192]
    movdqu xmm5, XMMWORD PTR [rdx + 208]
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [rdx + 224]
    movdqu xmm5, XMMWORD PTR [rdx + 240]
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesenc xmm0, xmm2
    aesdec xmm1, xmm2
    pshufb xmm0, xmm3
    pshufb xmm1, xmm3
    movdqa xmm4, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm4, xmm1
    movdqa xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 256]
    movdqu xmm5, XMMWORD PTR [rdx + 272]
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [rdx + 288]
    movdqu xmm5, XMMWORD PTR [rdx + 304]
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesenc xmm0, xmm2
    aesdec xmm1, xmm2
    pshufb xmm0, xmm3
    pshufb xmm1, xmm3
    movdqa xmm4, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm4, xmm1
    movdqa xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 320]
    movdqu xmm5, XMMWORD PTR [rdx + 336]
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [rdx + 352]
    movdqu xmm5, XMMWORD PTR [rdx + 368]
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [rdx + 384]
    movdqu xmm5, XMMWORD PTR [rdx + 400]
    aesenc xmm0, xmm4
    aesdec xmm1, xmm5
    movdqu XMMWORD PTR [rdi], xmm0
    movdqu XMMWORD PTR [rdi + 16], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    xor rdx, rdx
    ret
areion_asura_encrypt_block_asm ENDP

PUBLIC areion_asura_decrypt_block_asm
ALIGN 16
areion_asura_decrypt_block_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    pxor xmm2, xmm2
    movdqu xmm4, XMMWORD PTR [rdx + 384]
    movdqu xmm5, XMMWORD PTR [rdx + 400]
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [rdx + 352]
    movdqu xmm5, XMMWORD PTR [rdx + 368]
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm2
    aesdeclast xmm5, xmm2
    aesdeclast xmm0, xmm4
    aesenc xmm1, xmm2
    aesenc xmm5, xmm2
    movdqu xmm4, XMMWORD PTR [rdx + 320]
    aesdeclast xmm0, xmm2
    aesenc xmm1, xmm5
    movdqu xmm5, XMMWORD PTR [rdx + 336]
    aesenc xmm0, xmm2
    aesenclast xmm0, xmm4
    aesenclast xmm1, xmm5
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm4, XMMWORD PTR [rdx + 288]
    movdqu xmm5, XMMWORD PTR [rdx + 304]
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm2
    aesdeclast xmm5, xmm2
    aesdeclast xmm0, xmm4
    aesenc xmm1, xmm2
    aesenc xmm5, xmm2
    movdqu xmm4, XMMWORD PTR [rdx + 256]
    aesdeclast xmm0, xmm2
    aesenc xmm1, xmm5
    movdqu xmm5, XMMWORD PTR [rdx + 272]
    aesenc xmm0, xmm2
    aesenclast xmm0, xmm4
    aesenclast xmm1, xmm5
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm4, XMMWORD PTR [rdx + 224]
    movdqu xmm5, XMMWORD PTR [rdx + 240]
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm2
    aesdeclast xmm5, xmm2
    aesdeclast xmm0, xmm4
    aesenc xmm1, xmm2
    aesenc xmm5, xmm2
    movdqu xmm4, XMMWORD PTR [rdx + 192]
    aesdeclast xmm0, xmm2
    aesenc xmm1, xmm5
    movdqu xmm5, XMMWORD PTR [rdx + 208]
    aesenc xmm0, xmm2
    aesenclast xmm0, xmm4
    aesenclast xmm1, xmm5
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm4, XMMWORD PTR [rdx + 160]
    movdqu xmm5, XMMWORD PTR [rdx + 176]
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm2
    aesdeclast xmm5, xmm2
    aesdeclast xmm0, xmm4
    aesenc xmm1, xmm2
    aesenc xmm5, xmm2
    movdqu xmm4, XMMWORD PTR [rdx + 128]
    aesdeclast xmm0, xmm2
    aesenc xmm1, xmm5
    movdqu xmm5, XMMWORD PTR [rdx + 144]
    aesenc xmm0, xmm2
    aesenclast xmm0, xmm4
    aesenclast xmm1, xmm5
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm4, XMMWORD PTR [rdx + 96]
    movdqu xmm5, XMMWORD PTR [rdx + 112]
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm2
    aesdeclast xmm5, xmm2
    aesdeclast xmm0, xmm4
    aesenc xmm1, xmm2
    aesenc xmm5, xmm2
    movdqu xmm4, XMMWORD PTR [rdx + 64]
    aesdeclast xmm0, xmm2
    aesenc xmm1, xmm5
    movdqu xmm5, XMMWORD PTR [rdx + 80]
    aesenc xmm0, xmm2
    aesenclast xmm0, xmm4
    aesenclast xmm1, xmm5
    movdqa xmm3, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm4, XMMWORD PTR [rdx + 32]
    movdqu xmm5, XMMWORD PTR [rdx + 48]
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm2
    aesdeclast xmm5, xmm2
    aesdeclast xmm0, xmm4
    aesenc xmm1, xmm2
    aesenc xmm5, xmm2
    movdqu xmm4, XMMWORD PTR [rdx]
    aesdeclast xmm0, xmm2
    aesenc xmm1, xmm5
    movdqu xmm5, XMMWORD PTR [rdx + 16]
    aesenc xmm0, xmm2
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    xor rdx, rdx
    ret
areion_asura_decrypt_block_asm ENDP

PUBLIC areion_asura_encrypt_block_otf_asm
ALIGN 16
areion_asura_encrypt_block_otf_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 72
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    movdqu xmm4, XMMWORD PTR [rcx]
    pxor xmm5, xmm5
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    pxor xmm0, xmm6
    pxor xmm1, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 16]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    aesdec xmm0, xmm6
    aesdec xmm1, xmm7
    aesenc xmm0, xmm5
    aesdec xmm1, xmm5
    pshufb xmm0, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm1, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm8, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm8, xmm1
    movdqa xmm1, xmm8
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 32]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    pxor xmm0, xmm6
    pxor xmm1, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 48]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    aesdec xmm0, xmm6
    aesdec xmm1, xmm7
    aesenc xmm0, xmm5
    aesdec xmm1, xmm5
    pshufb xmm0, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm1, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm8, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm8, xmm1
    movdqa xmm1, xmm8
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 64]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    pxor xmm0, xmm6
    pxor xmm1, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 80]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    aesdec xmm0, xmm6
    aesdec xmm1, xmm7
    aesenc xmm0, xmm5
    aesdec xmm1, xmm5
    pshufb xmm0, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm1, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm8, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm8, xmm1
    movdqa xmm1, xmm8
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 96]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    pxor xmm0, xmm6
    pxor xmm1, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 112]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    aesdec xmm0, xmm6
    aesdec xmm1, xmm7
    aesenc xmm0, xmm5
    aesdec xmm1, xmm5
    pshufb xmm0, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm1, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm8, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm8, xmm1
    movdqa xmm1, xmm8
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 128]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    pxor xmm0, xmm6
    pxor xmm1, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 144]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    aesdec xmm0, xmm6
    aesdec xmm1, xmm7
    aesenc xmm0, xmm5
    aesdec xmm1, xmm5
    pshufb xmm0, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm1, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm8, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm8, xmm1
    movdqa xmm1, xmm8
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 160]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    pxor xmm0, xmm6
    pxor xmm1, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 176]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    aesdec xmm0, xmm6
    aesdec xmm1, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 192]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    aesenc xmm0, xmm6
    aesdec xmm1, xmm7
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
    movdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 72
    xor rcx, rcx
    xor rdx, rdx
    ret
areion_asura_encrypt_block_otf_asm ENDP

PUBLIC areion_asura_decrypt_block_otf_asm
ALIGN 16
areion_asura_decrypt_block_otf_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 72
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    movdqu xmm4, XMMWORD PTR [rcx]
    pxor xmm5, xmm5
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    aesenc xmm4, xmm5
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    pshufb xmm2, XMMWORD PTR [asuraConsts]
    pshufb xmm3, XMMWORD PTR [asuraConsts]
    movdqa xmm6, xmm5
    movdqa xmm7, xmm5
    pcmpgtb xmm6, xmm2
    pcmpgtb xmm7, xmm3
    pand xmm6, XMMWORD PTR [asuraGFConsts]
    pand xmm7, XMMWORD PTR [asuraGFConsts]
    paddb xmm2, xmm2
    paddb xmm3, xmm3
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 192]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    pxor xmm0, xmm6
    pxor xmm1, xmm7
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm5
    movdqa xmm6, xmm2
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm2, 1
    pand xmm2, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm2, xmm7
    movdqa xmm6, xmm3
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm3, 1
    pand xmm3, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm3, xmm7
    pshufb xmm2, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 176]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm5
    aesdeclast xmm7, xmm5
    aesdeclast xmm0, xmm6
    aesenc xmm1, xmm5
    aesenc xmm7, xmm5
    aesdeclast xmm0, xmm5
    aesenc xmm1, xmm7
    aesenc xmm0, xmm5
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm5
    movdqa xmm6, xmm2
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm2, 1
    pand xmm2, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm2, xmm7
    movdqa xmm6, xmm3
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm3, 1
    pand xmm3, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm3, xmm7
    pshufb xmm2, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 160]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    aesenclast xmm0, xmm6
    aesenclast xmm1, xmm7
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm5
    movdqa xmm6, xmm2
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm2, 1
    pand xmm2, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm2, xmm7
    movdqa xmm6, xmm3
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm3, 1
    pand xmm3, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm3, xmm7
    pshufb xmm2, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 144]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    movdqa xmm8, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm8, xmm1
    movdqa xmm1, xmm8
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm5
    aesdeclast xmm7, xmm5
    aesdeclast xmm0, xmm6
    aesenc xmm1, xmm5
    aesenc xmm7, xmm5
    aesdeclast xmm0, xmm5
    aesenc xmm1, xmm7
    aesenc xmm0, xmm5
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm5
    movdqa xmm6, xmm2
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm2, 1
    pand xmm2, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm2, xmm7
    movdqa xmm6, xmm3
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm3, 1
    pand xmm3, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm3, xmm7
    pshufb xmm2, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 128]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    aesenclast xmm0, xmm6
    aesenclast xmm1, xmm7
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm5
    movdqa xmm6, xmm2
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm2, 1
    pand xmm2, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm2, xmm7
    movdqa xmm6, xmm3
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm3, 1
    pand xmm3, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm3, xmm7
    pshufb xmm2, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 112]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    movdqa xmm8, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm8, xmm1
    movdqa xmm1, xmm8
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm5
    aesdeclast xmm7, xmm5
    aesdeclast xmm0, xmm6
    aesenc xmm1, xmm5
    aesenc xmm7, xmm5
    aesdeclast xmm0, xmm5
    aesenc xmm1, xmm7
    aesenc xmm0, xmm5
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm5
    movdqa xmm6, xmm2
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm2, 1
    pand xmm2, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm2, xmm7
    movdqa xmm6, xmm3
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm3, 1
    pand xmm3, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm3, xmm7
    pshufb xmm2, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 96]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    aesenclast xmm0, xmm6
    aesenclast xmm1, xmm7
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm5
    movdqa xmm6, xmm2
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm2, 1
    pand xmm2, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm2, xmm7
    movdqa xmm6, xmm3
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm3, 1
    pand xmm3, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm3, xmm7
    pshufb xmm2, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 80]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    movdqa xmm8, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm8, xmm1
    movdqa xmm1, xmm8
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm5
    aesdeclast xmm7, xmm5
    aesdeclast xmm0, xmm6
    aesenc xmm1, xmm5
    aesenc xmm7, xmm5
    aesdeclast xmm0, xmm5
    aesenc xmm1, xmm7
    aesenc xmm0, xmm5
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm5
    movdqa xmm6, xmm2
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm2, 1
    pand xmm2, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm2, xmm7
    movdqa xmm6, xmm3
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm3, 1
    pand xmm3, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm3, xmm7
    pshufb xmm2, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 64]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    aesenclast xmm0, xmm6
    aesenclast xmm1, xmm7
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm5
    movdqa xmm6, xmm2
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm2, 1
    pand xmm2, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm2, xmm7
    movdqa xmm6, xmm3
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm3, 1
    pand xmm3, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm3, xmm7
    pshufb xmm2, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 48]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    movdqa xmm8, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm8, xmm1
    movdqa xmm1, xmm8
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm5
    aesdeclast xmm7, xmm5
    aesdeclast xmm0, xmm6
    aesenc xmm1, xmm5
    aesenc xmm7, xmm5
    aesdeclast xmm0, xmm5
    aesenc xmm1, xmm7
    aesenc xmm0, xmm5
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm5
    movdqa xmm6, xmm2
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm2, 1
    pand xmm2, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm2, xmm7
    movdqa xmm6, xmm3
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm3, 1
    pand xmm3, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm3, xmm7
    pshufb xmm2, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 32]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    aesenclast xmm0, xmm6
    aesenclast xmm1, xmm7
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm5
    movdqa xmm6, xmm2
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm2, 1
    pand xmm2, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm2, xmm7
    movdqa xmm6, xmm3
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm3, 1
    pand xmm3, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm3, xmm7
    pshufb xmm2, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants + 16]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    movdqa xmm8, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm8, xmm1
    movdqa xmm1, xmm8
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm5
    aesdeclast xmm7, xmm5
    aesdeclast xmm0, xmm6
    aesenc xmm1, xmm5
    aesenc xmm7, xmm5
    aesdeclast xmm0, xmm5
    aesenc xmm1, xmm7
    aesenc xmm0, xmm5
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm5
    movdqa xmm6, xmm2
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm2, 1
    pand xmm2, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm2, xmm7
    movdqa xmm6, xmm3
    psllw xmm6, 7
    movdqa xmm7, xmm5
    pcmpgtb xmm7, xmm6
    pand xmm7, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm3, 1
    pand xmm3, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm3, xmm7
    pshufb xmm2, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm6, xmm2
    pblendw xmm2, xmm3, 204
    pblendw xmm3, xmm6, 204
    movdqa xmm6, xmm2
    pxor xmm6, xmm4
    pxor xmm6, XMMWORD PTR [asuraRoundConstants]
    movdqa xmm7, xmm3
    pxor xmm7, xmm4
    aesenclast xmm0, xmm6
    aesenclast xmm1, xmm7
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
    movdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 72
    xor rcx, rcx
    xor rdx, rdx
    ret
areion_asura_decrypt_block_otf_asm ENDP

PUBLIC areion_asura_encrypt_4blocks_asm
ALIGN 16
areion_asura_encrypt_4blocks_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 136
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    movdqu XMMWORD PTR [rsp + 64], xmm9
    movdqu XMMWORD PTR [rsp + 80], xmm10
    movdqu XMMWORD PTR [rsp + 96], xmm11
    movdqu XMMWORD PTR [rsp + 112], xmm12
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    movdqu xmm2, XMMWORD PTR [rsi + 32]
    movdqu xmm3, XMMWORD PTR [rsi + 48]
    movdqu xmm4, XMMWORD PTR [rsi + 64]
    movdqu xmm5, XMMWORD PTR [rsi + 80]
    movdqu xmm6, XMMWORD PTR [rsi + 96]
    movdqu xmm7, XMMWORD PTR [rsi + 112]
    pxor xmm8, xmm8
    movdqa xmm9, XMMWORD PTR [asuraConsts + 64]
    movdqu xmm10, XMMWORD PTR [rdx]
    movdqu xmm11, XMMWORD PTR [rdx + 16]
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    pxor xmm4, xmm10
    pxor xmm5, xmm11
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    movdqu xmm10, XMMWORD PTR [rdx + 32]
    movdqu xmm11, XMMWORD PTR [rdx + 48]
    aesdec xmm0, xmm10
    aesdec xmm1, xmm11
    aesdec xmm2, xmm10
    aesdec xmm3, xmm11
    aesdec xmm4, xmm10
    aesdec xmm5, xmm11
    aesdec xmm6, xmm10
    aesdec xmm7, xmm11
    aesenc xmm0, xmm8
    aesdec xmm1, xmm8
    aesenc xmm2, xmm8
    aesdec xmm3, xmm8
    aesenc xmm4, xmm8
    aesdec xmm5, xmm8
    aesenc xmm6, xmm8
    aesdec xmm7, xmm8
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm12, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm12, xmm1
    movdqa xmm1, xmm12
    pshufb xmm2, xmm9
    pshufb xmm3, xmm9
    movdqa xmm12, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm12, xmm3
    movdqa xmm3, xmm12
    pshufb xmm4, xmm9
    pshufb xmm5, xmm9
    movdqa xmm12, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm12, xmm5
    movdqa xmm5, xmm12
    pshufb xmm6, xmm9
    pshufb xmm7, xmm9
    movdqa xmm12, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm12, xmm7
    movdqa xmm7, xmm12
    movdqu xmm10, XMMWORD PTR [rdx + 64]
    movdqu xmm11, XMMWORD PTR [rdx + 80]
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    pxor xmm4, xmm10
    pxor xmm5, xmm11
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    movdqu xmm10, XMMWORD PTR [rdx + 96]
    movdqu xmm11, XMMWORD PTR [rdx + 112]
    aesdec xmm0, xmm10
    aesdec xmm1, xmm11
    aesdec xmm2, xmm10
    aesdec xmm3, xmm11
    aesdec xmm4, xmm10
    aesdec xmm5, xmm11
    aesdec xmm6, xmm10
    aesdec xmm7, xmm11
    aesenc xmm0, xmm8
    aesdec xmm1, xmm8
    aesenc xmm2, xmm8
    aesdec xmm3, xmm8
    aesenc xmm4, xmm8
    aesdec xmm5, xmm8
    aesenc xmm6, xmm8
    aesdec xmm7, xmm8
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm12, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm12, xmm1
    movdqa xmm1, xmm12
    pshufb xmm2, xmm9
    pshufb xmm3, xmm9
    movdqa xmm12, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm12, xmm3
    movdqa xmm3, xmm12
    pshufb xmm4, xmm9
    pshufb xmm5, xmm9
    movdqa xmm12, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm12, xmm5
    movdqa xmm5, xmm12
    pshufb xmm6, xmm9
    pshufb xmm7, xmm9
    movdqa xmm12, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm12, xmm7
    movdqa xmm7, xmm12
    movdqu xmm10, XMMWORD PTR [rdx + 128]
    movdqu xmm11, XMMWORD PTR [rdx + 144]
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    pxor xmm4, xmm10
    pxor xmm5, xmm11
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    movdqu xmm10, XMMWORD PTR [rdx + 160]
    movdqu xmm11, XMMWORD PTR [rdx + 176]
    aesdec xmm0, xmm10
    aesdec xmm1, xmm11
    aesdec xmm2, xmm10
    aesdec xmm3, xmm11
    aesdec xmm4, xmm10
    aesdec xmm5, xmm11
    aesdec xmm6, xmm10
    aesdec xmm7, xmm11
    aesenc xmm0, xmm8
    aesdec xmm1, xmm8
    aesenc xmm2, xmm8
    aesdec xmm3, xmm8
    aesenc xmm4, xmm8
    aesdec xmm5, xmm8
    aesenc xmm6, xmm8
    aesdec xmm7, xmm8
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm12, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm12, xmm1
    movdqa xmm1, xmm12
    pshufb xmm2, xmm9
    pshufb xmm3, xmm9
    movdqa xmm12, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm12, xmm3
    movdqa xmm3, xmm12
    pshufb xmm4, xmm9
    pshufb xmm5, xmm9
    movdqa xmm12, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm12, xmm5
    movdqa xmm5, xmm12
    pshufb xmm6, xmm9
    pshufb xmm7, xmm9
    movdqa xmm12, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm12, xmm7
    movdqa xmm7, xmm12
    movdqu xmm10, XMMWORD PTR [rdx + 192]
    movdqu xmm11, XMMWORD PTR [rdx + 208]
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    pxor xmm4, xmm10
    pxor xmm5, xmm11
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    movdqu xmm10, XMMWORD PTR [rdx + 224]
    movdqu xmm11, XMMWORD PTR [rdx + 240]
    aesdec xmm0, xmm10
    aesdec xmm1, xmm11
    aesdec xmm2, xmm10
    aesdec xmm3, xmm11
    aesdec xmm4, xmm10
    aesdec xmm5, xmm11
    aesdec xmm6, xmm10
    aesdec xmm7, xmm11
    aesenc xmm0, xmm8
    aesdec xmm1, xmm8
    aesenc xmm2, xmm8
    aesdec xmm3, xmm8
    aesenc xmm4, xmm8
    aesdec xmm5, xmm8
    aesenc xmm6, xmm8
    aesdec xmm7, xmm8
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm12, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm12, xmm1
    movdqa xmm1, xmm12
    pshufb xmm2, xmm9
    pshufb xmm3, xmm9
    movdqa xmm12, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm12, xmm3
    movdqa xmm3, xmm12
    pshufb xmm4, xmm9
    pshufb xmm5, xmm9
    movdqa xmm12, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm12, xmm5
    movdqa xmm5, xmm12
    pshufb xmm6, xmm9
    pshufb xmm7, xmm9
    movdqa xmm12, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm12, xmm7
    movdqa xmm7, xmm12
    movdqu xmm10, XMMWORD PTR [rdx + 256]
    movdqu xmm11, XMMWORD PTR [rdx + 272]
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    pxor xmm4, xmm10
    pxor xmm5, xmm11
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    movdqu xmm10, XMMWORD PTR [rdx + 288]
    movdqu xmm11, XMMWORD PTR [rdx + 304]
    aesdec xmm0, xmm10
    aesdec xmm1, xmm11
    aesdec xmm2, xmm10
    aesdec xmm3, xmm11
    aesdec xmm4, xmm10
    aesdec xmm5, xmm11
    aesdec xmm6, xmm10
    aesdec xmm7, xmm11
    aesenc xmm0, xmm8
    aesdec xmm1, xmm8
    aesenc xmm2, xmm8
    aesdec xmm3, xmm8
    aesenc xmm4, xmm8
    aesdec xmm5, xmm8
    aesenc xmm6, xmm8
    aesdec xmm7, xmm8
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm12, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm12, xmm1
    movdqa xmm1, xmm12
    pshufb xmm2, xmm9
    pshufb xmm3, xmm9
    movdqa xmm12, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm12, xmm3
    movdqa xmm3, xmm12
    pshufb xmm4, xmm9
    pshufb xmm5, xmm9
    movdqa xmm12, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm12, xmm5
    movdqa xmm5, xmm12
    pshufb xmm6, xmm9
    pshufb xmm7, xmm9
    movdqa xmm12, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm12, xmm7
    movdqa xmm7, xmm12
    movdqu xmm10, XMMWORD PTR [rdx + 320]
    movdqu xmm11, XMMWORD PTR [rdx + 336]
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    pxor xmm4, xmm10
    pxor xmm5, xmm11
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    movdqu xmm10, XMMWORD PTR [rdx + 352]
    movdqu xmm11, XMMWORD PTR [rdx + 368]
    aesdec xmm0, xmm10
    aesdec xmm1, xmm11
    aesdec xmm2, xmm10
    aesdec xmm3, xmm11
    aesdec xmm4, xmm10
    aesdec xmm5, xmm11
    aesdec xmm6, xmm10
    aesdec xmm7, xmm11
    movdqu xmm10, XMMWORD PTR [rdx + 384]
    movdqu xmm11, XMMWORD PTR [rdx + 400]
    aesenc xmm0, xmm10
    aesdec xmm1, xmm11
    movdqu XMMWORD PTR [rdi], xmm0
    movdqu XMMWORD PTR [rdi + 16], xmm1
    aesenc xmm2, xmm10
    aesdec xmm3, xmm11
    movdqu XMMWORD PTR [rdi + 32], xmm2
    movdqu XMMWORD PTR [rdi + 48], xmm3
    aesenc xmm4, xmm10
    aesdec xmm5, xmm11
    movdqu XMMWORD PTR [rdi + 64], xmm4
    movdqu XMMWORD PTR [rdi + 80], xmm5
    aesenc xmm6, xmm10
    aesdec xmm7, xmm11
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 136
    xor rdx, rdx
    ret
areion_asura_encrypt_4blocks_asm ENDP

PUBLIC areion_asura_decrypt_4blocks_asm
ALIGN 16
areion_asura_decrypt_4blocks_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 120
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    movdqu XMMWORD PTR [rsp + 64], xmm9
    movdqu XMMWORD PTR [rsp + 80], xmm10
    movdqu XMMWORD PTR [rsp + 96], xmm11
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    movdqu xmm2, XMMWORD PTR [rsi + 32]
    movdqu xmm3, XMMWORD PTR [rsi + 48]
    movdqu xmm4, XMMWORD PTR [rsi + 64]
    movdqu xmm5, XMMWORD PTR [rsi + 80]
    movdqu xmm6, XMMWORD PTR [rsi + 96]
    movdqu xmm7, XMMWORD PTR [rsi + 112]
    pxor xmm8, xmm8
    movdqu xmm9, XMMWORD PTR [rdx + 384]
    movdqu xmm10, XMMWORD PTR [rdx + 400]
    pxor xmm0, xmm9
    pxor xmm1, xmm10
    pxor xmm2, xmm9
    pxor xmm3, xmm10
    pxor xmm4, xmm9
    pxor xmm5, xmm10
    pxor xmm6, xmm9
    pxor xmm7, xmm10
    movdqu xmm9, XMMWORD PTR [rdx + 352]
    movdqu xmm10, XMMWORD PTR [rdx + 368]
    aesdeclast xmm10, xmm8
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm8
    aesimc xmm2, xmm2
    aesdeclast xmm3, xmm8
    aesimc xmm4, xmm4
    aesdeclast xmm5, xmm8
    aesimc xmm6, xmm6
    aesdeclast xmm7, xmm8
    aesenc xmm10, xmm8
    aesdeclast xmm0, xmm9
    aesenc xmm1, xmm8
    aesdeclast xmm2, xmm9
    aesenc xmm3, xmm8
    aesdeclast xmm4, xmm9
    aesenc xmm5, xmm8
    aesdeclast xmm6, xmm9
    aesenc xmm7, xmm8
    aesdeclast xmm0, xmm8
    aesenc xmm1, xmm10
    aesdeclast xmm2, xmm8
    aesenc xmm3, xmm10
    aesdeclast xmm4, xmm8
    aesenc xmm5, xmm10
    aesdeclast xmm6, xmm8
    aesenc xmm7, xmm10
    movdqu xmm9, XMMWORD PTR [rdx + 320]
    movdqu xmm10, XMMWORD PTR [rdx + 336]
    aesenc xmm0, xmm8
    aesenc xmm2, xmm8
    aesenc xmm4, xmm8
    aesenc xmm6, xmm8
    aesenclast xmm0, xmm9
    aesenclast xmm1, xmm10
    aesenclast xmm2, xmm9
    aesenclast xmm3, xmm10
    aesenclast xmm4, xmm9
    aesenclast xmm5, xmm10
    aesenclast xmm6, xmm9
    aesenclast xmm7, xmm10
    movdqu xmm9, XMMWORD PTR [rdx + 288]
    movdqu xmm10, XMMWORD PTR [rdx + 304]
    aesdeclast xmm10, xmm8
    movdqa xmm11, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm11, xmm1
    movdqa xmm1, xmm11
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm8
    movdqa xmm11, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm11, xmm3
    movdqa xmm3, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm3, xmm8
    movdqa xmm11, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm11, xmm5
    movdqa xmm5, xmm11
    aesimc xmm4, xmm4
    aesdeclast xmm5, xmm8
    movdqa xmm11, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm11, xmm7
    movdqa xmm7, xmm11
    aesimc xmm6, xmm6
    aesdeclast xmm7, xmm8
    aesenc xmm10, xmm8
    aesdeclast xmm0, xmm9
    aesenc xmm1, xmm8
    aesdeclast xmm2, xmm9
    aesenc xmm3, xmm8
    aesdeclast xmm4, xmm9
    aesenc xmm5, xmm8
    aesdeclast xmm6, xmm9
    aesenc xmm7, xmm8
    aesdeclast xmm0, xmm8
    aesenc xmm1, xmm10
    aesdeclast xmm2, xmm8
    aesenc xmm3, xmm10
    aesdeclast xmm4, xmm8
    aesenc xmm5, xmm10
    aesdeclast xmm6, xmm8
    aesenc xmm7, xmm10
    movdqu xmm9, XMMWORD PTR [rdx + 256]
    movdqu xmm10, XMMWORD PTR [rdx + 272]
    aesenc xmm0, xmm8
    aesenc xmm2, xmm8
    aesenc xmm4, xmm8
    aesenc xmm6, xmm8
    aesenclast xmm0, xmm9
    aesenclast xmm1, xmm10
    aesenclast xmm2, xmm9
    aesenclast xmm3, xmm10
    aesenclast xmm4, xmm9
    aesenclast xmm5, xmm10
    aesenclast xmm6, xmm9
    aesenclast xmm7, xmm10
    movdqu xmm9, XMMWORD PTR [rdx + 224]
    movdqu xmm10, XMMWORD PTR [rdx + 240]
    aesdeclast xmm10, xmm8
    movdqa xmm11, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm11, xmm1
    movdqa xmm1, xmm11
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm8
    movdqa xmm11, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm11, xmm3
    movdqa xmm3, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm3, xmm8
    movdqa xmm11, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm11, xmm5
    movdqa xmm5, xmm11
    aesimc xmm4, xmm4
    aesdeclast xmm5, xmm8
    movdqa xmm11, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm11, xmm7
    movdqa xmm7, xmm11
    aesimc xmm6, xmm6
    aesdeclast xmm7, xmm8
    aesenc xmm10, xmm8
    aesdeclast xmm0, xmm9
    aesenc xmm1, xmm8
    aesdeclast xmm2, xmm9
    aesenc xmm3, xmm8
    aesdeclast xmm4, xmm9
    aesenc xmm5, xmm8
    aesdeclast xmm6, xmm9
    aesenc xmm7, xmm8
    aesdeclast xmm0, xmm8
    aesenc xmm1, xmm10
    aesdeclast xmm2, xmm8
    aesenc xmm3, xmm10
    aesdeclast xmm4, xmm8
    aesenc xmm5, xmm10
    aesdeclast xmm6, xmm8
    aesenc xmm7, xmm10
    movdqu xmm9, XMMWORD PTR [rdx + 192]
    movdqu xmm10, XMMWORD PTR [rdx + 208]
    aesenc xmm0, xmm8
    aesenc xmm2, xmm8
    aesenc xmm4, xmm8
    aesenc xmm6, xmm8
    aesenclast xmm0, xmm9
    aesenclast xmm1, xmm10
    aesenclast xmm2, xmm9
    aesenclast xmm3, xmm10
    aesenclast xmm4, xmm9
    aesenclast xmm5, xmm10
    aesenclast xmm6, xmm9
    aesenclast xmm7, xmm10
    movdqu xmm9, XMMWORD PTR [rdx + 160]
    movdqu xmm10, XMMWORD PTR [rdx + 176]
    aesdeclast xmm10, xmm8
    movdqa xmm11, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm11, xmm1
    movdqa xmm1, xmm11
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm8
    movdqa xmm11, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm11, xmm3
    movdqa xmm3, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm3, xmm8
    movdqa xmm11, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm11, xmm5
    movdqa xmm5, xmm11
    aesimc xmm4, xmm4
    aesdeclast xmm5, xmm8
    movdqa xmm11, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm11, xmm7
    movdqa xmm7, xmm11
    aesimc xmm6, xmm6
    aesdeclast xmm7, xmm8
    aesenc xmm10, xmm8
    aesdeclast xmm0, xmm9
    aesenc xmm1, xmm8
    aesdeclast xmm2, xmm9
    aesenc xmm3, xmm8
    aesdeclast xmm4, xmm9
    aesenc xmm5, xmm8
    aesdeclast xmm6, xmm9
    aesenc xmm7, xmm8
    aesdeclast xmm0, xmm8
    aesenc xmm1, xmm10
    aesdeclast xmm2, xmm8
    aesenc xmm3, xmm10
    aesdeclast xmm4, xmm8
    aesenc xmm5, xmm10
    aesdeclast xmm6, xmm8
    aesenc xmm7, xmm10
    movdqu xmm9, XMMWORD PTR [rdx + 128]
    movdqu xmm10, XMMWORD PTR [rdx + 144]
    aesenc xmm0, xmm8
    aesenc xmm2, xmm8
    aesenc xmm4, xmm8
    aesenc xmm6, xmm8
    aesenclast xmm0, xmm9
    aesenclast xmm1, xmm10
    aesenclast xmm2, xmm9
    aesenclast xmm3, xmm10
    aesenclast xmm4, xmm9
    aesenclast xmm5, xmm10
    aesenclast xmm6, xmm9
    aesenclast xmm7, xmm10
    movdqu xmm9, XMMWORD PTR [rdx + 96]
    movdqu xmm10, XMMWORD PTR [rdx + 112]
    aesdeclast xmm10, xmm8
    movdqa xmm11, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm11, xmm1
    movdqa xmm1, xmm11
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm8
    movdqa xmm11, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm11, xmm3
    movdqa xmm3, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm3, xmm8
    movdqa xmm11, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm11, xmm5
    movdqa xmm5, xmm11
    aesimc xmm4, xmm4
    aesdeclast xmm5, xmm8
    movdqa xmm11, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm11, xmm7
    movdqa xmm7, xmm11
    aesimc xmm6, xmm6
    aesdeclast xmm7, xmm8
    aesenc xmm10, xmm8
    aesdeclast xmm0, xmm9
    aesenc xmm1, xmm8
    aesdeclast xmm2, xmm9
    aesenc xmm3, xmm8
    aesdeclast xmm4, xmm9
    aesenc xmm5, xmm8
    aesdeclast xmm6, xmm9
    aesenc xmm7, xmm8
    aesdeclast xmm0, xmm8
    aesenc xmm1, xmm10
    aesdeclast xmm2, xmm8
    aesenc xmm3, xmm10
    aesdeclast xmm4, xmm8
    aesenc xmm5, xmm10
    aesdeclast xmm6, xmm8
    aesenc xmm7, xmm10
    movdqu xmm9, XMMWORD PTR [rdx + 64]
    movdqu xmm10, XMMWORD PTR [rdx + 80]
    aesenc xmm0, xmm8
    aesenc xmm2, xmm8
    aesenc xmm4, xmm8
    aesenc xmm6, xmm8
    aesenclast xmm0, xmm9
    aesenclast xmm1, xmm10
    aesenclast xmm2, xmm9
    aesenclast xmm3, xmm10
    aesenclast xmm4, xmm9
    aesenclast xmm5, xmm10
    aesenclast xmm6, xmm9
    aesenclast xmm7, xmm10
    movdqu xmm9, XMMWORD PTR [rdx + 32]
    movdqu xmm10, XMMWORD PTR [rdx + 48]
    aesdeclast xmm10, xmm8
    movdqa xmm11, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm11, xmm1
    movdqa xmm1, xmm11
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm8
    movdqa xmm11, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm11, xmm3
    movdqa xmm3, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm3, xmm8
    movdqa xmm11, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm11, xmm5
    movdqa xmm5, xmm11
    aesimc xmm4, xmm4
    aesdeclast xmm5, xmm8
    movdqa xmm11, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm11, xmm7
    movdqa xmm7, xmm11
    aesimc xmm6, xmm6
    aesdeclast xmm7, xmm8
    aesenc xmm10, xmm8
    aesdeclast xmm0, xmm9
    aesenc xmm1, xmm8
    aesdeclast xmm2, xmm9
    aesenc xmm3, xmm8
    aesdeclast xmm4, xmm9
    aesenc xmm5, xmm8
    aesdeclast xmm6, xmm9
    aesenc xmm7, xmm8
    aesdeclast xmm0, xmm8
    aesenc xmm1, xmm10
    aesdeclast xmm2, xmm8
    aesenc xmm3, xmm10
    aesdeclast xmm4, xmm8
    aesenc xmm5, xmm10
    aesdeclast xmm6, xmm8
    aesenc xmm7, xmm10
    movdqu xmm9, XMMWORD PTR [rdx]
    movdqu xmm10, XMMWORD PTR [rdx + 16]
    aesenc xmm0, xmm8
    aesenc xmm2, xmm8
    aesenc xmm4, xmm8
    aesenc xmm6, xmm8
    aesenclast xmm0, xmm9
    aesenclast xmm1, xmm10
    aesenclast xmm2, xmm9
    aesenclast xmm3, xmm10
    aesenclast xmm4, xmm9
    aesenclast xmm5, xmm10
    aesenclast xmm6, xmm9
    aesenclast xmm7, xmm10
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 120
    xor rdx, rdx
    ret
areion_asura_decrypt_4blocks_asm ENDP

PUBLIC areion_asura_encrypt_4blocks_otf_asm
ALIGN 16
areion_asura_encrypt_4blocks_otf_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    movdqu xmm10, XMMWORD PTR [rcx]
    movdqu xmm11, XMMWORD PTR [rcx + 16]
    movdqu xmm12, XMMWORD PTR [rcx + 32]
    movdqu xmm13, XMMWORD PTR [rcx + 48]
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    pxor xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    pxor xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    pxor xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    pxor xmm7, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 16]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesdec xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesdec xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesdec xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesdec xmm7, xmm15
    pxor xmm14, xmm14
    aesenc xmm0, xmm14
    aesdec xmm1, xmm14
    pshufb xmm0, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm1, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm15, xmm1
    movdqa xmm1, xmm15
    aesenc xmm2, xmm14
    aesdec xmm3, xmm14
    pshufb xmm2, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm15, xmm3
    movdqa xmm3, xmm15
    aesenc xmm4, xmm14
    aesdec xmm5, xmm14
    pshufb xmm4, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm5, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm15, xmm5
    movdqa xmm5, xmm15
    aesenc xmm6, xmm14
    aesdec xmm7, xmm14
    pshufb xmm6, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm7, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm15, xmm7
    movdqa xmm7, xmm15
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 32]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    pxor xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    pxor xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    pxor xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    pxor xmm7, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 48]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesdec xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesdec xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesdec xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesdec xmm7, xmm15
    pxor xmm14, xmm14
    aesenc xmm0, xmm14
    aesdec xmm1, xmm14
    pshufb xmm0, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm1, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm15, xmm1
    movdqa xmm1, xmm15
    aesenc xmm2, xmm14
    aesdec xmm3, xmm14
    pshufb xmm2, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm15, xmm3
    movdqa xmm3, xmm15
    aesenc xmm4, xmm14
    aesdec xmm5, xmm14
    pshufb xmm4, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm5, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm15, xmm5
    movdqa xmm5, xmm15
    aesenc xmm6, xmm14
    aesdec xmm7, xmm14
    pshufb xmm6, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm7, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm15, xmm7
    movdqa xmm7, xmm15
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 64]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    pxor xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    pxor xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    pxor xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    pxor xmm7, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 80]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesdec xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesdec xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesdec xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesdec xmm7, xmm15
    pxor xmm14, xmm14
    aesenc xmm0, xmm14
    aesdec xmm1, xmm14
    pshufb xmm0, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm1, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm15, xmm1
    movdqa xmm1, xmm15
    aesenc xmm2, xmm14
    aesdec xmm3, xmm14
    pshufb xmm2, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm15, xmm3
    movdqa xmm3, xmm15
    aesenc xmm4, xmm14
    aesdec xmm5, xmm14
    pshufb xmm4, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm5, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm15, xmm5
    movdqa xmm5, xmm15
    aesenc xmm6, xmm14
    aesdec xmm7, xmm14
    pshufb xmm6, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm7, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm15, xmm7
    movdqa xmm7, xmm15
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 96]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    pxor xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    pxor xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    pxor xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    pxor xmm7, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 112]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesdec xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesdec xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesdec xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesdec xmm7, xmm15
    pxor xmm14, xmm14
    aesenc xmm0, xmm14
    aesdec xmm1, xmm14
    pshufb xmm0, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm1, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm15, xmm1
    movdqa xmm1, xmm15
    aesenc xmm2, xmm14
    aesdec xmm3, xmm14
    pshufb xmm2, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm15, xmm3
    movdqa xmm3, xmm15
    aesenc xmm4, xmm14
    aesdec xmm5, xmm14
    pshufb xmm4, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm5, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm15, xmm5
    movdqa xmm5, xmm15
    aesenc xmm6, xmm14
    aesdec xmm7, xmm14
    pshufb xmm6, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm7, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm15, xmm7
    movdqa xmm7, xmm15
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 128]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    pxor xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    pxor xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    pxor xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    pxor xmm7, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 144]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesdec xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesdec xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesdec xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesdec xmm7, xmm15
    pxor xmm14, xmm14
    aesenc xmm0, xmm14
    aesdec xmm1, xmm14
    pshufb xmm0, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm1, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm15, xmm1
    movdqa xmm1, xmm15
    aesenc xmm2, xmm14
    aesdec xmm3, xmm14
    pshufb xmm2, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm3, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm15, xmm3
    movdqa xmm3, xmm15
    aesenc xmm4, xmm14
    aesdec xmm5, xmm14
    pshufb xmm4, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm5, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm15, xmm5
    movdqa xmm5, xmm15
    aesenc xmm6, xmm14
    aesdec xmm7, xmm14
    pshufb xmm6, XMMWORD PTR [asuraConsts + 64]
    pshufb xmm7, XMMWORD PTR [asuraConsts + 64]
    movdqa xmm15, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm15, xmm7
    movdqa xmm7, xmm15
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 160]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    pxor xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    pxor xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    pxor xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    pxor xmm7, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 176]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesdec xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesdec xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesdec xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesdec xmm7, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 192]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesenc xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesdec xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesenc xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesdec xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesenc xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesdec xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesenc xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesdec xmm7, xmm15
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    xor rcx, rcx
    xor rdx, rdx
    ret
areion_asura_encrypt_4blocks_otf_asm ENDP

PUBLIC areion_asura_decrypt_4blocks_otf_asm
ALIGN 16
areion_asura_decrypt_4blocks_otf_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    movdqu xmm10, XMMWORD PTR [rcx]
    movdqu xmm11, XMMWORD PTR [rcx + 16]
    movdqu xmm12, XMMWORD PTR [rcx + 32]
    movdqu xmm13, XMMWORD PTR [rcx + 48]
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    pxor xmm14, xmm14
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm12, xmm14
    aesenc xmm13, xmm14
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pshufb xmm8, XMMWORD PTR [asuraConsts]
    pshufb xmm9, XMMWORD PTR [asuraConsts]
    movdqa xmm15, xmm14
    pcmpgtb xmm14, xmm8
    pcmpgtb xmm15, xmm9
    pand xmm14, XMMWORD PTR [asuraGFConsts]
    pand xmm15, XMMWORD PTR [asuraGFConsts]
    paddb xmm8, xmm8
    paddb xmm9, xmm9
    pxor xmm8, xmm14
    pxor xmm9, xmm15
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 192]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    pxor xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    pxor xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    pxor xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    pxor xmm7, xmm15
    pxor xmm14, xmm14
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm14
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm14
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm14
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm14
    movdqa xmm15, xmm8
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm8, 1
    pand xmm8, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm8, xmm14
    pxor xmm14, xmm14
    movdqa xmm15, xmm9
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm9, 1
    pand xmm9, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm9, xmm14
    pshufb xmm8, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm9, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pxor xmm14, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 176]
    pxor xmm15, xmm10
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm1, xmm14
    aesenc xmm1, xmm14
    aesenc xmm1, xmm15
    aesdeclast xmm0, xmm14
    aesenc xmm0, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 176]
    pxor xmm15, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm3, xmm14
    aesenc xmm3, xmm14
    aesenc xmm3, xmm15
    aesdeclast xmm2, xmm14
    aesenc xmm2, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 176]
    pxor xmm15, xmm12
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm5, xmm14
    aesenc xmm5, xmm14
    aesenc xmm5, xmm15
    aesdeclast xmm4, xmm14
    aesenc xmm4, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 176]
    pxor xmm15, xmm13
    aesimc xmm6, xmm6
    aesdeclast xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm7, xmm14
    aesenc xmm7, xmm14
    aesenc xmm7, xmm15
    aesdeclast xmm6, xmm14
    aesenc xmm6, xmm14
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm14
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm14
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm14
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm14
    movdqa xmm15, xmm8
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm8, 1
    pand xmm8, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm8, xmm14
    pxor xmm14, xmm14
    movdqa xmm15, xmm9
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm9, 1
    pand xmm9, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm9, xmm14
    pshufb xmm8, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm9, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 160]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesenclast xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesenclast xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesenclast xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesenclast xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesenclast xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesenclast xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesenclast xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesenclast xmm7, xmm15
    movdqa xmm14, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm14, xmm1
    movdqa xmm1, xmm14
    movdqa xmm14, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm14, xmm3
    movdqa xmm3, xmm14
    movdqa xmm14, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm14, xmm5
    movdqa xmm5, xmm14
    movdqa xmm14, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm14, xmm7
    movdqa xmm7, xmm14
    pxor xmm14, xmm14
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm14
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm14
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm14
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm14
    movdqa xmm15, xmm8
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm8, 1
    pand xmm8, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm8, xmm14
    pxor xmm14, xmm14
    movdqa xmm15, xmm9
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm9, 1
    pand xmm9, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm9, xmm14
    pshufb xmm8, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm9, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pxor xmm14, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 144]
    pxor xmm15, xmm10
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm1, xmm14
    aesenc xmm1, xmm14
    aesenc xmm1, xmm15
    aesdeclast xmm0, xmm14
    aesenc xmm0, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 144]
    pxor xmm15, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm3, xmm14
    aesenc xmm3, xmm14
    aesenc xmm3, xmm15
    aesdeclast xmm2, xmm14
    aesenc xmm2, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 144]
    pxor xmm15, xmm12
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm5, xmm14
    aesenc xmm5, xmm14
    aesenc xmm5, xmm15
    aesdeclast xmm4, xmm14
    aesenc xmm4, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 144]
    pxor xmm15, xmm13
    aesimc xmm6, xmm6
    aesdeclast xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm7, xmm14
    aesenc xmm7, xmm14
    aesenc xmm7, xmm15
    aesdeclast xmm6, xmm14
    aesenc xmm6, xmm14
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm14
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm14
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm14
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm14
    movdqa xmm15, xmm8
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm8, 1
    pand xmm8, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm8, xmm14
    pxor xmm14, xmm14
    movdqa xmm15, xmm9
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm9, 1
    pand xmm9, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm9, xmm14
    pshufb xmm8, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm9, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 128]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesenclast xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesenclast xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesenclast xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesenclast xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesenclast xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesenclast xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesenclast xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesenclast xmm7, xmm15
    movdqa xmm14, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm14, xmm1
    movdqa xmm1, xmm14
    movdqa xmm14, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm14, xmm3
    movdqa xmm3, xmm14
    movdqa xmm14, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm14, xmm5
    movdqa xmm5, xmm14
    movdqa xmm14, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm14, xmm7
    movdqa xmm7, xmm14
    pxor xmm14, xmm14
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm14
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm14
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm14
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm14
    movdqa xmm15, xmm8
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm8, 1
    pand xmm8, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm8, xmm14
    pxor xmm14, xmm14
    movdqa xmm15, xmm9
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm9, 1
    pand xmm9, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm9, xmm14
    pshufb xmm8, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm9, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pxor xmm14, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 112]
    pxor xmm15, xmm10
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm1, xmm14
    aesenc xmm1, xmm14
    aesenc xmm1, xmm15
    aesdeclast xmm0, xmm14
    aesenc xmm0, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 112]
    pxor xmm15, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm3, xmm14
    aesenc xmm3, xmm14
    aesenc xmm3, xmm15
    aesdeclast xmm2, xmm14
    aesenc xmm2, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 112]
    pxor xmm15, xmm12
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm5, xmm14
    aesenc xmm5, xmm14
    aesenc xmm5, xmm15
    aesdeclast xmm4, xmm14
    aesenc xmm4, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 112]
    pxor xmm15, xmm13
    aesimc xmm6, xmm6
    aesdeclast xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm7, xmm14
    aesenc xmm7, xmm14
    aesenc xmm7, xmm15
    aesdeclast xmm6, xmm14
    aesenc xmm6, xmm14
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm14
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm14
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm14
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm14
    movdqa xmm15, xmm8
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm8, 1
    pand xmm8, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm8, xmm14
    pxor xmm14, xmm14
    movdqa xmm15, xmm9
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm9, 1
    pand xmm9, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm9, xmm14
    pshufb xmm8, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm9, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 96]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesenclast xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesenclast xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesenclast xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesenclast xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesenclast xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesenclast xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesenclast xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesenclast xmm7, xmm15
    movdqa xmm14, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm14, xmm1
    movdqa xmm1, xmm14
    movdqa xmm14, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm14, xmm3
    movdqa xmm3, xmm14
    movdqa xmm14, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm14, xmm5
    movdqa xmm5, xmm14
    movdqa xmm14, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm14, xmm7
    movdqa xmm7, xmm14
    pxor xmm14, xmm14
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm14
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm14
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm14
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm14
    movdqa xmm15, xmm8
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm8, 1
    pand xmm8, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm8, xmm14
    pxor xmm14, xmm14
    movdqa xmm15, xmm9
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm9, 1
    pand xmm9, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm9, xmm14
    pshufb xmm8, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm9, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pxor xmm14, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 80]
    pxor xmm15, xmm10
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm1, xmm14
    aesenc xmm1, xmm14
    aesenc xmm1, xmm15
    aesdeclast xmm0, xmm14
    aesenc xmm0, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 80]
    pxor xmm15, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm3, xmm14
    aesenc xmm3, xmm14
    aesenc xmm3, xmm15
    aesdeclast xmm2, xmm14
    aesenc xmm2, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 80]
    pxor xmm15, xmm12
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm5, xmm14
    aesenc xmm5, xmm14
    aesenc xmm5, xmm15
    aesdeclast xmm4, xmm14
    aesenc xmm4, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 80]
    pxor xmm15, xmm13
    aesimc xmm6, xmm6
    aesdeclast xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm7, xmm14
    aesenc xmm7, xmm14
    aesenc xmm7, xmm15
    aesdeclast xmm6, xmm14
    aesenc xmm6, xmm14
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm14
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm14
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm14
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm14
    movdqa xmm15, xmm8
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm8, 1
    pand xmm8, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm8, xmm14
    pxor xmm14, xmm14
    movdqa xmm15, xmm9
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm9, 1
    pand xmm9, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm9, xmm14
    pshufb xmm8, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm9, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 64]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesenclast xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesenclast xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesenclast xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesenclast xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesenclast xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesenclast xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesenclast xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesenclast xmm7, xmm15
    movdqa xmm14, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm14, xmm1
    movdqa xmm1, xmm14
    movdqa xmm14, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm14, xmm3
    movdqa xmm3, xmm14
    movdqa xmm14, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm14, xmm5
    movdqa xmm5, xmm14
    movdqa xmm14, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm14, xmm7
    movdqa xmm7, xmm14
    pxor xmm14, xmm14
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm14
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm14
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm14
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm14
    movdqa xmm15, xmm8
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm8, 1
    pand xmm8, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm8, xmm14
    pxor xmm14, xmm14
    movdqa xmm15, xmm9
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm9, 1
    pand xmm9, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm9, xmm14
    pshufb xmm8, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm9, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pxor xmm14, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 48]
    pxor xmm15, xmm10
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm1, xmm14
    aesenc xmm1, xmm14
    aesenc xmm1, xmm15
    aesdeclast xmm0, xmm14
    aesenc xmm0, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 48]
    pxor xmm15, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm3, xmm14
    aesenc xmm3, xmm14
    aesenc xmm3, xmm15
    aesdeclast xmm2, xmm14
    aesenc xmm2, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 48]
    pxor xmm15, xmm12
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm5, xmm14
    aesenc xmm5, xmm14
    aesenc xmm5, xmm15
    aesdeclast xmm4, xmm14
    aesenc xmm4, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 48]
    pxor xmm15, xmm13
    aesimc xmm6, xmm6
    aesdeclast xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm7, xmm14
    aesenc xmm7, xmm14
    aesenc xmm7, xmm15
    aesdeclast xmm6, xmm14
    aesenc xmm6, xmm14
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm14
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm14
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm14
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm14
    movdqa xmm15, xmm8
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm8, 1
    pand xmm8, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm8, xmm14
    pxor xmm14, xmm14
    movdqa xmm15, xmm9
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm9, 1
    pand xmm9, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm9, xmm14
    pshufb xmm8, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm9, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants + 32]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesenclast xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesenclast xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesenclast xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesenclast xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesenclast xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesenclast xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesenclast xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesenclast xmm7, xmm15
    movdqa xmm14, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm14, xmm1
    movdqa xmm1, xmm14
    movdqa xmm14, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm14, xmm3
    movdqa xmm3, xmm14
    movdqa xmm14, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm14, xmm5
    movdqa xmm5, xmm14
    movdqa xmm14, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm14, xmm7
    movdqa xmm7, xmm14
    pxor xmm14, xmm14
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm14
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm14
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm14
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm14
    movdqa xmm15, xmm8
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm8, 1
    pand xmm8, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm8, xmm14
    pxor xmm14, xmm14
    movdqa xmm15, xmm9
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm9, 1
    pand xmm9, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm9, xmm14
    pshufb xmm8, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm9, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    pxor xmm14, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 16]
    pxor xmm15, xmm10
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm1, xmm14
    aesenc xmm1, xmm14
    aesenc xmm1, xmm15
    aesdeclast xmm0, xmm14
    aesenc xmm0, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 16]
    pxor xmm15, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm3, xmm14
    aesenc xmm3, xmm14
    aesenc xmm3, xmm15
    aesdeclast xmm2, xmm14
    aesenc xmm2, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 16]
    pxor xmm15, xmm12
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm5, xmm14
    aesenc xmm5, xmm14
    aesenc xmm5, xmm15
    aesdeclast xmm4, xmm14
    aesenc xmm4, xmm14
    movdqa xmm15, xmm8
    pxor xmm15, XMMWORD PTR [asuraRoundConstants + 16]
    pxor xmm15, xmm13
    aesimc xmm6, xmm6
    aesdeclast xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesdeclast xmm15, xmm14
    aesenc xmm15, xmm14
    aesdeclast xmm7, xmm14
    aesenc xmm7, xmm14
    aesenc xmm7, xmm15
    aesdeclast xmm6, xmm14
    aesenc xmm6, xmm14
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm14
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm14
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm14
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm14
    movdqa xmm15, xmm8
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm8, 1
    pand xmm8, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm8, xmm14
    pxor xmm14, xmm14
    movdqa xmm15, xmm9
    psllw xmm15, 7
    pcmpgtb xmm14, xmm15
    pand xmm14, XMMWORD PTR [asuraGFConsts + 32]
    psrlw xmm9, 1
    pand xmm9, XMMWORD PTR [asuraGFConsts + 64]
    pxor xmm9, xmm14
    pshufb xmm8, XMMWORD PTR [asuraConsts + 32]
    pshufb xmm9, XMMWORD PTR [asuraConsts + 32]
    movdqa xmm15, xmm8
    pblendw xmm8, xmm9, 204
    pblendw xmm9, xmm15, 204
    movdqa xmm14, xmm8
    pxor xmm14, XMMWORD PTR [asuraRoundConstants]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesenclast xmm0, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm10
    aesenclast xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesenclast xmm2, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm11
    aesenclast xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesenclast xmm4, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm12
    aesenclast xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesenclast xmm6, xmm15
    movdqa xmm15, xmm9
    pxor xmm15, xmm13
    aesenclast xmm7, xmm15
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    xor rcx, rcx
    xor rdx, rdx
    ret
areion_asura_decrypt_4blocks_otf_asm ENDP

PUBLIC areion_asura_expand_tweakey_vex_asm
ALIGN 16
areion_asura_expand_tweakey_vex_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rdx]
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm0, xmm2
    vpxor xmm4, xmm4, XMMWORD PTR [asuraRoundConstants]
    vpxor xmm5, xmm1, xmm2
    vmovdqu XMMWORD PTR [rdi], xmm4
    vmovdqu XMMWORD PTR [rdi + 16], xmm5
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm4, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm4, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm4, xmm3, xmm0
    vpcmpgtb xmm5, xmm3, xmm1
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpand xmm5, xmm5, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm4, xmm0, xmm2
    vpxor xmm4, xmm4, XMMWORD PTR [asuraRoundConstants + 16]
    vpxor xmm5, xmm1, xmm2
    vmovdqu XMMWORD PTR [rdi + 32], xmm4
    vmovdqu XMMWORD PTR [rdi + 48], xmm5
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm4, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm4, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm4, xmm3, xmm0
    vpcmpgtb xmm5, xmm3, xmm1
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpand xmm5, xmm5, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm4, xmm0, xmm2
    vpxor xmm4, xmm4, XMMWORD PTR [asuraRoundConstants + 32]
    vpxor xmm5, xmm1, xmm2
    vmovdqu XMMWORD PTR [rdi + 64], xmm4
    vmovdqu XMMWORD PTR [rdi + 80], xmm5
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm4, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm4, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm4, xmm3, xmm0
    vpcmpgtb xmm5, xmm3, xmm1
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpand xmm5, xmm5, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm4, xmm0, xmm2
    vpxor xmm4, xmm4, XMMWORD PTR [asuraRoundConstants + 48]
    vpxor xmm5, xmm1, xmm2
    vmovdqu XMMWORD PTR [rdi + 96], xmm4
    vmovdqu XMMWORD PTR [rdi + 112], xmm5
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm4, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm4, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm4, xmm3, xmm0
    vpcmpgtb xmm5, xmm3, xmm1
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpand xmm5, xmm5, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm4, xmm0, xmm2
    vpxor xmm4, xmm4, XMMWORD PTR [asuraRoundConstants + 64]
    vpxor xmm5, xmm1, xmm2
    vmovdqu XMMWORD PTR [rdi + 128], xmm4
    vmovdqu XMMWORD PTR [rdi + 144], xmm5
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm4, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm4, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm4, xmm3, xmm0
    vpcmpgtb xmm5, xmm3, xmm1
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpand xmm5, xmm5, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm4, xmm0, xmm2
    vpxor xmm4, xmm4, XMMWORD PTR [asuraRoundConstants + 80]
    vpxor xmm5, xmm1, xmm2
    vmovdqu XMMWORD PTR [rdi + 160], xmm4
    vmovdqu XMMWORD PTR [rdi + 176], xmm5
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm4, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm4, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm4, xmm3, xmm0
    vpcmpgtb xmm5, xmm3, xmm1
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpand xmm5, xmm5, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm4, xmm0, xmm2
    vpxor xmm4, xmm4, XMMWORD PTR [asuraRoundConstants + 96]
    vpxor xmm5, xmm1, xmm2
    vmovdqu XMMWORD PTR [rdi + 192], xmm4
    vmovdqu XMMWORD PTR [rdi + 208], xmm5
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm4, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm4, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm4, xmm3, xmm0
    vpcmpgtb xmm5, xmm3, xmm1
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpand xmm5, xmm5, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm4, xmm0, xmm2
    vpxor xmm4, xmm4, XMMWORD PTR [asuraRoundConstants + 112]
    vpxor xmm5, xmm1, xmm2
    vmovdqu XMMWORD PTR [rdi + 224], xmm4
    vmovdqu XMMWORD PTR [rdi + 240], xmm5
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm4, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm4, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm4, xmm3, xmm0
    vpcmpgtb xmm5, xmm3, xmm1
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpand xmm5, xmm5, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm4, xmm0, xmm2
    vpxor xmm4, xmm4, XMMWORD PTR [asuraRoundConstants + 128]
    vpxor xmm5, xmm1, xmm2
    vmovdqu XMMWORD PTR [rdi + 256], xmm4
    vmovdqu XMMWORD PTR [rdi + 272], xmm5
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm4, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm4, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm4, xmm3, xmm0
    vpcmpgtb xmm5, xmm3, xmm1
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpand xmm5, xmm5, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm4, xmm0, xmm2
    vpxor xmm4, xmm4, XMMWORD PTR [asuraRoundConstants + 144]
    vpxor xmm5, xmm1, xmm2
    vmovdqu XMMWORD PTR [rdi + 288], xmm4
    vmovdqu XMMWORD PTR [rdi + 304], xmm5
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm4, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm4, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm4, xmm3, xmm0
    vpcmpgtb xmm5, xmm3, xmm1
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpand xmm5, xmm5, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm4, xmm0, xmm2
    vpxor xmm4, xmm4, XMMWORD PTR [asuraRoundConstants + 160]
    vpxor xmm5, xmm1, xmm2
    vmovdqu XMMWORD PTR [rdi + 320], xmm4
    vmovdqu XMMWORD PTR [rdi + 336], xmm5
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm4, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm4, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm4, xmm3, xmm0
    vpcmpgtb xmm5, xmm3, xmm1
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpand xmm5, xmm5, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm4, xmm0, xmm2
    vpxor xmm4, xmm4, XMMWORD PTR [asuraRoundConstants + 176]
    vpxor xmm5, xmm1, xmm2
    vmovdqu XMMWORD PTR [rdi + 352], xmm4
    vmovdqu XMMWORD PTR [rdi + 368], xmm5
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm4, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm4, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm4, xmm3, xmm0
    vpcmpgtb xmm5, xmm3, xmm1
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpand xmm5, xmm5, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm4, xmm0, xmm2
    vpxor xmm4, xmm4, XMMWORD PTR [asuraRoundConstants + 192]
    vpxor xmm5, xmm1, xmm2
    vmovdqu XMMWORD PTR [rdi + 384], xmm4
    vmovdqu XMMWORD PTR [rdi + 400], xmm5
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    xor rdx, rdx
    ret
areion_asura_expand_tweakey_vex_asm ENDP

PUBLIC areion_asura_encrypt_block_vex_asm
ALIGN 16
areion_asura_encrypt_block_vex_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vpxor xmm2, xmm2, xmm2
    vmovdqa xmm3, XMMWORD PTR [asuraConsts + 64]
    vpxor xmm0, xmm0, XMMWORD PTR [rdx]
    vpxor xmm1, xmm1, XMMWORD PTR [rdx + 16]
    vaesdec xmm0, xmm0, XMMWORD PTR [rdx + 32]
    vaesdec xmm1, xmm1, XMMWORD PTR [rdx + 48]
    vaesenc xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm2
    vpshufb xmm4, xmm0, xmm3
    vpshufb xmm5, xmm1, xmm3
    vpunpcklqdq xmm0, xmm4, xmm5
    vpunpckhqdq xmm1, xmm4, xmm5
    vpxor xmm0, xmm0, XMMWORD PTR [rdx + 64]
    vpxor xmm1, xmm1, XMMWORD PTR [rdx + 80]
    vaesdec xmm0, xmm0, XMMWORD PTR [rdx + 96]
    vaesdec xmm1, xmm1, XMMWORD PTR [rdx + 112]
    vaesenc xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm2
    vpshufb xmm4, xmm0, xmm3
    vpshufb xmm5, xmm1, xmm3
    vpunpcklqdq xmm0, xmm4, xmm5
    vpunpckhqdq xmm1, xmm4, xmm5
    vpxor xmm0, xmm0, XMMWORD PTR [rdx + 128]
    vpxor xmm1, xmm1, XMMWORD PTR [rdx + 144]
    vaesdec xmm0, xmm0, XMMWORD PTR [rdx + 160]
    vaesdec xmm1, xmm1, XMMWORD PTR [rdx + 176]
    vaesenc xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm2
    vpshufb xmm4, xmm0, xmm3
    vpshufb xmm5, xmm1, xmm3
    vpunpcklqdq xmm0, xmm4, xmm5
    vpunpckhqdq xmm1, xmm4, xmm5
    vpxor xmm0, xmm0, XMMWORD PTR [rdx + 192]
    vpxor xmm1, xmm1, XMMWORD PTR [rdx + 208]
    vaesdec xmm0, xmm0, XMMWORD PTR [rdx + 224]
    vaesdec xmm1, xmm1, XMMWORD PTR [rdx + 240]
    vaesenc xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm2
    vpshufb xmm4, xmm0, xmm3
    vpshufb xmm5, xmm1, xmm3
    vpunpcklqdq xmm0, xmm4, xmm5
    vpunpckhqdq xmm1, xmm4, xmm5
    vpxor xmm0, xmm0, XMMWORD PTR [rdx + 256]
    vpxor xmm1, xmm1, XMMWORD PTR [rdx + 272]
    vaesdec xmm0, xmm0, XMMWORD PTR [rdx + 288]
    vaesdec xmm1, xmm1, XMMWORD PTR [rdx + 304]
    vaesenc xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm2
    vpshufb xmm4, xmm0, xmm3
    vpshufb xmm5, xmm1, xmm3
    vpunpcklqdq xmm0, xmm4, xmm5
    vpunpckhqdq xmm1, xmm4, xmm5
    vpxor xmm0, xmm0, XMMWORD PTR [rdx + 320]
    vpxor xmm1, xmm1, XMMWORD PTR [rdx + 336]
    vaesdec xmm0, xmm0, XMMWORD PTR [rdx + 352]
    vaesdec xmm1, xmm1, XMMWORD PTR [rdx + 368]
    vaesenc xmm0, xmm0, XMMWORD PTR [rdx + 384]
    vaesdec xmm1, xmm1, XMMWORD PTR [rdx + 400]
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    xor rdx, rdx
    ret
areion_asura_encrypt_block_vex_asm ENDP

PUBLIC areion_asura_decrypt_block_vex_asm
ALIGN 16
areion_asura_decrypt_block_vex_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vpxor xmm2, xmm2, xmm2
    vpxor xmm0, xmm0, XMMWORD PTR [rdx + 384]
    vpxor xmm1, xmm1, XMMWORD PTR [rdx + 400]
    vmovdqu xmm4, XMMWORD PTR [rdx + 368]
    vaesimc xmm0, xmm0
    vaesdeclast xmm1, xmm1, xmm2
    vaesdeclast xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, XMMWORD PTR [rdx + 352]
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm4
    vaesenc xmm0, xmm0, xmm2
    vaesenclast xmm0, xmm0, XMMWORD PTR [rdx + 320]
    vaesenclast xmm1, xmm1, XMMWORD PTR [rdx + 336]
    vpunpcklbw xmm3, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqu xmm4, XMMWORD PTR [rdx + 304]
    vaesimc xmm0, xmm3
    vaesdeclast xmm1, xmm1, xmm2
    vaesdeclast xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, XMMWORD PTR [rdx + 288]
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm4
    vaesenc xmm0, xmm0, xmm2
    vaesenclast xmm0, xmm0, XMMWORD PTR [rdx + 256]
    vaesenclast xmm1, xmm1, XMMWORD PTR [rdx + 272]
    vpunpcklbw xmm3, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqu xmm4, XMMWORD PTR [rdx + 240]
    vaesimc xmm0, xmm3
    vaesdeclast xmm1, xmm1, xmm2
    vaesdeclast xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, XMMWORD PTR [rdx + 224]
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm4
    vaesenc xmm0, xmm0, xmm2
    vaesenclast xmm0, xmm0, XMMWORD PTR [rdx + 192]
    vaesenclast xmm1, xmm1, XMMWORD PTR [rdx + 208]
    vpunpcklbw xmm3, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqu xmm4, XMMWORD PTR [rdx + 176]
    vaesimc xmm0, xmm3
    vaesdeclast xmm1, xmm1, xmm2
    vaesdeclast xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, XMMWORD PTR [rdx + 160]
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm4
    vaesenc xmm0, xmm0, xmm2
    vaesenclast xmm0, xmm0, XMMWORD PTR [rdx + 128]
    vaesenclast xmm1, xmm1, XMMWORD PTR [rdx + 144]
    vpunpcklbw xmm3, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqu xmm4, XMMWORD PTR [rdx + 112]
    vaesimc xmm0, xmm3
    vaesdeclast xmm1, xmm1, xmm2
    vaesdeclast xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, XMMWORD PTR [rdx + 96]
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm4
    vaesenc xmm0, xmm0, xmm2
    vaesenclast xmm0, xmm0, XMMWORD PTR [rdx + 64]
    vaesenclast xmm1, xmm1, XMMWORD PTR [rdx + 80]
    vpunpcklbw xmm3, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqu xmm4, XMMWORD PTR [rdx + 48]
    vaesimc xmm0, xmm3
    vaesdeclast xmm1, xmm1, xmm2
    vaesdeclast xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, XMMWORD PTR [rdx + 32]
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm4
    vaesenc xmm0, xmm0, xmm2
    vaesenclast xmm0, xmm0, XMMWORD PTR [rdx]
    vaesenclast xmm1, xmm1, XMMWORD PTR [rdx + 16]
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    xor rdx, rdx
    ret
areion_asura_decrypt_block_vex_asm ENDP

PUBLIC areion_asura_encrypt_block_otf_vex_asm
ALIGN 16
areion_asura_encrypt_block_otf_vex_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rdx]
    vmovdqu xmm3, XMMWORD PTR [rdx + 16]
    vmovdqu xmm4, XMMWORD PTR [rcx]
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm2, xmm4
    vpxor xmm6, xmm6, XMMWORD PTR [asuraRoundConstants]
    vpxor xmm7, xmm3, xmm4
    vpxor xmm0, xmm0, xmm6
    vpxor xmm1, xmm1, xmm7
    vaesenc xmm4, xmm4, xmm5
    vpblendw xmm6, xmm2, xmm3, 204
    vpblendw xmm3, xmm3, xmm2, 204
    vpshufb xmm2, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm5, xmm2
    vpcmpgtb xmm7, xmm5, xmm3
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm2, xmm2, xmm2
    vpaddb xmm3, xmm3, xmm3
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm6, xmm2, xmm4
    vpxor xmm6, xmm6, XMMWORD PTR [asuraRoundConstants + 16]
    vpxor xmm7, xmm3, xmm4
    vaesdec xmm0, xmm0, xmm6
    vaesdec xmm1, xmm1, xmm7
    vaesenc xmm0, xmm0, xmm5
    vaesdec xmm1, xmm1, xmm5
    vpshufb xmm8, xmm0, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm9, xmm1, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm0, xmm8, xmm9
    vpunpckhqdq xmm1, xmm8, xmm9
    vaesenc xmm4, xmm4, xmm5
    vpblendw xmm6, xmm2, xmm3, 204
    vpblendw xmm3, xmm3, xmm2, 204
    vpshufb xmm2, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm5, xmm2
    vpcmpgtb xmm7, xmm5, xmm3
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm2, xmm2, xmm2
    vpaddb xmm3, xmm3, xmm3
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm6, xmm2, xmm4
    vpxor xmm6, xmm6, XMMWORD PTR [asuraRoundConstants + 32]
    vpxor xmm7, xmm3, xmm4
    vpxor xmm0, xmm0, xmm6
    vpxor xmm1, xmm1, xmm7
    vaesenc xmm4, xmm4, xmm5
    vpblendw xmm6, xmm2, xmm3, 204
    vpblendw xmm3, xmm3, xmm2, 204
    vpshufb xmm2, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm5, xmm2
    vpcmpgtb xmm7, xmm5, xmm3
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm2, xmm2, xmm2
    vpaddb xmm3, xmm3, xmm3
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm6, xmm2, xmm4
    vpxor xmm6, xmm6, XMMWORD PTR [asuraRoundConstants + 48]
    vpxor xmm7, xmm3, xmm4
    vaesdec xmm0, xmm0, xmm6
    vaesdec xmm1, xmm1, xmm7
    vaesenc xmm0, xmm0, xmm5
    vaesdec xmm1, xmm1, xmm5
    vpshufb xmm8, xmm0, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm9, xmm1, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm0, xmm8, xmm9
    vpunpckhqdq xmm1, xmm8, xmm9
    vaesenc xmm4, xmm4, xmm5
    vpblendw xmm6, xmm2, xmm3, 204
    vpblendw xmm3, xmm3, xmm2, 204
    vpshufb xmm2, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm5, xmm2
    vpcmpgtb xmm7, xmm5, xmm3
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm2, xmm2, xmm2
    vpaddb xmm3, xmm3, xmm3
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm6, xmm2, xmm4
    vpxor xmm6, xmm6, XMMWORD PTR [asuraRoundConstants + 64]
    vpxor xmm7, xmm3, xmm4
    vpxor xmm0, xmm0, xmm6
    vpxor xmm1, xmm1, xmm7
    vaesenc xmm4, xmm4, xmm5
    vpblendw xmm6, xmm2, xmm3, 204
    vpblendw xmm3, xmm3, xmm2, 204
    vpshufb xmm2, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm5, xmm2
    vpcmpgtb xmm7, xmm5, xmm3
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm2, xmm2, xmm2
    vpaddb xmm3, xmm3, xmm3
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm6, xmm2, xmm4
    vpxor xmm6, xmm6, XMMWORD PTR [asuraRoundConstants + 80]
    vpxor xmm7, xmm3, xmm4
    vaesdec xmm0, xmm0, xmm6
    vaesdec xmm1, xmm1, xmm7
    vaesenc xmm0, xmm0, xmm5
    vaesdec xmm1, xmm1, xmm5
    vpshufb xmm8, xmm0, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm9, xmm1, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm0, xmm8, xmm9
    vpunpckhqdq xmm1, xmm8, xmm9
    vaesenc xmm4, xmm4, xmm5
    vpblendw xmm6, xmm2, xmm3, 204
    vpblendw xmm3, xmm3, xmm2, 204
    vpshufb xmm2, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm5, xmm2
    vpcmpgtb xmm7, xmm5, xmm3
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm2, xmm2, xmm2
    vpaddb xmm3, xmm3, xmm3
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm6, xmm2, xmm4
    vpxor xmm6, xmm6, XMMWORD PTR [asuraRoundConstants + 96]
    vpxor xmm7, xmm3, xmm4
    vpxor xmm0, xmm0, xmm6
    vpxor xmm1, xmm1, xmm7
    vaesenc xmm4, xmm4, xmm5
    vpblendw xmm6, xmm2, xmm3, 204
    vpblendw xmm3, xmm3, xmm2, 204
    vpshufb xmm2, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm5, xmm2
    vpcmpgtb xmm7, xmm5, xmm3
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm2, xmm2, xmm2
    vpaddb xmm3, xmm3, xmm3
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm6, xmm2, xmm4
    vpxor xmm6, xmm6, XMMWORD PTR [asuraRoundConstants + 112]
    vpxor xmm7, xmm3, xmm4
    vaesdec xmm0, xmm0, xmm6
    vaesdec xmm1, xmm1, xmm7
    vaesenc xmm0, xmm0, xmm5
    vaesdec xmm1, xmm1, xmm5
    vpshufb xmm8, xmm0, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm9, xmm1, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm0, xmm8, xmm9
    vpunpckhqdq xmm1, xmm8, xmm9
    vaesenc xmm4, xmm4, xmm5
    vpblendw xmm6, xmm2, xmm3, 204
    vpblendw xmm3, xmm3, xmm2, 204
    vpshufb xmm2, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm5, xmm2
    vpcmpgtb xmm7, xmm5, xmm3
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm2, xmm2, xmm2
    vpaddb xmm3, xmm3, xmm3
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm6, xmm2, xmm4
    vpxor xmm6, xmm6, XMMWORD PTR [asuraRoundConstants + 128]
    vpxor xmm7, xmm3, xmm4
    vpxor xmm0, xmm0, xmm6
    vpxor xmm1, xmm1, xmm7
    vaesenc xmm4, xmm4, xmm5
    vpblendw xmm6, xmm2, xmm3, 204
    vpblendw xmm3, xmm3, xmm2, 204
    vpshufb xmm2, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm5, xmm2
    vpcmpgtb xmm7, xmm5, xmm3
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm2, xmm2, xmm2
    vpaddb xmm3, xmm3, xmm3
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm6, xmm2, xmm4
    vpxor xmm6, xmm6, XMMWORD PTR [asuraRoundConstants + 144]
    vpxor xmm7, xmm3, xmm4
    vaesdec xmm0, xmm0, xmm6
    vaesdec xmm1, xmm1, xmm7
    vaesenc xmm0, xmm0, xmm5
    vaesdec xmm1, xmm1, xmm5
    vpshufb xmm8, xmm0, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm9, xmm1, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm0, xmm8, xmm9
    vpunpckhqdq xmm1, xmm8, xmm9
    vaesenc xmm4, xmm4, xmm5
    vpblendw xmm6, xmm2, xmm3, 204
    vpblendw xmm3, xmm3, xmm2, 204
    vpshufb xmm2, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm5, xmm2
    vpcmpgtb xmm7, xmm5, xmm3
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm2, xmm2, xmm2
    vpaddb xmm3, xmm3, xmm3
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm6, xmm2, xmm4
    vpxor xmm6, xmm6, XMMWORD PTR [asuraRoundConstants + 160]
    vpxor xmm7, xmm3, xmm4
    vpxor xmm0, xmm0, xmm6
    vpxor xmm1, xmm1, xmm7
    vaesenc xmm4, xmm4, xmm5
    vpblendw xmm6, xmm2, xmm3, 204
    vpblendw xmm3, xmm3, xmm2, 204
    vpshufb xmm2, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm5, xmm2
    vpcmpgtb xmm7, xmm5, xmm3
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm2, xmm2, xmm2
    vpaddb xmm3, xmm3, xmm3
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm6, xmm2, xmm4
    vpxor xmm6, xmm6, XMMWORD PTR [asuraRoundConstants + 176]
    vpxor xmm7, xmm3, xmm4
    vaesdec xmm0, xmm0, xmm6
    vaesdec xmm1, xmm1, xmm7
    vaesenc xmm4, xmm4, xmm5
    vpblendw xmm6, xmm2, xmm3, 204
    vpblendw xmm3, xmm3, xmm2, 204
    vpshufb xmm2, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm5, xmm2
    vpcmpgtb xmm7, xmm5, xmm3
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm2, xmm2, xmm2
    vpaddb xmm3, xmm3, xmm3
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm6, xmm2, xmm4
    vpxor xmm6, xmm6, XMMWORD PTR [asuraRoundConstants + 192]
    vpxor xmm7, xmm3, xmm4
    vaesenc xmm0, xmm0, xmm6
    vaesdec xmm1, xmm1, xmm7
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 88
    xor rcx, rcx
    xor rdx, rdx
    ret
areion_asura_encrypt_block_otf_vex_asm ENDP

PUBLIC areion_asura_decrypt_block_otf_vex_asm
ALIGN 16
areion_asura_decrypt_block_otf_vex_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    vmovdqu xmm0, XMMWORD PTR [rdx]
    vmovdqu xmm1, XMMWORD PTR [rdx + 16]
    vmovdqu xmm2, XMMWORD PTR [rcx]
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm0, xmm2
    vpxor xmm4, xmm4, XMMWORD PTR [asuraRoundConstants]
    vpxor xmm15, xmm1, xmm2
    vinsertf128 ymm4, ymm4, xmm15, 1
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm15, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm3, xmm0
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpxor xmm0, xmm0, xmm15
    vpcmpgtb xmm15, xmm3, xmm1
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm1, xmm1, xmm15
    vpxor xmm5, xmm0, xmm2
    vpxor xmm5, xmm5, XMMWORD PTR [asuraRoundConstants + 16]
    vpxor xmm15, xmm1, xmm2
    vaesdeclast xmm15, xmm15, xmm3
    vaesenc xmm15, xmm15, xmm3
    vinsertf128 ymm5, ymm5, xmm15, 1
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm15, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm3, xmm0
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpxor xmm0, xmm0, xmm15
    vpcmpgtb xmm15, xmm3, xmm1
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm1, xmm1, xmm15
    vpxor xmm6, xmm0, xmm2
    vpxor xmm6, xmm6, XMMWORD PTR [asuraRoundConstants + 32]
    vpxor xmm15, xmm1, xmm2
    vinsertf128 ymm6, ymm6, xmm15, 1
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm15, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm3, xmm0
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpxor xmm0, xmm0, xmm15
    vpcmpgtb xmm15, xmm3, xmm1
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm1, xmm1, xmm15
    vpxor xmm7, xmm0, xmm2
    vpxor xmm7, xmm7, XMMWORD PTR [asuraRoundConstants + 48]
    vpxor xmm15, xmm1, xmm2
    vaesdeclast xmm15, xmm15, xmm3
    vaesenc xmm15, xmm15, xmm3
    vinsertf128 ymm7, ymm7, xmm15, 1
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm15, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm3, xmm0
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpxor xmm0, xmm0, xmm15
    vpcmpgtb xmm15, xmm3, xmm1
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm1, xmm1, xmm15
    vpxor xmm8, xmm0, xmm2
    vpxor xmm8, xmm8, XMMWORD PTR [asuraRoundConstants + 64]
    vpxor xmm15, xmm1, xmm2
    vinsertf128 ymm8, ymm8, xmm15, 1
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm15, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm3, xmm0
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpxor xmm0, xmm0, xmm15
    vpcmpgtb xmm15, xmm3, xmm1
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm1, xmm1, xmm15
    vpxor xmm9, xmm0, xmm2
    vpxor xmm9, xmm9, XMMWORD PTR [asuraRoundConstants + 80]
    vpxor xmm15, xmm1, xmm2
    vaesdeclast xmm15, xmm15, xmm3
    vaesenc xmm15, xmm15, xmm3
    vinsertf128 ymm9, ymm9, xmm15, 1
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm15, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm3, xmm0
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpxor xmm0, xmm0, xmm15
    vpcmpgtb xmm15, xmm3, xmm1
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm1, xmm1, xmm15
    vpxor xmm10, xmm0, xmm2
    vpxor xmm10, xmm10, XMMWORD PTR [asuraRoundConstants + 96]
    vpxor xmm15, xmm1, xmm2
    vinsertf128 ymm10, ymm10, xmm15, 1
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm15, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm3, xmm0
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpxor xmm0, xmm0, xmm15
    vpcmpgtb xmm15, xmm3, xmm1
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm1, xmm1, xmm15
    vpxor xmm11, xmm0, xmm2
    vpxor xmm11, xmm11, XMMWORD PTR [asuraRoundConstants + 112]
    vpxor xmm15, xmm1, xmm2
    vaesdeclast xmm15, xmm15, xmm3
    vaesenc xmm15, xmm15, xmm3
    vinsertf128 ymm11, ymm11, xmm15, 1
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm15, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm3, xmm0
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpxor xmm0, xmm0, xmm15
    vpcmpgtb xmm15, xmm3, xmm1
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm1, xmm1, xmm15
    vpxor xmm12, xmm0, xmm2
    vpxor xmm12, xmm12, XMMWORD PTR [asuraRoundConstants + 128]
    vpxor xmm15, xmm1, xmm2
    vinsertf128 ymm12, ymm12, xmm15, 1
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm15, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm3, xmm0
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpxor xmm0, xmm0, xmm15
    vpcmpgtb xmm15, xmm3, xmm1
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm1, xmm1, xmm15
    vpxor xmm13, xmm0, xmm2
    vpxor xmm13, xmm13, XMMWORD PTR [asuraRoundConstants + 144]
    vpxor xmm15, xmm1, xmm2
    vaesdeclast xmm15, xmm15, xmm3
    vaesenc xmm15, xmm15, xmm3
    vinsertf128 ymm13, ymm13, xmm15, 1
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm15, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm3, xmm0
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpxor xmm0, xmm0, xmm15
    vpcmpgtb xmm15, xmm3, xmm1
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm1, xmm1, xmm15
    vpxor xmm14, xmm0, xmm2
    vpxor xmm14, xmm14, XMMWORD PTR [asuraRoundConstants + 160]
    vpxor xmm15, xmm1, xmm2
    vinsertf128 ymm14, ymm14, xmm15, 1
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm15, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm3, xmm0
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpxor xmm0, xmm0, xmm15
    vpcmpgtb xmm15, xmm3, xmm1
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm1, xmm1, xmm15
    vpxor xmm15, xmm1, xmm2
    vaesdeclast xmm15, xmm15, xmm3
    vaesenc xmm15, xmm15, xmm3
    vpxor xmm3, xmm0, xmm2
    vpxor xmm3, xmm3, XMMWORD PTR [asuraRoundConstants + 176]
    vinsertf128 ymm15, ymm3, xmm15, 1
    vpxor xmm3, xmm3, xmm3
    vaesenc xmm2, xmm2, xmm3
    vpblendw xmm3, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm3, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpxor xmm3, xmm3, xmm3
    vpcmpgtb xmm3, xmm3, xmm0
    vpand xmm3, xmm3, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpxor xmm0, xmm0, xmm3
    vpxor xmm3, xmm3, xmm3
    vpcmpgtb xmm3, xmm3, xmm1
    vpand xmm3, xmm3, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm1, xmm1, xmm3
    vpxor xmm3, xmm3, xmm3
    vpxor xmm0, xmm0, xmm2
    vpxor xmm0, xmm0, XMMWORD PTR [asuraRoundConstants + 192]
    vpxor xmm1, xmm1, xmm2
    vpxor xmm0, xmm0, XMMWORD PTR [rsi]
    vpxor xmm1, xmm1, XMMWORD PTR [rsi + 16]
    vextractf128 xmm2, ymm15, 1
    vaesimc xmm0, xmm0
    vaesdeclast xmm1, xmm1, xmm3
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm1, xmm3
    vaesdeclast xmm0, xmm0, xmm3
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm0, xmm0, xmm3
    vextractf128 xmm2, ymm14, 1
    vaesenclast xmm0, xmm0, xmm14
    vaesenclast xmm1, xmm1, xmm2
    vpunpcklbw xmm2, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm2
    vextractf128 xmm2, ymm13, 1
    vaesdeclast xmm1, xmm1, xmm3
    vaesdeclast xmm0, xmm0, xmm13
    vaesenc xmm1, xmm1, xmm3
    vaesdeclast xmm0, xmm0, xmm3
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm0, xmm0, xmm3
    vextractf128 xmm2, ymm12, 1
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm1, xmm1, xmm2
    vpunpcklbw xmm2, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm2
    vextractf128 xmm2, ymm11, 1
    vaesdeclast xmm1, xmm1, xmm3
    vaesdeclast xmm0, xmm0, xmm11
    vaesenc xmm1, xmm1, xmm3
    vaesdeclast xmm0, xmm0, xmm3
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm0, xmm0, xmm3
    vextractf128 xmm2, ymm10, 1
    vaesenclast xmm0, xmm0, xmm10
    vaesenclast xmm1, xmm1, xmm2
    vpunpcklbw xmm2, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm2
    vextractf128 xmm2, ymm9, 1
    vaesdeclast xmm1, xmm1, xmm3
    vaesdeclast xmm0, xmm0, xmm9
    vaesenc xmm1, xmm1, xmm3
    vaesdeclast xmm0, xmm0, xmm3
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm0, xmm0, xmm3
    vextractf128 xmm2, ymm8, 1
    vaesenclast xmm0, xmm0, xmm8
    vaesenclast xmm1, xmm1, xmm2
    vpunpcklbw xmm2, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm2
    vextractf128 xmm2, ymm7, 1
    vaesdeclast xmm1, xmm1, xmm3
    vaesdeclast xmm0, xmm0, xmm7
    vaesenc xmm1, xmm1, xmm3
    vaesdeclast xmm0, xmm0, xmm3
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm0, xmm0, xmm3
    vextractf128 xmm2, ymm6, 1
    vaesenclast xmm0, xmm0, xmm6
    vaesenclast xmm1, xmm1, xmm2
    vpunpcklbw xmm2, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm2
    vextractf128 xmm2, ymm5, 1
    vaesdeclast xmm1, xmm1, xmm3
    vaesdeclast xmm0, xmm0, xmm5
    vaesenc xmm1, xmm1, xmm3
    vaesdeclast xmm0, xmm0, xmm3
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm0, xmm0, xmm3
    vextractf128 xmm2, ymm4, 1
    vaesenclast xmm0, xmm0, xmm4
    vaesenclast xmm1, xmm1, xmm2
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
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    xor rcx, rcx
    xor rdx, rdx
    vzeroupper
    ret
areion_asura_decrypt_block_otf_vex_asm ENDP

PUBLIC areion_asura_encrypt_4blocks_vex_asm
ALIGN 16
areion_asura_encrypt_4blocks_vex_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vmovdqu xmm4, XMMWORD PTR [rsi + 64]
    vmovdqu xmm5, XMMWORD PTR [rsi + 80]
    vmovdqu xmm6, XMMWORD PTR [rsi + 96]
    vmovdqu xmm7, XMMWORD PTR [rsi + 112]
    vpxor xmm8, xmm8, xmm8
    vmovdqa xmm9, XMMWORD PTR [asuraConsts + 64]
    vmovdqu xmm10, XMMWORD PTR [rdx]
    vmovdqu xmm11, XMMWORD PTR [rdx + 16]
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vpxor xmm4, xmm4, xmm10
    vpxor xmm5, xmm5, xmm11
    vpxor xmm6, xmm6, xmm10
    vpxor xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rdx + 32]
    vmovdqu xmm11, XMMWORD PTR [rdx + 48]
    vaesdec xmm0, xmm0, xmm10
    vaesdec xmm1, xmm1, xmm11
    vaesdec xmm2, xmm2, xmm10
    vaesdec xmm3, xmm3, xmm11
    vaesdec xmm4, xmm4, xmm10
    vaesdec xmm5, xmm5, xmm11
    vaesdec xmm6, xmm6, xmm10
    vaesdec xmm7, xmm7, xmm11
    vaesenc xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm8
    vaesenc xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm8
    vaesenc xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm8
    vpshufb xmm12, xmm0, xmm9
    vpshufb xmm13, xmm1, xmm9
    vpunpcklqdq xmm0, xmm12, xmm13
    vpunpckhqdq xmm1, xmm12, xmm13
    vpshufb xmm12, xmm2, xmm9
    vpshufb xmm13, xmm3, xmm9
    vpunpcklqdq xmm2, xmm12, xmm13
    vpunpckhqdq xmm3, xmm12, xmm13
    vpshufb xmm12, xmm4, xmm9
    vpshufb xmm13, xmm5, xmm9
    vpunpcklqdq xmm4, xmm12, xmm13
    vpunpckhqdq xmm5, xmm12, xmm13
    vpshufb xmm12, xmm6, xmm9
    vpshufb xmm13, xmm7, xmm9
    vpunpcklqdq xmm6, xmm12, xmm13
    vpunpckhqdq xmm7, xmm12, xmm13
    vmovdqu xmm10, XMMWORD PTR [rdx + 64]
    vmovdqu xmm11, XMMWORD PTR [rdx + 80]
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vpxor xmm4, xmm4, xmm10
    vpxor xmm5, xmm5, xmm11
    vpxor xmm6, xmm6, xmm10
    vpxor xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rdx + 96]
    vmovdqu xmm11, XMMWORD PTR [rdx + 112]
    vaesdec xmm0, xmm0, xmm10
    vaesdec xmm1, xmm1, xmm11
    vaesdec xmm2, xmm2, xmm10
    vaesdec xmm3, xmm3, xmm11
    vaesdec xmm4, xmm4, xmm10
    vaesdec xmm5, xmm5, xmm11
    vaesdec xmm6, xmm6, xmm10
    vaesdec xmm7, xmm7, xmm11
    vaesenc xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm8
    vaesenc xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm8
    vaesenc xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm8
    vpshufb xmm12, xmm0, xmm9
    vpshufb xmm13, xmm1, xmm9
    vpunpcklqdq xmm0, xmm12, xmm13
    vpunpckhqdq xmm1, xmm12, xmm13
    vpshufb xmm12, xmm2, xmm9
    vpshufb xmm13, xmm3, xmm9
    vpunpcklqdq xmm2, xmm12, xmm13
    vpunpckhqdq xmm3, xmm12, xmm13
    vpshufb xmm12, xmm4, xmm9
    vpshufb xmm13, xmm5, xmm9
    vpunpcklqdq xmm4, xmm12, xmm13
    vpunpckhqdq xmm5, xmm12, xmm13
    vpshufb xmm12, xmm6, xmm9
    vpshufb xmm13, xmm7, xmm9
    vpunpcklqdq xmm6, xmm12, xmm13
    vpunpckhqdq xmm7, xmm12, xmm13
    vmovdqu xmm10, XMMWORD PTR [rdx + 128]
    vmovdqu xmm11, XMMWORD PTR [rdx + 144]
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vpxor xmm4, xmm4, xmm10
    vpxor xmm5, xmm5, xmm11
    vpxor xmm6, xmm6, xmm10
    vpxor xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rdx + 160]
    vmovdqu xmm11, XMMWORD PTR [rdx + 176]
    vaesdec xmm0, xmm0, xmm10
    vaesdec xmm1, xmm1, xmm11
    vaesdec xmm2, xmm2, xmm10
    vaesdec xmm3, xmm3, xmm11
    vaesdec xmm4, xmm4, xmm10
    vaesdec xmm5, xmm5, xmm11
    vaesdec xmm6, xmm6, xmm10
    vaesdec xmm7, xmm7, xmm11
    vaesenc xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm8
    vaesenc xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm8
    vaesenc xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm8
    vpshufb xmm12, xmm0, xmm9
    vpshufb xmm13, xmm1, xmm9
    vpunpcklqdq xmm0, xmm12, xmm13
    vpunpckhqdq xmm1, xmm12, xmm13
    vpshufb xmm12, xmm2, xmm9
    vpshufb xmm13, xmm3, xmm9
    vpunpcklqdq xmm2, xmm12, xmm13
    vpunpckhqdq xmm3, xmm12, xmm13
    vpshufb xmm12, xmm4, xmm9
    vpshufb xmm13, xmm5, xmm9
    vpunpcklqdq xmm4, xmm12, xmm13
    vpunpckhqdq xmm5, xmm12, xmm13
    vpshufb xmm12, xmm6, xmm9
    vpshufb xmm13, xmm7, xmm9
    vpunpcklqdq xmm6, xmm12, xmm13
    vpunpckhqdq xmm7, xmm12, xmm13
    vmovdqu xmm10, XMMWORD PTR [rdx + 192]
    vmovdqu xmm11, XMMWORD PTR [rdx + 208]
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vpxor xmm4, xmm4, xmm10
    vpxor xmm5, xmm5, xmm11
    vpxor xmm6, xmm6, xmm10
    vpxor xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rdx + 224]
    vmovdqu xmm11, XMMWORD PTR [rdx + 240]
    vaesdec xmm0, xmm0, xmm10
    vaesdec xmm1, xmm1, xmm11
    vaesdec xmm2, xmm2, xmm10
    vaesdec xmm3, xmm3, xmm11
    vaesdec xmm4, xmm4, xmm10
    vaesdec xmm5, xmm5, xmm11
    vaesdec xmm6, xmm6, xmm10
    vaesdec xmm7, xmm7, xmm11
    vaesenc xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm8
    vaesenc xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm8
    vaesenc xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm8
    vpshufb xmm12, xmm0, xmm9
    vpshufb xmm13, xmm1, xmm9
    vpunpcklqdq xmm0, xmm12, xmm13
    vpunpckhqdq xmm1, xmm12, xmm13
    vpshufb xmm12, xmm2, xmm9
    vpshufb xmm13, xmm3, xmm9
    vpunpcklqdq xmm2, xmm12, xmm13
    vpunpckhqdq xmm3, xmm12, xmm13
    vpshufb xmm12, xmm4, xmm9
    vpshufb xmm13, xmm5, xmm9
    vpunpcklqdq xmm4, xmm12, xmm13
    vpunpckhqdq xmm5, xmm12, xmm13
    vpshufb xmm12, xmm6, xmm9
    vpshufb xmm13, xmm7, xmm9
    vpunpcklqdq xmm6, xmm12, xmm13
    vpunpckhqdq xmm7, xmm12, xmm13
    vmovdqu xmm10, XMMWORD PTR [rdx + 256]
    vmovdqu xmm11, XMMWORD PTR [rdx + 272]
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vpxor xmm4, xmm4, xmm10
    vpxor xmm5, xmm5, xmm11
    vpxor xmm6, xmm6, xmm10
    vpxor xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rdx + 288]
    vmovdqu xmm11, XMMWORD PTR [rdx + 304]
    vaesdec xmm0, xmm0, xmm10
    vaesdec xmm1, xmm1, xmm11
    vaesdec xmm2, xmm2, xmm10
    vaesdec xmm3, xmm3, xmm11
    vaesdec xmm4, xmm4, xmm10
    vaesdec xmm5, xmm5, xmm11
    vaesdec xmm6, xmm6, xmm10
    vaesdec xmm7, xmm7, xmm11
    vaesenc xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm8
    vaesenc xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm8
    vaesenc xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm8
    vpshufb xmm12, xmm0, xmm9
    vpshufb xmm13, xmm1, xmm9
    vpunpcklqdq xmm0, xmm12, xmm13
    vpunpckhqdq xmm1, xmm12, xmm13
    vpshufb xmm12, xmm2, xmm9
    vpshufb xmm13, xmm3, xmm9
    vpunpcklqdq xmm2, xmm12, xmm13
    vpunpckhqdq xmm3, xmm12, xmm13
    vpshufb xmm12, xmm4, xmm9
    vpshufb xmm13, xmm5, xmm9
    vpunpcklqdq xmm4, xmm12, xmm13
    vpunpckhqdq xmm5, xmm12, xmm13
    vpshufb xmm12, xmm6, xmm9
    vpshufb xmm13, xmm7, xmm9
    vpunpcklqdq xmm6, xmm12, xmm13
    vpunpckhqdq xmm7, xmm12, xmm13
    vmovdqu xmm10, XMMWORD PTR [rdx + 320]
    vmovdqu xmm11, XMMWORD PTR [rdx + 336]
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vpxor xmm4, xmm4, xmm10
    vpxor xmm5, xmm5, xmm11
    vpxor xmm6, xmm6, xmm10
    vpxor xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rdx + 352]
    vmovdqu xmm11, XMMWORD PTR [rdx + 368]
    vaesdec xmm0, xmm0, xmm10
    vaesdec xmm1, xmm1, xmm11
    vaesdec xmm2, xmm2, xmm10
    vaesdec xmm3, xmm3, xmm11
    vaesdec xmm4, xmm4, xmm10
    vaesdec xmm5, xmm5, xmm11
    vaesdec xmm6, xmm6, xmm10
    vaesdec xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rdx + 384]
    vmovdqu xmm11, XMMWORD PTR [rdx + 400]
    vaesenc xmm0, xmm0, xmm10
    vaesdec xmm1, xmm1, xmm11
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vaesenc xmm2, xmm2, xmm10
    vaesdec xmm3, xmm3, xmm11
    vmovdqu XMMWORD PTR [rdi + 32], xmm2
    vmovdqu XMMWORD PTR [rdi + 48], xmm3
    vaesenc xmm4, xmm4, xmm10
    vaesdec xmm5, xmm5, xmm11
    vmovdqu XMMWORD PTR [rdi + 64], xmm4
    vmovdqu XMMWORD PTR [rdi + 80], xmm5
    vaesenc xmm6, xmm6, xmm10
    vaesdec xmm7, xmm7, xmm11
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 152
    xor rdx, rdx
    ret
areion_asura_encrypt_4blocks_vex_asm ENDP

PUBLIC areion_asura_decrypt_4blocks_vex_asm
ALIGN 16
areion_asura_decrypt_4blocks_vex_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 120
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vmovdqu xmm3, XMMWORD PTR [rsi + 48]
    vmovdqu xmm4, XMMWORD PTR [rsi + 64]
    vmovdqu xmm5, XMMWORD PTR [rsi + 80]
    vmovdqu xmm6, XMMWORD PTR [rsi + 96]
    vmovdqu xmm7, XMMWORD PTR [rsi + 112]
    vpxor xmm8, xmm8, xmm8
    vmovdqu xmm9, XMMWORD PTR [rdx + 384]
    vmovdqu xmm10, XMMWORD PTR [rdx + 400]
    vpxor xmm0, xmm0, xmm9
    vpxor xmm1, xmm1, xmm10
    vpxor xmm2, xmm2, xmm9
    vpxor xmm3, xmm3, xmm10
    vpxor xmm4, xmm4, xmm9
    vpxor xmm5, xmm5, xmm10
    vpxor xmm6, xmm6, xmm9
    vpxor xmm7, xmm7, xmm10
    vmovdqu xmm9, XMMWORD PTR [rdx + 352]
    vmovdqu xmm10, XMMWORD PTR [rdx + 368]
    vaesdeclast xmm10, xmm10, xmm8
    vaesimc xmm0, xmm0
    vaesdeclast xmm1, xmm1, xmm8
    vaesimc xmm2, xmm2
    vaesdeclast xmm3, xmm3, xmm8
    vaesimc xmm4, xmm4
    vaesdeclast xmm5, xmm5, xmm8
    vaesimc xmm6, xmm6
    vaesdeclast xmm7, xmm7, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesdeclast xmm0, xmm0, xmm9
    vaesenc xmm1, xmm1, xmm8
    vaesdeclast xmm2, xmm2, xmm9
    vaesenc xmm3, xmm3, xmm8
    vaesdeclast xmm4, xmm4, xmm9
    vaesenc xmm5, xmm5, xmm8
    vaesdeclast xmm6, xmm6, xmm9
    vaesenc xmm7, xmm7, xmm8
    vaesdeclast xmm0, xmm0, xmm8
    vaesenc xmm1, xmm1, xmm10
    vaesdeclast xmm2, xmm2, xmm8
    vaesenc xmm3, xmm3, xmm10
    vaesdeclast xmm4, xmm4, xmm8
    vaesenc xmm5, xmm5, xmm10
    vaesdeclast xmm6, xmm6, xmm8
    vaesenc xmm7, xmm7, xmm10
    vmovdqu xmm9, XMMWORD PTR [rdx + 320]
    vmovdqu xmm10, XMMWORD PTR [rdx + 336]
    vaesenc xmm0, xmm0, xmm8
    vaesenc xmm2, xmm2, xmm8
    vaesenc xmm4, xmm4, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesenclast xmm0, xmm0, xmm9
    vaesenclast xmm1, xmm1, xmm10
    vaesenclast xmm2, xmm2, xmm9
    vaesenclast xmm3, xmm3, xmm10
    vaesenclast xmm4, xmm4, xmm9
    vaesenclast xmm5, xmm5, xmm10
    vaesenclast xmm6, xmm6, xmm9
    vaesenclast xmm7, xmm7, xmm10
    vmovdqu xmm9, XMMWORD PTR [rdx + 288]
    vmovdqu xmm10, XMMWORD PTR [rdx + 304]
    vaesdeclast xmm10, xmm10, xmm8
    vpunpcklbw xmm11, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm11
    vaesdeclast xmm1, xmm1, xmm8
    vpunpcklbw xmm11, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vaesimc xmm2, xmm11
    vaesdeclast xmm3, xmm3, xmm8
    vpunpcklbw xmm11, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vaesimc xmm4, xmm11
    vaesdeclast xmm5, xmm5, xmm8
    vpunpcklbw xmm11, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vaesimc xmm6, xmm11
    vaesdeclast xmm7, xmm7, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesdeclast xmm0, xmm0, xmm9
    vaesenc xmm1, xmm1, xmm8
    vaesdeclast xmm2, xmm2, xmm9
    vaesenc xmm3, xmm3, xmm8
    vaesdeclast xmm4, xmm4, xmm9
    vaesenc xmm5, xmm5, xmm8
    vaesdeclast xmm6, xmm6, xmm9
    vaesenc xmm7, xmm7, xmm8
    vaesdeclast xmm0, xmm0, xmm8
    vaesenc xmm1, xmm1, xmm10
    vaesdeclast xmm2, xmm2, xmm8
    vaesenc xmm3, xmm3, xmm10
    vaesdeclast xmm4, xmm4, xmm8
    vaesenc xmm5, xmm5, xmm10
    vaesdeclast xmm6, xmm6, xmm8
    vaesenc xmm7, xmm7, xmm10
    vmovdqu xmm9, XMMWORD PTR [rdx + 256]
    vmovdqu xmm10, XMMWORD PTR [rdx + 272]
    vaesenc xmm0, xmm0, xmm8
    vaesenc xmm2, xmm2, xmm8
    vaesenc xmm4, xmm4, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesenclast xmm0, xmm0, xmm9
    vaesenclast xmm1, xmm1, xmm10
    vaesenclast xmm2, xmm2, xmm9
    vaesenclast xmm3, xmm3, xmm10
    vaesenclast xmm4, xmm4, xmm9
    vaesenclast xmm5, xmm5, xmm10
    vaesenclast xmm6, xmm6, xmm9
    vaesenclast xmm7, xmm7, xmm10
    vmovdqu xmm9, XMMWORD PTR [rdx + 224]
    vmovdqu xmm10, XMMWORD PTR [rdx + 240]
    vaesdeclast xmm10, xmm10, xmm8
    vpunpcklbw xmm11, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm11
    vaesdeclast xmm1, xmm1, xmm8
    vpunpcklbw xmm11, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vaesimc xmm2, xmm11
    vaesdeclast xmm3, xmm3, xmm8
    vpunpcklbw xmm11, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vaesimc xmm4, xmm11
    vaesdeclast xmm5, xmm5, xmm8
    vpunpcklbw xmm11, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vaesimc xmm6, xmm11
    vaesdeclast xmm7, xmm7, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesdeclast xmm0, xmm0, xmm9
    vaesenc xmm1, xmm1, xmm8
    vaesdeclast xmm2, xmm2, xmm9
    vaesenc xmm3, xmm3, xmm8
    vaesdeclast xmm4, xmm4, xmm9
    vaesenc xmm5, xmm5, xmm8
    vaesdeclast xmm6, xmm6, xmm9
    vaesenc xmm7, xmm7, xmm8
    vaesdeclast xmm0, xmm0, xmm8
    vaesenc xmm1, xmm1, xmm10
    vaesdeclast xmm2, xmm2, xmm8
    vaesenc xmm3, xmm3, xmm10
    vaesdeclast xmm4, xmm4, xmm8
    vaesenc xmm5, xmm5, xmm10
    vaesdeclast xmm6, xmm6, xmm8
    vaesenc xmm7, xmm7, xmm10
    vmovdqu xmm9, XMMWORD PTR [rdx + 192]
    vmovdqu xmm10, XMMWORD PTR [rdx + 208]
    vaesenc xmm0, xmm0, xmm8
    vaesenc xmm2, xmm2, xmm8
    vaesenc xmm4, xmm4, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesenclast xmm0, xmm0, xmm9
    vaesenclast xmm1, xmm1, xmm10
    vaesenclast xmm2, xmm2, xmm9
    vaesenclast xmm3, xmm3, xmm10
    vaesenclast xmm4, xmm4, xmm9
    vaesenclast xmm5, xmm5, xmm10
    vaesenclast xmm6, xmm6, xmm9
    vaesenclast xmm7, xmm7, xmm10
    vmovdqu xmm9, XMMWORD PTR [rdx + 160]
    vmovdqu xmm10, XMMWORD PTR [rdx + 176]
    vaesdeclast xmm10, xmm10, xmm8
    vpunpcklbw xmm11, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm11
    vaesdeclast xmm1, xmm1, xmm8
    vpunpcklbw xmm11, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vaesimc xmm2, xmm11
    vaesdeclast xmm3, xmm3, xmm8
    vpunpcklbw xmm11, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vaesimc xmm4, xmm11
    vaesdeclast xmm5, xmm5, xmm8
    vpunpcklbw xmm11, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vaesimc xmm6, xmm11
    vaesdeclast xmm7, xmm7, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesdeclast xmm0, xmm0, xmm9
    vaesenc xmm1, xmm1, xmm8
    vaesdeclast xmm2, xmm2, xmm9
    vaesenc xmm3, xmm3, xmm8
    vaesdeclast xmm4, xmm4, xmm9
    vaesenc xmm5, xmm5, xmm8
    vaesdeclast xmm6, xmm6, xmm9
    vaesenc xmm7, xmm7, xmm8
    vaesdeclast xmm0, xmm0, xmm8
    vaesenc xmm1, xmm1, xmm10
    vaesdeclast xmm2, xmm2, xmm8
    vaesenc xmm3, xmm3, xmm10
    vaesdeclast xmm4, xmm4, xmm8
    vaesenc xmm5, xmm5, xmm10
    vaesdeclast xmm6, xmm6, xmm8
    vaesenc xmm7, xmm7, xmm10
    vmovdqu xmm9, XMMWORD PTR [rdx + 128]
    vmovdqu xmm10, XMMWORD PTR [rdx + 144]
    vaesenc xmm0, xmm0, xmm8
    vaesenc xmm2, xmm2, xmm8
    vaesenc xmm4, xmm4, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesenclast xmm0, xmm0, xmm9
    vaesenclast xmm1, xmm1, xmm10
    vaesenclast xmm2, xmm2, xmm9
    vaesenclast xmm3, xmm3, xmm10
    vaesenclast xmm4, xmm4, xmm9
    vaesenclast xmm5, xmm5, xmm10
    vaesenclast xmm6, xmm6, xmm9
    vaesenclast xmm7, xmm7, xmm10
    vmovdqu xmm9, XMMWORD PTR [rdx + 96]
    vmovdqu xmm10, XMMWORD PTR [rdx + 112]
    vaesdeclast xmm10, xmm10, xmm8
    vpunpcklbw xmm11, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm11
    vaesdeclast xmm1, xmm1, xmm8
    vpunpcklbw xmm11, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vaesimc xmm2, xmm11
    vaesdeclast xmm3, xmm3, xmm8
    vpunpcklbw xmm11, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vaesimc xmm4, xmm11
    vaesdeclast xmm5, xmm5, xmm8
    vpunpcklbw xmm11, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vaesimc xmm6, xmm11
    vaesdeclast xmm7, xmm7, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesdeclast xmm0, xmm0, xmm9
    vaesenc xmm1, xmm1, xmm8
    vaesdeclast xmm2, xmm2, xmm9
    vaesenc xmm3, xmm3, xmm8
    vaesdeclast xmm4, xmm4, xmm9
    vaesenc xmm5, xmm5, xmm8
    vaesdeclast xmm6, xmm6, xmm9
    vaesenc xmm7, xmm7, xmm8
    vaesdeclast xmm0, xmm0, xmm8
    vaesenc xmm1, xmm1, xmm10
    vaesdeclast xmm2, xmm2, xmm8
    vaesenc xmm3, xmm3, xmm10
    vaesdeclast xmm4, xmm4, xmm8
    vaesenc xmm5, xmm5, xmm10
    vaesdeclast xmm6, xmm6, xmm8
    vaesenc xmm7, xmm7, xmm10
    vmovdqu xmm9, XMMWORD PTR [rdx + 64]
    vmovdqu xmm10, XMMWORD PTR [rdx + 80]
    vaesenc xmm0, xmm0, xmm8
    vaesenc xmm2, xmm2, xmm8
    vaesenc xmm4, xmm4, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesenclast xmm0, xmm0, xmm9
    vaesenclast xmm1, xmm1, xmm10
    vaesenclast xmm2, xmm2, xmm9
    vaesenclast xmm3, xmm3, xmm10
    vaesenclast xmm4, xmm4, xmm9
    vaesenclast xmm5, xmm5, xmm10
    vaesenclast xmm6, xmm6, xmm9
    vaesenclast xmm7, xmm7, xmm10
    vmovdqu xmm9, XMMWORD PTR [rdx + 32]
    vmovdqu xmm10, XMMWORD PTR [rdx + 48]
    vaesdeclast xmm10, xmm10, xmm8
    vpunpcklbw xmm11, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vaesimc xmm0, xmm11
    vaesdeclast xmm1, xmm1, xmm8
    vpunpcklbw xmm11, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vaesimc xmm2, xmm11
    vaesdeclast xmm3, xmm3, xmm8
    vpunpcklbw xmm11, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vaesimc xmm4, xmm11
    vaesdeclast xmm5, xmm5, xmm8
    vpunpcklbw xmm11, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vaesimc xmm6, xmm11
    vaesdeclast xmm7, xmm7, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesdeclast xmm0, xmm0, xmm9
    vaesenc xmm1, xmm1, xmm8
    vaesdeclast xmm2, xmm2, xmm9
    vaesenc xmm3, xmm3, xmm8
    vaesdeclast xmm4, xmm4, xmm9
    vaesenc xmm5, xmm5, xmm8
    vaesdeclast xmm6, xmm6, xmm9
    vaesenc xmm7, xmm7, xmm8
    vaesdeclast xmm0, xmm0, xmm8
    vaesenc xmm1, xmm1, xmm10
    vaesdeclast xmm2, xmm2, xmm8
    vaesenc xmm3, xmm3, xmm10
    vaesdeclast xmm4, xmm4, xmm8
    vaesenc xmm5, xmm5, xmm10
    vaesdeclast xmm6, xmm6, xmm8
    vaesenc xmm7, xmm7, xmm10
    vmovdqu xmm9, XMMWORD PTR [rdx]
    vmovdqu xmm10, XMMWORD PTR [rdx + 16]
    vaesenc xmm0, xmm0, xmm8
    vaesenc xmm2, xmm2, xmm8
    vaesenc xmm4, xmm4, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesenclast xmm0, xmm0, xmm9
    vaesenclast xmm1, xmm1, xmm10
    vaesenclast xmm2, xmm2, xmm9
    vaesenclast xmm3, xmm3, xmm10
    vaesenclast xmm4, xmm4, xmm9
    vaesenclast xmm5, xmm5, xmm10
    vaesenclast xmm6, xmm6, xmm9
    vaesenclast xmm7, xmm7, xmm10
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 120
    xor rdx, rdx
    ret
areion_asura_decrypt_4blocks_vex_asm ENDP

PUBLIC areion_asura_encrypt_4blocks_otf_vex_asm
ALIGN 16
areion_asura_encrypt_4blocks_otf_vex_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    vmovdqu xmm10, XMMWORD PTR [rcx]
    vmovdqu xmm11, XMMWORD PTR [rcx + 16]
    vmovdqu xmm12, XMMWORD PTR [rcx + 32]
    vmovdqu xmm13, XMMWORD PTR [rcx + 48]
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vpxor xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vpxor xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vpxor xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vpxor xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vpxor xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vpxor xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vpxor xmm7, xmm7, xmm15
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 16]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesdec xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesdec xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesdec xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesdec xmm7, xmm7, xmm15
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm0, xmm0, xmm14
    vaesdec xmm1, xmm1, xmm14
    vpshufb xmm0, xmm0, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm0, xmm1
    vpunpckhqdq xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm15
    vaesenc xmm2, xmm2, xmm14
    vaesdec xmm3, xmm3, xmm14
    vpshufb xmm2, xmm2, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm2, xmm3
    vpunpckhqdq xmm3, xmm2, xmm3
    vmovdqa xmm2, xmm15
    vaesenc xmm4, xmm4, xmm14
    vaesdec xmm5, xmm5, xmm14
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm5, xmm5, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm4, xmm5
    vpunpckhqdq xmm5, xmm4, xmm5
    vmovdqa xmm4, xmm15
    vaesenc xmm6, xmm6, xmm14
    vaesdec xmm7, xmm7, xmm14
    vpshufb xmm6, xmm6, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm7, xmm7, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm6, xmm7
    vpunpckhqdq xmm7, xmm6, xmm7
    vmovdqa xmm6, xmm15
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 32]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vpxor xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vpxor xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vpxor xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vpxor xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vpxor xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vpxor xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vpxor xmm7, xmm7, xmm15
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 48]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesdec xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesdec xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesdec xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesdec xmm7, xmm7, xmm15
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm0, xmm0, xmm14
    vaesdec xmm1, xmm1, xmm14
    vpshufb xmm0, xmm0, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm0, xmm1
    vpunpckhqdq xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm15
    vaesenc xmm2, xmm2, xmm14
    vaesdec xmm3, xmm3, xmm14
    vpshufb xmm2, xmm2, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm2, xmm3
    vpunpckhqdq xmm3, xmm2, xmm3
    vmovdqa xmm2, xmm15
    vaesenc xmm4, xmm4, xmm14
    vaesdec xmm5, xmm5, xmm14
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm5, xmm5, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm4, xmm5
    vpunpckhqdq xmm5, xmm4, xmm5
    vmovdqa xmm4, xmm15
    vaesenc xmm6, xmm6, xmm14
    vaesdec xmm7, xmm7, xmm14
    vpshufb xmm6, xmm6, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm7, xmm7, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm6, xmm7
    vpunpckhqdq xmm7, xmm6, xmm7
    vmovdqa xmm6, xmm15
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 64]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vpxor xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vpxor xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vpxor xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vpxor xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vpxor xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vpxor xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vpxor xmm7, xmm7, xmm15
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 80]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesdec xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesdec xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesdec xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesdec xmm7, xmm7, xmm15
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm0, xmm0, xmm14
    vaesdec xmm1, xmm1, xmm14
    vpshufb xmm0, xmm0, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm0, xmm1
    vpunpckhqdq xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm15
    vaesenc xmm2, xmm2, xmm14
    vaesdec xmm3, xmm3, xmm14
    vpshufb xmm2, xmm2, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm2, xmm3
    vpunpckhqdq xmm3, xmm2, xmm3
    vmovdqa xmm2, xmm15
    vaesenc xmm4, xmm4, xmm14
    vaesdec xmm5, xmm5, xmm14
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm5, xmm5, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm4, xmm5
    vpunpckhqdq xmm5, xmm4, xmm5
    vmovdqa xmm4, xmm15
    vaesenc xmm6, xmm6, xmm14
    vaesdec xmm7, xmm7, xmm14
    vpshufb xmm6, xmm6, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm7, xmm7, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm6, xmm7
    vpunpckhqdq xmm7, xmm6, xmm7
    vmovdqa xmm6, xmm15
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 96]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vpxor xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vpxor xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vpxor xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vpxor xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vpxor xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vpxor xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vpxor xmm7, xmm7, xmm15
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 112]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesdec xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesdec xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesdec xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesdec xmm7, xmm7, xmm15
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm0, xmm0, xmm14
    vaesdec xmm1, xmm1, xmm14
    vpshufb xmm0, xmm0, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm0, xmm1
    vpunpckhqdq xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm15
    vaesenc xmm2, xmm2, xmm14
    vaesdec xmm3, xmm3, xmm14
    vpshufb xmm2, xmm2, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm2, xmm3
    vpunpckhqdq xmm3, xmm2, xmm3
    vmovdqa xmm2, xmm15
    vaesenc xmm4, xmm4, xmm14
    vaesdec xmm5, xmm5, xmm14
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm5, xmm5, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm4, xmm5
    vpunpckhqdq xmm5, xmm4, xmm5
    vmovdqa xmm4, xmm15
    vaesenc xmm6, xmm6, xmm14
    vaesdec xmm7, xmm7, xmm14
    vpshufb xmm6, xmm6, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm7, xmm7, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm6, xmm7
    vpunpckhqdq xmm7, xmm6, xmm7
    vmovdqa xmm6, xmm15
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 128]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vpxor xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vpxor xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vpxor xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vpxor xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vpxor xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vpxor xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vpxor xmm7, xmm7, xmm15
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 144]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesdec xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesdec xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesdec xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesdec xmm7, xmm7, xmm15
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm0, xmm0, xmm14
    vaesdec xmm1, xmm1, xmm14
    vpshufb xmm0, xmm0, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm0, xmm1
    vpunpckhqdq xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm15
    vaesenc xmm2, xmm2, xmm14
    vaesdec xmm3, xmm3, xmm14
    vpshufb xmm2, xmm2, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm3, xmm3, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm2, xmm3
    vpunpckhqdq xmm3, xmm2, xmm3
    vmovdqa xmm2, xmm15
    vaesenc xmm4, xmm4, xmm14
    vaesdec xmm5, xmm5, xmm14
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm5, xmm5, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm4, xmm5
    vpunpckhqdq xmm5, xmm4, xmm5
    vmovdqa xmm4, xmm15
    vaesenc xmm6, xmm6, xmm14
    vaesdec xmm7, xmm7, xmm14
    vpshufb xmm6, xmm6, XMMWORD PTR [asuraConsts + 64]
    vpshufb xmm7, xmm7, XMMWORD PTR [asuraConsts + 64]
    vpunpcklqdq xmm15, xmm6, xmm7
    vpunpckhqdq xmm7, xmm6, xmm7
    vmovdqa xmm6, xmm15
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 160]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vpxor xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vpxor xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vpxor xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vpxor xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vpxor xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vpxor xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vpxor xmm7, xmm7, xmm15
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 176]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesdec xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesdec xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesdec xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesdec xmm7, xmm7, xmm15
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 192]
    vpxor xmm15, xmm14, xmm10
    vaesenc xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesdec xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesenc xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesdec xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesenc xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesdec xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesenc xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesdec xmm7, xmm7, xmm15
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    xor rcx, rcx
    xor rdx, rdx
    ret
areion_asura_encrypt_4blocks_otf_vex_asm ENDP

PUBLIC areion_asura_decrypt_4blocks_otf_vex_asm
ALIGN 16
areion_asura_decrypt_4blocks_otf_vex_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    vmovdqu xmm10, XMMWORD PTR [rcx]
    vmovdqu xmm11, XMMWORD PTR [rcx + 16]
    vmovdqu xmm12, XMMWORD PTR [rcx + 32]
    vmovdqu xmm13, XMMWORD PTR [rcx + 48]
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesenc xmm10, xmm10, xmm14
    vaesenc xmm11, xmm11, xmm14
    vaesenc xmm12, xmm12, xmm14
    vaesenc xmm13, xmm13, xmm14
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm15, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm15, xmm14, xmm8
    vpcmpgtb xmm14, xmm14, xmm9
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts]
    vpand xmm14, xmm14, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm15
    vpxor xmm9, xmm9, xmm14
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 192]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vpxor xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vpxor xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vpxor xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vpxor xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vpxor xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vpxor xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vpxor xmm7, xmm7, xmm15
    vpxor xmm14, xmm14, xmm14
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm14
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm14
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm14
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm14
    vpsllw xmm15, xmm8, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm8, xmm8, 1
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm8, xmm8, xmm15
    vpsllw xmm15, xmm9, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm9, xmm9, 1
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm9, xmm9, xmm15
    vpshufb xmm8, xmm8, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vmovdqa xmm8, xmm15
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 176]
    vpxor xmm15, xmm15, xmm10
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm1, xmm1, xmm14
    vaesenc xmm1, xmm1, xmm14
    vaesenc xmm1, xmm1, xmm15
    vaesdeclast xmm0, xmm0, xmm14
    vaesenc xmm0, xmm0, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 176]
    vpxor xmm15, xmm15, xmm11
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm3, xmm3, xmm14
    vaesenc xmm3, xmm3, xmm14
    vaesenc xmm3, xmm3, xmm15
    vaesdeclast xmm2, xmm2, xmm14
    vaesenc xmm2, xmm2, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 176]
    vpxor xmm15, xmm15, xmm12
    vaesimc xmm4, xmm4
    vaesdeclast xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm5, xmm5, xmm14
    vaesenc xmm5, xmm5, xmm14
    vaesenc xmm5, xmm5, xmm15
    vaesdeclast xmm4, xmm4, xmm14
    vaesenc xmm4, xmm4, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 176]
    vpxor xmm15, xmm15, xmm13
    vaesimc xmm6, xmm6
    vaesdeclast xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm7, xmm7, xmm14
    vaesenc xmm7, xmm7, xmm14
    vaesenc xmm7, xmm7, xmm15
    vaesdeclast xmm6, xmm6, xmm14
    vaesenc xmm6, xmm6, xmm14
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm14
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm14
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm14
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm14
    vpsllw xmm15, xmm8, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm8, xmm8, 1
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm8, xmm8, xmm15
    vpsllw xmm15, xmm9, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm9, xmm9, 1
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm9, xmm9, xmm15
    vpshufb xmm8, xmm8, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vmovdqa xmm8, xmm15
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 160]
    vpxor xmm15, xmm14, xmm10
    vaesenclast xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesenclast xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesenclast xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesenclast xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesenclast xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesenclast xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesenclast xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesenclast xmm7, xmm7, xmm15
    vpunpcklbw xmm14, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm14
    vpunpcklbw xmm14, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vmovdqa xmm2, xmm14
    vpunpcklbw xmm14, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vmovdqa xmm4, xmm14
    vpunpcklbw xmm14, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vmovdqa xmm6, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm14
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm14
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm14
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm14
    vpsllw xmm15, xmm8, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm8, xmm8, 1
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm8, xmm8, xmm15
    vpsllw xmm15, xmm9, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm9, xmm9, 1
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm9, xmm9, xmm15
    vpshufb xmm8, xmm8, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vmovdqa xmm8, xmm15
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 144]
    vpxor xmm15, xmm15, xmm10
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm1, xmm1, xmm14
    vaesenc xmm1, xmm1, xmm14
    vaesenc xmm1, xmm1, xmm15
    vaesdeclast xmm0, xmm0, xmm14
    vaesenc xmm0, xmm0, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 144]
    vpxor xmm15, xmm15, xmm11
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm3, xmm3, xmm14
    vaesenc xmm3, xmm3, xmm14
    vaesenc xmm3, xmm3, xmm15
    vaesdeclast xmm2, xmm2, xmm14
    vaesenc xmm2, xmm2, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 144]
    vpxor xmm15, xmm15, xmm12
    vaesimc xmm4, xmm4
    vaesdeclast xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm5, xmm5, xmm14
    vaesenc xmm5, xmm5, xmm14
    vaesenc xmm5, xmm5, xmm15
    vaesdeclast xmm4, xmm4, xmm14
    vaesenc xmm4, xmm4, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 144]
    vpxor xmm15, xmm15, xmm13
    vaesimc xmm6, xmm6
    vaesdeclast xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm7, xmm7, xmm14
    vaesenc xmm7, xmm7, xmm14
    vaesenc xmm7, xmm7, xmm15
    vaesdeclast xmm6, xmm6, xmm14
    vaesenc xmm6, xmm6, xmm14
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm14
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm14
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm14
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm14
    vpsllw xmm15, xmm8, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm8, xmm8, 1
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm8, xmm8, xmm15
    vpsllw xmm15, xmm9, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm9, xmm9, 1
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm9, xmm9, xmm15
    vpshufb xmm8, xmm8, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vmovdqa xmm8, xmm15
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 128]
    vpxor xmm15, xmm14, xmm10
    vaesenclast xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesenclast xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesenclast xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesenclast xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesenclast xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesenclast xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesenclast xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesenclast xmm7, xmm7, xmm15
    vpunpcklbw xmm14, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm14
    vpunpcklbw xmm14, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vmovdqa xmm2, xmm14
    vpunpcklbw xmm14, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vmovdqa xmm4, xmm14
    vpunpcklbw xmm14, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vmovdqa xmm6, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm14
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm14
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm14
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm14
    vpsllw xmm15, xmm8, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm8, xmm8, 1
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm8, xmm8, xmm15
    vpsllw xmm15, xmm9, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm9, xmm9, 1
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm9, xmm9, xmm15
    vpshufb xmm8, xmm8, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vmovdqa xmm8, xmm15
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 112]
    vpxor xmm15, xmm15, xmm10
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm1, xmm1, xmm14
    vaesenc xmm1, xmm1, xmm14
    vaesenc xmm1, xmm1, xmm15
    vaesdeclast xmm0, xmm0, xmm14
    vaesenc xmm0, xmm0, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 112]
    vpxor xmm15, xmm15, xmm11
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm3, xmm3, xmm14
    vaesenc xmm3, xmm3, xmm14
    vaesenc xmm3, xmm3, xmm15
    vaesdeclast xmm2, xmm2, xmm14
    vaesenc xmm2, xmm2, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 112]
    vpxor xmm15, xmm15, xmm12
    vaesimc xmm4, xmm4
    vaesdeclast xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm5, xmm5, xmm14
    vaesenc xmm5, xmm5, xmm14
    vaesenc xmm5, xmm5, xmm15
    vaesdeclast xmm4, xmm4, xmm14
    vaesenc xmm4, xmm4, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 112]
    vpxor xmm15, xmm15, xmm13
    vaesimc xmm6, xmm6
    vaesdeclast xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm7, xmm7, xmm14
    vaesenc xmm7, xmm7, xmm14
    vaesenc xmm7, xmm7, xmm15
    vaesdeclast xmm6, xmm6, xmm14
    vaesenc xmm6, xmm6, xmm14
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm14
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm14
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm14
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm14
    vpsllw xmm15, xmm8, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm8, xmm8, 1
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm8, xmm8, xmm15
    vpsllw xmm15, xmm9, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm9, xmm9, 1
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm9, xmm9, xmm15
    vpshufb xmm8, xmm8, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vmovdqa xmm8, xmm15
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 96]
    vpxor xmm15, xmm14, xmm10
    vaesenclast xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesenclast xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesenclast xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesenclast xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesenclast xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesenclast xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesenclast xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesenclast xmm7, xmm7, xmm15
    vpunpcklbw xmm14, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm14
    vpunpcklbw xmm14, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vmovdqa xmm2, xmm14
    vpunpcklbw xmm14, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vmovdqa xmm4, xmm14
    vpunpcklbw xmm14, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vmovdqa xmm6, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm14
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm14
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm14
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm14
    vpsllw xmm15, xmm8, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm8, xmm8, 1
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm8, xmm8, xmm15
    vpsllw xmm15, xmm9, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm9, xmm9, 1
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm9, xmm9, xmm15
    vpshufb xmm8, xmm8, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vmovdqa xmm8, xmm15
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 80]
    vpxor xmm15, xmm15, xmm10
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm1, xmm1, xmm14
    vaesenc xmm1, xmm1, xmm14
    vaesenc xmm1, xmm1, xmm15
    vaesdeclast xmm0, xmm0, xmm14
    vaesenc xmm0, xmm0, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 80]
    vpxor xmm15, xmm15, xmm11
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm3, xmm3, xmm14
    vaesenc xmm3, xmm3, xmm14
    vaesenc xmm3, xmm3, xmm15
    vaesdeclast xmm2, xmm2, xmm14
    vaesenc xmm2, xmm2, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 80]
    vpxor xmm15, xmm15, xmm12
    vaesimc xmm4, xmm4
    vaesdeclast xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm5, xmm5, xmm14
    vaesenc xmm5, xmm5, xmm14
    vaesenc xmm5, xmm5, xmm15
    vaesdeclast xmm4, xmm4, xmm14
    vaesenc xmm4, xmm4, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 80]
    vpxor xmm15, xmm15, xmm13
    vaesimc xmm6, xmm6
    vaesdeclast xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm7, xmm7, xmm14
    vaesenc xmm7, xmm7, xmm14
    vaesenc xmm7, xmm7, xmm15
    vaesdeclast xmm6, xmm6, xmm14
    vaesenc xmm6, xmm6, xmm14
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm14
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm14
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm14
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm14
    vpsllw xmm15, xmm8, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm8, xmm8, 1
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm8, xmm8, xmm15
    vpsllw xmm15, xmm9, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm9, xmm9, 1
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm9, xmm9, xmm15
    vpshufb xmm8, xmm8, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vmovdqa xmm8, xmm15
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 64]
    vpxor xmm15, xmm14, xmm10
    vaesenclast xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesenclast xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesenclast xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesenclast xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesenclast xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesenclast xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesenclast xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesenclast xmm7, xmm7, xmm15
    vpunpcklbw xmm14, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm14
    vpunpcklbw xmm14, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vmovdqa xmm2, xmm14
    vpunpcklbw xmm14, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vmovdqa xmm4, xmm14
    vpunpcklbw xmm14, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vmovdqa xmm6, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm14
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm14
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm14
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm14
    vpsllw xmm15, xmm8, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm8, xmm8, 1
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm8, xmm8, xmm15
    vpsllw xmm15, xmm9, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm9, xmm9, 1
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm9, xmm9, xmm15
    vpshufb xmm8, xmm8, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vmovdqa xmm8, xmm15
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 48]
    vpxor xmm15, xmm15, xmm10
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm1, xmm1, xmm14
    vaesenc xmm1, xmm1, xmm14
    vaesenc xmm1, xmm1, xmm15
    vaesdeclast xmm0, xmm0, xmm14
    vaesenc xmm0, xmm0, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 48]
    vpxor xmm15, xmm15, xmm11
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm3, xmm3, xmm14
    vaesenc xmm3, xmm3, xmm14
    vaesenc xmm3, xmm3, xmm15
    vaesdeclast xmm2, xmm2, xmm14
    vaesenc xmm2, xmm2, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 48]
    vpxor xmm15, xmm15, xmm12
    vaesimc xmm4, xmm4
    vaesdeclast xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm5, xmm5, xmm14
    vaesenc xmm5, xmm5, xmm14
    vaesenc xmm5, xmm5, xmm15
    vaesdeclast xmm4, xmm4, xmm14
    vaesenc xmm4, xmm4, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 48]
    vpxor xmm15, xmm15, xmm13
    vaesimc xmm6, xmm6
    vaesdeclast xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm7, xmm7, xmm14
    vaesenc xmm7, xmm7, xmm14
    vaesenc xmm7, xmm7, xmm15
    vaesdeclast xmm6, xmm6, xmm14
    vaesenc xmm6, xmm6, xmm14
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm14
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm14
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm14
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm14
    vpsllw xmm15, xmm8, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm8, xmm8, 1
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm8, xmm8, xmm15
    vpsllw xmm15, xmm9, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm9, xmm9, 1
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm9, xmm9, xmm15
    vpshufb xmm8, xmm8, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vmovdqa xmm8, xmm15
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants + 32]
    vpxor xmm15, xmm14, xmm10
    vaesenclast xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesenclast xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesenclast xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesenclast xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesenclast xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesenclast xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesenclast xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesenclast xmm7, xmm7, xmm15
    vpunpcklbw xmm14, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm14
    vpunpcklbw xmm14, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vmovdqa xmm2, xmm14
    vpunpcklbw xmm14, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vmovdqa xmm4, xmm14
    vpunpcklbw xmm14, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vmovdqa xmm6, xmm14
    vpxor xmm14, xmm14, xmm14
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm14
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm14
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm14
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm14
    vpsllw xmm15, xmm8, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm8, xmm8, 1
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm8, xmm8, xmm15
    vpsllw xmm15, xmm9, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm9, xmm9, 1
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm9, xmm9, xmm15
    vpshufb xmm8, xmm8, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vmovdqa xmm8, xmm15
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 16]
    vpxor xmm15, xmm15, xmm10
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm1, xmm1, xmm14
    vaesenc xmm1, xmm1, xmm14
    vaesenc xmm1, xmm1, xmm15
    vaesdeclast xmm0, xmm0, xmm14
    vaesenc xmm0, xmm0, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 16]
    vpxor xmm15, xmm15, xmm11
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm3, xmm3, xmm14
    vaesenc xmm3, xmm3, xmm14
    vaesenc xmm3, xmm3, xmm15
    vaesdeclast xmm2, xmm2, xmm14
    vaesenc xmm2, xmm2, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 16]
    vpxor xmm15, xmm15, xmm12
    vaesimc xmm4, xmm4
    vaesdeclast xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm5, xmm5, xmm14
    vaesenc xmm5, xmm5, xmm14
    vaesenc xmm5, xmm5, xmm15
    vaesdeclast xmm4, xmm4, xmm14
    vaesenc xmm4, xmm4, xmm14
    vpxor xmm15, xmm8, XMMWORD PTR [asuraRoundConstants + 16]
    vpxor xmm15, xmm15, xmm13
    vaesimc xmm6, xmm6
    vaesdeclast xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesdeclast xmm15, xmm15, xmm14
    vaesenc xmm15, xmm15, xmm14
    vaesdeclast xmm7, xmm7, xmm14
    vaesenc xmm7, xmm7, xmm14
    vaesenc xmm7, xmm7, xmm15
    vaesdeclast xmm6, xmm6, xmm14
    vaesenc xmm6, xmm6, xmm14
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm14
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm14
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm14
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm14
    vpsllw xmm15, xmm8, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm8, xmm8, 1
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm8, xmm8, xmm15
    vpsllw xmm15, xmm9, 7
    vpcmpgtb xmm15, xmm14, xmm15
    vpand xmm15, xmm15, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm9, xmm9, 1
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm9, xmm9, xmm15
    vpshufb xmm8, xmm8, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm15, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vmovdqa xmm8, xmm15
    vpxor xmm14, xmm8, XMMWORD PTR [asuraRoundConstants]
    vpxor xmm15, xmm14, xmm10
    vaesenclast xmm0, xmm0, xmm15
    vpxor xmm15, xmm9, xmm10
    vaesenclast xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesenclast xmm2, xmm2, xmm15
    vpxor xmm15, xmm9, xmm11
    vaesenclast xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesenclast xmm4, xmm4, xmm15
    vpxor xmm15, xmm9, xmm12
    vaesenclast xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesenclast xmm6, xmm6, xmm15
    vpxor xmm15, xmm9, xmm13
    vaesenclast xmm7, xmm7, xmm15
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    xor rcx, rcx
    xor rdx, rdx
    ret
areion_asura_decrypt_4blocks_otf_vex_asm ENDP

PUBLIC areion_asura_encrypt_4blocks_vaes256_asm
ALIGN 16
areion_asura_encrypt_4blocks_vaes256_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    vmovdqu ymm6, YMMWORD PTR [rsi]
    vmovdqu ymm7, YMMWORD PTR [rsi + 32]
    vperm2i128 ymm0, ymm6, ymm7, 32
    vperm2i128 ymm1, ymm6, ymm7, 49
    vmovdqu ymm6, YMMWORD PTR [rsi + 64]
    vmovdqu ymm7, YMMWORD PTR [rsi + 96]
    vperm2i128 ymm2, ymm6, ymm7, 32
    vperm2i128 ymm3, ymm6, ymm7, 49
    vpxor ymm4, ymm4, ymm4
    vmovdqa ymm5, YMMWORD PTR [asuraConsts + 64]
    vbroadcasti128 ymm6, XMMWORD PTR [rdx]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 16]
    vpxor ymm0, ymm0, ymm6
    vpxor ymm1, ymm1, ymm7
    vpxor ymm2, ymm2, ymm6
    vpxor ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 32]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 48]
    vaesdec ymm0, ymm0, ymm6
    vaesdec ymm1, ymm1, ymm7
    vaesdec ymm2, ymm2, ymm6
    vaesdec ymm3, ymm3, ymm7
    vaesenc ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm8, ymm0, ymm5
    vpshufb ymm9, ymm1, ymm5
    vpunpcklqdq ymm0, ymm8, ymm9
    vpunpckhqdq ymm1, ymm8, ymm9
    vpshufb ymm8, ymm2, ymm5
    vpshufb ymm9, ymm3, ymm5
    vpunpcklqdq ymm2, ymm8, ymm9
    vpunpckhqdq ymm3, ymm8, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 64]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 80]
    vpxor ymm0, ymm0, ymm6
    vpxor ymm1, ymm1, ymm7
    vpxor ymm2, ymm2, ymm6
    vpxor ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 96]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 112]
    vaesdec ymm0, ymm0, ymm6
    vaesdec ymm1, ymm1, ymm7
    vaesdec ymm2, ymm2, ymm6
    vaesdec ymm3, ymm3, ymm7
    vaesenc ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm8, ymm0, ymm5
    vpshufb ymm9, ymm1, ymm5
    vpunpcklqdq ymm0, ymm8, ymm9
    vpunpckhqdq ymm1, ymm8, ymm9
    vpshufb ymm8, ymm2, ymm5
    vpshufb ymm9, ymm3, ymm5
    vpunpcklqdq ymm2, ymm8, ymm9
    vpunpckhqdq ymm3, ymm8, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 128]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 144]
    vpxor ymm0, ymm0, ymm6
    vpxor ymm1, ymm1, ymm7
    vpxor ymm2, ymm2, ymm6
    vpxor ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 160]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 176]
    vaesdec ymm0, ymm0, ymm6
    vaesdec ymm1, ymm1, ymm7
    vaesdec ymm2, ymm2, ymm6
    vaesdec ymm3, ymm3, ymm7
    vaesenc ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm8, ymm0, ymm5
    vpshufb ymm9, ymm1, ymm5
    vpunpcklqdq ymm0, ymm8, ymm9
    vpunpckhqdq ymm1, ymm8, ymm9
    vpshufb ymm8, ymm2, ymm5
    vpshufb ymm9, ymm3, ymm5
    vpunpcklqdq ymm2, ymm8, ymm9
    vpunpckhqdq ymm3, ymm8, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 192]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 208]
    vpxor ymm0, ymm0, ymm6
    vpxor ymm1, ymm1, ymm7
    vpxor ymm2, ymm2, ymm6
    vpxor ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 224]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 240]
    vaesdec ymm0, ymm0, ymm6
    vaesdec ymm1, ymm1, ymm7
    vaesdec ymm2, ymm2, ymm6
    vaesdec ymm3, ymm3, ymm7
    vaesenc ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm8, ymm0, ymm5
    vpshufb ymm9, ymm1, ymm5
    vpunpcklqdq ymm0, ymm8, ymm9
    vpunpckhqdq ymm1, ymm8, ymm9
    vpshufb ymm8, ymm2, ymm5
    vpshufb ymm9, ymm3, ymm5
    vpunpcklqdq ymm2, ymm8, ymm9
    vpunpckhqdq ymm3, ymm8, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 256]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 272]
    vpxor ymm0, ymm0, ymm6
    vpxor ymm1, ymm1, ymm7
    vpxor ymm2, ymm2, ymm6
    vpxor ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 288]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 304]
    vaesdec ymm0, ymm0, ymm6
    vaesdec ymm1, ymm1, ymm7
    vaesdec ymm2, ymm2, ymm6
    vaesdec ymm3, ymm3, ymm7
    vaesenc ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm8, ymm0, ymm5
    vpshufb ymm9, ymm1, ymm5
    vpunpcklqdq ymm0, ymm8, ymm9
    vpunpckhqdq ymm1, ymm8, ymm9
    vpshufb ymm8, ymm2, ymm5
    vpshufb ymm9, ymm3, ymm5
    vpunpcklqdq ymm2, ymm8, ymm9
    vpunpckhqdq ymm3, ymm8, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 320]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 336]
    vpxor ymm0, ymm0, ymm6
    vpxor ymm1, ymm1, ymm7
    vpxor ymm2, ymm2, ymm6
    vpxor ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 352]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 368]
    vaesdec ymm0, ymm0, ymm6
    vaesdec ymm1, ymm1, ymm7
    vaesdec ymm2, ymm2, ymm6
    vaesdec ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 384]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 400]
    vaesenc ymm0, ymm0, ymm6
    vaesdec ymm1, ymm1, ymm7
    vaesenc ymm2, ymm2, ymm6
    vaesdec ymm3, ymm3, ymm7
    vperm2i128 ymm6, ymm0, ymm1, 32
    vperm2i128 ymm7, ymm0, ymm1, 49
    vmovdqu YMMWORD PTR [rdi], ymm6
    vmovdqu YMMWORD PTR [rdi + 32], ymm7
    vperm2i128 ymm6, ymm2, ymm3, 32
    vperm2i128 ymm7, ymm2, ymm3, 49
    vmovdqu YMMWORD PTR [rdi + 64], ymm6
    vmovdqu YMMWORD PTR [rdi + 96], ymm7
    vpxor ymm0, ymm0, ymm0
    vpxor ymm1, ymm1, ymm1
    vpxor ymm2, ymm2, ymm2
    vpxor ymm3, ymm3, ymm3
    vpxor ymm4, ymm4, ymm4
    vpxor ymm5, ymm5, ymm5
    vpxor ymm6, ymm6, ymm6
    vpxor ymm7, ymm7, ymm7
    vpxor ymm8, ymm8, ymm8
    vpxor ymm9, ymm9, ymm9
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 88
    xor rdx, rdx
    vzeroupper
    ret
areion_asura_encrypt_4blocks_vaes256_asm ENDP

PUBLIC areion_asura_decrypt_4blocks_vaes256_asm
ALIGN 16
areion_asura_decrypt_4blocks_vaes256_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 72
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    vmovdqu ymm6, YMMWORD PTR [rsi]
    vmovdqu ymm7, YMMWORD PTR [rsi + 32]
    vperm2i128 ymm0, ymm6, ymm7, 32
    vperm2i128 ymm1, ymm6, ymm7, 49
    vmovdqu ymm6, YMMWORD PTR [rsi + 64]
    vmovdqu ymm7, YMMWORD PTR [rsi + 96]
    vperm2i128 ymm2, ymm6, ymm7, 32
    vperm2i128 ymm3, ymm6, ymm7, 49
    vpxor ymm4, ymm4, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 384]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 400]
    vpxor ymm0, ymm0, ymm6
    vpxor ymm1, ymm1, ymm7
    vpxor ymm2, ymm2, ymm6
    vpxor ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 352]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 368]
    vaesdeclast ymm7, ymm7, ymm4
    vaesenclast ymm0, ymm0, ymm4
    vaesdeclast ymm1, ymm1, ymm4
    vaesenclast ymm2, ymm2, ymm4
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm7, ymm7, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesdeclast ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm7
    vaesdeclast ymm2, ymm2, ymm6
    vaesenc ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 320]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 336]
    vaesdeclast ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm7
    vaesenclast ymm2, ymm2, ymm6
    vaesenclast ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 288]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 304]
    vaesdeclast ymm7, ymm7, ymm4
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vaesenclast ymm0, ymm8, ymm4
    vaesdeclast ymm1, ymm1, ymm4
    vpunpcklbw ymm8, ymm2, ymm3
    vpunpckhbw ymm3, ymm2, ymm3
    vaesenclast ymm2, ymm8, ymm4
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm7, ymm7, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesdeclast ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm7
    vaesdeclast ymm2, ymm2, ymm6
    vaesenc ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 256]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 272]
    vaesdeclast ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm7
    vaesenclast ymm2, ymm2, ymm6
    vaesenclast ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 224]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 240]
    vaesdeclast ymm7, ymm7, ymm4
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vaesenclast ymm0, ymm8, ymm4
    vaesdeclast ymm1, ymm1, ymm4
    vpunpcklbw ymm8, ymm2, ymm3
    vpunpckhbw ymm3, ymm2, ymm3
    vaesenclast ymm2, ymm8, ymm4
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm7, ymm7, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesdeclast ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm7
    vaesdeclast ymm2, ymm2, ymm6
    vaesenc ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 192]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 208]
    vaesdeclast ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm7
    vaesenclast ymm2, ymm2, ymm6
    vaesenclast ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 160]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 176]
    vaesdeclast ymm7, ymm7, ymm4
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vaesenclast ymm0, ymm8, ymm4
    vaesdeclast ymm1, ymm1, ymm4
    vpunpcklbw ymm8, ymm2, ymm3
    vpunpckhbw ymm3, ymm2, ymm3
    vaesenclast ymm2, ymm8, ymm4
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm7, ymm7, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesdeclast ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm7
    vaesdeclast ymm2, ymm2, ymm6
    vaesenc ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 128]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 144]
    vaesdeclast ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm7
    vaesenclast ymm2, ymm2, ymm6
    vaesenclast ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 96]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 112]
    vaesdeclast ymm7, ymm7, ymm4
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vaesenclast ymm0, ymm8, ymm4
    vaesdeclast ymm1, ymm1, ymm4
    vpunpcklbw ymm8, ymm2, ymm3
    vpunpckhbw ymm3, ymm2, ymm3
    vaesenclast ymm2, ymm8, ymm4
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm7, ymm7, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesdeclast ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm7
    vaesdeclast ymm2, ymm2, ymm6
    vaesenc ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 64]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 80]
    vaesdeclast ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm7
    vaesenclast ymm2, ymm2, ymm6
    vaesenclast ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 32]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 48]
    vaesdeclast ymm7, ymm7, ymm4
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vaesenclast ymm0, ymm8, ymm4
    vaesdeclast ymm1, ymm1, ymm4
    vpunpcklbw ymm8, ymm2, ymm3
    vpunpckhbw ymm3, ymm2, ymm3
    vaesenclast ymm2, ymm8, ymm4
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm7, ymm7, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesdeclast ymm0, ymm0, ymm6
    vaesenc ymm1, ymm1, ymm7
    vaesdeclast ymm2, ymm2, ymm6
    vaesenc ymm3, ymm3, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 16]
    vaesdeclast ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm0, ymm0, ymm6
    vaesenclast ymm1, ymm1, ymm7
    vaesenclast ymm2, ymm2, ymm6
    vaesenclast ymm3, ymm3, ymm7
    vperm2i128 ymm6, ymm0, ymm1, 32
    vperm2i128 ymm7, ymm0, ymm1, 49
    vmovdqu YMMWORD PTR [rdi], ymm6
    vmovdqu YMMWORD PTR [rdi + 32], ymm7
    vperm2i128 ymm6, ymm2, ymm3, 32
    vperm2i128 ymm7, ymm2, ymm3, 49
    vmovdqu YMMWORD PTR [rdi + 64], ymm6
    vmovdqu YMMWORD PTR [rdi + 96], ymm7
    vpxor ymm0, ymm0, ymm0
    vpxor ymm1, ymm1, ymm1
    vpxor ymm2, ymm2, ymm2
    vpxor ymm3, ymm3, ymm3
    vpxor ymm4, ymm4, ymm4
    vpxor ymm5, ymm5, ymm5
    vpxor ymm6, ymm6, ymm6
    vpxor ymm7, ymm7, ymm7
    vpxor ymm8, ymm8, ymm8
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 72
    xor rdx, rdx
    vzeroupper
    ret
areion_asura_decrypt_4blocks_vaes256_asm ENDP

PUBLIC areion_asura_encrypt_4blocks_otf_vaes256_asm
ALIGN 16
areion_asura_encrypt_4blocks_otf_vaes256_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu ymm6, YMMWORD PTR [rsi]
    vmovdqu ymm7, YMMWORD PTR [rsi + 32]
    vperm2i128 ymm0, ymm6, ymm7, 32
    vperm2i128 ymm1, ymm6, ymm7, 49
    vmovdqu ymm6, YMMWORD PTR [rsi + 64]
    vmovdqu ymm7, YMMWORD PTR [rsi + 96]
    vperm2i128 ymm2, ymm6, ymm7, 32
    vperm2i128 ymm3, ymm6, ymm7, 49
    vbroadcasti128 ymm10, XMMWORD PTR [rdx]
    vbroadcasti128 ymm11, XMMWORD PTR [rdx + 16]
    vmovdqu ymm12, YMMWORD PTR [rcx]
    vmovdqu ymm13, YMMWORD PTR [rcx + 32]
    vpxor ymm4, ymm4, ymm4
    vmovdqa ymm5, YMMWORD PTR [asuraConsts + 64]
    vbroadcasti128 ymm6, XMMWORD PTR [asuraRoundConstants]
    vpxor ymm6, ymm6, ymm10
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm11, ymm12
    vpxor ymm0, ymm0, ymm8
    vpxor ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm11, ymm13
    vpxor ymm2, ymm2, ymm8
    vpxor ymm3, ymm3, ymm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw ymm8, ymm10, ymm11, 204
    vpblendw ymm11, ymm11, ymm10, 204
    vbroadcasti128 ymm6, XMMWORD PTR [asuraConsts]
    vpshufb ymm10, ymm8, ymm6
    vpshufb ymm11, ymm11, ymm6
    vpcmpgtb ymm8, ymm4, ymm10
    vpcmpgtb ymm9, ymm4, ymm11
    vbroadcasti128 ymm6, XMMWORD PTR [asuraGFConsts]
    vpand ymm8, ymm8, ymm6
    vpand ymm9, ymm9, ymm6
    vpaddb ymm10, ymm10, ymm10
    vpaddb ymm11, ymm11, ymm11
    vpxor ymm10, ymm10, ymm8
    vpxor ymm11, ymm11, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [asuraRoundConstants + 16]
    vpxor ymm6, ymm6, ymm10
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm11, ymm12
    vaesdec ymm0, ymm0, ymm8
    vaesdec ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm11, ymm13
    vaesdec ymm2, ymm2, ymm8
    vaesdec ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm8, ymm0, ymm5
    vpshufb ymm9, ymm1, ymm5
    vpunpcklqdq ymm0, ymm8, ymm9
    vpunpckhqdq ymm1, ymm8, ymm9
    vpshufb ymm8, ymm2, ymm5
    vpshufb ymm9, ymm3, ymm5
    vpunpcklqdq ymm2, ymm8, ymm9
    vpunpckhqdq ymm3, ymm8, ymm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw ymm8, ymm10, ymm11, 204
    vpblendw ymm11, ymm11, ymm10, 204
    vbroadcasti128 ymm6, XMMWORD PTR [asuraConsts]
    vpshufb ymm10, ymm8, ymm6
    vpshufb ymm11, ymm11, ymm6
    vpcmpgtb ymm8, ymm4, ymm10
    vpcmpgtb ymm9, ymm4, ymm11
    vbroadcasti128 ymm6, XMMWORD PTR [asuraGFConsts]
    vpand ymm8, ymm8, ymm6
    vpand ymm9, ymm9, ymm6
    vpaddb ymm10, ymm10, ymm10
    vpaddb ymm11, ymm11, ymm11
    vpxor ymm10, ymm10, ymm8
    vpxor ymm11, ymm11, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [asuraRoundConstants + 32]
    vpxor ymm6, ymm6, ymm10
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm11, ymm12
    vpxor ymm0, ymm0, ymm8
    vpxor ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm11, ymm13
    vpxor ymm2, ymm2, ymm8
    vpxor ymm3, ymm3, ymm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw ymm8, ymm10, ymm11, 204
    vpblendw ymm11, ymm11, ymm10, 204
    vbroadcasti128 ymm6, XMMWORD PTR [asuraConsts]
    vpshufb ymm10, ymm8, ymm6
    vpshufb ymm11, ymm11, ymm6
    vpcmpgtb ymm8, ymm4, ymm10
    vpcmpgtb ymm9, ymm4, ymm11
    vbroadcasti128 ymm6, XMMWORD PTR [asuraGFConsts]
    vpand ymm8, ymm8, ymm6
    vpand ymm9, ymm9, ymm6
    vpaddb ymm10, ymm10, ymm10
    vpaddb ymm11, ymm11, ymm11
    vpxor ymm10, ymm10, ymm8
    vpxor ymm11, ymm11, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [asuraRoundConstants + 48]
    vpxor ymm6, ymm6, ymm10
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm11, ymm12
    vaesdec ymm0, ymm0, ymm8
    vaesdec ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm11, ymm13
    vaesdec ymm2, ymm2, ymm8
    vaesdec ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm8, ymm0, ymm5
    vpshufb ymm9, ymm1, ymm5
    vpunpcklqdq ymm0, ymm8, ymm9
    vpunpckhqdq ymm1, ymm8, ymm9
    vpshufb ymm8, ymm2, ymm5
    vpshufb ymm9, ymm3, ymm5
    vpunpcklqdq ymm2, ymm8, ymm9
    vpunpckhqdq ymm3, ymm8, ymm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw ymm8, ymm10, ymm11, 204
    vpblendw ymm11, ymm11, ymm10, 204
    vbroadcasti128 ymm6, XMMWORD PTR [asuraConsts]
    vpshufb ymm10, ymm8, ymm6
    vpshufb ymm11, ymm11, ymm6
    vpcmpgtb ymm8, ymm4, ymm10
    vpcmpgtb ymm9, ymm4, ymm11
    vbroadcasti128 ymm6, XMMWORD PTR [asuraGFConsts]
    vpand ymm8, ymm8, ymm6
    vpand ymm9, ymm9, ymm6
    vpaddb ymm10, ymm10, ymm10
    vpaddb ymm11, ymm11, ymm11
    vpxor ymm10, ymm10, ymm8
    vpxor ymm11, ymm11, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [asuraRoundConstants + 64]
    vpxor ymm6, ymm6, ymm10
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm11, ymm12
    vpxor ymm0, ymm0, ymm8
    vpxor ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm11, ymm13
    vpxor ymm2, ymm2, ymm8
    vpxor ymm3, ymm3, ymm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw ymm8, ymm10, ymm11, 204
    vpblendw ymm11, ymm11, ymm10, 204
    vbroadcasti128 ymm6, XMMWORD PTR [asuraConsts]
    vpshufb ymm10, ymm8, ymm6
    vpshufb ymm11, ymm11, ymm6
    vpcmpgtb ymm8, ymm4, ymm10
    vpcmpgtb ymm9, ymm4, ymm11
    vbroadcasti128 ymm6, XMMWORD PTR [asuraGFConsts]
    vpand ymm8, ymm8, ymm6
    vpand ymm9, ymm9, ymm6
    vpaddb ymm10, ymm10, ymm10
    vpaddb ymm11, ymm11, ymm11
    vpxor ymm10, ymm10, ymm8
    vpxor ymm11, ymm11, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [asuraRoundConstants + 80]
    vpxor ymm6, ymm6, ymm10
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm11, ymm12
    vaesdec ymm0, ymm0, ymm8
    vaesdec ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm11, ymm13
    vaesdec ymm2, ymm2, ymm8
    vaesdec ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm8, ymm0, ymm5
    vpshufb ymm9, ymm1, ymm5
    vpunpcklqdq ymm0, ymm8, ymm9
    vpunpckhqdq ymm1, ymm8, ymm9
    vpshufb ymm8, ymm2, ymm5
    vpshufb ymm9, ymm3, ymm5
    vpunpcklqdq ymm2, ymm8, ymm9
    vpunpckhqdq ymm3, ymm8, ymm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw ymm8, ymm10, ymm11, 204
    vpblendw ymm11, ymm11, ymm10, 204
    vbroadcasti128 ymm6, XMMWORD PTR [asuraConsts]
    vpshufb ymm10, ymm8, ymm6
    vpshufb ymm11, ymm11, ymm6
    vpcmpgtb ymm8, ymm4, ymm10
    vpcmpgtb ymm9, ymm4, ymm11
    vbroadcasti128 ymm6, XMMWORD PTR [asuraGFConsts]
    vpand ymm8, ymm8, ymm6
    vpand ymm9, ymm9, ymm6
    vpaddb ymm10, ymm10, ymm10
    vpaddb ymm11, ymm11, ymm11
    vpxor ymm10, ymm10, ymm8
    vpxor ymm11, ymm11, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [asuraRoundConstants + 96]
    vpxor ymm6, ymm6, ymm10
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm11, ymm12
    vpxor ymm0, ymm0, ymm8
    vpxor ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm11, ymm13
    vpxor ymm2, ymm2, ymm8
    vpxor ymm3, ymm3, ymm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw ymm8, ymm10, ymm11, 204
    vpblendw ymm11, ymm11, ymm10, 204
    vbroadcasti128 ymm6, XMMWORD PTR [asuraConsts]
    vpshufb ymm10, ymm8, ymm6
    vpshufb ymm11, ymm11, ymm6
    vpcmpgtb ymm8, ymm4, ymm10
    vpcmpgtb ymm9, ymm4, ymm11
    vbroadcasti128 ymm6, XMMWORD PTR [asuraGFConsts]
    vpand ymm8, ymm8, ymm6
    vpand ymm9, ymm9, ymm6
    vpaddb ymm10, ymm10, ymm10
    vpaddb ymm11, ymm11, ymm11
    vpxor ymm10, ymm10, ymm8
    vpxor ymm11, ymm11, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [asuraRoundConstants + 112]
    vpxor ymm6, ymm6, ymm10
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm11, ymm12
    vaesdec ymm0, ymm0, ymm8
    vaesdec ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm11, ymm13
    vaesdec ymm2, ymm2, ymm8
    vaesdec ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm8, ymm0, ymm5
    vpshufb ymm9, ymm1, ymm5
    vpunpcklqdq ymm0, ymm8, ymm9
    vpunpckhqdq ymm1, ymm8, ymm9
    vpshufb ymm8, ymm2, ymm5
    vpshufb ymm9, ymm3, ymm5
    vpunpcklqdq ymm2, ymm8, ymm9
    vpunpckhqdq ymm3, ymm8, ymm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw ymm8, ymm10, ymm11, 204
    vpblendw ymm11, ymm11, ymm10, 204
    vbroadcasti128 ymm6, XMMWORD PTR [asuraConsts]
    vpshufb ymm10, ymm8, ymm6
    vpshufb ymm11, ymm11, ymm6
    vpcmpgtb ymm8, ymm4, ymm10
    vpcmpgtb ymm9, ymm4, ymm11
    vbroadcasti128 ymm6, XMMWORD PTR [asuraGFConsts]
    vpand ymm8, ymm8, ymm6
    vpand ymm9, ymm9, ymm6
    vpaddb ymm10, ymm10, ymm10
    vpaddb ymm11, ymm11, ymm11
    vpxor ymm10, ymm10, ymm8
    vpxor ymm11, ymm11, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [asuraRoundConstants + 128]
    vpxor ymm6, ymm6, ymm10
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm11, ymm12
    vpxor ymm0, ymm0, ymm8
    vpxor ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm11, ymm13
    vpxor ymm2, ymm2, ymm8
    vpxor ymm3, ymm3, ymm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw ymm8, ymm10, ymm11, 204
    vpblendw ymm11, ymm11, ymm10, 204
    vbroadcasti128 ymm6, XMMWORD PTR [asuraConsts]
    vpshufb ymm10, ymm8, ymm6
    vpshufb ymm11, ymm11, ymm6
    vpcmpgtb ymm8, ymm4, ymm10
    vpcmpgtb ymm9, ymm4, ymm11
    vbroadcasti128 ymm6, XMMWORD PTR [asuraGFConsts]
    vpand ymm8, ymm8, ymm6
    vpand ymm9, ymm9, ymm6
    vpaddb ymm10, ymm10, ymm10
    vpaddb ymm11, ymm11, ymm11
    vpxor ymm10, ymm10, ymm8
    vpxor ymm11, ymm11, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [asuraRoundConstants + 144]
    vpxor ymm6, ymm6, ymm10
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm11, ymm12
    vaesdec ymm0, ymm0, ymm8
    vaesdec ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm11, ymm13
    vaesdec ymm2, ymm2, ymm8
    vaesdec ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm8, ymm0, ymm5
    vpshufb ymm9, ymm1, ymm5
    vpunpcklqdq ymm0, ymm8, ymm9
    vpunpckhqdq ymm1, ymm8, ymm9
    vpshufb ymm8, ymm2, ymm5
    vpshufb ymm9, ymm3, ymm5
    vpunpcklqdq ymm2, ymm8, ymm9
    vpunpckhqdq ymm3, ymm8, ymm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw ymm8, ymm10, ymm11, 204
    vpblendw ymm11, ymm11, ymm10, 204
    vbroadcasti128 ymm6, XMMWORD PTR [asuraConsts]
    vpshufb ymm10, ymm8, ymm6
    vpshufb ymm11, ymm11, ymm6
    vpcmpgtb ymm8, ymm4, ymm10
    vpcmpgtb ymm9, ymm4, ymm11
    vbroadcasti128 ymm6, XMMWORD PTR [asuraGFConsts]
    vpand ymm8, ymm8, ymm6
    vpand ymm9, ymm9, ymm6
    vpaddb ymm10, ymm10, ymm10
    vpaddb ymm11, ymm11, ymm11
    vpxor ymm10, ymm10, ymm8
    vpxor ymm11, ymm11, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [asuraRoundConstants + 160]
    vpxor ymm6, ymm6, ymm10
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm11, ymm12
    vpxor ymm0, ymm0, ymm8
    vpxor ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm11, ymm13
    vpxor ymm2, ymm2, ymm8
    vpxor ymm3, ymm3, ymm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw ymm8, ymm10, ymm11, 204
    vpblendw ymm11, ymm11, ymm10, 204
    vbroadcasti128 ymm6, XMMWORD PTR [asuraConsts]
    vpshufb ymm10, ymm8, ymm6
    vpshufb ymm11, ymm11, ymm6
    vpcmpgtb ymm8, ymm4, ymm10
    vpcmpgtb ymm9, ymm4, ymm11
    vbroadcasti128 ymm6, XMMWORD PTR [asuraGFConsts]
    vpand ymm8, ymm8, ymm6
    vpand ymm9, ymm9, ymm6
    vpaddb ymm10, ymm10, ymm10
    vpaddb ymm11, ymm11, ymm11
    vpxor ymm10, ymm10, ymm8
    vpxor ymm11, ymm11, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [asuraRoundConstants + 176]
    vpxor ymm6, ymm6, ymm10
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm11, ymm12
    vaesdec ymm0, ymm0, ymm8
    vaesdec ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm11, ymm13
    vaesdec ymm2, ymm2, ymm8
    vaesdec ymm3, ymm3, ymm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw ymm8, ymm10, ymm11, 204
    vpblendw ymm11, ymm11, ymm10, 204
    vbroadcasti128 ymm6, XMMWORD PTR [asuraConsts]
    vpshufb ymm10, ymm8, ymm6
    vpshufb ymm11, ymm11, ymm6
    vpcmpgtb ymm8, ymm4, ymm10
    vpcmpgtb ymm9, ymm4, ymm11
    vbroadcasti128 ymm6, XMMWORD PTR [asuraGFConsts]
    vpand ymm8, ymm8, ymm6
    vpand ymm9, ymm9, ymm6
    vpaddb ymm10, ymm10, ymm10
    vpaddb ymm11, ymm11, ymm11
    vpxor ymm10, ymm10, ymm8
    vpxor ymm11, ymm11, ymm9
    vbroadcasti128 ymm6, XMMWORD PTR [asuraRoundConstants + 192]
    vpxor ymm6, ymm6, ymm10
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm11, ymm12
    vaesenc ymm0, ymm0, ymm8
    vaesdec ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm11, ymm13
    vaesenc ymm2, ymm2, ymm8
    vaesdec ymm3, ymm3, ymm9
    vperm2i128 ymm6, ymm0, ymm1, 32
    vperm2i128 ymm7, ymm0, ymm1, 49
    vmovdqu YMMWORD PTR [rdi], ymm6
    vmovdqu YMMWORD PTR [rdi + 32], ymm7
    vperm2i128 ymm6, ymm2, ymm3, 32
    vperm2i128 ymm7, ymm2, ymm3, 49
    vmovdqu YMMWORD PTR [rdi + 64], ymm6
    vmovdqu YMMWORD PTR [rdi + 96], ymm7
    vpxor ymm0, ymm0, ymm0
    vpxor ymm1, ymm1, ymm1
    vpxor ymm2, ymm2, ymm2
    vpxor ymm3, ymm3, ymm3
    vpxor ymm4, ymm4, ymm4
    vpxor ymm5, ymm5, ymm5
    vpxor ymm6, ymm6, ymm6
    vpxor ymm7, ymm7, ymm7
    vpxor ymm8, ymm8, ymm8
    vpxor ymm9, ymm9, ymm9
    vpxor ymm10, ymm10, ymm10
    vpxor ymm11, ymm11, ymm11
    vpxor ymm12, ymm12, ymm12
    vpxor ymm13, ymm13, ymm13
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 152
    xor rcx, rcx
    xor rdx, rdx
    vzeroupper
    ret
areion_asura_encrypt_4blocks_otf_vaes256_asm ENDP

PUBLIC areion_asura_decrypt_4blocks_otf_vaes256_asm
ALIGN 16
areion_asura_decrypt_4blocks_otf_vaes256_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    vmovdqu XMMWORD PTR [rsp + 128], xmm13
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu ymm6, YMMWORD PTR [rsi]
    vmovdqu ymm7, YMMWORD PTR [rsi + 32]
    vperm2i128 ymm0, ymm6, ymm7, 32
    vperm2i128 ymm1, ymm6, ymm7, 49
    vmovdqu ymm6, YMMWORD PTR [rsi + 64]
    vmovdqu ymm7, YMMWORD PTR [rsi + 96]
    vperm2i128 ymm2, ymm6, ymm7, 32
    vperm2i128 ymm3, ymm6, ymm7, 49
    vmovdqu xmm10, XMMWORD PTR [rdx]
    vmovdqu xmm11, XMMWORD PTR [rdx + 16]
    vmovdqu ymm12, YMMWORD PTR [rcx]
    vmovdqu ymm13, YMMWORD PTR [rcx + 32]
    vpxor ymm4, ymm4, ymm4
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vpshufb xmm10, xmm8, XMMWORD PTR [asuraConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm8, xmm4, xmm10
    vpcmpgtb xmm9, xmm4, xmm11
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm10, xmm10, xmm10
    vpaddb xmm11, xmm11, xmm11
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vpshufb xmm10, xmm8, XMMWORD PTR [asuraConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm8, xmm4, xmm10
    vpcmpgtb xmm9, xmm4, xmm11
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm10, xmm10, xmm10
    vpaddb xmm11, xmm11, xmm11
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vpshufb xmm10, xmm8, XMMWORD PTR [asuraConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm8, xmm4, xmm10
    vpcmpgtb xmm9, xmm4, xmm11
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm10, xmm10, xmm10
    vpaddb xmm11, xmm11, xmm11
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vpshufb xmm10, xmm8, XMMWORD PTR [asuraConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm8, xmm4, xmm10
    vpcmpgtb xmm9, xmm4, xmm11
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm10, xmm10, xmm10
    vpaddb xmm11, xmm11, xmm11
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vpshufb xmm10, xmm8, XMMWORD PTR [asuraConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm8, xmm4, xmm10
    vpcmpgtb xmm9, xmm4, xmm11
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm10, xmm10, xmm10
    vpaddb xmm11, xmm11, xmm11
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vpshufb xmm10, xmm8, XMMWORD PTR [asuraConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm8, xmm4, xmm10
    vpcmpgtb xmm9, xmm4, xmm11
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm10, xmm10, xmm10
    vpaddb xmm11, xmm11, xmm11
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vpshufb xmm10, xmm8, XMMWORD PTR [asuraConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm8, xmm4, xmm10
    vpcmpgtb xmm9, xmm4, xmm11
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm10, xmm10, xmm10
    vpaddb xmm11, xmm11, xmm11
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vpshufb xmm10, xmm8, XMMWORD PTR [asuraConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm8, xmm4, xmm10
    vpcmpgtb xmm9, xmm4, xmm11
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm10, xmm10, xmm10
    vpaddb xmm11, xmm11, xmm11
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vpshufb xmm10, xmm8, XMMWORD PTR [asuraConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm8, xmm4, xmm10
    vpcmpgtb xmm9, xmm4, xmm11
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm10, xmm10, xmm10
    vpaddb xmm11, xmm11, xmm11
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vpshufb xmm10, xmm8, XMMWORD PTR [asuraConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm8, xmm4, xmm10
    vpcmpgtb xmm9, xmm4, xmm11
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm10, xmm10, xmm10
    vpaddb xmm11, xmm11, xmm11
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vpshufb xmm10, xmm8, XMMWORD PTR [asuraConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm8, xmm4, xmm10
    vpcmpgtb xmm9, xmm4, xmm11
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm10, xmm10, xmm10
    vpaddb xmm11, xmm11, xmm11
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vaesenc ymm12, ymm12, ymm4
    vaesenc ymm13, ymm13, ymm4
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vpshufb xmm10, xmm8, XMMWORD PTR [asuraConsts]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm8, xmm4, xmm10
    vpcmpgtb xmm9, xmm4, xmm11
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm10, xmm10, xmm10
    vpaddb xmm11, xmm11, xmm11
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vpxor xmm6, xmm10, XMMWORD PTR [asuraRoundConstants + 192]
    vinserti128 ymm6, ymm6, xmm6, 1
    vinserti128 ymm7, ymm11, xmm11, 1
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm7, ymm12
    vpxor ymm0, ymm0, ymm8
    vpxor ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm7, ymm13
    vpxor ymm2, ymm2, ymm8
    vpxor ymm3, ymm3, ymm9
    vaesenclast ymm12, ymm12, ymm4
    vaesdec ymm12, ymm12, ymm4
    vaesdeclast ymm12, ymm12, ymm4
    vaesenclast ymm13, ymm13, ymm4
    vaesdec ymm13, ymm13, ymm4
    vaesdeclast ymm13, ymm13, ymm4
    vpsllw xmm8, xmm10, 7
    vpsllw xmm9, xmm11, 7
    vpcmpgtb xmm8, xmm4, xmm8
    vpcmpgtb xmm9, xmm4, xmm9
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 32]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm10, xmm10, 1
    vpsrlw xmm11, xmm11, 1
    vpand xmm10, xmm10, XMMWORD PTR [asuraGFConsts + 64]
    vpand xmm11, xmm11, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vpshufb xmm10, xmm10, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vmovdqa xmm10, xmm8
    vpxor xmm6, xmm10, XMMWORD PTR [asuraRoundConstants + 176]
    vinserti128 ymm6, ymm6, xmm6, 1
    vinserti128 ymm7, ymm11, xmm11, 1
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm7, ymm12
    vaesdeclast ymm9, ymm9, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenclast ymm0, ymm0, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesdeclast ymm0, ymm0, ymm8
    vaesdeclast ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm7, ymm13
    vaesdeclast ymm9, ymm9, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenclast ymm2, ymm2, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdeclast ymm2, ymm2, ymm8
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm9
    vaesdeclast ymm0, ymm0, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm12, ymm12, ymm4
    vaesdec ymm12, ymm12, ymm4
    vaesdeclast ymm12, ymm12, ymm4
    vaesenclast ymm13, ymm13, ymm4
    vaesdec ymm13, ymm13, ymm4
    vaesdeclast ymm13, ymm13, ymm4
    vpsllw xmm8, xmm10, 7
    vpsllw xmm9, xmm11, 7
    vpcmpgtb xmm8, xmm4, xmm8
    vpcmpgtb xmm9, xmm4, xmm9
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 32]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm10, xmm10, 1
    vpsrlw xmm11, xmm11, 1
    vpand xmm10, xmm10, XMMWORD PTR [asuraGFConsts + 64]
    vpand xmm11, xmm11, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vpshufb xmm10, xmm10, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vmovdqa xmm10, xmm8
    vpxor xmm6, xmm10, XMMWORD PTR [asuraRoundConstants + 160]
    vinserti128 ymm6, ymm6, xmm6, 1
    vinserti128 ymm7, ymm11, xmm11, 1
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm7, ymm12
    vaesenclast ymm0, ymm0, ymm8
    vaesenclast ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm7, ymm13
    vaesenclast ymm2, ymm2, ymm8
    vaesenclast ymm3, ymm3, ymm9
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vmovdqa ymm0, ymm8
    vpunpcklbw ymm8, ymm2, ymm3
    vpunpckhbw ymm3, ymm2, ymm3
    vmovdqa ymm2, ymm8
    vaesenclast ymm12, ymm12, ymm4
    vaesdec ymm12, ymm12, ymm4
    vaesdeclast ymm12, ymm12, ymm4
    vaesenclast ymm13, ymm13, ymm4
    vaesdec ymm13, ymm13, ymm4
    vaesdeclast ymm13, ymm13, ymm4
    vpsllw xmm8, xmm10, 7
    vpsllw xmm9, xmm11, 7
    vpcmpgtb xmm8, xmm4, xmm8
    vpcmpgtb xmm9, xmm4, xmm9
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 32]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm10, xmm10, 1
    vpsrlw xmm11, xmm11, 1
    vpand xmm10, xmm10, XMMWORD PTR [asuraGFConsts + 64]
    vpand xmm11, xmm11, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vpshufb xmm10, xmm10, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vmovdqa xmm10, xmm8
    vpxor xmm6, xmm10, XMMWORD PTR [asuraRoundConstants + 144]
    vinserti128 ymm6, ymm6, xmm6, 1
    vinserti128 ymm7, ymm11, xmm11, 1
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm7, ymm12
    vaesdeclast ymm9, ymm9, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenclast ymm0, ymm0, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesdeclast ymm0, ymm0, ymm8
    vaesdeclast ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm7, ymm13
    vaesdeclast ymm9, ymm9, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenclast ymm2, ymm2, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdeclast ymm2, ymm2, ymm8
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm9
    vaesdeclast ymm0, ymm0, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm12, ymm12, ymm4
    vaesdec ymm12, ymm12, ymm4
    vaesdeclast ymm12, ymm12, ymm4
    vaesenclast ymm13, ymm13, ymm4
    vaesdec ymm13, ymm13, ymm4
    vaesdeclast ymm13, ymm13, ymm4
    vpsllw xmm8, xmm10, 7
    vpsllw xmm9, xmm11, 7
    vpcmpgtb xmm8, xmm4, xmm8
    vpcmpgtb xmm9, xmm4, xmm9
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 32]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm10, xmm10, 1
    vpsrlw xmm11, xmm11, 1
    vpand xmm10, xmm10, XMMWORD PTR [asuraGFConsts + 64]
    vpand xmm11, xmm11, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vpshufb xmm10, xmm10, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vmovdqa xmm10, xmm8
    vpxor xmm6, xmm10, XMMWORD PTR [asuraRoundConstants + 128]
    vinserti128 ymm6, ymm6, xmm6, 1
    vinserti128 ymm7, ymm11, xmm11, 1
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm7, ymm12
    vaesenclast ymm0, ymm0, ymm8
    vaesenclast ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm7, ymm13
    vaesenclast ymm2, ymm2, ymm8
    vaesenclast ymm3, ymm3, ymm9
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vmovdqa ymm0, ymm8
    vpunpcklbw ymm8, ymm2, ymm3
    vpunpckhbw ymm3, ymm2, ymm3
    vmovdqa ymm2, ymm8
    vaesenclast ymm12, ymm12, ymm4
    vaesdec ymm12, ymm12, ymm4
    vaesdeclast ymm12, ymm12, ymm4
    vaesenclast ymm13, ymm13, ymm4
    vaesdec ymm13, ymm13, ymm4
    vaesdeclast ymm13, ymm13, ymm4
    vpsllw xmm8, xmm10, 7
    vpsllw xmm9, xmm11, 7
    vpcmpgtb xmm8, xmm4, xmm8
    vpcmpgtb xmm9, xmm4, xmm9
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 32]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm10, xmm10, 1
    vpsrlw xmm11, xmm11, 1
    vpand xmm10, xmm10, XMMWORD PTR [asuraGFConsts + 64]
    vpand xmm11, xmm11, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vpshufb xmm10, xmm10, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vmovdqa xmm10, xmm8
    vpxor xmm6, xmm10, XMMWORD PTR [asuraRoundConstants + 112]
    vinserti128 ymm6, ymm6, xmm6, 1
    vinserti128 ymm7, ymm11, xmm11, 1
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm7, ymm12
    vaesdeclast ymm9, ymm9, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenclast ymm0, ymm0, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesdeclast ymm0, ymm0, ymm8
    vaesdeclast ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm7, ymm13
    vaesdeclast ymm9, ymm9, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenclast ymm2, ymm2, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdeclast ymm2, ymm2, ymm8
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm9
    vaesdeclast ymm0, ymm0, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm12, ymm12, ymm4
    vaesdec ymm12, ymm12, ymm4
    vaesdeclast ymm12, ymm12, ymm4
    vaesenclast ymm13, ymm13, ymm4
    vaesdec ymm13, ymm13, ymm4
    vaesdeclast ymm13, ymm13, ymm4
    vpsllw xmm8, xmm10, 7
    vpsllw xmm9, xmm11, 7
    vpcmpgtb xmm8, xmm4, xmm8
    vpcmpgtb xmm9, xmm4, xmm9
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 32]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm10, xmm10, 1
    vpsrlw xmm11, xmm11, 1
    vpand xmm10, xmm10, XMMWORD PTR [asuraGFConsts + 64]
    vpand xmm11, xmm11, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vpshufb xmm10, xmm10, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vmovdqa xmm10, xmm8
    vpxor xmm6, xmm10, XMMWORD PTR [asuraRoundConstants + 96]
    vinserti128 ymm6, ymm6, xmm6, 1
    vinserti128 ymm7, ymm11, xmm11, 1
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm7, ymm12
    vaesenclast ymm0, ymm0, ymm8
    vaesenclast ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm7, ymm13
    vaesenclast ymm2, ymm2, ymm8
    vaesenclast ymm3, ymm3, ymm9
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vmovdqa ymm0, ymm8
    vpunpcklbw ymm8, ymm2, ymm3
    vpunpckhbw ymm3, ymm2, ymm3
    vmovdqa ymm2, ymm8
    vaesenclast ymm12, ymm12, ymm4
    vaesdec ymm12, ymm12, ymm4
    vaesdeclast ymm12, ymm12, ymm4
    vaesenclast ymm13, ymm13, ymm4
    vaesdec ymm13, ymm13, ymm4
    vaesdeclast ymm13, ymm13, ymm4
    vpsllw xmm8, xmm10, 7
    vpsllw xmm9, xmm11, 7
    vpcmpgtb xmm8, xmm4, xmm8
    vpcmpgtb xmm9, xmm4, xmm9
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 32]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm10, xmm10, 1
    vpsrlw xmm11, xmm11, 1
    vpand xmm10, xmm10, XMMWORD PTR [asuraGFConsts + 64]
    vpand xmm11, xmm11, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vpshufb xmm10, xmm10, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vmovdqa xmm10, xmm8
    vpxor xmm6, xmm10, XMMWORD PTR [asuraRoundConstants + 80]
    vinserti128 ymm6, ymm6, xmm6, 1
    vinserti128 ymm7, ymm11, xmm11, 1
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm7, ymm12
    vaesdeclast ymm9, ymm9, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenclast ymm0, ymm0, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesdeclast ymm0, ymm0, ymm8
    vaesdeclast ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm7, ymm13
    vaesdeclast ymm9, ymm9, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenclast ymm2, ymm2, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdeclast ymm2, ymm2, ymm8
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm9
    vaesdeclast ymm0, ymm0, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm12, ymm12, ymm4
    vaesdec ymm12, ymm12, ymm4
    vaesdeclast ymm12, ymm12, ymm4
    vaesenclast ymm13, ymm13, ymm4
    vaesdec ymm13, ymm13, ymm4
    vaesdeclast ymm13, ymm13, ymm4
    vpsllw xmm8, xmm10, 7
    vpsllw xmm9, xmm11, 7
    vpcmpgtb xmm8, xmm4, xmm8
    vpcmpgtb xmm9, xmm4, xmm9
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 32]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm10, xmm10, 1
    vpsrlw xmm11, xmm11, 1
    vpand xmm10, xmm10, XMMWORD PTR [asuraGFConsts + 64]
    vpand xmm11, xmm11, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vpshufb xmm10, xmm10, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vmovdqa xmm10, xmm8
    vpxor xmm6, xmm10, XMMWORD PTR [asuraRoundConstants + 64]
    vinserti128 ymm6, ymm6, xmm6, 1
    vinserti128 ymm7, ymm11, xmm11, 1
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm7, ymm12
    vaesenclast ymm0, ymm0, ymm8
    vaesenclast ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm7, ymm13
    vaesenclast ymm2, ymm2, ymm8
    vaesenclast ymm3, ymm3, ymm9
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vmovdqa ymm0, ymm8
    vpunpcklbw ymm8, ymm2, ymm3
    vpunpckhbw ymm3, ymm2, ymm3
    vmovdqa ymm2, ymm8
    vaesenclast ymm12, ymm12, ymm4
    vaesdec ymm12, ymm12, ymm4
    vaesdeclast ymm12, ymm12, ymm4
    vaesenclast ymm13, ymm13, ymm4
    vaesdec ymm13, ymm13, ymm4
    vaesdeclast ymm13, ymm13, ymm4
    vpsllw xmm8, xmm10, 7
    vpsllw xmm9, xmm11, 7
    vpcmpgtb xmm8, xmm4, xmm8
    vpcmpgtb xmm9, xmm4, xmm9
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 32]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm10, xmm10, 1
    vpsrlw xmm11, xmm11, 1
    vpand xmm10, xmm10, XMMWORD PTR [asuraGFConsts + 64]
    vpand xmm11, xmm11, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vpshufb xmm10, xmm10, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vmovdqa xmm10, xmm8
    vpxor xmm6, xmm10, XMMWORD PTR [asuraRoundConstants + 48]
    vinserti128 ymm6, ymm6, xmm6, 1
    vinserti128 ymm7, ymm11, xmm11, 1
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm7, ymm12
    vaesdeclast ymm9, ymm9, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenclast ymm0, ymm0, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesdeclast ymm0, ymm0, ymm8
    vaesdeclast ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm7, ymm13
    vaesdeclast ymm9, ymm9, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenclast ymm2, ymm2, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdeclast ymm2, ymm2, ymm8
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm9
    vaesdeclast ymm0, ymm0, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm12, ymm12, ymm4
    vaesdec ymm12, ymm12, ymm4
    vaesdeclast ymm12, ymm12, ymm4
    vaesenclast ymm13, ymm13, ymm4
    vaesdec ymm13, ymm13, ymm4
    vaesdeclast ymm13, ymm13, ymm4
    vpsllw xmm8, xmm10, 7
    vpsllw xmm9, xmm11, 7
    vpcmpgtb xmm8, xmm4, xmm8
    vpcmpgtb xmm9, xmm4, xmm9
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 32]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm10, xmm10, 1
    vpsrlw xmm11, xmm11, 1
    vpand xmm10, xmm10, XMMWORD PTR [asuraGFConsts + 64]
    vpand xmm11, xmm11, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vpshufb xmm10, xmm10, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vmovdqa xmm10, xmm8
    vpxor xmm6, xmm10, XMMWORD PTR [asuraRoundConstants + 32]
    vinserti128 ymm6, ymm6, xmm6, 1
    vinserti128 ymm7, ymm11, xmm11, 1
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm7, ymm12
    vaesenclast ymm0, ymm0, ymm8
    vaesenclast ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm7, ymm13
    vaesenclast ymm2, ymm2, ymm8
    vaesenclast ymm3, ymm3, ymm9
    vpunpcklbw ymm8, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vmovdqa ymm0, ymm8
    vpunpcklbw ymm8, ymm2, ymm3
    vpunpckhbw ymm3, ymm2, ymm3
    vmovdqa ymm2, ymm8
    vaesenclast ymm12, ymm12, ymm4
    vaesdec ymm12, ymm12, ymm4
    vaesdeclast ymm12, ymm12, ymm4
    vaesenclast ymm13, ymm13, ymm4
    vaesdec ymm13, ymm13, ymm4
    vaesdeclast ymm13, ymm13, ymm4
    vpsllw xmm8, xmm10, 7
    vpsllw xmm9, xmm11, 7
    vpcmpgtb xmm8, xmm4, xmm8
    vpcmpgtb xmm9, xmm4, xmm9
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 32]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm10, xmm10, 1
    vpsrlw xmm11, xmm11, 1
    vpand xmm10, xmm10, XMMWORD PTR [asuraGFConsts + 64]
    vpand xmm11, xmm11, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vpshufb xmm10, xmm10, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vmovdqa xmm10, xmm8
    vpxor xmm6, xmm10, XMMWORD PTR [asuraRoundConstants + 16]
    vinserti128 ymm6, ymm6, xmm6, 1
    vinserti128 ymm7, ymm11, xmm11, 1
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm7, ymm12
    vaesdeclast ymm9, ymm9, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenclast ymm0, ymm0, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesdeclast ymm0, ymm0, ymm8
    vaesdeclast ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm7, ymm13
    vaesdeclast ymm9, ymm9, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenclast ymm2, ymm2, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdeclast ymm2, ymm2, ymm8
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm9
    vaesdeclast ymm0, ymm0, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm12, ymm12, ymm4
    vaesdec ymm12, ymm12, ymm4
    vaesdeclast ymm12, ymm12, ymm4
    vaesenclast ymm13, ymm13, ymm4
    vaesdec ymm13, ymm13, ymm4
    vaesdeclast ymm13, ymm13, ymm4
    vpsllw xmm8, xmm10, 7
    vpsllw xmm9, xmm11, 7
    vpcmpgtb xmm8, xmm4, xmm8
    vpcmpgtb xmm9, xmm4, xmm9
    vpand xmm8, xmm8, XMMWORD PTR [asuraGFConsts + 32]
    vpand xmm9, xmm9, XMMWORD PTR [asuraGFConsts + 32]
    vpsrlw xmm10, xmm10, 1
    vpsrlw xmm11, xmm11, 1
    vpand xmm10, xmm10, XMMWORD PTR [asuraGFConsts + 64]
    vpand xmm11, xmm11, XMMWORD PTR [asuraGFConsts + 64]
    vpxor xmm10, xmm10, xmm8
    vpxor xmm11, xmm11, xmm9
    vpshufb xmm10, xmm10, XMMWORD PTR [asuraConsts + 32]
    vpshufb xmm11, xmm11, XMMWORD PTR [asuraConsts + 32]
    vpblendw xmm8, xmm10, xmm11, 204
    vpblendw xmm11, xmm11, xmm10, 204
    vmovdqa xmm10, xmm8
    vpxor xmm6, xmm10, XMMWORD PTR [asuraRoundConstants]
    vinserti128 ymm6, ymm6, xmm6, 1
    vinserti128 ymm7, ymm11, xmm11, 1
    vpxor ymm8, ymm6, ymm12
    vpxor ymm9, ymm7, ymm12
    vaesenclast ymm0, ymm0, ymm8
    vaesenclast ymm1, ymm1, ymm9
    vpxor ymm8, ymm6, ymm13
    vpxor ymm9, ymm7, ymm13
    vaesenclast ymm2, ymm2, ymm8
    vaesenclast ymm3, ymm3, ymm9
    vperm2i128 ymm6, ymm0, ymm1, 32
    vperm2i128 ymm7, ymm0, ymm1, 49
    vmovdqu YMMWORD PTR [rdi], ymm6
    vmovdqu YMMWORD PTR [rdi + 32], ymm7
    vperm2i128 ymm6, ymm2, ymm3, 32
    vperm2i128 ymm7, ymm2, ymm3, 49
    vmovdqu YMMWORD PTR [rdi + 64], ymm6
    vmovdqu YMMWORD PTR [rdi + 96], ymm7
    vpxor ymm0, ymm0, ymm0
    vpxor ymm1, ymm1, ymm1
    vpxor ymm2, ymm2, ymm2
    vpxor ymm3, ymm3, ymm3
    vpxor ymm4, ymm4, ymm4
    vpxor ymm5, ymm5, ymm5
    vpxor ymm6, ymm6, ymm6
    vpxor ymm7, ymm7, ymm7
    vpxor ymm8, ymm8, ymm8
    vpxor ymm9, ymm9, ymm9
    vpxor ymm10, ymm10, ymm10
    vpxor ymm11, ymm11, ymm11
    vpxor ymm12, ymm12, ymm12
    vpxor ymm13, ymm13, ymm13
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 152
    xor rcx, rcx
    xor rdx, rdx
    vzeroupper
    ret
areion_asura_decrypt_4blocks_otf_vaes256_asm ENDP

PUBLIC areion_asura_encrypt_4blocks_vaes512_asm
ALIGN 16
areion_asura_encrypt_4blocks_vaes512_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 56
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    vmovdqu64 zmm6, ZMMWORD PTR [rsi]
    vmovdqu64 zmm7, ZMMWORD PTR [rsi + 64]
    vshufi64x2 zmm0, zmm6, zmm7, 136
    vshufi64x2 zmm1, zmm6, zmm7, 221
    vpxorq zmm2, zmm2, zmm2
    vbroadcasti32x4 zmm3, XMMWORD PTR [asuraConsts + 64]
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 16]
    vpxorq zmm0, zmm0, zmm4
    vpxorq zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 32]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 48]
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm2
    vpshufb zmm6, zmm0, zmm3
    vpshufb zmm7, zmm1, zmm3
    vpunpcklqdq zmm0, zmm6, zmm7
    vpunpckhqdq zmm1, zmm6, zmm7
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 64]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 80]
    vpxorq zmm0, zmm0, zmm4
    vpxorq zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 96]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 112]
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm2
    vpshufb zmm6, zmm0, zmm3
    vpshufb zmm7, zmm1, zmm3
    vpunpcklqdq zmm0, zmm6, zmm7
    vpunpckhqdq zmm1, zmm6, zmm7
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 128]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 144]
    vpxorq zmm0, zmm0, zmm4
    vpxorq zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 160]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 176]
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm2
    vpshufb zmm6, zmm0, zmm3
    vpshufb zmm7, zmm1, zmm3
    vpunpcklqdq zmm0, zmm6, zmm7
    vpunpckhqdq zmm1, zmm6, zmm7
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 192]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 208]
    vpxorq zmm0, zmm0, zmm4
    vpxorq zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 224]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 240]
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm2
    vpshufb zmm6, zmm0, zmm3
    vpshufb zmm7, zmm1, zmm3
    vpunpcklqdq zmm0, zmm6, zmm7
    vpunpckhqdq zmm1, zmm6, zmm7
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 256]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 272]
    vpxorq zmm0, zmm0, zmm4
    vpxorq zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 288]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 304]
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm2
    vpshufb zmm6, zmm0, zmm3
    vpshufb zmm7, zmm1, zmm3
    vpunpcklqdq zmm0, zmm6, zmm7
    vpunpckhqdq zmm1, zmm6, zmm7
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 320]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 336]
    vpxorq zmm0, zmm0, zmm4
    vpxorq zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 352]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 368]
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 384]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 400]
    vaesenc zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vshufi64x2 zmm6, zmm0, zmm1, 68
    vshufi64x2 zmm6, zmm6, zmm6, 216
    vshufi64x2 zmm7, zmm0, zmm1, 238
    vshufi64x2 zmm7, zmm7, zmm7, 216
    vmovdqu64 ZMMWORD PTR [rdi], zmm6
    vmovdqu64 ZMMWORD PTR [rdi + 64], zmm7
    vpxorq zmm0, zmm0, zmm0
    vpxorq zmm1, zmm1, zmm1
    vpxorq zmm2, zmm2, zmm2
    vpxorq zmm3, zmm3, zmm3
    vpxorq zmm4, zmm4, zmm4
    vpxorq zmm5, zmm5, zmm5
    vpxorq zmm6, zmm6, zmm6
    vpxorq zmm7, zmm7, zmm7
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 56
    xor rdx, rdx
    vzeroupper
    ret
areion_asura_encrypt_4blocks_vaes512_asm ENDP

PUBLIC areion_asura_decrypt_4blocks_vaes512_asm
ALIGN 16
areion_asura_decrypt_4blocks_vaes512_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 56
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    vmovdqu64 zmm6, ZMMWORD PTR [rsi]
    vmovdqu64 zmm7, ZMMWORD PTR [rsi + 64]
    vshufi64x2 zmm0, zmm6, zmm7, 136
    vshufi64x2 zmm1, zmm6, zmm7, 221
    vpxorq zmm2, zmm2, zmm2
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 384]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 400]
    vpxorq zmm0, zmm0, zmm4
    vpxorq zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 352]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 368]
    vaesdeclast zmm5, zmm5, zmm2
    vaesenclast zmm0, zmm0, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesenc zmm5, zmm5, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm4
    vaesenc zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 320]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 336]
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm4
    vaesenclast zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 288]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 304]
    vaesdeclast zmm5, zmm5, zmm2
    vpunpcklbw zmm6, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm6, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesenc zmm5, zmm5, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm4
    vaesenc zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 256]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 272]
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm4
    vaesenclast zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 224]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 240]
    vaesdeclast zmm5, zmm5, zmm2
    vpunpcklbw zmm6, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm6, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesenc zmm5, zmm5, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm4
    vaesenc zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 192]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 208]
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm4
    vaesenclast zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 160]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 176]
    vaesdeclast zmm5, zmm5, zmm2
    vpunpcklbw zmm6, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm6, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesenc zmm5, zmm5, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm4
    vaesenc zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 128]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 144]
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm4
    vaesenclast zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 96]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 112]
    vaesdeclast zmm5, zmm5, zmm2
    vpunpcklbw zmm6, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm6, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesenc zmm5, zmm5, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm4
    vaesenc zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 64]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 80]
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm4
    vaesenclast zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 32]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 48]
    vaesdeclast zmm5, zmm5, zmm2
    vpunpcklbw zmm6, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm6, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesenc zmm5, zmm5, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm4
    vaesenc zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 16]
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm4
    vaesenclast zmm1, zmm1, zmm5
    vshufi64x2 zmm6, zmm0, zmm1, 68
    vshufi64x2 zmm6, zmm6, zmm6, 216
    vshufi64x2 zmm7, zmm0, zmm1, 238
    vshufi64x2 zmm7, zmm7, zmm7, 216
    vmovdqu64 ZMMWORD PTR [rdi], zmm6
    vmovdqu64 ZMMWORD PTR [rdi + 64], zmm7
    vpxorq zmm0, zmm0, zmm0
    vpxorq zmm1, zmm1, zmm1
    vpxorq zmm2, zmm2, zmm2
    vpxorq zmm3, zmm3, zmm3
    vpxorq zmm4, zmm4, zmm4
    vpxorq zmm5, zmm5, zmm5
    vpxorq zmm6, zmm6, zmm6
    vpxorq zmm7, zmm7, zmm7
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 56
    xor rdx, rdx
    vzeroupper
    ret
areion_asura_decrypt_4blocks_vaes512_asm ENDP

PUBLIC areion_asura_encrypt_4blocks_otf_vaes512_asm
ALIGN 16
areion_asura_encrypt_4blocks_otf_vaes512_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 136
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm10
    vmovdqu XMMWORD PTR [rsp + 96], xmm11
    vmovdqu XMMWORD PTR [rsp + 112], xmm12
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu64 zmm11, ZMMWORD PTR [rsi]
    vmovdqu64 zmm12, ZMMWORD PTR [rsi + 64]
    vshufi64x2 zmm0, zmm11, zmm12, 136
    vshufi64x2 zmm1, zmm11, zmm12, 221
    vmovdqu xmm8, XMMWORD PTR [rdx]
    vmovdqu xmm9, XMMWORD PTR [rdx + 16]
    vmovdqu64 zmm10, ZMMWORD PTR [rcx]
    vpxorq zmm2, zmm2, zmm2
    vbroadcasti32x4 zmm3, XMMWORD PTR [asuraConsts + 64]
    vpxor xmm4, xmm8, XMMWORD PTR [asuraRoundConstants]
    vshufi32x4 zmm4, zmm4, zmm4, 0
    vshufi32x4 zmm5, zmm9, zmm9, 0
    vpternlogq zmm0, zmm4, zmm10, 150
    vpternlogq zmm1, zmm5, zmm10, 150
    vaesenc zmm10, zmm10, zmm2
    vpblendw xmm6, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm8
    vpcmpgtb xmm7, xmm2, xmm9
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm6
    vpxor xmm9, xmm9, xmm7
    vpxor xmm4, xmm8, XMMWORD PTR [asuraRoundConstants + 16]
    vshufi32x4 zmm4, zmm4, zmm4, 0
    vshufi32x4 zmm5, zmm9, zmm9, 0
    vpxorq zmm4, zmm4, zmm10
    vpxorq zmm5, zmm5, zmm10
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm2
    vpshufb zmm11, zmm0, zmm3
    vpshufb zmm12, zmm1, zmm3
    vpunpcklqdq zmm0, zmm11, zmm12
    vpunpckhqdq zmm1, zmm11, zmm12
    vaesenc zmm10, zmm10, zmm2
    vpblendw xmm6, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm8
    vpcmpgtb xmm7, xmm2, xmm9
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm6
    vpxor xmm9, xmm9, xmm7
    vpxor xmm4, xmm8, XMMWORD PTR [asuraRoundConstants + 32]
    vshufi32x4 zmm4, zmm4, zmm4, 0
    vshufi32x4 zmm5, zmm9, zmm9, 0
    vpternlogq zmm0, zmm4, zmm10, 150
    vpternlogq zmm1, zmm5, zmm10, 150
    vaesenc zmm10, zmm10, zmm2
    vpblendw xmm6, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm8
    vpcmpgtb xmm7, xmm2, xmm9
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm6
    vpxor xmm9, xmm9, xmm7
    vpxor xmm4, xmm8, XMMWORD PTR [asuraRoundConstants + 48]
    vshufi32x4 zmm4, zmm4, zmm4, 0
    vshufi32x4 zmm5, zmm9, zmm9, 0
    vpxorq zmm4, zmm4, zmm10
    vpxorq zmm5, zmm5, zmm10
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm2
    vpshufb zmm11, zmm0, zmm3
    vpshufb zmm12, zmm1, zmm3
    vpunpcklqdq zmm0, zmm11, zmm12
    vpunpckhqdq zmm1, zmm11, zmm12
    vaesenc zmm10, zmm10, zmm2
    vpblendw xmm6, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm8
    vpcmpgtb xmm7, xmm2, xmm9
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm6
    vpxor xmm9, xmm9, xmm7
    vpxor xmm4, xmm8, XMMWORD PTR [asuraRoundConstants + 64]
    vshufi32x4 zmm4, zmm4, zmm4, 0
    vshufi32x4 zmm5, zmm9, zmm9, 0
    vpternlogq zmm0, zmm4, zmm10, 150
    vpternlogq zmm1, zmm5, zmm10, 150
    vaesenc zmm10, zmm10, zmm2
    vpblendw xmm6, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm8
    vpcmpgtb xmm7, xmm2, xmm9
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm6
    vpxor xmm9, xmm9, xmm7
    vpxor xmm4, xmm8, XMMWORD PTR [asuraRoundConstants + 80]
    vshufi32x4 zmm4, zmm4, zmm4, 0
    vshufi32x4 zmm5, zmm9, zmm9, 0
    vpxorq zmm4, zmm4, zmm10
    vpxorq zmm5, zmm5, zmm10
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm2
    vpshufb zmm11, zmm0, zmm3
    vpshufb zmm12, zmm1, zmm3
    vpunpcklqdq zmm0, zmm11, zmm12
    vpunpckhqdq zmm1, zmm11, zmm12
    vaesenc zmm10, zmm10, zmm2
    vpblendw xmm6, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm8
    vpcmpgtb xmm7, xmm2, xmm9
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm6
    vpxor xmm9, xmm9, xmm7
    vpxor xmm4, xmm8, XMMWORD PTR [asuraRoundConstants + 96]
    vshufi32x4 zmm4, zmm4, zmm4, 0
    vshufi32x4 zmm5, zmm9, zmm9, 0
    vpternlogq zmm0, zmm4, zmm10, 150
    vpternlogq zmm1, zmm5, zmm10, 150
    vaesenc zmm10, zmm10, zmm2
    vpblendw xmm6, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm8
    vpcmpgtb xmm7, xmm2, xmm9
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm6
    vpxor xmm9, xmm9, xmm7
    vpxor xmm4, xmm8, XMMWORD PTR [asuraRoundConstants + 112]
    vshufi32x4 zmm4, zmm4, zmm4, 0
    vshufi32x4 zmm5, zmm9, zmm9, 0
    vpxorq zmm4, zmm4, zmm10
    vpxorq zmm5, zmm5, zmm10
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm2
    vpshufb zmm11, zmm0, zmm3
    vpshufb zmm12, zmm1, zmm3
    vpunpcklqdq zmm0, zmm11, zmm12
    vpunpckhqdq zmm1, zmm11, zmm12
    vaesenc zmm10, zmm10, zmm2
    vpblendw xmm6, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm8
    vpcmpgtb xmm7, xmm2, xmm9
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm6
    vpxor xmm9, xmm9, xmm7
    vpxor xmm4, xmm8, XMMWORD PTR [asuraRoundConstants + 128]
    vshufi32x4 zmm4, zmm4, zmm4, 0
    vshufi32x4 zmm5, zmm9, zmm9, 0
    vpternlogq zmm0, zmm4, zmm10, 150
    vpternlogq zmm1, zmm5, zmm10, 150
    vaesenc zmm10, zmm10, zmm2
    vpblendw xmm6, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm8
    vpcmpgtb xmm7, xmm2, xmm9
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm6
    vpxor xmm9, xmm9, xmm7
    vpxor xmm4, xmm8, XMMWORD PTR [asuraRoundConstants + 144]
    vshufi32x4 zmm4, zmm4, zmm4, 0
    vshufi32x4 zmm5, zmm9, zmm9, 0
    vpxorq zmm4, zmm4, zmm10
    vpxorq zmm5, zmm5, zmm10
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm2
    vpshufb zmm11, zmm0, zmm3
    vpshufb zmm12, zmm1, zmm3
    vpunpcklqdq zmm0, zmm11, zmm12
    vpunpckhqdq zmm1, zmm11, zmm12
    vaesenc zmm10, zmm10, zmm2
    vpblendw xmm6, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm8
    vpcmpgtb xmm7, xmm2, xmm9
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm6
    vpxor xmm9, xmm9, xmm7
    vpxor xmm4, xmm8, XMMWORD PTR [asuraRoundConstants + 160]
    vshufi32x4 zmm4, zmm4, zmm4, 0
    vshufi32x4 zmm5, zmm9, zmm9, 0
    vpternlogq zmm0, zmm4, zmm10, 150
    vpternlogq zmm1, zmm5, zmm10, 150
    vaesenc zmm10, zmm10, zmm2
    vpblendw xmm6, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm8
    vpcmpgtb xmm7, xmm2, xmm9
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm6
    vpxor xmm9, xmm9, xmm7
    vpxor xmm4, xmm8, XMMWORD PTR [asuraRoundConstants + 176]
    vshufi32x4 zmm4, zmm4, zmm4, 0
    vshufi32x4 zmm5, zmm9, zmm9, 0
    vpxorq zmm4, zmm4, zmm10
    vpxorq zmm5, zmm5, zmm10
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm10, zmm10, zmm2
    vpblendw xmm6, xmm8, xmm9, 204
    vpblendw xmm9, xmm9, xmm8, 204
    vpshufb xmm8, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm9, xmm9, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm8
    vpcmpgtb xmm7, xmm2, xmm9
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm8, xmm8, xmm8
    vpaddb xmm9, xmm9, xmm9
    vpxor xmm8, xmm8, xmm6
    vpxor xmm9, xmm9, xmm7
    vpxor xmm4, xmm8, XMMWORD PTR [asuraRoundConstants + 192]
    vshufi32x4 zmm4, zmm4, zmm4, 0
    vshufi32x4 zmm5, zmm9, zmm9, 0
    vpxorq zmm4, zmm4, zmm10
    vpxorq zmm5, zmm5, zmm10
    vaesenc zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vshufi64x2 zmm11, zmm0, zmm1, 68
    vshufi64x2 zmm11, zmm11, zmm11, 216
    vshufi64x2 zmm12, zmm0, zmm1, 238
    vshufi64x2 zmm12, zmm12, zmm12, 216
    vmovdqu64 ZMMWORD PTR [rdi], zmm11
    vmovdqu64 ZMMWORD PTR [rdi + 64], zmm12
    vpxorq zmm0, zmm0, zmm0
    vpxorq zmm1, zmm1, zmm1
    vpxorq zmm2, zmm2, zmm2
    vpxorq zmm3, zmm3, zmm3
    vpxorq zmm4, zmm4, zmm4
    vpxorq zmm5, zmm5, zmm5
    vpxorq zmm6, zmm6, zmm6
    vpxorq zmm7, zmm7, zmm7
    vpxorq zmm8, zmm8, zmm8
    vpxorq zmm9, zmm9, zmm9
    vpxorq zmm10, zmm10, zmm10
    vpxorq zmm11, zmm11, zmm11
    vpxorq zmm12, zmm12, zmm12
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 136
    xor rcx, rcx
    xor rdx, rdx
    vzeroupper
    ret
areion_asura_encrypt_4blocks_otf_vaes512_asm ENDP

PUBLIC areion_asura_decrypt_4blocks_otf_vaes512_asm
ALIGN 16
areion_asura_decrypt_4blocks_otf_vaes512_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    vmovdqu64 zmm6, ZMMWORD PTR [rsi]
    vmovdqu64 zmm7, ZMMWORD PTR [rsi + 64]
    vshufi64x2 zmm0, zmm6, zmm7, 136
    vshufi64x2 zmm1, zmm6, zmm7, 221
    vmovdqu xmm3, XMMWORD PTR [rdx]
    vmovdqu xmm4, XMMWORD PTR [rdx + 16]
    vmovdqu64 zmm5, ZMMWORD PTR [rcx]
    vpxorq zmm2, zmm2, zmm2
    vpxor xmm6, xmm3, XMMWORD PTR [asuraRoundConstants]
    vshufi64x2 zmm8, zmm6, zmm6, 0
    vshufi64x2 zmm9, zmm4, zmm4, 0
    vpxorq zmm8, zmm8, zmm5
    vpxorq zmm9, zmm9, zmm5
    vaesenc zmm5, zmm5, zmm2
    vpblendw xmm6, xmm3, xmm4, 204
    vpblendw xmm4, xmm4, xmm3, 204
    vpshufb xmm3, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm3
    vpcmpgtb xmm7, xmm2, xmm4
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm3, xmm3, xmm3
    vpaddb xmm4, xmm4, xmm4
    vpxor xmm3, xmm3, xmm6
    vpxor xmm4, xmm4, xmm7
    vpxor xmm6, xmm3, XMMWORD PTR [asuraRoundConstants + 16]
    vshufi64x2 zmm10, zmm6, zmm6, 0
    vshufi64x2 zmm11, zmm4, zmm4, 0
    vpxorq zmm10, zmm10, zmm5
    vpxorq zmm11, zmm11, zmm5
    vaesdeclast zmm11, zmm11, zmm2
    vaesenc zmm11, zmm11, zmm2
    vaesenc zmm5, zmm5, zmm2
    vpblendw xmm6, xmm3, xmm4, 204
    vpblendw xmm4, xmm4, xmm3, 204
    vpshufb xmm3, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm3
    vpcmpgtb xmm7, xmm2, xmm4
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm3, xmm3, xmm3
    vpaddb xmm4, xmm4, xmm4
    vpxor xmm3, xmm3, xmm6
    vpxor xmm4, xmm4, xmm7
    vpxor xmm6, xmm3, XMMWORD PTR [asuraRoundConstants + 32]
    vshufi64x2 zmm12, zmm6, zmm6, 0
    vshufi64x2 zmm13, zmm4, zmm4, 0
    vpxorq zmm12, zmm12, zmm5
    vpxorq zmm13, zmm13, zmm5
    vaesenc zmm5, zmm5, zmm2
    vpblendw xmm6, xmm3, xmm4, 204
    vpblendw xmm4, xmm4, xmm3, 204
    vpshufb xmm3, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm3
    vpcmpgtb xmm7, xmm2, xmm4
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm3, xmm3, xmm3
    vpaddb xmm4, xmm4, xmm4
    vpxor xmm3, xmm3, xmm6
    vpxor xmm4, xmm4, xmm7
    vpxor xmm6, xmm3, XMMWORD PTR [asuraRoundConstants + 48]
    vshufi64x2 zmm14, zmm6, zmm6, 0
    vshufi64x2 zmm15, zmm4, zmm4, 0
    vpxorq zmm14, zmm14, zmm5
    vpxorq zmm15, zmm15, zmm5
    vaesdeclast zmm15, zmm15, zmm2
    vaesenc zmm15, zmm15, zmm2
    vaesenc zmm5, zmm5, zmm2
    vpblendw xmm6, xmm3, xmm4, 204
    vpblendw xmm4, xmm4, xmm3, 204
    vpshufb xmm3, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm3
    vpcmpgtb xmm7, xmm2, xmm4
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm3, xmm3, xmm3
    vpaddb xmm4, xmm4, xmm4
    vpxor xmm3, xmm3, xmm6
    vpxor xmm4, xmm4, xmm7
    vpxor xmm6, xmm3, XMMWORD PTR [asuraRoundConstants + 64]
    vshufi64x2 zmm16, zmm6, zmm6, 0
    vshufi64x2 zmm17, zmm4, zmm4, 0
    vpxorq zmm16, zmm16, zmm5
    vpxorq zmm17, zmm17, zmm5
    vaesenc zmm5, zmm5, zmm2
    vpblendw xmm6, xmm3, xmm4, 204
    vpblendw xmm4, xmm4, xmm3, 204
    vpshufb xmm3, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm3
    vpcmpgtb xmm7, xmm2, xmm4
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm3, xmm3, xmm3
    vpaddb xmm4, xmm4, xmm4
    vpxor xmm3, xmm3, xmm6
    vpxor xmm4, xmm4, xmm7
    vpxor xmm6, xmm3, XMMWORD PTR [asuraRoundConstants + 80]
    vshufi64x2 zmm18, zmm6, zmm6, 0
    vshufi64x2 zmm19, zmm4, zmm4, 0
    vpxorq zmm18, zmm18, zmm5
    vpxorq zmm19, zmm19, zmm5
    vaesdeclast zmm19, zmm19, zmm2
    vaesenc zmm19, zmm19, zmm2
    vaesenc zmm5, zmm5, zmm2
    vpblendw xmm6, xmm3, xmm4, 204
    vpblendw xmm4, xmm4, xmm3, 204
    vpshufb xmm3, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm3
    vpcmpgtb xmm7, xmm2, xmm4
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm3, xmm3, xmm3
    vpaddb xmm4, xmm4, xmm4
    vpxor xmm3, xmm3, xmm6
    vpxor xmm4, xmm4, xmm7
    vpxor xmm6, xmm3, XMMWORD PTR [asuraRoundConstants + 96]
    vshufi64x2 zmm20, zmm6, zmm6, 0
    vshufi64x2 zmm21, zmm4, zmm4, 0
    vpxorq zmm20, zmm20, zmm5
    vpxorq zmm21, zmm21, zmm5
    vaesenc zmm5, zmm5, zmm2
    vpblendw xmm6, xmm3, xmm4, 204
    vpblendw xmm4, xmm4, xmm3, 204
    vpshufb xmm3, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm3
    vpcmpgtb xmm7, xmm2, xmm4
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm3, xmm3, xmm3
    vpaddb xmm4, xmm4, xmm4
    vpxor xmm3, xmm3, xmm6
    vpxor xmm4, xmm4, xmm7
    vpxor xmm6, xmm3, XMMWORD PTR [asuraRoundConstants + 112]
    vshufi64x2 zmm22, zmm6, zmm6, 0
    vshufi64x2 zmm23, zmm4, zmm4, 0
    vpxorq zmm22, zmm22, zmm5
    vpxorq zmm23, zmm23, zmm5
    vaesdeclast zmm23, zmm23, zmm2
    vaesenc zmm23, zmm23, zmm2
    vaesenc zmm5, zmm5, zmm2
    vpblendw xmm6, xmm3, xmm4, 204
    vpblendw xmm4, xmm4, xmm3, 204
    vpshufb xmm3, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm3
    vpcmpgtb xmm7, xmm2, xmm4
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm3, xmm3, xmm3
    vpaddb xmm4, xmm4, xmm4
    vpxor xmm3, xmm3, xmm6
    vpxor xmm4, xmm4, xmm7
    vpxor xmm6, xmm3, XMMWORD PTR [asuraRoundConstants + 128]
    vshufi64x2 zmm24, zmm6, zmm6, 0
    vshufi64x2 zmm25, zmm4, zmm4, 0
    vpxorq zmm24, zmm24, zmm5
    vpxorq zmm25, zmm25, zmm5
    vaesenc zmm5, zmm5, zmm2
    vpblendw xmm6, xmm3, xmm4, 204
    vpblendw xmm4, xmm4, xmm3, 204
    vpshufb xmm3, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm3
    vpcmpgtb xmm7, xmm2, xmm4
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm3, xmm3, xmm3
    vpaddb xmm4, xmm4, xmm4
    vpxor xmm3, xmm3, xmm6
    vpxor xmm4, xmm4, xmm7
    vpxor xmm6, xmm3, XMMWORD PTR [asuraRoundConstants + 144]
    vshufi64x2 zmm26, zmm6, zmm6, 0
    vshufi64x2 zmm27, zmm4, zmm4, 0
    vpxorq zmm26, zmm26, zmm5
    vpxorq zmm27, zmm27, zmm5
    vaesdeclast zmm27, zmm27, zmm2
    vaesenc zmm27, zmm27, zmm2
    vaesenc zmm5, zmm5, zmm2
    vpblendw xmm6, xmm3, xmm4, 204
    vpblendw xmm4, xmm4, xmm3, 204
    vpshufb xmm3, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm3
    vpcmpgtb xmm7, xmm2, xmm4
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm3, xmm3, xmm3
    vpaddb xmm4, xmm4, xmm4
    vpxor xmm3, xmm3, xmm6
    vpxor xmm4, xmm4, xmm7
    vpxor xmm6, xmm3, XMMWORD PTR [asuraRoundConstants + 160]
    vshufi64x2 zmm28, zmm6, zmm6, 0
    vshufi64x2 zmm29, zmm4, zmm4, 0
    vpxorq zmm28, zmm28, zmm5
    vpxorq zmm29, zmm29, zmm5
    vaesenc zmm5, zmm5, zmm2
    vpblendw xmm6, xmm3, xmm4, 204
    vpblendw xmm4, xmm4, xmm3, 204
    vpshufb xmm3, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm3
    vpcmpgtb xmm7, xmm2, xmm4
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm3, xmm3, xmm3
    vpaddb xmm4, xmm4, xmm4
    vpxor xmm3, xmm3, xmm6
    vpxor xmm4, xmm4, xmm7
    vpxor xmm6, xmm3, XMMWORD PTR [asuraRoundConstants + 176]
    vshufi64x2 zmm30, zmm6, zmm6, 0
    vshufi64x2 zmm31, zmm4, zmm4, 0
    vpxorq zmm30, zmm30, zmm5
    vpxorq zmm31, zmm31, zmm5
    vaesdeclast zmm31, zmm31, zmm2
    vaesenc zmm31, zmm31, zmm2
    vaesenc zmm5, zmm5, zmm2
    vpblendw xmm6, xmm3, xmm4, 204
    vpblendw xmm4, xmm4, xmm3, 204
    vpshufb xmm3, xmm6, XMMWORD PTR [asuraConsts]
    vpshufb xmm4, xmm4, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm6, xmm2, xmm3
    vpcmpgtb xmm7, xmm2, xmm4
    vpand xmm6, xmm6, XMMWORD PTR [asuraGFConsts]
    vpand xmm7, xmm7, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm3, xmm3, xmm3
    vpaddb xmm4, xmm4, xmm4
    vpxor xmm3, xmm3, xmm6
    vpxor xmm4, xmm4, xmm7
    vpxor xmm3, xmm3, XMMWORD PTR [asuraRoundConstants + 192]
    vshufi64x2 zmm3, zmm3, zmm3, 0
    vshufi64x2 zmm4, zmm4, zmm4, 0
    vpxorq zmm3, zmm3, zmm5
    vpxorq zmm4, zmm4, zmm5
    vpxorq zmm0, zmm0, zmm3
    vpxorq zmm1, zmm1, zmm4
    vaesenclast zmm0, zmm0, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm30
    vaesenc zmm1, zmm1, zmm31
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm28
    vaesenclast zmm1, zmm1, zmm29
    vpunpcklbw zmm6, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm6, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm26
    vaesenc zmm1, zmm1, zmm27
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm24
    vaesenclast zmm1, zmm1, zmm25
    vpunpcklbw zmm6, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm6, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm22
    vaesenc zmm1, zmm1, zmm23
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm20
    vaesenclast zmm1, zmm1, zmm21
    vpunpcklbw zmm6, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm6, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm18
    vaesenc zmm1, zmm1, zmm19
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm16
    vaesenclast zmm1, zmm1, zmm17
    vpunpcklbw zmm6, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm6, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm14
    vaesenc zmm1, zmm1, zmm15
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm12
    vaesenclast zmm1, zmm1, zmm13
    vpunpcklbw zmm6, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm6, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm10
    vaesenc zmm1, zmm1, zmm11
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm8
    vaesenclast zmm1, zmm1, zmm9
    vshufi64x2 zmm6, zmm0, zmm1, 68
    vshufi64x2 zmm6, zmm6, zmm6, 216
    vshufi64x2 zmm7, zmm0, zmm1, 238
    vshufi64x2 zmm7, zmm7, zmm7, 216
    vmovdqu64 ZMMWORD PTR [rdi], zmm6
    vmovdqu64 ZMMWORD PTR [rdi + 64], zmm7
    vpxorq zmm0, zmm0, zmm0
    vpxorq zmm1, zmm1, zmm1
    vpxorq zmm2, zmm2, zmm2
    vpxorq zmm3, zmm3, zmm3
    vpxorq zmm4, zmm4, zmm4
    vpxorq zmm5, zmm5, zmm5
    vpxorq zmm6, zmm6, zmm6
    vpxorq zmm7, zmm7, zmm7
    vpxorq zmm8, zmm8, zmm8
    vpxorq zmm9, zmm9, zmm9
    vpxorq zmm10, zmm10, zmm10
    vpxorq zmm11, zmm11, zmm11
    vpxorq zmm12, zmm12, zmm12
    vpxorq zmm13, zmm13, zmm13
    vpxorq zmm14, zmm14, zmm14
    vpxorq zmm15, zmm15, zmm15
    vpxorq zmm16, zmm16, zmm16
    vpxorq zmm17, zmm17, zmm17
    vpxorq zmm18, zmm18, zmm18
    vpxorq zmm19, zmm19, zmm19
    vpxorq zmm20, zmm20, zmm20
    vpxorq zmm21, zmm21, zmm21
    vpxorq zmm22, zmm22, zmm22
    vpxorq zmm23, zmm23, zmm23
    vpxorq zmm24, zmm24, zmm24
    vpxorq zmm25, zmm25, zmm25
    vpxorq zmm26, zmm26, zmm26
    vpxorq zmm27, zmm27, zmm27
    vpxorq zmm28, zmm28, zmm28
    vpxorq zmm29, zmm29, zmm29
    vpxorq zmm30, zmm30, zmm30
    vpxorq zmm31, zmm31, zmm31
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    xor rcx, rcx
    xor rdx, rdx
    vzeroupper
    ret
areion_asura_decrypt_4blocks_otf_vaes512_asm ENDP

PUBLIC areion_asura_expand_key_aesni_asm
ALIGN 16
areion_asura_expand_key_aesni_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    mov rdi, rcx
    mov rsi, rdx
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    pxor xmm2, xmm2
    movdqa xmm3, xmm0
    pxor xmm3, XMMWORD PTR [asuraRoundConstants]
    movdqu XMMWORD PTR [rdi], xmm3
    movdqu XMMWORD PTR [rdi + 16], xmm1
    movdqa xmm3, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm3, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm3, xmm2
    movdqa xmm4, xmm2
    pcmpgtb xmm3, xmm0
    pcmpgtb xmm4, xmm1
    pand xmm3, XMMWORD PTR [asuraGFConsts]
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm3
    pxor xmm1, xmm4
    movdqa xmm3, xmm0
    pxor xmm3, XMMWORD PTR [asuraRoundConstants + 16]
    movdqu XMMWORD PTR [rdi + 32], xmm3
    movdqu XMMWORD PTR [rdi + 48], xmm1
    movdqa xmm3, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm3, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm3, xmm2
    movdqa xmm4, xmm2
    pcmpgtb xmm3, xmm0
    pcmpgtb xmm4, xmm1
    pand xmm3, XMMWORD PTR [asuraGFConsts]
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm3
    pxor xmm1, xmm4
    movdqa xmm3, xmm0
    pxor xmm3, XMMWORD PTR [asuraRoundConstants + 32]
    movdqu XMMWORD PTR [rdi + 64], xmm3
    movdqu XMMWORD PTR [rdi + 80], xmm1
    movdqa xmm3, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm3, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm3, xmm2
    movdqa xmm4, xmm2
    pcmpgtb xmm3, xmm0
    pcmpgtb xmm4, xmm1
    pand xmm3, XMMWORD PTR [asuraGFConsts]
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm3
    pxor xmm1, xmm4
    movdqa xmm3, xmm0
    pxor xmm3, XMMWORD PTR [asuraRoundConstants + 48]
    movdqu XMMWORD PTR [rdi + 96], xmm3
    movdqu XMMWORD PTR [rdi + 112], xmm1
    movdqa xmm3, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm3, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm3, xmm2
    movdqa xmm4, xmm2
    pcmpgtb xmm3, xmm0
    pcmpgtb xmm4, xmm1
    pand xmm3, XMMWORD PTR [asuraGFConsts]
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm3
    pxor xmm1, xmm4
    movdqa xmm3, xmm0
    pxor xmm3, XMMWORD PTR [asuraRoundConstants + 64]
    movdqu XMMWORD PTR [rdi + 128], xmm3
    movdqu XMMWORD PTR [rdi + 144], xmm1
    movdqa xmm3, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm3, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm3, xmm2
    movdqa xmm4, xmm2
    pcmpgtb xmm3, xmm0
    pcmpgtb xmm4, xmm1
    pand xmm3, XMMWORD PTR [asuraGFConsts]
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm3
    pxor xmm1, xmm4
    movdqa xmm3, xmm0
    pxor xmm3, XMMWORD PTR [asuraRoundConstants + 80]
    movdqu XMMWORD PTR [rdi + 160], xmm3
    movdqu XMMWORD PTR [rdi + 176], xmm1
    movdqa xmm3, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm3, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm3, xmm2
    movdqa xmm4, xmm2
    pcmpgtb xmm3, xmm0
    pcmpgtb xmm4, xmm1
    pand xmm3, XMMWORD PTR [asuraGFConsts]
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm3
    pxor xmm1, xmm4
    movdqa xmm3, xmm0
    pxor xmm3, XMMWORD PTR [asuraRoundConstants + 96]
    movdqu XMMWORD PTR [rdi + 192], xmm3
    movdqu XMMWORD PTR [rdi + 208], xmm1
    movdqa xmm3, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm3, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm3, xmm2
    movdqa xmm4, xmm2
    pcmpgtb xmm3, xmm0
    pcmpgtb xmm4, xmm1
    pand xmm3, XMMWORD PTR [asuraGFConsts]
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm3
    pxor xmm1, xmm4
    movdqa xmm3, xmm0
    pxor xmm3, XMMWORD PTR [asuraRoundConstants + 112]
    movdqu XMMWORD PTR [rdi + 224], xmm3
    movdqu XMMWORD PTR [rdi + 240], xmm1
    movdqa xmm3, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm3, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm3, xmm2
    movdqa xmm4, xmm2
    pcmpgtb xmm3, xmm0
    pcmpgtb xmm4, xmm1
    pand xmm3, XMMWORD PTR [asuraGFConsts]
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm3
    pxor xmm1, xmm4
    movdqa xmm3, xmm0
    pxor xmm3, XMMWORD PTR [asuraRoundConstants + 128]
    movdqu XMMWORD PTR [rdi + 256], xmm3
    movdqu XMMWORD PTR [rdi + 272], xmm1
    movdqa xmm3, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm3, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm3, xmm2
    movdqa xmm4, xmm2
    pcmpgtb xmm3, xmm0
    pcmpgtb xmm4, xmm1
    pand xmm3, XMMWORD PTR [asuraGFConsts]
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm3
    pxor xmm1, xmm4
    movdqa xmm3, xmm0
    pxor xmm3, XMMWORD PTR [asuraRoundConstants + 144]
    movdqu XMMWORD PTR [rdi + 288], xmm3
    movdqu XMMWORD PTR [rdi + 304], xmm1
    movdqa xmm3, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm3, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm3, xmm2
    movdqa xmm4, xmm2
    pcmpgtb xmm3, xmm0
    pcmpgtb xmm4, xmm1
    pand xmm3, XMMWORD PTR [asuraGFConsts]
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm3
    pxor xmm1, xmm4
    movdqa xmm3, xmm0
    pxor xmm3, XMMWORD PTR [asuraRoundConstants + 160]
    movdqu XMMWORD PTR [rdi + 320], xmm3
    movdqu XMMWORD PTR [rdi + 336], xmm1
    movdqa xmm3, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm3, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm3, xmm2
    movdqa xmm4, xmm2
    pcmpgtb xmm3, xmm0
    pcmpgtb xmm4, xmm1
    pand xmm3, XMMWORD PTR [asuraGFConsts]
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm3
    pxor xmm1, xmm4
    movdqa xmm3, xmm0
    pxor xmm3, XMMWORD PTR [asuraRoundConstants + 176]
    movdqu XMMWORD PTR [rdi + 352], xmm3
    movdqu XMMWORD PTR [rdi + 368], xmm1
    movdqa xmm3, xmm0
    pblendw xmm0, xmm1, 204
    pblendw xmm1, xmm3, 204
    pshufb xmm0, XMMWORD PTR [asuraConsts]
    pshufb xmm1, XMMWORD PTR [asuraConsts]
    movdqa xmm3, xmm2
    movdqa xmm4, xmm2
    pcmpgtb xmm3, xmm0
    pcmpgtb xmm4, xmm1
    pand xmm3, XMMWORD PTR [asuraGFConsts]
    pand xmm4, XMMWORD PTR [asuraGFConsts]
    paddb xmm0, xmm0
    paddb xmm1, xmm1
    pxor xmm0, xmm3
    pxor xmm1, xmm4
    movdqa xmm3, xmm0
    pxor xmm3, XMMWORD PTR [asuraRoundConstants + 192]
    movdqu XMMWORD PTR [rdi + 384], xmm3
    movdqu XMMWORD PTR [rdi + 400], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    xor rcx, rcx
    xor rdx, rdx
    ret
areion_asura_expand_key_aesni_asm ENDP

PUBLIC areion_asura_expand_key_vex_asm
ALIGN 16
areion_asura_expand_key_vex_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    mov rdi, rcx
    mov rsi, rdx
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm0, XMMWORD PTR [asuraRoundConstants]
    vmovdqu XMMWORD PTR [rdi], xmm3
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vpblendw xmm3, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm3, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm3, xmm2, xmm0
    vpcmpgtb xmm4, xmm2, xmm1
    vpand xmm3, xmm3, XMMWORD PTR [asuraGFConsts]
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm3
    vpxor xmm1, xmm1, xmm4
    vpxor xmm3, xmm0, XMMWORD PTR [asuraRoundConstants + 16]
    vmovdqu XMMWORD PTR [rdi + 32], xmm3
    vmovdqu XMMWORD PTR [rdi + 48], xmm1
    vpblendw xmm3, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm3, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm3, xmm2, xmm0
    vpcmpgtb xmm4, xmm2, xmm1
    vpand xmm3, xmm3, XMMWORD PTR [asuraGFConsts]
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm3
    vpxor xmm1, xmm1, xmm4
    vpxor xmm3, xmm0, XMMWORD PTR [asuraRoundConstants + 32]
    vmovdqu XMMWORD PTR [rdi + 64], xmm3
    vmovdqu XMMWORD PTR [rdi + 80], xmm1
    vpblendw xmm3, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm3, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm3, xmm2, xmm0
    vpcmpgtb xmm4, xmm2, xmm1
    vpand xmm3, xmm3, XMMWORD PTR [asuraGFConsts]
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm3
    vpxor xmm1, xmm1, xmm4
    vpxor xmm3, xmm0, XMMWORD PTR [asuraRoundConstants + 48]
    vmovdqu XMMWORD PTR [rdi + 96], xmm3
    vmovdqu XMMWORD PTR [rdi + 112], xmm1
    vpblendw xmm3, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm3, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm3, xmm2, xmm0
    vpcmpgtb xmm4, xmm2, xmm1
    vpand xmm3, xmm3, XMMWORD PTR [asuraGFConsts]
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm3
    vpxor xmm1, xmm1, xmm4
    vpxor xmm3, xmm0, XMMWORD PTR [asuraRoundConstants + 64]
    vmovdqu XMMWORD PTR [rdi + 128], xmm3
    vmovdqu XMMWORD PTR [rdi + 144], xmm1
    vpblendw xmm3, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm3, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm3, xmm2, xmm0
    vpcmpgtb xmm4, xmm2, xmm1
    vpand xmm3, xmm3, XMMWORD PTR [asuraGFConsts]
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm3
    vpxor xmm1, xmm1, xmm4
    vpxor xmm3, xmm0, XMMWORD PTR [asuraRoundConstants + 80]
    vmovdqu XMMWORD PTR [rdi + 160], xmm3
    vmovdqu XMMWORD PTR [rdi + 176], xmm1
    vpblendw xmm3, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm3, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm3, xmm2, xmm0
    vpcmpgtb xmm4, xmm2, xmm1
    vpand xmm3, xmm3, XMMWORD PTR [asuraGFConsts]
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm3
    vpxor xmm1, xmm1, xmm4
    vpxor xmm3, xmm0, XMMWORD PTR [asuraRoundConstants + 96]
    vmovdqu XMMWORD PTR [rdi + 192], xmm3
    vmovdqu XMMWORD PTR [rdi + 208], xmm1
    vpblendw xmm3, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm3, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm3, xmm2, xmm0
    vpcmpgtb xmm4, xmm2, xmm1
    vpand xmm3, xmm3, XMMWORD PTR [asuraGFConsts]
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm3
    vpxor xmm1, xmm1, xmm4
    vpxor xmm3, xmm0, XMMWORD PTR [asuraRoundConstants + 112]
    vmovdqu XMMWORD PTR [rdi + 224], xmm3
    vmovdqu XMMWORD PTR [rdi + 240], xmm1
    vpblendw xmm3, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm3, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm3, xmm2, xmm0
    vpcmpgtb xmm4, xmm2, xmm1
    vpand xmm3, xmm3, XMMWORD PTR [asuraGFConsts]
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm3
    vpxor xmm1, xmm1, xmm4
    vpxor xmm3, xmm0, XMMWORD PTR [asuraRoundConstants + 128]
    vmovdqu XMMWORD PTR [rdi + 256], xmm3
    vmovdqu XMMWORD PTR [rdi + 272], xmm1
    vpblendw xmm3, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm3, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm3, xmm2, xmm0
    vpcmpgtb xmm4, xmm2, xmm1
    vpand xmm3, xmm3, XMMWORD PTR [asuraGFConsts]
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm3
    vpxor xmm1, xmm1, xmm4
    vpxor xmm3, xmm0, XMMWORD PTR [asuraRoundConstants + 144]
    vmovdqu XMMWORD PTR [rdi + 288], xmm3
    vmovdqu XMMWORD PTR [rdi + 304], xmm1
    vpblendw xmm3, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm3, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm3, xmm2, xmm0
    vpcmpgtb xmm4, xmm2, xmm1
    vpand xmm3, xmm3, XMMWORD PTR [asuraGFConsts]
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm3
    vpxor xmm1, xmm1, xmm4
    vpxor xmm3, xmm0, XMMWORD PTR [asuraRoundConstants + 160]
    vmovdqu XMMWORD PTR [rdi + 320], xmm3
    vmovdqu XMMWORD PTR [rdi + 336], xmm1
    vpblendw xmm3, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm3, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm3, xmm2, xmm0
    vpcmpgtb xmm4, xmm2, xmm1
    vpand xmm3, xmm3, XMMWORD PTR [asuraGFConsts]
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm3
    vpxor xmm1, xmm1, xmm4
    vpxor xmm3, xmm0, XMMWORD PTR [asuraRoundConstants + 176]
    vmovdqu XMMWORD PTR [rdi + 352], xmm3
    vmovdqu XMMWORD PTR [rdi + 368], xmm1
    vpblendw xmm3, xmm0, xmm1, 204
    vpblendw xmm1, xmm1, xmm0, 204
    vpshufb xmm0, xmm3, XMMWORD PTR [asuraConsts]
    vpshufb xmm1, xmm1, XMMWORD PTR [asuraConsts]
    vpcmpgtb xmm3, xmm2, xmm0
    vpcmpgtb xmm4, xmm2, xmm1
    vpand xmm3, xmm3, XMMWORD PTR [asuraGFConsts]
    vpand xmm4, xmm4, XMMWORD PTR [asuraGFConsts]
    vpaddb xmm0, xmm0, xmm0
    vpaddb xmm1, xmm1, xmm1
    vpxor xmm0, xmm0, xmm3
    vpxor xmm1, xmm1, xmm4
    vpxor xmm3, xmm0, XMMWORD PTR [asuraRoundConstants + 192]
    vmovdqu XMMWORD PTR [rdi + 384], xmm3
    vmovdqu XMMWORD PTR [rdi + 400], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    xor rcx, rcx
    xor rdx, rdx
    ret
areion_asura_expand_key_vex_asm ENDP

PUBLIC areion_asura_encrypt_block_rk_aesni_asm
ALIGN 16
areion_asura_encrypt_block_rk_aesni_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 40
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    movdqu xmm0, XMMWORD PTR [rsi]
    movdqu xmm1, XMMWORD PTR [rsi + 16]
    pxor xmm2, xmm2
    movdqa xmm3, XMMWORD PTR [asuraConsts + 64]
    movdqu xmm6, XMMWORD PTR [rcx]
    movdqu xmm4, XMMWORD PTR [rdx]
    movdqu xmm5, XMMWORD PTR [rdx + 16]
    pxor xmm4, xmm6
    pxor xmm5, xmm6
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    aesenc xmm6, xmm2
    movdqu xmm4, XMMWORD PTR [rdx + 32]
    movdqu xmm5, XMMWORD PTR [rdx + 48]
    pxor xmm4, xmm6
    pxor xmm5, xmm6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesenc xmm6, xmm2
    aesenc xmm0, xmm2
    aesdec xmm1, xmm2
    pshufb xmm0, xmm3
    pshufb xmm1, xmm3
    movdqa xmm4, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm4, xmm1
    movdqa xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 64]
    movdqu xmm5, XMMWORD PTR [rdx + 80]
    pxor xmm4, xmm6
    pxor xmm5, xmm6
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    aesenc xmm6, xmm2
    movdqu xmm4, XMMWORD PTR [rdx + 96]
    movdqu xmm5, XMMWORD PTR [rdx + 112]
    pxor xmm4, xmm6
    pxor xmm5, xmm6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesenc xmm6, xmm2
    aesenc xmm0, xmm2
    aesdec xmm1, xmm2
    pshufb xmm0, xmm3
    pshufb xmm1, xmm3
    movdqa xmm4, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm4, xmm1
    movdqa xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 128]
    movdqu xmm5, XMMWORD PTR [rdx + 144]
    pxor xmm4, xmm6
    pxor xmm5, xmm6
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    aesenc xmm6, xmm2
    movdqu xmm4, XMMWORD PTR [rdx + 160]
    movdqu xmm5, XMMWORD PTR [rdx + 176]
    pxor xmm4, xmm6
    pxor xmm5, xmm6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesenc xmm6, xmm2
    aesenc xmm0, xmm2
    aesdec xmm1, xmm2
    pshufb xmm0, xmm3
    pshufb xmm1, xmm3
    movdqa xmm4, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm4, xmm1
    movdqa xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 192]
    movdqu xmm5, XMMWORD PTR [rdx + 208]
    pxor xmm4, xmm6
    pxor xmm5, xmm6
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    aesenc xmm6, xmm2
    movdqu xmm4, XMMWORD PTR [rdx + 224]
    movdqu xmm5, XMMWORD PTR [rdx + 240]
    pxor xmm4, xmm6
    pxor xmm5, xmm6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesenc xmm6, xmm2
    aesenc xmm0, xmm2
    aesdec xmm1, xmm2
    pshufb xmm0, xmm3
    pshufb xmm1, xmm3
    movdqa xmm4, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm4, xmm1
    movdqa xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 256]
    movdqu xmm5, XMMWORD PTR [rdx + 272]
    pxor xmm4, xmm6
    pxor xmm5, xmm6
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    aesenc xmm6, xmm2
    movdqu xmm4, XMMWORD PTR [rdx + 288]
    movdqu xmm5, XMMWORD PTR [rdx + 304]
    pxor xmm4, xmm6
    pxor xmm5, xmm6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesenc xmm6, xmm2
    aesenc xmm0, xmm2
    aesdec xmm1, xmm2
    pshufb xmm0, xmm3
    pshufb xmm1, xmm3
    movdqa xmm4, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm4, xmm1
    movdqa xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 320]
    movdqu xmm5, XMMWORD PTR [rdx + 336]
    pxor xmm4, xmm6
    pxor xmm5, xmm6
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    aesenc xmm6, xmm2
    movdqu xmm4, XMMWORD PTR [rdx + 352]
    movdqu xmm5, XMMWORD PTR [rdx + 368]
    pxor xmm4, xmm6
    pxor xmm5, xmm6
    aesdec xmm0, xmm4
    aesdec xmm1, xmm5
    aesenc xmm6, xmm2
    movdqu xmm4, XMMWORD PTR [rdx + 384]
    movdqu xmm5, XMMWORD PTR [rdx + 400]
    pxor xmm4, xmm6
    pxor xmm5, xmm6
    aesenc xmm0, xmm4
    aesdec xmm1, xmm5
    movdqu XMMWORD PTR [rdi], xmm0
    movdqu XMMWORD PTR [rdi + 16], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    movdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 40
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    ret
areion_asura_encrypt_block_rk_aesni_asm ENDP

PUBLIC areion_asura_encrypt_block_rk_vex_asm
ALIGN 16
areion_asura_encrypt_block_rk_vex_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 40
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rsi]
    vmovdqu xmm1, XMMWORD PTR [rsi + 16]
    vpxor xmm2, xmm2, xmm2
    vmovdqa xmm3, XMMWORD PTR [asuraConsts + 64]
    vmovdqu xmm6, XMMWORD PTR [rcx]
    vmovdqu xmm4, XMMWORD PTR [rdx]
    vmovdqu xmm5, XMMWORD PTR [rdx + 16]
    vpxor xmm4, xmm4, xmm6
    vpxor xmm5, xmm5, xmm6
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vaesenc xmm6, xmm6, xmm2
    vmovdqu xmm4, XMMWORD PTR [rdx + 32]
    vmovdqu xmm5, XMMWORD PTR [rdx + 48]
    vpxor xmm4, xmm4, xmm6
    vpxor xmm5, xmm5, xmm6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesenc xmm6, xmm6, xmm2
    vaesenc xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm2
    vpshufb xmm4, xmm0, xmm3
    vpshufb xmm5, xmm1, xmm3
    vpunpcklqdq xmm0, xmm4, xmm5
    vpunpckhqdq xmm1, xmm4, xmm5
    vmovdqu xmm4, XMMWORD PTR [rdx + 64]
    vmovdqu xmm5, XMMWORD PTR [rdx + 80]
    vpxor xmm4, xmm4, xmm6
    vpxor xmm5, xmm5, xmm6
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vaesenc xmm6, xmm6, xmm2
    vmovdqu xmm4, XMMWORD PTR [rdx + 96]
    vmovdqu xmm5, XMMWORD PTR [rdx + 112]
    vpxor xmm4, xmm4, xmm6
    vpxor xmm5, xmm5, xmm6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesenc xmm6, xmm6, xmm2
    vaesenc xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm2
    vpshufb xmm4, xmm0, xmm3
    vpshufb xmm5, xmm1, xmm3
    vpunpcklqdq xmm0, xmm4, xmm5
    vpunpckhqdq xmm1, xmm4, xmm5
    vmovdqu xmm4, XMMWORD PTR [rdx + 128]
    vmovdqu xmm5, XMMWORD PTR [rdx + 144]
    vpxor xmm4, xmm4, xmm6
    vpxor xmm5, xmm5, xmm6
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vaesenc xmm6, xmm6, xmm2
    vmovdqu xmm4, XMMWORD PTR [rdx + 160]
    vmovdqu xmm5, XMMWORD PTR [rdx + 176]
    vpxor xmm4, xmm4, xmm6
    vpxor xmm5, xmm5, xmm6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesenc xmm6, xmm6, xmm2
    vaesenc xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm2
    vpshufb xmm4, xmm0, xmm3
    vpshufb xmm5, xmm1, xmm3
    vpunpcklqdq xmm0, xmm4, xmm5
    vpunpckhqdq xmm1, xmm4, xmm5
    vmovdqu xmm4, XMMWORD PTR [rdx + 192]
    vmovdqu xmm5, XMMWORD PTR [rdx + 208]
    vpxor xmm4, xmm4, xmm6
    vpxor xmm5, xmm5, xmm6
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vaesenc xmm6, xmm6, xmm2
    vmovdqu xmm4, XMMWORD PTR [rdx + 224]
    vmovdqu xmm5, XMMWORD PTR [rdx + 240]
    vpxor xmm4, xmm4, xmm6
    vpxor xmm5, xmm5, xmm6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesenc xmm6, xmm6, xmm2
    vaesenc xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm2
    vpshufb xmm4, xmm0, xmm3
    vpshufb xmm5, xmm1, xmm3
    vpunpcklqdq xmm0, xmm4, xmm5
    vpunpckhqdq xmm1, xmm4, xmm5
    vmovdqu xmm4, XMMWORD PTR [rdx + 256]
    vmovdqu xmm5, XMMWORD PTR [rdx + 272]
    vpxor xmm4, xmm4, xmm6
    vpxor xmm5, xmm5, xmm6
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vaesenc xmm6, xmm6, xmm2
    vmovdqu xmm4, XMMWORD PTR [rdx + 288]
    vmovdqu xmm5, XMMWORD PTR [rdx + 304]
    vpxor xmm4, xmm4, xmm6
    vpxor xmm5, xmm5, xmm6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesenc xmm6, xmm6, xmm2
    vaesenc xmm0, xmm0, xmm2
    vaesdec xmm1, xmm1, xmm2
    vpshufb xmm4, xmm0, xmm3
    vpshufb xmm5, xmm1, xmm3
    vpunpcklqdq xmm0, xmm4, xmm5
    vpunpckhqdq xmm1, xmm4, xmm5
    vmovdqu xmm4, XMMWORD PTR [rdx + 320]
    vmovdqu xmm5, XMMWORD PTR [rdx + 336]
    vpxor xmm4, xmm4, xmm6
    vpxor xmm5, xmm5, xmm6
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vaesenc xmm6, xmm6, xmm2
    vmovdqu xmm4, XMMWORD PTR [rdx + 352]
    vmovdqu xmm5, XMMWORD PTR [rdx + 368]
    vpxor xmm4, xmm4, xmm6
    vpxor xmm5, xmm5, xmm6
    vaesdec xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vaesenc xmm6, xmm6, xmm2
    vmovdqu xmm4, XMMWORD PTR [rdx + 384]
    vmovdqu xmm5, XMMWORD PTR [rdx + 400]
    vpxor xmm4, xmm4, xmm6
    vpxor xmm5, xmm5, xmm6
    vaesenc xmm0, xmm0, xmm4
    vaesdec xmm1, xmm1, xmm5
    vmovdqu XMMWORD PTR [rdi], xmm0
    vmovdqu XMMWORD PTR [rdi + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 40
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    ret
areion_asura_encrypt_block_rk_vex_asm ENDP

PUBLIC areion_asura_decrypt_block_rk_aesni_asm
ALIGN 16
areion_asura_decrypt_block_rk_aesni_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    pxor xmm2, xmm2
    movdqu xmm3, XMMWORD PTR [rcx]
    movdqa xmm6, xmm3
    aesenc xmm6, xmm2
    movdqa xmm7, xmm6
    aesenc xmm7, xmm2
    movdqa xmm8, xmm7
    aesenc xmm8, xmm2
    movdqa xmm9, xmm8
    aesenc xmm9, xmm2
    movdqa xmm10, xmm9
    aesenc xmm10, xmm2
    movdqa xmm11, xmm10
    aesenc xmm11, xmm2
    movdqa xmm12, xmm11
    aesenc xmm12, xmm2
    movdqa xmm13, xmm12
    aesenc xmm13, xmm2
    movdqa xmm14, xmm13
    aesenc xmm14, xmm2
    movdqa xmm15, xmm14
    aesenc xmm15, xmm2
    movdqa xmm5, xmm15
    aesenc xmm5, xmm2
    movdqa xmm4, xmm5
    aesenc xmm4, xmm2
    pxor xmm0, xmm4
    pxor xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 384]
    pxor xmm0, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 400]
    pxor xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 352]
    pxor xmm4, xmm5
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm2
    aesdeclast xmm0, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 368]
    pxor xmm4, xmm5
    aesdeclast xmm4, xmm2
    aesenc xmm1, xmm2
    aesenc xmm4, xmm2
    aesdeclast xmm0, xmm2
    aesenc xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 320]
    movdqu xmm5, XMMWORD PTR [rdx + 336]
    pxor xmm4, xmm15
    pxor xmm5, xmm15
    aesenc xmm0, xmm2
    aesenclast xmm0, xmm4
    aesenclast xmm1, xmm5
    movdqa xmm4, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm4, xmm1
    movdqa xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 288]
    pxor xmm4, xmm14
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm2
    aesdeclast xmm0, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 304]
    pxor xmm4, xmm14
    aesdeclast xmm4, xmm2
    aesenc xmm1, xmm2
    aesenc xmm4, xmm2
    aesdeclast xmm0, xmm2
    aesenc xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 256]
    movdqu xmm5, XMMWORD PTR [rdx + 272]
    pxor xmm4, xmm13
    pxor xmm5, xmm13
    aesenc xmm0, xmm2
    aesenclast xmm0, xmm4
    aesenclast xmm1, xmm5
    movdqa xmm4, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm4, xmm1
    movdqa xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 224]
    pxor xmm4, xmm12
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm2
    aesdeclast xmm0, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 240]
    pxor xmm4, xmm12
    aesdeclast xmm4, xmm2
    aesenc xmm1, xmm2
    aesenc xmm4, xmm2
    aesdeclast xmm0, xmm2
    aesenc xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 192]
    movdqu xmm5, XMMWORD PTR [rdx + 208]
    pxor xmm4, xmm11
    pxor xmm5, xmm11
    aesenc xmm0, xmm2
    aesenclast xmm0, xmm4
    aesenclast xmm1, xmm5
    movdqa xmm4, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm4, xmm1
    movdqa xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 160]
    pxor xmm4, xmm10
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm2
    aesdeclast xmm0, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 176]
    pxor xmm4, xmm10
    aesdeclast xmm4, xmm2
    aesenc xmm1, xmm2
    aesenc xmm4, xmm2
    aesdeclast xmm0, xmm2
    aesenc xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 128]
    movdqu xmm5, XMMWORD PTR [rdx + 144]
    pxor xmm4, xmm9
    pxor xmm5, xmm9
    aesenc xmm0, xmm2
    aesenclast xmm0, xmm4
    aesenclast xmm1, xmm5
    movdqa xmm4, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm4, xmm1
    movdqa xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 96]
    pxor xmm4, xmm8
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm2
    aesdeclast xmm0, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 112]
    pxor xmm4, xmm8
    aesdeclast xmm4, xmm2
    aesenc xmm1, xmm2
    aesenc xmm4, xmm2
    aesdeclast xmm0, xmm2
    aesenc xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 64]
    movdqu xmm5, XMMWORD PTR [rdx + 80]
    pxor xmm4, xmm7
    pxor xmm5, xmm7
    aesenc xmm0, xmm2
    aesenclast xmm0, xmm4
    aesenclast xmm1, xmm5
    movdqa xmm4, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm4, xmm1
    movdqa xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 32]
    pxor xmm4, xmm6
    aesimc xmm0, xmm0
    aesdeclast xmm1, xmm2
    aesdeclast xmm0, xmm4
    movdqu xmm4, XMMWORD PTR [rdx + 48]
    pxor xmm4, xmm6
    aesdeclast xmm4, xmm2
    aesenc xmm1, xmm2
    aesenc xmm4, xmm2
    aesdeclast xmm0, xmm2
    aesenc xmm1, xmm4
    movdqu xmm4, XMMWORD PTR [rdx]
    movdqu xmm5, XMMWORD PTR [rdx + 16]
    pxor xmm4, xmm3
    pxor xmm5, xmm3
    aesenc xmm0, xmm2
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
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm14, xmm14
    pxor xmm15, xmm15
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    ret
areion_asura_decrypt_block_rk_aesni_asm ENDP

PUBLIC areion_asura_decrypt_block_rk_vex_asm
ALIGN 16
areion_asura_decrypt_block_rk_vex_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    vpxor xmm2, xmm2, xmm2
    vmovdqu xmm3, XMMWORD PTR [rcx]
    vaesenc xmm6, xmm3, xmm2
    vaesenc xmm7, xmm6, xmm2
    vaesenc xmm8, xmm7, xmm2
    vaesenc xmm9, xmm8, xmm2
    vaesenc xmm10, xmm9, xmm2
    vaesenc xmm11, xmm10, xmm2
    vaesenc xmm12, xmm11, xmm2
    vaesenc xmm13, xmm12, xmm2
    vaesenc xmm14, xmm13, xmm2
    vaesenc xmm15, xmm14, xmm2
    vaesenc xmm5, xmm15, xmm2
    vaesenc xmm4, xmm5, xmm2
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 384]
    vpxor xmm0, xmm0, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 400]
    vpxor xmm1, xmm1, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 352]
    vpxor xmm4, xmm4, xmm5
    vaesimc xmm0, xmm0
    vaesdeclast xmm1, xmm1, xmm2
    vaesdeclast xmm0, xmm0, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 368]
    vpxor xmm4, xmm4, xmm5
    vaesdeclast xmm4, xmm4, xmm2
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 320]
    vmovdqu xmm5, XMMWORD PTR [rdx + 336]
    vpxor xmm4, xmm4, xmm15
    vpxor xmm5, xmm5, xmm15
    vaesenc xmm0, xmm0, xmm2
    vaesenclast xmm0, xmm0, xmm4
    vaesenclast xmm1, xmm1, xmm5
    vpunpcklbw xmm4, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 288]
    vpxor xmm4, xmm4, xmm14
    vaesimc xmm0, xmm0
    vaesdeclast xmm1, xmm1, xmm2
    vaesdeclast xmm0, xmm0, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 304]
    vpxor xmm4, xmm4, xmm14
    vaesdeclast xmm4, xmm4, xmm2
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 256]
    vmovdqu xmm5, XMMWORD PTR [rdx + 272]
    vpxor xmm4, xmm4, xmm13
    vpxor xmm5, xmm5, xmm13
    vaesenc xmm0, xmm0, xmm2
    vaesenclast xmm0, xmm0, xmm4
    vaesenclast xmm1, xmm1, xmm5
    vpunpcklbw xmm4, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 224]
    vpxor xmm4, xmm4, xmm12
    vaesimc xmm0, xmm0
    vaesdeclast xmm1, xmm1, xmm2
    vaesdeclast xmm0, xmm0, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 240]
    vpxor xmm4, xmm4, xmm12
    vaesdeclast xmm4, xmm4, xmm2
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 192]
    vmovdqu xmm5, XMMWORD PTR [rdx + 208]
    vpxor xmm4, xmm4, xmm11
    vpxor xmm5, xmm5, xmm11
    vaesenc xmm0, xmm0, xmm2
    vaesenclast xmm0, xmm0, xmm4
    vaesenclast xmm1, xmm1, xmm5
    vpunpcklbw xmm4, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 160]
    vpxor xmm4, xmm4, xmm10
    vaesimc xmm0, xmm0
    vaesdeclast xmm1, xmm1, xmm2
    vaesdeclast xmm0, xmm0, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 176]
    vpxor xmm4, xmm4, xmm10
    vaesdeclast xmm4, xmm4, xmm2
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 128]
    vmovdqu xmm5, XMMWORD PTR [rdx + 144]
    vpxor xmm4, xmm4, xmm9
    vpxor xmm5, xmm5, xmm9
    vaesenc xmm0, xmm0, xmm2
    vaesenclast xmm0, xmm0, xmm4
    vaesenclast xmm1, xmm1, xmm5
    vpunpcklbw xmm4, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 96]
    vpxor xmm4, xmm4, xmm8
    vaesimc xmm0, xmm0
    vaesdeclast xmm1, xmm1, xmm2
    vaesdeclast xmm0, xmm0, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 112]
    vpxor xmm4, xmm4, xmm8
    vaesdeclast xmm4, xmm4, xmm2
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 64]
    vmovdqu xmm5, XMMWORD PTR [rdx + 80]
    vpxor xmm4, xmm4, xmm7
    vpxor xmm5, xmm5, xmm7
    vaesenc xmm0, xmm0, xmm2
    vaesenclast xmm0, xmm0, xmm4
    vaesenclast xmm1, xmm1, xmm5
    vpunpcklbw xmm4, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 32]
    vpxor xmm4, xmm4, xmm6
    vaesimc xmm0, xmm0
    vaesdeclast xmm1, xmm1, xmm2
    vaesdeclast xmm0, xmm0, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx + 48]
    vpxor xmm4, xmm4, xmm6
    vaesdeclast xmm4, xmm4, xmm2
    vaesenc xmm1, xmm1, xmm2
    vaesenc xmm4, xmm4, xmm2
    vaesdeclast xmm0, xmm0, xmm2
    vaesenc xmm1, xmm1, xmm4
    vmovdqu xmm4, XMMWORD PTR [rdx]
    vmovdqu xmm5, XMMWORD PTR [rdx + 16]
    vpxor xmm4, xmm4, xmm3
    vpxor xmm5, xmm5, xmm3
    vaesenc xmm0, xmm0, xmm2
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
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    ret
areion_asura_decrypt_block_rk_vex_asm ENDP

PUBLIC areion_asura_encrypt_4blocks_rk_aesni_asm
ALIGN 16
areion_asura_encrypt_4blocks_rk_aesni_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    pxor xmm8, xmm8
    movdqa xmm9, XMMWORD PTR [asuraConsts + 64]
    movdqu xmm10, XMMWORD PTR [rcx]
    movdqu xmm11, XMMWORD PTR [rcx + 16]
    movdqu xmm12, XMMWORD PTR [rcx + 32]
    movdqu xmm13, XMMWORD PTR [rcx + 48]
    movdqu xmm14, XMMWORD PTR [rdx]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm0, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm2, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm4, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm6, xmm15
    movdqu xmm14, XMMWORD PTR [rdx + 16]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm1, xmm15
    aesenc xmm10, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm3, xmm15
    aesenc xmm11, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm5, xmm15
    aesenc xmm12, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm7, xmm15
    aesenc xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 32]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm0, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm2, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm4, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm6, xmm15
    movdqu xmm14, XMMWORD PTR [rdx + 48]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm1, xmm15
    aesenc xmm10, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm3, xmm15
    aesenc xmm11, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm5, xmm15
    aesenc xmm12, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm7, xmm15
    aesenc xmm13, xmm8
    aesenc xmm0, xmm8
    aesdec xmm1, xmm8
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm14, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm14, xmm1
    movdqa xmm1, xmm14
    aesenc xmm2, xmm8
    aesdec xmm3, xmm8
    pshufb xmm2, xmm9
    pshufb xmm3, xmm9
    movdqa xmm14, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm14, xmm3
    movdqa xmm3, xmm14
    aesenc xmm4, xmm8
    aesdec xmm5, xmm8
    pshufb xmm4, xmm9
    pshufb xmm5, xmm9
    movdqa xmm14, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm14, xmm5
    movdqa xmm5, xmm14
    aesenc xmm6, xmm8
    aesdec xmm7, xmm8
    pshufb xmm6, xmm9
    pshufb xmm7, xmm9
    movdqa xmm14, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm14, xmm7
    movdqa xmm7, xmm14
    movdqu xmm14, XMMWORD PTR [rdx + 64]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm0, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm2, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm4, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm6, xmm15
    movdqu xmm14, XMMWORD PTR [rdx + 80]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm1, xmm15
    aesenc xmm10, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm3, xmm15
    aesenc xmm11, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm5, xmm15
    aesenc xmm12, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm7, xmm15
    aesenc xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 96]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm0, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm2, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm4, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm6, xmm15
    movdqu xmm14, XMMWORD PTR [rdx + 112]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm1, xmm15
    aesenc xmm10, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm3, xmm15
    aesenc xmm11, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm5, xmm15
    aesenc xmm12, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm7, xmm15
    aesenc xmm13, xmm8
    aesenc xmm0, xmm8
    aesdec xmm1, xmm8
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm14, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm14, xmm1
    movdqa xmm1, xmm14
    aesenc xmm2, xmm8
    aesdec xmm3, xmm8
    pshufb xmm2, xmm9
    pshufb xmm3, xmm9
    movdqa xmm14, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm14, xmm3
    movdqa xmm3, xmm14
    aesenc xmm4, xmm8
    aesdec xmm5, xmm8
    pshufb xmm4, xmm9
    pshufb xmm5, xmm9
    movdqa xmm14, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm14, xmm5
    movdqa xmm5, xmm14
    aesenc xmm6, xmm8
    aesdec xmm7, xmm8
    pshufb xmm6, xmm9
    pshufb xmm7, xmm9
    movdqa xmm14, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm14, xmm7
    movdqa xmm7, xmm14
    movdqu xmm14, XMMWORD PTR [rdx + 128]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm0, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm2, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm4, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm6, xmm15
    movdqu xmm14, XMMWORD PTR [rdx + 144]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm1, xmm15
    aesenc xmm10, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm3, xmm15
    aesenc xmm11, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm5, xmm15
    aesenc xmm12, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm7, xmm15
    aesenc xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 160]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm0, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm2, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm4, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm6, xmm15
    movdqu xmm14, XMMWORD PTR [rdx + 176]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm1, xmm15
    aesenc xmm10, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm3, xmm15
    aesenc xmm11, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm5, xmm15
    aesenc xmm12, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm7, xmm15
    aesenc xmm13, xmm8
    aesenc xmm0, xmm8
    aesdec xmm1, xmm8
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm14, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm14, xmm1
    movdqa xmm1, xmm14
    aesenc xmm2, xmm8
    aesdec xmm3, xmm8
    pshufb xmm2, xmm9
    pshufb xmm3, xmm9
    movdqa xmm14, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm14, xmm3
    movdqa xmm3, xmm14
    aesenc xmm4, xmm8
    aesdec xmm5, xmm8
    pshufb xmm4, xmm9
    pshufb xmm5, xmm9
    movdqa xmm14, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm14, xmm5
    movdqa xmm5, xmm14
    aesenc xmm6, xmm8
    aesdec xmm7, xmm8
    pshufb xmm6, xmm9
    pshufb xmm7, xmm9
    movdqa xmm14, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm14, xmm7
    movdqa xmm7, xmm14
    movdqu xmm14, XMMWORD PTR [rdx + 192]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm0, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm2, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm4, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm6, xmm15
    movdqu xmm14, XMMWORD PTR [rdx + 208]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm1, xmm15
    aesenc xmm10, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm3, xmm15
    aesenc xmm11, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm5, xmm15
    aesenc xmm12, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm7, xmm15
    aesenc xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 224]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm0, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm2, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm4, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm6, xmm15
    movdqu xmm14, XMMWORD PTR [rdx + 240]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm1, xmm15
    aesenc xmm10, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm3, xmm15
    aesenc xmm11, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm5, xmm15
    aesenc xmm12, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm7, xmm15
    aesenc xmm13, xmm8
    aesenc xmm0, xmm8
    aesdec xmm1, xmm8
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm14, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm14, xmm1
    movdqa xmm1, xmm14
    aesenc xmm2, xmm8
    aesdec xmm3, xmm8
    pshufb xmm2, xmm9
    pshufb xmm3, xmm9
    movdqa xmm14, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm14, xmm3
    movdqa xmm3, xmm14
    aesenc xmm4, xmm8
    aesdec xmm5, xmm8
    pshufb xmm4, xmm9
    pshufb xmm5, xmm9
    movdqa xmm14, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm14, xmm5
    movdqa xmm5, xmm14
    aesenc xmm6, xmm8
    aesdec xmm7, xmm8
    pshufb xmm6, xmm9
    pshufb xmm7, xmm9
    movdqa xmm14, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm14, xmm7
    movdqa xmm7, xmm14
    movdqu xmm14, XMMWORD PTR [rdx + 256]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm0, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm2, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm4, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm6, xmm15
    movdqu xmm14, XMMWORD PTR [rdx + 272]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm1, xmm15
    aesenc xmm10, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm3, xmm15
    aesenc xmm11, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm5, xmm15
    aesenc xmm12, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm7, xmm15
    aesenc xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 288]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm0, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm2, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm4, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm6, xmm15
    movdqu xmm14, XMMWORD PTR [rdx + 304]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm1, xmm15
    aesenc xmm10, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm3, xmm15
    aesenc xmm11, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm5, xmm15
    aesenc xmm12, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm7, xmm15
    aesenc xmm13, xmm8
    aesenc xmm0, xmm8
    aesdec xmm1, xmm8
    pshufb xmm0, xmm9
    pshufb xmm1, xmm9
    movdqa xmm14, xmm0
    punpcklqdq xmm0, xmm1
    punpckhqdq xmm14, xmm1
    movdqa xmm1, xmm14
    aesenc xmm2, xmm8
    aesdec xmm3, xmm8
    pshufb xmm2, xmm9
    pshufb xmm3, xmm9
    movdqa xmm14, xmm2
    punpcklqdq xmm2, xmm3
    punpckhqdq xmm14, xmm3
    movdqa xmm3, xmm14
    aesenc xmm4, xmm8
    aesdec xmm5, xmm8
    pshufb xmm4, xmm9
    pshufb xmm5, xmm9
    movdqa xmm14, xmm4
    punpcklqdq xmm4, xmm5
    punpckhqdq xmm14, xmm5
    movdqa xmm5, xmm14
    aesenc xmm6, xmm8
    aesdec xmm7, xmm8
    pshufb xmm6, xmm9
    pshufb xmm7, xmm9
    movdqa xmm14, xmm6
    punpcklqdq xmm6, xmm7
    punpckhqdq xmm14, xmm7
    movdqa xmm7, xmm14
    movdqu xmm14, XMMWORD PTR [rdx + 320]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm0, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm2, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm4, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm6, xmm15
    movdqu xmm14, XMMWORD PTR [rdx + 336]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    pxor xmm1, xmm15
    aesenc xmm10, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    pxor xmm3, xmm15
    aesenc xmm11, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    pxor xmm5, xmm15
    aesenc xmm12, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    pxor xmm7, xmm15
    aesenc xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 352]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm0, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm2, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm4, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm6, xmm15
    movdqu xmm14, XMMWORD PTR [rdx + 368]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm1, xmm15
    aesenc xmm10, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm3, xmm15
    aesenc xmm11, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm5, xmm15
    aesenc xmm12, xmm8
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm7, xmm15
    aesenc xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 384]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesenc xmm0, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesenc xmm2, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesenc xmm4, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesenc xmm6, xmm15
    movdqu xmm14, XMMWORD PTR [rdx + 400]
    movdqa xmm15, xmm14
    pxor xmm15, xmm10
    aesdec xmm1, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm11
    aesdec xmm3, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm12
    aesdec xmm5, xmm15
    movdqa xmm15, xmm14
    pxor xmm15, xmm13
    aesdec xmm7, xmm15
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    ret
areion_asura_encrypt_4blocks_rk_aesni_asm ENDP

PUBLIC areion_asura_encrypt_4blocks_rk_vex_asm
ALIGN 16
areion_asura_encrypt_4blocks_rk_vex_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    vpxor xmm8, xmm8, xmm8
    vmovdqa xmm9, XMMWORD PTR [asuraConsts + 64]
    vmovdqu xmm10, XMMWORD PTR [rcx]
    vmovdqu xmm11, XMMWORD PTR [rcx + 16]
    vmovdqu xmm12, XMMWORD PTR [rcx + 32]
    vmovdqu xmm13, XMMWORD PTR [rcx + 48]
    vmovdqu xmm14, XMMWORD PTR [rdx]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm0, xmm0, xmm15
    vpxor xmm15, xmm14, xmm11
    vpxor xmm2, xmm2, xmm15
    vpxor xmm15, xmm14, xmm12
    vpxor xmm4, xmm4, xmm15
    vpxor xmm15, xmm14, xmm13
    vpxor xmm6, xmm6, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 16]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm1, xmm1, xmm15
    vaesenc xmm10, xmm10, xmm8
    vpxor xmm15, xmm14, xmm11
    vpxor xmm3, xmm3, xmm15
    vaesenc xmm11, xmm11, xmm8
    vpxor xmm15, xmm14, xmm12
    vpxor xmm5, xmm5, xmm15
    vaesenc xmm12, xmm12, xmm8
    vpxor xmm15, xmm14, xmm13
    vpxor xmm7, xmm7, xmm15
    vaesenc xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 32]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm0, xmm0, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm2, xmm2, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm4, xmm4, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm6, xmm6, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 48]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm1, xmm1, xmm15
    vaesenc xmm10, xmm10, xmm8
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm3, xmm3, xmm15
    vaesenc xmm11, xmm11, xmm8
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm5, xmm5, xmm15
    vaesenc xmm12, xmm12, xmm8
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm7, xmm7, xmm15
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm8
    vpshufb xmm14, xmm0, xmm9
    vpshufb xmm15, xmm1, xmm9
    vpunpcklqdq xmm0, xmm14, xmm15
    vpunpckhqdq xmm1, xmm14, xmm15
    vaesenc xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm8
    vpshufb xmm14, xmm2, xmm9
    vpshufb xmm15, xmm3, xmm9
    vpunpcklqdq xmm2, xmm14, xmm15
    vpunpckhqdq xmm3, xmm14, xmm15
    vaesenc xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm8
    vpshufb xmm14, xmm4, xmm9
    vpshufb xmm15, xmm5, xmm9
    vpunpcklqdq xmm4, xmm14, xmm15
    vpunpckhqdq xmm5, xmm14, xmm15
    vaesenc xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm8
    vpshufb xmm14, xmm6, xmm9
    vpshufb xmm15, xmm7, xmm9
    vpunpcklqdq xmm6, xmm14, xmm15
    vpunpckhqdq xmm7, xmm14, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 64]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm0, xmm0, xmm15
    vpxor xmm15, xmm14, xmm11
    vpxor xmm2, xmm2, xmm15
    vpxor xmm15, xmm14, xmm12
    vpxor xmm4, xmm4, xmm15
    vpxor xmm15, xmm14, xmm13
    vpxor xmm6, xmm6, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 80]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm1, xmm1, xmm15
    vaesenc xmm10, xmm10, xmm8
    vpxor xmm15, xmm14, xmm11
    vpxor xmm3, xmm3, xmm15
    vaesenc xmm11, xmm11, xmm8
    vpxor xmm15, xmm14, xmm12
    vpxor xmm5, xmm5, xmm15
    vaesenc xmm12, xmm12, xmm8
    vpxor xmm15, xmm14, xmm13
    vpxor xmm7, xmm7, xmm15
    vaesenc xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 96]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm0, xmm0, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm2, xmm2, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm4, xmm4, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm6, xmm6, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 112]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm1, xmm1, xmm15
    vaesenc xmm10, xmm10, xmm8
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm3, xmm3, xmm15
    vaesenc xmm11, xmm11, xmm8
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm5, xmm5, xmm15
    vaesenc xmm12, xmm12, xmm8
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm7, xmm7, xmm15
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm8
    vpshufb xmm14, xmm0, xmm9
    vpshufb xmm15, xmm1, xmm9
    vpunpcklqdq xmm0, xmm14, xmm15
    vpunpckhqdq xmm1, xmm14, xmm15
    vaesenc xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm8
    vpshufb xmm14, xmm2, xmm9
    vpshufb xmm15, xmm3, xmm9
    vpunpcklqdq xmm2, xmm14, xmm15
    vpunpckhqdq xmm3, xmm14, xmm15
    vaesenc xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm8
    vpshufb xmm14, xmm4, xmm9
    vpshufb xmm15, xmm5, xmm9
    vpunpcklqdq xmm4, xmm14, xmm15
    vpunpckhqdq xmm5, xmm14, xmm15
    vaesenc xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm8
    vpshufb xmm14, xmm6, xmm9
    vpshufb xmm15, xmm7, xmm9
    vpunpcklqdq xmm6, xmm14, xmm15
    vpunpckhqdq xmm7, xmm14, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 128]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm0, xmm0, xmm15
    vpxor xmm15, xmm14, xmm11
    vpxor xmm2, xmm2, xmm15
    vpxor xmm15, xmm14, xmm12
    vpxor xmm4, xmm4, xmm15
    vpxor xmm15, xmm14, xmm13
    vpxor xmm6, xmm6, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 144]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm1, xmm1, xmm15
    vaesenc xmm10, xmm10, xmm8
    vpxor xmm15, xmm14, xmm11
    vpxor xmm3, xmm3, xmm15
    vaesenc xmm11, xmm11, xmm8
    vpxor xmm15, xmm14, xmm12
    vpxor xmm5, xmm5, xmm15
    vaesenc xmm12, xmm12, xmm8
    vpxor xmm15, xmm14, xmm13
    vpxor xmm7, xmm7, xmm15
    vaesenc xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 160]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm0, xmm0, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm2, xmm2, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm4, xmm4, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm6, xmm6, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 176]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm1, xmm1, xmm15
    vaesenc xmm10, xmm10, xmm8
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm3, xmm3, xmm15
    vaesenc xmm11, xmm11, xmm8
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm5, xmm5, xmm15
    vaesenc xmm12, xmm12, xmm8
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm7, xmm7, xmm15
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm8
    vpshufb xmm14, xmm0, xmm9
    vpshufb xmm15, xmm1, xmm9
    vpunpcklqdq xmm0, xmm14, xmm15
    vpunpckhqdq xmm1, xmm14, xmm15
    vaesenc xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm8
    vpshufb xmm14, xmm2, xmm9
    vpshufb xmm15, xmm3, xmm9
    vpunpcklqdq xmm2, xmm14, xmm15
    vpunpckhqdq xmm3, xmm14, xmm15
    vaesenc xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm8
    vpshufb xmm14, xmm4, xmm9
    vpshufb xmm15, xmm5, xmm9
    vpunpcklqdq xmm4, xmm14, xmm15
    vpunpckhqdq xmm5, xmm14, xmm15
    vaesenc xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm8
    vpshufb xmm14, xmm6, xmm9
    vpshufb xmm15, xmm7, xmm9
    vpunpcklqdq xmm6, xmm14, xmm15
    vpunpckhqdq xmm7, xmm14, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 192]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm0, xmm0, xmm15
    vpxor xmm15, xmm14, xmm11
    vpxor xmm2, xmm2, xmm15
    vpxor xmm15, xmm14, xmm12
    vpxor xmm4, xmm4, xmm15
    vpxor xmm15, xmm14, xmm13
    vpxor xmm6, xmm6, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 208]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm1, xmm1, xmm15
    vaesenc xmm10, xmm10, xmm8
    vpxor xmm15, xmm14, xmm11
    vpxor xmm3, xmm3, xmm15
    vaesenc xmm11, xmm11, xmm8
    vpxor xmm15, xmm14, xmm12
    vpxor xmm5, xmm5, xmm15
    vaesenc xmm12, xmm12, xmm8
    vpxor xmm15, xmm14, xmm13
    vpxor xmm7, xmm7, xmm15
    vaesenc xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 224]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm0, xmm0, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm2, xmm2, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm4, xmm4, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm6, xmm6, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 240]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm1, xmm1, xmm15
    vaesenc xmm10, xmm10, xmm8
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm3, xmm3, xmm15
    vaesenc xmm11, xmm11, xmm8
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm5, xmm5, xmm15
    vaesenc xmm12, xmm12, xmm8
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm7, xmm7, xmm15
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm8
    vpshufb xmm14, xmm0, xmm9
    vpshufb xmm15, xmm1, xmm9
    vpunpcklqdq xmm0, xmm14, xmm15
    vpunpckhqdq xmm1, xmm14, xmm15
    vaesenc xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm8
    vpshufb xmm14, xmm2, xmm9
    vpshufb xmm15, xmm3, xmm9
    vpunpcklqdq xmm2, xmm14, xmm15
    vpunpckhqdq xmm3, xmm14, xmm15
    vaesenc xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm8
    vpshufb xmm14, xmm4, xmm9
    vpshufb xmm15, xmm5, xmm9
    vpunpcklqdq xmm4, xmm14, xmm15
    vpunpckhqdq xmm5, xmm14, xmm15
    vaesenc xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm8
    vpshufb xmm14, xmm6, xmm9
    vpshufb xmm15, xmm7, xmm9
    vpunpcklqdq xmm6, xmm14, xmm15
    vpunpckhqdq xmm7, xmm14, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 256]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm0, xmm0, xmm15
    vpxor xmm15, xmm14, xmm11
    vpxor xmm2, xmm2, xmm15
    vpxor xmm15, xmm14, xmm12
    vpxor xmm4, xmm4, xmm15
    vpxor xmm15, xmm14, xmm13
    vpxor xmm6, xmm6, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 272]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm1, xmm1, xmm15
    vaesenc xmm10, xmm10, xmm8
    vpxor xmm15, xmm14, xmm11
    vpxor xmm3, xmm3, xmm15
    vaesenc xmm11, xmm11, xmm8
    vpxor xmm15, xmm14, xmm12
    vpxor xmm5, xmm5, xmm15
    vaesenc xmm12, xmm12, xmm8
    vpxor xmm15, xmm14, xmm13
    vpxor xmm7, xmm7, xmm15
    vaesenc xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 288]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm0, xmm0, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm2, xmm2, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm4, xmm4, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm6, xmm6, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 304]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm1, xmm1, xmm15
    vaesenc xmm10, xmm10, xmm8
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm3, xmm3, xmm15
    vaesenc xmm11, xmm11, xmm8
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm5, xmm5, xmm15
    vaesenc xmm12, xmm12, xmm8
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm7, xmm7, xmm15
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm0, xmm0, xmm8
    vaesdec xmm1, xmm1, xmm8
    vpshufb xmm14, xmm0, xmm9
    vpshufb xmm15, xmm1, xmm9
    vpunpcklqdq xmm0, xmm14, xmm15
    vpunpckhqdq xmm1, xmm14, xmm15
    vaesenc xmm2, xmm2, xmm8
    vaesdec xmm3, xmm3, xmm8
    vpshufb xmm14, xmm2, xmm9
    vpshufb xmm15, xmm3, xmm9
    vpunpcklqdq xmm2, xmm14, xmm15
    vpunpckhqdq xmm3, xmm14, xmm15
    vaesenc xmm4, xmm4, xmm8
    vaesdec xmm5, xmm5, xmm8
    vpshufb xmm14, xmm4, xmm9
    vpshufb xmm15, xmm5, xmm9
    vpunpcklqdq xmm4, xmm14, xmm15
    vpunpckhqdq xmm5, xmm14, xmm15
    vaesenc xmm6, xmm6, xmm8
    vaesdec xmm7, xmm7, xmm8
    vpshufb xmm14, xmm6, xmm9
    vpshufb xmm15, xmm7, xmm9
    vpunpcklqdq xmm6, xmm14, xmm15
    vpunpckhqdq xmm7, xmm14, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 320]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm0, xmm0, xmm15
    vpxor xmm15, xmm14, xmm11
    vpxor xmm2, xmm2, xmm15
    vpxor xmm15, xmm14, xmm12
    vpxor xmm4, xmm4, xmm15
    vpxor xmm15, xmm14, xmm13
    vpxor xmm6, xmm6, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 336]
    vpxor xmm15, xmm14, xmm10
    vpxor xmm1, xmm1, xmm15
    vaesenc xmm10, xmm10, xmm8
    vpxor xmm15, xmm14, xmm11
    vpxor xmm3, xmm3, xmm15
    vaesenc xmm11, xmm11, xmm8
    vpxor xmm15, xmm14, xmm12
    vpxor xmm5, xmm5, xmm15
    vaesenc xmm12, xmm12, xmm8
    vpxor xmm15, xmm14, xmm13
    vpxor xmm7, xmm7, xmm15
    vaesenc xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 352]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm0, xmm0, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm2, xmm2, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm4, xmm4, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm6, xmm6, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 368]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm1, xmm1, xmm15
    vaesenc xmm10, xmm10, xmm8
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm3, xmm3, xmm15
    vaesenc xmm11, xmm11, xmm8
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm5, xmm5, xmm15
    vaesenc xmm12, xmm12, xmm8
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm7, xmm7, xmm15
    vaesenc xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 384]
    vpxor xmm15, xmm14, xmm10
    vaesenc xmm0, xmm0, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesenc xmm2, xmm2, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesenc xmm4, xmm4, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesenc xmm6, xmm6, xmm15
    vmovdqu xmm14, XMMWORD PTR [rdx + 400]
    vpxor xmm15, xmm14, xmm10
    vaesdec xmm1, xmm1, xmm15
    vpxor xmm15, xmm14, xmm11
    vaesdec xmm3, xmm3, xmm15
    vpxor xmm15, xmm14, xmm12
    vaesdec xmm5, xmm5, xmm15
    vpxor xmm15, xmm14, xmm13
    vaesdec xmm7, xmm7, xmm15
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    ret
areion_asura_encrypt_4blocks_rk_vex_asm ENDP

PUBLIC areion_asura_encrypt_4blocks_rk_vaes256_asm
ALIGN 16
areion_asura_encrypt_4blocks_rk_vaes256_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 120
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    vmovdqu ymm6, YMMWORD PTR [rsi]
    vmovdqu ymm7, YMMWORD PTR [rsi + 32]
    vperm2i128 ymm0, ymm6, ymm7, 32
    vperm2i128 ymm1, ymm6, ymm7, 49
    vmovdqu ymm6, YMMWORD PTR [rsi + 64]
    vmovdqu ymm7, YMMWORD PTR [rsi + 96]
    vperm2i128 ymm2, ymm6, ymm7, 32
    vperm2i128 ymm3, ymm6, ymm7, 49
    vpxor ymm4, ymm4, ymm4
    vmovdqa ymm5, YMMWORD PTR [asuraConsts + 64]
    vmovdqu ymm8, YMMWORD PTR [rcx]
    vmovdqu ymm9, YMMWORD PTR [rcx + 32]
    vbroadcasti128 ymm6, XMMWORD PTR [rdx]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 16]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vpxor ymm0, ymm0, ymm10
    vpxor ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vpxor ymm2, ymm2, ymm10
    vpxor ymm3, ymm3, ymm11
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 32]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 48]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesdec ymm0, ymm0, ymm10
    vaesdec ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesdec ymm2, ymm2, ymm10
    vaesdec ymm3, ymm3, ymm11
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm6, ymm0, ymm5
    vpshufb ymm7, ymm1, ymm5
    vpunpcklqdq ymm0, ymm6, ymm7
    vpunpckhqdq ymm1, ymm6, ymm7
    vpshufb ymm6, ymm2, ymm5
    vpshufb ymm7, ymm3, ymm5
    vpunpcklqdq ymm2, ymm6, ymm7
    vpunpckhqdq ymm3, ymm6, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 64]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 80]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vpxor ymm0, ymm0, ymm10
    vpxor ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vpxor ymm2, ymm2, ymm10
    vpxor ymm3, ymm3, ymm11
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 96]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 112]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesdec ymm0, ymm0, ymm10
    vaesdec ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesdec ymm2, ymm2, ymm10
    vaesdec ymm3, ymm3, ymm11
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm6, ymm0, ymm5
    vpshufb ymm7, ymm1, ymm5
    vpunpcklqdq ymm0, ymm6, ymm7
    vpunpckhqdq ymm1, ymm6, ymm7
    vpshufb ymm6, ymm2, ymm5
    vpshufb ymm7, ymm3, ymm5
    vpunpcklqdq ymm2, ymm6, ymm7
    vpunpckhqdq ymm3, ymm6, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 128]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 144]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vpxor ymm0, ymm0, ymm10
    vpxor ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vpxor ymm2, ymm2, ymm10
    vpxor ymm3, ymm3, ymm11
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 160]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 176]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesdec ymm0, ymm0, ymm10
    vaesdec ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesdec ymm2, ymm2, ymm10
    vaesdec ymm3, ymm3, ymm11
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm6, ymm0, ymm5
    vpshufb ymm7, ymm1, ymm5
    vpunpcklqdq ymm0, ymm6, ymm7
    vpunpckhqdq ymm1, ymm6, ymm7
    vpshufb ymm6, ymm2, ymm5
    vpshufb ymm7, ymm3, ymm5
    vpunpcklqdq ymm2, ymm6, ymm7
    vpunpckhqdq ymm3, ymm6, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 192]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 208]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vpxor ymm0, ymm0, ymm10
    vpxor ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vpxor ymm2, ymm2, ymm10
    vpxor ymm3, ymm3, ymm11
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 224]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 240]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesdec ymm0, ymm0, ymm10
    vaesdec ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesdec ymm2, ymm2, ymm10
    vaesdec ymm3, ymm3, ymm11
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm6, ymm0, ymm5
    vpshufb ymm7, ymm1, ymm5
    vpunpcklqdq ymm0, ymm6, ymm7
    vpunpckhqdq ymm1, ymm6, ymm7
    vpshufb ymm6, ymm2, ymm5
    vpshufb ymm7, ymm3, ymm5
    vpunpcklqdq ymm2, ymm6, ymm7
    vpunpckhqdq ymm3, ymm6, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 256]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 272]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vpxor ymm0, ymm0, ymm10
    vpxor ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vpxor ymm2, ymm2, ymm10
    vpxor ymm3, ymm3, ymm11
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 288]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 304]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesdec ymm0, ymm0, ymm10
    vaesdec ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesdec ymm2, ymm2, ymm10
    vaesdec ymm3, ymm3, ymm11
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdec ymm1, ymm1, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesdec ymm3, ymm3, ymm4
    vpshufb ymm6, ymm0, ymm5
    vpshufb ymm7, ymm1, ymm5
    vpunpcklqdq ymm0, ymm6, ymm7
    vpunpckhqdq ymm1, ymm6, ymm7
    vpshufb ymm6, ymm2, ymm5
    vpshufb ymm7, ymm3, ymm5
    vpunpcklqdq ymm2, ymm6, ymm7
    vpunpckhqdq ymm3, ymm6, ymm7
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 320]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 336]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vpxor ymm0, ymm0, ymm10
    vpxor ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vpxor ymm2, ymm2, ymm10
    vpxor ymm3, ymm3, ymm11
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 352]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 368]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesdec ymm0, ymm0, ymm10
    vaesdec ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesdec ymm2, ymm2, ymm10
    vaesdec ymm3, ymm3, ymm11
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 384]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 400]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesenc ymm0, ymm0, ymm10
    vaesdec ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesenc ymm2, ymm2, ymm10
    vaesdec ymm3, ymm3, ymm11
    vperm2i128 ymm6, ymm0, ymm1, 32
    vperm2i128 ymm7, ymm0, ymm1, 49
    vmovdqu YMMWORD PTR [rdi], ymm6
    vmovdqu YMMWORD PTR [rdi + 32], ymm7
    vperm2i128 ymm6, ymm2, ymm3, 32
    vperm2i128 ymm7, ymm2, ymm3, 49
    vmovdqu YMMWORD PTR [rdi + 64], ymm6
    vmovdqu YMMWORD PTR [rdi + 96], ymm7
    vpxor ymm0, ymm0, ymm0
    vpxor ymm1, ymm1, ymm1
    vpxor ymm2, ymm2, ymm2
    vpxor ymm3, ymm3, ymm3
    vpxor ymm4, ymm4, ymm4
    vpxor ymm5, ymm5, ymm5
    vpxor ymm6, ymm6, ymm6
    vpxor ymm7, ymm7, ymm7
    vpxor ymm8, ymm8, ymm8
    vpxor ymm9, ymm9, ymm9
    vpxor ymm10, ymm10, ymm10
    vpxor ymm11, ymm11, ymm11
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 120
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    vzeroupper
    ret
areion_asura_encrypt_4blocks_rk_vaes256_asm ENDP

PUBLIC areion_asura_encrypt_4blocks_rk_vaes512_asm
ALIGN 16
areion_asura_encrypt_4blocks_rk_vaes512_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 72
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu64 zmm6, ZMMWORD PTR [rsi]
    vmovdqu64 zmm7, ZMMWORD PTR [rsi + 64]
    vshufi64x2 zmm0, zmm6, zmm7, 136
    vshufi64x2 zmm1, zmm6, zmm7, 221
    vpxorq zmm2, zmm2, zmm2
    vbroadcasti32x4 zmm3, XMMWORD PTR [asuraConsts + 64]
    vmovdqu64 zmm8, ZMMWORD PTR [rcx]
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 16]
    vpternlogq zmm0, zmm4, zmm8, 150
    vpternlogq zmm1, zmm5, zmm8, 150
    vaesenc zmm8, zmm8, zmm2
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 32]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 48]
    vpxorq zmm4, zmm4, zmm8
    vpxorq zmm5, zmm5, zmm8
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm8, zmm8, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm2
    vpshufb zmm6, zmm0, zmm3
    vpshufb zmm7, zmm1, zmm3
    vpunpcklqdq zmm0, zmm6, zmm7
    vpunpckhqdq zmm1, zmm6, zmm7
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 64]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 80]
    vpternlogq zmm0, zmm4, zmm8, 150
    vpternlogq zmm1, zmm5, zmm8, 150
    vaesenc zmm8, zmm8, zmm2
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 96]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 112]
    vpxorq zmm4, zmm4, zmm8
    vpxorq zmm5, zmm5, zmm8
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm8, zmm8, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm2
    vpshufb zmm6, zmm0, zmm3
    vpshufb zmm7, zmm1, zmm3
    vpunpcklqdq zmm0, zmm6, zmm7
    vpunpckhqdq zmm1, zmm6, zmm7
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 128]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 144]
    vpternlogq zmm0, zmm4, zmm8, 150
    vpternlogq zmm1, zmm5, zmm8, 150
    vaesenc zmm8, zmm8, zmm2
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 160]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 176]
    vpxorq zmm4, zmm4, zmm8
    vpxorq zmm5, zmm5, zmm8
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm8, zmm8, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm2
    vpshufb zmm6, zmm0, zmm3
    vpshufb zmm7, zmm1, zmm3
    vpunpcklqdq zmm0, zmm6, zmm7
    vpunpckhqdq zmm1, zmm6, zmm7
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 192]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 208]
    vpternlogq zmm0, zmm4, zmm8, 150
    vpternlogq zmm1, zmm5, zmm8, 150
    vaesenc zmm8, zmm8, zmm2
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 224]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 240]
    vpxorq zmm4, zmm4, zmm8
    vpxorq zmm5, zmm5, zmm8
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm8, zmm8, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm2
    vpshufb zmm6, zmm0, zmm3
    vpshufb zmm7, zmm1, zmm3
    vpunpcklqdq zmm0, zmm6, zmm7
    vpunpckhqdq zmm1, zmm6, zmm7
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 256]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 272]
    vpternlogq zmm0, zmm4, zmm8, 150
    vpternlogq zmm1, zmm5, zmm8, 150
    vaesenc zmm8, zmm8, zmm2
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 288]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 304]
    vpxorq zmm4, zmm4, zmm8
    vpxorq zmm5, zmm5, zmm8
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm8, zmm8, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesdec zmm1, zmm1, zmm2
    vpshufb zmm6, zmm0, zmm3
    vpshufb zmm7, zmm1, zmm3
    vpunpcklqdq zmm0, zmm6, zmm7
    vpunpckhqdq zmm1, zmm6, zmm7
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 320]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 336]
    vpternlogq zmm0, zmm4, zmm8, 150
    vpternlogq zmm1, zmm5, zmm8, 150
    vaesenc zmm8, zmm8, zmm2
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 352]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 368]
    vpxorq zmm4, zmm4, zmm8
    vpxorq zmm5, zmm5, zmm8
    vaesdec zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vaesenc zmm8, zmm8, zmm2
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 384]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 400]
    vpxorq zmm4, zmm4, zmm8
    vpxorq zmm5, zmm5, zmm8
    vaesenc zmm0, zmm0, zmm4
    vaesdec zmm1, zmm1, zmm5
    vshufi64x2 zmm6, zmm0, zmm1, 68
    vshufi64x2 zmm6, zmm6, zmm6, 216
    vshufi64x2 zmm7, zmm0, zmm1, 238
    vshufi64x2 zmm7, zmm7, zmm7, 216
    vmovdqu64 ZMMWORD PTR [rdi], zmm6
    vmovdqu64 ZMMWORD PTR [rdi + 64], zmm7
    vpxorq zmm0, zmm0, zmm0
    vpxorq zmm1, zmm1, zmm1
    vpxorq zmm2, zmm2, zmm2
    vpxorq zmm3, zmm3, zmm3
    vpxorq zmm4, zmm4, zmm4
    vpxorq zmm5, zmm5, zmm5
    vpxorq zmm6, zmm6, zmm6
    vpxorq zmm7, zmm7, zmm7
    vpxorq zmm8, zmm8, zmm8
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 72
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    vzeroupper
    ret
areion_asura_encrypt_4blocks_rk_vaes512_asm ENDP

PUBLIC areion_asura_decrypt_4blocks_rk_aesni_asm
ALIGN 16
areion_asura_decrypt_4blocks_rk_aesni_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    pxor xmm8, xmm8
    movdqu xmm10, XMMWORD PTR [rcx]
    movdqu xmm11, XMMWORD PTR [rcx + 16]
    movdqu xmm12, XMMWORD PTR [rcx + 32]
    movdqu xmm13, XMMWORD PTR [rcx + 48]
    aesenc xmm10, xmm8
    aesenc xmm11, xmm8
    aesenc xmm12, xmm8
    aesenc xmm13, xmm8
    aesenc xmm10, xmm8
    aesenc xmm11, xmm8
    aesenc xmm12, xmm8
    aesenc xmm13, xmm8
    aesenc xmm10, xmm8
    aesenc xmm11, xmm8
    aesenc xmm12, xmm8
    aesenc xmm13, xmm8
    aesenc xmm10, xmm8
    aesenc xmm11, xmm8
    aesenc xmm12, xmm8
    aesenc xmm13, xmm8
    aesenc xmm10, xmm8
    aesenc xmm11, xmm8
    aesenc xmm12, xmm8
    aesenc xmm13, xmm8
    aesenc xmm10, xmm8
    aesenc xmm11, xmm8
    aesenc xmm12, xmm8
    aesenc xmm13, xmm8
    aesenc xmm10, xmm8
    aesenc xmm11, xmm8
    aesenc xmm12, xmm8
    aesenc xmm13, xmm8
    aesenc xmm10, xmm8
    aesenc xmm11, xmm8
    aesenc xmm12, xmm8
    aesenc xmm13, xmm8
    aesenc xmm10, xmm8
    aesenc xmm11, xmm8
    aesenc xmm12, xmm8
    aesenc xmm13, xmm8
    aesenc xmm10, xmm8
    aesenc xmm11, xmm8
    aesenc xmm12, xmm8
    aesenc xmm13, xmm8
    aesenc xmm10, xmm8
    aesenc xmm11, xmm8
    aesenc xmm12, xmm8
    aesenc xmm13, xmm8
    aesenc xmm10, xmm8
    aesenc xmm11, xmm8
    aesenc xmm12, xmm8
    aesenc xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 384]
    movdqu xmm15, XMMWORD PTR [rdx + 400]
    movdqa xmm9, xmm14
    pxor xmm9, xmm10
    pxor xmm0, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm10
    pxor xmm1, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm11
    pxor xmm2, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm11
    pxor xmm3, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm12
    pxor xmm4, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm12
    pxor xmm5, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm13
    pxor xmm6, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm13
    pxor xmm7, xmm9
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm8
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm8
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm8
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 352]
    movdqu xmm15, XMMWORD PTR [rdx + 368]
    movdqa xmm9, xmm14
    pxor xmm9, xmm10
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm10
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm1, xmm8
    aesenc xmm1, xmm8
    aesenc xmm1, xmm9
    aesdeclast xmm0, xmm8
    aesenc xmm0, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm11
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm3, xmm8
    aesenc xmm3, xmm8
    aesenc xmm3, xmm9
    aesdeclast xmm2, xmm8
    aesenc xmm2, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm12
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm12
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm5, xmm8
    aesenc xmm5, xmm8
    aesenc xmm5, xmm9
    aesdeclast xmm4, xmm8
    aesenc xmm4, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm13
    aesimc xmm6, xmm6
    aesdeclast xmm6, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm13
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm7, xmm8
    aesenc xmm7, xmm8
    aesenc xmm7, xmm9
    aesdeclast xmm6, xmm8
    aesenc xmm6, xmm8
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm8
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm8
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm8
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 320]
    movdqu xmm15, XMMWORD PTR [rdx + 336]
    movdqa xmm9, xmm14
    pxor xmm9, xmm10
    aesenclast xmm0, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm10
    aesenclast xmm1, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm11
    aesenclast xmm2, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm11
    aesenclast xmm3, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm12
    aesenclast xmm4, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm12
    aesenclast xmm5, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm13
    aesenclast xmm6, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm13
    aesenclast xmm7, xmm9
    movdqa xmm9, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm9, xmm1
    movdqa xmm1, xmm9
    movdqa xmm9, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm9, xmm3
    movdqa xmm3, xmm9
    movdqa xmm9, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm9, xmm5
    movdqa xmm5, xmm9
    movdqa xmm9, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm9, xmm7
    movdqa xmm7, xmm9
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm8
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm8
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm8
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 288]
    movdqu xmm15, XMMWORD PTR [rdx + 304]
    movdqa xmm9, xmm14
    pxor xmm9, xmm10
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm10
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm1, xmm8
    aesenc xmm1, xmm8
    aesenc xmm1, xmm9
    aesdeclast xmm0, xmm8
    aesenc xmm0, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm11
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm3, xmm8
    aesenc xmm3, xmm8
    aesenc xmm3, xmm9
    aesdeclast xmm2, xmm8
    aesenc xmm2, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm12
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm12
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm5, xmm8
    aesenc xmm5, xmm8
    aesenc xmm5, xmm9
    aesdeclast xmm4, xmm8
    aesenc xmm4, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm13
    aesimc xmm6, xmm6
    aesdeclast xmm6, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm13
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm7, xmm8
    aesenc xmm7, xmm8
    aesenc xmm7, xmm9
    aesdeclast xmm6, xmm8
    aesenc xmm6, xmm8
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm8
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm8
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm8
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 256]
    movdqu xmm15, XMMWORD PTR [rdx + 272]
    movdqa xmm9, xmm14
    pxor xmm9, xmm10
    aesenclast xmm0, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm10
    aesenclast xmm1, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm11
    aesenclast xmm2, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm11
    aesenclast xmm3, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm12
    aesenclast xmm4, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm12
    aesenclast xmm5, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm13
    aesenclast xmm6, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm13
    aesenclast xmm7, xmm9
    movdqa xmm9, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm9, xmm1
    movdqa xmm1, xmm9
    movdqa xmm9, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm9, xmm3
    movdqa xmm3, xmm9
    movdqa xmm9, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm9, xmm5
    movdqa xmm5, xmm9
    movdqa xmm9, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm9, xmm7
    movdqa xmm7, xmm9
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm8
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm8
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm8
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 224]
    movdqu xmm15, XMMWORD PTR [rdx + 240]
    movdqa xmm9, xmm14
    pxor xmm9, xmm10
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm10
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm1, xmm8
    aesenc xmm1, xmm8
    aesenc xmm1, xmm9
    aesdeclast xmm0, xmm8
    aesenc xmm0, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm11
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm3, xmm8
    aesenc xmm3, xmm8
    aesenc xmm3, xmm9
    aesdeclast xmm2, xmm8
    aesenc xmm2, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm12
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm12
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm5, xmm8
    aesenc xmm5, xmm8
    aesenc xmm5, xmm9
    aesdeclast xmm4, xmm8
    aesenc xmm4, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm13
    aesimc xmm6, xmm6
    aesdeclast xmm6, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm13
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm7, xmm8
    aesenc xmm7, xmm8
    aesenc xmm7, xmm9
    aesdeclast xmm6, xmm8
    aesenc xmm6, xmm8
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm8
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm8
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm8
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 192]
    movdqu xmm15, XMMWORD PTR [rdx + 208]
    movdqa xmm9, xmm14
    pxor xmm9, xmm10
    aesenclast xmm0, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm10
    aesenclast xmm1, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm11
    aesenclast xmm2, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm11
    aesenclast xmm3, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm12
    aesenclast xmm4, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm12
    aesenclast xmm5, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm13
    aesenclast xmm6, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm13
    aesenclast xmm7, xmm9
    movdqa xmm9, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm9, xmm1
    movdqa xmm1, xmm9
    movdqa xmm9, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm9, xmm3
    movdqa xmm3, xmm9
    movdqa xmm9, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm9, xmm5
    movdqa xmm5, xmm9
    movdqa xmm9, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm9, xmm7
    movdqa xmm7, xmm9
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm8
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm8
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm8
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 160]
    movdqu xmm15, XMMWORD PTR [rdx + 176]
    movdqa xmm9, xmm14
    pxor xmm9, xmm10
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm10
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm1, xmm8
    aesenc xmm1, xmm8
    aesenc xmm1, xmm9
    aesdeclast xmm0, xmm8
    aesenc xmm0, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm11
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm3, xmm8
    aesenc xmm3, xmm8
    aesenc xmm3, xmm9
    aesdeclast xmm2, xmm8
    aesenc xmm2, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm12
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm12
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm5, xmm8
    aesenc xmm5, xmm8
    aesenc xmm5, xmm9
    aesdeclast xmm4, xmm8
    aesenc xmm4, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm13
    aesimc xmm6, xmm6
    aesdeclast xmm6, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm13
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm7, xmm8
    aesenc xmm7, xmm8
    aesenc xmm7, xmm9
    aesdeclast xmm6, xmm8
    aesenc xmm6, xmm8
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm8
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm8
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm8
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 128]
    movdqu xmm15, XMMWORD PTR [rdx + 144]
    movdqa xmm9, xmm14
    pxor xmm9, xmm10
    aesenclast xmm0, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm10
    aesenclast xmm1, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm11
    aesenclast xmm2, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm11
    aesenclast xmm3, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm12
    aesenclast xmm4, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm12
    aesenclast xmm5, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm13
    aesenclast xmm6, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm13
    aesenclast xmm7, xmm9
    movdqa xmm9, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm9, xmm1
    movdqa xmm1, xmm9
    movdqa xmm9, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm9, xmm3
    movdqa xmm3, xmm9
    movdqa xmm9, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm9, xmm5
    movdqa xmm5, xmm9
    movdqa xmm9, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm9, xmm7
    movdqa xmm7, xmm9
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm8
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm8
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm8
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 96]
    movdqu xmm15, XMMWORD PTR [rdx + 112]
    movdqa xmm9, xmm14
    pxor xmm9, xmm10
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm10
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm1, xmm8
    aesenc xmm1, xmm8
    aesenc xmm1, xmm9
    aesdeclast xmm0, xmm8
    aesenc xmm0, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm11
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm3, xmm8
    aesenc xmm3, xmm8
    aesenc xmm3, xmm9
    aesdeclast xmm2, xmm8
    aesenc xmm2, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm12
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm12
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm5, xmm8
    aesenc xmm5, xmm8
    aesenc xmm5, xmm9
    aesdeclast xmm4, xmm8
    aesenc xmm4, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm13
    aesimc xmm6, xmm6
    aesdeclast xmm6, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm13
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm7, xmm8
    aesenc xmm7, xmm8
    aesenc xmm7, xmm9
    aesdeclast xmm6, xmm8
    aesenc xmm6, xmm8
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm8
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm8
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm8
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 64]
    movdqu xmm15, XMMWORD PTR [rdx + 80]
    movdqa xmm9, xmm14
    pxor xmm9, xmm10
    aesenclast xmm0, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm10
    aesenclast xmm1, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm11
    aesenclast xmm2, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm11
    aesenclast xmm3, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm12
    aesenclast xmm4, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm12
    aesenclast xmm5, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm13
    aesenclast xmm6, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm13
    aesenclast xmm7, xmm9
    movdqa xmm9, xmm0
    punpcklbw xmm0, xmm1
    punpckhbw xmm9, xmm1
    movdqa xmm1, xmm9
    movdqa xmm9, xmm2
    punpcklbw xmm2, xmm3
    punpckhbw xmm9, xmm3
    movdqa xmm3, xmm9
    movdqa xmm9, xmm4
    punpcklbw xmm4, xmm5
    punpckhbw xmm9, xmm5
    movdqa xmm5, xmm9
    movdqa xmm9, xmm6
    punpcklbw xmm6, xmm7
    punpckhbw xmm9, xmm7
    movdqa xmm7, xmm9
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm8
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm8
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm8
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx + 32]
    movdqu xmm15, XMMWORD PTR [rdx + 48]
    movdqa xmm9, xmm14
    pxor xmm9, xmm10
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm10
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm1, xmm8
    aesenc xmm1, xmm8
    aesenc xmm1, xmm9
    aesdeclast xmm0, xmm8
    aesenc xmm0, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm11
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm11
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm3, xmm8
    aesenc xmm3, xmm8
    aesenc xmm3, xmm9
    aesdeclast xmm2, xmm8
    aesenc xmm2, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm12
    aesimc xmm4, xmm4
    aesdeclast xmm4, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm12
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm5, xmm8
    aesenc xmm5, xmm8
    aesenc xmm5, xmm9
    aesdeclast xmm4, xmm8
    aesenc xmm4, xmm8
    movdqa xmm9, xmm14
    pxor xmm9, xmm13
    aesimc xmm6, xmm6
    aesdeclast xmm6, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm13
    aesdeclast xmm9, xmm8
    aesenc xmm9, xmm8
    aesdeclast xmm7, xmm8
    aesenc xmm7, xmm8
    aesenc xmm7, xmm9
    aesdeclast xmm6, xmm8
    aesenc xmm6, xmm8
    aesimc xmm10, xmm10
    aesdeclast xmm10, xmm8
    aesimc xmm11, xmm11
    aesdeclast xmm11, xmm8
    aesimc xmm12, xmm12
    aesdeclast xmm12, xmm8
    aesimc xmm13, xmm13
    aesdeclast xmm13, xmm8
    movdqu xmm14, XMMWORD PTR [rdx]
    movdqu xmm15, XMMWORD PTR [rdx + 16]
    movdqa xmm9, xmm14
    pxor xmm9, xmm10
    aesenclast xmm0, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm10
    aesenclast xmm1, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm11
    aesenclast xmm2, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm11
    aesenclast xmm3, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm12
    aesenclast xmm4, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm12
    aesenclast xmm5, xmm9
    movdqa xmm9, xmm14
    pxor xmm9, xmm13
    aesenclast xmm6, xmm9
    movdqa xmm9, xmm15
    pxor xmm9, xmm13
    aesenclast xmm7, xmm9
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    ret
areion_asura_decrypt_4blocks_rk_aesni_asm ENDP

PUBLIC areion_asura_decrypt_4blocks_rk_vex_asm
ALIGN 16
areion_asura_decrypt_4blocks_rk_vex_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 184
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    vpxor xmm8, xmm8, xmm8
    vmovdqu xmm10, XMMWORD PTR [rcx]
    vmovdqu xmm11, XMMWORD PTR [rcx + 16]
    vmovdqu xmm12, XMMWORD PTR [rcx + 32]
    vmovdqu xmm13, XMMWORD PTR [rcx + 48]
    vaesenc xmm10, xmm10, xmm8
    vaesenc xmm11, xmm11, xmm8
    vaesenc xmm12, xmm12, xmm8
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesenc xmm11, xmm11, xmm8
    vaesenc xmm12, xmm12, xmm8
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesenc xmm11, xmm11, xmm8
    vaesenc xmm12, xmm12, xmm8
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesenc xmm11, xmm11, xmm8
    vaesenc xmm12, xmm12, xmm8
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesenc xmm11, xmm11, xmm8
    vaesenc xmm12, xmm12, xmm8
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesenc xmm11, xmm11, xmm8
    vaesenc xmm12, xmm12, xmm8
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesenc xmm11, xmm11, xmm8
    vaesenc xmm12, xmm12, xmm8
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesenc xmm11, xmm11, xmm8
    vaesenc xmm12, xmm12, xmm8
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesenc xmm11, xmm11, xmm8
    vaesenc xmm12, xmm12, xmm8
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesenc xmm11, xmm11, xmm8
    vaesenc xmm12, xmm12, xmm8
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesenc xmm11, xmm11, xmm8
    vaesenc xmm12, xmm12, xmm8
    vaesenc xmm13, xmm13, xmm8
    vaesenc xmm10, xmm10, xmm8
    vaesenc xmm11, xmm11, xmm8
    vaesenc xmm12, xmm12, xmm8
    vaesenc xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 384]
    vmovdqu xmm15, XMMWORD PTR [rdx + 400]
    vpxor xmm9, xmm14, xmm10
    vpxor xmm0, xmm0, xmm9
    vpxor xmm9, xmm15, xmm10
    vpxor xmm1, xmm1, xmm9
    vpxor xmm9, xmm14, xmm11
    vpxor xmm2, xmm2, xmm9
    vpxor xmm9, xmm15, xmm11
    vpxor xmm3, xmm3, xmm9
    vpxor xmm9, xmm14, xmm12
    vpxor xmm4, xmm4, xmm9
    vpxor xmm9, xmm15, xmm12
    vpxor xmm5, xmm5, xmm9
    vpxor xmm9, xmm14, xmm13
    vpxor xmm6, xmm6, xmm9
    vpxor xmm9, xmm15, xmm13
    vpxor xmm7, xmm7, xmm9
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm8
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm8
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm8
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 352]
    vmovdqu xmm15, XMMWORD PTR [rdx + 368]
    vpxor xmm9, xmm14, xmm10
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, xmm9
    vpxor xmm9, xmm15, xmm10
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm1, xmm1, xmm8
    vaesenc xmm1, xmm1, xmm8
    vaesenc xmm1, xmm1, xmm9
    vaesdeclast xmm0, xmm0, xmm8
    vaesenc xmm0, xmm0, xmm8
    vpxor xmm9, xmm14, xmm11
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, xmm9
    vpxor xmm9, xmm15, xmm11
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm3, xmm3, xmm8
    vaesenc xmm3, xmm3, xmm8
    vaesenc xmm3, xmm3, xmm9
    vaesdeclast xmm2, xmm2, xmm8
    vaesenc xmm2, xmm2, xmm8
    vpxor xmm9, xmm14, xmm12
    vaesimc xmm4, xmm4
    vaesdeclast xmm4, xmm4, xmm9
    vpxor xmm9, xmm15, xmm12
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm5, xmm5, xmm8
    vaesenc xmm5, xmm5, xmm8
    vaesenc xmm5, xmm5, xmm9
    vaesdeclast xmm4, xmm4, xmm8
    vaesenc xmm4, xmm4, xmm8
    vpxor xmm9, xmm14, xmm13
    vaesimc xmm6, xmm6
    vaesdeclast xmm6, xmm6, xmm9
    vpxor xmm9, xmm15, xmm13
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm7, xmm7, xmm8
    vaesenc xmm7, xmm7, xmm8
    vaesenc xmm7, xmm7, xmm9
    vaesdeclast xmm6, xmm6, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm8
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm8
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm8
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 320]
    vmovdqu xmm15, XMMWORD PTR [rdx + 336]
    vpxor xmm9, xmm14, xmm10
    vaesenclast xmm0, xmm0, xmm9
    vpxor xmm9, xmm15, xmm10
    vaesenclast xmm1, xmm1, xmm9
    vpxor xmm9, xmm14, xmm11
    vaesenclast xmm2, xmm2, xmm9
    vpxor xmm9, xmm15, xmm11
    vaesenclast xmm3, xmm3, xmm9
    vpxor xmm9, xmm14, xmm12
    vaesenclast xmm4, xmm4, xmm9
    vpxor xmm9, xmm15, xmm12
    vaesenclast xmm5, xmm5, xmm9
    vpxor xmm9, xmm14, xmm13
    vaesenclast xmm6, xmm6, xmm9
    vpxor xmm9, xmm15, xmm13
    vaesenclast xmm7, xmm7, xmm9
    vpunpcklbw xmm9, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm9
    vpunpcklbw xmm9, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vmovdqa xmm2, xmm9
    vpunpcklbw xmm9, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vmovdqa xmm4, xmm9
    vpunpcklbw xmm9, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vmovdqa xmm6, xmm9
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm8
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm8
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm8
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 288]
    vmovdqu xmm15, XMMWORD PTR [rdx + 304]
    vpxor xmm9, xmm14, xmm10
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, xmm9
    vpxor xmm9, xmm15, xmm10
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm1, xmm1, xmm8
    vaesenc xmm1, xmm1, xmm8
    vaesenc xmm1, xmm1, xmm9
    vaesdeclast xmm0, xmm0, xmm8
    vaesenc xmm0, xmm0, xmm8
    vpxor xmm9, xmm14, xmm11
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, xmm9
    vpxor xmm9, xmm15, xmm11
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm3, xmm3, xmm8
    vaesenc xmm3, xmm3, xmm8
    vaesenc xmm3, xmm3, xmm9
    vaesdeclast xmm2, xmm2, xmm8
    vaesenc xmm2, xmm2, xmm8
    vpxor xmm9, xmm14, xmm12
    vaesimc xmm4, xmm4
    vaesdeclast xmm4, xmm4, xmm9
    vpxor xmm9, xmm15, xmm12
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm5, xmm5, xmm8
    vaesenc xmm5, xmm5, xmm8
    vaesenc xmm5, xmm5, xmm9
    vaesdeclast xmm4, xmm4, xmm8
    vaesenc xmm4, xmm4, xmm8
    vpxor xmm9, xmm14, xmm13
    vaesimc xmm6, xmm6
    vaesdeclast xmm6, xmm6, xmm9
    vpxor xmm9, xmm15, xmm13
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm7, xmm7, xmm8
    vaesenc xmm7, xmm7, xmm8
    vaesenc xmm7, xmm7, xmm9
    vaesdeclast xmm6, xmm6, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm8
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm8
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm8
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 256]
    vmovdqu xmm15, XMMWORD PTR [rdx + 272]
    vpxor xmm9, xmm14, xmm10
    vaesenclast xmm0, xmm0, xmm9
    vpxor xmm9, xmm15, xmm10
    vaesenclast xmm1, xmm1, xmm9
    vpxor xmm9, xmm14, xmm11
    vaesenclast xmm2, xmm2, xmm9
    vpxor xmm9, xmm15, xmm11
    vaesenclast xmm3, xmm3, xmm9
    vpxor xmm9, xmm14, xmm12
    vaesenclast xmm4, xmm4, xmm9
    vpxor xmm9, xmm15, xmm12
    vaesenclast xmm5, xmm5, xmm9
    vpxor xmm9, xmm14, xmm13
    vaesenclast xmm6, xmm6, xmm9
    vpxor xmm9, xmm15, xmm13
    vaesenclast xmm7, xmm7, xmm9
    vpunpcklbw xmm9, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm9
    vpunpcklbw xmm9, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vmovdqa xmm2, xmm9
    vpunpcklbw xmm9, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vmovdqa xmm4, xmm9
    vpunpcklbw xmm9, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vmovdqa xmm6, xmm9
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm8
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm8
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm8
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 224]
    vmovdqu xmm15, XMMWORD PTR [rdx + 240]
    vpxor xmm9, xmm14, xmm10
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, xmm9
    vpxor xmm9, xmm15, xmm10
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm1, xmm1, xmm8
    vaesenc xmm1, xmm1, xmm8
    vaesenc xmm1, xmm1, xmm9
    vaesdeclast xmm0, xmm0, xmm8
    vaesenc xmm0, xmm0, xmm8
    vpxor xmm9, xmm14, xmm11
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, xmm9
    vpxor xmm9, xmm15, xmm11
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm3, xmm3, xmm8
    vaesenc xmm3, xmm3, xmm8
    vaesenc xmm3, xmm3, xmm9
    vaesdeclast xmm2, xmm2, xmm8
    vaesenc xmm2, xmm2, xmm8
    vpxor xmm9, xmm14, xmm12
    vaesimc xmm4, xmm4
    vaesdeclast xmm4, xmm4, xmm9
    vpxor xmm9, xmm15, xmm12
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm5, xmm5, xmm8
    vaesenc xmm5, xmm5, xmm8
    vaesenc xmm5, xmm5, xmm9
    vaesdeclast xmm4, xmm4, xmm8
    vaesenc xmm4, xmm4, xmm8
    vpxor xmm9, xmm14, xmm13
    vaesimc xmm6, xmm6
    vaesdeclast xmm6, xmm6, xmm9
    vpxor xmm9, xmm15, xmm13
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm7, xmm7, xmm8
    vaesenc xmm7, xmm7, xmm8
    vaesenc xmm7, xmm7, xmm9
    vaesdeclast xmm6, xmm6, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm8
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm8
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm8
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 192]
    vmovdqu xmm15, XMMWORD PTR [rdx + 208]
    vpxor xmm9, xmm14, xmm10
    vaesenclast xmm0, xmm0, xmm9
    vpxor xmm9, xmm15, xmm10
    vaesenclast xmm1, xmm1, xmm9
    vpxor xmm9, xmm14, xmm11
    vaesenclast xmm2, xmm2, xmm9
    vpxor xmm9, xmm15, xmm11
    vaesenclast xmm3, xmm3, xmm9
    vpxor xmm9, xmm14, xmm12
    vaesenclast xmm4, xmm4, xmm9
    vpxor xmm9, xmm15, xmm12
    vaesenclast xmm5, xmm5, xmm9
    vpxor xmm9, xmm14, xmm13
    vaesenclast xmm6, xmm6, xmm9
    vpxor xmm9, xmm15, xmm13
    vaesenclast xmm7, xmm7, xmm9
    vpunpcklbw xmm9, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm9
    vpunpcklbw xmm9, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vmovdqa xmm2, xmm9
    vpunpcklbw xmm9, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vmovdqa xmm4, xmm9
    vpunpcklbw xmm9, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vmovdqa xmm6, xmm9
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm8
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm8
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm8
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 160]
    vmovdqu xmm15, XMMWORD PTR [rdx + 176]
    vpxor xmm9, xmm14, xmm10
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, xmm9
    vpxor xmm9, xmm15, xmm10
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm1, xmm1, xmm8
    vaesenc xmm1, xmm1, xmm8
    vaesenc xmm1, xmm1, xmm9
    vaesdeclast xmm0, xmm0, xmm8
    vaesenc xmm0, xmm0, xmm8
    vpxor xmm9, xmm14, xmm11
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, xmm9
    vpxor xmm9, xmm15, xmm11
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm3, xmm3, xmm8
    vaesenc xmm3, xmm3, xmm8
    vaesenc xmm3, xmm3, xmm9
    vaesdeclast xmm2, xmm2, xmm8
    vaesenc xmm2, xmm2, xmm8
    vpxor xmm9, xmm14, xmm12
    vaesimc xmm4, xmm4
    vaesdeclast xmm4, xmm4, xmm9
    vpxor xmm9, xmm15, xmm12
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm5, xmm5, xmm8
    vaesenc xmm5, xmm5, xmm8
    vaesenc xmm5, xmm5, xmm9
    vaesdeclast xmm4, xmm4, xmm8
    vaesenc xmm4, xmm4, xmm8
    vpxor xmm9, xmm14, xmm13
    vaesimc xmm6, xmm6
    vaesdeclast xmm6, xmm6, xmm9
    vpxor xmm9, xmm15, xmm13
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm7, xmm7, xmm8
    vaesenc xmm7, xmm7, xmm8
    vaesenc xmm7, xmm7, xmm9
    vaesdeclast xmm6, xmm6, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm8
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm8
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm8
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 128]
    vmovdqu xmm15, XMMWORD PTR [rdx + 144]
    vpxor xmm9, xmm14, xmm10
    vaesenclast xmm0, xmm0, xmm9
    vpxor xmm9, xmm15, xmm10
    vaesenclast xmm1, xmm1, xmm9
    vpxor xmm9, xmm14, xmm11
    vaesenclast xmm2, xmm2, xmm9
    vpxor xmm9, xmm15, xmm11
    vaesenclast xmm3, xmm3, xmm9
    vpxor xmm9, xmm14, xmm12
    vaesenclast xmm4, xmm4, xmm9
    vpxor xmm9, xmm15, xmm12
    vaesenclast xmm5, xmm5, xmm9
    vpxor xmm9, xmm14, xmm13
    vaesenclast xmm6, xmm6, xmm9
    vpxor xmm9, xmm15, xmm13
    vaesenclast xmm7, xmm7, xmm9
    vpunpcklbw xmm9, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm9
    vpunpcklbw xmm9, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vmovdqa xmm2, xmm9
    vpunpcklbw xmm9, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vmovdqa xmm4, xmm9
    vpunpcklbw xmm9, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vmovdqa xmm6, xmm9
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm8
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm8
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm8
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 96]
    vmovdqu xmm15, XMMWORD PTR [rdx + 112]
    vpxor xmm9, xmm14, xmm10
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, xmm9
    vpxor xmm9, xmm15, xmm10
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm1, xmm1, xmm8
    vaesenc xmm1, xmm1, xmm8
    vaesenc xmm1, xmm1, xmm9
    vaesdeclast xmm0, xmm0, xmm8
    vaesenc xmm0, xmm0, xmm8
    vpxor xmm9, xmm14, xmm11
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, xmm9
    vpxor xmm9, xmm15, xmm11
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm3, xmm3, xmm8
    vaesenc xmm3, xmm3, xmm8
    vaesenc xmm3, xmm3, xmm9
    vaesdeclast xmm2, xmm2, xmm8
    vaesenc xmm2, xmm2, xmm8
    vpxor xmm9, xmm14, xmm12
    vaesimc xmm4, xmm4
    vaesdeclast xmm4, xmm4, xmm9
    vpxor xmm9, xmm15, xmm12
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm5, xmm5, xmm8
    vaesenc xmm5, xmm5, xmm8
    vaesenc xmm5, xmm5, xmm9
    vaesdeclast xmm4, xmm4, xmm8
    vaesenc xmm4, xmm4, xmm8
    vpxor xmm9, xmm14, xmm13
    vaesimc xmm6, xmm6
    vaesdeclast xmm6, xmm6, xmm9
    vpxor xmm9, xmm15, xmm13
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm7, xmm7, xmm8
    vaesenc xmm7, xmm7, xmm8
    vaesenc xmm7, xmm7, xmm9
    vaesdeclast xmm6, xmm6, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm8
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm8
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm8
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 64]
    vmovdqu xmm15, XMMWORD PTR [rdx + 80]
    vpxor xmm9, xmm14, xmm10
    vaesenclast xmm0, xmm0, xmm9
    vpxor xmm9, xmm15, xmm10
    vaesenclast xmm1, xmm1, xmm9
    vpxor xmm9, xmm14, xmm11
    vaesenclast xmm2, xmm2, xmm9
    vpxor xmm9, xmm15, xmm11
    vaesenclast xmm3, xmm3, xmm9
    vpxor xmm9, xmm14, xmm12
    vaesenclast xmm4, xmm4, xmm9
    vpxor xmm9, xmm15, xmm12
    vaesenclast xmm5, xmm5, xmm9
    vpxor xmm9, xmm14, xmm13
    vaesenclast xmm6, xmm6, xmm9
    vpxor xmm9, xmm15, xmm13
    vaesenclast xmm7, xmm7, xmm9
    vpunpcklbw xmm9, xmm0, xmm1
    vpunpckhbw xmm1, xmm0, xmm1
    vmovdqa xmm0, xmm9
    vpunpcklbw xmm9, xmm2, xmm3
    vpunpckhbw xmm3, xmm2, xmm3
    vmovdqa xmm2, xmm9
    vpunpcklbw xmm9, xmm4, xmm5
    vpunpckhbw xmm5, xmm4, xmm5
    vmovdqa xmm4, xmm9
    vpunpcklbw xmm9, xmm6, xmm7
    vpunpckhbw xmm7, xmm6, xmm7
    vmovdqa xmm6, xmm9
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm8
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm8
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm8
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx + 32]
    vmovdqu xmm15, XMMWORD PTR [rdx + 48]
    vpxor xmm9, xmm14, xmm10
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, xmm9
    vpxor xmm9, xmm15, xmm10
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm1, xmm1, xmm8
    vaesenc xmm1, xmm1, xmm8
    vaesenc xmm1, xmm1, xmm9
    vaesdeclast xmm0, xmm0, xmm8
    vaesenc xmm0, xmm0, xmm8
    vpxor xmm9, xmm14, xmm11
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, xmm9
    vpxor xmm9, xmm15, xmm11
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm3, xmm3, xmm8
    vaesenc xmm3, xmm3, xmm8
    vaesenc xmm3, xmm3, xmm9
    vaesdeclast xmm2, xmm2, xmm8
    vaesenc xmm2, xmm2, xmm8
    vpxor xmm9, xmm14, xmm12
    vaesimc xmm4, xmm4
    vaesdeclast xmm4, xmm4, xmm9
    vpxor xmm9, xmm15, xmm12
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm5, xmm5, xmm8
    vaesenc xmm5, xmm5, xmm8
    vaesenc xmm5, xmm5, xmm9
    vaesdeclast xmm4, xmm4, xmm8
    vaesenc xmm4, xmm4, xmm8
    vpxor xmm9, xmm14, xmm13
    vaesimc xmm6, xmm6
    vaesdeclast xmm6, xmm6, xmm9
    vpxor xmm9, xmm15, xmm13
    vaesdeclast xmm9, xmm9, xmm8
    vaesenc xmm9, xmm9, xmm8
    vaesdeclast xmm7, xmm7, xmm8
    vaesenc xmm7, xmm7, xmm8
    vaesenc xmm7, xmm7, xmm9
    vaesdeclast xmm6, xmm6, xmm8
    vaesenc xmm6, xmm6, xmm8
    vaesimc xmm10, xmm10
    vaesdeclast xmm10, xmm10, xmm8
    vaesimc xmm11, xmm11
    vaesdeclast xmm11, xmm11, xmm8
    vaesimc xmm12, xmm12
    vaesdeclast xmm12, xmm12, xmm8
    vaesimc xmm13, xmm13
    vaesdeclast xmm13, xmm13, xmm8
    vmovdqu xmm14, XMMWORD PTR [rdx]
    vmovdqu xmm15, XMMWORD PTR [rdx + 16]
    vpxor xmm9, xmm14, xmm10
    vaesenclast xmm0, xmm0, xmm9
    vpxor xmm9, xmm15, xmm10
    vaesenclast xmm1, xmm1, xmm9
    vpxor xmm9, xmm14, xmm11
    vaesenclast xmm2, xmm2, xmm9
    vpxor xmm9, xmm15, xmm11
    vaesenclast xmm3, xmm3, xmm9
    vpxor xmm9, xmm14, xmm12
    vaesenclast xmm4, xmm4, xmm9
    vpxor xmm9, xmm15, xmm12
    vaesenclast xmm5, xmm5, xmm9
    vpxor xmm9, xmm14, xmm13
    vaesenclast xmm6, xmm6, xmm9
    vpxor xmm9, xmm15, xmm13
    vaesenclast xmm7, xmm7, xmm9
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 184
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    ret
areion_asura_decrypt_4blocks_rk_vex_asm ENDP

PUBLIC areion_asura_decrypt_4blocks_rk_vaes256_asm
ALIGN 16
areion_asura_decrypt_4blocks_rk_vaes256_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 120
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
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
    vmovdqu ymm6, YMMWORD PTR [rsi]
    vmovdqu ymm7, YMMWORD PTR [rsi + 32]
    vperm2i128 ymm0, ymm6, ymm7, 32
    vperm2i128 ymm1, ymm6, ymm7, 49
    vmovdqu ymm6, YMMWORD PTR [rsi + 64]
    vmovdqu ymm7, YMMWORD PTR [rsi + 96]
    vperm2i128 ymm2, ymm6, ymm7, 32
    vperm2i128 ymm3, ymm6, ymm7, 49
    vpxor ymm4, ymm4, ymm4
    vmovdqu ymm8, YMMWORD PTR [rcx]
    vmovdqu ymm9, YMMWORD PTR [rcx + 32]
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vaesenc ymm8, ymm8, ymm4
    vaesenc ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 384]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 400]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vpxor ymm0, ymm0, ymm10
    vpxor ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vpxor ymm2, ymm2, ymm10
    vpxor ymm3, ymm3, ymm11
    vaesenclast ymm8, ymm8, ymm4
    vaesdec ymm8, ymm8, ymm4
    vaesdeclast ymm8, ymm8, ymm4
    vaesenclast ymm9, ymm9, ymm4
    vaesdec ymm9, ymm9, ymm4
    vaesdeclast ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 352]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 368]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesdeclast ymm11, ymm11, ymm4
    vaesenc ymm11, ymm11, ymm4
    vaesenclast ymm0, ymm0, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesdeclast ymm0, ymm0, ymm10
    vaesdeclast ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesdeclast ymm11, ymm11, ymm4
    vaesenc ymm11, ymm11, ymm4
    vaesenclast ymm2, ymm2, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdeclast ymm2, ymm2, ymm10
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm11
    vaesdeclast ymm0, ymm0, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm8, ymm8, ymm4
    vaesdec ymm8, ymm8, ymm4
    vaesdeclast ymm8, ymm8, ymm4
    vaesenclast ymm9, ymm9, ymm4
    vaesdec ymm9, ymm9, ymm4
    vaesdeclast ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 320]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 336]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesenclast ymm0, ymm0, ymm10
    vaesenclast ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesenclast ymm2, ymm2, ymm10
    vaesenclast ymm3, ymm3, ymm11
    vpunpcklbw ymm10, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vmovdqa ymm0, ymm10
    vpunpcklbw ymm10, ymm2, ymm3
    vpunpckhbw ymm3, ymm2, ymm3
    vmovdqa ymm2, ymm10
    vaesenclast ymm8, ymm8, ymm4
    vaesdec ymm8, ymm8, ymm4
    vaesdeclast ymm8, ymm8, ymm4
    vaesenclast ymm9, ymm9, ymm4
    vaesdec ymm9, ymm9, ymm4
    vaesdeclast ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 288]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 304]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesdeclast ymm11, ymm11, ymm4
    vaesenc ymm11, ymm11, ymm4
    vaesenclast ymm0, ymm0, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesdeclast ymm0, ymm0, ymm10
    vaesdeclast ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesdeclast ymm11, ymm11, ymm4
    vaesenc ymm11, ymm11, ymm4
    vaesenclast ymm2, ymm2, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdeclast ymm2, ymm2, ymm10
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm11
    vaesdeclast ymm0, ymm0, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm8, ymm8, ymm4
    vaesdec ymm8, ymm8, ymm4
    vaesdeclast ymm8, ymm8, ymm4
    vaesenclast ymm9, ymm9, ymm4
    vaesdec ymm9, ymm9, ymm4
    vaesdeclast ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 256]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 272]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesenclast ymm0, ymm0, ymm10
    vaesenclast ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesenclast ymm2, ymm2, ymm10
    vaesenclast ymm3, ymm3, ymm11
    vpunpcklbw ymm10, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vmovdqa ymm0, ymm10
    vpunpcklbw ymm10, ymm2, ymm3
    vpunpckhbw ymm3, ymm2, ymm3
    vmovdqa ymm2, ymm10
    vaesenclast ymm8, ymm8, ymm4
    vaesdec ymm8, ymm8, ymm4
    vaesdeclast ymm8, ymm8, ymm4
    vaesenclast ymm9, ymm9, ymm4
    vaesdec ymm9, ymm9, ymm4
    vaesdeclast ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 224]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 240]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesdeclast ymm11, ymm11, ymm4
    vaesenc ymm11, ymm11, ymm4
    vaesenclast ymm0, ymm0, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesdeclast ymm0, ymm0, ymm10
    vaesdeclast ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesdeclast ymm11, ymm11, ymm4
    vaesenc ymm11, ymm11, ymm4
    vaesenclast ymm2, ymm2, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdeclast ymm2, ymm2, ymm10
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm11
    vaesdeclast ymm0, ymm0, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm8, ymm8, ymm4
    vaesdec ymm8, ymm8, ymm4
    vaesdeclast ymm8, ymm8, ymm4
    vaesenclast ymm9, ymm9, ymm4
    vaesdec ymm9, ymm9, ymm4
    vaesdeclast ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 192]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 208]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesenclast ymm0, ymm0, ymm10
    vaesenclast ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesenclast ymm2, ymm2, ymm10
    vaesenclast ymm3, ymm3, ymm11
    vpunpcklbw ymm10, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vmovdqa ymm0, ymm10
    vpunpcklbw ymm10, ymm2, ymm3
    vpunpckhbw ymm3, ymm2, ymm3
    vmovdqa ymm2, ymm10
    vaesenclast ymm8, ymm8, ymm4
    vaesdec ymm8, ymm8, ymm4
    vaesdeclast ymm8, ymm8, ymm4
    vaesenclast ymm9, ymm9, ymm4
    vaesdec ymm9, ymm9, ymm4
    vaesdeclast ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 160]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 176]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesdeclast ymm11, ymm11, ymm4
    vaesenc ymm11, ymm11, ymm4
    vaesenclast ymm0, ymm0, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesdeclast ymm0, ymm0, ymm10
    vaesdeclast ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesdeclast ymm11, ymm11, ymm4
    vaesenc ymm11, ymm11, ymm4
    vaesenclast ymm2, ymm2, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdeclast ymm2, ymm2, ymm10
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm11
    vaesdeclast ymm0, ymm0, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm8, ymm8, ymm4
    vaesdec ymm8, ymm8, ymm4
    vaesdeclast ymm8, ymm8, ymm4
    vaesenclast ymm9, ymm9, ymm4
    vaesdec ymm9, ymm9, ymm4
    vaesdeclast ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 128]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 144]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesenclast ymm0, ymm0, ymm10
    vaesenclast ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesenclast ymm2, ymm2, ymm10
    vaesenclast ymm3, ymm3, ymm11
    vpunpcklbw ymm10, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vmovdqa ymm0, ymm10
    vpunpcklbw ymm10, ymm2, ymm3
    vpunpckhbw ymm3, ymm2, ymm3
    vmovdqa ymm2, ymm10
    vaesenclast ymm8, ymm8, ymm4
    vaesdec ymm8, ymm8, ymm4
    vaesdeclast ymm8, ymm8, ymm4
    vaesenclast ymm9, ymm9, ymm4
    vaesdec ymm9, ymm9, ymm4
    vaesdeclast ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 96]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 112]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesdeclast ymm11, ymm11, ymm4
    vaesenc ymm11, ymm11, ymm4
    vaesenclast ymm0, ymm0, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesdeclast ymm0, ymm0, ymm10
    vaesdeclast ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesdeclast ymm11, ymm11, ymm4
    vaesenc ymm11, ymm11, ymm4
    vaesenclast ymm2, ymm2, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdeclast ymm2, ymm2, ymm10
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm11
    vaesdeclast ymm0, ymm0, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm8, ymm8, ymm4
    vaesdec ymm8, ymm8, ymm4
    vaesdeclast ymm8, ymm8, ymm4
    vaesenclast ymm9, ymm9, ymm4
    vaesdec ymm9, ymm9, ymm4
    vaesdeclast ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 64]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 80]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesenclast ymm0, ymm0, ymm10
    vaesenclast ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesenclast ymm2, ymm2, ymm10
    vaesenclast ymm3, ymm3, ymm11
    vpunpcklbw ymm10, ymm0, ymm1
    vpunpckhbw ymm1, ymm0, ymm1
    vmovdqa ymm0, ymm10
    vpunpcklbw ymm10, ymm2, ymm3
    vpunpckhbw ymm3, ymm2, ymm3
    vmovdqa ymm2, ymm10
    vaesenclast ymm8, ymm8, ymm4
    vaesdec ymm8, ymm8, ymm4
    vaesdeclast ymm8, ymm8, ymm4
    vaesenclast ymm9, ymm9, ymm4
    vaesdec ymm9, ymm9, ymm4
    vaesdeclast ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx + 32]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 48]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesdeclast ymm11, ymm11, ymm4
    vaesenc ymm11, ymm11, ymm4
    vaesenclast ymm0, ymm0, ymm4
    vaesdec ymm0, ymm0, ymm4
    vaesdeclast ymm0, ymm0, ymm10
    vaesdeclast ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm4
    vaesenc ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesdeclast ymm11, ymm11, ymm4
    vaesenc ymm11, ymm11, ymm4
    vaesenclast ymm2, ymm2, ymm4
    vaesdec ymm2, ymm2, ymm4
    vaesdeclast ymm2, ymm2, ymm10
    vaesdeclast ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm4
    vaesenc ymm3, ymm3, ymm11
    vaesdeclast ymm0, ymm0, ymm4
    vaesenc ymm0, ymm0, ymm4
    vaesdeclast ymm2, ymm2, ymm4
    vaesenc ymm2, ymm2, ymm4
    vaesenclast ymm8, ymm8, ymm4
    vaesdec ymm8, ymm8, ymm4
    vaesdeclast ymm8, ymm8, ymm4
    vaesenclast ymm9, ymm9, ymm4
    vaesdec ymm9, ymm9, ymm4
    vaesdeclast ymm9, ymm9, ymm4
    vbroadcasti128 ymm6, XMMWORD PTR [rdx]
    vbroadcasti128 ymm7, XMMWORD PTR [rdx + 16]
    vpxor ymm10, ymm6, ymm8
    vpxor ymm11, ymm7, ymm8
    vaesenclast ymm0, ymm0, ymm10
    vaesenclast ymm1, ymm1, ymm11
    vpxor ymm10, ymm6, ymm9
    vpxor ymm11, ymm7, ymm9
    vaesenclast ymm2, ymm2, ymm10
    vaesenclast ymm3, ymm3, ymm11
    vperm2i128 ymm6, ymm0, ymm1, 32
    vperm2i128 ymm7, ymm0, ymm1, 49
    vmovdqu YMMWORD PTR [rdi], ymm6
    vmovdqu YMMWORD PTR [rdi + 32], ymm7
    vperm2i128 ymm6, ymm2, ymm3, 32
    vperm2i128 ymm7, ymm2, ymm3, 49
    vmovdqu YMMWORD PTR [rdi + 64], ymm6
    vmovdqu YMMWORD PTR [rdi + 96], ymm7
    vpxor ymm0, ymm0, ymm0
    vpxor ymm1, ymm1, ymm1
    vpxor ymm2, ymm2, ymm2
    vpxor ymm3, ymm3, ymm3
    vpxor ymm4, ymm4, ymm4
    vpxor ymm5, ymm5, ymm5
    vpxor ymm6, ymm6, ymm6
    vpxor ymm7, ymm7, ymm7
    vpxor ymm8, ymm8, ymm8
    vpxor ymm9, ymm9, ymm9
    vpxor ymm10, ymm10, ymm10
    vpxor ymm11, ymm11, ymm11
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
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 120
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    vzeroupper
    ret
areion_asura_decrypt_4blocks_rk_vaes256_asm ENDP

PUBLIC areion_asura_decrypt_4blocks_rk_vaes512_asm
ALIGN 16
areion_asura_decrypt_4blocks_rk_vaes512_asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 56
    mov QWORD PTR [rsp + 0], rdi
    mov QWORD PTR [rsp + 8], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    mov rdi, rcx
    mov rsi, rdx
    mov rdx, r8
    mov rcx, r9
    vmovdqu64 zmm6, ZMMWORD PTR [rsi]
    vmovdqu64 zmm7, ZMMWORD PTR [rsi + 64]
    vshufi64x2 zmm0, zmm6, zmm7, 136
    vshufi64x2 zmm1, zmm6, zmm7, 221
    vpxorq zmm2, zmm2, zmm2
    vmovdqu64 zmm16, ZMMWORD PTR [rcx]
    vaesenc zmm17, zmm16, zmm2
    vaesenc zmm18, zmm17, zmm2
    vaesenc zmm19, zmm18, zmm2
    vaesenc zmm20, zmm19, zmm2
    vaesenc zmm21, zmm20, zmm2
    vaesenc zmm22, zmm21, zmm2
    vaesenc zmm23, zmm22, zmm2
    vaesenc zmm24, zmm23, zmm2
    vaesenc zmm25, zmm24, zmm2
    vaesenc zmm26, zmm25, zmm2
    vaesenc zmm27, zmm26, zmm2
    vaesenc zmm28, zmm27, zmm2
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 384]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 400]
    vpxorq zmm4, zmm4, zmm28
    vpxorq zmm5, zmm5, zmm28
    vpxorq zmm0, zmm0, zmm4
    vpxorq zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 352]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 368]
    vpxorq zmm4, zmm4, zmm27
    vpxorq zmm5, zmm5, zmm27
    vaesdeclast zmm5, zmm5, zmm2
    vaesenclast zmm0, zmm0, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesenc zmm5, zmm5, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm4
    vaesenc zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 320]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 336]
    vpxorq zmm4, zmm4, zmm26
    vpxorq zmm5, zmm5, zmm26
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm4
    vaesenclast zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 288]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 304]
    vpxorq zmm4, zmm4, zmm25
    vpxorq zmm5, zmm5, zmm25
    vaesdeclast zmm5, zmm5, zmm2
    vpunpcklbw zmm6, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm6, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesenc zmm5, zmm5, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm4
    vaesenc zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 256]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 272]
    vpxorq zmm4, zmm4, zmm24
    vpxorq zmm5, zmm5, zmm24
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm4
    vaesenclast zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 224]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 240]
    vpxorq zmm4, zmm4, zmm23
    vpxorq zmm5, zmm5, zmm23
    vaesdeclast zmm5, zmm5, zmm2
    vpunpcklbw zmm6, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm6, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesenc zmm5, zmm5, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm4
    vaesenc zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 192]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 208]
    vpxorq zmm4, zmm4, zmm22
    vpxorq zmm5, zmm5, zmm22
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm4
    vaesenclast zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 160]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 176]
    vpxorq zmm4, zmm4, zmm21
    vpxorq zmm5, zmm5, zmm21
    vaesdeclast zmm5, zmm5, zmm2
    vpunpcklbw zmm6, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm6, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesenc zmm5, zmm5, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm4
    vaesenc zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 128]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 144]
    vpxorq zmm4, zmm4, zmm20
    vpxorq zmm5, zmm5, zmm20
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm4
    vaesenclast zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 96]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 112]
    vpxorq zmm4, zmm4, zmm19
    vpxorq zmm5, zmm5, zmm19
    vaesdeclast zmm5, zmm5, zmm2
    vpunpcklbw zmm6, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm6, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesenc zmm5, zmm5, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm4
    vaesenc zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 64]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 80]
    vpxorq zmm4, zmm4, zmm18
    vpxorq zmm5, zmm5, zmm18
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm4
    vaesenclast zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx + 32]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 48]
    vpxorq zmm4, zmm4, zmm17
    vpxorq zmm5, zmm5, zmm17
    vaesdeclast zmm5, zmm5, zmm2
    vpunpcklbw zmm6, zmm0, zmm1
    vpunpckhbw zmm1, zmm0, zmm1
    vaesenclast zmm0, zmm6, zmm2
    vaesdeclast zmm1, zmm1, zmm2
    vaesenc zmm5, zmm5, zmm2
    vaesdec zmm0, zmm0, zmm2
    vaesenc zmm1, zmm1, zmm2
    vaesdeclast zmm0, zmm0, zmm4
    vaesenc zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm4, XMMWORD PTR [rdx]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rdx + 16]
    vpxorq zmm4, zmm4, zmm16
    vpxorq zmm5, zmm5, zmm16
    vaesdeclast zmm0, zmm0, zmm2
    vaesenc zmm0, zmm0, zmm2
    vaesenclast zmm0, zmm0, zmm4
    vaesenclast zmm1, zmm1, zmm5
    vshufi64x2 zmm6, zmm0, zmm1, 68
    vshufi64x2 zmm6, zmm6, zmm6, 216
    vshufi64x2 zmm7, zmm0, zmm1, 238
    vshufi64x2 zmm7, zmm7, zmm7, 216
    vmovdqu64 ZMMWORD PTR [rdi], zmm6
    vmovdqu64 ZMMWORD PTR [rdi + 64], zmm7
    vpxorq zmm0, zmm0, zmm0
    vpxorq zmm1, zmm1, zmm1
    vpxorq zmm2, zmm2, zmm2
    vpxorq zmm4, zmm4, zmm4
    vpxorq zmm5, zmm5, zmm5
    vpxorq zmm6, zmm6, zmm6
    vpxorq zmm7, zmm7, zmm7
    vpxorq zmm16, zmm16, zmm16
    vpxorq zmm17, zmm17, zmm17
    vpxorq zmm18, zmm18, zmm18
    vpxorq zmm19, zmm19, zmm19
    vpxorq zmm20, zmm20, zmm20
    vpxorq zmm21, zmm21, zmm21
    vpxorq zmm22, zmm22, zmm22
    vpxorq zmm23, zmm23, zmm23
    vpxorq zmm24, zmm24, zmm24
    vpxorq zmm25, zmm25, zmm25
    vpxorq zmm26, zmm26, zmm26
    vpxorq zmm27, zmm27, zmm27
    vpxorq zmm28, zmm28, zmm28
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    mov rdi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rsi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 56
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    vzeroupper
    ret
areion_asura_decrypt_4blocks_rk_vaes512_asm ENDP

END
