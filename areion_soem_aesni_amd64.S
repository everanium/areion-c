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
    movq %rsi, %r11
    movq %r8, %r10
    movq %rdx, %r8
    movq %rcx, %r9
#else
    subq $136, %rsp
    movdqu %xmm6, 0(%rsp)
    movdqu %xmm7, 16(%rsp)
    movdqu %xmm8, 32(%rsp)
    movdqu %xmm9, 48(%rsp)
    movdqu %xmm10, 64(%rsp)
    movdqu %xmm11, 80(%rsp)
    movdqu %xmm12, 96(%rsp)
    movdqu %xmm15, 112(%rsp)
    movq %rcx, %rax
    movq %rdx, %r11
    movq 176(%rsp), %r10
#endif
    movdqu (%rax), %xmm0
    movdqu 16(%rax), %xmm1
    movdqu (%r11), %xmm2
    movdqu 16(%r11), %xmm3
    movdqu (%r8), %xmm4
    movdqu 16(%r8), %xmm5
    movdqu (%r9), %xmm6
    movdqu 16(%r9), %xmm7
    pxor %xmm15, %xmm15
    movdqu (%r10), %xmm12
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm4
    aesenclast %xmm15, %xmm6
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 64(%r10), %xmm12
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm5
    aesenclast %xmm15, %xmm7
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 128(%r10), %xmm12
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm4
    aesenclast %xmm15, %xmm6
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 192(%r10), %xmm12
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm5
    aesenclast %xmm15, %xmm7
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 256(%r10), %xmm12
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm4
    aesenclast %xmm15, %xmm6
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 320(%r10), %xmm12
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm5
    aesenclast %xmm15, %xmm7
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 384(%r10), %xmm12
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm4
    aesenclast %xmm15, %xmm6
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 448(%r10), %xmm12
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm5
    aesenclast %xmm15, %xmm7
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 512(%r10), %xmm12
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm4
    aesenclast %xmm15, %xmm6
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 576(%r10), %xmm12
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm5
    aesenclast %xmm15, %xmm7
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu %xmm0, (%rax)
    movdqu %xmm1, 16(%rax)
    movdqu %xmm2, (%r11)
    movdqu %xmm3, 16(%r11)
    movdqu %xmm4, (%r8)
    movdqu %xmm5, 16(%r8)
    movdqu %xmm6, (%r9)
    movdqu %xmm7, 16(%r9)
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
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r8, %r8
    xorq %r9, %r9
    xorq %r10, %r10
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
    movdqu 112(%rsp), %xmm15
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    addq $136, %rsp
#endif
    ret
AREION_FUNC_END(areion256Permutex4AesNiRC)

