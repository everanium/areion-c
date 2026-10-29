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
    movdqu XMMWORD PTR [rsp + 112], xmm15
    mov rax, rcx
    mov r11, rdx
    mov r10, QWORD PTR [rsp + 176]
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [rax + 16]
    movdqu xmm2, XMMWORD PTR [r11]
    movdqu xmm3, XMMWORD PTR [r11 + 16]
    movdqu xmm4, XMMWORD PTR [r8]
    movdqu xmm5, XMMWORD PTR [r8 + 16]
    movdqu xmm6, XMMWORD PTR [r9]
    movdqu xmm7, XMMWORD PTR [r9 + 16]
    pxor xmm15, xmm15
    movdqu xmm12, XMMWORD PTR [r10]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm6, xmm15
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 64]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm7, xmm15
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 128]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm6, xmm15
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 192]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm7, xmm15
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 256]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm6, xmm15
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 320]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm7, xmm15
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 384]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm6, xmm15
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 448]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm7, xmm15
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 512]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm6, xmm15
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 576]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm7, xmm15
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu XMMWORD PTR [rax], xmm0
    movdqu XMMWORD PTR [rax + 16], xmm1
    movdqu XMMWORD PTR [r11], xmm2
    movdqu XMMWORD PTR [r11 + 16], xmm3
    movdqu XMMWORD PTR [r8], xmm4
    movdqu XMMWORD PTR [r8 + 16], xmm5
    movdqu XMMWORD PTR [r9], xmm6
    movdqu XMMWORD PTR [r9 + 16], xmm7
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
    pxor xmm15, xmm15
    xor rax, rax
    xor r8, r8
    xor r9, r9
    xor r10, r10
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
    movdqu xmm15, XMMWORD PTR [rsp + 112]
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
    vmovdqu XMMWORD PTR [rsp + 112], xmm15
    mov rax, rcx
    mov r11, rdx
    mov r10, QWORD PTR [rsp + 176]
    vmovdqu xmm0, XMMWORD PTR [rax]
    vmovdqu xmm1, XMMWORD PTR [rax + 16]
    vmovdqu xmm2, XMMWORD PTR [r11]
    vmovdqu xmm3, XMMWORD PTR [r11 + 16]
    vmovdqu xmm4, XMMWORD PTR [r8]
    vmovdqu xmm5, XMMWORD PTR [r8 + 16]
    vmovdqu xmm6, XMMWORD PTR [r9]
    vmovdqu xmm7, XMMWORD PTR [r9 + 16]
    vpxor xmm15, xmm15, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10]
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm12
    vaesenc xmm11, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [r10 + 64]
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm12
    vaesenc xmm11, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 128]
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm12
    vaesenc xmm11, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [r10 + 192]
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm12
    vaesenc xmm11, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 256]
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm12
    vaesenc xmm11, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [r10 + 320]
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm12
    vaesenc xmm11, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 384]
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm12
    vaesenc xmm11, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [r10 + 448]
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm12
    vaesenc xmm11, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 512]
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm12
    vaesenc xmm11, xmm6, xmm12
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [r10 + 576]
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm12
    vaesenc xmm11, xmm7, xmm12
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu XMMWORD PTR [rax], xmm0
    vmovdqu XMMWORD PTR [rax + 16], xmm1
    vmovdqu XMMWORD PTR [r11], xmm2
    vmovdqu XMMWORD PTR [r11 + 16], xmm3
    vmovdqu XMMWORD PTR [r8], xmm4
    vmovdqu XMMWORD PTR [r8 + 16], xmm5
    vmovdqu XMMWORD PTR [r9], xmm6
    vmovdqu XMMWORD PTR [r9 + 16], xmm7
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
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r8, r8
    xor r9, r9
    xor r10, r10
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
    vmovdqu xmm15, XMMWORD PTR [rsp + 112]
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
    movdqu XMMWORD PTR [rsp + 112], xmm15
    mov rax, rcx
    mov r11, rdx
    mov r10, QWORD PTR [rsp + 176]
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [rax + 16]
    movdqu xmm2, XMMWORD PTR [r11]
    movdqu xmm3, XMMWORD PTR [r11 + 16]
    movdqu xmm4, XMMWORD PTR [r8]
    movdqu xmm5, XMMWORD PTR [r8 + 16]
    movdqu xmm6, XMMWORD PTR [r9]
    movdqu xmm7, XMMWORD PTR [r9 + 16]
    pxor xmm15, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 576]
    aesdeclast xmm1, xmm15
    aesdeclast xmm3, xmm15
    aesdeclast xmm5, xmm15
    aesdeclast xmm7, xmm15
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 512]
    aesdeclast xmm0, xmm15
    aesdeclast xmm2, xmm15
    aesdeclast xmm4, xmm15
    aesdeclast xmm6, xmm15
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 448]
    aesdeclast xmm1, xmm15
    aesdeclast xmm3, xmm15
    aesdeclast xmm5, xmm15
    aesdeclast xmm7, xmm15
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 384]
    aesdeclast xmm0, xmm15
    aesdeclast xmm2, xmm15
    aesdeclast xmm4, xmm15
    aesdeclast xmm6, xmm15
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 320]
    aesdeclast xmm1, xmm15
    aesdeclast xmm3, xmm15
    aesdeclast xmm5, xmm15
    aesdeclast xmm7, xmm15
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 256]
    aesdeclast xmm0, xmm15
    aesdeclast xmm2, xmm15
    aesdeclast xmm4, xmm15
    aesdeclast xmm6, xmm15
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 192]
    aesdeclast xmm1, xmm15
    aesdeclast xmm3, xmm15
    aesdeclast xmm5, xmm15
    aesdeclast xmm7, xmm15
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 128]
    aesdeclast xmm0, xmm15
    aesdeclast xmm2, xmm15
    aesdeclast xmm4, xmm15
    aesdeclast xmm6, xmm15
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 64]
    aesdeclast xmm1, xmm15
    aesdeclast xmm3, xmm15
    aesdeclast xmm5, xmm15
    aesdeclast xmm7, xmm15
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10]
    aesdeclast xmm0, xmm15
    aesdeclast xmm2, xmm15
    aesdeclast xmm4, xmm15
    aesdeclast xmm6, xmm15
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm12
    aesenc xmm11, xmm12
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu XMMWORD PTR [rax], xmm0
    movdqu XMMWORD PTR [rax + 16], xmm1
    movdqu XMMWORD PTR [r11], xmm2
    movdqu XMMWORD PTR [r11 + 16], xmm3
    movdqu XMMWORD PTR [r8], xmm4
    movdqu XMMWORD PTR [r8 + 16], xmm5
    movdqu XMMWORD PTR [r9], xmm6
    movdqu XMMWORD PTR [r9 + 16], xmm7
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
    pxor xmm15, xmm15
    xor rax, rax
    xor r8, r8
    xor r9, r9
    xor r10, r10
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
    movdqu xmm15, XMMWORD PTR [rsp + 112]
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
    vmovdqu XMMWORD PTR [rsp + 112], xmm15
    mov rax, rcx
    mov r11, rdx
    mov r10, QWORD PTR [rsp + 176]
    vmovdqu xmm0, XMMWORD PTR [rax]
    vmovdqu xmm1, XMMWORD PTR [rax + 16]
    vmovdqu xmm2, XMMWORD PTR [r11]
    vmovdqu xmm3, XMMWORD PTR [r11 + 16]
    vmovdqu xmm4, XMMWORD PTR [r8]
    vmovdqu xmm5, XMMWORD PTR [r8 + 16]
    vmovdqu xmm6, XMMWORD PTR [r9]
    vmovdqu xmm7, XMMWORD PTR [r9 + 16]
    vpxor xmm15, xmm15, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 576]
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm12
    vaesenc xmm11, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 512]
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm12
    vaesenc xmm11, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [r10 + 448]
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm12
    vaesenc xmm11, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 384]
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm12
    vaesenc xmm11, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [r10 + 320]
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm12
    vaesenc xmm11, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 256]
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm12
    vaesenc xmm11, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [r10 + 192]
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm12
    vaesenc xmm11, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 128]
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm12
    vaesenc xmm11, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [r10 + 64]
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm12
    vaesenc xmm11, xmm7, xmm12
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10]
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm12
    vaesenc xmm11, xmm6, xmm12
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu XMMWORD PTR [rax], xmm0
    vmovdqu XMMWORD PTR [rax + 16], xmm1
    vmovdqu XMMWORD PTR [r11], xmm2
    vmovdqu XMMWORD PTR [r11 + 16], xmm3
    vmovdqu XMMWORD PTR [r8], xmm4
    vmovdqu XMMWORD PTR [r8 + 16], xmm5
    vmovdqu XMMWORD PTR [r9], xmm6
    vmovdqu XMMWORD PTR [r9 + 16], xmm7
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
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r8, r8
    xor r9, r9
    xor r10, r10
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
    vmovdqu xmm15, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    add rsp, 136
    ret
