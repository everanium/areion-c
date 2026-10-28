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
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vmovdqu64 zmm16, ZMMWORD PTR [r10]
    vmovdqu64 zmm17, ZMMWORD PTR [r10 + 64]
    vmovdqu64 ymm18, YMMWORD PTR [rax]
    vinserti64x4 zmm18, zmm18, YMMWORD PTR [rax + 64], 1
    vmovdqu64 ymm19, YMMWORD PTR [rax + 128]
    vinserti64x4 zmm19, zmm19, YMMWORD PTR [rax + 192], 1
    vmovdqu64 ymm20, YMMWORD PTR [rax + 32]
    vinserti64x4 zmm20, zmm20, YMMWORD PTR [rax + 96], 1
    vmovdqu64 ymm21, YMMWORD PTR [rax + 160]
    vinserti64x4 zmm21, zmm21, YMMWORD PTR [rax + 224], 1
    vpxord zmm22, zmm16, zmm18
    vpxord zmm23, zmm17, zmm19
    vshufi64x2 zmm0, zmm22, zmm23, 136
    vshufi64x2 zmm1, zmm22, zmm23, 221
    vpxord zmm22, zmm16, zmm20
    vpxord zmm23, zmm17, zmm21
    vshufi64x2 zmm2, zmm22, zmm23, 136
    vshufi64x2 zmm3, zmm22, zmm23, 221
    vpxord zmm18, zmm18, zmm20
    vpxord zmm19, zmm19, zmm21
    vpxord zmm24, zmm24, zmm24
    vaesenc zmm4, zmm0, ZMMWORD PTR [areionRC4x]
    vaesenc zmm5, zmm2, ZMMWORD PTR [areionRC4x2]
    vaesenclast zmm0, zmm0, zmm24
    vaesenclast zmm2, zmm2, zmm24
    vaesenc zmm1, zmm4, zmm1
    vaesenc zmm3, zmm5, zmm3
    vaesenc zmm4, zmm1, ZMMWORD PTR [areionRC4x + 64]
    vaesenc zmm5, zmm3, ZMMWORD PTR [areionRC4x2 + 64]
    vaesenclast zmm1, zmm1, zmm24
    vaesenclast zmm3, zmm3, zmm24
    vaesenc zmm0, zmm4, zmm0
    vaesenc zmm2, zmm5, zmm2
    vaesenc zmm4, zmm0, ZMMWORD PTR [areionRC4x + 128]
    vaesenc zmm5, zmm2, ZMMWORD PTR [areionRC4x2 + 128]
    vaesenclast zmm0, zmm0, zmm24
    vaesenclast zmm2, zmm2, zmm24
    vaesenc zmm1, zmm4, zmm1
    vaesenc zmm3, zmm5, zmm3
    vaesenc zmm4, zmm1, ZMMWORD PTR [areionRC4x + 192]
    vaesenc zmm5, zmm3, ZMMWORD PTR [areionRC4x2 + 192]
    vaesenclast zmm1, zmm1, zmm24
    vaesenclast zmm3, zmm3, zmm24
    vaesenc zmm0, zmm4, zmm0
    vaesenc zmm2, zmm5, zmm2
    vaesenc zmm4, zmm0, ZMMWORD PTR [areionRC4x + 256]
    vaesenc zmm5, zmm2, ZMMWORD PTR [areionRC4x2 + 256]
    vaesenclast zmm0, zmm0, zmm24
    vaesenclast zmm2, zmm2, zmm24
    vaesenc zmm1, zmm4, zmm1
    vaesenc zmm3, zmm5, zmm3
    vaesenc zmm4, zmm1, ZMMWORD PTR [areionRC4x + 320]
    vaesenc zmm5, zmm3, ZMMWORD PTR [areionRC4x2 + 320]
    vaesenclast zmm1, zmm1, zmm24
    vaesenclast zmm3, zmm3, zmm24
    vaesenc zmm0, zmm4, zmm0
    vaesenc zmm2, zmm5, zmm2
    vaesenc zmm4, zmm0, ZMMWORD PTR [areionRC4x + 384]
    vaesenc zmm5, zmm2, ZMMWORD PTR [areionRC4x2 + 384]
    vaesenclast zmm0, zmm0, zmm24
    vaesenclast zmm2, zmm2, zmm24
    vaesenc zmm1, zmm4, zmm1
    vaesenc zmm3, zmm5, zmm3
    vaesenc zmm4, zmm1, ZMMWORD PTR [areionRC4x + 448]
    vaesenc zmm5, zmm3, ZMMWORD PTR [areionRC4x2 + 448]
    vaesenclast zmm1, zmm1, zmm24
    vaesenclast zmm3, zmm3, zmm24
    vaesenc zmm0, zmm4, zmm0
    vaesenc zmm2, zmm5, zmm2
    vaesenc zmm4, zmm0, ZMMWORD PTR [areionRC4x + 512]
    vaesenc zmm5, zmm2, ZMMWORD PTR [areionRC4x2 + 512]
    vaesenclast zmm0, zmm0, zmm24
    vaesenclast zmm2, zmm2, zmm24
    vaesenc zmm1, zmm4, zmm1
    vaesenc zmm3, zmm5, zmm3
    vaesenc zmm4, zmm1, ZMMWORD PTR [areionRC4x + 576]
    vaesenc zmm5, zmm3, ZMMWORD PTR [areionRC4x2 + 576]
    vaesenclast zmm1, zmm1, zmm24
    vaesenclast zmm3, zmm3, zmm24
    vaesenc zmm0, zmm4, zmm0
    vaesenc zmm2, zmm5, zmm2
    vpxord zmm0, zmm0, zmm2
    vpxord zmm1, zmm1, zmm3
    vshufi64x2 zmm16, zmm0, zmm1, 68
    vshufi64x2 zmm17, zmm0, zmm1, 238
    vshufi64x2 zmm16, zmm16, zmm16, 216
    vshufi64x2 zmm17, zmm17, zmm17, 216
    vpxord zmm16, zmm16, zmm18
    vpxord zmm17, zmm17, zmm19
    vmovdqu64 ZMMWORD PTR [rdx], zmm16
    vmovdqu64 ZMMWORD PTR [rdx + 64], zmm17
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm4, xmm4, xmm4
    vpxord xmm5, xmm5, xmm5
    vpxord xmm16, xmm16, xmm16
    vpxord xmm17, xmm17, xmm17
    vpxord xmm18, xmm18, xmm18
    vpxord xmm19, xmm19, xmm19
    vpxord xmm20, xmm20, xmm20
    vpxord xmm21, xmm21, xmm21
    vpxord xmm22, xmm22, xmm22
    vpxord xmm23, xmm23, xmm23
    vpxord xmm24, xmm24, xmm24
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    vzeroupper
    ret
