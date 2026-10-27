/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#if defined(__x86_64__) || defined(_M_X64)
#include "asm_abi.h"

.text

AREION_FUNC_START(areion512SoEMPermutex4Interleaved)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $56, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm7, 16(%rsp)
    vmovdqu %xmm15, 32(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    vmovdqu64 0(%r10), %ymm16
    vinserti64x4 $1, 64(%r10), %zmm16, %zmm16
    vmovdqu64 128(%r10), %ymm17
    vinserti64x4 $1, 192(%r10), %zmm17, %zmm17
    vshufi64x2 $0x88, %zmm17, %zmm16, %zmm0
    vshufi64x2 $0xdd, %zmm17, %zmm16, %zmm1
    vmovdqu64 32(%r10), %ymm16
    vinserti64x4 $1, 96(%r10), %zmm16, %zmm16
    vmovdqu64 160(%r10), %ymm17
    vinserti64x4 $1, 224(%r10), %zmm17, %zmm17
    vshufi64x2 $0x88, %zmm17, %zmm16, %zmm2
    vshufi64x2 $0xdd, %zmm17, %zmm16, %zmm3
    vmovdqu64 64(%rax), %ymm16
    vinserti64x4 $1, 192(%rax), %zmm16, %zmm16
    vmovdqu64 320(%rax), %ymm17
    vinserti64x4 $1, 448(%rax), %zmm17, %zmm17
    vshufi64x2 $0x88, %zmm17, %zmm16, %zmm18
    vshufi64x2 $0xdd, %zmm17, %zmm16, %zmm17
    vpxord %zmm18, %zmm0, %zmm4
    vpxord %zmm17, %zmm1, %zmm5
    vmovdqu64 96(%rax), %ymm16
    vinserti64x4 $1, 224(%rax), %zmm16, %zmm16
    vmovdqu64 352(%rax), %ymm17
    vinserti64x4 $1, 480(%rax), %zmm17, %zmm17
    vshufi64x2 $0x88, %zmm17, %zmm16, %zmm18
    vshufi64x2 $0xdd, %zmm17, %zmm16, %zmm17
    vpxord %zmm18, %zmm2, %zmm6
    vpxord %zmm17, %zmm3, %zmm7
    vmovdqu64 0(%rax), %ymm16
    vinserti64x4 $1, 128(%rax), %zmm16, %zmm16
    vmovdqu64 256(%rax), %ymm17
    vinserti64x4 $1, 384(%rax), %zmm17, %zmm17
    vshufi64x2 $0x88, %zmm17, %zmm16, %zmm18
    vshufi64x2 $0xdd, %zmm17, %zmm16, %zmm17
    vpxord %zmm18, %zmm0, %zmm0
    vpxord %zmm17, %zmm1, %zmm1
    vmovdqu64 32(%rax), %ymm16
    vinserti64x4 $1, 160(%rax), %zmm16, %zmm16
    vmovdqu64 288(%rax), %ymm17
    vinserti64x4 $1, 416(%rax), %zmm17, %zmm17
    vshufi64x2 $0x88, %zmm17, %zmm16, %zmm18
    vshufi64x2 $0xdd, %zmm17, %zmm16, %zmm17
    vpxord %zmm18, %zmm2, %zmm2
    vpxord %zmm17, %zmm3, %zmm3
    vpxord %zmm15, %zmm15, %zmm15
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm5, %zmm4, %zmm5
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm7, %zmm6, %zmm7
    vaesenclast %zmm15, %zmm0, %zmm0
    vaesenclast %zmm15, %zmm4, %zmm4
    vaesenclast AREION_SYM(areionRC4x)(%rip), %zmm2, %zmm2
    vaesenclast AREION_SYM(areionRC4x2)(%rip), %zmm6, %zmm6
    vaesenc %zmm15, %zmm2, %zmm2
    vaesenc %zmm15, %zmm6, %zmm6
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm6, %zmm5, %zmm6
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm4, %zmm7, %zmm4
    vaesenclast %zmm15, %zmm1, %zmm1
    vaesenclast %zmm15, %zmm5, %zmm5
    vaesenclast 64+AREION_SYM(areionRC4x)(%rip), %zmm3, %zmm3
    vaesenclast 64+AREION_SYM(areionRC4x2)(%rip), %zmm7, %zmm7
    vaesenc %zmm15, %zmm3, %zmm3
    vaesenc %zmm15, %zmm7, %zmm7
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm7, %zmm6, %zmm7
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm5, %zmm4, %zmm5
    vaesenclast %zmm15, %zmm2, %zmm2
    vaesenclast %zmm15, %zmm6, %zmm6
    vaesenclast 128+AREION_SYM(areionRC4x)(%rip), %zmm0, %zmm0
    vaesenclast 128+AREION_SYM(areionRC4x2)(%rip), %zmm4, %zmm4
    vaesenc %zmm15, %zmm0, %zmm0
    vaesenc %zmm15, %zmm4, %zmm4
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm4, %zmm7, %zmm4
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm6, %zmm5, %zmm6
    vaesenclast %zmm15, %zmm3, %zmm3
    vaesenclast %zmm15, %zmm7, %zmm7
    vaesenclast 192+AREION_SYM(areionRC4x)(%rip), %zmm1, %zmm1
    vaesenclast 192+AREION_SYM(areionRC4x2)(%rip), %zmm5, %zmm5
    vaesenc %zmm15, %zmm1, %zmm1
    vaesenc %zmm15, %zmm5, %zmm5
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm5, %zmm4, %zmm5
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm7, %zmm6, %zmm7
    vaesenclast %zmm15, %zmm0, %zmm0
    vaesenclast %zmm15, %zmm4, %zmm4
    vaesenclast 256+AREION_SYM(areionRC4x)(%rip), %zmm2, %zmm2
    vaesenclast 256+AREION_SYM(areionRC4x2)(%rip), %zmm6, %zmm6
    vaesenc %zmm15, %zmm2, %zmm2
    vaesenc %zmm15, %zmm6, %zmm6
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm6, %zmm5, %zmm6
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm4, %zmm7, %zmm4
    vaesenclast %zmm15, %zmm1, %zmm1
    vaesenclast %zmm15, %zmm5, %zmm5
    vaesenclast 320+AREION_SYM(areionRC4x)(%rip), %zmm3, %zmm3
    vaesenclast 320+AREION_SYM(areionRC4x2)(%rip), %zmm7, %zmm7
    vaesenc %zmm15, %zmm3, %zmm3
    vaesenc %zmm15, %zmm7, %zmm7
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm7, %zmm6, %zmm7
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm5, %zmm4, %zmm5
    vaesenclast %zmm15, %zmm2, %zmm2
    vaesenclast %zmm15, %zmm6, %zmm6
    vaesenclast 384+AREION_SYM(areionRC4x)(%rip), %zmm0, %zmm0
    vaesenclast 384+AREION_SYM(areionRC4x2)(%rip), %zmm4, %zmm4
    vaesenc %zmm15, %zmm0, %zmm0
    vaesenc %zmm15, %zmm4, %zmm4
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm4, %zmm7, %zmm4
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm6, %zmm5, %zmm6
    vaesenclast %zmm15, %zmm3, %zmm3
    vaesenclast %zmm15, %zmm7, %zmm7
    vaesenclast 448+AREION_SYM(areionRC4x)(%rip), %zmm1, %zmm1
    vaesenclast 448+AREION_SYM(areionRC4x2)(%rip), %zmm5, %zmm5
    vaesenc %zmm15, %zmm1, %zmm1
    vaesenc %zmm15, %zmm5, %zmm5
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm5, %zmm4, %zmm5
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm7, %zmm6, %zmm7
    vaesenclast %zmm15, %zmm0, %zmm0
    vaesenclast %zmm15, %zmm4, %zmm4
    vaesenclast 512+AREION_SYM(areionRC4x)(%rip), %zmm2, %zmm2
    vaesenclast 512+AREION_SYM(areionRC4x2)(%rip), %zmm6, %zmm6
    vaesenc %zmm15, %zmm2, %zmm2
    vaesenc %zmm15, %zmm6, %zmm6
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm6, %zmm5, %zmm6
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm4, %zmm7, %zmm4
    vaesenclast %zmm15, %zmm1, %zmm1
    vaesenclast %zmm15, %zmm5, %zmm5
    vaesenclast 576+AREION_SYM(areionRC4x)(%rip), %zmm3, %zmm3
    vaesenclast 576+AREION_SYM(areionRC4x2)(%rip), %zmm7, %zmm7
    vaesenc %zmm15, %zmm3, %zmm3
    vaesenc %zmm15, %zmm7, %zmm7
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm7, %zmm6, %zmm7
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm5, %zmm4, %zmm5
    vaesenclast %zmm15, %zmm2, %zmm2
    vaesenclast %zmm15, %zmm6, %zmm6
    vaesenclast 640+AREION_SYM(areionRC4x)(%rip), %zmm0, %zmm0
    vaesenclast 640+AREION_SYM(areionRC4x2)(%rip), %zmm4, %zmm4
    vaesenc %zmm15, %zmm0, %zmm0
    vaesenc %zmm15, %zmm4, %zmm4
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm4, %zmm7, %zmm4
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm6, %zmm5, %zmm6
    vaesenclast %zmm15, %zmm3, %zmm3
    vaesenclast %zmm15, %zmm7, %zmm7
    vaesenclast 704+AREION_SYM(areionRC4x)(%rip), %zmm1, %zmm1
    vaesenclast 704+AREION_SYM(areionRC4x2)(%rip), %zmm5, %zmm5
    vaesenc %zmm15, %zmm1, %zmm1
    vaesenc %zmm15, %zmm5, %zmm5
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm5, %zmm4, %zmm5
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm7, %zmm6, %zmm7
    vaesenclast %zmm15, %zmm0, %zmm0
    vaesenclast %zmm15, %zmm4, %zmm4
    vaesenclast 768+AREION_SYM(areionRC4x)(%rip), %zmm2, %zmm2
    vaesenclast 768+AREION_SYM(areionRC4x2)(%rip), %zmm6, %zmm6
    vaesenc %zmm15, %zmm2, %zmm2
    vaesenc %zmm15, %zmm6, %zmm6
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm6, %zmm5, %zmm6
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm4, %zmm7, %zmm4
    vaesenclast %zmm15, %zmm1, %zmm1
    vaesenclast %zmm15, %zmm5, %zmm5
    vaesenclast 832+AREION_SYM(areionRC4x)(%rip), %zmm3, %zmm3
    vaesenclast 832+AREION_SYM(areionRC4x2)(%rip), %zmm7, %zmm7
    vaesenc %zmm15, %zmm3, %zmm3
    vaesenc %zmm15, %zmm7, %zmm7
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm7, %zmm6, %zmm7
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm5, %zmm4, %zmm5
    vaesenclast %zmm15, %zmm2, %zmm2
    vaesenclast %zmm15, %zmm6, %zmm6
    vaesenclast 896+AREION_SYM(areionRC4x)(%rip), %zmm0, %zmm0
    vaesenclast 896+AREION_SYM(areionRC4x2)(%rip), %zmm4, %zmm4
    vaesenc %zmm15, %zmm0, %zmm0
    vaesenc %zmm15, %zmm4, %zmm4
    vpxord %zmm7, %zmm3, %zmm3
    vpxord %zmm4, %zmm0, %zmm0
    vpxord %zmm5, %zmm1, %zmm1
    vpxord %zmm6, %zmm2, %zmm2
    vmovdqu64 0(%rax), %ymm16
    vinserti64x4 $1, 128(%rax), %zmm16, %zmm16
    vmovdqu64 256(%rax), %ymm17
    vinserti64x4 $1, 384(%rax), %zmm17, %zmm17
    vshufi64x2 $0x88, %zmm17, %zmm16, %zmm18
    vshufi64x2 $0xdd, %zmm17, %zmm16, %zmm17
    vpxord %zmm18, %zmm3, %zmm3
    vpxord %zmm17, %zmm0, %zmm0
    vmovdqu64 32(%rax), %ymm16
    vinserti64x4 $1, 160(%rax), %zmm16, %zmm16
    vmovdqu64 288(%rax), %ymm17
    vinserti64x4 $1, 416(%rax), %zmm17, %zmm17
    vshufi64x2 $0x88, %zmm17, %zmm16, %zmm18
    vshufi64x2 $0xdd, %zmm17, %zmm16, %zmm17
    vpxord %zmm18, %zmm1, %zmm1
    vpxord %zmm17, %zmm2, %zmm2
    vmovdqu64 64(%rax), %ymm16
    vinserti64x4 $1, 192(%rax), %zmm16, %zmm16
    vmovdqu64 320(%rax), %ymm17
    vinserti64x4 $1, 448(%rax), %zmm17, %zmm17
    vshufi64x2 $0x88, %zmm17, %zmm16, %zmm18
    vshufi64x2 $0xdd, %zmm17, %zmm16, %zmm17
    vpxord %zmm18, %zmm3, %zmm3
    vpxord %zmm17, %zmm0, %zmm0
    vmovdqu64 96(%rax), %ymm16
    vinserti64x4 $1, 224(%rax), %zmm16, %zmm16
    vmovdqu64 352(%rax), %ymm17
    vinserti64x4 $1, 480(%rax), %zmm17, %zmm17
    vshufi64x2 $0x88, %zmm17, %zmm16, %zmm18
    vshufi64x2 $0xdd, %zmm17, %zmm16, %zmm17
    vpxord %zmm18, %zmm1, %zmm1
    vpxord %zmm17, %zmm2, %zmm2
    vshufi64x2 $0x44, %zmm0, %zmm3, %zmm16
    vshufi64x2 $0xee, %zmm0, %zmm3, %zmm17
    vshufi64x2 $0xd8, %zmm16, %zmm16, %zmm16
    vshufi64x2 $0xd8, %zmm17, %zmm17, %zmm17
    vmovdqu64 %ymm16, 0(%rdx)
    vextracti64x4 $1, %zmm16, 64(%rdx)
    vmovdqu64 %ymm17, 128(%rdx)
    vextracti64x4 $1, %zmm17, 192(%rdx)
    vshufi64x2 $0x44, %zmm2, %zmm1, %zmm16
    vshufi64x2 $0xee, %zmm2, %zmm1, %zmm17
    vshufi64x2 $0xd8, %zmm16, %zmm16, %zmm16
    vshufi64x2 $0xd8, %zmm17, %zmm17, %zmm17
    vmovdqu64 %ymm16, 32(%rdx)
    vextracti64x4 $1, %zmm16, 96(%rdx)
    vmovdqu64 %ymm17, 160(%rdx)
    vextracti64x4 $1, %zmm17, 224(%rdx)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    vpxord %xmm6, %xmm6, %xmm6
    vpxord %xmm7, %xmm7, %xmm7
    vpxord %xmm15, %xmm15, %xmm15
    vpxord %xmm16, %xmm16, %xmm16
    vpxord %xmm17, %xmm17, %xmm17
    vpxord %xmm18, %xmm18, %xmm18
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm6
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm7
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm15
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    addq $56, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion512SoEMPermutex4Interleaved)

