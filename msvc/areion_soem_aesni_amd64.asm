; Copyright (c) 2026 Andrey Kuvshinov
; SPDX-License-Identifier: Apache-2.0 OR MIT

EXTERN roundConstantsP1:BYTE
EXTERN roundConstantsP2:BYTE
EXTERN areionRC4x:BYTE
EXTERN areionRC4x2:BYTE

.code

PUBLIC areion256Permutex4AesNiRC
ALIGN 16
areion256Permutex4AesNiRC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 136
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm10
    movdqu XMMWORD PTR [rsp + 80], xmm11
    movdqu XMMWORD PTR [rsp + 96], xmm12
    movdqu XMMWORD PTR [rsp + 112], xmm13
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    pxor xmm12, xmm12
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [r10]
    movdqu xmm2, XMMWORD PTR [rax + 16]
    movdqu xmm3, XMMWORD PTR [r10 + 16]
    movdqu xmm4, XMMWORD PTR [rax + 32]
    movdqu xmm5, XMMWORD PTR [r10 + 32]
    movdqu xmm6, XMMWORD PTR [rax + 48]
    movdqu xmm7, XMMWORD PTR [r10 + 48]
    movdqu xmm13, XMMWORD PTR [rcx]
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm12
    aesenclast xmm2, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm6, xmm12
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 64]
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm12
    aesenclast xmm3, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm7, xmm12
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 128]
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm12
    aesenclast xmm2, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm6, xmm12
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 192]
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm12
    aesenclast xmm3, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm7, xmm12
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 256]
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm12
    aesenclast xmm2, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm6, xmm12
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 320]
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm12
    aesenclast xmm3, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm7, xmm12
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 384]
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm12
    aesenclast xmm2, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm6, xmm12
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 448]
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm12
    aesenclast xmm3, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm7, xmm12
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 512]
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm12
    aesenclast xmm2, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm6, xmm12
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 576]
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm12
    aesenclast xmm3, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm7, xmm12
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu XMMWORD PTR [rax], xmm0
    movdqu XMMWORD PTR [r10], xmm1
    movdqu XMMWORD PTR [rax + 16], xmm2
    movdqu XMMWORD PTR [r10 + 16], xmm3
    movdqu XMMWORD PTR [rax + 32], xmm4
    movdqu XMMWORD PTR [r10 + 32], xmm5
    movdqu XMMWORD PTR [rax + 48], xmm6
    movdqu XMMWORD PTR [r10 + 48], xmm7
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
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    movdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm12, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm13, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    add rsp, 136
    ret
areion256Permutex4AesNiRC ENDP

PUBLIC areion256Permutex4VexRC
ALIGN 16
areion256Permutex4VexRC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 136
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm8
    vmovdqu XMMWORD PTR [rsp + 48], xmm9
    vmovdqu XMMWORD PTR [rsp + 64], xmm10
    vmovdqu XMMWORD PTR [rsp + 80], xmm11
    vmovdqu XMMWORD PTR [rsp + 96], xmm12
    vmovdqu XMMWORD PTR [rsp + 112], xmm13
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    vpxor xmm12, xmm12, xmm12
    vmovdqu xmm0, XMMWORD PTR [rax]
    vmovdqu xmm1, XMMWORD PTR [r10]
    vmovdqu xmm2, XMMWORD PTR [rax + 16]
    vmovdqu xmm3, XMMWORD PTR [r10 + 16]
    vmovdqu xmm4, XMMWORD PTR [rax + 32]
    vmovdqu xmm5, XMMWORD PTR [r10 + 32]
    vmovdqu xmm6, XMMWORD PTR [rax + 48]
    vmovdqu xmm7, XMMWORD PTR [r10 + 48]
    vmovdqu xmm13, XMMWORD PTR [rcx]
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [rcx + 64]
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [rcx + 128]
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [rcx + 192]
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [rcx + 256]
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [rcx + 320]
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [rcx + 384]
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [rcx + 448]
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [rcx + 512]
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [rcx + 576]
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu XMMWORD PTR [rax], xmm0
    vmovdqu XMMWORD PTR [r10], xmm1
    vmovdqu XMMWORD PTR [rax + 16], xmm2
    vmovdqu XMMWORD PTR [r10 + 16], xmm3
    vmovdqu XMMWORD PTR [rax + 32], xmm4
    vmovdqu XMMWORD PTR [r10 + 32], xmm5
    vmovdqu XMMWORD PTR [rax + 48], xmm6
    vmovdqu XMMWORD PTR [r10 + 48], xmm7
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
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    add rsp, 136
    ret
areion256Permutex4VexRC ENDP

PUBLIC areion256InversePermutex4AesNiRC
ALIGN 16
areion256InversePermutex4AesNiRC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 136
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm10
    movdqu XMMWORD PTR [rsp + 80], xmm11
    movdqu XMMWORD PTR [rsp + 96], xmm12
    movdqu XMMWORD PTR [rsp + 112], xmm13
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    pxor xmm12, xmm12
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [r10]
    movdqu xmm2, XMMWORD PTR [rax + 16]
    movdqu xmm3, XMMWORD PTR [r10 + 16]
    movdqu xmm4, XMMWORD PTR [rax + 32]
    movdqu xmm5, XMMWORD PTR [r10 + 32]
    movdqu xmm6, XMMWORD PTR [rax + 48]
    movdqu xmm7, XMMWORD PTR [r10 + 48]
    movdqu xmm13, XMMWORD PTR [rcx + 576]
    aesdeclast xmm1, xmm12
    aesdeclast xmm3, xmm12
    aesdeclast xmm5, xmm12
    aesdeclast xmm7, xmm12
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 512]
    aesdeclast xmm0, xmm12
    aesdeclast xmm2, xmm12
    aesdeclast xmm4, xmm12
    aesdeclast xmm6, xmm12
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 448]
    aesdeclast xmm1, xmm12
    aesdeclast xmm3, xmm12
    aesdeclast xmm5, xmm12
    aesdeclast xmm7, xmm12
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 384]
    aesdeclast xmm0, xmm12
    aesdeclast xmm2, xmm12
    aesdeclast xmm4, xmm12
    aesdeclast xmm6, xmm12
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 320]
    aesdeclast xmm1, xmm12
    aesdeclast xmm3, xmm12
    aesdeclast xmm5, xmm12
    aesdeclast xmm7, xmm12
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 256]
    aesdeclast xmm0, xmm12
    aesdeclast xmm2, xmm12
    aesdeclast xmm4, xmm12
    aesdeclast xmm6, xmm12
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 192]
    aesdeclast xmm1, xmm12
    aesdeclast xmm3, xmm12
    aesdeclast xmm5, xmm12
    aesdeclast xmm7, xmm12
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 128]
    aesdeclast xmm0, xmm12
    aesdeclast xmm2, xmm12
    aesdeclast xmm4, xmm12
    aesdeclast xmm6, xmm12
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [rcx + 64]
    aesdeclast xmm1, xmm12
    aesdeclast xmm3, xmm12
    aesdeclast xmm5, xmm12
    aesdeclast xmm7, xmm12
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [rcx]
    aesdeclast xmm0, xmm12
    aesdeclast xmm2, xmm12
    aesdeclast xmm4, xmm12
    aesdeclast xmm6, xmm12
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu XMMWORD PTR [rax], xmm0
    movdqu XMMWORD PTR [r10], xmm1
    movdqu XMMWORD PTR [rax + 16], xmm2
    movdqu XMMWORD PTR [r10 + 16], xmm3
    movdqu XMMWORD PTR [rax + 32], xmm4
    movdqu XMMWORD PTR [r10 + 32], xmm5
    movdqu XMMWORD PTR [rax + 48], xmm6
    movdqu XMMWORD PTR [r10 + 48], xmm7
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
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    movdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm12, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm13, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    add rsp, 136
    ret
