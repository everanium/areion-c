/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#if defined(__x86_64__) || defined(_M_X64)
#include "asm_abi.h"

.text

AREION_FUNC_START(vistrutah256EncryptBlockAsm)
#if !defined(_WIN64)
#else
    subq $104, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    movdqu %xmm6, 16(%rsp)
    movdqu %xmm7, 32(%rsp)
    movdqu %xmm8, 48(%rsp)
    movdqu %xmm9, 64(%rsp)
    movdqu %xmm10, 80(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu (%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu (%rdx), %xmm2
    movdqu 16(%rdx), %xmm3
    movdqa %xmm3, %xmm4
    movdqa %xmm2, %xmm5
    pxor %xmm6, %xmm6
    movdqu AREION_SYM(vistrutahConsts)(%rip), %xmm7
    movdqu 16+AREION_SYM(vistrutahConsts)(%rip), %xmm8
    movdqu 64+AREION_SYM(vistrutahConsts)(%rip), %xmm9
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    aesenc %xmm2, %xmm0
    aesenc %xmm3, %xmm1
    aesenc %xmm6, %xmm0
    aesenc %xmm6, %xmm1
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm10
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm10
    movdqa %xmm10, %xmm1
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10
    pxor %xmm4, %xmm0
    pxor %xmm10, %xmm0
    pxor %xmm5, %xmm1
    aesenc %xmm2, %xmm0
    aesenc %xmm3, %xmm1
    aesenc %xmm6, %xmm0
    aesenc %xmm6, %xmm1
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm10
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm10
    movdqa %xmm10, %xmm1
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10
    pxor %xmm4, %xmm0
    pxor %xmm10, %xmm0
    pxor %xmm5, %xmm1
    aesenc %xmm2, %xmm0
    aesenc %xmm3, %xmm1
    aesenc %xmm6, %xmm0
    aesenc %xmm6, %xmm1
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm10
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm10
    movdqa %xmm10, %xmm1
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10
    pxor %xmm4, %xmm0
    pxor %xmm10, %xmm0
    pxor %xmm5, %xmm1
    aesenc %xmm2, %xmm0
    aesenc %xmm3, %xmm1
    aesenc %xmm6, %xmm0
    aesenc %xmm6, %xmm1
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm10
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm10
    movdqa %xmm10, %xmm1
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10
    pxor %xmm4, %xmm0
    pxor %xmm10, %xmm0
    pxor %xmm5, %xmm1
    cmpq $10, %rcx
    je .Lv256_blk_aesni_final
    aesenc %xmm2, %xmm0
    aesenc %xmm3, %xmm1
    aesenc %xmm6, %xmm0
    aesenc %xmm6, %xmm1
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm10
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm10
    movdqa %xmm10, %xmm1
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10
    pxor %xmm4, %xmm0
    pxor %xmm10, %xmm0
    pxor %xmm5, %xmm1
    aesenc %xmm2, %xmm0
    aesenc %xmm3, %xmm1
    aesenc %xmm6, %xmm0
    aesenc %xmm6, %xmm1
    pshufb %xmm9, %xmm0
    pshufb %xmm9, %xmm1
    movdqa %xmm0, %xmm10
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm10
    movdqa %xmm10, %xmm1
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10
    pxor %xmm4, %xmm0
    pxor %xmm10, %xmm0
    pxor %xmm5, %xmm1
.Lv256_blk_aesni_final:
    aesenc %xmm2, %xmm0
    aesenc %xmm3, %xmm1
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    aesenclast %xmm4, %xmm0
    aesenclast %xmm5, %xmm1
    movdqu %xmm0, (%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $104, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah256EncryptBlockAsm)

AREION_FUNC_START(vistrutah256DecryptBlockAsm)
#if !defined(_WIN64)
#else
    subq $72, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    movdqu %xmm6, 16(%rsp)
    movdqu %xmm7, 32(%rsp)
    movdqu %xmm8, 48(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu (%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu (%rdx), %xmm2
    movdqu 16(%rdx), %xmm3
    movdqa %xmm3, %xmm4
    movdqa %xmm2, %xmm5
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    movdqu 352+AREION_SYM(vistrutahConsts)(%rip), %xmm7
    movdqu 368+AREION_SYM(vistrutahConsts)(%rip), %xmm8
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    cmpq $10, %rcx
    je .Lv256_dec_blk_aesni_init_done
    movdqu AREION_SYM(vistrutahConsts)(%rip), %xmm7
    movdqu 16+AREION_SYM(vistrutahConsts)(%rip), %xmm8
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
.Lv256_dec_blk_aesni_init_done:
    movdqu 288+AREION_SYM(vistrutahConsts)(%rip), %xmm7
    movdqu 304+AREION_SYM(vistrutahConsts)(%rip), %xmm8
    pxor %xmm4, %xmm0
    pxor %xmm5, %xmm1
    cmpq $10, %rcx
    je .Lv256_dec_blk_aesni_step4
    aesdec %xmm2, %xmm0
    aesdec %xmm3, %xmm1
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    pxor %xmm4, %xmm6
    aesdeclast %xmm6, %xmm0
    aesdeclast %xmm5, %xmm1
    movdqa %xmm0, %xmm6
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm6
    movdqa %xmm6, %xmm1
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesdec %xmm2, %xmm0
    aesdec %xmm3, %xmm1
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    pxor %xmm4, %xmm6
    aesdeclast %xmm6, %xmm0
    aesdeclast %xmm5, %xmm1
    movdqa %xmm0, %xmm6
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm6
    movdqa %xmm6, %xmm1
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
.Lv256_dec_blk_aesni_step4:
    aesdec %xmm2, %xmm0
    aesdec %xmm3, %xmm1
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    pxor %xmm4, %xmm6
    aesdeclast %xmm6, %xmm0
    aesdeclast %xmm5, %xmm1
    movdqa %xmm0, %xmm6
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm6
    movdqa %xmm6, %xmm1
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesdec %xmm2, %xmm0
    aesdec %xmm3, %xmm1
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    pxor %xmm4, %xmm6
    aesdeclast %xmm6, %xmm0
    aesdeclast %xmm5, %xmm1
    movdqa %xmm0, %xmm6
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm6
    movdqa %xmm6, %xmm1
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesdec %xmm2, %xmm0
    aesdec %xmm3, %xmm1
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    pxor %xmm4, %xmm6
    aesdeclast %xmm6, %xmm0
    aesdeclast %xmm5, %xmm1
    movdqa %xmm0, %xmm6
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm6
    movdqa %xmm6, %xmm1
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesdec %xmm2, %xmm0
    aesdec %xmm3, %xmm1
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    pxor %xmm4, %xmm6
    aesdeclast %xmm6, %xmm0
    aesdeclast %xmm5, %xmm1
    movdqa %xmm0, %xmm6
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm6
    movdqa %xmm6, %xmm1
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesdec %xmm2, %xmm0
    aesdec %xmm3, %xmm1
    pshufb %xmm7, %xmm4
    pshufb %xmm8, %xmm5
    aesdeclast %xmm4, %xmm0
    aesdeclast %xmm5, %xmm1
    movdqu %xmm0, (%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $72, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah256DecryptBlockAsm)

AREION_FUNC_START(vistrutah256EncryptBlockVexAsm)
#if !defined(_WIN64)
#else
    subq $120, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu (%rdx), %xmm2
    vmovdqu 16(%rdx), %xmm3
    vmovdqa %xmm3, %xmm4
    vmovdqa %xmm2, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    vmovdqu AREION_SYM(vistrutahConsts)(%rip), %xmm7
    vmovdqu 16+AREION_SYM(vistrutahConsts)(%rip), %xmm8
    vmovdqu 64+AREION_SYM(vistrutahConsts)(%rip), %xmm9
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenc %xmm3, %xmm1, %xmm1
    vaesenc %xmm6, %xmm0, %xmm0
    vaesenc %xmm6, %xmm1, %xmm1
    vpshufb %xmm9, %xmm0, %xmm10
    vpshufb %xmm9, %xmm1, %xmm11
    vpunpcklqdq %xmm11, %xmm10, %xmm0
    vpunpckhqdq %xmm11, %xmm10, %xmm1
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm4, %xmm10
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenc %xmm3, %xmm1, %xmm1
    vaesenc %xmm6, %xmm0, %xmm0
    vaesenc %xmm6, %xmm1, %xmm1
    vpshufb %xmm9, %xmm0, %xmm10
    vpshufb %xmm9, %xmm1, %xmm11
    vpunpcklqdq %xmm11, %xmm10, %xmm0
    vpunpckhqdq %xmm11, %xmm10, %xmm1
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm4, %xmm10
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenc %xmm3, %xmm1, %xmm1
    vaesenc %xmm6, %xmm0, %xmm0
    vaesenc %xmm6, %xmm1, %xmm1
    vpshufb %xmm9, %xmm0, %xmm10
    vpshufb %xmm9, %xmm1, %xmm11
    vpunpcklqdq %xmm11, %xmm10, %xmm0
    vpunpckhqdq %xmm11, %xmm10, %xmm1
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm4, %xmm10
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenc %xmm3, %xmm1, %xmm1
    vaesenc %xmm6, %xmm0, %xmm0
    vaesenc %xmm6, %xmm1, %xmm1
    vpshufb %xmm9, %xmm0, %xmm10
    vpshufb %xmm9, %xmm1, %xmm11
    vpunpcklqdq %xmm11, %xmm10, %xmm0
    vpunpckhqdq %xmm11, %xmm10, %xmm1
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm4, %xmm10
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    cmpq $10, %rcx
    je .Lv256_blk_vex_final
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenc %xmm3, %xmm1, %xmm1
    vaesenc %xmm6, %xmm0, %xmm0
    vaesenc %xmm6, %xmm1, %xmm1
    vpshufb %xmm9, %xmm0, %xmm10
    vpshufb %xmm9, %xmm1, %xmm11
    vpunpcklqdq %xmm11, %xmm10, %xmm0
    vpunpckhqdq %xmm11, %xmm10, %xmm1
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm4, %xmm10
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenc %xmm3, %xmm1, %xmm1
    vaesenc %xmm6, %xmm0, %xmm0
    vaesenc %xmm6, %xmm1, %xmm1
    vpshufb %xmm9, %xmm0, %xmm10
    vpshufb %xmm9, %xmm1, %xmm11
    vpunpcklqdq %xmm11, %xmm10, %xmm0
    vpunpckhqdq %xmm11, %xmm10, %xmm1
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm4, %xmm10
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
.Lv256_blk_vex_final:
    vaesenc %xmm2, %xmm0, %xmm0
    vaesenc %xmm3, %xmm1, %xmm1
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
    vaesenclast %xmm4, %xmm0, %xmm0
    vaesenclast %xmm5, %xmm1, %xmm1
    vmovdqu %xmm0, (%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $120, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah256EncryptBlockVexAsm)

AREION_FUNC_START(vistrutah256DecryptBlockVexAsm)
#if !defined(_WIN64)
#else
    subq $72, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu (%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu (%rdx), %xmm2
    vmovdqu 16(%rdx), %xmm3
    vmovdqa %xmm3, %xmm4
    vmovdqa %xmm2, %xmm5
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vpshufb 352+AREION_SYM(vistrutahConsts)(%rip), %xmm4, %xmm4
    vpshufb 368+AREION_SYM(vistrutahConsts)(%rip), %xmm5, %xmm5
    cmpq $10, %rcx
    je .Lv256_dec_blk_vex_init_done
    vmovdqu AREION_SYM(vistrutahConsts)(%rip), %xmm7
    vmovdqu 16+AREION_SYM(vistrutahConsts)(%rip), %xmm8
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
.Lv256_dec_blk_vex_init_done:
    vmovdqu 288+AREION_SYM(vistrutahConsts)(%rip), %xmm7
    vmovdqu 304+AREION_SYM(vistrutahConsts)(%rip), %xmm8
    vpxor %xmm4, %xmm0, %xmm0
    vpxor %xmm5, %xmm1, %xmm1
    cmpq $10, %rcx
    je .Lv256_dec_blk_vex_step4
    vaesdec %xmm2, %xmm0, %xmm0
    vaesdec %xmm3, %xmm1, %xmm1
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm4, %xmm6
    vaesdeclast %xmm6, %xmm0, %xmm0
    vaesdeclast %xmm5, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm6
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm6, %xmm0
    vaesimc %xmm1, %xmm1
    vaesdec %xmm2, %xmm0, %xmm0
    vaesdec %xmm3, %xmm1, %xmm1
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm4, %xmm6
    vaesdeclast %xmm6, %xmm0, %xmm0
    vaesdeclast %xmm5, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm6
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm6, %xmm0
    vaesimc %xmm1, %xmm1
.Lv256_dec_blk_vex_step4:
    vaesdec %xmm2, %xmm0, %xmm0
    vaesdec %xmm3, %xmm1, %xmm1
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm4, %xmm6
    vaesdeclast %xmm6, %xmm0, %xmm0
    vaesdeclast %xmm5, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm6
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm6, %xmm0
    vaesimc %xmm1, %xmm1
    vaesdec %xmm2, %xmm0, %xmm0
    vaesdec %xmm3, %xmm1, %xmm1
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm4, %xmm6
    vaesdeclast %xmm6, %xmm0, %xmm0
    vaesdeclast %xmm5, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm6
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm6, %xmm0
    vaesimc %xmm1, %xmm1
    vaesdec %xmm2, %xmm0, %xmm0
    vaesdec %xmm3, %xmm1, %xmm1
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm4, %xmm6
    vaesdeclast %xmm6, %xmm0, %xmm0
    vaesdeclast %xmm5, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm6
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm6, %xmm0
    vaesimc %xmm1, %xmm1
    vaesdec %xmm2, %xmm0, %xmm0
    vaesdec %xmm3, %xmm1, %xmm1
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm4, %xmm6
    vaesdeclast %xmm6, %xmm0, %xmm0
    vaesdeclast %xmm5, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm6
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm6, %xmm0
    vaesimc %xmm1, %xmm1
    vaesdec %xmm2, %xmm0, %xmm0
    vaesdec %xmm3, %xmm1, %xmm1
    vpshufb %xmm7, %xmm4, %xmm4
    vpshufb %xmm8, %xmm5, %xmm5
    vaesdeclast %xmm4, %xmm0, %xmm0
    vaesdeclast %xmm5, %xmm1, %xmm1
    vmovdqu %xmm0, (%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $72, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah256DecryptBlockVexAsm)

AREION_FUNC_START(vistrutah256EncryptBlockYmmAsm)
#if !defined(_WIN64)
#else
    subq $40, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu (%rsi), %ymm0
    vmovdqu (%rdx), %ymm1
    vperm2i128 $1, %ymm1, %ymm1, %ymm2
    vpxor %xmm3, %xmm3, %xmm3
    vmovdqu AREION_SYM(vistrutahConsts)(%rip), %ymm4
    vmovdqu 64+AREION_SYM(vistrutahConsts)(%rip), %ymm5
    vpxor %ymm2, %ymm0, %ymm0
    vaesenc %ymm1, %ymm0, %ymm0
    vaesenc %ymm3, %ymm0, %ymm0
    vpshufb %ymm5, %ymm0, %ymm0
    vpermq $216, %ymm0, %ymm0
    vpshufb %ymm4, %ymm2, %ymm2
    vmovdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxor %ymm2, %ymm6, %ymm6
    vpxor %ymm6, %ymm0, %ymm0
    vaesenc %ymm1, %ymm0, %ymm0
    vaesenc %ymm3, %ymm0, %ymm0
    vpshufb %ymm5, %ymm0, %ymm0
    vpermq $216, %ymm0, %ymm0
    vpshufb %ymm4, %ymm2, %ymm2
    vmovdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxor %ymm2, %ymm6, %ymm6
    vpxor %ymm6, %ymm0, %ymm0
    vaesenc %ymm1, %ymm0, %ymm0
    vaesenc %ymm3, %ymm0, %ymm0
    vpshufb %ymm5, %ymm0, %ymm0
    vpermq $216, %ymm0, %ymm0
    vpshufb %ymm4, %ymm2, %ymm2
    vmovdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxor %ymm2, %ymm6, %ymm6
    vpxor %ymm6, %ymm0, %ymm0
    vaesenc %ymm1, %ymm0, %ymm0
    vaesenc %ymm3, %ymm0, %ymm0
    vpshufb %ymm5, %ymm0, %ymm0
    vpermq $216, %ymm0, %ymm0
    vpshufb %ymm4, %ymm2, %ymm2
    vmovdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxor %ymm2, %ymm6, %ymm6
    vpxor %ymm6, %ymm0, %ymm0
    cmpq $10, %rcx
    je .Lv256_blk_ymm_final
    vaesenc %ymm1, %ymm0, %ymm0
    vaesenc %ymm3, %ymm0, %ymm0
    vpshufb %ymm5, %ymm0, %ymm0
    vpermq $216, %ymm0, %ymm0
    vpshufb %ymm4, %ymm2, %ymm2
    vmovdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxor %ymm2, %ymm6, %ymm6
    vpxor %ymm6, %ymm0, %ymm0
    vaesenc %ymm1, %ymm0, %ymm0
    vaesenc %ymm3, %ymm0, %ymm0
    vpshufb %ymm5, %ymm0, %ymm0
    vpermq $216, %ymm0, %ymm0
    vpshufb %ymm4, %ymm2, %ymm2
    vmovdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxor %ymm2, %ymm6, %ymm6
    vpxor %ymm6, %ymm0, %ymm0
.Lv256_blk_ymm_final:
    vaesenc %ymm1, %ymm0, %ymm0
    vpshufb %ymm4, %ymm2, %ymm2
    vaesenclast %ymm2, %ymm0, %ymm0
    vmovdqu %ymm0, (%rdi)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
#if defined(_WIN64)
    vmovdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $40, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah256EncryptBlockYmmAsm)

AREION_FUNC_START(vistrutah256DecryptBlockYmmAsm)
#if !defined(_WIN64)
#else
    subq $40, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu (%rsi), %ymm0
    vmovdqu (%rdx), %ymm1
    vperm2i128 $1, %ymm1, %ymm1, %ymm2
    vpxor %xmm3, %xmm3, %xmm3
    vaesenclast %ymm3, %ymm1, %ymm1
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb 352+AREION_SYM(vistrutahConsts)(%rip), %ymm2, %ymm2
    cmpq $10, %rcx
    je .Lv256_dec_blk_ymm_init_done
    vmovdqu AREION_SYM(vistrutahConsts)(%rip), %ymm4
    vpshufb %ymm4, %ymm2, %ymm2
    vpshufb %ymm4, %ymm2, %ymm2
.Lv256_dec_blk_ymm_init_done:
    vmovdqu 288+AREION_SYM(vistrutahConsts)(%rip), %ymm4
    vmovdqu 416+AREION_SYM(vistrutahConsts)(%rip), %ymm5
    vpxor %ymm2, %ymm0, %ymm0
    cmpq $10, %rcx
    je .Lv256_dec_blk_ymm_step4
    vaesdec %ymm1, %ymm0, %ymm0
    vpshufb %ymm4, %ymm2, %ymm2
    vmovdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxor %ymm2, %ymm6, %ymm6
    vaesdeclast %ymm6, %ymm0, %ymm0
    vpermq $216, %ymm0, %ymm0
    vpshufb %ymm5, %ymm0, %ymm0
    vaesenclast %ymm3, %ymm0, %ymm0
    vaesdec %ymm3, %ymm0, %ymm0
    vaesdec %ymm1, %ymm0, %ymm0
    vpshufb %ymm4, %ymm2, %ymm2
    vmovdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxor %ymm2, %ymm6, %ymm6
    vaesdeclast %ymm6, %ymm0, %ymm0
    vpermq $216, %ymm0, %ymm0
    vpshufb %ymm5, %ymm0, %ymm0
    vaesenclast %ymm3, %ymm0, %ymm0
    vaesdec %ymm3, %ymm0, %ymm0
.Lv256_dec_blk_ymm_step4:
    vaesdec %ymm1, %ymm0, %ymm0
    vpshufb %ymm4, %ymm2, %ymm2
    vmovdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxor %ymm2, %ymm6, %ymm6
    vaesdeclast %ymm6, %ymm0, %ymm0
    vpermq $216, %ymm0, %ymm0
    vpshufb %ymm5, %ymm0, %ymm0
    vaesenclast %ymm3, %ymm0, %ymm0
    vaesdec %ymm3, %ymm0, %ymm0
    vaesdec %ymm1, %ymm0, %ymm0
    vpshufb %ymm4, %ymm2, %ymm2
    vmovdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxor %ymm2, %ymm6, %ymm6
    vaesdeclast %ymm6, %ymm0, %ymm0
    vpermq $216, %ymm0, %ymm0
    vpshufb %ymm5, %ymm0, %ymm0
    vaesenclast %ymm3, %ymm0, %ymm0
    vaesdec %ymm3, %ymm0, %ymm0
    vaesdec %ymm1, %ymm0, %ymm0
    vpshufb %ymm4, %ymm2, %ymm2
    vmovdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxor %ymm2, %ymm6, %ymm6
    vaesdeclast %ymm6, %ymm0, %ymm0
    vpermq $216, %ymm0, %ymm0
    vpshufb %ymm5, %ymm0, %ymm0
    vaesenclast %ymm3, %ymm0, %ymm0
    vaesdec %ymm3, %ymm0, %ymm0
    vaesdec %ymm1, %ymm0, %ymm0
    vpshufb %ymm4, %ymm2, %ymm2
    vmovdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxor %ymm2, %ymm6, %ymm6
    vaesdeclast %ymm6, %ymm0, %ymm0
    vpermq $216, %ymm0, %ymm0
    vpshufb %ymm5, %ymm0, %ymm0
    vaesenclast %ymm3, %ymm0, %ymm0
    vaesdec %ymm3, %ymm0, %ymm0
    vaesdec %ymm1, %ymm0, %ymm0
    vpshufb %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm2, %ymm0, %ymm0
    vmovdqu %ymm0, (%rdi)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    vpxor %xmm6, %xmm6, %xmm6
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
#if defined(_WIN64)
    vmovdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $40, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah256DecryptBlockYmmAsm)

AREION_FUNC_START(vistrutah256Encrypt4BlocksAesNiAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
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
    movdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu (%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    movdqu 64(%rsi), %xmm4
    movdqu 80(%rsi), %xmm5
    movdqu 96(%rsi), %xmm6
    movdqu 112(%rsi), %xmm7
    movdqu (%rdx), %xmm8
    movdqu 16(%rdx), %xmm9
    movdqa %xmm9, %xmm10
    movdqa %xmm8, %xmm11
    pxor %xmm12, %xmm12
    movdqu 64+AREION_SYM(vistrutahConsts)(%rip), %xmm13
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm10, %xmm4
    pxor %xmm11, %xmm5
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    aesenc %xmm8, %xmm0
    aesenc %xmm9, %xmm1
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    pshufb %xmm13, %xmm0
    pshufb %xmm13, %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesenc %xmm8, %xmm2
    aesenc %xmm9, %xmm3
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    pshufb %xmm13, %xmm2
    pshufb %xmm13, %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesenc %xmm8, %xmm4
    aesenc %xmm9, %xmm5
    aesenc %xmm12, %xmm4
    aesenc %xmm12, %xmm5
    pshufb %xmm13, %xmm4
    pshufb %xmm13, %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesenc %xmm8, %xmm6
    aesenc %xmm9, %xmm7
    aesenc %xmm12, %xmm6
    aesenc %xmm12, %xmm7
    pshufb %xmm13, %xmm6
    pshufb %xmm13, %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    movdqu AREION_SYM(vistrutahConsts)(%rip), %xmm14
    movdqu 16+AREION_SYM(vistrutahConsts)(%rip), %xmm15
    pshufb %xmm14, %xmm10
    pshufb %xmm15, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm14
    pxor %xmm10, %xmm14
    pxor %xmm14, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm14, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm14, %xmm4
    pxor %xmm11, %xmm5
    pxor %xmm14, %xmm6
    pxor %xmm11, %xmm7
    aesenc %xmm8, %xmm0
    aesenc %xmm9, %xmm1
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    pshufb %xmm13, %xmm0
    pshufb %xmm13, %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesenc %xmm8, %xmm2
    aesenc %xmm9, %xmm3
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    pshufb %xmm13, %xmm2
    pshufb %xmm13, %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesenc %xmm8, %xmm4
    aesenc %xmm9, %xmm5
    aesenc %xmm12, %xmm4
    aesenc %xmm12, %xmm5
    pshufb %xmm13, %xmm4
    pshufb %xmm13, %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesenc %xmm8, %xmm6
    aesenc %xmm9, %xmm7
    aesenc %xmm12, %xmm6
    aesenc %xmm12, %xmm7
    pshufb %xmm13, %xmm6
    pshufb %xmm13, %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    movdqu AREION_SYM(vistrutahConsts)(%rip), %xmm14
    movdqu 16+AREION_SYM(vistrutahConsts)(%rip), %xmm15
    pshufb %xmm14, %xmm10
    pshufb %xmm15, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm14
    pxor %xmm10, %xmm14
    pxor %xmm14, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm14, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm14, %xmm4
    pxor %xmm11, %xmm5
    pxor %xmm14, %xmm6
    pxor %xmm11, %xmm7
    aesenc %xmm8, %xmm0
    aesenc %xmm9, %xmm1
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    pshufb %xmm13, %xmm0
    pshufb %xmm13, %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesenc %xmm8, %xmm2
    aesenc %xmm9, %xmm3
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    pshufb %xmm13, %xmm2
    pshufb %xmm13, %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesenc %xmm8, %xmm4
    aesenc %xmm9, %xmm5
    aesenc %xmm12, %xmm4
    aesenc %xmm12, %xmm5
    pshufb %xmm13, %xmm4
    pshufb %xmm13, %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesenc %xmm8, %xmm6
    aesenc %xmm9, %xmm7
    aesenc %xmm12, %xmm6
    aesenc %xmm12, %xmm7
    pshufb %xmm13, %xmm6
    pshufb %xmm13, %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    movdqu AREION_SYM(vistrutahConsts)(%rip), %xmm14
    movdqu 16+AREION_SYM(vistrutahConsts)(%rip), %xmm15
    pshufb %xmm14, %xmm10
    pshufb %xmm15, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm14
    pxor %xmm10, %xmm14
    pxor %xmm14, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm14, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm14, %xmm4
    pxor %xmm11, %xmm5
    pxor %xmm14, %xmm6
    pxor %xmm11, %xmm7
    aesenc %xmm8, %xmm0
    aesenc %xmm9, %xmm1
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    pshufb %xmm13, %xmm0
    pshufb %xmm13, %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesenc %xmm8, %xmm2
    aesenc %xmm9, %xmm3
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    pshufb %xmm13, %xmm2
    pshufb %xmm13, %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesenc %xmm8, %xmm4
    aesenc %xmm9, %xmm5
    aesenc %xmm12, %xmm4
    aesenc %xmm12, %xmm5
    pshufb %xmm13, %xmm4
    pshufb %xmm13, %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesenc %xmm8, %xmm6
    aesenc %xmm9, %xmm7
    aesenc %xmm12, %xmm6
    aesenc %xmm12, %xmm7
    pshufb %xmm13, %xmm6
    pshufb %xmm13, %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    movdqu AREION_SYM(vistrutahConsts)(%rip), %xmm14
    movdqu 16+AREION_SYM(vistrutahConsts)(%rip), %xmm15
    pshufb %xmm14, %xmm10
    pshufb %xmm15, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm14
    pxor %xmm10, %xmm14
    pxor %xmm14, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm14, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm14, %xmm4
    pxor %xmm11, %xmm5
    pxor %xmm14, %xmm6
    pxor %xmm11, %xmm7
    cmpq $10, %rcx
    je .Lv256_4blk_aesni_final
    aesenc %xmm8, %xmm0
    aesenc %xmm9, %xmm1
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    pshufb %xmm13, %xmm0
    pshufb %xmm13, %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesenc %xmm8, %xmm2
    aesenc %xmm9, %xmm3
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    pshufb %xmm13, %xmm2
    pshufb %xmm13, %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesenc %xmm8, %xmm4
    aesenc %xmm9, %xmm5
    aesenc %xmm12, %xmm4
    aesenc %xmm12, %xmm5
    pshufb %xmm13, %xmm4
    pshufb %xmm13, %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesenc %xmm8, %xmm6
    aesenc %xmm9, %xmm7
    aesenc %xmm12, %xmm6
    aesenc %xmm12, %xmm7
    pshufb %xmm13, %xmm6
    pshufb %xmm13, %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    movdqu AREION_SYM(vistrutahConsts)(%rip), %xmm14
    movdqu 16+AREION_SYM(vistrutahConsts)(%rip), %xmm15
    pshufb %xmm14, %xmm10
    pshufb %xmm15, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm14
    pxor %xmm10, %xmm14
    pxor %xmm14, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm14, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm14, %xmm4
    pxor %xmm11, %xmm5
    pxor %xmm14, %xmm6
    pxor %xmm11, %xmm7
    aesenc %xmm8, %xmm0
    aesenc %xmm9, %xmm1
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    pshufb %xmm13, %xmm0
    pshufb %xmm13, %xmm1
    movdqa %xmm0, %xmm14
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm14
    movdqa %xmm14, %xmm1
    aesenc %xmm8, %xmm2
    aesenc %xmm9, %xmm3
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    pshufb %xmm13, %xmm2
    pshufb %xmm13, %xmm3
    movdqa %xmm2, %xmm14
    punpcklqdq %xmm3, %xmm2
    punpckhqdq %xmm3, %xmm14
    movdqa %xmm14, %xmm3
    aesenc %xmm8, %xmm4
    aesenc %xmm9, %xmm5
    aesenc %xmm12, %xmm4
    aesenc %xmm12, %xmm5
    pshufb %xmm13, %xmm4
    pshufb %xmm13, %xmm5
    movdqa %xmm4, %xmm14
    punpcklqdq %xmm5, %xmm4
    punpckhqdq %xmm5, %xmm14
    movdqa %xmm14, %xmm5
    aesenc %xmm8, %xmm6
    aesenc %xmm9, %xmm7
    aesenc %xmm12, %xmm6
    aesenc %xmm12, %xmm7
    pshufb %xmm13, %xmm6
    pshufb %xmm13, %xmm7
    movdqa %xmm6, %xmm14
    punpcklqdq %xmm7, %xmm6
    punpckhqdq %xmm7, %xmm14
    movdqa %xmm14, %xmm7
    movdqu AREION_SYM(vistrutahConsts)(%rip), %xmm14
    movdqu 16+AREION_SYM(vistrutahConsts)(%rip), %xmm15
    pshufb %xmm14, %xmm10
    pshufb %xmm15, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm14
    pxor %xmm10, %xmm14
    pxor %xmm14, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm14, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm14, %xmm4
    pxor %xmm11, %xmm5
    pxor %xmm14, %xmm6
    pxor %xmm11, %xmm7
.Lv256_4blk_aesni_final:
    aesenc %xmm8, %xmm0
    aesenc %xmm9, %xmm1
    aesenc %xmm8, %xmm2
    aesenc %xmm9, %xmm3
    aesenc %xmm8, %xmm4
    aesenc %xmm9, %xmm5
    aesenc %xmm8, %xmm6
    aesenc %xmm9, %xmm7
    movdqu AREION_SYM(vistrutahConsts)(%rip), %xmm14
    movdqu 16+AREION_SYM(vistrutahConsts)(%rip), %xmm15
    pshufb %xmm14, %xmm10
    pshufb %xmm15, %xmm11
    aesenclast %xmm10, %xmm0
    aesenclast %xmm11, %xmm1
    aesenclast %xmm10, %xmm2
    aesenclast %xmm11, %xmm3
    aesenclast %xmm10, %xmm4
    aesenclast %xmm11, %xmm5
    aesenclast %xmm10, %xmm6
    aesenclast %xmm11, %xmm7
    movdqu %xmm0, (%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah256Encrypt4BlocksAesNiAsm)

AREION_FUNC_START(vistrutah256Decrypt4BlocksAesNiAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
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
    movdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu (%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    movdqu 64(%rsi), %xmm4
    movdqu 80(%rsi), %xmm5
    movdqu 96(%rsi), %xmm6
    movdqu 112(%rsi), %xmm7
    movdqu (%rdx), %xmm8
    movdqu 16(%rdx), %xmm9
    movdqa %xmm9, %xmm10
    movdqa %xmm8, %xmm11
    aesimc %xmm8, %xmm8
    aesimc %xmm9, %xmm9
    movdqu 352+AREION_SYM(vistrutahConsts)(%rip), %xmm12
    movdqu 368+AREION_SYM(vistrutahConsts)(%rip), %xmm13
    pshufb %xmm12, %xmm10
    pshufb %xmm13, %xmm11
    cmpq $10, %rcx
    je .Lv256_dec_4blk_aesni_init_done
    movdqu AREION_SYM(vistrutahConsts)(%rip), %xmm12
    movdqu 16+AREION_SYM(vistrutahConsts)(%rip), %xmm13
    pshufb %xmm12, %xmm10
    pshufb %xmm13, %xmm11
    pshufb %xmm12, %xmm10
    pshufb %xmm13, %xmm11
.Lv256_dec_4blk_aesni_init_done:
    movdqu 288+AREION_SYM(vistrutahConsts)(%rip), %xmm12
    movdqu 304+AREION_SYM(vistrutahConsts)(%rip), %xmm13
    pxor %xmm10, %xmm0
    pxor %xmm11, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    pxor %xmm10, %xmm4
    pxor %xmm11, %xmm5
    pxor %xmm10, %xmm6
    pxor %xmm11, %xmm7
    cmpq $10, %rcx
    je .Lv256_dec_4blk_aesni_step4
    pshufb %xmm12, %xmm10
    pshufb %xmm13, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm14
    pxor %xmm10, %xmm14
    aesdec %xmm8, %xmm0
    aesdec %xmm9, %xmm1
    aesdeclast %xmm14, %xmm0
    aesdeclast %xmm11, %xmm1
    movdqa %xmm0, %xmm15
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm15
    movdqa %xmm15, %xmm1
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesdec %xmm8, %xmm2
    aesdec %xmm9, %xmm3
    aesdeclast %xmm14, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqa %xmm2, %xmm15
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm15
    movdqa %xmm15, %xmm3
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm8, %xmm4
    aesdec %xmm9, %xmm5
    aesdeclast %xmm14, %xmm4
    aesdeclast %xmm11, %xmm5
    movdqa %xmm4, %xmm15
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm15
    movdqa %xmm15, %xmm5
    aesimc %xmm4, %xmm4
    aesimc %xmm5, %xmm5
    aesdec %xmm8, %xmm6
    aesdec %xmm9, %xmm7
    aesdeclast %xmm14, %xmm6
    aesdeclast %xmm11, %xmm7
    movdqa %xmm6, %xmm15
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm15
    movdqa %xmm15, %xmm7
    aesimc %xmm6, %xmm6
    aesimc %xmm7, %xmm7
    pshufb %xmm12, %xmm10
    pshufb %xmm13, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm14
    pxor %xmm10, %xmm14
    aesdec %xmm8, %xmm0
    aesdec %xmm9, %xmm1
    aesdeclast %xmm14, %xmm0
    aesdeclast %xmm11, %xmm1
    movdqa %xmm0, %xmm15
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm15
    movdqa %xmm15, %xmm1
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesdec %xmm8, %xmm2
    aesdec %xmm9, %xmm3
    aesdeclast %xmm14, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqa %xmm2, %xmm15
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm15
    movdqa %xmm15, %xmm3
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm8, %xmm4
    aesdec %xmm9, %xmm5
    aesdeclast %xmm14, %xmm4
    aesdeclast %xmm11, %xmm5
    movdqa %xmm4, %xmm15
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm15
    movdqa %xmm15, %xmm5
    aesimc %xmm4, %xmm4
    aesimc %xmm5, %xmm5
    aesdec %xmm8, %xmm6
    aesdec %xmm9, %xmm7
    aesdeclast %xmm14, %xmm6
    aesdeclast %xmm11, %xmm7
    movdqa %xmm6, %xmm15
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm15
    movdqa %xmm15, %xmm7
    aesimc %xmm6, %xmm6
    aesimc %xmm7, %xmm7
.Lv256_dec_4blk_aesni_step4:
    pshufb %xmm12, %xmm10
    pshufb %xmm13, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm14
    pxor %xmm10, %xmm14
    aesdec %xmm8, %xmm0
    aesdec %xmm9, %xmm1
    aesdeclast %xmm14, %xmm0
    aesdeclast %xmm11, %xmm1
    movdqa %xmm0, %xmm15
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm15
    movdqa %xmm15, %xmm1
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesdec %xmm8, %xmm2
    aesdec %xmm9, %xmm3
    aesdeclast %xmm14, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqa %xmm2, %xmm15
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm15
    movdqa %xmm15, %xmm3
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm8, %xmm4
    aesdec %xmm9, %xmm5
    aesdeclast %xmm14, %xmm4
    aesdeclast %xmm11, %xmm5
    movdqa %xmm4, %xmm15
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm15
    movdqa %xmm15, %xmm5
    aesimc %xmm4, %xmm4
    aesimc %xmm5, %xmm5
    aesdec %xmm8, %xmm6
    aesdec %xmm9, %xmm7
    aesdeclast %xmm14, %xmm6
    aesdeclast %xmm11, %xmm7
    movdqa %xmm6, %xmm15
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm15
    movdqa %xmm15, %xmm7
    aesimc %xmm6, %xmm6
    aesimc %xmm7, %xmm7
    pshufb %xmm12, %xmm10
    pshufb %xmm13, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm14
    pxor %xmm10, %xmm14
    aesdec %xmm8, %xmm0
    aesdec %xmm9, %xmm1
    aesdeclast %xmm14, %xmm0
    aesdeclast %xmm11, %xmm1
    movdqa %xmm0, %xmm15
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm15
    movdqa %xmm15, %xmm1
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesdec %xmm8, %xmm2
    aesdec %xmm9, %xmm3
    aesdeclast %xmm14, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqa %xmm2, %xmm15
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm15
    movdqa %xmm15, %xmm3
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm8, %xmm4
    aesdec %xmm9, %xmm5
    aesdeclast %xmm14, %xmm4
    aesdeclast %xmm11, %xmm5
    movdqa %xmm4, %xmm15
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm15
    movdqa %xmm15, %xmm5
    aesimc %xmm4, %xmm4
    aesimc %xmm5, %xmm5
    aesdec %xmm8, %xmm6
    aesdec %xmm9, %xmm7
    aesdeclast %xmm14, %xmm6
    aesdeclast %xmm11, %xmm7
    movdqa %xmm6, %xmm15
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm15
    movdqa %xmm15, %xmm7
    aesimc %xmm6, %xmm6
    aesimc %xmm7, %xmm7
    pshufb %xmm12, %xmm10
    pshufb %xmm13, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm14
    pxor %xmm10, %xmm14
    aesdec %xmm8, %xmm0
    aesdec %xmm9, %xmm1
    aesdeclast %xmm14, %xmm0
    aesdeclast %xmm11, %xmm1
    movdqa %xmm0, %xmm15
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm15
    movdqa %xmm15, %xmm1
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesdec %xmm8, %xmm2
    aesdec %xmm9, %xmm3
    aesdeclast %xmm14, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqa %xmm2, %xmm15
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm15
    movdqa %xmm15, %xmm3
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm8, %xmm4
    aesdec %xmm9, %xmm5
    aesdeclast %xmm14, %xmm4
    aesdeclast %xmm11, %xmm5
    movdqa %xmm4, %xmm15
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm15
    movdqa %xmm15, %xmm5
    aesimc %xmm4, %xmm4
    aesimc %xmm5, %xmm5
    aesdec %xmm8, %xmm6
    aesdec %xmm9, %xmm7
    aesdeclast %xmm14, %xmm6
    aesdeclast %xmm11, %xmm7
    movdqa %xmm6, %xmm15
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm15
    movdqa %xmm15, %xmm7
    aesimc %xmm6, %xmm6
    aesimc %xmm7, %xmm7
    pshufb %xmm12, %xmm10
    pshufb %xmm13, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm14
    pxor %xmm10, %xmm14
    aesdec %xmm8, %xmm0
    aesdec %xmm9, %xmm1
    aesdeclast %xmm14, %xmm0
    aesdeclast %xmm11, %xmm1
    movdqa %xmm0, %xmm15
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm15
    movdqa %xmm15, %xmm1
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesdec %xmm8, %xmm2
    aesdec %xmm9, %xmm3
    aesdeclast %xmm14, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqa %xmm2, %xmm15
    punpcklbw %xmm3, %xmm2
    punpckhbw %xmm3, %xmm15
    movdqa %xmm15, %xmm3
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm8, %xmm4
    aesdec %xmm9, %xmm5
    aesdeclast %xmm14, %xmm4
    aesdeclast %xmm11, %xmm5
    movdqa %xmm4, %xmm15
    punpcklbw %xmm5, %xmm4
    punpckhbw %xmm5, %xmm15
    movdqa %xmm15, %xmm5
    aesimc %xmm4, %xmm4
    aesimc %xmm5, %xmm5
    aesdec %xmm8, %xmm6
    aesdec %xmm9, %xmm7
    aesdeclast %xmm14, %xmm6
    aesdeclast %xmm11, %xmm7
    movdqa %xmm6, %xmm15
    punpcklbw %xmm7, %xmm6
    punpckhbw %xmm7, %xmm15
    movdqa %xmm15, %xmm7
    aesimc %xmm6, %xmm6
    aesimc %xmm7, %xmm7
    pshufb %xmm12, %xmm10
    pshufb %xmm13, %xmm11
    aesdec %xmm8, %xmm0
    aesdec %xmm9, %xmm1
    aesdeclast %xmm10, %xmm0
    aesdeclast %xmm11, %xmm1
    aesdec %xmm8, %xmm2
    aesdec %xmm9, %xmm3
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    aesdec %xmm8, %xmm4
    aesdec %xmm9, %xmm5
    aesdeclast %xmm10, %xmm4
    aesdeclast %xmm11, %xmm5
    aesdec %xmm8, %xmm6
    aesdec %xmm9, %xmm7
    aesdeclast %xmm10, %xmm6
    aesdeclast %xmm11, %xmm7
    movdqu %xmm0, (%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah256Decrypt4BlocksAesNiAsm)

AREION_FUNC_START(vistrutah256Encrypt4BlocksVexAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vmovdqu 64(%rsi), %xmm4
    vmovdqu 80(%rsi), %xmm5
    vmovdqu 96(%rsi), %xmm6
    vmovdqu 112(%rsi), %xmm7
    vmovdqu (%rdx), %xmm8
    vmovdqu 16(%rdx), %xmm9
    vmovdqa %xmm9, %xmm10
    vmovdqa %xmm8, %xmm11
    vpxor %xmm12, %xmm12, %xmm12
    vmovdqu 64+AREION_SYM(vistrutahConsts)(%rip), %xmm13
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm10, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm10, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    vaesenc %xmm8, %xmm0, %xmm0
    vaesenc %xmm9, %xmm1, %xmm1
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vpshufb %xmm13, %xmm0, %xmm14
    vpshufb %xmm13, %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesenc %xmm9, %xmm3, %xmm3
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpshufb %xmm13, %xmm2, %xmm14
    vpshufb %xmm13, %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesenc %xmm9, %xmm5, %xmm5
    vaesenc %xmm12, %xmm4, %xmm4
    vaesenc %xmm12, %xmm5, %xmm5
    vpshufb %xmm13, %xmm4, %xmm14
    vpshufb %xmm13, %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesenc %xmm9, %xmm7, %xmm7
    vaesenc %xmm12, %xmm6, %xmm6
    vaesenc %xmm12, %xmm7, %xmm7
    vpshufb %xmm13, %xmm6, %xmm14
    vpshufb %xmm13, %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vpshufb AREION_SYM(vistrutahConsts)(%rip), %xmm10, %xmm10
    vpshufb 16+AREION_SYM(vistrutahConsts)(%rip), %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10, %xmm14
    vpxor %xmm14, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm14, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm14, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm14, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    vaesenc %xmm8, %xmm0, %xmm0
    vaesenc %xmm9, %xmm1, %xmm1
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vpshufb %xmm13, %xmm0, %xmm14
    vpshufb %xmm13, %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesenc %xmm9, %xmm3, %xmm3
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpshufb %xmm13, %xmm2, %xmm14
    vpshufb %xmm13, %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesenc %xmm9, %xmm5, %xmm5
    vaesenc %xmm12, %xmm4, %xmm4
    vaesenc %xmm12, %xmm5, %xmm5
    vpshufb %xmm13, %xmm4, %xmm14
    vpshufb %xmm13, %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesenc %xmm9, %xmm7, %xmm7
    vaesenc %xmm12, %xmm6, %xmm6
    vaesenc %xmm12, %xmm7, %xmm7
    vpshufb %xmm13, %xmm6, %xmm14
    vpshufb %xmm13, %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vpshufb AREION_SYM(vistrutahConsts)(%rip), %xmm10, %xmm10
    vpshufb 16+AREION_SYM(vistrutahConsts)(%rip), %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10, %xmm14
    vpxor %xmm14, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm14, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm14, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm14, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    vaesenc %xmm8, %xmm0, %xmm0
    vaesenc %xmm9, %xmm1, %xmm1
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vpshufb %xmm13, %xmm0, %xmm14
    vpshufb %xmm13, %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesenc %xmm9, %xmm3, %xmm3
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpshufb %xmm13, %xmm2, %xmm14
    vpshufb %xmm13, %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesenc %xmm9, %xmm5, %xmm5
    vaesenc %xmm12, %xmm4, %xmm4
    vaesenc %xmm12, %xmm5, %xmm5
    vpshufb %xmm13, %xmm4, %xmm14
    vpshufb %xmm13, %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesenc %xmm9, %xmm7, %xmm7
    vaesenc %xmm12, %xmm6, %xmm6
    vaesenc %xmm12, %xmm7, %xmm7
    vpshufb %xmm13, %xmm6, %xmm14
    vpshufb %xmm13, %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vpshufb AREION_SYM(vistrutahConsts)(%rip), %xmm10, %xmm10
    vpshufb 16+AREION_SYM(vistrutahConsts)(%rip), %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10, %xmm14
    vpxor %xmm14, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm14, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm14, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm14, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    vaesenc %xmm8, %xmm0, %xmm0
    vaesenc %xmm9, %xmm1, %xmm1
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vpshufb %xmm13, %xmm0, %xmm14
    vpshufb %xmm13, %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesenc %xmm9, %xmm3, %xmm3
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpshufb %xmm13, %xmm2, %xmm14
    vpshufb %xmm13, %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesenc %xmm9, %xmm5, %xmm5
    vaesenc %xmm12, %xmm4, %xmm4
    vaesenc %xmm12, %xmm5, %xmm5
    vpshufb %xmm13, %xmm4, %xmm14
    vpshufb %xmm13, %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesenc %xmm9, %xmm7, %xmm7
    vaesenc %xmm12, %xmm6, %xmm6
    vaesenc %xmm12, %xmm7, %xmm7
    vpshufb %xmm13, %xmm6, %xmm14
    vpshufb %xmm13, %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vpshufb AREION_SYM(vistrutahConsts)(%rip), %xmm10, %xmm10
    vpshufb 16+AREION_SYM(vistrutahConsts)(%rip), %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10, %xmm14
    vpxor %xmm14, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm14, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm14, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm14, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    cmpq $10, %rcx
    je .Lv256_4blk_vex_final
    vaesenc %xmm8, %xmm0, %xmm0
    vaesenc %xmm9, %xmm1, %xmm1
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vpshufb %xmm13, %xmm0, %xmm14
    vpshufb %xmm13, %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesenc %xmm9, %xmm3, %xmm3
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpshufb %xmm13, %xmm2, %xmm14
    vpshufb %xmm13, %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesenc %xmm9, %xmm5, %xmm5
    vaesenc %xmm12, %xmm4, %xmm4
    vaesenc %xmm12, %xmm5, %xmm5
    vpshufb %xmm13, %xmm4, %xmm14
    vpshufb %xmm13, %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesenc %xmm9, %xmm7, %xmm7
    vaesenc %xmm12, %xmm6, %xmm6
    vaesenc %xmm12, %xmm7, %xmm7
    vpshufb %xmm13, %xmm6, %xmm14
    vpshufb %xmm13, %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vpshufb AREION_SYM(vistrutahConsts)(%rip), %xmm10, %xmm10
    vpshufb 16+AREION_SYM(vistrutahConsts)(%rip), %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10, %xmm14
    vpxor %xmm14, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm14, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm14, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm14, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    vaesenc %xmm8, %xmm0, %xmm0
    vaesenc %xmm9, %xmm1, %xmm1
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vpshufb %xmm13, %xmm0, %xmm14
    vpshufb %xmm13, %xmm1, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm0
    vpunpckhqdq %xmm15, %xmm14, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesenc %xmm9, %xmm3, %xmm3
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpshufb %xmm13, %xmm2, %xmm14
    vpshufb %xmm13, %xmm3, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm2
    vpunpckhqdq %xmm15, %xmm14, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesenc %xmm9, %xmm5, %xmm5
    vaesenc %xmm12, %xmm4, %xmm4
    vaesenc %xmm12, %xmm5, %xmm5
    vpshufb %xmm13, %xmm4, %xmm14
    vpshufb %xmm13, %xmm5, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm4
    vpunpckhqdq %xmm15, %xmm14, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesenc %xmm9, %xmm7, %xmm7
    vaesenc %xmm12, %xmm6, %xmm6
    vaesenc %xmm12, %xmm7, %xmm7
    vpshufb %xmm13, %xmm6, %xmm14
    vpshufb %xmm13, %xmm7, %xmm15
    vpunpcklqdq %xmm15, %xmm14, %xmm6
    vpunpckhqdq %xmm15, %xmm14, %xmm7
    vpshufb AREION_SYM(vistrutahConsts)(%rip), %xmm10, %xmm10
    vpshufb 16+AREION_SYM(vistrutahConsts)(%rip), %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10, %xmm14
    vpxor %xmm14, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm14, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm14, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm14, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
.Lv256_4blk_vex_final:
    vaesenc %xmm8, %xmm0, %xmm0
    vaesenc %xmm9, %xmm1, %xmm1
    vaesenc %xmm8, %xmm2, %xmm2
    vaesenc %xmm9, %xmm3, %xmm3
    vaesenc %xmm8, %xmm4, %xmm4
    vaesenc %xmm9, %xmm5, %xmm5
    vaesenc %xmm8, %xmm6, %xmm6
    vaesenc %xmm9, %xmm7, %xmm7
    vpshufb AREION_SYM(vistrutahConsts)(%rip), %xmm10, %xmm10
    vpshufb 16+AREION_SYM(vistrutahConsts)(%rip), %xmm11, %xmm11
    vaesenclast %xmm10, %xmm0, %xmm0
    vaesenclast %xmm11, %xmm1, %xmm1
    vaesenclast %xmm10, %xmm2, %xmm2
    vaesenclast %xmm11, %xmm3, %xmm3
    vaesenclast %xmm10, %xmm4, %xmm4
    vaesenclast %xmm11, %xmm5, %xmm5
    vaesenclast %xmm10, %xmm6, %xmm6
    vaesenclast %xmm11, %xmm7, %xmm7
    vmovdqu %xmm0, (%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah256Encrypt4BlocksVexAsm)

AREION_FUNC_START(vistrutah256Decrypt4BlocksVexAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vmovdqu 64(%rsi), %xmm4
    vmovdqu 80(%rsi), %xmm5
    vmovdqu 96(%rsi), %xmm6
    vmovdqu 112(%rsi), %xmm7
    vmovdqu (%rdx), %xmm8
    vmovdqu 16(%rdx), %xmm9
    vmovdqa %xmm9, %xmm10
    vmovdqa %xmm8, %xmm11
    vaesimc %xmm8, %xmm8
    vaesimc %xmm9, %xmm9
    vpshufb 352+AREION_SYM(vistrutahConsts)(%rip), %xmm10, %xmm10
    vpshufb 368+AREION_SYM(vistrutahConsts)(%rip), %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv256_dec_4blk_vex_init_done
    vmovdqu AREION_SYM(vistrutahConsts)(%rip), %xmm12
    vmovdqu 16+AREION_SYM(vistrutahConsts)(%rip), %xmm13
    vpshufb %xmm12, %xmm10, %xmm10
    vpshufb %xmm13, %xmm11, %xmm11
    vpshufb %xmm12, %xmm10, %xmm10
    vpshufb %xmm13, %xmm11, %xmm11
.Lv256_dec_4blk_vex_init_done:
    vmovdqu 288+AREION_SYM(vistrutahConsts)(%rip), %xmm12
    vmovdqu 304+AREION_SYM(vistrutahConsts)(%rip), %xmm13
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm10, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm10, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    cmpq $10, %rcx
    je .Lv256_dec_4blk_vex_step4
    vpshufb %xmm12, %xmm10, %xmm10
    vpshufb %xmm13, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10, %xmm14
    vaesdec %xmm8, %xmm0, %xmm0
    vaesdec %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm14, %xmm0, %xmm0
    vaesdeclast %xmm11, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm15
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm15, %xmm0
    vaesimc %xmm1, %xmm1
    vaesdec %xmm8, %xmm2, %xmm2
    vaesdec %xmm9, %xmm3, %xmm3
    vaesdeclast %xmm14, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpunpcklbw %xmm3, %xmm2, %xmm15
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm15, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm8, %xmm4, %xmm4
    vaesdec %xmm9, %xmm5, %xmm5
    vaesdeclast %xmm14, %xmm4, %xmm4
    vaesdeclast %xmm11, %xmm5, %xmm5
    vpunpcklbw %xmm5, %xmm4, %xmm15
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm15, %xmm4
    vaesimc %xmm5, %xmm5
    vaesdec %xmm8, %xmm6, %xmm6
    vaesdec %xmm9, %xmm7, %xmm7
    vaesdeclast %xmm14, %xmm6, %xmm6
    vaesdeclast %xmm11, %xmm7, %xmm7
    vpunpcklbw %xmm7, %xmm6, %xmm15
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm15, %xmm6
    vaesimc %xmm7, %xmm7
    vpshufb %xmm12, %xmm10, %xmm10
    vpshufb %xmm13, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10, %xmm14
    vaesdec %xmm8, %xmm0, %xmm0
    vaesdec %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm14, %xmm0, %xmm0
    vaesdeclast %xmm11, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm15
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm15, %xmm0
    vaesimc %xmm1, %xmm1
    vaesdec %xmm8, %xmm2, %xmm2
    vaesdec %xmm9, %xmm3, %xmm3
    vaesdeclast %xmm14, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpunpcklbw %xmm3, %xmm2, %xmm15
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm15, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm8, %xmm4, %xmm4
    vaesdec %xmm9, %xmm5, %xmm5
    vaesdeclast %xmm14, %xmm4, %xmm4
    vaesdeclast %xmm11, %xmm5, %xmm5
    vpunpcklbw %xmm5, %xmm4, %xmm15
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm15, %xmm4
    vaesimc %xmm5, %xmm5
    vaesdec %xmm8, %xmm6, %xmm6
    vaesdec %xmm9, %xmm7, %xmm7
    vaesdeclast %xmm14, %xmm6, %xmm6
    vaesdeclast %xmm11, %xmm7, %xmm7
    vpunpcklbw %xmm7, %xmm6, %xmm15
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm15, %xmm6
    vaesimc %xmm7, %xmm7
.Lv256_dec_4blk_vex_step4:
    vpshufb %xmm12, %xmm10, %xmm10
    vpshufb %xmm13, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10, %xmm14
    vaesdec %xmm8, %xmm0, %xmm0
    vaesdec %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm14, %xmm0, %xmm0
    vaesdeclast %xmm11, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm15
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm15, %xmm0
    vaesimc %xmm1, %xmm1
    vaesdec %xmm8, %xmm2, %xmm2
    vaesdec %xmm9, %xmm3, %xmm3
    vaesdeclast %xmm14, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpunpcklbw %xmm3, %xmm2, %xmm15
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm15, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm8, %xmm4, %xmm4
    vaesdec %xmm9, %xmm5, %xmm5
    vaesdeclast %xmm14, %xmm4, %xmm4
    vaesdeclast %xmm11, %xmm5, %xmm5
    vpunpcklbw %xmm5, %xmm4, %xmm15
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm15, %xmm4
    vaesimc %xmm5, %xmm5
    vaesdec %xmm8, %xmm6, %xmm6
    vaesdec %xmm9, %xmm7, %xmm7
    vaesdeclast %xmm14, %xmm6, %xmm6
    vaesdeclast %xmm11, %xmm7, %xmm7
    vpunpcklbw %xmm7, %xmm6, %xmm15
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm15, %xmm6
    vaesimc %xmm7, %xmm7
    vpshufb %xmm12, %xmm10, %xmm10
    vpshufb %xmm13, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10, %xmm14
    vaesdec %xmm8, %xmm0, %xmm0
    vaesdec %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm14, %xmm0, %xmm0
    vaesdeclast %xmm11, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm15
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm15, %xmm0
    vaesimc %xmm1, %xmm1
    vaesdec %xmm8, %xmm2, %xmm2
    vaesdec %xmm9, %xmm3, %xmm3
    vaesdeclast %xmm14, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpunpcklbw %xmm3, %xmm2, %xmm15
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm15, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm8, %xmm4, %xmm4
    vaesdec %xmm9, %xmm5, %xmm5
    vaesdeclast %xmm14, %xmm4, %xmm4
    vaesdeclast %xmm11, %xmm5, %xmm5
    vpunpcklbw %xmm5, %xmm4, %xmm15
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm15, %xmm4
    vaesimc %xmm5, %xmm5
    vaesdec %xmm8, %xmm6, %xmm6
    vaesdec %xmm9, %xmm7, %xmm7
    vaesdeclast %xmm14, %xmm6, %xmm6
    vaesdeclast %xmm11, %xmm7, %xmm7
    vpunpcklbw %xmm7, %xmm6, %xmm15
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm15, %xmm6
    vaesimc %xmm7, %xmm7
    vpshufb %xmm12, %xmm10, %xmm10
    vpshufb %xmm13, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10, %xmm14
    vaesdec %xmm8, %xmm0, %xmm0
    vaesdec %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm14, %xmm0, %xmm0
    vaesdeclast %xmm11, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm15
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm15, %xmm0
    vaesimc %xmm1, %xmm1
    vaesdec %xmm8, %xmm2, %xmm2
    vaesdec %xmm9, %xmm3, %xmm3
    vaesdeclast %xmm14, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpunpcklbw %xmm3, %xmm2, %xmm15
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm15, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm8, %xmm4, %xmm4
    vaesdec %xmm9, %xmm5, %xmm5
    vaesdeclast %xmm14, %xmm4, %xmm4
    vaesdeclast %xmm11, %xmm5, %xmm5
    vpunpcklbw %xmm5, %xmm4, %xmm15
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm15, %xmm4
    vaesimc %xmm5, %xmm5
    vaesdec %xmm8, %xmm6, %xmm6
    vaesdec %xmm9, %xmm7, %xmm7
    vaesdeclast %xmm14, %xmm6, %xmm6
    vaesdeclast %xmm11, %xmm7, %xmm7
    vpunpcklbw %xmm7, %xmm6, %xmm15
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm15, %xmm6
    vaesimc %xmm7, %xmm7
    vpshufb %xmm12, %xmm10, %xmm10
    vpshufb %xmm13, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm10, %xmm14
    vaesdec %xmm8, %xmm0, %xmm0
    vaesdec %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm14, %xmm0, %xmm0
    vaesdeclast %xmm11, %xmm1, %xmm1
    vpunpcklbw %xmm1, %xmm0, %xmm15
    vpunpckhbw %xmm1, %xmm0, %xmm1
    vaesimc %xmm15, %xmm0
    vaesimc %xmm1, %xmm1
    vaesdec %xmm8, %xmm2, %xmm2
    vaesdec %xmm9, %xmm3, %xmm3
    vaesdeclast %xmm14, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpunpcklbw %xmm3, %xmm2, %xmm15
    vpunpckhbw %xmm3, %xmm2, %xmm3
    vaesimc %xmm15, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm8, %xmm4, %xmm4
    vaesdec %xmm9, %xmm5, %xmm5
    vaesdeclast %xmm14, %xmm4, %xmm4
    vaesdeclast %xmm11, %xmm5, %xmm5
    vpunpcklbw %xmm5, %xmm4, %xmm15
    vpunpckhbw %xmm5, %xmm4, %xmm5
    vaesimc %xmm15, %xmm4
    vaesimc %xmm5, %xmm5
    vaesdec %xmm8, %xmm6, %xmm6
    vaesdec %xmm9, %xmm7, %xmm7
    vaesdeclast %xmm14, %xmm6, %xmm6
    vaesdeclast %xmm11, %xmm7, %xmm7
    vpunpcklbw %xmm7, %xmm6, %xmm15
    vpunpckhbw %xmm7, %xmm6, %xmm7
    vaesimc %xmm15, %xmm6
    vaesimc %xmm7, %xmm7
    vpshufb %xmm12, %xmm10, %xmm10
    vpshufb %xmm13, %xmm11, %xmm11
    vaesdec %xmm8, %xmm0, %xmm0
    vaesdec %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm0, %xmm0
    vaesdeclast %xmm11, %xmm1, %xmm1
    vaesdec %xmm8, %xmm2, %xmm2
    vaesdec %xmm9, %xmm3, %xmm3
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vaesdec %xmm8, %xmm4, %xmm4
    vaesdec %xmm9, %xmm5, %xmm5
    vaesdeclast %xmm10, %xmm4, %xmm4
    vaesdeclast %xmm11, %xmm5, %xmm5
    vaesdec %xmm8, %xmm6, %xmm6
    vaesdec %xmm9, %xmm7, %xmm7
    vaesdeclast %xmm10, %xmm6, %xmm6
    vaesdeclast %xmm11, %xmm7, %xmm7
    vmovdqu %xmm0, (%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah256Decrypt4BlocksVexAsm)

AREION_FUNC_START(vistrutah256Encrypt4BlocksYmmAsm)
#if !defined(_WIN64)
#else
    subq $88, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu (%rsi), %ymm0
    vmovdqu 32(%rsi), %ymm1
    vmovdqu 64(%rsi), %ymm2
    vmovdqu 96(%rsi), %ymm3
    vmovdqu (%rdx), %ymm4
    vperm2i128 $1, %ymm4, %ymm4, %ymm5
    vpxor %xmm6, %xmm6, %xmm6
    vmovdqu AREION_SYM(vistrutahConsts)(%rip), %ymm7
    vmovdqu 64+AREION_SYM(vistrutahConsts)(%rip), %ymm8
    vpxor %ymm5, %ymm0, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vpxor %ymm5, %ymm2, %ymm2
    vpxor %ymm5, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vaesenc %ymm6, %ymm2, %ymm2
    vaesenc %ymm6, %ymm3, %ymm3
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpshufb %ymm8, %ymm2, %ymm2
    vpshufb %ymm8, %ymm3, %ymm3
    vpermq $216, %ymm0, %ymm0
    vpermq $216, %ymm1, %ymm1
    vpermq $216, %ymm2, %ymm2
    vpermq $216, %ymm3, %ymm3
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm5, %ymm9, %ymm9
    vpxor %ymm9, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vpxor %ymm9, %ymm2, %ymm2
    vpxor %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vaesenc %ymm6, %ymm2, %ymm2
    vaesenc %ymm6, %ymm3, %ymm3
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpshufb %ymm8, %ymm2, %ymm2
    vpshufb %ymm8, %ymm3, %ymm3
    vpermq $216, %ymm0, %ymm0
    vpermq $216, %ymm1, %ymm1
    vpermq $216, %ymm2, %ymm2
    vpermq $216, %ymm3, %ymm3
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm5, %ymm9, %ymm9
    vpxor %ymm9, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vpxor %ymm9, %ymm2, %ymm2
    vpxor %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vaesenc %ymm6, %ymm2, %ymm2
    vaesenc %ymm6, %ymm3, %ymm3
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpshufb %ymm8, %ymm2, %ymm2
    vpshufb %ymm8, %ymm3, %ymm3
    vpermq $216, %ymm0, %ymm0
    vpermq $216, %ymm1, %ymm1
    vpermq $216, %ymm2, %ymm2
    vpermq $216, %ymm3, %ymm3
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm5, %ymm9, %ymm9
    vpxor %ymm9, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vpxor %ymm9, %ymm2, %ymm2
    vpxor %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vaesenc %ymm6, %ymm2, %ymm2
    vaesenc %ymm6, %ymm3, %ymm3
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpshufb %ymm8, %ymm2, %ymm2
    vpshufb %ymm8, %ymm3, %ymm3
    vpermq $216, %ymm0, %ymm0
    vpermq $216, %ymm1, %ymm1
    vpermq $216, %ymm2, %ymm2
    vpermq $216, %ymm3, %ymm3
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm5, %ymm9, %ymm9
    vpxor %ymm9, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vpxor %ymm9, %ymm2, %ymm2
    vpxor %ymm9, %ymm3, %ymm3
    cmpq $10, %rcx
    je .Lv256_4blk_ymm_final
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vaesenc %ymm6, %ymm2, %ymm2
    vaesenc %ymm6, %ymm3, %ymm3
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpshufb %ymm8, %ymm2, %ymm2
    vpshufb %ymm8, %ymm3, %ymm3
    vpermq $216, %ymm0, %ymm0
    vpermq $216, %ymm1, %ymm1
    vpermq $216, %ymm2, %ymm2
    vpermq $216, %ymm3, %ymm3
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm5, %ymm9, %ymm9
    vpxor %ymm9, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vpxor %ymm9, %ymm2, %ymm2
    vpxor %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vaesenc %ymm6, %ymm2, %ymm2
    vaesenc %ymm6, %ymm3, %ymm3
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpshufb %ymm8, %ymm2, %ymm2
    vpshufb %ymm8, %ymm3, %ymm3
    vpermq $216, %ymm0, %ymm0
    vpermq $216, %ymm1, %ymm1
    vpermq $216, %ymm2, %ymm2
    vpermq $216, %ymm3, %ymm3
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm5, %ymm9, %ymm9
    vpxor %ymm9, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vpxor %ymm9, %ymm2, %ymm2
    vpxor %ymm9, %ymm3, %ymm3
.Lv256_4blk_ymm_final:
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm4, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm4, %ymm3, %ymm3
    vpshufb %ymm7, %ymm5, %ymm5
    vaesenclast %ymm5, %ymm0, %ymm0
    vaesenclast %ymm5, %ymm1, %ymm1
    vaesenclast %ymm5, %ymm2, %ymm2
    vaesenclast %ymm5, %ymm3, %ymm3
    vmovdqu %ymm0, (%rdi)
    vmovdqu %ymm1, 32(%rdi)
    vmovdqu %ymm2, 64(%rdi)
    vmovdqu %ymm3, 96(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $88, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah256Encrypt4BlocksYmmAsm)

AREION_FUNC_START(vistrutah256Decrypt4BlocksYmmAsm)
#if !defined(_WIN64)
#else
    subq $88, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu (%rsi), %ymm0
    vmovdqu 32(%rsi), %ymm1
    vmovdqu 64(%rsi), %ymm2
    vmovdqu 96(%rsi), %ymm3
    vmovdqu (%rdx), %ymm4
    vperm2i128 $1, %ymm4, %ymm4, %ymm5
    vpxor %xmm6, %xmm6, %xmm6
    vaesenclast %ymm6, %ymm4, %ymm4
    vaesdec %ymm6, %ymm4, %ymm4
    vpshufb 352+AREION_SYM(vistrutahConsts)(%rip), %ymm5, %ymm5
    cmpq $10, %rcx
    je .Lv256_dec_4blk_ymm_init_done
    vmovdqu AREION_SYM(vistrutahConsts)(%rip), %ymm7
    vpshufb %ymm7, %ymm5, %ymm5
    vpshufb %ymm7, %ymm5, %ymm5
.Lv256_dec_4blk_ymm_init_done:
    vmovdqu 288+AREION_SYM(vistrutahConsts)(%rip), %ymm7
    vmovdqu 416+AREION_SYM(vistrutahConsts)(%rip), %ymm8
    vpxor %ymm5, %ymm0, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vpxor %ymm5, %ymm2, %ymm2
    vpxor %ymm5, %ymm3, %ymm3
    cmpq $10, %rcx
    je .Lv256_dec_4blk_ymm_step4
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm5, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm9, %ymm1, %ymm1
    vaesdeclast %ymm9, %ymm2, %ymm2
    vaesdeclast %ymm9, %ymm3, %ymm3
    vpermq $216, %ymm0, %ymm0
    vpermq $216, %ymm1, %ymm1
    vpermq $216, %ymm2, %ymm2
    vpermq $216, %ymm3, %ymm3
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpshufb %ymm8, %ymm2, %ymm2
    vpshufb %ymm8, %ymm3, %ymm3
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesdec %ymm6, %ymm2, %ymm2
    vaesenclast %ymm6, %ymm3, %ymm3
    vaesdec %ymm6, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm5, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm9, %ymm1, %ymm1
    vaesdeclast %ymm9, %ymm2, %ymm2
    vaesdeclast %ymm9, %ymm3, %ymm3
    vpermq $216, %ymm0, %ymm0
    vpermq $216, %ymm1, %ymm1
    vpermq $216, %ymm2, %ymm2
    vpermq $216, %ymm3, %ymm3
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpshufb %ymm8, %ymm2, %ymm2
    vpshufb %ymm8, %ymm3, %ymm3
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesdec %ymm6, %ymm2, %ymm2
    vaesenclast %ymm6, %ymm3, %ymm3
    vaesdec %ymm6, %ymm3, %ymm3
.Lv256_dec_4blk_ymm_step4:
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm5, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm9, %ymm1, %ymm1
    vaesdeclast %ymm9, %ymm2, %ymm2
    vaesdeclast %ymm9, %ymm3, %ymm3
    vpermq $216, %ymm0, %ymm0
    vpermq $216, %ymm1, %ymm1
    vpermq $216, %ymm2, %ymm2
    vpermq $216, %ymm3, %ymm3
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpshufb %ymm8, %ymm2, %ymm2
    vpshufb %ymm8, %ymm3, %ymm3
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesdec %ymm6, %ymm2, %ymm2
    vaesenclast %ymm6, %ymm3, %ymm3
    vaesdec %ymm6, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm5, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm9, %ymm1, %ymm1
    vaesdeclast %ymm9, %ymm2, %ymm2
    vaesdeclast %ymm9, %ymm3, %ymm3
    vpermq $216, %ymm0, %ymm0
    vpermq $216, %ymm1, %ymm1
    vpermq $216, %ymm2, %ymm2
    vpermq $216, %ymm3, %ymm3
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpshufb %ymm8, %ymm2, %ymm2
    vpshufb %ymm8, %ymm3, %ymm3
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesdec %ymm6, %ymm2, %ymm2
    vaesenclast %ymm6, %ymm3, %ymm3
    vaesdec %ymm6, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm5, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm9, %ymm1, %ymm1
    vaesdeclast %ymm9, %ymm2, %ymm2
    vaesdeclast %ymm9, %ymm3, %ymm3
    vpermq $216, %ymm0, %ymm0
    vpermq $216, %ymm1, %ymm1
    vpermq $216, %ymm2, %ymm2
    vpermq $216, %ymm3, %ymm3
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpshufb %ymm8, %ymm2, %ymm2
    vpshufb %ymm8, %ymm3, %ymm3
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesdec %ymm6, %ymm2, %ymm2
    vaesenclast %ymm6, %ymm3, %ymm3
    vaesdec %ymm6, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm5, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm9, %ymm1, %ymm1
    vaesdeclast %ymm9, %ymm2, %ymm2
    vaesdeclast %ymm9, %ymm3, %ymm3
    vpermq $216, %ymm0, %ymm0
    vpermq $216, %ymm1, %ymm1
    vpermq $216, %ymm2, %ymm2
    vpermq $216, %ymm3, %ymm3
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpshufb %ymm8, %ymm2, %ymm2
    vpshufb %ymm8, %ymm3, %ymm3
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesdec %ymm6, %ymm2, %ymm2
    vaesenclast %ymm6, %ymm3, %ymm3
    vaesdec %ymm6, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm4, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm4, %ymm3, %ymm3
    vpshufb %ymm7, %ymm5, %ymm5
    vaesdeclast %ymm5, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vaesdeclast %ymm5, %ymm2, %ymm2
    vaesdeclast %ymm5, %ymm3, %ymm3
    vmovdqu %ymm0, (%rdi)
    vmovdqu %ymm1, 32(%rdi)
    vmovdqu %ymm2, 64(%rdi)
    vmovdqu %ymm3, 96(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $88, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah256Decrypt4BlocksYmmAsm)

AREION_FUNC_START(vistrutah256Encrypt4BlocksZmmAsm)
#if !defined(_WIN64)
#else
    subq $120, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rsi), %xmm0
    vinserti32x4 $1, 32(%rsi), %zmm0, %zmm0
    vinserti32x4 $2, 64(%rsi), %zmm0, %zmm0
    vinserti32x4 $3, 96(%rsi), %zmm0, %zmm0
    vmovdqu 16(%rsi), %xmm1
    vinserti32x4 $1, 48(%rsi), %zmm1, %zmm1
    vinserti32x4 $2, 80(%rsi), %zmm1, %zmm1
    vinserti32x4 $3, 112(%rsi), %zmm1, %zmm1
    vbroadcasti32x4 (%rdx), %zmm2
    vbroadcasti32x4 16(%rdx), %zmm3
    vmovdqu64 %zmm3, %zmm4
    vmovdqu64 %zmm2, %zmm5
    vbroadcasti32x4 AREION_SYM(vistrutahConsts)(%rip), %zmm6
    vbroadcasti32x4 16+AREION_SYM(vistrutahConsts)(%rip), %zmm7
    vbroadcasti32x4 64+AREION_SYM(vistrutahConsts)(%rip), %zmm8
    vpxord %xmm9, %xmm9, %xmm9
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenc %zmm3, %zmm1, %zmm1
    vaesenc %zmm9, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vpshufb %zmm8, %zmm0, %zmm10
    vpshufb %zmm8, %zmm1, %zmm11
    vpunpcklqdq %zmm11, %zmm10, %zmm0
    vpunpckhqdq %zmm11, %zmm10, %zmm1
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    vbroadcasti32x4 AREION_SYM(vistrutahRoundConstants)(%rip), %zmm10
    vpxorq %zmm4, %zmm10, %zmm10
    vpxorq %zmm10, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenc %zmm3, %zmm1, %zmm1
    vaesenc %zmm9, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vpshufb %zmm8, %zmm0, %zmm10
    vpshufb %zmm8, %zmm1, %zmm11
    vpunpcklqdq %zmm11, %zmm10, %zmm0
    vpunpckhqdq %zmm11, %zmm10, %zmm1
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    vbroadcasti32x4 16+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm10
    vpxorq %zmm4, %zmm10, %zmm10
    vpxorq %zmm10, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenc %zmm3, %zmm1, %zmm1
    vaesenc %zmm9, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vpshufb %zmm8, %zmm0, %zmm10
    vpshufb %zmm8, %zmm1, %zmm11
    vpunpcklqdq %zmm11, %zmm10, %zmm0
    vpunpckhqdq %zmm11, %zmm10, %zmm1
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    vbroadcasti32x4 32+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm10
    vpxorq %zmm4, %zmm10, %zmm10
    vpxorq %zmm10, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenc %zmm3, %zmm1, %zmm1
    vaesenc %zmm9, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vpshufb %zmm8, %zmm0, %zmm10
    vpshufb %zmm8, %zmm1, %zmm11
    vpunpcklqdq %zmm11, %zmm10, %zmm0
    vpunpckhqdq %zmm11, %zmm10, %zmm1
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    vbroadcasti32x4 48+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm10
    vpxorq %zmm4, %zmm10, %zmm10
    vpxorq %zmm10, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    cmpq $10, %rcx
    je .Lv256_4blk_zmm_final
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenc %zmm3, %zmm1, %zmm1
    vaesenc %zmm9, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vpshufb %zmm8, %zmm0, %zmm10
    vpshufb %zmm8, %zmm1, %zmm11
    vpunpcklqdq %zmm11, %zmm10, %zmm0
    vpunpckhqdq %zmm11, %zmm10, %zmm1
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    vbroadcasti32x4 64+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm10
    vpxorq %zmm4, %zmm10, %zmm10
    vpxorq %zmm10, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenc %zmm3, %zmm1, %zmm1
    vaesenc %zmm9, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vpshufb %zmm8, %zmm0, %zmm10
    vpshufb %zmm8, %zmm1, %zmm11
    vpunpcklqdq %zmm11, %zmm10, %zmm0
    vpunpckhqdq %zmm11, %zmm10, %zmm1
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    vbroadcasti32x4 80+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm10
    vpxorq %zmm4, %zmm10, %zmm10
    vpxorq %zmm10, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
.Lv256_4blk_zmm_final:
    vaesenc %zmm2, %zmm0, %zmm0
    vaesenc %zmm3, %zmm1, %zmm1
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    vaesenclast %zmm4, %zmm0, %zmm0
    vaesenclast %zmm5, %zmm1, %zmm1
    vmovdqu %xmm0, (%rdi)
    vextracti32x4 $1, %zmm0, 32(%rdi)
    vextracti32x4 $2, %zmm0, 64(%rdi)
    vextracti32x4 $3, %zmm0, 96(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vextracti32x4 $1, %zmm1, 48(%rdi)
    vextracti32x4 $2, %zmm1, 80(%rdi)
    vextracti32x4 $3, %zmm1, 112(%rdi)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    vpxord %xmm6, %xmm6, %xmm6
    vpxord %xmm7, %xmm7, %xmm7
    vpxord %xmm8, %xmm8, %xmm8
    vpxord %xmm9, %xmm9, %xmm9
    vpxord %xmm10, %xmm10, %xmm10
    vpxord %xmm11, %xmm11, %xmm11
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $120, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah256Encrypt4BlocksZmmAsm)

AREION_FUNC_START(vistrutah256Decrypt4BlocksZmmAsm)
#if !defined(_WIN64)
#else
    subq $88, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu (%rsi), %xmm0
    vinserti32x4 $1, 32(%rsi), %zmm0, %zmm0
    vinserti32x4 $2, 64(%rsi), %zmm0, %zmm0
    vinserti32x4 $3, 96(%rsi), %zmm0, %zmm0
    vmovdqu 16(%rsi), %xmm1
    vinserti32x4 $1, 48(%rsi), %zmm1, %zmm1
    vinserti32x4 $2, 80(%rsi), %zmm1, %zmm1
    vinserti32x4 $3, 112(%rsi), %zmm1, %zmm1
    vbroadcasti32x4 (%rdx), %zmm2
    vbroadcasti32x4 16(%rdx), %zmm3
    vmovdqu64 %zmm3, %zmm4
    vmovdqu64 %zmm2, %zmm5
    vpxord %xmm8, %xmm8, %xmm8
    vaesenclast %zmm8, %zmm2, %zmm2
    vaesdec %zmm8, %zmm2, %zmm2
    vaesenclast %zmm8, %zmm3, %zmm3
    vaesdec %zmm8, %zmm3, %zmm3
    vbroadcasti32x4 352+AREION_SYM(vistrutahConsts)(%rip), %zmm6
    vbroadcasti32x4 368+AREION_SYM(vistrutahConsts)(%rip), %zmm7
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    cmpq $10, %rcx
    je .Lv256_dec_4blk_zmm_init_done
    vbroadcasti32x4 AREION_SYM(vistrutahConsts)(%rip), %zmm6
    vbroadcasti32x4 16+AREION_SYM(vistrutahConsts)(%rip), %zmm7
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
.Lv256_dec_4blk_zmm_init_done:
    vbroadcasti32x4 288+AREION_SYM(vistrutahConsts)(%rip), %zmm6
    vbroadcasti32x4 304+AREION_SYM(vistrutahConsts)(%rip), %zmm7
    vpxorq %zmm4, %zmm0, %zmm0
    vpxorq %zmm5, %zmm1, %zmm1
    cmpq $10, %rcx
    je .Lv256_dec_4blk_zmm_step4
    vaesdec %zmm2, %zmm0, %zmm0
    vaesdec %zmm3, %zmm1, %zmm1
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    vbroadcasti32x4 80+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm9
    vpxorq %zmm4, %zmm9, %zmm9
    vaesdeclast %zmm9, %zmm0, %zmm0
    vaesdeclast %zmm5, %zmm1, %zmm1
    vpunpcklbw %zmm1, %zmm0, %zmm9
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm8, %zmm9, %zmm0
    vaesdec %zmm8, %zmm0, %zmm0
    vaesenclast %zmm8, %zmm1, %zmm1
    vaesdec %zmm8, %zmm1, %zmm1
    vaesdec %zmm2, %zmm0, %zmm0
    vaesdec %zmm3, %zmm1, %zmm1
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    vbroadcasti32x4 64+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm9
    vpxorq %zmm4, %zmm9, %zmm9
    vaesdeclast %zmm9, %zmm0, %zmm0
    vaesdeclast %zmm5, %zmm1, %zmm1
    vpunpcklbw %zmm1, %zmm0, %zmm9
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm8, %zmm9, %zmm0
    vaesdec %zmm8, %zmm0, %zmm0
    vaesenclast %zmm8, %zmm1, %zmm1
    vaesdec %zmm8, %zmm1, %zmm1
.Lv256_dec_4blk_zmm_step4:
    vaesdec %zmm2, %zmm0, %zmm0
    vaesdec %zmm3, %zmm1, %zmm1
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    vbroadcasti32x4 48+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm9
    vpxorq %zmm4, %zmm9, %zmm9
    vaesdeclast %zmm9, %zmm0, %zmm0
    vaesdeclast %zmm5, %zmm1, %zmm1
    vpunpcklbw %zmm1, %zmm0, %zmm9
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm8, %zmm9, %zmm0
    vaesdec %zmm8, %zmm0, %zmm0
    vaesenclast %zmm8, %zmm1, %zmm1
    vaesdec %zmm8, %zmm1, %zmm1
    vaesdec %zmm2, %zmm0, %zmm0
    vaesdec %zmm3, %zmm1, %zmm1
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    vbroadcasti32x4 32+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm9
    vpxorq %zmm4, %zmm9, %zmm9
    vaesdeclast %zmm9, %zmm0, %zmm0
    vaesdeclast %zmm5, %zmm1, %zmm1
    vpunpcklbw %zmm1, %zmm0, %zmm9
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm8, %zmm9, %zmm0
    vaesdec %zmm8, %zmm0, %zmm0
    vaesenclast %zmm8, %zmm1, %zmm1
    vaesdec %zmm8, %zmm1, %zmm1
    vaesdec %zmm2, %zmm0, %zmm0
    vaesdec %zmm3, %zmm1, %zmm1
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    vbroadcasti32x4 16+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm9
    vpxorq %zmm4, %zmm9, %zmm9
    vaesdeclast %zmm9, %zmm0, %zmm0
    vaesdeclast %zmm5, %zmm1, %zmm1
    vpunpcklbw %zmm1, %zmm0, %zmm9
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm8, %zmm9, %zmm0
    vaesdec %zmm8, %zmm0, %zmm0
    vaesenclast %zmm8, %zmm1, %zmm1
    vaesdec %zmm8, %zmm1, %zmm1
    vaesdec %zmm2, %zmm0, %zmm0
    vaesdec %zmm3, %zmm1, %zmm1
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    vbroadcasti32x4 AREION_SYM(vistrutahRoundConstants)(%rip), %zmm9
    vpxorq %zmm4, %zmm9, %zmm9
    vaesdeclast %zmm9, %zmm0, %zmm0
    vaesdeclast %zmm5, %zmm1, %zmm1
    vpunpcklbw %zmm1, %zmm0, %zmm9
    vpunpckhbw %zmm1, %zmm0, %zmm1
    vaesenclast %zmm8, %zmm9, %zmm0
    vaesdec %zmm8, %zmm0, %zmm0
    vaesenclast %zmm8, %zmm1, %zmm1
    vaesdec %zmm8, %zmm1, %zmm1
    vaesdec %zmm2, %zmm0, %zmm0
    vaesdec %zmm3, %zmm1, %zmm1
    vpshufb %zmm6, %zmm4, %zmm4
    vpshufb %zmm7, %zmm5, %zmm5
    vaesdeclast %zmm4, %zmm0, %zmm0
    vaesdeclast %zmm5, %zmm1, %zmm1
    vmovdqu %xmm0, (%rdi)
    vextracti32x4 $1, %zmm0, 32(%rdi)
    vextracti32x4 $2, %zmm0, 64(%rdi)
    vextracti32x4 $3, %zmm0, 96(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vextracti32x4 $1, %zmm1, 48(%rdi)
    vextracti32x4 $2, %zmm1, 80(%rdi)
    vextracti32x4 $3, %zmm1, 112(%rdi)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    vpxord %xmm6, %xmm6, %xmm6
    vpxord %xmm7, %xmm7, %xmm7
    vpxord %xmm8, %xmm8, %xmm8
    vpxord %xmm9, %xmm9, %xmm9
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $88, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah256Decrypt4BlocksZmmAsm)

AREION_FUNC_START(vistrutah512EncryptBlock256Asm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
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
    movdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu (%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    movdqu (%rdx), %xmm4
    movdqu 16(%rdx), %xmm5
    movdqu 192+AREION_SYM(vistrutahConsts)(%rip), %xmm13
    movdqu 224+AREION_SYM(vistrutahConsts)(%rip), %xmm14
    movdqa %xmm4, %xmm6
    pshufb %xmm13, %xmm6
    movdqa %xmm5, %xmm15
    pshufb %xmm14, %xmm15
    pxor %xmm15, %xmm6
    movdqa %xmm5, %xmm7
    pshufb %xmm13, %xmm7
    movdqa %xmm4, %xmm15
    pshufb %xmm14, %xmm15
    pxor %xmm15, %xmm7
    movdqa %xmm5, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm7, %xmm10
    movdqa %xmm6, %xmm11
    pxor %xmm12, %xmm12
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_blk256_aesni_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $12, %rcx
    je .Lv512_blk256_aesni_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $14, %rcx
    je .Lv512_blk256_aesni_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
.Lv512_blk256_aesni_final:
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    aesenclast %xmm8, %xmm0
    aesenclast %xmm9, %xmm1
    aesenclast %xmm10, %xmm2
    aesenclast %xmm11, %xmm3
    movdqu %xmm0, (%rdi)
    movdqu %xmm1, 16(%rdi)
    movdqu %xmm2, 32(%rdi)
    movdqu %xmm3, 48(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah512EncryptBlock256Asm)

AREION_FUNC_START(vistrutah512DecryptBlock256Asm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
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
    movdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu (%rdx), %xmm4
    movdqu 16(%rdx), %xmm5
    movdqu 192+AREION_SYM(vistrutahConsts)(%rip), %xmm13
    movdqu 224+AREION_SYM(vistrutahConsts)(%rip), %xmm14
    movdqa %xmm4, %xmm6
    pshufb %xmm13, %xmm6
    movdqa %xmm5, %xmm15
    pshufb %xmm14, %xmm15
    pxor %xmm15, %xmm6
    movdqa %xmm5, %xmm7
    pshufb %xmm13, %xmm7
    movdqa %xmm4, %xmm15
    pshufb %xmm14, %xmm15
    pxor %xmm15, %xmm7
    movdqa %xmm5, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm7, %xmm10
    movdqa %xmm6, %xmm11
    aesimc %xmm4, %xmm4
    aesimc %xmm5, %xmm5
    aesimc %xmm6, %xmm6
    aesimc %xmm7, %xmm7
    movdqu 576+AREION_SYM(vistrutahConsts)(%rip), %xmm12
    movdqu (%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    palignr $9, %xmm8, %xmm8
    palignr $2, %xmm9, %xmm9
    palignr $9, %xmm10, %xmm10
    palignr $2, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_blk256_aesni_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_blk256_aesni_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_blk256_aesni_init_done
    palignr $10, %xmm8, %xmm8
    palignr $4, %xmm9, %xmm9
    palignr $10, %xmm10, %xmm10
    palignr $4, %xmm11, %xmm11
.Lv512_dec_blk256_aesni_init_done:
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_blk256_aesni_step4
    cmpq $12, %rcx
    je .Lv512_dec_blk256_aesni_step5
    cmpq $14, %rcx
    je .Lv512_dec_blk256_aesni_step6
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_blk256_aesni_step6:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_blk256_aesni_step5:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_blk256_aesni_step4:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    aesdeclast %xmm8, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqu %xmm0, (%rdi)
    movdqu %xmm1, 16(%rdi)
    movdqu %xmm2, 32(%rdi)
    movdqu %xmm3, 48(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah512DecryptBlock256Asm)

AREION_FUNC_START(vistrutah512EncryptBlock256VexAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vmovdqu (%rdx), %xmm4
    vmovdqu 16(%rdx), %xmm5
    vmovdqu 192+AREION_SYM(vistrutahConsts)(%rip), %xmm13
    vmovdqu 224+AREION_SYM(vistrutahConsts)(%rip), %xmm14
    vpshufb %xmm13, %xmm4, %xmm6
    vpshufb %xmm14, %xmm5, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vpshufb %xmm13, %xmm5, %xmm7
    vpshufb %xmm14, %xmm4, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vmovdqa %xmm5, %xmm8
    vmovdqa %xmm4, %xmm9
    vmovdqa %xmm7, %xmm10
    vmovdqa %xmm6, %xmm11
    vpxor %xmm12, %xmm12, %xmm12
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_blk256_vex_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $12, %rcx
    je .Lv512_blk256_vex_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $14, %rcx
    je .Lv512_blk256_vex_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
.Lv512_blk256_vex_final:
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vaesenclast %xmm8, %xmm0, %xmm0
    vaesenclast %xmm9, %xmm1, %xmm1
    vaesenclast %xmm10, %xmm2, %xmm2
    vaesenclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, (%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vmovdqu %xmm3, 48(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah512EncryptBlock256VexAsm)

AREION_FUNC_START(vistrutah512DecryptBlock256VexAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rdx), %xmm4
    vmovdqu 16(%rdx), %xmm5
    vmovdqu 192+AREION_SYM(vistrutahConsts)(%rip), %xmm13
    vmovdqu 224+AREION_SYM(vistrutahConsts)(%rip), %xmm14
    vpshufb %xmm13, %xmm4, %xmm6
    vpshufb %xmm14, %xmm5, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vpshufb %xmm13, %xmm5, %xmm7
    vpshufb %xmm14, %xmm4, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vmovdqa %xmm5, %xmm8
    vmovdqa %xmm4, %xmm9
    vmovdqa %xmm7, %xmm10
    vmovdqa %xmm6, %xmm11
    vaesimc %xmm4, %xmm4
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %xmm12
    vmovdqu (%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vpalignr $9, %xmm8, %xmm8, %xmm8
    vpalignr $2, %xmm9, %xmm9, %xmm9
    vpalignr $9, %xmm10, %xmm10, %xmm10
    vpalignr $2, %xmm11, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_blk256_vex_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_blk256_vex_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_blk256_vex_init_done
    vpalignr $10, %xmm8, %xmm8, %xmm8
    vpalignr $4, %xmm9, %xmm9, %xmm9
    vpalignr $10, %xmm10, %xmm10, %xmm10
    vpalignr $4, %xmm11, %xmm11, %xmm11
.Lv512_dec_blk256_vex_init_done:
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_blk256_vex_step4
    cmpq $12, %rcx
    je .Lv512_dec_blk256_vex_step5
    cmpq $14, %rcx
    je .Lv512_dec_blk256_vex_step6
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_blk256_vex_step6:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_blk256_vex_step5:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_blk256_vex_step4:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, (%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vmovdqu %xmm3, 48(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah512DecryptBlock256VexAsm)

AREION_FUNC_START(vistrutah512EncryptBlock256YmmAsm)
#if !defined(_WIN64)
#else
    subq $88, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu (%rsi), %ymm0
    vmovdqu 32(%rsi), %ymm1
    vmovdqu (%rdx), %ymm2
    vperm2i128 $1, %ymm2, %ymm2, %ymm4
    vpshufb 192+AREION_SYM(vistrutahConsts)(%rip), %ymm2, %ymm3
    vpshufb 224+AREION_SYM(vistrutahConsts)(%rip), %ymm4, %ymm8
    vpxor %ymm8, %ymm3, %ymm3
    vperm2i128 $1, %ymm3, %ymm3, %ymm5
    vpxor %xmm6, %xmm6, %xmm6
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm7
    vpxor %ymm4, %ymm0, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    cmpq $10, %rcx
    je .Lv512_blk256_ymm_final
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    cmpq $12, %rcx
    je .Lv512_blk256_ymm_final
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    cmpq $14, %rcx
    je .Lv512_blk256_ymm_final
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
.Lv512_blk256_ymm_final:
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesenclast %ymm5, %ymm1, %ymm1
    vmovdqu %ymm0, (%rdi)
    vmovdqu %ymm1, 32(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $88, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512EncryptBlock256YmmAsm)

AREION_FUNC_START(vistrutah512DecryptBlock256YmmAsm)
#if !defined(_WIN64)
#else
    subq $88, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu (%rsi), %ymm0
    vmovdqu 32(%rsi), %ymm1
    vmovdqu (%rdx), %ymm2
    vperm2i128 $1, %ymm2, %ymm2, %ymm4
    vpshufb 192+AREION_SYM(vistrutahConsts)(%rip), %ymm2, %ymm3
    vpshufb 224+AREION_SYM(vistrutahConsts)(%rip), %ymm4, %ymm8
    vpxor %ymm8, %ymm3, %ymm3
    vperm2i128 $1, %ymm3, %ymm3, %ymm5
    vpxor %xmm6, %xmm6, %xmm6
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesdec %ymm6, %ymm2, %ymm2
    vaesenclast %ymm6, %ymm3, %ymm3
    vaesdec %ymm6, %ymm3, %ymm3
    vmovdqu 512+AREION_SYM(vistrutahConsts)(%rip), %ymm7
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    cmpq $10, %rcx
    je .Lv512_dec_blk256_ymm_init_done
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm7
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    cmpq $12, %rcx
    je .Lv512_dec_blk256_ymm_init_done
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    cmpq $14, %rcx
    je .Lv512_dec_blk256_ymm_init_done
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
.Lv512_dec_blk256_ymm_init_done:
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm8
    vpxor %ymm4, %ymm0, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    cmpq $10, %rcx
    je .Lv512_dec_blk256_ymm_step4
    cmpq $12, %rcx
    je .Lv512_dec_blk256_ymm_step5
    cmpq $14, %rcx
    je .Lv512_dec_blk256_ymm_step6
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
.Lv512_dec_blk256_ymm_step6:
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
.Lv512_dec_blk256_ymm_step5:
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
.Lv512_dec_blk256_ymm_step4:
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vmovdqu %ymm0, (%rdi)
    vmovdqu %ymm1, 32(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $88, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512DecryptBlock256YmmAsm)

AREION_FUNC_START(vistrutah512EncryptBlock256ZmmAsm)
#if !defined(_WIN64)
#else
    subq $56, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu64 (%rsi), %zmm0
    vmovdqu (%rdx), %ymm1
    vperm2i128 $1, %ymm1, %ymm1, %ymm5
    vpshufb 192+AREION_SYM(vistrutahConsts)(%rip), %ymm1, %ymm6
    vpshufb 224+AREION_SYM(vistrutahConsts)(%rip), %ymm5, %ymm7
    vpxor %ymm7, %ymm6, %ymm6
    vshufi32x4 $68, %zmm6, %zmm1, %zmm1
    vshufi32x4 $177, %zmm1, %zmm1, %zmm2
    vpxord %xmm3, %xmm3, %xmm3
    vmovdqu64 128+AREION_SYM(vistrutahConsts)(%rip), %zmm4
    vpxorq %zmm2, %zmm0, %zmm0
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
    cmpq $10, %rcx
    je .Lv512_blk256_zmm_final
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
    cmpq $12, %rcx
    je .Lv512_blk256_zmm_final
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
    cmpq $14, %rcx
    je .Lv512_blk256_zmm_final
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
.Lv512_blk256_zmm_final:
    vaesenc %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vaesenclast %zmm2, %zmm0, %zmm0
    vmovdqu64 %zmm0, (%rdi)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    vpxord %xmm6, %xmm6, %xmm6
    vpxord %xmm7, %xmm7, %xmm7
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
#if defined(_WIN64)
    vmovdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm7
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $56, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512EncryptBlock256ZmmAsm)

AREION_FUNC_START(vistrutah512DecryptBlock256ZmmAsm)
#if !defined(_WIN64)
#else
    subq $56, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu64 (%rsi), %zmm0
    vmovdqu (%rdx), %ymm1
    vperm2i128 $1, %ymm1, %ymm1, %ymm5
    vpshufb 192+AREION_SYM(vistrutahConsts)(%rip), %ymm1, %ymm6
    vpshufb 224+AREION_SYM(vistrutahConsts)(%rip), %ymm5, %ymm7
    vpxor %ymm7, %ymm6, %ymm6
    vshufi32x4 $68, %zmm6, %zmm1, %zmm1
    vshufi32x4 $177, %zmm1, %zmm1, %zmm2
    vpxord %xmm3, %xmm3, %xmm3
    vaesenclast %zmm3, %zmm1, %zmm1
    vaesdec %zmm3, %zmm1, %zmm1
    vmovdqu64 512+AREION_SYM(vistrutahConsts)(%rip), %zmm4
    vpshufb %zmm4, %zmm2, %zmm2
    cmpq $10, %rcx
    je .Lv512_dec_blk256_zmm_init_done
    vmovdqu64 128+AREION_SYM(vistrutahConsts)(%rip), %zmm4
    vpshufb %zmm4, %zmm2, %zmm2
    cmpq $12, %rcx
    je .Lv512_dec_blk256_zmm_init_done
    vpshufb %zmm4, %zmm2, %zmm2
    cmpq $14, %rcx
    je .Lv512_dec_blk256_zmm_init_done
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm2, %zmm2
.Lv512_dec_blk256_zmm_init_done:
    vmovdqu64 448+AREION_SYM(vistrutahConsts)(%rip), %zmm4
    vmovdqu64 576+AREION_SYM(vistrutahConsts)(%rip), %zmm5
    vpxorq %zmm2, %zmm0, %zmm0
    cmpq $10, %rcx
    je .Lv512_dec_blk256_zmm_step4
    cmpq $12, %rcx
    je .Lv512_dec_blk256_zmm_step5
    cmpq $14, %rcx
    je .Lv512_dec_blk256_zmm_step6
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
.Lv512_dec_blk256_zmm_step6:
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
.Lv512_dec_blk256_zmm_step5:
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
.Lv512_dec_blk256_zmm_step4:
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vaesdeclast %zmm2, %zmm0, %zmm0
    vmovdqu64 %zmm0, (%rdi)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    vpxord %xmm6, %xmm6, %xmm6
    vpxord %xmm7, %xmm7, %xmm7
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
#if defined(_WIN64)
    vmovdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm7
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $56, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512DecryptBlock256ZmmAsm)

AREION_FUNC_START(vistrutah512EncryptBlock512Asm)
#if !defined(_WIN64)
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
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu (%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    movdqu (%rdx), %xmm4
    movdqu 16(%rdx), %xmm5
    movdqu 32(%rdx), %xmm6
    movdqu 48(%rdx), %xmm7
    movdqa %xmm5, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm7, %xmm10
    movdqa %xmm6, %xmm11
    pxor %xmm12, %xmm12
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_blk512_aesni_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $12, %rcx
    je .Lv512_blk512_aesni_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $14, %rcx
    je .Lv512_blk512_aesni_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
.Lv512_blk512_aesni_final:
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    aesenclast %xmm8, %xmm0
    aesenclast %xmm9, %xmm1
    aesenclast %xmm10, %xmm2
    aesenclast %xmm11, %xmm3
    movdqu %xmm0, (%rdi)
    movdqu %xmm1, 16(%rdi)
    movdqu %xmm2, 32(%rdi)
    movdqu %xmm3, 48(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
AREION_FUNC_END(vistrutah512EncryptBlock512Asm)

AREION_FUNC_START(vistrutah512DecryptBlock512Asm)
#if !defined(_WIN64)
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
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu (%rdx), %xmm4
    movdqu 16(%rdx), %xmm5
    movdqu 32(%rdx), %xmm6
    movdqu 48(%rdx), %xmm7
    movdqa %xmm5, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm7, %xmm10
    movdqa %xmm6, %xmm11
    aesimc %xmm4, %xmm4
    aesimc %xmm5, %xmm5
    aesimc %xmm6, %xmm6
    aesimc %xmm7, %xmm7
    movdqu 576+AREION_SYM(vistrutahConsts)(%rip), %xmm12
    movdqu (%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    palignr $9, %xmm8, %xmm8
    palignr $2, %xmm9, %xmm9
    palignr $9, %xmm10, %xmm10
    palignr $2, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_blk512_aesni_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_blk512_aesni_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_blk512_aesni_init_done
    palignr $10, %xmm8, %xmm8
    palignr $4, %xmm9, %xmm9
    palignr $10, %xmm10, %xmm10
    palignr $4, %xmm11, %xmm11
.Lv512_dec_blk512_aesni_init_done:
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_blk512_aesni_step4
    cmpq $12, %rcx
    je .Lv512_dec_blk512_aesni_step5
    cmpq $14, %rcx
    je .Lv512_dec_blk512_aesni_step6
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_blk512_aesni_step6:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_blk512_aesni_step5:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_blk512_aesni_step4:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    aesdeclast %xmm8, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqu %xmm0, (%rdi)
    movdqu %xmm1, 16(%rdi)
    movdqu %xmm2, 32(%rdi)
    movdqu %xmm3, 48(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
AREION_FUNC_END(vistrutah512DecryptBlock512Asm)

AREION_FUNC_START(vistrutah512EncryptBlock512VexAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vmovdqu (%rdx), %xmm4
    vmovdqu 16(%rdx), %xmm5
    vmovdqu 32(%rdx), %xmm6
    vmovdqu 48(%rdx), %xmm7
    vmovdqa %xmm5, %xmm8
    vmovdqa %xmm4, %xmm9
    vmovdqa %xmm7, %xmm10
    vmovdqa %xmm6, %xmm11
    vpxor %xmm12, %xmm12, %xmm12
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_blk512_vex_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $12, %rcx
    je .Lv512_blk512_vex_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $14, %rcx
    je .Lv512_blk512_vex_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
.Lv512_blk512_vex_final:
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vaesenclast %xmm8, %xmm0, %xmm0
    vaesenclast %xmm9, %xmm1, %xmm1
    vaesenclast %xmm10, %xmm2, %xmm2
    vaesenclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, (%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vmovdqu %xmm3, 48(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah512EncryptBlock512VexAsm)

AREION_FUNC_START(vistrutah512DecryptBlock512VexAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rdx), %xmm4
    vmovdqu 16(%rdx), %xmm5
    vmovdqu 32(%rdx), %xmm6
    vmovdqu 48(%rdx), %xmm7
    vmovdqa %xmm5, %xmm8
    vmovdqa %xmm4, %xmm9
    vmovdqa %xmm7, %xmm10
    vmovdqa %xmm6, %xmm11
    vaesimc %xmm4, %xmm4
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %xmm12
    vmovdqu (%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vpalignr $9, %xmm8, %xmm8, %xmm8
    vpalignr $2, %xmm9, %xmm9, %xmm9
    vpalignr $9, %xmm10, %xmm10, %xmm10
    vpalignr $2, %xmm11, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_blk512_vex_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_blk512_vex_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_blk512_vex_init_done
    vpalignr $10, %xmm8, %xmm8, %xmm8
    vpalignr $4, %xmm9, %xmm9, %xmm9
    vpalignr $10, %xmm10, %xmm10, %xmm10
    vpalignr $4, %xmm11, %xmm11, %xmm11
.Lv512_dec_blk512_vex_init_done:
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_blk512_vex_step4
    cmpq $12, %rcx
    je .Lv512_dec_blk512_vex_step5
    cmpq $14, %rcx
    je .Lv512_dec_blk512_vex_step6
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_blk512_vex_step6:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_blk512_vex_step5:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_blk512_vex_step4:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, (%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vmovdqu %xmm3, 48(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah512DecryptBlock512VexAsm)

AREION_FUNC_START(vistrutah512EncryptBlock512YmmAsm)
#if !defined(_WIN64)
#else
    subq $88, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu (%rsi), %ymm0
    vmovdqu 32(%rsi), %ymm1
    vmovdqu (%rdx), %ymm2
    vperm2i128 $1, %ymm2, %ymm2, %ymm4
    vmovdqu 32(%rdx), %ymm3
    vperm2i128 $1, %ymm3, %ymm3, %ymm5
    vpxor %xmm6, %xmm6, %xmm6
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm7
    vpxor %ymm4, %ymm0, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    cmpq $10, %rcx
    je .Lv512_blk512_ymm_final
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    cmpq $12, %rcx
    je .Lv512_blk512_ymm_final
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    cmpq $14, %rcx
    je .Lv512_blk512_ymm_final
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vaesenc %ymm6, %ymm0, %ymm0
    vaesenc %ymm6, %ymm1, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm9
    vperm2i128 $32, %ymm9, %ymm8, %ymm0
    vperm2i128 $49, %ymm9, %ymm8, %ymm1
    vpunpcklbw %ymm1, %ymm0, %ymm8
    vpunpckhbw %ymm1, %ymm0, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vpxor %ymm9, %ymm8, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
.Lv512_blk512_ymm_final:
    vaesenc %ymm2, %ymm0, %ymm0
    vaesenc %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesenclast %ymm5, %ymm1, %ymm1
    vmovdqu %ymm0, (%rdi)
    vmovdqu %ymm1, 32(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $88, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512EncryptBlock512YmmAsm)

AREION_FUNC_START(vistrutah512DecryptBlock512YmmAsm)
#if !defined(_WIN64)
#else
    subq $88, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    vmovdqu %xmm8, 48(%rsp)
    vmovdqu %xmm9, 64(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu (%rsi), %ymm0
    vmovdqu 32(%rsi), %ymm1
    vmovdqu (%rdx), %ymm2
    vperm2i128 $1, %ymm2, %ymm2, %ymm4
    vmovdqu 32(%rdx), %ymm3
    vperm2i128 $1, %ymm3, %ymm3, %ymm5
    vpxor %xmm6, %xmm6, %xmm6
    vaesenclast %ymm6, %ymm2, %ymm2
    vaesdec %ymm6, %ymm2, %ymm2
    vaesenclast %ymm6, %ymm3, %ymm3
    vaesdec %ymm6, %ymm3, %ymm3
    vmovdqu 512+AREION_SYM(vistrutahConsts)(%rip), %ymm7
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    cmpq $10, %rcx
    je .Lv512_dec_blk512_ymm_init_done
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm7
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    cmpq $12, %rcx
    je .Lv512_dec_blk512_ymm_init_done
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    cmpq $14, %rcx
    je .Lv512_dec_blk512_ymm_init_done
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
.Lv512_dec_blk512_ymm_init_done:
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm8
    vpxor %ymm4, %ymm0, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    cmpq $10, %rcx
    je .Lv512_dec_blk512_ymm_step4
    cmpq $12, %rcx
    je .Lv512_dec_blk512_ymm_step5
    cmpq $14, %rcx
    je .Lv512_dec_blk512_ymm_step6
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
.Lv512_dec_blk512_ymm_step6:
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
.Lv512_dec_blk512_ymm_step5:
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
.Lv512_dec_blk512_ymm_step4:
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vmovdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm9
    vpxor %ymm4, %ymm9, %ymm9
    vaesdeclast %ymm9, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vpshufb %ymm8, %ymm0, %ymm0
    vpshufb %ymm8, %ymm1, %ymm1
    vpunpckldq %ymm1, %ymm0, %ymm9
    vpunpckhdq %ymm1, %ymm0, %ymm1
    vpermq $216, %ymm9, %ymm0
    vpermq $216, %ymm1, %ymm1
    vaesenclast %ymm6, %ymm0, %ymm0
    vaesdec %ymm6, %ymm0, %ymm0
    vaesenclast %ymm6, %ymm1, %ymm1
    vaesdec %ymm6, %ymm1, %ymm1
    vaesdec %ymm2, %ymm0, %ymm0
    vaesdec %ymm3, %ymm1, %ymm1
    vpshufb %ymm7, %ymm4, %ymm4
    vpshufb %ymm7, %ymm5, %ymm5
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vmovdqu %ymm0, (%rdi)
    vmovdqu %ymm1, 32(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $88, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512DecryptBlock512YmmAsm)

AREION_FUNC_START(vistrutah512EncryptBlock512ZmmAsm)
#if !defined(_WIN64)
#else
    subq $56, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu64 (%rsi), %zmm0
    vmovdqu64 (%rdx), %zmm1
    vshufi32x4 $177, %zmm1, %zmm1, %zmm2
    vpxord %xmm3, %xmm3, %xmm3
    vmovdqu64 128+AREION_SYM(vistrutahConsts)(%rip), %zmm4
    vpxorq %zmm2, %zmm0, %zmm0
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
    cmpq $10, %rcx
    je .Lv512_blk512_zmm_final
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
    cmpq $12, %rcx
    je .Lv512_blk512_zmm_final
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
    cmpq $14, %rcx
    je .Lv512_blk512_zmm_final
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
    vaesenc %zmm1, %zmm0, %zmm0
    vaesenc %zmm3, %zmm0, %zmm0
    vpermq $216, %zmm0, %zmm5
    vshufi32x4 $78, %zmm5, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm5, %zmm7
    vpunpckhbw %zmm6, %zmm5, %zmm6
    vpunpcklbw %zmm6, %zmm7, %zmm5
    vpunpckhbw %zmm6, %zmm7, %zmm6
    vshufi32x4 $68, %zmm6, %zmm5, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm5
    vpxorq %zmm2, %zmm5, %zmm5
    vpxorq %zmm5, %zmm0, %zmm0
.Lv512_blk512_zmm_final:
    vaesenc %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vaesenclast %zmm2, %zmm0, %zmm0
    vmovdqu64 %zmm0, (%rdi)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    vpxord %xmm6, %xmm6, %xmm6
    vpxord %xmm7, %xmm7, %xmm7
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
#if defined(_WIN64)
    vmovdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm7
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $56, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512EncryptBlock512ZmmAsm)

AREION_FUNC_START(vistrutah512DecryptBlock512ZmmAsm)
#if !defined(_WIN64)
#else
    subq $56, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
    vmovdqu %xmm6, 16(%rsp)
    vmovdqu %xmm7, 32(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    vmovdqu64 (%rsi), %zmm0
    vmovdqu64 (%rdx), %zmm1
    vshufi32x4 $177, %zmm1, %zmm1, %zmm2
    vpxord %xmm3, %xmm3, %xmm3
    vaesenclast %zmm3, %zmm1, %zmm1
    vaesdec %zmm3, %zmm1, %zmm1
    vmovdqu64 512+AREION_SYM(vistrutahConsts)(%rip), %zmm4
    vpshufb %zmm4, %zmm2, %zmm2
    cmpq $10, %rcx
    je .Lv512_dec_blk512_zmm_init_done
    vmovdqu64 128+AREION_SYM(vistrutahConsts)(%rip), %zmm4
    vpshufb %zmm4, %zmm2, %zmm2
    cmpq $12, %rcx
    je .Lv512_dec_blk512_zmm_init_done
    vpshufb %zmm4, %zmm2, %zmm2
    cmpq $14, %rcx
    je .Lv512_dec_blk512_zmm_init_done
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm2, %zmm2
.Lv512_dec_blk512_zmm_init_done:
    vmovdqu64 448+AREION_SYM(vistrutahConsts)(%rip), %zmm4
    vmovdqu64 576+AREION_SYM(vistrutahConsts)(%rip), %zmm5
    vpxorq %zmm2, %zmm0, %zmm0
    cmpq $10, %rcx
    je .Lv512_dec_blk512_zmm_step4
    cmpq $12, %rcx
    je .Lv512_dec_blk512_zmm_step5
    cmpq $14, %rcx
    je .Lv512_dec_blk512_zmm_step6
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
.Lv512_dec_blk512_zmm_step6:
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
.Lv512_dec_blk512_zmm_step5:
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
.Lv512_dec_blk512_zmm_step4:
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vmovdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm6
    vpxorq %zmm2, %zmm6, %zmm6
    vaesdeclast %zmm6, %zmm0, %zmm0
    vpshufb %zmm5, %zmm0, %zmm0
    vshufi32x4 $78, %zmm0, %zmm0, %zmm6
    vpunpckldq %zmm6, %zmm0, %zmm7
    vpunpckhdq %zmm6, %zmm0, %zmm6
    vshufi32x4 $68, %zmm6, %zmm7, %zmm0
    vpermq $216, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesdec %zmm3, %zmm0, %zmm0
    vaesdec %zmm1, %zmm0, %zmm0
    vpshufb %zmm4, %zmm2, %zmm2
    vaesdeclast %zmm2, %zmm0, %zmm0
    vmovdqu64 %zmm0, (%rdi)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    vpxord %xmm6, %xmm6, %xmm6
    vpxord %xmm7, %xmm7, %xmm7
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
#if defined(_WIN64)
    vmovdqu 16(%rsp), %xmm6
    movq $0, 16(%rsp)
    movq $0, 24(%rsp)
    vmovdqu 32(%rsp), %xmm7
    movq $0, 32(%rsp)
    movq $0, 40(%rsp)
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $56, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512DecryptBlock512ZmmAsm)

AREION_FUNC_START(vistrutah512Encrypt4Blocks256AesNiAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
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
    movdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu (%rdx), %xmm4
    movdqu 16(%rdx), %xmm5
    movdqu 192+AREION_SYM(vistrutahConsts)(%rip), %xmm13
    movdqu 224+AREION_SYM(vistrutahConsts)(%rip), %xmm14
    movdqa %xmm4, %xmm6
    pshufb %xmm13, %xmm6
    movdqa %xmm5, %xmm15
    pshufb %xmm14, %xmm15
    pxor %xmm15, %xmm6
    movdqa %xmm5, %xmm7
    pshufb %xmm13, %xmm7
    movdqa %xmm4, %xmm15
    pshufb %xmm14, %xmm15
    pxor %xmm15, %xmm7
    pxor %xmm12, %xmm12
    movdqu (%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    movdqa %xmm5, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm7, %xmm10
    movdqa %xmm6, %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk256_aesni_b0_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk256_aesni_b0_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk256_aesni_b0_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
.Lv512_4blk256_aesni_b0_final:
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    aesenclast %xmm8, %xmm0
    aesenclast %xmm9, %xmm1
    aesenclast %xmm10, %xmm2
    aesenclast %xmm11, %xmm3
    movdqu %xmm0, (%rdi)
    movdqu %xmm1, 16(%rdi)
    movdqu %xmm2, 32(%rdi)
    movdqu %xmm3, 48(%rdi)
    movdqu 64(%rsi), %xmm0
    movdqu 80(%rsi), %xmm1
    movdqu 96(%rsi), %xmm2
    movdqu 112(%rsi), %xmm3
    movdqa %xmm5, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm7, %xmm10
    movdqa %xmm6, %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk256_aesni_b1_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk256_aesni_b1_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk256_aesni_b1_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
.Lv512_4blk256_aesni_b1_final:
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    aesenclast %xmm8, %xmm0
    aesenclast %xmm9, %xmm1
    aesenclast %xmm10, %xmm2
    aesenclast %xmm11, %xmm3
    movdqu %xmm0, 64(%rdi)
    movdqu %xmm1, 80(%rdi)
    movdqu %xmm2, 96(%rdi)
    movdqu %xmm3, 112(%rdi)
    movdqu 128(%rsi), %xmm0
    movdqu 144(%rsi), %xmm1
    movdqu 160(%rsi), %xmm2
    movdqu 176(%rsi), %xmm3
    movdqa %xmm5, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm7, %xmm10
    movdqa %xmm6, %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk256_aesni_b2_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk256_aesni_b2_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk256_aesni_b2_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
.Lv512_4blk256_aesni_b2_final:
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    aesenclast %xmm8, %xmm0
    aesenclast %xmm9, %xmm1
    aesenclast %xmm10, %xmm2
    aesenclast %xmm11, %xmm3
    movdqu %xmm0, 128(%rdi)
    movdqu %xmm1, 144(%rdi)
    movdqu %xmm2, 160(%rdi)
    movdqu %xmm3, 176(%rdi)
    movdqu 192(%rsi), %xmm0
    movdqu 208(%rsi), %xmm1
    movdqu 224(%rsi), %xmm2
    movdqu 240(%rsi), %xmm3
    movdqa %xmm5, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm7, %xmm10
    movdqa %xmm6, %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk256_aesni_b3_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk256_aesni_b3_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk256_aesni_b3_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
.Lv512_4blk256_aesni_b3_final:
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    aesenclast %xmm8, %xmm0
    aesenclast %xmm9, %xmm1
    aesenclast %xmm10, %xmm2
    aesenclast %xmm11, %xmm3
    movdqu %xmm0, 192(%rdi)
    movdqu %xmm1, 208(%rdi)
    movdqu %xmm2, 224(%rdi)
    movdqu %xmm3, 240(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah512Encrypt4Blocks256AesNiAsm)

AREION_FUNC_START(vistrutah512Decrypt4Blocks256AesNiAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
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
    movdqu %xmm15, 160(%rsp)
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu (%rdx), %xmm4
    movdqu 16(%rdx), %xmm5
    movdqu 192+AREION_SYM(vistrutahConsts)(%rip), %xmm13
    movdqu 224+AREION_SYM(vistrutahConsts)(%rip), %xmm14
    movdqa %xmm4, %xmm6
    pshufb %xmm13, %xmm6
    movdqa %xmm5, %xmm15
    pshufb %xmm14, %xmm15
    pxor %xmm15, %xmm6
    movdqa %xmm5, %xmm7
    pshufb %xmm13, %xmm7
    movdqa %xmm4, %xmm15
    pshufb %xmm14, %xmm15
    pxor %xmm15, %xmm7
    movdqa %xmm5, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm7, %xmm10
    movdqa %xmm6, %xmm11
    aesimc %xmm4, %xmm4
    aesimc %xmm5, %xmm5
    aesimc %xmm6, %xmm6
    aesimc %xmm7, %xmm7
    movdqu 576+AREION_SYM(vistrutahConsts)(%rip), %xmm12
    movdqu (%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    palignr $9, %xmm8, %xmm8
    palignr $2, %xmm9, %xmm9
    palignr $9, %xmm10, %xmm10
    palignr $2, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_aesni_b0_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_aesni_b0_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_aesni_b0_init_done
    palignr $10, %xmm8, %xmm8
    palignr $4, %xmm9, %xmm9
    palignr $10, %xmm10, %xmm10
    palignr $4, %xmm11, %xmm11
.Lv512_dec_4blk256_aesni_b0_init_done:
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_aesni_b0_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_aesni_b0_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_aesni_b0_step6
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk256_aesni_b0_step6:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk256_aesni_b0_step5:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk256_aesni_b0_step4:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    aesdeclast %xmm8, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqu %xmm0, (%rdi)
    movdqu %xmm1, 16(%rdi)
    movdqu %xmm2, 32(%rdi)
    movdqu %xmm3, 48(%rdi)
    movdqu 64(%rsi), %xmm0
    movdqu 80(%rsi), %xmm1
    movdqu 96(%rsi), %xmm2
    movdqu 112(%rsi), %xmm3
    palignr $9, %xmm8, %xmm8
    palignr $2, %xmm9, %xmm9
    palignr $9, %xmm10, %xmm10
    palignr $2, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_aesni_b1_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_aesni_b1_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_aesni_b1_init_done
    palignr $10, %xmm8, %xmm8
    palignr $4, %xmm9, %xmm9
    palignr $10, %xmm10, %xmm10
    palignr $4, %xmm11, %xmm11
.Lv512_dec_4blk256_aesni_b1_init_done:
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_aesni_b1_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_aesni_b1_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_aesni_b1_step6
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk256_aesni_b1_step6:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk256_aesni_b1_step5:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk256_aesni_b1_step4:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    aesdeclast %xmm8, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqu %xmm0, 64(%rdi)
    movdqu %xmm1, 80(%rdi)
    movdqu %xmm2, 96(%rdi)
    movdqu %xmm3, 112(%rdi)
    movdqu 128(%rsi), %xmm0
    movdqu 144(%rsi), %xmm1
    movdqu 160(%rsi), %xmm2
    movdqu 176(%rsi), %xmm3
    palignr $9, %xmm8, %xmm8
    palignr $2, %xmm9, %xmm9
    palignr $9, %xmm10, %xmm10
    palignr $2, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_aesni_b2_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_aesni_b2_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_aesni_b2_init_done
    palignr $10, %xmm8, %xmm8
    palignr $4, %xmm9, %xmm9
    palignr $10, %xmm10, %xmm10
    palignr $4, %xmm11, %xmm11
.Lv512_dec_4blk256_aesni_b2_init_done:
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_aesni_b2_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_aesni_b2_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_aesni_b2_step6
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk256_aesni_b2_step6:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk256_aesni_b2_step5:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk256_aesni_b2_step4:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    aesdeclast %xmm8, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqu %xmm0, 128(%rdi)
    movdqu %xmm1, 144(%rdi)
    movdqu %xmm2, 160(%rdi)
    movdqu %xmm3, 176(%rdi)
    movdqu 192(%rsi), %xmm0
    movdqu 208(%rsi), %xmm1
    movdqu 224(%rsi), %xmm2
    movdqu 240(%rsi), %xmm3
    palignr $9, %xmm8, %xmm8
    palignr $2, %xmm9, %xmm9
    palignr $9, %xmm10, %xmm10
    palignr $2, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_aesni_b3_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_aesni_b3_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_aesni_b3_init_done
    palignr $10, %xmm8, %xmm8
    palignr $4, %xmm9, %xmm9
    palignr $10, %xmm10, %xmm10
    palignr $4, %xmm11, %xmm11
.Lv512_dec_4blk256_aesni_b3_init_done:
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_aesni_b3_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_aesni_b3_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_aesni_b3_step6
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk256_aesni_b3_step6:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk256_aesni_b3_step5:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk256_aesni_b3_step4:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    aesdeclast %xmm8, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqu %xmm0, 192(%rdi)
    movdqu %xmm1, 208(%rdi)
    movdqu %xmm2, 224(%rdi)
    movdqu %xmm3, 240(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah512Decrypt4Blocks256AesNiAsm)

AREION_FUNC_START(vistrutah512Encrypt4Blocks256VexAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rdx), %xmm4
    vmovdqu 16(%rdx), %xmm5
    vmovdqu 192+AREION_SYM(vistrutahConsts)(%rip), %xmm13
    vmovdqu 224+AREION_SYM(vistrutahConsts)(%rip), %xmm14
    vpshufb %xmm13, %xmm4, %xmm6
    vpshufb %xmm14, %xmm5, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vpshufb %xmm13, %xmm5, %xmm7
    vpshufb %xmm14, %xmm4, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vpxor %xmm12, %xmm12, %xmm12
    vmovdqu (%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vmovdqa %xmm5, %xmm8
    vmovdqa %xmm4, %xmm9
    vmovdqa %xmm7, %xmm10
    vmovdqa %xmm6, %xmm11
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk256_vex_b0_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk256_vex_b0_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk256_vex_b0_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
.Lv512_4blk256_vex_b0_final:
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vaesenclast %xmm8, %xmm0, %xmm0
    vaesenclast %xmm9, %xmm1, %xmm1
    vaesenclast %xmm10, %xmm2, %xmm2
    vaesenclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, (%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vmovdqu 64(%rsi), %xmm0
    vmovdqu 80(%rsi), %xmm1
    vmovdqu 96(%rsi), %xmm2
    vmovdqu 112(%rsi), %xmm3
    vmovdqa %xmm5, %xmm8
    vmovdqa %xmm4, %xmm9
    vmovdqa %xmm7, %xmm10
    vmovdqa %xmm6, %xmm11
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk256_vex_b1_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk256_vex_b1_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk256_vex_b1_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
.Lv512_4blk256_vex_b1_final:
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vaesenclast %xmm8, %xmm0, %xmm0
    vaesenclast %xmm9, %xmm1, %xmm1
    vaesenclast %xmm10, %xmm2, %xmm2
    vaesenclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, 64(%rdi)
    vmovdqu %xmm1, 80(%rdi)
    vmovdqu %xmm2, 96(%rdi)
    vmovdqu %xmm3, 112(%rdi)
    vmovdqu 128(%rsi), %xmm0
    vmovdqu 144(%rsi), %xmm1
    vmovdqu 160(%rsi), %xmm2
    vmovdqu 176(%rsi), %xmm3
    vmovdqa %xmm5, %xmm8
    vmovdqa %xmm4, %xmm9
    vmovdqa %xmm7, %xmm10
    vmovdqa %xmm6, %xmm11
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk256_vex_b2_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk256_vex_b2_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk256_vex_b2_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
.Lv512_4blk256_vex_b2_final:
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vaesenclast %xmm8, %xmm0, %xmm0
    vaesenclast %xmm9, %xmm1, %xmm1
    vaesenclast %xmm10, %xmm2, %xmm2
    vaesenclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, 128(%rdi)
    vmovdqu %xmm1, 144(%rdi)
    vmovdqu %xmm2, 160(%rdi)
    vmovdqu %xmm3, 176(%rdi)
    vmovdqu 192(%rsi), %xmm0
    vmovdqu 208(%rsi), %xmm1
    vmovdqu 224(%rsi), %xmm2
    vmovdqu 240(%rsi), %xmm3
    vmovdqa %xmm5, %xmm8
    vmovdqa %xmm4, %xmm9
    vmovdqa %xmm7, %xmm10
    vmovdqa %xmm6, %xmm11
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk256_vex_b3_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk256_vex_b3_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk256_vex_b3_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
.Lv512_4blk256_vex_b3_final:
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vaesenclast %xmm8, %xmm0, %xmm0
    vaesenclast %xmm9, %xmm1, %xmm1
    vaesenclast %xmm10, %xmm2, %xmm2
    vaesenclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, 192(%rdi)
    vmovdqu %xmm1, 208(%rdi)
    vmovdqu %xmm2, 224(%rdi)
    vmovdqu %xmm3, 240(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah512Encrypt4Blocks256VexAsm)

AREION_FUNC_START(vistrutah512Decrypt4Blocks256VexAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rdx), %xmm4
    vmovdqu 16(%rdx), %xmm5
    vmovdqu 192+AREION_SYM(vistrutahConsts)(%rip), %xmm13
    vmovdqu 224+AREION_SYM(vistrutahConsts)(%rip), %xmm14
    vpshufb %xmm13, %xmm4, %xmm6
    vpshufb %xmm14, %xmm5, %xmm15
    vpxor %xmm15, %xmm6, %xmm6
    vpshufb %xmm13, %xmm5, %xmm7
    vpshufb %xmm14, %xmm4, %xmm15
    vpxor %xmm15, %xmm7, %xmm7
    vmovdqa %xmm5, %xmm8
    vmovdqa %xmm4, %xmm9
    vmovdqa %xmm7, %xmm10
    vmovdqa %xmm6, %xmm11
    vaesimc %xmm4, %xmm4
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %xmm12
    vmovdqu (%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vpalignr $9, %xmm8, %xmm8, %xmm8
    vpalignr $2, %xmm9, %xmm9, %xmm9
    vpalignr $9, %xmm10, %xmm10, %xmm10
    vpalignr $2, %xmm11, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_vex_b0_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_vex_b0_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_vex_b0_init_done
    vpalignr $10, %xmm8, %xmm8, %xmm8
    vpalignr $4, %xmm9, %xmm9, %xmm9
    vpalignr $10, %xmm10, %xmm10, %xmm10
    vpalignr $4, %xmm11, %xmm11, %xmm11
.Lv512_dec_4blk256_vex_b0_init_done:
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_vex_b0_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_vex_b0_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_vex_b0_step6
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk256_vex_b0_step6:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk256_vex_b0_step5:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk256_vex_b0_step4:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, (%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vmovdqu 64(%rsi), %xmm0
    vmovdqu 80(%rsi), %xmm1
    vmovdqu 96(%rsi), %xmm2
    vmovdqu 112(%rsi), %xmm3
    vpalignr $9, %xmm8, %xmm8, %xmm8
    vpalignr $2, %xmm9, %xmm9, %xmm9
    vpalignr $9, %xmm10, %xmm10, %xmm10
    vpalignr $2, %xmm11, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_vex_b1_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_vex_b1_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_vex_b1_init_done
    vpalignr $10, %xmm8, %xmm8, %xmm8
    vpalignr $4, %xmm9, %xmm9, %xmm9
    vpalignr $10, %xmm10, %xmm10, %xmm10
    vpalignr $4, %xmm11, %xmm11, %xmm11
.Lv512_dec_4blk256_vex_b1_init_done:
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_vex_b1_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_vex_b1_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_vex_b1_step6
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk256_vex_b1_step6:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk256_vex_b1_step5:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk256_vex_b1_step4:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, 64(%rdi)
    vmovdqu %xmm1, 80(%rdi)
    vmovdqu %xmm2, 96(%rdi)
    vmovdqu %xmm3, 112(%rdi)
    vmovdqu 128(%rsi), %xmm0
    vmovdqu 144(%rsi), %xmm1
    vmovdqu 160(%rsi), %xmm2
    vmovdqu 176(%rsi), %xmm3
    vpalignr $9, %xmm8, %xmm8, %xmm8
    vpalignr $2, %xmm9, %xmm9, %xmm9
    vpalignr $9, %xmm10, %xmm10, %xmm10
    vpalignr $2, %xmm11, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_vex_b2_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_vex_b2_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_vex_b2_init_done
    vpalignr $10, %xmm8, %xmm8, %xmm8
    vpalignr $4, %xmm9, %xmm9, %xmm9
    vpalignr $10, %xmm10, %xmm10, %xmm10
    vpalignr $4, %xmm11, %xmm11, %xmm11
.Lv512_dec_4blk256_vex_b2_init_done:
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_vex_b2_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_vex_b2_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_vex_b2_step6
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk256_vex_b2_step6:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk256_vex_b2_step5:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk256_vex_b2_step4:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, 128(%rdi)
    vmovdqu %xmm1, 144(%rdi)
    vmovdqu %xmm2, 160(%rdi)
    vmovdqu %xmm3, 176(%rdi)
    vmovdqu 192(%rsi), %xmm0
    vmovdqu 208(%rsi), %xmm1
    vmovdqu 224(%rsi), %xmm2
    vmovdqu 240(%rsi), %xmm3
    vpalignr $9, %xmm8, %xmm8, %xmm8
    vpalignr $2, %xmm9, %xmm9, %xmm9
    vpalignr $9, %xmm10, %xmm10, %xmm10
    vpalignr $2, %xmm11, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_vex_b3_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_vex_b3_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_vex_b3_init_done
    vpalignr $10, %xmm8, %xmm8, %xmm8
    vpalignr $4, %xmm9, %xmm9, %xmm9
    vpalignr $10, %xmm10, %xmm10, %xmm10
    vpalignr $4, %xmm11, %xmm11, %xmm11
.Lv512_dec_4blk256_vex_b3_init_done:
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_vex_b3_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_vex_b3_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_vex_b3_step6
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk256_vex_b3_step6:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk256_vex_b3_step5:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk256_vex_b3_step4:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, 192(%rdi)
    vmovdqu %xmm1, 208(%rdi)
    vmovdqu %xmm2, 224(%rdi)
    vmovdqu %xmm3, 240(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah512Decrypt4Blocks256VexAsm)

AREION_FUNC_START(vistrutah512Encrypt4Blocks256YmmAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rsi), %xmm0
    vinserti128 $1, 64(%rsi), %ymm0, %ymm0
    vmovdqu 16(%rsi), %xmm1
    vinserti128 $1, 80(%rsi), %ymm1, %ymm1
    vmovdqu 32(%rsi), %xmm2
    vinserti128 $1, 96(%rsi), %ymm2, %ymm2
    vmovdqu 48(%rsi), %xmm3
    vinserti128 $1, 112(%rsi), %ymm3, %ymm3
    vmovdqu 128(%rsi), %xmm4
    vinserti128 $1, 192(%rsi), %ymm4, %ymm4
    vmovdqu 144(%rsi), %xmm5
    vinserti128 $1, 208(%rsi), %ymm5, %ymm5
    vmovdqu 160(%rsi), %xmm6
    vinserti128 $1, 224(%rsi), %ymm6, %ymm6
    vmovdqu 176(%rsi), %xmm7
    vinserti128 $1, 240(%rsi), %ymm7, %ymm7
    vmovdqu (%rdx), %ymm8
    vperm2i128 $1, %ymm8, %ymm8, %ymm10
    vpshufb 192+AREION_SYM(vistrutahConsts)(%rip), %ymm8, %ymm9
    vpshufb 224+AREION_SYM(vistrutahConsts)(%rip), %ymm10, %ymm13
    vpxor %ymm13, %ymm9, %ymm9
    vperm2i128 $1, %ymm9, %ymm9, %ymm11
    vpxor %xmm12, %xmm12, %xmm12
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 16+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 32+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 48+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    cmpq $10, %rcx
    je .Lv512_4blk256_ymm_final
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 64+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    cmpq $12, %rcx
    je .Lv512_4blk256_ymm_final
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 80+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    cmpq $14, %rcx
    je .Lv512_4blk256_ymm_final
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 96+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 112+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
.Lv512_4blk256_ymm_final:
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesenclast %ymm13, %ymm0, %ymm0
    vaesenclast %ymm13, %ymm4, %ymm4
    vaesenclast %ymm14, %ymm1, %ymm1
    vaesenclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesenclast %ymm13, %ymm2, %ymm2
    vaesenclast %ymm13, %ymm6, %ymm6
    vaesenclast %ymm14, %ymm3, %ymm3
    vaesenclast %ymm14, %ymm7, %ymm7
    vmovdqu %xmm0, (%rdi)
    vextracti128 $1, %ymm0, 64(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vextracti128 $1, %ymm1, 80(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vextracti128 $1, %ymm2, 96(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vextracti128 $1, %ymm3, 112(%rdi)
    vmovdqu %xmm4, 128(%rdi)
    vextracti128 $1, %ymm4, 192(%rdi)
    vmovdqu %xmm5, 144(%rdi)
    vextracti128 $1, %ymm5, 208(%rdi)
    vmovdqu %xmm6, 160(%rdi)
    vextracti128 $1, %ymm6, 224(%rdi)
    vmovdqu %xmm7, 176(%rdi)
    vextracti128 $1, %ymm7, 240(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512Encrypt4Blocks256YmmAsm)

AREION_FUNC_START(vistrutah512Decrypt4Blocks256YmmAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rsi), %xmm0
    vinserti128 $1, 64(%rsi), %ymm0, %ymm0
    vmovdqu 16(%rsi), %xmm1
    vinserti128 $1, 80(%rsi), %ymm1, %ymm1
    vmovdqu 32(%rsi), %xmm2
    vinserti128 $1, 96(%rsi), %ymm2, %ymm2
    vmovdqu 48(%rsi), %xmm3
    vinserti128 $1, 112(%rsi), %ymm3, %ymm3
    vmovdqu 128(%rsi), %xmm4
    vinserti128 $1, 192(%rsi), %ymm4, %ymm4
    vmovdqu 144(%rsi), %xmm5
    vinserti128 $1, 208(%rsi), %ymm5, %ymm5
    vmovdqu 160(%rsi), %xmm6
    vinserti128 $1, 224(%rsi), %ymm6, %ymm6
    vmovdqu 176(%rsi), %xmm7
    vinserti128 $1, 240(%rsi), %ymm7, %ymm7
    vmovdqu (%rdx), %ymm8
    vperm2i128 $1, %ymm8, %ymm8, %ymm10
    vpshufb 192+AREION_SYM(vistrutahConsts)(%rip), %ymm8, %ymm9
    vpshufb 224+AREION_SYM(vistrutahConsts)(%rip), %ymm10, %ymm13
    vpxor %ymm13, %ymm9, %ymm9
    vperm2i128 $1, %ymm9, %ymm9, %ymm11
    vpxor %xmm12, %xmm12, %xmm12
    vaesenclast %ymm12, %ymm8, %ymm8
    vaesdec %ymm12, %ymm8, %ymm8
    vaesenclast %ymm12, %ymm9, %ymm9
    vaesdec %ymm12, %ymm9, %ymm9
    vmovdqu 512+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_ymm_init_done
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_ymm_init_done
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_ymm_init_done
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
.Lv512_dec_4blk256_ymm_init_done:
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_ymm_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_ymm_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_ymm_step6
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 112+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 96+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
.Lv512_dec_4blk256_ymm_step6:
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 80+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
.Lv512_dec_4blk256_ymm_step5:
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 64+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
.Lv512_dec_4blk256_ymm_step4:
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 48+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 32+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 16+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu %xmm0, (%rdi)
    vextracti128 $1, %ymm0, 64(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vextracti128 $1, %ymm1, 80(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vextracti128 $1, %ymm2, 96(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vextracti128 $1, %ymm3, 112(%rdi)
    vmovdqu %xmm4, 128(%rdi)
    vextracti128 $1, %ymm4, 192(%rdi)
    vmovdqu %xmm5, 144(%rdi)
    vextracti128 $1, %ymm5, 208(%rdi)
    vmovdqu %xmm6, 160(%rdi)
    vextracti128 $1, %ymm6, 224(%rdi)
    vmovdqu %xmm7, 176(%rdi)
    vextracti128 $1, %ymm7, 240(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512Decrypt4Blocks256YmmAsm)

AREION_FUNC_START(vistrutah512Encrypt4Blocks256ZmmAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rsi), %xmm0
    vinserti32x4 $1, 64(%rsi), %zmm0, %zmm0
    vinserti32x4 $2, 128(%rsi), %zmm0, %zmm0
    vinserti32x4 $3, 192(%rsi), %zmm0, %zmm0
    vmovdqu 16(%rsi), %xmm1
    vinserti32x4 $1, 80(%rsi), %zmm1, %zmm1
    vinserti32x4 $2, 144(%rsi), %zmm1, %zmm1
    vinserti32x4 $3, 208(%rsi), %zmm1, %zmm1
    vmovdqu 32(%rsi), %xmm2
    vinserti32x4 $1, 96(%rsi), %zmm2, %zmm2
    vinserti32x4 $2, 160(%rsi), %zmm2, %zmm2
    vinserti32x4 $3, 224(%rsi), %zmm2, %zmm2
    vmovdqu 48(%rsi), %xmm3
    vinserti32x4 $1, 112(%rsi), %zmm3, %zmm3
    vinserti32x4 $2, 176(%rsi), %zmm3, %zmm3
    vinserti32x4 $3, 240(%rsi), %zmm3, %zmm3
    vmovdqu (%rdx), %ymm4
    vperm2i128 $1, %ymm4, %ymm4, %ymm12
    vpshufb 192+AREION_SYM(vistrutahConsts)(%rip), %ymm4, %ymm13
    vpshufb 224+AREION_SYM(vistrutahConsts)(%rip), %ymm12, %ymm14
    vpxor %ymm14, %ymm13, %ymm13
    vshufi32x4 $68, %zmm13, %zmm4, %zmm4
    vshufi32x4 $0, %zmm4, %zmm4, %zmm8
    vshufi32x4 $85, %zmm4, %zmm4, %zmm9
    vshufi32x4 $170, %zmm4, %zmm4, %zmm10
    vshufi32x4 $255, %zmm4, %zmm4, %zmm11
    vshufi32x4 $177, %zmm4, %zmm4, %zmm5
    vmovdqu64 128+AREION_SYM(vistrutahConsts)(%rip), %zmm6
    vpxord %xmm7, %xmm7, %xmm7
    vpxorq %zmm9, %zmm0, %zmm0
    vpxorq %zmm8, %zmm1, %zmm1
    vpxorq %zmm11, %zmm2, %zmm2
    vpxorq %zmm10, %zmm3, %zmm3
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 16+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 32+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 48+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
    cmpq $10, %rcx
    je .Lv512_4blk256_zmm_final
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 64+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
    cmpq $12, %rcx
    je .Lv512_4blk256_zmm_final
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 80+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
    cmpq $14, %rcx
    je .Lv512_4blk256_zmm_final
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 96+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 112+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
.Lv512_4blk256_zmm_final:
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesenclast %zmm12, %zmm0, %zmm0
    vaesenclast %zmm13, %zmm1, %zmm1
    vaesenclast %zmm14, %zmm2, %zmm2
    vaesenclast %zmm15, %zmm3, %zmm3
    vmovdqu %xmm0, (%rdi)
    vextracti32x4 $1, %zmm0, 64(%rdi)
    vextracti32x4 $2, %zmm0, 128(%rdi)
    vextracti32x4 $3, %zmm0, 192(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vextracti32x4 $1, %zmm1, 80(%rdi)
    vextracti32x4 $2, %zmm1, 144(%rdi)
    vextracti32x4 $3, %zmm1, 208(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vextracti32x4 $1, %zmm2, 96(%rdi)
    vextracti32x4 $2, %zmm2, 160(%rdi)
    vextracti32x4 $3, %zmm2, 224(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vextracti32x4 $1, %zmm3, 112(%rdi)
    vextracti32x4 $2, %zmm3, 176(%rdi)
    vextracti32x4 $3, %zmm3, 240(%rdi)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    vpxord %xmm6, %xmm6, %xmm6
    vpxord %xmm7, %xmm7, %xmm7
    vpxord %xmm8, %xmm8, %xmm8
    vpxord %xmm9, %xmm9, %xmm9
    vpxord %xmm10, %xmm10, %xmm10
    vpxord %xmm11, %xmm11, %xmm11
    vpxord %xmm12, %xmm12, %xmm12
    vpxord %xmm13, %xmm13, %xmm13
    vpxord %xmm14, %xmm14, %xmm14
    vpxord %xmm15, %xmm15, %xmm15
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512Encrypt4Blocks256ZmmAsm)

AREION_FUNC_START(vistrutah512Decrypt4Blocks256ZmmAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rsi), %xmm0
    vinserti32x4 $1, 64(%rsi), %zmm0, %zmm0
    vinserti32x4 $2, 128(%rsi), %zmm0, %zmm0
    vinserti32x4 $3, 192(%rsi), %zmm0, %zmm0
    vmovdqu 16(%rsi), %xmm1
    vinserti32x4 $1, 80(%rsi), %zmm1, %zmm1
    vinserti32x4 $2, 144(%rsi), %zmm1, %zmm1
    vinserti32x4 $3, 208(%rsi), %zmm1, %zmm1
    vmovdqu 32(%rsi), %xmm2
    vinserti32x4 $1, 96(%rsi), %zmm2, %zmm2
    vinserti32x4 $2, 160(%rsi), %zmm2, %zmm2
    vinserti32x4 $3, 224(%rsi), %zmm2, %zmm2
    vmovdqu 48(%rsi), %xmm3
    vinserti32x4 $1, 112(%rsi), %zmm3, %zmm3
    vinserti32x4 $2, 176(%rsi), %zmm3, %zmm3
    vinserti32x4 $3, 240(%rsi), %zmm3, %zmm3
    vmovdqu (%rdx), %ymm4
    vperm2i128 $1, %ymm4, %ymm4, %ymm12
    vpshufb 192+AREION_SYM(vistrutahConsts)(%rip), %ymm4, %ymm13
    vpshufb 224+AREION_SYM(vistrutahConsts)(%rip), %ymm12, %ymm14
    vpxor %ymm14, %ymm13, %ymm13
    vshufi32x4 $68, %zmm13, %zmm4, %zmm4
    vshufi32x4 $177, %zmm4, %zmm4, %zmm5
    vpxord %xmm7, %xmm7, %xmm7
    vaesenclast %zmm7, %zmm4, %zmm4
    vaesdec %zmm7, %zmm4, %zmm4
    vshufi32x4 $0, %zmm4, %zmm4, %zmm8
    vshufi32x4 $85, %zmm4, %zmm4, %zmm9
    vshufi32x4 $170, %zmm4, %zmm4, %zmm10
    vshufi32x4 $255, %zmm4, %zmm4, %zmm11
    vmovdqu64 512+AREION_SYM(vistrutahConsts)(%rip), %zmm6
    vpshufb %zmm6, %zmm5, %zmm5
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_zmm_init_done
    vmovdqu64 128+AREION_SYM(vistrutahConsts)(%rip), %zmm6
    vpshufb %zmm6, %zmm5, %zmm5
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_zmm_init_done
    vpshufb %zmm6, %zmm5, %zmm5
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_zmm_init_done
    vpshufb %zmm6, %zmm5, %zmm5
    vpshufb %zmm6, %zmm5, %zmm5
.Lv512_dec_4blk256_zmm_init_done:
    vmovdqu64 576+AREION_SYM(vistrutahConsts)(%rip), %zmm4
    vmovdqu64 448+AREION_SYM(vistrutahConsts)(%rip), %zmm6
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vpxorq %zmm12, %zmm0, %zmm0
    vpxorq %zmm13, %zmm1, %zmm1
    vpxorq %zmm14, %zmm2, %zmm2
    vpxorq %zmm15, %zmm3, %zmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk256_zmm_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk256_zmm_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk256_zmm_step6
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 112+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 96+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
.Lv512_dec_4blk256_zmm_step6:
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 80+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
.Lv512_dec_4blk256_zmm_step5:
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 64+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
.Lv512_dec_4blk256_zmm_step4:
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 48+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 32+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 16+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vmovdqu %xmm0, (%rdi)
    vextracti32x4 $1, %zmm0, 64(%rdi)
    vextracti32x4 $2, %zmm0, 128(%rdi)
    vextracti32x4 $3, %zmm0, 192(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vextracti32x4 $1, %zmm1, 80(%rdi)
    vextracti32x4 $2, %zmm1, 144(%rdi)
    vextracti32x4 $3, %zmm1, 208(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vextracti32x4 $1, %zmm2, 96(%rdi)
    vextracti32x4 $2, %zmm2, 160(%rdi)
    vextracti32x4 $3, %zmm2, 224(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vextracti32x4 $1, %zmm3, 112(%rdi)
    vextracti32x4 $2, %zmm3, 176(%rdi)
    vextracti32x4 $3, %zmm3, 240(%rdi)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    vpxord %xmm6, %xmm6, %xmm6
    vpxord %xmm7, %xmm7, %xmm7
    vpxord %xmm8, %xmm8, %xmm8
    vpxord %xmm9, %xmm9, %xmm9
    vpxord %xmm10, %xmm10, %xmm10
    vpxord %xmm11, %xmm11, %xmm11
    vpxord %xmm12, %xmm12, %xmm12
    vpxord %xmm13, %xmm13, %xmm13
    vpxord %xmm14, %xmm14, %xmm14
    vpxord %xmm15, %xmm15, %xmm15
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512Decrypt4Blocks256ZmmAsm)

AREION_FUNC_START(vistrutah512Encrypt4Blocks512AesNiAsm)
#if !defined(_WIN64)
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
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu (%rdx), %xmm4
    movdqu 16(%rdx), %xmm5
    movdqu 32(%rdx), %xmm6
    movdqu 48(%rdx), %xmm7
    pxor %xmm12, %xmm12
    movdqu (%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    movdqa %xmm5, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm7, %xmm10
    movdqa %xmm6, %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk512_aesni_b0_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk512_aesni_b0_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk512_aesni_b0_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
.Lv512_4blk512_aesni_b0_final:
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    aesenclast %xmm8, %xmm0
    aesenclast %xmm9, %xmm1
    aesenclast %xmm10, %xmm2
    aesenclast %xmm11, %xmm3
    movdqu %xmm0, (%rdi)
    movdqu %xmm1, 16(%rdi)
    movdqu %xmm2, 32(%rdi)
    movdqu %xmm3, 48(%rdi)
    movdqu 64(%rsi), %xmm0
    movdqu 80(%rsi), %xmm1
    movdqu 96(%rsi), %xmm2
    movdqu 112(%rsi), %xmm3
    movdqa %xmm5, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm7, %xmm10
    movdqa %xmm6, %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk512_aesni_b1_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk512_aesni_b1_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk512_aesni_b1_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
.Lv512_4blk512_aesni_b1_final:
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    aesenclast %xmm8, %xmm0
    aesenclast %xmm9, %xmm1
    aesenclast %xmm10, %xmm2
    aesenclast %xmm11, %xmm3
    movdqu %xmm0, 64(%rdi)
    movdqu %xmm1, 80(%rdi)
    movdqu %xmm2, 96(%rdi)
    movdqu %xmm3, 112(%rdi)
    movdqu 128(%rsi), %xmm0
    movdqu 144(%rsi), %xmm1
    movdqu 160(%rsi), %xmm2
    movdqu 176(%rsi), %xmm3
    movdqa %xmm5, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm7, %xmm10
    movdqa %xmm6, %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk512_aesni_b2_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk512_aesni_b2_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk512_aesni_b2_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
.Lv512_4blk512_aesni_b2_final:
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    aesenclast %xmm8, %xmm0
    aesenclast %xmm9, %xmm1
    aesenclast %xmm10, %xmm2
    aesenclast %xmm11, %xmm3
    movdqu %xmm0, 128(%rdi)
    movdqu %xmm1, 144(%rdi)
    movdqu %xmm2, 160(%rdi)
    movdqu %xmm3, 176(%rdi)
    movdqu 192(%rsi), %xmm0
    movdqu 208(%rsi), %xmm1
    movdqu 224(%rsi), %xmm2
    movdqu 240(%rsi), %xmm3
    movdqa %xmm5, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm7, %xmm10
    movdqa %xmm6, %xmm11
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk512_aesni_b3_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk512_aesni_b3_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk512_aesni_b3_final
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    aesenc %xmm12, %xmm0
    aesenc %xmm12, %xmm1
    aesenc %xmm12, %xmm2
    aesenc %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpcklbw %xmm2, %xmm13
    punpckhbw %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpcklbw %xmm3, %xmm14
    punpckhbw %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklbw %xmm14, %xmm13
    punpckhbw %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklbw %xmm1, %xmm0
    punpckhbw %xmm1, %xmm3
    movdqa %xmm0, %xmm1
    movdqa %xmm13, %xmm0
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm0
    pxor %xmm13, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
.Lv512_4blk512_aesni_b3_final:
    aesenc %xmm4, %xmm0
    aesenc %xmm5, %xmm1
    aesenc %xmm6, %xmm2
    aesenc %xmm7, %xmm3
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    aesenclast %xmm8, %xmm0
    aesenclast %xmm9, %xmm1
    aesenclast %xmm10, %xmm2
    aesenclast %xmm11, %xmm3
    movdqu %xmm0, 192(%rdi)
    movdqu %xmm1, 208(%rdi)
    movdqu %xmm2, 224(%rdi)
    movdqu %xmm3, 240(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
AREION_FUNC_END(vistrutah512Encrypt4Blocks512AesNiAsm)

AREION_FUNC_START(vistrutah512Decrypt4Blocks512AesNiAsm)
#if !defined(_WIN64)
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
    movq %rcx, %rdi
    movq %rdx, %rsi
    movq %r8, %rdx
    movq %r9, %rcx
#endif
    movdqu (%rdx), %xmm4
    movdqu 16(%rdx), %xmm5
    movdqu 32(%rdx), %xmm6
    movdqu 48(%rdx), %xmm7
    movdqa %xmm5, %xmm8
    movdqa %xmm4, %xmm9
    movdqa %xmm7, %xmm10
    movdqa %xmm6, %xmm11
    aesimc %xmm4, %xmm4
    aesimc %xmm5, %xmm5
    aesimc %xmm6, %xmm6
    aesimc %xmm7, %xmm7
    movdqu 576+AREION_SYM(vistrutahConsts)(%rip), %xmm12
    movdqu (%rsi), %xmm0
    movdqu 16(%rsi), %xmm1
    movdqu 32(%rsi), %xmm2
    movdqu 48(%rsi), %xmm3
    palignr $9, %xmm8, %xmm8
    palignr $2, %xmm9, %xmm9
    palignr $9, %xmm10, %xmm10
    palignr $2, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_aesni_b0_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_aesni_b0_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_aesni_b0_init_done
    palignr $10, %xmm8, %xmm8
    palignr $4, %xmm9, %xmm9
    palignr $10, %xmm10, %xmm10
    palignr $4, %xmm11, %xmm11
.Lv512_dec_4blk512_aesni_b0_init_done:
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_aesni_b0_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_aesni_b0_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_aesni_b0_step6
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk512_aesni_b0_step6:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk512_aesni_b0_step5:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk512_aesni_b0_step4:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    aesdeclast %xmm8, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqu %xmm0, (%rdi)
    movdqu %xmm1, 16(%rdi)
    movdqu %xmm2, 32(%rdi)
    movdqu %xmm3, 48(%rdi)
    movdqu 64(%rsi), %xmm0
    movdqu 80(%rsi), %xmm1
    movdqu 96(%rsi), %xmm2
    movdqu 112(%rsi), %xmm3
    palignr $9, %xmm8, %xmm8
    palignr $2, %xmm9, %xmm9
    palignr $9, %xmm10, %xmm10
    palignr $2, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_aesni_b1_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_aesni_b1_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_aesni_b1_init_done
    palignr $10, %xmm8, %xmm8
    palignr $4, %xmm9, %xmm9
    palignr $10, %xmm10, %xmm10
    palignr $4, %xmm11, %xmm11
.Lv512_dec_4blk512_aesni_b1_init_done:
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_aesni_b1_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_aesni_b1_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_aesni_b1_step6
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk512_aesni_b1_step6:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk512_aesni_b1_step5:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk512_aesni_b1_step4:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    aesdeclast %xmm8, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqu %xmm0, 64(%rdi)
    movdqu %xmm1, 80(%rdi)
    movdqu %xmm2, 96(%rdi)
    movdqu %xmm3, 112(%rdi)
    movdqu 128(%rsi), %xmm0
    movdqu 144(%rsi), %xmm1
    movdqu 160(%rsi), %xmm2
    movdqu 176(%rsi), %xmm3
    palignr $9, %xmm8, %xmm8
    palignr $2, %xmm9, %xmm9
    palignr $9, %xmm10, %xmm10
    palignr $2, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_aesni_b2_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_aesni_b2_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_aesni_b2_init_done
    palignr $10, %xmm8, %xmm8
    palignr $4, %xmm9, %xmm9
    palignr $10, %xmm10, %xmm10
    palignr $4, %xmm11, %xmm11
.Lv512_dec_4blk512_aesni_b2_init_done:
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_aesni_b2_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_aesni_b2_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_aesni_b2_step6
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk512_aesni_b2_step6:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk512_aesni_b2_step5:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk512_aesni_b2_step4:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    aesdeclast %xmm8, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqu %xmm0, 128(%rdi)
    movdqu %xmm1, 144(%rdi)
    movdqu %xmm2, 160(%rdi)
    movdqu %xmm3, 176(%rdi)
    movdqu 192(%rsi), %xmm0
    movdqu 208(%rsi), %xmm1
    movdqu 224(%rsi), %xmm2
    movdqu 240(%rsi), %xmm3
    palignr $9, %xmm8, %xmm8
    palignr $2, %xmm9, %xmm9
    palignr $9, %xmm10, %xmm10
    palignr $2, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_aesni_b3_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_aesni_b3_init_done
    palignr $5, %xmm8, %xmm8
    palignr $10, %xmm9, %xmm9
    palignr $5, %xmm10, %xmm10
    palignr $10, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_aesni_b3_init_done
    palignr $10, %xmm8, %xmm8
    palignr $4, %xmm9, %xmm9
    palignr $10, %xmm10, %xmm10
    palignr $4, %xmm11, %xmm11
.Lv512_dec_4blk512_aesni_b3_init_done:
    pxor %xmm8, %xmm0
    pxor %xmm9, %xmm1
    pxor %xmm10, %xmm2
    pxor %xmm11, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_aesni_b3_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_aesni_b3_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_aesni_b3_step6
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk512_aesni_b3_step6:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk512_aesni_b3_step5:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
.Lv512_dec_4blk512_aesni_b3_step4:
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    movdqu AREION_SYM(vistrutahRoundConstants)(%rip), %xmm13
    pxor %xmm8, %xmm13
    aesdeclast %xmm13, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    pshufb %xmm12, %xmm0
    pshufb %xmm12, %xmm1
    pshufb %xmm12, %xmm2
    pshufb %xmm12, %xmm3
    movdqa %xmm0, %xmm13
    punpckldq %xmm2, %xmm13
    punpckhdq %xmm2, %xmm0
    movdqa %xmm1, %xmm14
    punpckldq %xmm3, %xmm14
    punpckhdq %xmm3, %xmm1
    movdqa %xmm13, %xmm2
    punpcklqdq %xmm14, %xmm13
    punpckhqdq %xmm14, %xmm2
    movdqa %xmm0, %xmm3
    punpcklqdq %xmm1, %xmm0
    punpckhqdq %xmm1, %xmm3
    movdqa %xmm2, %xmm1
    movdqa %xmm0, %xmm2
    movdqa %xmm13, %xmm0
    aesimc %xmm0, %xmm0
    aesimc %xmm1, %xmm1
    aesimc %xmm2, %xmm2
    aesimc %xmm3, %xmm3
    aesdec %xmm4, %xmm0
    aesdec %xmm5, %xmm1
    aesdec %xmm6, %xmm2
    aesdec %xmm7, %xmm3
    palignr $11, %xmm8, %xmm8
    palignr $6, %xmm9, %xmm9
    palignr $11, %xmm10, %xmm10
    palignr $6, %xmm11, %xmm11
    aesdeclast %xmm8, %xmm0
    aesdeclast %xmm9, %xmm1
    aesdeclast %xmm10, %xmm2
    aesdeclast %xmm11, %xmm3
    movdqu %xmm0, 192(%rdi)
    movdqu %xmm1, 208(%rdi)
    movdqu %xmm2, 224(%rdi)
    movdqu %xmm3, 240(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
AREION_FUNC_END(vistrutah512Decrypt4Blocks512AesNiAsm)

AREION_FUNC_START(vistrutah512Encrypt4Blocks512VexAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rdx), %xmm4
    vmovdqu 16(%rdx), %xmm5
    vmovdqu 32(%rdx), %xmm6
    vmovdqu 48(%rdx), %xmm7
    vpxor %xmm12, %xmm12, %xmm12
    vmovdqu (%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vmovdqa %xmm5, %xmm8
    vmovdqa %xmm4, %xmm9
    vmovdqa %xmm7, %xmm10
    vmovdqa %xmm6, %xmm11
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk512_vex_b0_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk512_vex_b0_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk512_vex_b0_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
.Lv512_4blk512_vex_b0_final:
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vaesenclast %xmm8, %xmm0, %xmm0
    vaesenclast %xmm9, %xmm1, %xmm1
    vaesenclast %xmm10, %xmm2, %xmm2
    vaesenclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, (%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vmovdqu 64(%rsi), %xmm0
    vmovdqu 80(%rsi), %xmm1
    vmovdqu 96(%rsi), %xmm2
    vmovdqu 112(%rsi), %xmm3
    vmovdqa %xmm5, %xmm8
    vmovdqa %xmm4, %xmm9
    vmovdqa %xmm7, %xmm10
    vmovdqa %xmm6, %xmm11
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk512_vex_b1_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk512_vex_b1_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk512_vex_b1_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
.Lv512_4blk512_vex_b1_final:
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vaesenclast %xmm8, %xmm0, %xmm0
    vaesenclast %xmm9, %xmm1, %xmm1
    vaesenclast %xmm10, %xmm2, %xmm2
    vaesenclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, 64(%rdi)
    vmovdqu %xmm1, 80(%rdi)
    vmovdqu %xmm2, 96(%rdi)
    vmovdqu %xmm3, 112(%rdi)
    vmovdqu 128(%rsi), %xmm0
    vmovdqu 144(%rsi), %xmm1
    vmovdqu 160(%rsi), %xmm2
    vmovdqu 176(%rsi), %xmm3
    vmovdqa %xmm5, %xmm8
    vmovdqa %xmm4, %xmm9
    vmovdqa %xmm7, %xmm10
    vmovdqa %xmm6, %xmm11
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk512_vex_b2_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk512_vex_b2_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk512_vex_b2_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
.Lv512_4blk512_vex_b2_final:
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vaesenclast %xmm8, %xmm0, %xmm0
    vaesenclast %xmm9, %xmm1, %xmm1
    vaesenclast %xmm10, %xmm2, %xmm2
    vaesenclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, 128(%rdi)
    vmovdqu %xmm1, 144(%rdi)
    vmovdqu %xmm2, 160(%rdi)
    vmovdqu %xmm3, 176(%rdi)
    vmovdqu 192(%rsi), %xmm0
    vmovdqu 208(%rsi), %xmm1
    vmovdqu 224(%rsi), %xmm2
    vmovdqu 240(%rsi), %xmm3
    vmovdqa %xmm5, %xmm8
    vmovdqa %xmm4, %xmm9
    vmovdqa %xmm7, %xmm10
    vmovdqa %xmm6, %xmm11
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_4blk512_vex_b3_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $12, %rcx
    je .Lv512_4blk512_vex_b3_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $14, %rcx
    je .Lv512_4blk512_vex_b3_final
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vaesenc %xmm12, %xmm0, %xmm0
    vaesenc %xmm12, %xmm1, %xmm1
    vaesenc %xmm12, %xmm2, %xmm2
    vaesenc %xmm12, %xmm3, %xmm3
    vpunpcklbw %xmm2, %xmm0, %xmm13
    vpunpckhbw %xmm2, %xmm0, %xmm14
    vpunpcklbw %xmm3, %xmm1, %xmm15
    vpunpckhbw %xmm3, %xmm1, %xmm1
    vpunpcklbw %xmm15, %xmm13, %xmm0
    vpunpckhbw %xmm15, %xmm13, %xmm2
    vpunpckhbw %xmm1, %xmm14, %xmm3
    vpunpcklbw %xmm1, %xmm14, %xmm1
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vpxor %xmm13, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
.Lv512_4blk512_vex_b3_final:
    vaesenc %xmm4, %xmm0, %xmm0
    vaesenc %xmm5, %xmm1, %xmm1
    vaesenc %xmm6, %xmm2, %xmm2
    vaesenc %xmm7, %xmm3, %xmm3
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    vaesenclast %xmm8, %xmm0, %xmm0
    vaesenclast %xmm9, %xmm1, %xmm1
    vaesenclast %xmm10, %xmm2, %xmm2
    vaesenclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, 192(%rdi)
    vmovdqu %xmm1, 208(%rdi)
    vmovdqu %xmm2, 224(%rdi)
    vmovdqu %xmm3, 240(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah512Encrypt4Blocks512VexAsm)

AREION_FUNC_START(vistrutah512Decrypt4Blocks512VexAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rdx), %xmm4
    vmovdqu 16(%rdx), %xmm5
    vmovdqu 32(%rdx), %xmm6
    vmovdqu 48(%rdx), %xmm7
    vmovdqa %xmm5, %xmm8
    vmovdqa %xmm4, %xmm9
    vmovdqa %xmm7, %xmm10
    vmovdqa %xmm6, %xmm11
    vaesimc %xmm4, %xmm4
    vaesimc %xmm5, %xmm5
    vaesimc %xmm6, %xmm6
    vaesimc %xmm7, %xmm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %xmm12
    vmovdqu (%rsi), %xmm0
    vmovdqu 16(%rsi), %xmm1
    vmovdqu 32(%rsi), %xmm2
    vmovdqu 48(%rsi), %xmm3
    vpalignr $9, %xmm8, %xmm8, %xmm8
    vpalignr $2, %xmm9, %xmm9, %xmm9
    vpalignr $9, %xmm10, %xmm10, %xmm10
    vpalignr $2, %xmm11, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_vex_b0_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_vex_b0_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_vex_b0_init_done
    vpalignr $10, %xmm8, %xmm8, %xmm8
    vpalignr $4, %xmm9, %xmm9, %xmm9
    vpalignr $10, %xmm10, %xmm10, %xmm10
    vpalignr $4, %xmm11, %xmm11, %xmm11
.Lv512_dec_4blk512_vex_b0_init_done:
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_vex_b0_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_vex_b0_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_vex_b0_step6
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk512_vex_b0_step6:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk512_vex_b0_step5:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk512_vex_b0_step4:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, (%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vmovdqu 64(%rsi), %xmm0
    vmovdqu 80(%rsi), %xmm1
    vmovdqu 96(%rsi), %xmm2
    vmovdqu 112(%rsi), %xmm3
    vpalignr $9, %xmm8, %xmm8, %xmm8
    vpalignr $2, %xmm9, %xmm9, %xmm9
    vpalignr $9, %xmm10, %xmm10, %xmm10
    vpalignr $2, %xmm11, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_vex_b1_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_vex_b1_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_vex_b1_init_done
    vpalignr $10, %xmm8, %xmm8, %xmm8
    vpalignr $4, %xmm9, %xmm9, %xmm9
    vpalignr $10, %xmm10, %xmm10, %xmm10
    vpalignr $4, %xmm11, %xmm11, %xmm11
.Lv512_dec_4blk512_vex_b1_init_done:
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_vex_b1_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_vex_b1_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_vex_b1_step6
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk512_vex_b1_step6:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk512_vex_b1_step5:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk512_vex_b1_step4:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, 64(%rdi)
    vmovdqu %xmm1, 80(%rdi)
    vmovdqu %xmm2, 96(%rdi)
    vmovdqu %xmm3, 112(%rdi)
    vmovdqu 128(%rsi), %xmm0
    vmovdqu 144(%rsi), %xmm1
    vmovdqu 160(%rsi), %xmm2
    vmovdqu 176(%rsi), %xmm3
    vpalignr $9, %xmm8, %xmm8, %xmm8
    vpalignr $2, %xmm9, %xmm9, %xmm9
    vpalignr $9, %xmm10, %xmm10, %xmm10
    vpalignr $2, %xmm11, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_vex_b2_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_vex_b2_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_vex_b2_init_done
    vpalignr $10, %xmm8, %xmm8, %xmm8
    vpalignr $4, %xmm9, %xmm9, %xmm9
    vpalignr $10, %xmm10, %xmm10, %xmm10
    vpalignr $4, %xmm11, %xmm11, %xmm11
.Lv512_dec_4blk512_vex_b2_init_done:
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_vex_b2_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_vex_b2_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_vex_b2_step6
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk512_vex_b2_step6:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk512_vex_b2_step5:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk512_vex_b2_step4:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, 128(%rdi)
    vmovdqu %xmm1, 144(%rdi)
    vmovdqu %xmm2, 160(%rdi)
    vmovdqu %xmm3, 176(%rdi)
    vmovdqu 192(%rsi), %xmm0
    vmovdqu 208(%rsi), %xmm1
    vmovdqu 224(%rsi), %xmm2
    vmovdqu 240(%rsi), %xmm3
    vpalignr $9, %xmm8, %xmm8, %xmm8
    vpalignr $2, %xmm9, %xmm9, %xmm9
    vpalignr $9, %xmm10, %xmm10, %xmm10
    vpalignr $2, %xmm11, %xmm11, %xmm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_vex_b3_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_vex_b3_init_done
    vpalignr $5, %xmm8, %xmm8, %xmm8
    vpalignr $10, %xmm9, %xmm9, %xmm9
    vpalignr $5, %xmm10, %xmm10, %xmm10
    vpalignr $10, %xmm11, %xmm11, %xmm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_vex_b3_init_done
    vpalignr $10, %xmm8, %xmm8, %xmm8
    vpalignr $4, %xmm9, %xmm9, %xmm9
    vpalignr $10, %xmm10, %xmm10, %xmm10
    vpalignr $4, %xmm11, %xmm11, %xmm11
.Lv512_dec_4blk512_vex_b3_init_done:
    vpxor %xmm8, %xmm0, %xmm0
    vpxor %xmm9, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_vex_b3_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_vex_b3_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_vex_b3_step6
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 112+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 96+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk512_vex_b3_step6:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 80+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk512_vex_b3_step5:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 64+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
.Lv512_dec_4blk512_vex_b3_step4:
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 48+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 32+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor 16+AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vpxor AREION_SYM(vistrutahRoundConstants)(%rip), %xmm8, %xmm13
    vaesdeclast %xmm13, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpshufb %xmm12, %xmm0, %xmm0
    vpshufb %xmm12, %xmm1, %xmm1
    vpshufb %xmm12, %xmm2, %xmm2
    vpshufb %xmm12, %xmm3, %xmm3
    vpunpckldq %xmm2, %xmm0, %xmm13
    vpunpckhdq %xmm2, %xmm0, %xmm14
    vpunpckldq %xmm3, %xmm1, %xmm15
    vpunpckhdq %xmm3, %xmm1, %xmm1
    vpunpcklqdq %xmm15, %xmm13, %xmm0
    vpunpckhqdq %xmm15, %xmm13, %xmm13
    vpunpcklqdq %xmm1, %xmm14, %xmm2
    vpunpckhqdq %xmm1, %xmm14, %xmm3
    vaesimc %xmm0, %xmm0
    vaesimc %xmm13, %xmm1
    vaesimc %xmm2, %xmm2
    vaesimc %xmm3, %xmm3
    vaesdec %xmm4, %xmm0, %xmm0
    vaesdec %xmm5, %xmm1, %xmm1
    vaesdec %xmm6, %xmm2, %xmm2
    vaesdec %xmm7, %xmm3, %xmm3
    vpalignr $11, %xmm8, %xmm8, %xmm8
    vpalignr $6, %xmm9, %xmm9, %xmm9
    vpalignr $11, %xmm10, %xmm10, %xmm10
    vpalignr $6, %xmm11, %xmm11, %xmm11
    vaesdeclast %xmm8, %xmm0, %xmm0
    vaesdeclast %xmm9, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vmovdqu %xmm0, 192(%rdi)
    vmovdqu %xmm1, 208(%rdi)
    vmovdqu %xmm2, 224(%rdi)
    vmovdqu %xmm3, 240(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    ret
AREION_FUNC_END(vistrutah512Decrypt4Blocks512VexAsm)

AREION_FUNC_START(vistrutah512Encrypt4Blocks512YmmAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rsi), %xmm0
    vinserti128 $1, 64(%rsi), %ymm0, %ymm0
    vmovdqu 16(%rsi), %xmm1
    vinserti128 $1, 80(%rsi), %ymm1, %ymm1
    vmovdqu 32(%rsi), %xmm2
    vinserti128 $1, 96(%rsi), %ymm2, %ymm2
    vmovdqu 48(%rsi), %xmm3
    vinserti128 $1, 112(%rsi), %ymm3, %ymm3
    vmovdqu 128(%rsi), %xmm4
    vinserti128 $1, 192(%rsi), %ymm4, %ymm4
    vmovdqu 144(%rsi), %xmm5
    vinserti128 $1, 208(%rsi), %ymm5, %ymm5
    vmovdqu 160(%rsi), %xmm6
    vinserti128 $1, 224(%rsi), %ymm6, %ymm6
    vmovdqu 176(%rsi), %xmm7
    vinserti128 $1, 240(%rsi), %ymm7, %ymm7
    vmovdqu (%rdx), %ymm8
    vperm2i128 $1, %ymm8, %ymm8, %ymm10
    vmovdqu 32(%rdx), %ymm9
    vperm2i128 $1, %ymm9, %ymm9, %ymm11
    vpxor %xmm12, %xmm12, %xmm12
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 16+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 32+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 48+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    cmpq $10, %rcx
    je .Lv512_4blk512_ymm_final
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 64+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    cmpq $12, %rcx
    je .Lv512_4blk512_ymm_final
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 80+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    cmpq $14, %rcx
    je .Lv512_4blk512_ymm_final
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 96+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vaesenc %ymm12, %ymm0, %ymm0
    vaesenc %ymm12, %ymm1, %ymm1
    vaesenc %ymm12, %ymm2, %ymm2
    vaesenc %ymm12, %ymm3, %ymm3
    vaesenc %ymm12, %ymm4, %ymm4
    vaesenc %ymm12, %ymm5, %ymm5
    vaesenc %ymm12, %ymm6, %ymm6
    vaesenc %ymm12, %ymm7, %ymm7
    vpunpcklbw %ymm2, %ymm0, %ymm13
    vpunpckhbw %ymm2, %ymm0, %ymm14
    vpunpcklbw %ymm3, %ymm1, %ymm15
    vpunpckhbw %ymm3, %ymm1, %ymm1
    vpunpcklbw %ymm15, %ymm13, %ymm0
    vpunpckhbw %ymm15, %ymm13, %ymm2
    vpunpckhbw %ymm1, %ymm14, %ymm3
    vpunpcklbw %ymm1, %ymm14, %ymm1
    vpunpcklbw %ymm6, %ymm4, %ymm13
    vpunpckhbw %ymm6, %ymm4, %ymm14
    vpunpcklbw %ymm7, %ymm5, %ymm15
    vpunpckhbw %ymm7, %ymm5, %ymm5
    vpunpcklbw %ymm15, %ymm13, %ymm4
    vpunpckhbw %ymm15, %ymm13, %ymm6
    vpunpckhbw %ymm5, %ymm14, %ymm7
    vpunpcklbw %ymm5, %ymm14, %ymm5
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 112+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
.Lv512_4blk512_ymm_final:
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesenc %ymm13, %ymm0, %ymm0
    vaesenc %ymm13, %ymm4, %ymm4
    vaesenc %ymm14, %ymm1, %ymm1
    vaesenc %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesenc %ymm13, %ymm2, %ymm2
    vaesenc %ymm13, %ymm6, %ymm6
    vaesenc %ymm14, %ymm3, %ymm3
    vaesenc %ymm14, %ymm7, %ymm7
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesenclast %ymm13, %ymm0, %ymm0
    vaesenclast %ymm13, %ymm4, %ymm4
    vaesenclast %ymm14, %ymm1, %ymm1
    vaesenclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesenclast %ymm13, %ymm2, %ymm2
    vaesenclast %ymm13, %ymm6, %ymm6
    vaesenclast %ymm14, %ymm3, %ymm3
    vaesenclast %ymm14, %ymm7, %ymm7
    vmovdqu %xmm0, (%rdi)
    vextracti128 $1, %ymm0, 64(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vextracti128 $1, %ymm1, 80(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vextracti128 $1, %ymm2, 96(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vextracti128 $1, %ymm3, 112(%rdi)
    vmovdqu %xmm4, 128(%rdi)
    vextracti128 $1, %ymm4, 192(%rdi)
    vmovdqu %xmm5, 144(%rdi)
    vextracti128 $1, %ymm5, 208(%rdi)
    vmovdqu %xmm6, 160(%rdi)
    vextracti128 $1, %ymm6, 224(%rdi)
    vmovdqu %xmm7, 176(%rdi)
    vextracti128 $1, %ymm7, 240(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512Encrypt4Blocks512YmmAsm)

AREION_FUNC_START(vistrutah512Decrypt4Blocks512YmmAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rsi), %xmm0
    vinserti128 $1, 64(%rsi), %ymm0, %ymm0
    vmovdqu 16(%rsi), %xmm1
    vinserti128 $1, 80(%rsi), %ymm1, %ymm1
    vmovdqu 32(%rsi), %xmm2
    vinserti128 $1, 96(%rsi), %ymm2, %ymm2
    vmovdqu 48(%rsi), %xmm3
    vinserti128 $1, 112(%rsi), %ymm3, %ymm3
    vmovdqu 128(%rsi), %xmm4
    vinserti128 $1, 192(%rsi), %ymm4, %ymm4
    vmovdqu 144(%rsi), %xmm5
    vinserti128 $1, 208(%rsi), %ymm5, %ymm5
    vmovdqu 160(%rsi), %xmm6
    vinserti128 $1, 224(%rsi), %ymm6, %ymm6
    vmovdqu 176(%rsi), %xmm7
    vinserti128 $1, 240(%rsi), %ymm7, %ymm7
    vmovdqu (%rdx), %ymm8
    vperm2i128 $1, %ymm8, %ymm8, %ymm10
    vmovdqu 32(%rdx), %ymm9
    vperm2i128 $1, %ymm9, %ymm9, %ymm11
    vpxor %xmm12, %xmm12, %xmm12
    vaesenclast %ymm12, %ymm8, %ymm8
    vaesdec %ymm12, %ymm8, %ymm8
    vaesenclast %ymm12, %ymm9, %ymm9
    vaesdec %ymm12, %ymm9, %ymm9
    vmovdqu 512+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_ymm_init_done
    vmovdqu 128+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_ymm_init_done
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_ymm_init_done
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
.Lv512_dec_4blk512_ymm_init_done:
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vpxor %ymm13, %ymm0, %ymm0
    vpxor %ymm13, %ymm4, %ymm4
    vpxor %ymm14, %ymm1, %ymm1
    vpxor %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vpxor %ymm13, %ymm2, %ymm2
    vpxor %ymm13, %ymm6, %ymm6
    vpxor %ymm14, %ymm3, %ymm3
    vpxor %ymm14, %ymm7, %ymm7
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_ymm_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_ymm_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_ymm_step6
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 112+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 96+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
.Lv512_dec_4blk512_ymm_step6:
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 80+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
.Lv512_dec_4blk512_ymm_step5:
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 64+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
.Lv512_dec_4blk512_ymm_step4:
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 48+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 32+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 16+AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vbroadcasti128 AREION_SYM(vistrutahRoundConstants)(%rip), %ymm15
    vpxor %ymm15, %ymm13, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu 576+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm0, %ymm0
    vpshufb %ymm15, %ymm1, %ymm1
    vpshufb %ymm15, %ymm2, %ymm2
    vpshufb %ymm15, %ymm3, %ymm3
    vpunpckldq %ymm2, %ymm0, %ymm13
    vpunpckhdq %ymm2, %ymm0, %ymm14
    vpunpckldq %ymm3, %ymm1, %ymm2
    vpunpckhdq %ymm3, %ymm1, %ymm3
    vpunpcklqdq %ymm2, %ymm13, %ymm0
    vpunpckhqdq %ymm2, %ymm13, %ymm1
    vpunpcklqdq %ymm3, %ymm14, %ymm2
    vpunpckhqdq %ymm3, %ymm14, %ymm3
    vpshufb %ymm15, %ymm4, %ymm4
    vpshufb %ymm15, %ymm5, %ymm5
    vpshufb %ymm15, %ymm6, %ymm6
    vpshufb %ymm15, %ymm7, %ymm7
    vpunpckldq %ymm6, %ymm4, %ymm13
    vpunpckhdq %ymm6, %ymm4, %ymm14
    vpunpckldq %ymm7, %ymm5, %ymm6
    vpunpckhdq %ymm7, %ymm5, %ymm7
    vpunpcklqdq %ymm6, %ymm13, %ymm4
    vpunpckhqdq %ymm6, %ymm13, %ymm5
    vpunpcklqdq %ymm7, %ymm14, %ymm6
    vpunpckhqdq %ymm7, %ymm14, %ymm7
    vaesenclast %ymm12, %ymm0, %ymm0
    vaesdec %ymm12, %ymm0, %ymm0
    vaesenclast %ymm12, %ymm1, %ymm1
    vaesdec %ymm12, %ymm1, %ymm1
    vaesenclast %ymm12, %ymm2, %ymm2
    vaesdec %ymm12, %ymm2, %ymm2
    vaesenclast %ymm12, %ymm3, %ymm3
    vaesdec %ymm12, %ymm3, %ymm3
    vaesenclast %ymm12, %ymm4, %ymm4
    vaesdec %ymm12, %ymm4, %ymm4
    vaesenclast %ymm12, %ymm5, %ymm5
    vaesdec %ymm12, %ymm5, %ymm5
    vaesenclast %ymm12, %ymm6, %ymm6
    vaesdec %ymm12, %ymm6, %ymm6
    vaesenclast %ymm12, %ymm7, %ymm7
    vaesdec %ymm12, %ymm7, %ymm7
    vperm2i128 $0, %ymm8, %ymm8, %ymm13
    vperm2i128 $17, %ymm8, %ymm8, %ymm14
    vaesdec %ymm13, %ymm0, %ymm0
    vaesdec %ymm13, %ymm4, %ymm4
    vaesdec %ymm14, %ymm1, %ymm1
    vaesdec %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm9, %ymm9, %ymm13
    vperm2i128 $17, %ymm9, %ymm9, %ymm14
    vaesdec %ymm13, %ymm2, %ymm2
    vaesdec %ymm13, %ymm6, %ymm6
    vaesdec %ymm14, %ymm3, %ymm3
    vaesdec %ymm14, %ymm7, %ymm7
    vmovdqu 448+AREION_SYM(vistrutahConsts)(%rip), %ymm15
    vpshufb %ymm15, %ymm10, %ymm10
    vpshufb %ymm15, %ymm11, %ymm11
    vperm2i128 $0, %ymm10, %ymm10, %ymm13
    vperm2i128 $17, %ymm10, %ymm10, %ymm14
    vaesdeclast %ymm13, %ymm0, %ymm0
    vaesdeclast %ymm13, %ymm4, %ymm4
    vaesdeclast %ymm14, %ymm1, %ymm1
    vaesdeclast %ymm14, %ymm5, %ymm5
    vperm2i128 $0, %ymm11, %ymm11, %ymm13
    vperm2i128 $17, %ymm11, %ymm11, %ymm14
    vaesdeclast %ymm13, %ymm2, %ymm2
    vaesdeclast %ymm13, %ymm6, %ymm6
    vaesdeclast %ymm14, %ymm3, %ymm3
    vaesdeclast %ymm14, %ymm7, %ymm7
    vmovdqu %xmm0, (%rdi)
    vextracti128 $1, %ymm0, 64(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vextracti128 $1, %ymm1, 80(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vextracti128 $1, %ymm2, 96(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vextracti128 $1, %ymm3, 112(%rdi)
    vmovdqu %xmm4, 128(%rdi)
    vextracti128 $1, %ymm4, 192(%rdi)
    vmovdqu %xmm5, 144(%rdi)
    vextracti128 $1, %ymm5, 208(%rdi)
    vmovdqu %xmm6, 160(%rdi)
    vextracti128 $1, %ymm6, 224(%rdi)
    vmovdqu %xmm7, 176(%rdi)
    vextracti128 $1, %ymm7, 240(%rdi)
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
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512Decrypt4Blocks512YmmAsm)

AREION_FUNC_START(vistrutah512Encrypt4Blocks512ZmmAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rsi), %xmm0
    vinserti32x4 $1, 64(%rsi), %zmm0, %zmm0
    vinserti32x4 $2, 128(%rsi), %zmm0, %zmm0
    vinserti32x4 $3, 192(%rsi), %zmm0, %zmm0
    vmovdqu 16(%rsi), %xmm1
    vinserti32x4 $1, 80(%rsi), %zmm1, %zmm1
    vinserti32x4 $2, 144(%rsi), %zmm1, %zmm1
    vinserti32x4 $3, 208(%rsi), %zmm1, %zmm1
    vmovdqu 32(%rsi), %xmm2
    vinserti32x4 $1, 96(%rsi), %zmm2, %zmm2
    vinserti32x4 $2, 160(%rsi), %zmm2, %zmm2
    vinserti32x4 $3, 224(%rsi), %zmm2, %zmm2
    vmovdqu 48(%rsi), %xmm3
    vinserti32x4 $1, 112(%rsi), %zmm3, %zmm3
    vinserti32x4 $2, 176(%rsi), %zmm3, %zmm3
    vinserti32x4 $3, 240(%rsi), %zmm3, %zmm3
    vmovdqu64 (%rdx), %zmm4
    vshufi32x4 $0, %zmm4, %zmm4, %zmm8
    vshufi32x4 $85, %zmm4, %zmm4, %zmm9
    vshufi32x4 $170, %zmm4, %zmm4, %zmm10
    vshufi32x4 $255, %zmm4, %zmm4, %zmm11
    vshufi32x4 $177, %zmm4, %zmm4, %zmm5
    vmovdqu64 128+AREION_SYM(vistrutahConsts)(%rip), %zmm6
    vpxord %xmm7, %xmm7, %xmm7
    vpxorq %zmm9, %zmm0, %zmm0
    vpxorq %zmm8, %zmm1, %zmm1
    vpxorq %zmm11, %zmm2, %zmm2
    vpxorq %zmm10, %zmm3, %zmm3
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 16+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 32+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 48+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
    cmpq $10, %rcx
    je .Lv512_4blk512_zmm_final
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 64+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
    cmpq $12, %rcx
    je .Lv512_4blk512_zmm_final
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 80+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
    cmpq $14, %rcx
    je .Lv512_4blk512_zmm_final
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 96+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vaesenc %zmm7, %zmm0, %zmm0
    vaesenc %zmm7, %zmm1, %zmm1
    vaesenc %zmm7, %zmm2, %zmm2
    vaesenc %zmm7, %zmm3, %zmm3
    vpunpcklbw %zmm2, %zmm0, %zmm12
    vpunpckhbw %zmm2, %zmm0, %zmm13
    vpunpcklbw %zmm3, %zmm1, %zmm14
    vpunpckhbw %zmm3, %zmm1, %zmm15
    vpunpcklbw %zmm14, %zmm12, %zmm0
    vpunpckhbw %zmm14, %zmm12, %zmm2
    vpunpcklbw %zmm15, %zmm13, %zmm1
    vpunpckhbw %zmm15, %zmm13, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 112+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vpxorq %zmm12, %zmm0, %zmm0
    vshufi32x4 $85, %zmm5, %zmm5, %zmm12
    vpxorq %zmm12, %zmm1, %zmm1
    vshufi32x4 $170, %zmm5, %zmm5, %zmm13
    vpxorq %zmm13, %zmm2, %zmm2
    vshufi32x4 $255, %zmm5, %zmm5, %zmm14
    vpxorq %zmm14, %zmm3, %zmm3
.Lv512_4blk512_zmm_final:
    vaesenc %zmm8, %zmm0, %zmm0
    vaesenc %zmm9, %zmm1, %zmm1
    vaesenc %zmm10, %zmm2, %zmm2
    vaesenc %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesenclast %zmm12, %zmm0, %zmm0
    vaesenclast %zmm13, %zmm1, %zmm1
    vaesenclast %zmm14, %zmm2, %zmm2
    vaesenclast %zmm15, %zmm3, %zmm3
    vmovdqu %xmm0, (%rdi)
    vextracti32x4 $1, %zmm0, 64(%rdi)
    vextracti32x4 $2, %zmm0, 128(%rdi)
    vextracti32x4 $3, %zmm0, 192(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vextracti32x4 $1, %zmm1, 80(%rdi)
    vextracti32x4 $2, %zmm1, 144(%rdi)
    vextracti32x4 $3, %zmm1, 208(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vextracti32x4 $1, %zmm2, 96(%rdi)
    vextracti32x4 $2, %zmm2, 160(%rdi)
    vextracti32x4 $3, %zmm2, 224(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vextracti32x4 $1, %zmm3, 112(%rdi)
    vextracti32x4 $2, %zmm3, 176(%rdi)
    vextracti32x4 $3, %zmm3, 240(%rdi)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    vpxord %xmm6, %xmm6, %xmm6
    vpxord %xmm7, %xmm7, %xmm7
    vpxord %xmm8, %xmm8, %xmm8
    vpxord %xmm9, %xmm9, %xmm9
    vpxord %xmm10, %xmm10, %xmm10
    vpxord %xmm11, %xmm11, %xmm11
    vpxord %xmm12, %xmm12, %xmm12
    vpxord %xmm13, %xmm13, %xmm13
    vpxord %xmm14, %xmm14, %xmm14
    vpxord %xmm15, %xmm15, %xmm15
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512Encrypt4Blocks512ZmmAsm)

AREION_FUNC_START(vistrutah512Decrypt4Blocks512ZmmAsm)
#if !defined(_WIN64)
#else
    subq $184, %rsp
    movq %rsi, 0(%rsp)
    movq %rdi, 8(%rsp)
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
    vmovdqu (%rsi), %xmm0
    vinserti32x4 $1, 64(%rsi), %zmm0, %zmm0
    vinserti32x4 $2, 128(%rsi), %zmm0, %zmm0
    vinserti32x4 $3, 192(%rsi), %zmm0, %zmm0
    vmovdqu 16(%rsi), %xmm1
    vinserti32x4 $1, 80(%rsi), %zmm1, %zmm1
    vinserti32x4 $2, 144(%rsi), %zmm1, %zmm1
    vinserti32x4 $3, 208(%rsi), %zmm1, %zmm1
    vmovdqu 32(%rsi), %xmm2
    vinserti32x4 $1, 96(%rsi), %zmm2, %zmm2
    vinserti32x4 $2, 160(%rsi), %zmm2, %zmm2
    vinserti32x4 $3, 224(%rsi), %zmm2, %zmm2
    vmovdqu 48(%rsi), %xmm3
    vinserti32x4 $1, 112(%rsi), %zmm3, %zmm3
    vinserti32x4 $2, 176(%rsi), %zmm3, %zmm3
    vinserti32x4 $3, 240(%rsi), %zmm3, %zmm3
    vmovdqu64 (%rdx), %zmm4
    vshufi32x4 $177, %zmm4, %zmm4, %zmm5
    vpxord %xmm7, %xmm7, %xmm7
    vaesenclast %zmm7, %zmm4, %zmm4
    vaesdec %zmm7, %zmm4, %zmm4
    vshufi32x4 $0, %zmm4, %zmm4, %zmm8
    vshufi32x4 $85, %zmm4, %zmm4, %zmm9
    vshufi32x4 $170, %zmm4, %zmm4, %zmm10
    vshufi32x4 $255, %zmm4, %zmm4, %zmm11
    vmovdqu64 512+AREION_SYM(vistrutahConsts)(%rip), %zmm6
    vpshufb %zmm6, %zmm5, %zmm5
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_zmm_init_done
    vmovdqu64 128+AREION_SYM(vistrutahConsts)(%rip), %zmm6
    vpshufb %zmm6, %zmm5, %zmm5
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_zmm_init_done
    vpshufb %zmm6, %zmm5, %zmm5
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_zmm_init_done
    vpshufb %zmm6, %zmm5, %zmm5
    vpshufb %zmm6, %zmm5, %zmm5
.Lv512_dec_4blk512_zmm_init_done:
    vmovdqu64 576+AREION_SYM(vistrutahConsts)(%rip), %zmm4
    vmovdqu64 448+AREION_SYM(vistrutahConsts)(%rip), %zmm6
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vpxorq %zmm12, %zmm0, %zmm0
    vpxorq %zmm13, %zmm1, %zmm1
    vpxorq %zmm14, %zmm2, %zmm2
    vpxorq %zmm15, %zmm3, %zmm3
    cmpq $10, %rcx
    je .Lv512_dec_4blk512_zmm_step4
    cmpq $12, %rcx
    je .Lv512_dec_4blk512_zmm_step5
    cmpq $14, %rcx
    je .Lv512_dec_4blk512_zmm_step6
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 112+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 96+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
.Lv512_dec_4blk512_zmm_step6:
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 80+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
.Lv512_dec_4blk512_zmm_step5:
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 64+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
.Lv512_dec_4blk512_zmm_step4:
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 48+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 32+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 16+AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vbroadcasti32x4 AREION_SYM(vistrutahRoundConstants)(%rip), %zmm13
    vpxorq %zmm13, %zmm12, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vpshufb %zmm4, %zmm0, %zmm0
    vpshufb %zmm4, %zmm1, %zmm1
    vpshufb %zmm4, %zmm2, %zmm2
    vpshufb %zmm4, %zmm3, %zmm3
    vpunpckldq %zmm2, %zmm0, %zmm12
    vpunpckhdq %zmm2, %zmm0, %zmm13
    vpunpckldq %zmm3, %zmm1, %zmm14
    vpunpckhdq %zmm3, %zmm1, %zmm15
    vpunpcklqdq %zmm14, %zmm12, %zmm0
    vpunpckhqdq %zmm14, %zmm12, %zmm1
    vpunpcklqdq %zmm15, %zmm13, %zmm2
    vpunpckhqdq %zmm15, %zmm13, %zmm3
    vaesenclast %zmm7, %zmm0, %zmm0
    vaesdec %zmm7, %zmm0, %zmm0
    vaesenclast %zmm7, %zmm1, %zmm1
    vaesdec %zmm7, %zmm1, %zmm1
    vaesenclast %zmm7, %zmm2, %zmm2
    vaesdec %zmm7, %zmm2, %zmm2
    vaesenclast %zmm7, %zmm3, %zmm3
    vaesdec %zmm7, %zmm3, %zmm3
    vaesdec %zmm8, %zmm0, %zmm0
    vaesdec %zmm9, %zmm1, %zmm1
    vaesdec %zmm10, %zmm2, %zmm2
    vaesdec %zmm11, %zmm3, %zmm3
    vpshufb %zmm6, %zmm5, %zmm5
    vshufi32x4 $0, %zmm5, %zmm5, %zmm12
    vshufi32x4 $85, %zmm5, %zmm5, %zmm13
    vshufi32x4 $170, %zmm5, %zmm5, %zmm14
    vshufi32x4 $255, %zmm5, %zmm5, %zmm15
    vaesdeclast %zmm12, %zmm0, %zmm0
    vaesdeclast %zmm13, %zmm1, %zmm1
    vaesdeclast %zmm14, %zmm2, %zmm2
    vaesdeclast %zmm15, %zmm3, %zmm3
    vmovdqu %xmm0, (%rdi)
    vextracti32x4 $1, %zmm0, 64(%rdi)
    vextracti32x4 $2, %zmm0, 128(%rdi)
    vextracti32x4 $3, %zmm0, 192(%rdi)
    vmovdqu %xmm1, 16(%rdi)
    vextracti32x4 $1, %zmm1, 80(%rdi)
    vextracti32x4 $2, %zmm1, 144(%rdi)
    vextracti32x4 $3, %zmm1, 208(%rdi)
    vmovdqu %xmm2, 32(%rdi)
    vextracti32x4 $1, %zmm2, 96(%rdi)
    vextracti32x4 $2, %zmm2, 160(%rdi)
    vextracti32x4 $3, %zmm2, 224(%rdi)
    vmovdqu %xmm3, 48(%rdi)
    vextracti32x4 $1, %zmm3, 112(%rdi)
    vextracti32x4 $2, %zmm3, 176(%rdi)
    vextracti32x4 $3, %zmm3, 240(%rdi)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    vpxord %xmm6, %xmm6, %xmm6
    vpxord %xmm7, %xmm7, %xmm7
    vpxord %xmm8, %xmm8, %xmm8
    vpxord %xmm9, %xmm9, %xmm9
    vpxord %xmm10, %xmm10, %xmm10
    vpxord %xmm11, %xmm11, %xmm11
    vpxord %xmm12, %xmm12, %xmm12
    vpxord %xmm13, %xmm13, %xmm13
    vpxord %xmm14, %xmm14, %xmm14
    vpxord %xmm15, %xmm15, %xmm15
    xorq %rdi, %rdi
    xorq %rsi, %rsi
    xorq %rdx, %rdx
    xorq %rcx, %rcx
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
    movq 0(%rsp), %rsi
    movq $0, 0(%rsp)
    movq 8(%rsp), %rdi
    movq $0, 8(%rsp)
    addq $184, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(vistrutah512Decrypt4Blocks512ZmmAsm)

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