areion256InversePermutex4VexRC ENDP

PUBLIC areion512Permutex4AesNiRC
ALIGN 16
areion512Permutex4AesNiRC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 136
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm10
    movdqu XMMWORD PTR [rsp + 80], xmm11
    movdqu XMMWORD PTR [rsp + 96], xmm12
    movdqu XMMWORD PTR [rsp + 112], xmm15
    mov rax, rcx
    mov r11, rdx
    mov r10, QWORD PTR [rsp + 176]
    pxor xmm15, xmm15
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [rax + 16]
    movdqu xmm2, XMMWORD PTR [rax + 32]
    movdqu xmm3, XMMWORD PTR [rax + 48]
    movdqu xmm4, XMMWORD PTR [r11]
    movdqu xmm5, XMMWORD PTR [r11 + 16]
    movdqu xmm6, XMMWORD PTR [r11 + 32]
    movdqu xmm7, XMMWORD PTR [r11 + 48]
    movdqu xmm12, XMMWORD PTR [r10]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    movdqa xmm10, xmm2
    movdqa xmm11, xmm6
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    aesenc xmm10, xmm3
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm3, xmm10
    movdqa xmm7, xmm11
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 64]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 128]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 192]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    movdqa xmm10, xmm1
    movdqa xmm11, xmm5
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    aesenc xmm10, xmm2
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm2, xmm10
    movdqa xmm6, xmm11
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 256]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    movdqa xmm10, xmm2
    movdqa xmm11, xmm6
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    aesenc xmm10, xmm3
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm3, xmm10
    movdqa xmm7, xmm11
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 320]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 384]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 448]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    movdqa xmm10, xmm1
    movdqa xmm11, xmm5
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    aesenc xmm10, xmm2
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm2, xmm10
    movdqa xmm6, xmm11
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 512]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    movdqa xmm10, xmm2
    movdqa xmm11, xmm6
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    aesenc xmm10, xmm3
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm3, xmm10
    movdqa xmm7, xmm11
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 576]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 640]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 704]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    movdqa xmm10, xmm1
    movdqa xmm11, xmm5
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    aesenc xmm10, xmm2
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm2, xmm10
    movdqa xmm6, xmm11
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 768]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    movdqa xmm10, xmm2
    movdqa xmm11, xmm6
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    aesenc xmm10, xmm3
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm3, xmm10
    movdqa xmm7, xmm11
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 832]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 896]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu XMMWORD PTR [rax], xmm3
    movdqu XMMWORD PTR [rax + 16], xmm0
    movdqu XMMWORD PTR [rax + 32], xmm1
    movdqu XMMWORD PTR [rax + 48], xmm2
    movdqu XMMWORD PTR [r11], xmm7
    movdqu XMMWORD PTR [r11 + 16], xmm4
    movdqu XMMWORD PTR [r11 + 32], xmm5
    movdqu XMMWORD PTR [r11 + 48], xmm6
    movdqu xmm0, XMMWORD PTR [r8]
    movdqu xmm1, XMMWORD PTR [r8 + 16]
    movdqu xmm2, XMMWORD PTR [r8 + 32]
    movdqu xmm3, XMMWORD PTR [r8 + 48]
    movdqu xmm4, XMMWORD PTR [r9]
    movdqu xmm5, XMMWORD PTR [r9 + 16]
    movdqu xmm6, XMMWORD PTR [r9 + 32]
    movdqu xmm7, XMMWORD PTR [r9 + 48]
    movdqu xmm12, XMMWORD PTR [r10]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    movdqa xmm10, xmm2
    movdqa xmm11, xmm6
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    aesenc xmm10, xmm3
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm3, xmm10
    movdqa xmm7, xmm11
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 64]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 128]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 192]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    movdqa xmm10, xmm1
    movdqa xmm11, xmm5
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    aesenc xmm10, xmm2
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm2, xmm10
    movdqa xmm6, xmm11
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 256]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    movdqa xmm10, xmm2
    movdqa xmm11, xmm6
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    aesenc xmm10, xmm3
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm3, xmm10
    movdqa xmm7, xmm11
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 320]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 384]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 448]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    movdqa xmm10, xmm1
    movdqa xmm11, xmm5
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    aesenc xmm10, xmm2
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm2, xmm10
    movdqa xmm6, xmm11
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 512]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    movdqa xmm10, xmm2
    movdqa xmm11, xmm6
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    aesenc xmm10, xmm3
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm3, xmm10
    movdqa xmm7, xmm11
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 576]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 640]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 704]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    movdqa xmm10, xmm1
    movdqa xmm11, xmm5
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    aesenc xmm10, xmm2
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm2, xmm10
    movdqa xmm6, xmm11
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm12
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 768]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    movdqa xmm10, xmm2
    movdqa xmm11, xmm6
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    aesenc xmm10, xmm3
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm3, xmm10
    movdqa xmm7, xmm11
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm12
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 832]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm12
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [r10 + 896]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm12
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu XMMWORD PTR [r8], xmm3
    movdqu XMMWORD PTR [r8 + 16], xmm0
    movdqu XMMWORD PTR [r8 + 32], xmm1
    movdqu XMMWORD PTR [r8 + 48], xmm2
    movdqu XMMWORD PTR [r9], xmm7
    movdqu XMMWORD PTR [r9 + 16], xmm4
    movdqu XMMWORD PTR [r9 + 32], xmm5
    movdqu XMMWORD PTR [r9 + 48], xmm6
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
    pxor xmm15, xmm15
    xor rax, rax
    xor r8, r8
    xor r9, r9
    xor r10, r10
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
    movdqu xmm15, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    add rsp, 136
    ret
