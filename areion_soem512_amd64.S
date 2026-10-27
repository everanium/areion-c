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
    movq %rdi, %rax
    movq %rsi, %r10
    movq %r8, %rsi
    movq %r9, %rdi
    movq %rdx, %r11
    movq %rcx, %rdx
    movq %r11, %rcx
    movq 8(%rsp), %r8
    movq 16(%rsp), %r9
#else
    subq $104, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm8, 32(%rsp)
    vmovdqu %xmm9, 48(%rsp)
    vmovdqu %xmm10, 64(%rsp)
    vmovdqu %xmm11, 80(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
    movq %r9, %rdx
    movq 144(%rsp), %rsi
    movq 152(%rsp), %rdi
    movq 160(%rsp), %r8
    movq 168(%rsp), %r9
#endif
    vmovdqu64 (%rax), %zmm0
    vmovdqu64 (%r10), %zmm1
    vmovdqu64 (%rcx), %zmm2
    vmovdqu64 (%rdx), %zmm3
    vmovdqu64 (%rsi), %zmm8
    vmovdqu64 (%rdi), %zmm9
    vmovdqu64 (%r8), %zmm10
    vmovdqu64 (%r9), %zmm11
    vpxord %zmm6, %zmm6, %zmm6
    vmovdqu64 AREION_SYM(areionRC4x)(%rip), %zmm16
    vmovdqu64 64+AREION_SYM(areionRC4x)(%rip), %zmm17
    vmovdqu64 128+AREION_SYM(areionRC4x)(%rip), %zmm18
    vmovdqu64 192+AREION_SYM(areionRC4x)(%rip), %zmm19
    vmovdqu64 256+AREION_SYM(areionRC4x)(%rip), %zmm20
    vmovdqu64 320+AREION_SYM(areionRC4x)(%rip), %zmm21
    vmovdqu64 384+AREION_SYM(areionRC4x)(%rip), %zmm22
    vmovdqu64 448+AREION_SYM(areionRC4x)(%rip), %zmm23
    vmovdqu64 512+AREION_SYM(areionRC4x)(%rip), %zmm24
    vmovdqu64 576+AREION_SYM(areionRC4x)(%rip), %zmm25
    vmovdqu64 640+AREION_SYM(areionRC4x)(%rip), %zmm26
    vmovdqu64 704+AREION_SYM(areionRC4x)(%rip), %zmm27
    vmovdqu64 768+AREION_SYM(areionRC4x)(%rip), %zmm28
    vmovdqu64 832+AREION_SYM(areionRC4x)(%rip), %zmm29
    vmovdqu64 896+AREION_SYM(areionRC4x)(%rip), %zmm30
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm9, %zmm8, %zmm9
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm11, %zmm10, %zmm11
    vaesenclast %zmm6, %zmm0, %zmm0
    vaesenclast %zmm6, %zmm8, %zmm8
    vaesenclast %zmm16, %zmm2, %zmm2
    vaesenclast AREION_SYM(areionRC4x2)(%rip), %zmm10, %zmm10
    vaesenc %zmm6, %zmm2, %zmm2
    vaesenc %zmm6, %zmm10, %zmm10
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm10, %zmm9, %zmm10
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm8, %zmm11, %zmm8
    vaesenclast %zmm6, %zmm1, %zmm1
    vaesenclast %zmm6, %zmm9, %zmm9
    vaesenclast %zmm17, %zmm3, %zmm3
    vaesenclast 64+AREION_SYM(areionRC4x2)(%rip), %zmm11, %zmm11
    vaesenc %zmm6, %zmm3, %zmm3
    vaesenc %zmm6, %zmm11, %zmm11
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm11, %zmm10, %zmm11
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm9, %zmm8, %zmm9
    vaesenclast %zmm6, %zmm2, %zmm2
    vaesenclast %zmm6, %zmm10, %zmm10
    vaesenclast %zmm18, %zmm0, %zmm0
    vaesenclast 128+AREION_SYM(areionRC4x2)(%rip), %zmm8, %zmm8
    vaesenc %zmm6, %zmm0, %zmm0
    vaesenc %zmm6, %zmm8, %zmm8
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm8, %zmm11, %zmm8
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm10, %zmm9, %zmm10
    vaesenclast %zmm6, %zmm3, %zmm3
    vaesenclast %zmm6, %zmm11, %zmm11
    vaesenclast %zmm19, %zmm1, %zmm1
    vaesenclast 192+AREION_SYM(areionRC4x2)(%rip), %zmm9, %zmm9
    vaesenc %zmm6, %zmm1, %zmm1
    vaesenc %zmm6, %zmm9, %zmm9
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm9, %zmm8, %zmm9
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm11, %zmm10, %zmm11
    vaesenclast %zmm6, %zmm0, %zmm0
    vaesenclast %zmm6, %zmm8, %zmm8
    vaesenclast %zmm20, %zmm2, %zmm2
    vaesenclast 256+AREION_SYM(areionRC4x2)(%rip), %zmm10, %zmm10
    vaesenc %zmm6, %zmm2, %zmm2
    vaesenc %zmm6, %zmm10, %zmm10
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm10, %zmm9, %zmm10
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm8, %zmm11, %zmm8
    vaesenclast %zmm6, %zmm1, %zmm1
    vaesenclast %zmm6, %zmm9, %zmm9
    vaesenclast %zmm21, %zmm3, %zmm3
    vaesenclast 320+AREION_SYM(areionRC4x2)(%rip), %zmm11, %zmm11
    vaesenc %zmm6, %zmm3, %zmm3
    vaesenc %zmm6, %zmm11, %zmm11
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm11, %zmm10, %zmm11
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm9, %zmm8, %zmm9
    vaesenclast %zmm6, %zmm2, %zmm2
    vaesenclast %zmm6, %zmm10, %zmm10
    vaesenclast %zmm22, %zmm0, %zmm0
    vaesenclast 384+AREION_SYM(areionRC4x2)(%rip), %zmm8, %zmm8
    vaesenc %zmm6, %zmm0, %zmm0
    vaesenc %zmm6, %zmm8, %zmm8
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm8, %zmm11, %zmm8
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm10, %zmm9, %zmm10
    vaesenclast %zmm6, %zmm3, %zmm3
    vaesenclast %zmm6, %zmm11, %zmm11
    vaesenclast %zmm23, %zmm1, %zmm1
    vaesenclast 448+AREION_SYM(areionRC4x2)(%rip), %zmm9, %zmm9
    vaesenc %zmm6, %zmm1, %zmm1
    vaesenc %zmm6, %zmm9, %zmm9
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm9, %zmm8, %zmm9
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm11, %zmm10, %zmm11
    vaesenclast %zmm6, %zmm0, %zmm0
    vaesenclast %zmm6, %zmm8, %zmm8
    vaesenclast %zmm24, %zmm2, %zmm2
    vaesenclast 512+AREION_SYM(areionRC4x2)(%rip), %zmm10, %zmm10
    vaesenc %zmm6, %zmm2, %zmm2
    vaesenc %zmm6, %zmm10, %zmm10
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm10, %zmm9, %zmm10
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm8, %zmm11, %zmm8
    vaesenclast %zmm6, %zmm1, %zmm1
    vaesenclast %zmm6, %zmm9, %zmm9
    vaesenclast %zmm25, %zmm3, %zmm3
    vaesenclast 576+AREION_SYM(areionRC4x2)(%rip), %zmm11, %zmm11
    vaesenc %zmm6, %zmm3, %zmm3
    vaesenc %zmm6, %zmm11, %zmm11
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm11, %zmm10, %zmm11
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm9, %zmm8, %zmm9
    vaesenclast %zmm6, %zmm2, %zmm2
    vaesenclast %zmm6, %zmm10, %zmm10
    vaesenclast %zmm26, %zmm0, %zmm0
    vaesenclast 640+AREION_SYM(areionRC4x2)(%rip), %zmm8, %zmm8
    vaesenc %zmm6, %zmm0, %zmm0
    vaesenc %zmm6, %zmm8, %zmm8
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm8, %zmm11, %zmm8
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm10, %zmm9, %zmm10
    vaesenclast %zmm6, %zmm3, %zmm3
    vaesenclast %zmm6, %zmm11, %zmm11
    vaesenclast %zmm27, %zmm1, %zmm1
    vaesenclast 704+AREION_SYM(areionRC4x2)(%rip), %zmm9, %zmm9
    vaesenc %zmm6, %zmm1, %zmm1
    vaesenc %zmm6, %zmm9, %zmm9
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm9, %zmm8, %zmm9
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm11, %zmm10, %zmm11
    vaesenclast %zmm6, %zmm0, %zmm0
    vaesenclast %zmm6, %zmm8, %zmm8
    vaesenclast %zmm28, %zmm2, %zmm2
    vaesenclast 768+AREION_SYM(areionRC4x2)(%rip), %zmm10, %zmm10
    vaesenc %zmm6, %zmm2, %zmm2
    vaesenc %zmm6, %zmm10, %zmm10
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm10, %zmm9, %zmm10
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm8, %zmm11, %zmm8
    vaesenclast %zmm6, %zmm1, %zmm1
    vaesenclast %zmm6, %zmm9, %zmm9
    vaesenclast %zmm29, %zmm3, %zmm3
    vaesenclast 832+AREION_SYM(areionRC4x2)(%rip), %zmm11, %zmm11
    vaesenc %zmm6, %zmm3, %zmm3
    vaesenc %zmm6, %zmm11, %zmm11
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm11, %zmm10, %zmm11
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm9, %zmm8, %zmm9
    vaesenclast %zmm6, %zmm2, %zmm2
    vaesenclast %zmm6, %zmm10, %zmm10
    vaesenclast %zmm30, %zmm0, %zmm0
    vaesenclast 896+AREION_SYM(areionRC4x2)(%rip), %zmm8, %zmm8
    vaesenc %zmm6, %zmm0, %zmm0
    vaesenc %zmm6, %zmm8, %zmm8
    vpxord %zmm11, %zmm3, %zmm3
    vpxord %zmm8, %zmm0, %zmm0
    vpxord %zmm9, %zmm1, %zmm1
    vpxord %zmm10, %zmm2, %zmm2
    vmovdqu64 %zmm3, (%rax)
    vmovdqu64 %zmm0, (%r10)
    vmovdqu64 %zmm1, (%rcx)
    vmovdqu64 %zmm2, (%rdx)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm8, %xmm8, %xmm8
    vpxord %xmm9, %xmm9, %xmm9
    vpxord %xmm10, %xmm10, %xmm10
    vpxord %xmm11, %xmm11, %xmm11
    vpxord %xmm16, %xmm16, %xmm16
    vpxord %xmm17, %xmm17, %xmm17
    vpxord %xmm18, %xmm18, %xmm18
    vpxord %xmm19, %xmm19, %xmm19
    vpxord %xmm20, %xmm20, %xmm20
    vpxord %xmm21, %xmm21, %xmm21
    vpxord %xmm22, %xmm22, %xmm22
    vpxord %xmm23, %xmm23, %xmm23
    vpxord %xmm24, %xmm24, %xmm24
    vpxord %xmm25, %xmm25, %xmm25
    vpxord %xmm26, %xmm26, %xmm26
    vpxord %xmm27, %xmm27, %xmm27
    vpxord %xmm28, %xmm28, %xmm28
    vpxord %xmm29, %xmm29, %xmm29
    vpxord %xmm30, %xmm30, %xmm30
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %rsi, %rsi
    xorq %rdi, %rdi
    xorq %r8, %r8
    xorq %r9, %r9
    xorq %r11, %r11
#if defined(_WIN64)
    vmovdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm8
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    vmovdqu 48(%rsp), %xmm9
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    vmovdqu 64(%rsp), %xmm10
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    vmovdqu 80(%rsp), %xmm11
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $104, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion512SoEMPermutex4Interleaved)

