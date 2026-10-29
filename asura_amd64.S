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
    pxor %xmm11, %xmm11
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    pxor %xmm12, %xmm0
    pxor %xmm13, %xmm1
    pxor %xmm12, %xmm2
    pxor %xmm13, %xmm3
    pxor %xmm12, %xmm4
    pxor %xmm13, %xmm5
    pxor %xmm12, %xmm6
    pxor %xmm13, %xmm7
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesdec %xmm12, %xmm0
    aesdec %xmm13, %xmm1
    aesdec %xmm12, %xmm2
    aesdec %xmm13, %xmm3
    aesdec %xmm12, %xmm4
    aesdec %xmm13, %xmm5
    aesdec %xmm12, %xmm6
    aesdec %xmm13, %xmm7
    aesenc %xmm11, %xmm0
    aesdec %xmm11, %xmm1
    aesenc %xmm11, %xmm2
    aesdec %xmm11, %xmm3
    aesenc %xmm11, %xmm4
    aesdec %xmm11, %xmm5
    aesenc %xmm11, %xmm6
    aesdec %xmm11, %xmm7
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    pxor %xmm12, %xmm0
    pxor %xmm13, %xmm1
    pxor %xmm12, %xmm2
    pxor %xmm13, %xmm3
    pxor %xmm12, %xmm4
    pxor %xmm13, %xmm5
    pxor %xmm12, %xmm6
    pxor %xmm13, %xmm7
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesdec %xmm12, %xmm0
    aesdec %xmm13, %xmm1
    aesdec %xmm12, %xmm2
    aesdec %xmm13, %xmm3
    aesdec %xmm12, %xmm4
    aesdec %xmm13, %xmm5
    aesdec %xmm12, %xmm6
    aesdec %xmm13, %xmm7
    aesenc %xmm11, %xmm0
    aesdec %xmm11, %xmm1
    aesenc %xmm11, %xmm2
    aesdec %xmm11, %xmm3
    aesenc %xmm11, %xmm4
    aesdec %xmm11, %xmm5
    aesenc %xmm11, %xmm6
    aesdec %xmm11, %xmm7
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    pxor %xmm12, %xmm0
    pxor %xmm13, %xmm1
    pxor %xmm12, %xmm2
    pxor %xmm13, %xmm3
    pxor %xmm12, %xmm4
    pxor %xmm13, %xmm5
    pxor %xmm12, %xmm6
    pxor %xmm13, %xmm7
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesdec %xmm12, %xmm0
    aesdec %xmm13, %xmm1
    aesdec %xmm12, %xmm2
    aesdec %xmm13, %xmm3
    aesdec %xmm12, %xmm4
    aesdec %xmm13, %xmm5
    aesdec %xmm12, %xmm6
    aesdec %xmm13, %xmm7
    aesenc %xmm11, %xmm0
    aesdec %xmm11, %xmm1
    aesenc %xmm11, %xmm2
    aesdec %xmm11, %xmm3
    aesenc %xmm11, %xmm4
    aesdec %xmm11, %xmm5
    aesenc %xmm11, %xmm6
    aesdec %xmm11, %xmm7
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    pxor %xmm12, %xmm0
    pxor %xmm13, %xmm1
    pxor %xmm12, %xmm2
    pxor %xmm13, %xmm3
    pxor %xmm12, %xmm4
    pxor %xmm13, %xmm5
    pxor %xmm12, %xmm6
    pxor %xmm13, %xmm7
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesdec %xmm12, %xmm0
    aesdec %xmm13, %xmm1
    aesdec %xmm12, %xmm2
    aesdec %xmm13, %xmm3
    aesdec %xmm12, %xmm4
    aesdec %xmm13, %xmm5
    aesdec %xmm12, %xmm6
    aesdec %xmm13, %xmm7
    aesenc %xmm11, %xmm0
    aesdec %xmm11, %xmm1
    aesenc %xmm11, %xmm2
    aesdec %xmm11, %xmm3
    aesenc %xmm11, %xmm4
    aesdec %xmm11, %xmm5
    aesenc %xmm11, %xmm6
    aesdec %xmm11, %xmm7
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    pxor %xmm12, %xmm0
    pxor %xmm13, %xmm1
    pxor %xmm12, %xmm2
    pxor %xmm13, %xmm3
    pxor %xmm12, %xmm4
    pxor %xmm13, %xmm5
    pxor %xmm12, %xmm6
    pxor %xmm13, %xmm7
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesdec %xmm12, %xmm0
    aesdec %xmm13, %xmm1
    aesdec %xmm12, %xmm2
    aesdec %xmm13, %xmm3
    aesdec %xmm12, %xmm4
    aesdec %xmm13, %xmm5
    aesdec %xmm12, %xmm6
    aesdec %xmm13, %xmm7
    aesenc %xmm11, %xmm0
    aesdec %xmm11, %xmm1
    aesenc %xmm11, %xmm2
    aesdec %xmm11, %xmm3
    aesenc %xmm11, %xmm4
    aesdec %xmm11, %xmm5
    aesenc %xmm11, %xmm6
    aesdec %xmm11, %xmm7
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6
    pshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    pxor %xmm12, %xmm0
    pxor %xmm13, %xmm1
    pxor %xmm12, %xmm2
    pxor %xmm13, %xmm3
    pxor %xmm12, %xmm4
    pxor %xmm13, %xmm5
    pxor %xmm12, %xmm6
    pxor %xmm13, %xmm7
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesdec %xmm12, %xmm0
    aesdec %xmm13, %xmm1
    aesdec %xmm12, %xmm2
    aesdec %xmm13, %xmm3
    aesdec %xmm12, %xmm4
    aesdec %xmm13, %xmm5
    aesdec %xmm12, %xmm6
    aesdec %xmm13, %xmm7
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesenc %xmm12, %xmm0
    aesdec %xmm13, %xmm1
    movdqu %xmm0, 0(%rdi)
    movdqu %xmm1, 16(%rdi)
    aesenc %xmm12, %xmm2
    aesdec %xmm13, %xmm3
    movdqu %xmm2, 32(%rdi)
    movdqu %xmm3, 48(%rdi)
    aesenc %xmm12, %xmm4
    aesdec %xmm13, %xmm5
    movdqu %xmm4, 64(%rdi)
    movdqu %xmm5, 80(%rdi)
    aesenc %xmm12, %xmm6
    aesdec %xmm13, %xmm7
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
    pxor %xmm11, %xmm11
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    aesenc %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm11, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm8, %xmm14
    pcmpgtb %xmm9, %xmm15
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm14
    pand AREION_SYM(asuraGFConsts)(%rip), %xmm15
    paddb %xmm8, %xmm8
    paddb %xmm9, %xmm9
    pxor %xmm14, %xmm8
    pxor %xmm15, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    pxor %xmm12, %xmm0
    pxor %xmm13, %xmm1
    pxor %xmm12, %xmm2
    pxor %xmm13, %xmm3
    pxor %xmm12, %xmm4
    pxor %xmm13, %xmm5
    pxor %xmm12, %xmm6
    pxor %xmm13, %xmm7
    aesimc %xmm10, %xmm10
    aesdeclast %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm15, %xmm8
    movdqa %xmm9, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm15, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesdeclast %xmm11, %xmm13
    aesimc %xmm0, %xmm0
    aesdeclast %xmm11, %xmm1
    aesimc %xmm2, %xmm2
    aesdeclast %xmm11, %xmm3
    aesimc %xmm4, %xmm4
    aesdeclast %xmm11, %xmm5
    aesimc %xmm6, %xmm6
    aesdeclast %xmm11, %xmm7
    aesenc %xmm11, %xmm13
    aesdeclast %xmm12, %xmm0
    aesenc %xmm11, %xmm1
    aesdeclast %xmm12, %xmm2
    aesenc %xmm11, %xmm3
    aesdeclast %xmm12, %xmm4
    aesenc %xmm11, %xmm5
    aesdeclast %xmm12, %xmm6
    aesenc %xmm11, %xmm7
    aesdeclast %xmm11, %xmm0
    aesenc %xmm13, %xmm1
    aesdeclast %xmm11, %xmm2
    aesenc %xmm13, %xmm3
    aesdeclast %xmm11, %xmm4
    aesenc %xmm13, %xmm5
    aesdeclast %xmm11, %xmm6
    aesenc %xmm13, %xmm7
    aesenc %xmm11, %xmm0
    aesenc %xmm11, %xmm2
    aesenc %xmm11, %xmm4
    aesenc %xmm11, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm15, %xmm8
    movdqa %xmm9, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm15, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm1
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm3
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm5
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm7
    aesimc %xmm10, %xmm10
    aesdeclast %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm15, %xmm8
    movdqa %xmm9, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm15, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesdeclast %xmm11, %xmm13
    movdqa %xmm0, %xmm14
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesimc %xmm0, %xmm0
    aesdeclast %xmm11, %xmm1
    movdqa %xmm2, %xmm14
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesimc %xmm2, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqa %xmm4, %xmm14
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesimc %xmm4, %xmm4
    aesdeclast %xmm11, %xmm5
    movdqa %xmm6, %xmm14
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    aesimc %xmm6, %xmm6
    aesdeclast %xmm11, %xmm7
    aesenc %xmm11, %xmm13
    aesdeclast %xmm12, %xmm0
    aesenc %xmm11, %xmm1
    aesdeclast %xmm12, %xmm2
    aesenc %xmm11, %xmm3
    aesdeclast %xmm12, %xmm4
    aesenc %xmm11, %xmm5
    aesdeclast %xmm12, %xmm6
    aesenc %xmm11, %xmm7
    aesdeclast %xmm11, %xmm0
    aesenc %xmm13, %xmm1
    aesdeclast %xmm11, %xmm2
    aesenc %xmm13, %xmm3
    aesdeclast %xmm11, %xmm4
    aesenc %xmm13, %xmm5
    aesdeclast %xmm11, %xmm6
    aesenc %xmm13, %xmm7
    aesenc %xmm11, %xmm0
    aesenc %xmm11, %xmm2
    aesenc %xmm11, %xmm4
    aesenc %xmm11, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm15, %xmm8
    movdqa %xmm9, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm15, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm1
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm3
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm5
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm7
    aesimc %xmm10, %xmm10
    aesdeclast %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm15, %xmm8
    movdqa %xmm9, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm15, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesdeclast %xmm11, %xmm13
    movdqa %xmm0, %xmm14
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesimc %xmm0, %xmm0
    aesdeclast %xmm11, %xmm1
    movdqa %xmm2, %xmm14
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesimc %xmm2, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqa %xmm4, %xmm14
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesimc %xmm4, %xmm4
    aesdeclast %xmm11, %xmm5
    movdqa %xmm6, %xmm14
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    aesimc %xmm6, %xmm6
    aesdeclast %xmm11, %xmm7
    aesenc %xmm11, %xmm13
    aesdeclast %xmm12, %xmm0
    aesenc %xmm11, %xmm1
    aesdeclast %xmm12, %xmm2
    aesenc %xmm11, %xmm3
    aesdeclast %xmm12, %xmm4
    aesenc %xmm11, %xmm5
    aesdeclast %xmm12, %xmm6
    aesenc %xmm11, %xmm7
    aesdeclast %xmm11, %xmm0
    aesenc %xmm13, %xmm1
    aesdeclast %xmm11, %xmm2
    aesenc %xmm13, %xmm3
    aesdeclast %xmm11, %xmm4
    aesenc %xmm13, %xmm5
    aesdeclast %xmm11, %xmm6
    aesenc %xmm13, %xmm7
    aesenc %xmm11, %xmm0
    aesenc %xmm11, %xmm2
    aesenc %xmm11, %xmm4
    aesenc %xmm11, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm15, %xmm8
    movdqa %xmm9, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm15, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm1
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm3
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm5
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm7
    aesimc %xmm10, %xmm10
    aesdeclast %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm15, %xmm8
    movdqa %xmm9, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm15, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesdeclast %xmm11, %xmm13
    movdqa %xmm0, %xmm14
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesimc %xmm0, %xmm0
    aesdeclast %xmm11, %xmm1
    movdqa %xmm2, %xmm14
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesimc %xmm2, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqa %xmm4, %xmm14
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesimc %xmm4, %xmm4
    aesdeclast %xmm11, %xmm5
    movdqa %xmm6, %xmm14
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    aesimc %xmm6, %xmm6
    aesdeclast %xmm11, %xmm7
    aesenc %xmm11, %xmm13
    aesdeclast %xmm12, %xmm0
    aesenc %xmm11, %xmm1
    aesdeclast %xmm12, %xmm2
    aesenc %xmm11, %xmm3
    aesdeclast %xmm12, %xmm4
    aesenc %xmm11, %xmm5
    aesdeclast %xmm12, %xmm6
    aesenc %xmm11, %xmm7
    aesdeclast %xmm11, %xmm0
    aesenc %xmm13, %xmm1
    aesdeclast %xmm11, %xmm2
    aesenc %xmm13, %xmm3
    aesdeclast %xmm11, %xmm4
    aesenc %xmm13, %xmm5
    aesdeclast %xmm11, %xmm6
    aesenc %xmm13, %xmm7
    aesenc %xmm11, %xmm0
    aesenc %xmm11, %xmm2
    aesenc %xmm11, %xmm4
    aesenc %xmm11, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm15, %xmm8
    movdqa %xmm9, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm15, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm1
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm3
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm5
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm7
    aesimc %xmm10, %xmm10
    aesdeclast %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm15, %xmm8
    movdqa %xmm9, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm15, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesdeclast %xmm11, %xmm13
    movdqa %xmm0, %xmm14
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesimc %xmm0, %xmm0
    aesdeclast %xmm11, %xmm1
    movdqa %xmm2, %xmm14
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesimc %xmm2, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqa %xmm4, %xmm14
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesimc %xmm4, %xmm4
    aesdeclast %xmm11, %xmm5
    movdqa %xmm6, %xmm14
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    aesimc %xmm6, %xmm6
    aesdeclast %xmm11, %xmm7
    aesenc %xmm11, %xmm13
    aesdeclast %xmm12, %xmm0
    aesenc %xmm11, %xmm1
    aesdeclast %xmm12, %xmm2
    aesenc %xmm11, %xmm3
    aesdeclast %xmm12, %xmm4
    aesenc %xmm11, %xmm5
    aesdeclast %xmm12, %xmm6
    aesenc %xmm11, %xmm7
    aesdeclast %xmm11, %xmm0
    aesenc %xmm13, %xmm1
    aesdeclast %xmm11, %xmm2
    aesenc %xmm13, %xmm3
    aesdeclast %xmm11, %xmm4
    aesenc %xmm13, %xmm5
    aesdeclast %xmm11, %xmm6
    aesenc %xmm13, %xmm7
    aesenc %xmm11, %xmm0
    aesenc %xmm11, %xmm2
    aesenc %xmm11, %xmm4
    aesenc %xmm11, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm15, %xmm8
    movdqa %xmm9, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm15, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm1
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm3
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm5
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm7
    aesimc %xmm10, %xmm10
    aesdeclast %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm15, %xmm8
    movdqa %xmm9, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm15, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesdeclast %xmm11, %xmm13
    movdqa %xmm0, %xmm14
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesimc %xmm0, %xmm0
    aesdeclast %xmm11, %xmm1
    movdqa %xmm2, %xmm14
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesimc %xmm2, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqa %xmm4, %xmm14
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesimc %xmm4, %xmm4
    aesdeclast %xmm11, %xmm5
    movdqa %xmm6, %xmm14
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    aesimc %xmm6, %xmm6
    aesdeclast %xmm11, %xmm7
    aesenc %xmm11, %xmm13
    aesdeclast %xmm12, %xmm0
    aesenc %xmm11, %xmm1
    aesdeclast %xmm12, %xmm2
    aesenc %xmm11, %xmm3
    aesdeclast %xmm12, %xmm4
    aesenc %xmm11, %xmm5
    aesdeclast %xmm12, %xmm6
    aesenc %xmm11, %xmm7
    aesdeclast %xmm11, %xmm0
    aesenc %xmm13, %xmm1
    aesdeclast %xmm11, %xmm2
    aesenc %xmm13, %xmm3
    aesdeclast %xmm11, %xmm4
    aesenc %xmm13, %xmm5
    aesdeclast %xmm11, %xmm6
    aesenc %xmm13, %xmm7
    aesenc %xmm11, %xmm0
    aesenc %xmm11, %xmm2
    aesenc %xmm11, %xmm4
    aesenc %xmm11, %xmm6
    aesimc %xmm10, %xmm10
    aesdeclast %xmm11, %xmm10
    movdqa %xmm8, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm8
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8
    pxor %xmm15, %xmm8
    movdqa %xmm9, %xmm14
    psllw $7, %xmm14
    movdqa %xmm11, %xmm15
    pcmpgtb %xmm14, %xmm15
    pand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15
    psrlw $1, %xmm9
    pand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9
    pxor %xmm15, %xmm9
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8
    pshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9
    movdqa %xmm8, %xmm14
    pblendw $0xcc, %xmm9, %xmm8
    pblendw $0xcc, %xmm14, %xmm9
    movdqa %xmm8, %xmm12
    pxor %xmm10, %xmm12
    pxor AREION_SYM(asuraRoundConstants)(%rip), %xmm12
    movdqa %xmm9, %xmm13
    pxor %xmm10, %xmm13
    aesenclast %xmm12, %xmm0
    aesenclast %xmm13, %xmm1
    aesenclast %xmm12, %xmm2
    aesenclast %xmm13, %xmm3
    aesenclast %xmm12, %xmm4
    aesenclast %xmm13, %xmm5
    aesenclast %xmm12, %xmm6
    aesenclast %xmm13, %xmm7
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
    vmovdqu 0(%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 0(%rdx), %xmm2
    vmovdqu 16(%rdx), %xmm3
    vmovdqu 0(%rcx), %xmm4
    vpxor %xmm5, %xmm5, %xmm5
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
    vpxor %xmm6, %xmm0, %xmm0
    vpxor %xmm7, %xmm1, %xmm1
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm5, %xmm4, %xmm4
    vpsllw $7, %xmm2, %xmm6
    vpsllw $7, %xmm3, %xmm7
    vpcmpgtb %xmm6, %xmm5, %xmm6
    vpcmpgtb %xmm7, %xmm5, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm2, %xmm2
    vpsrlw $1, %xmm3, %xmm3
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2, %xmm2
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vmovdqa %xmm6, %xmm2
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm5, %xmm1, %xmm1
    vaesdeclast %xmm5, %xmm7, %xmm7
    vaesdeclast %xmm6, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm5, %xmm7, %xmm7
    vaesdeclast %xmm5, %xmm0, %xmm0
    vaesenc %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm5, %xmm4, %xmm4
    vpsllw $7, %xmm2, %xmm6
    vpsllw $7, %xmm3, %xmm7
    vpcmpgtb %xmm6, %xmm5, %xmm6
    vpcmpgtb %xmm7, %xmm5, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm2, %xmm2
    vpsrlw $1, %xmm3, %xmm3
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2, %xmm2
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vmovdqa %xmm6, %xmm2
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vaesenclast %xmm6, %xmm0, %xmm0
    vaesenclast %xmm7, %xmm1, %xmm1
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm5, %xmm4, %xmm4
    vpsllw $7, %xmm2, %xmm6
    vpsllw $7, %xmm3, %xmm7
    vpcmpgtb %xmm6, %xmm5, %xmm6
    vpcmpgtb %xmm7, %xmm5, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm2, %xmm2
    vpsrlw $1, %xmm3, %xmm3
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2, %xmm2
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vmovdqa %xmm6, %xmm2
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vpunpcklbw %xmm1, %xmm0, %xmm8
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm8, %xmm0
    vaesdeclast %xmm5, %xmm1, %xmm1
    vaesdeclast %xmm5, %xmm7, %xmm7
    vaesdeclast %xmm6, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm5, %xmm7, %xmm7
    vaesdeclast %xmm5, %xmm0, %xmm0
    vaesenc %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm5, %xmm4, %xmm4
    vpsllw $7, %xmm2, %xmm6
    vpsllw $7, %xmm3, %xmm7
    vpcmpgtb %xmm6, %xmm5, %xmm6
    vpcmpgtb %xmm7, %xmm5, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm2, %xmm2
    vpsrlw $1, %xmm3, %xmm3
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2, %xmm2
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vmovdqa %xmm6, %xmm2
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vaesenclast %xmm6, %xmm0, %xmm0
    vaesenclast %xmm7, %xmm1, %xmm1
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm5, %xmm4, %xmm4
    vpsllw $7, %xmm2, %xmm6
    vpsllw $7, %xmm3, %xmm7
    vpcmpgtb %xmm6, %xmm5, %xmm6
    vpcmpgtb %xmm7, %xmm5, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm2, %xmm2
    vpsrlw $1, %xmm3, %xmm3
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2, %xmm2
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vmovdqa %xmm6, %xmm2
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vpunpcklbw %xmm1, %xmm0, %xmm8
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm8, %xmm0
    vaesdeclast %xmm5, %xmm1, %xmm1
    vaesdeclast %xmm5, %xmm7, %xmm7
    vaesdeclast %xmm6, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm5, %xmm7, %xmm7
    vaesdeclast %xmm5, %xmm0, %xmm0
    vaesenc %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm5, %xmm4, %xmm4
    vpsllw $7, %xmm2, %xmm6
    vpsllw $7, %xmm3, %xmm7
    vpcmpgtb %xmm6, %xmm5, %xmm6
    vpcmpgtb %xmm7, %xmm5, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm2, %xmm2
    vpsrlw $1, %xmm3, %xmm3
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2, %xmm2
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vmovdqa %xmm6, %xmm2
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vaesenclast %xmm6, %xmm0, %xmm0
    vaesenclast %xmm7, %xmm1, %xmm1
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm5, %xmm4, %xmm4
    vpsllw $7, %xmm2, %xmm6
    vpsllw $7, %xmm3, %xmm7
    vpcmpgtb %xmm6, %xmm5, %xmm6
    vpcmpgtb %xmm7, %xmm5, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm2, %xmm2
    vpsrlw $1, %xmm3, %xmm3
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2, %xmm2
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vmovdqa %xmm6, %xmm2
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vpunpcklbw %xmm1, %xmm0, %xmm8
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm8, %xmm0
    vaesdeclast %xmm5, %xmm1, %xmm1
    vaesdeclast %xmm5, %xmm7, %xmm7
    vaesdeclast %xmm6, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm5, %xmm7, %xmm7
    vaesdeclast %xmm5, %xmm0, %xmm0
    vaesenc %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm5, %xmm4, %xmm4
    vpsllw $7, %xmm2, %xmm6
    vpsllw $7, %xmm3, %xmm7
    vpcmpgtb %xmm6, %xmm5, %xmm6
    vpcmpgtb %xmm7, %xmm5, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm2, %xmm2
    vpsrlw $1, %xmm3, %xmm3
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2, %xmm2
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vmovdqa %xmm6, %xmm2
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vaesenclast %xmm6, %xmm0, %xmm0
    vaesenclast %xmm7, %xmm1, %xmm1
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm5, %xmm4, %xmm4
    vpsllw $7, %xmm2, %xmm6
    vpsllw $7, %xmm3, %xmm7
    vpcmpgtb %xmm6, %xmm5, %xmm6
    vpcmpgtb %xmm7, %xmm5, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm2, %xmm2
    vpsrlw $1, %xmm3, %xmm3
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2, %xmm2
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vmovdqa %xmm6, %xmm2
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vpunpcklbw %xmm1, %xmm0, %xmm8
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm8, %xmm0
    vaesdeclast %xmm5, %xmm1, %xmm1
    vaesdeclast %xmm5, %xmm7, %xmm7
    vaesdeclast %xmm6, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm5, %xmm7, %xmm7
    vaesdeclast %xmm5, %xmm0, %xmm0
    vaesenc %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm5, %xmm4, %xmm4
    vpsllw $7, %xmm2, %xmm6
    vpsllw $7, %xmm3, %xmm7
    vpcmpgtb %xmm6, %xmm5, %xmm6
    vpcmpgtb %xmm7, %xmm5, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm2, %xmm2
    vpsrlw $1, %xmm3, %xmm3
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2, %xmm2
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vmovdqa %xmm6, %xmm2
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vaesenclast %xmm6, %xmm0, %xmm0
    vaesenclast %xmm7, %xmm1, %xmm1
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm5, %xmm4, %xmm4
    vpsllw $7, %xmm2, %xmm6
    vpsllw $7, %xmm3, %xmm7
    vpcmpgtb %xmm6, %xmm5, %xmm6
    vpcmpgtb %xmm7, %xmm5, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm2, %xmm2
    vpsrlw $1, %xmm3, %xmm3
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2, %xmm2
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vmovdqa %xmm6, %xmm2
    vpxor %xmm4, %xmm2, %xmm6
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vpunpcklbw %xmm1, %xmm0, %xmm8
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm8, %xmm0
    vaesdeclast %xmm5, %xmm1, %xmm1
    vaesdeclast %xmm5, %xmm7, %xmm7
    vaesdeclast %xmm6, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm5, %xmm7, %xmm7
    vaesdeclast %xmm5, %xmm0, %xmm0
    vaesenc %xmm7, %xmm1, %xmm1
    vaesenc %xmm5, %xmm0, %xmm0
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm5, %xmm4, %xmm4
    vpsllw $7, %xmm2, %xmm6
    vpsllw $7, %xmm3, %xmm7
    vpcmpgtb %xmm6, %xmm5, %xmm6
    vpcmpgtb %xmm7, %xmm5, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm2, %xmm2
    vpsrlw $1, %xmm3, %xmm3
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm2, %xmm2
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm3, %xmm3
    vpxor %xmm6, %xmm2, %xmm2
    vpxor %xmm7, %xmm3, %xmm3
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm2
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm3
    vpblendw $0xcc, %xmm3, %xmm2, %xmm6
    vpblendw $0xcc, %xmm2, %xmm3, %xmm3
    vmovdqa %xmm6, %xmm2
    vpxor %xmm4, %xmm2, %xmm6
    vpxor AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm4, %xmm3, %xmm7
    vaesenclast %xmm6, %xmm0, %xmm0
    vaesenclast %xmm7, %xmm1, %xmm1
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
#else
    xorq %rcx, %rcx
    xorq %rdi, %rdi
    xorq %rdx, %rdx
    xorq %rsi, %rsi
#endif
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
    vpxor %xmm11, %xmm11, %xmm11
    vpxor %xmm10, %xmm8, %xmm12
    vpxor AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vpxor %xmm12, %xmm0, %xmm0
    vpxor %xmm13, %xmm1, %xmm1
    vpxor %xmm12, %xmm2, %xmm2
    vpxor %xmm13, %xmm3, %xmm3
    vpxor %xmm12, %xmm4, %xmm4
    vpxor %xmm13, %xmm5, %xmm5
    vpxor %xmm12, %xmm6, %xmm6
    vpxor %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesdec %xmm12, %xmm0, %xmm0
    vaesdec %xmm13, %xmm1, %xmm1
    vaesdec %xmm12, %xmm2, %xmm2
    vaesdec %xmm13, %xmm3, %xmm3
    vaesdec %xmm12, %xmm4, %xmm4
    vaesdec %xmm13, %xmm5, %xmm5
    vaesdec %xmm12, %xmm6, %xmm6
    vaesdec %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesenc %xmm11, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vaesenc %xmm11, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesenc %xmm11, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vpxor %xmm12, %xmm0, %xmm0
    vpxor %xmm13, %xmm1, %xmm1
    vpxor %xmm12, %xmm2, %xmm2
    vpxor %xmm13, %xmm3, %xmm3
    vpxor %xmm12, %xmm4, %xmm4
    vpxor %xmm13, %xmm5, %xmm5
    vpxor %xmm12, %xmm6, %xmm6
    vpxor %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesdec %xmm12, %xmm0, %xmm0
    vaesdec %xmm13, %xmm1, %xmm1
    vaesdec %xmm12, %xmm2, %xmm2
    vaesdec %xmm13, %xmm3, %xmm3
    vaesdec %xmm12, %xmm4, %xmm4
    vaesdec %xmm13, %xmm5, %xmm5
    vaesdec %xmm12, %xmm6, %xmm6
    vaesdec %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesenc %xmm11, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vaesenc %xmm11, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesenc %xmm11, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vpxor %xmm12, %xmm0, %xmm0
    vpxor %xmm13, %xmm1, %xmm1
    vpxor %xmm12, %xmm2, %xmm2
    vpxor %xmm13, %xmm3, %xmm3
    vpxor %xmm12, %xmm4, %xmm4
    vpxor %xmm13, %xmm5, %xmm5
    vpxor %xmm12, %xmm6, %xmm6
    vpxor %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesdec %xmm12, %xmm0, %xmm0
    vaesdec %xmm13, %xmm1, %xmm1
    vaesdec %xmm12, %xmm2, %xmm2
    vaesdec %xmm13, %xmm3, %xmm3
    vaesdec %xmm12, %xmm4, %xmm4
    vaesdec %xmm13, %xmm5, %xmm5
    vaesdec %xmm12, %xmm6, %xmm6
    vaesdec %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesenc %xmm11, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vaesenc %xmm11, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesenc %xmm11, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vpxor %xmm12, %xmm0, %xmm0
    vpxor %xmm13, %xmm1, %xmm1
    vpxor %xmm12, %xmm2, %xmm2
    vpxor %xmm13, %xmm3, %xmm3
    vpxor %xmm12, %xmm4, %xmm4
    vpxor %xmm13, %xmm5, %xmm5
    vpxor %xmm12, %xmm6, %xmm6
    vpxor %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesdec %xmm12, %xmm0, %xmm0
    vaesdec %xmm13, %xmm1, %xmm1
    vaesdec %xmm12, %xmm2, %xmm2
    vaesdec %xmm13, %xmm3, %xmm3
    vaesdec %xmm12, %xmm4, %xmm4
    vaesdec %xmm13, %xmm5, %xmm5
    vaesdec %xmm12, %xmm6, %xmm6
    vaesdec %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesenc %xmm11, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vaesenc %xmm11, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesenc %xmm11, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vpxor %xmm12, %xmm0, %xmm0
    vpxor %xmm13, %xmm1, %xmm1
    vpxor %xmm12, %xmm2, %xmm2
    vpxor %xmm13, %xmm3, %xmm3
    vpxor %xmm12, %xmm4, %xmm4
    vpxor %xmm13, %xmm5, %xmm5
    vpxor %xmm12, %xmm6, %xmm6
    vpxor %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesdec %xmm12, %xmm0, %xmm0
    vaesdec %xmm13, %xmm1, %xmm1
    vaesdec %xmm12, %xmm2, %xmm2
    vaesdec %xmm13, %xmm3, %xmm3
    vaesdec %xmm12, %xmm4, %xmm4
    vaesdec %xmm13, %xmm5, %xmm5
    vaesdec %xmm12, %xmm6, %xmm6
    vaesdec %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesenc %xmm11, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vaesenc %xmm11, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesenc %xmm11, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm0, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm2, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm4, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm6, %xmm14
    vpshufb 64+AREION_SYM(asuraConsts)(%rip), %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vpxor %xmm12, %xmm0, %xmm0
    vpxor %xmm13, %xmm1, %xmm1
    vpxor %xmm12, %xmm2, %xmm2
    vpxor %xmm13, %xmm3, %xmm3
    vpxor %xmm12, %xmm4, %xmm4
    vpxor %xmm13, %xmm5, %xmm5
    vpxor %xmm12, %xmm6, %xmm6
    vpxor %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesdec %xmm12, %xmm0, %xmm0
    vaesdec %xmm13, %xmm1, %xmm1
    vaesdec %xmm12, %xmm2, %xmm2
    vaesdec %xmm13, %xmm3, %xmm3
    vaesdec %xmm12, %xmm4, %xmm4
    vaesdec %xmm13, %xmm5, %xmm5
    vaesdec %xmm12, %xmm6, %xmm6
    vaesdec %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesenc %xmm12, %xmm0, %xmm0
    vaesdec %xmm13, %xmm1, %xmm1
    vmovdqu %xmm0, 0(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vaesenc %xmm12, %xmm2, %xmm2
    vaesdec %xmm13, %xmm3, %xmm3
    vmovdqu %xmm2, 32(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vaesenc %xmm12, %xmm4, %xmm4
    vaesdec %xmm13, %xmm5, %xmm5
    vmovdqu %xmm4, 64(%rdi)
    vmovdqu %xmm5, 80(%rdi)
    vaesenc %xmm12, %xmm6, %xmm6
    vaesdec %xmm13, %xmm7, %xmm7
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
    vpxor %xmm11, %xmm11, %xmm11
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vaesenc %xmm11, %xmm10, %xmm10
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm14, %xmm8
    vpshufb AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpcmpgtb %xmm8, %xmm11, %xmm14
    vpcmpgtb %xmm9, %xmm11, %xmm15
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpaddb %xmm8, %xmm8, %xmm8
    vpaddb %xmm9, %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vpxor %xmm12, %xmm0, %xmm0
    vpxor %xmm13, %xmm1, %xmm1
    vpxor %xmm12, %xmm2, %xmm2
    vpxor %xmm13, %xmm3, %xmm3
    vpxor %xmm12, %xmm4, %xmm4
    vpxor %xmm13, %xmm5, %xmm5
    vpxor %xmm12, %xmm6, %xmm6
    vpxor %xmm13, %xmm7, %xmm7
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm11, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm14
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm14, %xmm11, %xmm14
    vpcmpgtb %xmm15, %xmm11, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm14, %xmm8
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesdeclast %xmm11, %xmm13, %xmm13
    vaesimc %xmm0, %xmm0
    vaesdeclast %xmm11, %xmm1, %xmm1
    vaesimc %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vaesimc %xmm4, %xmm4
    vaesdeclast %xmm11, %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesdeclast %xmm11, %xmm7, %xmm7
    vaesenc %xmm11, %xmm13, %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vaesdeclast %xmm11, %xmm0, %xmm0
    vaesenc %xmm13, %xmm1, %xmm1
    vaesdeclast %xmm11, %xmm2, %xmm2
    vaesenc %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm11, %xmm4, %xmm4
    vaesenc %xmm13, %xmm5, %xmm5
    vaesdeclast %xmm11, %xmm6, %xmm6
    vaesenc %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm0, %xmm0
    vaesenc %xmm11, %xmm2, %xmm2
    vaesenc %xmm11, %xmm4, %xmm4
    vaesenc %xmm11, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm11, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm14
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm14, %xmm11, %xmm14
    vpcmpgtb %xmm15, %xmm11, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm14, %xmm8
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm7, %xmm7
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm11, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm14
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm14, %xmm11, %xmm14
    vpcmpgtb %xmm15, %xmm11, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm14, %xmm8
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesdeclast %xmm11, %xmm13, %xmm13
    vpunpcklbw %xmm1, %xmm0, %xmm14
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm14, %xmm0
    vaesdeclast %xmm11, %xmm1, %xmm1
    vpunpcklbw %xmm3, %xmm2, %xmm14
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm14, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpunpcklbw %xmm5, %xmm4, %xmm14
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm14, %xmm4
    vaesdeclast %xmm11, %xmm5, %xmm5
    vpunpcklbw %xmm7, %xmm6, %xmm14
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm14, %xmm6
    vaesdeclast %xmm11, %xmm7, %xmm7
    vaesenc %xmm11, %xmm13, %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vaesdeclast %xmm11, %xmm0, %xmm0
    vaesenc %xmm13, %xmm1, %xmm1
    vaesdeclast %xmm11, %xmm2, %xmm2
    vaesenc %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm11, %xmm4, %xmm4
    vaesenc %xmm13, %xmm5, %xmm5
    vaesdeclast %xmm11, %xmm6, %xmm6
    vaesenc %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm0, %xmm0
    vaesenc %xmm11, %xmm2, %xmm2
    vaesenc %xmm11, %xmm4, %xmm4
    vaesenc %xmm11, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm11, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm14
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm14, %xmm11, %xmm14
    vpcmpgtb %xmm15, %xmm11, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm14, %xmm8
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm7, %xmm7
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm11, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm14
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm14, %xmm11, %xmm14
    vpcmpgtb %xmm15, %xmm11, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm14, %xmm8
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesdeclast %xmm11, %xmm13, %xmm13
    vpunpcklbw %xmm1, %xmm0, %xmm14
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm14, %xmm0
    vaesdeclast %xmm11, %xmm1, %xmm1
    vpunpcklbw %xmm3, %xmm2, %xmm14
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm14, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpunpcklbw %xmm5, %xmm4, %xmm14
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm14, %xmm4
    vaesdeclast %xmm11, %xmm5, %xmm5
    vpunpcklbw %xmm7, %xmm6, %xmm14
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm14, %xmm6
    vaesdeclast %xmm11, %xmm7, %xmm7
    vaesenc %xmm11, %xmm13, %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vaesdeclast %xmm11, %xmm0, %xmm0
    vaesenc %xmm13, %xmm1, %xmm1
    vaesdeclast %xmm11, %xmm2, %xmm2
    vaesenc %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm11, %xmm4, %xmm4
    vaesenc %xmm13, %xmm5, %xmm5
    vaesdeclast %xmm11, %xmm6, %xmm6
    vaesenc %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm0, %xmm0
    vaesenc %xmm11, %xmm2, %xmm2
    vaesenc %xmm11, %xmm4, %xmm4
    vaesenc %xmm11, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm11, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm14
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm14, %xmm11, %xmm14
    vpcmpgtb %xmm15, %xmm11, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm14, %xmm8
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm7, %xmm7
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm11, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm14
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm14, %xmm11, %xmm14
    vpcmpgtb %xmm15, %xmm11, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm14, %xmm8
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesdeclast %xmm11, %xmm13, %xmm13
    vpunpcklbw %xmm1, %xmm0, %xmm14
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm14, %xmm0
    vaesdeclast %xmm11, %xmm1, %xmm1
    vpunpcklbw %xmm3, %xmm2, %xmm14
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm14, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpunpcklbw %xmm5, %xmm4, %xmm14
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm14, %xmm4
    vaesdeclast %xmm11, %xmm5, %xmm5
    vpunpcklbw %xmm7, %xmm6, %xmm14
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm14, %xmm6
    vaesdeclast %xmm11, %xmm7, %xmm7
    vaesenc %xmm11, %xmm13, %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vaesdeclast %xmm11, %xmm0, %xmm0
    vaesenc %xmm13, %xmm1, %xmm1
    vaesdeclast %xmm11, %xmm2, %xmm2
    vaesenc %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm11, %xmm4, %xmm4
    vaesenc %xmm13, %xmm5, %xmm5
    vaesdeclast %xmm11, %xmm6, %xmm6
    vaesenc %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm0, %xmm0
    vaesenc %xmm11, %xmm2, %xmm2
    vaesenc %xmm11, %xmm4, %xmm4
    vaesenc %xmm11, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm11, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm14
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm14, %xmm11, %xmm14
    vpcmpgtb %xmm15, %xmm11, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm14, %xmm8
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm7, %xmm7
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm11, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm14
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm14, %xmm11, %xmm14
    vpcmpgtb %xmm15, %xmm11, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm14, %xmm8
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesdeclast %xmm11, %xmm13, %xmm13
    vpunpcklbw %xmm1, %xmm0, %xmm14
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm14, %xmm0
    vaesdeclast %xmm11, %xmm1, %xmm1
    vpunpcklbw %xmm3, %xmm2, %xmm14
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm14, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpunpcklbw %xmm5, %xmm4, %xmm14
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm14, %xmm4
    vaesdeclast %xmm11, %xmm5, %xmm5
    vpunpcklbw %xmm7, %xmm6, %xmm14
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm14, %xmm6
    vaesdeclast %xmm11, %xmm7, %xmm7
    vaesenc %xmm11, %xmm13, %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vaesdeclast %xmm11, %xmm0, %xmm0
    vaesenc %xmm13, %xmm1, %xmm1
    vaesdeclast %xmm11, %xmm2, %xmm2
    vaesenc %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm11, %xmm4, %xmm4
    vaesenc %xmm13, %xmm5, %xmm5
    vaesdeclast %xmm11, %xmm6, %xmm6
    vaesenc %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm0, %xmm0
    vaesenc %xmm11, %xmm2, %xmm2
    vaesenc %xmm11, %xmm4, %xmm4
    vaesenc %xmm11, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm11, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm14
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm14, %xmm11, %xmm14
    vpcmpgtb %xmm15, %xmm11, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm14, %xmm8
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm7, %xmm7
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm11, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm14
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm14, %xmm11, %xmm14
    vpcmpgtb %xmm15, %xmm11, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm14, %xmm8
    vpxor %xmm10, %xmm8, %xmm12
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesdeclast %xmm11, %xmm13, %xmm13
    vpunpcklbw %xmm1, %xmm0, %xmm14
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm14, %xmm0
    vaesdeclast %xmm11, %xmm1, %xmm1
    vpunpcklbw %xmm3, %xmm2, %xmm14
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm14, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpunpcklbw %xmm5, %xmm4, %xmm14
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm14, %xmm4
    vaesdeclast %xmm11, %xmm5, %xmm5
    vpunpcklbw %xmm7, %xmm6, %xmm14
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm14, %xmm6
    vaesdeclast %xmm11, %xmm7, %xmm7
    vaesenc %xmm11, %xmm13, %xmm13
    vaesdeclast %xmm12, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesdeclast %xmm12, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vaesdeclast %xmm12, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesdeclast %xmm12, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vaesdeclast %xmm11, %xmm0, %xmm0
    vaesenc %xmm13, %xmm1, %xmm1
    vaesdeclast %xmm11, %xmm2, %xmm2
    vaesenc %xmm13, %xmm3, %xmm3
    vaesdeclast %xmm11, %xmm4, %xmm4
    vaesenc %xmm13, %xmm5, %xmm5
    vaesdeclast %xmm11, %xmm6, %xmm6
    vaesenc %xmm13, %xmm7, %xmm7
    vaesenc %xmm11, %xmm0, %xmm0
    vaesenc %xmm11, %xmm2, %xmm2
    vaesenc %xmm11, %xmm4, %xmm4
    vaesenc %xmm11, %xmm6, %xmm6
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm11, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm14
    vpsllw $7, %xmm9, %xmm15
    vpcmpgtb %xmm14, %xmm11, %xmm14
    vpcmpgtb %xmm15, %xmm11, %xmm15
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm14, %xmm14
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm15, %xmm15
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm14, %xmm8, %xmm8
    vpxor %xmm15, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm14
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm14, %xmm8
    vpxor %xmm10, %xmm8, %xmm12
    vpxor AREION_SYM(asuraRoundConstants)(%rip), %xmm12, %xmm12
    vpxor %xmm10, %xmm9, %xmm13
    vaesenclast %xmm12, %xmm0, %xmm0
    vaesenclast %xmm13, %xmm1, %xmm1
    vaesenclast %xmm12, %xmm2, %xmm2
    vaesenclast %xmm13, %xmm3, %xmm3
    vaesenclast %xmm12, %xmm4, %xmm4
    vaesenclast %xmm13, %xmm5, %xmm5
    vaesenclast %xmm12, %xmm6, %xmm6
    vaesenclast %xmm13, %xmm7, %xmm7
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
    vmovdqu 0(%rcx), %xmm12
    vpxor %ymm4, %ymm4, %ymm4
    vmovdqa 64+AREION_SYM(asuraConsts)(%rip), %ymm5
    vpxor %xmm12, %xmm10, %xmm6
    vpxor AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vpxor %ymm6, %ymm0, %ymm0
    vpxor %ymm7, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
    vaesenc %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vpxor %ymm6, %ymm0, %ymm0
    vpxor %ymm7, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
    vaesenc %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vpxor %ymm6, %ymm0, %ymm0
    vpxor %ymm7, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
    vaesenc %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vpxor %ymm6, %ymm0, %ymm0
    vpxor %ymm7, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
    vaesenc %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vpxor %ymm6, %ymm0, %ymm0
    vpxor %ymm7, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
    vaesenc %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vpxor %ymm6, %ymm0, %ymm0
    vpxor %ymm7, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
    vaesenc %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vaesdec %ymm6, %ymm0, %ymm0
    vaesdec %ymm7, %ymm1, %ymm1
    vaesdec %ymm6, %ymm2, %ymm2
    vaesdec %ymm7, %ymm3, %ymm3
    vaesenc %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
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
    vpxor %ymm10, %ymm10, %ymm10
    vpxor %ymm11, %ymm11, %ymm11
    vpxor %ymm12, %ymm12, %ymm12
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
AREION_FUNC_END(areion_asura_encrypt_4blocks_otf_vaes256_asm)

AREION_FUNC_START(areion_asura_decrypt_4blocks_otf_vaes256_asm)
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
    vmovdqu 0(%rcx), %xmm12
    vpxor %ymm4, %ymm4, %ymm4
    vaesenc %xmm4, %xmm12, %xmm12
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vaesenc %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vpxor %ymm6, %ymm0, %ymm0
    vpxor %ymm7, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vaesdeclast %xmm4, %xmm7, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vaesenclast %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %xmm4, %xmm7, %xmm7
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vaesdec %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesdeclast %ymm6, %ymm0, %ymm0
    vaesenc %ymm7, %ymm1, %ymm1
    vaesdeclast %ymm6, %ymm2, %ymm2
    vaesenc %ymm7, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm2, %ymm2
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesenclast %ymm7, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesenclast %ymm7, %ymm3, %ymm3
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vaesdeclast %xmm4, %xmm7, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vaesenclast %ymm4, %ymm8, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vpunpcklbw %ymm3, %ymm2, %ymm8
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vaesenclast %ymm4, %ymm8, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %xmm4, %xmm7, %xmm7
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vaesdec %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesdeclast %ymm6, %ymm0, %ymm0
    vaesenc %ymm7, %ymm1, %ymm1
    vaesdeclast %ymm6, %ymm2, %ymm2
    vaesenc %ymm7, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm2, %ymm2
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesenclast %ymm7, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesenclast %ymm7, %ymm3, %ymm3
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vaesdeclast %xmm4, %xmm7, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vaesenclast %ymm4, %ymm8, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vpunpcklbw %ymm3, %ymm2, %ymm8
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vaesenclast %ymm4, %ymm8, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %xmm4, %xmm7, %xmm7
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vaesdec %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesdeclast %ymm6, %ymm0, %ymm0
    vaesenc %ymm7, %ymm1, %ymm1
    vaesdeclast %ymm6, %ymm2, %ymm2
    vaesenc %ymm7, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm2, %ymm2
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesenclast %ymm7, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesenclast %ymm7, %ymm3, %ymm3
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vaesdeclast %xmm4, %xmm7, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vaesenclast %ymm4, %ymm8, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vpunpcklbw %ymm3, %ymm2, %ymm8
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vaesenclast %ymm4, %ymm8, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %xmm4, %xmm7, %xmm7
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vaesdec %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesdeclast %ymm6, %ymm0, %ymm0
    vaesenc %ymm7, %ymm1, %ymm1
    vaesdeclast %ymm6, %ymm2, %ymm2
    vaesenc %ymm7, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm2, %ymm2
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesenclast %ymm7, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesenclast %ymm7, %ymm3, %ymm3
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vaesdeclast %xmm4, %xmm7, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vaesenclast %ymm4, %ymm8, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vpunpcklbw %ymm3, %ymm2, %ymm8
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vaesenclast %ymm4, %ymm8, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %xmm4, %xmm7, %xmm7
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vaesdec %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesdeclast %ymm6, %ymm0, %ymm0
    vaesenc %ymm7, %ymm1, %ymm1
    vaesdeclast %ymm6, %ymm2, %ymm2
    vaesenc %ymm7, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm2, %ymm2
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesenclast %ymm7, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesenclast %ymm7, %ymm3, %ymm3
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vaesdeclast %xmm4, %xmm7, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vaesenclast %ymm4, %ymm8, %ymm0
    vaesdeclast %ymm4, %ymm1, %ymm1
    vpunpcklbw %ymm3, %ymm2, %ymm8
    vpunpckhbw %ymm3, %ymm2, %ymm3
    vaesenclast %ymm4, %ymm8, %ymm2
    vaesdeclast %ymm4, %ymm3, %ymm3
    vaesenc %xmm4, %xmm7, %xmm7
    vinserti128 $1, %xmm7, %ymm7, %ymm7
    vaesdec %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesdeclast %ymm6, %ymm0, %ymm0
    vaesenc %ymm7, %ymm1, %ymm1
    vaesdeclast %ymm6, %ymm2, %ymm2
    vaesenc %ymm7, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm2, %ymm2
    vaesimc %xmm12, %xmm12
    vaesdeclast %xmm4, %xmm12, %xmm12
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
    vpxor %xmm12, %xmm10, %xmm6
    vpxor AREION_SYM(asuraRoundConstants)(%rip), %xmm6, %xmm6
    vpxor %xmm12, %xmm11, %xmm7
    vinserti128 $1, %xmm6, %ymm6, %ymm6
    vinserti128 $1, %xmm7, %ymm7, %ymm7
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
    vpxor %ymm9, %ymm9, %ymm9
    vpxor %ymm10, %ymm10, %ymm10
    vpxor %ymm11, %ymm11, %ymm11
    vpxor %ymm12, %ymm12, %ymm12
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
    subq $104, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu64 0(%rsi), %zmm6
    vmovdqu64 64(%rsi), %zmm7
    vshufi64x2 $0x88, %zmm7, %zmm6, %zmm0
    vshufi64x2 $0xDD, %zmm7, %zmm6, %zmm1
    vmovdqu 0(%rdx), %xmm8
    vmovdqu 16(%rdx), %xmm9
    vmovdqu 0(%rcx), %xmm10
    vpxorq %zmm2, %zmm2, %zmm2
    vbroadcasti32x4 64+AREION_SYM(asuraConsts)(%rip), %zmm3
    vpxor %xmm10, %xmm8, %xmm4
    vpxor AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vaesenc %xmm2, %xmm10, %xmm10
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
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm6
    vpshufb %zmm3, %zmm1, %zmm7
    vpunpcklqdq %zmm7, %zmm6, %zmm0
    vpunpckhqdq %zmm7, %zmm6, %zmm1
    vaesenc %xmm2, %xmm10, %xmm10
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
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vaesenc %xmm2, %xmm10, %xmm10
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
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm6
    vpshufb %zmm3, %zmm1, %zmm7
    vpunpcklqdq %zmm7, %zmm6, %zmm0
    vpunpckhqdq %zmm7, %zmm6, %zmm1
    vaesenc %xmm2, %xmm10, %xmm10
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
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vaesenc %xmm2, %xmm10, %xmm10
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
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm6
    vpshufb %zmm3, %zmm1, %zmm7
    vpunpcklqdq %zmm7, %zmm6, %zmm0
    vpunpckhqdq %zmm7, %zmm6, %zmm1
    vaesenc %xmm2, %xmm10, %xmm10
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
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vaesenc %xmm2, %xmm10, %xmm10
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
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm6
    vpshufb %zmm3, %zmm1, %zmm7
    vpunpcklqdq %zmm7, %zmm6, %zmm0
    vpunpckhqdq %zmm7, %zmm6, %zmm1
    vaesenc %xmm2, %xmm10, %xmm10
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
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vaesenc %xmm2, %xmm10, %xmm10
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
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesdec %zmm2, %zmm1, %zmm1
    vpshufb %zmm3, %zmm0, %zmm6
    vpshufb %zmm3, %zmm1, %zmm7
    vpunpcklqdq %zmm7, %zmm6, %zmm0
    vpunpckhqdq %zmm7, %zmm6, %zmm1
    vaesenc %xmm2, %xmm10, %xmm10
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
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vaesenc %xmm2, %xmm10, %xmm10
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
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesdec %zmm4, %zmm0, %zmm0
    vaesdec %zmm5, %zmm1, %zmm1
    vaesenc %xmm2, %xmm10, %xmm10
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
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
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
    vpxorq %zmm9, %zmm9, %zmm9
    vpxorq %zmm10, %zmm10, %zmm10
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
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $104, %rsp
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
    subq $104, %rsp
    movq %rdi, 0(%rsp)
    movq %rsi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    vmovdqu %xmm10, 80(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu64 0(%rsi), %zmm6
    vmovdqu64 64(%rsi), %zmm7
    vshufi64x2 $0x88, %zmm7, %zmm6, %zmm0
    vshufi64x2 $0xDD, %zmm7, %zmm6, %zmm1
    vmovdqu 0(%rdx), %xmm8
    vmovdqu 16(%rdx), %xmm9
    vmovdqu 0(%rcx), %xmm10
    vpxorq %zmm2, %zmm2, %zmm2
    vaesenc %xmm2, %xmm10, %xmm10
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
    vaesenc %xmm2, %xmm10, %xmm10
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
    vaesenc %xmm2, %xmm10, %xmm10
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
    vaesenc %xmm2, %xmm10, %xmm10
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
    vaesenc %xmm2, %xmm10, %xmm10
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
    vaesenc %xmm2, %xmm10, %xmm10
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
    vaesenc %xmm2, %xmm10, %xmm10
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
    vaesenc %xmm2, %xmm10, %xmm10
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
    vaesenc %xmm2, %xmm10, %xmm10
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
    vaesenc %xmm2, %xmm10, %xmm10
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
    vaesenc %xmm2, %xmm10, %xmm10
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
    vaesenc %xmm2, %xmm10, %xmm10
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
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 192+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm2, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm6
    vpsllw $7, %xmm9, %xmm7
    vpcmpgtb %xmm6, %xmm2, %xmm6
    vpcmpgtb %xmm7, %xmm2, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm6, %xmm8
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 176+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vaesdeclast %xmm2, %xmm5, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vaesenclast %zmm2, %zmm0, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %xmm2, %xmm5, %xmm5
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm2, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm6
    vpsllw $7, %xmm9, %xmm7
    vpcmpgtb %xmm6, %xmm2, %xmm6
    vpcmpgtb %xmm7, %xmm2, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm6, %xmm8
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 160+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm2, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm6
    vpsllw $7, %xmm9, %xmm7
    vpcmpgtb %xmm6, %xmm2, %xmm6
    vpcmpgtb %xmm7, %xmm2, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm6, %xmm8
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 144+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vaesdeclast %xmm2, %xmm5, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %xmm2, %xmm5, %xmm5
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm2, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm6
    vpsllw $7, %xmm9, %xmm7
    vpcmpgtb %xmm6, %xmm2, %xmm6
    vpcmpgtb %xmm7, %xmm2, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm6, %xmm8
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 128+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm2, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm6
    vpsllw $7, %xmm9, %xmm7
    vpcmpgtb %xmm6, %xmm2, %xmm6
    vpcmpgtb %xmm7, %xmm2, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm6, %xmm8
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 112+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vaesdeclast %xmm2, %xmm5, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %xmm2, %xmm5, %xmm5
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm2, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm6
    vpsllw $7, %xmm9, %xmm7
    vpcmpgtb %xmm6, %xmm2, %xmm6
    vpcmpgtb %xmm7, %xmm2, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm6, %xmm8
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 96+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm2, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm6
    vpsllw $7, %xmm9, %xmm7
    vpcmpgtb %xmm6, %xmm2, %xmm6
    vpcmpgtb %xmm7, %xmm2, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm6, %xmm8
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 80+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vaesdeclast %xmm2, %xmm5, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %xmm2, %xmm5, %xmm5
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm2, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm6
    vpsllw $7, %xmm9, %xmm7
    vpcmpgtb %xmm6, %xmm2, %xmm6
    vpcmpgtb %xmm7, %xmm2, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm6, %xmm8
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 64+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm2, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm6
    vpsllw $7, %xmm9, %xmm7
    vpcmpgtb %xmm6, %xmm2, %xmm6
    vpcmpgtb %xmm7, %xmm2, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm6, %xmm8
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 48+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vaesdeclast %xmm2, %xmm5, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %xmm2, %xmm5, %xmm5
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm2, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm6
    vpsllw $7, %xmm9, %xmm7
    vpcmpgtb %xmm6, %xmm2, %xmm6
    vpcmpgtb %xmm7, %xmm2, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm6, %xmm8
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 32+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm2, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm6
    vpsllw $7, %xmm9, %xmm7
    vpcmpgtb %xmm6, %xmm2, %xmm6
    vpcmpgtb %xmm7, %xmm2, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm6, %xmm8
    vpxor %xmm10, %xmm8, %xmm4
    vpxor 16+AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vaesdeclast %xmm2, %xmm5, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vpunpcklbw %zmm1, %zmm0, %zmm6
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm2, %zmm6, %zmm0
    vaesdeclast %zmm2, %zmm1, %zmm1
    vaesenc %xmm2, %xmm5, %xmm5
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
    vaesdec %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm1, %zmm1
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesenc %zmm5, %zmm1, %zmm1
    vaesdeclast %zmm2, %zmm0, %zmm0
    vaesenc %zmm2, %zmm0, %zmm0
    vaesimc %xmm10, %xmm10
    vaesdeclast %xmm2, %xmm10, %xmm10
    vpsllw $7, %xmm8, %xmm6
    vpsllw $7, %xmm9, %xmm7
    vpcmpgtb %xmm6, %xmm2, %xmm6
    vpcmpgtb %xmm7, %xmm2, %xmm7
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm6, %xmm6
    vpand 32+AREION_SYM(asuraGFConsts)(%rip), %xmm7, %xmm7
    vpsrlw $1, %xmm8, %xmm8
    vpsrlw $1, %xmm9, %xmm9
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm8, %xmm8
    vpand 64+AREION_SYM(asuraGFConsts)(%rip), %xmm9, %xmm9
    vpxor %xmm6, %xmm8, %xmm8
    vpxor %xmm7, %xmm9, %xmm9
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm8, %xmm8
    vpshufb 32+AREION_SYM(asuraConsts)(%rip), %xmm9, %xmm9
    vpblendw $0xcc, %xmm9, %xmm8, %xmm6
    vpblendw $0xcc, %xmm8, %xmm9, %xmm9
    vmovdqa %xmm6, %xmm8
    vpxor %xmm10, %xmm8, %xmm4
    vpxor AREION_SYM(asuraRoundConstants)(%rip), %xmm4, %xmm4
    vpxor %xmm10, %xmm9, %xmm5
    vshufi32x4 $0x00, %zmm4, %zmm4, %zmm4
    vshufi32x4 $0x00, %zmm5, %zmm5, %zmm5
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
    vpxorq %zmm8, %zmm8, %zmm8
    vpxorq %zmm9, %zmm9, %zmm9
    vpxorq %zmm10, %zmm10, %zmm10
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
    movq 0(%rsp), %rdi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rsi
    movq $0, 8(%rsp)
    addq $104, %rsp
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