areion256InversePermutex4AesNiRC ENDP

PUBLIC areion256InversePermutex4VexRC
ALIGN 16
areion256InversePermutex4VexRC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 136
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm8
    vmovdqu XMMWORD PTR [rsp + 48], xmm9
    vmovdqu XMMWORD PTR [rsp + 64], xmm10
    vmovdqu XMMWORD PTR [rsp + 80], xmm11
    vmovdqu XMMWORD PTR [rsp + 96], xmm12
    vmovdqu XMMWORD PTR [rsp + 112], xmm13
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    vpxor xmm12, xmm12, xmm12
    vmovdqu xmm0, XMMWORD PTR [rax]
    vmovdqu xmm1, XMMWORD PTR [r10]
    vmovdqu xmm2, XMMWORD PTR [rax + 16]
    vmovdqu xmm3, XMMWORD PTR [r10 + 16]
    vmovdqu xmm4, XMMWORD PTR [rax + 32]
    vmovdqu xmm5, XMMWORD PTR [r10 + 32]
    vmovdqu xmm6, XMMWORD PTR [rax + 48]
    vmovdqu xmm7, XMMWORD PTR [r10 + 48]
    vmovdqu xmm13, XMMWORD PTR [rcx + 576]
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [rcx + 512]
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [rcx + 448]
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [rcx + 384]
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [rcx + 320]
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [rcx + 256]
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [rcx + 192]
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [rcx + 128]
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [rcx + 64]
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [rcx]
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu XMMWORD PTR [rax], xmm0
    vmovdqu XMMWORD PTR [r10], xmm1
    vmovdqu XMMWORD PTR [rax + 16], xmm2
    vmovdqu XMMWORD PTR [r10 + 16], xmm3
    vmovdqu XMMWORD PTR [rax + 32], xmm4
    vmovdqu XMMWORD PTR [r10 + 32], xmm5
    vmovdqu XMMWORD PTR [rax + 48], xmm6
    vmovdqu XMMWORD PTR [r10 + 48], xmm7
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
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    add rsp, 136
    ret
areion256InversePermutex4VexRC ENDP

PUBLIC areion512Permutex4AesNiRC
ALIGN 16
areion512Permutex4AesNiRC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    mov QWORD PTR [rsp + 0], rsi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    movdqu XMMWORD PTR [rsp + 64], xmm9
    movdqu XMMWORD PTR [rsp + 80], xmm10
    movdqu XMMWORD PTR [rsp + 96], xmm11
    movdqu XMMWORD PTR [rsp + 112], xmm12
    movdqu XMMWORD PTR [rsp + 128], xmm13
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    mov rdx, r9
    mov rsi, QWORD PTR [rsp + 192]
    pxor xmm12, xmm12
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [r10]
    movdqu xmm2, XMMWORD PTR [rcx]
    movdqu xmm3, XMMWORD PTR [rdx]
    movdqu xmm4, XMMWORD PTR [rax + 16]
    movdqu xmm5, XMMWORD PTR [r10 + 16]
    movdqu xmm6, XMMWORD PTR [rcx + 16]
    movdqu xmm7, XMMWORD PTR [rdx + 16]
    movdqu xmm13, XMMWORD PTR [rsi]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 64]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 128]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 192]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 256]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 320]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 384]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 448]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 512]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 576]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 640]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 704]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 768]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 832]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 896]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu XMMWORD PTR [rax], xmm3
    movdqu XMMWORD PTR [r10], xmm0
    movdqu XMMWORD PTR [rcx], xmm1
    movdqu XMMWORD PTR [rdx], xmm2
    movdqu XMMWORD PTR [rax + 16], xmm7
    movdqu XMMWORD PTR [r10 + 16], xmm4
    movdqu XMMWORD PTR [rcx + 16], xmm5
    movdqu XMMWORD PTR [rdx + 16], xmm6
    movdqu xmm0, XMMWORD PTR [rax + 32]
    movdqu xmm1, XMMWORD PTR [r10 + 32]
    movdqu xmm2, XMMWORD PTR [rcx + 32]
    movdqu xmm3, XMMWORD PTR [rdx + 32]
    movdqu xmm4, XMMWORD PTR [rax + 48]
    movdqu xmm5, XMMWORD PTR [r10 + 48]
    movdqu xmm6, XMMWORD PTR [rcx + 48]
    movdqu xmm7, XMMWORD PTR [rdx + 48]
    movdqu xmm13, XMMWORD PTR [rsi]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 64]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 128]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 192]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 256]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 320]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 384]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 448]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 512]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 576]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 640]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 704]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 768]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 832]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [rsi + 896]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu XMMWORD PTR [rax + 32], xmm3
    movdqu XMMWORD PTR [r10 + 32], xmm0
    movdqu XMMWORD PTR [rcx + 32], xmm1
    movdqu XMMWORD PTR [rdx + 32], xmm2
    movdqu XMMWORD PTR [rax + 48], xmm7
    movdqu XMMWORD PTR [r10 + 48], xmm4
    movdqu XMMWORD PTR [rcx + 48], xmm5
    movdqu XMMWORD PTR [rdx + 48], xmm6
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
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    xor rsi, rsi
    xor r11, r11
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
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    add rsp, 152
    ret
areion512Permutex4AesNiRC ENDP