AREION_FUNC_START(areion512SoEMPermutex4VaesAvx2)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $72, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm7, 16(%rsp)
    vmovdqu %xmm14, 32(%rsp)
    vmovdqu %xmm15, 48(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    vmovdqu 0(%r10), %ymm14
    vmovdqu 64(%r10), %ymm1
    vperm2i128 $0x20, %ymm1, %ymm14, %ymm0
    vperm2i128 $0x31, %ymm1, %ymm14, %ymm1
    vmovdqu 32(%r10), %ymm14
    vmovdqu 96(%r10), %ymm3
    vperm2i128 $0x20, %ymm3, %ymm14, %ymm2
    vperm2i128 $0x31, %ymm3, %ymm14, %ymm3
    vmovdqu 64(%rax), %xmm14
    vinserti128 $1, 192(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm0, %ymm4
    vmovdqu 80(%rax), %xmm14
    vinserti128 $1, 208(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm1, %ymm5
    vmovdqu 96(%rax), %xmm14
    vinserti128 $1, 224(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm2, %ymm6
    vmovdqu 112(%rax), %xmm14
    vinserti128 $1, 240(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm3, %ymm7
    vmovdqu 0(%rax), %xmm14
    vinserti128 $1, 128(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm0, %ymm0
    vmovdqu 16(%rax), %xmm14
    vinserti128 $1, 144(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm1, %ymm1
    vmovdqu 32(%rax), %xmm14
    vinserti128 $1, 160(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm2, %ymm2
    vmovdqu 48(%rax), %xmm14
    vinserti128 $1, 176(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm15, %ymm15, %ymm15
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast AREION_SYM(areionRC4x)(%rip), %ymm2, %ymm2
    vaesenclast AREION_SYM(areionRC4x2)(%rip), %ymm6, %ymm6
    vaesenc %ymm15, %ymm2, %ymm2
    vaesenc %ymm15, %ymm6, %ymm6
    vaesenc %ymm2, %ymm1, %ymm2
    vaesenc %ymm6, %ymm5, %ymm6
    vaesenc %ymm0, %ymm3, %ymm0
    vaesenc %ymm4, %ymm7, %ymm4
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenclast 64+AREION_SYM(areionRC4x)(%rip), %ymm3, %ymm3
    vaesenclast 64+AREION_SYM(areionRC4x2)(%rip), %ymm7, %ymm7
    vaesenc %ymm15, %ymm3, %ymm3
    vaesenc %ymm15, %ymm7, %ymm7
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast 128+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm0
    vaesenclast 128+AREION_SYM(areionRC4x2)(%rip), %ymm4, %ymm4
    vaesenc %ymm15, %ymm0, %ymm0
    vaesenc %ymm15, %ymm4, %ymm4
    vaesenc %ymm0, %ymm3, %ymm0
    vaesenc %ymm4, %ymm7, %ymm4
    vaesenc %ymm2, %ymm1, %ymm2
    vaesenc %ymm6, %ymm5, %ymm6
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenclast %ymm15, %ymm7, %ymm7
    vaesenclast 192+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm1
    vaesenclast 192+AREION_SYM(areionRC4x2)(%rip), %ymm5, %ymm5
    vaesenc %ymm15, %ymm1, %ymm1
    vaesenc %ymm15, %ymm5, %ymm5
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast 256+AREION_SYM(areionRC4x)(%rip), %ymm2, %ymm2
    vaesenclast 256+AREION_SYM(areionRC4x2)(%rip), %ymm6, %ymm6
    vaesenc %ymm15, %ymm2, %ymm2
    vaesenc %ymm15, %ymm6, %ymm6
    vaesenc %ymm2, %ymm1, %ymm2
    vaesenc %ymm6, %ymm5, %ymm6
    vaesenc %ymm0, %ymm3, %ymm0
    vaesenc %ymm4, %ymm7, %ymm4
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenclast 320+AREION_SYM(areionRC4x)(%rip), %ymm3, %ymm3
    vaesenclast 320+AREION_SYM(areionRC4x2)(%rip), %ymm7, %ymm7
    vaesenc %ymm15, %ymm3, %ymm3
    vaesenc %ymm15, %ymm7, %ymm7
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast 384+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm0
    vaesenclast 384+AREION_SYM(areionRC4x2)(%rip), %ymm4, %ymm4
    vaesenc %ymm15, %ymm0, %ymm0
    vaesenc %ymm15, %ymm4, %ymm4
    vaesenc %ymm0, %ymm3, %ymm0
    vaesenc %ymm4, %ymm7, %ymm4
    vaesenc %ymm2, %ymm1, %ymm2
    vaesenc %ymm6, %ymm5, %ymm6
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenclast %ymm15, %ymm7, %ymm7
    vaesenclast 448+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm1
    vaesenclast 448+AREION_SYM(areionRC4x2)(%rip), %ymm5, %ymm5
    vaesenc %ymm15, %ymm1, %ymm1
    vaesenc %ymm15, %ymm5, %ymm5
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast 512+AREION_SYM(areionRC4x)(%rip), %ymm2, %ymm2
    vaesenclast 512+AREION_SYM(areionRC4x2)(%rip), %ymm6, %ymm6
    vaesenc %ymm15, %ymm2, %ymm2
    vaesenc %ymm15, %ymm6, %ymm6
    vaesenc %ymm2, %ymm1, %ymm2
    vaesenc %ymm6, %ymm5, %ymm6
    vaesenc %ymm0, %ymm3, %ymm0
    vaesenc %ymm4, %ymm7, %ymm4
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenclast 576+AREION_SYM(areionRC4x)(%rip), %ymm3, %ymm3
    vaesenclast 576+AREION_SYM(areionRC4x2)(%rip), %ymm7, %ymm7
    vaesenc %ymm15, %ymm3, %ymm3
    vaesenc %ymm15, %ymm7, %ymm7
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast 640+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm0
    vaesenclast 640+AREION_SYM(areionRC4x2)(%rip), %ymm4, %ymm4
    vaesenc %ymm15, %ymm0, %ymm0
    vaesenc %ymm15, %ymm4, %ymm4
    vaesenc %ymm0, %ymm3, %ymm0
    vaesenc %ymm4, %ymm7, %ymm4
    vaesenc %ymm2, %ymm1, %ymm2
    vaesenc %ymm6, %ymm5, %ymm6
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenclast %ymm15, %ymm7, %ymm7
    vaesenclast 704+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm1
    vaesenclast 704+AREION_SYM(areionRC4x2)(%rip), %ymm5, %ymm5
    vaesenc %ymm15, %ymm1, %ymm1
    vaesenc %ymm15, %ymm5, %ymm5
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast 768+AREION_SYM(areionRC4x)(%rip), %ymm2, %ymm2
    vaesenclast 768+AREION_SYM(areionRC4x2)(%rip), %ymm6, %ymm6
    vaesenc %ymm15, %ymm2, %ymm2
    vaesenc %ymm15, %ymm6, %ymm6
    vaesenc %ymm2, %ymm1, %ymm2
    vaesenc %ymm6, %ymm5, %ymm6
    vaesenc %ymm0, %ymm3, %ymm0
    vaesenc %ymm4, %ymm7, %ymm4
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenclast 832+AREION_SYM(areionRC4x)(%rip), %ymm3, %ymm3
    vaesenclast 832+AREION_SYM(areionRC4x2)(%rip), %ymm7, %ymm7
    vaesenc %ymm15, %ymm3, %ymm3
    vaesenc %ymm15, %ymm7, %ymm7
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast 896+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm0
    vaesenclast 896+AREION_SYM(areionRC4x2)(%rip), %ymm4, %ymm4
    vaesenc %ymm15, %ymm0, %ymm0
    vaesenc %ymm15, %ymm4, %ymm4
    vpxor %ymm7, %ymm3, %ymm3
    vpxor %ymm4, %ymm0, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vmovdqu 0(%rax), %xmm14
    vinserti128 $1, 128(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm3, %ymm3
    vmovdqu 16(%rax), %xmm14
    vinserti128 $1, 144(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm0, %ymm0
    vmovdqu 32(%rax), %xmm14
    vinserti128 $1, 160(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm1, %ymm1
    vmovdqu 48(%rax), %xmm14
    vinserti128 $1, 176(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm2, %ymm2
    vmovdqu 64(%rax), %xmm14
    vinserti128 $1, 192(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm3, %ymm3
    vmovdqu 80(%rax), %xmm14
    vinserti128 $1, 208(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm0, %ymm0
    vmovdqu 96(%rax), %xmm14
    vinserti128 $1, 224(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm1, %ymm1
    vmovdqu 112(%rax), %xmm14
    vinserti128 $1, 240(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm2, %ymm2
    vperm2i128 $0x20, %ymm0, %ymm3, %ymm14
    vperm2i128 $0x31, %ymm0, %ymm3, %ymm0
    vmovdqu %ymm14, 0(%rdx)
    vmovdqu %ymm0, 64(%rdx)
    vperm2i128 $0x20, %ymm2, %ymm1, %ymm14
    vperm2i128 $0x31, %ymm2, %ymm1, %ymm2
    vmovdqu %ymm14, 32(%rdx)
    vmovdqu %ymm2, 96(%rdx)
    vmovdqu 128(%r10), %ymm14
    vmovdqu 192(%r10), %ymm1
    vperm2i128 $0x20, %ymm1, %ymm14, %ymm0
    vperm2i128 $0x31, %ymm1, %ymm14, %ymm1
    vmovdqu 160(%r10), %ymm14
    vmovdqu 224(%r10), %ymm3
    vperm2i128 $0x20, %ymm3, %ymm14, %ymm2
    vperm2i128 $0x31, %ymm3, %ymm14, %ymm3
    vmovdqu 320(%rax), %xmm14
    vinserti128 $1, 448(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm0, %ymm4
    vmovdqu 336(%rax), %xmm14
    vinserti128 $1, 464(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm1, %ymm5
    vmovdqu 352(%rax), %xmm14
    vinserti128 $1, 480(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm2, %ymm6
    vmovdqu 368(%rax), %xmm14
    vinserti128 $1, 496(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm3, %ymm7
    vmovdqu 256(%rax), %xmm14
    vinserti128 $1, 384(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm0, %ymm0
    vmovdqu 272(%rax), %xmm14
    vinserti128 $1, 400(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm1, %ymm1
    vmovdqu 288(%rax), %xmm14
    vinserti128 $1, 416(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm2, %ymm2
    vmovdqu 304(%rax), %xmm14
    vinserti128 $1, 432(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm15, %ymm15, %ymm15
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast AREION_SYM(areionRC4x)(%rip), %ymm2, %ymm2
    vaesenclast AREION_SYM(areionRC4x2)(%rip), %ymm6, %ymm6
    vaesenc %ymm15, %ymm2, %ymm2
    vaesenc %ymm15, %ymm6, %ymm6
    vaesenc %ymm2, %ymm1, %ymm2
    vaesenc %ymm6, %ymm5, %ymm6
    vaesenc %ymm0, %ymm3, %ymm0
    vaesenc %ymm4, %ymm7, %ymm4
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenclast 64+AREION_SYM(areionRC4x)(%rip), %ymm3, %ymm3
    vaesenclast 64+AREION_SYM(areionRC4x2)(%rip), %ymm7, %ymm7
    vaesenc %ymm15, %ymm3, %ymm3
    vaesenc %ymm15, %ymm7, %ymm7
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast 128+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm0
    vaesenclast 128+AREION_SYM(areionRC4x2)(%rip), %ymm4, %ymm4
    vaesenc %ymm15, %ymm0, %ymm0
    vaesenc %ymm15, %ymm4, %ymm4
    vaesenc %ymm0, %ymm3, %ymm0
    vaesenc %ymm4, %ymm7, %ymm4
    vaesenc %ymm2, %ymm1, %ymm2
    vaesenc %ymm6, %ymm5, %ymm6
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenclast %ymm15, %ymm7, %ymm7
    vaesenclast 192+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm1
    vaesenclast 192+AREION_SYM(areionRC4x2)(%rip), %ymm5, %ymm5
    vaesenc %ymm15, %ymm1, %ymm1
    vaesenc %ymm15, %ymm5, %ymm5
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast 256+AREION_SYM(areionRC4x)(%rip), %ymm2, %ymm2
    vaesenclast 256+AREION_SYM(areionRC4x2)(%rip), %ymm6, %ymm6
    vaesenc %ymm15, %ymm2, %ymm2
    vaesenc %ymm15, %ymm6, %ymm6
    vaesenc %ymm2, %ymm1, %ymm2
    vaesenc %ymm6, %ymm5, %ymm6
    vaesenc %ymm0, %ymm3, %ymm0
    vaesenc %ymm4, %ymm7, %ymm4
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenclast 320+AREION_SYM(areionRC4x)(%rip), %ymm3, %ymm3
    vaesenclast 320+AREION_SYM(areionRC4x2)(%rip), %ymm7, %ymm7
    vaesenc %ymm15, %ymm3, %ymm3
    vaesenc %ymm15, %ymm7, %ymm7
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast 384+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm0
    vaesenclast 384+AREION_SYM(areionRC4x2)(%rip), %ymm4, %ymm4
    vaesenc %ymm15, %ymm0, %ymm0
    vaesenc %ymm15, %ymm4, %ymm4
    vaesenc %ymm0, %ymm3, %ymm0
    vaesenc %ymm4, %ymm7, %ymm4
    vaesenc %ymm2, %ymm1, %ymm2
    vaesenc %ymm6, %ymm5, %ymm6
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenclast %ymm15, %ymm7, %ymm7
    vaesenclast 448+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm1
    vaesenclast 448+AREION_SYM(areionRC4x2)(%rip), %ymm5, %ymm5
    vaesenc %ymm15, %ymm1, %ymm1
    vaesenc %ymm15, %ymm5, %ymm5
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast 512+AREION_SYM(areionRC4x)(%rip), %ymm2, %ymm2
    vaesenclast 512+AREION_SYM(areionRC4x2)(%rip), %ymm6, %ymm6
    vaesenc %ymm15, %ymm2, %ymm2
    vaesenc %ymm15, %ymm6, %ymm6
    vaesenc %ymm2, %ymm1, %ymm2
    vaesenc %ymm6, %ymm5, %ymm6
    vaesenc %ymm0, %ymm3, %ymm0
    vaesenc %ymm4, %ymm7, %ymm4
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenclast 576+AREION_SYM(areionRC4x)(%rip), %ymm3, %ymm3
    vaesenclast 576+AREION_SYM(areionRC4x2)(%rip), %ymm7, %ymm7
    vaesenc %ymm15, %ymm3, %ymm3
    vaesenc %ymm15, %ymm7, %ymm7
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast 640+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm0
    vaesenclast 640+AREION_SYM(areionRC4x2)(%rip), %ymm4, %ymm4
    vaesenc %ymm15, %ymm0, %ymm0
    vaesenc %ymm15, %ymm4, %ymm4
    vaesenc %ymm0, %ymm3, %ymm0
    vaesenc %ymm4, %ymm7, %ymm4
    vaesenc %ymm2, %ymm1, %ymm2
    vaesenc %ymm6, %ymm5, %ymm6
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenclast %ymm15, %ymm7, %ymm7
    vaesenclast 704+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm1
    vaesenclast 704+AREION_SYM(areionRC4x2)(%rip), %ymm5, %ymm5
    vaesenc %ymm15, %ymm1, %ymm1
    vaesenc %ymm15, %ymm5, %ymm5
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast 768+AREION_SYM(areionRC4x)(%rip), %ymm2, %ymm2
    vaesenclast 768+AREION_SYM(areionRC4x2)(%rip), %ymm6, %ymm6
    vaesenc %ymm15, %ymm2, %ymm2
    vaesenc %ymm15, %ymm6, %ymm6
    vaesenc %ymm2, %ymm1, %ymm2
    vaesenc %ymm6, %ymm5, %ymm6
    vaesenc %ymm0, %ymm3, %ymm0
    vaesenc %ymm4, %ymm7, %ymm4
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenclast 832+AREION_SYM(areionRC4x)(%rip), %ymm3, %ymm3
    vaesenclast 832+AREION_SYM(areionRC4x2)(%rip), %ymm7, %ymm7
    vaesenc %ymm15, %ymm3, %ymm3
    vaesenc %ymm15, %ymm7, %ymm7
    vaesenc %ymm3, %ymm2, %ymm3
    vaesenc %ymm7, %ymm6, %ymm7
    vaesenc %ymm1, %ymm0, %ymm1
    vaesenc %ymm5, %ymm4, %ymm5
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast 896+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm0
    vaesenclast 896+AREION_SYM(areionRC4x2)(%rip), %ymm4, %ymm4
    vaesenc %ymm15, %ymm0, %ymm0
    vaesenc %ymm15, %ymm4, %ymm4
    vpxor %ymm7, %ymm3, %ymm3
    vpxor %ymm4, %ymm0, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vmovdqu 256(%rax), %xmm14
    vinserti128 $1, 384(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm3, %ymm3
    vmovdqu 272(%rax), %xmm14
    vinserti128 $1, 400(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm0, %ymm0
    vmovdqu 288(%rax), %xmm14
    vinserti128 $1, 416(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm1, %ymm1
    vmovdqu 304(%rax), %xmm14
    vinserti128 $1, 432(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm2, %ymm2
    vmovdqu 320(%rax), %xmm14
    vinserti128 $1, 448(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm3, %ymm3
    vmovdqu 336(%rax), %xmm14
    vinserti128 $1, 464(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm0, %ymm0
    vmovdqu 352(%rax), %xmm14
    vinserti128 $1, 480(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm1, %ymm1
    vmovdqu 368(%rax), %xmm14
    vinserti128 $1, 496(%rax), %ymm14, %ymm14
    vpxor %ymm14, %ymm2, %ymm2
    vperm2i128 $0x20, %ymm0, %ymm3, %ymm14
    vperm2i128 $0x31, %ymm0, %ymm3, %ymm0
    vmovdqu %ymm14, 128(%rdx)
    vmovdqu %ymm0, 192(%rdx)
    vperm2i128 $0x20, %ymm2, %ymm1, %ymm14
    vperm2i128 $0x31, %ymm2, %ymm1, %ymm2
    vmovdqu %ymm14, 160(%rdx)
    vmovdqu %ymm2, 224(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    vpxor %xmm7, %xmm7, %xmm7
    vpxor %xmm14, %xmm14, %xmm14
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm6
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm7
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm14
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    vmovdqu 48(%rsp), %xmm15
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    addq $72, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion512SoEMPermutex4VaesAvx2)

#endif /* __x86_64__ || _M_X64 */

#if defined(__linux__) && defined(__ELF__)
#if defined(__x86_64__)
.pushsection .note.gnu.property, "a"
.p2align 3
.long 4
.long 16
.long 5
.asciz "GNU"
.long 0xc0000002
.long 4
.long 3
.long 0
.popsection
#elif defined(__aarch64__)
.pushsection .note.gnu.property, "a"
.p2align 3
.long 4
.long 16
.long 5
.asciz "GNU"
.long 0xc0000000
.long 4
.long 3
.long 0
.popsection
#endif
.section .note.GNU-stack,"",%progbits
#endif