areion512Permutex4AesNiRC ENDP

PUBLIC areion512Permutex4VexRC
ALIGN 16
areion512Permutex4VexRC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 72
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm12
    vmovdqu XMMWORD PTR [rsp + 48], xmm15
    mov rax, rcx
    mov r11, rdx
    mov r10, QWORD PTR [rsp + 112]
    vpxor xmm15, xmm15, xmm15
    vmovdqu xmm0, XMMWORD PTR [rax]
    vmovdqu xmm1, XMMWORD PTR [rax + 16]
    vmovdqu xmm2, XMMWORD PTR [rax + 32]
    vmovdqu xmm3, XMMWORD PTR [rax + 48]
    vmovdqu xmm4, XMMWORD PTR [r11]
    vmovdqu xmm5, XMMWORD PTR [r11 + 16]
    vmovdqu xmm6, XMMWORD PTR [r11 + 32]
    vmovdqu xmm7, XMMWORD PTR [r11 + 48]
    vmovdqu xmm12, XMMWORD PTR [r10]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 64]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 128]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 192]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 256]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 320]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 384]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 448]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 512]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 576]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 640]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 704]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 768]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 832]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 896]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vmovdqu XMMWORD PTR [rax], xmm3
    vmovdqu XMMWORD PTR [rax + 16], xmm0
    vmovdqu XMMWORD PTR [rax + 32], xmm1
    vmovdqu XMMWORD PTR [rax + 48], xmm2
    vmovdqu XMMWORD PTR [r11], xmm7
    vmovdqu XMMWORD PTR [r11 + 16], xmm4
    vmovdqu XMMWORD PTR [r11 + 32], xmm5
    vmovdqu XMMWORD PTR [r11 + 48], xmm6
    vmovdqu xmm0, XMMWORD PTR [r8]
    vmovdqu xmm1, XMMWORD PTR [r8 + 16]
    vmovdqu xmm2, XMMWORD PTR [r8 + 32]
    vmovdqu xmm3, XMMWORD PTR [r8 + 48]
    vmovdqu xmm4, XMMWORD PTR [r9]
    vmovdqu xmm5, XMMWORD PTR [r9 + 16]
    vmovdqu xmm6, XMMWORD PTR [r9 + 32]
    vmovdqu xmm7, XMMWORD PTR [r9 + 48]
    vmovdqu xmm12, XMMWORD PTR [r10]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 64]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 128]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 192]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 256]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 320]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 384]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 448]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 512]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 576]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 640]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 704]
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, xmm12
    vaesenclast xmm5, xmm5, xmm12
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 768]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, xmm12
    vaesenclast xmm6, xmm6, xmm12
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 832]
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, xmm12
    vaesenclast xmm7, xmm7, xmm12
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vmovdqu xmm12, XMMWORD PTR [r10 + 896]
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, xmm12
    vaesenclast xmm4, xmm4, xmm12
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vmovdqu XMMWORD PTR [r8], xmm3
    vmovdqu XMMWORD PTR [r8 + 16], xmm0
    vmovdqu XMMWORD PTR [r8 + 32], xmm1
    vmovdqu XMMWORD PTR [r8 + 48], xmm2
    vmovdqu XMMWORD PTR [r9], xmm7
    vmovdqu XMMWORD PTR [r9 + 16], xmm4
    vmovdqu XMMWORD PTR [r9 + 32], xmm5
    vmovdqu XMMWORD PTR [r9 + 48], xmm6
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm12, xmm12, xmm12
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r8, r8
    xor r9, r9
    xor r10, r10
    xor r11, r11
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    add rsp, 72
    ret
areion512Permutex4VexRC ENDP