PUBLIC areion512Permutex4VexRC
ALIGN 16
areion512Permutex4VexRC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    mov QWORD PTR [rsp + 0], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm12
    vmovdqu XMMWORD PTR [rsp + 64], xmm13
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    mov rdx, r9
    mov rsi, QWORD PTR [rsp + 128]
    vpxor xmm12, xmm12, xmm12
    vmovdqu xmm0, XMMWORD PTR [rax]
    vmovdqu xmm1, XMMWORD PTR [r10]
    vmovdqu xmm2, XMMWORD PTR [rcx]
    vmovdqu xmm3, XMMWORD PTR [rdx]
    vmovdqu xmm4, XMMWORD PTR [rax + 16]
    vmovdqu xmm5, XMMWORD PTR [r10 + 16]
    vmovdqu xmm6, XMMWORD PTR [rcx + 16]
    vmovdqu xmm7, XMMWORD PTR [rdx + 16]
    vmovdqu xmm13, XMMWORD PTR [rsi]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm13
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 64]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm13
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 128]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm13
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 192]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm13
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 256]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm13
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 320]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm13
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 384]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm13
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 448]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm13
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 512]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm13
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 576]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm13
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 640]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm13
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 704]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm13
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 768]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm13
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 832]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm13
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 896]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm13
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu XMMWORD PTR [rax], xmm3
    vmovdqu XMMWORD PTR [r10], xmm0
    vmovdqu XMMWORD PTR [rcx], xmm1
    vmovdqu XMMWORD PTR [rdx], xmm2
    vmovdqu XMMWORD PTR [rax + 16], xmm7
    vmovdqu XMMWORD PTR [r10 + 16], xmm4
    vmovdqu XMMWORD PTR [rcx + 16], xmm5
    vmovdqu XMMWORD PTR [rdx + 16], xmm6
    vmovdqu xmm0, XMMWORD PTR [rax + 32]
    vmovdqu xmm1, XMMWORD PTR [r10 + 32]
    vmovdqu xmm2, XMMWORD PTR [rcx + 32]
    vmovdqu xmm3, XMMWORD PTR [rdx + 32]
    vmovdqu xmm4, XMMWORD PTR [rax + 48]
    vmovdqu xmm5, XMMWORD PTR [r10 + 48]
    vmovdqu xmm6, XMMWORD PTR [rcx + 48]
    vmovdqu xmm7, XMMWORD PTR [rdx + 48]
    vmovdqu xmm13, XMMWORD PTR [rsi]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm13
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 64]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm13
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 128]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm13
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 192]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm13
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 256]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm13
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 320]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm13
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 384]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm13
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 448]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm13
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 512]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm13
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 576]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm13
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 640]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm13
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 704]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm13
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 768]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm13
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 832]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm13
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [rsi + 896]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm13
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu XMMWORD PTR [rax + 32], xmm3
    vmovdqu XMMWORD PTR [r10 + 32], xmm0
    vmovdqu XMMWORD PTR [rcx + 32], xmm1
    vmovdqu XMMWORD PTR [rdx + 32], xmm2
    vmovdqu XMMWORD PTR [rax + 48], xmm7
    vmovdqu XMMWORD PTR [r10 + 48], xmm4
    vmovdqu XMMWORD PTR [rcx + 48], xmm5
    vmovdqu XMMWORD PTR [rdx + 48], xmm6
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    xor rsi, rsi
    xor r11, r11
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    add rsp, 88
    ret
areion512Permutex4VexRC ENDP

PUBLIC areion512InversePermutex4AesNiRC
ALIGN 16
areion512InversePermutex4AesNiRC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    mov QWORD PTR [rsp + 0], rsi
    movdqu XMMWORD PTR [rsp + 16], xmm6
    movdqu XMMWORD PTR [rsp + 32], xmm7
    movdqu XMMWORD PTR [rsp + 48], xmm8
    movdqu XMMWORD PTR [rsp + 64], xmm9
    movdqu XMMWORD PTR [rsp + 80], xmm10
    movdqu XMMWORD PTR [rsp + 96], xmm11
    movdqu XMMWORD PTR [rsp + 112], xmm12
    movdqu XMMWORD PTR [rsp + 128], xmm13
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    mov rdx, r9
    mov rsi, QWORD PTR [rsp + 192]
    pxor xmm12, xmm12
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [rcx]
    movdqu xmm2, XMMWORD PTR [rdx]
    movdqu xmm3, XMMWORD PTR [rax]
    movdqu xmm4, XMMWORD PTR [r10 + 16]
    movdqu xmm5, XMMWORD PTR [rcx + 16]
    movdqu xmm6, XMMWORD PTR [rdx + 16]
    movdqu xmm7, XMMWORD PTR [rax + 16]
    movdqu xmm13, XMMWORD PTR [rsi + 896]
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm13
    aesdeclast xmm4, xmm13
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 832]
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm13
    aesdeclast xmm7, xmm13
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 768]
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesimc xmm2, xmm2
    aesimc xmm6, xmm6
    aesdeclast xmm2, xmm13
    aesdeclast xmm6, xmm13
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 704]
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    aesimc xmm1, xmm1
    aesimc xmm5, xmm5
    aesdeclast xmm1, xmm13
    aesdeclast xmm5, xmm13
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 640]
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm13
    aesdeclast xmm4, xmm13
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 576]
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm13
    aesdeclast xmm7, xmm13
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 512]
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesimc xmm2, xmm2
    aesimc xmm6, xmm6
    aesdeclast xmm2, xmm13
    aesdeclast xmm6, xmm13
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 448]
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    aesimc xmm1, xmm1
    aesimc xmm5, xmm5
    aesdeclast xmm1, xmm13
    aesdeclast xmm5, xmm13
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 384]
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm13
    aesdeclast xmm4, xmm13
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 320]
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm13
    aesdeclast xmm7, xmm13
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 256]
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesimc xmm2, xmm2
    aesimc xmm6, xmm6
    aesdeclast xmm2, xmm13
    aesdeclast xmm6, xmm13
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 192]
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    aesimc xmm1, xmm1
    aesimc xmm5, xmm5
    aesdeclast xmm1, xmm13
    aesdeclast xmm5, xmm13
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 128]
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm13
    aesdeclast xmm4, xmm13
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 64]
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm13
    aesdeclast xmm7, xmm13
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    movdqu xmm13, XMMWORD PTR [rsi]
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesimc xmm2, xmm2
    aesimc xmm6, xmm6
    aesdeclast xmm2, xmm13
    aesdeclast xmm6, xmm13
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    movdqu XMMWORD PTR [rax], xmm0
    movdqu XMMWORD PTR [r10], xmm1
    movdqu XMMWORD PTR [rcx], xmm2
    movdqu XMMWORD PTR [rdx], xmm3
    movdqu XMMWORD PTR [rax + 16], xmm4
    movdqu XMMWORD PTR [r10 + 16], xmm5
    movdqu XMMWORD PTR [rcx + 16], xmm6
    movdqu XMMWORD PTR [rdx + 16], xmm7
    movdqu xmm0, XMMWORD PTR [r10 + 32]
    movdqu xmm1, XMMWORD PTR [rcx + 32]
    movdqu xmm2, XMMWORD PTR [rdx + 32]
    movdqu xmm3, XMMWORD PTR [rax + 32]
    movdqu xmm4, XMMWORD PTR [r10 + 48]
    movdqu xmm5, XMMWORD PTR [rcx + 48]
    movdqu xmm6, XMMWORD PTR [rdx + 48]
    movdqu xmm7, XMMWORD PTR [rax + 48]
    movdqu xmm13, XMMWORD PTR [rsi + 896]
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm13
    aesdeclast xmm4, xmm13
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 832]
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm13
    aesdeclast xmm7, xmm13
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 768]
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesimc xmm2, xmm2
    aesimc xmm6, xmm6
    aesdeclast xmm2, xmm13
    aesdeclast xmm6, xmm13
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 704]
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    aesimc xmm1, xmm1
    aesimc xmm5, xmm5
    aesdeclast xmm1, xmm13
    aesdeclast xmm5, xmm13
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 640]
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm13
    aesdeclast xmm4, xmm13
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 576]
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm13
    aesdeclast xmm7, xmm13
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 512]
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesimc xmm2, xmm2
    aesimc xmm6, xmm6
    aesdeclast xmm2, xmm13
    aesdeclast xmm6, xmm13
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 448]
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    aesimc xmm1, xmm1
    aesimc xmm5, xmm5
    aesdeclast xmm1, xmm13
    aesdeclast xmm5, xmm13
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 384]
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm13
    aesdeclast xmm4, xmm13
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 320]
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm13
    aesdeclast xmm7, xmm13
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 256]
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesimc xmm2, xmm2
    aesimc xmm6, xmm6
    aesdeclast xmm2, xmm13
    aesdeclast xmm6, xmm13
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 192]
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    aesimc xmm1, xmm1
    aesimc xmm5, xmm5
    aesdeclast xmm1, xmm13
    aesdeclast xmm5, xmm13
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 128]
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm13
    aesdeclast xmm4, xmm13
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    movdqu xmm13, XMMWORD PTR [rsi + 64]
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm13
    aesdeclast xmm7, xmm13
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    movdqu xmm13, XMMWORD PTR [rsi]
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesimc xmm2, xmm2
    aesimc xmm6, xmm6
    aesdeclast xmm2, xmm13
    aesdeclast xmm6, xmm13
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    movdqu XMMWORD PTR [rax + 32], xmm0
    movdqu XMMWORD PTR [r10 + 32], xmm1
    movdqu XMMWORD PTR [rcx + 32], xmm2
    movdqu XMMWORD PTR [rdx + 32], xmm3
    movdqu XMMWORD PTR [rax + 48], xmm4
    movdqu XMMWORD PTR [r10 + 48], xmm5
    movdqu XMMWORD PTR [rcx + 48], xmm6
    movdqu XMMWORD PTR [rdx + 48], xmm7
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
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    xor rsi, rsi
    xor r11, r11
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
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    add rsp, 152
    ret
