/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#if defined(__x86_64__) || defined(_M_X64)
#include "asm_abi.h"

.text

/* =========================================================================
 * ASURA 256-bit Tweakable Block Cipher (R = 6 steps, 12 sub-rounds)
 * ========================================================================= */

AREION_FUNC_START(areion_asura_expand_tweakey_asm)
#if defined(_WIN64)
    subq $24, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
#endif
    movdqu 0(%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 0(%rdx), %xmm2
    pxor %xmm3, %xmm3
    movdqa %xmm0, %xmm4
    pxor %xmm2, %xmm4
    pxor AREION_SYM(asuraRoundConstants)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    pxor %xmm2, %xmm5
    movdqu %xmm4, 0(%rdi)
    movdqu %xmm5, 16(%rdi)
    aesenc %xmm3, %xmm2
    movdqa %xmm0, %xmm4
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm4, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm3, %xmm4
    movdqa %xmm3, %xmm5
    pcmpgtb %xmm0, %xmm4
    pcmpgtb %xmm1, %xmm5
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm5
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    pxor %xmm2, %xmm4
    pxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    pxor %xmm2, %xmm5
    movdqu %xmm4, 32(%rdi)
    movdqu %xmm5, 48(%rdi)
    aesenc %xmm3, %xmm2
    movdqa %xmm0, %xmm4
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm4, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm3, %xmm4
    movdqa %xmm3, %xmm5
    pcmpgtb %xmm0, %xmm4
    pcmpgtb %xmm1, %xmm5
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm5
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    pxor %xmm2, %xmm4
    pxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    pxor %xmm2, %xmm5
    movdqu %xmm4, 64(%rdi)
    movdqu %xmm5, 80(%rdi)
    aesenc %xmm3, %xmm2
    movdqa %xmm0, %xmm4
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm4, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm3, %xmm4
    movdqa %xmm3, %xmm5
    pcmpgtb %xmm0, %xmm4
    pcmpgtb %xmm1, %xmm5
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm5
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    pxor %xmm2, %xmm4
    pxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    pxor %xmm2, %xmm5
    movdqu %xmm4, 96(%rdi)
    movdqu %xmm5, 112(%rdi)
    aesenc %xmm3, %xmm2
    movdqa %xmm0, %xmm4
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm4, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm3, %xmm4
    movdqa %xmm3, %xmm5
    pcmpgtb %xmm0, %xmm4
    pcmpgtb %xmm1, %xmm5
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm5
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    pxor %xmm2, %xmm4
    pxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    pxor %xmm2, %xmm5
    movdqu %xmm4, 128(%rdi)
    movdqu %xmm5, 144(%rdi)
    aesenc %xmm3, %xmm2
    movdqa %xmm0, %xmm4
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm4, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm3, %xmm4
    movdqa %xmm3, %xmm5
    pcmpgtb %xmm0, %xmm4
    pcmpgtb %xmm1, %xmm5
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm5
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    pxor %xmm2, %xmm4
    pxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    pxor %xmm2, %xmm5
    movdqu %xmm4, 160(%rdi)
    movdqu %xmm5, 176(%rdi)
    aesenc %xmm3, %xmm2
    movdqa %xmm0, %xmm4
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm4, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm3, %xmm4
    movdqa %xmm3, %xmm5
    pcmpgtb %xmm0, %xmm4
    pcmpgtb %xmm1, %xmm5
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm5
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    pxor %xmm2, %xmm4
    pxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    pxor %xmm2, %xmm5
    movdqu %xmm4, 192(%rdi)
    movdqu %xmm5, 208(%rdi)
    aesenc %xmm3, %xmm2
    movdqa %xmm0, %xmm4
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm4, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm3, %xmm4
    movdqa %xmm3, %xmm5
    pcmpgtb %xmm0, %xmm4
    pcmpgtb %xmm1, %xmm5
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm5
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    pxor %xmm2, %xmm4
    pxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    pxor %xmm2, %xmm5
    movdqu %xmm4, 224(%rdi)
    movdqu %xmm5, 240(%rdi)
    aesenc %xmm3, %xmm2
    movdqa %xmm0, %xmm4
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm4, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm3, %xmm4
    movdqa %xmm3, %xmm5
    pcmpgtb %xmm0, %xmm4
    pcmpgtb %xmm1, %xmm5
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm5
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    pxor %xmm2, %xmm4
    pxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    pxor %xmm2, %xmm5
    movdqu %xmm4, 256(%rdi)
    movdqu %xmm5, 272(%rdi)
    aesenc %xmm3, %xmm2
    movdqa %xmm0, %xmm4
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm4, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm3, %xmm4
    movdqa %xmm3, %xmm5
    pcmpgtb %xmm0, %xmm4
    pcmpgtb %xmm1, %xmm5
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm5
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    pxor %xmm2, %xmm4
    pxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    pxor %xmm2, %xmm5
    movdqu %xmm4, 288(%rdi)
    movdqu %xmm5, 304(%rdi)
    aesenc %xmm3, %xmm2
    movdqa %xmm0, %xmm4
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm4, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm3, %xmm4
    movdqa %xmm3, %xmm5
    pcmpgtb %xmm0, %xmm4
    pcmpgtb %xmm1, %xmm5
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm5
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    pxor %xmm2, %xmm4
    pxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    pxor %xmm2, %xmm5
    movdqu %xmm4, 320(%rdi)
    movdqu %xmm5, 336(%rdi)
    aesenc %xmm3, %xmm2
    movdqa %xmm0, %xmm4
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm4, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm3, %xmm4
    movdqa %xmm3, %xmm5
    pcmpgtb %xmm0, %xmm4
    pcmpgtb %xmm1, %xmm5
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm5
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    pxor %xmm2, %xmm4
    pxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    pxor %xmm2, %xmm5
    movdqu %xmm4, 352(%rdi)
    movdqu %xmm5, 368(%rdi)
    aesenc %xmm3, %xmm2
    movdqa %xmm0, %xmm4
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm4, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm3, %xmm4
    movdqa %xmm3, %xmm5
    pcmpgtb %xmm0, %xmm4
    pcmpgtb %xmm1, %xmm5
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm5
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    pxor %xmm2, %xmm4
    pxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm4
    movdqa %xmm1, %xmm5
    pxor %xmm2, %xmm5
    movdqu %xmm4, 384(%rdi)
    movdqu %xmm5, 400(%rdi)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
#if defined(_WIN64)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $24, %rsp
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_expand_tweakey_asm)

AREION_FUNC_START(areion_asura_encrypt_block_asm)
#if defined(_WIN64)
    subq $24, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
#endif
    movdqu 0(%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    pxor %xmm2, %xmm2
    movdqa 64+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqu 0(%rdx), %xmm4
    movdqu 16(%rdx), %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqu 32(%rdx), %xmm4
    movdqu 48(%rdx), %xmm5
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesenc %xmm2, %xmm0
    aesdec %xmm2, %xmm1
    pshufb %xmm3, %xmm0
    pshufb %xmm3, %xmm1
    movdqa %xmm0, %xmm4
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm4
    movdqa %xmm4, %xmm1
    movdqu 64(%rdx), %xmm4
    movdqu 80(%rdx), %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqu 96(%rdx), %xmm4
    movdqu 112(%rdx), %xmm5
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesenc %xmm2, %xmm0
    aesdec %xmm2, %xmm1
    pshufb %xmm3, %xmm0
    pshufb %xmm3, %xmm1
    movdqa %xmm0, %xmm4
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm4
    movdqa %xmm4, %xmm1
    movdqu 128(%rdx), %xmm4
    movdqu 144(%rdx), %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqu 160(%rdx), %xmm4
    movdqu 176(%rdx), %xmm5
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesenc %xmm2, %xmm0
    aesdec %xmm2, %xmm1
    pshufb %xmm3, %xmm0
    pshufb %xmm3, %xmm1
    movdqa %xmm0, %xmm4
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm4
    movdqa %xmm4, %xmm1
    movdqu 192(%rdx), %xmm4
    movdqu 208(%rdx), %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqu 224(%rdx), %xmm4
    movdqu 240(%rdx), %xmm5
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesenc %xmm2, %xmm0
    aesdec %xmm2, %xmm1
    pshufb %xmm3, %xmm0
    pshufb %xmm3, %xmm1
    movdqa %xmm0, %xmm4
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm4
    movdqa %xmm4, %xmm1
    movdqu 256(%rdx), %xmm4
    movdqu 272(%rdx), %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqu 288(%rdx), %xmm4
    movdqu 304(%rdx), %xmm5
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesenc %xmm2, %xmm0
    aesdec %xmm2, %xmm1
    pshufb %xmm3, %xmm0
    pshufb %xmm3, %xmm1
    movdqa %xmm0, %xmm4
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm4
    movdqa %xmm4, %xmm1
    movdqu 320(%rdx), %xmm4
    movdqu 336(%rdx), %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqu 352(%rdx), %xmm4
    movdqu 368(%rdx), %xmm5
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    movdqu 384(%rdx), %xmm4
    movdqu 400(%rdx), %xmm5
    aesenc %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    movdqu %xmm0, 0(%rdi)
    movdqu %xmm1, 16(%rdi)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
#if defined(_WIN64)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $24, %rsp
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_encrypt_block_asm)

AREION_FUNC_START(areion_asura_decrypt_block_asm)
#if defined(_WIN64)
    subq $24, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
#endif
    movdqu 0(%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    pxor %xmm2, %xmm2
    movdqu 384(%rdx), %xmm4
    movdqu 400(%rdx), %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    movdqu 352(%rdx), %xmm4
    movdqu 368(%rdx), %xmm5
    aesimc %xmm0, %xmm0
    aesdeclast %xmm2, %xmm1
    aesdeclast %xmm2, %xmm5
    aesdeclast %xmm4, %xmm0
    aesenc %xmm2, %xmm1
    aesenc %xmm2, %xmm5
    movdqu 320(%rdx), %xmm4
    aesdeclast %xmm2, %xmm0
    aesenc %xmm5, %xmm1
    movdqu 336(%rdx), %xmm5
    aesenc %xmm2, %xmm0
    aesenclast %xmm4, %xmm0
    aesenclast %xmm5, %xmm1
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 288(%rdx), %xmm4
    movdqu 304(%rdx), %xmm5
    aesimc %xmm0, %xmm0
    aesdeclast %xmm2, %xmm1
    aesdeclast %xmm2, %xmm5
    aesdeclast %xmm4, %xmm0
    aesenc %xmm2, %xmm1
    aesenc %xmm2, %xmm5
    movdqu 256(%rdx), %xmm4
    aesdeclast %xmm2, %xmm0
    aesenc %xmm5, %xmm1
    movdqu 272(%rdx), %xmm5
    aesenc %xmm2, %xmm0
    aesenclast %xmm4, %xmm0
    aesenclast %xmm5, %xmm1
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 224(%rdx), %xmm4
    movdqu 240(%rdx), %xmm5
    aesimc %xmm0, %xmm0
    aesdeclast %xmm2, %xmm1
    aesdeclast %xmm2, %xmm5
    aesdeclast %xmm4, %xmm0
    aesenc %xmm2, %xmm1
    aesenc %xmm2, %xmm5
    movdqu 192(%rdx), %xmm4
    aesdeclast %xmm2, %xmm0
    aesenc %xmm5, %xmm1
    movdqu 208(%rdx), %xmm5
    aesenc %xmm2, %xmm0
    aesenclast %xmm4, %xmm0
    aesenclast %xmm5, %xmm1
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 160(%rdx), %xmm4
    movdqu 176(%rdx), %xmm5
    aesimc %xmm0, %xmm0
    aesdeclast %xmm2, %xmm1
    aesdeclast %xmm2, %xmm5
    aesdeclast %xmm4, %xmm0
    aesenc %xmm2, %xmm1
    aesenc %xmm2, %xmm5
    movdqu 128(%rdx), %xmm4
    aesdeclast %xmm2, %xmm0
    aesenc %xmm5, %xmm1
    movdqu 144(%rdx), %xmm5
    aesenc %xmm2, %xmm0
    aesenclast %xmm4, %xmm0
    aesenclast %xmm5, %xmm1
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 96(%rdx), %xmm4
    movdqu 112(%rdx), %xmm5
    aesimc %xmm0, %xmm0
    aesdeclast %xmm2, %xmm1
    aesdeclast %xmm2, %xmm5
    aesdeclast %xmm4, %xmm0
    aesenc %xmm2, %xmm1
    aesenc %xmm2, %xmm5
    movdqu 64(%rdx), %xmm4
    aesdeclast %xmm2, %xmm0
    aesenc %xmm5, %xmm1
    movdqu 80(%rdx), %xmm5
    aesenc %xmm2, %xmm0
    aesenclast %xmm4, %xmm0
    aesenclast %xmm5, %xmm1
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm3, %xmm1
    movdqu 32(%rdx), %xmm4
    movdqu 48(%rdx), %xmm5
    aesimc %xmm0, %xmm0
    aesdeclast %xmm2, %xmm1
    aesdeclast %xmm2, %xmm5
    aesdeclast %xmm4, %xmm0
    aesenc %xmm2, %xmm1
    aesenc %xmm2, %xmm5
    movdqu 0(%rdx), %xmm4
    aesdeclast %xmm2, %xmm0
    aesenc %xmm5, %xmm1
    movdqu 16(%rdx), %xmm5
    aesenc %xmm2, %xmm0
    aesenclast %xmm4, %xmm0
    aesenclast %xmm5, %xmm1
    movdqu %xmm0, 0(%rdi)
    movdqu %xmm1, 16(%rdi)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
#if defined(_WIN64)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $24, %rsp
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_decrypt_block_asm)

AREION_FUNC_START(areion_asura_encrypt_block_otf_asm)
#if defined(_WIN64)
    subq $72, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movdqu %xmm6, 16(%rsp)
    movdqu %xmm7, 32(%rsp)
    movdqu %xmm8, 48(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu 0(%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 0(%rdx), %xmm2
    movdqu 16(%rdx), %xmm3
    movdqu 0(%rcx), %xmm4
    pxor %xmm5, %xmm5
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    pxor %xmm6, %xmm0
    pxor %xmm7, %xmm1
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    aesdec %xmm6, %xmm0
    aesdec %xmm7, %xmm1
    aesenc %xmm5, %xmm0
    aesdec %xmm5, %xmm1
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm0, %xmm8
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm8
    movdqa %xmm8, %xmm1
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    pxor %xmm6, %xmm0
    pxor %xmm7, %xmm1
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    aesdec %xmm6, %xmm0
    aesdec %xmm7, %xmm1
    aesenc %xmm5, %xmm0
    aesdec %xmm5, %xmm1
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm0, %xmm8
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm8
    movdqa %xmm8, %xmm1
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    pxor %xmm6, %xmm0
    pxor %xmm7, %xmm1
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    aesdec %xmm6, %xmm0
    aesdec %xmm7, %xmm1
    aesenc %xmm5, %xmm0
    aesdec %xmm5, %xmm1
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm0, %xmm8
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm8
    movdqa %xmm8, %xmm1
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    pxor %xmm6, %xmm0
    pxor %xmm7, %xmm1
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    aesdec %xmm6, %xmm0
    aesdec %xmm7, %xmm1
    aesenc %xmm5, %xmm0
    aesdec %xmm5, %xmm1
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm0, %xmm8
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm8
    movdqa %xmm8, %xmm1
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    pxor %xmm6, %xmm0
    pxor %xmm7, %xmm1
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    aesdec %xmm6, %xmm0
    aesdec %xmm7, %xmm1
    aesenc %xmm5, %xmm0
    aesdec %xmm5, %xmm1
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm0, %xmm8
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm8
    movdqa %xmm8, %xmm1
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    pxor %xmm6, %xmm0
    pxor %xmm7, %xmm1
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    aesdec %xmm6, %xmm0
    aesdec %xmm7, %xmm1
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    aesenc %xmm6, %xmm0
    aesdec %xmm7, %xmm1
    movdqu %xmm0, 0(%rdi)
    movdqu %xmm1, 16(%rdi)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    pxor %xmm6, %xmm6
    pxor %xmm7, %xmm7
    pxor %xmm8, %xmm8
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
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $72, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_encrypt_block_otf_asm)

AREION_FUNC_START(areion_asura_decrypt_block_otf_asm)
#if defined(_WIN64)
    subq $72, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movdqu %xmm6, 16(%rsp)
    movdqu %xmm7, 32(%rsp)
    movdqu %xmm8, 48(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu 0(%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 0(%rdx), %xmm2
    movdqu 16(%rdx), %xmm3
    movdqu 0(%rcx), %xmm4
    pxor %xmm5, %xmm5
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    aesenc %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm5, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm2, %xmm6
    pcmpgtb %xmm3, %xmm7
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm6
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm7
    paddb %xmm2, %xmm2
    paddb %xmm3, %xmm3
    pxor %xmm6, %xmm2
    pxor %xmm7, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    pxor %xmm6, %xmm0
    pxor %xmm7, %xmm1
    aesimc %xmm4, %xmm4
    aesdeclast %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm2
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2
    pxor %xmm7, %xmm2
    movdqa %xmm3, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm3
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pxor %xmm7, %xmm3
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    aesimc %xmm0, %xmm0
    aesdeclast %xmm5, %xmm1
    aesdeclast %xmm5, %xmm7
    aesdeclast %xmm6, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm5, %xmm7
    aesdeclast %xmm5, %xmm0
    aesenc %xmm7, %xmm1
    aesenc %xmm5, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm2
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2
    pxor %xmm7, %xmm2
    movdqa %xmm3, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm3
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pxor %xmm7, %xmm3
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    aesenclast %xmm6, %xmm0
    aesenclast %xmm7, %xmm1
    aesimc %xmm4, %xmm4
    aesdeclast %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm2
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2
    pxor %xmm7, %xmm2
    movdqa %xmm3, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm3
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pxor %xmm7, %xmm3
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    movdqa %xmm0, %xmm8
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm8
    movdqa %xmm8, %xmm1
    aesimc %xmm0, %xmm0
    aesdeclast %xmm5, %xmm1
    aesdeclast %xmm5, %xmm7
    aesdeclast %xmm6, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm5, %xmm7
    aesdeclast %xmm5, %xmm0
    aesenc %xmm7, %xmm1
    aesenc %xmm5, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm2
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2
    pxor %xmm7, %xmm2
    movdqa %xmm3, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm3
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pxor %xmm7, %xmm3
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    aesenclast %xmm6, %xmm0
    aesenclast %xmm7, %xmm1
    aesimc %xmm4, %xmm4
    aesdeclast %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm2
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2
    pxor %xmm7, %xmm2
    movdqa %xmm3, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm3
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pxor %xmm7, %xmm3
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    movdqa %xmm0, %xmm8
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm8
    movdqa %xmm8, %xmm1
    aesimc %xmm0, %xmm0
    aesdeclast %xmm5, %xmm1
    aesdeclast %xmm5, %xmm7
    aesdeclast %xmm6, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm5, %xmm7
    aesdeclast %xmm5, %xmm0
    aesenc %xmm7, %xmm1
    aesenc %xmm5, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm2
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2
    pxor %xmm7, %xmm2
    movdqa %xmm3, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm3
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pxor %xmm7, %xmm3
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    aesenclast %xmm6, %xmm0
    aesenclast %xmm7, %xmm1
    aesimc %xmm4, %xmm4
    aesdeclast %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm2
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2
    pxor %xmm7, %xmm2
    movdqa %xmm3, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm3
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pxor %xmm7, %xmm3
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    movdqa %xmm0, %xmm8
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm8
    movdqa %xmm8, %xmm1
    aesimc %xmm0, %xmm0
    aesdeclast %xmm5, %xmm1
    aesdeclast %xmm5, %xmm7
    aesdeclast %xmm6, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm5, %xmm7
    aesdeclast %xmm5, %xmm0
    aesenc %xmm7, %xmm1
    aesenc %xmm5, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm2
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2
    pxor %xmm7, %xmm2
    movdqa %xmm3, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm3
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pxor %xmm7, %xmm3
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    aesenclast %xmm6, %xmm0
    aesenclast %xmm7, %xmm1
    aesimc %xmm4, %xmm4
    aesdeclast %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm2
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2
    pxor %xmm7, %xmm2
    movdqa %xmm3, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm3
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pxor %xmm7, %xmm3
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    movdqa %xmm0, %xmm8
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm8
    movdqa %xmm8, %xmm1
    aesimc %xmm0, %xmm0
    aesdeclast %xmm5, %xmm1
    aesdeclast %xmm5, %xmm7
    aesdeclast %xmm6, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm5, %xmm7
    aesdeclast %xmm5, %xmm0
    aesenc %xmm7, %xmm1
    aesenc %xmm5, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm2
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2
    pxor %xmm7, %xmm2
    movdqa %xmm3, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm3
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pxor %xmm7, %xmm3
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    aesenclast %xmm6, %xmm0
    aesenclast %xmm7, %xmm1
    aesimc %xmm4, %xmm4
    aesdeclast %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm2
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2
    pxor %xmm7, %xmm2
    movdqa %xmm3, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm3
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pxor %xmm7, %xmm3
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    movdqa %xmm0, %xmm8
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm8
    movdqa %xmm8, %xmm1
    aesimc %xmm0, %xmm0
    aesdeclast %xmm5, %xmm1
    aesdeclast %xmm5, %xmm7
    aesdeclast %xmm6, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm5, %xmm7
    aesdeclast %xmm5, %xmm0
    aesenc %xmm7, %xmm1
    aesenc %xmm5, %xmm0
    aesimc %xmm4, %xmm4
    aesdeclast %xmm5, %xmm4
    movdqa %xmm2, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm2
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2
    pxor %xmm7, %xmm2
    movdqa %xmm3, %xmm6
    psllw $7, %xmm6
    movdqa %xmm5, %xmm7
    pcmpgtb %xmm6, %xmm7
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7
    psrlw $1, %xmm3
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pxor %xmm7, %xmm3
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm6
    pblendw $0xcc, %xmm3, %xmm2
    pblendw $0xcc, %xmm6, %xmm3
    movdqa %xmm2, %xmm6
    pxor %xmm4, %xmm6
    pxor AREION_SYM(asuraRoundConstants)(%rip), %xmm6
    movdqa %xmm3, %xmm7
    pxor %xmm4, %xmm7
    aesenclast %xmm6, %xmm0
    aesenclast %xmm7, %xmm1
    movdqu %xmm0, 0(%rdi)
    movdqu %xmm1, 16(%rdi)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    pxor %xmm6, %xmm6
    pxor %xmm7, %xmm7
    pxor %xmm8, %xmm8
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
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $72, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_decrypt_block_otf_asm)

AREION_FUNC_START(areion_asura_encrypt_4blocks_asm)
#if defined(_WIN64)
    subq $136, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movdqu %xmm6, 16(%rsp)
    movdqu %xmm7, 32(%rsp)
    movdqu %xmm8, 48(%rsp)
    movdqu %xmm9, 64(%rsp)
    movdqu %xmm10, 80(%rsp)
    movdqu %xmm11, 96(%rsp)
    movdqu %xmm12, 112(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
#endif
    movdqu 0(%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    movdqu 64(%rsi), %xmm4
    movdqu 80(%rsi), %xmm5
    movdqu 96(%rsi), %xmm6
    movdqu 112(%rsi), %xmm7
    pxor %xmm8, %xmm8
    movdqa 64+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqu 0(%rdx), %xmm10
    movdqu 16(%rdx), %xmm11
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm10, %xmm4
    pxor %xmm11, %xmm5
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    movdqu 32(%rdx), %xmm10
    movdqu 48(%rdx), %xmm11
    aesdec %xmm10, %xmm0
    aesdec %xmm11, %xmm1
    aesdec %xmm10, %xmm2
    aesdec %xmm11, %xmm3
    aesdec %xmm10, %xmm4
    aesdec %xmm11, %xmm5
    aesdec %xmm10, %xmm6
    aesdec %xmm11, %xmm7
    aesenc %xmm8, %xmm0
    aesdec %xmm8, %xmm1
    aesenc %xmm8, %xmm2
    aesdec %xmm8, %xmm3
    aesenc %xmm8, %xmm4
    aesdec %xmm8, %xmm5
    aesenc %xmm8, %xmm6
    aesdec %xmm8, %xmm7
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm12
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm12
    movdqa %xmm12, %xmm1
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm3
    movdqa %xmm2, %xmm12
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm12
    movdqa %xmm12, %xmm3
    pshufb %xmm9, %xmm4
    pshufb %xmm9, %xmm5
    movdqa %xmm4, %xmm12
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm12
    movdqa %xmm12, %xmm5
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm7
    movdqa %xmm6, %xmm12
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm12
    movdqa %xmm12, %xmm7
    movdqu 64(%rdx), %xmm10
    movdqu 80(%rdx), %xmm11
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm10, %xmm4
    pxor %xmm11, %xmm5
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    movdqu 96(%rdx), %xmm10
    movdqu 112(%rdx), %xmm11
    aesdec %xmm10, %xmm0
    aesdec %xmm11, %xmm1
    aesdec %xmm10, %xmm2
    aesdec %xmm11, %xmm3
    aesdec %xmm10, %xmm4
    aesdec %xmm11, %xmm5
    aesdec %xmm10, %xmm6
    aesdec %xmm11, %xmm7
    aesenc %xmm8, %xmm0
    aesdec %xmm8, %xmm1
    aesenc %xmm8, %xmm2
    aesdec %xmm8, %xmm3
    aesenc %xmm8, %xmm4
    aesdec %xmm8, %xmm5
    aesenc %xmm8, %xmm6
    aesdec %xmm8, %xmm7
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm12
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm12
    movdqa %xmm12, %xmm1
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm3
    movdqa %xmm2, %xmm12
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm12
    movdqa %xmm12, %xmm3
    pshufb %xmm9, %xmm4
    pshufb %xmm9, %xmm5
    movdqa %xmm4, %xmm12
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm12
    movdqa %xmm12, %xmm5
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm7
    movdqa %xmm6, %xmm12
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm12
    movdqa %xmm12, %xmm7
    movdqu 128(%rdx), %xmm10
    movdqu 144(%rdx), %xmm11
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm10, %xmm4
    pxor %xmm11, %xmm5
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    movdqu 160(%rdx), %xmm10
    movdqu 176(%rdx), %xmm11
    aesdec %xmm10, %xmm0
    aesdec %xmm11, %xmm1
    aesdec %xmm10, %xmm2
    aesdec %xmm11, %xmm3
    aesdec %xmm10, %xmm4
    aesdec %xmm11, %xmm5
    aesdec %xmm10, %xmm6
    aesdec %xmm11, %xmm7
    aesenc %xmm8, %xmm0
    aesdec %xmm8, %xmm1
    aesenc %xmm8, %xmm2
    aesdec %xmm8, %xmm3
    aesenc %xmm8, %xmm4
    aesdec %xmm8, %xmm5
    aesenc %xmm8, %xmm6
    aesdec %xmm8, %xmm7
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm12
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm12
    movdqa %xmm12, %xmm1
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm3
    movdqa %xmm2, %xmm12
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm12
    movdqa %xmm12, %xmm3
    pshufb %xmm9, %xmm4
    pshufb %xmm9, %xmm5
    movdqa %xmm4, %xmm12
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm12
    movdqa %xmm12, %xmm5
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm7
    movdqa %xmm6, %xmm12
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm12
    movdqa %xmm12, %xmm7
    movdqu 192(%rdx), %xmm10
    movdqu 208(%rdx), %xmm11
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm10, %xmm4
    pxor %xmm11, %xmm5
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    movdqu 224(%rdx), %xmm10
    movdqu 240(%rdx), %xmm11
    aesdec %xmm10, %xmm0
    aesdec %xmm11, %xmm1
    aesdec %xmm10, %xmm2
    aesdec %xmm11, %xmm3
    aesdec %xmm10, %xmm4
    aesdec %xmm11, %xmm5
    aesdec %xmm10, %xmm6
    aesdec %xmm11, %xmm7
    aesenc %xmm8, %xmm0
    aesdec %xmm8, %xmm1
    aesenc %xmm8, %xmm2
    aesdec %xmm8, %xmm3
    aesenc %xmm8, %xmm4
    aesdec %xmm8, %xmm5
    aesenc %xmm8, %xmm6
    aesdec %xmm8, %xmm7
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm12
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm12
    movdqa %xmm12, %xmm1
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm3
    movdqa %xmm2, %xmm12
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm12
    movdqa %xmm12, %xmm3
    pshufb %xmm9, %xmm4
    pshufb %xmm9, %xmm5
    movdqa %xmm4, %xmm12
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm12
    movdqa %xmm12, %xmm5
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm7
    movdqa %xmm6, %xmm12
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm12
    movdqa %xmm12, %xmm7
    movdqu 256(%rdx), %xmm10
    movdqu 272(%rdx), %xmm11
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm10, %xmm4
    pxor %xmm11, %xmm5
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    movdqu 288(%rdx), %xmm10
    movdqu 304(%rdx), %xmm11
    aesdec %xmm10, %xmm0
    aesdec %xmm11, %xmm1
    aesdec %xmm10, %xmm2
    aesdec %xmm11, %xmm3
    aesdec %xmm10, %xmm4
    aesdec %xmm11, %xmm5
    aesdec %xmm10, %xmm6
    aesdec %xmm11, %xmm7
    aesenc %xmm8, %xmm0
    aesdec %xmm8, %xmm1
    aesenc %xmm8, %xmm2
    aesdec %xmm8, %xmm3
    aesenc %xmm8, %xmm4
    aesdec %xmm8, %xmm5
    aesenc %xmm8, %xmm6
    aesdec %xmm8, %xmm7
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm12
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm12
    movdqa %xmm12, %xmm1
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm3
    movdqa %xmm2, %xmm12
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm12
    movdqa %xmm12, %xmm3
    pshufb %xmm9, %xmm4
    pshufb %xmm9, %xmm5
    movdqa %xmm4, %xmm12
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm12
    movdqa %xmm12, %xmm5
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm7
    movdqa %xmm6, %xmm12
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm12
    movdqa %xmm12, %xmm7
    movdqu 320(%rdx), %xmm10
    movdqu 336(%rdx), %xmm11
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm10, %xmm4
    pxor %xmm11, %xmm5
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    movdqu 352(%rdx), %xmm10
    movdqu 368(%rdx), %xmm11
    aesdec %xmm10, %xmm0
    aesdec %xmm11, %xmm1
    aesdec %xmm10, %xmm2
    aesdec %xmm11, %xmm3
    aesdec %xmm10, %xmm4
    aesdec %xmm11, %xmm5
    aesdec %xmm10, %xmm6
    aesdec %xmm11, %xmm7
    movdqu 384(%rdx), %xmm10
    movdqu 400(%rdx), %xmm11
    aesenc %xmm10, %xmm0
    aesdec %xmm11, %xmm1
    movdqu %xmm0, 0(%rdi)
    movdqu %xmm1, 16(%rdi)
    aesenc %xmm10, %xmm2
    aesdec %xmm11, %xmm3
    movdqu %xmm2, 32(%rdi)
    movdqu %xmm3, 48(%rdi)
    aesenc %xmm10, %xmm4
    aesdec %xmm11, %xmm5
    movdqu %xmm4, 64(%rdi)
    movdqu %xmm5, 80(%rdi)
    aesenc %xmm10, %xmm6
    aesdec %xmm11, %xmm7
    movdqu %xmm6, 96(%rdi)
    movdqu %xmm7, 112(%rdi)
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
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $136, %rsp
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_encrypt_4blocks_asm)

AREION_FUNC_START(areion_asura_decrypt_4blocks_asm)
#if defined(_WIN64)
    subq $120, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movdqu %xmm6, 16(%rsp)
    movdqu %xmm7, 32(%rsp)
    movdqu %xmm8, 48(%rsp)
    movdqu %xmm9, 64(%rsp)
    movdqu %xmm10, 80(%rsp)
    movdqu %xmm11, 96(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
#endif
    movdqu 0(%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    movdqu 64(%rsi), %xmm4
    movdqu 80(%rsi), %xmm5
    movdqu 96(%rsi), %xmm6
    movdqu 112(%rsi), %xmm7
    pxor %xmm8, %xmm8
    movdqu 384(%rdx), %xmm9
    movdqu 400(%rdx), %xmm10
    pxor %xmm9, %xmm0
    pxor %xmm10, %xmm1
    pxor %xmm9, %xmm2
    pxor %xmm10, %xmm3
    pxor %xmm9, %xmm4
    pxor %xmm10, %xmm5
    pxor %xmm9, %xmm6
    pxor %xmm10, %xmm7
    movdqu 352(%rdx), %xmm9
    movdqu 368(%rdx), %xmm10
    aesdeclast %xmm8, %xmm10
    aesimc %xmm0, %xmm0
    aesdeclast %xmm8, %xmm1
    aesimc %xmm2, %xmm2
    aesdeclast %xmm8, %xmm3
    aesimc %xmm4, %xmm4
    aesdeclast %xmm8, %xmm5
    aesimc %xmm6, %xmm6
    aesdeclast %xmm8, %xmm7
    aesenc %xmm8, %xmm10
    aesdeclast %xmm9, %xmm0
    aesenc %xmm8, %xmm1
    aesdeclast %xmm9, %xmm2
    aesenc %xmm8, %xmm3
    aesdeclast %xmm9, %xmm4
    aesenc %xmm8, %xmm5
    aesdeclast %xmm9, %xmm6
    aesenc %xmm8, %xmm7
    aesdeclast %xmm8, %xmm0
    aesenc %xmm10, %xmm1
    aesdeclast %xmm8, %xmm2
    aesenc %xmm10, %xmm3
    aesdeclast %xmm8, %xmm4
    aesenc %xmm10, %xmm5
    aesdeclast %xmm8, %xmm6
    aesenc %xmm10, %xmm7
    movdqu 320(%rdx), %xmm9
    movdqu 336(%rdx), %xmm10
    aesenc %xmm8, %xmm0
    aesenc %xmm8, %xmm2
    aesenc %xmm8, %xmm4
    aesenc %xmm8, %xmm6
    aesenclast %xmm9, %xmm0
    aesenclast %xmm10, %xmm1
    aesenclast %xmm9, %xmm2
    aesenclast %xmm10, %xmm3
    aesenclast %xmm9, %xmm4
    aesenclast %xmm10, %xmm5
    aesenclast %xmm9, %xmm6
    aesenclast %xmm10, %xmm7
    movdqu 288(%rdx), %xmm9
    movdqu 304(%rdx), %xmm10
    aesdeclast %xmm8, %xmm10
    movdqa %xmm0, %xmm11
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm11
    movdqa %xmm11, %xmm1
    aesimc %xmm0, %xmm0
    aesdeclast %xmm8, %xmm1
    movdqa %xmm2, %xmm11
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm11
    movdqa %xmm11, %xmm3
    aesimc %xmm2, %xmm2
    aesdeclast %xmm8, %xmm3
    movdqa %xmm4, %xmm11
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm11
    movdqa %xmm11, %xmm5
    aesimc %xmm4, %xmm4
    aesdeclast %xmm8, %xmm5
    movdqa %xmm6, %xmm11
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm11
    movdqa %xmm11, %xmm7
    aesimc %xmm6, %xmm6
    aesdeclast %xmm8, %xmm7
    aesenc %xmm8, %xmm10
    aesdeclast %xmm9, %xmm0
    aesenc %xmm8, %xmm1
    aesdeclast %xmm9, %xmm2
    aesenc %xmm8, %xmm3
    aesdeclast %xmm9, %xmm4
    aesenc %xmm8, %xmm5
    aesdeclast %xmm9, %xmm6
    aesenc %xmm8, %xmm7
    aesdeclast %xmm8, %xmm0
    aesenc %xmm10, %xmm1
    aesdeclast %xmm8, %xmm2
    aesenc %xmm10, %xmm3
    aesdeclast %xmm8, %xmm4
    aesenc %xmm10, %xmm5
    aesdeclast %xmm8, %xmm6
    aesenc %xmm10, %xmm7
    movdqu 256(%rdx), %xmm9
    movdqu 272(%rdx), %xmm10
    aesenc %xmm8, %xmm0
    aesenc %xmm8, %xmm2
    aesenc %xmm8, %xmm4
    aesenc %xmm8, %xmm6
    aesenclast %xmm9, %xmm0
    aesenclast %xmm10, %xmm1
    aesenclast %xmm9, %xmm2
    aesenclast %xmm10, %xmm3
    aesenclast %xmm9, %xmm4
    aesenclast %xmm10, %xmm5
    aesenclast %xmm9, %xmm6
    aesenclast %xmm10, %xmm7
    movdqu 224(%rdx), %xmm9
    movdqu 240(%rdx), %xmm10
    aesdeclast %xmm8, %xmm10
    movdqa %xmm0, %xmm11
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm11
    movdqa %xmm11, %xmm1
    aesimc %xmm0, %xmm0
    aesdeclast %xmm8, %xmm1
    movdqa %xmm2, %xmm11
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm11
    movdqa %xmm11, %xmm3
    aesimc %xmm2, %xmm2
    aesdeclast %xmm8, %xmm3
    movdqa %xmm4, %xmm11
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm11
    movdqa %xmm11, %xmm5
    aesimc %xmm4, %xmm4
    aesdeclast %xmm8, %xmm5
    movdqa %xmm6, %xmm11
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm11
    movdqa %xmm11, %xmm7
    aesimc %xmm6, %xmm6
    aesdeclast %xmm8, %xmm7
    aesenc %xmm8, %xmm10
    aesdeclast %xmm9, %xmm0
    aesenc %xmm8, %xmm1
    aesdeclast %xmm9, %xmm2
    aesenc %xmm8, %xmm3
    aesdeclast %xmm9, %xmm4
    aesenc %xmm8, %xmm5
    aesdeclast %xmm9, %xmm6
    aesenc %xmm8, %xmm7
    aesdeclast %xmm8, %xmm0
    aesenc %xmm10, %xmm1
    aesdeclast %xmm8, %xmm2
    aesenc %xmm10, %xmm3
    aesdeclast %xmm8, %xmm4
    aesenc %xmm10, %xmm5
    aesdeclast %xmm8, %xmm6
    aesenc %xmm10, %xmm7
    movdqu 192(%rdx), %xmm9
    movdqu 208(%rdx), %xmm10
    aesenc %xmm8, %xmm0
    aesenc %xmm8, %xmm2
    aesenc %xmm8, %xmm4
    aesenc %xmm8, %xmm6
    aesenclast %xmm9, %xmm0
    aesenclast %xmm10, %xmm1
    aesenclast %xmm9, %xmm2
    aesenclast %xmm10, %xmm3
    aesenclast %xmm9, %xmm4
    aesenclast %xmm10, %xmm5
    aesenclast %xmm9, %xmm6
    aesenclast %xmm10, %xmm7
    movdqu 160(%rdx), %xmm9
    movdqu 176(%rdx), %xmm10
    aesdeclast %xmm8, %xmm10
    movdqa %xmm0, %xmm11
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm11
    movdqa %xmm11, %xmm1
    aesimc %xmm0, %xmm0
    aesdeclast %xmm8, %xmm1
    movdqa %xmm2, %xmm11
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm11
    movdqa %xmm11, %xmm3
    aesimc %xmm2, %xmm2
    aesdeclast %xmm8, %xmm3
    movdqa %xmm4, %xmm11
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm11
    movdqa %xmm11, %xmm5
    aesimc %xmm4, %xmm4
    aesdeclast %xmm8, %xmm5
    movdqa %xmm6, %xmm11
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm11
    movdqa %xmm11, %xmm7
    aesimc %xmm6, %xmm6
    aesdeclast %xmm8, %xmm7
    aesenc %xmm8, %xmm10
    aesdeclast %xmm9, %xmm0
    aesenc %xmm8, %xmm1
    aesdeclast %xmm9, %xmm2
    aesenc %xmm8, %xmm3
    aesdeclast %xmm9, %xmm4
    aesenc %xmm8, %xmm5
    aesdeclast %xmm9, %xmm6
    aesenc %xmm8, %xmm7
    aesdeclast %xmm8, %xmm0
    aesenc %xmm10, %xmm1
    aesdeclast %xmm8, %xmm2
    aesenc %xmm10, %xmm3
    aesdeclast %xmm8, %xmm4
    aesenc %xmm10, %xmm5
    aesdeclast %xmm8, %xmm6
    aesenc %xmm10, %xmm7
    movdqu 128(%rdx), %xmm9
    movdqu 144(%rdx), %xmm10
    aesenc %xmm8, %xmm0
    aesenc %xmm8, %xmm2
    aesenc %xmm8, %xmm4
    aesenc %xmm8, %xmm6
    aesenclast %xmm9, %xmm0
    aesenclast %xmm10, %xmm1
    aesenclast %xmm9, %xmm2
    aesenclast %xmm10, %xmm3
    aesenclast %xmm9, %xmm4
    aesenclast %xmm10, %xmm5
    aesenclast %xmm9, %xmm6
    aesenclast %xmm10, %xmm7
    movdqu 96(%rdx), %xmm9
    movdqu 112(%rdx), %xmm10
    aesdeclast %xmm8, %xmm10
    movdqa %xmm0, %xmm11
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm11
    movdqa %xmm11, %xmm1
    aesimc %xmm0, %xmm0
    aesdeclast %xmm8, %xmm1
    movdqa %xmm2, %xmm11
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm11
    movdqa %xmm11, %xmm3
    aesimc %xmm2, %xmm2
    aesdeclast %xmm8, %xmm3
    movdqa %xmm4, %xmm11
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm11
    movdqa %xmm11, %xmm5
    aesimc %xmm4, %xmm4
    aesdeclast %xmm8, %xmm5
    movdqa %xmm6, %xmm11
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm11
    movdqa %xmm11, %xmm7
    aesimc %xmm6, %xmm6
    aesdeclast %xmm8, %xmm7
    aesenc %xmm8, %xmm10
    aesdeclast %xmm9, %xmm0
    aesenc %xmm8, %xmm1
    aesdeclast %xmm9, %xmm2
    aesenc %xmm8, %xmm3
    aesdeclast %xmm9, %xmm4
    aesenc %xmm8, %xmm5
    aesdeclast %xmm9, %xmm6
    aesenc %xmm8, %xmm7
    aesdeclast %xmm8, %xmm0
    aesenc %xmm10, %xmm1
    aesdeclast %xmm8, %xmm2
    aesenc %xmm10, %xmm3
    aesdeclast %xmm8, %xmm4
    aesenc %xmm10, %xmm5
    aesdeclast %xmm8, %xmm6
    aesenc %xmm10, %xmm7
    movdqu 64(%rdx), %xmm9
    movdqu 80(%rdx), %xmm10
    aesenc %xmm8, %xmm0
    aesenc %xmm8, %xmm2
    aesenc %xmm8, %xmm4
    aesenc %xmm8, %xmm6
    aesenclast %xmm9, %xmm0
    aesenclast %xmm10, %xmm1
    aesenclast %xmm9, %xmm2
    aesenclast %xmm10, %xmm3
    aesenclast %xmm9, %xmm4
    aesenclast %xmm10, %xmm5
    aesenclast %xmm9, %xmm6
    aesenclast %xmm10, %xmm7
    movdqu 32(%rdx), %xmm9
    movdqu 48(%rdx), %xmm10
    aesdeclast %xmm8, %xmm10
    movdqa %xmm0, %xmm11
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm11
    movdqa %xmm11, %xmm1
    aesimc %xmm0, %xmm0
    aesdeclast %xmm8, %xmm1
    movdqa %xmm2, %xmm11
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm11
    movdqa %xmm11, %xmm3
    aesimc %xmm2, %xmm2
    aesdeclast %xmm8, %xmm3
    movdqa %xmm4, %xmm11
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm11
    movdqa %xmm11, %xmm5
    aesimc %xmm4, %xmm4
    aesdeclast %xmm8, %xmm5
    movdqa %xmm6, %xmm11
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm11
    movdqa %xmm11, %xmm7
    aesimc %xmm6, %xmm6
    aesdeclast %xmm8, %xmm7
    aesenc %xmm8, %xmm10
    aesdeclast %xmm9, %xmm0
    aesenc %xmm8, %xmm1
    aesdeclast %xmm9, %xmm2
    aesenc %xmm8, %xmm3
    aesdeclast %xmm9, %xmm4
    aesenc %xmm8, %xmm5
    aesdeclast %xmm9, %xmm6
    aesenc %xmm8, %xmm7
    aesdeclast %xmm8, %xmm0
    aesenc %xmm10, %xmm1
    aesdeclast %xmm8, %xmm2
    aesenc %xmm10, %xmm3
    aesdeclast %xmm8, %xmm4
    aesenc %xmm10, %xmm5
    aesdeclast %xmm8, %xmm6
    aesenc %xmm10, %xmm7
    movdqu 0(%rdx), %xmm9
    movdqu 16(%rdx), %xmm10
    aesenc %xmm8, %xmm0
    aesenc %xmm8, %xmm2
    aesenc %xmm8, %xmm4
    aesenc %xmm8, %xmm6
    aesenclast %xmm9, %xmm0
    aesenclast %xmm10, %xmm1
    aesenclast %xmm9, %xmm2
    aesenclast %xmm10, %xmm3
    aesenclast %xmm9, %xmm4
    aesenclast %xmm10, %xmm5
    aesenclast %xmm9, %xmm6
    aesenclast %xmm10, %xmm7
    movdqu %xmm0, 0(%rdi)
    movdqu %xmm1, 16(%rdi)
    movdqu %xmm2, 32(%rdi)
    movdqu %xmm3, 48(%rdi)
    movdqu %xmm4, 64(%rdi)
    movdqu %xmm5, 80(%rdi)
    movdqu %xmm6, 96(%rdi)
    movdqu %xmm7, 112(%rdi)
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
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $120, %rsp
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_decrypt_4blocks_asm)

AREION_FUNC_START(areion_asura_encrypt_4blocks_otf_asm)
#if defined(_WIN64)
    subq $184, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movdqu %xmm6, 16(%rsp)
    movdqu %xmm7, 32(%rsp)
    movdqu %xmm8, 48(%rsp)
    movdqu %xmm9, 64(%rsp)
    movdqu %xmm10, 80(%rsp)
    movdqu %xmm11, 96(%rsp)
    movdqu %xmm12, 112(%rsp)
    movdqu %xmm13, 128(%rsp)
    movdqu %xmm14, 144(%rsp)
    movdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu 0(%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    movdqu 64(%rsi), %xmm4
    movdqu 80(%rsi), %xmm5
    movdqu 96(%rsi), %xmm6
    movdqu 112(%rsi), %xmm7
    movdqu 0(%rdx), %xmm8
    movdqu 16(%rdx), %xmm9
    movdqu 0(%rcx), %xmm10
    movdqu 16(%rcx), %xmm11
    movdqu 32(%rcx), %xmm12
    movdqu 48(%rcx), %xmm13
    movdqa %xmm8, %xmm14
    pxor AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm7
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm7
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm0
    aesdec %xmm14, %xmm1
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm0, %xmm15
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm15
    movdqa %xmm15, %xmm1
    aesenc %xmm14, %xmm2
    aesdec %xmm14, %xmm3
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm15
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm15
    movdqa %xmm15, %xmm3
    aesenc %xmm14, %xmm4
    aesdec %xmm14, %xmm5
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5
    movdqa %xmm4, %xmm15
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm15
    movdqa %xmm15, %xmm5
    aesenc %xmm14, %xmm6
    aesdec %xmm14, %xmm7
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7
    movdqa %xmm6, %xmm15
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm15
    movdqa %xmm15, %xmm7
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm7
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm7
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm0
    aesdec %xmm14, %xmm1
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm0, %xmm15
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm15
    movdqa %xmm15, %xmm1
    aesenc %xmm14, %xmm2
    aesdec %xmm14, %xmm3
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm15
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm15
    movdqa %xmm15, %xmm3
    aesenc %xmm14, %xmm4
    aesdec %xmm14, %xmm5
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5
    movdqa %xmm4, %xmm15
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm15
    movdqa %xmm15, %xmm5
    aesenc %xmm14, %xmm6
    aesdec %xmm14, %xmm7
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7
    movdqa %xmm6, %xmm15
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm15
    movdqa %xmm15, %xmm7
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm7
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm7
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm0
    aesdec %xmm14, %xmm1
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm0, %xmm15
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm15
    movdqa %xmm15, %xmm1
    aesenc %xmm14, %xmm2
    aesdec %xmm14, %xmm3
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm15
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm15
    movdqa %xmm15, %xmm3
    aesenc %xmm14, %xmm4
    aesdec %xmm14, %xmm5
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5
    movdqa %xmm4, %xmm15
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm15
    movdqa %xmm15, %xmm5
    aesenc %xmm14, %xmm6
    aesdec %xmm14, %xmm7
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7
    movdqa %xmm6, %xmm15
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm15
    movdqa %xmm15, %xmm7
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm7
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm7
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm0
    aesdec %xmm14, %xmm1
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm0, %xmm15
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm15
    movdqa %xmm15, %xmm1
    aesenc %xmm14, %xmm2
    aesdec %xmm14, %xmm3
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm15
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm15
    movdqa %xmm15, %xmm3
    aesenc %xmm14, %xmm4
    aesdec %xmm14, %xmm5
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5
    movdqa %xmm4, %xmm15
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm15
    movdqa %xmm15, %xmm5
    aesenc %xmm14, %xmm6
    aesdec %xmm14, %xmm7
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7
    movdqa %xmm6, %xmm15
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm15
    movdqa %xmm15, %xmm7
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm7
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm7
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm0
    aesdec %xmm14, %xmm1
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm0, %xmm15
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm15
    movdqa %xmm15, %xmm1
    aesenc %xmm14, %xmm2
    aesdec %xmm14, %xmm3
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm15
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm15
    movdqa %xmm15, %xmm3
    aesenc %xmm14, %xmm4
    aesdec %xmm14, %xmm5
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5
    movdqa %xmm4, %xmm15
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm15
    movdqa %xmm15, %xmm5
    aesenc %xmm14, %xmm6
    aesdec %xmm14, %xmm7
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7
    movdqa %xmm6, %xmm15
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm15
    movdqa %xmm15, %xmm7
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm7
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm7
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesenc %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesenc %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesenc %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesenc %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm7
    movdqu %xmm0, 0(%rdi)
    movdqu %xmm1, 16(%rdi)
    movdqu %xmm2, 32(%rdi)
    movdqu %xmm3, 48(%rdi)
    movdqu %xmm4, 64(%rdi)
    movdqu %xmm5, 80(%rdi)
    movdqu %xmm6, 96(%rdi)
    movdqu %xmm7, 112(%rdi)
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
    pxor %xmm15, %xmm15
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
    movdqu 160(%rsp), %xmm15
    movq $0, 160(%rsp)
    movq $0, 168(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $184, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_encrypt_4blocks_otf_asm)

AREION_FUNC_START(areion_asura_decrypt_4blocks_otf_asm)
#if defined(_WIN64)
    subq $184, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movdqu %xmm6, 16(%rsp)
    movdqu %xmm7, 32(%rsp)
    movdqu %xmm8, 48(%rsp)
    movdqu %xmm9, 64(%rsp)
    movdqu %xmm10, 80(%rsp)
    movdqu %xmm11, 96(%rsp)
    movdqu %xmm12, 112(%rsp)
    movdqu %xmm13, 128(%rsp)
    movdqu %xmm14, 144(%rsp)
    movdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu 0(%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    movdqu 64(%rsi), %xmm4
    movdqu 80(%rsi), %xmm5
    movdqu 96(%rsi), %xmm6
    movdqu 112(%rsi), %xmm7
    movdqu 0(%rdx), %xmm8
    movdqu 16(%rdx), %xmm9
    movdqu 0(%rcx), %xmm10
    movdqu 16(%rcx), %xmm11
    movdqu 32(%rcx), %xmm12
    movdqu 48(%rcx), %xmm13
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    pxor %xmm14, %xmm14
    aesenc %xmm14, %xmm10
    aesenc %xmm14, %xmm11
    aesenc %xmm14, %xmm12
    aesenc %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm14, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm7
    pxor %xmm14, %xmm14
    aesimc %xmm10, %xmm10
    aesdeclast %xmm14, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm14, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm14, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm14, %xmm8
    pxor %xmm14, %xmm14
    movdqa %xmm9, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm14, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pxor %xmm14, %xmm14
    movdqa %xmm8, %xmm15
    pxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm10, %xmm15
    aesimc %xmm0, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm1
    aesenc %xmm14, %xmm1
    aesenc %xmm15, %xmm1
    aesdeclast %xmm14, %xmm0
    aesenc %xmm14, %xmm0
    movdqa %xmm8, %xmm15
    pxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm11, %xmm15
    aesimc %xmm2, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm3
    aesenc %xmm14, %xmm3
    aesenc %xmm15, %xmm3
    aesdeclast %xmm14, %xmm2
    aesenc %xmm14, %xmm2
    movdqa %xmm8, %xmm15
    pxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm12, %xmm15
    aesimc %xmm4, %xmm4
    aesdeclast %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm5
    aesenc %xmm14, %xmm5
    aesenc %xmm15, %xmm5
    aesdeclast %xmm14, %xmm4
    aesenc %xmm14, %xmm4
    movdqa %xmm8, %xmm15
    pxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm13, %xmm15
    aesimc %xmm6, %xmm6
    aesdeclast %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm7
    aesenc %xmm14, %xmm7
    aesenc %xmm15, %xmm7
    aesdeclast %xmm14, %xmm6
    aesenc %xmm14, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm14, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm14, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm14, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm14, %xmm8
    pxor %xmm14, %xmm14
    movdqa %xmm9, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm14, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesenclast %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesenclast %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesenclast %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesenclast %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesenclast %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesenclast %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesenclast %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesenclast %xmm15, %xmm7
    movdqa %xmm0, %xmm14
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    movdqa %xmm2, %xmm14
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    movdqa %xmm4, %xmm14
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    movdqa %xmm6, %xmm14
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    pxor %xmm14, %xmm14
    aesimc %xmm10, %xmm10
    aesdeclast %xmm14, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm14, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm14, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm14, %xmm8
    pxor %xmm14, %xmm14
    movdqa %xmm9, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm14, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pxor %xmm14, %xmm14
    movdqa %xmm8, %xmm15
    pxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm10, %xmm15
    aesimc %xmm0, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm1
    aesenc %xmm14, %xmm1
    aesenc %xmm15, %xmm1
    aesdeclast %xmm14, %xmm0
    aesenc %xmm14, %xmm0
    movdqa %xmm8, %xmm15
    pxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm11, %xmm15
    aesimc %xmm2, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm3
    aesenc %xmm14, %xmm3
    aesenc %xmm15, %xmm3
    aesdeclast %xmm14, %xmm2
    aesenc %xmm14, %xmm2
    movdqa %xmm8, %xmm15
    pxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm12, %xmm15
    aesimc %xmm4, %xmm4
    aesdeclast %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm5
    aesenc %xmm14, %xmm5
    aesenc %xmm15, %xmm5
    aesdeclast %xmm14, %xmm4
    aesenc %xmm14, %xmm4
    movdqa %xmm8, %xmm15
    pxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm13, %xmm15
    aesimc %xmm6, %xmm6
    aesdeclast %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm7
    aesenc %xmm14, %xmm7
    aesenc %xmm15, %xmm7
    aesdeclast %xmm14, %xmm6
    aesenc %xmm14, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm14, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm14, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm14, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm14, %xmm8
    pxor %xmm14, %xmm14
    movdqa %xmm9, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm14, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesenclast %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesenclast %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesenclast %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesenclast %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesenclast %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesenclast %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesenclast %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesenclast %xmm15, %xmm7
    movdqa %xmm0, %xmm14
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    movdqa %xmm2, %xmm14
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    movdqa %xmm4, %xmm14
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    movdqa %xmm6, %xmm14
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    pxor %xmm14, %xmm14
    aesimc %xmm10, %xmm10
    aesdeclast %xmm14, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm14, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm14, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm14, %xmm8
    pxor %xmm14, %xmm14
    movdqa %xmm9, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm14, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pxor %xmm14, %xmm14
    movdqa %xmm8, %xmm15
    pxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm10, %xmm15
    aesimc %xmm0, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm1
    aesenc %xmm14, %xmm1
    aesenc %xmm15, %xmm1
    aesdeclast %xmm14, %xmm0
    aesenc %xmm14, %xmm0
    movdqa %xmm8, %xmm15
    pxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm11, %xmm15
    aesimc %xmm2, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm3
    aesenc %xmm14, %xmm3
    aesenc %xmm15, %xmm3
    aesdeclast %xmm14, %xmm2
    aesenc %xmm14, %xmm2
    movdqa %xmm8, %xmm15
    pxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm12, %xmm15
    aesimc %xmm4, %xmm4
    aesdeclast %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm5
    aesenc %xmm14, %xmm5
    aesenc %xmm15, %xmm5
    aesdeclast %xmm14, %xmm4
    aesenc %xmm14, %xmm4
    movdqa %xmm8, %xmm15
    pxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm13, %xmm15
    aesimc %xmm6, %xmm6
    aesdeclast %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm7
    aesenc %xmm14, %xmm7
    aesenc %xmm15, %xmm7
    aesdeclast %xmm14, %xmm6
    aesenc %xmm14, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm14, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm14, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm14, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm14, %xmm8
    pxor %xmm14, %xmm14
    movdqa %xmm9, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm14, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesenclast %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesenclast %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesenclast %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesenclast %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesenclast %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesenclast %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesenclast %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesenclast %xmm15, %xmm7
    movdqa %xmm0, %xmm14
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    movdqa %xmm2, %xmm14
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    movdqa %xmm4, %xmm14
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    movdqa %xmm6, %xmm14
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    pxor %xmm14, %xmm14
    aesimc %xmm10, %xmm10
    aesdeclast %xmm14, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm14, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm14, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm14, %xmm8
    pxor %xmm14, %xmm14
    movdqa %xmm9, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm14, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pxor %xmm14, %xmm14
    movdqa %xmm8, %xmm15
    pxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm10, %xmm15
    aesimc %xmm0, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm1
    aesenc %xmm14, %xmm1
    aesenc %xmm15, %xmm1
    aesdeclast %xmm14, %xmm0
    aesenc %xmm14, %xmm0
    movdqa %xmm8, %xmm15
    pxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm11, %xmm15
    aesimc %xmm2, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm3
    aesenc %xmm14, %xmm3
    aesenc %xmm15, %xmm3
    aesdeclast %xmm14, %xmm2
    aesenc %xmm14, %xmm2
    movdqa %xmm8, %xmm15
    pxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm12, %xmm15
    aesimc %xmm4, %xmm4
    aesdeclast %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm5
    aesenc %xmm14, %xmm5
    aesenc %xmm15, %xmm5
    aesdeclast %xmm14, %xmm4
    aesenc %xmm14, %xmm4
    movdqa %xmm8, %xmm15
    pxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm13, %xmm15
    aesimc %xmm6, %xmm6
    aesdeclast %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm7
    aesenc %xmm14, %xmm7
    aesenc %xmm15, %xmm7
    aesdeclast %xmm14, %xmm6
    aesenc %xmm14, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm14, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm14, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm14, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm14, %xmm8
    pxor %xmm14, %xmm14
    movdqa %xmm9, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm14, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesenclast %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesenclast %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesenclast %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesenclast %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesenclast %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesenclast %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesenclast %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesenclast %xmm15, %xmm7
    movdqa %xmm0, %xmm14
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    movdqa %xmm2, %xmm14
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    movdqa %xmm4, %xmm14
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    movdqa %xmm6, %xmm14
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    pxor %xmm14, %xmm14
    aesimc %xmm10, %xmm10
    aesdeclast %xmm14, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm14, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm14, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm14, %xmm8
    pxor %xmm14, %xmm14
    movdqa %xmm9, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm14, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pxor %xmm14, %xmm14
    movdqa %xmm8, %xmm15
    pxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm10, %xmm15
    aesimc %xmm0, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm1
    aesenc %xmm14, %xmm1
    aesenc %xmm15, %xmm1
    aesdeclast %xmm14, %xmm0
    aesenc %xmm14, %xmm0
    movdqa %xmm8, %xmm15
    pxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm11, %xmm15
    aesimc %xmm2, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm3
    aesenc %xmm14, %xmm3
    aesenc %xmm15, %xmm3
    aesdeclast %xmm14, %xmm2
    aesenc %xmm14, %xmm2
    movdqa %xmm8, %xmm15
    pxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm12, %xmm15
    aesimc %xmm4, %xmm4
    aesdeclast %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm5
    aesenc %xmm14, %xmm5
    aesenc %xmm15, %xmm5
    aesdeclast %xmm14, %xmm4
    aesenc %xmm14, %xmm4
    movdqa %xmm8, %xmm15
    pxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm13, %xmm15
    aesimc %xmm6, %xmm6
    aesdeclast %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm7
    aesenc %xmm14, %xmm7
    aesenc %xmm15, %xmm7
    aesdeclast %xmm14, %xmm6
    aesenc %xmm14, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm14, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm14, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm14, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm14, %xmm8
    pxor %xmm14, %xmm14
    movdqa %xmm9, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm14, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesenclast %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesenclast %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesenclast %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesenclast %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesenclast %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesenclast %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesenclast %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesenclast %xmm15, %xmm7
    movdqa %xmm0, %xmm14
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    movdqa %xmm2, %xmm14
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    movdqa %xmm4, %xmm14
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    movdqa %xmm6, %xmm14
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    pxor %xmm14, %xmm14
    aesimc %xmm10, %xmm10
    aesdeclast %xmm14, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm14, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm14, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm14, %xmm8
    pxor %xmm14, %xmm14
    movdqa %xmm9, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm14, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    pxor %xmm14, %xmm14
    movdqa %xmm8, %xmm15
    pxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm10, %xmm15
    aesimc %xmm0, %xmm0
    aesdeclast %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm1
    aesenc %xmm14, %xmm1
    aesenc %xmm15, %xmm1
    aesdeclast %xmm14, %xmm0
    aesenc %xmm14, %xmm0
    movdqa %xmm8, %xmm15
    pxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm11, %xmm15
    aesimc %xmm2, %xmm2
    aesdeclast %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm3
    aesenc %xmm14, %xmm3
    aesenc %xmm15, %xmm3
    aesdeclast %xmm14, %xmm2
    aesenc %xmm14, %xmm2
    movdqa %xmm8, %xmm15
    pxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm12, %xmm15
    aesimc %xmm4, %xmm4
    aesdeclast %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm5
    aesenc %xmm14, %xmm5
    aesenc %xmm15, %xmm5
    aesdeclast %xmm14, %xmm4
    aesenc %xmm14, %xmm4
    movdqa %xmm8, %xmm15
    pxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm15
    pxor %xmm13, %xmm15
    aesimc %xmm6, %xmm6
    aesdeclast %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesdeclast %xmm14, %xmm15
    aesenc %xmm14, %xmm15
    aesdeclast %xmm14, %xmm7
    aesenc %xmm14, %xmm7
    aesenc %xmm15, %xmm7
    aesdeclast %xmm14, %xmm6
    aesenc %xmm14, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm14, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm14, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm14, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm14, %xmm13
    movdqa %xmm8, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm14, %xmm8
    pxor %xmm14, %xmm14
    movdqa %xmm9, %xmm15
    psllw $7, %xmm15
    pcmpgtb %xmm15, %xmm14
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm14, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm15
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm15, %xmm9
    movdqa %xmm8, %xmm14
    pxor AREION_SYM(asuraRoundConstants)(%rip), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesenclast %xmm15, %xmm0
    movdqa %xmm9, %xmm15
    pxor %xmm10, %xmm15
    aesenclast %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesenclast %xmm15, %xmm2
    movdqa %xmm9, %xmm15
    pxor %xmm11, %xmm15
    aesenclast %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesenclast %xmm15, %xmm4
    movdqa %xmm9, %xmm15
    pxor %xmm12, %xmm15
    aesenclast %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesenclast %xmm15, %xmm6
    movdqa %xmm9, %xmm15
    pxor %xmm13, %xmm15
    aesenclast %xmm15, %xmm7
    movdqu %xmm0, 0(%rdi)
    movdqu %xmm1, 16(%rdi)
    movdqu %xmm2, 32(%rdi)
    movdqu %xmm3, 48(%rdi)
    movdqu %xmm4, 64(%rdi)
    movdqu %xmm5, 80(%rdi)
    movdqu %xmm6, 96(%rdi)
    movdqu %xmm7, 112(%rdi)
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
    pxor %xmm15, %xmm15
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
    movdqu 160(%rsp), %xmm15
    movq $0, 160(%rsp)
    movq $0, 168(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $184, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_decrypt_4blocks_otf_asm)

AREION_FUNC_START(areion_asura_expand_tweakey_vex_asm)
#if defined(_WIN64)
    subq $24, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
#endif
    vmovdqu 0(%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 0(%rdx), %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm2, %xmm0, %xmm4
    vpxor AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm2, %xmm1, %xmm5
    vmovdqu %xmm4, 0(%rdi)
    vmovdqu %xmm5, 16(%rdi)
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm4
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm4
    vpcmpgtb %xmm1, %xmm3, %xmm5
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm5, %xmm5
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm4
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm2, %xmm1, %xmm5
    vmovdqu %xmm4, 32(%rdi)
    vmovdqu %xmm5, 48(%rdi)
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm4
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm4
    vpcmpgtb %xmm1, %xmm3, %xmm5
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm5, %xmm5
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm4
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm2, %xmm1, %xmm5
    vmovdqu %xmm4, 64(%rdi)
    vmovdqu %xmm5, 80(%rdi)
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm4
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm4
    vpcmpgtb %xmm1, %xmm3, %xmm5
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm5, %xmm5
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm4
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm2, %xmm1, %xmm5
    vmovdqu %xmm4, 96(%rdi)
    vmovdqu %xmm5, 112(%rdi)
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm4
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm4
    vpcmpgtb %xmm1, %xmm3, %xmm5
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm5, %xmm5
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm4
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm2, %xmm1, %xmm5
    vmovdqu %xmm4, 128(%rdi)
    vmovdqu %xmm5, 144(%rdi)
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm4
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm4
    vpcmpgtb %xmm1, %xmm3, %xmm5
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm5, %xmm5
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm4
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm2, %xmm1, %xmm5
    vmovdqu %xmm4, 160(%rdi)
    vmovdqu %xmm5, 176(%rdi)
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm4
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm4
    vpcmpgtb %xmm1, %xmm3, %xmm5
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm5, %xmm5
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm4
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm2, %xmm1, %xmm5
    vmovdqu %xmm4, 192(%rdi)
    vmovdqu %xmm5, 208(%rdi)
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm4
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm4
    vpcmpgtb %xmm1, %xmm3, %xmm5
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm5, %xmm5
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm4
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm2, %xmm1, %xmm5
    vmovdqu %xmm4, 224(%rdi)
    vmovdqu %xmm5, 240(%rdi)
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm4
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm4
    vpcmpgtb %xmm1, %xmm3, %xmm5
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm5, %xmm5
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm4
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm2, %xmm1, %xmm5
    vmovdqu %xmm4, 256(%rdi)
    vmovdqu %xmm5, 272(%rdi)
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm4
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm4
    vpcmpgtb %xmm1, %xmm3, %xmm5
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm5, %xmm5
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm4
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm2, %xmm1, %xmm5
    vmovdqu %xmm4, 288(%rdi)
    vmovdqu %xmm5, 304(%rdi)
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm4
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm4
    vpcmpgtb %xmm1, %xmm3, %xmm5
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm5, %xmm5
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm4
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm2, %xmm1, %xmm5
    vmovdqu %xmm4, 320(%rdi)
    vmovdqu %xmm5, 336(%rdi)
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm4
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm4
    vpcmpgtb %xmm1, %xmm3, %xmm5
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm5, %xmm5
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm4
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm2, %xmm1, %xmm5
    vmovdqu %xmm4, 352(%rdi)
    vmovdqu %xmm5, 368(%rdi)
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm4
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm4
    vpcmpgtb %xmm1, %xmm3, %xmm5
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm5, %xmm5
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm4
    vpxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm2, %xmm1, %xmm5
    vmovdqu %xmm4, 384(%rdi)
    vmovdqu %xmm5, 400(%rdi)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
#if defined(_WIN64)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $24, %rsp
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_expand_tweakey_vex_asm)

AREION_FUNC_START(areion_asura_encrypt_block_vex_asm)
#if defined(_WIN64)
    subq $24, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
#endif
    vmovdqu 0(%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vmovdqa 64+AREION_SYM(asuraConsts)(%rip), %xmm3
    vpxor 0(%rdx), %xmm0, %xmm0
    vpxor 16(%rdx), %xmm1, %xmm1
    vaesdec 32(%rdx), %xmm0, %xmm0
    vaesdec 48(%rdx), %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesdec %xmm2, %xmm1, %xmm1
    vpshufb %xmm3, %xmm0, %xmm4
    vpshufb %xmm3, %xmm1, %xmm5
    vpunpcklqdq %xmm5, %xmm4, %xmm0
    vpunpckhqdq %xmm5, %xmm4, %xmm1
    vpxor 64(%rdx), %xmm0, %xmm0
    vpxor 80(%rdx), %xmm1, %xmm1
    vaesdec 96(%rdx), %xmm0, %xmm0
    vaesdec 112(%rdx), %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesdec %xmm2, %xmm1, %xmm1
    vpshufb %xmm3, %xmm0, %xmm4
    vpshufb %xmm3, %xmm1, %xmm5
    vpunpcklqdq %xmm5, %xmm4, %xmm0
    vpunpckhqdq %xmm5, %xmm4, %xmm1
    vpxor 128(%rdx), %xmm0, %xmm0
    vpxor 144(%rdx), %xmm1, %xmm1
    vaesdec 160(%rdx), %xmm0, %xmm0
    vaesdec 176(%rdx), %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesdec %xmm2, %xmm1, %xmm1
    vpshufb %xmm3, %xmm0, %xmm4
    vpshufb %xmm3, %xmm1, %xmm5
    vpunpcklqdq %xmm5, %xmm4, %xmm0
    vpunpckhqdq %xmm5, %xmm4, %xmm1
    vpxor 192(%rdx), %xmm0, %xmm0
    vpxor 208(%rdx), %xmm1, %xmm1
    vaesdec 224(%rdx), %xmm0, %xmm0
    vaesdec 240(%rdx), %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesdec %xmm2, %xmm1, %xmm1
    vpshufb %xmm3, %xmm0, %xmm4
    vpshufb %xmm3, %xmm1, %xmm5
    vpunpcklqdq %xmm5, %xmm4, %xmm0
    vpunpckhqdq %xmm5, %xmm4, %xmm1
    vpxor 256(%rdx), %xmm0, %xmm0
    vpxor 272(%rdx), %xmm1, %xmm1
    vaesdec 288(%rdx), %xmm0, %xmm0
    vaesdec 304(%rdx), %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesdec %xmm2, %xmm1, %xmm1
    vpshufb %xmm3, %xmm0, %xmm4
    vpshufb %xmm3, %xmm1, %xmm5
    vpunpcklqdq %xmm5, %xmm4, %xmm0
    vpunpckhqdq %xmm5, %xmm4, %xmm1
    vpxor 320(%rdx), %xmm0, %xmm0
    vpxor 336(%rdx), %xmm1, %xmm1
    vaesdec 352(%rdx), %xmm0, %xmm0
    vaesdec 368(%rdx), %xmm1, %xmm1
    vaesenc 384(%rdx), %xmm0, %xmm0
    vaesdec 400(%rdx), %xmm1, %xmm1
    vmovdqu %xmm0, 0(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
#if defined(_WIN64)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $24, %rsp
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_encrypt_block_vex_asm)

AREION_FUNC_START(areion_asura_decrypt_block_vex_asm)
#if defined(_WIN64)
    subq $24, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
#endif
    vmovdqu 0(%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor 384(%rdx), %xmm0, %xmm0
    vpxor 400(%rdx), %xmm1, %xmm1
    vmovdqu 368(%rdx), %xmm4
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm2, %xmm1, %xmm1
    vaesdeclast %xmm2, %xmm4, %xmm4
    vaesdeclast 352(%rdx), %xmm0, %xmm0
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm2, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenclast 320(%rdx), %xmm0, %xmm0
    vaesenclast 336(%rdx), %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm3
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqu 304(%rdx), %xmm4
    vaesimc %xmm3, %xmm0
    vaesdeclast %xmm2, %xmm1, %xmm1
    vaesdeclast %xmm2, %xmm4, %xmm4
    vaesdeclast 288(%rdx), %xmm0, %xmm0
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm2, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenclast 256(%rdx), %xmm0, %xmm0
    vaesenclast 272(%rdx), %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm3
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqu 240(%rdx), %xmm4
    vaesimc %xmm3, %xmm0
    vaesdeclast %xmm2, %xmm1, %xmm1
    vaesdeclast %xmm2, %xmm4, %xmm4
    vaesdeclast 224(%rdx), %xmm0, %xmm0
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm2, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenclast 192(%rdx), %xmm0, %xmm0
    vaesenclast 208(%rdx), %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm3
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqu 176(%rdx), %xmm4
    vaesimc %xmm3, %xmm0
    vaesdeclast %xmm2, %xmm1, %xmm1
    vaesdeclast %xmm2, %xmm4, %xmm4
    vaesdeclast 160(%rdx), %xmm0, %xmm0
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm2, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenclast 128(%rdx), %xmm0, %xmm0
    vaesenclast 144(%rdx), %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm3
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqu 112(%rdx), %xmm4
    vaesimc %xmm3, %xmm0
    vaesdeclast %xmm2, %xmm1, %xmm1
    vaesdeclast %xmm2, %xmm4, %xmm4
    vaesdeclast 96(%rdx), %xmm0, %xmm0
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm2, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenclast 64(%rdx), %xmm0, %xmm0
    vaesenclast 80(%rdx), %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm3
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqu 48(%rdx), %xmm4
    vaesimc %xmm3, %xmm0
    vaesdeclast %xmm2, %xmm1, %xmm1
    vaesdeclast %xmm2, %xmm4, %xmm4
    vaesdeclast 32(%rdx), %xmm0, %xmm0
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm2, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenclast 0(%rdx), %xmm0, %xmm0
    vaesenclast 16(%rdx), %xmm1, %xmm1
    vmovdqu %xmm0, 0(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
#if defined(_WIN64)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $24, %rsp
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_decrypt_block_vex_asm)

AREION_FUNC_START(areion_asura_encrypt_block_otf_vex_asm)
#if defined(_WIN64)
    subq $88, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu 0(%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 0(%rdx), %xmm2
    vmovdqu 16(%rdx), %xmm3
    vmovdqu 0(%rcx), %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm4, %xmm2, %xmm6
    vpxor AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vpxor %xmm6, %xmm0, %xmm0
    vpxor %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm4, %xmm4
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm2
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpcmpgtb %xmm2, %xmm5, %xmm6
    vpcmpgtb %xmm3, %xmm5, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm2, %xmm2, %xmm2
    vpaddb %xmm3, %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vaesdec %xmm6, %xmm0, %xmm0
    vaesdec %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0, %xmm8
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm9
    vpunpcklqdq %xmm9, %xmm8, %xmm0
    vpunpckhqdq %xmm9, %xmm8, %xmm1
    vaesenc %xmm5, %xmm4, %xmm4
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm2
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpcmpgtb %xmm2, %xmm5, %xmm6
    vpcmpgtb %xmm3, %xmm5, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm2, %xmm2, %xmm2
    vpaddb %xmm3, %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vpxor %xmm6, %xmm0, %xmm0
    vpxor %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm4, %xmm4
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm2
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpcmpgtb %xmm2, %xmm5, %xmm6
    vpcmpgtb %xmm3, %xmm5, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm2, %xmm2, %xmm2
    vpaddb %xmm3, %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vaesdec %xmm6, %xmm0, %xmm0
    vaesdec %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0, %xmm8
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm9
    vpunpcklqdq %xmm9, %xmm8, %xmm0
    vpunpckhqdq %xmm9, %xmm8, %xmm1
    vaesenc %xmm5, %xmm4, %xmm4
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm2
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpcmpgtb %xmm2, %xmm5, %xmm6
    vpcmpgtb %xmm3, %xmm5, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm2, %xmm2, %xmm2
    vpaddb %xmm3, %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vpxor %xmm6, %xmm0, %xmm0
    vpxor %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm4, %xmm4
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm2
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpcmpgtb %xmm2, %xmm5, %xmm6
    vpcmpgtb %xmm3, %xmm5, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm2, %xmm2, %xmm2
    vpaddb %xmm3, %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vaesdec %xmm6, %xmm0, %xmm0
    vaesdec %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0, %xmm8
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm9
    vpunpcklqdq %xmm9, %xmm8, %xmm0
    vpunpckhqdq %xmm9, %xmm8, %xmm1
    vaesenc %xmm5, %xmm4, %xmm4
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm2
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpcmpgtb %xmm2, %xmm5, %xmm6
    vpcmpgtb %xmm3, %xmm5, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm2, %xmm2, %xmm2
    vpaddb %xmm3, %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vpxor %xmm6, %xmm0, %xmm0
    vpxor %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm4, %xmm4
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm2
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpcmpgtb %xmm2, %xmm5, %xmm6
    vpcmpgtb %xmm3, %xmm5, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm2, %xmm2, %xmm2
    vpaddb %xmm3, %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vaesdec %xmm6, %xmm0, %xmm0
    vaesdec %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0, %xmm8
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm9
    vpunpcklqdq %xmm9, %xmm8, %xmm0
    vpunpckhqdq %xmm9, %xmm8, %xmm1
    vaesenc %xmm5, %xmm4, %xmm4
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm2
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpcmpgtb %xmm2, %xmm5, %xmm6
    vpcmpgtb %xmm3, %xmm5, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm2, %xmm2, %xmm2
    vpaddb %xmm3, %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vpxor %xmm6, %xmm0, %xmm0
    vpxor %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm4, %xmm4
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm2
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpcmpgtb %xmm2, %xmm5, %xmm6
    vpcmpgtb %xmm3, %xmm5, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm2, %xmm2, %xmm2
    vpaddb %xmm3, %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vaesdec %xmm6, %xmm0, %xmm0
    vaesdec %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0, %xmm8
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm9
    vpunpcklqdq %xmm9, %xmm8, %xmm0
    vpunpckhqdq %xmm9, %xmm8, %xmm1
    vaesenc %xmm5, %xmm4, %xmm4
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm2
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpcmpgtb %xmm2, %xmm5, %xmm6
    vpcmpgtb %xmm3, %xmm5, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm2, %xmm2, %xmm2
    vpaddb %xmm3, %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vpxor %xmm6, %xmm0, %xmm0
    vpxor %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm4, %xmm4
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm2
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpcmpgtb %xmm2, %xmm5, %xmm6
    vpcmpgtb %xmm3, %xmm5, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm2, %xmm2, %xmm2
    vpaddb %xmm3, %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vaesdec %xmm6, %xmm0, %xmm0
    vaesdec %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm4, %xmm4
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm2
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpcmpgtb %xmm2, %xmm5, %xmm6
    vpcmpgtb %xmm3, %xmm5, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm2, %xmm2, %xmm2
    vpaddb %xmm3, %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vaesenc %xmm6, %xmm0, %xmm0
    vaesdec %xmm7, %xmm1, %xmm1
    vmovdqu %xmm0, 0(%rdi)
    vmovdqu %xmm1, 16(%rdi)
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
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $88, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_encrypt_block_otf_vex_asm)

AREION_FUNC_START(areion_asura_decrypt_block_otf_vex_asm)
#if defined(_WIN64)
    subq $184, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    vmovdqu %xmm11, 96(%rsp)
    vmovdqu %xmm12, 112(%rsp)
    vmovdqu %xmm13, 128(%rsp)
    vmovdqu %xmm14, 144(%rsp)
    vmovdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu 0(%rdx), %xmm0
    vmovdqu 16(%rdx), %xmm1
    vmovdqu 0(%rcx), %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm2, %xmm0, %xmm4
    vpxor AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm2, %xmm1, %xmm15
    vinsertf128 $1, %xmm15, %ymm4, %ymm4
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm15
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm0, %xmm0, %xmm0
    vpxor %xmm15, %xmm0, %xmm0
    vpcmpgtb %xmm1, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm5
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm5, %xmm5
    vpxor %xmm2, %xmm1, %xmm15
    vaesdeclast %xmm3, %xmm15, %xmm15
    vaesenc %xmm3, %xmm15, %xmm15
    vinsertf128 $1, %xmm15, %ymm5, %ymm5
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm15
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm0, %xmm0, %xmm0
    vpxor %xmm15, %xmm0, %xmm0
    vpcmpgtb %xmm1, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm6
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm2, %xmm1, %xmm15
    vinsertf128 $1, %xmm15, %ymm6, %ymm6
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm15
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm0, %xmm0, %xmm0
    vpxor %xmm15, %xmm0, %xmm0
    vpcmpgtb %xmm1, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm7
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm7, %xmm7
    vpxor %xmm2, %xmm1, %xmm15
    vaesdeclast %xmm3, %xmm15, %xmm15
    vaesenc %xmm3, %xmm15, %xmm15
    vinsertf128 $1, %xmm15, %ymm7, %ymm7
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm15
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm0, %xmm0, %xmm0
    vpxor %xmm15, %xmm0, %xmm0
    vpcmpgtb %xmm1, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm8
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm8
    vpxor %xmm2, %xmm1, %xmm15
    vinsertf128 $1, %xmm15, %ymm8, %ymm8
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm15
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm0, %xmm0, %xmm0
    vpxor %xmm15, %xmm0, %xmm0
    vpcmpgtb %xmm1, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm9
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm9, %xmm9
    vpxor %xmm2, %xmm1, %xmm15
    vaesdeclast %xmm3, %xmm15, %xmm15
    vaesenc %xmm3, %xmm15, %xmm15
    vinsertf128 $1, %xmm15, %ymm9, %ymm9
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm15
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm0, %xmm0, %xmm0
    vpxor %xmm15, %xmm0, %xmm0
    vpcmpgtb %xmm1, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm10
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm10, %xmm10
    vpxor %xmm2, %xmm1, %xmm15
    vinsertf128 $1, %xmm15, %ymm10, %ymm10
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm15
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm0, %xmm0, %xmm0
    vpxor %xmm15, %xmm0, %xmm0
    vpcmpgtb %xmm1, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm11
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm11, %xmm11
    vpxor %xmm2, %xmm1, %xmm15
    vaesdeclast %xmm3, %xmm15, %xmm15
    vaesenc %xmm3, %xmm15, %xmm15
    vinsertf128 $1, %xmm15, %ymm11, %ymm11
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm15
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm0, %xmm0, %xmm0
    vpxor %xmm15, %xmm0, %xmm0
    vpcmpgtb %xmm1, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm12
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm2, %xmm1, %xmm15
    vinsertf128 $1, %xmm15, %ymm12, %ymm12
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm15
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm0, %xmm0, %xmm0
    vpxor %xmm15, %xmm0, %xmm0
    vpcmpgtb %xmm1, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm13
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm13, %xmm13
    vpxor %xmm2, %xmm1, %xmm15
    vaesdeclast %xmm3, %xmm15, %xmm15
    vaesenc %xmm3, %xmm15, %xmm15
    vinsertf128 $1, %xmm15, %ymm13, %ymm13
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm15
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm0, %xmm0, %xmm0
    vpxor %xmm15, %xmm0, %xmm0
    vpcmpgtb %xmm1, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm2, %xmm0, %xmm14
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm14, %xmm14
    vpxor %xmm2, %xmm1, %xmm15
    vinsertf128 $1, %xmm15, %ymm14, %ymm14
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm15
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm0, %xmm0, %xmm0
    vpxor %xmm15, %xmm0, %xmm0
    vpcmpgtb %xmm1, %xmm3, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm2, %xmm1, %xmm15
    vaesdeclast %xmm3, %xmm15, %xmm15
    vaesenc %xmm3, %xmm15, %xmm15
    vpxor %xmm2, %xmm0, %xmm3
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm3, %xmm3
    vinsertf128 $1, %xmm15, %ymm3, %ymm15
    vpxor %xmm3, %xmm3, %xmm3
    vaesenc %xmm3, %xmm2, %xmm2
    vpblendw $0xcc, %xmm1, %xmm0, %xmm3
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpxor %xmm3, %xmm3, %xmm3
    vpcmpgtb %xmm0, %xmm3, %xmm3
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpaddb %xmm0, %xmm0, %xmm0
    vpxor %xmm3, %xmm0, %xmm0
    vpxor %xmm3, %xmm3, %xmm3
    vpcmpgtb %xmm1, %xmm3, %xmm3
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm1, %xmm1
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm2, %xmm0, %xmm0
    vpxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm0, %xmm0
    vpxor %xmm2, %xmm1, %xmm1
    vpxor 0(%rsi), %xmm0, %xmm0
    vpxor 16(%rsi), %xmm1, %xmm1
    vextractf128 $1, %ymm15, %xmm2
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm3, %xmm1, %xmm1
    vaesdeclast %xmm15, %xmm0, %xmm0
    vaesenc %xmm3, %xmm1, %xmm1
    vaesdeclast %xmm3, %xmm0, %xmm0
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm3, %xmm0, %xmm0
    vextractf128 $1, %ymm14, %xmm2
    vaesenclast %xmm14, %xmm0, %xmm0
    vaesenclast %xmm2, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm2
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm2, %xmm0
    vextractf128 $1, %ymm13, %xmm2
    vaesdeclast %xmm3, %xmm1, %xmm1
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesenc %xmm3, %xmm1, %xmm1
    vaesdeclast %xmm3, %xmm0, %xmm0
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm3, %xmm0, %xmm0
    vextractf128 $1, %ymm12, %xmm2
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm2, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm2
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm2, %xmm0
    vextractf128 $1, %ymm11, %xmm2
    vaesdeclast %xmm3, %xmm1, %xmm1
    vaesdeclast %xmm11, %xmm0, %xmm0
    vaesenc %xmm3, %xmm1, %xmm1
    vaesdeclast %xmm3, %xmm0, %xmm0
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm3, %xmm0, %xmm0
    vextractf128 $1, %ymm10, %xmm2
    vaesenclast %xmm10, %xmm0, %xmm0
    vaesenclast %xmm2, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm2
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm2, %xmm0
    vextractf128 $1, %ymm9, %xmm2
    vaesdeclast %xmm3, %xmm1, %xmm1
    vaesdeclast %xmm9, %xmm0, %xmm0
    vaesenc %xmm3, %xmm1, %xmm1
    vaesdeclast %xmm3, %xmm0, %xmm0
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm3, %xmm0, %xmm0
    vextractf128 $1, %ymm8, %xmm2
    vaesenclast %xmm8, %xmm0, %xmm0
    vaesenclast %xmm2, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm2
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm2, %xmm0
    vextractf128 $1, %ymm7, %xmm2
    vaesdeclast %xmm3, %xmm1, %xmm1
    vaesdeclast %xmm7, %xmm0, %xmm0
    vaesenc %xmm3, %xmm1, %xmm1
    vaesdeclast %xmm3, %xmm0, %xmm0
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm3, %xmm0, %xmm0
    vextractf128 $1, %ymm6, %xmm2
    vaesenclast %xmm6, %xmm0, %xmm0
    vaesenclast %xmm2, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm2
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm2, %xmm0
    vextractf128 $1, %ymm5, %xmm2
    vaesdeclast %xmm3, %xmm1, %xmm1
    vaesdeclast %xmm5, %xmm0, %xmm0
    vaesenc %xmm3, %xmm1, %xmm1
    vaesdeclast %xmm3, %xmm0, %xmm0
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm3, %xmm0, %xmm0
    vextractf128 $1, %ymm4, %xmm2
    vaesenclast %xmm4, %xmm0, %xmm0
    vaesenclast %xmm2, %xmm1, %xmm1
    vmovdqu %xmm0, 0(%rdi)
    vmovdqu %xmm1, 16(%rdi)
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
    vpxor %xmm15, %xmm15, %xmm15
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
    vmovdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    vmovdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    vmovdqu 112(%rsp), %xmm12
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    vmovdqu 128(%rsp), %xmm13
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    vmovdqu 144(%rsp), %xmm14
    movq $0, 144(%rsp)
    movq $0, 152(%rsp)
    vmovdqu 160(%rsp), %xmm15
    movq $0, 160(%rsp)
    movq $0, 168(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $184, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion_asura_decrypt_block_otf_vex_asm)

AREION_FUNC_START(areion_asura_encrypt_4blocks_vex_asm)
#if defined(_WIN64)
    subq $152, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    vmovdqu %xmm11, 96(%rsp)
    vmovdqu %xmm12, 112(%rsp)
    vmovdqu %xmm13, 128(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
#endif
    vmovdqu 0(%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vmovdqu 64(%rsi), %xmm4
    vmovdqu 80(%rsi), %xmm5
    vmovdqu 96(%rsi), %xmm6
    vmovdqu 112(%rsi), %xmm7
    vpxor %xmm8, %xmm8, %xmm8
    vmovdqa 64+AREION_SYM(asuraConsts)(%rip), %xmm9
    vmovdqu 0(%rdx), %xmm10
    vmovdqu 16(%rdx), %xmm11
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm10, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm10, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    vmovdqu 32(%rdx), %xmm10
    vmovdqu 48(%rdx), %xmm11
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vaesenc %xmm8, %xmm0, %xmm0
    vaesdec %xmm8, %xmm1, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesdec %xmm8, %xmm3, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesdec %xmm8, %xmm5, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesdec %xmm8, %xmm7, %xmm7
    vpshufb %xmm9, %xmm0, %xmm12
    vpshufb %xmm9, %xmm1, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm0
    vpunpckhqdq %xmm13, %xmm12, %xmm1
    vpshufb %xmm9, %xmm2, %xmm12
    vpshufb %xmm9, %xmm3, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm2
    vpunpckhqdq %xmm13, %xmm12, %xmm3
    vpshufb %xmm9, %xmm4, %xmm12
    vpshufb %xmm9, %xmm5, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm4
    vpunpckhqdq %xmm13, %xmm12, %xmm5
    vpshufb %xmm9, %xmm6, %xmm12
    vpshufb %xmm9, %xmm7, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm6
    vpunpckhqdq %xmm13, %xmm12, %xmm7
    vmovdqu 64(%rdx), %xmm10
    vmovdqu 80(%rdx), %xmm11
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm10, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm10, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    vmovdqu 96(%rdx), %xmm10
    vmovdqu 112(%rdx), %xmm11
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vaesenc %xmm8, %xmm0, %xmm0
    vaesdec %xmm8, %xmm1, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesdec %xmm8, %xmm3, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesdec %xmm8, %xmm5, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesdec %xmm8, %xmm7, %xmm7
    vpshufb %xmm9, %xmm0, %xmm12
    vpshufb %xmm9, %xmm1, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm0
    vpunpckhqdq %xmm13, %xmm12, %xmm1
    vpshufb %xmm9, %xmm2, %xmm12
    vpshufb %xmm9, %xmm3, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm2
    vpunpckhqdq %xmm13, %xmm12, %xmm3
    vpshufb %xmm9, %xmm4, %xmm12
    vpshufb %xmm9, %xmm5, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm4
    vpunpckhqdq %xmm13, %xmm12, %xmm5
    vpshufb %xmm9, %xmm6, %xmm12
    vpshufb %xmm9, %xmm7, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm6
    vpunpckhqdq %xmm13, %xmm12, %xmm7
    vmovdqu 128(%rdx), %xmm10
    vmovdqu 144(%rdx), %xmm11
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm10, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm10, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    vmovdqu 160(%rdx), %xmm10
    vmovdqu 176(%rdx), %xmm11
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vaesenc %xmm8, %xmm0, %xmm0
    vaesdec %xmm8, %xmm1, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesdec %xmm8, %xmm3, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesdec %xmm8, %xmm5, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesdec %xmm8, %xmm7, %xmm7
    vpshufb %xmm9, %xmm0, %xmm12
    vpshufb %xmm9, %xmm1, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm0
    vpunpckhqdq %xmm13, %xmm12, %xmm1
    vpshufb %xmm9, %xmm2, %xmm12
    vpshufb %xmm9, %xmm3, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm2
    vpunpckhqdq %xmm13, %xmm12, %xmm3
    vpshufb %xmm9, %xmm4, %xmm12
    vpshufb %xmm9, %xmm5, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm4
    vpunpckhqdq %xmm13, %xmm12, %xmm5
    vpshufb %xmm9, %xmm6, %xmm12
    vpshufb %xmm9, %xmm7, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm6
    vpunpckhqdq %xmm13, %xmm12, %xmm7
    vmovdqu 192(%rdx), %xmm10
    vmovdqu 208(%rdx), %xmm11
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm10, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm10, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    vmovdqu 224(%rdx), %xmm10
    vmovdqu 240(%rdx), %xmm11
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vaesenc %xmm8, %xmm0, %xmm0
    vaesdec %xmm8, %xmm1, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesdec %xmm8, %xmm3, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesdec %xmm8, %xmm5, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesdec %xmm8, %xmm7, %xmm7
    vpshufb %xmm9, %xmm0, %xmm12
    vpshufb %xmm9, %xmm1, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm0
    vpunpckhqdq %xmm13, %xmm12, %xmm1
    vpshufb %xmm9, %xmm2, %xmm12
    vpshufb %xmm9, %xmm3, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm2
    vpunpckhqdq %xmm13, %xmm12, %xmm3
    vpshufb %xmm9, %xmm4, %xmm12
    vpshufb %xmm9, %xmm5, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm4
    vpunpckhqdq %xmm13, %xmm12, %xmm5
    vpshufb %xmm9, %xmm6, %xmm12
    vpshufb %xmm9, %xmm7, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm6
    vpunpckhqdq %xmm13, %xmm12, %xmm7
    vmovdqu 256(%rdx), %xmm10
    vmovdqu 272(%rdx), %xmm11
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm10, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm10, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    vmovdqu 288(%rdx), %xmm10
    vmovdqu 304(%rdx), %xmm11
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vaesenc %xmm8, %xmm0, %xmm0
    vaesdec %xmm8, %xmm1, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesdec %xmm8, %xmm3, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesdec %xmm8, %xmm5, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesdec %xmm8, %xmm7, %xmm7
    vpshufb %xmm9, %xmm0, %xmm12
    vpshufb %xmm9, %xmm1, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm0
    vpunpckhqdq %xmm13, %xmm12, %xmm1
    vpshufb %xmm9, %xmm2, %xmm12
    vpshufb %xmm9, %xmm3, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm2
    vpunpckhqdq %xmm13, %xmm12, %xmm3
    vpshufb %xmm9, %xmm4, %xmm12
    vpshufb %xmm9, %xmm5, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm4
    vpunpckhqdq %xmm13, %xmm12, %xmm5
    vpshufb %xmm9, %xmm6, %xmm12
    vpshufb %xmm9, %xmm7, %xmm13
    vpunpcklqdq %xmm13, %xmm12, %xmm6
    vpunpckhqdq %xmm13, %xmm12, %xmm7
    vmovdqu 320(%rdx), %xmm10
    vmovdqu 336(%rdx), %xmm11
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm10, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm10, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    vmovdqu 352(%rdx), %xmm10
    vmovdqu 368(%rdx), %xmm11
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vmovdqu 384(%rdx), %xmm10
    vmovdqu 400(%rdx), %xmm11
    vaesenc %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vmovdqu %xmm0, 0(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vaesenc %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vmovdqu %xmm2, 32(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vaesenc %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vmovdqu %xmm4, 64(%rdi)
    vmovdqu %xmm5, 80(%rdi)
    vaesenc %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vmovdqu %xmm6, 96(%rdi)
    vmovdqu %xmm7, 112(%rdi)
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
    vmovdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    vmovdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    vmovdqu 112(%rsp), %xmm12
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    vmovdqu 128(%rsp), %xmm13
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $152, %rsp
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_encrypt_4blocks_vex_asm)

AREION_FUNC_START(areion_asura_decrypt_4blocks_vex_asm)
#if defined(_WIN64)
    subq $120, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    vmovdqu %xmm11, 96(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
#endif
    vmovdqu 0(%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vmovdqu 64(%rsi), %xmm4
    vmovdqu 80(%rsi), %xmm5
    vmovdqu 96(%rsi), %xmm6
    vmovdqu 112(%rsi), %xmm7
    vpxor %xmm8, %xmm8, %xmm8
    vmovdqu 384(%rdx), %xmm9
    vmovdqu 400(%rdx), %xmm10
    vpxor %xmm9, %xmm0, %xmm0
    vpxor %xmm10, %xmm1, %xmm1
    vpxor %xmm9, %xmm2, %xmm2
    vpxor %xmm10, %xmm3, %xmm3
    vpxor %xmm9, %xmm4, %xmm4
    vpxor %xmm10, %xmm5, %xmm5
    vpxor %xmm9, %xmm6, %xmm6
    vpxor %xmm10, %xmm7, %xmm7
    vmovdqu 352(%rdx), %xmm9
    vmovdqu 368(%rdx), %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm8, %xmm1, %xmm1
    vaesimc %xmm2, %xmm2
    vaesdeclast %xmm8, %xmm3, %xmm3
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm8, %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm8, %xmm7, %xmm7
    vaesenc %xmm8, %xmm10, %xmm10
    vaesdeclast %xmm9, %xmm0, %xmm0
    vaesenc %xmm8, %xmm1, %xmm1
    vaesdeclast %xmm9, %xmm2, %xmm2
    vaesenc %xmm8, %xmm3, %xmm3
    vaesdeclast %xmm9, %xmm4, %xmm4
    vaesenc %xmm8, %xmm5, %xmm5
    vaesdeclast %xmm9, %xmm6, %xmm6
    vaesenc %xmm8, %xmm7, %xmm7
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesenc %xmm10, %xmm1, %xmm1
    vaesdeclast %xmm8, %xmm2, %xmm2
    vaesenc %xmm10, %xmm3, %xmm3
    vaesdeclast %xmm8, %xmm4, %xmm4
    vaesenc %xmm10, %xmm5, %xmm5
    vaesdeclast %xmm8, %xmm6, %xmm6
    vaesenc %xmm10, %xmm7, %xmm7
    vmovdqu 320(%rdx), %xmm9
    vmovdqu 336(%rdx), %xmm10
    vaesenc %xmm8, %xmm0, %xmm0
    vaesenc %xmm8, %xmm2, %xmm2
    vaesenc %xmm8, %xmm4, %xmm4
    vaesenc %xmm8, %xmm6, %xmm6
    vaesenclast %xmm9, %xmm0, %xmm0
    vaesenclast %xmm10, %xmm1, %xmm1
    vaesenclast %xmm9, %xmm2, %xmm2
    vaesenclast %xmm10, %xmm3, %xmm3
    vaesenclast %xmm9, %xmm4, %xmm4
    vaesenclast %xmm10, %xmm5, %xmm5
    vaesenclast %xmm9, %xmm6, %xmm6
    vaesenclast %xmm10, %xmm7, %xmm7
    vmovdqu 288(%rdx), %xmm9
    vmovdqu 304(%rdx), %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vpunpcklbw %xmm1, %xmm0, %xmm11
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm11, %xmm0
    vaesdeclast %xmm8, %xmm1, %xmm1
    vpunpcklbw %xmm3, %xmm2, %xmm11
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm11, %xmm2
    vaesdeclast %xmm8, %xmm3, %xmm3
    vpunpcklbw %xmm5, %xmm4, %xmm11
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm11, %xmm4
    vaesdeclast %xmm8, %xmm5, %xmm5
    vpunpcklbw %xmm7, %xmm6, %xmm11
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm11, %xmm6
    vaesdeclast %xmm8, %xmm7, %xmm7
    vaesenc %xmm8, %xmm10, %xmm10
    vaesdeclast %xmm9, %xmm0, %xmm0
    vaesenc %xmm8, %xmm1, %xmm1
    vaesdeclast %xmm9, %xmm2, %xmm2
    vaesenc %xmm8, %xmm3, %xmm3
    vaesdeclast %xmm9, %xmm4, %xmm4
    vaesenc %xmm8, %xmm5, %xmm5
    vaesdeclast %xmm9, %xmm6, %xmm6
    vaesenc %xmm8, %xmm7, %xmm7
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesenc %xmm10, %xmm1, %xmm1
    vaesdeclast %xmm8, %xmm2, %xmm2
    vaesenc %xmm10, %xmm3, %xmm3
    vaesdeclast %xmm8, %xmm4, %xmm4
    vaesenc %xmm10, %xmm5, %xmm5
    vaesdeclast %xmm8, %xmm6, %xmm6
    vaesenc %xmm10, %xmm7, %xmm7
    vmovdqu 256(%rdx), %xmm9
    vmovdqu 272(%rdx), %xmm10
    vaesenc %xmm8, %xmm0, %xmm0
    vaesenc %xmm8, %xmm2, %xmm2
    vaesenc %xmm8, %xmm4, %xmm4
    vaesenc %xmm8, %xmm6, %xmm6
    vaesenclast %xmm9, %xmm0, %xmm0
    vaesenclast %xmm10, %xmm1, %xmm1
    vaesenclast %xmm9, %xmm2, %xmm2
    vaesenclast %xmm10, %xmm3, %xmm3
    vaesenclast %xmm9, %xmm4, %xmm4
    vaesenclast %xmm10, %xmm5, %xmm5
    vaesenclast %xmm9, %xmm6, %xmm6
    vaesenclast %xmm10, %xmm7, %xmm7
    vmovdqu 224(%rdx), %xmm9
    vmovdqu 240(%rdx), %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vpunpcklbw %xmm1, %xmm0, %xmm11
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm11, %xmm0
    vaesdeclast %xmm8, %xmm1, %xmm1
    vpunpcklbw %xmm3, %xmm2, %xmm11
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm11, %xmm2
    vaesdeclast %xmm8, %xmm3, %xmm3
    vpunpcklbw %xmm5, %xmm4, %xmm11
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm11, %xmm4
    vaesdeclast %xmm8, %xmm5, %xmm5
    vpunpcklbw %xmm7, %xmm6, %xmm11
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm11, %xmm6
    vaesdeclast %xmm8, %xmm7, %xmm7
    vaesenc %xmm8, %xmm10, %xmm10
    vaesdeclast %xmm9, %xmm0, %xmm0
    vaesenc %xmm8, %xmm1, %xmm1
    vaesdeclast %xmm9, %xmm2, %xmm2
    vaesenc %xmm8, %xmm3, %xmm3
    vaesdeclast %xmm9, %xmm4, %xmm4
    vaesenc %xmm8, %xmm5, %xmm5
    vaesdeclast %xmm9, %xmm6, %xmm6
    vaesenc %xmm8, %xmm7, %xmm7
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesenc %xmm10, %xmm1, %xmm1
    vaesdeclast %xmm8, %xmm2, %xmm2
    vaesenc %xmm10, %xmm3, %xmm3
    vaesdeclast %xmm8, %xmm4, %xmm4
    vaesenc %xmm10, %xmm5, %xmm5
    vaesdeclast %xmm8, %xmm6, %xmm6
    vaesenc %xmm10, %xmm7, %xmm7
    vmovdqu 192(%rdx), %xmm9
    vmovdqu 208(%rdx), %xmm10
    vaesenc %xmm8, %xmm0, %xmm0
    vaesenc %xmm8, %xmm2, %xmm2
    vaesenc %xmm8, %xmm4, %xmm4
    vaesenc %xmm8, %xmm6, %xmm6
    vaesenclast %xmm9, %xmm0, %xmm0
    vaesenclast %xmm10, %xmm1, %xmm1
    vaesenclast %xmm9, %xmm2, %xmm2
    vaesenclast %xmm10, %xmm3, %xmm3
    vaesenclast %xmm9, %xmm4, %xmm4
    vaesenclast %xmm10, %xmm5, %xmm5
    vaesenclast %xmm9, %xmm6, %xmm6
    vaesenclast %xmm10, %xmm7, %xmm7
    vmovdqu 160(%rdx), %xmm9
    vmovdqu 176(%rdx), %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vpunpcklbw %xmm1, %xmm0, %xmm11
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm11, %xmm0
    vaesdeclast %xmm8, %xmm1, %xmm1
    vpunpcklbw %xmm3, %xmm2, %xmm11
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm11, %xmm2
    vaesdeclast %xmm8, %xmm3, %xmm3
    vpunpcklbw %xmm5, %xmm4, %xmm11
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm11, %xmm4
    vaesdeclast %xmm8, %xmm5, %xmm5
    vpunpcklbw %xmm7, %xmm6, %xmm11
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm11, %xmm6
    vaesdeclast %xmm8, %xmm7, %xmm7
    vaesenc %xmm8, %xmm10, %xmm10
    vaesdeclast %xmm9, %xmm0, %xmm0
    vaesenc %xmm8, %xmm1, %xmm1
    vaesdeclast %xmm9, %xmm2, %xmm2
    vaesenc %xmm8, %xmm3, %xmm3
    vaesdeclast %xmm9, %xmm4, %xmm4
    vaesenc %xmm8, %xmm5, %xmm5
    vaesdeclast %xmm9, %xmm6, %xmm6
    vaesenc %xmm8, %xmm7, %xmm7
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesenc %xmm10, %xmm1, %xmm1
    vaesdeclast %xmm8, %xmm2, %xmm2
    vaesenc %xmm10, %xmm3, %xmm3
    vaesdeclast %xmm8, %xmm4, %xmm4
    vaesenc %xmm10, %xmm5, %xmm5
    vaesdeclast %xmm8, %xmm6, %xmm6
    vaesenc %xmm10, %xmm7, %xmm7
    vmovdqu 128(%rdx), %xmm9
    vmovdqu 144(%rdx), %xmm10
    vaesenc %xmm8, %xmm0, %xmm0
    vaesenc %xmm8, %xmm2, %xmm2
    vaesenc %xmm8, %xmm4, %xmm4
    vaesenc %xmm8, %xmm6, %xmm6
    vaesenclast %xmm9, %xmm0, %xmm0
    vaesenclast %xmm10, %xmm1, %xmm1
    vaesenclast %xmm9, %xmm2, %xmm2
    vaesenclast %xmm10, %xmm3, %xmm3
    vaesenclast %xmm9, %xmm4, %xmm4
    vaesenclast %xmm10, %xmm5, %xmm5
    vaesenclast %xmm9, %xmm6, %xmm6
    vaesenclast %xmm10, %xmm7, %xmm7
    vmovdqu 96(%rdx), %xmm9
    vmovdqu 112(%rdx), %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vpunpcklbw %xmm1, %xmm0, %xmm11
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm11, %xmm0
    vaesdeclast %xmm8, %xmm1, %xmm1
    vpunpcklbw %xmm3, %xmm2, %xmm11
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm11, %xmm2
    vaesdeclast %xmm8, %xmm3, %xmm3
    vpunpcklbw %xmm5, %xmm4, %xmm11
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm11, %xmm4
    vaesdeclast %xmm8, %xmm5, %xmm5
    vpunpcklbw %xmm7, %xmm6, %xmm11
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm11, %xmm6
    vaesdeclast %xmm8, %xmm7, %xmm7
    vaesenc %xmm8, %xmm10, %xmm10
    vaesdeclast %xmm9, %xmm0, %xmm0
    vaesenc %xmm8, %xmm1, %xmm1
    vaesdeclast %xmm9, %xmm2, %xmm2
    vaesenc %xmm8, %xmm3, %xmm3
    vaesdeclast %xmm9, %xmm4, %xmm4
    vaesenc %xmm8, %xmm5, %xmm5
    vaesdeclast %xmm9, %xmm6, %xmm6
    vaesenc %xmm8, %xmm7, %xmm7
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesenc %xmm10, %xmm1, %xmm1
    vaesdeclast %xmm8, %xmm2, %xmm2
    vaesenc %xmm10, %xmm3, %xmm3
    vaesdeclast %xmm8, %xmm4, %xmm4
    vaesenc %xmm10, %xmm5, %xmm5
    vaesdeclast %xmm8, %xmm6, %xmm6
    vaesenc %xmm10, %xmm7, %xmm7
    vmovdqu 64(%rdx), %xmm9
    vmovdqu 80(%rdx), %xmm10
    vaesenc %xmm8, %xmm0, %xmm0
    vaesenc %xmm8, %xmm2, %xmm2
    vaesenc %xmm8, %xmm4, %xmm4
    vaesenc %xmm8, %xmm6, %xmm6
    vaesenclast %xmm9, %xmm0, %xmm0
    vaesenclast %xmm10, %xmm1, %xmm1
    vaesenclast %xmm9, %xmm2, %xmm2
    vaesenclast %xmm10, %xmm3, %xmm3
    vaesenclast %xmm9, %xmm4, %xmm4
    vaesenclast %xmm10, %xmm5, %xmm5
    vaesenclast %xmm9, %xmm6, %xmm6
    vaesenclast %xmm10, %xmm7, %xmm7
    vmovdqu 32(%rdx), %xmm9
    vmovdqu 48(%rdx), %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vpunpcklbw %xmm1, %xmm0, %xmm11
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm11, %xmm0
    vaesdeclast %xmm8, %xmm1, %xmm1
    vpunpcklbw %xmm3, %xmm2, %xmm11
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm11, %xmm2
    vaesdeclast %xmm8, %xmm3, %xmm3
    vpunpcklbw %xmm5, %xmm4, %xmm11
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm11, %xmm4
    vaesdeclast %xmm8, %xmm5, %xmm5
    vpunpcklbw %xmm7, %xmm6, %xmm11
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm11, %xmm6
    vaesdeclast %xmm8, %xmm7, %xmm7
    vaesenc %xmm8, %xmm10, %xmm10
    vaesdeclast %xmm9, %xmm0, %xmm0
    vaesenc %xmm8, %xmm1, %xmm1
    vaesdeclast %xmm9, %xmm2, %xmm2
    vaesenc %xmm8, %xmm3, %xmm3
    vaesdeclast %xmm9, %xmm4, %xmm4
    vaesenc %xmm8, %xmm5, %xmm5
    vaesdeclast %xmm9, %xmm6, %xmm6
    vaesenc %xmm8, %xmm7, %xmm7
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesenc %xmm10, %xmm1, %xmm1
    vaesdeclast %xmm8, %xmm2, %xmm2
    vaesenc %xmm10, %xmm3, %xmm3
    vaesdeclast %xmm8, %xmm4, %xmm4
    vaesenc %xmm10, %xmm5, %xmm5
    vaesdeclast %xmm8, %xmm6, %xmm6
    vaesenc %xmm10, %xmm7, %xmm7
    vmovdqu 0(%rdx), %xmm9
    vmovdqu 16(%rdx), %xmm10
    vaesenc %xmm8, %xmm0, %xmm0
    vaesenc %xmm8, %xmm2, %xmm2
    vaesenc %xmm8, %xmm4, %xmm4
    vaesenc %xmm8, %xmm6, %xmm6
    vaesenclast %xmm9, %xmm0, %xmm0
    vaesenclast %xmm10, %xmm1, %xmm1
    vaesenclast %xmm9, %xmm2, %xmm2
    vaesenclast %xmm10, %xmm3, %xmm3
    vaesenclast %xmm9, %xmm4, %xmm4
    vaesenclast %xmm10, %xmm5, %xmm5
    vaesenclast %xmm9, %xmm6, %xmm6
    vaesenclast %xmm10, %xmm7, %xmm7
    vmovdqu %xmm0, 0(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vmovdqu %xmm4, 64(%rdi)
    vmovdqu %xmm5, 80(%rdi)
    vmovdqu %xmm6, 96(%rdi)
    vmovdqu %xmm7, 112(%rdi)
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
    vmovdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    vmovdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $120, %rsp
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_decrypt_4blocks_vex_asm)

AREION_FUNC_START(areion_asura_encrypt_4blocks_otf_vex_asm)
#if defined(_WIN64)
    subq $184, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    vmovdqu %xmm11, 96(%rsp)
    vmovdqu %xmm12, 112(%rsp)
    vmovdqu %xmm13, 128(%rsp)
    vmovdqu %xmm14, 144(%rsp)
    vmovdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu 0(%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vmovdqu 64(%rsi), %xmm4
    vmovdqu 80(%rsi), %xmm5
    vmovdqu 96(%rsi), %xmm6
    vmovdqu 112(%rsi), %xmm7
    vmovdqu 0(%rdx), %xmm8
    vmovdqu 16(%rdx), %xmm9
    vmovdqu 0(%rcx), %xmm10
    vmovdqu 16(%rcx), %xmm11
    vmovdqu 32(%rcx), %xmm12
    vmovdqu 48(%rcx), %xmm13
    vpxor AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vpxor %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vpxor %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesdec %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesdec %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesdec %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesdec %xmm15, %xmm7, %xmm7
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm0, %xmm0
    vaesdec %xmm14, %xmm1, %xmm1
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0, %xmm0
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpunpcklqdq %xmm1, %xmm0, %xmm15
    vpunpckhqdq %xmm1, %xmm0, %xmm1
    vmovdqa %xmm15, %xmm0
    vaesenc %xmm14, %xmm2, %xmm2
    vaesdec %xmm14, %xmm3, %xmm3
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpunpcklqdq %xmm3, %xmm2, %xmm15
    vpunpckhqdq %xmm3, %xmm2, %xmm3
    vmovdqa %xmm15, %xmm2
    vaesenc %xmm14, %xmm4, %xmm4
    vaesdec %xmm14, %xmm5, %xmm5
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5, %xmm5
    vpunpcklqdq %xmm5, %xmm4, %xmm15
    vpunpckhqdq %xmm5, %xmm4, %xmm5
    vmovdqa %xmm15, %xmm4
    vaesenc %xmm14, %xmm6, %xmm6
    vaesdec %xmm14, %xmm7, %xmm7
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm6
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7, %xmm7
    vpunpcklqdq %xmm7, %xmm6, %xmm15
    vpunpckhqdq %xmm7, %xmm6, %xmm7
    vmovdqa %xmm15, %xmm6
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vpxor %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vpxor %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesdec %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesdec %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesdec %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesdec %xmm15, %xmm7, %xmm7
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm0, %xmm0
    vaesdec %xmm14, %xmm1, %xmm1
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0, %xmm0
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpunpcklqdq %xmm1, %xmm0, %xmm15
    vpunpckhqdq %xmm1, %xmm0, %xmm1
    vmovdqa %xmm15, %xmm0
    vaesenc %xmm14, %xmm2, %xmm2
    vaesdec %xmm14, %xmm3, %xmm3
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpunpcklqdq %xmm3, %xmm2, %xmm15
    vpunpckhqdq %xmm3, %xmm2, %xmm3
    vmovdqa %xmm15, %xmm2
    vaesenc %xmm14, %xmm4, %xmm4
    vaesdec %xmm14, %xmm5, %xmm5
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5, %xmm5
    vpunpcklqdq %xmm5, %xmm4, %xmm15
    vpunpckhqdq %xmm5, %xmm4, %xmm5
    vmovdqa %xmm15, %xmm4
    vaesenc %xmm14, %xmm6, %xmm6
    vaesdec %xmm14, %xmm7, %xmm7
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm6
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7, %xmm7
    vpunpcklqdq %xmm7, %xmm6, %xmm15
    vpunpckhqdq %xmm7, %xmm6, %xmm7
    vmovdqa %xmm15, %xmm6
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vpxor %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vpxor %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesdec %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesdec %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesdec %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesdec %xmm15, %xmm7, %xmm7
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm0, %xmm0
    vaesdec %xmm14, %xmm1, %xmm1
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0, %xmm0
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpunpcklqdq %xmm1, %xmm0, %xmm15
    vpunpckhqdq %xmm1, %xmm0, %xmm1
    vmovdqa %xmm15, %xmm0
    vaesenc %xmm14, %xmm2, %xmm2
    vaesdec %xmm14, %xmm3, %xmm3
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpunpcklqdq %xmm3, %xmm2, %xmm15
    vpunpckhqdq %xmm3, %xmm2, %xmm3
    vmovdqa %xmm15, %xmm2
    vaesenc %xmm14, %xmm4, %xmm4
    vaesdec %xmm14, %xmm5, %xmm5
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5, %xmm5
    vpunpcklqdq %xmm5, %xmm4, %xmm15
    vpunpckhqdq %xmm5, %xmm4, %xmm5
    vmovdqa %xmm15, %xmm4
    vaesenc %xmm14, %xmm6, %xmm6
    vaesdec %xmm14, %xmm7, %xmm7
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm6
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7, %xmm7
    vpunpcklqdq %xmm7, %xmm6, %xmm15
    vpunpckhqdq %xmm7, %xmm6, %xmm7
    vmovdqa %xmm15, %xmm6
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vpxor %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vpxor %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesdec %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesdec %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesdec %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesdec %xmm15, %xmm7, %xmm7
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm0, %xmm0
    vaesdec %xmm14, %xmm1, %xmm1
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0, %xmm0
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpunpcklqdq %xmm1, %xmm0, %xmm15
    vpunpckhqdq %xmm1, %xmm0, %xmm1
    vmovdqa %xmm15, %xmm0
    vaesenc %xmm14, %xmm2, %xmm2
    vaesdec %xmm14, %xmm3, %xmm3
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpunpcklqdq %xmm3, %xmm2, %xmm15
    vpunpckhqdq %xmm3, %xmm2, %xmm3
    vmovdqa %xmm15, %xmm2
    vaesenc %xmm14, %xmm4, %xmm4
    vaesdec %xmm14, %xmm5, %xmm5
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5, %xmm5
    vpunpcklqdq %xmm5, %xmm4, %xmm15
    vpunpckhqdq %xmm5, %xmm4, %xmm5
    vmovdqa %xmm15, %xmm4
    vaesenc %xmm14, %xmm6, %xmm6
    vaesdec %xmm14, %xmm7, %xmm7
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm6
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7, %xmm7
    vpunpcklqdq %xmm7, %xmm6, %xmm15
    vpunpckhqdq %xmm7, %xmm6, %xmm7
    vmovdqa %xmm15, %xmm6
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vpxor %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vpxor %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesdec %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesdec %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesdec %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesdec %xmm15, %xmm7, %xmm7
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm0, %xmm0
    vaesdec %xmm14, %xmm1, %xmm1
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0, %xmm0
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpunpcklqdq %xmm1, %xmm0, %xmm15
    vpunpckhqdq %xmm1, %xmm0, %xmm1
    vmovdqa %xmm15, %xmm0
    vaesenc %xmm14, %xmm2, %xmm2
    vaesdec %xmm14, %xmm3, %xmm3
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpunpcklqdq %xmm3, %xmm2, %xmm15
    vpunpckhqdq %xmm3, %xmm2, %xmm3
    vmovdqa %xmm15, %xmm2
    vaesenc %xmm14, %xmm4, %xmm4
    vaesdec %xmm14, %xmm5, %xmm5
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5, %xmm5
    vpunpcklqdq %xmm5, %xmm4, %xmm15
    vpunpckhqdq %xmm5, %xmm4, %xmm5
    vmovdqa %xmm15, %xmm4
    vaesenc %xmm14, %xmm6, %xmm6
    vaesdec %xmm14, %xmm7, %xmm7
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm6
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7, %xmm7
    vpunpcklqdq %xmm7, %xmm6, %xmm15
    vpunpckhqdq %xmm7, %xmm6, %xmm7
    vmovdqa %xmm15, %xmm6
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vpxor %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vpxor %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesdec %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesdec %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesdec %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesdec %xmm15, %xmm7, %xmm7
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesenc %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesdec %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vaesenc %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesdec %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vaesenc %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesdec %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vaesenc %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesdec %xmm15, %xmm7, %xmm7
    vmovdqu %xmm0, 0(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vmovdqu %xmm4, 64(%rdi)
    vmovdqu %xmm5, 80(%rdi)
    vmovdqu %xmm6, 96(%rdi)
    vmovdqu %xmm7, 112(%rdi)
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
    vpxor %xmm15, %xmm15, %xmm15
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
    vmovdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    vmovdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    vmovdqu 112(%rsp), %xmm12
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    vmovdqu 128(%rsp), %xmm13
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    vmovdqu 144(%rsp), %xmm14
    movq $0, 144(%rsp)
    movq $0, 152(%rsp)
    vmovdqu 160(%rsp), %xmm15
    movq $0, 160(%rsp)
    movq $0, 168(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $184, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_encrypt_4blocks_otf_vex_asm)

AREION_FUNC_START(areion_asura_decrypt_4blocks_otf_vex_asm)
#if defined(_WIN64)
    subq $184, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    vmovdqu %xmm11, 96(%rsp)
    vmovdqu %xmm12, 112(%rsp)
    vmovdqu %xmm13, 128(%rsp)
    vmovdqu %xmm14, 144(%rsp)
    vmovdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu 0(%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vmovdqu 64(%rsi), %xmm4
    vmovdqu 80(%rsi), %xmm5
    vmovdqu 96(%rsi), %xmm6
    vmovdqu 112(%rsi), %xmm7
    vmovdqu 0(%rdx), %xmm8
    vmovdqu 16(%rdx), %xmm9
    vmovdqu 0(%rcx), %xmm10
    vmovdqu 16(%rcx), %xmm11
    vmovdqu 32(%rcx), %xmm12
    vmovdqu 48(%rcx), %xmm13
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor %xmm14, %xmm14, %xmm14
    vaesenc %xmm14, %xmm10, %xmm10
    vaesenc %xmm14, %xmm11, %xmm11
    vaesenc %xmm14, %xmm12, %xmm12
    vaesenc %xmm14, %xmm13, %xmm13
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm15, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm14, %xmm15
    vpcmpgtb %xmm9, %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm15, %xmm8, %xmm8
    vpxor %xmm14, %xmm9, %xmm9
    vpxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vpxor %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vpxor %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vpxor %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vpxor %xmm14, %xmm14, %xmm14
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm14, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm14, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm14, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm14, %xmm13, %xmm13
    vpsllw $7, %xmm8, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpxor %xmm15, %xmm8, %xmm8
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm15, %xmm8
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm10, %xmm15, %xmm15
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm1, %xmm1
    vaesenc %xmm14, %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm14, %xmm0, %xmm0
    vaesenc %xmm14, %xmm0, %xmm0
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm11, %xmm15, %xmm15
    vaesimc %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm3, %xmm3
    vaesenc %xmm14, %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm14, %xmm2, %xmm2
    vaesenc %xmm14, %xmm2, %xmm2
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm12, %xmm15, %xmm15
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm14, %xmm5, %xmm5
    vaesenc %xmm15, %xmm5, %xmm5
    vaesdeclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm14, %xmm4, %xmm4
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm13, %xmm15, %xmm15
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm14, %xmm7, %xmm7
    vaesenc %xmm15, %xmm7, %xmm7
    vaesdeclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm14, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm14, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm14, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm14, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm14, %xmm13, %xmm13
    vpsllw $7, %xmm8, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpxor %xmm15, %xmm8, %xmm8
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm15, %xmm8
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm7, %xmm7
    vpunpcklbw %xmm1, %xmm0, %xmm14
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqa %xmm14, %xmm0
    vpunpcklbw %xmm3, %xmm2, %xmm14
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vmovdqa %xmm14, %xmm2
    vpunpcklbw %xmm5, %xmm4, %xmm14
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vmovdqa %xmm14, %xmm4
    vpunpcklbw %xmm7, %xmm6, %xmm14
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vmovdqa %xmm14, %xmm6
    vpxor %xmm14, %xmm14, %xmm14
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm14, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm14, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm14, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm14, %xmm13, %xmm13
    vpsllw $7, %xmm8, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpxor %xmm15, %xmm8, %xmm8
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm15, %xmm8
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm10, %xmm15, %xmm15
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm1, %xmm1
    vaesenc %xmm14, %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm14, %xmm0, %xmm0
    vaesenc %xmm14, %xmm0, %xmm0
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm11, %xmm15, %xmm15
    vaesimc %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm3, %xmm3
    vaesenc %xmm14, %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm14, %xmm2, %xmm2
    vaesenc %xmm14, %xmm2, %xmm2
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm12, %xmm15, %xmm15
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm14, %xmm5, %xmm5
    vaesenc %xmm15, %xmm5, %xmm5
    vaesdeclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm14, %xmm4, %xmm4
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm13, %xmm15, %xmm15
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm14, %xmm7, %xmm7
    vaesenc %xmm15, %xmm7, %xmm7
    vaesdeclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm14, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm14, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm14, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm14, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm14, %xmm13, %xmm13
    vpsllw $7, %xmm8, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpxor %xmm15, %xmm8, %xmm8
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm15, %xmm8
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm7, %xmm7
    vpunpcklbw %xmm1, %xmm0, %xmm14
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqa %xmm14, %xmm0
    vpunpcklbw %xmm3, %xmm2, %xmm14
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vmovdqa %xmm14, %xmm2
    vpunpcklbw %xmm5, %xmm4, %xmm14
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vmovdqa %xmm14, %xmm4
    vpunpcklbw %xmm7, %xmm6, %xmm14
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vmovdqa %xmm14, %xmm6
    vpxor %xmm14, %xmm14, %xmm14
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm14, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm14, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm14, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm14, %xmm13, %xmm13
    vpsllw $7, %xmm8, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpxor %xmm15, %xmm8, %xmm8
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm15, %xmm8
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm10, %xmm15, %xmm15
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm1, %xmm1
    vaesenc %xmm14, %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm14, %xmm0, %xmm0
    vaesenc %xmm14, %xmm0, %xmm0
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm11, %xmm15, %xmm15
    vaesimc %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm3, %xmm3
    vaesenc %xmm14, %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm14, %xmm2, %xmm2
    vaesenc %xmm14, %xmm2, %xmm2
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm12, %xmm15, %xmm15
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm14, %xmm5, %xmm5
    vaesenc %xmm15, %xmm5, %xmm5
    vaesdeclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm14, %xmm4, %xmm4
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm13, %xmm15, %xmm15
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm14, %xmm7, %xmm7
    vaesenc %xmm15, %xmm7, %xmm7
    vaesdeclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm14, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm14, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm14, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm14, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm14, %xmm13, %xmm13
    vpsllw $7, %xmm8, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpxor %xmm15, %xmm8, %xmm8
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm15, %xmm8
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm7, %xmm7
    vpunpcklbw %xmm1, %xmm0, %xmm14
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqa %xmm14, %xmm0
    vpunpcklbw %xmm3, %xmm2, %xmm14
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vmovdqa %xmm14, %xmm2
    vpunpcklbw %xmm5, %xmm4, %xmm14
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vmovdqa %xmm14, %xmm4
    vpunpcklbw %xmm7, %xmm6, %xmm14
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vmovdqa %xmm14, %xmm6
    vpxor %xmm14, %xmm14, %xmm14
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm14, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm14, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm14, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm14, %xmm13, %xmm13
    vpsllw $7, %xmm8, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpxor %xmm15, %xmm8, %xmm8
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm15, %xmm8
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm10, %xmm15, %xmm15
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm1, %xmm1
    vaesenc %xmm14, %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm14, %xmm0, %xmm0
    vaesenc %xmm14, %xmm0, %xmm0
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm11, %xmm15, %xmm15
    vaesimc %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm3, %xmm3
    vaesenc %xmm14, %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm14, %xmm2, %xmm2
    vaesenc %xmm14, %xmm2, %xmm2
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm12, %xmm15, %xmm15
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm14, %xmm5, %xmm5
    vaesenc %xmm15, %xmm5, %xmm5
    vaesdeclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm14, %xmm4, %xmm4
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm13, %xmm15, %xmm15
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm14, %xmm7, %xmm7
    vaesenc %xmm15, %xmm7, %xmm7
    vaesdeclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm14, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm14, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm14, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm14, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm14, %xmm13, %xmm13
    vpsllw $7, %xmm8, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpxor %xmm15, %xmm8, %xmm8
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm15, %xmm8
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm7, %xmm7
    vpunpcklbw %xmm1, %xmm0, %xmm14
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqa %xmm14, %xmm0
    vpunpcklbw %xmm3, %xmm2, %xmm14
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vmovdqa %xmm14, %xmm2
    vpunpcklbw %xmm5, %xmm4, %xmm14
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vmovdqa %xmm14, %xmm4
    vpunpcklbw %xmm7, %xmm6, %xmm14
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vmovdqa %xmm14, %xmm6
    vpxor %xmm14, %xmm14, %xmm14
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm14, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm14, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm14, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm14, %xmm13, %xmm13
    vpsllw $7, %xmm8, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpxor %xmm15, %xmm8, %xmm8
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm15, %xmm8
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm10, %xmm15, %xmm15
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm1, %xmm1
    vaesenc %xmm14, %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm14, %xmm0, %xmm0
    vaesenc %xmm14, %xmm0, %xmm0
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm11, %xmm15, %xmm15
    vaesimc %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm3, %xmm3
    vaesenc %xmm14, %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm14, %xmm2, %xmm2
    vaesenc %xmm14, %xmm2, %xmm2
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm12, %xmm15, %xmm15
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm14, %xmm5, %xmm5
    vaesenc %xmm15, %xmm5, %xmm5
    vaesdeclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm14, %xmm4, %xmm4
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm13, %xmm15, %xmm15
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm14, %xmm7, %xmm7
    vaesenc %xmm15, %xmm7, %xmm7
    vaesdeclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm14, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm14, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm14, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm14, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm14, %xmm13, %xmm13
    vpsllw $7, %xmm8, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpxor %xmm15, %xmm8, %xmm8
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm15, %xmm8
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm7, %xmm7
    vpunpcklbw %xmm1, %xmm0, %xmm14
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqa %xmm14, %xmm0
    vpunpcklbw %xmm3, %xmm2, %xmm14
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vmovdqa %xmm14, %xmm2
    vpunpcklbw %xmm5, %xmm4, %xmm14
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vmovdqa %xmm14, %xmm4
    vpunpcklbw %xmm7, %xmm6, %xmm14
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vmovdqa %xmm14, %xmm6
    vpxor %xmm14, %xmm14, %xmm14
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm14, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm14, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm14, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm14, %xmm13, %xmm13
    vpsllw $7, %xmm8, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpxor %xmm15, %xmm8, %xmm8
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm15, %xmm8
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm10, %xmm15, %xmm15
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm1, %xmm1
    vaesenc %xmm14, %xmm1, %xmm1
    vaesenc %xmm15, %xmm1, %xmm1
    vaesdeclast %xmm14, %xmm0, %xmm0
    vaesenc %xmm14, %xmm0, %xmm0
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm11, %xmm15, %xmm15
    vaesimc %xmm2, %xmm2
    vaesdeclast %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm3, %xmm3
    vaesenc %xmm14, %xmm3, %xmm3
    vaesenc %xmm15, %xmm3, %xmm3
    vaesdeclast %xmm14, %xmm2, %xmm2
    vaesenc %xmm14, %xmm2, %xmm2
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm12, %xmm15, %xmm15
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm5, %xmm5
    vaesenc %xmm14, %xmm5, %xmm5
    vaesenc %xmm15, %xmm5, %xmm5
    vaesdeclast %xmm14, %xmm4, %xmm4
    vaesenc %xmm14, %xmm4, %xmm4
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm15
    vpxor %xmm13, %xmm15, %xmm15
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesdeclast %xmm14, %xmm15, %xmm15
    vaesenc %xmm14, %xmm15, %xmm15
    vaesdeclast %xmm14, %xmm7, %xmm7
    vaesenc %xmm14, %xmm7, %xmm7
    vaesenc %xmm15, %xmm7, %xmm7
    vaesdeclast %xmm14, %xmm6, %xmm6
    vaesenc %xmm14, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm14, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm14, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm14, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm14, %xmm13, %xmm13
    vpsllw $7, %xmm8, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpxor %xmm15, %xmm8, %xmm8
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm15, %xmm14, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm15
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm15, %xmm8
    vpxor AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm0, %xmm0
    vpxor %xmm10, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm2, %xmm2
    vpxor %xmm11, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm4, %xmm4
    vpxor %xmm12, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vaesenclast %xmm15, %xmm6, %xmm6
    vpxor %xmm13, %xmm9, %xmm15
    vaesenclast %xmm15, %xmm7, %xmm7
    vmovdqu %xmm0, 0(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vmovdqu %xmm4, 64(%rdi)
    vmovdqu %xmm5, 80(%rdi)
    vmovdqu %xmm6, 96(%rdi)
    vmovdqu %xmm7, 112(%rdi)
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
    vpxor %xmm15, %xmm15, %xmm15
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
    vmovdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    vmovdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    vmovdqu 112(%rsp), %xmm12
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    vmovdqu 128(%rsp), %xmm13
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    vmovdqu 144(%rsp), %xmm14
    movq $0, 144(%rsp)
    movq $0, 152(%rsp)
    vmovdqu 160(%rsp), %xmm15
    movq $0, 160(%rsp)
    movq $0, 168(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $184, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_decrypt_4blocks_otf_vex_asm)

AREION_FUNC_START(areion_asura_encrypt_4blocks_vaes256_asm)
#if defined(_WIN64)
    subq $88, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
#endif
    vmovdqu 0(%rsi), %ymm6
    vmovdqu 32(%rsi), %ymm7
    vperm2i128 $0x20, %ymm7, %ymm6, %ymm0
    vperm2i128 $0x31, %ymm7, %ymm6, %ymm1
    vmovdqu 64(%rsi), %ymm6
    vmovdqu 96(%rsi), %ymm7
    vperm2i128 $0x20, %ymm7, %ymm6, %ymm2
    vperm2i128 $0x31, %ymm7, %ymm6, %ymm3
    vpxor %ymm4, %ymm4, %ymm4
    vmovdqa 64+AREION_SYM(asuraConsts)(%rip), %ymm5
    vbroadcasti128 0(%rdx), %ymm6
    vbroadcasti128 16(%rdx), %ymm7
    vpxor %ymm6, %ymm0, %ymm0
    vpxor %ymm7, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
    vbroadcasti128 32(%rdx), %ymm6
    vbroadcasti128 48(%rdx), %ymm7
    vaesdec %ymm6, %ymm0, %ymm0
    vaesdec %ymm7, %ymm1, %ymm1
    vaesdec %ymm6, %ymm2, %ymm2
    vaesdec %ymm7, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm5, %ymm0, %ymm8
    vpshufb %ymm5, %ymm1, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm0
    vpunpckhqdq %ymm9, %ymm8, %ymm1
    vpshufb %ymm5, %ymm2, %ymm8
    vpshufb %ymm5, %ymm3, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm2
    vpunpckhqdq %ymm9, %ymm8, %ymm3
    vbroadcasti128 64(%rdx), %ymm6
    vbroadcasti128 80(%rdx), %ymm7
    vpxor %ymm6, %ymm0, %ymm0
    vpxor %ymm7, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
    vbroadcasti128 96(%rdx), %ymm6
    vbroadcasti128 112(%rdx), %ymm7
    vaesdec %ymm6, %ymm0, %ymm0
    vaesdec %ymm7, %ymm1, %ymm1
    vaesdec %ymm6, %ymm2, %ymm2
    vaesdec %ymm7, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm5, %ymm0, %ymm8
    vpshufb %ymm5, %ymm1, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm0
    vpunpckhqdq %ymm9, %ymm8, %ymm1
    vpshufb %ymm5, %ymm2, %ymm8
    vpshufb %ymm5, %ymm3, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm2
    vpunpckhqdq %ymm9, %ymm8, %ymm3
    vbroadcasti128 128(%rdx), %ymm6
    vbroadcasti128 144(%rdx), %ymm7
    vpxor %ymm6, %ymm0, %ymm0
    vpxor %ymm7, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
    vbroadcasti128 160(%rdx), %ymm6
    vbroadcasti128 176(%rdx), %ymm7
    vaesdec %ymm6, %ymm0, %ymm0
    vaesdec %ymm7, %ymm1, %ymm1
    vaesdec %ymm6, %ymm2, %ymm2
    vaesdec %ymm7, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm5, %ymm0, %ymm8
    vpshufb %ymm5, %ymm1, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm0
    vpunpckhqdq %ymm9, %ymm8, %ymm1
    vpshufb %ymm5, %ymm2, %ymm8
    vpshufb %ymm5, %ymm3, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm2
    vpunpckhqdq %ymm9, %ymm8, %ymm3
    vbroadcasti128 192(%rdx), %ymm6
    vbroadcasti128 208(%rdx), %ymm7
    vpxor %ymm6, %ymm0, %ymm0
    vpxor %ymm7, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
    vbroadcasti128 224(%rdx), %ymm6
    vbroadcasti128 240(%rdx), %ymm7
    vaesdec %ymm6, %ymm0, %ymm0
    vaesdec %ymm7, %ymm1, %ymm1
    vaesdec %ymm6, %ymm2, %ymm2
    vaesdec %ymm7, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm5, %ymm0, %ymm8
    vpshufb %ymm5, %ymm1, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm0
    vpunpckhqdq %ymm9, %ymm8, %ymm1
    vpshufb %ymm5, %ymm2, %ymm8
    vpshufb %ymm5, %ymm3, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm2
    vpunpckhqdq %ymm9, %ymm8, %ymm3
    vbroadcasti128 256(%rdx), %ymm6
    vbroadcasti128 272(%rdx), %ymm7
    vpxor %ymm6, %ymm0, %ymm0
    vpxor %ymm7, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
    vbroadcasti128 288(%rdx), %ymm6
    vbroadcasti128 304(%rdx), %ymm7
    vaesdec %ymm6, %ymm0, %ymm0
    vaesdec %ymm7, %ymm1, %ymm1
    vaesdec %ymm6, %ymm2, %ymm2
    vaesdec %ymm7, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm5, %ymm0, %ymm8
    vpshufb %ymm5, %ymm1, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm0
    vpunpckhqdq %ymm9, %ymm8, %ymm1
    vpshufb %ymm5, %ymm2, %ymm8
    vpshufb %ymm5, %ymm3, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm2
    vpunpckhqdq %ymm9, %ymm8, %ymm3
    vbroadcasti128 320(%rdx), %ymm6
    vbroadcasti128 336(%rdx), %ymm7
    vpxor %ymm6, %ymm0, %ymm0
    vpxor %ymm7, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
    vbroadcasti128 352(%rdx), %ymm6
    vbroadcasti128 368(%rdx), %ymm7
    vaesdec %ymm6, %ymm0, %ymm0
    vaesdec %ymm7, %ymm1, %ymm1
    vaesdec %ymm6, %ymm2, %ymm2
    vaesdec %ymm7, %ymm3, %ymm3
    vbroadcasti128 384(%rdx), %ymm6
    vbroadcasti128 400(%rdx), %ymm7
    vaesenc %ymm6, %ymm0, %ymm0
    vaesdec %ymm7, %ymm1, %ymm1
    vaesenc %ymm6, %ymm2, %ymm2
    vaesdec %ymm7, %ymm3, %ymm3
    vperm2i128 $0x20, %ymm1, %ymm0, %ymm6
    vperm2i128 $0x31, %ymm1, %ymm0, %ymm7
    vmovdqu %ymm6, 0(%rdi)
    vmovdqu %ymm7, 32(%rdi)
    vperm2i128 $0x20, %ymm3, %ymm2, %ymm6
    vperm2i128 $0x31, %ymm3, %ymm2, %ymm7
    vmovdqu %ymm6, 64(%rdi)
    vmovdqu %ymm7, 96(%rdi)
    vpxor %ymm0, %ymm0, %ymm0
    vpxor %ymm1, %ymm1, %ymm1
    vpxor %ymm2, %ymm2, %ymm2
    vpxor %ymm3, %ymm3, %ymm3
    vpxor %ymm4, %ymm4, %ymm4
    vpxor %ymm5, %ymm5, %ymm5
    vpxor %ymm6, %ymm6, %ymm6
    vpxor %ymm7, %ymm7, %ymm7
    vpxor %ymm8, %ymm8, %ymm8
    vpxor %ymm9, %ymm9, %ymm9
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
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $88, %rsp
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion_asura_encrypt_4blocks_vaes256_asm)

AREION_FUNC_START(areion_asura_decrypt_4blocks_vaes256_asm)
#if defined(_WIN64)
    subq $72, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
#endif
    vmovdqu 0(%rsi), %ymm6
    vmovdqu 32(%rsi), %ymm7
    vperm2i128 $0x20, %ymm7, %ymm6, %ymm0
    vperm2i128 $0x31, %ymm7, %ymm6, %ymm1
    vmovdqu 64(%rsi), %ymm6
    vmovdqu 96(%rsi), %ymm7
    vperm2i128 $0x20, %ymm7, %ymm6, %ymm2
    vperm2i128 $0x31, %ymm7, %ymm6, %ymm3
    vpxor %ymm4, %ymm4, %ymm4
    vbroadcasti128 384(%rdx), %ymm6
    vbroadcasti128 400(%rdx), %ymm7
    vpxor %ymm6, %ymm0, %ymm0
    vpxor %ymm7, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
    vbroadcasti128 352(%rdx), %ymm6
    vbroadcasti128 368(%rdx), %ymm7
    vaesdeclast %ymm4, %ymm7, %ymm7
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vaesenclast %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm7, %ymm7
    vaesdec %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesdeclast %ymm6, %ymm0, %ymm0
    vaesenc %ymm7, %ymm1, %ymm1
    vaesdeclast %ymm6, %ymm2, %ymm2
    vaesenc %ymm7, %ymm3, %ymm3
    vbroadcasti128 320(%rdx), %ymm6
    vbroadcasti128 336(%rdx), %ymm7
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesenclast %ymm7, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesenclast %ymm7, %ymm3, %ymm3
    vbroadcasti128 288(%rdx), %ymm6
    vbroadcasti128 304(%rdx), %ymm7
    vaesdeclast %ymm4, %ymm7, %ymm7
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vaesenclast %ymm4, %ymm8, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vpunpcklbw %ymm3, %ymm2, %ymm8
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vaesenclast %ymm4, %ymm8, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm7, %ymm7
    vaesdec %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesdeclast %ymm6, %ymm0, %ymm0
    vaesenc %ymm7, %ymm1, %ymm1
    vaesdeclast %ymm6, %ymm2, %ymm2
    vaesenc %ymm7, %ymm3, %ymm3
    vbroadcasti128 256(%rdx), %ymm6
    vbroadcasti128 272(%rdx), %ymm7
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesenclast %ymm7, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesenclast %ymm7, %ymm3, %ymm3
    vbroadcasti128 224(%rdx), %ymm6
    vbroadcasti128 240(%rdx), %ymm7
    vaesdeclast %ymm4, %ymm7, %ymm7
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vaesenclast %ymm4, %ymm8, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vpunpcklbw %ymm3, %ymm2, %ymm8
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vaesenclast %ymm4, %ymm8, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm7, %ymm7
    vaesdec %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesdeclast %ymm6, %ymm0, %ymm0
    vaesenc %ymm7, %ymm1, %ymm1
    vaesdeclast %ymm6, %ymm2, %ymm2
    vaesenc %ymm7, %ymm3, %ymm3
    vbroadcasti128 192(%rdx), %ymm6
    vbroadcasti128 208(%rdx), %ymm7
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesenclast %ymm7, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesenclast %ymm7, %ymm3, %ymm3
    vbroadcasti128 160(%rdx), %ymm6
    vbroadcasti128 176(%rdx), %ymm7
    vaesdeclast %ymm4, %ymm7, %ymm7
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vaesenclast %ymm4, %ymm8, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vpunpcklbw %ymm3, %ymm2, %ymm8
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vaesenclast %ymm4, %ymm8, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm7, %ymm7
    vaesdec %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesdeclast %ymm6, %ymm0, %ymm0
    vaesenc %ymm7, %ymm1, %ymm1
    vaesdeclast %ymm6, %ymm2, %ymm2
    vaesenc %ymm7, %ymm3, %ymm3
    vbroadcasti128 128(%rdx), %ymm6
    vbroadcasti128 144(%rdx), %ymm7
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesenclast %ymm7, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesenclast %ymm7, %ymm3, %ymm3
    vbroadcasti128 96(%rdx), %ymm6
    vbroadcasti128 112(%rdx), %ymm7
    vaesdeclast %ymm4, %ymm7, %ymm7
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vaesenclast %ymm4, %ymm8, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vpunpcklbw %ymm3, %ymm2, %ymm8
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vaesenclast %ymm4, %ymm8, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm7, %ymm7
    vaesdec %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesdeclast %ymm6, %ymm0, %ymm0
    vaesenc %ymm7, %ymm1, %ymm1
    vaesdeclast %ymm6, %ymm2, %ymm2
    vaesenc %ymm7, %ymm3, %ymm3
    vbroadcasti128 64(%rdx), %ymm6
    vbroadcasti128 80(%rdx), %ymm7
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesenclast %ymm7, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesenclast %ymm7, %ymm3, %ymm3
    vbroadcasti128 32(%rdx), %ymm6
    vbroadcasti128 48(%rdx), %ymm7
    vaesdeclast %ymm4, %ymm7, %ymm7
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vaesenclast %ymm4, %ymm8, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vpunpcklbw %ymm3, %ymm2, %ymm8
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vaesenclast %ymm4, %ymm8, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm7, %ymm7
    vaesdec %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesdeclast %ymm6, %ymm0, %ymm0
    vaesenc %ymm7, %ymm1, %ymm1
    vaesdeclast %ymm6, %ymm2, %ymm2
    vaesenc %ymm7, %ymm3, %ymm3
    vbroadcasti128 0(%rdx), %ymm6
    vbroadcasti128 16(%rdx), %ymm7
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesenclast %ymm7, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesenclast %ymm7, %ymm3, %ymm3
    vperm2i128 $0x20, %ymm1, %ymm0, %ymm6
    vperm2i128 $0x31, %ymm1, %ymm0, %ymm7
    vmovdqu %ymm6, 0(%rdi)
    vmovdqu %ymm7, 32(%rdi)
    vperm2i128 $0x20, %ymm3, %ymm2, %ymm6
    vperm2i128 $0x31, %ymm3, %ymm2, %ymm7
    vmovdqu %ymm6, 64(%rdi)
    vmovdqu %ymm7, 96(%rdi)
    vpxor %ymm0, %ymm0, %ymm0
    vpxor %ymm1, %ymm1, %ymm1
    vpxor %ymm2, %ymm2, %ymm2
    vpxor %ymm3, %ymm3, %ymm3
    vpxor %ymm4, %ymm4, %ymm4
    vpxor %ymm5, %ymm5, %ymm5
    vpxor %ymm6, %ymm6, %ymm6
    vpxor %ymm7, %ymm7, %ymm7
    vpxor %ymm8, %ymm8, %ymm8
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
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $72, %rsp
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion_asura_decrypt_4blocks_vaes256_asm)

AREION_FUNC_START(areion_asura_encrypt_4blocks_otf_vaes256_asm)
#if defined(_WIN64)
    subq $152, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    vmovdqu %xmm11, 96(%rsp)
    vmovdqu %xmm12, 112(%rsp)
    vmovdqu %xmm13, 128(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu 0(%rsi), %ymm6
    vmovdqu 32(%rsi), %ymm7
    vperm2i128 $0x20, %ymm7, %ymm6, %ymm0
    vperm2i128 $0x31, %ymm7, %ymm6, %ymm1
    vmovdqu 64(%rsi), %ymm6
    vmovdqu 96(%rsi), %ymm7
    vperm2i128 $0x20, %ymm7, %ymm6, %ymm2
    vperm2i128 $0x31, %ymm7, %ymm6, %ymm3
    vbroadcasti128 0(%rdx), %ymm10
    vbroadcasti128 16(%rdx), %ymm11
    vmovdqu 0(%rcx), %ymm12
    vmovdqu 32(%rcx), %ymm13
    vpxor %ymm4, %ymm4, %ymm4
    vmovdqa 64+AREION_SYM(asuraConsts)(%rip), %ymm5
    vbroadcasti128 AREION_SYM(asuraRoundConstants)(%rip), %ymm6
    vpxor %ymm10, %ymm6, %ymm6
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm11, %ymm9
    vpxor %ymm8, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm11, %ymm9
    vpxor %ymm8, %ymm2, %ymm2
    vpxor %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %ymm11, %ymm10, %ymm8
    vpblendw $0xcc, %ymm10, %ymm11, %ymm11
    vbroadcasti128 AREION_SYM(asuraConsts)(%rip), %ymm6
    vpshufb %ymm6, %ymm8, %ymm10
    vpshufb %ymm6, %ymm11, %ymm11
    vpcmpgtb %ymm10, %ymm4, %ymm8
    vpcmpgtb %ymm11, %ymm4, %ymm9
    vbroadcasti128 AREION_SYM(asuraGFConsts)(%rip), %ymm6
    vpand %ymm6, %ymm8, %ymm8
    vpand %ymm6, %ymm9, %ymm9
    vpaddb %ymm10, %ymm10, %ymm10
    vpaddb %ymm11, %ymm11, %ymm11
    vpxor %ymm8, %ymm10, %ymm10
    vpxor %ymm9, %ymm11, %ymm11
    vbroadcasti128 16+AREION_SYM(asuraRoundConstants)(%rip), %ymm6
    vpxor %ymm10, %ymm6, %ymm6
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm11, %ymm9
    vaesdec %ymm8, %ymm0, %ymm0
    vaesdec %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm11, %ymm9
    vaesdec %ymm8, %ymm2, %ymm2
    vaesdec %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm5, %ymm0, %ymm8
    vpshufb %ymm5, %ymm1, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm0
    vpunpckhqdq %ymm9, %ymm8, %ymm1
    vpshufb %ymm5, %ymm2, %ymm8
    vpshufb %ymm5, %ymm3, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm2
    vpunpckhqdq %ymm9, %ymm8, %ymm3
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %ymm11, %ymm10, %ymm8
    vpblendw $0xcc, %ymm10, %ymm11, %ymm11
    vbroadcasti128 AREION_SYM(asuraConsts)(%rip), %ymm6
    vpshufb %ymm6, %ymm8, %ymm10
    vpshufb %ymm6, %ymm11, %ymm11
    vpcmpgtb %ymm10, %ymm4, %ymm8
    vpcmpgtb %ymm11, %ymm4, %ymm9
    vbroadcasti128 AREION_SYM(asuraGFConsts)(%rip), %ymm6
    vpand %ymm6, %ymm8, %ymm8
    vpand %ymm6, %ymm9, %ymm9
    vpaddb %ymm10, %ymm10, %ymm10
    vpaddb %ymm11, %ymm11, %ymm11
    vpxor %ymm8, %ymm10, %ymm10
    vpxor %ymm9, %ymm11, %ymm11
    vbroadcasti128 32+AREION_SYM(asuraRoundConstants)(%rip), %ymm6
    vpxor %ymm10, %ymm6, %ymm6
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm11, %ymm9
    vpxor %ymm8, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm11, %ymm9
    vpxor %ymm8, %ymm2, %ymm2
    vpxor %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %ymm11, %ymm10, %ymm8
    vpblendw $0xcc, %ymm10, %ymm11, %ymm11
    vbroadcasti128 AREION_SYM(asuraConsts)(%rip), %ymm6
    vpshufb %ymm6, %ymm8, %ymm10
    vpshufb %ymm6, %ymm11, %ymm11
    vpcmpgtb %ymm10, %ymm4, %ymm8
    vpcmpgtb %ymm11, %ymm4, %ymm9
    vbroadcasti128 AREION_SYM(asuraGFConsts)(%rip), %ymm6
    vpand %ymm6, %ymm8, %ymm8
    vpand %ymm6, %ymm9, %ymm9
    vpaddb %ymm10, %ymm10, %ymm10
    vpaddb %ymm11, %ymm11, %ymm11
    vpxor %ymm8, %ymm10, %ymm10
    vpxor %ymm9, %ymm11, %ymm11
    vbroadcasti128 48+AREION_SYM(asuraRoundConstants)(%rip), %ymm6
    vpxor %ymm10, %ymm6, %ymm6
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm11, %ymm9
    vaesdec %ymm8, %ymm0, %ymm0
    vaesdec %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm11, %ymm9
    vaesdec %ymm8, %ymm2, %ymm2
    vaesdec %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm5, %ymm0, %ymm8
    vpshufb %ymm5, %ymm1, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm0
    vpunpckhqdq %ymm9, %ymm8, %ymm1
    vpshufb %ymm5, %ymm2, %ymm8
    vpshufb %ymm5, %ymm3, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm2
    vpunpckhqdq %ymm9, %ymm8, %ymm3
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %ymm11, %ymm10, %ymm8
    vpblendw $0xcc, %ymm10, %ymm11, %ymm11
    vbroadcasti128 AREION_SYM(asuraConsts)(%rip), %ymm6
    vpshufb %ymm6, %ymm8, %ymm10
    vpshufb %ymm6, %ymm11, %ymm11
    vpcmpgtb %ymm10, %ymm4, %ymm8
    vpcmpgtb %ymm11, %ymm4, %ymm9
    vbroadcasti128 AREION_SYM(asuraGFConsts)(%rip), %ymm6
    vpand %ymm6, %ymm8, %ymm8
    vpand %ymm6, %ymm9, %ymm9
    vpaddb %ymm10, %ymm10, %ymm10
    vpaddb %ymm11, %ymm11, %ymm11
    vpxor %ymm8, %ymm10, %ymm10
    vpxor %ymm9, %ymm11, %ymm11
    vbroadcasti128 64+AREION_SYM(asuraRoundConstants)(%rip), %ymm6
    vpxor %ymm10, %ymm6, %ymm6
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm11, %ymm9
    vpxor %ymm8, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm11, %ymm9
    vpxor %ymm8, %ymm2, %ymm2
    vpxor %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %ymm11, %ymm10, %ymm8
    vpblendw $0xcc, %ymm10, %ymm11, %ymm11
    vbroadcasti128 AREION_SYM(asuraConsts)(%rip), %ymm6
    vpshufb %ymm6, %ymm8, %ymm10
    vpshufb %ymm6, %ymm11, %ymm11
    vpcmpgtb %ymm10, %ymm4, %ymm8
    vpcmpgtb %ymm11, %ymm4, %ymm9
    vbroadcasti128 AREION_SYM(asuraGFConsts)(%rip), %ymm6
    vpand %ymm6, %ymm8, %ymm8
    vpand %ymm6, %ymm9, %ymm9
    vpaddb %ymm10, %ymm10, %ymm10
    vpaddb %ymm11, %ymm11, %ymm11
    vpxor %ymm8, %ymm10, %ymm10
    vpxor %ymm9, %ymm11, %ymm11
    vbroadcasti128 80+AREION_SYM(asuraRoundConstants)(%rip), %ymm6
    vpxor %ymm10, %ymm6, %ymm6
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm11, %ymm9
    vaesdec %ymm8, %ymm0, %ymm0
    vaesdec %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm11, %ymm9
    vaesdec %ymm8, %ymm2, %ymm2
    vaesdec %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm5, %ymm0, %ymm8
    vpshufb %ymm5, %ymm1, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm0
    vpunpckhqdq %ymm9, %ymm8, %ymm1
    vpshufb %ymm5, %ymm2, %ymm8
    vpshufb %ymm5, %ymm3, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm2
    vpunpckhqdq %ymm9, %ymm8, %ymm3
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %ymm11, %ymm10, %ymm8
    vpblendw $0xcc, %ymm10, %ymm11, %ymm11
    vbroadcasti128 AREION_SYM(asuraConsts)(%rip), %ymm6
    vpshufb %ymm6, %ymm8, %ymm10
    vpshufb %ymm6, %ymm11, %ymm11
    vpcmpgtb %ymm10, %ymm4, %ymm8
    vpcmpgtb %ymm11, %ymm4, %ymm9
    vbroadcasti128 AREION_SYM(asuraGFConsts)(%rip), %ymm6
    vpand %ymm6, %ymm8, %ymm8
    vpand %ymm6, %ymm9, %ymm9
    vpaddb %ymm10, %ymm10, %ymm10
    vpaddb %ymm11, %ymm11, %ymm11
    vpxor %ymm8, %ymm10, %ymm10
    vpxor %ymm9, %ymm11, %ymm11
    vbroadcasti128 96+AREION_SYM(asuraRoundConstants)(%rip), %ymm6
    vpxor %ymm10, %ymm6, %ymm6
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm11, %ymm9
    vpxor %ymm8, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm11, %ymm9
    vpxor %ymm8, %ymm2, %ymm2
    vpxor %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %ymm11, %ymm10, %ymm8
    vpblendw $0xcc, %ymm10, %ymm11, %ymm11
    vbroadcasti128 AREION_SYM(asuraConsts)(%rip), %ymm6
    vpshufb %ymm6, %ymm8, %ymm10
    vpshufb %ymm6, %ymm11, %ymm11
    vpcmpgtb %ymm10, %ymm4, %ymm8
    vpcmpgtb %ymm11, %ymm4, %ymm9
    vbroadcasti128 AREION_SYM(asuraGFConsts)(%rip), %ymm6
    vpand %ymm6, %ymm8, %ymm8
    vpand %ymm6, %ymm9, %ymm9
    vpaddb %ymm10, %ymm10, %ymm10
    vpaddb %ymm11, %ymm11, %ymm11
    vpxor %ymm8, %ymm10, %ymm10
    vpxor %ymm9, %ymm11, %ymm11
    vbroadcasti128 112+AREION_SYM(asuraRoundConstants)(%rip), %ymm6
    vpxor %ymm10, %ymm6, %ymm6
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm11, %ymm9
    vaesdec %ymm8, %ymm0, %ymm0
    vaesdec %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm11, %ymm9
    vaesdec %ymm8, %ymm2, %ymm2
    vaesdec %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm5, %ymm0, %ymm8
    vpshufb %ymm5, %ymm1, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm0
    vpunpckhqdq %ymm9, %ymm8, %ymm1
    vpshufb %ymm5, %ymm2, %ymm8
    vpshufb %ymm5, %ymm3, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm2
    vpunpckhqdq %ymm9, %ymm8, %ymm3
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %ymm11, %ymm10, %ymm8
    vpblendw $0xcc, %ymm10, %ymm11, %ymm11
    vbroadcasti128 AREION_SYM(asuraConsts)(%rip), %ymm6
    vpshufb %ymm6, %ymm8, %ymm10
    vpshufb %ymm6, %ymm11, %ymm11
    vpcmpgtb %ymm10, %ymm4, %ymm8
    vpcmpgtb %ymm11, %ymm4, %ymm9
    vbroadcasti128 AREION_SYM(asuraGFConsts)(%rip), %ymm6
    vpand %ymm6, %ymm8, %ymm8
    vpand %ymm6, %ymm9, %ymm9
    vpaddb %ymm10, %ymm10, %ymm10
    vpaddb %ymm11, %ymm11, %ymm11
    vpxor %ymm8, %ymm10, %ymm10
    vpxor %ymm9, %ymm11, %ymm11
    vbroadcasti128 128+AREION_SYM(asuraRoundConstants)(%rip), %ymm6
    vpxor %ymm10, %ymm6, %ymm6
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm11, %ymm9
    vpxor %ymm8, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm11, %ymm9
    vpxor %ymm8, %ymm2, %ymm2
    vpxor %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %ymm11, %ymm10, %ymm8
    vpblendw $0xcc, %ymm10, %ymm11, %ymm11
    vbroadcasti128 AREION_SYM(asuraConsts)(%rip), %ymm6
    vpshufb %ymm6, %ymm8, %ymm10
    vpshufb %ymm6, %ymm11, %ymm11
    vpcmpgtb %ymm10, %ymm4, %ymm8
    vpcmpgtb %ymm11, %ymm4, %ymm9
    vbroadcasti128 AREION_SYM(asuraGFConsts)(%rip), %ymm6
    vpand %ymm6, %ymm8, %ymm8
    vpand %ymm6, %ymm9, %ymm9
    vpaddb %ymm10, %ymm10, %ymm10
    vpaddb %ymm11, %ymm11, %ymm11
    vpxor %ymm8, %ymm10, %ymm10
    vpxor %ymm9, %ymm11, %ymm11
    vbroadcasti128 144+AREION_SYM(asuraRoundConstants)(%rip), %ymm6
    vpxor %ymm10, %ymm6, %ymm6
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm11, %ymm9
    vaesdec %ymm8, %ymm0, %ymm0
    vaesdec %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm11, %ymm9
    vaesdec %ymm8, %ymm2, %ymm2
    vaesdec %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm5, %ymm0, %ymm8
    vpshufb %ymm5, %ymm1, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm0
    vpunpckhqdq %ymm9, %ymm8, %ymm1
    vpshufb %ymm5, %ymm2, %ymm8
    vpshufb %ymm5, %ymm3, %ymm9
    vpunpcklqdq %ymm9, %ymm8, %ymm2
    vpunpckhqdq %ymm9, %ymm8, %ymm3
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %ymm11, %ymm10, %ymm8
    vpblendw $0xcc, %ymm10, %ymm11, %ymm11
    vbroadcasti128 AREION_SYM(asuraConsts)(%rip), %ymm6
    vpshufb %ymm6, %ymm8, %ymm10
    vpshufb %ymm6, %ymm11, %ymm11
    vpcmpgtb %ymm10, %ymm4, %ymm8
    vpcmpgtb %ymm11, %ymm4, %ymm9
    vbroadcasti128 AREION_SYM(asuraGFConsts)(%rip), %ymm6
    vpand %ymm6, %ymm8, %ymm8
    vpand %ymm6, %ymm9, %ymm9
    vpaddb %ymm10, %ymm10, %ymm10
    vpaddb %ymm11, %ymm11, %ymm11
    vpxor %ymm8, %ymm10, %ymm10
    vpxor %ymm9, %ymm11, %ymm11
    vbroadcasti128 160+AREION_SYM(asuraRoundConstants)(%rip), %ymm6
    vpxor %ymm10, %ymm6, %ymm6
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm11, %ymm9
    vpxor %ymm8, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm11, %ymm9
    vpxor %ymm8, %ymm2, %ymm2
    vpxor %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %ymm11, %ymm10, %ymm8
    vpblendw $0xcc, %ymm10, %ymm11, %ymm11
    vbroadcasti128 AREION_SYM(asuraConsts)(%rip), %ymm6
    vpshufb %ymm6, %ymm8, %ymm10
    vpshufb %ymm6, %ymm11, %ymm11
    vpcmpgtb %ymm10, %ymm4, %ymm8
    vpcmpgtb %ymm11, %ymm4, %ymm9
    vbroadcasti128 AREION_SYM(asuraGFConsts)(%rip), %ymm6
    vpand %ymm6, %ymm8, %ymm8
    vpand %ymm6, %ymm9, %ymm9
    vpaddb %ymm10, %ymm10, %ymm10
    vpaddb %ymm11, %ymm11, %ymm11
    vpxor %ymm8, %ymm10, %ymm10
    vpxor %ymm9, %ymm11, %ymm11
    vbroadcasti128 176+AREION_SYM(asuraRoundConstants)(%rip), %ymm6
    vpxor %ymm10, %ymm6, %ymm6
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm11, %ymm9
    vaesdec %ymm8, %ymm0, %ymm0
    vaesdec %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm11, %ymm9
    vaesdec %ymm8, %ymm2, %ymm2
    vaesdec %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %ymm11, %ymm10, %ymm8
    vpblendw $0xcc, %ymm10, %ymm11, %ymm11
    vbroadcasti128 AREION_SYM(asuraConsts)(%rip), %ymm6
    vpshufb %ymm6, %ymm8, %ymm10
    vpshufb %ymm6, %ymm11, %ymm11
    vpcmpgtb %ymm10, %ymm4, %ymm8
    vpcmpgtb %ymm11, %ymm4, %ymm9
    vbroadcasti128 AREION_SYM(asuraGFConsts)(%rip), %ymm6
    vpand %ymm6, %ymm8, %ymm8
    vpand %ymm6, %ymm9, %ymm9
    vpaddb %ymm10, %ymm10, %ymm10
    vpaddb %ymm11, %ymm11, %ymm11
    vpxor %ymm8, %ymm10, %ymm10
    vpxor %ymm9, %ymm11, %ymm11
    vbroadcasti128 192+AREION_SYM(asuraRoundConstants)(%rip), %ymm6
    vpxor %ymm10, %ymm6, %ymm6
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm11, %ymm9
    vaesenc %ymm8, %ymm0, %ymm0
    vaesdec %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm11, %ymm9
    vaesenc %ymm8, %ymm2, %ymm2
    vaesdec %ymm9, %ymm3, %ymm3
    vperm2i128 $0x20, %ymm1, %ymm0, %ymm6
    vperm2i128 $0x31, %ymm1, %ymm0, %ymm7
    vmovdqu %ymm6, 0(%rdi)
    vmovdqu %ymm7, 32(%rdi)
    vperm2i128 $0x20, %ymm3, %ymm2, %ymm6
    vperm2i128 $0x31, %ymm3, %ymm2, %ymm7
    vmovdqu %ymm6, 64(%rdi)
    vmovdqu %ymm7, 96(%rdi)
    vpxor %ymm0, %ymm0, %ymm0
    vpxor %ymm1, %ymm1, %ymm1
    vpxor %ymm2, %ymm2, %ymm2
    vpxor %ymm3, %ymm3, %ymm3
    vpxor %ymm4, %ymm4, %ymm4
    vpxor %ymm5, %ymm5, %ymm5
    vpxor %ymm6, %ymm6, %ymm6
    vpxor %ymm7, %ymm7, %ymm7
    vpxor %ymm8, %ymm8, %ymm8
    vpxor %ymm9, %ymm9, %ymm9
    vpxor %ymm10, %ymm10, %ymm10
    vpxor %ymm11, %ymm11, %ymm11
    vpxor %ymm12, %ymm12, %ymm12
    vpxor %ymm13, %ymm13, %ymm13
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
    vmovdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    vmovdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    vmovdqu 112(%rsp), %xmm12
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    vmovdqu 128(%rsp), %xmm13
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $152, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion_asura_encrypt_4blocks_otf_vaes256_asm)

AREION_FUNC_START(areion_asura_decrypt_4blocks_otf_vaes256_asm)
#if defined(_WIN64)
    subq $152, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    vmovdqu %xmm11, 96(%rsp)
    vmovdqu %xmm12, 112(%rsp)
    vmovdqu %xmm13, 128(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu 0(%rsi), %ymm6
    vmovdqu 32(%rsi), %ymm7
    vperm2i128 $0x20, %ymm7, %ymm6, %ymm0
    vperm2i128 $0x31, %ymm7, %ymm6, %ymm1
    vmovdqu 64(%rsi), %ymm6
    vmovdqu 96(%rsi), %ymm7
    vperm2i128 $0x20, %ymm7, %ymm6, %ymm2
    vperm2i128 $0x31, %ymm7, %ymm6, %ymm3
    vmovdqu 0(%rdx), %xmm10
    vmovdqu 16(%rdx), %xmm11
    vmovdqu 0(%rcx), %ymm12
    vmovdqu 32(%rcx), %ymm13
    vpxor %ymm4, %ymm4, %ymm4
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm10
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpcmpgtb %xmm10, %xmm4, %xmm8
    vpcmpgtb %xmm11, %xmm4, %xmm9
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpaddb %xmm10, %xmm10, %xmm10
    vpaddb %xmm11, %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm10
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpcmpgtb %xmm10, %xmm4, %xmm8
    vpcmpgtb %xmm11, %xmm4, %xmm9
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpaddb %xmm10, %xmm10, %xmm10
    vpaddb %xmm11, %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm10
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpcmpgtb %xmm10, %xmm4, %xmm8
    vpcmpgtb %xmm11, %xmm4, %xmm9
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpaddb %xmm10, %xmm10, %xmm10
    vpaddb %xmm11, %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm10
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpcmpgtb %xmm10, %xmm4, %xmm8
    vpcmpgtb %xmm11, %xmm4, %xmm9
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpaddb %xmm10, %xmm10, %xmm10
    vpaddb %xmm11, %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm10
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpcmpgtb %xmm10, %xmm4, %xmm8
    vpcmpgtb %xmm11, %xmm4, %xmm9
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpaddb %xmm10, %xmm10, %xmm10
    vpaddb %xmm11, %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm10
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpcmpgtb %xmm10, %xmm4, %xmm8
    vpcmpgtb %xmm11, %xmm4, %xmm9
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpaddb %xmm10, %xmm10, %xmm10
    vpaddb %xmm11, %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm10
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpcmpgtb %xmm10, %xmm4, %xmm8
    vpcmpgtb %xmm11, %xmm4, %xmm9
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpaddb %xmm10, %xmm10, %xmm10
    vpaddb %xmm11, %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm10
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpcmpgtb %xmm10, %xmm4, %xmm8
    vpcmpgtb %xmm11, %xmm4, %xmm9
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpaddb %xmm10, %xmm10, %xmm10
    vpaddb %xmm11, %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm10
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpcmpgtb %xmm10, %xmm4, %xmm8
    vpcmpgtb %xmm11, %xmm4, %xmm9
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpaddb %xmm10, %xmm10, %xmm10
    vpaddb %xmm11, %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm10
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpcmpgtb %xmm10, %xmm4, %xmm8
    vpcmpgtb %xmm11, %xmm4, %xmm9
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpaddb %xmm10, %xmm10, %xmm10
    vpaddb %xmm11, %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm10
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpcmpgtb %xmm10, %xmm4, %xmm8
    vpcmpgtb %xmm11, %xmm4, %xmm9
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpaddb %xmm10, %xmm10, %xmm10
    vpaddb %xmm11, %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vaesenc %ymm4, %ymm12, %ymm12
    vaesenc %ymm4, %ymm13, %ymm13
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm10
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpcmpgtb %xmm10, %xmm4, %xmm8
    vpcmpgtb %xmm11, %xmm4, %xmm9
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpaddb %xmm10, %xmm10, %xmm10
    vpaddb %xmm11, %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vpxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm10, %xmm6
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm11, %ymm11, %ymm7
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm7, %ymm9
    vpxor %ymm8, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm7, %ymm9
    vpxor %ymm8, %ymm2, %ymm2
    vpxor %ymm9, %ymm3, %ymm3
    vaesenclast %ymm4, %ymm12, %ymm12
    vaesdec %ymm4, %ymm12, %ymm12
    vaesdeclast %ymm4, %ymm12, %ymm12
    vaesenclast %ymm4, %ymm13, %ymm13
    vaesdec %ymm4, %ymm13, %ymm13
    vaesdeclast %ymm4, %ymm13, %ymm13
    vpsllw $7, %xmm10, %xmm8
    vpsllw $7, %xmm11, %xmm9
    vpcmpgtb %xmm8, %xmm4, %xmm8
    vpcmpgtb %xmm9, %xmm4, %xmm9
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpsrlw $1, %xmm10, %xmm10
    vpsrlw $1, %xmm11, %xmm11
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm10, %xmm10
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm10, %xmm10
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vmovdqa %xmm8, %xmm10
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm10, %xmm6
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm11, %ymm11, %ymm7
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm7, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm8, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm7, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenclast %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm8, %ymm2, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm9, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm4, %ymm12, %ymm12
    vaesdec %ymm4, %ymm12, %ymm12
    vaesdeclast %ymm4, %ymm12, %ymm12
    vaesenclast %ymm4, %ymm13, %ymm13
    vaesdec %ymm4, %ymm13, %ymm13
    vaesdeclast %ymm4, %ymm13, %ymm13
    vpsllw $7, %xmm10, %xmm8
    vpsllw $7, %xmm11, %xmm9
    vpcmpgtb %xmm8, %xmm4, %xmm8
    vpcmpgtb %xmm9, %xmm4, %xmm9
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpsrlw $1, %xmm10, %xmm10
    vpsrlw $1, %xmm11, %xmm11
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm10, %xmm10
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm10, %xmm10
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vmovdqa %xmm8, %xmm10
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm10, %xmm6
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm11, %ymm11, %ymm7
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm7, %ymm9
    vaesenclast %ymm8, %ymm0, %ymm0
    vaesenclast %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm7, %ymm9
    vaesenclast %ymm8, %ymm2, %ymm2
    vaesenclast %ymm9, %ymm3, %ymm3
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vmovdqa %ymm8, %ymm0
    vpunpcklbw %ymm3, %ymm2, %ymm8
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vmovdqa %ymm8, %ymm2
    vaesenclast %ymm4, %ymm12, %ymm12
    vaesdec %ymm4, %ymm12, %ymm12
    vaesdeclast %ymm4, %ymm12, %ymm12
    vaesenclast %ymm4, %ymm13, %ymm13
    vaesdec %ymm4, %ymm13, %ymm13
    vaesdeclast %ymm4, %ymm13, %ymm13
    vpsllw $7, %xmm10, %xmm8
    vpsllw $7, %xmm11, %xmm9
    vpcmpgtb %xmm8, %xmm4, %xmm8
    vpcmpgtb %xmm9, %xmm4, %xmm9
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpsrlw $1, %xmm10, %xmm10
    vpsrlw $1, %xmm11, %xmm11
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm10, %xmm10
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm10, %xmm10
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vmovdqa %xmm8, %xmm10
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm10, %xmm6
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm11, %ymm11, %ymm7
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm7, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm8, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm7, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenclast %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm8, %ymm2, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm9, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm4, %ymm12, %ymm12
    vaesdec %ymm4, %ymm12, %ymm12
    vaesdeclast %ymm4, %ymm12, %ymm12
    vaesenclast %ymm4, %ymm13, %ymm13
    vaesdec %ymm4, %ymm13, %ymm13
    vaesdeclast %ymm4, %ymm13, %ymm13
    vpsllw $7, %xmm10, %xmm8
    vpsllw $7, %xmm11, %xmm9
    vpcmpgtb %xmm8, %xmm4, %xmm8
    vpcmpgtb %xmm9, %xmm4, %xmm9
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpsrlw $1, %xmm10, %xmm10
    vpsrlw $1, %xmm11, %xmm11
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm10, %xmm10
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm10, %xmm10
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vmovdqa %xmm8, %xmm10
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm10, %xmm6
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm11, %ymm11, %ymm7
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm7, %ymm9
    vaesenclast %ymm8, %ymm0, %ymm0
    vaesenclast %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm7, %ymm9
    vaesenclast %ymm8, %ymm2, %ymm2
    vaesenclast %ymm9, %ymm3, %ymm3
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vmovdqa %ymm8, %ymm0
    vpunpcklbw %ymm3, %ymm2, %ymm8
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vmovdqa %ymm8, %ymm2
    vaesenclast %ymm4, %ymm12, %ymm12
    vaesdec %ymm4, %ymm12, %ymm12
    vaesdeclast %ymm4, %ymm12, %ymm12
    vaesenclast %ymm4, %ymm13, %ymm13
    vaesdec %ymm4, %ymm13, %ymm13
    vaesdeclast %ymm4, %ymm13, %ymm13
    vpsllw $7, %xmm10, %xmm8
    vpsllw $7, %xmm11, %xmm9
    vpcmpgtb %xmm8, %xmm4, %xmm8
    vpcmpgtb %xmm9, %xmm4, %xmm9
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpsrlw $1, %xmm10, %xmm10
    vpsrlw $1, %xmm11, %xmm11
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm10, %xmm10
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm10, %xmm10
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vmovdqa %xmm8, %xmm10
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm10, %xmm6
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm11, %ymm11, %ymm7
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm7, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm8, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm7, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenclast %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm8, %ymm2, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm9, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm4, %ymm12, %ymm12
    vaesdec %ymm4, %ymm12, %ymm12
    vaesdeclast %ymm4, %ymm12, %ymm12
    vaesenclast %ymm4, %ymm13, %ymm13
    vaesdec %ymm4, %ymm13, %ymm13
    vaesdeclast %ymm4, %ymm13, %ymm13
    vpsllw $7, %xmm10, %xmm8
    vpsllw $7, %xmm11, %xmm9
    vpcmpgtb %xmm8, %xmm4, %xmm8
    vpcmpgtb %xmm9, %xmm4, %xmm9
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpsrlw $1, %xmm10, %xmm10
    vpsrlw $1, %xmm11, %xmm11
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm10, %xmm10
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm10, %xmm10
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vmovdqa %xmm8, %xmm10
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm10, %xmm6
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm11, %ymm11, %ymm7
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm7, %ymm9
    vaesenclast %ymm8, %ymm0, %ymm0
    vaesenclast %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm7, %ymm9
    vaesenclast %ymm8, %ymm2, %ymm2
    vaesenclast %ymm9, %ymm3, %ymm3
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vmovdqa %ymm8, %ymm0
    vpunpcklbw %ymm3, %ymm2, %ymm8
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vmovdqa %ymm8, %ymm2
    vaesenclast %ymm4, %ymm12, %ymm12
    vaesdec %ymm4, %ymm12, %ymm12
    vaesdeclast %ymm4, %ymm12, %ymm12
    vaesenclast %ymm4, %ymm13, %ymm13
    vaesdec %ymm4, %ymm13, %ymm13
    vaesdeclast %ymm4, %ymm13, %ymm13
    vpsllw $7, %xmm10, %xmm8
    vpsllw $7, %xmm11, %xmm9
    vpcmpgtb %xmm8, %xmm4, %xmm8
    vpcmpgtb %xmm9, %xmm4, %xmm9
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpsrlw $1, %xmm10, %xmm10
    vpsrlw $1, %xmm11, %xmm11
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm10, %xmm10
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm10, %xmm10
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vmovdqa %xmm8, %xmm10
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm10, %xmm6
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm11, %ymm11, %ymm7
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm7, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm8, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm7, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenclast %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm8, %ymm2, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm9, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm4, %ymm12, %ymm12
    vaesdec %ymm4, %ymm12, %ymm12
    vaesdeclast %ymm4, %ymm12, %ymm12
    vaesenclast %ymm4, %ymm13, %ymm13
    vaesdec %ymm4, %ymm13, %ymm13
    vaesdeclast %ymm4, %ymm13, %ymm13
    vpsllw $7, %xmm10, %xmm8
    vpsllw $7, %xmm11, %xmm9
    vpcmpgtb %xmm8, %xmm4, %xmm8
    vpcmpgtb %xmm9, %xmm4, %xmm9
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpsrlw $1, %xmm10, %xmm10
    vpsrlw $1, %xmm11, %xmm11
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm10, %xmm10
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm10, %xmm10
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vmovdqa %xmm8, %xmm10
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm10, %xmm6
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm11, %ymm11, %ymm7
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm7, %ymm9
    vaesenclast %ymm8, %ymm0, %ymm0
    vaesenclast %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm7, %ymm9
    vaesenclast %ymm8, %ymm2, %ymm2
    vaesenclast %ymm9, %ymm3, %ymm3
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vmovdqa %ymm8, %ymm0
    vpunpcklbw %ymm3, %ymm2, %ymm8
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vmovdqa %ymm8, %ymm2
    vaesenclast %ymm4, %ymm12, %ymm12
    vaesdec %ymm4, %ymm12, %ymm12
    vaesdeclast %ymm4, %ymm12, %ymm12
    vaesenclast %ymm4, %ymm13, %ymm13
    vaesdec %ymm4, %ymm13, %ymm13
    vaesdeclast %ymm4, %ymm13, %ymm13
    vpsllw $7, %xmm10, %xmm8
    vpsllw $7, %xmm11, %xmm9
    vpcmpgtb %xmm8, %xmm4, %xmm8
    vpcmpgtb %xmm9, %xmm4, %xmm9
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpsrlw $1, %xmm10, %xmm10
    vpsrlw $1, %xmm11, %xmm11
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm10, %xmm10
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm10, %xmm10
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vmovdqa %xmm8, %xmm10
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm10, %xmm6
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm11, %ymm11, %ymm7
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm7, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm8, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm7, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenclast %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm8, %ymm2, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm9, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm4, %ymm12, %ymm12
    vaesdec %ymm4, %ymm12, %ymm12
    vaesdeclast %ymm4, %ymm12, %ymm12
    vaesenclast %ymm4, %ymm13, %ymm13
    vaesdec %ymm4, %ymm13, %ymm13
    vaesdeclast %ymm4, %ymm13, %ymm13
    vpsllw $7, %xmm10, %xmm8
    vpsllw $7, %xmm11, %xmm9
    vpcmpgtb %xmm8, %xmm4, %xmm8
    vpcmpgtb %xmm9, %xmm4, %xmm9
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpsrlw $1, %xmm10, %xmm10
    vpsrlw $1, %xmm11, %xmm11
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm10, %xmm10
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm10, %xmm10
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vmovdqa %xmm8, %xmm10
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm10, %xmm6
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm11, %ymm11, %ymm7
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm7, %ymm9
    vaesenclast %ymm8, %ymm0, %ymm0
    vaesenclast %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm7, %ymm9
    vaesenclast %ymm8, %ymm2, %ymm2
    vaesenclast %ymm9, %ymm3, %ymm3
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vmovdqa %ymm8, %ymm0
    vpunpcklbw %ymm3, %ymm2, %ymm8
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vmovdqa %ymm8, %ymm2
    vaesenclast %ymm4, %ymm12, %ymm12
    vaesdec %ymm4, %ymm12, %ymm12
    vaesdeclast %ymm4, %ymm12, %ymm12
    vaesenclast %ymm4, %ymm13, %ymm13
    vaesdec %ymm4, %ymm13, %ymm13
    vaesdeclast %ymm4, %ymm13, %ymm13
    vpsllw $7, %xmm10, %xmm8
    vpsllw $7, %xmm11, %xmm9
    vpcmpgtb %xmm8, %xmm4, %xmm8
    vpcmpgtb %xmm9, %xmm4, %xmm9
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpsrlw $1, %xmm10, %xmm10
    vpsrlw $1, %xmm11, %xmm11
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm10, %xmm10
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm10, %xmm10
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vmovdqa %xmm8, %xmm10
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm10, %xmm6
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm11, %ymm11, %ymm7
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm7, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm8, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm7, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenclast %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm8, %ymm2, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm9, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm4, %ymm12, %ymm12
    vaesdec %ymm4, %ymm12, %ymm12
    vaesdeclast %ymm4, %ymm12, %ymm12
    vaesenclast %ymm4, %ymm13, %ymm13
    vaesdec %ymm4, %ymm13, %ymm13
    vaesdeclast %ymm4, %ymm13, %ymm13
    vpsllw $7, %xmm10, %xmm8
    vpsllw $7, %xmm11, %xmm9
    vpcmpgtb %xmm8, %xmm4, %xmm8
    vpcmpgtb %xmm9, %xmm4, %xmm9
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpsrlw $1, %xmm10, %xmm10
    vpsrlw $1, %xmm11, %xmm11
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm10, %xmm10
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm11, %xmm11
    vpxor %xmm8, %xmm10, %xmm10
    vpxor %xmm9, %xmm11, %xmm11
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm10, %xmm10
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm11, %xmm11
    vpblendw $0xcc, %xmm11, %xmm10, %xmm8
    vpblendw $0xcc, %xmm10, %xmm11, %xmm11
    vmovdqa %xmm8, %xmm10
    vpxor AREION_SYM(asuraRoundConstants)(%rip), %xmm10, %xmm6
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm11, %ymm11, %ymm7
    vpxor %ymm12, %ymm6, %ymm8
    vpxor %ymm12, %ymm7, %ymm9
    vaesenclast %ymm8, %ymm0, %ymm0
    vaesenclast %ymm9, %ymm1, %ymm1
    vpxor %ymm13, %ymm6, %ymm8
    vpxor %ymm13, %ymm7, %ymm9
    vaesenclast %ymm8, %ymm2, %ymm2
    vaesenclast %ymm9, %ymm3, %ymm3
    vperm2i128 $0x20, %ymm1, %ymm0, %ymm6
    vperm2i128 $0x31, %ymm1, %ymm0, %ymm7
    vmovdqu %ymm6, 0(%rdi)
    vmovdqu %ymm7, 32(%rdi)
    vperm2i128 $0x20, %ymm3, %ymm2, %ymm6
    vperm2i128 $0x31, %ymm3, %ymm2, %ymm7
    vmovdqu %ymm6, 64(%rdi)
    vmovdqu %ymm7, 96(%rdi)
    vpxor %ymm0, %ymm0, %ymm0
    vpxor %ymm1, %ymm1, %ymm1
    vpxor %ymm2, %ymm2, %ymm2
    vpxor %ymm3, %ymm3, %ymm3
    vpxor %ymm4, %ymm4, %ymm4
    vpxor %ymm5, %ymm5, %ymm5
    vpxor %ymm6, %ymm6, %ymm6
    vpxor %ymm7, %ymm7, %ymm7
    vpxor %ymm8, %ymm8, %ymm8
    vpxor %ymm9, %ymm9, %ymm9
    vpxor %ymm10, %ymm10, %ymm10
    vpxor %ymm11, %ymm11, %ymm11
    vpxor %ymm12, %ymm12, %ymm12
    vpxor %ymm13, %ymm13, %ymm13
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
    vmovdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    vmovdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    vmovdqu 112(%rsp), %xmm12
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    vmovdqu 128(%rsp), %xmm13
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $152, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion_asura_decrypt_4blocks_otf_vaes256_asm)

AREION_FUNC_START(areion_asura_encrypt_4blocks_vaes512_asm)
#if defined(_WIN64)
    subq $56, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
#endif
    vmovdqu64 0(%rsi), %zmm6
    vmovdqu64 64(%rsi), %zmm7
    vshufi64x2 $0x88, %zmm7, %zmm6, %zmm0
    vshufi64x2 $0xDD, %zmm7, %zmm6, %zmm1
    vpxorq %zmm2, %zmm2, %zmm2
    vbroadcasti32x4 64+AREION_SYM(asuraConsts)(%rip), %zmm3
    vbroadcasti32x4 0(%rdx), %zmm4
    vbroadcasti32x4 16(%rdx), %zmm5
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 32(%rdx), %zmm4
    vbroadcasti32x4 48(%rdx), %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm6
    vpshufb %zmm3, %zmm1, %zmm7
    vpunpcklqdq %zmm7, %zmm6, %zmm0
    vpunpckhqdq %zmm7, %zmm6, %zmm1
    vbroadcasti32x4 64(%rdx), %zmm4
    vbroadcasti32x4 80(%rdx), %zmm5
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 96(%rdx), %zmm4
    vbroadcasti32x4 112(%rdx), %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm6
    vpshufb %zmm3, %zmm1, %zmm7
    vpunpcklqdq %zmm7, %zmm6, %zmm0
    vpunpckhqdq %zmm7, %zmm6, %zmm1
    vbroadcasti32x4 128(%rdx), %zmm4
    vbroadcasti32x4 144(%rdx), %zmm5
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 160(%rdx), %zmm4
    vbroadcasti32x4 176(%rdx), %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm6
    vpshufb %zmm3, %zmm1, %zmm7
    vpunpcklqdq %zmm7, %zmm6, %zmm0
    vpunpckhqdq %zmm7, %zmm6, %zmm1
    vbroadcasti32x4 192(%rdx), %zmm4
    vbroadcasti32x4 208(%rdx), %zmm5
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 224(%rdx), %zmm4
    vbroadcasti32x4 240(%rdx), %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm6
    vpshufb %zmm3, %zmm1, %zmm7
    vpunpcklqdq %zmm7, %zmm6, %zmm0
    vpunpckhqdq %zmm7, %zmm6, %zmm1
    vbroadcasti32x4 256(%rdx), %zmm4
    vbroadcasti32x4 272(%rdx), %zmm5
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 288(%rdx), %zmm4
    vbroadcasti32x4 304(%rdx), %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm6
    vpshufb %zmm3, %zmm1, %zmm7
    vpunpcklqdq %zmm7, %zmm6, %zmm0
    vpunpckhqdq %zmm7, %zmm6, %zmm1
    vbroadcasti32x4 320(%rdx), %zmm4
    vbroadcasti32x4 336(%rdx), %zmm5
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 352(%rdx), %zmm4
    vbroadcasti32x4 368(%rdx), %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 384(%rdx), %zmm4
    vbroadcasti32x4 400(%rdx), %zmm5
    vaesenc %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vshufi64x2 $0x44, %zmm1, %zmm0, %zmm6
    vshufi64x2 $0xD8, %zmm6, %zmm6, %zmm6
    vshufi64x2 $0xEE, %zmm1, %zmm0, %zmm7
    vshufi64x2 $0xD8, %zmm7, %zmm7, %zmm7
    vmovdqu64 %zmm6, 0(%rdi)
    vmovdqu64 %zmm7, 64(%rdi)
    vpxorq %zmm0, %zmm0, %zmm0
    vpxorq %zmm1, %zmm1, %zmm1
    vpxorq %zmm2, %zmm2, %zmm2
    vpxorq %zmm3, %zmm3, %zmm3
    vpxorq %zmm4, %zmm4, %zmm4
    vpxorq %zmm5, %zmm5, %zmm5
    vpxorq %zmm6, %zmm6, %zmm6
    vpxorq %zmm7, %zmm7, %zmm7
#if defined(_WIN64)
    vmovdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm7
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $56, %rsp
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion_asura_encrypt_4blocks_vaes512_asm)

AREION_FUNC_START(areion_asura_decrypt_4blocks_vaes512_asm)
#if defined(_WIN64)
    subq $56, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
#endif
    vmovdqu64 0(%rsi), %zmm6
    vmovdqu64 64(%rsi), %zmm7
    vshufi64x2 $0x88, %zmm7, %zmm6, %zmm0
    vshufi64x2 $0xDD, %zmm7, %zmm6, %zmm1
    vpxorq %zmm2, %zmm2, %zmm2
    vbroadcasti32x4 384(%rdx), %zmm4
    vbroadcasti32x4 400(%rdx), %zmm5
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 352(%rdx), %zmm4
    vbroadcasti32x4 368(%rdx), %zmm5
    vaesdeclast %zmm2, %zmm5, %zmm5
    vaesenclast %zmm2, %zmm0, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %zmm2, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 320(%rdx), %zmm4
    vbroadcasti32x4 336(%rdx), %zmm5
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 288(%rdx), %zmm4
    vbroadcasti32x4 304(%rdx), %zmm5
    vaesdeclast %zmm2, %zmm5, %zmm5
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %zmm2, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 256(%rdx), %zmm4
    vbroadcasti32x4 272(%rdx), %zmm5
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 224(%rdx), %zmm4
    vbroadcasti32x4 240(%rdx), %zmm5
    vaesdeclast %zmm2, %zmm5, %zmm5
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %zmm2, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 192(%rdx), %zmm4
    vbroadcasti32x4 208(%rdx), %zmm5
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 160(%rdx), %zmm4
    vbroadcasti32x4 176(%rdx), %zmm5
    vaesdeclast %zmm2, %zmm5, %zmm5
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %zmm2, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 128(%rdx), %zmm4
    vbroadcasti32x4 144(%rdx), %zmm5
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 96(%rdx), %zmm4
    vbroadcasti32x4 112(%rdx), %zmm5
    vaesdeclast %zmm2, %zmm5, %zmm5
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %zmm2, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 64(%rdx), %zmm4
    vbroadcasti32x4 80(%rdx), %zmm5
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 32(%rdx), %zmm4
    vbroadcasti32x4 48(%rdx), %zmm5
    vaesdeclast %zmm2, %zmm5, %zmm5
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %zmm2, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 0(%rdx), %zmm4
    vbroadcasti32x4 16(%rdx), %zmm5
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vshufi64x2 $0x44, %zmm1, %zmm0, %zmm6
    vshufi64x2 $0xD8, %zmm6, %zmm6, %zmm6
    vshufi64x2 $0xEE, %zmm1, %zmm0, %zmm7
    vshufi64x2 $0xD8, %zmm7, %zmm7, %zmm7
    vmovdqu64 %zmm6, 0(%rdi)
    vmovdqu64 %zmm7, 64(%rdi)
    vpxorq %zmm0, %zmm0, %zmm0
    vpxorq %zmm1, %zmm1, %zmm1
    vpxorq %zmm2, %zmm2, %zmm2
    vpxorq %zmm3, %zmm3, %zmm3
    vpxorq %zmm4, %zmm4, %zmm4
    vpxorq %zmm5, %zmm5, %zmm5
    vpxorq %zmm6, %zmm6, %zmm6
    vpxorq %zmm7, %zmm7, %zmm7
#if defined(_WIN64)
    vmovdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm7
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $56, %rsp
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion_asura_decrypt_4blocks_vaes512_asm)

AREION_FUNC_START(areion_asura_encrypt_4blocks_otf_vaes512_asm)
#if defined(_WIN64)
    subq $136, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    vmovdqu %xmm11, 96(%rsp)
    vmovdqu %xmm12, 112(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu64 0(%rsi), %zmm11
    vmovdqu64 64(%rsi), %zmm12
    vshufi64x2 $0x88, %zmm12, %zmm11, %zmm0
    vshufi64x2 $0xDD, %zmm12, %zmm11, %zmm1
    vmovdqu 0(%rdx), %xmm8
    vmovdqu 16(%rdx), %xmm9
    vmovdqu64 0(%rcx), %zmm10
    vpxorq %zmm2, %zmm2, %zmm2
    vbroadcasti32x4 64+AREION_SYM(asuraConsts)(%rip), %zmm3
    vpxor AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm4
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm9, %zmm9, %zmm5
    vpternlogq $0x96, %zmm10, %zmm4, %zmm0
    vpternlogq $0x96, %zmm10, %zmm5, %zmm1
    vaesenc %zmm2, %zmm10, %zmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm2, %xmm6
    vpcmpgtb %xmm9, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm4
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm9, %zmm9, %zmm5
    vpxorq %zmm10, %zmm4, %zmm4
    vpxorq %zmm10, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm11
    vpshufb %zmm3, %zmm1, %zmm12
    vpunpcklqdq %zmm12, %zmm11, %zmm0
    vpunpckhqdq %zmm12, %zmm11, %zmm1
    vaesenc %zmm2, %zmm10, %zmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm2, %xmm6
    vpcmpgtb %xmm9, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm4
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm9, %zmm9, %zmm5
    vpternlogq $0x96, %zmm10, %zmm4, %zmm0
    vpternlogq $0x96, %zmm10, %zmm5, %zmm1
    vaesenc %zmm2, %zmm10, %zmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm2, %xmm6
    vpcmpgtb %xmm9, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm4
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm9, %zmm9, %zmm5
    vpxorq %zmm10, %zmm4, %zmm4
    vpxorq %zmm10, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm11
    vpshufb %zmm3, %zmm1, %zmm12
    vpunpcklqdq %zmm12, %zmm11, %zmm0
    vpunpckhqdq %zmm12, %zmm11, %zmm1
    vaesenc %zmm2, %zmm10, %zmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm2, %xmm6
    vpcmpgtb %xmm9, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm4
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm9, %zmm9, %zmm5
    vpternlogq $0x96, %zmm10, %zmm4, %zmm0
    vpternlogq $0x96, %zmm10, %zmm5, %zmm1
    vaesenc %zmm2, %zmm10, %zmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm2, %xmm6
    vpcmpgtb %xmm9, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm4
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm9, %zmm9, %zmm5
    vpxorq %zmm10, %zmm4, %zmm4
    vpxorq %zmm10, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm11
    vpshufb %zmm3, %zmm1, %zmm12
    vpunpcklqdq %zmm12, %zmm11, %zmm0
    vpunpckhqdq %zmm12, %zmm11, %zmm1
    vaesenc %zmm2, %zmm10, %zmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm2, %xmm6
    vpcmpgtb %xmm9, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm4
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm9, %zmm9, %zmm5
    vpternlogq $0x96, %zmm10, %zmm4, %zmm0
    vpternlogq $0x96, %zmm10, %zmm5, %zmm1
    vaesenc %zmm2, %zmm10, %zmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm2, %xmm6
    vpcmpgtb %xmm9, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm4
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm9, %zmm9, %zmm5
    vpxorq %zmm10, %zmm4, %zmm4
    vpxorq %zmm10, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm11
    vpshufb %zmm3, %zmm1, %zmm12
    vpunpcklqdq %zmm12, %zmm11, %zmm0
    vpunpckhqdq %zmm12, %zmm11, %zmm1
    vaesenc %zmm2, %zmm10, %zmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm2, %xmm6
    vpcmpgtb %xmm9, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm4
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm9, %zmm9, %zmm5
    vpternlogq $0x96, %zmm10, %zmm4, %zmm0
    vpternlogq $0x96, %zmm10, %zmm5, %zmm1
    vaesenc %zmm2, %zmm10, %zmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm2, %xmm6
    vpcmpgtb %xmm9, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm4
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm9, %zmm9, %zmm5
    vpxorq %zmm10, %zmm4, %zmm4
    vpxorq %zmm10, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm11
    vpshufb %zmm3, %zmm1, %zmm12
    vpunpcklqdq %zmm12, %zmm11, %zmm0
    vpunpckhqdq %zmm12, %zmm11, %zmm1
    vaesenc %zmm2, %zmm10, %zmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm2, %xmm6
    vpcmpgtb %xmm9, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm4
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm9, %zmm9, %zmm5
    vpternlogq $0x96, %zmm10, %zmm4, %zmm0
    vpternlogq $0x96, %zmm10, %zmm5, %zmm1
    vaesenc %zmm2, %zmm10, %zmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm2, %xmm6
    vpcmpgtb %xmm9, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm4
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm9, %zmm9, %zmm5
    vpxorq %zmm10, %zmm4, %zmm4
    vpxorq %zmm10, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm10, %zmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm2, %xmm6
    vpcmpgtb %xmm9, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm8, %xmm4
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm9, %zmm9, %zmm5
    vpxorq %zmm10, %zmm4, %zmm4
    vpxorq %zmm10, %zmm5, %zmm5
    vaesenc %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vshufi64x2 $0x44, %zmm1, %zmm0, %zmm11
    vshufi64x2 $0xD8, %zmm11, %zmm11, %zmm11
    vshufi64x2 $0xEE, %zmm1, %zmm0, %zmm12
    vshufi64x2 $0xD8, %zmm12, %zmm12, %zmm12
    vmovdqu64 %zmm11, 0(%rdi)
    vmovdqu64 %zmm12, 64(%rdi)
    vpxorq %zmm0, %zmm0, %zmm0
    vpxorq %zmm1, %zmm1, %zmm1
    vpxorq %zmm2, %zmm2, %zmm2
    vpxorq %zmm3, %zmm3, %zmm3
    vpxorq %zmm4, %zmm4, %zmm4
    vpxorq %zmm5, %zmm5, %zmm5
    vpxorq %zmm6, %zmm6, %zmm6
    vpxorq %zmm7, %zmm7, %zmm7
    vpxorq %zmm8, %zmm8, %zmm8
    vpxorq %zmm9, %zmm9, %zmm9
    vpxorq %zmm10, %zmm10, %zmm10
    vpxorq %zmm11, %zmm11, %zmm11
    vpxorq %zmm12, %zmm12, %zmm12
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
    vmovdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    vmovdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    vmovdqu 112(%rsp), %xmm12
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $136, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion_asura_encrypt_4blocks_otf_vaes512_asm)

AREION_FUNC_START(areion_asura_decrypt_4blocks_otf_vaes512_asm)
#if defined(_WIN64)
    subq $184, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    vmovdqu %xmm11, 96(%rsp)
    vmovdqu %xmm12, 112(%rsp)
    vmovdqu %xmm13, 128(%rsp)
    vmovdqu %xmm14, 144(%rsp)
    vmovdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu64 0(%rsi), %zmm6
    vmovdqu64 64(%rsi), %zmm7
    vshufi64x2 $0x88, %zmm7, %zmm6, %zmm0
    vshufi64x2 $0xDD, %zmm7, %zmm6, %zmm1
    vmovdqu 0(%rdx), %xmm3
    vmovdqu 16(%rdx), %xmm4
    vmovdqu64 0(%rcx), %zmm5
    vpxorq %zmm2, %zmm2, %zmm2
    vpxor AREION_SYM(asuraRoundConstants)(%rip), %xmm3, %xmm6
    vshufi64x2 $0x00, %zmm6, %zmm6, %zmm8
    vshufi64x2 $0x00, %zmm4, %zmm4, %zmm9
    vpxorq %zmm5, %zmm8, %zmm8
    vpxorq %zmm5, %zmm9, %zmm9
    vaesenc %zmm2, %zmm5, %zmm5
    vpblendw $0xcc, %xmm4, %xmm3, %xmm6
    vpblendw $0xcc, %xmm3, %xmm4, %xmm4
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpcmpgtb %xmm3, %xmm2, %xmm6
    vpcmpgtb %xmm4, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm3, %xmm3, %xmm3
    vpaddb %xmm4, %xmm4, %xmm4
    vpxor %xmm6, %xmm3, %xmm3
    vpxor %xmm7, %xmm4, %xmm4
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm3, %xmm6
    vshufi64x2 $0x00, %zmm6, %zmm6, %zmm10
    vshufi64x2 $0x00, %zmm4, %zmm4, %zmm11
    vpxorq %zmm5, %zmm10, %zmm10
    vpxorq %zmm5, %zmm11, %zmm11
    vaesdeclast %zmm2, %zmm11, %zmm11
    vaesenc %zmm2, %zmm11, %zmm11
    vaesenc %zmm2, %zmm5, %zmm5
    vpblendw $0xcc, %xmm4, %xmm3, %xmm6
    vpblendw $0xcc, %xmm3, %xmm4, %xmm4
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpcmpgtb %xmm3, %xmm2, %xmm6
    vpcmpgtb %xmm4, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm3, %xmm3, %xmm3
    vpaddb %xmm4, %xmm4, %xmm4
    vpxor %xmm6, %xmm3, %xmm3
    vpxor %xmm7, %xmm4, %xmm4
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm3, %xmm6
    vshufi64x2 $0x00, %zmm6, %zmm6, %zmm12
    vshufi64x2 $0x00, %zmm4, %zmm4, %zmm13
    vpxorq %zmm5, %zmm12, %zmm12
    vpxorq %zmm5, %zmm13, %zmm13
    vaesenc %zmm2, %zmm5, %zmm5
    vpblendw $0xcc, %xmm4, %xmm3, %xmm6
    vpblendw $0xcc, %xmm3, %xmm4, %xmm4
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpcmpgtb %xmm3, %xmm2, %xmm6
    vpcmpgtb %xmm4, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm3, %xmm3, %xmm3
    vpaddb %xmm4, %xmm4, %xmm4
    vpxor %xmm6, %xmm3, %xmm3
    vpxor %xmm7, %xmm4, %xmm4
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm3, %xmm6
    vshufi64x2 $0x00, %zmm6, %zmm6, %zmm14
    vshufi64x2 $0x00, %zmm4, %zmm4, %zmm15
    vpxorq %zmm5, %zmm14, %zmm14
    vpxorq %zmm5, %zmm15, %zmm15
    vaesdeclast %zmm2, %zmm15, %zmm15
    vaesenc %zmm2, %zmm15, %zmm15
    vaesenc %zmm2, %zmm5, %zmm5
    vpblendw $0xcc, %xmm4, %xmm3, %xmm6
    vpblendw $0xcc, %xmm3, %xmm4, %xmm4
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpcmpgtb %xmm3, %xmm2, %xmm6
    vpcmpgtb %xmm4, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm3, %xmm3, %xmm3
    vpaddb %xmm4, %xmm4, %xmm4
    vpxor %xmm6, %xmm3, %xmm3
    vpxor %xmm7, %xmm4, %xmm4
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm3, %xmm6
    vshufi64x2 $0x00, %zmm6, %zmm6, %zmm16
    vshufi64x2 $0x00, %zmm4, %zmm4, %zmm17
    vpxorq %zmm5, %zmm16, %zmm16
    vpxorq %zmm5, %zmm17, %zmm17
    vaesenc %zmm2, %zmm5, %zmm5
    vpblendw $0xcc, %xmm4, %xmm3, %xmm6
    vpblendw $0xcc, %xmm3, %xmm4, %xmm4
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpcmpgtb %xmm3, %xmm2, %xmm6
    vpcmpgtb %xmm4, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm3, %xmm3, %xmm3
    vpaddb %xmm4, %xmm4, %xmm4
    vpxor %xmm6, %xmm3, %xmm3
    vpxor %xmm7, %xmm4, %xmm4
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm3, %xmm6
    vshufi64x2 $0x00, %zmm6, %zmm6, %zmm18
    vshufi64x2 $0x00, %zmm4, %zmm4, %zmm19
    vpxorq %zmm5, %zmm18, %zmm18
    vpxorq %zmm5, %zmm19, %zmm19
    vaesdeclast %zmm2, %zmm19, %zmm19
    vaesenc %zmm2, %zmm19, %zmm19
    vaesenc %zmm2, %zmm5, %zmm5
    vpblendw $0xcc, %xmm4, %xmm3, %xmm6
    vpblendw $0xcc, %xmm3, %xmm4, %xmm4
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpcmpgtb %xmm3, %xmm2, %xmm6
    vpcmpgtb %xmm4, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm3, %xmm3, %xmm3
    vpaddb %xmm4, %xmm4, %xmm4
    vpxor %xmm6, %xmm3, %xmm3
    vpxor %xmm7, %xmm4, %xmm4
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm3, %xmm6
    vshufi64x2 $0x00, %zmm6, %zmm6, %zmm20
    vshufi64x2 $0x00, %zmm4, %zmm4, %zmm21
    vpxorq %zmm5, %zmm20, %zmm20
    vpxorq %zmm5, %zmm21, %zmm21
    vaesenc %zmm2, %zmm5, %zmm5
    vpblendw $0xcc, %xmm4, %xmm3, %xmm6
    vpblendw $0xcc, %xmm3, %xmm4, %xmm4
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpcmpgtb %xmm3, %xmm2, %xmm6
    vpcmpgtb %xmm4, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm3, %xmm3, %xmm3
    vpaddb %xmm4, %xmm4, %xmm4
    vpxor %xmm6, %xmm3, %xmm3
    vpxor %xmm7, %xmm4, %xmm4
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm3, %xmm6
    vshufi64x2 $0x00, %zmm6, %zmm6, %zmm22
    vshufi64x2 $0x00, %zmm4, %zmm4, %zmm23
    vpxorq %zmm5, %zmm22, %zmm22
    vpxorq %zmm5, %zmm23, %zmm23
    vaesdeclast %zmm2, %zmm23, %zmm23
    vaesenc %zmm2, %zmm23, %zmm23
    vaesenc %zmm2, %zmm5, %zmm5
    vpblendw $0xcc, %xmm4, %xmm3, %xmm6
    vpblendw $0xcc, %xmm3, %xmm4, %xmm4
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpcmpgtb %xmm3, %xmm2, %xmm6
    vpcmpgtb %xmm4, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm3, %xmm3, %xmm3
    vpaddb %xmm4, %xmm4, %xmm4
    vpxor %xmm6, %xmm3, %xmm3
    vpxor %xmm7, %xmm4, %xmm4
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm3, %xmm6
    vshufi64x2 $0x00, %zmm6, %zmm6, %zmm24
    vshufi64x2 $0x00, %zmm4, %zmm4, %zmm25
    vpxorq %zmm5, %zmm24, %zmm24
    vpxorq %zmm5, %zmm25, %zmm25
    vaesenc %zmm2, %zmm5, %zmm5
    vpblendw $0xcc, %xmm4, %xmm3, %xmm6
    vpblendw $0xcc, %xmm3, %xmm4, %xmm4
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpcmpgtb %xmm3, %xmm2, %xmm6
    vpcmpgtb %xmm4, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm3, %xmm3, %xmm3
    vpaddb %xmm4, %xmm4, %xmm4
    vpxor %xmm6, %xmm3, %xmm3
    vpxor %xmm7, %xmm4, %xmm4
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm3, %xmm6
    vshufi64x2 $0x00, %zmm6, %zmm6, %zmm26
    vshufi64x2 $0x00, %zmm4, %zmm4, %zmm27
    vpxorq %zmm5, %zmm26, %zmm26
    vpxorq %zmm5, %zmm27, %zmm27
    vaesdeclast %zmm2, %zmm27, %zmm27
    vaesenc %zmm2, %zmm27, %zmm27
    vaesenc %zmm2, %zmm5, %zmm5
    vpblendw $0xcc, %xmm4, %xmm3, %xmm6
    vpblendw $0xcc, %xmm3, %xmm4, %xmm4
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpcmpgtb %xmm3, %xmm2, %xmm6
    vpcmpgtb %xmm4, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm3, %xmm3, %xmm3
    vpaddb %xmm4, %xmm4, %xmm4
    vpxor %xmm6, %xmm3, %xmm3
    vpxor %xmm7, %xmm4, %xmm4
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm3, %xmm6
    vshufi64x2 $0x00, %zmm6, %zmm6, %zmm28
    vshufi64x2 $0x00, %zmm4, %zmm4, %zmm29
    vpxorq %zmm5, %zmm28, %zmm28
    vpxorq %zmm5, %zmm29, %zmm29
    vaesenc %zmm2, %zmm5, %zmm5
    vpblendw $0xcc, %xmm4, %xmm3, %xmm6
    vpblendw $0xcc, %xmm3, %xmm4, %xmm4
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpcmpgtb %xmm3, %xmm2, %xmm6
    vpcmpgtb %xmm4, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm3, %xmm3, %xmm3
    vpaddb %xmm4, %xmm4, %xmm4
    vpxor %xmm6, %xmm3, %xmm3
    vpxor %xmm7, %xmm4, %xmm4
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm3, %xmm6
    vshufi64x2 $0x00, %zmm6, %zmm6, %zmm30
    vshufi64x2 $0x00, %zmm4, %zmm4, %zmm31
    vpxorq %zmm5, %zmm30, %zmm30
    vpxorq %zmm5, %zmm31, %zmm31
    vaesdeclast %zmm2, %zmm31, %zmm31
    vaesenc %zmm2, %zmm31, %zmm31
    vaesenc %zmm2, %zmm5, %zmm5
    vpblendw $0xcc, %xmm4, %xmm3, %xmm6
    vpblendw $0xcc, %xmm3, %xmm4, %xmm4
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm3
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm4
    vpcmpgtb %xmm3, %xmm2, %xmm6
    vpcmpgtb %xmm4, %xmm2, %xmm7
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpaddb %xmm3, %xmm3, %xmm3
    vpaddb %xmm4, %xmm4, %xmm4
    vpxor %xmm6, %xmm3, %xmm3
    vpxor %xmm7, %xmm4, %xmm4
    vpxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm3, %xmm3
    vshufi64x2 $0x00, %zmm3, %zmm3, %zmm3
    vshufi64x2 $0x00, %zmm4, %zmm4, %zmm4
    vpxorq %zmm5, %zmm3, %zmm3
    vpxorq %zmm5, %zmm4, %zmm4
    vpxorq %zmm3, %zmm0, %zmm0
    vpxorq %zmm4, %zmm1, %zmm1
    vaesenclast %zmm2, %zmm0, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm30, %zmm0, %zmm0
    vaesenc %zmm31, %zmm1, %zmm1
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm28, %zmm0, %zmm0
    vaesenclast %zmm29, %zmm1, %zmm1
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm26, %zmm0, %zmm0
    vaesenc %zmm27, %zmm1, %zmm1
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm24, %zmm0, %zmm0
    vaesenclast %zmm25, %zmm1, %zmm1
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm22, %zmm0, %zmm0
    vaesenc %zmm23, %zmm1, %zmm1
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm20, %zmm0, %zmm0
    vaesenclast %zmm21, %zmm1, %zmm1
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm18, %zmm0, %zmm0
    vaesenc %zmm19, %zmm1, %zmm1
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm16, %zmm0, %zmm0
    vaesenclast %zmm17, %zmm1, %zmm1
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm0, %zmm0
    vaesenc %zmm15, %zmm1, %zmm1
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm12, %zmm0, %zmm0
    vaesenclast %zmm13, %zmm1, %zmm1
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm10, %zmm0, %zmm0
    vaesenc %zmm11, %zmm1, %zmm1
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm8, %zmm0, %zmm0
    vaesenclast %zmm9, %zmm1, %zmm1
    vshufi64x2 $0x44, %zmm1, %zmm0, %zmm6
    vshufi64x2 $0xD8, %zmm6, %zmm6, %zmm6
    vshufi64x2 $0xEE, %zmm1, %zmm0, %zmm7
    vshufi64x2 $0xD8, %zmm7, %zmm7, %zmm7
    vmovdqu64 %zmm6, 0(%rdi)
    vmovdqu64 %zmm7, 64(%rdi)
    vpxorq %zmm0, %zmm0, %zmm0
    vpxorq %zmm1, %zmm1, %zmm1
    vpxorq %zmm2, %zmm2, %zmm2
    vpxorq %zmm3, %zmm3, %zmm3
    vpxorq %zmm4, %zmm4, %zmm4
    vpxorq %zmm5, %zmm5, %zmm5
    vpxorq %zmm6, %zmm6, %zmm6
    vpxorq %zmm7, %zmm7, %zmm7
    vpxorq %zmm8, %zmm8, %zmm8
    vpxorq %zmm9, %zmm9, %zmm9
    vpxorq %zmm10, %zmm10, %zmm10
    vpxorq %zmm11, %zmm11, %zmm11
    vpxorq %zmm12, %zmm12, %zmm12
    vpxorq %zmm13, %zmm13, %zmm13
    vpxorq %zmm14, %zmm14, %zmm14
    vpxorq %zmm15, %zmm15, %zmm15
    vpxorq %zmm16, %zmm16, %zmm16
    vpxorq %zmm17, %zmm17, %zmm17
    vpxorq %zmm18, %zmm18, %zmm18
    vpxorq %zmm19, %zmm19, %zmm19
    vpxorq %zmm20, %zmm20, %zmm20
    vpxorq %zmm21, %zmm21, %zmm21
    vpxorq %zmm22, %zmm22, %zmm22
    vpxorq %zmm23, %zmm23, %zmm23
    vpxorq %zmm24, %zmm24, %zmm24
    vpxorq %zmm25, %zmm25, %zmm25
    vpxorq %zmm26, %zmm26, %zmm26
    vpxorq %zmm27, %zmm27, %zmm27
    vpxorq %zmm28, %zmm28, %zmm28
    vpxorq %zmm29, %zmm29, %zmm29
    vpxorq %zmm30, %zmm30, %zmm30
    vpxorq %zmm31, %zmm31, %zmm31
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
    vmovdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    vmovdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    vmovdqu 112(%rsp), %xmm12
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    vmovdqu 128(%rsp), %xmm13
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    vmovdqu 144(%rsp), %xmm14
    movq $0, 144(%rsp)
    movq $0, 152(%rsp)
    vmovdqu 160(%rsp), %xmm15
    movq $0, 160(%rsp)
    movq $0, 168(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $184, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion_asura_decrypt_4blocks_otf_vaes512_asm)

AREION_FUNC_START(areion_asura_expand_key_aesni_asm)
#if defined(_WIN64)
    subq $24, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
#endif
    movdqu 0(%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    pxor %xmm2, %xmm2
    movdqa %xmm0, %xmm3
    pxor 0+AREION_SYM(asuraRoundConstants)(%rip), %xmm3
    movdqu %xmm3, 0(%rdi)
    movdqu %xmm1, 16(%rdi)
    movdqa %xmm0, %xmm3
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm3, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm2, %xmm3
    movdqa %xmm2, %xmm4
    pcmpgtb %xmm0, %xmm3
    pcmpgtb %xmm1, %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm3, %xmm0
    pxor %xmm4, %xmm1
    movdqa %xmm0, %xmm3
    pxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm3
    movdqu %xmm3, 32(%rdi)
    movdqu %xmm1, 48(%rdi)
    movdqa %xmm0, %xmm3
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm3, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm2, %xmm3
    movdqa %xmm2, %xmm4
    pcmpgtb %xmm0, %xmm3
    pcmpgtb %xmm1, %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm3, %xmm0
    pxor %xmm4, %xmm1
    movdqa %xmm0, %xmm3
    pxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm3
    movdqu %xmm3, 64(%rdi)
    movdqu %xmm1, 80(%rdi)
    movdqa %xmm0, %xmm3
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm3, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm2, %xmm3
    movdqa %xmm2, %xmm4
    pcmpgtb %xmm0, %xmm3
    pcmpgtb %xmm1, %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm3, %xmm0
    pxor %xmm4, %xmm1
    movdqa %xmm0, %xmm3
    pxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm3
    movdqu %xmm3, 96(%rdi)
    movdqu %xmm1, 112(%rdi)
    movdqa %xmm0, %xmm3
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm3, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm2, %xmm3
    movdqa %xmm2, %xmm4
    pcmpgtb %xmm0, %xmm3
    pcmpgtb %xmm1, %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm3, %xmm0
    pxor %xmm4, %xmm1
    movdqa %xmm0, %xmm3
    pxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm3
    movdqu %xmm3, 128(%rdi)
    movdqu %xmm1, 144(%rdi)
    movdqa %xmm0, %xmm3
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm3, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm2, %xmm3
    movdqa %xmm2, %xmm4
    pcmpgtb %xmm0, %xmm3
    pcmpgtb %xmm1, %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm3, %xmm0
    pxor %xmm4, %xmm1
    movdqa %xmm0, %xmm3
    pxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm3
    movdqu %xmm3, 160(%rdi)
    movdqu %xmm1, 176(%rdi)
    movdqa %xmm0, %xmm3
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm3, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm2, %xmm3
    movdqa %xmm2, %xmm4
    pcmpgtb %xmm0, %xmm3
    pcmpgtb %xmm1, %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm3, %xmm0
    pxor %xmm4, %xmm1
    movdqa %xmm0, %xmm3
    pxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm3
    movdqu %xmm3, 192(%rdi)
    movdqu %xmm1, 208(%rdi)
    movdqa %xmm0, %xmm3
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm3, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm2, %xmm3
    movdqa %xmm2, %xmm4
    pcmpgtb %xmm0, %xmm3
    pcmpgtb %xmm1, %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm3, %xmm0
    pxor %xmm4, %xmm1
    movdqa %xmm0, %xmm3
    pxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm3
    movdqu %xmm3, 224(%rdi)
    movdqu %xmm1, 240(%rdi)
    movdqa %xmm0, %xmm3
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm3, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm2, %xmm3
    movdqa %xmm2, %xmm4
    pcmpgtb %xmm0, %xmm3
    pcmpgtb %xmm1, %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm3, %xmm0
    pxor %xmm4, %xmm1
    movdqa %xmm0, %xmm3
    pxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm3
    movdqu %xmm3, 256(%rdi)
    movdqu %xmm1, 272(%rdi)
    movdqa %xmm0, %xmm3
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm3, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm2, %xmm3
    movdqa %xmm2, %xmm4
    pcmpgtb %xmm0, %xmm3
    pcmpgtb %xmm1, %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm3, %xmm0
    pxor %xmm4, %xmm1
    movdqa %xmm0, %xmm3
    pxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm3
    movdqu %xmm3, 288(%rdi)
    movdqu %xmm1, 304(%rdi)
    movdqa %xmm0, %xmm3
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm3, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm2, %xmm3
    movdqa %xmm2, %xmm4
    pcmpgtb %xmm0, %xmm3
    pcmpgtb %xmm1, %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm3, %xmm0
    pxor %xmm4, %xmm1
    movdqa %xmm0, %xmm3
    pxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm3
    movdqu %xmm3, 320(%rdi)
    movdqu %xmm1, 336(%rdi)
    movdqa %xmm0, %xmm3
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm3, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm2, %xmm3
    movdqa %xmm2, %xmm4
    pcmpgtb %xmm0, %xmm3
    pcmpgtb %xmm1, %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm3, %xmm0
    pxor %xmm4, %xmm1
    movdqa %xmm0, %xmm3
    pxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm3
    movdqu %xmm3, 352(%rdi)
    movdqu %xmm1, 368(%rdi)
    movdqa %xmm0, %xmm3
    pblendw $0xcc, %xmm1, %xmm0
    pblendw $0xcc, %xmm3, %xmm1
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm2, %xmm3
    movdqa %xmm2, %xmm4
    pcmpgtb %xmm0, %xmm3
    pcmpgtb %xmm1, %xmm4
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm3
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm4
    paddb %xmm0, %xmm0
    paddb %xmm1, %xmm1
    pxor %xmm3, %xmm0
    pxor %xmm4, %xmm1
    movdqa %xmm0, %xmm3
    pxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm3
    movdqu %xmm3, 384(%rdi)
    movdqu %xmm1, 400(%rdi)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
#if defined(_WIN64)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $24, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_expand_key_aesni_asm)

AREION_FUNC_START(areion_asura_expand_key_vex_asm)
#if defined(_WIN64)
    subq $24, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
#endif
    vmovdqu 0(%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor 0+AREION_SYM(asuraRoundConstants)(%rip), %xmm0, %xmm3
    vmovdqu %xmm3, 0(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vpblendw $0xcc, %xmm1, %xmm0, %xmm3
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm2, %xmm3
    vpcmpgtb %xmm1, %xmm2, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm0, %xmm0
    vpxor %xmm4, %xmm1, %xmm1
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm0, %xmm3
    vmovdqu %xmm3, 32(%rdi)
    vmovdqu %xmm1, 48(%rdi)
    vpblendw $0xcc, %xmm1, %xmm0, %xmm3
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm2, %xmm3
    vpcmpgtb %xmm1, %xmm2, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm0, %xmm0
    vpxor %xmm4, %xmm1, %xmm1
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm0, %xmm3
    vmovdqu %xmm3, 64(%rdi)
    vmovdqu %xmm1, 80(%rdi)
    vpblendw $0xcc, %xmm1, %xmm0, %xmm3
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm2, %xmm3
    vpcmpgtb %xmm1, %xmm2, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm0, %xmm0
    vpxor %xmm4, %xmm1, %xmm1
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm0, %xmm3
    vmovdqu %xmm3, 96(%rdi)
    vmovdqu %xmm1, 112(%rdi)
    vpblendw $0xcc, %xmm1, %xmm0, %xmm3
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm2, %xmm3
    vpcmpgtb %xmm1, %xmm2, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm0, %xmm0
    vpxor %xmm4, %xmm1, %xmm1
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm0, %xmm3
    vmovdqu %xmm3, 128(%rdi)
    vmovdqu %xmm1, 144(%rdi)
    vpblendw $0xcc, %xmm1, %xmm0, %xmm3
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm2, %xmm3
    vpcmpgtb %xmm1, %xmm2, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm0, %xmm0
    vpxor %xmm4, %xmm1, %xmm1
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm0, %xmm3
    vmovdqu %xmm3, 160(%rdi)
    vmovdqu %xmm1, 176(%rdi)
    vpblendw $0xcc, %xmm1, %xmm0, %xmm3
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm2, %xmm3
    vpcmpgtb %xmm1, %xmm2, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm0, %xmm0
    vpxor %xmm4, %xmm1, %xmm1
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm0, %xmm3
    vmovdqu %xmm3, 192(%rdi)
    vmovdqu %xmm1, 208(%rdi)
    vpblendw $0xcc, %xmm1, %xmm0, %xmm3
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm2, %xmm3
    vpcmpgtb %xmm1, %xmm2, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm0, %xmm0
    vpxor %xmm4, %xmm1, %xmm1
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm0, %xmm3
    vmovdqu %xmm3, 224(%rdi)
    vmovdqu %xmm1, 240(%rdi)
    vpblendw $0xcc, %xmm1, %xmm0, %xmm3
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm2, %xmm3
    vpcmpgtb %xmm1, %xmm2, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm0, %xmm0
    vpxor %xmm4, %xmm1, %xmm1
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm0, %xmm3
    vmovdqu %xmm3, 256(%rdi)
    vmovdqu %xmm1, 272(%rdi)
    vpblendw $0xcc, %xmm1, %xmm0, %xmm3
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm2, %xmm3
    vpcmpgtb %xmm1, %xmm2, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm0, %xmm0
    vpxor %xmm4, %xmm1, %xmm1
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm0, %xmm3
    vmovdqu %xmm3, 288(%rdi)
    vmovdqu %xmm1, 304(%rdi)
    vpblendw $0xcc, %xmm1, %xmm0, %xmm3
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm2, %xmm3
    vpcmpgtb %xmm1, %xmm2, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm0, %xmm0
    vpxor %xmm4, %xmm1, %xmm1
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm0, %xmm3
    vmovdqu %xmm3, 320(%rdi)
    vmovdqu %xmm1, 336(%rdi)
    vpblendw $0xcc, %xmm1, %xmm0, %xmm3
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm2, %xmm3
    vpcmpgtb %xmm1, %xmm2, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm0, %xmm0
    vpxor %xmm4, %xmm1, %xmm1
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm0, %xmm3
    vmovdqu %xmm3, 352(%rdi)
    vmovdqu %xmm1, 368(%rdi)
    vpblendw $0xcc, %xmm1, %xmm0, %xmm3
    vpblendw $0xcc, %xmm0, %xmm1, %xmm1
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm0
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm1
    vpcmpgtb %xmm0, %xmm2, %xmm3
    vpcmpgtb %xmm1, %xmm2, %xmm4
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm4, %xmm4
    vpaddb %xmm0, %xmm0, %xmm0
    vpaddb %xmm1, %xmm1, %xmm1
    vpxor %xmm3, %xmm0, %xmm0
    vpxor %xmm4, %xmm1, %xmm1
    vpxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm0, %xmm3
    vmovdqu %xmm3, 384(%rdi)
    vmovdqu %xmm1, 400(%rdi)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
#if defined(_WIN64)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $24, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
#else
    xorq %rdi, %rdi
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_expand_key_vex_asm)

AREION_FUNC_START(areion_asura_encrypt_block_rk_aesni_asm)
#if defined(_WIN64)
    subq $40, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movdqu %xmm6, 16(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu 0(%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    pxor %xmm2, %xmm2
    movdqa 64+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqu 0(%rcx), %xmm6
    movdqu 0(%rdx), %xmm4
    movdqu 16(%rdx), %xmm5
    pxor %xmm6, %xmm4
    pxor %xmm6, %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    aesenc %xmm2, %xmm6
    movdqu 32(%rdx), %xmm4
    movdqu 48(%rdx), %xmm5
    pxor %xmm6, %xmm4
    pxor %xmm6, %xmm5
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesenc %xmm2, %xmm6
    aesenc %xmm2, %xmm0
    aesdec %xmm2, %xmm1
    pshufb %xmm3, %xmm0
    pshufb %xmm3, %xmm1
    movdqa %xmm0, %xmm4
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm4
    movdqa %xmm4, %xmm1
    movdqu 64(%rdx), %xmm4
    movdqu 80(%rdx), %xmm5
    pxor %xmm6, %xmm4
    pxor %xmm6, %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    aesenc %xmm2, %xmm6
    movdqu 96(%rdx), %xmm4
    movdqu 112(%rdx), %xmm5
    pxor %xmm6, %xmm4
    pxor %xmm6, %xmm5
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesenc %xmm2, %xmm6
    aesenc %xmm2, %xmm0
    aesdec %xmm2, %xmm1
    pshufb %xmm3, %xmm0
    pshufb %xmm3, %xmm1
    movdqa %xmm0, %xmm4
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm4
    movdqa %xmm4, %xmm1
    movdqu 128(%rdx), %xmm4
    movdqu 144(%rdx), %xmm5
    pxor %xmm6, %xmm4
    pxor %xmm6, %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    aesenc %xmm2, %xmm6
    movdqu 160(%rdx), %xmm4
    movdqu 176(%rdx), %xmm5
    pxor %xmm6, %xmm4
    pxor %xmm6, %xmm5
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesenc %xmm2, %xmm6
    aesenc %xmm2, %xmm0
    aesdec %xmm2, %xmm1
    pshufb %xmm3, %xmm0
    pshufb %xmm3, %xmm1
    movdqa %xmm0, %xmm4
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm4
    movdqa %xmm4, %xmm1
    movdqu 192(%rdx), %xmm4
    movdqu 208(%rdx), %xmm5
    pxor %xmm6, %xmm4
    pxor %xmm6, %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    aesenc %xmm2, %xmm6
    movdqu 224(%rdx), %xmm4
    movdqu 240(%rdx), %xmm5
    pxor %xmm6, %xmm4
    pxor %xmm6, %xmm5
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesenc %xmm2, %xmm6
    aesenc %xmm2, %xmm0
    aesdec %xmm2, %xmm1
    pshufb %xmm3, %xmm0
    pshufb %xmm3, %xmm1
    movdqa %xmm0, %xmm4
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm4
    movdqa %xmm4, %xmm1
    movdqu 256(%rdx), %xmm4
    movdqu 272(%rdx), %xmm5
    pxor %xmm6, %xmm4
    pxor %xmm6, %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    aesenc %xmm2, %xmm6
    movdqu 288(%rdx), %xmm4
    movdqu 304(%rdx), %xmm5
    pxor %xmm6, %xmm4
    pxor %xmm6, %xmm5
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesenc %xmm2, %xmm6
    aesenc %xmm2, %xmm0
    aesdec %xmm2, %xmm1
    pshufb %xmm3, %xmm0
    pshufb %xmm3, %xmm1
    movdqa %xmm0, %xmm4
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm4
    movdqa %xmm4, %xmm1
    movdqu 320(%rdx), %xmm4
    movdqu 336(%rdx), %xmm5
    pxor %xmm6, %xmm4
    pxor %xmm6, %xmm5
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    aesenc %xmm2, %xmm6
    movdqu 352(%rdx), %xmm4
    movdqu 368(%rdx), %xmm5
    pxor %xmm6, %xmm4
    pxor %xmm6, %xmm5
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesenc %xmm2, %xmm6
    movdqu 384(%rdx), %xmm4
    movdqu 400(%rdx), %xmm5
    pxor %xmm6, %xmm4
    pxor %xmm6, %xmm5
    aesenc %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    movdqu %xmm0, 0(%rdi)
    movdqu %xmm1, 16(%rdi)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    pxor %xmm6, %xmm6
#if defined(_WIN64)
    movdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $40, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r8, %r8
    xorq %r9, %r9
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_encrypt_block_rk_aesni_asm)

AREION_FUNC_START(areion_asura_encrypt_block_rk_vex_asm)
#if defined(_WIN64)
    subq $40, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu 0(%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vmovdqa 64+AREION_SYM(asuraConsts)(%rip), %xmm3
    vmovdqu 0(%rcx), %xmm6
    vmovdqu 0(%rdx), %xmm4
    vmovdqu 16(%rdx), %xmm5
    vpxor %xmm6, %xmm4, %xmm4
    vpxor %xmm6, %xmm5, %xmm5
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm6, %xmm6
    vmovdqu 32(%rdx), %xmm4
    vmovdqu 48(%rdx), %xmm5
    vpxor %xmm6, %xmm4, %xmm4
    vpxor %xmm6, %xmm5, %xmm5
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm6, %xmm6
    vaesenc %xmm2, %xmm0, %xmm0
    vaesdec %xmm2, %xmm1, %xmm1
    vpshufb %xmm3, %xmm0, %xmm4
    vpshufb %xmm3, %xmm1, %xmm5
    vpunpcklqdq %xmm5, %xmm4, %xmm0
    vpunpckhqdq %xmm5, %xmm4, %xmm1
    vmovdqu 64(%rdx), %xmm4
    vmovdqu 80(%rdx), %xmm5
    vpxor %xmm6, %xmm4, %xmm4
    vpxor %xmm6, %xmm5, %xmm5
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm6, %xmm6
    vmovdqu 96(%rdx), %xmm4
    vmovdqu 112(%rdx), %xmm5
    vpxor %xmm6, %xmm4, %xmm4
    vpxor %xmm6, %xmm5, %xmm5
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm6, %xmm6
    vaesenc %xmm2, %xmm0, %xmm0
    vaesdec %xmm2, %xmm1, %xmm1
    vpshufb %xmm3, %xmm0, %xmm4
    vpshufb %xmm3, %xmm1, %xmm5
    vpunpcklqdq %xmm5, %xmm4, %xmm0
    vpunpckhqdq %xmm5, %xmm4, %xmm1
    vmovdqu 128(%rdx), %xmm4
    vmovdqu 144(%rdx), %xmm5
    vpxor %xmm6, %xmm4, %xmm4
    vpxor %xmm6, %xmm5, %xmm5
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm6, %xmm6
    vmovdqu 160(%rdx), %xmm4
    vmovdqu 176(%rdx), %xmm5
    vpxor %xmm6, %xmm4, %xmm4
    vpxor %xmm6, %xmm5, %xmm5
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm6, %xmm6
    vaesenc %xmm2, %xmm0, %xmm0
    vaesdec %xmm2, %xmm1, %xmm1
    vpshufb %xmm3, %xmm0, %xmm4
    vpshufb %xmm3, %xmm1, %xmm5
    vpunpcklqdq %xmm5, %xmm4, %xmm0
    vpunpckhqdq %xmm5, %xmm4, %xmm1
    vmovdqu 192(%rdx), %xmm4
    vmovdqu 208(%rdx), %xmm5
    vpxor %xmm6, %xmm4, %xmm4
    vpxor %xmm6, %xmm5, %xmm5
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm6, %xmm6
    vmovdqu 224(%rdx), %xmm4
    vmovdqu 240(%rdx), %xmm5
    vpxor %xmm6, %xmm4, %xmm4
    vpxor %xmm6, %xmm5, %xmm5
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm6, %xmm6
    vaesenc %xmm2, %xmm0, %xmm0
    vaesdec %xmm2, %xmm1, %xmm1
    vpshufb %xmm3, %xmm0, %xmm4
    vpshufb %xmm3, %xmm1, %xmm5
    vpunpcklqdq %xmm5, %xmm4, %xmm0
    vpunpckhqdq %xmm5, %xmm4, %xmm1
    vmovdqu 256(%rdx), %xmm4
    vmovdqu 272(%rdx), %xmm5
    vpxor %xmm6, %xmm4, %xmm4
    vpxor %xmm6, %xmm5, %xmm5
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm6, %xmm6
    vmovdqu 288(%rdx), %xmm4
    vmovdqu 304(%rdx), %xmm5
    vpxor %xmm6, %xmm4, %xmm4
    vpxor %xmm6, %xmm5, %xmm5
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm6, %xmm6
    vaesenc %xmm2, %xmm0, %xmm0
    vaesdec %xmm2, %xmm1, %xmm1
    vpshufb %xmm3, %xmm0, %xmm4
    vpshufb %xmm3, %xmm1, %xmm5
    vpunpcklqdq %xmm5, %xmm4, %xmm0
    vpunpckhqdq %xmm5, %xmm4, %xmm1
    vmovdqu 320(%rdx), %xmm4
    vmovdqu 336(%rdx), %xmm5
    vpxor %xmm6, %xmm4, %xmm4
    vpxor %xmm6, %xmm5, %xmm5
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm6, %xmm6
    vmovdqu 352(%rdx), %xmm4
    vmovdqu 368(%rdx), %xmm5
    vpxor %xmm6, %xmm4, %xmm4
    vpxor %xmm6, %xmm5, %xmm5
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm6, %xmm6
    vmovdqu 384(%rdx), %xmm4
    vmovdqu 400(%rdx), %xmm5
    vpxor %xmm6, %xmm4, %xmm4
    vpxor %xmm6, %xmm5, %xmm5
    vaesenc %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vmovdqu %xmm0, 0(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
#if defined(_WIN64)
    vmovdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $40, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r8, %r8
    xorq %r9, %r9
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_encrypt_block_rk_vex_asm)

AREION_FUNC_START(areion_asura_decrypt_block_rk_aesni_asm)
#if defined(_WIN64)
    subq $184, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movdqu %xmm6, 16(%rsp)
    movdqu %xmm7, 32(%rsp)
    movdqu %xmm8, 48(%rsp)
    movdqu %xmm9, 64(%rsp)
    movdqu %xmm10, 80(%rsp)
    movdqu %xmm11, 96(%rsp)
    movdqu %xmm12, 112(%rsp)
    movdqu %xmm13, 128(%rsp)
    movdqu %xmm14, 144(%rsp)
    movdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu 0(%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    pxor %xmm2, %xmm2
    movdqu 0(%rcx), %xmm3
    movdqa %xmm3, %xmm6
    aesenc %xmm2, %xmm6
    movdqa %xmm6, %xmm7
    aesenc %xmm2, %xmm7
    movdqa %xmm7, %xmm8
    aesenc %xmm2, %xmm8
    movdqa %xmm8, %xmm9
    aesenc %xmm2, %xmm9
    movdqa %xmm9, %xmm10
    aesenc %xmm2, %xmm10
    movdqa %xmm10, %xmm11
    aesenc %xmm2, %xmm11
    movdqa %xmm11, %xmm12
    aesenc %xmm2, %xmm12
    movdqa %xmm12, %xmm13
    aesenc %xmm2, %xmm13
    movdqa %xmm13, %xmm14
    aesenc %xmm2, %xmm14
    movdqa %xmm14, %xmm15
    aesenc %xmm2, %xmm15
    movdqa %xmm15, %xmm5
    aesenc %xmm2, %xmm5
    movdqa %xmm5, %xmm4
    aesenc %xmm2, %xmm4
    pxor %xmm4, %xmm0
    pxor %xmm4, %xmm1
    movdqu 384(%rdx), %xmm4
    pxor %xmm4, %xmm0
    movdqu 400(%rdx), %xmm4
    pxor %xmm4, %xmm1
    movdqu 352(%rdx), %xmm4
    pxor %xmm5, %xmm4
    aesimc %xmm0, %xmm0
    aesdeclast %xmm2, %xmm1
    aesdeclast %xmm4, %xmm0
    movdqu 368(%rdx), %xmm4
    pxor %xmm5, %xmm4
    aesdeclast %xmm2, %xmm4
    aesenc %xmm2, %xmm1
    aesenc %xmm2, %xmm4
    aesdeclast %xmm2, %xmm0
    aesenc %xmm4, %xmm1
    movdqu 320(%rdx), %xmm4
    movdqu 336(%rdx), %xmm5
    pxor %xmm15, %xmm4
    pxor %xmm15, %xmm5
    aesenc %xmm2, %xmm0
    aesenclast %xmm4, %xmm0
    aesenclast %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm4
    movdqa %xmm4, %xmm1
    movdqu 288(%rdx), %xmm4
    pxor %xmm14, %xmm4
    aesimc %xmm0, %xmm0
    aesdeclast %xmm2, %xmm1
    aesdeclast %xmm4, %xmm0
    movdqu 304(%rdx), %xmm4
    pxor %xmm14, %xmm4
    aesdeclast %xmm2, %xmm4
    aesenc %xmm2, %xmm1
    aesenc %xmm2, %xmm4
    aesdeclast %xmm2, %xmm0
    aesenc %xmm4, %xmm1
    movdqu 256(%rdx), %xmm4
    movdqu 272(%rdx), %xmm5
    pxor %xmm13, %xmm4
    pxor %xmm13, %xmm5
    aesenc %xmm2, %xmm0
    aesenclast %xmm4, %xmm0
    aesenclast %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm4
    movdqa %xmm4, %xmm1
    movdqu 224(%rdx), %xmm4
    pxor %xmm12, %xmm4
    aesimc %xmm0, %xmm0
    aesdeclast %xmm2, %xmm1
    aesdeclast %xmm4, %xmm0
    movdqu 240(%rdx), %xmm4
    pxor %xmm12, %xmm4
    aesdeclast %xmm2, %xmm4
    aesenc %xmm2, %xmm1
    aesenc %xmm2, %xmm4
    aesdeclast %xmm2, %xmm0
    aesenc %xmm4, %xmm1
    movdqu 192(%rdx), %xmm4
    movdqu 208(%rdx), %xmm5
    pxor %xmm11, %xmm4
    pxor %xmm11, %xmm5
    aesenc %xmm2, %xmm0
    aesenclast %xmm4, %xmm0
    aesenclast %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm4
    movdqa %xmm4, %xmm1
    movdqu 160(%rdx), %xmm4
    pxor %xmm10, %xmm4
    aesimc %xmm0, %xmm0
    aesdeclast %xmm2, %xmm1
    aesdeclast %xmm4, %xmm0
    movdqu 176(%rdx), %xmm4
    pxor %xmm10, %xmm4
    aesdeclast %xmm2, %xmm4
    aesenc %xmm2, %xmm1
    aesenc %xmm2, %xmm4
    aesdeclast %xmm2, %xmm0
    aesenc %xmm4, %xmm1
    movdqu 128(%rdx), %xmm4
    movdqu 144(%rdx), %xmm5
    pxor %xmm9, %xmm4
    pxor %xmm9, %xmm5
    aesenc %xmm2, %xmm0
    aesenclast %xmm4, %xmm0
    aesenclast %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm4
    movdqa %xmm4, %xmm1
    movdqu 96(%rdx), %xmm4
    pxor %xmm8, %xmm4
    aesimc %xmm0, %xmm0
    aesdeclast %xmm2, %xmm1
    aesdeclast %xmm4, %xmm0
    movdqu 112(%rdx), %xmm4
    pxor %xmm8, %xmm4
    aesdeclast %xmm2, %xmm4
    aesenc %xmm2, %xmm1
    aesenc %xmm2, %xmm4
    aesdeclast %xmm2, %xmm0
    aesenc %xmm4, %xmm1
    movdqu 64(%rdx), %xmm4
    movdqu 80(%rdx), %xmm5
    pxor %xmm7, %xmm4
    pxor %xmm7, %xmm5
    aesenc %xmm2, %xmm0
    aesenclast %xmm4, %xmm0
    aesenclast %xmm5, %xmm1
    movdqa %xmm0, %xmm4
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm4
    movdqa %xmm4, %xmm1
    movdqu 32(%rdx), %xmm4
    pxor %xmm6, %xmm4
    aesimc %xmm0, %xmm0
    aesdeclast %xmm2, %xmm1
    aesdeclast %xmm4, %xmm0
    movdqu 48(%rdx), %xmm4
    pxor %xmm6, %xmm4
    aesdeclast %xmm2, %xmm4
    aesenc %xmm2, %xmm1
    aesenc %xmm2, %xmm4
    aesdeclast %xmm2, %xmm0
    aesenc %xmm4, %xmm1
    movdqu 0(%rdx), %xmm4
    movdqu 16(%rdx), %xmm5
    pxor %xmm3, %xmm4
    pxor %xmm3, %xmm5
    aesenc %xmm2, %xmm0
    aesenclast %xmm4, %xmm0
    aesenclast %xmm5, %xmm1
    movdqu %xmm0, 0(%rdi)
    movdqu %xmm1, 16(%rdi)
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
    pxor %xmm15, %xmm15
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
    movdqu 160(%rsp), %xmm15
    movq $0, 160(%rsp)
    movq $0, 168(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $184, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r8, %r8
    xorq %r9, %r9
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_decrypt_block_rk_aesni_asm)

AREION_FUNC_START(areion_asura_decrypt_block_rk_vex_asm)
#if defined(_WIN64)
    subq $184, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    vmovdqu %xmm11, 96(%rsp)
    vmovdqu %xmm12, 112(%rsp)
    vmovdqu %xmm13, 128(%rsp)
    vmovdqu %xmm14, 144(%rsp)
    vmovdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu 0(%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vmovdqu 0(%rcx), %xmm3
    vaesenc %xmm2, %xmm3, %xmm6
    vaesenc %xmm2, %xmm6, %xmm7
    vaesenc %xmm2, %xmm7, %xmm8
    vaesenc %xmm2, %xmm8, %xmm9
    vaesenc %xmm2, %xmm9, %xmm10
    vaesenc %xmm2, %xmm10, %xmm11
    vaesenc %xmm2, %xmm11, %xmm12
    vaesenc %xmm2, %xmm12, %xmm13
    vaesenc %xmm2, %xmm13, %xmm14
    vaesenc %xmm2, %xmm14, %xmm15
    vaesenc %xmm2, %xmm15, %xmm5
    vaesenc %xmm2, %xmm5, %xmm4
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm4, %xmm1, %xmm1
    vmovdqu 384(%rdx), %xmm4
    vpxor %xmm4, %xmm0, %xmm0
    vmovdqu 400(%rdx), %xmm4
    vpxor %xmm4, %xmm1, %xmm1
    vmovdqu 352(%rdx), %xmm4
    vpxor %xmm5, %xmm4, %xmm4
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm2, %xmm1, %xmm1
    vaesdeclast %xmm4, %xmm0, %xmm0
    vmovdqu 368(%rdx), %xmm4
    vpxor %xmm5, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm4, %xmm4
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm2, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vmovdqu 320(%rdx), %xmm4
    vmovdqu 336(%rdx), %xmm5
    vpxor %xmm15, %xmm4, %xmm4
    vpxor %xmm15, %xmm5, %xmm5
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenclast %xmm4, %xmm0, %xmm0
    vaesenclast %xmm5, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm4
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqa %xmm4, %xmm0
    vmovdqu 288(%rdx), %xmm4
    vpxor %xmm14, %xmm4, %xmm4
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm2, %xmm1, %xmm1
    vaesdeclast %xmm4, %xmm0, %xmm0
    vmovdqu 304(%rdx), %xmm4
    vpxor %xmm14, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm4, %xmm4
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm2, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vmovdqu 256(%rdx), %xmm4
    vmovdqu 272(%rdx), %xmm5
    vpxor %xmm13, %xmm4, %xmm4
    vpxor %xmm13, %xmm5, %xmm5
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenclast %xmm4, %xmm0, %xmm0
    vaesenclast %xmm5, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm4
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqa %xmm4, %xmm0
    vmovdqu 224(%rdx), %xmm4
    vpxor %xmm12, %xmm4, %xmm4
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm2, %xmm1, %xmm1
    vaesdeclast %xmm4, %xmm0, %xmm0
    vmovdqu 240(%rdx), %xmm4
    vpxor %xmm12, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm4, %xmm4
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm2, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vmovdqu 192(%rdx), %xmm4
    vmovdqu 208(%rdx), %xmm5
    vpxor %xmm11, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenclast %xmm4, %xmm0, %xmm0
    vaesenclast %xmm5, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm4
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqa %xmm4, %xmm0
    vmovdqu 160(%rdx), %xmm4
    vpxor %xmm10, %xmm4, %xmm4
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm2, %xmm1, %xmm1
    vaesdeclast %xmm4, %xmm0, %xmm0
    vmovdqu 176(%rdx), %xmm4
    vpxor %xmm10, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm4, %xmm4
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm2, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vmovdqu 128(%rdx), %xmm4
    vmovdqu 144(%rdx), %xmm5
    vpxor %xmm9, %xmm4, %xmm4
    vpxor %xmm9, %xmm5, %xmm5
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenclast %xmm4, %xmm0, %xmm0
    vaesenclast %xmm5, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm4
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqa %xmm4, %xmm0
    vmovdqu 96(%rdx), %xmm4
    vpxor %xmm8, %xmm4, %xmm4
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm2, %xmm1, %xmm1
    vaesdeclast %xmm4, %xmm0, %xmm0
    vmovdqu 112(%rdx), %xmm4
    vpxor %xmm8, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm4, %xmm4
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm2, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vmovdqu 64(%rdx), %xmm4
    vmovdqu 80(%rdx), %xmm5
    vpxor %xmm7, %xmm4, %xmm4
    vpxor %xmm7, %xmm5, %xmm5
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenclast %xmm4, %xmm0, %xmm0
    vaesenclast %xmm5, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm4
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqa %xmm4, %xmm0
    vmovdqu 32(%rdx), %xmm4
    vpxor %xmm6, %xmm4, %xmm4
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm2, %xmm1, %xmm1
    vaesdeclast %xmm4, %xmm0, %xmm0
    vmovdqu 48(%rdx), %xmm4
    vpxor %xmm6, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm4, %xmm4
    vaesenc %xmm2, %xmm1, %xmm1
    vaesenc %xmm2, %xmm4, %xmm4
    vaesdeclast %xmm2, %xmm0, %xmm0
    vaesenc %xmm4, %xmm1, %xmm1
    vmovdqu 0(%rdx), %xmm4
    vmovdqu 16(%rdx), %xmm5
    vpxor %xmm3, %xmm4, %xmm4
    vpxor %xmm3, %xmm5, %xmm5
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenclast %xmm4, %xmm0, %xmm0
    vaesenclast %xmm5, %xmm1, %xmm1
    vmovdqu %xmm0, 0(%rdi)
    vmovdqu %xmm1, 16(%rdi)
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
    vpxor %xmm15, %xmm15, %xmm15
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
    vmovdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    vmovdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    vmovdqu 112(%rsp), %xmm12
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    vmovdqu 128(%rsp), %xmm13
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    vmovdqu 144(%rsp), %xmm14
    movq $0, 144(%rsp)
    movq $0, 152(%rsp)
    vmovdqu 160(%rsp), %xmm15
    movq $0, 160(%rsp)
    movq $0, 168(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $184, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r8, %r8
    xorq %r9, %r9
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_decrypt_block_rk_vex_asm)

AREION_FUNC_START(areion_asura_encrypt_4blocks_rk_aesni_asm)
#if defined(_WIN64)
    subq $184, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movdqu %xmm6, 16(%rsp)
    movdqu %xmm7, 32(%rsp)
    movdqu %xmm8, 48(%rsp)
    movdqu %xmm9, 64(%rsp)
    movdqu %xmm10, 80(%rsp)
    movdqu %xmm11, 96(%rsp)
    movdqu %xmm12, 112(%rsp)
    movdqu %xmm13, 128(%rsp)
    movdqu %xmm14, 144(%rsp)
    movdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu 0(%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    movdqu 64(%rsi), %xmm4
    movdqu 80(%rsi), %xmm5
    movdqu 96(%rsi), %xmm6
    movdqu 112(%rsi), %xmm7
    pxor %xmm8, %xmm8
    movdqa 64+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqu 0(%rcx), %xmm10
    movdqu 16(%rcx), %xmm11
    movdqu 32(%rcx), %xmm12
    movdqu 48(%rcx), %xmm13
    movdqu 0(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm0
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm2
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm4
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm6
    movdqu 16(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm1
    aesenc %xmm8, %xmm10
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm3
    aesenc %xmm8, %xmm11
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm5
    aesenc %xmm8, %xmm12
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm7
    aesenc %xmm8, %xmm13
    movdqu 32(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm0
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm2
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm4
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm6
    movdqu 48(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm1
    aesenc %xmm8, %xmm10
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm3
    aesenc %xmm8, %xmm11
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm5
    aesenc %xmm8, %xmm12
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm7
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm0
    aesdec %xmm8, %xmm1
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesenc %xmm8, %xmm2
    aesdec %xmm8, %xmm3
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesenc %xmm8, %xmm4
    aesdec %xmm8, %xmm5
    pshufb %xmm9, %xmm4
    pshufb %xmm9, %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesenc %xmm8, %xmm6
    aesdec %xmm8, %xmm7
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    movdqu 64(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm0
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm2
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm4
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm6
    movdqu 80(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm1
    aesenc %xmm8, %xmm10
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm3
    aesenc %xmm8, %xmm11
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm5
    aesenc %xmm8, %xmm12
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm7
    aesenc %xmm8, %xmm13
    movdqu 96(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm0
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm2
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm4
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm6
    movdqu 112(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm1
    aesenc %xmm8, %xmm10
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm3
    aesenc %xmm8, %xmm11
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm5
    aesenc %xmm8, %xmm12
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm7
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm0
    aesdec %xmm8, %xmm1
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesenc %xmm8, %xmm2
    aesdec %xmm8, %xmm3
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesenc %xmm8, %xmm4
    aesdec %xmm8, %xmm5
    pshufb %xmm9, %xmm4
    pshufb %xmm9, %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesenc %xmm8, %xmm6
    aesdec %xmm8, %xmm7
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    movdqu 128(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm0
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm2
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm4
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm6
    movdqu 144(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm1
    aesenc %xmm8, %xmm10
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm3
    aesenc %xmm8, %xmm11
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm5
    aesenc %xmm8, %xmm12
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm7
    aesenc %xmm8, %xmm13
    movdqu 160(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm0
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm2
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm4
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm6
    movdqu 176(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm1
    aesenc %xmm8, %xmm10
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm3
    aesenc %xmm8, %xmm11
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm5
    aesenc %xmm8, %xmm12
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm7
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm0
    aesdec %xmm8, %xmm1
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesenc %xmm8, %xmm2
    aesdec %xmm8, %xmm3
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesenc %xmm8, %xmm4
    aesdec %xmm8, %xmm5
    pshufb %xmm9, %xmm4
    pshufb %xmm9, %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesenc %xmm8, %xmm6
    aesdec %xmm8, %xmm7
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    movdqu 192(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm0
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm2
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm4
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm6
    movdqu 208(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm1
    aesenc %xmm8, %xmm10
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm3
    aesenc %xmm8, %xmm11
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm5
    aesenc %xmm8, %xmm12
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm7
    aesenc %xmm8, %xmm13
    movdqu 224(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm0
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm2
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm4
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm6
    movdqu 240(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm1
    aesenc %xmm8, %xmm10
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm3
    aesenc %xmm8, %xmm11
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm5
    aesenc %xmm8, %xmm12
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm7
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm0
    aesdec %xmm8, %xmm1
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesenc %xmm8, %xmm2
    aesdec %xmm8, %xmm3
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesenc %xmm8, %xmm4
    aesdec %xmm8, %xmm5
    pshufb %xmm9, %xmm4
    pshufb %xmm9, %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesenc %xmm8, %xmm6
    aesdec %xmm8, %xmm7
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    movdqu 256(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm0
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm2
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm4
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm6
    movdqu 272(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm1
    aesenc %xmm8, %xmm10
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm3
    aesenc %xmm8, %xmm11
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm5
    aesenc %xmm8, %xmm12
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm7
    aesenc %xmm8, %xmm13
    movdqu 288(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm0
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm2
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm4
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm6
    movdqu 304(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm1
    aesenc %xmm8, %xmm10
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm3
    aesenc %xmm8, %xmm11
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm5
    aesenc %xmm8, %xmm12
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm7
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm0
    aesdec %xmm8, %xmm1
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesenc %xmm8, %xmm2
    aesdec %xmm8, %xmm3
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesenc %xmm8, %xmm4
    aesdec %xmm8, %xmm5
    pshufb %xmm9, %xmm4
    pshufb %xmm9, %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesenc %xmm8, %xmm6
    aesdec %xmm8, %xmm7
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    movdqu 320(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm0
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm2
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm4
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm6
    movdqu 336(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    pxor %xmm15, %xmm1
    aesenc %xmm8, %xmm10
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    pxor %xmm15, %xmm3
    aesenc %xmm8, %xmm11
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    pxor %xmm15, %xmm5
    aesenc %xmm8, %xmm12
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    pxor %xmm15, %xmm7
    aesenc %xmm8, %xmm13
    movdqu 352(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm0
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm2
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm4
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm6
    movdqu 368(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm1
    aesenc %xmm8, %xmm10
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm3
    aesenc %xmm8, %xmm11
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm5
    aesenc %xmm8, %xmm12
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm7
    aesenc %xmm8, %xmm13
    movdqu 384(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesenc %xmm15, %xmm0
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesenc %xmm15, %xmm2
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesenc %xmm15, %xmm4
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesenc %xmm15, %xmm6
    movdqu 400(%rdx), %xmm14
    movdqa %xmm14, %xmm15
    pxor %xmm10, %xmm15
    aesdec %xmm15, %xmm1
    movdqa %xmm14, %xmm15
    pxor %xmm11, %xmm15
    aesdec %xmm15, %xmm3
    movdqa %xmm14, %xmm15
    pxor %xmm12, %xmm15
    aesdec %xmm15, %xmm5
    movdqa %xmm14, %xmm15
    pxor %xmm13, %xmm15
    aesdec %xmm15, %xmm7
    movdqu %xmm0, 0(%rdi)
    movdqu %xmm1, 16(%rdi)
    movdqu %xmm2, 32(%rdi)
    movdqu %xmm3, 48(%rdi)
    movdqu %xmm4, 64(%rdi)
    movdqu %xmm5, 80(%rdi)
    movdqu %xmm6, 96(%rdi)
    movdqu %xmm7, 112(%rdi)
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
    pxor %xmm15, %xmm15
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
    movdqu 160(%rsp), %xmm15
    movq $0, 160(%rsp)
    movq $0, 168(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $184, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r8, %r8
    xorq %r9, %r9
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_encrypt_4blocks_rk_aesni_asm)

AREION_FUNC_START(areion_asura_encrypt_4blocks_rk_vex_asm)
#if defined(_WIN64)
    subq $184, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    vmovdqu %xmm11, 96(%rsp)
    vmovdqu %xmm12, 112(%rsp)
    vmovdqu %xmm13, 128(%rsp)
    vmovdqu %xmm14, 144(%rsp)
    vmovdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu 0(%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vmovdqu 64(%rsi), %xmm4
    vmovdqu 80(%rsi), %xmm5
    vmovdqu 96(%rsi), %xmm6
    vmovdqu 112(%rsi), %xmm7
    vpxor %xmm8, %xmm8, %xmm8
    vmovdqa 64+AREION_SYM(asuraConsts)(%rip), %xmm9
    vmovdqu 0(%rcx), %xmm10
    vmovdqu 16(%rcx), %xmm11
    vmovdqu 32(%rcx), %xmm12
    vmovdqu 48(%rcx), %xmm13
    vmovdqu 0(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vmovdqu 16(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm1, %xmm1
    vaesenc %xmm8, %xmm10, %xmm10
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm3, %xmm3
    vaesenc %xmm8, %xmm11, %xmm11
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm5, %xmm5
    vaesenc %xmm8, %xmm12, %xmm12
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vaesenc %xmm8, %xmm13, %xmm13
    vmovdqu 32(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm6, %xmm6
    vmovdqu 48(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm1, %xmm1
    vaesenc %xmm8, %xmm10, %xmm10
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm3, %xmm3
    vaesenc %xmm8, %xmm11, %xmm11
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm5, %xmm5
    vaesenc %xmm8, %xmm12, %xmm12
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm7, %xmm7
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm0, %xmm0
    vaesdec %xmm8, %xmm1, %xmm1
    vpshufb %xmm9, %xmm0, %xmm14
    vpshufb %xmm9, %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesdec %xmm8, %xmm3, %xmm3
    vpshufb %xmm9, %xmm2, %xmm14
    vpshufb %xmm9, %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesdec %xmm8, %xmm5, %xmm5
    vpshufb %xmm9, %xmm4, %xmm14
    vpshufb %xmm9, %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesdec %xmm8, %xmm7, %xmm7
    vpshufb %xmm9, %xmm6, %xmm14
    vpshufb %xmm9, %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vmovdqu 64(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vmovdqu 80(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm1, %xmm1
    vaesenc %xmm8, %xmm10, %xmm10
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm3, %xmm3
    vaesenc %xmm8, %xmm11, %xmm11
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm5, %xmm5
    vaesenc %xmm8, %xmm12, %xmm12
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vaesenc %xmm8, %xmm13, %xmm13
    vmovdqu 96(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm6, %xmm6
    vmovdqu 112(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm1, %xmm1
    vaesenc %xmm8, %xmm10, %xmm10
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm3, %xmm3
    vaesenc %xmm8, %xmm11, %xmm11
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm5, %xmm5
    vaesenc %xmm8, %xmm12, %xmm12
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm7, %xmm7
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm0, %xmm0
    vaesdec %xmm8, %xmm1, %xmm1
    vpshufb %xmm9, %xmm0, %xmm14
    vpshufb %xmm9, %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesdec %xmm8, %xmm3, %xmm3
    vpshufb %xmm9, %xmm2, %xmm14
    vpshufb %xmm9, %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesdec %xmm8, %xmm5, %xmm5
    vpshufb %xmm9, %xmm4, %xmm14
    vpshufb %xmm9, %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesdec %xmm8, %xmm7, %xmm7
    vpshufb %xmm9, %xmm6, %xmm14
    vpshufb %xmm9, %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vmovdqu 128(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vmovdqu 144(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm1, %xmm1
    vaesenc %xmm8, %xmm10, %xmm10
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm3, %xmm3
    vaesenc %xmm8, %xmm11, %xmm11
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm5, %xmm5
    vaesenc %xmm8, %xmm12, %xmm12
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vaesenc %xmm8, %xmm13, %xmm13
    vmovdqu 160(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm6, %xmm6
    vmovdqu 176(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm1, %xmm1
    vaesenc %xmm8, %xmm10, %xmm10
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm3, %xmm3
    vaesenc %xmm8, %xmm11, %xmm11
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm5, %xmm5
    vaesenc %xmm8, %xmm12, %xmm12
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm7, %xmm7
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm0, %xmm0
    vaesdec %xmm8, %xmm1, %xmm1
    vpshufb %xmm9, %xmm0, %xmm14
    vpshufb %xmm9, %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesdec %xmm8, %xmm3, %xmm3
    vpshufb %xmm9, %xmm2, %xmm14
    vpshufb %xmm9, %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesdec %xmm8, %xmm5, %xmm5
    vpshufb %xmm9, %xmm4, %xmm14
    vpshufb %xmm9, %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesdec %xmm8, %xmm7, %xmm7
    vpshufb %xmm9, %xmm6, %xmm14
    vpshufb %xmm9, %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vmovdqu 192(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vmovdqu 208(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm1, %xmm1
    vaesenc %xmm8, %xmm10, %xmm10
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm3, %xmm3
    vaesenc %xmm8, %xmm11, %xmm11
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm5, %xmm5
    vaesenc %xmm8, %xmm12, %xmm12
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vaesenc %xmm8, %xmm13, %xmm13
    vmovdqu 224(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm6, %xmm6
    vmovdqu 240(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm1, %xmm1
    vaesenc %xmm8, %xmm10, %xmm10
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm3, %xmm3
    vaesenc %xmm8, %xmm11, %xmm11
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm5, %xmm5
    vaesenc %xmm8, %xmm12, %xmm12
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm7, %xmm7
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm0, %xmm0
    vaesdec %xmm8, %xmm1, %xmm1
    vpshufb %xmm9, %xmm0, %xmm14
    vpshufb %xmm9, %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesdec %xmm8, %xmm3, %xmm3
    vpshufb %xmm9, %xmm2, %xmm14
    vpshufb %xmm9, %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesdec %xmm8, %xmm5, %xmm5
    vpshufb %xmm9, %xmm4, %xmm14
    vpshufb %xmm9, %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesdec %xmm8, %xmm7, %xmm7
    vpshufb %xmm9, %xmm6, %xmm14
    vpshufb %xmm9, %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vmovdqu 256(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vmovdqu 272(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm1, %xmm1
    vaesenc %xmm8, %xmm10, %xmm10
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm3, %xmm3
    vaesenc %xmm8, %xmm11, %xmm11
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm5, %xmm5
    vaesenc %xmm8, %xmm12, %xmm12
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vaesenc %xmm8, %xmm13, %xmm13
    vmovdqu 288(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm6, %xmm6
    vmovdqu 304(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm1, %xmm1
    vaesenc %xmm8, %xmm10, %xmm10
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm3, %xmm3
    vaesenc %xmm8, %xmm11, %xmm11
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm5, %xmm5
    vaesenc %xmm8, %xmm12, %xmm12
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm7, %xmm7
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm0, %xmm0
    vaesdec %xmm8, %xmm1, %xmm1
    vpshufb %xmm9, %xmm0, %xmm14
    vpshufb %xmm9, %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesdec %xmm8, %xmm3, %xmm3
    vpshufb %xmm9, %xmm2, %xmm14
    vpshufb %xmm9, %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesdec %xmm8, %xmm5, %xmm5
    vpshufb %xmm9, %xmm4, %xmm14
    vpshufb %xmm9, %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesdec %xmm8, %xmm7, %xmm7
    vpshufb %xmm9, %xmm6, %xmm14
    vpshufb %xmm9, %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vmovdqu 320(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vmovdqu 336(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vpxor %xmm15, %xmm1, %xmm1
    vaesenc %xmm8, %xmm10, %xmm10
    vpxor %xmm11, %xmm14, %xmm15
    vpxor %xmm15, %xmm3, %xmm3
    vaesenc %xmm8, %xmm11, %xmm11
    vpxor %xmm12, %xmm14, %xmm15
    vpxor %xmm15, %xmm5, %xmm5
    vaesenc %xmm8, %xmm12, %xmm12
    vpxor %xmm13, %xmm14, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vaesenc %xmm8, %xmm13, %xmm13
    vmovdqu 352(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm6, %xmm6
    vmovdqu 368(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm1, %xmm1
    vaesenc %xmm8, %xmm10, %xmm10
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm3, %xmm3
    vaesenc %xmm8, %xmm11, %xmm11
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm5, %xmm5
    vaesenc %xmm8, %xmm12, %xmm12
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm7, %xmm7
    vaesenc %xmm8, %xmm13, %xmm13
    vmovdqu 384(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesenc %xmm15, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm15
    vaesenc %xmm15, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm15
    vaesenc %xmm15, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm15
    vaesenc %xmm15, %xmm6, %xmm6
    vmovdqu 400(%rdx), %xmm14
    vpxor %xmm10, %xmm14, %xmm15
    vaesdec %xmm15, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm15
    vaesdec %xmm15, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm15
    vaesdec %xmm15, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm15
    vaesdec %xmm15, %xmm7, %xmm7
    vmovdqu %xmm0, 0(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vmovdqu %xmm4, 64(%rdi)
    vmovdqu %xmm5, 80(%rdi)
    vmovdqu %xmm6, 96(%rdi)
    vmovdqu %xmm7, 112(%rdi)
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
    vpxor %xmm15, %xmm15, %xmm15
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
    vmovdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    vmovdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    vmovdqu 112(%rsp), %xmm12
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    vmovdqu 128(%rsp), %xmm13
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    vmovdqu 144(%rsp), %xmm14
    movq $0, 144(%rsp)
    movq $0, 152(%rsp)
    vmovdqu 160(%rsp), %xmm15
    movq $0, 160(%rsp)
    movq $0, 168(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $184, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r8, %r8
    xorq %r9, %r9
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_encrypt_4blocks_rk_vex_asm)

AREION_FUNC_START(areion_asura_encrypt_4blocks_rk_vaes256_asm)
#if defined(_WIN64)
    subq $120, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    vmovdqu %xmm11, 96(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu 0(%rsi), %ymm6
    vmovdqu 32(%rsi), %ymm7
    vperm2i128 $0x20, %ymm7, %ymm6, %ymm0
    vperm2i128 $0x31, %ymm7, %ymm6, %ymm1
    vmovdqu 64(%rsi), %ymm6
    vmovdqu 96(%rsi), %ymm7
    vperm2i128 $0x20, %ymm7, %ymm6, %ymm2
    vperm2i128 $0x31, %ymm7, %ymm6, %ymm3
    vpxor %ymm4, %ymm4, %ymm4
    vmovdqa 64+AREION_SYM(asuraConsts)(%rip), %ymm5
    vmovdqu 0(%rcx), %ymm8
    vmovdqu 32(%rcx), %ymm9
    vbroadcasti128 0(%rdx), %ymm6
    vbroadcasti128 16(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vpxor %ymm10, %ymm0, %ymm0
    vpxor %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vpxor %ymm10, %ymm2, %ymm2
    vpxor %ymm11, %ymm3, %ymm3
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vbroadcasti128 32(%rdx), %ymm6
    vbroadcasti128 48(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesdec %ymm10, %ymm0, %ymm0
    vaesdec %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesdec %ymm10, %ymm2, %ymm2
    vaesdec %ymm11, %ymm3, %ymm3
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm5, %ymm0, %ymm6
    vpshufb %ymm5, %ymm1, %ymm7
    vpunpcklqdq %ymm7, %ymm6, %ymm0
    vpunpckhqdq %ymm7, %ymm6, %ymm1
    vpshufb %ymm5, %ymm2, %ymm6
    vpshufb %ymm5, %ymm3, %ymm7
    vpunpcklqdq %ymm7, %ymm6, %ymm2
    vpunpckhqdq %ymm7, %ymm6, %ymm3
    vbroadcasti128 64(%rdx), %ymm6
    vbroadcasti128 80(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vpxor %ymm10, %ymm0, %ymm0
    vpxor %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vpxor %ymm10, %ymm2, %ymm2
    vpxor %ymm11, %ymm3, %ymm3
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vbroadcasti128 96(%rdx), %ymm6
    vbroadcasti128 112(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesdec %ymm10, %ymm0, %ymm0
    vaesdec %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesdec %ymm10, %ymm2, %ymm2
    vaesdec %ymm11, %ymm3, %ymm3
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm5, %ymm0, %ymm6
    vpshufb %ymm5, %ymm1, %ymm7
    vpunpcklqdq %ymm7, %ymm6, %ymm0
    vpunpckhqdq %ymm7, %ymm6, %ymm1
    vpshufb %ymm5, %ymm2, %ymm6
    vpshufb %ymm5, %ymm3, %ymm7
    vpunpcklqdq %ymm7, %ymm6, %ymm2
    vpunpckhqdq %ymm7, %ymm6, %ymm3
    vbroadcasti128 128(%rdx), %ymm6
    vbroadcasti128 144(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vpxor %ymm10, %ymm0, %ymm0
    vpxor %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vpxor %ymm10, %ymm2, %ymm2
    vpxor %ymm11, %ymm3, %ymm3
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vbroadcasti128 160(%rdx), %ymm6
    vbroadcasti128 176(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesdec %ymm10, %ymm0, %ymm0
    vaesdec %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesdec %ymm10, %ymm2, %ymm2
    vaesdec %ymm11, %ymm3, %ymm3
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm5, %ymm0, %ymm6
    vpshufb %ymm5, %ymm1, %ymm7
    vpunpcklqdq %ymm7, %ymm6, %ymm0
    vpunpckhqdq %ymm7, %ymm6, %ymm1
    vpshufb %ymm5, %ymm2, %ymm6
    vpshufb %ymm5, %ymm3, %ymm7
    vpunpcklqdq %ymm7, %ymm6, %ymm2
    vpunpckhqdq %ymm7, %ymm6, %ymm3
    vbroadcasti128 192(%rdx), %ymm6
    vbroadcasti128 208(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vpxor %ymm10, %ymm0, %ymm0
    vpxor %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vpxor %ymm10, %ymm2, %ymm2
    vpxor %ymm11, %ymm3, %ymm3
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vbroadcasti128 224(%rdx), %ymm6
    vbroadcasti128 240(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesdec %ymm10, %ymm0, %ymm0
    vaesdec %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesdec %ymm10, %ymm2, %ymm2
    vaesdec %ymm11, %ymm3, %ymm3
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm5, %ymm0, %ymm6
    vpshufb %ymm5, %ymm1, %ymm7
    vpunpcklqdq %ymm7, %ymm6, %ymm0
    vpunpckhqdq %ymm7, %ymm6, %ymm1
    vpshufb %ymm5, %ymm2, %ymm6
    vpshufb %ymm5, %ymm3, %ymm7
    vpunpcklqdq %ymm7, %ymm6, %ymm2
    vpunpckhqdq %ymm7, %ymm6, %ymm3
    vbroadcasti128 256(%rdx), %ymm6
    vbroadcasti128 272(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vpxor %ymm10, %ymm0, %ymm0
    vpxor %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vpxor %ymm10, %ymm2, %ymm2
    vpxor %ymm11, %ymm3, %ymm3
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vbroadcasti128 288(%rdx), %ymm6
    vbroadcasti128 304(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesdec %ymm10, %ymm0, %ymm0
    vaesdec %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesdec %ymm10, %ymm2, %ymm2
    vaesdec %ymm11, %ymm3, %ymm3
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm5, %ymm0, %ymm6
    vpshufb %ymm5, %ymm1, %ymm7
    vpunpcklqdq %ymm7, %ymm6, %ymm0
    vpunpckhqdq %ymm7, %ymm6, %ymm1
    vpshufb %ymm5, %ymm2, %ymm6
    vpshufb %ymm5, %ymm3, %ymm7
    vpunpcklqdq %ymm7, %ymm6, %ymm2
    vpunpckhqdq %ymm7, %ymm6, %ymm3
    vbroadcasti128 320(%rdx), %ymm6
    vbroadcasti128 336(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vpxor %ymm10, %ymm0, %ymm0
    vpxor %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vpxor %ymm10, %ymm2, %ymm2
    vpxor %ymm11, %ymm3, %ymm3
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vbroadcasti128 352(%rdx), %ymm6
    vbroadcasti128 368(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesdec %ymm10, %ymm0, %ymm0
    vaesdec %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesdec %ymm10, %ymm2, %ymm2
    vaesdec %ymm11, %ymm3, %ymm3
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vbroadcasti128 384(%rdx), %ymm6
    vbroadcasti128 400(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesenc %ymm10, %ymm0, %ymm0
    vaesdec %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesenc %ymm10, %ymm2, %ymm2
    vaesdec %ymm11, %ymm3, %ymm3
    vperm2i128 $0x20, %ymm1, %ymm0, %ymm6
    vperm2i128 $0x31, %ymm1, %ymm0, %ymm7
    vmovdqu %ymm6, 0(%rdi)
    vmovdqu %ymm7, 32(%rdi)
    vperm2i128 $0x20, %ymm3, %ymm2, %ymm6
    vperm2i128 $0x31, %ymm3, %ymm2, %ymm7
    vmovdqu %ymm6, 64(%rdi)
    vmovdqu %ymm7, 96(%rdi)
    vpxor %ymm0, %ymm0, %ymm0
    vpxor %ymm1, %ymm1, %ymm1
    vpxor %ymm2, %ymm2, %ymm2
    vpxor %ymm3, %ymm3, %ymm3
    vpxor %ymm4, %ymm4, %ymm4
    vpxor %ymm5, %ymm5, %ymm5
    vpxor %ymm6, %ymm6, %ymm6
    vpxor %ymm7, %ymm7, %ymm7
    vpxor %ymm8, %ymm8, %ymm8
    vpxor %ymm9, %ymm9, %ymm9
    vpxor %ymm10, %ymm10, %ymm10
    vpxor %ymm11, %ymm11, %ymm11
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
    vmovdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    vmovdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $120, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r8, %r8
    xorq %r9, %r9
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion_asura_encrypt_4blocks_rk_vaes256_asm)

AREION_FUNC_START(areion_asura_encrypt_4blocks_rk_vaes512_asm)
#if defined(_WIN64)
    subq $72, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu64 0(%rsi), %zmm6
    vmovdqu64 64(%rsi), %zmm7
    vshufi64x2 $0x88, %zmm7, %zmm6, %zmm0
    vshufi64x2 $0xDD, %zmm7, %zmm6, %zmm1
    vpxorq %zmm2, %zmm2, %zmm2
    vbroadcasti32x4 64+AREION_SYM(asuraConsts)(%rip), %zmm3
    vmovdqu64 0(%rcx), %zmm8
    vbroadcasti32x4 0(%rdx), %zmm4
    vbroadcasti32x4 16(%rdx), %zmm5
    vpternlogq $0x96, %zmm8, %zmm4, %zmm0
    vpternlogq $0x96, %zmm8, %zmm5, %zmm1
    vaesenc %zmm2, %zmm8, %zmm8
    vbroadcasti32x4 32(%rdx), %zmm4
    vbroadcasti32x4 48(%rdx), %zmm5
    vpxorq %zmm8, %zmm4, %zmm4
    vpxorq %zmm8, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm8, %zmm8
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm6
    vpshufb %zmm3, %zmm1, %zmm7
    vpunpcklqdq %zmm7, %zmm6, %zmm0
    vpunpckhqdq %zmm7, %zmm6, %zmm1
    vbroadcasti32x4 64(%rdx), %zmm4
    vbroadcasti32x4 80(%rdx), %zmm5
    vpternlogq $0x96, %zmm8, %zmm4, %zmm0
    vpternlogq $0x96, %zmm8, %zmm5, %zmm1
    vaesenc %zmm2, %zmm8, %zmm8
    vbroadcasti32x4 96(%rdx), %zmm4
    vbroadcasti32x4 112(%rdx), %zmm5
    vpxorq %zmm8, %zmm4, %zmm4
    vpxorq %zmm8, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm8, %zmm8
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm6
    vpshufb %zmm3, %zmm1, %zmm7
    vpunpcklqdq %zmm7, %zmm6, %zmm0
    vpunpckhqdq %zmm7, %zmm6, %zmm1
    vbroadcasti32x4 128(%rdx), %zmm4
    vbroadcasti32x4 144(%rdx), %zmm5
    vpternlogq $0x96, %zmm8, %zmm4, %zmm0
    vpternlogq $0x96, %zmm8, %zmm5, %zmm1
    vaesenc %zmm2, %zmm8, %zmm8
    vbroadcasti32x4 160(%rdx), %zmm4
    vbroadcasti32x4 176(%rdx), %zmm5
    vpxorq %zmm8, %zmm4, %zmm4
    vpxorq %zmm8, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm8, %zmm8
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm6
    vpshufb %zmm3, %zmm1, %zmm7
    vpunpcklqdq %zmm7, %zmm6, %zmm0
    vpunpckhqdq %zmm7, %zmm6, %zmm1
    vbroadcasti32x4 192(%rdx), %zmm4
    vbroadcasti32x4 208(%rdx), %zmm5
    vpternlogq $0x96, %zmm8, %zmm4, %zmm0
    vpternlogq $0x96, %zmm8, %zmm5, %zmm1
    vaesenc %zmm2, %zmm8, %zmm8
    vbroadcasti32x4 224(%rdx), %zmm4
    vbroadcasti32x4 240(%rdx), %zmm5
    vpxorq %zmm8, %zmm4, %zmm4
    vpxorq %zmm8, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm8, %zmm8
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm6
    vpshufb %zmm3, %zmm1, %zmm7
    vpunpcklqdq %zmm7, %zmm6, %zmm0
    vpunpckhqdq %zmm7, %zmm6, %zmm1
    vbroadcasti32x4 256(%rdx), %zmm4
    vbroadcasti32x4 272(%rdx), %zmm5
    vpternlogq $0x96, %zmm8, %zmm4, %zmm0
    vpternlogq $0x96, %zmm8, %zmm5, %zmm1
    vaesenc %zmm2, %zmm8, %zmm8
    vbroadcasti32x4 288(%rdx), %zmm4
    vbroadcasti32x4 304(%rdx), %zmm5
    vpxorq %zmm8, %zmm4, %zmm4
    vpxorq %zmm8, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm8, %zmm8
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm6
    vpshufb %zmm3, %zmm1, %zmm7
    vpunpcklqdq %zmm7, %zmm6, %zmm0
    vpunpckhqdq %zmm7, %zmm6, %zmm1
    vbroadcasti32x4 320(%rdx), %zmm4
    vbroadcasti32x4 336(%rdx), %zmm5
    vpternlogq $0x96, %zmm8, %zmm4, %zmm0
    vpternlogq $0x96, %zmm8, %zmm5, %zmm1
    vaesenc %zmm2, %zmm8, %zmm8
    vbroadcasti32x4 352(%rdx), %zmm4
    vbroadcasti32x4 368(%rdx), %zmm5
    vpxorq %zmm8, %zmm4, %zmm4
    vpxorq %zmm8, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm8, %zmm8
    vbroadcasti32x4 384(%rdx), %zmm4
    vbroadcasti32x4 400(%rdx), %zmm5
    vpxorq %zmm8, %zmm4, %zmm4
    vpxorq %zmm8, %zmm5, %zmm5
    vaesenc %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vshufi64x2 $0x44, %zmm1, %zmm0, %zmm6
    vshufi64x2 $0xD8, %zmm6, %zmm6, %zmm6
    vshufi64x2 $0xEE, %zmm1, %zmm0, %zmm7
    vshufi64x2 $0xD8, %zmm7, %zmm7, %zmm7
    vmovdqu64 %zmm6, 0(%rdi)
    vmovdqu64 %zmm7, 64(%rdi)
    vpxorq %zmm0, %zmm0, %zmm0
    vpxorq %zmm1, %zmm1, %zmm1
    vpxorq %zmm2, %zmm2, %zmm2
    vpxorq %zmm3, %zmm3, %zmm3
    vpxorq %zmm4, %zmm4, %zmm4
    vpxorq %zmm5, %zmm5, %zmm5
    vpxorq %zmm6, %zmm6, %zmm6
    vpxorq %zmm7, %zmm7, %zmm7
    vpxorq %zmm8, %zmm8, %zmm8
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
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $72, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r8, %r8
    xorq %r9, %r9
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion_asura_encrypt_4blocks_rk_vaes512_asm)

AREION_FUNC_START(areion_asura_decrypt_4blocks_rk_aesni_asm)
#if defined(_WIN64)
    subq $184, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    movdqu %xmm6, 16(%rsp)
    movdqu %xmm7, 32(%rsp)
    movdqu %xmm8, 48(%rsp)
    movdqu %xmm9, 64(%rsp)
    movdqu %xmm10, 80(%rsp)
    movdqu %xmm11, 96(%rsp)
    movdqu %xmm12, 112(%rsp)
    movdqu %xmm13, 128(%rsp)
    movdqu %xmm14, 144(%rsp)
    movdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu 0(%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    movdqu 64(%rsi), %xmm4
    movdqu 80(%rsi), %xmm5
    movdqu 96(%rsi), %xmm6
    movdqu 112(%rsi), %xmm7
    pxor %xmm8, %xmm8
    movdqu 0(%rcx), %xmm10
    movdqu 16(%rcx), %xmm11
    movdqu 32(%rcx), %xmm12
    movdqu 48(%rcx), %xmm13
    aesenc %xmm8, %xmm10
    aesenc %xmm8, %xmm11
    aesenc %xmm8, %xmm12
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm10
    aesenc %xmm8, %xmm11
    aesenc %xmm8, %xmm12
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm10
    aesenc %xmm8, %xmm11
    aesenc %xmm8, %xmm12
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm10
    aesenc %xmm8, %xmm11
    aesenc %xmm8, %xmm12
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm10
    aesenc %xmm8, %xmm11
    aesenc %xmm8, %xmm12
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm10
    aesenc %xmm8, %xmm11
    aesenc %xmm8, %xmm12
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm10
    aesenc %xmm8, %xmm11
    aesenc %xmm8, %xmm12
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm10
    aesenc %xmm8, %xmm11
    aesenc %xmm8, %xmm12
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm10
    aesenc %xmm8, %xmm11
    aesenc %xmm8, %xmm12
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm10
    aesenc %xmm8, %xmm11
    aesenc %xmm8, %xmm12
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm10
    aesenc %xmm8, %xmm11
    aesenc %xmm8, %xmm12
    aesenc %xmm8, %xmm13
    aesenc %xmm8, %xmm10
    aesenc %xmm8, %xmm11
    aesenc %xmm8, %xmm12
    aesenc %xmm8, %xmm13
    movdqu 384(%rdx), %xmm14
    movdqu 400(%rdx), %xmm15
    movdqa %xmm14, %xmm9
    pxor %xmm10, %xmm9
    pxor %xmm9, %xmm0
    movdqa %xmm15, %xmm9
    pxor %xmm10, %xmm9
    pxor %xmm9, %xmm1
    movdqa %xmm14, %xmm9
    pxor %xmm11, %xmm9
    pxor %xmm9, %xmm2
    movdqa %xmm15, %xmm9
    pxor %xmm11, %xmm9
    pxor %xmm9, %xmm3
    movdqa %xmm14, %xmm9
    pxor %xmm12, %xmm9
    pxor %xmm9, %xmm4
    movdqa %xmm15, %xmm9
    pxor %xmm12, %xmm9
    pxor %xmm9, %xmm5
    movdqa %xmm14, %xmm9
    pxor %xmm13, %xmm9
    pxor %xmm9, %xmm6
    movdqa %xmm15, %xmm9
    pxor %xmm13, %xmm9
    pxor %xmm9, %xmm7
    aesimc %xmm10, %xmm10
    aesdeclast %xmm8, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm8, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm8, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm8, %xmm13
    movdqu 352(%rdx), %xmm14
    movdqu 368(%rdx), %xmm15
    movdqa %xmm14, %xmm9
    pxor %xmm10, %xmm9
    aesimc %xmm0, %xmm0
    aesdeclast %xmm9, %xmm0
    movdqa %xmm15, %xmm9
    pxor %xmm10, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm1
    aesenc %xmm8, %xmm1
    aesenc %xmm9, %xmm1
    aesdeclast %xmm8, %xmm0
    aesenc %xmm8, %xmm0
    movdqa %xmm14, %xmm9
    pxor %xmm11, %xmm9
    aesimc %xmm2, %xmm2
    aesdeclast %xmm9, %xmm2
    movdqa %xmm15, %xmm9
    pxor %xmm11, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm3
    aesenc %xmm8, %xmm3
    aesenc %xmm9, %xmm3
    aesdeclast %xmm8, %xmm2
    aesenc %xmm8, %xmm2
    movdqa %xmm14, %xmm9
    pxor %xmm12, %xmm9
    aesimc %xmm4, %xmm4
    aesdeclast %xmm9, %xmm4
    movdqa %xmm15, %xmm9
    pxor %xmm12, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm5
    aesenc %xmm8, %xmm5
    aesenc %xmm9, %xmm5
    aesdeclast %xmm8, %xmm4
    aesenc %xmm8, %xmm4
    movdqa %xmm14, %xmm9
    pxor %xmm13, %xmm9
    aesimc %xmm6, %xmm6
    aesdeclast %xmm9, %xmm6
    movdqa %xmm15, %xmm9
    pxor %xmm13, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm7
    aesenc %xmm8, %xmm7
    aesenc %xmm9, %xmm7
    aesdeclast %xmm8, %xmm6
    aesenc %xmm8, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm8, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm8, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm8, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm8, %xmm13
    movdqu 320(%rdx), %xmm14
    movdqu 336(%rdx), %xmm15
    movdqa %xmm14, %xmm9
    pxor %xmm10, %xmm9
    aesenclast %xmm9, %xmm0
    movdqa %xmm15, %xmm9
    pxor %xmm10, %xmm9
    aesenclast %xmm9, %xmm1
    movdqa %xmm14, %xmm9
    pxor %xmm11, %xmm9
    aesenclast %xmm9, %xmm2
    movdqa %xmm15, %xmm9
    pxor %xmm11, %xmm9
    aesenclast %xmm9, %xmm3
    movdqa %xmm14, %xmm9
    pxor %xmm12, %xmm9
    aesenclast %xmm9, %xmm4
    movdqa %xmm15, %xmm9
    pxor %xmm12, %xmm9
    aesenclast %xmm9, %xmm5
    movdqa %xmm14, %xmm9
    pxor %xmm13, %xmm9
    aesenclast %xmm9, %xmm6
    movdqa %xmm15, %xmm9
    pxor %xmm13, %xmm9
    aesenclast %xmm9, %xmm7
    movdqa %xmm0, %xmm9
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm9
    movdqa %xmm9, %xmm1
    movdqa %xmm2, %xmm9
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm9
    movdqa %xmm9, %xmm3
    movdqa %xmm4, %xmm9
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm9
    movdqa %xmm9, %xmm5
    movdqa %xmm6, %xmm9
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm9
    movdqa %xmm9, %xmm7
    aesimc %xmm10, %xmm10
    aesdeclast %xmm8, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm8, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm8, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm8, %xmm13
    movdqu 288(%rdx), %xmm14
    movdqu 304(%rdx), %xmm15
    movdqa %xmm14, %xmm9
    pxor %xmm10, %xmm9
    aesimc %xmm0, %xmm0
    aesdeclast %xmm9, %xmm0
    movdqa %xmm15, %xmm9
    pxor %xmm10, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm1
    aesenc %xmm8, %xmm1
    aesenc %xmm9, %xmm1
    aesdeclast %xmm8, %xmm0
    aesenc %xmm8, %xmm0
    movdqa %xmm14, %xmm9
    pxor %xmm11, %xmm9
    aesimc %xmm2, %xmm2
    aesdeclast %xmm9, %xmm2
    movdqa %xmm15, %xmm9
    pxor %xmm11, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm3
    aesenc %xmm8, %xmm3
    aesenc %xmm9, %xmm3
    aesdeclast %xmm8, %xmm2
    aesenc %xmm8, %xmm2
    movdqa %xmm14, %xmm9
    pxor %xmm12, %xmm9
    aesimc %xmm4, %xmm4
    aesdeclast %xmm9, %xmm4
    movdqa %xmm15, %xmm9
    pxor %xmm12, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm5
    aesenc %xmm8, %xmm5
    aesenc %xmm9, %xmm5
    aesdeclast %xmm8, %xmm4
    aesenc %xmm8, %xmm4
    movdqa %xmm14, %xmm9
    pxor %xmm13, %xmm9
    aesimc %xmm6, %xmm6
    aesdeclast %xmm9, %xmm6
    movdqa %xmm15, %xmm9
    pxor %xmm13, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm7
    aesenc %xmm8, %xmm7
    aesenc %xmm9, %xmm7
    aesdeclast %xmm8, %xmm6
    aesenc %xmm8, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm8, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm8, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm8, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm8, %xmm13
    movdqu 256(%rdx), %xmm14
    movdqu 272(%rdx), %xmm15
    movdqa %xmm14, %xmm9
    pxor %xmm10, %xmm9
    aesenclast %xmm9, %xmm0
    movdqa %xmm15, %xmm9
    pxor %xmm10, %xmm9
    aesenclast %xmm9, %xmm1
    movdqa %xmm14, %xmm9
    pxor %xmm11, %xmm9
    aesenclast %xmm9, %xmm2
    movdqa %xmm15, %xmm9
    pxor %xmm11, %xmm9
    aesenclast %xmm9, %xmm3
    movdqa %xmm14, %xmm9
    pxor %xmm12, %xmm9
    aesenclast %xmm9, %xmm4
    movdqa %xmm15, %xmm9
    pxor %xmm12, %xmm9
    aesenclast %xmm9, %xmm5
    movdqa %xmm14, %xmm9
    pxor %xmm13, %xmm9
    aesenclast %xmm9, %xmm6
    movdqa %xmm15, %xmm9
    pxor %xmm13, %xmm9
    aesenclast %xmm9, %xmm7
    movdqa %xmm0, %xmm9
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm9
    movdqa %xmm9, %xmm1
    movdqa %xmm2, %xmm9
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm9
    movdqa %xmm9, %xmm3
    movdqa %xmm4, %xmm9
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm9
    movdqa %xmm9, %xmm5
    movdqa %xmm6, %xmm9
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm9
    movdqa %xmm9, %xmm7
    aesimc %xmm10, %xmm10
    aesdeclast %xmm8, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm8, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm8, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm8, %xmm13
    movdqu 224(%rdx), %xmm14
    movdqu 240(%rdx), %xmm15
    movdqa %xmm14, %xmm9
    pxor %xmm10, %xmm9
    aesimc %xmm0, %xmm0
    aesdeclast %xmm9, %xmm0
    movdqa %xmm15, %xmm9
    pxor %xmm10, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm1
    aesenc %xmm8, %xmm1
    aesenc %xmm9, %xmm1
    aesdeclast %xmm8, %xmm0
    aesenc %xmm8, %xmm0
    movdqa %xmm14, %xmm9
    pxor %xmm11, %xmm9
    aesimc %xmm2, %xmm2
    aesdeclast %xmm9, %xmm2
    movdqa %xmm15, %xmm9
    pxor %xmm11, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm3
    aesenc %xmm8, %xmm3
    aesenc %xmm9, %xmm3
    aesdeclast %xmm8, %xmm2
    aesenc %xmm8, %xmm2
    movdqa %xmm14, %xmm9
    pxor %xmm12, %xmm9
    aesimc %xmm4, %xmm4
    aesdeclast %xmm9, %xmm4
    movdqa %xmm15, %xmm9
    pxor %xmm12, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm5
    aesenc %xmm8, %xmm5
    aesenc %xmm9, %xmm5
    aesdeclast %xmm8, %xmm4
    aesenc %xmm8, %xmm4
    movdqa %xmm14, %xmm9
    pxor %xmm13, %xmm9
    aesimc %xmm6, %xmm6
    aesdeclast %xmm9, %xmm6
    movdqa %xmm15, %xmm9
    pxor %xmm13, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm7
    aesenc %xmm8, %xmm7
    aesenc %xmm9, %xmm7
    aesdeclast %xmm8, %xmm6
    aesenc %xmm8, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm8, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm8, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm8, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm8, %xmm13
    movdqu 192(%rdx), %xmm14
    movdqu 208(%rdx), %xmm15
    movdqa %xmm14, %xmm9
    pxor %xmm10, %xmm9
    aesenclast %xmm9, %xmm0
    movdqa %xmm15, %xmm9
    pxor %xmm10, %xmm9
    aesenclast %xmm9, %xmm1
    movdqa %xmm14, %xmm9
    pxor %xmm11, %xmm9
    aesenclast %xmm9, %xmm2
    movdqa %xmm15, %xmm9
    pxor %xmm11, %xmm9
    aesenclast %xmm9, %xmm3
    movdqa %xmm14, %xmm9
    pxor %xmm12, %xmm9
    aesenclast %xmm9, %xmm4
    movdqa %xmm15, %xmm9
    pxor %xmm12, %xmm9
    aesenclast %xmm9, %xmm5
    movdqa %xmm14, %xmm9
    pxor %xmm13, %xmm9
    aesenclast %xmm9, %xmm6
    movdqa %xmm15, %xmm9
    pxor %xmm13, %xmm9
    aesenclast %xmm9, %xmm7
    movdqa %xmm0, %xmm9
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm9
    movdqa %xmm9, %xmm1
    movdqa %xmm2, %xmm9
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm9
    movdqa %xmm9, %xmm3
    movdqa %xmm4, %xmm9
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm9
    movdqa %xmm9, %xmm5
    movdqa %xmm6, %xmm9
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm9
    movdqa %xmm9, %xmm7
    aesimc %xmm10, %xmm10
    aesdeclast %xmm8, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm8, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm8, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm8, %xmm13
    movdqu 160(%rdx), %xmm14
    movdqu 176(%rdx), %xmm15
    movdqa %xmm14, %xmm9
    pxor %xmm10, %xmm9
    aesimc %xmm0, %xmm0
    aesdeclast %xmm9, %xmm0
    movdqa %xmm15, %xmm9
    pxor %xmm10, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm1
    aesenc %xmm8, %xmm1
    aesenc %xmm9, %xmm1
    aesdeclast %xmm8, %xmm0
    aesenc %xmm8, %xmm0
    movdqa %xmm14, %xmm9
    pxor %xmm11, %xmm9
    aesimc %xmm2, %xmm2
    aesdeclast %xmm9, %xmm2
    movdqa %xmm15, %xmm9
    pxor %xmm11, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm3
    aesenc %xmm8, %xmm3
    aesenc %xmm9, %xmm3
    aesdeclast %xmm8, %xmm2
    aesenc %xmm8, %xmm2
    movdqa %xmm14, %xmm9
    pxor %xmm12, %xmm9
    aesimc %xmm4, %xmm4
    aesdeclast %xmm9, %xmm4
    movdqa %xmm15, %xmm9
    pxor %xmm12, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm5
    aesenc %xmm8, %xmm5
    aesenc %xmm9, %xmm5
    aesdeclast %xmm8, %xmm4
    aesenc %xmm8, %xmm4
    movdqa %xmm14, %xmm9
    pxor %xmm13, %xmm9
    aesimc %xmm6, %xmm6
    aesdeclast %xmm9, %xmm6
    movdqa %xmm15, %xmm9
    pxor %xmm13, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm7
    aesenc %xmm8, %xmm7
    aesenc %xmm9, %xmm7
    aesdeclast %xmm8, %xmm6
    aesenc %xmm8, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm8, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm8, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm8, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm8, %xmm13
    movdqu 128(%rdx), %xmm14
    movdqu 144(%rdx), %xmm15
    movdqa %xmm14, %xmm9
    pxor %xmm10, %xmm9
    aesenclast %xmm9, %xmm0
    movdqa %xmm15, %xmm9
    pxor %xmm10, %xmm9
    aesenclast %xmm9, %xmm1
    movdqa %xmm14, %xmm9
    pxor %xmm11, %xmm9
    aesenclast %xmm9, %xmm2
    movdqa %xmm15, %xmm9
    pxor %xmm11, %xmm9
    aesenclast %xmm9, %xmm3
    movdqa %xmm14, %xmm9
    pxor %xmm12, %xmm9
    aesenclast %xmm9, %xmm4
    movdqa %xmm15, %xmm9
    pxor %xmm12, %xmm9
    aesenclast %xmm9, %xmm5
    movdqa %xmm14, %xmm9
    pxor %xmm13, %xmm9
    aesenclast %xmm9, %xmm6
    movdqa %xmm15, %xmm9
    pxor %xmm13, %xmm9
    aesenclast %xmm9, %xmm7
    movdqa %xmm0, %xmm9
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm9
    movdqa %xmm9, %xmm1
    movdqa %xmm2, %xmm9
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm9
    movdqa %xmm9, %xmm3
    movdqa %xmm4, %xmm9
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm9
    movdqa %xmm9, %xmm5
    movdqa %xmm6, %xmm9
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm9
    movdqa %xmm9, %xmm7
    aesimc %xmm10, %xmm10
    aesdeclast %xmm8, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm8, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm8, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm8, %xmm13
    movdqu 96(%rdx), %xmm14
    movdqu 112(%rdx), %xmm15
    movdqa %xmm14, %xmm9
    pxor %xmm10, %xmm9
    aesimc %xmm0, %xmm0
    aesdeclast %xmm9, %xmm0
    movdqa %xmm15, %xmm9
    pxor %xmm10, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm1
    aesenc %xmm8, %xmm1
    aesenc %xmm9, %xmm1
    aesdeclast %xmm8, %xmm0
    aesenc %xmm8, %xmm0
    movdqa %xmm14, %xmm9
    pxor %xmm11, %xmm9
    aesimc %xmm2, %xmm2
    aesdeclast %xmm9, %xmm2
    movdqa %xmm15, %xmm9
    pxor %xmm11, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm3
    aesenc %xmm8, %xmm3
    aesenc %xmm9, %xmm3
    aesdeclast %xmm8, %xmm2
    aesenc %xmm8, %xmm2
    movdqa %xmm14, %xmm9
    pxor %xmm12, %xmm9
    aesimc %xmm4, %xmm4
    aesdeclast %xmm9, %xmm4
    movdqa %xmm15, %xmm9
    pxor %xmm12, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm5
    aesenc %xmm8, %xmm5
    aesenc %xmm9, %xmm5
    aesdeclast %xmm8, %xmm4
    aesenc %xmm8, %xmm4
    movdqa %xmm14, %xmm9
    pxor %xmm13, %xmm9
    aesimc %xmm6, %xmm6
    aesdeclast %xmm9, %xmm6
    movdqa %xmm15, %xmm9
    pxor %xmm13, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm7
    aesenc %xmm8, %xmm7
    aesenc %xmm9, %xmm7
    aesdeclast %xmm8, %xmm6
    aesenc %xmm8, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm8, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm8, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm8, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm8, %xmm13
    movdqu 64(%rdx), %xmm14
    movdqu 80(%rdx), %xmm15
    movdqa %xmm14, %xmm9
    pxor %xmm10, %xmm9
    aesenclast %xmm9, %xmm0
    movdqa %xmm15, %xmm9
    pxor %xmm10, %xmm9
    aesenclast %xmm9, %xmm1
    movdqa %xmm14, %xmm9
    pxor %xmm11, %xmm9
    aesenclast %xmm9, %xmm2
    movdqa %xmm15, %xmm9
    pxor %xmm11, %xmm9
    aesenclast %xmm9, %xmm3
    movdqa %xmm14, %xmm9
    pxor %xmm12, %xmm9
    aesenclast %xmm9, %xmm4
    movdqa %xmm15, %xmm9
    pxor %xmm12, %xmm9
    aesenclast %xmm9, %xmm5
    movdqa %xmm14, %xmm9
    pxor %xmm13, %xmm9
    aesenclast %xmm9, %xmm6
    movdqa %xmm15, %xmm9
    pxor %xmm13, %xmm9
    aesenclast %xmm9, %xmm7
    movdqa %xmm0, %xmm9
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm9
    movdqa %xmm9, %xmm1
    movdqa %xmm2, %xmm9
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm9
    movdqa %xmm9, %xmm3
    movdqa %xmm4, %xmm9
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm9
    movdqa %xmm9, %xmm5
    movdqa %xmm6, %xmm9
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm9
    movdqa %xmm9, %xmm7
    aesimc %xmm10, %xmm10
    aesdeclast %xmm8, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm8, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm8, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm8, %xmm13
    movdqu 32(%rdx), %xmm14
    movdqu 48(%rdx), %xmm15
    movdqa %xmm14, %xmm9
    pxor %xmm10, %xmm9
    aesimc %xmm0, %xmm0
    aesdeclast %xmm9, %xmm0
    movdqa %xmm15, %xmm9
    pxor %xmm10, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm1
    aesenc %xmm8, %xmm1
    aesenc %xmm9, %xmm1
    aesdeclast %xmm8, %xmm0
    aesenc %xmm8, %xmm0
    movdqa %xmm14, %xmm9
    pxor %xmm11, %xmm9
    aesimc %xmm2, %xmm2
    aesdeclast %xmm9, %xmm2
    movdqa %xmm15, %xmm9
    pxor %xmm11, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm3
    aesenc %xmm8, %xmm3
    aesenc %xmm9, %xmm3
    aesdeclast %xmm8, %xmm2
    aesenc %xmm8, %xmm2
    movdqa %xmm14, %xmm9
    pxor %xmm12, %xmm9
    aesimc %xmm4, %xmm4
    aesdeclast %xmm9, %xmm4
    movdqa %xmm15, %xmm9
    pxor %xmm12, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm5
    aesenc %xmm8, %xmm5
    aesenc %xmm9, %xmm5
    aesdeclast %xmm8, %xmm4
    aesenc %xmm8, %xmm4
    movdqa %xmm14, %xmm9
    pxor %xmm13, %xmm9
    aesimc %xmm6, %xmm6
    aesdeclast %xmm9, %xmm6
    movdqa %xmm15, %xmm9
    pxor %xmm13, %xmm9
    aesdeclast %xmm8, %xmm9
    aesenc %xmm8, %xmm9
    aesdeclast %xmm8, %xmm7
    aesenc %xmm8, %xmm7
    aesenc %xmm9, %xmm7
    aesdeclast %xmm8, %xmm6
    aesenc %xmm8, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm8, %xmm10
    aesimc %xmm11, %xmm11
    aesdeclast %xmm8, %xmm11
    aesimc %xmm12, %xmm12
    aesdeclast %xmm8, %xmm12
    aesimc %xmm13, %xmm13
    aesdeclast %xmm8, %xmm13
    movdqu 0(%rdx), %xmm14
    movdqu 16(%rdx), %xmm15
    movdqa %xmm14, %xmm9
    pxor %xmm10, %xmm9
    aesenclast %xmm9, %xmm0
    movdqa %xmm15, %xmm9
    pxor %xmm10, %xmm9
    aesenclast %xmm9, %xmm1
    movdqa %xmm14, %xmm9
    pxor %xmm11, %xmm9
    aesenclast %xmm9, %xmm2
    movdqa %xmm15, %xmm9
    pxor %xmm11, %xmm9
    aesenclast %xmm9, %xmm3
    movdqa %xmm14, %xmm9
    pxor %xmm12, %xmm9
    aesenclast %xmm9, %xmm4
    movdqa %xmm15, %xmm9
    pxor %xmm12, %xmm9
    aesenclast %xmm9, %xmm5
    movdqa %xmm14, %xmm9
    pxor %xmm13, %xmm9
    aesenclast %xmm9, %xmm6
    movdqa %xmm15, %xmm9
    pxor %xmm13, %xmm9
    aesenclast %xmm9, %xmm7
    movdqu %xmm0, 0(%rdi)
    movdqu %xmm1, 16(%rdi)
    movdqu %xmm2, 32(%rdi)
    movdqu %xmm3, 48(%rdi)
    movdqu %xmm4, 64(%rdi)
    movdqu %xmm5, 80(%rdi)
    movdqu %xmm6, 96(%rdi)
    movdqu %xmm7, 112(%rdi)
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
    pxor %xmm15, %xmm15
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
    movdqu 160(%rsp), %xmm15
    movq $0, 160(%rsp)
    movq $0, 168(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $184, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r8, %r8
    xorq %r9, %r9
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_decrypt_4blocks_rk_aesni_asm)

AREION_FUNC_START(areion_asura_decrypt_4blocks_rk_vex_asm)
#if defined(_WIN64)
    subq $184, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    vmovdqu %xmm11, 96(%rsp)
    vmovdqu %xmm12, 112(%rsp)
    vmovdqu %xmm13, 128(%rsp)
    vmovdqu %xmm14, 144(%rsp)
    vmovdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu 0(%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vmovdqu 64(%rsi), %xmm4
    vmovdqu 80(%rsi), %xmm5
    vmovdqu 96(%rsi), %xmm6
    vmovdqu 112(%rsi), %xmm7
    vpxor %xmm8, %xmm8, %xmm8
    vmovdqu 0(%rcx), %xmm10
    vmovdqu 16(%rcx), %xmm11
    vmovdqu 32(%rcx), %xmm12
    vmovdqu 48(%rcx), %xmm13
    vaesenc %xmm8, %xmm10, %xmm10
    vaesenc %xmm8, %xmm11, %xmm11
    vaesenc %xmm8, %xmm12, %xmm12
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm10, %xmm10
    vaesenc %xmm8, %xmm11, %xmm11
    vaesenc %xmm8, %xmm12, %xmm12
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm10, %xmm10
    vaesenc %xmm8, %xmm11, %xmm11
    vaesenc %xmm8, %xmm12, %xmm12
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm10, %xmm10
    vaesenc %xmm8, %xmm11, %xmm11
    vaesenc %xmm8, %xmm12, %xmm12
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm10, %xmm10
    vaesenc %xmm8, %xmm11, %xmm11
    vaesenc %xmm8, %xmm12, %xmm12
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm10, %xmm10
    vaesenc %xmm8, %xmm11, %xmm11
    vaesenc %xmm8, %xmm12, %xmm12
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm10, %xmm10
    vaesenc %xmm8, %xmm11, %xmm11
    vaesenc %xmm8, %xmm12, %xmm12
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm10, %xmm10
    vaesenc %xmm8, %xmm11, %xmm11
    vaesenc %xmm8, %xmm12, %xmm12
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm10, %xmm10
    vaesenc %xmm8, %xmm11, %xmm11
    vaesenc %xmm8, %xmm12, %xmm12
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm10, %xmm10
    vaesenc %xmm8, %xmm11, %xmm11
    vaesenc %xmm8, %xmm12, %xmm12
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm10, %xmm10
    vaesenc %xmm8, %xmm11, %xmm11
    vaesenc %xmm8, %xmm12, %xmm12
    vaesenc %xmm8, %xmm13, %xmm13
    vaesenc %xmm8, %xmm10, %xmm10
    vaesenc %xmm8, %xmm11, %xmm11
    vaesenc %xmm8, %xmm12, %xmm12
    vaesenc %xmm8, %xmm13, %xmm13
    vmovdqu 384(%rdx), %xmm14
    vmovdqu 400(%rdx), %xmm15
    vpxor %xmm10, %xmm14, %xmm9
    vpxor %xmm9, %xmm0, %xmm0
    vpxor %xmm10, %xmm15, %xmm9
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm9
    vpxor %xmm9, %xmm2, %xmm2
    vpxor %xmm11, %xmm15, %xmm9
    vpxor %xmm9, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm9
    vpxor %xmm9, %xmm4, %xmm4
    vpxor %xmm12, %xmm15, %xmm9
    vpxor %xmm9, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm9
    vpxor %xmm9, %xmm6, %xmm6
    vpxor %xmm13, %xmm15, %xmm9
    vpxor %xmm9, %xmm7, %xmm7
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm8, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm8, %xmm13, %xmm13
    vmovdqu 352(%rdx), %xmm14
    vmovdqu 368(%rdx), %xmm15
    vpxor %xmm10, %xmm14, %xmm9
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm0, %xmm0
    vpxor %xmm10, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm1, %xmm1
    vaesenc %xmm8, %xmm1, %xmm1
    vaesenc %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesenc %xmm8, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm9
    vaesimc %xmm2, %xmm2
    vaesdeclast %xmm9, %xmm2, %xmm2
    vpxor %xmm11, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm3, %xmm3
    vaesenc %xmm8, %xmm3, %xmm3
    vaesenc %xmm9, %xmm3, %xmm3
    vaesdeclast %xmm8, %xmm2, %xmm2
    vaesenc %xmm8, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm9
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm9, %xmm4, %xmm4
    vpxor %xmm12, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm5, %xmm5
    vaesenc %xmm8, %xmm5, %xmm5
    vaesenc %xmm9, %xmm5, %xmm5
    vaesdeclast %xmm8, %xmm4, %xmm4
    vaesenc %xmm8, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm9
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm9, %xmm6, %xmm6
    vpxor %xmm13, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm7, %xmm7
    vaesenc %xmm8, %xmm7, %xmm7
    vaesenc %xmm9, %xmm7, %xmm7
    vaesdeclast %xmm8, %xmm6, %xmm6
    vaesenc %xmm8, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm8, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm8, %xmm13, %xmm13
    vmovdqu 320(%rdx), %xmm14
    vmovdqu 336(%rdx), %xmm15
    vpxor %xmm10, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm0, %xmm0
    vpxor %xmm10, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm2, %xmm2
    vpxor %xmm11, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm4, %xmm4
    vpxor %xmm12, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm6, %xmm6
    vpxor %xmm13, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm7, %xmm7
    vpunpcklbw %xmm1, %xmm0, %xmm9
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqa %xmm9, %xmm0
    vpunpcklbw %xmm3, %xmm2, %xmm9
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vmovdqa %xmm9, %xmm2
    vpunpcklbw %xmm5, %xmm4, %xmm9
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vmovdqa %xmm9, %xmm4
    vpunpcklbw %xmm7, %xmm6, %xmm9
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vmovdqa %xmm9, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm8, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm8, %xmm13, %xmm13
    vmovdqu 288(%rdx), %xmm14
    vmovdqu 304(%rdx), %xmm15
    vpxor %xmm10, %xmm14, %xmm9
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm0, %xmm0
    vpxor %xmm10, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm1, %xmm1
    vaesenc %xmm8, %xmm1, %xmm1
    vaesenc %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesenc %xmm8, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm9
    vaesimc %xmm2, %xmm2
    vaesdeclast %xmm9, %xmm2, %xmm2
    vpxor %xmm11, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm3, %xmm3
    vaesenc %xmm8, %xmm3, %xmm3
    vaesenc %xmm9, %xmm3, %xmm3
    vaesdeclast %xmm8, %xmm2, %xmm2
    vaesenc %xmm8, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm9
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm9, %xmm4, %xmm4
    vpxor %xmm12, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm5, %xmm5
    vaesenc %xmm8, %xmm5, %xmm5
    vaesenc %xmm9, %xmm5, %xmm5
    vaesdeclast %xmm8, %xmm4, %xmm4
    vaesenc %xmm8, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm9
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm9, %xmm6, %xmm6
    vpxor %xmm13, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm7, %xmm7
    vaesenc %xmm8, %xmm7, %xmm7
    vaesenc %xmm9, %xmm7, %xmm7
    vaesdeclast %xmm8, %xmm6, %xmm6
    vaesenc %xmm8, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm8, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm8, %xmm13, %xmm13
    vmovdqu 256(%rdx), %xmm14
    vmovdqu 272(%rdx), %xmm15
    vpxor %xmm10, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm0, %xmm0
    vpxor %xmm10, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm2, %xmm2
    vpxor %xmm11, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm4, %xmm4
    vpxor %xmm12, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm6, %xmm6
    vpxor %xmm13, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm7, %xmm7
    vpunpcklbw %xmm1, %xmm0, %xmm9
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqa %xmm9, %xmm0
    vpunpcklbw %xmm3, %xmm2, %xmm9
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vmovdqa %xmm9, %xmm2
    vpunpcklbw %xmm5, %xmm4, %xmm9
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vmovdqa %xmm9, %xmm4
    vpunpcklbw %xmm7, %xmm6, %xmm9
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vmovdqa %xmm9, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm8, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm8, %xmm13, %xmm13
    vmovdqu 224(%rdx), %xmm14
    vmovdqu 240(%rdx), %xmm15
    vpxor %xmm10, %xmm14, %xmm9
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm0, %xmm0
    vpxor %xmm10, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm1, %xmm1
    vaesenc %xmm8, %xmm1, %xmm1
    vaesenc %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesenc %xmm8, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm9
    vaesimc %xmm2, %xmm2
    vaesdeclast %xmm9, %xmm2, %xmm2
    vpxor %xmm11, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm3, %xmm3
    vaesenc %xmm8, %xmm3, %xmm3
    vaesenc %xmm9, %xmm3, %xmm3
    vaesdeclast %xmm8, %xmm2, %xmm2
    vaesenc %xmm8, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm9
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm9, %xmm4, %xmm4
    vpxor %xmm12, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm5, %xmm5
    vaesenc %xmm8, %xmm5, %xmm5
    vaesenc %xmm9, %xmm5, %xmm5
    vaesdeclast %xmm8, %xmm4, %xmm4
    vaesenc %xmm8, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm9
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm9, %xmm6, %xmm6
    vpxor %xmm13, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm7, %xmm7
    vaesenc %xmm8, %xmm7, %xmm7
    vaesenc %xmm9, %xmm7, %xmm7
    vaesdeclast %xmm8, %xmm6, %xmm6
    vaesenc %xmm8, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm8, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm8, %xmm13, %xmm13
    vmovdqu 192(%rdx), %xmm14
    vmovdqu 208(%rdx), %xmm15
    vpxor %xmm10, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm0, %xmm0
    vpxor %xmm10, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm2, %xmm2
    vpxor %xmm11, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm4, %xmm4
    vpxor %xmm12, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm6, %xmm6
    vpxor %xmm13, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm7, %xmm7
    vpunpcklbw %xmm1, %xmm0, %xmm9
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqa %xmm9, %xmm0
    vpunpcklbw %xmm3, %xmm2, %xmm9
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vmovdqa %xmm9, %xmm2
    vpunpcklbw %xmm5, %xmm4, %xmm9
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vmovdqa %xmm9, %xmm4
    vpunpcklbw %xmm7, %xmm6, %xmm9
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vmovdqa %xmm9, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm8, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm8, %xmm13, %xmm13
    vmovdqu 160(%rdx), %xmm14
    vmovdqu 176(%rdx), %xmm15
    vpxor %xmm10, %xmm14, %xmm9
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm0, %xmm0
    vpxor %xmm10, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm1, %xmm1
    vaesenc %xmm8, %xmm1, %xmm1
    vaesenc %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesenc %xmm8, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm9
    vaesimc %xmm2, %xmm2
    vaesdeclast %xmm9, %xmm2, %xmm2
    vpxor %xmm11, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm3, %xmm3
    vaesenc %xmm8, %xmm3, %xmm3
    vaesenc %xmm9, %xmm3, %xmm3
    vaesdeclast %xmm8, %xmm2, %xmm2
    vaesenc %xmm8, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm9
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm9, %xmm4, %xmm4
    vpxor %xmm12, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm5, %xmm5
    vaesenc %xmm8, %xmm5, %xmm5
    vaesenc %xmm9, %xmm5, %xmm5
    vaesdeclast %xmm8, %xmm4, %xmm4
    vaesenc %xmm8, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm9
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm9, %xmm6, %xmm6
    vpxor %xmm13, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm7, %xmm7
    vaesenc %xmm8, %xmm7, %xmm7
    vaesenc %xmm9, %xmm7, %xmm7
    vaesdeclast %xmm8, %xmm6, %xmm6
    vaesenc %xmm8, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm8, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm8, %xmm13, %xmm13
    vmovdqu 128(%rdx), %xmm14
    vmovdqu 144(%rdx), %xmm15
    vpxor %xmm10, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm0, %xmm0
    vpxor %xmm10, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm2, %xmm2
    vpxor %xmm11, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm4, %xmm4
    vpxor %xmm12, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm6, %xmm6
    vpxor %xmm13, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm7, %xmm7
    vpunpcklbw %xmm1, %xmm0, %xmm9
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqa %xmm9, %xmm0
    vpunpcklbw %xmm3, %xmm2, %xmm9
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vmovdqa %xmm9, %xmm2
    vpunpcklbw %xmm5, %xmm4, %xmm9
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vmovdqa %xmm9, %xmm4
    vpunpcklbw %xmm7, %xmm6, %xmm9
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vmovdqa %xmm9, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm8, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm8, %xmm13, %xmm13
    vmovdqu 96(%rdx), %xmm14
    vmovdqu 112(%rdx), %xmm15
    vpxor %xmm10, %xmm14, %xmm9
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm0, %xmm0
    vpxor %xmm10, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm1, %xmm1
    vaesenc %xmm8, %xmm1, %xmm1
    vaesenc %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesenc %xmm8, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm9
    vaesimc %xmm2, %xmm2
    vaesdeclast %xmm9, %xmm2, %xmm2
    vpxor %xmm11, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm3, %xmm3
    vaesenc %xmm8, %xmm3, %xmm3
    vaesenc %xmm9, %xmm3, %xmm3
    vaesdeclast %xmm8, %xmm2, %xmm2
    vaesenc %xmm8, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm9
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm9, %xmm4, %xmm4
    vpxor %xmm12, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm5, %xmm5
    vaesenc %xmm8, %xmm5, %xmm5
    vaesenc %xmm9, %xmm5, %xmm5
    vaesdeclast %xmm8, %xmm4, %xmm4
    vaesenc %xmm8, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm9
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm9, %xmm6, %xmm6
    vpxor %xmm13, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm7, %xmm7
    vaesenc %xmm8, %xmm7, %xmm7
    vaesenc %xmm9, %xmm7, %xmm7
    vaesdeclast %xmm8, %xmm6, %xmm6
    vaesenc %xmm8, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm8, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm8, %xmm13, %xmm13
    vmovdqu 64(%rdx), %xmm14
    vmovdqu 80(%rdx), %xmm15
    vpxor %xmm10, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm0, %xmm0
    vpxor %xmm10, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm2, %xmm2
    vpxor %xmm11, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm4, %xmm4
    vpxor %xmm12, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm6, %xmm6
    vpxor %xmm13, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm7, %xmm7
    vpunpcklbw %xmm1, %xmm0, %xmm9
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vmovdqa %xmm9, %xmm0
    vpunpcklbw %xmm3, %xmm2, %xmm9
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vmovdqa %xmm9, %xmm2
    vpunpcklbw %xmm5, %xmm4, %xmm9
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vmovdqa %xmm9, %xmm4
    vpunpcklbw %xmm7, %xmm6, %xmm9
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vmovdqa %xmm9, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm8, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm8, %xmm13, %xmm13
    vmovdqu 32(%rdx), %xmm14
    vmovdqu 48(%rdx), %xmm15
    vpxor %xmm10, %xmm14, %xmm9
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm0, %xmm0
    vpxor %xmm10, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm1, %xmm1
    vaesenc %xmm8, %xmm1, %xmm1
    vaesenc %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesenc %xmm8, %xmm0, %xmm0
    vpxor %xmm11, %xmm14, %xmm9
    vaesimc %xmm2, %xmm2
    vaesdeclast %xmm9, %xmm2, %xmm2
    vpxor %xmm11, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm3, %xmm3
    vaesenc %xmm8, %xmm3, %xmm3
    vaesenc %xmm9, %xmm3, %xmm3
    vaesdeclast %xmm8, %xmm2, %xmm2
    vaesenc %xmm8, %xmm2, %xmm2
    vpxor %xmm12, %xmm14, %xmm9
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm9, %xmm4, %xmm4
    vpxor %xmm12, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm5, %xmm5
    vaesenc %xmm8, %xmm5, %xmm5
    vaesenc %xmm9, %xmm5, %xmm5
    vaesdeclast %xmm8, %xmm4, %xmm4
    vaesenc %xmm8, %xmm4, %xmm4
    vpxor %xmm13, %xmm14, %xmm9
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm9, %xmm6, %xmm6
    vpxor %xmm13, %xmm15, %xmm9
    vaesdeclast %xmm8, %xmm9, %xmm9
    vaesenc %xmm8, %xmm9, %xmm9
    vaesdeclast %xmm8, %xmm7, %xmm7
    vaesenc %xmm8, %xmm7, %xmm7
    vaesenc %xmm9, %xmm7, %xmm7
    vaesdeclast %xmm8, %xmm6, %xmm6
    vaesenc %xmm8, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm8, %xmm10, %xmm10
    vaesimc %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm11, %xmm11
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm8, %xmm12, %xmm12
    vaesimc %xmm13, %xmm13
    vaesdeclast %xmm8, %xmm13, %xmm13
    vmovdqu 0(%rdx), %xmm14
    vmovdqu 16(%rdx), %xmm15
    vpxor %xmm10, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm0, %xmm0
    vpxor %xmm10, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm1, %xmm1
    vpxor %xmm11, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm2, %xmm2
    vpxor %xmm11, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm3, %xmm3
    vpxor %xmm12, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm4, %xmm4
    vpxor %xmm12, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm5, %xmm5
    vpxor %xmm13, %xmm14, %xmm9
    vaesenclast %xmm9, %xmm6, %xmm6
    vpxor %xmm13, %xmm15, %xmm9
    vaesenclast %xmm9, %xmm7, %xmm7
    vmovdqu %xmm0, 0(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vmovdqu %xmm4, 64(%rdi)
    vmovdqu %xmm5, 80(%rdi)
    vmovdqu %xmm6, 96(%rdi)
    vmovdqu %xmm7, 112(%rdi)
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
    vpxor %xmm15, %xmm15, %xmm15
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
    vmovdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    vmovdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    vmovdqu 112(%rsp), %xmm12
    movq $0, 112(%rsp)
    movq $0, 120(%rsp)
    vmovdqu 128(%rsp), %xmm13
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    vmovdqu 144(%rsp), %xmm14
    movq $0, 144(%rsp)
    movq $0, 152(%rsp)
    vmovdqu 160(%rsp), %xmm15
    movq $0, 160(%rsp)
    movq $0, 168(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $184, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r8, %r8
    xorq %r9, %r9
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    ret
AREION_FUNC_END(areion_asura_decrypt_4blocks_rk_vex_asm)

AREION_FUNC_START(areion_asura_decrypt_4blocks_rk_vaes256_asm)
#if defined(_WIN64)
    subq $120, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    vmovdqu %xmm11, 96(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu 0(%rsi), %ymm6
    vmovdqu 32(%rsi), %ymm7
    vperm2i128 $0x20, %ymm7, %ymm6, %ymm0
    vperm2i128 $0x31, %ymm7, %ymm6, %ymm1
    vmovdqu 64(%rsi), %ymm6
    vmovdqu 96(%rsi), %ymm7
    vperm2i128 $0x20, %ymm7, %ymm6, %ymm2
    vperm2i128 $0x31, %ymm7, %ymm6, %ymm3
    vpxor %ymm4, %ymm4, %ymm4
    vmovdqu 0(%rcx), %ymm8
    vmovdqu 32(%rcx), %ymm9
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vaesenc %ymm4, %ymm8, %ymm8
    vaesenc %ymm4, %ymm9, %ymm9
    vbroadcasti128 384(%rdx), %ymm6
    vbroadcasti128 400(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vpxor %ymm10, %ymm0, %ymm0
    vpxor %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vpxor %ymm10, %ymm2, %ymm2
    vpxor %ymm11, %ymm3, %ymm3
    vaesenclast %ymm4, %ymm8, %ymm8
    vaesdec %ymm4, %ymm8, %ymm8
    vaesdeclast %ymm4, %ymm8, %ymm8
    vaesenclast %ymm4, %ymm9, %ymm9
    vaesdec %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vbroadcasti128 352(%rdx), %ymm6
    vbroadcasti128 368(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesdeclast %ymm4, %ymm11, %ymm11
    vaesenc %ymm4, %ymm11, %ymm11
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm10, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesdeclast %ymm4, %ymm11, %ymm11
    vaesenc %ymm4, %ymm11, %ymm11
    vaesenclast %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm10, %ymm2, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm11, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm4, %ymm8, %ymm8
    vaesdec %ymm4, %ymm8, %ymm8
    vaesdeclast %ymm4, %ymm8, %ymm8
    vaesenclast %ymm4, %ymm9, %ymm9
    vaesdec %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vbroadcasti128 320(%rdx), %ymm6
    vbroadcasti128 336(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesenclast %ymm10, %ymm0, %ymm0
    vaesenclast %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesenclast %ymm10, %ymm2, %ymm2
    vaesenclast %ymm11, %ymm3, %ymm3
    vpunpcklbw %ymm1, %ymm0, %ymm10
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vmovdqa %ymm10, %ymm0
    vpunpcklbw %ymm3, %ymm2, %ymm10
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vmovdqa %ymm10, %ymm2
    vaesenclast %ymm4, %ymm8, %ymm8
    vaesdec %ymm4, %ymm8, %ymm8
    vaesdeclast %ymm4, %ymm8, %ymm8
    vaesenclast %ymm4, %ymm9, %ymm9
    vaesdec %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vbroadcasti128 288(%rdx), %ymm6
    vbroadcasti128 304(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesdeclast %ymm4, %ymm11, %ymm11
    vaesenc %ymm4, %ymm11, %ymm11
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm10, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesdeclast %ymm4, %ymm11, %ymm11
    vaesenc %ymm4, %ymm11, %ymm11
    vaesenclast %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm10, %ymm2, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm11, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm4, %ymm8, %ymm8
    vaesdec %ymm4, %ymm8, %ymm8
    vaesdeclast %ymm4, %ymm8, %ymm8
    vaesenclast %ymm4, %ymm9, %ymm9
    vaesdec %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vbroadcasti128 256(%rdx), %ymm6
    vbroadcasti128 272(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesenclast %ymm10, %ymm0, %ymm0
    vaesenclast %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesenclast %ymm10, %ymm2, %ymm2
    vaesenclast %ymm11, %ymm3, %ymm3
    vpunpcklbw %ymm1, %ymm0, %ymm10
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vmovdqa %ymm10, %ymm0
    vpunpcklbw %ymm3, %ymm2, %ymm10
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vmovdqa %ymm10, %ymm2
    vaesenclast %ymm4, %ymm8, %ymm8
    vaesdec %ymm4, %ymm8, %ymm8
    vaesdeclast %ymm4, %ymm8, %ymm8
    vaesenclast %ymm4, %ymm9, %ymm9
    vaesdec %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vbroadcasti128 224(%rdx), %ymm6
    vbroadcasti128 240(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesdeclast %ymm4, %ymm11, %ymm11
    vaesenc %ymm4, %ymm11, %ymm11
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm10, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesdeclast %ymm4, %ymm11, %ymm11
    vaesenc %ymm4, %ymm11, %ymm11
    vaesenclast %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm10, %ymm2, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm11, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm4, %ymm8, %ymm8
    vaesdec %ymm4, %ymm8, %ymm8
    vaesdeclast %ymm4, %ymm8, %ymm8
    vaesenclast %ymm4, %ymm9, %ymm9
    vaesdec %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vbroadcasti128 192(%rdx), %ymm6
    vbroadcasti128 208(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesenclast %ymm10, %ymm0, %ymm0
    vaesenclast %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesenclast %ymm10, %ymm2, %ymm2
    vaesenclast %ymm11, %ymm3, %ymm3
    vpunpcklbw %ymm1, %ymm0, %ymm10
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vmovdqa %ymm10, %ymm0
    vpunpcklbw %ymm3, %ymm2, %ymm10
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vmovdqa %ymm10, %ymm2
    vaesenclast %ymm4, %ymm8, %ymm8
    vaesdec %ymm4, %ymm8, %ymm8
    vaesdeclast %ymm4, %ymm8, %ymm8
    vaesenclast %ymm4, %ymm9, %ymm9
    vaesdec %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vbroadcasti128 160(%rdx), %ymm6
    vbroadcasti128 176(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesdeclast %ymm4, %ymm11, %ymm11
    vaesenc %ymm4, %ymm11, %ymm11
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm10, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesdeclast %ymm4, %ymm11, %ymm11
    vaesenc %ymm4, %ymm11, %ymm11
    vaesenclast %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm10, %ymm2, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm11, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm4, %ymm8, %ymm8
    vaesdec %ymm4, %ymm8, %ymm8
    vaesdeclast %ymm4, %ymm8, %ymm8
    vaesenclast %ymm4, %ymm9, %ymm9
    vaesdec %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vbroadcasti128 128(%rdx), %ymm6
    vbroadcasti128 144(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesenclast %ymm10, %ymm0, %ymm0
    vaesenclast %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesenclast %ymm10, %ymm2, %ymm2
    vaesenclast %ymm11, %ymm3, %ymm3
    vpunpcklbw %ymm1, %ymm0, %ymm10
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vmovdqa %ymm10, %ymm0
    vpunpcklbw %ymm3, %ymm2, %ymm10
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vmovdqa %ymm10, %ymm2
    vaesenclast %ymm4, %ymm8, %ymm8
    vaesdec %ymm4, %ymm8, %ymm8
    vaesdeclast %ymm4, %ymm8, %ymm8
    vaesenclast %ymm4, %ymm9, %ymm9
    vaesdec %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vbroadcasti128 96(%rdx), %ymm6
    vbroadcasti128 112(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesdeclast %ymm4, %ymm11, %ymm11
    vaesenc %ymm4, %ymm11, %ymm11
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm10, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesdeclast %ymm4, %ymm11, %ymm11
    vaesenc %ymm4, %ymm11, %ymm11
    vaesenclast %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm10, %ymm2, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm11, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm4, %ymm8, %ymm8
    vaesdec %ymm4, %ymm8, %ymm8
    vaesdeclast %ymm4, %ymm8, %ymm8
    vaesenclast %ymm4, %ymm9, %ymm9
    vaesdec %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vbroadcasti128 64(%rdx), %ymm6
    vbroadcasti128 80(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesenclast %ymm10, %ymm0, %ymm0
    vaesenclast %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesenclast %ymm10, %ymm2, %ymm2
    vaesenclast %ymm11, %ymm3, %ymm3
    vpunpcklbw %ymm1, %ymm0, %ymm10
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vmovdqa %ymm10, %ymm0
    vpunpcklbw %ymm3, %ymm2, %ymm10
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vmovdqa %ymm10, %ymm2
    vaesenclast %ymm4, %ymm8, %ymm8
    vaesdec %ymm4, %ymm8, %ymm8
    vaesdeclast %ymm4, %ymm8, %ymm8
    vaesenclast %ymm4, %ymm9, %ymm9
    vaesdec %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vbroadcasti128 32(%rdx), %ymm6
    vbroadcasti128 48(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesdeclast %ymm4, %ymm11, %ymm11
    vaesenc %ymm4, %ymm11, %ymm11
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm10, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesdeclast %ymm4, %ymm11, %ymm11
    vaesenc %ymm4, %ymm11, %ymm11
    vaesenclast %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm10, %ymm2, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm11, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenclast %ymm4, %ymm8, %ymm8
    vaesdec %ymm4, %ymm8, %ymm8
    vaesdeclast %ymm4, %ymm8, %ymm8
    vaesenclast %ymm4, %ymm9, %ymm9
    vaesdec %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm4, %ymm9, %ymm9
    vbroadcasti128 0(%rdx), %ymm6
    vbroadcasti128 16(%rdx), %ymm7
    vpxor %ymm8, %ymm6, %ymm10
    vpxor %ymm8, %ymm7, %ymm11
    vaesenclast %ymm10, %ymm0, %ymm0
    vaesenclast %ymm11, %ymm1, %ymm1
    vpxor %ymm9, %ymm6, %ymm10
    vpxor %ymm9, %ymm7, %ymm11
    vaesenclast %ymm10, %ymm2, %ymm2
    vaesenclast %ymm11, %ymm3, %ymm3
    vperm2i128 $0x20, %ymm1, %ymm0, %ymm6
    vperm2i128 $0x31, %ymm1, %ymm0, %ymm7
    vmovdqu %ymm6, 0(%rdi)
    vmovdqu %ymm7, 32(%rdi)
    vperm2i128 $0x20, %ymm3, %ymm2, %ymm6
    vperm2i128 $0x31, %ymm3, %ymm2, %ymm7
    vmovdqu %ymm6, 64(%rdi)
    vmovdqu %ymm7, 96(%rdi)
    vpxor %ymm0, %ymm0, %ymm0
    vpxor %ymm1, %ymm1, %ymm1
    vpxor %ymm2, %ymm2, %ymm2
    vpxor %ymm3, %ymm3, %ymm3
    vpxor %ymm4, %ymm4, %ymm4
    vpxor %ymm5, %ymm5, %ymm5
    vpxor %ymm6, %ymm6, %ymm6
    vpxor %ymm7, %ymm7, %ymm7
    vpxor %ymm8, %ymm8, %ymm8
    vpxor %ymm9, %ymm9, %ymm9
    vpxor %ymm10, %ymm10, %ymm10
    vpxor %ymm11, %ymm11, %ymm11
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
    vmovdqu 80(%rsp), %xmm10
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    vmovdqu 96(%rsp), %xmm11
    movq $0, 96(%rsp)
    movq $0, 104(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $120, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r8, %r8
    xorq %r9, %r9
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion_asura_decrypt_4blocks_rk_vaes256_asm)

AREION_FUNC_START(areion_asura_decrypt_4blocks_rk_vaes512_asm)
#if defined(_WIN64)
    subq $56, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu64 0(%rsi), %zmm6
    vmovdqu64 64(%rsi), %zmm7
    vshufi64x2 $0x88, %zmm7, %zmm6, %zmm0
    vshufi64x2 $0xDD, %zmm7, %zmm6, %zmm1
    vpxorq %zmm2, %zmm2, %zmm2
    vmovdqu64 0(%rcx), %zmm16
    vaesenc %zmm2, %zmm16, %zmm17
    vaesenc %zmm2, %zmm17, %zmm18
    vaesenc %zmm2, %zmm18, %zmm19
    vaesenc %zmm2, %zmm19, %zmm20
    vaesenc %zmm2, %zmm20, %zmm21
    vaesenc %zmm2, %zmm21, %zmm22
    vaesenc %zmm2, %zmm22, %zmm23
    vaesenc %zmm2, %zmm23, %zmm24
    vaesenc %zmm2, %zmm24, %zmm25
    vaesenc %zmm2, %zmm25, %zmm26
    vaesenc %zmm2, %zmm26, %zmm27
    vaesenc %zmm2, %zmm27, %zmm28
    vbroadcasti32x4 384(%rdx), %zmm4
    vbroadcasti32x4 400(%rdx), %zmm5
    vpxorq %zmm28, %zmm4, %zmm4
    vpxorq %zmm28, %zmm5, %zmm5
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 352(%rdx), %zmm4
    vbroadcasti32x4 368(%rdx), %zmm5
    vpxorq %zmm27, %zmm4, %zmm4
    vpxorq %zmm27, %zmm5, %zmm5
    vaesdeclast %zmm2, %zmm5, %zmm5
    vaesenclast %zmm2, %zmm0, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %zmm2, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 320(%rdx), %zmm4
    vbroadcasti32x4 336(%rdx), %zmm5
    vpxorq %zmm26, %zmm4, %zmm4
    vpxorq %zmm26, %zmm5, %zmm5
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 288(%rdx), %zmm4
    vbroadcasti32x4 304(%rdx), %zmm5
    vpxorq %zmm25, %zmm4, %zmm4
    vpxorq %zmm25, %zmm5, %zmm5
    vaesdeclast %zmm2, %zmm5, %zmm5
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %zmm2, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 256(%rdx), %zmm4
    vbroadcasti32x4 272(%rdx), %zmm5
    vpxorq %zmm24, %zmm4, %zmm4
    vpxorq %zmm24, %zmm5, %zmm5
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 224(%rdx), %zmm4
    vbroadcasti32x4 240(%rdx), %zmm5
    vpxorq %zmm23, %zmm4, %zmm4
    vpxorq %zmm23, %zmm5, %zmm5
    vaesdeclast %zmm2, %zmm5, %zmm5
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %zmm2, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 192(%rdx), %zmm4
    vbroadcasti32x4 208(%rdx), %zmm5
    vpxorq %zmm22, %zmm4, %zmm4
    vpxorq %zmm22, %zmm5, %zmm5
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 160(%rdx), %zmm4
    vbroadcasti32x4 176(%rdx), %zmm5
    vpxorq %zmm21, %zmm4, %zmm4
    vpxorq %zmm21, %zmm5, %zmm5
    vaesdeclast %zmm2, %zmm5, %zmm5
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %zmm2, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 128(%rdx), %zmm4
    vbroadcasti32x4 144(%rdx), %zmm5
    vpxorq %zmm20, %zmm4, %zmm4
    vpxorq %zmm20, %zmm5, %zmm5
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 96(%rdx), %zmm4
    vbroadcasti32x4 112(%rdx), %zmm5
    vpxorq %zmm19, %zmm4, %zmm4
    vpxorq %zmm19, %zmm5, %zmm5
    vaesdeclast %zmm2, %zmm5, %zmm5
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %zmm2, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 64(%rdx), %zmm4
    vbroadcasti32x4 80(%rdx), %zmm5
    vpxorq %zmm18, %zmm4, %zmm4
    vpxorq %zmm18, %zmm5, %zmm5
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 32(%rdx), %zmm4
    vbroadcasti32x4 48(%rdx), %zmm5
    vpxorq %zmm17, %zmm4, %zmm4
    vpxorq %zmm17, %zmm5, %zmm5
    vaesdeclast %zmm2, %zmm5, %zmm5
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %zmm2, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 0(%rdx), %zmm4
    vbroadcasti32x4 16(%rdx), %zmm5
    vpxorq %zmm16, %zmm4, %zmm4
    vpxorq %zmm16, %zmm5, %zmm5
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vshufi64x2 $0x44, %zmm1, %zmm0, %zmm6
    vshufi64x2 $0xD8, %zmm6, %zmm6, %zmm6
    vshufi64x2 $0xEE, %zmm1, %zmm0, %zmm7
    vshufi64x2 $0xD8, %zmm7, %zmm7, %zmm7
    vmovdqu64 %zmm6, 0(%rdi)
    vmovdqu64 %zmm7, 64(%rdi)
    vpxorq %zmm0, %zmm0, %zmm0
    vpxorq %zmm1, %zmm1, %zmm1
    vpxorq %zmm2, %zmm2, %zmm2
    vpxorq %zmm4, %zmm4, %zmm4
    vpxorq %zmm5, %zmm5, %zmm5
    vpxorq %zmm6, %zmm6, %zmm6
    vpxorq %zmm7, %zmm7, %zmm7
    vpxorq %zmm16, %zmm16, %zmm16
    vpxorq %zmm17, %zmm17, %zmm17
    vpxorq %zmm18, %zmm18, %zmm18
    vpxorq %zmm19, %zmm19, %zmm19
    vpxorq %zmm20, %zmm20, %zmm20
    vpxorq %zmm21, %zmm21, %zmm21
    vpxorq %zmm22, %zmm22, %zmm22
    vpxorq %zmm23, %zmm23, %zmm23
    vpxorq %zmm24, %zmm24, %zmm24
    vpxorq %zmm25, %zmm25, %zmm25
    vpxorq %zmm26, %zmm26, %zmm26
    vpxorq %zmm27, %zmm27, %zmm27
    vpxorq %zmm28, %zmm28, %zmm28
#if defined(_WIN64)
    vmovdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm7
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $56, %rsp
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r8, %r8
    xorq %r9, %r9
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion_asura_decrypt_4blocks_rk_vaes512_asm)

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