AREION_FUNC_START(areion256Permutex4VexRC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r11
    movq %r8, %r10
    movq %rdx, %r8
    movq %rcx, %r9
#else
    subq $136, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm7, 16(%rsp)
    vmovdqu %xmm8, 32(%rsp)
    vmovdqu %xmm9, 48(%rsp)
    vmovdqu %xmm10, 64(%rsp)
    vmovdqu %xmm11, 80(%rsp)
    vmovdqu %xmm12, 96(%rsp)
    vmovdqu %xmm15, 112(%rsp)
    movq %rcx, %rax
    movq %rdx, %r11
    movq 176(%rsp), %r10
#endif
    vmovdqu (%rax), %xmm0
    vmovdqu 16(%rax), %xmm1
    vmovdqu (%r11), %xmm2
    vmovdqu 16(%r11), %xmm3
    vmovdqu (%r8), %xmm4
    vmovdqu 16(%r8), %xmm5
    vmovdqu (%r9), %xmm6
    vmovdqu 16(%r9), %xmm7
    vpxor %xmm15, %xmm15, %xmm15
    vmovdqu (%r10), %xmm12
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm12, %xmm4, %xmm10
    vaesenc %xmm12, %xmm6, %xmm11
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 64(%r10), %xmm12
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm12, %xmm5, %xmm10
    vaesenc %xmm12, %xmm7, %xmm11
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 128(%r10), %xmm12
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm12, %xmm4, %xmm10
    vaesenc %xmm12, %xmm6, %xmm11
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 192(%r10), %xmm12
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm12, %xmm5, %xmm10
    vaesenc %xmm12, %xmm7, %xmm11
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 256(%r10), %xmm12
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm12, %xmm4, %xmm10
    vaesenc %xmm12, %xmm6, %xmm11
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 320(%r10), %xmm12
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm12, %xmm5, %xmm10
    vaesenc %xmm12, %xmm7, %xmm11
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 384(%r10), %xmm12
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm12, %xmm4, %xmm10
    vaesenc %xmm12, %xmm6, %xmm11
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 448(%r10), %xmm12
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm12, %xmm5, %xmm10
    vaesenc %xmm12, %xmm7, %xmm11
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 512(%r10), %xmm12
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm12, %xmm4, %xmm10
    vaesenc %xmm12, %xmm6, %xmm11
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 576(%r10), %xmm12
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm12, %xmm5, %xmm10
    vaesenc %xmm12, %xmm7, %xmm11
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu %xmm0, (%rax)
    vmovdqu %xmm1, 16(%rax)
    vmovdqu %xmm2, (%r11)
    vmovdqu %xmm3, 16(%r11)
    vmovdqu %xmm4, (%r8)
    vmovdqu %xmm5, 16(%r8)
    vmovdqu %xmm6, (%r9)
    vmovdqu %xmm7, 16(%r9)
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
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r8, %r8
    xorq %r9, %r9
    xorq %r10, %r10
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
    vmovdqu 112(%rsp), %xmm15
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    addq $136, %rsp
#endif
    ret
AREION_FUNC_END(areion256Permutex4VexRC)

AREION_FUNC_START(areion256InversePermutex4AesNiRC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r11
    movq %r8, %r10
    movq %rdx, %r8
    movq %rcx, %r9
#else
    subq $136, %rsp
    movdqu %xmm6, 0(%rsp)
    movdqu %xmm7, 16(%rsp)
    movdqu %xmm8, 32(%rsp)
    movdqu %xmm9, 48(%rsp)
    movdqu %xmm10, 64(%rsp)
    movdqu %xmm11, 80(%rsp)
    movdqu %xmm12, 96(%rsp)
    movdqu %xmm15, 112(%rsp)
    movq %rcx, %rax
    movq %rdx, %r11
    movq 176(%rsp), %r10
#endif
    movdqu (%rax), %xmm0
    movdqu 16(%rax), %xmm1
    movdqu (%r11), %xmm2
    movdqu 16(%r11), %xmm3
    movdqu (%r8), %xmm4
    movdqu 16(%r8), %xmm5
    movdqu (%r9), %xmm6
    movdqu 16(%r9), %xmm7
    pxor %xmm15, %xmm15
    movdqu 576(%r10), %xmm12
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm5
    aesdeclast %xmm15, %xmm7
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 512(%r10), %xmm12
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm4
    aesdeclast %xmm15, %xmm6
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 448(%r10), %xmm12
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm5
    aesdeclast %xmm15, %xmm7
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 384(%r10), %xmm12
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm4
    aesdeclast %xmm15, %xmm6
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 320(%r10), %xmm12
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm5
    aesdeclast %xmm15, %xmm7
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 256(%r10), %xmm12
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm4
    aesdeclast %xmm15, %xmm6
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 192(%r10), %xmm12
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm5
    aesdeclast %xmm15, %xmm7
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 128(%r10), %xmm12
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm4
    aesdeclast %xmm15, %xmm6
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 64(%r10), %xmm12
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm5
    aesdeclast %xmm15, %xmm7
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu (%r10), %xmm12
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm4
    aesdeclast %xmm15, %xmm6
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm12, %xmm10
    aesenc %xmm12, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu %xmm0, (%rax)
    movdqu %xmm1, 16(%rax)
    movdqu %xmm2, (%r11)
    movdqu %xmm3, 16(%r11)
    movdqu %xmm4, (%r8)
    movdqu %xmm5, 16(%r8)
    movdqu %xmm6, (%r9)
    movdqu %xmm7, 16(%r9)
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
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r8, %r8
    xorq %r9, %r9
    xorq %r10, %r10
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
    movdqu 112(%rsp), %xmm15
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    addq $136, %rsp
#endif
    ret
AREION_FUNC_END(areion256InversePermutex4AesNiRC)

AREION_FUNC_START(areion256InversePermutex4VexRC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r11
    movq %r8, %r10
    movq %rdx, %r8
    movq %rcx, %r9
#else
    subq $136, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm7, 16(%rsp)
    vmovdqu %xmm8, 32(%rsp)
    vmovdqu %xmm9, 48(%rsp)
    vmovdqu %xmm10, 64(%rsp)
    vmovdqu %xmm11, 80(%rsp)
    vmovdqu %xmm12, 96(%rsp)
    vmovdqu %xmm15, 112(%rsp)
    movq %rcx, %rax
    movq %rdx, %r11
    movq 176(%rsp), %r10
#endif
    vmovdqu (%rax), %xmm0
    vmovdqu 16(%rax), %xmm1
    vmovdqu (%r11), %xmm2
    vmovdqu 16(%r11), %xmm3
    vmovdqu (%r8), %xmm4
    vmovdqu 16(%r8), %xmm5
    vmovdqu (%r9), %xmm6
    vmovdqu 16(%r9), %xmm7
    vpxor %xmm15, %xmm15, %xmm15
    vmovdqu 576(%r10), %xmm12
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm12, %xmm5, %xmm10
    vaesenc %xmm12, %xmm7, %xmm11
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 512(%r10), %xmm12
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm12, %xmm4, %xmm10
    vaesenc %xmm12, %xmm6, %xmm11
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 448(%r10), %xmm12
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm12, %xmm5, %xmm10
    vaesenc %xmm12, %xmm7, %xmm11
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 384(%r10), %xmm12
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm12, %xmm4, %xmm10
    vaesenc %xmm12, %xmm6, %xmm11
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 320(%r10), %xmm12
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm12, %xmm5, %xmm10
    vaesenc %xmm12, %xmm7, %xmm11
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 256(%r10), %xmm12
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm12, %xmm4, %xmm10
    vaesenc %xmm12, %xmm6, %xmm11
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 192(%r10), %xmm12
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm12, %xmm5, %xmm10
    vaesenc %xmm12, %xmm7, %xmm11
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 128(%r10), %xmm12
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm12, %xmm4, %xmm10
    vaesenc %xmm12, %xmm6, %xmm11
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 64(%r10), %xmm12
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm12, %xmm5, %xmm10
    vaesenc %xmm12, %xmm7, %xmm11
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu (%r10), %xmm12
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm12, %xmm4, %xmm10
    vaesenc %xmm12, %xmm6, %xmm11
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu %xmm0, (%rax)
    vmovdqu %xmm1, 16(%rax)
    vmovdqu %xmm2, (%r11)
    vmovdqu %xmm3, 16(%r11)
    vmovdqu %xmm4, (%r8)
    vmovdqu %xmm5, 16(%r8)
    vmovdqu %xmm6, (%r9)
    vmovdqu %xmm7, 16(%r9)
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
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r8, %r8
    xorq %r9, %r9
    xorq %r10, %r10
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
    vmovdqu 112(%rsp), %xmm15
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    addq $136, %rsp
#endif
    ret
AREION_FUNC_END(areion256InversePermutex4VexRC)

AREION_FUNC_START(areion512Permutex4AesNiRC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r11
    movq %r8, %r10
    movq %rdx, %r8
    movq %rcx, %r9
#else
    subq $136, %rsp
    movdqu %xmm6, 0(%rsp)
    movdqu %xmm7, 16(%rsp)
    movdqu %xmm8, 32(%rsp)
    movdqu %xmm9, 48(%rsp)
    movdqu %xmm10, 64(%rsp)
    movdqu %xmm11, 80(%rsp)
    movdqu %xmm12, 96(%rsp)
    movdqu %xmm15, 112(%rsp)
    movq %rcx, %rax
    movq %rdx, %r11
    movq 176(%rsp), %r10
#endif
    pxor %xmm15, %xmm15
    movdqu (%rax), %xmm0
    movdqu 16(%rax), %xmm1
    movdqu 32(%rax), %xmm2
    movdqu 48(%rax), %xmm3
    movdqu (%r11), %xmm4
    movdqu 16(%r11), %xmm5
    movdqu 32(%r11), %xmm6
    movdqu 48(%r11), %xmm7
    movdqu (%r10), %xmm12
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm2, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    aesenc %xmm3, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm10, %xmm3
    movdqa %xmm11, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 64(%r10), %xmm12
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 128(%r10), %xmm12
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 192(%r10), %xmm12
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    movdqa %xmm1, %xmm10
    movdqa %xmm5, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    aesenc %xmm2, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm10, %xmm2
    movdqa %xmm11, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 256(%r10), %xmm12
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm2, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    aesenc %xmm3, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm10, %xmm3
    movdqa %xmm11, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 320(%r10), %xmm12
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 384(%r10), %xmm12
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 448(%r10), %xmm12
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    movdqa %xmm1, %xmm10
    movdqa %xmm5, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    aesenc %xmm2, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm10, %xmm2
    movdqa %xmm11, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 512(%r10), %xmm12
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm2, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    aesenc %xmm3, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm10, %xmm3
    movdqa %xmm11, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 576(%r10), %xmm12
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 640(%r10), %xmm12
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 704(%r10), %xmm12
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    movdqa %xmm1, %xmm10
    movdqa %xmm5, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    aesenc %xmm2, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm10, %xmm2
    movdqa %xmm11, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 768(%r10), %xmm12
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm2, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    aesenc %xmm3, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm10, %xmm3
    movdqa %xmm11, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 832(%r10), %xmm12
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 896(%r10), %xmm12
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu %xmm3, (%rax)
    movdqu %xmm0, 16(%rax)
    movdqu %xmm1, 32(%rax)
    movdqu %xmm2, 48(%rax)
    movdqu %xmm7, (%r11)
    movdqu %xmm4, 16(%r11)
    movdqu %xmm5, 32(%r11)
    movdqu %xmm6, 48(%r11)
    movdqu (%r8), %xmm0
    movdqu 16(%r8), %xmm1
    movdqu 32(%r8), %xmm2
    movdqu 48(%r8), %xmm3
    movdqu (%r9), %xmm4
    movdqu 16(%r9), %xmm5
    movdqu 32(%r9), %xmm6
    movdqu 48(%r9), %xmm7
    movdqu (%r10), %xmm12
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm2, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    aesenc %xmm3, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm10, %xmm3
    movdqa %xmm11, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 64(%r10), %xmm12
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 128(%r10), %xmm12
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 192(%r10), %xmm12
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    movdqa %xmm1, %xmm10
    movdqa %xmm5, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    aesenc %xmm2, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm10, %xmm2
    movdqa %xmm11, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 256(%r10), %xmm12
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm2, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    aesenc %xmm3, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm10, %xmm3
    movdqa %xmm11, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 320(%r10), %xmm12
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 384(%r10), %xmm12
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 448(%r10), %xmm12
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    movdqa %xmm1, %xmm10
    movdqa %xmm5, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    aesenc %xmm2, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm10, %xmm2
    movdqa %xmm11, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 512(%r10), %xmm12
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm2, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    aesenc %xmm3, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm10, %xmm3
    movdqa %xmm11, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 576(%r10), %xmm12
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 640(%r10), %xmm12
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 704(%r10), %xmm12
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    movdqa %xmm1, %xmm10
    movdqa %xmm5, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    aesenc %xmm2, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm10, %xmm2
    movdqa %xmm11, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm12, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 768(%r10), %xmm12
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm2, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    aesenc %xmm3, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm10, %xmm3
    movdqa %xmm11, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm12, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 832(%r10), %xmm12
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm12, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 896(%r10), %xmm12
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm12, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu %xmm3, (%r8)
    movdqu %xmm0, 16(%r8)
    movdqu %xmm1, 32(%r8)
    movdqu %xmm2, 48(%r8)
    movdqu %xmm7, (%r9)
    movdqu %xmm4, 16(%r9)
    movdqu %xmm5, 32(%r9)
    movdqu %xmm6, 48(%r9)
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
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r8, %r8
    xorq %r9, %r9
    xorq %r10, %r10
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
    movdqu 112(%rsp), %xmm15
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    addq $136, %rsp
#endif
    ret
AREION_FUNC_END(areion512Permutex4AesNiRC)

AREION_FUNC_START(areion512Permutex4VexRC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r11
    movq %r8, %r10
    movq %rdx, %r8
    movq %rcx, %r9
#else
    subq $72, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm7, 16(%rsp)
    vmovdqu %xmm12, 32(%rsp)
    vmovdqu %xmm15, 48(%rsp)
    movq %rcx, %rax
    movq %rdx, %r11
    movq 112(%rsp), %r10
#endif
    vpxor %xmm15, %xmm15, %xmm15
    vmovdqu (%rax), %xmm0
    vmovdqu 16(%rax), %xmm1
    vmovdqu 32(%rax), %xmm2
    vmovdqu 48(%rax), %xmm3
    vmovdqu (%r11), %xmm4
    vmovdqu 16(%r11), %xmm5
    vmovdqu 32(%r11), %xmm6
    vmovdqu 48(%r11), %xmm7
    vmovdqu (%r10), %xmm12
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vmovdqu 64(%r10), %xmm12
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vmovdqu 128(%r10), %xmm12
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vmovdqu 192(%r10), %xmm12
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vmovdqu 256(%r10), %xmm12
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vmovdqu 320(%r10), %xmm12
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vmovdqu 384(%r10), %xmm12
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vmovdqu 448(%r10), %xmm12
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vmovdqu 512(%r10), %xmm12
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vmovdqu 576(%r10), %xmm12
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vmovdqu 640(%r10), %xmm12
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vmovdqu 704(%r10), %xmm12
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vmovdqu 768(%r10), %xmm12
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vmovdqu 832(%r10), %xmm12
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vmovdqu 896(%r10), %xmm12
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vmovdqu %xmm3, (%rax)
    vmovdqu %xmm0, 16(%rax)
    vmovdqu %xmm1, 32(%rax)
    vmovdqu %xmm2, 48(%rax)
    vmovdqu %xmm7, (%r11)
    vmovdqu %xmm4, 16(%r11)
    vmovdqu %xmm5, 32(%r11)
    vmovdqu %xmm6, 48(%r11)
    vmovdqu (%r8), %xmm0
    vmovdqu 16(%r8), %xmm1
    vmovdqu 32(%r8), %xmm2
    vmovdqu 48(%r8), %xmm3
    vmovdqu (%r9), %xmm4
    vmovdqu 16(%r9), %xmm5
    vmovdqu 32(%r9), %xmm6
    vmovdqu 48(%r9), %xmm7
    vmovdqu (%r10), %xmm12
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vmovdqu 64(%r10), %xmm12
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vmovdqu 128(%r10), %xmm12
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vmovdqu 192(%r10), %xmm12
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vmovdqu 256(%r10), %xmm12
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vmovdqu 320(%r10), %xmm12
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vmovdqu 384(%r10), %xmm12
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vmovdqu 448(%r10), %xmm12
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vmovdqu 512(%r10), %xmm12
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vmovdqu 576(%r10), %xmm12
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vmovdqu 640(%r10), %xmm12
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vmovdqu 704(%r10), %xmm12
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast %xmm12, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vmovdqu 768(%r10), %xmm12
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vmovdqu 832(%r10), %xmm12
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vmovdqu 896(%r10), %xmm12
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vmovdqu %xmm3, (%r8)
    vmovdqu %xmm0, 16(%r8)
    vmovdqu %xmm1, 32(%r8)
    vmovdqu %xmm2, 48(%r8)
    vmovdqu %xmm7, (%r9)
    vmovdqu %xmm4, 16(%r9)
    vmovdqu %xmm5, 32(%r9)
    vmovdqu %xmm6, 48(%r9)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    vpxor %xmm7, %xmm7, %xmm7
    vpxor %xmm12, %xmm12, %xmm12
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r8, %r8
    xorq %r9, %r9
    xorq %r10, %r10
    xorq %r11, %r11
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm6
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm7
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm12
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    vmovdqu 48(%rsp), %xmm15
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    addq $72, %rsp
#endif
    ret
AREION_FUNC_END(areion512Permutex4VexRC)

AREION_FUNC_START(areion512InversePermutex4AesNiRC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r11
    movq %r8, %r10
    movq %rdx, %r8
    movq %rcx, %r9
#else
    subq $136, %rsp
    movdqu %xmm6, 0(%rsp)
    movdqu %xmm7, 16(%rsp)
    movdqu %xmm8, 32(%rsp)
    movdqu %xmm9, 48(%rsp)
    movdqu %xmm10, 64(%rsp)
    movdqu %xmm11, 80(%rsp)
    movdqu %xmm12, 96(%rsp)
    movdqu %xmm15, 112(%rsp)
    movq %rcx, %rax
    movq %rdx, %r11
    movq 176(%rsp), %r10
#endif
    pxor %xmm15, %xmm15
    movdqu (%rax), %xmm0
    movdqu 16(%rax), %xmm1
    movdqu 32(%rax), %xmm2
    movdqu 48(%rax), %xmm3
    movdqu (%r11), %xmm4
    movdqu 16(%r11), %xmm5
    movdqu 32(%r11), %xmm6
    movdqu 48(%r11), %xmm7
    movdqu 896(%r10), %xmm12
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    aesimc %xmm1, %xmm1
    aesimc %xmm5, %xmm5
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    movdqa %xmm1, %xmm10
    movdqa %xmm5, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    aesenc %xmm2, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm10, %xmm2
    movdqa %xmm11, %xmm6
    movdqu 832(%r10), %xmm12
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm4
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    movdqu 768(%r10), %xmm12
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    movdqu 704(%r10), %xmm12
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm4
    aesimc %xmm2, %xmm2
    aesimc %xmm6, %xmm6
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm6
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm2, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    aesenc %xmm3, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm10, %xmm3
    movdqa %xmm11, %xmm7
    movdqu 640(%r10), %xmm12
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    aesimc %xmm1, %xmm1
    aesimc %xmm5, %xmm5
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    movdqa %xmm1, %xmm10
    movdqa %xmm5, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    aesenc %xmm2, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm10, %xmm2
    movdqa %xmm11, %xmm6
    movdqu 576(%r10), %xmm12
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm4
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    movdqu 512(%r10), %xmm12
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    movdqu 448(%r10), %xmm12
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm4
    aesimc %xmm2, %xmm2
    aesimc %xmm6, %xmm6
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm6
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm2, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    aesenc %xmm3, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm10, %xmm3
    movdqa %xmm11, %xmm7
    movdqu 384(%r10), %xmm12
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    aesimc %xmm1, %xmm1
    aesimc %xmm5, %xmm5
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    movdqa %xmm1, %xmm10
    movdqa %xmm5, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    aesenc %xmm2, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm10, %xmm2
    movdqa %xmm11, %xmm6
    movdqu 320(%r10), %xmm12
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm4
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    movdqu 256(%r10), %xmm12
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    movdqu 192(%r10), %xmm12
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm4
    aesimc %xmm2, %xmm2
    aesimc %xmm6, %xmm6
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm6
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm2, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    aesenc %xmm3, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm10, %xmm3
    movdqa %xmm11, %xmm7
    movdqu 128(%r10), %xmm12
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    aesimc %xmm1, %xmm1
    aesimc %xmm5, %xmm5
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    movdqa %xmm1, %xmm10
    movdqa %xmm5, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    aesenc %xmm2, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm10, %xmm2
    movdqa %xmm11, %xmm6
    movdqu 64(%r10), %xmm12
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm4
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    movdqu (%r10), %xmm12
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    movdqu %xmm1, (%rax)
    movdqu %xmm2, 16(%rax)
    movdqu %xmm3, 32(%rax)
    movdqu %xmm0, 48(%rax)
    movdqu %xmm5, (%r11)
    movdqu %xmm6, 16(%r11)
    movdqu %xmm7, 32(%r11)
    movdqu %xmm4, 48(%r11)
    movdqu (%r8), %xmm0
    movdqu 16(%r8), %xmm1
    movdqu 32(%r8), %xmm2
    movdqu 48(%r8), %xmm3
    movdqu (%r9), %xmm4
    movdqu 16(%r9), %xmm5
    movdqu 32(%r9), %xmm6
    movdqu 48(%r9), %xmm7
    movdqu 896(%r10), %xmm12
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    aesimc %xmm1, %xmm1
    aesimc %xmm5, %xmm5
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    movdqa %xmm1, %xmm10
    movdqa %xmm5, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    aesenc %xmm2, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm10, %xmm2
    movdqa %xmm11, %xmm6
    movdqu 832(%r10), %xmm12
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm4
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    movdqu 768(%r10), %xmm12
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    movdqu 704(%r10), %xmm12
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm4
    aesimc %xmm2, %xmm2
    aesimc %xmm6, %xmm6
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm6
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm2, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    aesenc %xmm3, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm10, %xmm3
    movdqa %xmm11, %xmm7
    movdqu 640(%r10), %xmm12
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    aesimc %xmm1, %xmm1
    aesimc %xmm5, %xmm5
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    movdqa %xmm1, %xmm10
    movdqa %xmm5, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    aesenc %xmm2, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm10, %xmm2
    movdqa %xmm11, %xmm6
    movdqu 576(%r10), %xmm12
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm4
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    movdqu 512(%r10), %xmm12
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    movdqu 448(%r10), %xmm12
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm4
    aesimc %xmm2, %xmm2
    aesimc %xmm6, %xmm6
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm6
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm2, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    aesenc %xmm3, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm10, %xmm3
    movdqa %xmm11, %xmm7
    movdqu 384(%r10), %xmm12
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    aesimc %xmm1, %xmm1
    aesimc %xmm5, %xmm5
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    movdqa %xmm1, %xmm10
    movdqa %xmm5, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    aesenc %xmm2, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm10, %xmm2
    movdqa %xmm11, %xmm6
    movdqu 320(%r10), %xmm12
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm4
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    movdqu 256(%r10), %xmm12
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    movdqu 192(%r10), %xmm12
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm4
    aesimc %xmm2, %xmm2
    aesimc %xmm6, %xmm6
    aesdeclast %xmm12, %xmm2
    aesdeclast %xmm12, %xmm6
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm6
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm2, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    aesenc %xmm3, %xmm10
    aesenc %xmm7, %xmm11
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm10, %xmm3
    movdqa %xmm11, %xmm7
    movdqu 128(%r10), %xmm12
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    aesimc %xmm1, %xmm1
    aesimc %xmm5, %xmm5
    aesdeclast %xmm12, %xmm1
    aesdeclast %xmm12, %xmm5
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    movdqa %xmm1, %xmm10
    movdqa %xmm5, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    aesenc %xmm2, %xmm10
    aesenc %xmm6, %xmm11
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm10, %xmm2
    movdqa %xmm11, %xmm6
    movdqu 64(%r10), %xmm12
    aesdeclast %xmm15, %xmm2
    aesdeclast %xmm15, %xmm6
    aesimc %xmm0, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm12, %xmm0
    aesdeclast %xmm12, %xmm4
    aesdeclast %xmm15, %xmm0
    aesdeclast %xmm15, %xmm4
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    movdqa %xmm0, %xmm10
    movdqa %xmm4, %xmm11
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    aesenc %xmm1, %xmm10
    aesenc %xmm5, %xmm11
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm10, %xmm1
    movdqa %xmm11, %xmm5
    movdqu (%r10), %xmm12
    aesdeclast %xmm15, %xmm1
    aesdeclast %xmm15, %xmm5
    aesimc %xmm3, %xmm3
    aesimc %xmm7, %xmm7
    aesdeclast %xmm12, %xmm3
    aesdeclast %xmm12, %xmm7
    aesdeclast %xmm15, %xmm3
    aesdeclast %xmm15, %xmm7
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    movdqa %xmm3, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    aesenc %xmm0, %xmm10
    aesenc %xmm4, %xmm11
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm10, %xmm0
    movdqa %xmm11, %xmm4
    movdqu %xmm1, (%r8)
    movdqu %xmm2, 16(%r8)
    movdqu %xmm3, 32(%r8)
    movdqu %xmm0, 48(%r8)
    movdqu %xmm5, (%r9)
    movdqu %xmm6, 16(%r9)
    movdqu %xmm7, 32(%r9)
    movdqu %xmm4, 48(%r9)
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
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r8, %r8
    xorq %r9, %r9
    xorq %r10, %r10
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
    movdqu 112(%rsp), %xmm15
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    addq $136, %rsp
#endif
    ret
AREION_FUNC_END(areion512InversePermutex4AesNiRC)

AREION_FUNC_START(areion512InversePermutex4VexRC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r11
    movq %r8, %r10
    movq %rdx, %r8
    movq %rcx, %r9
#else
    subq $72, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm7, 16(%rsp)
    vmovdqu %xmm12, 32(%rsp)
    vmovdqu %xmm15, 48(%rsp)
    movq %rcx, %rax
    movq %rdx, %r11
    movq 112(%rsp), %r10
#endif
    vpxor %xmm15, %xmm15, %xmm15
    vmovdqu (%rax), %xmm0
    vmovdqu 16(%rax), %xmm1
    vmovdqu 32(%rax), %xmm2
    vmovdqu 48(%rax), %xmm3
    vmovdqu (%r11), %xmm4
    vmovdqu 16(%r11), %xmm5
    vmovdqu 32(%r11), %xmm6
    vmovdqu 48(%r11), %xmm7
    vmovdqu 896(%r10), %xmm12
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vmovdqu 832(%r10), %xmm12
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu 768(%r10), %xmm12
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu 704(%r10), %xmm12
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesimc %xmm2, %xmm2
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vmovdqu 640(%r10), %xmm12
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vmovdqu 576(%r10), %xmm12
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu 512(%r10), %xmm12
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu 448(%r10), %xmm12
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesimc %xmm2, %xmm2
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vmovdqu 384(%r10), %xmm12
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vmovdqu 320(%r10), %xmm12
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu 256(%r10), %xmm12
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu 192(%r10), %xmm12
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesimc %xmm2, %xmm2
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vmovdqu 128(%r10), %xmm12
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vmovdqu 64(%r10), %xmm12
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu (%r10), %xmm12
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu %xmm1, (%rax)
    vmovdqu %xmm2, 16(%rax)
    vmovdqu %xmm3, 32(%rax)
    vmovdqu %xmm0, 48(%rax)
    vmovdqu %xmm5, (%r11)
    vmovdqu %xmm6, 16(%r11)
    vmovdqu %xmm7, 32(%r11)
    vmovdqu %xmm4, 48(%r11)
    vmovdqu (%r8), %xmm0
    vmovdqu 16(%r8), %xmm1
    vmovdqu 32(%r8), %xmm2
    vmovdqu 48(%r8), %xmm3
    vmovdqu (%r9), %xmm4
    vmovdqu 16(%r9), %xmm5
    vmovdqu 32(%r9), %xmm6
    vmovdqu 48(%r9), %xmm7
    vmovdqu 896(%r10), %xmm12
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vmovdqu 832(%r10), %xmm12
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu 768(%r10), %xmm12
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu 704(%r10), %xmm12
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesimc %xmm2, %xmm2
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vmovdqu 640(%r10), %xmm12
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vmovdqu 576(%r10), %xmm12
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu 512(%r10), %xmm12
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu 448(%r10), %xmm12
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesimc %xmm2, %xmm2
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vmovdqu 384(%r10), %xmm12
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vmovdqu 320(%r10), %xmm12
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu 256(%r10), %xmm12
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu 192(%r10), %xmm12
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesimc %xmm2, %xmm2
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vmovdqu 128(%r10), %xmm12
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm5, %xmm5
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vmovdqu 64(%r10), %xmm12
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm6, %xmm6
    vaesimc %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm4, %xmm4
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vmovdqu (%r10), %xmm12
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm5, %xmm5
    vaesimc %xmm3, %xmm3
    vaesimc %xmm7, %xmm7
    vaesdeclast %xmm12, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm7, %xmm7
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vmovdqu %xmm1, (%r8)
    vmovdqu %xmm2, 16(%r8)
    vmovdqu %xmm3, 32(%r8)
    vmovdqu %xmm0, 48(%r8)
    vmovdqu %xmm5, (%r9)
    vmovdqu %xmm6, 16(%r9)
    vmovdqu %xmm7, 32(%r9)
    vmovdqu %xmm4, 48(%r9)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    vpxor %xmm7, %xmm7, %xmm7
    vpxor %xmm12, %xmm12, %xmm12
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r8, %r8
    xorq %r9, %r9
    xorq %r10, %r10
    xorq %r11, %r11
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm6
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm7
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm12
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    vmovdqu 48(%rsp), %xmm15
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    addq $72, %rsp
#endif
    ret
AREION_FUNC_END(areion512InversePermutex4VexRC)

AREION_FUNC_START(areion256SoEMPermutex4AesNi)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
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
    movdqu %xmm15, 128(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    pxor %xmm15, %xmm15
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu 32(%r10), %xmm2
    movdqu 48(%r10), %xmm3
    movdqa %xmm0, %xmm4
    movdqa %xmm1, %xmm5
    movdqa %xmm2, %xmm6
    movdqa %xmm3, %xmm7
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm4
    pxor %xmm11, %xmm5
    movdqu 64(%rax), %xmm8
    movdqu 80(%rax), %xmm9
    movdqu 96(%rax), %xmm10
    movdqu 112(%rax), %xmm11
    pxor %xmm8, %xmm2
    pxor %xmm9, %xmm3
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm4
    aesenclast %xmm15, %xmm6
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm5
    aesenclast %xmm15, %xmm7
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm4
    aesenclast %xmm15, %xmm6
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm5
    aesenclast %xmm15, %xmm7
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm4
    aesenclast %xmm15, %xmm6
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm5
    aesenclast %xmm15, %xmm7
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm4
    aesenclast %xmm15, %xmm6
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm5
    aesenclast %xmm15, %xmm7
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm4
    aesenclast %xmm15, %xmm6
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm5
    aesenclast %xmm15, %xmm7
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    movdqu 64(%rax), %xmm8
    movdqu 80(%rax), %xmm9
    movdqu 96(%rax), %xmm10
    movdqu 112(%rax), %xmm11
    pxor %xmm8, %xmm2
    pxor %xmm9, %xmm3
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    movdqu %xmm0, (%rdx)
    movdqu %xmm1, 16(%rdx)
    movdqu %xmm2, 32(%rdx)
    movdqu %xmm3, 48(%rdx)
    movdqu 64(%r10), %xmm0
    movdqu 80(%r10), %xmm1
    movdqu 96(%r10), %xmm2
    movdqu 112(%r10), %xmm3
    movdqa %xmm0, %xmm4
    movdqa %xmm1, %xmm5
    movdqa %xmm2, %xmm6
    movdqa %xmm3, %xmm7
    movdqu 128(%rax), %xmm8
    movdqu 144(%rax), %xmm9
    movdqu 160(%rax), %xmm10
    movdqu 176(%rax), %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm4
    pxor %xmm11, %xmm5
    movdqu 192(%rax), %xmm8
    movdqu 208(%rax), %xmm9
    movdqu 224(%rax), %xmm10
    movdqu 240(%rax), %xmm11
    pxor %xmm8, %xmm2
    pxor %xmm9, %xmm3
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm4
    aesenclast %xmm15, %xmm6
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm5
    aesenclast %xmm15, %xmm7
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm4
    aesenclast %xmm15, %xmm6
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm5
    aesenclast %xmm15, %xmm7
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm4
    aesenclast %xmm15, %xmm6
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm5
    aesenclast %xmm15, %xmm7
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm4
    aesenclast %xmm15, %xmm6
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm5
    aesenclast %xmm15, %xmm7
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm2, %xmm9
    movdqa %xmm4, %xmm10
    movdqa %xmm6, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm1, %xmm8
    aesenc %xmm3, %xmm9
    aesenc %xmm5, %xmm10
    aesenc %xmm7, %xmm11
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm4
    aesenclast %xmm15, %xmm6
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm3
    movdqa %xmm10, %xmm5
    movdqa %xmm11, %xmm7
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm3, %xmm9
    movdqa %xmm5, %xmm10
    movdqa %xmm7, %xmm11
    aesenc %xmm12, %xmm8
    aesenc %xmm12, %xmm9
    aesenc %xmm13, %xmm10
    aesenc %xmm13, %xmm11
    aesenc %xmm0, %xmm8
    aesenc %xmm2, %xmm9
    aesenc %xmm4, %xmm10
    aesenc %xmm6, %xmm11
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm5
    aesenclast %xmm15, %xmm7
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm2
    movdqa %xmm10, %xmm4
    movdqa %xmm11, %xmm6
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqu 128(%rax), %xmm8
    movdqu 144(%rax), %xmm9
    movdqu 160(%rax), %xmm10
    movdqu 176(%rax), %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    movdqu 192(%rax), %xmm8
    movdqu 208(%rax), %xmm9
    movdqu 224(%rax), %xmm10
    movdqu 240(%rax), %xmm11
    pxor %xmm8, %xmm2
    pxor %xmm9, %xmm3
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    movdqu %xmm0, 64(%rdx)
    movdqu %xmm1, 80(%rdx)
    movdqu %xmm2, 96(%rdx)
    movdqu %xmm3, 112(%rdx)
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
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %rdx, %rdx
    xorq %r10, %r10
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
    movdqu 128(%rsp), %xmm15
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    addq $152, %rsp
#endif
    ret
AREION_FUNC_END(areion256SoEMPermutex4AesNi)

AREION_FUNC_START(areion256SoEMPermutex4Vex)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
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
    vmovdqu %xmm15, 128(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    vpxor %xmm15, %xmm15, %xmm15
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vmovdqu 32(%r10), %xmm2
    vmovdqu 48(%r10), %xmm3
    vpxor 32(%rax), %xmm0, %xmm4
    vpxor 48(%rax), %xmm1, %xmm5
    vpxor 96(%rax), %xmm2, %xmm6
    vpxor 112(%rax), %xmm3, %xmm7
    vpxor (%rax), %xmm0, %xmm0
    vpxor 16(%rax), %xmm1, %xmm1
    vpxor 64(%rax), %xmm2, %xmm2
    vpxor 80(%rax), %xmm3, %xmm3
    vmovdqu AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor (%rax), %xmm0, %xmm0
    vpxor 16(%rax), %xmm1, %xmm1
    vpxor 32(%rax), %xmm0, %xmm0
    vpxor 48(%rax), %xmm1, %xmm1
    vpxor 64(%rax), %xmm2, %xmm2
    vpxor 80(%rax), %xmm3, %xmm3
    vpxor 96(%rax), %xmm2, %xmm2
    vpxor 112(%rax), %xmm3, %xmm3
    vmovdqu %xmm0, (%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vmovdqu %xmm2, 32(%rdx)
    vmovdqu %xmm3, 48(%rdx)
    vmovdqu 64(%r10), %xmm0
    vmovdqu 80(%r10), %xmm1
    vmovdqu 96(%r10), %xmm2
    vmovdqu 112(%r10), %xmm3
    vpxor 160(%rax), %xmm0, %xmm4
    vpxor 176(%rax), %xmm1, %xmm5
    vpxor 224(%rax), %xmm2, %xmm6
    vpxor 240(%rax), %xmm3, %xmm7
    vpxor 128(%rax), %xmm0, %xmm0
    vpxor 144(%rax), %xmm1, %xmm1
    vpxor 192(%rax), %xmm2, %xmm2
    vpxor 208(%rax), %xmm3, %xmm3
    vmovdqu AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vmovdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm0, %xmm8
    vaesenc %xmm12, %xmm2, %xmm9
    vaesenc %xmm13, %xmm4, %xmm10
    vaesenc %xmm13, %xmm6, %xmm11
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenc %xmm1, %xmm8, %xmm1
    vaesenc %xmm3, %xmm9, %xmm3
    vaesenc %xmm5, %xmm10, %xmm5
    vaesenc %xmm7, %xmm11, %xmm7
    vmovdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    vmovdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    vaesenc %xmm12, %xmm1, %xmm8
    vaesenc %xmm12, %xmm3, %xmm9
    vaesenc %xmm13, %xmm5, %xmm10
    vaesenc %xmm13, %xmm7, %xmm11
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenc %xmm0, %xmm8, %xmm0
    vaesenc %xmm2, %xmm9, %xmm2
    vaesenc %xmm4, %xmm10, %xmm4
    vaesenc %xmm6, %xmm11, %xmm6
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor 128(%rax), %xmm0, %xmm0
    vpxor 144(%rax), %xmm1, %xmm1
    vpxor 160(%rax), %xmm0, %xmm0
    vpxor 176(%rax), %xmm1, %xmm1
    vpxor 192(%rax), %xmm2, %xmm2
    vpxor 208(%rax), %xmm3, %xmm3
    vpxor 224(%rax), %xmm2, %xmm2
    vpxor 240(%rax), %xmm3, %xmm3
    vmovdqu %xmm0, 64(%rdx)
    vmovdqu %xmm1, 80(%rdx)
    vmovdqu %xmm2, 96(%rdx)
    vmovdqu %xmm3, 112(%rdx)
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
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %rdx, %rdx
    xorq %r10, %r10
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
    vmovdqu 128(%rsp), %xmm15
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    addq $152, %rsp
#endif
    ret
AREION_FUNC_END(areion256SoEMPermutex4Vex)

AREION_FUNC_START(areion512SoEMPermutex4AesNi)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
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
    movdqu %xmm15, 128(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu 32(%r10), %xmm2
    movdqu 48(%r10), %xmm3
    movdqa %xmm0, %xmm4
    movdqa %xmm1, %xmm5
    movdqa %xmm2, %xmm6
    movdqa %xmm3, %xmm7
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    movdqu 64(%rax), %xmm8
    movdqu 80(%rax), %xmm9
    movdqu 96(%rax), %xmm10
    movdqu 112(%rax), %xmm11
    pxor %xmm8, %xmm4
    pxor %xmm9, %xmm5
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    pxor %xmm15, %xmm15
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 160+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 160+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 176+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 176+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 192+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 192+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 208+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 208+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 224+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 224+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    pxor %xmm7, %xmm3
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    pxor %xmm6, %xmm2
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    pxor %xmm8, %xmm3
    pxor %xmm9, %xmm0
    pxor %xmm10, %xmm1
    pxor %xmm11, %xmm2
    movdqu 64(%rax), %xmm8
    movdqu 80(%rax), %xmm9
    movdqu 96(%rax), %xmm10
    movdqu 112(%rax), %xmm11
    pxor %xmm8, %xmm3
    pxor %xmm9, %xmm0
    pxor %xmm10, %xmm1
    pxor %xmm11, %xmm2
    movdqu %xmm3, (%rdx)
    movdqu %xmm0, 16(%rdx)
    movdqu %xmm1, 32(%rdx)
    movdqu %xmm2, 48(%rdx)
    addq $64, %rdx
    addq $64, %r10
    addq $128, %rax
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu 32(%r10), %xmm2
    movdqu 48(%r10), %xmm3
    movdqa %xmm0, %xmm4
    movdqa %xmm1, %xmm5
    movdqa %xmm2, %xmm6
    movdqa %xmm3, %xmm7
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    movdqu 64(%rax), %xmm8
    movdqu 80(%rax), %xmm9
    movdqu 96(%rax), %xmm10
    movdqu 112(%rax), %xmm11
    pxor %xmm8, %xmm4
    pxor %xmm9, %xmm5
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    pxor %xmm15, %xmm15
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 160+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 160+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 176+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 176+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 192+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 192+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 208+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 208+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 224+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 224+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    pxor %xmm7, %xmm3
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    pxor %xmm6, %xmm2
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    pxor %xmm8, %xmm3
    pxor %xmm9, %xmm0
    pxor %xmm10, %xmm1
    pxor %xmm11, %xmm2
    movdqu 64(%rax), %xmm8
    movdqu 80(%rax), %xmm9
    movdqu 96(%rax), %xmm10
    movdqu 112(%rax), %xmm11
    pxor %xmm8, %xmm3
    pxor %xmm9, %xmm0
    pxor %xmm10, %xmm1
    pxor %xmm11, %xmm2
    movdqu %xmm3, (%rdx)
    movdqu %xmm0, 16(%rdx)
    movdqu %xmm1, 32(%rdx)
    movdqu %xmm2, 48(%rdx)
    addq $64, %rdx
    addq $64, %r10
    addq $128, %rax
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu 32(%r10), %xmm2
    movdqu 48(%r10), %xmm3
    movdqa %xmm0, %xmm4
    movdqa %xmm1, %xmm5
    movdqa %xmm2, %xmm6
    movdqa %xmm3, %xmm7
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    movdqu 64(%rax), %xmm8
    movdqu 80(%rax), %xmm9
    movdqu 96(%rax), %xmm10
    movdqu 112(%rax), %xmm11
    pxor %xmm8, %xmm4
    pxor %xmm9, %xmm5
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    pxor %xmm15, %xmm15
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 160+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 160+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 176+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 176+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 192+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 192+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 208+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 208+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 224+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 224+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    pxor %xmm7, %xmm3
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    pxor %xmm6, %xmm2
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    pxor %xmm8, %xmm3
    pxor %xmm9, %xmm0
    pxor %xmm10, %xmm1
    pxor %xmm11, %xmm2
    movdqu 64(%rax), %xmm8
    movdqu 80(%rax), %xmm9
    movdqu 96(%rax), %xmm10
    movdqu 112(%rax), %xmm11
    pxor %xmm8, %xmm3
    pxor %xmm9, %xmm0
    pxor %xmm10, %xmm1
    pxor %xmm11, %xmm2
    movdqu %xmm3, (%rdx)
    movdqu %xmm0, 16(%rdx)
    movdqu %xmm1, 32(%rdx)
    movdqu %xmm2, 48(%rdx)
    addq $64, %rdx
    addq $64, %r10
    addq $128, %rax
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu 32(%r10), %xmm2
    movdqu 48(%r10), %xmm3
    movdqa %xmm0, %xmm4
    movdqa %xmm1, %xmm5
    movdqa %xmm2, %xmm6
    movdqa %xmm3, %xmm7
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    movdqu 64(%rax), %xmm8
    movdqu 80(%rax), %xmm9
    movdqu 96(%rax), %xmm10
    movdqu 112(%rax), %xmm11
    pxor %xmm8, %xmm4
    pxor %xmm9, %xmm5
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    pxor %xmm15, %xmm15
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 160+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 160+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    movdqu 176+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 176+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    aesenclast %xmm15, %xmm3
    aesenclast %xmm15, %xmm7
    aesenclast %xmm12, %xmm1
    aesenclast %xmm13, %xmm5
    aesenc %xmm15, %xmm1
    aesenc %xmm15, %xmm5
    movdqu 192+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 192+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm4
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm6
    aesenc %xmm15, %xmm2
    aesenc %xmm15, %xmm6
    movdqu 208+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 208+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm1, %xmm8
    movdqa %xmm5, %xmm9
    aesenc %xmm2, %xmm8
    aesenc %xmm6, %xmm9
    movdqa %xmm8, %xmm2
    movdqa %xmm9, %xmm6
    movdqa %xmm3, %xmm8
    movdqa %xmm7, %xmm9
    aesenc %xmm0, %xmm8
    aesenc %xmm4, %xmm9
    movdqa %xmm8, %xmm0
    movdqa %xmm9, %xmm4
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm5
    aesenclast %xmm12, %xmm3
    aesenclast %xmm13, %xmm7
    aesenc %xmm15, %xmm3
    aesenc %xmm15, %xmm7
    movdqu 224+AREION_SYM(roundConstantsP1)(%rip), %xmm12
    movdqu 224+AREION_SYM(roundConstantsP2)(%rip), %xmm13
    movdqa %xmm2, %xmm8
    movdqa %xmm6, %xmm9
    aesenc %xmm3, %xmm8
    aesenc %xmm7, %xmm9
    movdqa %xmm8, %xmm3
    movdqa %xmm9, %xmm7
    movdqa %xmm0, %xmm8
    movdqa %xmm4, %xmm9
    aesenc %xmm1, %xmm8
    aesenc %xmm5, %xmm9
    movdqa %xmm8, %xmm1
    movdqa %xmm9, %xmm5
    aesenclast %xmm15, %xmm2
    aesenclast %xmm15, %xmm6
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm4
    aesenc %xmm15, %xmm0
    aesenc %xmm15, %xmm4
    pxor %xmm7, %xmm3
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    pxor %xmm6, %xmm2
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    pxor %xmm8, %xmm3
    pxor %xmm9, %xmm0
    pxor %xmm10, %xmm1
    pxor %xmm11, %xmm2
    movdqu 64(%rax), %xmm8
    movdqu 80(%rax), %xmm9
    movdqu 96(%rax), %xmm10
    movdqu 112(%rax), %xmm11
    pxor %xmm8, %xmm3
    pxor %xmm9, %xmm0
    pxor %xmm10, %xmm1
    pxor %xmm11, %xmm2
    movdqu %xmm3, (%rdx)
    movdqu %xmm0, 16(%rdx)
    movdqu %xmm1, 32(%rdx)
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
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
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
    movdqu 128(%rsp), %xmm15
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    addq $152, %rsp
#endif
    ret
AREION_FUNC_END(areion512SoEMPermutex4AesNi)

AREION_FUNC_START(areion512SoEMPermutex4Vex)
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
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vmovdqu 32(%r10), %xmm2
    vmovdqu 48(%r10), %xmm3
    vpxor 64(%rax), %xmm0, %xmm4
    vpxor 80(%rax), %xmm1, %xmm5
    vpxor 96(%rax), %xmm2, %xmm6
    vpxor 112(%rax), %xmm3, %xmm7
    vpxor (%rax), %xmm0, %xmm0
    vpxor 16(%rax), %xmm1, %xmm1
    vpxor 32(%rax), %xmm2, %xmm2
    vpxor 48(%rax), %xmm3, %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 16+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 16+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 32+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenclast 48+AREION_SYM(roundConstantsP2)(%rip), %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast 64+AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 80+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 80+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 96+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenclast 112+AREION_SYM(roundConstantsP2)(%rip), %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast 128+AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 144+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 144+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 160+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 160+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast 176+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenclast 176+AREION_SYM(roundConstantsP2)(%rip), %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast 192+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast 192+AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 208+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 208+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 224+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 224+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm6, %xmm2, %xmm2
    vpxor (%rax), %xmm3, %xmm3
    vpxor 16(%rax), %xmm0, %xmm0
    vpxor 32(%rax), %xmm1, %xmm1
    vpxor 48(%rax), %xmm2, %xmm2
    vpxor 64(%rax), %xmm3, %xmm3
    vpxor 80(%rax), %xmm0, %xmm0
    vpxor 96(%rax), %xmm1, %xmm1
    vpxor 112(%rax), %xmm2, %xmm2
    vmovdqu %xmm3, (%rdx)
    vmovdqu %xmm0, 16(%rdx)
    vmovdqu %xmm1, 32(%rdx)
    vmovdqu %xmm2, 48(%rdx)
    addq $64, %rdx
    addq $64, %r10
    addq $128, %rax
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vmovdqu 32(%r10), %xmm2
    vmovdqu 48(%r10), %xmm3
    vpxor 64(%rax), %xmm0, %xmm4
    vpxor 80(%rax), %xmm1, %xmm5
    vpxor 96(%rax), %xmm2, %xmm6
    vpxor 112(%rax), %xmm3, %xmm7
    vpxor (%rax), %xmm0, %xmm0
    vpxor 16(%rax), %xmm1, %xmm1
    vpxor 32(%rax), %xmm2, %xmm2
    vpxor 48(%rax), %xmm3, %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 16+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 16+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 32+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenclast 48+AREION_SYM(roundConstantsP2)(%rip), %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast 64+AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 80+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 80+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 96+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenclast 112+AREION_SYM(roundConstantsP2)(%rip), %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast 128+AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 144+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 144+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 160+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 160+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast 176+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenclast 176+AREION_SYM(roundConstantsP2)(%rip), %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast 192+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast 192+AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 208+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 208+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 224+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 224+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm6, %xmm2, %xmm2
    vpxor (%rax), %xmm3, %xmm3
    vpxor 16(%rax), %xmm0, %xmm0
    vpxor 32(%rax), %xmm1, %xmm1
    vpxor 48(%rax), %xmm2, %xmm2
    vpxor 64(%rax), %xmm3, %xmm3
    vpxor 80(%rax), %xmm0, %xmm0
    vpxor 96(%rax), %xmm1, %xmm1
    vpxor 112(%rax), %xmm2, %xmm2
    vmovdqu %xmm3, (%rdx)
    vmovdqu %xmm0, 16(%rdx)
    vmovdqu %xmm1, 32(%rdx)
    vmovdqu %xmm2, 48(%rdx)
    addq $64, %rdx
    addq $64, %r10
    addq $128, %rax
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vmovdqu 32(%r10), %xmm2
    vmovdqu 48(%r10), %xmm3
    vpxor 64(%rax), %xmm0, %xmm4
    vpxor 80(%rax), %xmm1, %xmm5
    vpxor 96(%rax), %xmm2, %xmm6
    vpxor 112(%rax), %xmm3, %xmm7
    vpxor (%rax), %xmm0, %xmm0
    vpxor 16(%rax), %xmm1, %xmm1
    vpxor 32(%rax), %xmm2, %xmm2
    vpxor 48(%rax), %xmm3, %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 16+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 16+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 32+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenclast 48+AREION_SYM(roundConstantsP2)(%rip), %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast 64+AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 80+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 80+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 96+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenclast 112+AREION_SYM(roundConstantsP2)(%rip), %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast 128+AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 144+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 144+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 160+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 160+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast 176+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenclast 176+AREION_SYM(roundConstantsP2)(%rip), %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast 192+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast 192+AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 208+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 208+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 224+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 224+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm6, %xmm2, %xmm2
    vpxor (%rax), %xmm3, %xmm3
    vpxor 16(%rax), %xmm0, %xmm0
    vpxor 32(%rax), %xmm1, %xmm1
    vpxor 48(%rax), %xmm2, %xmm2
    vpxor 64(%rax), %xmm3, %xmm3
    vpxor 80(%rax), %xmm0, %xmm0
    vpxor 96(%rax), %xmm1, %xmm1
    vpxor 112(%rax), %xmm2, %xmm2
    vmovdqu %xmm3, (%rdx)
    vmovdqu %xmm0, 16(%rdx)
    vmovdqu %xmm1, 32(%rdx)
    vmovdqu %xmm2, 48(%rdx)
    addq $64, %rdx
    addq $64, %r10
    addq $128, %rax
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vmovdqu 32(%r10), %xmm2
    vmovdqu 48(%r10), %xmm3
    vpxor 64(%rax), %xmm0, %xmm4
    vpxor 80(%rax), %xmm1, %xmm5
    vpxor 96(%rax), %xmm2, %xmm6
    vpxor 112(%rax), %xmm3, %xmm7
    vpxor (%rax), %xmm0, %xmm0
    vpxor 16(%rax), %xmm1, %xmm1
    vpxor 32(%rax), %xmm2, %xmm2
    vpxor 48(%rax), %xmm3, %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 16+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 16+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 32+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenclast 48+AREION_SYM(roundConstantsP2)(%rip), %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast 64+AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 80+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 80+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 96+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenclast 112+AREION_SYM(roundConstantsP2)(%rip), %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast 128+AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 144+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 144+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 160+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 160+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast %xmm15, %xmm7, %xmm7
    vaesenclast 176+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenclast 176+AREION_SYM(roundConstantsP2)(%rip), %xmm5, %xmm5
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm15, %xmm5, %xmm5
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm4, %xmm4
    vaesenclast 192+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenclast 192+AREION_SYM(roundConstantsP2)(%rip), %xmm6, %xmm6
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm15, %xmm6, %xmm6
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm6, %xmm5, %xmm6
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm4, %xmm7, %xmm4
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm5, %xmm5
    vaesenclast 208+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenclast 208+AREION_SYM(roundConstantsP2)(%rip), %xmm7, %xmm7
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm15, %xmm7, %xmm7
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm7, %xmm6, %xmm7
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm5, %xmm4, %xmm5
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast %xmm15, %xmm6, %xmm6
    vaesenclast 224+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenclast 224+AREION_SYM(roundConstantsP2)(%rip), %xmm4, %xmm4
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm15, %xmm4, %xmm4
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm6, %xmm2, %xmm2
    vpxor (%rax), %xmm3, %xmm3
    vpxor 16(%rax), %xmm0, %xmm0
    vpxor 32(%rax), %xmm1, %xmm1
    vpxor 48(%rax), %xmm2, %xmm2
    vpxor 64(%rax), %xmm3, %xmm3
    vpxor 80(%rax), %xmm0, %xmm0
    vpxor 96(%rax), %xmm1, %xmm1
    vpxor 112(%rax), %xmm2, %xmm2
    vmovdqu %xmm3, (%rdx)
    vmovdqu %xmm0, 16(%rdx)
    vmovdqu %xmm1, 32(%rdx)
    vmovdqu %xmm2, 48(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    vpxor %xmm7, %xmm7, %xmm7
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
    vmovdqu 32(%rsp), %xmm15
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    addq $56, %rsp
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
