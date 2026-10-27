; Copyright (c) 2026 Andrey Kuvshinov
; SPDX-License-Identifier: Apache-2.0 OR MIT

EXTERN roundConstantsP1:BYTE
EXTERN roundConstantsP2:BYTE
EXTERN areionRC4x:BYTE
EXTERN areionRC4x2:BYTE
EXTERN rijndael256Consts:BYTE
EXTERN vistrutahRoundConstants:BYTE
EXTERN vistrutahConsts:BYTE

.code

PUBLIC areion256SoEMPermutex4Interleaved
ALIGN 16
areion256SoEMPermutex4Interleaved PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    vmovdqu XMMWORD PTR [rsp + 0], xmm8
    vmovdqu XMMWORD PTR [rsp + 16], xmm9
    vmovdqu XMMWORD PTR [rsp + 32], xmm10
    vmovdqu XMMWORD PTR [rsp + 48], xmm11
    vmovdqu XMMWORD PTR [rsp + 64], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vmovdqu64 zmm16, ZMMWORD PTR [r10]
    vmovdqu64 zmm17, ZMMWORD PTR [r10 + 64]
    vshufi64x2 zmm0, zmm16, zmm17, 136
    vshufi64x2 zmm1, zmm16, zmm17, 221
    vmovdqu64 ymm16, YMMWORD PTR [rax]
    vinserti64x4 zmm16, zmm16, YMMWORD PTR [rax + 64], 1
    vmovdqu64 ymm17, YMMWORD PTR [rax + 128]
    vinserti64x4 zmm17, zmm17, YMMWORD PTR [rax + 192], 1
    vshufi64x2 zmm8, zmm16, zmm17, 136
    vshufi64x2 zmm9, zmm16, zmm17, 221
    vmovdqu64 ymm16, YMMWORD PTR [rax + 32]
    vinserti64x4 zmm16, zmm16, YMMWORD PTR [rax + 96], 1
    vmovdqu64 ymm17, YMMWORD PTR [rax + 160]
    vinserti64x4 zmm17, zmm17, YMMWORD PTR [rax + 224], 1
    vshufi64x2 zmm10, zmm16, zmm17, 136
    vshufi64x2 zmm11, zmm16, zmm17, 221
    vpxord zmm2, zmm0, zmm10
    vpxord zmm3, zmm1, zmm11
    vpxord zmm0, zmm0, zmm8
    vpxord zmm1, zmm1, zmm9
    vpxord zmm15, zmm15, zmm15
    vaesenc zmm4, zmm0, ZMMWORD PTR [areionRC4x]
    vaesenc zmm5, zmm2, ZMMWORD PTR [areionRC4x2]
    vaesenclast zmm0, zmm0, zmm15
    vaesenclast zmm2, zmm2, zmm15
    vaesenc zmm1, zmm4, zmm1
    vaesenc zmm3, zmm5, zmm3
    vaesenc zmm4, zmm1, ZMMWORD PTR [areionRC4x + 64]
    vaesenc zmm5, zmm3, ZMMWORD PTR [areionRC4x2 + 64]
    vaesenclast zmm1, zmm1, zmm15
    vaesenclast zmm3, zmm3, zmm15
    vaesenc zmm0, zmm4, zmm0
    vaesenc zmm2, zmm5, zmm2
    vaesenc zmm4, zmm0, ZMMWORD PTR [areionRC4x + 128]
    vaesenc zmm5, zmm2, ZMMWORD PTR [areionRC4x2 + 128]
    vaesenclast zmm0, zmm0, zmm15
    vaesenclast zmm2, zmm2, zmm15
    vaesenc zmm1, zmm4, zmm1
    vaesenc zmm3, zmm5, zmm3
    vaesenc zmm4, zmm1, ZMMWORD PTR [areionRC4x + 192]
    vaesenc zmm5, zmm3, ZMMWORD PTR [areionRC4x2 + 192]
    vaesenclast zmm1, zmm1, zmm15
    vaesenclast zmm3, zmm3, zmm15
    vaesenc zmm0, zmm4, zmm0
    vaesenc zmm2, zmm5, zmm2
    vaesenc zmm4, zmm0, ZMMWORD PTR [areionRC4x + 256]
    vaesenc zmm5, zmm2, ZMMWORD PTR [areionRC4x2 + 256]
    vaesenclast zmm0, zmm0, zmm15
    vaesenclast zmm2, zmm2, zmm15
    vaesenc zmm1, zmm4, zmm1
    vaesenc zmm3, zmm5, zmm3
    vaesenc zmm4, zmm1, ZMMWORD PTR [areionRC4x + 320]
    vaesenc zmm5, zmm3, ZMMWORD PTR [areionRC4x2 + 320]
    vaesenclast zmm1, zmm1, zmm15
    vaesenclast zmm3, zmm3, zmm15
    vaesenc zmm0, zmm4, zmm0
    vaesenc zmm2, zmm5, zmm2
    vaesenc zmm4, zmm0, ZMMWORD PTR [areionRC4x + 384]
    vaesenc zmm5, zmm2, ZMMWORD PTR [areionRC4x2 + 384]
    vaesenclast zmm0, zmm0, zmm15
    vaesenclast zmm2, zmm2, zmm15
    vaesenc zmm1, zmm4, zmm1
    vaesenc zmm3, zmm5, zmm3
    vaesenc zmm4, zmm1, ZMMWORD PTR [areionRC4x + 448]
    vaesenc zmm5, zmm3, ZMMWORD PTR [areionRC4x2 + 448]
    vaesenclast zmm1, zmm1, zmm15
    vaesenclast zmm3, zmm3, zmm15
    vaesenc zmm0, zmm4, zmm0
    vaesenc zmm2, zmm5, zmm2
    vaesenc zmm4, zmm0, ZMMWORD PTR [areionRC4x + 512]
    vaesenc zmm5, zmm2, ZMMWORD PTR [areionRC4x2 + 512]
    vaesenclast zmm0, zmm0, zmm15
    vaesenclast zmm2, zmm2, zmm15
    vaesenc zmm1, zmm4, zmm1
    vaesenc zmm3, zmm5, zmm3
    vaesenc zmm4, zmm1, ZMMWORD PTR [areionRC4x + 576]
    vaesenc zmm5, zmm3, ZMMWORD PTR [areionRC4x2 + 576]
    vaesenclast zmm1, zmm1, zmm15
    vaesenclast zmm3, zmm3, zmm15
    vaesenc zmm0, zmm4, zmm0
    vaesenc zmm2, zmm5, zmm2
    vpxord zmm0, zmm0, zmm2
    vpxord zmm1, zmm1, zmm3
    vpxord zmm8, zmm10, zmm8
    vpxord zmm9, zmm11, zmm9
    vpxord zmm0, zmm0, zmm8
    vpxord zmm1, zmm1, zmm9
    vshufi64x2 zmm16, zmm0, zmm1, 68
    vshufi64x2 zmm17, zmm0, zmm1, 238
    vshufi64x2 zmm16, zmm16, zmm16, 216
    vshufi64x2 zmm17, zmm17, zmm17, 216
    vmovdqu64 ZMMWORD PTR [rdx], zmm16
    vmovdqu64 ZMMWORD PTR [rdx + 64], zmm17
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm4, xmm4, xmm4
    vpxord xmm5, xmm5, xmm5
    vpxord xmm8, xmm8, xmm8
    vpxord xmm9, xmm9, xmm9
    vpxord xmm10, xmm10, xmm10
    vpxord xmm11, xmm11, xmm11
    vpxord xmm15, xmm15, xmm15
    vpxord xmm16, xmm16, xmm16
    vpxord xmm17, xmm17, xmm17
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    vmovdqu xmm8, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    add rsp, 88
    vzeroupper
    ret
