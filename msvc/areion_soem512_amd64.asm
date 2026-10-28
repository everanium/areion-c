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

PUBLIC areion512SoEMPermutex4Interleaved
ALIGN 16
areion512SoEMPermutex4Interleaved PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 56
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vmovdqu64 zmm16, ZMMWORD PTR [r10]
    vmovdqu64 zmm17, ZMMWORD PTR [r10 + 64]
    vmovdqu64 zmm18, ZMMWORD PTR [r10 + 128]
    vmovdqu64 zmm19, ZMMWORD PTR [r10 + 192]
    vpxord zmm20, zmm16, ZMMWORD PTR [rax]
    vpxord zmm21, zmm17, ZMMWORD PTR [rax + 128]
    vpxord zmm22, zmm18, ZMMWORD PTR [rax + 256]
    vpxord zmm23, zmm19, ZMMWORD PTR [rax + 384]
    vshufi64x2 zmm24, zmm20, zmm21, 68
    vshufi64x2 zmm25, zmm20, zmm21, 238
    vshufi64x2 zmm26, zmm22, zmm23, 68
    vshufi64x2 zmm27, zmm22, zmm23, 238
    vshufi64x2 zmm0, zmm24, zmm26, 136
    vshufi64x2 zmm1, zmm24, zmm26, 221
    vshufi64x2 zmm2, zmm25, zmm27, 136
    vshufi64x2 zmm3, zmm25, zmm27, 221
    vpxord zmm20, zmm16, ZMMWORD PTR [rax + 64]
    vpxord zmm21, zmm17, ZMMWORD PTR [rax + 192]
    vpxord zmm22, zmm18, ZMMWORD PTR [rax + 320]
    vpxord zmm23, zmm19, ZMMWORD PTR [rax + 448]
    vshufi64x2 zmm24, zmm20, zmm21, 68
    vshufi64x2 zmm25, zmm20, zmm21, 238
    vshufi64x2 zmm26, zmm22, zmm23, 68
    vshufi64x2 zmm27, zmm22, zmm23, 238
    vshufi64x2 zmm4, zmm24, zmm26, 136
    vshufi64x2 zmm5, zmm24, zmm26, 221
    vshufi64x2 zmm6, zmm25, zmm27, 136
    vshufi64x2 zmm7, zmm25, zmm27, 221
    vpxord zmm15, zmm15, zmm15
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm5, zmm4, zmm5
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm7, zmm6, zmm7
    vaesenclast zmm0, zmm0, zmm15
    vaesenclast zmm4, zmm4, zmm15
    vaesenclast zmm2, zmm2, ZMMWORD PTR [areionRC4x]
    vaesenclast zmm6, zmm6, ZMMWORD PTR [areionRC4x2]
    vaesenc zmm2, zmm2, zmm15
    vaesenc zmm6, zmm6, zmm15
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm6, zmm5, zmm6
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm4, zmm7, zmm4
    vaesenclast zmm1, zmm1, zmm15
    vaesenclast zmm5, zmm5, zmm15
    vaesenclast zmm3, zmm3, ZMMWORD PTR [areionRC4x + 64]
    vaesenclast zmm7, zmm7, ZMMWORD PTR [areionRC4x2 + 64]
    vaesenc zmm3, zmm3, zmm15
    vaesenc zmm7, zmm7, zmm15
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm7, zmm6, zmm7
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm5, zmm4, zmm5
    vaesenclast zmm2, zmm2, zmm15
    vaesenclast zmm6, zmm6, zmm15
    vaesenclast zmm0, zmm0, ZMMWORD PTR [areionRC4x + 128]
    vaesenclast zmm4, zmm4, ZMMWORD PTR [areionRC4x2 + 128]
    vaesenc zmm0, zmm0, zmm15
    vaesenc zmm4, zmm4, zmm15
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm4, zmm7, zmm4
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm6, zmm5, zmm6
    vaesenclast zmm3, zmm3, zmm15
    vaesenclast zmm7, zmm7, zmm15
    vaesenclast zmm1, zmm1, ZMMWORD PTR [areionRC4x + 192]
    vaesenclast zmm5, zmm5, ZMMWORD PTR [areionRC4x2 + 192]
    vaesenc zmm1, zmm1, zmm15
    vaesenc zmm5, zmm5, zmm15
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm5, zmm4, zmm5
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm7, zmm6, zmm7
    vaesenclast zmm0, zmm0, zmm15
    vaesenclast zmm4, zmm4, zmm15
    vaesenclast zmm2, zmm2, ZMMWORD PTR [areionRC4x + 256]
    vaesenclast zmm6, zmm6, ZMMWORD PTR [areionRC4x2 + 256]
    vaesenc zmm2, zmm2, zmm15
    vaesenc zmm6, zmm6, zmm15
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm6, zmm5, zmm6
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm4, zmm7, zmm4
    vaesenclast zmm1, zmm1, zmm15
    vaesenclast zmm5, zmm5, zmm15
    vaesenclast zmm3, zmm3, ZMMWORD PTR [areionRC4x + 320]
    vaesenclast zmm7, zmm7, ZMMWORD PTR [areionRC4x2 + 320]
    vaesenc zmm3, zmm3, zmm15
    vaesenc zmm7, zmm7, zmm15
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm7, zmm6, zmm7
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm5, zmm4, zmm5
    vaesenclast zmm2, zmm2, zmm15
    vaesenclast zmm6, zmm6, zmm15
    vaesenclast zmm0, zmm0, ZMMWORD PTR [areionRC4x + 384]
    vaesenclast zmm4, zmm4, ZMMWORD PTR [areionRC4x2 + 384]
    vaesenc zmm0, zmm0, zmm15
    vaesenc zmm4, zmm4, zmm15
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm4, zmm7, zmm4
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm6, zmm5, zmm6
    vaesenclast zmm3, zmm3, zmm15
    vaesenclast zmm7, zmm7, zmm15
    vaesenclast zmm1, zmm1, ZMMWORD PTR [areionRC4x + 448]
    vaesenclast zmm5, zmm5, ZMMWORD PTR [areionRC4x2 + 448]
    vaesenc zmm1, zmm1, zmm15
    vaesenc zmm5, zmm5, zmm15
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm5, zmm4, zmm5
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm7, zmm6, zmm7
    vaesenclast zmm0, zmm0, zmm15
    vaesenclast zmm4, zmm4, zmm15
    vaesenclast zmm2, zmm2, ZMMWORD PTR [areionRC4x + 512]
    vaesenclast zmm6, zmm6, ZMMWORD PTR [areionRC4x2 + 512]
    vaesenc zmm2, zmm2, zmm15
    vaesenc zmm6, zmm6, zmm15
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm6, zmm5, zmm6
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm4, zmm7, zmm4
    vaesenclast zmm1, zmm1, zmm15
    vaesenclast zmm5, zmm5, zmm15
    vaesenclast zmm3, zmm3, ZMMWORD PTR [areionRC4x + 576]
    vaesenclast zmm7, zmm7, ZMMWORD PTR [areionRC4x2 + 576]
    vaesenc zmm3, zmm3, zmm15
    vaesenc zmm7, zmm7, zmm15
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm7, zmm6, zmm7
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm5, zmm4, zmm5
    vaesenclast zmm2, zmm2, zmm15
    vaesenclast zmm6, zmm6, zmm15
    vaesenclast zmm0, zmm0, ZMMWORD PTR [areionRC4x + 640]
    vaesenclast zmm4, zmm4, ZMMWORD PTR [areionRC4x2 + 640]
    vaesenc zmm0, zmm0, zmm15
    vaesenc zmm4, zmm4, zmm15
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm4, zmm7, zmm4
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm6, zmm5, zmm6
    vaesenclast zmm3, zmm3, zmm15
    vaesenclast zmm7, zmm7, zmm15
    vaesenclast zmm1, zmm1, ZMMWORD PTR [areionRC4x + 704]
    vaesenclast zmm5, zmm5, ZMMWORD PTR [areionRC4x2 + 704]
    vaesenc zmm1, zmm1, zmm15
    vaesenc zmm5, zmm5, zmm15
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm5, zmm4, zmm5
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm7, zmm6, zmm7
    vaesenclast zmm0, zmm0, zmm15
    vaesenclast zmm4, zmm4, zmm15
    vaesenclast zmm2, zmm2, ZMMWORD PTR [areionRC4x + 768]
    vaesenclast zmm6, zmm6, ZMMWORD PTR [areionRC4x2 + 768]
    vaesenc zmm2, zmm2, zmm15
    vaesenc zmm6, zmm6, zmm15
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm6, zmm5, zmm6
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm4, zmm7, zmm4
    vaesenclast zmm1, zmm1, zmm15
    vaesenclast zmm5, zmm5, zmm15
    vaesenclast zmm3, zmm3, ZMMWORD PTR [areionRC4x + 832]
    vaesenclast zmm7, zmm7, ZMMWORD PTR [areionRC4x2 + 832]
    vaesenc zmm3, zmm3, zmm15
    vaesenc zmm7, zmm7, zmm15
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm7, zmm6, zmm7
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm5, zmm4, zmm5
    vaesenclast zmm2, zmm2, zmm15
    vaesenclast zmm6, zmm6, zmm15
    vaesenclast zmm0, zmm0, ZMMWORD PTR [areionRC4x + 896]
    vaesenclast zmm4, zmm4, ZMMWORD PTR [areionRC4x2 + 896]
    vaesenc zmm0, zmm0, zmm15
    vaesenc zmm4, zmm4, zmm15
    vpxord zmm3, zmm3, zmm7
    vpxord zmm0, zmm0, zmm4
    vpxord zmm1, zmm1, zmm5
    vpxord zmm2, zmm2, zmm6
    vshufi64x2 zmm24, zmm3, zmm0, 68
    vshufi64x2 zmm25, zmm3, zmm0, 238
    vshufi64x2 zmm26, zmm1, zmm2, 68
    vshufi64x2 zmm27, zmm1, zmm2, 238
    vshufi64x2 zmm16, zmm24, zmm26, 136
    vshufi64x2 zmm17, zmm24, zmm26, 221
    vshufi64x2 zmm18, zmm25, zmm27, 136
    vshufi64x2 zmm19, zmm25, zmm27, 221
    vpxord zmm16, zmm16, ZMMWORD PTR [rax]
    vpxord zmm16, zmm16, ZMMWORD PTR [rax + 64]
    vmovdqu64 ZMMWORD PTR [rdx], zmm16
    vpxord zmm17, zmm17, ZMMWORD PTR [rax + 128]
    vpxord zmm17, zmm17, ZMMWORD PTR [rax + 192]
    vmovdqu64 ZMMWORD PTR [rdx + 64], zmm17
    vpxord zmm18, zmm18, ZMMWORD PTR [rax + 256]
    vpxord zmm18, zmm18, ZMMWORD PTR [rax + 320]
    vmovdqu64 ZMMWORD PTR [rdx + 128], zmm18
    vpxord zmm19, zmm19, ZMMWORD PTR [rax + 384]
    vpxord zmm19, zmm19, ZMMWORD PTR [rax + 448]
    vmovdqu64 ZMMWORD PTR [rdx + 192], zmm19
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm4, xmm4, xmm4
    vpxord xmm5, xmm5, xmm5
    vpxord xmm6, xmm6, xmm6
    vpxord xmm7, xmm7, xmm7
    vpxord xmm15, xmm15, xmm15
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
    vzeroupper
    ret