PUBLIC areion512InversePermutex4AesNiRC
ALIGN 16
areion512InversePermutex4AesNiRC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 136
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm10
    movdqu XMMWORD PTR [rsp + 80], xmm11
    movdqu XMMWORD PTR [rsp + 96], xmm12
    movdqu XMMWORD PTR [rsp + 112], xmm15
    mov rax, rcx
    mov r11, rdx
    mov r10, QWORD PTR [rsp + 176]
    pxor xmm15, xmm15
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [rax + 16]
    movdqu xmm2, XMMWORD PTR [rax + 32]
    movdqu xmm3, XMMWORD PTR [rax + 48]
    movdqu xmm4, XMMWORD PTR [r11]
    movdqu xmm5, XMMWORD PTR [r11 + 16]
    movdqu xmm6, XMMWORD PTR [r11 + 32]
    movdqu xmm7, XMMWORD PTR [r11 + 48]
    movdqu xmm12, XMMWORD PTR [r10 + 896]
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    aesimc xmm1, xmm1
    aesimc xmm5, xmm5
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    movdqa xmm10, xmm1
    movdqa xmm11, xmm5
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    aesenc xmm10, xmm2
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm2, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 832]
    aesdeclast xmm2, xmm15
    aesdeclast xmm6, xmm15
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesdeclast xmm0, xmm15
    aesdeclast xmm4, xmm15
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 768]
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 704]
    aesdeclast xmm0, xmm15
    aesdeclast xmm4, xmm15
    aesimc xmm2, xmm2
    aesimc xmm6, xmm6
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    aesdeclast xmm2, xmm15
    aesdeclast xmm6, xmm15
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    movdqa xmm10, xmm2
    movdqa xmm11, xmm6
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    aesenc xmm10, xmm3
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm3, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 640]
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    aesimc xmm1, xmm1
    aesimc xmm5, xmm5
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    movdqa xmm10, xmm1
    movdqa xmm11, xmm5
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    aesenc xmm10, xmm2
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm2, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 576]
    aesdeclast xmm2, xmm15
    aesdeclast xmm6, xmm15
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesdeclast xmm0, xmm15
    aesdeclast xmm4, xmm15
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 512]
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 448]
    aesdeclast xmm0, xmm15
    aesdeclast xmm4, xmm15
    aesimc xmm2, xmm2
    aesimc xmm6, xmm6
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    aesdeclast xmm2, xmm15
    aesdeclast xmm6, xmm15
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    movdqa xmm10, xmm2
    movdqa xmm11, xmm6
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    aesenc xmm10, xmm3
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm3, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 384]
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    aesimc xmm1, xmm1
    aesimc xmm5, xmm5
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    movdqa xmm10, xmm1
    movdqa xmm11, xmm5
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    aesenc xmm10, xmm2
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm2, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 320]
    aesdeclast xmm2, xmm15
    aesdeclast xmm6, xmm15
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesdeclast xmm0, xmm15
    aesdeclast xmm4, xmm15
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 256]
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 192]
    aesdeclast xmm0, xmm15
    aesdeclast xmm4, xmm15
    aesimc xmm2, xmm2
    aesimc xmm6, xmm6
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    aesdeclast xmm2, xmm15
    aesdeclast xmm6, xmm15
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    movdqa xmm10, xmm2
    movdqa xmm11, xmm6
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    aesenc xmm10, xmm3
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm3, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 128]
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    aesimc xmm1, xmm1
    aesimc xmm5, xmm5
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    movdqa xmm10, xmm1
    movdqa xmm11, xmm5
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    aesenc xmm10, xmm2
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm2, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 64]
    aesdeclast xmm2, xmm15
    aesdeclast xmm6, xmm15
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesdeclast xmm0, xmm15
    aesdeclast xmm4, xmm15
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    movdqu xmm12, XMMWORD PTR [r10]
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    movdqu XMMWORD PTR [rax], xmm1
    movdqu XMMWORD PTR [rax + 16], xmm2
    movdqu XMMWORD PTR [rax + 32], xmm3
    movdqu XMMWORD PTR [rax + 48], xmm0
    movdqu XMMWORD PTR [r11], xmm5
    movdqu XMMWORD PTR [r11 + 16], xmm6
    movdqu XMMWORD PTR [r11 + 32], xmm7
    movdqu XMMWORD PTR [r11 + 48], xmm4
    movdqu xmm0, XMMWORD PTR [r8]
    movdqu xmm1, XMMWORD PTR [r8 + 16]
    movdqu xmm2, XMMWORD PTR [r8 + 32]
    movdqu xmm3, XMMWORD PTR [r8 + 48]
    movdqu xmm4, XMMWORD PTR [r9]
    movdqu xmm5, XMMWORD PTR [r9 + 16]
    movdqu xmm6, XMMWORD PTR [r9 + 32]
    movdqu xmm7, XMMWORD PTR [r9 + 48]
    movdqu xmm12, XMMWORD PTR [r10 + 896]
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    aesimc xmm1, xmm1
    aesimc xmm5, xmm5
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    movdqa xmm10, xmm1
    movdqa xmm11, xmm5
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    aesenc xmm10, xmm2
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm2, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 832]
    aesdeclast xmm2, xmm15
    aesdeclast xmm6, xmm15
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesdeclast xmm0, xmm15
    aesdeclast xmm4, xmm15
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 768]
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 704]
    aesdeclast xmm0, xmm15
    aesdeclast xmm4, xmm15
    aesimc xmm2, xmm2
    aesimc xmm6, xmm6
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    aesdeclast xmm2, xmm15
    aesdeclast xmm6, xmm15
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    movdqa xmm10, xmm2
    movdqa xmm11, xmm6
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    aesenc xmm10, xmm3
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm3, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 640]
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    aesimc xmm1, xmm1
    aesimc xmm5, xmm5
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    movdqa xmm10, xmm1
    movdqa xmm11, xmm5
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    aesenc xmm10, xmm2
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm2, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 576]
    aesdeclast xmm2, xmm15
    aesdeclast xmm6, xmm15
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesdeclast xmm0, xmm15
    aesdeclast xmm4, xmm15
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 512]
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 448]
    aesdeclast xmm0, xmm15
    aesdeclast xmm4, xmm15
    aesimc xmm2, xmm2
    aesimc xmm6, xmm6
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    aesdeclast xmm2, xmm15
    aesdeclast xmm6, xmm15
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    movdqa xmm10, xmm2
    movdqa xmm11, xmm6
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    aesenc xmm10, xmm3
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm3, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 384]
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    aesimc xmm1, xmm1
    aesimc xmm5, xmm5
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    movdqa xmm10, xmm1
    movdqa xmm11, xmm5
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    aesenc xmm10, xmm2
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm2, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 320]
    aesdeclast xmm2, xmm15
    aesdeclast xmm6, xmm15
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesdeclast xmm0, xmm15
    aesdeclast xmm4, xmm15
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 256]
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 192]
    aesdeclast xmm0, xmm15
    aesdeclast xmm4, xmm15
    aesimc xmm2, xmm2
    aesimc xmm6, xmm6
    aesdeclast xmm2, xmm12
    aesdeclast xmm6, xmm12
    aesdeclast xmm2, xmm15
    aesdeclast xmm6, xmm15
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    movdqa xmm10, xmm2
    movdqa xmm11, xmm6
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    aesenc xmm10, xmm3
    aesenc xmm11, xmm7
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm3, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 128]
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    aesimc xmm1, xmm1
    aesimc xmm5, xmm5
    aesdeclast xmm1, xmm12
    aesdeclast xmm5, xmm12
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    movdqa xmm10, xmm1
    movdqa xmm11, xmm5
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    aesenc xmm10, xmm2
    aesenc xmm11, xmm6
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm2, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [r10 + 64]
    aesdeclast xmm2, xmm15
    aesdeclast xmm6, xmm15
    aesimc xmm0, xmm0
    aesimc xmm4, xmm4
    aesdeclast xmm0, xmm12
    aesdeclast xmm4, xmm12
    aesdeclast xmm0, xmm15
    aesdeclast xmm4, xmm15
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    movdqa xmm10, xmm0
    movdqa xmm11, xmm4
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    aesenc xmm10, xmm1
    aesenc xmm11, xmm5
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm1, xmm10
    movdqa xmm5, xmm11
    movdqu xmm12, XMMWORD PTR [r10]
    aesdeclast xmm1, xmm15
    aesdeclast xmm5, xmm15
    aesimc xmm3, xmm3
    aesimc xmm7, xmm7
    aesdeclast xmm3, xmm12
    aesdeclast xmm7, xmm12
    aesdeclast xmm3, xmm15
    aesdeclast xmm7, xmm15
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    movdqa xmm10, xmm3
    movdqa xmm11, xmm7
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    aesenc xmm10, xmm0
    aesenc xmm11, xmm4
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm0, xmm10
    movdqa xmm4, xmm11
    movdqu XMMWORD PTR [r8], xmm1
    movdqu XMMWORD PTR [r8 + 16], xmm2
    movdqu XMMWORD PTR [r8 + 32], xmm3
    movdqu XMMWORD PTR [r8 + 48], xmm0
    movdqu XMMWORD PTR [r9], xmm5
    movdqu XMMWORD PTR [r9 + 16], xmm6
    movdqu XMMWORD PTR [r9 + 32], xmm7
    movdqu XMMWORD PTR [r9 + 48], xmm4
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
    pxor xmm15, xmm15
    xor rax, rax
    xor r8, r8
    xor r9, r9
    xor r10, r10
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
    movdqu xmm15, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    add rsp, 136
    ret
