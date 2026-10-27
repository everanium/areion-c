; Copyright (c) 2026 Andrey Kuvshinov
; SPDX-License-Identifier: Apache-2.0 OR MIT

EXTERN roundConstantsP1:BYTE
EXTERN roundConstantsP2:BYTE
EXTERN areionRC4x:BYTE
EXTERN areionRC4x2:BYTE

.code

PUBLIC areion256SoEMPermutex4Interleaved
ALIGN 16
areion256SoEMPermutex4Interleaved PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    mov rdx, r9
    vmovdqu64 zmm0, ZMMWORD PTR [rax]
    vmovdqu64 zmm1, ZMMWORD PTR [r10]
    vmovdqu64 zmm4, ZMMWORD PTR [rcx]
    vmovdqu64 zmm5, ZMMWORD PTR [rdx]
    vpxord zmm3, zmm3, zmm3
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
    vaesenc zmm2, zmm0, zmm16
    vaesenc zmm6, zmm4, ZMMWORD PTR [areionRC4x2]
    vaesenclast zmm0, zmm0, zmm3
    vaesenclast zmm4, zmm4, zmm3
    vaesenc zmm1, zmm2, zmm1
    vaesenc zmm5, zmm6, zmm5
    vaesenc zmm2, zmm1, zmm17
    vaesenc zmm6, zmm5, ZMMWORD PTR [areionRC4x2 + 64]
    vaesenclast zmm1, zmm1, zmm3
    vaesenclast zmm5, zmm5, zmm3
    vaesenc zmm0, zmm2, zmm0
    vaesenc zmm4, zmm6, zmm4
    vaesenc zmm2, zmm0, zmm18
    vaesenc zmm6, zmm4, ZMMWORD PTR [areionRC4x2 + 128]
    vaesenclast zmm0, zmm0, zmm3
    vaesenclast zmm4, zmm4, zmm3
    vaesenc zmm1, zmm2, zmm1
    vaesenc zmm5, zmm6, zmm5
    vaesenc zmm2, zmm1, zmm19
    vaesenc zmm6, zmm5, ZMMWORD PTR [areionRC4x2 + 192]
    vaesenclast zmm1, zmm1, zmm3
    vaesenclast zmm5, zmm5, zmm3
    vaesenc zmm0, zmm2, zmm0
    vaesenc zmm4, zmm6, zmm4
    vaesenc zmm2, zmm0, zmm20
    vaesenc zmm6, zmm4, ZMMWORD PTR [areionRC4x2 + 256]
    vaesenclast zmm0, zmm0, zmm3
    vaesenclast zmm4, zmm4, zmm3
    vaesenc zmm1, zmm2, zmm1
    vaesenc zmm5, zmm6, zmm5
    vaesenc zmm2, zmm1, zmm21
    vaesenc zmm6, zmm5, ZMMWORD PTR [areionRC4x2 + 320]
    vaesenclast zmm1, zmm1, zmm3
    vaesenclast zmm5, zmm5, zmm3
    vaesenc zmm0, zmm2, zmm0
    vaesenc zmm4, zmm6, zmm4
    vaesenc zmm2, zmm0, zmm22
    vaesenc zmm6, zmm4, ZMMWORD PTR [areionRC4x2 + 384]
    vaesenclast zmm0, zmm0, zmm3
    vaesenclast zmm4, zmm4, zmm3
    vaesenc zmm1, zmm2, zmm1
    vaesenc zmm5, zmm6, zmm5
    vaesenc zmm2, zmm1, zmm23
    vaesenc zmm6, zmm5, ZMMWORD PTR [areionRC4x2 + 448]
    vaesenclast zmm1, zmm1, zmm3
    vaesenclast zmm5, zmm5, zmm3
    vaesenc zmm0, zmm2, zmm0
    vaesenc zmm4, zmm6, zmm4
    vaesenc zmm2, zmm0, zmm24
    vaesenc zmm6, zmm4, ZMMWORD PTR [areionRC4x2 + 512]
    vaesenclast zmm0, zmm0, zmm3
    vaesenclast zmm4, zmm4, zmm3
    vaesenc zmm1, zmm2, zmm1
    vaesenc zmm5, zmm6, zmm5
    vaesenc zmm2, zmm1, zmm25
    vaesenc zmm6, zmm5, ZMMWORD PTR [areionRC4x2 + 576]
    vaesenclast zmm1, zmm1, zmm3
    vaesenclast zmm5, zmm5, zmm3
    vaesenc zmm0, zmm2, zmm0
    vaesenc zmm4, zmm6, zmm4
    vpxord zmm0, zmm0, zmm4
    vpxord zmm1, zmm1, zmm5
    vmovdqu64 ZMMWORD PTR [rax], zmm0
    vmovdqu64 ZMMWORD PTR [r10], zmm1
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm4, xmm4, xmm4
    vpxord xmm5, xmm5, xmm5
    vpxord xmm6, xmm6, xmm6
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
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    xor r11, r11
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    vzeroupper
    ret
