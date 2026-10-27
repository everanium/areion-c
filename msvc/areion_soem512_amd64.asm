; Copyright (c) 2026 Andrey Kuvshinov
; SPDX-License-Identifier: Apache-2.0 OR MIT

EXTERN roundConstantsP1:BYTE
EXTERN roundConstantsP2:BYTE
EXTERN areionRC4x:BYTE
EXTERN areionRC4x2:BYTE

.code

PUBLIC areion512SoEMPermutex4Interleaved
ALIGN 16
areion512SoEMPermutex4Interleaved PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 104
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm8
    vmovdqu XMMWORD PTR [rsp + 48], xmm9
    vmovdqu XMMWORD PTR [rsp + 64], xmm10
    vmovdqu XMMWORD PTR [rsp + 80], xmm11
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    mov rdx, r9
    mov rsi, QWORD PTR [rsp + 144]
    mov rdi, QWORD PTR [rsp + 152]
    mov r8, QWORD PTR [rsp + 160]
    mov r9, QWORD PTR [rsp + 168]
    vmovdqu64 zmm0, ZMMWORD PTR [rax]
    vmovdqu64 zmm1, ZMMWORD PTR [r10]
    vmovdqu64 zmm2, ZMMWORD PTR [rcx]
    vmovdqu64 zmm3, ZMMWORD PTR [rdx]
    vmovdqu64 zmm8, ZMMWORD PTR [rsi]
    vmovdqu64 zmm9, ZMMWORD PTR [rdi]
    vmovdqu64 zmm10, ZMMWORD PTR [r8]
    vmovdqu64 zmm11, ZMMWORD PTR [r9]
    vpxord zmm6, zmm6, zmm6
    vmovdqu64 zmm16, ZMMWORD PTR [areionRC4x]
    vmovdqu64 zmm17, ZMMWORD PTR [areionRC4x + 64]
    vmovdqu64 zmm18, ZMMWORD PTR [areionRC4x + 128]
    vmovdqu64 zmm19, ZMMWORD PTR [areionRC4x + 192]
    vmovdqu64 zmm20, ZMMWORD PTR [areionRC4x + 256]
    vmovdqu64 zmm21, ZMMWORD PTR [areionRC4x + 320]
    vmovdqu64 zmm22, ZMMWORD PTR [areionRC4x + 384]
    vmovdqu64 zmm23, ZMMWORD PTR [areionRC4x + 448]
    vmovdqu64 zmm24, ZMMWORD PTR [areionRC4x + 512]
    vmovdqu64 zmm25, ZMMWORD PTR [areionRC4x + 576]
    vmovdqu64 zmm26, ZMMWORD PTR [areionRC4x + 640]
    vmovdqu64 zmm27, ZMMWORD PTR [areionRC4x + 704]
    vmovdqu64 zmm28, ZMMWORD PTR [areionRC4x + 768]
    vmovdqu64 zmm29, ZMMWORD PTR [areionRC4x + 832]
    vmovdqu64 zmm30, ZMMWORD PTR [areionRC4x + 896]
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm9, zmm8, zmm9
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm11, zmm10, zmm11
    vaesenclast zmm0, zmm0, zmm6
    vaesenclast zmm8, zmm8, zmm6
    vaesenclast zmm2, zmm2, zmm16
    vaesenclast zmm10, zmm10, ZMMWORD PTR [areionRC4x2]
    vaesenc zmm2, zmm2, zmm6
    vaesenc zmm10, zmm10, zmm6
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm10, zmm9, zmm10
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm8, zmm11, zmm8
    vaesenclast zmm1, zmm1, zmm6
    vaesenclast zmm9, zmm9, zmm6
    vaesenclast zmm3, zmm3, zmm17
    vaesenclast zmm11, zmm11, ZMMWORD PTR [areionRC4x2 + 64]
    vaesenc zmm3, zmm3, zmm6
    vaesenc zmm11, zmm11, zmm6
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm11, zmm10, zmm11
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm9, zmm8, zmm9
    vaesenclast zmm2, zmm2, zmm6
    vaesenclast zmm10, zmm10, zmm6
    vaesenclast zmm0, zmm0, zmm18
    vaesenclast zmm8, zmm8, ZMMWORD PTR [areionRC4x2 + 128]
    vaesenc zmm0, zmm0, zmm6
    vaesenc zmm8, zmm8, zmm6
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm8, zmm11, zmm8
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm10, zmm9, zmm10
    vaesenclast zmm3, zmm3, zmm6
    vaesenclast zmm11, zmm11, zmm6
    vaesenclast zmm1, zmm1, zmm19
    vaesenclast zmm9, zmm9, ZMMWORD PTR [areionRC4x2 + 192]
    vaesenc zmm1, zmm1, zmm6
    vaesenc zmm9, zmm9, zmm6
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm9, zmm8, zmm9
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm11, zmm10, zmm11
    vaesenclast zmm0, zmm0, zmm6
    vaesenclast zmm8, zmm8, zmm6
    vaesenclast zmm2, zmm2, zmm20
    vaesenclast zmm10, zmm10, ZMMWORD PTR [areionRC4x2 + 256]
    vaesenc zmm2, zmm2, zmm6
    vaesenc zmm10, zmm10, zmm6
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm10, zmm9, zmm10
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm8, zmm11, zmm8
    vaesenclast zmm1, zmm1, zmm6
    vaesenclast zmm9, zmm9, zmm6
    vaesenclast zmm3, zmm3, zmm21
    vaesenclast zmm11, zmm11, ZMMWORD PTR [areionRC4x2 + 320]
    vaesenc zmm3, zmm3, zmm6
    vaesenc zmm11, zmm11, zmm6
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm11, zmm10, zmm11
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm9, zmm8, zmm9
    vaesenclast zmm2, zmm2, zmm6
    vaesenclast zmm10, zmm10, zmm6
    vaesenclast zmm0, zmm0, zmm22
    vaesenclast zmm8, zmm8, ZMMWORD PTR [areionRC4x2 + 384]
    vaesenc zmm0, zmm0, zmm6
    vaesenc zmm8, zmm8, zmm6
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm8, zmm11, zmm8
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm10, zmm9, zmm10
    vaesenclast zmm3, zmm3, zmm6
    vaesenclast zmm11, zmm11, zmm6
    vaesenclast zmm1, zmm1, zmm23
    vaesenclast zmm9, zmm9, ZMMWORD PTR [areionRC4x2 + 448]
    vaesenc zmm1, zmm1, zmm6
    vaesenc zmm9, zmm9, zmm6
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm9, zmm8, zmm9
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm11, zmm10, zmm11
    vaesenclast zmm0, zmm0, zmm6
    vaesenclast zmm8, zmm8, zmm6
    vaesenclast zmm2, zmm2, zmm24
    vaesenclast zmm10, zmm10, ZMMWORD PTR [areionRC4x2 + 512]
    vaesenc zmm2, zmm2, zmm6
    vaesenc zmm10, zmm10, zmm6
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm10, zmm9, zmm10
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm8, zmm11, zmm8
    vaesenclast zmm1, zmm1, zmm6
    vaesenclast zmm9, zmm9, zmm6
    vaesenclast zmm3, zmm3, zmm25
    vaesenclast zmm11, zmm11, ZMMWORD PTR [areionRC4x2 + 576]
    vaesenc zmm3, zmm3, zmm6
    vaesenc zmm11, zmm11, zmm6
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm11, zmm10, zmm11
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm9, zmm8, zmm9
    vaesenclast zmm2, zmm2, zmm6
    vaesenclast zmm10, zmm10, zmm6
    vaesenclast zmm0, zmm0, zmm26
    vaesenclast zmm8, zmm8, ZMMWORD PTR [areionRC4x2 + 640]
    vaesenc zmm0, zmm0, zmm6
    vaesenc zmm8, zmm8, zmm6
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm8, zmm11, zmm8
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm10, zmm9, zmm10
    vaesenclast zmm3, zmm3, zmm6
    vaesenclast zmm11, zmm11, zmm6
    vaesenclast zmm1, zmm1, zmm27
    vaesenclast zmm9, zmm9, ZMMWORD PTR [areionRC4x2 + 704]
    vaesenc zmm1, zmm1, zmm6
    vaesenc zmm9, zmm9, zmm6
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm9, zmm8, zmm9
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm11, zmm10, zmm11
    vaesenclast zmm0, zmm0, zmm6
    vaesenclast zmm8, zmm8, zmm6
    vaesenclast zmm2, zmm2, zmm28
    vaesenclast zmm10, zmm10, ZMMWORD PTR [areionRC4x2 + 768]
    vaesenc zmm2, zmm2, zmm6
    vaesenc zmm10, zmm10, zmm6
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm10, zmm9, zmm10
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm8, zmm11, zmm8
    vaesenclast zmm1, zmm1, zmm6
    vaesenclast zmm9, zmm9, zmm6
    vaesenclast zmm3, zmm3, zmm29
    vaesenclast zmm11, zmm11, ZMMWORD PTR [areionRC4x2 + 832]
    vaesenc zmm3, zmm3, zmm6
    vaesenc zmm11, zmm11, zmm6
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm11, zmm10, zmm11
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm9, zmm8, zmm9
    vaesenclast zmm2, zmm2, zmm6
    vaesenclast zmm10, zmm10, zmm6
    vaesenclast zmm0, zmm0, zmm30
    vaesenclast zmm8, zmm8, ZMMWORD PTR [areionRC4x2 + 896]
    vaesenc zmm0, zmm0, zmm6
    vaesenc zmm8, zmm8, zmm6
    vpxord zmm3, zmm3, zmm11
    vpxord zmm0, zmm0, zmm8
    vpxord zmm1, zmm1, zmm9
    vpxord zmm2, zmm2, zmm10
    vmovdqu64 ZMMWORD PTR [rax], zmm3
    vmovdqu64 ZMMWORD PTR [r10], zmm0
    vmovdqu64 ZMMWORD PTR [rcx], zmm1
    vmovdqu64 ZMMWORD PTR [rdx], zmm2
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm8, xmm8, xmm8
    vpxord xmm9, xmm9, xmm9
    vpxord xmm10, xmm10, xmm10
    vpxord xmm11, xmm11, xmm11
    vpxord xmm16, xmm16, xmm16
    vpxord xmm17, xmm17, xmm17
    vpxord xmm18, xmm18, xmm18
    vpxord xmm19, xmm19, xmm19
    vpxord xmm20, xmm20, xmm20
    vpxord xmm21, xmm21, xmm21
    vpxord xmm22, xmm22, xmm22
    vpxord xmm23, xmm23, xmm23
    vpxord xmm24, xmm24, xmm24
    vpxord xmm25, xmm25, xmm25
    vpxord xmm26, xmm26, xmm26
    vpxord xmm27, xmm27, xmm27
    vpxord xmm28, xmm28, xmm28
    vpxord xmm29, xmm29, xmm29
    vpxord xmm30, xmm30, xmm30
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
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 104
    vzeroupper
    ret