areion256SoEMPermutex4Interleaved ENDP

PUBLIC areion256SoEMPermutex4VaesAvx2
ALIGN 16
areion256SoEMPermutex4VaesAvx2 PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 104
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm8
    vmovdqu XMMWORD PTR [rsp + 48], xmm9
    vmovdqu XMMWORD PTR [rsp + 64], xmm10
    vmovdqu XMMWORD PTR [rsp + 80], xmm11
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vpxor ymm11, ymm11, ymm11
    vmovdqu ymm8, YMMWORD PTR [r10]
    vmovdqu ymm9, YMMWORD PTR [r10 + 32]
    vpxor ymm6, ymm8, YMMWORD PTR [rax]
    vpxor ymm7, ymm9, YMMWORD PTR [rax + 64]
    vperm2i128 ymm0, ymm6, ymm7, 32
    vperm2i128 ymm2, ymm6, ymm7, 49
    vpxor ymm6, ymm8, YMMWORD PTR [rax + 32]
    vpxor ymm7, ymm9, YMMWORD PTR [rax + 96]
    vperm2i128 ymm4, ymm6, ymm7, 32
    vperm2i128 ymm6, ymm6, ymm7, 49
    vmovdqu ymm8, YMMWORD PTR [r10 + 64]
    vmovdqu ymm9, YMMWORD PTR [r10 + 96]
    vpxor ymm10, ymm8, YMMWORD PTR [rax + 128]
    vpxor ymm7, ymm9, YMMWORD PTR [rax + 192]
    vperm2i128 ymm1, ymm10, ymm7, 32
    vperm2i128 ymm3, ymm10, ymm7, 49
    vpxor ymm10, ymm8, YMMWORD PTR [rax + 160]
    vpxor ymm7, ymm9, YMMWORD PTR [rax + 224]
    vperm2i128 ymm5, ymm10, ymm7, 32
    vperm2i128 ymm7, ymm10, ymm7, 49
    vmovdqu ymm8, YMMWORD PTR [areionRC4x]
    vaesenc ymm9, ymm0, ymm8
    vaesenc ymm10, ymm1, ymm8
    vmovdqu ymm8, YMMWORD PTR [areionRC4x2]
    vaesenc ymm2, ymm9, ymm2
    vaesenc ymm3, ymm10, ymm3
    vaesenclast ymm0, ymm0, ymm11
    vaesenclast ymm1, ymm1, ymm11
    vaesenc ymm9, ymm4, ymm8
    vaesenc ymm10, ymm5, ymm8
    vaesenc ymm6, ymm9, ymm6
    vaesenc ymm7, ymm10, ymm7
    vaesenclast ymm4, ymm4, ymm11
    vaesenclast ymm5, ymm5, ymm11
    vmovdqu ymm8, YMMWORD PTR [areionRC4x + 64]
    vaesenc ymm9, ymm2, ymm8
    vaesenc ymm10, ymm3, ymm8
    vmovdqu ymm8, YMMWORD PTR [areionRC4x2 + 64]
    vaesenc ymm0, ymm9, ymm0
    vaesenc ymm1, ymm10, ymm1
    vaesenclast ymm2, ymm2, ymm11
    vaesenclast ymm3, ymm3, ymm11
    vaesenc ymm9, ymm6, ymm8
    vaesenc ymm10, ymm7, ymm8
    vaesenc ymm4, ymm9, ymm4
    vaesenc ymm5, ymm10, ymm5
    vaesenclast ymm6, ymm6, ymm11
    vaesenclast ymm7, ymm7, ymm11
    vmovdqu ymm8, YMMWORD PTR [areionRC4x + 128]
    vaesenc ymm9, ymm0, ymm8
    vaesenc ymm10, ymm1, ymm8
    vmovdqu ymm8, YMMWORD PTR [areionRC4x2 + 128]
    vaesenc ymm2, ymm9, ymm2
    vaesenc ymm3, ymm10, ymm3
    vaesenclast ymm0, ymm0, ymm11
    vaesenclast ymm1, ymm1, ymm11
    vaesenc ymm9, ymm4, ymm8
    vaesenc ymm10, ymm5, ymm8
    vaesenc ymm6, ymm9, ymm6
    vaesenc ymm7, ymm10, ymm7
    vaesenclast ymm4, ymm4, ymm11
    vaesenclast ymm5, ymm5, ymm11
    vmovdqu ymm8, YMMWORD PTR [areionRC4x + 192]
    vaesenc ymm9, ymm2, ymm8
    vaesenc ymm10, ymm3, ymm8
    vmovdqu ymm8, YMMWORD PTR [areionRC4x2 + 192]
    vaesenc ymm0, ymm9, ymm0
    vaesenc ymm1, ymm10, ymm1
    vaesenclast ymm2, ymm2, ymm11
    vaesenclast ymm3, ymm3, ymm11
    vaesenc ymm9, ymm6, ymm8
    vaesenc ymm10, ymm7, ymm8
    vaesenc ymm4, ymm9, ymm4
    vaesenc ymm5, ymm10, ymm5
    vaesenclast ymm6, ymm6, ymm11
    vaesenclast ymm7, ymm7, ymm11
    vmovdqu ymm8, YMMWORD PTR [areionRC4x + 256]
    vaesenc ymm9, ymm0, ymm8
    vaesenc ymm10, ymm1, ymm8
    vmovdqu ymm8, YMMWORD PTR [areionRC4x2 + 256]
    vaesenc ymm2, ymm9, ymm2
    vaesenc ymm3, ymm10, ymm3
    vaesenclast ymm0, ymm0, ymm11
    vaesenclast ymm1, ymm1, ymm11
    vaesenc ymm9, ymm4, ymm8
    vaesenc ymm10, ymm5, ymm8
    vaesenc ymm6, ymm9, ymm6
    vaesenc ymm7, ymm10, ymm7
    vaesenclast ymm4, ymm4, ymm11
    vaesenclast ymm5, ymm5, ymm11
    vmovdqu ymm8, YMMWORD PTR [areionRC4x + 320]
    vaesenc ymm9, ymm2, ymm8
    vaesenc ymm10, ymm3, ymm8
    vmovdqu ymm8, YMMWORD PTR [areionRC4x2 + 320]
    vaesenc ymm0, ymm9, ymm0
    vaesenc ymm1, ymm10, ymm1
    vaesenclast ymm2, ymm2, ymm11
    vaesenclast ymm3, ymm3, ymm11
    vaesenc ymm9, ymm6, ymm8
    vaesenc ymm10, ymm7, ymm8
    vaesenc ymm4, ymm9, ymm4
    vaesenc ymm5, ymm10, ymm5
    vaesenclast ymm6, ymm6, ymm11
    vaesenclast ymm7, ymm7, ymm11
    vmovdqu ymm8, YMMWORD PTR [areionRC4x + 384]
    vaesenc ymm9, ymm0, ymm8
    vaesenc ymm10, ymm1, ymm8
    vmovdqu ymm8, YMMWORD PTR [areionRC4x2 + 384]
    vaesenc ymm2, ymm9, ymm2
    vaesenc ymm3, ymm10, ymm3
    vaesenclast ymm0, ymm0, ymm11
    vaesenclast ymm1, ymm1, ymm11
    vaesenc ymm9, ymm4, ymm8
    vaesenc ymm10, ymm5, ymm8
    vaesenc ymm6, ymm9, ymm6
    vaesenc ymm7, ymm10, ymm7
    vaesenclast ymm4, ymm4, ymm11
    vaesenclast ymm5, ymm5, ymm11
    vmovdqu ymm8, YMMWORD PTR [areionRC4x + 448]
    vaesenc ymm9, ymm2, ymm8
    vaesenc ymm10, ymm3, ymm8
    vmovdqu ymm8, YMMWORD PTR [areionRC4x2 + 448]
    vaesenc ymm0, ymm9, ymm0
    vaesenc ymm1, ymm10, ymm1
    vaesenclast ymm2, ymm2, ymm11
    vaesenclast ymm3, ymm3, ymm11
    vaesenc ymm9, ymm6, ymm8
    vaesenc ymm10, ymm7, ymm8
    vaesenc ymm4, ymm9, ymm4
    vaesenc ymm5, ymm10, ymm5
    vaesenclast ymm6, ymm6, ymm11
    vaesenclast ymm7, ymm7, ymm11
    vmovdqu ymm8, YMMWORD PTR [areionRC4x + 512]
    vaesenc ymm9, ymm0, ymm8
    vaesenc ymm10, ymm1, ymm8
    vmovdqu ymm8, YMMWORD PTR [areionRC4x2 + 512]
    vaesenc ymm2, ymm9, ymm2
    vaesenc ymm3, ymm10, ymm3
    vaesenclast ymm0, ymm0, ymm11
    vaesenclast ymm1, ymm1, ymm11
    vaesenc ymm9, ymm4, ymm8
    vaesenc ymm10, ymm5, ymm8
    vaesenc ymm6, ymm9, ymm6
    vaesenc ymm7, ymm10, ymm7
    vaesenclast ymm4, ymm4, ymm11
    vaesenclast ymm5, ymm5, ymm11
    vmovdqu ymm8, YMMWORD PTR [areionRC4x + 576]
    vaesenc ymm9, ymm2, ymm8
    vaesenc ymm10, ymm3, ymm8
    vmovdqu ymm8, YMMWORD PTR [areionRC4x2 + 576]
    vaesenc ymm0, ymm9, ymm0
    vaesenc ymm1, ymm10, ymm1
    vaesenclast ymm2, ymm2, ymm11
    vaesenclast ymm3, ymm3, ymm11
    vaesenc ymm9, ymm6, ymm8
    vaesenc ymm10, ymm7, ymm8
    vaesenc ymm4, ymm9, ymm4
    vaesenc ymm5, ymm10, ymm5
    vaesenclast ymm6, ymm6, ymm11
    vaesenclast ymm7, ymm7, ymm11
    vpxor ymm0, ymm0, ymm4
    vpxor ymm1, ymm1, ymm5
    vpxor ymm2, ymm2, ymm6
    vpxor ymm3, ymm3, ymm7
    vperm2i128 ymm8, ymm0, ymm2, 32
    vperm2i128 ymm9, ymm0, ymm2, 49
    vperm2i128 ymm10, ymm1, ymm3, 32
    vperm2i128 ymm11, ymm1, ymm3, 49
    vpxor ymm8, ymm8, YMMWORD PTR [rax]
    vpxor ymm8, ymm8, YMMWORD PTR [rax + 32]
    vmovdqu YMMWORD PTR [rdx], ymm8
    vpxor ymm9, ymm9, YMMWORD PTR [rax + 64]
    vpxor ymm9, ymm9, YMMWORD PTR [rax + 96]
    vmovdqu YMMWORD PTR [rdx + 32], ymm9
    vpxor ymm10, ymm10, YMMWORD PTR [rax + 128]
    vpxor ymm10, ymm10, YMMWORD PTR [rax + 160]
    vmovdqu YMMWORD PTR [rdx + 64], ymm10
    vpxor ymm11, ymm11, YMMWORD PTR [rax + 192]
    vpxor ymm11, ymm11, YMMWORD PTR [rax + 224]
    vmovdqu YMMWORD PTR [rdx + 96], ymm11
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
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
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
    add rsp, 104
    vzeroupper
    ret
areion256SoEMPermutex4VaesAvx2 ENDP

END
