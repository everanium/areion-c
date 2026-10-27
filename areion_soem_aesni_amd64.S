/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#if defined(__x86_64__) || defined(_M_X64)
#include "asm_abi.h"

.text

AREION_FUNC_START(areion256Permutex4AesNiRC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %rdx, %rcx
#else
    subq $136, %rsp
    movdqu %xmm6, 0(%rsp)
    movdqu %xmm7, 16(%rsp)
    movdqu %xmm8, 32(%rsp)
    movdqu %xmm9, 48(%rsp)
    movdqu %xmm10, 64(%rsp)
    movdqu %xmm11, 80(%rsp)
    movdqu %xmm12, 96(%rsp)
    movdqu %xmm13, 112(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
#endif
    pxor %xmm12, %xmm12
    movdqu (%rax), %xmm0
    movdqu (%r10), %xmm1
    movdqu 16(%rax), %xmm2
    movdqu 16(%r10), %xmm3
    movdqu 32(%rax), %xmm4
    movdqu 32(%r10), %xmm5
    movdqu 48(%rax), %xmm6
    movdqu 48(%r10), %xmm7
    movdqu (%rcx), %xmm13
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm4
    aesenclast %xmm12, %xmm6
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 64(%rcx), %xmm13
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm5
    aesenclast %xmm12, %xmm7
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 128(%rcx), %xmm13
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm4
    aesenclast %xmm12, %xmm6
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 192(%rcx), %xmm13
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm5
    aesenclast %xmm12, %xmm7
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 256(%rcx), %xmm13
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm4
    aesenclast %xmm12, %xmm6
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 320(%rcx), %xmm13
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm5
    aesenclast %xmm12, %xmm7
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 384(%rcx), %xmm13
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm4
    aesenclast %xmm12, %xmm6
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 448(%rcx), %xmm13
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm5
    aesenclast %xmm12, %xmm7
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 512(%rcx), %xmm13
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm4
    aesenclast %xmm12, %xmm6
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 576(%rcx), %xmm13
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm5
    aesenclast %xmm12, %xmm7
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu %xmm0, (%rax)
    movdqu %xmm1, (%r10)
    movdqu %xmm2, 16(%rax)
    movdqu %xmm3, 16(%r10)
    movdqu %xmm4, 32(%rax)
    movdqu %xmm5, 32(%r10)
    movdqu %xmm6, 48(%rax)
    movdqu %xmm7, 48(%r10)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    pxor %xmm6, %xmm6
    pxor %xmm7, %xmm7
    pxor %xmm8, %xmm8
    pxor %xmm9, %xmm9
    pxor %xmm10, %xmm10
    pxor %xmm11, %xmm11
    pxor %xmm12, %xmm12
    pxor %xmm13, %xmm13
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm6
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    movdqu 16(%rsp), %xmm7
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    movdqu 32(%rsp), %xmm8
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    movdqu 48(%rsp), %xmm9
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    movdqu 64(%rsp), %xmm10
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    movdqu 80(%rsp), %xmm11
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    movdqu 96(%rsp), %xmm12
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    movdqu 112(%rsp), %xmm13
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    addq $136, %rsp
#endif
    ret
AREION_FUNC_END(areion256Permutex4AesNiRC)

AREION_FUNC_START(areion256Permutex4VexRC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %rdx, %rcx
#else
    subq $136, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm7, 16(%rsp)
    vmovdqu %xmm8, 32(%rsp)
    vmovdqu %xmm9, 48(%rsp)
    vmovdqu %xmm10, 64(%rsp)
    vmovdqu %xmm11, 80(%rsp)
    vmovdqu %xmm12, 96(%rsp)
    vmovdqu %xmm13, 112(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
#endif
    vpxor %xmm12, %xmm12, %xmm12
    vmovdqu (%rax), %xmm0
    vmovdqu (%r10), %xmm1
    vmovdqu 16(%rax), %xmm2
    vmovdqu 16(%r10), %xmm3
    vmovdqu 32(%rax), %xmm4
    vmovdqu 32(%r10), %xmm5
    vmovdqu 48(%rax), %xmm6
    vmovdqu 48(%r10), %xmm7
    vmovdqu (%rcx), %xmm13
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 64(%rcx), %xmm13
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 128(%rcx), %xmm13
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 192(%rcx), %xmm13
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 256(%rcx), %xmm13
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 320(%rcx), %xmm13
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 384(%rcx), %xmm13
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 448(%rcx), %xmm13
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 512(%rcx), %xmm13
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 576(%rcx), %xmm13
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu %xmm0, (%rax)
    vmovdqu %xmm1, (%r10)
    vmovdqu %xmm2, 16(%rax)
    vmovdqu %xmm3, 16(%r10)
    vmovdqu %xmm4, 32(%rax)
    vmovdqu %xmm5, 32(%r10)
    vmovdqu %xmm6, 48(%rax)
    vmovdqu %xmm7, 48(%r10)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    vpxor %xmm7, %xmm7, %xmm7
    vpxor %xmm8, %xmm8, %xmm8
    vpxor %xmm9, %xmm9, %xmm9
    vpxor %xmm10, %xmm10, %xmm10
    vpxor %xmm11, %xmm11, %xmm11
    vpxor %xmm12, %xmm12, %xmm12
    vpxor %xmm13, %xmm13, %xmm13
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm6
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm7
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
    vmovdqu 96(%rsp), %xmm12
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    vmovdqu 112(%rsp), %xmm13
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    addq $136, %rsp
#endif
    ret
AREION_FUNC_END(areion256Permutex4VexRC)

AREION_FUNC_START(areion256InversePermutex4AesNiRC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %rdx, %rcx
#else
    subq $136, %rsp
    movdqu %xmm6, 0(%rsp)
    movdqu %xmm7, 16(%rsp)
    movdqu %xmm8, 32(%rsp)
    movdqu %xmm9, 48(%rsp)
    movdqu %xmm10, 64(%rsp)
    movdqu %xmm11, 80(%rsp)
    movdqu %xmm12, 96(%rsp)
    movdqu %xmm13, 112(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
#endif
    pxor %xmm12, %xmm12
    movdqu (%rax), %xmm0
    movdqu (%r10), %xmm1
    movdqu 16(%rax), %xmm2
    movdqu 16(%r10), %xmm3
    movdqu 32(%rax), %xmm4
    movdqu 32(%r10), %xmm5
    movdqu 48(%rax), %xmm6
    movdqu 48(%r10), %xmm7
    movdqu 576(%rcx), %xmm13
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm5
    aesdeclast %xmm12, %xmm7
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 512(%rcx), %xmm13
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm4
    aesdeclast %xmm12, %xmm6
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 448(%rcx), %xmm13
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm5
    aesdeclast %xmm12, %xmm7
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 384(%rcx), %xmm13
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm4
    aesdeclast %xmm12, %xmm6
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 320(%rcx), %xmm13
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm5
    aesdeclast %xmm12, %xmm7
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 256(%rcx), %xmm13
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm4
    aesdeclast %xmm12, %xmm6
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 192(%rcx), %xmm13
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm5
    aesdeclast %xmm12, %xmm7
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 128(%rcx), %xmm13
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm4
    aesdeclast %xmm12, %xmm6
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 64(%rcx), %xmm13
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm5
    aesdeclast %xmm12, %xmm7
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu (%rcx), %xmm13
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm4
    aesdeclast %xmm12, %xmm6
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu %xmm0, (%rax)
    movdqu %xmm1, (%r10)
    movdqu %xmm2, 16(%rax)
    movdqu %xmm3, 16(%r10)
    movdqu %xmm4, 32(%rax)
    movdqu %xmm5, 32(%r10)
    movdqu %xmm6, 48(%rax)
    movdqu %xmm7, 48(%r10)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    pxor %xmm6, %xmm6
    pxor %xmm7, %xmm7
    pxor %xmm8, %xmm8
    pxor %xmm9, %xmm9
    pxor %xmm10, %xmm10
    pxor %xmm11, %xmm11
    pxor %xmm12, %xmm12
    pxor %xmm13, %xmm13
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm6
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    movdqu 16(%rsp), %xmm7
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    movdqu 32(%rsp), %xmm8
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    movdqu 48(%rsp), %xmm9
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    movdqu 64(%rsp), %xmm10
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    movdqu 80(%rsp), %xmm11
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    movdqu 96(%rsp), %xmm12
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    movdqu 112(%rsp), %xmm13
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    addq $136, %rsp
#endif
    ret
AREION_FUNC_END(areion256InversePermutex4AesNiRC)

AREION_FUNC_START(areion256InversePermutex4VexRC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %rdx, %rcx
#else
    subq $136, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm7, 16(%rsp)
    vmovdqu %xmm8, 32(%rsp)
    vmovdqu %xmm9, 48(%rsp)
    vmovdqu %xmm10, 64(%rsp)
    vmovdqu %xmm11, 80(%rsp)
    vmovdqu %xmm12, 96(%rsp)
    vmovdqu %xmm13, 112(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
#endif
    vpxor %xmm12, %xmm12, %xmm12
    vmovdqu (%rax), %xmm0
    vmovdqu (%r10), %xmm1
    vmovdqu 16(%rax), %xmm2
    vmovdqu 16(%r10), %xmm3
    vmovdqu 32(%rax), %xmm4
    vmovdqu 32(%r10), %xmm5
    vmovdqu 48(%rax), %xmm6
    vmovdqu 48(%r10), %xmm7
    vmovdqu 576(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 512(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 448(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 384(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 320(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 256(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 192(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 128(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 64(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu (%rcx), %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu %xmm0, (%rax)
    vmovdqu %xmm1, (%r10)
    vmovdqu %xmm2, 16(%rax)
    vmovdqu %xmm3, 16(%r10)
    vmovdqu %xmm4, 32(%rax)
    vmovdqu %xmm5, 32(%r10)
    vmovdqu %xmm6, 48(%rax)
    vmovdqu %xmm7, 48(%r10)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    vpxor %xmm7, %xmm7, %xmm7
    vpxor %xmm8, %xmm8, %xmm8
    vpxor %xmm9, %xmm9, %xmm9
    vpxor %xmm10, %xmm10, %xmm10
    vpxor %xmm11, %xmm11, %xmm11
    vpxor %xmm12, %xmm12, %xmm12
    vpxor %xmm13, %xmm13, %xmm13
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm6
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm7
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
    vmovdqu 96(%rsp), %xmm12
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    vmovdqu 112(%rsp), %xmm13
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    addq $136, %rsp
#endif
    ret
AREION_FUNC_END(areion256InversePermutex4VexRC)

AREION_FUNC_START(areion512Permutex4AesNiRC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %r8, %rsi
    movq %rdx, %r11
    movq %rcx, %rdx
    movq %r11, %rcx
#else
    subq $152, %rsp
    movq %rsi, 0(%rsp)
    movdqu %xmm6, 16(%rsp)
    movdqu %xmm7, 32(%rsp)
    movdqu %xmm8, 48(%rsp)
    movdqu %xmm9, 64(%rsp)
    movdqu %xmm10, 80(%rsp)
    movdqu %xmm11, 96(%rsp)
    movdqu %xmm12, 112(%rsp)
    movdqu %xmm13, 128(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
    movq %r9, %rdx
    movq 192(%rsp), %rsi
#endif
    pxor %xmm12, %xmm12
    movdqu (%rax), %xmm0
    movdqu (%r10), %xmm1
    movdqu (%rcx), %xmm2
    movdqu (%rdx), %xmm3
    movdqu 16(%rax), %xmm4
    movdqu 16(%r10), %xmm5
    movdqu 16(%rcx), %xmm6
    movdqu 16(%rdx), %xmm7
    movdqu (%rsi), %xmm13
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 64(%rsi), %xmm13
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 128(%rsi), %xmm13
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 192(%rsi), %xmm13
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 256(%rsi), %xmm13
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 320(%rsi), %xmm13
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 384(%rsi), %xmm13
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 448(%rsi), %xmm13
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 512(%rsi), %xmm13
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 576(%rsi), %xmm13
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 640(%rsi), %xmm13
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 704(%rsi), %xmm13
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 768(%rsi), %xmm13
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 832(%rsi), %xmm13
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 896(%rsi), %xmm13
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu %xmm3, (%rax)
    movdqu %xmm0, (%r10)
    movdqu %xmm1, (%rcx)
    movdqu %xmm2, (%rdx)
    movdqu %xmm7, 16(%rax)
    movdqu %xmm4, 16(%r10)
    movdqu %xmm5, 16(%rcx)
    movdqu %xmm6, 16(%rdx)
    movdqu 32(%rax), %xmm0
    movdqu 32(%r10), %xmm1
    movdqu 32(%rcx), %xmm2
    movdqu 32(%rdx), %xmm3
    movdqu 48(%rax), %xmm4
    movdqu 48(%r10), %xmm5
    movdqu 48(%rcx), %xmm6
    movdqu 48(%rdx), %xmm7
    movdqu (%rsi), %xmm13
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 64(%rsi), %xmm13
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 128(%rsi), %xmm13
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 192(%rsi), %xmm13
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 256(%rsi), %xmm13
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 320(%rsi), %xmm13
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 384(%rsi), %xmm13
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 448(%rsi), %xmm13
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 512(%rsi), %xmm13
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 576(%rsi), %xmm13
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 640(%rsi), %xmm13
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 704(%rsi), %xmm13
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 768(%rsi), %xmm13
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 832(%rsi), %xmm13
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 896(%rsi), %xmm13
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu %xmm3, 32(%rax)
    movdqu %xmm0, 32(%r10)
    movdqu %xmm1, 32(%rcx)
    movdqu %xmm2, 32(%rdx)
    movdqu %xmm7, 48(%rax)
    movdqu %xmm4, 48(%r10)
    movdqu %xmm5, 48(%rcx)
    movdqu %xmm6, 48(%rdx)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    pxor %xmm6, %xmm6
    pxor %xmm7, %xmm7
    pxor %xmm8, %xmm8
    pxor %xmm9, %xmm9
    pxor %xmm10, %xmm10
    pxor %xmm11, %xmm11
    pxor %xmm12, %xmm12
    pxor %xmm13, %xmm13
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %rsi, %rsi
    xorq %r11, %r11
#if defined(_WIN64)
    movdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    movdqu 32(%rsp), %xmm7
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    movdqu 48(%rsp), %xmm8
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    movdqu 64(%rsp), %xmm9
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    movdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    movdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    movdqu 112(%rsp), %xmm12
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    movdqu 128(%rsp), %xmm13
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    addq $152, %rsp
#endif
    ret
AREION_FUNC_END(areion512Permutex4AesNiRC)

AREION_FUNC_START(areion512Permutex4VexRC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %r8, %rsi
    movq %rdx, %r11
    movq %rcx, %rdx
    movq %r11, %rcx
#else
    subq $88, %rsp
    movq %rsi, 0(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm12, 48(%rsp)
    vmovdqu %xmm13, 64(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
    movq %r9, %rdx
    movq 128(%rsp), %rsi
#endif
    vpxor %xmm12, %xmm12, %xmm12
    vmovdqu (%rax), %xmm0
    vmovdqu (%r10), %xmm1
    vmovdqu (%rcx), %xmm2
    vmovdqu (%rdx), %xmm3
    vmovdqu 16(%rax), %xmm4
    vmovdqu 16(%r10), %xmm5
    vmovdqu 16(%rcx), %xmm6
    vmovdqu 16(%rdx), %xmm7
    vmovdqu (%rsi), %xmm13
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm13, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 64(%rsi), %xmm13
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm13, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 128(%rsi), %xmm13
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm13, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 192(%rsi), %xmm13
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm13, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 256(%rsi), %xmm13
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm13, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 320(%rsi), %xmm13
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm13, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 384(%rsi), %xmm13
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm13, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 448(%rsi), %xmm13
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm13, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 512(%rsi), %xmm13
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm13, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 576(%rsi), %xmm13
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm13, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 640(%rsi), %xmm13
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm13, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 704(%rsi), %xmm13
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm13, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 768(%rsi), %xmm13
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm13, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 832(%rsi), %xmm13
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm13, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 896(%rsi), %xmm13
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm13, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu %xmm3, (%rax)
    vmovdqu %xmm0, (%r10)
    vmovdqu %xmm1, (%rcx)
    vmovdqu %xmm2, (%rdx)
    vmovdqu %xmm7, 16(%rax)
    vmovdqu %xmm4, 16(%r10)
    vmovdqu %xmm5, 16(%rcx)
    vmovdqu %xmm6, 16(%rdx)
    vmovdqu 32(%rax), %xmm0
    vmovdqu 32(%r10), %xmm1
    vmovdqu 32(%rcx), %xmm2
    vmovdqu 32(%rdx), %xmm3
    vmovdqu 48(%rax), %xmm4
    vmovdqu 48(%r10), %xmm5
    vmovdqu 48(%rcx), %xmm6
    vmovdqu 48(%rdx), %xmm7
    vmovdqu (%rsi), %xmm13
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm13, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 64(%rsi), %xmm13
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm13, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 128(%rsi), %xmm13
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm13, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 192(%rsi), %xmm13
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm13, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 256(%rsi), %xmm13
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm13, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 320(%rsi), %xmm13
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm13, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 384(%rsi), %xmm13
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm13, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 448(%rsi), %xmm13
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm13, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 512(%rsi), %xmm13
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm13, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 576(%rsi), %xmm13
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm13, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 640(%rsi), %xmm13
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm13, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 704(%rsi), %xmm13
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm13, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 768(%rsi), %xmm13
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm13, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 832(%rsi), %xmm13
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm13, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 896(%rsi), %xmm13
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm13, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu %xmm3, 32(%rax)
    vmovdqu %xmm0, 32(%r10)
    vmovdqu %xmm1, 32(%rcx)
    vmovdqu %xmm2, 32(%rdx)
    vmovdqu %xmm7, 48(%rax)
    vmovdqu %xmm4, 48(%r10)
    vmovdqu %xmm5, 48(%rcx)
    vmovdqu %xmm6, 48(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    vpxor %xmm7, %xmm7, %xmm7
    vpxor %xmm12, %xmm12, %xmm12
    vpxor %xmm13, %xmm13, %xmm13
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %rsi, %rsi
    xorq %r11, %r11
#if defined(_WIN64)
    vmovdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm7
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    vmovdqu 48(%rsp), %xmm12
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    vmovdqu 64(%rsp), %xmm13
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    addq $88, %rsp
#endif
    ret
AREION_FUNC_END(areion512Permutex4VexRC)

AREION_FUNC_START(areion512InversePermutex4AesNiRC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %r8, %rsi
    movq %rdx, %r11
    movq %rcx, %rdx
    movq %r11, %rcx
#else
    subq $152, %rsp
    movq %rsi, 0(%rsp)
    movdqu %xmm6, 16(%rsp)
    movdqu %xmm7, 32(%rsp)
    movdqu %xmm8, 48(%rsp)
    movdqu %xmm9, 64(%rsp)
    movdqu %xmm10, 80(%rsp)
    movdqu %xmm11, 96(%rsp)
    movdqu %xmm12, 112(%rsp)
    movdqu %xmm13, 128(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
    movq %r9, %rdx
    movq 192(%rsp), %rsi
#endif
    pxor %xmm12, %xmm12
    movdqu (%r10), %xmm0
    movdqu (%rcx), %xmm1
    movdqu (%rdx), %xmm2
    movdqu (%rax), %xmm3
    movdqu 16(%r10), %xmm4
    movdqu 16(%rcx), %xmm5
    movdqu 16(%rdx), %xmm6
    movdqu 16(%rax), %xmm7
    movdqu 896(%rsi), %xmm13
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm13, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    movdqu 832(%rsi), %xmm13
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm13, %xmm3
    aesdeclast %xmm13, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    movdqu 768(%rsi), %xmm13
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesimc %xmm2, %xmm2
    aesimc %xmm6, %xmm6
    aesdeclast %xmm13, %xmm2
    aesdeclast %xmm13, %xmm6
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    movdqu 704(%rsi), %xmm13
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    aesimc %xmm1, %xmm1
    aesimc %xmm5, %xmm5
    aesdeclast %xmm13, %xmm1
    aesdeclast %xmm13, %xmm5
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    movdqu 640(%rsi), %xmm13
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm13, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    movdqu 576(%rsi), %xmm13
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm13, %xmm3
    aesdeclast %xmm13, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    movdqu 512(%rsi), %xmm13
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesimc %xmm2, %xmm2
    aesimc %xmm6, %xmm6
    aesdeclast %xmm13, %xmm2
    aesdeclast %xmm13, %xmm6
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    movdqu 448(%rsi), %xmm13
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    aesimc %xmm1, %xmm1
    aesimc %xmm5, %xmm5
    aesdeclast %xmm13, %xmm1
    aesdeclast %xmm13, %xmm5
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    movdqu 384(%rsi), %xmm13
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm13, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    movdqu 320(%rsi), %xmm13
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm13, %xmm3
    aesdeclast %xmm13, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    movdqu 256(%rsi), %xmm13
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesimc %xmm2, %xmm2
    aesimc %xmm6, %xmm6
    aesdeclast %xmm13, %xmm2
    aesdeclast %xmm13, %xmm6
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    movdqu 192(%rsi), %xmm13
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    aesimc %xmm1, %xmm1
    aesimc %xmm5, %xmm5
    aesdeclast %xmm13, %xmm1
    aesdeclast %xmm13, %xmm5
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    movdqu 128(%rsi), %xmm13
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm13, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    movdqu 64(%rsi), %xmm13
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm13, %xmm3
    aesdeclast %xmm13, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    movdqu (%rsi), %xmm13
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesimc %xmm2, %xmm2
    aesimc %xmm6, %xmm6
    aesdeclast %xmm13, %xmm2
    aesdeclast %xmm13, %xmm6
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    movdqu %xmm0, (%rax)
    movdqu %xmm1, (%r10)
    movdqu %xmm2, (%rcx)
    movdqu %xmm3, (%rdx)
    movdqu %xmm4, 16(%rax)
    movdqu %xmm5, 16(%r10)
    movdqu %xmm6, 16(%rcx)
    movdqu %xmm7, 16(%rdx)
    movdqu 32(%r10), %xmm0
    movdqu 32(%rcx), %xmm1
    movdqu 32(%rdx), %xmm2
    movdqu 32(%rax), %xmm3
    movdqu 48(%r10), %xmm4
    movdqu 48(%rcx), %xmm5
    movdqu 48(%rdx), %xmm6
    movdqu 48(%rax), %xmm7
    movdqu 896(%rsi), %xmm13
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm13, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    movdqu 832(%rsi), %xmm13
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm13, %xmm3
    aesdeclast %xmm13, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    movdqu 768(%rsi), %xmm13
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesimc %xmm2, %xmm2
    aesimc %xmm6, %xmm6
    aesdeclast %xmm13, %xmm2
    aesdeclast %xmm13, %xmm6
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    movdqu 704(%rsi), %xmm13
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    aesimc %xmm1, %xmm1
    aesimc %xmm5, %xmm5
    aesdeclast %xmm13, %xmm1
    aesdeclast %xmm13, %xmm5
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    movdqu 640(%rsi), %xmm13
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm13, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    movdqu 576(%rsi), %xmm13
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm13, %xmm3
    aesdeclast %xmm13, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    movdqu 512(%rsi), %xmm13
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesimc %xmm2, %xmm2
    aesimc %xmm6, %xmm6
    aesdeclast %xmm13, %xmm2
    aesdeclast %xmm13, %xmm6
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    movdqu 448(%rsi), %xmm13
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    aesimc %xmm1, %xmm1
    aesimc %xmm5, %xmm5
    aesdeclast %xmm13, %xmm1
    aesdeclast %xmm13, %xmm5
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    movdqu 384(%rsi), %xmm13
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm13, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    movdqu 320(%rsi), %xmm13
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm13, %xmm3
    aesdeclast %xmm13, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    movdqu 256(%rsi), %xmm13
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesimc %xmm2, %xmm2
    aesimc %xmm6, %xmm6
    aesdeclast %xmm13, %xmm2
    aesdeclast %xmm13, %xmm6
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    movdqu 192(%rsi), %xmm13
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    aesimc %xmm1, %xmm1
    aesimc %xmm5, %xmm5
    aesdeclast %xmm13, %xmm1
    aesdeclast %xmm13, %xmm5
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    movdqu 128(%rsi), %xmm13
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm13, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    movdqu 64(%rsi), %xmm13
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm13, %xmm3
    aesdeclast %xmm13, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    movdqu (%rsi), %xmm13
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesimc %xmm2, %xmm2
    aesimc %xmm6, %xmm6
    aesdeclast %xmm13, %xmm2
    aesdeclast %xmm13, %xmm6
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    movdqu %xmm0, 32(%rax)
    movdqu %xmm1, 32(%r10)
    movdqu %xmm2, 32(%rcx)
    movdqu %xmm3, 32(%rdx)
    movdqu %xmm4, 48(%rax)
    movdqu %xmm5, 48(%r10)
    movdqu %xmm6, 48(%rcx)
    movdqu %xmm7, 48(%rdx)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    pxor %xmm6, %xmm6
    pxor %xmm7, %xmm7
    pxor %xmm8, %xmm8
    pxor %xmm9, %xmm9
    pxor %xmm10, %xmm10
    pxor %xmm11, %xmm11
    pxor %xmm12, %xmm12
    pxor %xmm13, %xmm13
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %rsi, %rsi
    xorq %r11, %r11
#if defined(_WIN64)
    movdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    movdqu 32(%rsp), %xmm7
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    movdqu 48(%rsp), %xmm8
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    movdqu 64(%rsp), %xmm9
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    movdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    movdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    movdqu 112(%rsp), %xmm12
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    movdqu 128(%rsp), %xmm13
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    addq $152, %rsp
#endif
    ret
AREION_FUNC_END(areion512InversePermutex4AesNiRC)

AREION_FUNC_START(areion512InversePermutex4VexRC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %rcx, %rsi
    movq %r8, %rcx
#else
    subq $88, %rsp
    movq %rsi, 0(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm12, 48(%rsp)
    vmovdqu %xmm13, 64(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rdx
    movq %r9, %rsi
    movq 128(%rsp), %rcx
#endif
    vpxor %xmm12, %xmm12, %xmm12
    vmovdqu (%r10), %xmm0
    vmovdqu (%rdx), %xmm1
    vmovdqu (%rsi), %xmm2
    vmovdqu (%rax), %xmm3
    vmovdqu 16(%r10), %xmm4
    vmovdqu 16(%rdx), %xmm5
    vmovdqu 16(%rsi), %xmm6
    vmovdqu 16(%rax), %xmm7
    vmovdqu 896(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm13, %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu 832(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm13, %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu 768(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesimc %xmm2, %xmm2
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm13, %xmm2, %xmm2
    vaesdeclast %xmm13, %xmm6, %xmm6
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vmovdqu 704(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesdeclast %xmm13, %xmm1, %xmm1
    vaesdeclast %xmm13, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vmovdqu 640(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm13, %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu 576(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm13, %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu 512(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesimc %xmm2, %xmm2
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm13, %xmm2, %xmm2
    vaesdeclast %xmm13, %xmm6, %xmm6
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vmovdqu 448(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesdeclast %xmm13, %xmm1, %xmm1
    vaesdeclast %xmm13, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vmovdqu 384(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm13, %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu 320(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm13, %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu 256(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesimc %xmm2, %xmm2
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm13, %xmm2, %xmm2
    vaesdeclast %xmm13, %xmm6, %xmm6
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vmovdqu 192(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesdeclast %xmm13, %xmm1, %xmm1
    vaesdeclast %xmm13, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vmovdqu 128(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm13, %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu 64(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm13, %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu (%rcx), %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesimc %xmm2, %xmm2
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm13, %xmm2, %xmm2
    vaesdeclast %xmm13, %xmm6, %xmm6
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vmovdqu %xmm0, (%rax)
    vmovdqu %xmm1, (%r10)
    vmovdqu %xmm2, (%rdx)
    vmovdqu %xmm3, (%rsi)
    vmovdqu %xmm4, 16(%rax)
    vmovdqu %xmm5, 16(%r10)
    vmovdqu %xmm6, 16(%rdx)
    vmovdqu %xmm7, 16(%rsi)
    vmovdqu 32(%r10), %xmm0
    vmovdqu 32(%rdx), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 32(%rax), %xmm3
    vmovdqu 48(%r10), %xmm4
    vmovdqu 48(%rdx), %xmm5
    vmovdqu 48(%rsi), %xmm6
    vmovdqu 48(%rax), %xmm7
    vmovdqu 896(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm13, %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu 832(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm13, %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu 768(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesimc %xmm2, %xmm2
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm13, %xmm2, %xmm2
    vaesdeclast %xmm13, %xmm6, %xmm6
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vmovdqu 704(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesdeclast %xmm13, %xmm1, %xmm1
    vaesdeclast %xmm13, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vmovdqu 640(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm13, %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu 576(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm13, %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu 512(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesimc %xmm2, %xmm2
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm13, %xmm2, %xmm2
    vaesdeclast %xmm13, %xmm6, %xmm6
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vmovdqu 448(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesdeclast %xmm13, %xmm1, %xmm1
    vaesdeclast %xmm13, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vmovdqu 384(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm13, %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu 320(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm13, %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu 256(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesimc %xmm2, %xmm2
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm13, %xmm2, %xmm2
    vaesdeclast %xmm13, %xmm6, %xmm6
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vmovdqu 192(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesdeclast %xmm13, %xmm1, %xmm1
    vaesdeclast %xmm13, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vmovdqu 128(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm13, %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu 64(%rcx), %xmm13
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm13, %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu (%rcx), %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesimc %xmm2, %xmm2
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm13, %xmm2, %xmm2
    vaesdeclast %xmm13, %xmm6, %xmm6
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vmovdqu %xmm0, 32(%rax)
    vmovdqu %xmm1, 32(%r10)
    vmovdqu %xmm2, 32(%rdx)
    vmovdqu %xmm3, 32(%rsi)
    vmovdqu %xmm4, 48(%rax)
    vmovdqu %xmm5, 48(%r10)
    vmovdqu %xmm6, 48(%rdx)
    vmovdqu %xmm7, 48(%rsi)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    vpxor %xmm7, %xmm7, %xmm7
    vpxor %xmm12, %xmm12, %xmm12
    vpxor %xmm13, %xmm13, %xmm13
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#if defined(_WIN64)
    vmovdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm7
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    vmovdqu 48(%rsp), %xmm12
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    vmovdqu 64(%rsp), %xmm13
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    addq $88, %rsp
#endif
    ret
AREION_FUNC_END(areion512InversePermutex4VexRC)

AREION_FUNC_START(areion256SoEMPermutex4AesNi)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %rdx, %r11
    movq %rcx, %rdx
    movq %r11, %rcx
#else
    subq $152, %rsp
    movdqu %xmm6, 0(%rsp)
    movdqu %xmm7, 16(%rsp)
    movdqu %xmm8, 32(%rsp)
    movdqu %xmm9, 48(%rsp)
    movdqu %xmm10, 64(%rsp)
    movdqu %xmm11, 80(%rsp)
    movdqu %xmm12, 96(%rsp)
    movdqu %xmm13, 112(%rsp)
    movdqu %xmm14, 128(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
    movq %r9, %rdx
#endif
    pxor %xmm12, %xmm12
    movdqu (%rax), %xmm0
    movdqu (%r10), %xmm1
    movdqu 16(%rax), %xmm2
    movdqu 16(%r10), %xmm3
    movdqu (%rcx), %xmm4
    movdqu (%rdx), %xmm5
    movdqu 16(%rcx), %xmm6
    movdqu 16(%rdx), %xmm7
    movdqu AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm4
    aesenclast %xmm12, %xmm6
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 64+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 64+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm5
    aesenclast %xmm12, %xmm7
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 128+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 128+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm4
    aesenclast %xmm12, %xmm6
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 192+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 192+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm5
    aesenclast %xmm12, %xmm7
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 256+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 256+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm4
    aesenclast %xmm12, %xmm6
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 320+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 320+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm5
    aesenclast %xmm12, %xmm7
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 384+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 384+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm4
    aesenclast %xmm12, %xmm6
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 448+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 448+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm5
    aesenclast %xmm12, %xmm7
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 512+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 512+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm4
    aesenclast %xmm12, %xmm6
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 576+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 576+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm5
    aesenclast %xmm12, %xmm7
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqu %xmm0, (%rax)
    movdqu %xmm1, (%r10)
    movdqu %xmm2, 16(%rax)
    movdqu %xmm3, 16(%r10)
    movdqu 32(%rax), %xmm0
    movdqu 32(%r10), %xmm1
    movdqu 48(%rax), %xmm2
    movdqu 48(%r10), %xmm3
    movdqu 32(%rcx), %xmm4
    movdqu 32(%rdx), %xmm5
    movdqu 48(%rcx), %xmm6
    movdqu 48(%rdx), %xmm7
    movdqu AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm4
    aesenclast %xmm12, %xmm6
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 64+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 64+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm5
    aesenclast %xmm12, %xmm7
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 128+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 128+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm4
    aesenclast %xmm12, %xmm6
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 192+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 192+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm5
    aesenclast %xmm12, %xmm7
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 256+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 256+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm4
    aesenclast %xmm12, %xmm6
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 320+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 320+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm5
    aesenclast %xmm12, %xmm7
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 384+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 384+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm4
    aesenclast %xmm12, %xmm6
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 448+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 448+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm5
    aesenclast %xmm12, %xmm7
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    movdqu 512+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 512+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm2, %xmm9
    movdqu %xmm4, %xmm10
    movdqu %xmm6, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm4
    aesenclast %xmm12, %xmm6
    movdqu %xmm8, %xmm1
    movdqu %xmm9, %xmm3
    movdqu %xmm10, %xmm5
    movdqu %xmm11, %xmm7
    movdqu 576+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 576+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm3, %xmm9
    movdqu %xmm5, %xmm10
    movdqu %xmm7, %xmm11
    aesenc %xmm13, %xmm8
    aesenc %xmm13, %xmm9
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm5
    aesenclast %xmm12, %xmm7
    movdqu %xmm8, %xmm0
    movdqu %xmm9, %xmm2
    movdqu %xmm10, %xmm4
    movdqu %xmm11, %xmm6
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqu %xmm0, 32(%rax)
    movdqu %xmm1, 32(%r10)
    movdqu %xmm2, 48(%rax)
    movdqu %xmm3, 48(%r10)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    pxor %xmm6, %xmm6
    pxor %xmm7, %xmm7
    pxor %xmm8, %xmm8
    pxor %xmm9, %xmm9
    pxor %xmm10, %xmm10
    pxor %xmm11, %xmm11
    pxor %xmm12, %xmm12
    pxor %xmm13, %xmm13
    pxor %xmm14, %xmm14
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r11, %r11
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm6
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    movdqu 16(%rsp), %xmm7
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    movdqu 32(%rsp), %xmm8
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    movdqu 48(%rsp), %xmm9
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    movdqu 64(%rsp), %xmm10
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    movdqu 80(%rsp), %xmm11
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    movdqu 96(%rsp), %xmm12
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    movdqu 112(%rsp), %xmm13
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    movdqu 128(%rsp), %xmm14
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    addq $152, %rsp
#endif
    ret
AREION_FUNC_END(areion256SoEMPermutex4AesNi)

AREION_FUNC_START(areion256SoEMPermutex4Vex)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %rdx, %r11
    movq %rcx, %rdx
    movq %r11, %rcx
#else
    subq $152, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm7, 16(%rsp)
    vmovdqu %xmm8, 32(%rsp)
    vmovdqu %xmm9, 48(%rsp)
    vmovdqu %xmm10, 64(%rsp)
    vmovdqu %xmm11, 80(%rsp)
    vmovdqu %xmm12, 96(%rsp)
    vmovdqu %xmm13, 112(%rsp)
    vmovdqu %xmm14, 128(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
    movq %r9, %rdx
#endif
    vpxor %xmm12, %xmm12, %xmm12
    vmovdqu (%rax), %xmm0
    vmovdqu (%r10), %xmm1
    vmovdqu 16(%rax), %xmm2
    vmovdqu 16(%r10), %xmm3
    vmovdqu (%rcx), %xmm4
    vmovdqu (%rdx), %xmm5
    vmovdqu 16(%rcx), %xmm6
    vmovdqu 16(%rdx), %xmm7
    vmovdqu AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm14, %xmm4, %xmm10
    vaesenc %xmm14, %xmm6, %xmm11
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 64+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 64+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm14, %xmm5, %xmm10
    vaesenc %xmm14, %xmm7, %xmm11
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 128+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 128+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm14, %xmm4, %xmm10
    vaesenc %xmm14, %xmm6, %xmm11
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 192+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 192+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm14, %xmm5, %xmm10
    vaesenc %xmm14, %xmm7, %xmm11
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 256+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 256+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm14, %xmm4, %xmm10
    vaesenc %xmm14, %xmm6, %xmm11
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 320+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 320+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm14, %xmm5, %xmm10
    vaesenc %xmm14, %xmm7, %xmm11
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 384+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 384+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm14, %xmm4, %xmm10
    vaesenc %xmm14, %xmm6, %xmm11
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 448+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 448+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm14, %xmm5, %xmm10
    vaesenc %xmm14, %xmm7, %xmm11
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 512+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 512+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm14, %xmm4, %xmm10
    vaesenc %xmm14, %xmm6, %xmm11
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 576+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 576+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm14, %xmm5, %xmm10
    vaesenc %xmm14, %xmm7, %xmm11
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vmovdqu %xmm0, (%rax)
    vmovdqu %xmm1, (%r10)
    vmovdqu %xmm2, 16(%rax)
    vmovdqu %xmm3, 16(%r10)
    vmovdqu 32(%rax), %xmm0
    vmovdqu 32(%r10), %xmm1
    vmovdqu 48(%rax), %xmm2
    vmovdqu 48(%r10), %xmm3
    vmovdqu 32(%rcx), %xmm4
    vmovdqu 32(%rdx), %xmm5
    vmovdqu 48(%rcx), %xmm6
    vmovdqu 48(%rdx), %xmm7
    vmovdqu AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm14, %xmm4, %xmm10
    vaesenc %xmm14, %xmm6, %xmm11
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 64+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 64+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm14, %xmm5, %xmm10
    vaesenc %xmm14, %xmm7, %xmm11
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 128+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 128+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm14, %xmm4, %xmm10
    vaesenc %xmm14, %xmm6, %xmm11
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 192+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 192+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm14, %xmm5, %xmm10
    vaesenc %xmm14, %xmm7, %xmm11
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 256+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 256+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm14, %xmm4, %xmm10
    vaesenc %xmm14, %xmm6, %xmm11
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 320+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 320+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm14, %xmm5, %xmm10
    vaesenc %xmm14, %xmm7, %xmm11
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 384+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 384+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm14, %xmm4, %xmm10
    vaesenc %xmm14, %xmm6, %xmm11
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 448+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 448+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm14, %xmm5, %xmm10
    vaesenc %xmm14, %xmm7, %xmm11
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 512+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 512+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm0, %xmm8
    vaesenc %xmm13, %xmm2, %xmm9
    vaesenc %xmm14, %xmm4, %xmm10
    vaesenc %xmm14, %xmm6, %xmm11
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 576+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 576+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm13, %xmm1, %xmm8
    vaesenc %xmm13, %xmm3, %xmm9
    vaesenc %xmm14, %xmm5, %xmm10
    vaesenc %xmm14, %xmm7, %xmm11
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vmovdqu %xmm0, 32(%rax)
    vmovdqu %xmm1, 32(%r10)
    vmovdqu %xmm2, 48(%rax)
    vmovdqu %xmm3, 48(%r10)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    vpxor %xmm7, %xmm7, %xmm7
    vpxor %xmm8, %xmm8, %xmm8
    vpxor %xmm9, %xmm9, %xmm9
    vpxor %xmm10, %xmm10, %xmm10
    vpxor %xmm11, %xmm11, %xmm11
    vpxor %xmm12, %xmm12, %xmm12
    vpxor %xmm13, %xmm13, %xmm13
    vpxor %xmm14, %xmm14, %xmm14
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r11, %r11
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm6
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm7
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
    vmovdqu 96(%rsp), %xmm12
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    vmovdqu 112(%rsp), %xmm13
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    vmovdqu 128(%rsp), %xmm14
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    addq $152, %rsp
#endif
    ret
AREION_FUNC_END(areion256SoEMPermutex4Vex)

AREION_FUNC_START(areion512SoEMPermutex4AesNi)
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
    subq $168, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    movdqu %xmm6, 16(%rsp)
    movdqu %xmm7, 32(%rsp)
    movdqu %xmm8, 48(%rsp)
    movdqu %xmm9, 64(%rsp)
    movdqu %xmm10, 80(%rsp)
    movdqu %xmm11, 96(%rsp)
    movdqu %xmm12, 112(%rsp)
    movdqu %xmm13, 128(%rsp)
    movdqu %xmm14, 144(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
    movq %r9, %rdx
    movq 208(%rsp), %rsi
    movq 216(%rsp), %rdi
    movq 224(%rsp), %r8
    movq 232(%rsp), %r9
#endif
    pxor %xmm12, %xmm12
    movdqu (%rax), %xmm0
    movdqu (%r10), %xmm1
    movdqu (%rcx), %xmm2
    movdqu (%rdx), %xmm3
    movdqu (%rsi), %xmm4
    movdqu (%rdi), %xmm5
    movdqu (%r8), %xmm6
    movdqu (%r9), %xmm7
    movdqu AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 64+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 64+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 128+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 128+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 192+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 192+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm14, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 256+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 256+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 320+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 320+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 384+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 384+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 448+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 448+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm14, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 512+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 512+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 576+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 576+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 640+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 640+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 704+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 704+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm14, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 768+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 768+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 832+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 832+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 896+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 896+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    pxor %xmm7, %xmm3
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    pxor %xmm6, %xmm2
    movdqu %xmm3, (%rax)
    movdqu %xmm0, (%r10)
    movdqu %xmm1, (%rcx)
    movdqu %xmm2, (%rdx)
    movdqu 16(%rax), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu 16(%rcx), %xmm2
    movdqu 16(%rdx), %xmm3
    movdqu 16(%rsi), %xmm4
    movdqu 16(%rdi), %xmm5
    movdqu 16(%r8), %xmm6
    movdqu 16(%r9), %xmm7
    movdqu AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 64+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 64+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 128+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 128+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 192+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 192+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm14, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 256+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 256+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 320+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 320+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 384+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 384+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 448+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 448+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm14, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 512+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 512+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 576+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 576+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 640+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 640+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 704+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 704+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm14, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 768+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 768+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 832+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 832+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 896+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 896+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    pxor %xmm7, %xmm3
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    pxor %xmm6, %xmm2
    movdqu %xmm3, 16(%rax)
    movdqu %xmm0, 16(%r10)
    movdqu %xmm1, 16(%rcx)
    movdqu %xmm2, 16(%rdx)
    movdqu 32(%rax), %xmm0
    movdqu 32(%r10), %xmm1
    movdqu 32(%rcx), %xmm2
    movdqu 32(%rdx), %xmm3
    movdqu 32(%rsi), %xmm4
    movdqu 32(%rdi), %xmm5
    movdqu 32(%r8), %xmm6
    movdqu 32(%r9), %xmm7
    movdqu AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 64+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 64+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 128+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 128+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 192+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 192+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm14, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 256+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 256+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 320+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 320+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 384+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 384+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 448+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 448+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm14, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 512+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 512+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 576+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 576+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 640+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 640+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 704+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 704+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm14, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 768+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 768+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 832+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 832+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 896+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 896+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    pxor %xmm7, %xmm3
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    pxor %xmm6, %xmm2
    movdqu %xmm3, 32(%rax)
    movdqu %xmm0, 32(%r10)
    movdqu %xmm1, 32(%rcx)
    movdqu %xmm2, 32(%rdx)
    movdqu 48(%rax), %xmm0
    movdqu 48(%r10), %xmm1
    movdqu 48(%rcx), %xmm2
    movdqu 48(%rdx), %xmm3
    movdqu 48(%rsi), %xmm4
    movdqu 48(%rdi), %xmm5
    movdqu 48(%r8), %xmm6
    movdqu 48(%r9), %xmm7
    movdqu AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 64+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 64+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 128+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 128+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 192+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 192+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm14, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 256+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 256+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 320+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 320+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 384+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 384+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 448+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 448+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm14, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 512+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 512+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 576+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 576+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 640+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 640+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    movdqu 704+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 704+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm3, %xmm8
    movdqu %xmm7, %xmm10
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm10
    movdqu %xmm8, %xmm0
    movdqu %xmm10, %xmm4
    movdqu %xmm1, %xmm9
    movdqu %xmm5, %xmm11
    aesenc %xmm2, %xmm9
    aesenc %xmm6, %xmm11
    movdqu %xmm9, %xmm2
    movdqu %xmm11, %xmm6
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenclast %xmm13, %xmm1
    aesenclast %xmm14, %xmm5
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm5
    movdqu 768+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 768+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm0, %xmm8
    movdqu %xmm4, %xmm10
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm10
    movdqu %xmm8, %xmm1
    movdqu %xmm10, %xmm5
    movdqu %xmm2, %xmm9
    movdqu %xmm6, %xmm11
    aesenc %xmm3, %xmm9
    aesenc %xmm7, %xmm11
    movdqu %xmm9, %xmm3
    movdqu %xmm11, %xmm7
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm2
    aesenclast %xmm14, %xmm6
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm6
    movdqu 832+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 832+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm1, %xmm8
    movdqu %xmm5, %xmm10
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm10
    movdqu %xmm8, %xmm2
    movdqu %xmm10, %xmm6
    movdqu %xmm3, %xmm9
    movdqu %xmm7, %xmm11
    aesenc %xmm0, %xmm9
    aesenc %xmm4, %xmm11
    movdqu %xmm9, %xmm0
    movdqu %xmm11, %xmm4
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenclast %xmm13, %xmm3
    aesenclast %xmm14, %xmm7
    aesenc %xmm12, %xmm3
    aesenc %xmm12, %xmm7
    movdqu 896+AREION_SYM(areionRC4x)(%rip), %xmm13
    movdqu 896+AREION_SYM(areionRC4x2)(%rip), %xmm14
    movdqu %xmm2, %xmm8
    movdqu %xmm6, %xmm10
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm10
    movdqu %xmm8, %xmm3
    movdqu %xmm10, %xmm7
    movdqu %xmm0, %xmm9
    movdqu %xmm4, %xmm11
    aesenc %xmm1, %xmm9
    aesenc %xmm5, %xmm11
    movdqu %xmm9, %xmm1
    movdqu %xmm11, %xmm5
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm0
    aesenclast %xmm14, %xmm4
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm4
    pxor %xmm7, %xmm3
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    pxor %xmm6, %xmm2
    movdqu %xmm3, 48(%rax)
    movdqu %xmm0, 48(%r10)
    movdqu %xmm1, 48(%rcx)
    movdqu %xmm2, 48(%rdx)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    pxor %xmm6, %xmm6
    pxor %xmm7, %xmm7
    pxor %xmm8, %xmm8
    pxor %xmm9, %xmm9
    pxor %xmm10, %xmm10
    pxor %xmm11, %xmm11
    pxor %xmm12, %xmm12
    pxor %xmm13, %xmm13
    pxor %xmm14, %xmm14
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
    movdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    movdqu 32(%rsp), %xmm7
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    movdqu 48(%rsp), %xmm8
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    movdqu 64(%rsp), %xmm9
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    movdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    movdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    movdqu 112(%rsp), %xmm12
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    movdqu 128(%rsp), %xmm13
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    movdqu 144(%rsp), %xmm14
    movq $0, 144(%rsp)
    movq $0, 152(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $168, %rsp
#endif
    ret
AREION_FUNC_END(areion512SoEMPermutex4AesNi)

AREION_FUNC_START(areion512SoEMPermutex4Vex)
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
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm12, 48(%rsp)
    vmovdqu %xmm13, 64(%rsp)
    vmovdqu %xmm14, 80(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
    movq %r9, %rdx
    movq 144(%rsp), %rsi
    movq 152(%rsp), %rdi
    movq 160(%rsp), %r8
    movq 168(%rsp), %r9
#endif
    vpxor %xmm12, %xmm12, %xmm12
    vmovdqu (%rax), %xmm0
    vmovdqu (%r10), %xmm1
    vmovdqu (%rcx), %xmm2
    vmovdqu (%rdx), %xmm3
    vmovdqu (%rsi), %xmm4
    vmovdqu (%rdi), %xmm5
    vmovdqu (%r8), %xmm6
    vmovdqu (%r9), %xmm7
    vmovdqu AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 64+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 64+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 128+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 128+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 192+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 192+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 256+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 256+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 320+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 320+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 384+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 384+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 448+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 448+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 512+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 512+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 576+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 576+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 640+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 640+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 704+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 704+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 768+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 768+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 832+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 832+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 896+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 896+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm6, %xmm2, %xmm2
    vmovdqu %xmm3, (%rax)
    vmovdqu %xmm0, (%r10)
    vmovdqu %xmm1, (%rcx)
    vmovdqu %xmm2, (%rdx)
    vmovdqu 16(%rax), %xmm0
    vmovdqu 16(%r10), %xmm1
    vmovdqu 16(%rcx), %xmm2
    vmovdqu 16(%rdx), %xmm3
    vmovdqu 16(%rsi), %xmm4
    vmovdqu 16(%rdi), %xmm5
    vmovdqu 16(%r8), %xmm6
    vmovdqu 16(%r9), %xmm7
    vmovdqu AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 64+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 64+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 128+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 128+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 192+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 192+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 256+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 256+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 320+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 320+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 384+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 384+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 448+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 448+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 512+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 512+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 576+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 576+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 640+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 640+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 704+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 704+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 768+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 768+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 832+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 832+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 896+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 896+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm6, %xmm2, %xmm2
    vmovdqu %xmm3, 16(%rax)
    vmovdqu %xmm0, 16(%r10)
    vmovdqu %xmm1, 16(%rcx)
    vmovdqu %xmm2, 16(%rdx)
    vmovdqu 32(%rax), %xmm0
    vmovdqu 32(%r10), %xmm1
    vmovdqu 32(%rcx), %xmm2
    vmovdqu 32(%rdx), %xmm3
    vmovdqu 32(%rsi), %xmm4
    vmovdqu 32(%rdi), %xmm5
    vmovdqu 32(%r8), %xmm6
    vmovdqu 32(%r9), %xmm7
    vmovdqu AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 64+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 64+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 128+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 128+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 192+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 192+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 256+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 256+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 320+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 320+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 384+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 384+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 448+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 448+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 512+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 512+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 576+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 576+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 640+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 640+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 704+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 704+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 768+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 768+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 832+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 832+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 896+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 896+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm6, %xmm2, %xmm2
    vmovdqu %xmm3, 32(%rax)
    vmovdqu %xmm0, 32(%r10)
    vmovdqu %xmm1, 32(%rcx)
    vmovdqu %xmm2, 32(%rdx)
    vmovdqu 48(%rax), %xmm0
    vmovdqu 48(%r10), %xmm1
    vmovdqu 48(%rcx), %xmm2
    vmovdqu 48(%rdx), %xmm3
    vmovdqu 48(%rsi), %xmm4
    vmovdqu 48(%rdi), %xmm5
    vmovdqu 48(%r8), %xmm6
    vmovdqu 48(%r9), %xmm7
    vmovdqu AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 64+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 64+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 128+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 128+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 192+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 192+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 256+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 256+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 320+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 320+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 384+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 384+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 448+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 448+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 512+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 512+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 576+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 576+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 640+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 640+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vmovdqu 704+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 704+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm5, %xmm5
    vmovdqu 768+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 768+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm2, %xmm2
    vaesenclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm6, %xmm6
    vmovdqu 832+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 832+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm12, %xmm3, %xmm3
    vaesenc %xmm12, %xmm7, %xmm7
    vmovdqu 896+AREION_SYM(areionRC4x)(%rip), %xmm13
    vmovdqu 896+AREION_SYM(areionRC4x2)(%rip), %xmm14
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm0, %xmm0
    vaesenclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm4, %xmm4
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm6, %xmm2, %xmm2
    vmovdqu %xmm3, 48(%rax)
    vmovdqu %xmm0, 48(%r10)
    vmovdqu %xmm1, 48(%rcx)
    vmovdqu %xmm2, 48(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    vpxor %xmm7, %xmm7, %xmm7
    vpxor %xmm12, %xmm12, %xmm12
    vpxor %xmm13, %xmm13, %xmm13
    vpxor %xmm14, %xmm14, %xmm14
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
    vmovdqu 48(%rsp), %xmm12
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    vmovdqu 64(%rsp), %xmm13
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    vmovdqu 80(%rsp), %xmm14
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $104, %rsp
#endif
    ret
AREION_FUNC_END(areion512SoEMPermutex4Vex)

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