areion512InversePermutex4AesNiRC ENDP

PUBLIC areion512InversePermutex4VexRC
ALIGN 16
areion512InversePermutex4VexRC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 72
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm12
    vmovdqu XMMWORD PTR [rsp + 48], xmm15
    mov rax, rcx
    mov r11, rdx
    mov r10, QWORD PTR [rsp + 112]
    vpxor xmm15, xmm15, xmm15
    vmovdqu xmm0, XMMWORD PTR [rax]
    vmovdqu xmm1, XMMWORD PTR [rax + 16]
    vmovdqu xmm2, XMMWORD PTR [rax + 32]
    vmovdqu xmm3, XMMWORD PTR [rax + 48]
    vmovdqu xmm4, XMMWORD PTR [r11]
    vmovdqu xmm5, XMMWORD PTR [r11 + 16]
    vmovdqu xmm6, XMMWORD PTR [r11 + 32]
    vmovdqu xmm7, XMMWORD PTR [r11 + 48]
    vmovdqu xmm12, XMMWORD PTR [r10 + 896]
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 832]
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm12, XMMWORD PTR [r10 + 768]
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu xmm12, XMMWORD PTR [r10 + 704]
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesimc xmm2, xmm2
    vaesimc xmm6, xmm6
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vmovdqu xmm12, XMMWORD PTR [r10 + 640]
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 576]
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm12, XMMWORD PTR [r10 + 512]
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu xmm12, XMMWORD PTR [r10 + 448]
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesimc xmm2, xmm2
    vaesimc xmm6, xmm6
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vmovdqu xmm12, XMMWORD PTR [r10 + 384]
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 320]
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm12, XMMWORD PTR [r10 + 256]
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu xmm12, XMMWORD PTR [r10 + 192]
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesimc xmm2, xmm2
    vaesimc xmm6, xmm6
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vmovdqu xmm12, XMMWORD PTR [r10 + 128]
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 64]
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm12, XMMWORD PTR [r10]
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu XMMWORD PTR [rax], xmm1
    vmovdqu XMMWORD PTR [rax + 16], xmm2
    vmovdqu XMMWORD PTR [rax + 32], xmm3
    vmovdqu XMMWORD PTR [rax + 48], xmm0
    vmovdqu XMMWORD PTR [r11], xmm5
    vmovdqu XMMWORD PTR [r11 + 16], xmm6
    vmovdqu XMMWORD PTR [r11 + 32], xmm7
    vmovdqu XMMWORD PTR [r11 + 48], xmm4
    vmovdqu xmm0, XMMWORD PTR [r8]
    vmovdqu xmm1, XMMWORD PTR [r8 + 16]
    vmovdqu xmm2, XMMWORD PTR [r8 + 32]
    vmovdqu xmm3, XMMWORD PTR [r8 + 48]
    vmovdqu xmm4, XMMWORD PTR [r9]
    vmovdqu xmm5, XMMWORD PTR [r9 + 16]
    vmovdqu xmm6, XMMWORD PTR [r9 + 32]
    vmovdqu xmm7, XMMWORD PTR [r9 + 48]
    vmovdqu xmm12, XMMWORD PTR [r10 + 896]
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 832]
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm12, XMMWORD PTR [r10 + 768]
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu xmm12, XMMWORD PTR [r10 + 704]
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesimc xmm2, xmm2
    vaesimc xmm6, xmm6
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vmovdqu xmm12, XMMWORD PTR [r10 + 640]
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 576]
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm12, XMMWORD PTR [r10 + 512]
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu xmm12, XMMWORD PTR [r10 + 448]
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesimc xmm2, xmm2
    vaesimc xmm6, xmm6
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vmovdqu xmm12, XMMWORD PTR [r10 + 384]
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 320]
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm12, XMMWORD PTR [r10 + 256]
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu xmm12, XMMWORD PTR [r10 + 192]
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesimc xmm2, xmm2
    vaesimc xmm6, xmm6
    vaesdeclast xmm2, xmm2, xmm12
    vaesdeclast xmm6, xmm6, xmm12
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vmovdqu xmm12, XMMWORD PTR [r10 + 128]
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesdeclast xmm1, xmm1, xmm12
    vaesdeclast xmm5, xmm5, xmm12
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vmovdqu xmm12, XMMWORD PTR [r10 + 64]
    vaesdeclast xmm2, xmm2, xmm15
    vaesdeclast xmm6, xmm6, xmm15
    vaesimc xmm0, xmm0
    vaesimc xmm4, xmm4
    vaesdeclast xmm0, xmm0, xmm12
    vaesdeclast xmm4, xmm4, xmm12
    vaesdeclast xmm0, xmm0, xmm15
    vaesdeclast xmm4, xmm4, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vmovdqu xmm12, XMMWORD PTR [r10]
    vaesdeclast xmm1, xmm1, xmm15
    vaesdeclast xmm5, xmm5, xmm15
    vaesimc xmm3, xmm3
    vaesimc xmm7, xmm7
    vaesdeclast xmm3, xmm3, xmm12
    vaesdeclast xmm7, xmm7, xmm12
    vaesdeclast xmm3, xmm3, xmm15
    vaesdeclast xmm7, xmm7, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vmovdqu XMMWORD PTR [r8], xmm1
    vmovdqu XMMWORD PTR [r8 + 16], xmm2
    vmovdqu XMMWORD PTR [r8 + 32], xmm3
    vmovdqu XMMWORD PTR [r8 + 48], xmm0
    vmovdqu XMMWORD PTR [r9], xmm5
    vmovdqu XMMWORD PTR [r9 + 16], xmm6
    vmovdqu XMMWORD PTR [r9 + 32], xmm7
    vmovdqu XMMWORD PTR [r9 + 48], xmm4
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm12, xmm12, xmm12
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r8, r8
    xor r9, r9
    xor r10, r10
    xor r11, r11
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    add rsp, 72
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
    movdqu XMMWORD PTR [rsp + 128], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    pxor xmm15, xmm15
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    movdqu xmm3, XMMWORD PTR [r10 + 48]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm1
    movdqa xmm6, xmm2
    movdqa xmm7, xmm3
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm4, xmm10
    pxor xmm5, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 64]
    movdqu xmm9, XMMWORD PTR [rax + 80]
    movdqu xmm10, XMMWORD PTR [rax + 96]
    movdqu xmm11, XMMWORD PTR [rax + 112]
    pxor xmm2, xmm8
    pxor xmm3, xmm9
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm6, xmm15
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 16]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm7, xmm15
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 32]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm6, xmm15
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 48]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm7, xmm15
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 64]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm6, xmm15
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 80]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm7, xmm15
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 96]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm6, xmm15
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 112]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm7, xmm15
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 128]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm6, xmm15
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 144]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm7, xmm15
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 64]
    movdqu xmm9, XMMWORD PTR [rax + 80]
    movdqu xmm10, XMMWORD PTR [rax + 96]
    movdqu xmm11, XMMWORD PTR [rax + 112]
    pxor xmm2, xmm8
    pxor xmm3, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    movdqu XMMWORD PTR [rdx], xmm0
    movdqu XMMWORD PTR [rdx + 16], xmm1
    movdqu XMMWORD PTR [rdx + 32], xmm2
    movdqu XMMWORD PTR [rdx + 48], xmm3
    movdqu xmm0, XMMWORD PTR [r10 + 64]
    movdqu xmm1, XMMWORD PTR [r10 + 80]
    movdqu xmm2, XMMWORD PTR [r10 + 96]
    movdqu xmm3, XMMWORD PTR [r10 + 112]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm1
    movdqa xmm6, xmm2
    movdqa xmm7, xmm3
    movdqu xmm8, XMMWORD PTR [rax + 128]
    movdqu xmm9, XMMWORD PTR [rax + 144]
    movdqu xmm10, XMMWORD PTR [rax + 160]
    movdqu xmm11, XMMWORD PTR [rax + 176]
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm4, xmm10
    pxor xmm5, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 192]
    movdqu xmm9, XMMWORD PTR [rax + 208]
    movdqu xmm10, XMMWORD PTR [rax + 224]
    movdqu xmm11, XMMWORD PTR [rax + 240]
    pxor xmm2, xmm8
    pxor xmm3, xmm9
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm6, xmm15
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 16]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm7, xmm15
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 32]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm6, xmm15
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 48]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm7, xmm15
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 64]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm6, xmm15
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 80]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm7, xmm15
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 96]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm6, xmm15
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 112]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm7, xmm15
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 128]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm2
    movdqa xmm10, xmm4
    movdqa xmm11, xmm6
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm1
    aesenc xmm9, xmm3
    aesenc xmm10, xmm5
    aesenc xmm11, xmm7
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm6, xmm15
    movdqa xmm1, xmm8
    movdqa xmm3, xmm9
    movdqa xmm5, xmm10
    movdqa xmm7, xmm11
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 144]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm3
    movdqa xmm10, xmm5
    movdqa xmm11, xmm7
    aesenc xmm8, xmm12
    aesenc xmm9, xmm12
    aesenc xmm10, xmm13
    aesenc xmm11, xmm13
    aesenc xmm8, xmm0
    aesenc xmm9, xmm2
    aesenc xmm10, xmm4
    aesenc xmm11, xmm6
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm7, xmm15
    movdqa xmm0, xmm8
    movdqa xmm2, xmm9
    movdqa xmm4, xmm10
    movdqa xmm6, xmm11
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    movdqu xmm8, XMMWORD PTR [rax + 128]
    movdqu xmm9, XMMWORD PTR [rax + 144]
    movdqu xmm10, XMMWORD PTR [rax + 160]
    movdqu xmm11, XMMWORD PTR [rax + 176]
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 192]
    movdqu xmm9, XMMWORD PTR [rax + 208]
    movdqu xmm10, XMMWORD PTR [rax + 224]
    movdqu xmm11, XMMWORD PTR [rax + 240]
    pxor xmm2, xmm8
    pxor xmm3, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    movdqu XMMWORD PTR [rdx + 64], xmm0
    movdqu XMMWORD PTR [rdx + 80], xmm1
    movdqu XMMWORD PTR [rdx + 96], xmm2
    movdqu XMMWORD PTR [rdx + 112], xmm3
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
    pxor xmm15, xmm15
    xor rax, rax
    xor rdx, rdx
    xor r10, r10
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
    movdqu xmm15, XMMWORD PTR [rsp + 128]
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
    vmovdqu XMMWORD PTR [rsp + 128], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vpxor xmm15, xmm15, xmm15
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm2, XMMWORD PTR [r10 + 32]
    vmovdqu xmm3, XMMWORD PTR [r10 + 48]
    vpxor xmm4, xmm0, XMMWORD PTR [rax + 32]
    vpxor xmm5, xmm1, XMMWORD PTR [rax + 48]
    vpxor xmm6, xmm2, XMMWORD PTR [rax + 96]
    vpxor xmm7, xmm3, XMMWORD PTR [rax + 112]
    vpxor xmm0, xmm0, XMMWORD PTR [rax]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 16]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 64]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 80]
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2]
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 16]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 32]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 48]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 64]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 80]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 96]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 112]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 128]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 144]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm0, xmm0, XMMWORD PTR [rax]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 16]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 32]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 48]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 64]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 80]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 96]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 112]
    vmovdqu XMMWORD PTR [rdx], xmm0
    vmovdqu XMMWORD PTR [rdx + 16], xmm1
    vmovdqu XMMWORD PTR [rdx + 32], xmm2
    vmovdqu XMMWORD PTR [rdx + 48], xmm3
    vmovdqu xmm0, XMMWORD PTR [r10 + 64]
    vmovdqu xmm1, XMMWORD PTR [r10 + 80]
    vmovdqu xmm2, XMMWORD PTR [r10 + 96]
    vmovdqu xmm3, XMMWORD PTR [r10 + 112]
    vpxor xmm4, xmm0, XMMWORD PTR [rax + 160]
    vpxor xmm5, xmm1, XMMWORD PTR [rax + 176]
    vpxor xmm6, xmm2, XMMWORD PTR [rax + 224]
    vpxor xmm7, xmm3, XMMWORD PTR [rax + 240]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 128]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 144]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 192]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 208]
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2]
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 16]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 32]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 48]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 64]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 80]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 96]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 112]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 128]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenc xmm8, xmm0, xmm12
    vaesenc xmm9, xmm2, xmm12
    vaesenc xmm10, xmm4, xmm13
    vaesenc xmm11, xmm6, xmm13
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenc xmm1, xmm8, xmm1
    vaesenc xmm3, xmm9, xmm3
    vaesenc xmm5, xmm10, xmm5
    vaesenc xmm7, xmm11, xmm7
    vmovdqu xmm12, XMMWORD PTR [roundConstantsP1 + 144]
    vmovdqu xmm13, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenc xmm8, xmm1, xmm12
    vaesenc xmm9, xmm3, xmm12
    vaesenc xmm10, xmm5, xmm13
    vaesenc xmm11, xmm7, xmm13
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenc xmm0, xmm8, xmm0
    vaesenc xmm2, xmm9, xmm2
    vaesenc xmm4, xmm10, xmm4
    vaesenc xmm6, xmm11, xmm6
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 128]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 144]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 160]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 176]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 192]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 208]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 224]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 240]
    vmovdqu XMMWORD PTR [rdx + 64], xmm0
    vmovdqu XMMWORD PTR [rdx + 80], xmm1
    vmovdqu XMMWORD PTR [rdx + 96], xmm2
    vmovdqu XMMWORD PTR [rdx + 112], xmm3
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
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor rdx, rdx
    xor r10, r10
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
    vmovdqu xmm15, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    add rsp, 152
    ret