areion512InversePermutex4AesNiRC ENDP

PUBLIC areion512InversePermutex4VexRC
ALIGN 16
areion512InversePermutex4VexRC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    mov QWORD PTR [rsp + 0], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm12
    vmovdqu XMMWORD PTR [rsp + 64], xmm13
    mov rax, rcx
    mov r10, rdx
    mov rdx, r8
    mov rsi, r9
    mov rcx, QWORD PTR [rsp + 128]
    vpxor xmm12, xmm12, xmm12
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [rdx]
    vmovdqu xmm2, XMMWORD PTR [rsi]
    vmovdqu xmm3, XMMWORD PTR [rax]
    vmovdqu xmm4, XMMWORD PTR [r10 + 16]
    vmovdqu xmm5, XMMWORD PTR [rdx + 16]
    vmovdqu xmm6, XMMWORD PTR [rsi + 16]
    vmovdqu xmm7, XMMWORD PTR [rax + 16]
    vmovdqu xmm13, XMMWORD PTR [rcx + 896]
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm4, xmm4, xmm13
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm13, XMMWORD PTR [rcx + 832]
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm13
    vaesdeclast xmm7, xmm7, xmm13
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu xmm13, XMMWORD PTR [rcx + 768]
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesimc xmm2, xmm2
    vaesimc xmm6, xmm6
    vaesdeclast xmm2, xmm2, xmm13
    vaesdeclast xmm6, xmm6, xmm13
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vmovdqu xmm13, XMMWORD PTR [rcx + 704]
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesdeclast xmm1, xmm1, xmm13
    vaesdeclast xmm5, xmm5, xmm13
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vmovdqu xmm13, XMMWORD PTR [rcx + 640]
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm4, xmm4, xmm13
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm13, XMMWORD PTR [rcx + 576]
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm13
    vaesdeclast xmm7, xmm7, xmm13
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu xmm13, XMMWORD PTR [rcx + 512]
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesimc xmm2, xmm2
    vaesimc xmm6, xmm6
    vaesdeclast xmm2, xmm2, xmm13
    vaesdeclast xmm6, xmm6, xmm13
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vmovdqu xmm13, XMMWORD PTR [rcx + 448]
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesdeclast xmm1, xmm1, xmm13
    vaesdeclast xmm5, xmm5, xmm13
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vmovdqu xmm13, XMMWORD PTR [rcx + 384]
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm4, xmm4, xmm13
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm13, XMMWORD PTR [rcx + 320]
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm13
    vaesdeclast xmm7, xmm7, xmm13
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu xmm13, XMMWORD PTR [rcx + 256]
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesimc xmm2, xmm2
    vaesimc xmm6, xmm6
    vaesdeclast xmm2, xmm2, xmm13
    vaesdeclast xmm6, xmm6, xmm13
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vmovdqu xmm13, XMMWORD PTR [rcx + 192]
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesdeclast xmm1, xmm1, xmm13
    vaesdeclast xmm5, xmm5, xmm13
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vmovdqu xmm13, XMMWORD PTR [rcx + 128]
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm4, xmm4, xmm13
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm13, XMMWORD PTR [rcx + 64]
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm13
    vaesdeclast xmm7, xmm7, xmm13
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu xmm13, XMMWORD PTR [rcx]
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesimc xmm2, xmm2
    vaesimc xmm6, xmm6
    vaesdeclast xmm2, xmm2, xmm13
    vaesdeclast xmm6, xmm6, xmm13
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vmovdqu XMMWORD PTR [rax], xmm0
    vmovdqu XMMWORD PTR [r10], xmm1
    vmovdqu XMMWORD PTR [rdx], xmm2
    vmovdqu XMMWORD PTR [rsi], xmm3
    vmovdqu XMMWORD PTR [rax + 16], xmm4
    vmovdqu XMMWORD PTR [r10 + 16], xmm5
    vmovdqu XMMWORD PTR [rdx + 16], xmm6
    vmovdqu XMMWORD PTR [rsi + 16], xmm7
    vmovdqu xmm0, XMMWORD PTR [r10 + 32]
    vmovdqu xmm1, XMMWORD PTR [rdx + 32]
    vmovdqu xmm2, XMMWORD PTR [rsi + 32]
    vmovdqu xmm3, XMMWORD PTR [rax + 32]
    vmovdqu xmm4, XMMWORD PTR [r10 + 48]
    vmovdqu xmm5, XMMWORD PTR [rdx + 48]
    vmovdqu xmm6, XMMWORD PTR [rsi + 48]
    vmovdqu xmm7, XMMWORD PTR [rax + 48]
    vmovdqu xmm13, XMMWORD PTR [rcx + 896]
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm4, xmm4, xmm13
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm13, XMMWORD PTR [rcx + 832]
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm13
    vaesdeclast xmm7, xmm7, xmm13
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu xmm13, XMMWORD PTR [rcx + 768]
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesimc xmm2, xmm2
    vaesimc xmm6, xmm6
    vaesdeclast xmm2, xmm2, xmm13
    vaesdeclast xmm6, xmm6, xmm13
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vmovdqu xmm13, XMMWORD PTR [rcx + 704]
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesdeclast xmm1, xmm1, xmm13
    vaesdeclast xmm5, xmm5, xmm13
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vmovdqu xmm13, XMMWORD PTR [rcx + 640]
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm4, xmm4, xmm13
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm13, XMMWORD PTR [rcx + 576]
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm13
    vaesdeclast xmm7, xmm7, xmm13
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu xmm13, XMMWORD PTR [rcx + 512]
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesimc xmm2, xmm2
    vaesimc xmm6, xmm6
    vaesdeclast xmm2, xmm2, xmm13
    vaesdeclast xmm6, xmm6, xmm13
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vmovdqu xmm13, XMMWORD PTR [rcx + 448]
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesdeclast xmm1, xmm1, xmm13
    vaesdeclast xmm5, xmm5, xmm13
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vmovdqu xmm13, XMMWORD PTR [rcx + 384]
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm4, xmm4, xmm13
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm13, XMMWORD PTR [rcx + 320]
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm13
    vaesdeclast xmm7, xmm7, xmm13
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu xmm13, XMMWORD PTR [rcx + 256]
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesimc xmm2, xmm2
    vaesimc xmm6, xmm6
    vaesdeclast xmm2, xmm2, xmm13
    vaesdeclast xmm6, xmm6, xmm13
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vmovdqu xmm13, XMMWORD PTR [rcx + 192]
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesdeclast xmm1, xmm1, xmm13
    vaesdeclast xmm5, xmm5, xmm13
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vmovdqu xmm13, XMMWORD PTR [rcx + 128]
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm13
    vaesdeclast xmm4, xmm4, xmm13
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm13, XMMWORD PTR [rcx + 64]
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm13
    vaesdeclast xmm7, xmm7, xmm13
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu xmm13, XMMWORD PTR [rcx]
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesimc xmm2, xmm2
    vaesimc xmm6, xmm6
    vaesdeclast xmm2, xmm2, xmm13
    vaesdeclast xmm6, xmm6, xmm13
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vmovdqu XMMWORD PTR [rax + 32], xmm0
    vmovdqu XMMWORD PTR [r10 + 32], xmm1
    vmovdqu XMMWORD PTR [rdx + 32], xmm2
    vmovdqu XMMWORD PTR [rsi + 32], xmm3
    vmovdqu XMMWORD PTR [rax + 48], xmm4
    vmovdqu XMMWORD PTR [r10 + 48], xmm5
    vmovdqu XMMWORD PTR [rdx + 48], xmm6
    vmovdqu XMMWORD PTR [rsi + 48], xmm7
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    xor rsi, rsi
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    add rsp, 88
    ret
