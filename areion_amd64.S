/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#if defined(__x86_64__) || defined(_M_X64)
#include "asm_abi.h"

.text

AREION_FUNC_START(aesRoundAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    movdqu (%rax), %xmm0
    movdqu (%r10), %xmm1
    aesenc %xmm1, %xmm0
    movdqu %xmm0, (%rax)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    xorq %rax, %rax
    xorq %r10, %r10
    ret
AREION_FUNC_END(aesRoundAsm)

AREION_FUNC_START(aesRoundVexAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    vmovdqu (%rax), %xmm0
    vaesenc (%r10), %xmm0, %xmm0
    vmovdqu %xmm0, (%rax)
    vpxor %xmm0, %xmm0, %xmm0
    xorq %rax, %rax
    xorq %r10, %r10
    ret
AREION_FUNC_END(aesRoundVexAsm)

AREION_FUNC_START(aesFinalRoundAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    movdqu (%rax), %xmm0
    movdqu (%r10), %xmm1
    aesenclast %xmm1, %xmm0
    movdqu %xmm0, (%rax)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    xorq %rax, %rax
    xorq %r10, %r10
    ret
AREION_FUNC_END(aesFinalRoundAsm)

AREION_FUNC_START(aesFinalRoundVexAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    vmovdqu (%rax), %xmm0
    vaesenclast (%r10), %xmm0, %xmm0
    vmovdqu %xmm0, (%rax)
    vpxor %xmm0, %xmm0, %xmm0
    xorq %rax, %rax
    xorq %r10, %r10
    ret
AREION_FUNC_END(aesFinalRoundVexAsm)

AREION_FUNC_START(aesRound4ZmmAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    vmovdqu64 (%rax), %zmm0
    vaesenc (%r10), %zmm0, %zmm0
    vmovdqu64 %zmm0, (%rax)
    vpxord %xmm0, %xmm0, %xmm0
    xorq %rax, %rax
    xorq %r10, %r10
    vzeroupper
    ret
AREION_FUNC_END(aesRound4ZmmAsm)

AREION_FUNC_START(aesFinalRound4ZmmAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    vmovdqu64 (%rax), %zmm0
    vaesenclast (%r10), %zmm0, %zmm0
    vmovdqu64 %zmm0, (%rax)
    vpxord %xmm0, %xmm0, %xmm0
    xorq %rax, %rax
    xorq %r10, %r10
    vzeroupper
    ret
AREION_FUNC_END(aesFinalRound4ZmmAsm)

AREION_FUNC_START(aesRound4YmmAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    vmovdqu (%rax), %ymm0
    vmovdqu 32(%rax), %ymm1
    vaesenc (%r10), %ymm0, %ymm0
    vaesenc 32(%r10), %ymm1, %ymm1
    vmovdqu %ymm0, (%rax)
    vmovdqu %ymm1, 32(%rax)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    xorq %rax, %rax
    xorq %r10, %r10
    vzeroupper
    ret
AREION_FUNC_END(aesRound4YmmAsm)

AREION_FUNC_START(aesFinalRound4YmmAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    vmovdqu (%rax), %ymm0
    vmovdqu 32(%rax), %ymm1
    vaesenclast (%r10), %ymm0, %ymm0
    vaesenclast 32(%r10), %ymm1, %ymm1
    vmovdqu %ymm0, (%rax)
    vmovdqu %ymm1, 32(%rax)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    xorq %rax, %rax
    xorq %r10, %r10
    vzeroupper
    ret
AREION_FUNC_END(aesFinalRound4YmmAsm)

AREION_FUNC_START(aesRound4VexAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    vmovdqu (%rax), %xmm0
    vmovdqu 16(%rax), %xmm1
    vmovdqu 32(%rax), %xmm2
    vmovdqu 48(%rax), %xmm3
    vaesenc (%r10), %xmm0, %xmm0
    vaesenc 16(%r10), %xmm1, %xmm1
    vaesenc 32(%r10), %xmm2, %xmm2
    vaesenc 48(%r10), %xmm3, %xmm3
    vmovdqu %xmm0, (%rax)
    vmovdqu %xmm1, 16(%rax)
    vmovdqu %xmm2, 32(%rax)
    vmovdqu %xmm3, 48(%rax)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    xorq %rax, %rax
    xorq %r10, %r10
    ret
AREION_FUNC_END(aesRound4VexAsm)

AREION_FUNC_START(aesFinalRound4VexAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    vmovdqu (%rax), %xmm0
    vmovdqu 16(%rax), %xmm1
    vmovdqu 32(%rax), %xmm2
    vmovdqu 48(%rax), %xmm3
    vaesenclast (%r10), %xmm0, %xmm0
    vaesenclast 16(%r10), %xmm1, %xmm1
    vaesenclast 32(%r10), %xmm2, %xmm2
    vaesenclast 48(%r10), %xmm3, %xmm3
    vmovdqu %xmm0, (%rax)
    vmovdqu %xmm1, 16(%rax)
    vmovdqu %xmm2, 32(%rax)
    vmovdqu %xmm3, 48(%rax)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    xorq %rax, %rax
    xorq %r10, %r10
    ret
AREION_FUNC_END(aesFinalRound4VexAsm)

AREION_FUNC_START(aesRound4AesNiAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    subq $40, %rsp
    movdqu %xmm6, 0(%rsp)
    movdqu %xmm7, 16(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    movdqu (%rax), %xmm0
    movdqu 16(%rax), %xmm1
    movdqu 32(%rax), %xmm2
    movdqu 48(%rax), %xmm3
    movdqu (%r10), %xmm4
    movdqu 16(%r10), %xmm5
    movdqu 32(%r10), %xmm6
    movdqu 48(%r10), %xmm7
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    movdqu %xmm0, (%rax)
    movdqu %xmm1, 16(%rax)
    movdqu %xmm2, 32(%rax)
    movdqu %xmm3, 48(%rax)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    pxor %xmm6, %xmm6
    pxor %xmm7, %xmm7
    xorq %rax, %rax
    xorq %r10, %r10
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm6
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    movdqu 16(%rsp), %xmm7
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    addq $40, %rsp
#endif
    ret
AREION_FUNC_END(aesRound4AesNiAsm)

AREION_FUNC_START(aesFinalRound4AesNiAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    subq $40, %rsp
    movdqu %xmm6, 0(%rsp)
    movdqu %xmm7, 16(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    movdqu (%rax), %xmm0
    movdqu 16(%rax), %xmm1
    movdqu 32(%rax), %xmm2
    movdqu 48(%rax), %xmm3
    movdqu (%r10), %xmm4
    movdqu 16(%r10), %xmm5
    movdqu 32(%r10), %xmm6
    movdqu 48(%r10), %xmm7
    aesenclast %xmm4, %xmm0
    aesenclast %xmm5, %xmm1
    aesenclast %xmm6, %xmm2
    aesenclast %xmm7, %xmm3
    movdqu %xmm0, (%rax)
    movdqu %xmm1, 16(%rax)
    movdqu %xmm2, 32(%rax)
    movdqu %xmm3, 48(%rax)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    pxor %xmm6, %xmm6
    pxor %xmm7, %xmm7
    xorq %rax, %rax
    xorq %r10, %r10
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm6
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    movdqu 16(%rsp), %xmm7
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    addq $40, %rsp
#endif
    ret
AREION_FUNC_END(aesFinalRound4AesNiAsm)

AREION_FUNC_START(aes128EncryptBlockAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
#else
    movq %rcx, %rax
    movq %r8, %rcx
#endif
    movdqu (%rcx), %xmm0
    movdqu (%rax), %xmm1
    pxor %xmm1, %xmm0
    movdqu 16(%rax), %xmm1
    aesenc %xmm1, %xmm0
    movdqu 32(%rax), %xmm1
    aesenc %xmm1, %xmm0
    movdqu 48(%rax), %xmm1
    aesenc %xmm1, %xmm0
    movdqu 64(%rax), %xmm1
    aesenc %xmm1, %xmm0
    movdqu 80(%rax), %xmm1
    aesenc %xmm1, %xmm0
    movdqu 96(%rax), %xmm1
    aesenc %xmm1, %xmm0
    movdqu 112(%rax), %xmm1
    aesenc %xmm1, %xmm0
    movdqu 128(%rax), %xmm1
    aesenc %xmm1, %xmm0
    movdqu 144(%rax), %xmm1
    aesenc %xmm1, %xmm0
    movdqu 160(%rax), %xmm1
    aesenclast %xmm1, %xmm0
    movdqu %xmm0, (%rdx)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    xorq %rax, %rax
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    ret
AREION_FUNC_END(aes128EncryptBlockAsm)

AREION_FUNC_START(aes128EncryptBlockVexAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
#else
    movq %rcx, %rax
    movq %r8, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vpxor (%rax), %xmm0, %xmm0
    vaesenc 16(%rax), %xmm0, %xmm0
    vaesenc 32(%rax), %xmm0, %xmm0
    vaesenc 48(%rax), %xmm0, %xmm0
    vaesenc 64(%rax), %xmm0, %xmm0
    vaesenc 80(%rax), %xmm0, %xmm0
    vaesenc 96(%rax), %xmm0, %xmm0
    vaesenc 112(%rax), %xmm0, %xmm0
    vaesenc 128(%rax), %xmm0, %xmm0
    vaesenc 144(%rax), %xmm0, %xmm0
    vaesenclast 160(%rax), %xmm0, %xmm0
    vmovdqu %xmm0, (%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    xorq %rax, %rax
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    ret
AREION_FUNC_END(aes128EncryptBlockVexAsm)

AREION_FUNC_START(aes128Encrypt4BlocksZmmAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
#else
    movq %rcx, %rax
    movq %r8, %rcx
#endif
    vmovdqu64 (%rcx), %zmm0
    vbroadcasti32x4 (%rax), %zmm1
    vpxorq %zmm1, %zmm0, %zmm0
    vbroadcasti32x4 16(%rax), %zmm1
    vaesenc %zmm1, %zmm0, %zmm0
    vbroadcasti32x4 32(%rax), %zmm1
    vaesenc %zmm1, %zmm0, %zmm0
    vbroadcasti32x4 48(%rax), %zmm1
    vaesenc %zmm1, %zmm0, %zmm0
    vbroadcasti32x4 64(%rax), %zmm1
    vaesenc %zmm1, %zmm0, %zmm0
    vbroadcasti32x4 80(%rax), %zmm1
    vaesenc %zmm1, %zmm0, %zmm0
    vbroadcasti32x4 96(%rax), %zmm1
    vaesenc %zmm1, %zmm0, %zmm0
    vbroadcasti32x4 112(%rax), %zmm1
    vaesenc %zmm1, %zmm0, %zmm0
    vbroadcasti32x4 128(%rax), %zmm1
    vaesenc %zmm1, %zmm0, %zmm0
    vbroadcasti32x4 144(%rax), %zmm1
    vaesenc %zmm1, %zmm0, %zmm0
    vbroadcasti32x4 160(%rax), %zmm1
    vaesenclast %zmm1, %zmm0, %zmm0
    vmovdqu64 %zmm0, (%rdx)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    xorq %rax, %rax
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    vzeroupper
    ret
AREION_FUNC_END(aes128Encrypt4BlocksZmmAsm)

AREION_FUNC_START(aes128Encrypt4BlocksYmmAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
#else
    movq %rcx, %rax
    movq %r8, %rcx
#endif
    vmovdqu (%rcx), %ymm0
    vmovdqu 32(%rcx), %ymm1
    vbroadcasti128 (%rax), %ymm2
    vpxor %ymm2, %ymm0, %ymm0
    vpxor %ymm2, %ymm1, %ymm1
    vbroadcasti128 16(%rax), %ymm2
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm2, %ymm1, %ymm1
    vbroadcasti128 32(%rax), %ymm2
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm2, %ymm1, %ymm1
    vbroadcasti128 48(%rax), %ymm2
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm2, %ymm1, %ymm1
    vbroadcasti128 64(%rax), %ymm2
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm2, %ymm1, %ymm1
    vbroadcasti128 80(%rax), %ymm2
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm2, %ymm1, %ymm1
    vbroadcasti128 96(%rax), %ymm2
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm2, %ymm1, %ymm1
    vbroadcasti128 112(%rax), %ymm2
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm2, %ymm1, %ymm1
    vbroadcasti128 128(%rax), %ymm2
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm2, %ymm1, %ymm1
    vbroadcasti128 144(%rax), %ymm2
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm2, %ymm1, %ymm1
    vbroadcasti128 160(%rax), %ymm2
    vaesenclast %ymm2, %ymm0, %ymm0
    vaesenclast %ymm2, %ymm1, %ymm1
    vmovdqu %ymm0, (%rdx)
    vmovdqu %ymm1, 32(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    xorq %rax, %rax
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    vzeroupper
    ret
AREION_FUNC_END(aes128Encrypt4BlocksYmmAsm)

AREION_FUNC_START(aes128Encrypt4BlocksVexAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
#else
    movq %rcx, %rax
    movq %r8, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vmovdqu 16(%rcx), %xmm1
    vmovdqu 32(%rcx), %xmm2
    vmovdqu 48(%rcx), %xmm3
    vmovdqu (%rax), %xmm4
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm4, %xmm1, %xmm1
    vpxor %xmm4, %xmm2, %xmm2
    vpxor %xmm4, %xmm3, %xmm3
    vmovdqu 16(%rax), %xmm4
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vaesenc %xmm4, %xmm2, %xmm2
    vaesenc %xmm4, %xmm3, %xmm3
    vmovdqu 32(%rax), %xmm4
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vaesenc %xmm4, %xmm2, %xmm2
    vaesenc %xmm4, %xmm3, %xmm3
    vmovdqu 48(%rax), %xmm4
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vaesenc %xmm4, %xmm2, %xmm2
    vaesenc %xmm4, %xmm3, %xmm3
    vmovdqu 64(%rax), %xmm4
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vaesenc %xmm4, %xmm2, %xmm2
    vaesenc %xmm4, %xmm3, %xmm3
    vmovdqu 80(%rax), %xmm4
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vaesenc %xmm4, %xmm2, %xmm2
    vaesenc %xmm4, %xmm3, %xmm3
    vmovdqu 96(%rax), %xmm4
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vaesenc %xmm4, %xmm2, %xmm2
    vaesenc %xmm4, %xmm3, %xmm3
    vmovdqu 112(%rax), %xmm4
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vaesenc %xmm4, %xmm2, %xmm2
    vaesenc %xmm4, %xmm3, %xmm3
    vmovdqu 128(%rax), %xmm4
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vaesenc %xmm4, %xmm2, %xmm2
    vaesenc %xmm4, %xmm3, %xmm3
    vmovdqu 144(%rax), %xmm4
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vaesenc %xmm4, %xmm2, %xmm2
    vaesenc %xmm4, %xmm3, %xmm3
    vmovdqu 160(%rax), %xmm4
    vaesenclast %xmm4, %xmm0, %xmm0
    vaesenclast %xmm4, %xmm1, %xmm1
    vaesenclast %xmm4, %xmm2, %xmm2
    vaesenclast %xmm4, %xmm3, %xmm3
    vmovdqu %xmm0, (%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vmovdqu %xmm2, 32(%rdx)
    vmovdqu %xmm3, 48(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    xorq %rax, %rax
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    ret
AREION_FUNC_END(aes128Encrypt4BlocksVexAsm)

AREION_FUNC_START(aes128Encrypt4BlocksAesNiAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
#else
    movq %rcx, %rax
    movq %r8, %rcx
#endif
    movdqu (%rcx), %xmm0
    movdqu 16(%rcx), %xmm1
    movdqu 32(%rcx), %xmm2
    movdqu 48(%rcx), %xmm3
    movdqu (%rax), %xmm4
    pxor %xmm4, %xmm0
    pxor %xmm4, %xmm1
    pxor %xmm4, %xmm2
    pxor %xmm4, %xmm3
    movdqu 16(%rax), %xmm4
    aesenc %xmm4, %xmm0
    aesenc %xmm4, %xmm1
    aesenc %xmm4, %xmm2
    aesenc %xmm4, %xmm3
    movdqu 32(%rax), %xmm4
    aesenc %xmm4, %xmm0
    aesenc %xmm4, %xmm1
    aesenc %xmm4, %xmm2
    aesenc %xmm4, %xmm3
    movdqu 48(%rax), %xmm4
    aesenc %xmm4, %xmm0
    aesenc %xmm4, %xmm1
    aesenc %xmm4, %xmm2
    aesenc %xmm4, %xmm3
    movdqu 64(%rax), %xmm4
    aesenc %xmm4, %xmm0
    aesenc %xmm4, %xmm1
    aesenc %xmm4, %xmm2
    aesenc %xmm4, %xmm3
    movdqu 80(%rax), %xmm4
    aesenc %xmm4, %xmm0
    aesenc %xmm4, %xmm1
    aesenc %xmm4, %xmm2
    aesenc %xmm4, %xmm3
    movdqu 96(%rax), %xmm4
    aesenc %xmm4, %xmm0
    aesenc %xmm4, %xmm1
    aesenc %xmm4, %xmm2
    aesenc %xmm4, %xmm3
    movdqu 112(%rax), %xmm4
    aesenc %xmm4, %xmm0
    aesenc %xmm4, %xmm1
    aesenc %xmm4, %xmm2
    aesenc %xmm4, %xmm3
    movdqu 128(%rax), %xmm4
    aesenc %xmm4, %xmm0
    aesenc %xmm4, %xmm1
    aesenc %xmm4, %xmm2
    aesenc %xmm4, %xmm3
    movdqu 144(%rax), %xmm4
    aesenc %xmm4, %xmm0
    aesenc %xmm4, %xmm1
    aesenc %xmm4, %xmm2
    aesenc %xmm4, %xmm3
    movdqu 160(%rax), %xmm4
    aesenclast %xmm4, %xmm0
    aesenclast %xmm4, %xmm1
    aesenclast %xmm4, %xmm2
    aesenclast %xmm4, %xmm3
    movdqu %xmm0, (%rdx)
    movdqu %xmm1, 16(%rdx)
    movdqu %xmm2, 32(%rdx)
    movdqu %xmm3, 48(%rdx)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    xorq %rax, %rax
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    ret
AREION_FUNC_END(aes128Encrypt4BlocksAesNiAsm)

AREION_FUNC_START(areion256PermuteRCAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    subq $24, %rsp
    movdqu %xmm15, 0(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    movdqu (%rax), %xmm0
    movdqu 16(%rax), %xmm1
    pxor %xmm15, %xmm15
    movdqu (%r10), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 16(%r10), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 32(%r10), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 48(%r10), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 64(%r10), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 80(%r10), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 96(%r10), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 112(%r10), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 128(%r10), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 144(%r10), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu %xmm0, (%rax)
    movdqu %xmm1, 16(%rax)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion256PermuteRCAsm)

AREION_FUNC_START(areion256PermuteVexRCAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    subq $24, %rsp
    vmovdqu %xmm15, 0(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    vmovdqu (%rax), %xmm0
    vmovdqu 16(%rax), %xmm1
    vpxor %xmm15, %xmm15, %xmm15
    vaesenc (%r10), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 16(%r10), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 32(%r10), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 48(%r10), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 64(%r10), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 80(%r10), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 96(%r10), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 112(%r10), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 128(%r10), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 144(%r10), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vmovdqu %xmm0, (%rax)
    vmovdqu %xmm1, 16(%rax)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion256PermuteVexRCAsm)

AREION_FUNC_START(areion256InversePermuteRCAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    subq $24, %rsp
    movdqu %xmm15, 0(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    movdqu (%rax), %xmm0
    movdqu 16(%rax), %xmm1
    pxor %xmm15, %xmm15
    movdqu 144(%r10), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 128(%r10), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 112(%r10), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 96(%r10), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 80(%r10), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 64(%r10), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 48(%r10), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 32(%r10), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 16(%r10), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu (%r10), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu %xmm0, (%rax)
    movdqu %xmm1, 16(%rax)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion256InversePermuteRCAsm)

AREION_FUNC_START(areion256InversePermuteVexRCAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    subq $24, %rsp
    vmovdqu %xmm15, 0(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    vmovdqu (%rax), %xmm0
    vmovdqu 16(%rax), %xmm1
    vpxor %xmm15, %xmm15, %xmm15
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 144(%r10), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 128(%r10), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 112(%r10), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 96(%r10), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 80(%r10), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 64(%r10), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 48(%r10), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 32(%r10), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 16(%r10), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc (%r10), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vmovdqu %xmm0, (%rax)
    vmovdqu %xmm1, 16(%rax)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion256InversePermuteVexRCAsm)

AREION_FUNC_START(areion512PermuteRCAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    subq $24, %rsp
    movdqu %xmm15, 0(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    movdqu (%rax), %xmm0
    movdqu 16(%rax), %xmm1
    movdqu 32(%rax), %xmm2
    movdqu 48(%rax), %xmm3
    pxor %xmm15, %xmm15
    movdqu (%r10), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 16(%r10), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 32(%r10), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 48(%r10), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 64(%r10), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 80(%r10), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 96(%r10), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 112(%r10), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 128(%r10), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 144(%r10), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 160(%r10), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 176(%r10), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 192(%r10), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 208(%r10), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 224(%r10), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu %xmm3, (%rax)
    movdqu %xmm0, 16(%rax)
    movdqu %xmm1, 32(%rax)
    movdqu %xmm2, 48(%rax)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion512PermuteRCAsm)

AREION_FUNC_START(areion512PermuteVexRCAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    subq $24, %rsp
    vmovdqu %xmm15, 0(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    vmovdqu (%rax), %xmm0
    vmovdqu 16(%rax), %xmm1
    vmovdqu 32(%rax), %xmm2
    vmovdqu 48(%rax), %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast (%r10), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 16(%r10), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 32(%r10), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 48(%r10), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 64(%r10), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 80(%r10), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 96(%r10), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 112(%r10), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 128(%r10), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 144(%r10), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 160(%r10), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 176(%r10), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 192(%r10), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 208(%r10), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 224(%r10), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vmovdqu %xmm3, (%rax)
    vmovdqu %xmm0, 16(%rax)
    vmovdqu %xmm1, 32(%rax)
    vmovdqu %xmm2, 48(%rax)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion512PermuteVexRCAsm)

AREION_FUNC_START(areion512InversePermuteRCAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    subq $24, %rsp
    movdqu %xmm15, 0(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    movdqu 16(%rax), %xmm0
    movdqu 32(%rax), %xmm1
    movdqu 48(%rax), %xmm2
    movdqu (%rax), %xmm3
    pxor %xmm15, %xmm15
    movdqu 224(%r10), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 208(%r10), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 192(%r10), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 176(%r10), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 160(%r10), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 144(%r10), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 128(%r10), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 112(%r10), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 96(%r10), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 80(%r10), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 64(%r10), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 48(%r10), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 32(%r10), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 16(%r10), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu (%r10), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu %xmm0, (%rax)
    movdqu %xmm1, 16(%rax)
    movdqu %xmm2, 32(%rax)
    movdqu %xmm3, 48(%rax)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion512InversePermuteRCAsm)

AREION_FUNC_START(areion512InversePermuteVexRCAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
#else
    subq $24, %rsp
    vmovdqu %xmm15, 0(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
#endif
    vmovdqu 16(%rax), %xmm0
    vmovdqu 32(%rax), %xmm1
    vmovdqu 48(%rax), %xmm2
    vmovdqu (%rax), %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 224(%r10), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 208(%r10), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 192(%r10), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 176(%r10), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 160(%r10), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 144(%r10), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 128(%r10), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 112(%r10), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 96(%r10), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 80(%r10), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 64(%r10), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 48(%r10), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 32(%r10), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 16(%r10), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast (%r10), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vmovdqu %xmm0, (%rax)
    vmovdqu %xmm1, 16(%rax)
    vmovdqu %xmm2, 32(%rax)
    vmovdqu %xmm3, 48(%rax)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion512InversePermuteVexRCAsm)

AREION_FUNC_START(areionSoEM256Asm)
#if !defined(_WIN64)
    movq %rsi, %rax
    movq %rdx, %r10
    movq %rdi, %rdx
#else
    subq $120, %rsp
    movdqu %xmm6, 0(%rsp)
    movdqu %xmm7, 16(%rsp)
    movdqu %xmm8, 32(%rsp)
    movdqu %xmm9, 48(%rsp)
    movdqu %xmm10, 64(%rsp)
    movdqu %xmm11, 80(%rsp)
    movdqu %xmm15, 96(%rsp)
    movq %rdx, %rax
    movq %rcx, %rdx
    movq %r8, %r10
#endif
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    movdqa %xmm0, %xmm2
    movdqa %xmm1, %xmm3
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm15, %xmm15
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm0, %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm1, %xmm4
    aesenc %xmm3, %xmm5
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    movdqa %xmm4, %xmm1
    movdqa %xmm5, %xmm3
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm1, %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm0, %xmm4
    aesenc %xmm2, %xmm5
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    movdqa %xmm4, %xmm0
    movdqa %xmm5, %xmm2
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm0, %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm1, %xmm4
    aesenc %xmm3, %xmm5
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    movdqa %xmm4, %xmm1
    movdqa %xmm5, %xmm3
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm1, %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm0, %xmm4
    aesenc %xmm2, %xmm5
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    movdqa %xmm4, %xmm0
    movdqa %xmm5, %xmm2
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm0, %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm1, %xmm4
    aesenc %xmm3, %xmm5
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    movdqa %xmm4, %xmm1
    movdqa %xmm5, %xmm3
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm1, %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm0, %xmm4
    aesenc %xmm2, %xmm5
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    movdqa %xmm4, %xmm0
    movdqa %xmm5, %xmm2
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm0, %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm1, %xmm4
    aesenc %xmm3, %xmm5
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    movdqa %xmm4, %xmm1
    movdqa %xmm5, %xmm3
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm1, %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm0, %xmm4
    aesenc %xmm2, %xmm5
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    movdqa %xmm4, %xmm0
    movdqa %xmm5, %xmm2
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm0, %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm1, %xmm4
    aesenc %xmm3, %xmm5
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    movdqa %xmm4, %xmm1
    movdqa %xmm5, %xmm3
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm1, %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm0, %xmm4
    aesenc %xmm2, %xmm5
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    movdqa %xmm4, %xmm0
    movdqa %xmm5, %xmm2
    pxor %xmm2, %xmm0
    pxor %xmm3, %xmm1
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    movdqu %xmm0, (%rdx)
    movdqu %xmm1, 16(%rdx)
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
    movdqu 96(%rsp), %xmm15
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    addq $120, %rsp
#endif
    ret
AREION_FUNC_END(areionSoEM256Asm)

AREION_FUNC_START(areionSoEM256VexAsm)
#if !defined(_WIN64)
    movq %rsi, %rax
    movq %rdx, %r10
    movq %rdi, %rdx
#else
    subq $88, %rsp
    vmovdqu %xmm8, 0(%rsp)
    vmovdqu %xmm9, 16(%rsp)
    vmovdqu %xmm10, 32(%rsp)
    vmovdqu %xmm11, 48(%rsp)
    vmovdqu %xmm15, 64(%rsp)
    movq %rdx, %rax
    movq %rcx, %rdx
    movq %r8, %r10
#endif
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vmovdqu (%rax), %xmm8
    vmovdqu 16(%rax), %xmm9
    vmovdqu 32(%rax), %xmm10
    vmovdqu 48(%rax), %xmm11
    vpxor %xmm10, %xmm0, %xmm2
    vpxor %xmm11, %xmm1, %xmm3
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm15, %xmm15, %xmm15
    vaesenc AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm4
    vaesenc AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm5
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm4, %xmm1
    vaesenc %xmm3, %xmm5, %xmm3
    vaesenc 16+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm4
    vaesenc 16+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm5
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm0, %xmm4, %xmm0
    vaesenc %xmm2, %xmm5, %xmm2
    vaesenc 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm4
    vaesenc 32+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm5
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm4, %xmm1
    vaesenc %xmm3, %xmm5, %xmm3
    vaesenc 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm4
    vaesenc 48+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm5
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm0, %xmm4, %xmm0
    vaesenc %xmm2, %xmm5, %xmm2
    vaesenc 64+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm4
    vaesenc 64+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm5
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm4, %xmm1
    vaesenc %xmm3, %xmm5, %xmm3
    vaesenc 80+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm4
    vaesenc 80+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm5
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm0, %xmm4, %xmm0
    vaesenc %xmm2, %xmm5, %xmm2
    vaesenc 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm4
    vaesenc 96+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm5
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm4, %xmm1
    vaesenc %xmm3, %xmm5, %xmm3
    vaesenc 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm4
    vaesenc 112+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm5
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm0, %xmm4, %xmm0
    vaesenc %xmm2, %xmm5, %xmm2
    vaesenc 128+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm4
    vaesenc 128+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm5
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm4, %xmm1
    vaesenc %xmm3, %xmm5, %xmm3
    vaesenc 144+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm4
    vaesenc 144+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm5
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm0, %xmm4, %xmm0
    vaesenc %xmm2, %xmm5, %xmm2
    vpxor %xmm2, %xmm0, %xmm0
    vpxor %xmm3, %xmm1, %xmm1
    vpxor %xmm8, %xmm10, %xmm8
    vpxor %xmm9, %xmm11, %xmm9
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vmovdqu %xmm0, (%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm8, %xmm8, %xmm8
    vpxor %xmm9, %xmm9, %xmm9
    vpxor %xmm10, %xmm10, %xmm10
    vpxor %xmm11, %xmm11, %xmm11
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm8
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm9
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm10
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    vmovdqu 48(%rsp), %xmm11
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    vmovdqu 64(%rsp), %xmm15
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    addq $88, %rsp
#endif
    ret
AREION_FUNC_END(areionSoEM256VexAsm)

AREION_FUNC_START(areionSoEM512Asm)
#if !defined(_WIN64)
    movq %rsi, %rax
    movq %rdx, %r10
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
    movq %rdx, %rax
    movq %rcx, %rdx
    movq %r8, %r10
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
AREION_FUNC_END(areionSoEM512Asm)

AREION_FUNC_START(areionSoEM512VexAsm)
#if !defined(_WIN64)
    movq %rsi, %rax
    movq %rdx, %r10
    movq %rdi, %rdx
#else
    subq $56, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm7, 16(%rsp)
    vmovdqu %xmm15, 32(%rsp)
    movq %rdx, %rax
    movq %rcx, %rdx
    movq %r8, %r10
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
AREION_FUNC_END(areionSoEM512VexAsm)

AREION_FUNC_START(areion256Permutex4RC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %rdx, %rcx
#else
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
#endif
    vmovdqu64 (%rax), %zmm0
    vmovdqu64 (%r10), %zmm1
    vpxord %zmm3, %zmm3, %zmm3
    vaesenc (%rcx), %zmm0, %zmm2
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesenc %zmm1, %zmm2, %zmm1
    vaesenc 64(%rcx), %zmm1, %zmm2
    vaesenclast %zmm3, %zmm1, %zmm1
    vaesenc %zmm0, %zmm2, %zmm0
    vaesenc 128(%rcx), %zmm0, %zmm2
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesenc %zmm1, %zmm2, %zmm1
    vaesenc 192(%rcx), %zmm1, %zmm2
    vaesenclast %zmm3, %zmm1, %zmm1
    vaesenc %zmm0, %zmm2, %zmm0
    vaesenc 256(%rcx), %zmm0, %zmm2
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesenc %zmm1, %zmm2, %zmm1
    vaesenc 320(%rcx), %zmm1, %zmm2
    vaesenclast %zmm3, %zmm1, %zmm1
    vaesenc %zmm0, %zmm2, %zmm0
    vaesenc 384(%rcx), %zmm0, %zmm2
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesenc %zmm1, %zmm2, %zmm1
    vaesenc 448(%rcx), %zmm1, %zmm2
    vaesenclast %zmm3, %zmm1, %zmm1
    vaesenc %zmm0, %zmm2, %zmm0
    vaesenc 512(%rcx), %zmm0, %zmm2
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesenc %zmm1, %zmm2, %zmm1
    vaesenc 576(%rcx), %zmm1, %zmm2
    vaesenclast %zmm3, %zmm1, %zmm1
    vaesenc %zmm0, %zmm2, %zmm0
    vmovdqu64 %zmm0, (%rax)
    vmovdqu64 %zmm1, (%r10)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    vzeroupper
    ret
AREION_FUNC_END(areion256Permutex4RC)

AREION_FUNC_START(areion256InversePermutex4RC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %rdx, %rcx
#else
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
#endif
    vmovdqu64 (%rax), %zmm0
    vmovdqu64 (%r10), %zmm1
    vpxord %zmm3, %zmm3, %zmm3
    vaesdeclast %zmm3, %zmm1, %zmm1
    vaesenc 576(%rcx), %zmm1, %zmm2
    vaesenc %zmm0, %zmm2, %zmm0
    vaesdeclast %zmm3, %zmm0, %zmm0
    vaesenc 512(%rcx), %zmm0, %zmm2
    vaesenc %zmm1, %zmm2, %zmm1
    vaesdeclast %zmm3, %zmm1, %zmm1
    vaesenc 448(%rcx), %zmm1, %zmm2
    vaesenc %zmm0, %zmm2, %zmm0
    vaesdeclast %zmm3, %zmm0, %zmm0
    vaesenc 384(%rcx), %zmm0, %zmm2
    vaesenc %zmm1, %zmm2, %zmm1
    vaesdeclast %zmm3, %zmm1, %zmm1
    vaesenc 320(%rcx), %zmm1, %zmm2
    vaesenc %zmm0, %zmm2, %zmm0
    vaesdeclast %zmm3, %zmm0, %zmm0
    vaesenc 256(%rcx), %zmm0, %zmm2
    vaesenc %zmm1, %zmm2, %zmm1
    vaesdeclast %zmm3, %zmm1, %zmm1
    vaesenc 192(%rcx), %zmm1, %zmm2
    vaesenc %zmm0, %zmm2, %zmm0
    vaesdeclast %zmm3, %zmm0, %zmm0
    vaesenc 128(%rcx), %zmm0, %zmm2
    vaesenc %zmm1, %zmm2, %zmm1
    vaesdeclast %zmm3, %zmm1, %zmm1
    vaesenc 64(%rcx), %zmm1, %zmm2
    vaesenc %zmm0, %zmm2, %zmm0
    vaesdeclast %zmm3, %zmm0, %zmm0
    vaesenc (%rcx), %zmm0, %zmm2
    vaesenc %zmm1, %zmm2, %zmm1
    vmovdqu64 %zmm0, (%rax)
    vmovdqu64 %zmm1, (%r10)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    vzeroupper
    ret
AREION_FUNC_END(areion256InversePermutex4RC)

AREION_FUNC_START(areion512Permutex4RC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %r8, %rsi
    movq %rdx, %r11
    movq %rcx, %rdx
    movq %r11, %rcx
#else
    subq $40, %rsp
    movq %rsi, 0(%rsp)
    vmovdqu %xmm15, 16(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
    movq %r9, %rdx
    movq 80(%rsp), %rsi
#endif
    vmovdqu64 (%rax), %zmm0
    vmovdqu64 (%r10), %zmm1
    vmovdqu64 (%rcx), %zmm2
    vmovdqu64 (%rdx), %zmm3
    vpxord %zmm15, %zmm15, %zmm15
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenclast %zmm15, %zmm0, %zmm0
    vaesenclast (%rsi), %zmm2, %zmm2
    vaesenc %zmm15, %zmm2, %zmm2
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenclast %zmm15, %zmm1, %zmm1
    vaesenclast 64(%rsi), %zmm3, %zmm3
    vaesenc %zmm15, %zmm3, %zmm3
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenclast %zmm15, %zmm2, %zmm2
    vaesenclast 128(%rsi), %zmm0, %zmm0
    vaesenc %zmm15, %zmm0, %zmm0
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenclast %zmm15, %zmm3, %zmm3
    vaesenclast 192(%rsi), %zmm1, %zmm1
    vaesenc %zmm15, %zmm1, %zmm1
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenclast %zmm15, %zmm0, %zmm0
    vaesenclast 256(%rsi), %zmm2, %zmm2
    vaesenc %zmm15, %zmm2, %zmm2
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenclast %zmm15, %zmm1, %zmm1
    vaesenclast 320(%rsi), %zmm3, %zmm3
    vaesenc %zmm15, %zmm3, %zmm3
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenclast %zmm15, %zmm2, %zmm2
    vaesenclast 384(%rsi), %zmm0, %zmm0
    vaesenc %zmm15, %zmm0, %zmm0
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenclast %zmm15, %zmm3, %zmm3
    vaesenclast 448(%rsi), %zmm1, %zmm1
    vaesenc %zmm15, %zmm1, %zmm1
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenclast %zmm15, %zmm0, %zmm0
    vaesenclast 512(%rsi), %zmm2, %zmm2
    vaesenc %zmm15, %zmm2, %zmm2
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenclast %zmm15, %zmm1, %zmm1
    vaesenclast 576(%rsi), %zmm3, %zmm3
    vaesenc %zmm15, %zmm3, %zmm3
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenclast %zmm15, %zmm2, %zmm2
    vaesenclast 640(%rsi), %zmm0, %zmm0
    vaesenc %zmm15, %zmm0, %zmm0
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenclast %zmm15, %zmm3, %zmm3
    vaesenclast 704(%rsi), %zmm1, %zmm1
    vaesenc %zmm15, %zmm1, %zmm1
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenclast %zmm15, %zmm0, %zmm0
    vaesenclast 768(%rsi), %zmm2, %zmm2
    vaesenc %zmm15, %zmm2, %zmm2
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenclast %zmm15, %zmm1, %zmm1
    vaesenclast 832(%rsi), %zmm3, %zmm3
    vaesenc %zmm15, %zmm3, %zmm3
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenclast %zmm15, %zmm2, %zmm2
    vaesenclast 896(%rsi), %zmm0, %zmm0
    vaesenc %zmm15, %zmm0, %zmm0
    vmovdqu64 %zmm3, (%rax)
    vmovdqu64 %zmm0, (%r10)
    vmovdqu64 %zmm1, (%rcx)
    vmovdqu64 %zmm2, (%rdx)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %rsi, %rsi
    xorq %r11, %r11
#if defined(_WIN64)
    vmovdqu 16(%rsp), %xmm15
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    addq $40, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion512Permutex4RC)

AREION_FUNC_START(areion512InversePermutex4RC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %r8, %rsi
    movq %rdx, %r11
    movq %rcx, %rdx
    movq %r11, %rcx
#else
    subq $72, %rsp
    movq %rsi, 0(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm15, 48(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
    movq %r9, %rdx
    movq 112(%rsp), %rsi
#endif
    vmovdqu64 (%r10), %zmm0
    vmovdqu64 (%rcx), %zmm1
    vmovdqu64 (%rdx), %zmm2
    vmovdqu64 (%rax), %zmm3
    vpxord %zmm15, %zmm15, %zmm15
    vaesdeclast %zmm15, %zmm2, %zmm2
    vextracti32x4 $1, %zmm0, %xmm5
    vextracti32x4 $2, %zmm0, %xmm6
    vextracti32x4 $3, %zmm0, %xmm7
    vaesimc %xmm0, %xmm0
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vinserti32x4 $1, %xmm5, %zmm0, %zmm0
    vinserti32x4 $2, %xmm6, %zmm0, %zmm0
    vinserti32x4 $3, %xmm7, %zmm0, %zmm0
    vaesdeclast 896(%rsi), %zmm0, %zmm0
    vaesdeclast %zmm15, %zmm0, %zmm0
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm1, %zmm0, %zmm1
    vaesdeclast %zmm15, %zmm1, %zmm1
    vextracti32x4 $1, %zmm3, %xmm5
    vextracti32x4 $2, %zmm3, %xmm6
    vextracti32x4 $3, %zmm3, %xmm7
    vaesimc %xmm3, %xmm3
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vinserti32x4 $1, %xmm5, %zmm3, %zmm3
    vinserti32x4 $2, %xmm6, %zmm3, %zmm3
    vinserti32x4 $3, %xmm7, %zmm3, %zmm3
    vaesdeclast 832(%rsi), %zmm3, %zmm3
    vaesdeclast %zmm15, %zmm3, %zmm3
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm0, %zmm3, %zmm0
    vaesdeclast %zmm15, %zmm0, %zmm0
    vextracti32x4 $1, %zmm2, %xmm5
    vextracti32x4 $2, %zmm2, %xmm6
    vextracti32x4 $3, %zmm2, %xmm7
    vaesimc %xmm2, %xmm2
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vinserti32x4 $1, %xmm5, %zmm2, %zmm2
    vinserti32x4 $2, %xmm6, %zmm2, %zmm2
    vinserti32x4 $3, %xmm7, %zmm2, %zmm2
    vaesdeclast 768(%rsi), %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm2, %zmm2
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm3, %zmm2, %zmm3
    vaesdeclast %zmm15, %zmm3, %zmm3
    vextracti32x4 $1, %zmm1, %xmm5
    vextracti32x4 $2, %zmm1, %xmm6
    vextracti32x4 $3, %zmm1, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vinserti32x4 $1, %xmm5, %zmm1, %zmm1
    vinserti32x4 $2, %xmm6, %zmm1, %zmm1
    vinserti32x4 $3, %xmm7, %zmm1, %zmm1
    vaesdeclast 704(%rsi), %zmm1, %zmm1
    vaesdeclast %zmm15, %zmm1, %zmm1
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm2, %zmm1, %zmm2
    vaesdeclast %zmm15, %zmm2, %zmm2
    vextracti32x4 $1, %zmm0, %xmm5
    vextracti32x4 $2, %zmm0, %xmm6
    vextracti32x4 $3, %zmm0, %xmm7
    vaesimc %xmm0, %xmm0
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vinserti32x4 $1, %xmm5, %zmm0, %zmm0
    vinserti32x4 $2, %xmm6, %zmm0, %zmm0
    vinserti32x4 $3, %xmm7, %zmm0, %zmm0
    vaesdeclast 640(%rsi), %zmm0, %zmm0
    vaesdeclast %zmm15, %zmm0, %zmm0
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm1, %zmm0, %zmm1
    vaesdeclast %zmm15, %zmm1, %zmm1
    vextracti32x4 $1, %zmm3, %xmm5
    vextracti32x4 $2, %zmm3, %xmm6
    vextracti32x4 $3, %zmm3, %xmm7
    vaesimc %xmm3, %xmm3
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vinserti32x4 $1, %xmm5, %zmm3, %zmm3
    vinserti32x4 $2, %xmm6, %zmm3, %zmm3
    vinserti32x4 $3, %xmm7, %zmm3, %zmm3
    vaesdeclast 576(%rsi), %zmm3, %zmm3
    vaesdeclast %zmm15, %zmm3, %zmm3
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm0, %zmm3, %zmm0
    vaesdeclast %zmm15, %zmm0, %zmm0
    vextracti32x4 $1, %zmm2, %xmm5
    vextracti32x4 $2, %zmm2, %xmm6
    vextracti32x4 $3, %zmm2, %xmm7
    vaesimc %xmm2, %xmm2
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vinserti32x4 $1, %xmm5, %zmm2, %zmm2
    vinserti32x4 $2, %xmm6, %zmm2, %zmm2
    vinserti32x4 $3, %xmm7, %zmm2, %zmm2
    vaesdeclast 512(%rsi), %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm2, %zmm2
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm3, %zmm2, %zmm3
    vaesdeclast %zmm15, %zmm3, %zmm3
    vextracti32x4 $1, %zmm1, %xmm5
    vextracti32x4 $2, %zmm1, %xmm6
    vextracti32x4 $3, %zmm1, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vinserti32x4 $1, %xmm5, %zmm1, %zmm1
    vinserti32x4 $2, %xmm6, %zmm1, %zmm1
    vinserti32x4 $3, %xmm7, %zmm1, %zmm1
    vaesdeclast 448(%rsi), %zmm1, %zmm1
    vaesdeclast %zmm15, %zmm1, %zmm1
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm2, %zmm1, %zmm2
    vaesdeclast %zmm15, %zmm2, %zmm2
    vextracti32x4 $1, %zmm0, %xmm5
    vextracti32x4 $2, %zmm0, %xmm6
    vextracti32x4 $3, %zmm0, %xmm7
    vaesimc %xmm0, %xmm0
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vinserti32x4 $1, %xmm5, %zmm0, %zmm0
    vinserti32x4 $2, %xmm6, %zmm0, %zmm0
    vinserti32x4 $3, %xmm7, %zmm0, %zmm0
    vaesdeclast 384(%rsi), %zmm0, %zmm0
    vaesdeclast %zmm15, %zmm0, %zmm0
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm1, %zmm0, %zmm1
    vaesdeclast %zmm15, %zmm1, %zmm1
    vextracti32x4 $1, %zmm3, %xmm5
    vextracti32x4 $2, %zmm3, %xmm6
    vextracti32x4 $3, %zmm3, %xmm7
    vaesimc %xmm3, %xmm3
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vinserti32x4 $1, %xmm5, %zmm3, %zmm3
    vinserti32x4 $2, %xmm6, %zmm3, %zmm3
    vinserti32x4 $3, %xmm7, %zmm3, %zmm3
    vaesdeclast 320(%rsi), %zmm3, %zmm3
    vaesdeclast %zmm15, %zmm3, %zmm3
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm0, %zmm3, %zmm0
    vaesdeclast %zmm15, %zmm0, %zmm0
    vextracti32x4 $1, %zmm2, %xmm5
    vextracti32x4 $2, %zmm2, %xmm6
    vextracti32x4 $3, %zmm2, %xmm7
    vaesimc %xmm2, %xmm2
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vinserti32x4 $1, %xmm5, %zmm2, %zmm2
    vinserti32x4 $2, %xmm6, %zmm2, %zmm2
    vinserti32x4 $3, %xmm7, %zmm2, %zmm2
    vaesdeclast 256(%rsi), %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm2, %zmm2
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm3, %zmm2, %zmm3
    vaesdeclast %zmm15, %zmm3, %zmm3
    vextracti32x4 $1, %zmm1, %xmm5
    vextracti32x4 $2, %zmm1, %xmm6
    vextracti32x4 $3, %zmm1, %xmm7
    vaesimc %xmm1, %xmm1
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vinserti32x4 $1, %xmm5, %zmm1, %zmm1
    vinserti32x4 $2, %xmm6, %zmm1, %zmm1
    vinserti32x4 $3, %xmm7, %zmm1, %zmm1
    vaesdeclast 192(%rsi), %zmm1, %zmm1
    vaesdeclast %zmm15, %zmm1, %zmm1
    vaesenc %zmm0, %zmm3, %zmm0
    vaesenc %zmm2, %zmm1, %zmm2
    vaesdeclast %zmm15, %zmm2, %zmm2
    vextracti32x4 $1, %zmm0, %xmm5
    vextracti32x4 $2, %zmm0, %xmm6
    vextracti32x4 $3, %zmm0, %xmm7
    vaesimc %xmm0, %xmm0
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vinserti32x4 $1, %xmm5, %zmm0, %zmm0
    vinserti32x4 $2, %xmm6, %zmm0, %zmm0
    vinserti32x4 $3, %xmm7, %zmm0, %zmm0
    vaesdeclast 128(%rsi), %zmm0, %zmm0
    vaesdeclast %zmm15, %zmm0, %zmm0
    vaesenc %zmm3, %zmm2, %zmm3
    vaesenc %zmm1, %zmm0, %zmm1
    vaesdeclast %zmm15, %zmm1, %zmm1
    vextracti32x4 $1, %zmm3, %xmm5
    vextracti32x4 $2, %zmm3, %xmm6
    vextracti32x4 $3, %zmm3, %xmm7
    vaesimc %xmm3, %xmm3
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vinserti32x4 $1, %xmm5, %zmm3, %zmm3
    vinserti32x4 $2, %xmm6, %zmm3, %zmm3
    vinserti32x4 $3, %xmm7, %zmm3, %zmm3
    vaesdeclast 64(%rsi), %zmm3, %zmm3
    vaesdeclast %zmm15, %zmm3, %zmm3
    vaesenc %zmm2, %zmm1, %zmm2
    vaesenc %zmm0, %zmm3, %zmm0
    vaesdeclast %zmm15, %zmm0, %zmm0
    vextracti32x4 $1, %zmm2, %xmm5
    vextracti32x4 $2, %zmm2, %xmm6
    vextracti32x4 $3, %zmm2, %xmm7
    vaesimc %xmm2, %xmm2
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vinserti32x4 $1, %xmm5, %zmm2, %zmm2
    vinserti32x4 $2, %xmm6, %zmm2, %zmm2
    vinserti32x4 $3, %xmm7, %zmm2, %zmm2
    vaesdeclast (%rsi), %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm2, %zmm2
    vaesenc %zmm1, %zmm0, %zmm1
    vaesenc %zmm3, %zmm2, %zmm3
    vmovdqu64 %zmm0, (%rax)
    vmovdqu64 %zmm1, (%r10)
    vmovdqu64 %zmm2, (%rcx)
    vmovdqu64 %zmm3, (%rdx)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm5, %xmm5, %xmm5
    vpxord %xmm6, %xmm6, %xmm6
    vpxord %xmm7, %xmm7, %xmm7
    vpxord %xmm15, %xmm15, %xmm15
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
    vmovdqu 48(%rsp), %xmm15
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    addq $72, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion512InversePermutex4RC)

AREION_FUNC_START(areion256Permutex4Avx2RC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %rdx, %rcx
#else
    subq $40, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm15, 16(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
#endif
    vmovdqu (%rax), %ymm0
    vmovdqu 32(%rax), %ymm1
    vmovdqu (%r10), %ymm2
    vmovdqu 32(%r10), %ymm3
    vpxor %ymm15, %ymm15, %ymm15
    vmovdqu (%rcx), %ymm6
    vaesenc %ymm6, %ymm0, %ymm4
    vaesenc %ymm6, %ymm1, %ymm5
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenc %ymm2, %ymm4, %ymm2
    vaesenc %ymm3, %ymm5, %ymm3
    vmovdqu 64(%rcx), %ymm6
    vaesenc %ymm6, %ymm2, %ymm4
    vaesenc %ymm6, %ymm3, %ymm5
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm1, %ymm5, %ymm1
    vmovdqu 128(%rcx), %ymm6
    vaesenc %ymm6, %ymm0, %ymm4
    vaesenc %ymm6, %ymm1, %ymm5
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenc %ymm2, %ymm4, %ymm2
    vaesenc %ymm3, %ymm5, %ymm3
    vmovdqu 192(%rcx), %ymm6
    vaesenc %ymm6, %ymm2, %ymm4
    vaesenc %ymm6, %ymm3, %ymm5
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm1, %ymm5, %ymm1
    vmovdqu 256(%rcx), %ymm6
    vaesenc %ymm6, %ymm0, %ymm4
    vaesenc %ymm6, %ymm1, %ymm5
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenc %ymm2, %ymm4, %ymm2
    vaesenc %ymm3, %ymm5, %ymm3
    vmovdqu 320(%rcx), %ymm6
    vaesenc %ymm6, %ymm2, %ymm4
    vaesenc %ymm6, %ymm3, %ymm5
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm1, %ymm5, %ymm1
    vmovdqu 384(%rcx), %ymm6
    vaesenc %ymm6, %ymm0, %ymm4
    vaesenc %ymm6, %ymm1, %ymm5
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenc %ymm2, %ymm4, %ymm2
    vaesenc %ymm3, %ymm5, %ymm3
    vmovdqu 448(%rcx), %ymm6
    vaesenc %ymm6, %ymm2, %ymm4
    vaesenc %ymm6, %ymm3, %ymm5
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm1, %ymm5, %ymm1
    vmovdqu 512(%rcx), %ymm6
    vaesenc %ymm6, %ymm0, %ymm4
    vaesenc %ymm6, %ymm1, %ymm5
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenc %ymm2, %ymm4, %ymm2
    vaesenc %ymm3, %ymm5, %ymm3
    vmovdqu 576(%rcx), %ymm6
    vaesenc %ymm6, %ymm2, %ymm4
    vaesenc %ymm6, %ymm3, %ymm5
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm1, %ymm5, %ymm1
    vmovdqu %ymm0, (%rax)
    vmovdqu %ymm1, 32(%rax)
    vmovdqu %ymm2, (%r10)
    vmovdqu %ymm3, 32(%r10)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm6
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm15
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    addq $40, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion256Permutex4Avx2RC)

AREION_FUNC_START(areion256InversePermutex4Avx2RC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %rdx, %rcx
#else
    subq $40, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm15, 16(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
#endif
    vmovdqu (%rax), %ymm0
    vmovdqu 32(%rax), %ymm1
    vmovdqu (%r10), %ymm2
    vmovdqu 32(%r10), %ymm3
    vpxor %ymm15, %ymm15, %ymm15
    vmovdqu 576(%rcx), %ymm6
    vaesdeclast %ymm15, %ymm2, %ymm2
    vaesdeclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm6, %ymm2, %ymm4
    vaesenc %ymm6, %ymm3, %ymm5
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm1, %ymm5, %ymm1
    vmovdqu 512(%rcx), %ymm6
    vaesdeclast %ymm15, %ymm0, %ymm0
    vaesdeclast %ymm15, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm4
    vaesenc %ymm6, %ymm1, %ymm5
    vaesenc %ymm2, %ymm4, %ymm2
    vaesenc %ymm3, %ymm5, %ymm3
    vmovdqu 448(%rcx), %ymm6
    vaesdeclast %ymm15, %ymm2, %ymm2
    vaesdeclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm6, %ymm2, %ymm4
    vaesenc %ymm6, %ymm3, %ymm5
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm1, %ymm5, %ymm1
    vmovdqu 384(%rcx), %ymm6
    vaesdeclast %ymm15, %ymm0, %ymm0
    vaesdeclast %ymm15, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm4
    vaesenc %ymm6, %ymm1, %ymm5
    vaesenc %ymm2, %ymm4, %ymm2
    vaesenc %ymm3, %ymm5, %ymm3
    vmovdqu 320(%rcx), %ymm6
    vaesdeclast %ymm15, %ymm2, %ymm2
    vaesdeclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm6, %ymm2, %ymm4
    vaesenc %ymm6, %ymm3, %ymm5
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm1, %ymm5, %ymm1
    vmovdqu 256(%rcx), %ymm6
    vaesdeclast %ymm15, %ymm0, %ymm0
    vaesdeclast %ymm15, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm4
    vaesenc %ymm6, %ymm1, %ymm5
    vaesenc %ymm2, %ymm4, %ymm2
    vaesenc %ymm3, %ymm5, %ymm3
    vmovdqu 192(%rcx), %ymm6
    vaesdeclast %ymm15, %ymm2, %ymm2
    vaesdeclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm6, %ymm2, %ymm4
    vaesenc %ymm6, %ymm3, %ymm5
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm1, %ymm5, %ymm1
    vmovdqu 128(%rcx), %ymm6
    vaesdeclast %ymm15, %ymm0, %ymm0
    vaesdeclast %ymm15, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm4
    vaesenc %ymm6, %ymm1, %ymm5
    vaesenc %ymm2, %ymm4, %ymm2
    vaesenc %ymm3, %ymm5, %ymm3
    vmovdqu 64(%rcx), %ymm6
    vaesdeclast %ymm15, %ymm2, %ymm2
    vaesdeclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm6, %ymm2, %ymm4
    vaesenc %ymm6, %ymm3, %ymm5
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm1, %ymm5, %ymm1
    vmovdqu (%rcx), %ymm6
    vaesdeclast %ymm15, %ymm0, %ymm0
    vaesdeclast %ymm15, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm4
    vaesenc %ymm6, %ymm1, %ymm5
    vaesenc %ymm2, %ymm4, %ymm2
    vaesenc %ymm3, %ymm5, %ymm3
    vmovdqu %ymm0, (%rax)
    vmovdqu %ymm1, 32(%rax)
    vmovdqu %ymm2, (%r10)
    vmovdqu %ymm3, 32(%r10)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm6
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm15
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    addq $40, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion256InversePermutex4Avx2RC)

AREION_FUNC_START(areion512Permutex4Avx2RC)
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
    vmovdqu %xmm15, 64(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rdx
    movq %r9, %rsi
    movq 128(%rsp), %rcx
#endif
    vmovdqu (%rax), %ymm0
    vmovdqu 32(%rax), %ymm1
    vmovdqu (%r10), %ymm2
    vmovdqu 32(%r10), %ymm3
    vmovdqu (%rdx), %ymm4
    vmovdqu 32(%rdx), %ymm5
    vmovdqu (%rsi), %ymm6
    vmovdqu 32(%rsi), %ymm7
    vpxor %ymm15, %ymm15, %ymm15
    vmovdqu (%rcx), %ymm12
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesenc %ymm15, %ymm4, %ymm4
    vaesenc %ymm15, %ymm5, %ymm5
    vmovdqu 64(%rcx), %ymm12
    vaesenc %ymm4, %ymm2, %ymm4
    vaesenc %ymm5, %ymm3, %ymm5
    vaesenc %ymm0, %ymm6, %ymm0
    vaesenc %ymm1, %ymm7, %ymm1
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesenc %ymm15, %ymm6, %ymm6
    vaesenc %ymm15, %ymm7, %ymm7
    vmovdqu 128(%rcx), %ymm12
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesenc %ymm15, %ymm0, %ymm0
    vaesenc %ymm15, %ymm1, %ymm1
    vmovdqu 192(%rcx), %ymm12
    vaesenc %ymm0, %ymm6, %ymm0
    vaesenc %ymm1, %ymm7, %ymm1
    vaesenc %ymm4, %ymm2, %ymm4
    vaesenc %ymm5, %ymm3, %ymm5
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast %ymm15, %ymm7, %ymm7
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesenc %ymm15, %ymm2, %ymm2
    vaesenc %ymm15, %ymm3, %ymm3
    vmovdqu 256(%rcx), %ymm12
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesenc %ymm15, %ymm4, %ymm4
    vaesenc %ymm15, %ymm5, %ymm5
    vmovdqu 320(%rcx), %ymm12
    vaesenc %ymm4, %ymm2, %ymm4
    vaesenc %ymm5, %ymm3, %ymm5
    vaesenc %ymm0, %ymm6, %ymm0
    vaesenc %ymm1, %ymm7, %ymm1
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesenc %ymm15, %ymm6, %ymm6
    vaesenc %ymm15, %ymm7, %ymm7
    vmovdqu 384(%rcx), %ymm12
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesenc %ymm15, %ymm0, %ymm0
    vaesenc %ymm15, %ymm1, %ymm1
    vmovdqu 448(%rcx), %ymm12
    vaesenc %ymm0, %ymm6, %ymm0
    vaesenc %ymm1, %ymm7, %ymm1
    vaesenc %ymm4, %ymm2, %ymm4
    vaesenc %ymm5, %ymm3, %ymm5
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast %ymm15, %ymm7, %ymm7
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesenc %ymm15, %ymm2, %ymm2
    vaesenc %ymm15, %ymm3, %ymm3
    vmovdqu 512(%rcx), %ymm12
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesenc %ymm15, %ymm4, %ymm4
    vaesenc %ymm15, %ymm5, %ymm5
    vmovdqu 576(%rcx), %ymm12
    vaesenc %ymm4, %ymm2, %ymm4
    vaesenc %ymm5, %ymm3, %ymm5
    vaesenc %ymm0, %ymm6, %ymm0
    vaesenc %ymm1, %ymm7, %ymm1
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesenc %ymm15, %ymm6, %ymm6
    vaesenc %ymm15, %ymm7, %ymm7
    vmovdqu 640(%rcx), %ymm12
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesenc %ymm15, %ymm0, %ymm0
    vaesenc %ymm15, %ymm1, %ymm1
    vmovdqu 704(%rcx), %ymm12
    vaesenc %ymm0, %ymm6, %ymm0
    vaesenc %ymm1, %ymm7, %ymm1
    vaesenc %ymm4, %ymm2, %ymm4
    vaesenc %ymm5, %ymm3, %ymm5
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast %ymm15, %ymm7, %ymm7
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesenc %ymm15, %ymm2, %ymm2
    vaesenc %ymm15, %ymm3, %ymm3
    vmovdqu 768(%rcx), %ymm12
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesenc %ymm15, %ymm4, %ymm4
    vaesenc %ymm15, %ymm5, %ymm5
    vmovdqu 832(%rcx), %ymm12
    vaesenc %ymm4, %ymm2, %ymm4
    vaesenc %ymm5, %ymm3, %ymm5
    vaesenc %ymm0, %ymm6, %ymm0
    vaesenc %ymm1, %ymm7, %ymm1
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesenc %ymm15, %ymm6, %ymm6
    vaesenc %ymm15, %ymm7, %ymm7
    vmovdqu 896(%rcx), %ymm12
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesenc %ymm15, %ymm0, %ymm0
    vaesenc %ymm15, %ymm1, %ymm1
    vmovdqu %ymm6, (%rax)
    vmovdqu %ymm7, 32(%rax)
    vmovdqu %ymm0, (%r10)
    vmovdqu %ymm1, 32(%r10)
    vmovdqu %ymm2, (%rdx)
    vmovdqu %ymm3, 32(%rdx)
    vmovdqu %ymm4, (%rsi)
    vmovdqu %ymm5, 32(%rsi)
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
    vmovdqu 64(%rsp), %xmm15
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    addq $88, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion512Permutex4Avx2RC)

AREION_FUNC_START(areion512InversePermutex4Avx2RC)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rsi, %r10
    movq %rcx, %rsi
    movq %r8, %rcx
#else
    subq $120, %rsp
    movq %rsi, 0(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm12, 80(%rsp)
    vmovdqu %xmm15, 96(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rdx
    movq %r9, %rsi
    movq 160(%rsp), %rcx
#endif
    vmovdqu (%r10), %ymm0
    vmovdqu 32(%r10), %ymm1
    vmovdqu (%rdx), %ymm2
    vmovdqu 32(%rdx), %ymm3
    vmovdqu (%rsi), %ymm4
    vmovdqu 32(%rsi), %ymm5
    vmovdqu (%rax), %ymm6
    vmovdqu 32(%rax), %ymm7
    vpxor %ymm15, %ymm15, %ymm15
    vmovdqu 896(%rcx), %ymm12
    vaesdeclast %ymm15, %ymm4, %ymm4
    vaesdeclast %ymm15, %ymm5, %ymm5
    vextracti128 $1, %ymm0, %xmm8
    vextracti128 $1, %ymm1, %xmm9
    vaesimc %xmm0, %xmm0
    vaesimc %xmm8, %xmm8
    vaesimc %xmm1, %xmm1
    vaesimc %xmm9, %xmm9
    vinserti128 $1, %xmm8, %ymm0, %ymm0
    vinserti128 $1, %xmm9, %ymm1, %ymm1
    vaesdeclast %ymm12, %ymm0, %ymm0
    vaesdeclast %ymm12, %ymm1, %ymm1
    vaesdeclast %ymm15, %ymm0, %ymm0
    vaesdeclast %ymm15, %ymm1, %ymm1
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vmovdqu 832(%rcx), %ymm12
    vaesdeclast %ymm15, %ymm2, %ymm2
    vaesdeclast %ymm15, %ymm3, %ymm3
    vextracti128 $1, %ymm6, %xmm8
    vextracti128 $1, %ymm7, %xmm9
    vaesimc %xmm6, %xmm6
    vaesimc %xmm8, %xmm8
    vaesimc %xmm7, %xmm7
    vaesimc %xmm9, %xmm9
    vinserti128 $1, %xmm8, %ymm6, %ymm6
    vinserti128 $1, %xmm9, %ymm7, %ymm7
    vaesdeclast %ymm12, %ymm6, %ymm6
    vaesdeclast %ymm12, %ymm7, %ymm7
    vaesdeclast %ymm15, %ymm6, %ymm6
    vaesdeclast %ymm15, %ymm7, %ymm7
    vaesenc %ymm4, %ymm2, %ymm4
    vaesenc %ymm5, %ymm3, %ymm5
    vaesenc %ymm0, %ymm6, %ymm0
    vaesenc %ymm1, %ymm7, %ymm1
    vmovdqu 768(%rcx), %ymm12
    vaesdeclast %ymm15, %ymm0, %ymm0
    vaesdeclast %ymm15, %ymm1, %ymm1
    vextracti128 $1, %ymm4, %xmm8
    vextracti128 $1, %ymm5, %xmm9
    vaesimc %xmm4, %xmm4
    vaesimc %xmm8, %xmm8
    vaesimc %xmm5, %xmm5
    vaesimc %xmm9, %xmm9
    vinserti128 $1, %xmm8, %ymm4, %ymm4
    vinserti128 $1, %xmm9, %ymm5, %ymm5
    vaesdeclast %ymm12, %ymm4, %ymm4
    vaesdeclast %ymm12, %ymm5, %ymm5
    vaesdeclast %ymm15, %ymm4, %ymm4
    vaesdeclast %ymm15, %ymm5, %ymm5
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vmovdqu 704(%rcx), %ymm12
    vaesdeclast %ymm15, %ymm6, %ymm6
    vaesdeclast %ymm15, %ymm7, %ymm7
    vextracti128 $1, %ymm2, %xmm8
    vextracti128 $1, %ymm3, %xmm9
    vaesimc %xmm2, %xmm2
    vaesimc %xmm8, %xmm8
    vaesimc %xmm3, %xmm3
    vaesimc %xmm9, %xmm9
    vinserti128 $1, %xmm8, %ymm2, %ymm2
    vinserti128 $1, %xmm9, %ymm3, %ymm3
    vaesdeclast %ymm12, %ymm2, %ymm2
    vaesdeclast %ymm12, %ymm3, %ymm3
    vaesdeclast %ymm15, %ymm2, %ymm2
    vaesdeclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm6, %ymm0
    vaesenc %ymm1, %ymm7, %ymm1
    vaesenc %ymm4, %ymm2, %ymm4
    vaesenc %ymm5, %ymm3, %ymm5
    vmovdqu 640(%rcx), %ymm12
    vaesdeclast %ymm15, %ymm4, %ymm4
    vaesdeclast %ymm15, %ymm5, %ymm5
    vextracti128 $1, %ymm0, %xmm8
    vextracti128 $1, %ymm1, %xmm9
    vaesimc %xmm0, %xmm0
    vaesimc %xmm8, %xmm8
    vaesimc %xmm1, %xmm1
    vaesimc %xmm9, %xmm9
    vinserti128 $1, %xmm8, %ymm0, %ymm0
    vinserti128 $1, %xmm9, %ymm1, %ymm1
    vaesdeclast %ymm12, %ymm0, %ymm0
    vaesdeclast %ymm12, %ymm1, %ymm1
    vaesdeclast %ymm15, %ymm0, %ymm0
    vaesdeclast %ymm15, %ymm1, %ymm1
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vmovdqu 576(%rcx), %ymm12
    vaesdeclast %ymm15, %ymm2, %ymm2
    vaesdeclast %ymm15, %ymm3, %ymm3
    vextracti128 $1, %ymm6, %xmm8
    vextracti128 $1, %ymm7, %xmm9
    vaesimc %xmm6, %xmm6
    vaesimc %xmm8, %xmm8
    vaesimc %xmm7, %xmm7
    vaesimc %xmm9, %xmm9
    vinserti128 $1, %xmm8, %ymm6, %ymm6
    vinserti128 $1, %xmm9, %ymm7, %ymm7
    vaesdeclast %ymm12, %ymm6, %ymm6
    vaesdeclast %ymm12, %ymm7, %ymm7
    vaesdeclast %ymm15, %ymm6, %ymm6
    vaesdeclast %ymm15, %ymm7, %ymm7
    vaesenc %ymm4, %ymm2, %ymm4
    vaesenc %ymm5, %ymm3, %ymm5
    vaesenc %ymm0, %ymm6, %ymm0
    vaesenc %ymm1, %ymm7, %ymm1
    vmovdqu 512(%rcx), %ymm12
    vaesdeclast %ymm15, %ymm0, %ymm0
    vaesdeclast %ymm15, %ymm1, %ymm1
    vextracti128 $1, %ymm4, %xmm8
    vextracti128 $1, %ymm5, %xmm9
    vaesimc %xmm4, %xmm4
    vaesimc %xmm8, %xmm8
    vaesimc %xmm5, %xmm5
    vaesimc %xmm9, %xmm9
    vinserti128 $1, %xmm8, %ymm4, %ymm4
    vinserti128 $1, %xmm9, %ymm5, %ymm5
    vaesdeclast %ymm12, %ymm4, %ymm4
    vaesdeclast %ymm12, %ymm5, %ymm5
    vaesdeclast %ymm15, %ymm4, %ymm4
    vaesdeclast %ymm15, %ymm5, %ymm5
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vmovdqu 448(%rcx), %ymm12
    vaesdeclast %ymm15, %ymm6, %ymm6
    vaesdeclast %ymm15, %ymm7, %ymm7
    vextracti128 $1, %ymm2, %xmm8
    vextracti128 $1, %ymm3, %xmm9
    vaesimc %xmm2, %xmm2
    vaesimc %xmm8, %xmm8
    vaesimc %xmm3, %xmm3
    vaesimc %xmm9, %xmm9
    vinserti128 $1, %xmm8, %ymm2, %ymm2
    vinserti128 $1, %xmm9, %ymm3, %ymm3
    vaesdeclast %ymm12, %ymm2, %ymm2
    vaesdeclast %ymm12, %ymm3, %ymm3
    vaesdeclast %ymm15, %ymm2, %ymm2
    vaesdeclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm6, %ymm0
    vaesenc %ymm1, %ymm7, %ymm1
    vaesenc %ymm4, %ymm2, %ymm4
    vaesenc %ymm5, %ymm3, %ymm5
    vmovdqu 384(%rcx), %ymm12
    vaesdeclast %ymm15, %ymm4, %ymm4
    vaesdeclast %ymm15, %ymm5, %ymm5
    vextracti128 $1, %ymm0, %xmm8
    vextracti128 $1, %ymm1, %xmm9
    vaesimc %xmm0, %xmm0
    vaesimc %xmm8, %xmm8
    vaesimc %xmm1, %xmm1
    vaesimc %xmm9, %xmm9
    vinserti128 $1, %xmm8, %ymm0, %ymm0
    vinserti128 $1, %xmm9, %ymm1, %ymm1
    vaesdeclast %ymm12, %ymm0, %ymm0
    vaesdeclast %ymm12, %ymm1, %ymm1
    vaesdeclast %ymm15, %ymm0, %ymm0
    vaesdeclast %ymm15, %ymm1, %ymm1
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vmovdqu 320(%rcx), %ymm12
    vaesdeclast %ymm15, %ymm2, %ymm2
    vaesdeclast %ymm15, %ymm3, %ymm3
    vextracti128 $1, %ymm6, %xmm8
    vextracti128 $1, %ymm7, %xmm9
    vaesimc %xmm6, %xmm6
    vaesimc %xmm8, %xmm8
    vaesimc %xmm7, %xmm7
    vaesimc %xmm9, %xmm9
    vinserti128 $1, %xmm8, %ymm6, %ymm6
    vinserti128 $1, %xmm9, %ymm7, %ymm7
    vaesdeclast %ymm12, %ymm6, %ymm6
    vaesdeclast %ymm12, %ymm7, %ymm7
    vaesdeclast %ymm15, %ymm6, %ymm6
    vaesdeclast %ymm15, %ymm7, %ymm7
    vaesenc %ymm4, %ymm2, %ymm4
    vaesenc %ymm5, %ymm3, %ymm5
    vaesenc %ymm0, %ymm6, %ymm0
    vaesenc %ymm1, %ymm7, %ymm1
    vmovdqu 256(%rcx), %ymm12
    vaesdeclast %ymm15, %ymm0, %ymm0
    vaesdeclast %ymm15, %ymm1, %ymm1
    vextracti128 $1, %ymm4, %xmm8
    vextracti128 $1, %ymm5, %xmm9
    vaesimc %xmm4, %xmm4
    vaesimc %xmm8, %xmm8
    vaesimc %xmm5, %xmm5
    vaesimc %xmm9, %xmm9
    vinserti128 $1, %xmm8, %ymm4, %ymm4
    vinserti128 $1, %xmm9, %ymm5, %ymm5
    vaesdeclast %ymm12, %ymm4, %ymm4
    vaesdeclast %ymm12, %ymm5, %ymm5
    vaesdeclast %ymm15, %ymm4, %ymm4
    vaesdeclast %ymm15, %ymm5, %ymm5
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vmovdqu 192(%rcx), %ymm12
    vaesdeclast %ymm15, %ymm6, %ymm6
    vaesdeclast %ymm15, %ymm7, %ymm7
    vextracti128 $1, %ymm2, %xmm8
    vextracti128 $1, %ymm3, %xmm9
    vaesimc %xmm2, %xmm2
    vaesimc %xmm8, %xmm8
    vaesimc %xmm3, %xmm3
    vaesimc %xmm9, %xmm9
    vinserti128 $1, %xmm8, %ymm2, %ymm2
    vinserti128 $1, %xmm9, %ymm3, %ymm3
    vaesdeclast %ymm12, %ymm2, %ymm2
    vaesdeclast %ymm12, %ymm3, %ymm3
    vaesdeclast %ymm15, %ymm2, %ymm2
    vaesdeclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm6, %ymm0
    vaesenc %ymm1, %ymm7, %ymm1
    vaesenc %ymm4, %ymm2, %ymm4
    vaesenc %ymm5, %ymm3, %ymm5
    vmovdqu 128(%rcx), %ymm12
    vaesdeclast %ymm15, %ymm4, %ymm4
    vaesdeclast %ymm15, %ymm5, %ymm5
    vextracti128 $1, %ymm0, %xmm8
    vextracti128 $1, %ymm1, %xmm9
    vaesimc %xmm0, %xmm0
    vaesimc %xmm8, %xmm8
    vaesimc %xmm1, %xmm1
    vaesimc %xmm9, %xmm9
    vinserti128 $1, %xmm8, %ymm0, %ymm0
    vinserti128 $1, %xmm9, %ymm1, %ymm1
    vaesdeclast %ymm12, %ymm0, %ymm0
    vaesdeclast %ymm12, %ymm1, %ymm1
    vaesdeclast %ymm15, %ymm0, %ymm0
    vaesdeclast %ymm15, %ymm1, %ymm1
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vmovdqu 64(%rcx), %ymm12
    vaesdeclast %ymm15, %ymm2, %ymm2
    vaesdeclast %ymm15, %ymm3, %ymm3
    vextracti128 $1, %ymm6, %xmm8
    vextracti128 $1, %ymm7, %xmm9
    vaesimc %xmm6, %xmm6
    vaesimc %xmm8, %xmm8
    vaesimc %xmm7, %xmm7
    vaesimc %xmm9, %xmm9
    vinserti128 $1, %xmm8, %ymm6, %ymm6
    vinserti128 $1, %xmm9, %ymm7, %ymm7
    vaesdeclast %ymm12, %ymm6, %ymm6
    vaesdeclast %ymm12, %ymm7, %ymm7
    vaesdeclast %ymm15, %ymm6, %ymm6
    vaesdeclast %ymm15, %ymm7, %ymm7
    vaesenc %ymm4, %ymm2, %ymm4
    vaesenc %ymm5, %ymm3, %ymm5
    vaesenc %ymm0, %ymm6, %ymm0
    vaesenc %ymm1, %ymm7, %ymm1
    vmovdqu (%rcx), %ymm12
    vaesdeclast %ymm15, %ymm0, %ymm0
    vaesdeclast %ymm15, %ymm1, %ymm1
    vextracti128 $1, %ymm4, %xmm8
    vextracti128 $1, %ymm5, %xmm9
    vaesimc %xmm4, %xmm4
    vaesimc %xmm8, %xmm8
    vaesimc %xmm5, %xmm5
    vaesimc %xmm9, %xmm9
    vinserti128 $1, %xmm8, %ymm4, %ymm4
    vinserti128 $1, %xmm9, %ymm5, %ymm5
    vaesdeclast %ymm12, %ymm4, %ymm4
    vaesdeclast %ymm12, %ymm5, %ymm5
    vaesdeclast %ymm15, %ymm4, %ymm4
    vaesdeclast %ymm15, %ymm5, %ymm5
    vaesenc %ymm2, %ymm0, %ymm2
    vaesenc %ymm3, %ymm1, %ymm3
    vaesenc %ymm6, %ymm4, %ymm6
    vaesenc %ymm7, %ymm5, %ymm7
    vmovdqu %ymm0, (%rax)
    vmovdqu %ymm1, 32(%rax)
    vmovdqu %ymm2, (%r10)
    vmovdqu %ymm3, 32(%r10)
    vmovdqu %ymm4, (%rdx)
    vmovdqu %ymm5, 32(%rdx)
    vmovdqu %ymm6, (%rsi)
    vmovdqu %ymm7, 32(%rsi)
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
    vpxor %xmm12, %xmm12, %xmm12
    vpxor %xmm15, %xmm15, %xmm15
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
    vmovdqu 48(%rsp), %xmm8
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    vmovdqu 64(%rsp), %xmm9
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    vmovdqu 80(%rsp), %xmm12
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    vmovdqu 96(%rsp), %xmm15
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    addq $120, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion512InversePermutex4Avx2RC)

AREION_FUNC_START(dumpSIMDRegs)
#if !defined(_WIN64)
    movq %rax, 512(%rdi)
    movq %rcx, 520(%rdi)
    movq %rdx, 528(%rdi)
    movq $0, 536(%rdi)
    movq %r8, 544(%rdi)
    movq %r9, 552(%rdi)
    movq %r10, 560(%rdi)
    movq %r11, 568(%rdi)
    movq $0, 576(%rdi)
    movq $0, 584(%rdi)
    movq $0, 592(%rdi)
    movq %rdi, %rax
    movl %esi, %ecx
#else
    movq %rax, 512(%rcx)
    movq $0, 520(%rcx)
    movq $0, 528(%rcx)
    movq $0, 536(%rcx)
    movq %r8, 544(%rcx)
    movq %r9, 552(%rcx)
    movq %r10, 560(%rcx)
    movq %r11, 568(%rcx)
    movq $0, 576(%rcx)
    movq $0, 584(%rcx)
    movq $0, 592(%rcx)
    movq %rcx, %rax
    movl %edx, %ecx
#endif
    movdqu %xmm0, 0(%rax)
    movdqu %xmm1, 16(%rax)
    movdqu %xmm2, 32(%rax)
    movdqu %xmm3, 48(%rax)
    movdqu %xmm4, 64(%rax)
    movdqu %xmm5, 80(%rax)
    movdqu %xmm6, 96(%rax)
    movdqu %xmm7, 112(%rax)
    movdqu %xmm8, 128(%rax)
    movdqu %xmm9, 144(%rax)
    movdqu %xmm10, 160(%rax)
    movdqu %xmm11, 176(%rax)
    movdqu %xmm12, 192(%rax)
    movdqu %xmm13, 208(%rax)
    movdqu %xmm14, 224(%rax)
    movdqu %xmm15, 240(%rax)
    testl %ecx, %ecx
    jz dumpDone
    vmovdqu64 %xmm16, 256(%rax)
    vmovdqu64 %xmm17, 272(%rax)
    vmovdqu64 %xmm18, 288(%rax)
    vmovdqu64 %xmm19, 304(%rax)
    vmovdqu64 %xmm20, 320(%rax)
    vmovdqu64 %xmm21, 336(%rax)
    vmovdqu64 %xmm22, 352(%rax)
    vmovdqu64 %xmm23, 368(%rax)
    vmovdqu64 %xmm24, 384(%rax)
    vmovdqu64 %xmm25, 400(%rax)
    vmovdqu64 %xmm26, 416(%rax)
    vmovdqu64 %xmm27, 432(%rax)
    vmovdqu64 %xmm28, 448(%rax)
    vmovdqu64 %xmm29, 464(%rax)
    vmovdqu64 %xmm30, 480(%rax)
    vmovdqu64 %xmm31, 496(%rax)
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
    vpxord %xmm31, %xmm31, %xmm31
    vzeroupper
dumpDone:
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
#if !defined(_WIN64)
    pxor %xmm6, %xmm6
    pxor %xmm7, %xmm7
    pxor %xmm8, %xmm8
    pxor %xmm9, %xmm9
    pxor %xmm10, %xmm10
    pxor %xmm11, %xmm11
    pxor %xmm12, %xmm12
    pxor %xmm13, %xmm13
    pxor %xmm14, %xmm14
    pxor %xmm15, %xmm15
    xorq %rsi, %rsi
    xorq %rdi, %rdi
#endif
    xorq %rax, %rax
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r8, %r8
    xorq %r9, %r9
    xorq %r10, %r10
    xorq %r11, %r11
    ret
AREION_FUNC_END(dumpSIMDRegs)

AREION_FUNC_START(clobberScratchGPRs)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
#if !defined(_WIN64)
    pxor %xmm6, %xmm6
    pxor %xmm7, %xmm7
    pxor %xmm8, %xmm8
    pxor %xmm9, %xmm9
    pxor %xmm10, %xmm10
    pxor %xmm11, %xmm11
    pxor %xmm12, %xmm12
    pxor %xmm13, %xmm13
    pxor %xmm14, %xmm14
    pxor %xmm15, %xmm15
    xorq %rsi, %rsi
    xorq %rdi, %rdi
#endif
    xorq %rax, %rax
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r8, %r8
    xorq %r9, %r9
    xorq %r10, %r10
    xorq %r11, %r11
    ret
AREION_FUNC_END(clobberScratchGPRs)

AREION_FUNC_START(dirtySIMDRegForTest)
#if !defined(_WIN64)
    movq %rdi, %r10
#else
    movq %rcx, %r10
#endif
    movabsq $0x5555555555555555, %rax
    xorq %rax, %r10
    movq %r10, %xmm2
    xorq %rax, %rax
    ret
AREION_FUNC_END(dirtySIMDRegForTest)

AREION_FUNC_START(areion256EMEncryptAESNI)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $24, %rsp
    movdqu %xmm15, 0(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu (%rax), %xmm2
    movdqu 16(%rax), %xmm3
    pxor %xmm2, %xmm0
    pxor %xmm3, %xmm1
    pxor %xmm15, %xmm15
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 32(%rax), %xmm2
    movdqu 48(%rax), %xmm3
    pxor %xmm2, %xmm0
    pxor %xmm3, %xmm1
    movdqu %xmm0, (%rdx)
    movdqu %xmm1, 16(%rdx)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion256EMEncryptAESNI)

AREION_FUNC_START(areion256EMEncryptVEX)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $24, %rsp
    vmovdqu %xmm15, 0(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vpxor (%rax), %xmm0, %xmm0
    vpxor 16(%rax), %xmm1, %xmm1
    vpxor %xmm15, %xmm15, %xmm15
    vaesenc AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 16+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 64+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 80+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 128+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 144+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vpxor 32(%rax), %xmm0, %xmm0
    vpxor 48(%rax), %xmm1, %xmm1
    vmovdqu %xmm0, (%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion256EMEncryptVEX)

AREION_FUNC_START(areion256EMDecryptAESNI)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $24, %rsp
    movdqu %xmm15, 0(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu 32(%rax), %xmm2
    movdqu 48(%rax), %xmm3
    pxor %xmm2, %xmm0
    pxor %xmm3, %xmm1
    pxor %xmm15, %xmm15
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu (%rax), %xmm2
    movdqu 16(%rax), %xmm3
    pxor %xmm2, %xmm0
    pxor %xmm3, %xmm1
    movdqu %xmm0, (%rdx)
    movdqu %xmm1, 16(%rdx)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion256EMDecryptAESNI)

AREION_FUNC_START(areion256EMDecryptVEX)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $24, %rsp
    vmovdqu %xmm15, 0(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vpxor 32(%rax), %xmm0, %xmm0
    vpxor 48(%rax), %xmm1, %xmm1
    vpxor %xmm15, %xmm15, %xmm15
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 144+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 128+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 80+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 64+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 16+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vpxor (%rax), %xmm0, %xmm0
    vpxor 16(%rax), %xmm1, %xmm1
    vmovdqu %xmm0, (%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion256EMDecryptVEX)

AREION_FUNC_START(areion512EMEncryptAESNI)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $24, %rsp
    movdqu %xmm15, 0(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu 32(%r10), %xmm2
    movdqu 48(%r10), %xmm3
    movdqu (%rax), %xmm4
    movdqu 16(%rax), %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqu 32(%rax), %xmm4
    movdqu 48(%rax), %xmm5
    pxor %xmm4, %xmm2
    pxor %xmm5, %xmm3
    pxor %xmm15, %xmm15
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 160+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 176+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 192+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 208+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 224+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 64(%rax), %xmm4
    movdqu 80(%rax), %xmm5
    pxor %xmm4, %xmm3
    pxor %xmm5, %xmm0
    movdqu 96(%rax), %xmm4
    movdqu 112(%rax), %xmm5
    pxor %xmm4, %xmm1
    pxor %xmm5, %xmm2
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
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion512EMEncryptAESNI)

AREION_FUNC_START(areion512EMEncryptVEX)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $24, %rsp
    vmovdqu %xmm15, 0(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vmovdqu 32(%r10), %xmm2
    vmovdqu 48(%r10), %xmm3
    vpxor (%rax), %xmm0, %xmm0
    vpxor 16(%rax), %xmm1, %xmm1
    vpxor 32(%rax), %xmm2, %xmm2
    vpxor 48(%rax), %xmm3, %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 16+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 80+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 144+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 160+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 176+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 192+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 208+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 224+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
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
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion512EMEncryptVEX)

AREION_FUNC_START(areion512EMDecryptAESNI)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $24, %rsp
    movdqu %xmm15, 0(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu 32(%r10), %xmm2
    movdqu 48(%r10), %xmm3
    movdqu 64(%rax), %xmm4
    movdqu 80(%rax), %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqu 96(%rax), %xmm4
    movdqu 112(%rax), %xmm5
    pxor %xmm4, %xmm2
    pxor %xmm5, %xmm3
    pxor %xmm15, %xmm15
    movdqu 224+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 208+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 192+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 176+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 160+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu (%rax), %xmm4
    movdqu 16(%rax), %xmm5
    pxor %xmm4, %xmm1
    pxor %xmm5, %xmm2
    movdqu 32(%rax), %xmm4
    movdqu 48(%rax), %xmm5
    pxor %xmm4, %xmm3
    pxor %xmm5, %xmm0
    movdqu %xmm1, (%rdx)
    movdqu %xmm2, 16(%rdx)
    movdqu %xmm3, 32(%rdx)
    movdqu %xmm0, 48(%rdx)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion512EMDecryptAESNI)

AREION_FUNC_START(areion512EMDecryptVEX)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $24, %rsp
    vmovdqu %xmm15, 0(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vmovdqu 32(%r10), %xmm2
    vmovdqu 48(%r10), %xmm3
    vpxor 64(%rax), %xmm0, %xmm0
    vpxor 80(%rax), %xmm1, %xmm1
    vpxor 96(%rax), %xmm2, %xmm2
    vpxor 112(%rax), %xmm3, %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 224+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 208+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 192+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 176+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 160+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 144+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 128+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 112+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 96+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 80+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 64+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 48+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 32+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 16+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vpxor (%rax), %xmm1, %xmm1
    vpxor 16(%rax), %xmm2, %xmm2
    vpxor 32(%rax), %xmm3, %xmm3
    vpxor 48(%rax), %xmm0, %xmm0
    vmovdqu %xmm1, (%rdx)
    vmovdqu %xmm2, 16(%rdx)
    vmovdqu %xmm3, 32(%rdx)
    vmovdqu %xmm0, 48(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm15
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    ret
AREION_FUNC_END(areion512EMDecryptVEX)

AREION_FUNC_START(areion256EM2EncryptAESNI)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $88, %rsp
    movdqu %xmm8, 0(%rsp)
    movdqu %xmm9, 16(%rsp)
    movdqu %xmm10, 32(%rsp)
    movdqu %xmm11, 48(%rsp)
    movdqu %xmm15, 64(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    pxor %xmm15, %xmm15
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    pxor %xmm10, %xmm8
    pxor %xmm11, %xmm9
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    movdqu %xmm0, (%rdx)
    movdqu %xmm1, 16(%rdx)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm8, %xmm8
    pxor %xmm9, %xmm9
    pxor %xmm10, %xmm10
    pxor %xmm11, %xmm11
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm8
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    movdqu 16(%rsp), %xmm9
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    movdqu 32(%rsp), %xmm10
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    movdqu 48(%rsp), %xmm11
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    movdqu 64(%rsp), %xmm15
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    addq $88, %rsp
#endif
    ret
AREION_FUNC_END(areion256EM2EncryptAESNI)

AREION_FUNC_START(areion256EM2EncryptVEX)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $88, %rsp
    vmovdqu %xmm8, 0(%rsp)
    vmovdqu %xmm9, 16(%rsp)
    vmovdqu %xmm10, 32(%rsp)
    vmovdqu %xmm11, 48(%rsp)
    vmovdqu %xmm15, 64(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vmovdqu (%rax), %xmm8
    vmovdqu 16(%rax), %xmm9
    vmovdqu 32(%rax), %xmm10
    vmovdqu 48(%rax), %xmm11
    vpxor %xmm15, %xmm15, %xmm15
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vaesenc AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 16+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 64+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 80+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 128+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 144+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vaesenc AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 16+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 32+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 48+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 64+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 80+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 96+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 112+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 128+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 144+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vpxor %xmm10, %xmm8, %xmm8
    vpxor %xmm11, %xmm9, %xmm9
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vmovdqu %xmm0, (%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm8, %xmm8, %xmm8
    vpxor %xmm9, %xmm9, %xmm9
    vpxor %xmm10, %xmm10, %xmm10
    vpxor %xmm11, %xmm11, %xmm11
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm8
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm9
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm10
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    vmovdqu 48(%rsp), %xmm11
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    vmovdqu 64(%rsp), %xmm15
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    addq $88, %rsp
#endif
    ret
AREION_FUNC_END(areion256EM2EncryptVEX)

AREION_FUNC_START(areion256EM2DecryptAESNI)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $88, %rsp
    movdqu %xmm8, 0(%rsp)
    movdqu %xmm9, 16(%rsp)
    movdqu %xmm10, 32(%rsp)
    movdqu %xmm11, 48(%rsp)
    movdqu %xmm15, 64(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    pxor %xmm15, %xmm15
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    movdqu %xmm0, (%rdx)
    movdqu %xmm1, 16(%rdx)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm8, %xmm8
    pxor %xmm9, %xmm9
    pxor %xmm10, %xmm10
    pxor %xmm11, %xmm11
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm8
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    movdqu 16(%rsp), %xmm9
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    movdqu 32(%rsp), %xmm10
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    movdqu 48(%rsp), %xmm11
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    movdqu 64(%rsp), %xmm15
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    addq $88, %rsp
#endif
    ret
AREION_FUNC_END(areion256EM2DecryptAESNI)

AREION_FUNC_START(areion256EM2DecryptVEX)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $88, %rsp
    vmovdqu %xmm8, 0(%rsp)
    vmovdqu %xmm9, 16(%rsp)
    vmovdqu %xmm10, 32(%rsp)
    vmovdqu %xmm11, 48(%rsp)
    vmovdqu %xmm15, 64(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vmovdqu (%rax), %xmm8
    vmovdqu 16(%rax), %xmm9
    vmovdqu 32(%rax), %xmm10
    vmovdqu 48(%rax), %xmm11
    vpxor %xmm15, %xmm15, %xmm15
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 144+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 128+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 112+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 96+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 80+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 64+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 48+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 32+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 16+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 144+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 128+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 80+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 64+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 16+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vmovdqu %xmm0, (%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm8, %xmm8, %xmm8
    vpxor %xmm9, %xmm9, %xmm9
    vpxor %xmm10, %xmm10, %xmm10
    vpxor %xmm11, %xmm11, %xmm11
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm8
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm9
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm10
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    vmovdqu 48(%rsp), %xmm11
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    vmovdqu 64(%rsp), %xmm15
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    addq $88, %rsp
#endif
    ret
AREION_FUNC_END(areion256EM2DecryptVEX)

AREION_FUNC_START(areion512EM2EncryptAESNI)
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
    movdqu (%rax), %xmm6
    movdqu 16(%rax), %xmm7
    movdqu 32(%rax), %xmm8
    movdqu 48(%rax), %xmm9
    movdqu 64(%rax), %xmm10
    movdqu 80(%rax), %xmm11
    movdqu 96(%rax), %xmm12
    movdqu 112(%rax), %xmm13
    pxor %xmm15, %xmm15
    pxor %xmm6, %xmm0
    pxor %xmm7, %xmm1
    pxor %xmm8, %xmm2
    pxor %xmm9, %xmm3
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 160+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 176+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 192+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 208+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 224+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    pxor %xmm10, %xmm3
    pxor %xmm11, %xmm0
    pxor %xmm12, %xmm1
    pxor %xmm13, %xmm2
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 160+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 176+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 192+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 208+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 224+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    pxor %xmm12, %xmm8
    pxor %xmm13, %xmm9
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    movdqu %xmm2, (%rdx)
    movdqu %xmm3, 16(%rdx)
    movdqu %xmm0, 32(%rdx)
    movdqu %xmm1, 48(%rdx)
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
AREION_FUNC_END(areion512EM2EncryptAESNI)

AREION_FUNC_START(areion512EM2EncryptVEX)
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
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vmovdqu 32(%r10), %xmm2
    vmovdqu 48(%r10), %xmm3
    vmovdqu (%rax), %xmm6
    vmovdqu 16(%rax), %xmm7
    vmovdqu 32(%rax), %xmm8
    vmovdqu 48(%rax), %xmm9
    vmovdqu 64(%rax), %xmm10
    vmovdqu 80(%rax), %xmm11
    vmovdqu 96(%rax), %xmm12
    vmovdqu 112(%rax), %xmm13
    vpxor %xmm15, %xmm15, %xmm15
    vpxor %xmm6, %xmm0, %xmm0
    vpxor %xmm7, %xmm1, %xmm1
    vpxor %xmm8, %xmm2, %xmm2
    vpxor %xmm9, %xmm3, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 16+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 80+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 144+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 160+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 176+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 192+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 208+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 224+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm3, %xmm3
    vpxor %xmm11, %xmm0, %xmm0
    vpxor %xmm12, %xmm1, %xmm1
    vpxor %xmm13, %xmm2, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 16+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 32+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 48+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 64+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 80+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 96+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 112+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 128+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 144+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 160+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 176+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 192+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 208+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 224+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vpxor %xmm10, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    vpxor %xmm12, %xmm8, %xmm8
    vpxor %xmm13, %xmm9, %xmm9
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vmovdqu %xmm2, (%rdx)
    vmovdqu %xmm3, 16(%rdx)
    vmovdqu %xmm0, 32(%rdx)
    vmovdqu %xmm1, 48(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
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
    xorq %r10, %r10
    xorq %rdx, %rdx
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
AREION_FUNC_END(areion512EM2EncryptVEX)

AREION_FUNC_START(areion512EM2DecryptAESNI)
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
    movdqu (%rax), %xmm6
    movdqu 16(%rax), %xmm7
    movdqu 32(%rax), %xmm8
    movdqu 48(%rax), %xmm9
    movdqu 64(%rax), %xmm10
    movdqu 80(%rax), %xmm11
    movdqu 96(%rax), %xmm12
    movdqu 112(%rax), %xmm13
    pxor %xmm15, %xmm15
    pxor %xmm6, %xmm0
    pxor %xmm7, %xmm1
    pxor %xmm8, %xmm2
    pxor %xmm9, %xmm3
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm12, %xmm2
    pxor %xmm13, %xmm3
    movdqu 224+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 208+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 192+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 176+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 160+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    pxor %xmm10, %xmm1
    pxor %xmm11, %xmm2
    pxor %xmm12, %xmm3
    pxor %xmm13, %xmm0
    movdqu 224+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 208+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 192+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 176+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 160+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    movdqu %xmm2, (%rdx)
    movdqu %xmm3, 16(%rdx)
    movdqu %xmm0, 32(%rdx)
    movdqu %xmm1, 48(%rdx)
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
AREION_FUNC_END(areion512EM2DecryptAESNI)

AREION_FUNC_START(areion512EM2DecryptVEX)
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
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vmovdqu 32(%r10), %xmm2
    vmovdqu 48(%r10), %xmm3
    vmovdqu (%rax), %xmm6
    vmovdqu 16(%rax), %xmm7
    vmovdqu 32(%rax), %xmm8
    vmovdqu 48(%rax), %xmm9
    vmovdqu 64(%rax), %xmm10
    vmovdqu 80(%rax), %xmm11
    vmovdqu 96(%rax), %xmm12
    vmovdqu 112(%rax), %xmm13
    vpxor %xmm15, %xmm15, %xmm15
    vpxor %xmm6, %xmm0, %xmm0
    vpxor %xmm7, %xmm1, %xmm1
    vpxor %xmm8, %xmm2, %xmm2
    vpxor %xmm9, %xmm3, %xmm3
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm12, %xmm2, %xmm2
    vpxor %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 224+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 208+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 192+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 176+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 160+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 144+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 128+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 112+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 96+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 80+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 64+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 48+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 32+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 16+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vpxor %xmm10, %xmm1, %xmm1
    vpxor %xmm11, %xmm2, %xmm2
    vpxor %xmm12, %xmm3, %xmm3
    vpxor %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 224+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 208+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 192+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 176+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 160+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 144+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 128+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 112+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 96+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 80+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 64+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 48+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 32+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 16+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vmovdqu %xmm2, (%rdx)
    vmovdqu %xmm3, 16(%rdx)
    vmovdqu %xmm0, 32(%rdx)
    vmovdqu %xmm1, 48(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
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
    xorq %r10, %r10
    xorq %rdx, %rdx
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
AREION_FUNC_END(areion512EM2DecryptVEX)

AREION_FUNC_START(areion256TEMEncryptAESNI)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $56, %rsp
    movdqu %xmm8, 0(%rsp)
    movdqu %xmm9, 16(%rsp)
    movdqu %xmm15, 32(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
    movq %r9, %rcx
#endif
    movdqu (%rcx), %xmm0
    movdqu 16(%rcx), %xmm1
    movdqu 32(%rax), %xmm2
    movdqu 48(%rax), %xmm3
    pxor %xmm2, %xmm0
    pxor %xmm3, %xmm1
    pxor %xmm15, %xmm15
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    pxor %xmm0, %xmm8
    pxor %xmm1, %xmm9
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    movdqu %xmm0, (%rdx)
    movdqu %xmm1, 16(%rdx)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm8, %xmm8
    pxor %xmm9, %xmm9
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm8
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    movdqu 16(%rsp), %xmm9
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    movdqu 32(%rsp), %xmm15
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    addq $56, %rsp
#endif
    ret
AREION_FUNC_END(areion256TEMEncryptAESNI)

AREION_FUNC_START(areion256TEMEncryptVEX)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $56, %rsp
    vmovdqu %xmm8, 0(%rsp)
    vmovdqu %xmm9, 16(%rsp)
    vmovdqu %xmm15, 32(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
    movq %r9, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vmovdqu 16(%rcx), %xmm1
    vpxor 32(%rax), %xmm0, %xmm0
    vpxor 48(%rax), %xmm1, %xmm1
    vpxor %xmm15, %xmm15, %xmm15
    vaesenc AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 16+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 32+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 48+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 64+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 80+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 96+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 112+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 128+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 144+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vpxor (%rax), %xmm0, %xmm8
    vpxor 16(%rax), %xmm1, %xmm9
    vpxor (%r10), %xmm8, %xmm0
    vpxor 16(%r10), %xmm9, %xmm1
    vaesenc AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 16+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 64+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 80+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 128+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 144+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vmovdqu %xmm0, (%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm8, %xmm8, %xmm8
    vpxor %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm8
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm9
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm15
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    addq $56, %rsp
#endif
    ret
AREION_FUNC_END(areion256TEMEncryptVEX)

AREION_FUNC_START(areion256TEMDecryptAESNI)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $56, %rsp
    movdqu %xmm8, 0(%rsp)
    movdqu %xmm9, 16(%rsp)
    movdqu %xmm15, 32(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
    movq %r9, %rcx
#endif
    movdqu (%rcx), %xmm0
    movdqu 16(%rcx), %xmm1
    movdqu 32(%rax), %xmm2
    movdqu 48(%rax), %xmm3
    pxor %xmm2, %xmm0
    pxor %xmm3, %xmm1
    pxor %xmm15, %xmm15
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    pxor %xmm0, %xmm8
    pxor %xmm1, %xmm9
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    movdqu %xmm0, (%rdx)
    movdqu %xmm1, 16(%rdx)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm8, %xmm8
    pxor %xmm9, %xmm9
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#if defined(_WIN64)
    movdqu 0(%rsp), %xmm8
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    movdqu 16(%rsp), %xmm9
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    movdqu 32(%rsp), %xmm15
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    addq $56, %rsp
#endif
    ret
AREION_FUNC_END(areion256TEMDecryptAESNI)

AREION_FUNC_START(areion256TEMDecryptVEX)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $56, %rsp
    vmovdqu %xmm8, 0(%rsp)
    vmovdqu %xmm9, 16(%rsp)
    vmovdqu %xmm15, 32(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
    movq %r9, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vmovdqu 16(%rcx), %xmm1
    vpxor 32(%rax), %xmm0, %xmm0
    vpxor 48(%rax), %xmm1, %xmm1
    vpxor %xmm15, %xmm15, %xmm15
    vaesenc AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 16+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 32+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 48+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 64+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 80+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 96+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 112+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 128+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 144+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vpxor (%rax), %xmm0, %xmm8
    vpxor 16(%rax), %xmm1, %xmm9
    vpxor (%r10), %xmm8, %xmm0
    vpxor 16(%r10), %xmm9, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 144+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 128+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 80+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 64+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 16+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vmovdqu %xmm0, (%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm8, %xmm8, %xmm8
    vpxor %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm8
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm9
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm15
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    addq $56, %rsp
#endif
    ret
AREION_FUNC_END(areion256TEMDecryptVEX)

AREION_FUNC_START(areion512TEMEncryptAESNI)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $88, %rsp
    movdqu %xmm6, 0(%rsp)
    movdqu %xmm7, 16(%rsp)
    movdqu %xmm8, 32(%rsp)
    movdqu %xmm9, 48(%rsp)
    movdqu %xmm15, 64(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
    movq %r9, %rcx
#endif
    movdqu (%rcx), %xmm0
    movdqu 16(%rcx), %xmm1
    movdqu 32(%rcx), %xmm2
    movdqu 48(%rcx), %xmm3
    movdqu 64(%rax), %xmm4
    movdqu 80(%rax), %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqu 96(%rax), %xmm4
    movdqu 112(%rax), %xmm5
    pxor %xmm4, %xmm2
    pxor %xmm5, %xmm3
    pxor %xmm15, %xmm15
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 160+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 176+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 192+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 208+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 224+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu (%rax), %xmm6
    movdqu 16(%rax), %xmm7
    movdqu 32(%rax), %xmm8
    movdqu 48(%rax), %xmm9
    pxor %xmm3, %xmm6
    pxor %xmm0, %xmm7
    pxor %xmm1, %xmm8
    pxor %xmm2, %xmm9
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu 32(%r10), %xmm2
    movdqu 48(%r10), %xmm3
    pxor %xmm6, %xmm0
    pxor %xmm7, %xmm1
    pxor %xmm8, %xmm2
    pxor %xmm9, %xmm3
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 160+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 176+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 192+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 208+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 224+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    pxor %xmm6, %xmm3
    pxor %xmm7, %xmm0
    pxor %xmm8, %xmm1
    pxor %xmm9, %xmm2
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
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
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
    movdqu 64(%rsp), %xmm15
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    addq $88, %rsp
#endif
    ret
AREION_FUNC_END(areion512TEMEncryptAESNI)

AREION_FUNC_START(areion512TEMEncryptVEX)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $88, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm7, 16(%rsp)
    vmovdqu %xmm8, 32(%rsp)
    vmovdqu %xmm9, 48(%rsp)
    vmovdqu %xmm15, 64(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
    movq %r9, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vmovdqu 16(%rcx), %xmm1
    vmovdqu 32(%rcx), %xmm2
    vmovdqu 48(%rcx), %xmm3
    vpxor 64(%rax), %xmm0, %xmm0
    vpxor 80(%rax), %xmm1, %xmm1
    vpxor 96(%rax), %xmm2, %xmm2
    vpxor 112(%rax), %xmm3, %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 16+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 32+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 48+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 64+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 80+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 96+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 112+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 128+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 144+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 160+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 176+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 192+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 208+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 224+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vpxor (%rax), %xmm3, %xmm6
    vpxor 16(%rax), %xmm0, %xmm7
    vpxor 32(%rax), %xmm1, %xmm8
    vpxor 48(%rax), %xmm2, %xmm9
    vpxor (%r10), %xmm6, %xmm0
    vpxor 16(%r10), %xmm7, %xmm1
    vpxor 32(%r10), %xmm8, %xmm2
    vpxor 48(%r10), %xmm9, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 16+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 80+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 144+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 160+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 176+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 192+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 208+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 224+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vpxor %xmm6, %xmm3, %xmm3
    vpxor %xmm7, %xmm0, %xmm0
    vpxor %xmm8, %xmm1, %xmm1
    vpxor %xmm9, %xmm2, %xmm2
    vmovdqu %xmm3, (%rdx)
    vmovdqu %xmm0, 16(%rdx)
    vmovdqu %xmm1, 32(%rdx)
    vmovdqu %xmm2, 48(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm6, %xmm6, %xmm6
    vpxor %xmm7, %xmm7, %xmm7
    vpxor %xmm8, %xmm8, %xmm8
    vpxor %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
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
    vmovdqu 64(%rsp), %xmm15
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    addq $88, %rsp
#endif
    ret
AREION_FUNC_END(areion512TEMEncryptVEX)

AREION_FUNC_START(areion512TEMDecryptAESNI)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $88, %rsp
    movdqu %xmm6, 0(%rsp)
    movdqu %xmm7, 16(%rsp)
    movdqu %xmm8, 32(%rsp)
    movdqu %xmm9, 48(%rsp)
    movdqu %xmm15, 64(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
    movq %r9, %rcx
#endif
    movdqu (%rcx), %xmm0
    movdqu 16(%rcx), %xmm1
    movdqu 32(%rcx), %xmm2
    movdqu 48(%rcx), %xmm3
    movdqu 64(%rax), %xmm4
    movdqu 80(%rax), %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqu 96(%rax), %xmm4
    movdqu 112(%rax), %xmm5
    pxor %xmm4, %xmm2
    pxor %xmm5, %xmm3
    pxor %xmm15, %xmm15
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 160+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 176+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 192+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 208+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 224+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu (%rax), %xmm6
    movdqu 16(%rax), %xmm7
    movdqu 32(%rax), %xmm8
    movdqu 48(%rax), %xmm9
    pxor %xmm3, %xmm6
    pxor %xmm0, %xmm7
    pxor %xmm1, %xmm8
    pxor %xmm2, %xmm9
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu 32(%r10), %xmm2
    movdqu 48(%r10), %xmm3
    pxor %xmm6, %xmm0
    pxor %xmm7, %xmm1
    pxor %xmm8, %xmm2
    pxor %xmm9, %xmm3
    movdqu 224+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 208+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 192+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 176+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 160+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    pxor %xmm6, %xmm1
    pxor %xmm7, %xmm2
    pxor %xmm8, %xmm3
    pxor %xmm9, %xmm0
    movdqu %xmm1, (%rdx)
    movdqu %xmm2, 16(%rdx)
    movdqu %xmm3, 32(%rdx)
    movdqu %xmm0, 48(%rdx)
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
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
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
    movdqu 64(%rsp), %xmm15
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    addq $88, %rsp
#endif
    ret
AREION_FUNC_END(areion512TEMDecryptAESNI)

AREION_FUNC_START(areion512TEMDecryptVEX)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $88, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm7, 16(%rsp)
    vmovdqu %xmm8, 32(%rsp)
    vmovdqu %xmm9, 48(%rsp)
    vmovdqu %xmm15, 64(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
    movq %r9, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vmovdqu 16(%rcx), %xmm1
    vmovdqu 32(%rcx), %xmm2
    vmovdqu 48(%rcx), %xmm3
    vpxor 64(%rax), %xmm0, %xmm0
    vpxor 80(%rax), %xmm1, %xmm1
    vpxor 96(%rax), %xmm2, %xmm2
    vpxor 112(%rax), %xmm3, %xmm3
    vpxor %xmm15, %xmm15, %xmm15
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 16+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 32+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 48+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 64+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 80+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 96+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 112+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 128+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 144+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 160+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 176+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 192+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 208+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 224+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vpxor (%rax), %xmm3, %xmm6
    vpxor 16(%rax), %xmm0, %xmm7
    vpxor 32(%rax), %xmm1, %xmm8
    vpxor 48(%rax), %xmm2, %xmm9
    vpxor (%r10), %xmm6, %xmm0
    vpxor 16(%r10), %xmm7, %xmm1
    vpxor 32(%r10), %xmm8, %xmm2
    vpxor 48(%r10), %xmm9, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 224+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 208+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 192+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 176+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 160+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 144+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 128+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 112+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 96+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 80+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 64+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 48+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 32+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 16+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vpxor %xmm6, %xmm1, %xmm1
    vpxor %xmm7, %xmm2, %xmm2
    vpxor %xmm8, %xmm3, %xmm3
    vpxor %xmm9, %xmm0, %xmm0
    vmovdqu %xmm1, (%rdx)
    vmovdqu %xmm2, 16(%rdx)
    vmovdqu %xmm3, 32(%rdx)
    vmovdqu %xmm0, 48(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm6, %xmm6, %xmm6
    vpxor %xmm7, %xmm7, %xmm7
    vpxor %xmm8, %xmm8, %xmm8
    vpxor %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
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
    vmovdqu 64(%rsp), %xmm15
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    addq $88, %rsp
#endif
    ret
AREION_FUNC_END(areion512TEMDecryptVEX)

AREION_FUNC_START(areion256TEM2EncryptAESNI)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $120, %rsp
    movdqu %xmm6, 0(%rsp)
    movdqu %xmm7, 16(%rsp)
    movdqu %xmm8, 32(%rsp)
    movdqu %xmm9, 48(%rsp)
    movdqu %xmm10, 64(%rsp)
    movdqu %xmm11, 80(%rsp)
    movdqu %xmm15, 96(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
    movq %r9, %rcx
#endif
    movdqu (%rcx), %xmm0
    movdqu 16(%rcx), %xmm1
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    movdqa %xmm0, %xmm2
    movdqa %xmm1, %xmm3
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm15, %xmm15
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm0, %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm1, %xmm4
    aesenc %xmm3, %xmm5
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    movdqa %xmm4, %xmm1
    movdqa %xmm5, %xmm3
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm1, %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm0, %xmm4
    aesenc %xmm2, %xmm5
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    movdqa %xmm4, %xmm0
    movdqa %xmm5, %xmm2
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm0, %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm1, %xmm4
    aesenc %xmm3, %xmm5
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    movdqa %xmm4, %xmm1
    movdqa %xmm5, %xmm3
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm1, %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm0, %xmm4
    aesenc %xmm2, %xmm5
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    movdqa %xmm4, %xmm0
    movdqa %xmm5, %xmm2
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm0, %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm1, %xmm4
    aesenc %xmm3, %xmm5
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    movdqa %xmm4, %xmm1
    movdqa %xmm5, %xmm3
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm1, %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm0, %xmm4
    aesenc %xmm2, %xmm5
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    movdqa %xmm4, %xmm0
    movdqa %xmm5, %xmm2
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm0, %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm1, %xmm4
    aesenc %xmm3, %xmm5
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    movdqa %xmm4, %xmm1
    movdqa %xmm5, %xmm3
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm1, %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm0, %xmm4
    aesenc %xmm2, %xmm5
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    movdqa %xmm4, %xmm0
    movdqa %xmm5, %xmm2
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm0, %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm1, %xmm4
    aesenc %xmm3, %xmm5
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    movdqa %xmm4, %xmm1
    movdqa %xmm5, %xmm3
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm1, %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm0, %xmm4
    aesenc %xmm2, %xmm5
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    movdqa %xmm4, %xmm0
    movdqa %xmm5, %xmm2
    pxor %xmm0, %xmm8
    pxor %xmm1, %xmm9
    pxor %xmm2, %xmm10
    pxor %xmm3, %xmm11
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    aesenclast %xmm15, %xmm0
    movdqa %xmm3, %xmm1
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    aesenclast %xmm15, %xmm1
    movdqa %xmm3, %xmm0
    pxor %xmm10, %xmm8
    pxor %xmm11, %xmm9
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    movdqu %xmm0, (%rdx)
    movdqu %xmm1, 16(%rdx)
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
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
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
    movdqu 96(%rsp), %xmm15
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    addq $120, %rsp
#endif
    ret
AREION_FUNC_END(areion256TEM2EncryptAESNI)

AREION_FUNC_START(areion256TEM2EncryptVEX)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $88, %rsp
    vmovdqu %xmm8, 0(%rsp)
    vmovdqu %xmm9, 16(%rsp)
    vmovdqu %xmm10, 32(%rsp)
    vmovdqu %xmm11, 48(%rsp)
    vmovdqu %xmm15, 64(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
    movq %r9, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vmovdqu 16(%rcx), %xmm1
    vmovdqu (%rax), %xmm8
    vmovdqu 16(%rax), %xmm9
    vmovdqu 32(%rax), %xmm10
    vmovdqu 48(%rax), %xmm11
    vpxor %xmm10, %xmm0, %xmm2
    vpxor %xmm11, %xmm1, %xmm3
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm15, %xmm15, %xmm15
    vaesenc AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm4
    vaesenc AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm5
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm4, %xmm1
    vaesenc %xmm3, %xmm5, %xmm3
    vaesenc 16+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm4
    vaesenc 16+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm5
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm0, %xmm4, %xmm0
    vaesenc %xmm2, %xmm5, %xmm2
    vaesenc 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm4
    vaesenc 32+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm5
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm4, %xmm1
    vaesenc %xmm3, %xmm5, %xmm3
    vaesenc 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm4
    vaesenc 48+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm5
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm0, %xmm4, %xmm0
    vaesenc %xmm2, %xmm5, %xmm2
    vaesenc 64+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm4
    vaesenc 64+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm5
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm4, %xmm1
    vaesenc %xmm3, %xmm5, %xmm3
    vaesenc 80+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm4
    vaesenc 80+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm5
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm0, %xmm4, %xmm0
    vaesenc %xmm2, %xmm5, %xmm2
    vaesenc 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm4
    vaesenc 96+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm5
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm4, %xmm1
    vaesenc %xmm3, %xmm5, %xmm3
    vaesenc 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm4
    vaesenc 112+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm5
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm0, %xmm4, %xmm0
    vaesenc %xmm2, %xmm5, %xmm2
    vaesenc 128+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm4
    vaesenc 128+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm5
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm4, %xmm1
    vaesenc %xmm3, %xmm5, %xmm3
    vaesenc 144+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm4
    vaesenc 144+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm5
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm0, %xmm4, %xmm0
    vaesenc %xmm2, %xmm5, %xmm2
    vpxor %xmm0, %xmm8, %xmm8
    vpxor %xmm1, %xmm9, %xmm9
    vpxor %xmm2, %xmm10, %xmm10
    vpxor %xmm3, %xmm11, %xmm11
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vaesenc AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 16+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 64+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 80+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 128+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 144+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vaesenc AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 16+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 32+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 48+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 64+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 80+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 96+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 112+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc 128+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm1, %xmm3, %xmm1
    vaesenc 144+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vpxor %xmm10, %xmm8, %xmm8
    vpxor %xmm11, %xmm9, %xmm9
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vmovdqu %xmm0, (%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm8, %xmm8, %xmm8
    vpxor %xmm9, %xmm9, %xmm9
    vpxor %xmm10, %xmm10, %xmm10
    vpxor %xmm11, %xmm11, %xmm11
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm8
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm9
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm10
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    vmovdqu 48(%rsp), %xmm11
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    vmovdqu 64(%rsp), %xmm15
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    addq $88, %rsp
#endif
    ret
AREION_FUNC_END(areion256TEM2EncryptVEX)

AREION_FUNC_START(areion256TEM2DecryptAESNI)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $120, %rsp
    movdqu %xmm6, 0(%rsp)
    movdqu %xmm7, 16(%rsp)
    movdqu %xmm8, 32(%rsp)
    movdqu %xmm9, 48(%rsp)
    movdqu %xmm10, 64(%rsp)
    movdqu %xmm11, 80(%rsp)
    movdqu %xmm15, 96(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
    movq %r9, %rcx
#endif
    movdqu (%rcx), %xmm0
    movdqu 16(%rcx), %xmm1
    movdqu (%rax), %xmm8
    movdqu 16(%rax), %xmm9
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    movdqa %xmm0, %xmm2
    movdqa %xmm1, %xmm3
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm15, %xmm15
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm0, %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm1, %xmm4
    aesenc %xmm3, %xmm5
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    movdqa %xmm4, %xmm1
    movdqa %xmm5, %xmm3
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm1, %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm0, %xmm4
    aesenc %xmm2, %xmm5
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    movdqa %xmm4, %xmm0
    movdqa %xmm5, %xmm2
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm0, %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm1, %xmm4
    aesenc %xmm3, %xmm5
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    movdqa %xmm4, %xmm1
    movdqa %xmm5, %xmm3
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm1, %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm0, %xmm4
    aesenc %xmm2, %xmm5
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    movdqa %xmm4, %xmm0
    movdqa %xmm5, %xmm2
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm0, %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm1, %xmm4
    aesenc %xmm3, %xmm5
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    movdqa %xmm4, %xmm1
    movdqa %xmm5, %xmm3
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm1, %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm0, %xmm4
    aesenc %xmm2, %xmm5
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    movdqa %xmm4, %xmm0
    movdqa %xmm5, %xmm2
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm0, %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm1, %xmm4
    aesenc %xmm3, %xmm5
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    movdqa %xmm4, %xmm1
    movdqa %xmm5, %xmm3
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm1, %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm0, %xmm4
    aesenc %xmm2, %xmm5
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    movdqa %xmm4, %xmm0
    movdqa %xmm5, %xmm2
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm0, %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm1, %xmm4
    aesenc %xmm3, %xmm5
    aesenclast %xmm15, %xmm0
    aesenclast %xmm15, %xmm2
    movdqa %xmm4, %xmm1
    movdqa %xmm5, %xmm3
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm6
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm7
    movdqa %xmm1, %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm6, %xmm4
    aesenc %xmm7, %xmm5
    aesenc %xmm0, %xmm4
    aesenc %xmm2, %xmm5
    aesenclast %xmm15, %xmm1
    aesenclast %xmm15, %xmm3
    movdqa %xmm4, %xmm0
    movdqa %xmm5, %xmm2
    pxor %xmm0, %xmm8
    pxor %xmm1, %xmm9
    pxor %xmm2, %xmm10
    pxor %xmm3, %xmm11
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm1
    movdqa %xmm1, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm0, %xmm3
    movdqa %xmm3, %xmm0
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm2
    aesdeclast %xmm15, %xmm0
    movdqa %xmm0, %xmm3
    aesenc %xmm2, %xmm3
    aesenc %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    movdqu %xmm0, (%rdx)
    movdqu %xmm1, 16(%rdx)
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
    pxor %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
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
    movdqu 96(%rsp), %xmm15
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    addq $120, %rsp
#endif
    ret
AREION_FUNC_END(areion256TEM2DecryptAESNI)

AREION_FUNC_START(areion256TEM2DecryptVEX)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $88, %rsp
    vmovdqu %xmm8, 0(%rsp)
    vmovdqu %xmm9, 16(%rsp)
    vmovdqu %xmm10, 32(%rsp)
    vmovdqu %xmm11, 48(%rsp)
    vmovdqu %xmm15, 64(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
    movq %r9, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vmovdqu 16(%rcx), %xmm1
    vmovdqu (%rax), %xmm8
    vmovdqu 16(%rax), %xmm9
    vmovdqu 32(%rax), %xmm10
    vmovdqu 48(%rax), %xmm11
    vpxor %xmm10, %xmm0, %xmm2
    vpxor %xmm11, %xmm1, %xmm3
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm15, %xmm15, %xmm15
    vaesenc AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm4
    vaesenc AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm5
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm4, %xmm1
    vaesenc %xmm3, %xmm5, %xmm3
    vaesenc 16+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm4
    vaesenc 16+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm5
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm0, %xmm4, %xmm0
    vaesenc %xmm2, %xmm5, %xmm2
    vaesenc 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm4
    vaesenc 32+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm5
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm4, %xmm1
    vaesenc %xmm3, %xmm5, %xmm3
    vaesenc 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm4
    vaesenc 48+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm5
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm0, %xmm4, %xmm0
    vaesenc %xmm2, %xmm5, %xmm2
    vaesenc 64+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm4
    vaesenc 64+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm5
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm4, %xmm1
    vaesenc %xmm3, %xmm5, %xmm3
    vaesenc 80+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm4
    vaesenc 80+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm5
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm0, %xmm4, %xmm0
    vaesenc %xmm2, %xmm5, %xmm2
    vaesenc 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm4
    vaesenc 96+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm5
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm4, %xmm1
    vaesenc %xmm3, %xmm5, %xmm3
    vaesenc 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm4
    vaesenc 112+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm5
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm0, %xmm4, %xmm0
    vaesenc %xmm2, %xmm5, %xmm2
    vaesenc 128+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm4
    vaesenc 128+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm5
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm4, %xmm1
    vaesenc %xmm3, %xmm5, %xmm3
    vaesenc 144+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm4
    vaesenc 144+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm5
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm0, %xmm4, %xmm0
    vaesenc %xmm2, %xmm5, %xmm2
    vpxor %xmm0, %xmm8, %xmm8
    vpxor %xmm1, %xmm9, %xmm9
    vpxor %xmm2, %xmm10, %xmm10
    vpxor %xmm3, %xmm11, %xmm11
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 144+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 128+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 112+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 96+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 80+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 64+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 48+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 32+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 16+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 144+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 128+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 80+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 64+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc 16+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm3
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm3
    vaesenc %xmm1, %xmm3, %xmm1
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vmovdqu %xmm0, (%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm8, %xmm8, %xmm8
    vpxor %xmm9, %xmm9, %xmm9
    vpxor %xmm10, %xmm10, %xmm10
    vpxor %xmm11, %xmm11, %xmm11
    vpxor %xmm15, %xmm15, %xmm15
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm8
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    vmovdqu 16(%rsp), %xmm9
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm10
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    vmovdqu 48(%rsp), %xmm11
    movq $0, 48(%rsp)
    movq $0, 56(%rsp)
    vmovdqu 64(%rsp), %xmm15
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    addq $88, %rsp
#endif
    ret
AREION_FUNC_END(areion256TEM2DecryptVEX)

AREION_FUNC_START(areion512TEM2EncryptAESNI)
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
    movq %r9, %rcx
#endif
    movdqu (%rcx), %xmm0
    movdqu 16(%rcx), %xmm1
    movdqu 32(%rcx), %xmm2
    movdqu 48(%rcx), %xmm3
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
    movdqu 64(%rax), %xmm10
    movdqu 80(%rax), %xmm11
    movdqu 96(%rax), %xmm12
    movdqu 112(%rax), %xmm13
    pxor %xmm7, %xmm10
    pxor %xmm4, %xmm11
    pxor %xmm5, %xmm12
    pxor %xmm6, %xmm13
    movdqu (%rax), %xmm6
    movdqu 16(%rax), %xmm7
    movdqu 32(%rax), %xmm8
    movdqu 48(%rax), %xmm9
    pxor %xmm3, %xmm6
    pxor %xmm0, %xmm7
    pxor %xmm1, %xmm8
    pxor %xmm2, %xmm9
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu 32(%r10), %xmm2
    movdqu 48(%r10), %xmm3
    pxor %xmm6, %xmm0
    pxor %xmm7, %xmm1
    pxor %xmm8, %xmm2
    pxor %xmm9, %xmm3
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 160+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 176+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 192+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 208+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 224+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    pxor %xmm10, %xmm3
    pxor %xmm11, %xmm0
    pxor %xmm12, %xmm1
    pxor %xmm13, %xmm2
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 160+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    movdqu 176+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    aesenclast %xmm15, %xmm2
    aesenclast %xmm4, %xmm0
    aesenc %xmm15, %xmm0
    movdqu 192+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    aesenclast %xmm15, %xmm3
    aesenclast %xmm4, %xmm1
    aesenc %xmm15, %xmm1
    movdqu 208+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    aesenclast %xmm15, %xmm0
    aesenclast %xmm4, %xmm2
    aesenc %xmm15, %xmm2
    movdqu 224+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    aesenclast %xmm15, %xmm1
    aesenclast %xmm4, %xmm3
    aesenc %xmm15, %xmm3
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    pxor %xmm12, %xmm8
    pxor %xmm13, %xmm9
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    movdqu %xmm2, (%rdx)
    movdqu %xmm3, 16(%rdx)
    movdqu %xmm0, 32(%rdx)
    movdqu %xmm1, 48(%rdx)
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
    xorq %rcx, %rcx
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
AREION_FUNC_END(areion512TEM2EncryptAESNI)

AREION_FUNC_START(areion512TEM2EncryptVEX)
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
    movq %r9, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vmovdqu 16(%rcx), %xmm1
    vmovdqu 32(%rcx), %xmm2
    vmovdqu 48(%rcx), %xmm3
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
    vpxor 64(%rax), %xmm7, %xmm10
    vpxor 80(%rax), %xmm4, %xmm11
    vpxor 96(%rax), %xmm5, %xmm12
    vpxor 112(%rax), %xmm6, %xmm13
    vpxor (%rax), %xmm3, %xmm6
    vpxor 16(%rax), %xmm0, %xmm7
    vpxor 32(%rax), %xmm1, %xmm8
    vpxor 48(%rax), %xmm2, %xmm9
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vmovdqu 32(%r10), %xmm2
    vmovdqu 48(%r10), %xmm3
    vpxor %xmm6, %xmm0, %xmm0
    vpxor %xmm7, %xmm1, %xmm1
    vpxor %xmm8, %xmm2, %xmm2
    vpxor %xmm9, %xmm3, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 16+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 32+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 48+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 64+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 80+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 96+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 112+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 128+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 144+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 160+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 176+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 192+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 208+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 224+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm3, %xmm3
    vpxor %xmm11, %xmm0, %xmm0
    vpxor %xmm12, %xmm1, %xmm1
    vpxor %xmm13, %xmm2, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 16+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 32+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 48+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 64+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 80+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 96+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 112+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 128+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 144+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 160+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenclast %xmm15, %xmm2, %xmm2
    vaesenclast 176+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesenc %xmm15, %xmm0, %xmm0
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenclast %xmm15, %xmm3, %xmm3
    vaesenclast 192+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenclast %xmm15, %xmm0, %xmm0
    vaesenclast 208+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesenc %xmm15, %xmm2, %xmm2
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenclast %xmm15, %xmm1, %xmm1
    vaesenclast 224+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vpxor %xmm10, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    vpxor %xmm12, %xmm8, %xmm8
    vpxor %xmm13, %xmm9, %xmm9
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vmovdqu %xmm2, (%rdx)
    vmovdqu %xmm3, 16(%rdx)
    vmovdqu %xmm0, 32(%rdx)
    vmovdqu %xmm1, 48(%rdx)
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
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
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
AREION_FUNC_END(areion512TEM2EncryptVEX)

AREION_FUNC_START(areion512TEM2DecryptAESNI)
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
    movq %r9, %rcx
#endif
    movdqu (%rcx), %xmm0
    movdqu 16(%rcx), %xmm1
    movdqu 32(%rcx), %xmm2
    movdqu 48(%rcx), %xmm3
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
    movdqu 64(%rax), %xmm10
    movdqu 80(%rax), %xmm11
    movdqu 96(%rax), %xmm12
    movdqu 112(%rax), %xmm13
    pxor %xmm7, %xmm10
    pxor %xmm4, %xmm11
    pxor %xmm5, %xmm12
    pxor %xmm6, %xmm13
    movdqu (%rax), %xmm6
    movdqu 16(%rax), %xmm7
    movdqu 32(%rax), %xmm8
    movdqu 48(%rax), %xmm9
    pxor %xmm3, %xmm6
    pxor %xmm0, %xmm7
    pxor %xmm1, %xmm8
    pxor %xmm2, %xmm9
    movdqu (%r10), %xmm0
    movdqu 16(%r10), %xmm1
    movdqu 32(%r10), %xmm2
    movdqu 48(%r10), %xmm3
    pxor %xmm6, %xmm0
    pxor %xmm7, %xmm1
    pxor %xmm8, %xmm2
    pxor %xmm9, %xmm3
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm12, %xmm2
    pxor %xmm13, %xmm3
    movdqu 224+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 208+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 192+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 176+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 160+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 144+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 128+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 112+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 96+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 80+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 64+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 48+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 32+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 16+AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu AREION_SYM(roundConstantsP2)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    pxor %xmm10, %xmm1
    pxor %xmm11, %xmm2
    pxor %xmm12, %xmm3
    pxor %xmm13, %xmm0
    movdqu 224+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 208+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 192+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 176+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 160+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 144+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 128+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 112+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 96+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 80+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu 64+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqu 48+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm1
    aesimc %xmm3, %xmm3
    aesdeclast %xmm4, %xmm3
    aesdeclast %xmm15, %xmm3
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqu 32+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm0
    aesimc %xmm2, %xmm2
    aesdeclast %xmm4, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqu 16+AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm3
    aesimc %xmm1, %xmm1
    aesdeclast %xmm4, %xmm1
    aesdeclast %xmm15, %xmm1
    movdqa %xmm3, %xmm5
    aesenc %xmm0, %xmm5
    movdqa %xmm5, %xmm0
    movdqa %xmm1, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm2
    movdqu AREION_SYM(roundConstantsP1)(%rip), %xmm4
    aesdeclast %xmm15, %xmm2
    aesimc %xmm0, %xmm0
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm2, %xmm5
    aesenc %xmm3, %xmm5
    movdqa %xmm5, %xmm3
    movdqa %xmm0, %xmm5
    aesenc %xmm1, %xmm5
    movdqa %xmm5, %xmm1
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    movdqu %xmm2, (%rdx)
    movdqu %xmm3, 16(%rdx)
    movdqu %xmm0, 32(%rdx)
    movdqu %xmm1, 48(%rdx)
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
    xorq %rcx, %rcx
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
AREION_FUNC_END(areion512TEM2DecryptAESNI)

AREION_FUNC_START(areion512TEM2DecryptVEX)
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
    movq %r9, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vmovdqu 16(%rcx), %xmm1
    vmovdqu 32(%rcx), %xmm2
    vmovdqu 48(%rcx), %xmm3
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
    vpxor 64(%rax), %xmm7, %xmm10
    vpxor 80(%rax), %xmm4, %xmm11
    vpxor 96(%rax), %xmm5, %xmm12
    vpxor 112(%rax), %xmm6, %xmm13
    vpxor (%rax), %xmm3, %xmm6
    vpxor 16(%rax), %xmm0, %xmm7
    vpxor 32(%rax), %xmm1, %xmm8
    vpxor 48(%rax), %xmm2, %xmm9
    vmovdqu (%r10), %xmm0
    vmovdqu 16(%r10), %xmm1
    vmovdqu 32(%r10), %xmm2
    vmovdqu 48(%r10), %xmm3
    vpxor %xmm6, %xmm0, %xmm0
    vpxor %xmm7, %xmm1, %xmm1
    vpxor %xmm8, %xmm2, %xmm2
    vpxor %xmm9, %xmm3, %xmm3
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm12, %xmm2, %xmm2
    vpxor %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 224+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 208+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 192+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 176+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 160+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 144+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 128+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 112+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 96+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 80+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 64+AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 48+AREION_SYM(roundConstantsP2)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 32+AREION_SYM(roundConstantsP2)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 16+AREION_SYM(roundConstantsP2)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast AREION_SYM(roundConstantsP2)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vpxor %xmm10, %xmm1, %xmm1
    vpxor %xmm11, %xmm2, %xmm2
    vpxor %xmm12, %xmm3, %xmm3
    vpxor %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 224+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 208+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 192+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 176+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 160+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 144+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 128+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 112+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 96+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 80+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast 64+AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesimc %xmm3, %xmm3
    vaesdeclast 48+AREION_SYM(roundConstantsP1)(%rip), %xmm3, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesenc %xmm2, %xmm1, %xmm2
    vaesenc %xmm0, %xmm3, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesimc %xmm2, %xmm2
    vaesdeclast 32+AREION_SYM(roundConstantsP1)(%rip), %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesenc %xmm1, %xmm0, %xmm1
    vaesenc %xmm3, %xmm2, %xmm3
    vaesdeclast %xmm15, %xmm3, %xmm3
    vaesimc %xmm1, %xmm1
    vaesdeclast 16+AREION_SYM(roundConstantsP1)(%rip), %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm1, %xmm1
    vaesenc %xmm0, %xmm3, %xmm0
    vaesenc %xmm2, %xmm1, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast AREION_SYM(roundConstantsP1)(%rip), %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm2, %xmm3
    vaesenc %xmm1, %xmm0, %xmm1
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vmovdqu %xmm2, (%rdx)
    vmovdqu %xmm3, 16(%rdx)
    vmovdqu %xmm0, 32(%rdx)
    vmovdqu %xmm1, 48(%rdx)
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
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
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
AREION_FUNC_END(areion512TEM2DecryptVEX)

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