areion512SoEMPermutex4Interleaved ENDP

PUBLIC areion512SoEMPermutex4VaesAvx2
ALIGN 16
areion512SoEMPermutex4VaesAvx2 PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 72
    mov QWORD PTR [rsp + 0], rsi
    mov QWORD PTR [rsp + 8], rdi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm15
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    mov rdx, r9
    mov rsi, QWORD PTR [rsp + 112]
    mov rdi, QWORD PTR [rsp + 120]
    mov r8, QWORD PTR [rsp + 128]
    mov r9, QWORD PTR [rsp + 136]
    vpxor ymm15, ymm15, ymm15
    vmovdqu ymm0, YMMWORD PTR [rax]
    vmovdqu ymm1, YMMWORD PTR [r10]
    vmovdqu ymm2, YMMWORD PTR [rcx]
    vmovdqu ymm3, YMMWORD PTR [rdx]
    vmovdqu ymm4, YMMWORD PTR [rsi]
    vmovdqu ymm5, YMMWORD PTR [rdi]
    vmovdqu ymm6, YMMWORD PTR [r8]
    vmovdqu ymm7, YMMWORD PTR [r9]
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm2, ymm2, YMMWORD PTR [areionRC4x]
    vaesenclast ymm6, ymm6, YMMWORD PTR [areionRC4x2]
    vaesenc ymm2, ymm2, ymm15
    vaesenc ymm6, ymm6, ymm15
    vaesenc ymm2, ymm1, ymm2
    vaesenc ymm6, ymm5, ymm6
    vaesenc ymm0, ymm3, ymm0
    vaesenc ymm4, ymm7, ymm4
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenclast ymm3, ymm3, YMMWORD PTR [areionRC4x + 64]
    vaesenclast ymm7, ymm7, YMMWORD PTR [areionRC4x2 + 64]
    vaesenc ymm3, ymm3, ymm15
    vaesenc ymm7, ymm7, ymm15
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm0, ymm0, YMMWORD PTR [areionRC4x + 128]
    vaesenclast ymm4, ymm4, YMMWORD PTR [areionRC4x2 + 128]
    vaesenc ymm0, ymm0, ymm15
    vaesenc ymm4, ymm4, ymm15
    vaesenc ymm0, ymm3, ymm0
    vaesenc ymm4, ymm7, ymm4
    vaesenc ymm2, ymm1, ymm2
    vaesenc ymm6, ymm5, ymm6
    vaesenclast ymm3, ymm3, ymm15
    vaesenclast ymm7, ymm7, ymm15
    vaesenclast ymm1, ymm1, YMMWORD PTR [areionRC4x + 192]
    vaesenclast ymm5, ymm5, YMMWORD PTR [areionRC4x2 + 192]
    vaesenc ymm1, ymm1, ymm15
    vaesenc ymm5, ymm5, ymm15
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm2, ymm2, YMMWORD PTR [areionRC4x + 256]
    vaesenclast ymm6, ymm6, YMMWORD PTR [areionRC4x2 + 256]
    vaesenc ymm2, ymm2, ymm15
    vaesenc ymm6, ymm6, ymm15
    vaesenc ymm2, ymm1, ymm2
    vaesenc ymm6, ymm5, ymm6
    vaesenc ymm0, ymm3, ymm0
    vaesenc ymm4, ymm7, ymm4
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenclast ymm3, ymm3, YMMWORD PTR [areionRC4x + 320]
    vaesenclast ymm7, ymm7, YMMWORD PTR [areionRC4x2 + 320]
    vaesenc ymm3, ymm3, ymm15
    vaesenc ymm7, ymm7, ymm15
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm0, ymm0, YMMWORD PTR [areionRC4x + 384]
    vaesenclast ymm4, ymm4, YMMWORD PTR [areionRC4x2 + 384]
    vaesenc ymm0, ymm0, ymm15
    vaesenc ymm4, ymm4, ymm15
    vaesenc ymm0, ymm3, ymm0
    vaesenc ymm4, ymm7, ymm4
    vaesenc ymm2, ymm1, ymm2
    vaesenc ymm6, ymm5, ymm6
    vaesenclast ymm3, ymm3, ymm15
    vaesenclast ymm7, ymm7, ymm15
    vaesenclast ymm1, ymm1, YMMWORD PTR [areionRC4x + 448]
    vaesenclast ymm5, ymm5, YMMWORD PTR [areionRC4x2 + 448]
    vaesenc ymm1, ymm1, ymm15
    vaesenc ymm5, ymm5, ymm15
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm2, ymm2, YMMWORD PTR [areionRC4x + 512]
    vaesenclast ymm6, ymm6, YMMWORD PTR [areionRC4x2 + 512]
    vaesenc ymm2, ymm2, ymm15
    vaesenc ymm6, ymm6, ymm15
    vaesenc ymm2, ymm1, ymm2
    vaesenc ymm6, ymm5, ymm6
    vaesenc ymm0, ymm3, ymm0
    vaesenc ymm4, ymm7, ymm4
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenclast ymm3, ymm3, YMMWORD PTR [areionRC4x + 576]
    vaesenclast ymm7, ymm7, YMMWORD PTR [areionRC4x2 + 576]
    vaesenc ymm3, ymm3, ymm15
    vaesenc ymm7, ymm7, ymm15
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm0, ymm0, YMMWORD PTR [areionRC4x + 640]
    vaesenclast ymm4, ymm4, YMMWORD PTR [areionRC4x2 + 640]
    vaesenc ymm0, ymm0, ymm15
    vaesenc ymm4, ymm4, ymm15
    vaesenc ymm0, ymm3, ymm0
    vaesenc ymm4, ymm7, ymm4
    vaesenc ymm2, ymm1, ymm2
    vaesenc ymm6, ymm5, ymm6
    vaesenclast ymm3, ymm3, ymm15
    vaesenclast ymm7, ymm7, ymm15
    vaesenclast ymm1, ymm1, YMMWORD PTR [areionRC4x + 704]
    vaesenclast ymm5, ymm5, YMMWORD PTR [areionRC4x2 + 704]
    vaesenc ymm1, ymm1, ymm15
    vaesenc ymm5, ymm5, ymm15
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm2, ymm2, YMMWORD PTR [areionRC4x + 768]
    vaesenclast ymm6, ymm6, YMMWORD PTR [areionRC4x2 + 768]
    vaesenc ymm2, ymm2, ymm15
    vaesenc ymm6, ymm6, ymm15
    vaesenc ymm2, ymm1, ymm2
    vaesenc ymm6, ymm5, ymm6
    vaesenc ymm0, ymm3, ymm0
    vaesenc ymm4, ymm7, ymm4
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenclast ymm3, ymm3, YMMWORD PTR [areionRC4x + 832]
    vaesenclast ymm7, ymm7, YMMWORD PTR [areionRC4x2 + 832]
    vaesenc ymm3, ymm3, ymm15
    vaesenc ymm7, ymm7, ymm15
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm0, ymm0, YMMWORD PTR [areionRC4x + 896]
    vaesenclast ymm4, ymm4, YMMWORD PTR [areionRC4x2 + 896]
    vaesenc ymm0, ymm0, ymm15
    vaesenc ymm4, ymm4, ymm15
    vpxor ymm3, ymm3, ymm7
    vpxor ymm0, ymm0, ymm4
    vpxor ymm1, ymm1, ymm5
    vpxor ymm2, ymm2, ymm6
    vmovdqu YMMWORD PTR [rax], ymm3
    vmovdqu YMMWORD PTR [r10], ymm0
    vmovdqu YMMWORD PTR [rcx], ymm1
    vmovdqu YMMWORD PTR [rdx], ymm2
    vmovdqu ymm0, YMMWORD PTR [rax + 32]
    vmovdqu ymm1, YMMWORD PTR [r10 + 32]
    vmovdqu ymm2, YMMWORD PTR [rcx + 32]
    vmovdqu ymm3, YMMWORD PTR [rdx + 32]
    vmovdqu ymm4, YMMWORD PTR [rsi + 32]
    vmovdqu ymm5, YMMWORD PTR [rdi + 32]
    vmovdqu ymm6, YMMWORD PTR [r8 + 32]
    vmovdqu ymm7, YMMWORD PTR [r9 + 32]
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm2, ymm2, YMMWORD PTR [areionRC4x]
    vaesenclast ymm6, ymm6, YMMWORD PTR [areionRC4x2]
    vaesenc ymm2, ymm2, ymm15
    vaesenc ymm6, ymm6, ymm15
    vaesenc ymm2, ymm1, ymm2
    vaesenc ymm6, ymm5, ymm6
    vaesenc ymm0, ymm3, ymm0
    vaesenc ymm4, ymm7, ymm4
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenclast ymm3, ymm3, YMMWORD PTR [areionRC4x + 64]
    vaesenclast ymm7, ymm7, YMMWORD PTR [areionRC4x2 + 64]
    vaesenc ymm3, ymm3, ymm15
    vaesenc ymm7, ymm7, ymm15
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm0, ymm0, YMMWORD PTR [areionRC4x + 128]
    vaesenclast ymm4, ymm4, YMMWORD PTR [areionRC4x2 + 128]
    vaesenc ymm0, ymm0, ymm15
    vaesenc ymm4, ymm4, ymm15
    vaesenc ymm0, ymm3, ymm0
    vaesenc ymm4, ymm7, ymm4
    vaesenc ymm2, ymm1, ymm2
    vaesenc ymm6, ymm5, ymm6
    vaesenclast ymm3, ymm3, ymm15
    vaesenclast ymm7, ymm7, ymm15
    vaesenclast ymm1, ymm1, YMMWORD PTR [areionRC4x + 192]
    vaesenclast ymm5, ymm5, YMMWORD PTR [areionRC4x2 + 192]
    vaesenc ymm1, ymm1, ymm15
    vaesenc ymm5, ymm5, ymm15
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm2, ymm2, YMMWORD PTR [areionRC4x + 256]
    vaesenclast ymm6, ymm6, YMMWORD PTR [areionRC4x2 + 256]
    vaesenc ymm2, ymm2, ymm15
    vaesenc ymm6, ymm6, ymm15
    vaesenc ymm2, ymm1, ymm2
    vaesenc ymm6, ymm5, ymm6
    vaesenc ymm0, ymm3, ymm0
    vaesenc ymm4, ymm7, ymm4
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenclast ymm3, ymm3, YMMWORD PTR [areionRC4x + 320]
    vaesenclast ymm7, ymm7, YMMWORD PTR [areionRC4x2 + 320]
    vaesenc ymm3, ymm3, ymm15
    vaesenc ymm7, ymm7, ymm15
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm0, ymm0, YMMWORD PTR [areionRC4x + 384]
    vaesenclast ymm4, ymm4, YMMWORD PTR [areionRC4x2 + 384]
    vaesenc ymm0, ymm0, ymm15
    vaesenc ymm4, ymm4, ymm15
    vaesenc ymm0, ymm3, ymm0
    vaesenc ymm4, ymm7, ymm4
    vaesenc ymm2, ymm1, ymm2
    vaesenc ymm6, ymm5, ymm6
    vaesenclast ymm3, ymm3, ymm15
    vaesenclast ymm7, ymm7, ymm15
    vaesenclast ymm1, ymm1, YMMWORD PTR [areionRC4x + 448]
    vaesenclast ymm5, ymm5, YMMWORD PTR [areionRC4x2 + 448]
    vaesenc ymm1, ymm1, ymm15
    vaesenc ymm5, ymm5, ymm15
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm2, ymm2, YMMWORD PTR [areionRC4x + 512]
    vaesenclast ymm6, ymm6, YMMWORD PTR [areionRC4x2 + 512]
    vaesenc ymm2, ymm2, ymm15
    vaesenc ymm6, ymm6, ymm15
    vaesenc ymm2, ymm1, ymm2
    vaesenc ymm6, ymm5, ymm6
    vaesenc ymm0, ymm3, ymm0
    vaesenc ymm4, ymm7, ymm4
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenclast ymm3, ymm3, YMMWORD PTR [areionRC4x + 576]
    vaesenclast ymm7, ymm7, YMMWORD PTR [areionRC4x2 + 576]
    vaesenc ymm3, ymm3, ymm15
    vaesenc ymm7, ymm7, ymm15
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm0, ymm0, YMMWORD PTR [areionRC4x + 640]
    vaesenclast ymm4, ymm4, YMMWORD PTR [areionRC4x2 + 640]
    vaesenc ymm0, ymm0, ymm15
    vaesenc ymm4, ymm4, ymm15
    vaesenc ymm0, ymm3, ymm0
    vaesenc ymm4, ymm7, ymm4
    vaesenc ymm2, ymm1, ymm2
    vaesenc ymm6, ymm5, ymm6
    vaesenclast ymm3, ymm3, ymm15
    vaesenclast ymm7, ymm7, ymm15
    vaesenclast ymm1, ymm1, YMMWORD PTR [areionRC4x + 704]
    vaesenclast ymm5, ymm5, YMMWORD PTR [areionRC4x2 + 704]
    vaesenc ymm1, ymm1, ymm15
    vaesenc ymm5, ymm5, ymm15
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm2, ymm2, YMMWORD PTR [areionRC4x + 768]
    vaesenclast ymm6, ymm6, YMMWORD PTR [areionRC4x2 + 768]
    vaesenc ymm2, ymm2, ymm15
    vaesenc ymm6, ymm6, ymm15
    vaesenc ymm2, ymm1, ymm2
    vaesenc ymm6, ymm5, ymm6
    vaesenc ymm0, ymm3, ymm0
    vaesenc ymm4, ymm7, ymm4
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenclast ymm3, ymm3, YMMWORD PTR [areionRC4x + 832]
    vaesenclast ymm7, ymm7, YMMWORD PTR [areionRC4x2 + 832]
    vaesenc ymm3, ymm3, ymm15
    vaesenc ymm7, ymm7, ymm15
    vaesenc ymm3, ymm2, ymm3
    vaesenc ymm7, ymm6, ymm7
    vaesenc ymm1, ymm0, ymm1
    vaesenc ymm5, ymm4, ymm5
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm0, ymm0, YMMWORD PTR [areionRC4x + 896]
    vaesenclast ymm4, ymm4, YMMWORD PTR [areionRC4x2 + 896]
    vaesenc ymm0, ymm0, ymm15
    vaesenc ymm4, ymm4, ymm15
    vpxor ymm3, ymm3, ymm7
    vpxor ymm0, ymm0, ymm4
    vpxor ymm1, ymm1, ymm5
    vpxor ymm2, ymm2, ymm6
    vmovdqu YMMWORD PTR [rax + 32], ymm3
    vmovdqu YMMWORD PTR [r10 + 32], ymm0
    vmovdqu YMMWORD PTR [rcx + 32], ymm1
    vmovdqu YMMWORD PTR [rdx + 32], ymm2
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
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
    vmovdqu xmm15, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov rdi, QWORD PTR [rsp + 8]
    mov QWORD PTR [rsp + 8], 0
    add rsp, 72
    vzeroupper
    ret
areion512SoEMPermutex4VaesAvx2 ENDP

END