areion512InversePermutex4VexRC ENDP

PUBLIC areion256SoEMPermutex4AesNi
ALIGN 16
areion256SoEMPermutex4AesNi PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm10
    movdqu XMMWORD PTR [rsp + 80], xmm11
    movdqu XMMWORD PTR [rsp + 96], xmm12
    movdqu XMMWORD PTR [rsp + 112], xmm13
    movdqu XMMWORD PTR [rsp + 128], xmm14
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    mov rdx, r9
    pxor xmm12, xmm12
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [r10]
    movdqu xmm2, XMMWORD PTR [rax + 16]
    movdqu xmm3, XMMWORD PTR [r10 + 16]
    movdqu xmm4, XMMWORD PTR [rcx]
    movdqu xmm5, XMMWORD PTR [rdx]
    movdqu xmm6, XMMWORD PTR [rcx + 16]
    movdqu xmm7, XMMWORD PTR [rdx + 16]
    movdqu xmm13, XMMWORD PTR [areionRC4x]
    movdqu xmm14, XMMWORD PTR [areionRC4x2]
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm12
    aesenclast xmm2, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm6, xmm12
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 64]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 64]
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm12
    aesenclast xmm3, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm7, xmm12
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 128]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 128]
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm12
    aesenclast xmm2, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm6, xmm12
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 192]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 192]
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm12
    aesenclast xmm3, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm7, xmm12
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 256]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 256]
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm12
    aesenclast xmm2, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm6, xmm12
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 320]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 320]
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm12
    aesenclast xmm3, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm7, xmm12
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 384]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 384]
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm12
    aesenclast xmm2, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm6, xmm12
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 448]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 448]
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm12
    aesenclast xmm3, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm7, xmm12
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 512]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 512]
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm12
    aesenclast xmm2, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm6, xmm12
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 576]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 576]
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm12
    aesenclast xmm3, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm7, xmm12
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqu XMMWORD PTR [rax], xmm0
    movdqu XMMWORD PTR [r10], xmm1
    movdqu XMMWORD PTR [rax + 16], xmm2
    movdqu XMMWORD PTR [r10 + 16], xmm3
    movdqu xmm0, XMMWORD PTR [rax + 32]
    movdqu xmm1, XMMWORD PTR [r10 + 32]
    movdqu xmm2, XMMWORD PTR [rax + 48]
    movdqu xmm3, XMMWORD PTR [r10 + 48]
    movdqu xmm4, XMMWORD PTR [rcx + 32]
    movdqu xmm5, XMMWORD PTR [rdx + 32]
    movdqu xmm6, XMMWORD PTR [rcx + 48]
    movdqu xmm7, XMMWORD PTR [rdx + 48]
    movdqu xmm13, XMMWORD PTR [areionRC4x]
    movdqu xmm14, XMMWORD PTR [areionRC4x2]
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm12
    aesenclast xmm2, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm6, xmm12
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 64]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 64]
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm12
    aesenclast xmm3, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm7, xmm12
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 128]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 128]
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm12
    aesenclast xmm2, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm6, xmm12
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 192]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 192]
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm12
    aesenclast xmm3, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm7, xmm12
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 256]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 256]
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm12
    aesenclast xmm2, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm6, xmm12
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 320]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 320]
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm12
    aesenclast xmm3, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm7, xmm12
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 384]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 384]
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm12
    aesenclast xmm2, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm6, xmm12
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 448]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 448]
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm12
    aesenclast xmm3, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm7, xmm12
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 512]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 512]
    movdqu xmm8, xmm0
    movdqu xmm9, xmm2
    movdqu xmm10, xmm4
    movdqu xmm11, xmm6
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm12
    aesenclast xmm2, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm6, xmm12
    movdqu xmm1, xmm8
    movdqu xmm3, xmm9
    movdqu xmm5, xmm10
    movdqu xmm7, xmm11
    movdqu xmm13, XMMWORD PTR [areionRC4x + 576]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 576]
    movdqu xmm8, xmm1
    movdqu xmm9, xmm3
    movdqu xmm10, xmm5
    movdqu xmm11, xmm7
    aesenc xmm8, xmm13
    aesenc xmm9, xmm13
    aesenc xmm10, xmm14
    aesenc xmm11, xmm14
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm12
    aesenclast xmm3, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm7, xmm12
    movdqu xmm0, xmm8
    movdqu xmm2, xmm9
    movdqu xmm4, xmm10
    movdqu xmm6, xmm11
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqu XMMWORD PTR [rax + 32], xmm0
    movdqu XMMWORD PTR [r10 + 32], xmm1
    movdqu XMMWORD PTR [rax + 48], xmm2
    movdqu XMMWORD PTR [r10 + 48], xmm3
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
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    xor r11, r11
    movdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm12, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm13, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm14, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    add rsp, 152
    ret