areion256SoEMPermutex4Vex ENDP

PUBLIC areion512SoEMPermutex4AesNi
ALIGN 16
areion512SoEMPermutex4AesNi PROC
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
    movdqu XMMWORD PTR [rsp + 128], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    movdqu xmm3, XMMWORD PTR [r10 + 48]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm1
    movdqa xmm6, xmm2
    movdqa xmm7, xmm3
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 64]
    movdqu xmm9, XMMWORD PTR [rax + 80]
    movdqu xmm10, XMMWORD PTR [rax + 96]
    movdqu xmm11, XMMWORD PTR [rax + 112]
    pxor xmm4, xmm8
    pxor xmm5, xmm9
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    pxor xmm15, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 16]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 32]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 48]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 64]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 80]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 96]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 112]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 128]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 144]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 160]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 160]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 176]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 176]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 192]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 192]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 208]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 208]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 224]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 224]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    pxor xmm3, xmm7
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    pxor xmm2, xmm6
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm3, xmm8
    pxor xmm0, xmm9
    pxor xmm1, xmm10
    pxor xmm2, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 64]
    movdqu xmm9, XMMWORD PTR [rax + 80]
    movdqu xmm10, XMMWORD PTR [rax + 96]
    movdqu xmm11, XMMWORD PTR [rax + 112]
    pxor xmm3, xmm8
    pxor xmm0, xmm9
    pxor xmm1, xmm10
    pxor xmm2, xmm11
    movdqu XMMWORD PTR [rdx], xmm3
    movdqu XMMWORD PTR [rdx + 16], xmm0
    movdqu XMMWORD PTR [rdx + 32], xmm1
    movdqu XMMWORD PTR [rdx + 48], xmm2
    add rdx, 64
    add r10, 64
    add rax, 128
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    movdqu xmm3, XMMWORD PTR [r10 + 48]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm1
    movdqa xmm6, xmm2
    movdqa xmm7, xmm3
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 64]
    movdqu xmm9, XMMWORD PTR [rax + 80]
    movdqu xmm10, XMMWORD PTR [rax + 96]
    movdqu xmm11, XMMWORD PTR [rax + 112]
    pxor xmm4, xmm8
    pxor xmm5, xmm9
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    pxor xmm15, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 16]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 32]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 48]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 64]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 80]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 96]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 112]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 128]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 144]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 160]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 160]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 176]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 176]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 192]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 192]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 208]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 208]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 224]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 224]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    pxor xmm3, xmm7
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    pxor xmm2, xmm6
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm3, xmm8
    pxor xmm0, xmm9
    pxor xmm1, xmm10
    pxor xmm2, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 64]
    movdqu xmm9, XMMWORD PTR [rax + 80]
    movdqu xmm10, XMMWORD PTR [rax + 96]
    movdqu xmm11, XMMWORD PTR [rax + 112]
    pxor xmm3, xmm8
    pxor xmm0, xmm9
    pxor xmm1, xmm10
    pxor xmm2, xmm11
    movdqu XMMWORD PTR [rdx], xmm3
    movdqu XMMWORD PTR [rdx + 16], xmm0
    movdqu XMMWORD PTR [rdx + 32], xmm1
    movdqu XMMWORD PTR [rdx + 48], xmm2
    add rdx, 64
    add r10, 64
    add rax, 128
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    movdqu xmm3, XMMWORD PTR [r10 + 48]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm1
    movdqa xmm6, xmm2
    movdqa xmm7, xmm3
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 64]
    movdqu xmm9, XMMWORD PTR [rax + 80]
    movdqu xmm10, XMMWORD PTR [rax + 96]
    movdqu xmm11, XMMWORD PTR [rax + 112]
    pxor xmm4, xmm8
    pxor xmm5, xmm9
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    pxor xmm15, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 16]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 32]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 48]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 64]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 80]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 96]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 112]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 128]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 144]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 160]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 160]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 176]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 176]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 192]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 192]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 208]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 208]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 224]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 224]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    pxor xmm3, xmm7
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    pxor xmm2, xmm6
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm3, xmm8
    pxor xmm0, xmm9
    pxor xmm1, xmm10
    pxor xmm2, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 64]
    movdqu xmm9, XMMWORD PTR [rax + 80]
    movdqu xmm10, XMMWORD PTR [rax + 96]
    movdqu xmm11, XMMWORD PTR [rax + 112]
    pxor xmm3, xmm8
    pxor xmm0, xmm9
    pxor xmm1, xmm10
    pxor xmm2, xmm11
    movdqu XMMWORD PTR [rdx], xmm3
    movdqu XMMWORD PTR [rdx + 16], xmm0
    movdqu XMMWORD PTR [rdx + 32], xmm1
    movdqu XMMWORD PTR [rdx + 48], xmm2
    add rdx, 64
    add r10, 64
    add rax, 128
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    movdqu xmm3, XMMWORD PTR [r10 + 48]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm1
    movdqa xmm6, xmm2
    movdqa xmm7, xmm3
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 64]
    movdqu xmm9, XMMWORD PTR [rax + 80]
    movdqu xmm10, XMMWORD PTR [rax + 96]
    movdqu xmm11, XMMWORD PTR [rax + 112]
    pxor xmm4, xmm8
    pxor xmm5, xmm9
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    pxor xmm15, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 16]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 32]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 48]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 64]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 80]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 96]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 112]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 128]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 144]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 160]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 160]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 176]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 176]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 192]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 192]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 208]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 208]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 224]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 224]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    pxor xmm3, xmm7
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    pxor xmm2, xmm6
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm3, xmm8
    pxor xmm0, xmm9
    pxor xmm1, xmm10
    pxor xmm2, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 64]
    movdqu xmm9, XMMWORD PTR [rax + 80]
    movdqu xmm10, XMMWORD PTR [rax + 96]
    movdqu xmm11, XMMWORD PTR [rax + 112]
    pxor xmm3, xmm8
    pxor xmm0, xmm9
    pxor xmm1, xmm10
    pxor xmm2, xmm11
    movdqu XMMWORD PTR [rdx], xmm3
    movdqu XMMWORD PTR [rdx + 16], xmm0
    movdqu XMMWORD PTR [rdx + 32], xmm1
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
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
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
    movdqu xmm15, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    add rsp, 152
    ret