areion256SoEMPermutex4Interleaved ENDP

PUBLIC areion256SoEMPermutex4VaesAvx2
ALIGN 16
areion256SoEMPermutex4VaesAvx2 PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 104
    vmovdqu XMMWORD PTR [rsp + 0], xmm8
    vmovdqu XMMWORD PTR [rsp + 16], xmm9
    vmovdqu XMMWORD PTR [rsp + 32], xmm10
    vmovdqu XMMWORD PTR [rsp + 48], xmm11
    vmovdqu XMMWORD PTR [rsp + 64], xmm14
    vmovdqu XMMWORD PTR [rsp + 80], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vmovdqu ymm14, YMMWORD PTR [r10]
    vmovdqu ymm1, YMMWORD PTR [r10 + 32]
    vperm2i128 ymm0, ymm14, ymm1, 32
    vperm2i128 ymm1, ymm14, ymm1, 49
    vmovdqu ymm14, YMMWORD PTR [rax]
    vmovdqu ymm9, YMMWORD PTR [rax + 64]
    vperm2i128 ymm8, ymm14, ymm9, 32
    vperm2i128 ymm9, ymm14, ymm9, 49
    vmovdqu ymm14, YMMWORD PTR [rax + 32]
    vmovdqu ymm11, YMMWORD PTR [rax + 96]
    vperm2i128 ymm10, ymm14, ymm11, 32
    vperm2i128 ymm11, ymm14, ymm11, 49
    vpxor ymm2, ymm0, ymm10
    vpxor ymm3, ymm1, ymm11
    vpxor ymm0, ymm0, ymm8
    vpxor ymm1, ymm1, ymm9
    vpxor ymm15, ymm15, ymm15
    vaesenc ymm4, ymm0, YMMWORD PTR [areionRC4x]
    vaesenc ymm5, ymm2, YMMWORD PTR [areionRC4x2]
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm2, ymm2, ymm15
    vaesenc ymm1, ymm4, ymm1
    vaesenc ymm3, ymm5, ymm3
    vaesenc ymm4, ymm1, YMMWORD PTR [areionRC4x + 64]
    vaesenc ymm5, ymm3, YMMWORD PTR [areionRC4x2 + 64]
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm2, ymm5, ymm2
    vaesenc ymm4, ymm0, YMMWORD PTR [areionRC4x + 128]
    vaesenc ymm5, ymm2, YMMWORD PTR [areionRC4x2 + 128]
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm2, ymm2, ymm15
    vaesenc ymm1, ymm4, ymm1
    vaesenc ymm3, ymm5, ymm3
    vaesenc ymm4, ymm1, YMMWORD PTR [areionRC4x + 192]
    vaesenc ymm5, ymm3, YMMWORD PTR [areionRC4x2 + 192]
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm2, ymm5, ymm2
    vaesenc ymm4, ymm0, YMMWORD PTR [areionRC4x + 256]
    vaesenc ymm5, ymm2, YMMWORD PTR [areionRC4x2 + 256]
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm2, ymm2, ymm15
    vaesenc ymm1, ymm4, ymm1
    vaesenc ymm3, ymm5, ymm3
    vaesenc ymm4, ymm1, YMMWORD PTR [areionRC4x + 320]
    vaesenc ymm5, ymm3, YMMWORD PTR [areionRC4x2 + 320]
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm2, ymm5, ymm2
    vaesenc ymm4, ymm0, YMMWORD PTR [areionRC4x + 384]
    vaesenc ymm5, ymm2, YMMWORD PTR [areionRC4x2 + 384]
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm2, ymm2, ymm15
    vaesenc ymm1, ymm4, ymm1
    vaesenc ymm3, ymm5, ymm3
    vaesenc ymm4, ymm1, YMMWORD PTR [areionRC4x + 448]
    vaesenc ymm5, ymm3, YMMWORD PTR [areionRC4x2 + 448]
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm2, ymm5, ymm2
    vaesenc ymm4, ymm0, YMMWORD PTR [areionRC4x + 512]
    vaesenc ymm5, ymm2, YMMWORD PTR [areionRC4x2 + 512]
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm2, ymm2, ymm15
    vaesenc ymm1, ymm4, ymm1
    vaesenc ymm3, ymm5, ymm3
    vaesenc ymm4, ymm1, YMMWORD PTR [areionRC4x + 576]
    vaesenc ymm5, ymm3, YMMWORD PTR [areionRC4x2 + 576]
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm2, ymm5, ymm2
    vpxor ymm0, ymm0, ymm2
    vpxor ymm1, ymm1, ymm3
    vpxor ymm8, ymm10, ymm8
    vpxor ymm9, ymm11, ymm9
    vpxor ymm0, ymm0, ymm8
    vpxor ymm1, ymm1, ymm9
    vperm2i128 ymm14, ymm0, ymm1, 32
    vperm2i128 ymm1, ymm0, ymm1, 49
    vmovdqu YMMWORD PTR [rdx], ymm14
    vmovdqu YMMWORD PTR [rdx + 32], ymm1
    vmovdqu ymm14, YMMWORD PTR [r10 + 64]
    vmovdqu ymm1, YMMWORD PTR [r10 + 96]
    vperm2i128 ymm0, ymm14, ymm1, 32
    vperm2i128 ymm1, ymm14, ymm1, 49
    vmovdqu ymm14, YMMWORD PTR [rax + 128]
    vmovdqu ymm9, YMMWORD PTR [rax + 192]
    vperm2i128 ymm8, ymm14, ymm9, 32
    vperm2i128 ymm9, ymm14, ymm9, 49
    vmovdqu ymm14, YMMWORD PTR [rax + 160]
    vmovdqu ymm11, YMMWORD PTR [rax + 224]
    vperm2i128 ymm10, ymm14, ymm11, 32
    vperm2i128 ymm11, ymm14, ymm11, 49
    vpxor ymm2, ymm0, ymm10
    vpxor ymm3, ymm1, ymm11
    vpxor ymm0, ymm0, ymm8
    vpxor ymm1, ymm1, ymm9
    vpxor ymm15, ymm15, ymm15
    vaesenc ymm4, ymm0, YMMWORD PTR [areionRC4x]
    vaesenc ymm5, ymm2, YMMWORD PTR [areionRC4x2]
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm2, ymm2, ymm15
    vaesenc ymm1, ymm4, ymm1
    vaesenc ymm3, ymm5, ymm3
    vaesenc ymm4, ymm1, YMMWORD PTR [areionRC4x + 64]
    vaesenc ymm5, ymm3, YMMWORD PTR [areionRC4x2 + 64]
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm2, ymm5, ymm2
    vaesenc ymm4, ymm0, YMMWORD PTR [areionRC4x + 128]
    vaesenc ymm5, ymm2, YMMWORD PTR [areionRC4x2 + 128]
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm2, ymm2, ymm15
    vaesenc ymm1, ymm4, ymm1
    vaesenc ymm3, ymm5, ymm3
    vaesenc ymm4, ymm1, YMMWORD PTR [areionRC4x + 192]
    vaesenc ymm5, ymm3, YMMWORD PTR [areionRC4x2 + 192]
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm2, ymm5, ymm2
    vaesenc ymm4, ymm0, YMMWORD PTR [areionRC4x + 256]
    vaesenc ymm5, ymm2, YMMWORD PTR [areionRC4x2 + 256]
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm2, ymm2, ymm15
    vaesenc ymm1, ymm4, ymm1
    vaesenc ymm3, ymm5, ymm3
    vaesenc ymm4, ymm1, YMMWORD PTR [areionRC4x + 320]
    vaesenc ymm5, ymm3, YMMWORD PTR [areionRC4x2 + 320]
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm2, ymm5, ymm2
    vaesenc ymm4, ymm0, YMMWORD PTR [areionRC4x + 384]
    vaesenc ymm5, ymm2, YMMWORD PTR [areionRC4x2 + 384]
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm2, ymm2, ymm15
    vaesenc ymm1, ymm4, ymm1
    vaesenc ymm3, ymm5, ymm3
    vaesenc ymm4, ymm1, YMMWORD PTR [areionRC4x + 448]
    vaesenc ymm5, ymm3, YMMWORD PTR [areionRC4x2 + 448]
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm2, ymm5, ymm2
    vaesenc ymm4, ymm0, YMMWORD PTR [areionRC4x + 512]
    vaesenc ymm5, ymm2, YMMWORD PTR [areionRC4x2 + 512]
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm2, ymm2, ymm15
    vaesenc ymm1, ymm4, ymm1
    vaesenc ymm3, ymm5, ymm3
    vaesenc ymm4, ymm1, YMMWORD PTR [areionRC4x + 576]
    vaesenc ymm5, ymm3, YMMWORD PTR [areionRC4x2 + 576]
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm2, ymm5, ymm2
    vpxor ymm0, ymm0, ymm2
    vpxor ymm1, ymm1, ymm3
    vpxor ymm8, ymm10, ymm8
    vpxor ymm9, ymm11, ymm9
    vpxor ymm0, ymm0, ymm8
    vpxor ymm1, ymm1, ymm9
    vperm2i128 ymm14, ymm0, ymm1, 32
    vperm2i128 ymm1, ymm0, ymm1, 49
    vmovdqu YMMWORD PTR [rdx + 64], ymm14
    vmovdqu YMMWORD PTR [rdx + 96], ymm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm14, xmm14, xmm14
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    vmovdqu xmm8, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm14, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    add rsp, 104
    vzeroupper
    ret
areion256SoEMPermutex4VaesAvx2 ENDP

END