areion256SoEMPermutex4AesNi ENDP

PUBLIC areion256SoEMPermutex4Vex
ALIGN 16
areion256SoEMPermutex4Vex PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm8
    vmovdqu XMMWORD PTR [rsp + 48], xmm9
    vmovdqu XMMWORD PTR [rsp + 64], xmm10
    vmovdqu XMMWORD PTR [rsp + 80], xmm11
    vmovdqu XMMWORD PTR [rsp + 96], xmm12
    vmovdqu XMMWORD PTR [rsp + 112], xmm13
    vmovdqu XMMWORD PTR [rsp + 128], xmm14
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    mov rdx, r9
    vpxor xmm12, xmm12, xmm12
    vmovdqu xmm0, XMMWORD PTR [rax]
    vmovdqu xmm1, XMMWORD PTR [r10]
    vmovdqu xmm2, XMMWORD PTR [rax + 16]
    vmovdqu xmm3, XMMWORD PTR [r10 + 16]
    vmovdqu xmm4, XMMWORD PTR [rcx]
    vmovdqu xmm5, XMMWORD PTR [rdx]
    vmovdqu xmm6, XMMWORD PTR [rcx + 16]
    vmovdqu xmm7, XMMWORD PTR [rdx + 16]
    vmovdqu xmm13, XMMWORD PTR [areionRC4x]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2]
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm14
    vaesenc xmm11, xmm6, xmm14
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 64]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 64]
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm14
    vaesenc xmm11, xmm7, xmm14
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 128]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 128]
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm14
    vaesenc xmm11, xmm6, xmm14
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 192]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 192]
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm14
    vaesenc xmm11, xmm7, xmm14
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 256]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 256]
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm14
    vaesenc xmm11, xmm6, xmm14
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 320]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 320]
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm14
    vaesenc xmm11, xmm7, xmm14
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 384]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 384]
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm14
    vaesenc xmm11, xmm6, xmm14
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 448]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 448]
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm14
    vaesenc xmm11, xmm7, xmm14
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 512]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 512]
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm14
    vaesenc xmm11, xmm6, xmm14
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 576]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 576]
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm14
    vaesenc xmm11, xmm7, xmm14
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vmovdqu XMMWORD PTR [rax], xmm0
    vmovdqu XMMWORD PTR [r10], xmm1
    vmovdqu XMMWORD PTR [rax + 16], xmm2
    vmovdqu XMMWORD PTR [r10 + 16], xmm3
    vmovdqu xmm0, XMMWORD PTR [rax + 32]
    vmovdqu xmm1, XMMWORD PTR [r10 + 32]
    vmovdqu xmm2, XMMWORD PTR [rax + 48]
    vmovdqu xmm3, XMMWORD PTR [r10 + 48]
    vmovdqu xmm4, XMMWORD PTR [rcx + 32]
    vmovdqu xmm5, XMMWORD PTR [rdx + 32]
    vmovdqu xmm6, XMMWORD PTR [rcx + 48]
    vmovdqu xmm7, XMMWORD PTR [rdx + 48]
    vmovdqu xmm13, XMMWORD PTR [areionRC4x]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2]
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm14
    vaesenc xmm11, xmm6, xmm14
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 64]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 64]
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm14
    vaesenc xmm11, xmm7, xmm14
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 128]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 128]
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm14
    vaesenc xmm11, xmm6, xmm14
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 192]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 192]
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm14
    vaesenc xmm11, xmm7, xmm14
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 256]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 256]
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm14
    vaesenc xmm11, xmm6, xmm14
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 320]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 320]
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm14
    vaesenc xmm11, xmm7, xmm14
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 384]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 384]
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm14
    vaesenc xmm11, xmm6, xmm14
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 448]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 448]
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm14
    vaesenc xmm11, xmm7, xmm14
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 512]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 512]
    vaesenc xmm8, xmm0, xmm13
    vaesenc xmm9, xmm2, xmm13
    vaesenc xmm10, xmm4, xmm14
    vaesenc xmm11, xmm6, xmm14
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 576]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 576]
    vaesenc xmm8, xmm1, xmm13
    vaesenc xmm9, xmm3, xmm13
    vaesenc xmm10, xmm5, xmm14
    vaesenc xmm11, xmm7, xmm14
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vmovdqu XMMWORD PTR [rax + 32], xmm0
    vmovdqu XMMWORD PTR [r10 + 32], xmm1
    vmovdqu XMMWORD PTR [rax + 48], xmm2
    vmovdqu XMMWORD PTR [r10 + 48], xmm3
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
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    xor r11, r11
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    add rsp, 152
    ret
areion256SoEMPermutex4Vex ENDP