areion512SoEMPermutex4AesNi ENDP

PUBLIC areion512SoEMPermutex4Vex
ALIGN 16
areion512SoEMPermutex4Vex PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 56
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm2, XMMWORD PTR [r10 + 32]
    vmovdqu xmm3, XMMWORD PTR [r10 + 48]
    vpxor xmm4, xmm0, XMMWORD PTR [rax + 64]
    vpxor xmm5, xmm1, XMMWORD PTR [rax + 80]
    vpxor xmm6, xmm2, XMMWORD PTR [rax + 96]
    vpxor xmm7, xmm3, XMMWORD PTR [rax + 112]
    vpxor xmm0, xmm0, XMMWORD PTR [rax]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 16]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 32]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 48]
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 160]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 160]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 176]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 176]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 192]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 192]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 208]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 208]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 224]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 224]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vpxor xmm3, xmm3, xmm7
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, XMMWORD PTR [rax]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 16]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 32]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 48]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 64]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 80]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 96]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 112]
    vmovdqu XMMWORD PTR [rdx], xmm3
    vmovdqu XMMWORD PTR [rdx + 16], xmm0
    vmovdqu XMMWORD PTR [rdx + 32], xmm1
    vmovdqu XMMWORD PTR [rdx + 48], xmm2
    add rdx, 64
    add r10, 64
    add rax, 128
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm2, XMMWORD PTR [r10 + 32]
    vmovdqu xmm3, XMMWORD PTR [r10 + 48]
    vpxor xmm4, xmm0, XMMWORD PTR [rax + 64]
    vpxor xmm5, xmm1, XMMWORD PTR [rax + 80]
    vpxor xmm6, xmm2, XMMWORD PTR [rax + 96]
    vpxor xmm7, xmm3, XMMWORD PTR [rax + 112]
    vpxor xmm0, xmm0, XMMWORD PTR [rax]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 16]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 32]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 48]
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 160]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 160]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 176]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 176]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 192]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 192]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 208]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 208]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 224]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 224]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vpxor xmm3, xmm3, xmm7
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, XMMWORD PTR [rax]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 16]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 32]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 48]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 64]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 80]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 96]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 112]
    vmovdqu XMMWORD PTR [rdx], xmm3
    vmovdqu XMMWORD PTR [rdx + 16], xmm0
    vmovdqu XMMWORD PTR [rdx + 32], xmm1
    vmovdqu XMMWORD PTR [rdx + 48], xmm2
    add rdx, 64
    add r10, 64
    add rax, 128
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm2, XMMWORD PTR [r10 + 32]
    vmovdqu xmm3, XMMWORD PTR [r10 + 48]
    vpxor xmm4, xmm0, XMMWORD PTR [rax + 64]
    vpxor xmm5, xmm1, XMMWORD PTR [rax + 80]
    vpxor xmm6, xmm2, XMMWORD PTR [rax + 96]
    vpxor xmm7, xmm3, XMMWORD PTR [rax + 112]
    vpxor xmm0, xmm0, XMMWORD PTR [rax]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 16]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 32]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 48]
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 160]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 160]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 176]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 176]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 192]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 192]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 208]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 208]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 224]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 224]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vpxor xmm3, xmm3, xmm7
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, XMMWORD PTR [rax]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 16]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 32]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 48]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 64]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 80]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 96]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 112]
    vmovdqu XMMWORD PTR [rdx], xmm3
    vmovdqu XMMWORD PTR [rdx + 16], xmm0
    vmovdqu XMMWORD PTR [rdx + 32], xmm1
    vmovdqu XMMWORD PTR [rdx + 48], xmm2
    add rdx, 64
    add r10, 64
    add rax, 128
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm2, XMMWORD PTR [r10 + 32]
    vmovdqu xmm3, XMMWORD PTR [r10 + 48]
    vpxor xmm4, xmm0, XMMWORD PTR [rax + 64]
    vpxor xmm5, xmm1, XMMWORD PTR [rax + 80]
    vpxor xmm6, xmm2, XMMWORD PTR [rax + 96]
    vpxor xmm7, xmm3, XMMWORD PTR [rax + 112]
    vpxor xmm0, xmm0, XMMWORD PTR [rax]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 16]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 32]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 48]
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 160]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 160]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 176]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 176]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 192]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 192]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 208]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 208]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 224]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 224]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vpxor xmm3, xmm3, xmm7
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, XMMWORD PTR [rax]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 16]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 32]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 48]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 64]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 80]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 96]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 112]
    vmovdqu XMMWORD PTR [rdx], xmm3
    vmovdqu XMMWORD PTR [rdx + 16], xmm0
    vmovdqu XMMWORD PTR [rdx + 32], xmm1
    vmovdqu XMMWORD PTR [rdx + 48], xmm2
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    add rsp, 56
    ret
areion512SoEMPermutex4Vex ENDP

END