areion512SoEMPermutex4Interleaved ENDP

PUBLIC areion512SoEMPermutex4VaesAvx2
ALIGN 16
areion512SoEMPermutex4VaesAvx2 PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 72
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm14
    vmovdqu XMMWORD PTR [rsp + 48], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vmovdqu ymm14, YMMWORD PTR [r10]
    vmovdqu ymm1, YMMWORD PTR [r10 + 64]
    vperm2i128 ymm0, ymm14, ymm1, 32
    vperm2i128 ymm1, ymm14, ymm1, 49
    vmovdqu ymm14, YMMWORD PTR [r10 + 32]
    vmovdqu ymm3, YMMWORD PTR [r10 + 96]
    vperm2i128 ymm2, ymm14, ymm3, 32
    vperm2i128 ymm3, ymm14, ymm3, 49
    vmovdqu xmm14, XMMWORD PTR [rax + 64]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 192], 1
    vpxor ymm4, ymm0, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 80]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 208], 1
    vpxor ymm5, ymm1, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 96]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 224], 1
    vpxor ymm6, ymm2, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 112]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 240], 1
    vpxor ymm7, ymm3, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 128], 1
    vpxor ymm0, ymm0, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 16]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 144], 1
    vpxor ymm1, ymm1, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 32]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 160], 1
    vpxor ymm2, ymm2, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 48]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 176], 1
    vpxor ymm3, ymm3, ymm14
    vpxor ymm15, ymm15, ymm15
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
    vmovdqu xmm14, XMMWORD PTR [rax]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 128], 1
    vpxor ymm3, ymm3, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 16]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 144], 1
    vpxor ymm0, ymm0, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 32]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 160], 1
    vpxor ymm1, ymm1, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 48]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 176], 1
    vpxor ymm2, ymm2, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 64]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 192], 1
    vpxor ymm3, ymm3, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 80]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 208], 1
    vpxor ymm0, ymm0, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 96]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 224], 1
    vpxor ymm1, ymm1, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 112]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 240], 1
    vpxor ymm2, ymm2, ymm14
    vperm2i128 ymm14, ymm3, ymm0, 32
    vperm2i128 ymm0, ymm3, ymm0, 49
    vmovdqu YMMWORD PTR [rdx], ymm14
    vmovdqu YMMWORD PTR [rdx + 64], ymm0
    vperm2i128 ymm14, ymm1, ymm2, 32
    vperm2i128 ymm2, ymm1, ymm2, 49
    vmovdqu YMMWORD PTR [rdx + 32], ymm14
    vmovdqu YMMWORD PTR [rdx + 96], ymm2
    vmovdqu ymm14, YMMWORD PTR [r10 + 128]
    vmovdqu ymm1, YMMWORD PTR [r10 + 192]
    vperm2i128 ymm0, ymm14, ymm1, 32
    vperm2i128 ymm1, ymm14, ymm1, 49
    vmovdqu ymm14, YMMWORD PTR [r10 + 160]
    vmovdqu ymm3, YMMWORD PTR [r10 + 224]
    vperm2i128 ymm2, ymm14, ymm3, 32
    vperm2i128 ymm3, ymm14, ymm3, 49
    vmovdqu xmm14, XMMWORD PTR [rax + 320]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 448], 1
    vpxor ymm4, ymm0, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 336]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 464], 1
    vpxor ymm5, ymm1, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 352]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 480], 1
    vpxor ymm6, ymm2, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 368]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 496], 1
    vpxor ymm7, ymm3, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 256]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 384], 1
    vpxor ymm0, ymm0, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 272]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 400], 1
    vpxor ymm1, ymm1, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 288]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 416], 1
    vpxor ymm2, ymm2, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 304]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 432], 1
    vpxor ymm3, ymm3, ymm14
    vpxor ymm15, ymm15, ymm15
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
    vmovdqu xmm14, XMMWORD PTR [rax + 256]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 384], 1
    vpxor ymm3, ymm3, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 272]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 400], 1
    vpxor ymm0, ymm0, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 288]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 416], 1
    vpxor ymm1, ymm1, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 304]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 432], 1
    vpxor ymm2, ymm2, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 320]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 448], 1
    vpxor ymm3, ymm3, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 336]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 464], 1
    vpxor ymm0, ymm0, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 352]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 480], 1
    vpxor ymm1, ymm1, ymm14
    vmovdqu xmm14, XMMWORD PTR [rax + 368]
    vinserti128 ymm14, ymm14, XMMWORD PTR [rax + 496], 1
    vpxor ymm2, ymm2, ymm14
    vperm2i128 ymm14, ymm3, ymm0, 32
    vperm2i128 ymm0, ymm3, ymm0, 49
    vmovdqu YMMWORD PTR [rdx + 128], ymm14
    vmovdqu YMMWORD PTR [rdx + 192], ymm0
    vperm2i128 ymm14, ymm1, ymm2, 32
    vperm2i128 ymm2, ymm1, ymm2, 49
    vmovdqu YMMWORD PTR [rdx + 160], ymm14
    vmovdqu YMMWORD PTR [rdx + 224], ymm2
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm14, xmm14, xmm14
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
    vmovdqu xmm14, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    add rsp, 72
    vzeroupper
    ret
areion512SoEMPermutex4VaesAvx2 ENDP

END