PUBLIC areion512SoEMPermutex4AesNi
ALIGN 16
areion512SoEMPermutex4AesNi PROC
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
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    mov rdx, r9
    mov rsi, QWORD PTR [rsp + 208]
    mov rdi, QWORD PTR [rsp + 216]
    mov r8, QWORD PTR [rsp + 224]
    mov r9, QWORD PTR [rsp + 232]
    pxor xmm12, xmm12
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [r10]
    movdqu xmm2, XMMWORD PTR [rcx]
    movdqu xmm3, XMMWORD PTR [rdx]
    movdqu xmm4, XMMWORD PTR [rsi]
    movdqu xmm5, XMMWORD PTR [rdi]
    movdqu xmm6, XMMWORD PTR [r8]
    movdqu xmm7, XMMWORD PTR [r9]
    movdqu xmm13, XMMWORD PTR [areionRC4x]
    movdqu xmm14, XMMWORD PTR [areionRC4x2]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 64]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 64]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 128]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 128]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 192]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 192]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm14
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 256]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 256]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 320]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 320]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 384]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 384]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 448]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 448]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm14
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 512]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 512]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 576]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 576]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 640]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 640]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 704]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 704]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm14
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 768]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 768]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 832]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 832]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 896]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 896]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    pxor xmm3, xmm7
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    pxor xmm2, xmm6
    movdqu XMMWORD PTR [rax], xmm3
    movdqu XMMWORD PTR [r10], xmm0
    movdqu XMMWORD PTR [rcx], xmm1
    movdqu XMMWORD PTR [rdx], xmm2
    movdqu xmm0, XMMWORD PTR [rax + 16]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [rcx + 16]
    movdqu xmm3, XMMWORD PTR [rdx + 16]
    movdqu xmm4, XMMWORD PTR [rsi + 16]
    movdqu xmm5, XMMWORD PTR [rdi + 16]
    movdqu xmm6, XMMWORD PTR [r8 + 16]
    movdqu xmm7, XMMWORD PTR [r9 + 16]
    movdqu xmm13, XMMWORD PTR [areionRC4x]
    movdqu xmm14, XMMWORD PTR [areionRC4x2]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 64]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 64]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 128]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 128]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 192]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 192]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm14
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 256]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 256]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 320]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 320]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 384]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 384]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 448]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 448]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm14
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 512]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 512]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 576]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 576]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 640]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 640]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 704]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 704]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm14
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 768]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 768]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 832]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 832]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 896]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 896]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    pxor xmm3, xmm7
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    pxor xmm2, xmm6
    movdqu XMMWORD PTR [rax + 16], xmm3
    movdqu XMMWORD PTR [r10 + 16], xmm0
    movdqu XMMWORD PTR [rcx + 16], xmm1
    movdqu XMMWORD PTR [rdx + 16], xmm2
    movdqu xmm0, XMMWORD PTR [rax + 32]
    movdqu xmm1, XMMWORD PTR [r10 + 32]
    movdqu xmm2, XMMWORD PTR [rcx + 32]
    movdqu xmm3, XMMWORD PTR [rdx + 32]
    movdqu xmm4, XMMWORD PTR [rsi + 32]
    movdqu xmm5, XMMWORD PTR [rdi + 32]
    movdqu xmm6, XMMWORD PTR [r8 + 32]
    movdqu xmm7, XMMWORD PTR [r9 + 32]
    movdqu xmm13, XMMWORD PTR [areionRC4x]
    movdqu xmm14, XMMWORD PTR [areionRC4x2]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 64]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 64]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 128]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 128]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 192]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 192]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm14
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 256]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 256]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 320]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 320]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 384]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 384]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 448]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 448]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm14
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 512]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 512]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 576]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 576]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 640]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 640]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 704]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 704]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm14
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 768]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 768]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 832]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 832]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 896]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 896]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    pxor xmm3, xmm7
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    pxor xmm2, xmm6
    movdqu XMMWORD PTR [rax + 32], xmm3
    movdqu XMMWORD PTR [r10 + 32], xmm0
    movdqu XMMWORD PTR [rcx + 32], xmm1
    movdqu XMMWORD PTR [rdx + 32], xmm2
    movdqu xmm0, XMMWORD PTR [rax + 48]
    movdqu xmm1, XMMWORD PTR [r10 + 48]
    movdqu xmm2, XMMWORD PTR [rcx + 48]
    movdqu xmm3, XMMWORD PTR [rdx + 48]
    movdqu xmm4, XMMWORD PTR [rsi + 48]
    movdqu xmm5, XMMWORD PTR [rdi + 48]
    movdqu xmm6, XMMWORD PTR [r8 + 48]
    movdqu xmm7, XMMWORD PTR [r9 + 48]
    movdqu xmm13, XMMWORD PTR [areionRC4x]
    movdqu xmm14, XMMWORD PTR [areionRC4x2]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 64]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 64]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 128]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 128]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 192]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 192]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm14
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 256]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 256]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 320]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 320]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 384]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 384]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 448]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 448]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm14
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 512]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 512]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 576]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 576]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 640]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 640]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 704]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 704]
    movdqu xmm8, xmm3
    movdqu xmm10, xmm7
    aesenc xmm8, xmm0
    aesenc xmm10, xmm4
    movdqu xmm0, xmm8
    movdqu xmm4, xmm10
    movdqu xmm9, xmm1
    movdqu xmm11, xmm5
    aesenc xmm9, xmm2
    aesenc xmm11, xmm6
    movdqu xmm2, xmm9
    movdqu xmm6, xmm11
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenclast xmm1, xmm13
    aesenclast xmm5, xmm14
    aesenc xmm1, xmm12
    aesenc xmm5, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 768]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 768]
    movdqu xmm8, xmm0
    movdqu xmm10, xmm4
    aesenc xmm8, xmm1
    aesenc xmm10, xmm5
    movdqu xmm1, xmm8
    movdqu xmm5, xmm10
    movdqu xmm9, xmm2
    movdqu xmm11, xmm6
    aesenc xmm9, xmm3
    aesenc xmm11, xmm7
    movdqu xmm3, xmm9
    movdqu xmm7, xmm11
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenclast xmm2, xmm13
    aesenclast xmm6, xmm14
    aesenc xmm2, xmm12
    aesenc xmm6, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 832]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 832]
    movdqu xmm8, xmm1
    movdqu xmm10, xmm5
    aesenc xmm8, xmm2
    aesenc xmm10, xmm6
    movdqu xmm2, xmm8
    movdqu xmm6, xmm10
    movdqu xmm9, xmm3
    movdqu xmm11, xmm7
    aesenc xmm9, xmm0
    aesenc xmm11, xmm4
    movdqu xmm0, xmm9
    movdqu xmm4, xmm11
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenclast xmm3, xmm13
    aesenclast xmm7, xmm14
    aesenc xmm3, xmm12
    aesenc xmm7, xmm12
    movdqu xmm13, XMMWORD PTR [areionRC4x + 896]
    movdqu xmm14, XMMWORD PTR [areionRC4x2 + 896]
    movdqu xmm8, xmm2
    movdqu xmm10, xmm6
    aesenc xmm8, xmm3
    aesenc xmm10, xmm7
    movdqu xmm3, xmm8
    movdqu xmm7, xmm10
    movdqu xmm9, xmm0
    movdqu xmm11, xmm4
    aesenc xmm9, xmm1
    aesenc xmm11, xmm5
    movdqu xmm1, xmm9
    movdqu xmm5, xmm11
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenclast xmm0, xmm13
    aesenclast xmm4, xmm14
    aesenc xmm0, xmm12
    aesenc xmm4, xmm12
    pxor xmm3, xmm7
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    pxor xmm2, xmm6
    movdqu XMMWORD PTR [rax + 48], xmm3
    movdqu XMMWORD PTR [r10 + 48], xmm0
    movdqu XMMWORD PTR [rcx + 48], xmm1
    movdqu XMMWORD PTR [rdx + 48], xmm2
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
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    xor rsi, rsi
    xor rdi, rdi
    xor r8, r8
    xor r9, r9
    xor r11, r11
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
areion512SoEMPermutex4AesNi ENDP