areion256SoEMPermutex4Interleaved ENDP

PUBLIC areion256SoEMPermutex4VaesAvx2
ALIGN 16
areion256SoEMPermutex4VaesAvx2 PROC
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
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    mov rdx, r9
    vmovdqu ymm0, YMMWORD PTR [rax]
    vmovdqu ymm1, YMMWORD PTR [rax + 32]
    vmovdqu ymm2, YMMWORD PTR [r10]
    vmovdqu ymm3, YMMWORD PTR [r10 + 32]
    vmovdqu ymm4, YMMWORD PTR [rcx]
    vmovdqu ymm5, YMMWORD PTR [rcx + 32]
    vmovdqu ymm6, YMMWORD PTR [rdx]
    vmovdqu ymm7, YMMWORD PTR [rdx + 32]
    vpxor ymm15, ymm15, ymm15
    vmovdqu ymm12, YMMWORD PTR [areionRC4x]
    vmovdqu ymm13, YMMWORD PTR [areionRC4x2]
    vaesenc ymm8, ymm0, ymm12
    vaesenc ymm9, ymm1, ymm12
    vaesenc ymm10, ymm4, ymm13
    vaesenc ymm11, ymm5, ymm13
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenc ymm2, ymm8, ymm2
    vaesenc ymm3, ymm9, ymm3
    vaesenc ymm6, ymm10, ymm6
    vaesenc ymm7, ymm11, ymm7
    vmovdqu ymm12, YMMWORD PTR [areionRC4x + 64]
    vmovdqu ymm13, YMMWORD PTR [areionRC4x2 + 64]
    vaesenc ymm8, ymm2, ymm12
    vaesenc ymm9, ymm3, ymm12
    vaesenc ymm10, ymm6, ymm13
    vaesenc ymm11, ymm7, ymm13
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm7, ymm7, ymm15
    vaesenc ymm0, ymm8, ymm0
    vaesenc ymm1, ymm9, ymm1
    vaesenc ymm4, ymm10, ymm4
    vaesenc ymm5, ymm11, ymm5
    vmovdqu ymm12, YMMWORD PTR [areionRC4x + 128]
    vmovdqu ymm13, YMMWORD PTR [areionRC4x2 + 128]
    vaesenc ymm8, ymm0, ymm12
    vaesenc ymm9, ymm1, ymm12
    vaesenc ymm10, ymm4, ymm13
    vaesenc ymm11, ymm5, ymm13
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenc ymm2, ymm8, ymm2
    vaesenc ymm3, ymm9, ymm3
    vaesenc ymm6, ymm10, ymm6
    vaesenc ymm7, ymm11, ymm7
    vmovdqu ymm12, YMMWORD PTR [areionRC4x + 192]
    vmovdqu ymm13, YMMWORD PTR [areionRC4x2 + 192]
    vaesenc ymm8, ymm2, ymm12
    vaesenc ymm9, ymm3, ymm12
    vaesenc ymm10, ymm6, ymm13
    vaesenc ymm11, ymm7, ymm13
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm7, ymm7, ymm15
    vaesenc ymm0, ymm8, ymm0
    vaesenc ymm1, ymm9, ymm1
    vaesenc ymm4, ymm10, ymm4
    vaesenc ymm5, ymm11, ymm5
    vmovdqu ymm12, YMMWORD PTR [areionRC4x + 256]
    vmovdqu ymm13, YMMWORD PTR [areionRC4x2 + 256]
    vaesenc ymm8, ymm0, ymm12
    vaesenc ymm9, ymm1, ymm12
    vaesenc ymm10, ymm4, ymm13
    vaesenc ymm11, ymm5, ymm13
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenc ymm2, ymm8, ymm2
    vaesenc ymm3, ymm9, ymm3
    vaesenc ymm6, ymm10, ymm6
    vaesenc ymm7, ymm11, ymm7
    vmovdqu ymm12, YMMWORD PTR [areionRC4x + 320]
    vmovdqu ymm13, YMMWORD PTR [areionRC4x2 + 320]
    vaesenc ymm8, ymm2, ymm12
    vaesenc ymm9, ymm3, ymm12
    vaesenc ymm10, ymm6, ymm13
    vaesenc ymm11, ymm7, ymm13
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm7, ymm7, ymm15
    vaesenc ymm0, ymm8, ymm0
    vaesenc ymm1, ymm9, ymm1
    vaesenc ymm4, ymm10, ymm4
    vaesenc ymm5, ymm11, ymm5
    vmovdqu ymm12, YMMWORD PTR [areionRC4x + 384]
    vmovdqu ymm13, YMMWORD PTR [areionRC4x2 + 384]
    vaesenc ymm8, ymm0, ymm12
    vaesenc ymm9, ymm1, ymm12
    vaesenc ymm10, ymm4, ymm13
    vaesenc ymm11, ymm5, ymm13
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenc ymm2, ymm8, ymm2
    vaesenc ymm3, ymm9, ymm3
    vaesenc ymm6, ymm10, ymm6
    vaesenc ymm7, ymm11, ymm7
    vmovdqu ymm12, YMMWORD PTR [areionRC4x + 448]
    vmovdqu ymm13, YMMWORD PTR [areionRC4x2 + 448]
    vaesenc ymm8, ymm2, ymm12
    vaesenc ymm9, ymm3, ymm12
    vaesenc ymm10, ymm6, ymm13
    vaesenc ymm11, ymm7, ymm13
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm7, ymm7, ymm15
    vaesenc ymm0, ymm8, ymm0
    vaesenc ymm1, ymm9, ymm1
    vaesenc ymm4, ymm10, ymm4
    vaesenc ymm5, ymm11, ymm5
    vmovdqu ymm12, YMMWORD PTR [areionRC4x + 512]
    vmovdqu ymm13, YMMWORD PTR [areionRC4x2 + 512]
    vaesenc ymm8, ymm0, ymm12
    vaesenc ymm9, ymm1, ymm12
    vaesenc ymm10, ymm4, ymm13
    vaesenc ymm11, ymm5, ymm13
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenc ymm2, ymm8, ymm2
    vaesenc ymm3, ymm9, ymm3
    vaesenc ymm6, ymm10, ymm6
    vaesenc ymm7, ymm11, ymm7
    vmovdqu ymm12, YMMWORD PTR [areionRC4x + 576]
    vmovdqu ymm13, YMMWORD PTR [areionRC4x2 + 576]
    vaesenc ymm8, ymm2, ymm12
    vaesenc ymm9, ymm3, ymm12
    vaesenc ymm10, ymm6, ymm13
    vaesenc ymm11, ymm7, ymm13
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm7, ymm7, ymm15
    vaesenc ymm0, ymm8, ymm0
    vaesenc ymm1, ymm9, ymm1
    vaesenc ymm4, ymm10, ymm4
    vaesenc ymm5, ymm11, ymm5
    vpxor ymm0, ymm0, ymm4
    vpxor ymm1, ymm1, ymm5
    vpxor ymm2, ymm2, ymm6
    vpxor ymm3, ymm3, ymm7
    vmovdqu YMMWORD PTR [rax], ymm0
    vmovdqu YMMWORD PTR [rax + 32], ymm1
    vmovdqu YMMWORD PTR [r10], ymm2
    vmovdqu YMMWORD PTR [r10 + 32], ymm3
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
    vmovdqu xmm15, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    add rsp, 152
    vzeroupper
    ret
areion256SoEMPermutex4VaesAvx2 ENDP

END