AREION_FUNC_START(areion512SoEMPermutex4VaesAvx2)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %r8, %rsi
    movq %r9, %rdi
    movq %rdx, %r11
    movq %rcx, %rdx
    movq %r11, %rcx
    movq 8(%rsp), %r8
    movq 16(%rsp), %r9
#else
    subq $72, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm15, 48(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
    movq %r9, %rdx
    movq 112(%rsp), %rsi
    movq 120(%rsp), %rdi
    movq 128(%rsp), %r8
    movq 136(%rsp), %r9
#endif
    vpxor %ymm15, %ymm15, %ymm15
    vmovdqu (%rax), %ymm0
    vmovdqu (%r10), %ymm1
    vmovdqu (%rcx), %ymm2
    vmovdqu (%rdx), %ymm3
    vmovdqu (%rsi), %ymm4
    vmovdqu (%rdi), %ymm5
    vmovdqu (%r8), %ymm6
    vmovdqu (%r9), %ymm7
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
    vmovdqu %ymm3, (%rax)
    vmovdqu %ymm0, (%r10)
    vmovdqu %ymm1, (%rcx)
    vmovdqu %ymm2, (%rdx)
    vmovdqu 32(%rax), %ymm0
    vmovdqu 32(%r10), %ymm1
    vmovdqu 32(%rcx), %ymm2
    vmovdqu 32(%rdx), %ymm3
    vmovdqu 32(%rsi), %ymm4
    vmovdqu 32(%rdi), %ymm5
    vmovdqu 32(%r8), %ymm6
    vmovdqu 32(%r9), %ymm7
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
    vmovdqu %ymm3, 32(%rax)
    vmovdqu %ymm0, 32(%r10)
    vmovdqu %ymm1, 32(%rcx)
    vmovdqu %ymm2, 32(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    vpxor %xmm7, %xmm7, %xmm7
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %rsi, %rsi
    xorq %rdi, %rdi
    xorq %r8, %r8
    xorq %r9, %r9
    xorq %r11, %r11
#if defined(_WIN64)
    vmovdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm7
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    vmovdqu 48(%rsp), %xmm15
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
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