PUBLIC areion512SoEMPermutex4Vex
ALIGN 16
areion512SoEMPermutex4Vex PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 104
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm12
    vmovdqu XMMWORD PTR [rsp + 64], xmm13
    vmovdqu XMMWORD PTR [rsp + 80], xmm14
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    mov rdx, r9
    mov rsi, QWORD PTR [rsp + 144]
    mov rdi, QWORD PTR [rsp + 152]
    mov r8, QWORD PTR [rsp + 160]
    mov r9, QWORD PTR [rsp + 168]
    vpxor xmm12, xmm12, xmm12
    vmovdqu xmm0, XMMWORD PTR [rax]
    vmovdqu xmm1, XMMWORD PTR [r10]
    vmovdqu xmm2, XMMWORD PTR [rcx]
    vmovdqu xmm3, XMMWORD PTR [rdx]
    vmovdqu xmm4, XMMWORD PTR [rsi]
    vmovdqu xmm5, XMMWORD PTR [rdi]
    vmovdqu xmm6, XMMWORD PTR [r8]
    vmovdqu xmm7, XMMWORD PTR [r9]
    vmovdqu xmm13, XMMWORD PTR [areionRC4x]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 64]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 64]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 128]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 128]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 192]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 192]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm14
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 256]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 256]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 320]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 320]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 384]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 384]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 448]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 448]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm14
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 512]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 512]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 576]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 576]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 640]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 640]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 704]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 704]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm14
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 768]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 768]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 832]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 832]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 896]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 896]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vpxor xmm3, xmm3, xmm7
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm2, xmm2, xmm6
    vmovdqu XMMWORD PTR [rax], xmm3
    vmovdqu XMMWORD PTR [r10], xmm0
    vmovdqu XMMWORD PTR [rcx], xmm1
    vmovdqu XMMWORD PTR [rdx], xmm2
    vmovdqu xmm0, XMMWORD PTR [rax + 16]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm2, XMMWORD PTR [rcx + 16]
    vmovdqu xmm3, XMMWORD PTR [rdx + 16]
    vmovdqu xmm4, XMMWORD PTR [rsi + 16]
    vmovdqu xmm5, XMMWORD PTR [rdi + 16]
    vmovdqu xmm6, XMMWORD PTR [r8 + 16]
    vmovdqu xmm7, XMMWORD PTR [r9 + 16]
    vmovdqu xmm13, XMMWORD PTR [areionRC4x]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 64]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 64]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 128]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 128]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 192]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 192]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm14
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 256]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 256]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 320]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 320]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 384]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 384]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 448]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 448]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm14
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 512]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 512]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 576]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 576]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 640]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 640]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 704]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 704]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm14
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 768]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 768]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 832]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 832]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 896]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 896]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vpxor xmm3, xmm3, xmm7
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm2, xmm2, xmm6
    vmovdqu XMMWORD PTR [rax + 16], xmm3
    vmovdqu XMMWORD PTR [r10 + 16], xmm0
    vmovdqu XMMWORD PTR [rcx + 16], xmm1
    vmovdqu XMMWORD PTR [rdx + 16], xmm2
    vmovdqu xmm0, XMMWORD PTR [rax + 32]
    vmovdqu xmm1, XMMWORD PTR [r10 + 32]
    vmovdqu xmm2, XMMWORD PTR [rcx + 32]
    vmovdqu xmm3, XMMWORD PTR [rdx + 32]
    vmovdqu xmm4, XMMWORD PTR [rsi + 32]
    vmovdqu xmm5, XMMWORD PTR [rdi + 32]
    vmovdqu xmm6, XMMWORD PTR [r8 + 32]
    vmovdqu xmm7, XMMWORD PTR [r9 + 32]
    vmovdqu xmm13, XMMWORD PTR [areionRC4x]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 64]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 64]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 128]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 128]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 192]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 192]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm14
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 256]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 256]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 320]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 320]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 384]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 384]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 448]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 448]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm14
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 512]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 512]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 576]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 576]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 640]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 640]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 704]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 704]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm14
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 768]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 768]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 832]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 832]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 896]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 896]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vpxor xmm3, xmm3, xmm7
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm2, xmm2, xmm6
    vmovdqu XMMWORD PTR [rax + 32], xmm3
    vmovdqu XMMWORD PTR [r10 + 32], xmm0
    vmovdqu XMMWORD PTR [rcx + 32], xmm1
    vmovdqu XMMWORD PTR [rdx + 32], xmm2
    vmovdqu xmm0, XMMWORD PTR [rax + 48]
    vmovdqu xmm1, XMMWORD PTR [r10 + 48]
    vmovdqu xmm2, XMMWORD PTR [rcx + 48]
    vmovdqu xmm3, XMMWORD PTR [rdx + 48]
    vmovdqu xmm4, XMMWORD PTR [rsi + 48]
    vmovdqu xmm5, XMMWORD PTR [rdi + 48]
    vmovdqu xmm6, XMMWORD PTR [r8 + 48]
    vmovdqu xmm7, XMMWORD PTR [r9 + 48]
    vmovdqu xmm13, XMMWORD PTR [areionRC4x]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 64]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 64]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 128]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 128]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 192]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 192]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm14
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 256]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 256]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 320]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 320]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 384]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 384]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 448]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 448]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm14
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 512]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 512]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 576]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 576]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 640]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 640]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 704]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 704]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm13
    vaesenclast xmm5, xmm5, xmm14
    vaesenc xmm1, xmm1, xmm12
    vaesenc xmm5, xmm5, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 768]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 768]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenclast xmm2, xmm2, xmm13
    vaesenclast xmm6, xmm6, xmm14
    vaesenc xmm2, xmm2, xmm12
    vaesenc xmm6, xmm6, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 832]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 832]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenclast xmm3, xmm3, xmm13
    vaesenclast xmm7, xmm7, xmm14
    vaesenc xmm3, xmm3, xmm12
    vaesenc xmm7, xmm7, xmm12
    vmovdqu xmm13, XMMWORD PTR [areionRC4x + 896]
    vmovdqu xmm14, XMMWORD PTR [areionRC4x2 + 896]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm13
    vaesenclast xmm4, xmm4, xmm14
    vaesenc xmm0, xmm0, xmm12
    vaesenc xmm4, xmm4, xmm12
    vpxor xmm3, xmm3, xmm7
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm2, xmm2, xmm6
    vmovdqu XMMWORD PTR [rax + 48], xmm3
    vmovdqu XMMWORD PTR [r10 + 48], xmm0
    vmovdqu XMMWORD PTR [rcx + 48], xmm1
    vmovdqu XMMWORD PTR [rdx + 48], xmm2
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm14, xmm14, xmm14
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    xor rsi, rsi
    xor rdi, rdi
    xor r8, r8
    xor r9, r9
    xor r11, r11
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 104
    ret
areion512SoEMPermutex4Vex ENDP

END
