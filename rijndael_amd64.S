/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#if defined(__x86_64__) || defined(_M_X64)
#include "asm_abi.h"

.text

AREION_FUNC_START(rijndael256EncryptBlockAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
#else
    movq %rcx, %rax
    movq %r8, %rcx
#endif
    movdqu AREION_SYM(rijndael256Consts)(%rip), %xmm0
    movdqu 16+AREION_SYM(rijndael256Consts)(%rip), %xmm4
    movdqu (%rcx), %xmm1
    movdqu 16(%rcx), %xmm2
    movdqu (%rax), %xmm5
    pxor %xmm5, %xmm1
    movdqu 16(%rax), %xmm5
    pxor %xmm5, %xmm2
    movdqu %xmm1, %xmm3
    pblendvb %xmm0, %xmm2, %xmm3
    pblendvb %xmm0, %xmm1, %xmm2
    pshufb %xmm4, %xmm3
    pshufb %xmm4, %xmm2
    movdqu 32(%rax), %xmm5
    aesenc %xmm5, %xmm3
    movdqu 48(%rax), %xmm5
    aesenc %xmm5, %xmm2
    movdqu %xmm3, %xmm1
    pblendvb %xmm0, %xmm2, %xmm1
    pblendvb %xmm0, %xmm3, %xmm2
    pshufb %xmm4, %xmm1
    pshufb %xmm4, %xmm2
    movdqu 64(%rax), %xmm5
    aesenc %xmm5, %xmm1
    movdqu 80(%rax), %xmm5
    aesenc %xmm5, %xmm2
    movdqu %xmm1, %xmm3
    pblendvb %xmm0, %xmm2, %xmm3
    pblendvb %xmm0, %xmm1, %xmm2
    pshufb %xmm4, %xmm3
    pshufb %xmm4, %xmm2
    movdqu 96(%rax), %xmm5
    aesenc %xmm5, %xmm3
    movdqu 112(%rax), %xmm5
    aesenc %xmm5, %xmm2
    movdqu %xmm3, %xmm1
    pblendvb %xmm0, %xmm2, %xmm1
    pblendvb %xmm0, %xmm3, %xmm2
    pshufb %xmm4, %xmm1
    pshufb %xmm4, %xmm2
    movdqu 128(%rax), %xmm5
    aesenc %xmm5, %xmm1
    movdqu 144(%rax), %xmm5
    aesenc %xmm5, %xmm2
    movdqu %xmm1, %xmm3
    pblendvb %xmm0, %xmm2, %xmm3
    pblendvb %xmm0, %xmm1, %xmm2
    pshufb %xmm4, %xmm3
    pshufb %xmm4, %xmm2
    movdqu 160(%rax), %xmm5
    aesenc %xmm5, %xmm3
    movdqu 176(%rax), %xmm5
    aesenc %xmm5, %xmm2
    movdqu %xmm3, %xmm1
    pblendvb %xmm0, %xmm2, %xmm1
    pblendvb %xmm0, %xmm3, %xmm2
    pshufb %xmm4, %xmm1
    pshufb %xmm4, %xmm2
    movdqu 192(%rax), %xmm5
    aesenc %xmm5, %xmm1
    movdqu 208(%rax), %xmm5
    aesenc %xmm5, %xmm2
    movdqu %xmm1, %xmm3
    pblendvb %xmm0, %xmm2, %xmm3
    pblendvb %xmm0, %xmm1, %xmm2
    pshufb %xmm4, %xmm3
    pshufb %xmm4, %xmm2
    movdqu 224(%rax), %xmm5
    aesenc %xmm5, %xmm3
    movdqu 240(%rax), %xmm5
    aesenc %xmm5, %xmm2
    movdqu %xmm3, %xmm1
    pblendvb %xmm0, %xmm2, %xmm1
    pblendvb %xmm0, %xmm3, %xmm2
    pshufb %xmm4, %xmm1
    pshufb %xmm4, %xmm2
    movdqu 256(%rax), %xmm5
    aesenc %xmm5, %xmm1
    movdqu 272(%rax), %xmm5
    aesenc %xmm5, %xmm2
    movdqu %xmm1, %xmm3
    pblendvb %xmm0, %xmm2, %xmm3
    pblendvb %xmm0, %xmm1, %xmm2
    pshufb %xmm4, %xmm3
    pshufb %xmm4, %xmm2
    movdqu 288(%rax), %xmm5
    aesenc %xmm5, %xmm3
    movdqu 304(%rax), %xmm5
    aesenc %xmm5, %xmm2
    movdqu %xmm3, %xmm1
    pblendvb %xmm0, %xmm2, %xmm1
    pblendvb %xmm0, %xmm3, %xmm2
    pshufb %xmm4, %xmm1
    pshufb %xmm4, %xmm2
    movdqu 320(%rax), %xmm5
    aesenc %xmm5, %xmm1
    movdqu 336(%rax), %xmm5
    aesenc %xmm5, %xmm2
    movdqu %xmm1, %xmm3
    pblendvb %xmm0, %xmm2, %xmm3
    pblendvb %xmm0, %xmm1, %xmm2
    pshufb %xmm4, %xmm3
    pshufb %xmm4, %xmm2
    movdqu 352(%rax), %xmm5
    aesenc %xmm5, %xmm3
    movdqu 368(%rax), %xmm5
    aesenc %xmm5, %xmm2
    movdqu %xmm3, %xmm1
    pblendvb %xmm0, %xmm2, %xmm1
    pblendvb %xmm0, %xmm3, %xmm2
    pshufb %xmm4, %xmm1
    pshufb %xmm4, %xmm2
    movdqu 384(%rax), %xmm5
    aesenc %xmm5, %xmm1
    movdqu 400(%rax), %xmm5
    aesenc %xmm5, %xmm2
    movdqu %xmm1, %xmm3
    pblendvb %xmm0, %xmm2, %xmm3
    pblendvb %xmm0, %xmm1, %xmm2
    pshufb %xmm4, %xmm3
    pshufb %xmm4, %xmm2
    movdqu 416(%rax), %xmm5
    aesenc %xmm5, %xmm3
    movdqu 432(%rax), %xmm5
    aesenc %xmm5, %xmm2
    movdqu %xmm3, %xmm1
    pblendvb %xmm0, %xmm2, %xmm1
    pblendvb %xmm0, %xmm3, %xmm2
    pshufb %xmm4, %xmm1
    pshufb %xmm4, %xmm2
    movdqu 448(%rax), %xmm5
    aesenclast %xmm5, %xmm1
    movdqu 464(%rax), %xmm5
    aesenclast %xmm5, %xmm2
    movdqu %xmm1, (%rdx)
    movdqu %xmm2, 16(%rdx)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    xorq %rax, %rax
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    ret
AREION_FUNC_END(rijndael256EncryptBlockAsm)

AREION_FUNC_START(rijndael256DecryptBlockAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
#else
    movq %rcx, %rax
    movq %r8, %rcx
#endif
    movdqu 64+AREION_SYM(rijndael256Consts)(%rip), %xmm0
    movdqu 80+AREION_SYM(rijndael256Consts)(%rip), %xmm4
    movdqu (%rcx), %xmm1
    movdqu 16(%rcx), %xmm2
    movdqu (%rax), %xmm5
    pxor %xmm5, %xmm1
    movdqu 16(%rax), %xmm5
    pxor %xmm5, %xmm2
    movdqu %xmm1, %xmm3
    pblendvb %xmm0, %xmm2, %xmm3
    pblendvb %xmm0, %xmm1, %xmm2
    pshufb %xmm4, %xmm3
    pshufb %xmm4, %xmm2
    movdqu 32(%rax), %xmm5
    aesdec %xmm5, %xmm3
    movdqu 48(%rax), %xmm5
    aesdec %xmm5, %xmm2
    movdqu %xmm3, %xmm1
    pblendvb %xmm0, %xmm2, %xmm1
    pblendvb %xmm0, %xmm3, %xmm2
    pshufb %xmm4, %xmm1
    pshufb %xmm4, %xmm2
    movdqu 64(%rax), %xmm5
    aesdec %xmm5, %xmm1
    movdqu 80(%rax), %xmm5
    aesdec %xmm5, %xmm2
    movdqu %xmm1, %xmm3
    pblendvb %xmm0, %xmm2, %xmm3
    pblendvb %xmm0, %xmm1, %xmm2
    pshufb %xmm4, %xmm3
    pshufb %xmm4, %xmm2
    movdqu 96(%rax), %xmm5
    aesdec %xmm5, %xmm3
    movdqu 112(%rax), %xmm5
    aesdec %xmm5, %xmm2
    movdqu %xmm3, %xmm1
    pblendvb %xmm0, %xmm2, %xmm1
    pblendvb %xmm0, %xmm3, %xmm2
    pshufb %xmm4, %xmm1
    pshufb %xmm4, %xmm2
    movdqu 128(%rax), %xmm5
    aesdec %xmm5, %xmm1
    movdqu 144(%rax), %xmm5
    aesdec %xmm5, %xmm2
    movdqu %xmm1, %xmm3
    pblendvb %xmm0, %xmm2, %xmm3
    pblendvb %xmm0, %xmm1, %xmm2
    pshufb %xmm4, %xmm3
    pshufb %xmm4, %xmm2
    movdqu 160(%rax), %xmm5
    aesdec %xmm5, %xmm3
    movdqu 176(%rax), %xmm5
    aesdec %xmm5, %xmm2
    movdqu %xmm3, %xmm1
    pblendvb %xmm0, %xmm2, %xmm1
    pblendvb %xmm0, %xmm3, %xmm2
    pshufb %xmm4, %xmm1
    pshufb %xmm4, %xmm2
    movdqu 192(%rax), %xmm5
    aesdec %xmm5, %xmm1
    movdqu 208(%rax), %xmm5
    aesdec %xmm5, %xmm2
    movdqu %xmm1, %xmm3
    pblendvb %xmm0, %xmm2, %xmm3
    pblendvb %xmm0, %xmm1, %xmm2
    pshufb %xmm4, %xmm3
    pshufb %xmm4, %xmm2
    movdqu 224(%rax), %xmm5
    aesdec %xmm5, %xmm3
    movdqu 240(%rax), %xmm5
    aesdec %xmm5, %xmm2
    movdqu %xmm3, %xmm1
    pblendvb %xmm0, %xmm2, %xmm1
    pblendvb %xmm0, %xmm3, %xmm2
    pshufb %xmm4, %xmm1
    pshufb %xmm4, %xmm2
    movdqu 256(%rax), %xmm5
    aesdec %xmm5, %xmm1
    movdqu 272(%rax), %xmm5
    aesdec %xmm5, %xmm2
    movdqu %xmm1, %xmm3
    pblendvb %xmm0, %xmm2, %xmm3
    pblendvb %xmm0, %xmm1, %xmm2
    pshufb %xmm4, %xmm3
    pshufb %xmm4, %xmm2
    movdqu 288(%rax), %xmm5
    aesdec %xmm5, %xmm3
    movdqu 304(%rax), %xmm5
    aesdec %xmm5, %xmm2
    movdqu %xmm3, %xmm1
    pblendvb %xmm0, %xmm2, %xmm1
    pblendvb %xmm0, %xmm3, %xmm2
    pshufb %xmm4, %xmm1
    pshufb %xmm4, %xmm2
    movdqu 320(%rax), %xmm5
    aesdec %xmm5, %xmm1
    movdqu 336(%rax), %xmm5
    aesdec %xmm5, %xmm2
    movdqu %xmm1, %xmm3
    pblendvb %xmm0, %xmm2, %xmm3
    pblendvb %xmm0, %xmm1, %xmm2
    pshufb %xmm4, %xmm3
    pshufb %xmm4, %xmm2
    movdqu 352(%rax), %xmm5
    aesdec %xmm5, %xmm3
    movdqu 368(%rax), %xmm5
    aesdec %xmm5, %xmm2
    movdqu %xmm3, %xmm1
    pblendvb %xmm0, %xmm2, %xmm1
    pblendvb %xmm0, %xmm3, %xmm2
    pshufb %xmm4, %xmm1
    pshufb %xmm4, %xmm2
    movdqu 384(%rax), %xmm5
    aesdec %xmm5, %xmm1
    movdqu 400(%rax), %xmm5
    aesdec %xmm5, %xmm2
    movdqu %xmm1, %xmm3
    pblendvb %xmm0, %xmm2, %xmm3
    pblendvb %xmm0, %xmm1, %xmm2
    pshufb %xmm4, %xmm3
    pshufb %xmm4, %xmm2
    movdqu 416(%rax), %xmm5
    aesdec %xmm5, %xmm3
    movdqu 432(%rax), %xmm5
    aesdec %xmm5, %xmm2
    movdqu %xmm3, %xmm1
    pblendvb %xmm0, %xmm2, %xmm1
    pblendvb %xmm0, %xmm3, %xmm2
    pshufb %xmm4, %xmm1
    pshufb %xmm4, %xmm2
    movdqu 448(%rax), %xmm5
    aesdeclast %xmm5, %xmm1
    movdqu 464(%rax), %xmm5
    aesdeclast %xmm5, %xmm2
    movdqu %xmm1, (%rdx)
    movdqu %xmm2, 16(%rdx)
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    pxor %xmm2, %xmm2
    pxor %xmm3, %xmm3
    pxor %xmm4, %xmm4
    pxor %xmm5, %xmm5
    xorq %rax, %rax
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    ret
AREION_FUNC_END(rijndael256DecryptBlockAsm)

AREION_FUNC_START(rijndael256EncryptBlockVexAsm)
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
    vmovdqu AREION_SYM(rijndael256Consts)(%rip), %xmm3
    vmovdqu 16+AREION_SYM(rijndael256Consts)(%rip), %xmm4
    vmovdqu (%rax), %xmm5
    vpxor %xmm5, %xmm0, %xmm0
    vmovdqu 16(%rax), %xmm5
    vpxor %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 32(%rax), %xmm5
    vaesenc %xmm5, %xmm0, %xmm0
    vmovdqu 48(%rax), %xmm5
    vaesenc %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 64(%rax), %xmm5
    vaesenc %xmm5, %xmm0, %xmm0
    vmovdqu 80(%rax), %xmm5
    vaesenc %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 96(%rax), %xmm5
    vaesenc %xmm5, %xmm0, %xmm0
    vmovdqu 112(%rax), %xmm5
    vaesenc %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 128(%rax), %xmm5
    vaesenc %xmm5, %xmm0, %xmm0
    vmovdqu 144(%rax), %xmm5
    vaesenc %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 160(%rax), %xmm5
    vaesenc %xmm5, %xmm0, %xmm0
    vmovdqu 176(%rax), %xmm5
    vaesenc %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 192(%rax), %xmm5
    vaesenc %xmm5, %xmm0, %xmm0
    vmovdqu 208(%rax), %xmm5
    vaesenc %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 224(%rax), %xmm5
    vaesenc %xmm5, %xmm0, %xmm0
    vmovdqu 240(%rax), %xmm5
    vaesenc %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 256(%rax), %xmm5
    vaesenc %xmm5, %xmm0, %xmm0
    vmovdqu 272(%rax), %xmm5
    vaesenc %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 288(%rax), %xmm5
    vaesenc %xmm5, %xmm0, %xmm0
    vmovdqu 304(%rax), %xmm5
    vaesenc %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 320(%rax), %xmm5
    vaesenc %xmm5, %xmm0, %xmm0
    vmovdqu 336(%rax), %xmm5
    vaesenc %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 352(%rax), %xmm5
    vaesenc %xmm5, %xmm0, %xmm0
    vmovdqu 368(%rax), %xmm5
    vaesenc %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 384(%rax), %xmm5
    vaesenc %xmm5, %xmm0, %xmm0
    vmovdqu 400(%rax), %xmm5
    vaesenc %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 416(%rax), %xmm5
    vaesenc %xmm5, %xmm0, %xmm0
    vmovdqu 432(%rax), %xmm5
    vaesenc %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 448(%rax), %xmm5
    vaesenclast %xmm5, %xmm0, %xmm0
    vmovdqu 464(%rax), %xmm5
    vaesenclast %xmm5, %xmm1, %xmm1
    vmovdqu %xmm0, (%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    xorq %rax, %rax
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    ret
AREION_FUNC_END(rijndael256EncryptBlockVexAsm)

AREION_FUNC_START(rijndael256DecryptBlockVexAsm)
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
    vmovdqu 64+AREION_SYM(rijndael256Consts)(%rip), %xmm3
    vmovdqu 80+AREION_SYM(rijndael256Consts)(%rip), %xmm4
    vmovdqu (%rax), %xmm5
    vpxor %xmm5, %xmm0, %xmm0
    vmovdqu 16(%rax), %xmm5
    vpxor %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 32(%rax), %xmm5
    vaesdec %xmm5, %xmm0, %xmm0
    vmovdqu 48(%rax), %xmm5
    vaesdec %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 64(%rax), %xmm5
    vaesdec %xmm5, %xmm0, %xmm0
    vmovdqu 80(%rax), %xmm5
    vaesdec %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 96(%rax), %xmm5
    vaesdec %xmm5, %xmm0, %xmm0
    vmovdqu 112(%rax), %xmm5
    vaesdec %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 128(%rax), %xmm5
    vaesdec %xmm5, %xmm0, %xmm0
    vmovdqu 144(%rax), %xmm5
    vaesdec %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 160(%rax), %xmm5
    vaesdec %xmm5, %xmm0, %xmm0
    vmovdqu 176(%rax), %xmm5
    vaesdec %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 192(%rax), %xmm5
    vaesdec %xmm5, %xmm0, %xmm0
    vmovdqu 208(%rax), %xmm5
    vaesdec %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 224(%rax), %xmm5
    vaesdec %xmm5, %xmm0, %xmm0
    vmovdqu 240(%rax), %xmm5
    vaesdec %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 256(%rax), %xmm5
    vaesdec %xmm5, %xmm0, %xmm0
    vmovdqu 272(%rax), %xmm5
    vaesdec %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 288(%rax), %xmm5
    vaesdec %xmm5, %xmm0, %xmm0
    vmovdqu 304(%rax), %xmm5
    vaesdec %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 320(%rax), %xmm5
    vaesdec %xmm5, %xmm0, %xmm0
    vmovdqu 336(%rax), %xmm5
    vaesdec %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 352(%rax), %xmm5
    vaesdec %xmm5, %xmm0, %xmm0
    vmovdqu 368(%rax), %xmm5
    vaesdec %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 384(%rax), %xmm5
    vaesdec %xmm5, %xmm0, %xmm0
    vmovdqu 400(%rax), %xmm5
    vaesdec %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 416(%rax), %xmm5
    vaesdec %xmm5, %xmm0, %xmm0
    vmovdqu 432(%rax), %xmm5
    vaesdec %xmm5, %xmm1, %xmm1
    vpblendvb %xmm3, %xmm1, %xmm0, %xmm2
    vpblendvb %xmm3, %xmm0, %xmm1, %xmm1
    vpshufb %xmm4, %xmm2, %xmm0
    vpshufb %xmm4, %xmm1, %xmm1
    vmovdqu 448(%rax), %xmm5
    vaesdeclast %xmm5, %xmm0, %xmm0
    vmovdqu 464(%rax), %xmm5
    vaesdeclast %xmm5, %xmm1, %xmm1
    vmovdqu %xmm0, (%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vpxor %xmm0, %xmm0, %xmm0
    vpxor %xmm1, %xmm1, %xmm1
    vpxor %xmm2, %xmm2, %xmm2
    vpxor %xmm3, %xmm3, %xmm3
    vpxor %xmm4, %xmm4, %xmm4
    vpxor %xmm5, %xmm5, %xmm5
    xorq %rax, %rax
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    ret
AREION_FUNC_END(rijndael256DecryptBlockVexAsm)

AREION_FUNC_START(rijndael256Encrypt4BlocksZmmAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
#else
    movq %rcx, %rax
    movq %r8, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vinserti32x4 $1, 32(%rcx), %zmm0, %zmm0
    vinserti32x4 $2, 64(%rcx), %zmm0, %zmm0
    vinserti32x4 $3, 96(%rcx), %zmm0, %zmm0
    vmovdqu 16(%rcx), %xmm1
    vinserti32x4 $1, 48(%rcx), %zmm1, %zmm1
    vinserti32x4 $2, 80(%rcx), %zmm1, %zmm1
    vinserti32x4 $3, 112(%rcx), %zmm1, %zmm1
    vbroadcasti32x4 AREION_SYM(rijndael256Consts)(%rip), %zmm4
    vbroadcasti32x4 16+AREION_SYM(rijndael256Consts)(%rip), %zmm5
    vbroadcasti32x4 (%rax), %zmm3
    vpxorq %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 16(%rax), %zmm3
    vpxorq %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 32(%rax), %zmm3
    vaesenc %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 48(%rax), %zmm3
    vaesenc %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 64(%rax), %zmm3
    vaesenc %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 80(%rax), %zmm3
    vaesenc %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 96(%rax), %zmm3
    vaesenc %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 112(%rax), %zmm3
    vaesenc %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 128(%rax), %zmm3
    vaesenc %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 144(%rax), %zmm3
    vaesenc %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 160(%rax), %zmm3
    vaesenc %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 176(%rax), %zmm3
    vaesenc %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 192(%rax), %zmm3
    vaesenc %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 208(%rax), %zmm3
    vaesenc %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 224(%rax), %zmm3
    vaesenc %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 240(%rax), %zmm3
    vaesenc %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 256(%rax), %zmm3
    vaesenc %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 272(%rax), %zmm3
    vaesenc %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 288(%rax), %zmm3
    vaesenc %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 304(%rax), %zmm3
    vaesenc %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 320(%rax), %zmm3
    vaesenc %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 336(%rax), %zmm3
    vaesenc %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 352(%rax), %zmm3
    vaesenc %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 368(%rax), %zmm3
    vaesenc %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 384(%rax), %zmm3
    vaesenc %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 400(%rax), %zmm3
    vaesenc %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 416(%rax), %zmm3
    vaesenc %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 432(%rax), %zmm3
    vaesenc %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 448(%rax), %zmm3
    vaesenclast %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 464(%rax), %zmm3
    vaesenclast %zmm3, %zmm1, %zmm1
    vmovdqu %xmm0, (%rdx)
    vextracti32x4 $1, %zmm0, 32(%rdx)
    vextracti32x4 $2, %zmm0, 64(%rdx)
    vextracti32x4 $3, %zmm0, 96(%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vextracti32x4 $1, %zmm1, 48(%rdx)
    vextracti32x4 $2, %zmm1, 80(%rdx)
    vextracti32x4 $3, %zmm1, 112(%rdx)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    xorq %rax, %rax
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    vzeroupper
    ret
AREION_FUNC_END(rijndael256Encrypt4BlocksZmmAsm)

AREION_FUNC_START(rijndael256Decrypt4BlocksZmmAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
#else
    movq %rcx, %rax
    movq %r8, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vinserti32x4 $1, 32(%rcx), %zmm0, %zmm0
    vinserti32x4 $2, 64(%rcx), %zmm0, %zmm0
    vinserti32x4 $3, 96(%rcx), %zmm0, %zmm0
    vmovdqu 16(%rcx), %xmm1
    vinserti32x4 $1, 48(%rcx), %zmm1, %zmm1
    vinserti32x4 $2, 80(%rcx), %zmm1, %zmm1
    vinserti32x4 $3, 112(%rcx), %zmm1, %zmm1
    vbroadcasti32x4 64+AREION_SYM(rijndael256Consts)(%rip), %zmm4
    vbroadcasti32x4 80+AREION_SYM(rijndael256Consts)(%rip), %zmm5
    vbroadcasti32x4 (%rax), %zmm3
    vpxorq %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 16(%rax), %zmm3
    vpxorq %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 32(%rax), %zmm3
    vaesdec %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 48(%rax), %zmm3
    vaesdec %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 64(%rax), %zmm3
    vaesdec %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 80(%rax), %zmm3
    vaesdec %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 96(%rax), %zmm3
    vaesdec %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 112(%rax), %zmm3
    vaesdec %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 128(%rax), %zmm3
    vaesdec %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 144(%rax), %zmm3
    vaesdec %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 160(%rax), %zmm3
    vaesdec %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 176(%rax), %zmm3
    vaesdec %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 192(%rax), %zmm3
    vaesdec %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 208(%rax), %zmm3
    vaesdec %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 224(%rax), %zmm3
    vaesdec %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 240(%rax), %zmm3
    vaesdec %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 256(%rax), %zmm3
    vaesdec %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 272(%rax), %zmm3
    vaesdec %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 288(%rax), %zmm3
    vaesdec %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 304(%rax), %zmm3
    vaesdec %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 320(%rax), %zmm3
    vaesdec %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 336(%rax), %zmm3
    vaesdec %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 352(%rax), %zmm3
    vaesdec %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 368(%rax), %zmm3
    vaesdec %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 384(%rax), %zmm3
    vaesdec %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 400(%rax), %zmm3
    vaesdec %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 416(%rax), %zmm3
    vaesdec %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 432(%rax), %zmm3
    vaesdec %zmm3, %zmm1, %zmm1
    vmovdqu64 %zmm0, %zmm2
    vpternlogq $184, %zmm1, %zmm4, %zmm2
    vpternlogq $184, %zmm0, %zmm4, %zmm1
    vpshufb %zmm5, %zmm2, %zmm0
    vpshufb %zmm5, %zmm1, %zmm1
    vbroadcasti32x4 448(%rax), %zmm3
    vaesdeclast %zmm3, %zmm0, %zmm0
    vbroadcasti32x4 464(%rax), %zmm3
    vaesdeclast %zmm3, %zmm1, %zmm1
    vmovdqu %xmm0, (%rdx)
    vextracti32x4 $1, %zmm0, 32(%rdx)
    vextracti32x4 $2, %zmm0, 64(%rdx)
    vextracti32x4 $3, %zmm0, 96(%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vextracti32x4 $1, %zmm1, 48(%rdx)
    vextracti32x4 $2, %zmm1, 80(%rdx)
    vextracti32x4 $3, %zmm1, 112(%rdx)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    xorq %rax, %rax
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    vzeroupper
    ret
AREION_FUNC_END(rijndael256Decrypt4BlocksZmmAsm)

AREION_FUNC_START(rijndael256Encrypt4BlocksYmmAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
#else
    subq $72, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm7, 16(%rsp)
    vmovdqu %xmm8, 32(%rsp)
    vmovdqu %xmm9, 48(%rsp)
    movq %rcx, %rax
    movq %r8, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vinserti128 $1, 32(%rcx), %ymm0, %ymm0
    vmovdqu 16(%rcx), %xmm1
    vinserti128 $1, 48(%rcx), %ymm1, %ymm1
    vmovdqu 64(%rcx), %xmm2
    vinserti128 $1, 96(%rcx), %ymm2, %ymm2
    vmovdqu 80(%rcx), %xmm3
    vinserti128 $1, 112(%rcx), %ymm3, %ymm3
    vbroadcasti128 AREION_SYM(rijndael256Consts)(%rip), %ymm8
    vbroadcasti128 16+AREION_SYM(rijndael256Consts)(%rip), %ymm9
    vbroadcasti128 (%rax), %ymm4
    vbroadcasti128 16(%rax), %ymm5
    vpxor %ymm4, %ymm0, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vpxor %ymm4, %ymm2, %ymm2
    vpxor %ymm5, %ymm3, %ymm3
    vbroadcasti128 32(%rax), %ymm4
    vbroadcasti128 48(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm5, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm5, %ymm3, %ymm3
    vbroadcasti128 64(%rax), %ymm4
    vbroadcasti128 80(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm5, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm5, %ymm3, %ymm3
    vbroadcasti128 96(%rax), %ymm4
    vbroadcasti128 112(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm5, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm5, %ymm3, %ymm3
    vbroadcasti128 128(%rax), %ymm4
    vbroadcasti128 144(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm5, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm5, %ymm3, %ymm3
    vbroadcasti128 160(%rax), %ymm4
    vbroadcasti128 176(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm5, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm5, %ymm3, %ymm3
    vbroadcasti128 192(%rax), %ymm4
    vbroadcasti128 208(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm5, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm5, %ymm3, %ymm3
    vbroadcasti128 224(%rax), %ymm4
    vbroadcasti128 240(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm5, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm5, %ymm3, %ymm3
    vbroadcasti128 256(%rax), %ymm4
    vbroadcasti128 272(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm5, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm5, %ymm3, %ymm3
    vbroadcasti128 288(%rax), %ymm4
    vbroadcasti128 304(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm5, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm5, %ymm3, %ymm3
    vbroadcasti128 320(%rax), %ymm4
    vbroadcasti128 336(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm5, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm5, %ymm3, %ymm3
    vbroadcasti128 352(%rax), %ymm4
    vbroadcasti128 368(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm5, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm5, %ymm3, %ymm3
    vbroadcasti128 384(%rax), %ymm4
    vbroadcasti128 400(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm5, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm5, %ymm3, %ymm3
    vbroadcasti128 416(%rax), %ymm4
    vbroadcasti128 432(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesenc %ymm4, %ymm0, %ymm0
    vaesenc %ymm5, %ymm1, %ymm1
    vaesenc %ymm4, %ymm2, %ymm2
    vaesenc %ymm5, %ymm3, %ymm3
    vbroadcasti128 448(%rax), %ymm4
    vbroadcasti128 464(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesenclast %ymm4, %ymm0, %ymm0
    vaesenclast %ymm5, %ymm1, %ymm1
    vaesenclast %ymm4, %ymm2, %ymm2
    vaesenclast %ymm5, %ymm3, %ymm3
    vmovdqu %xmm0, (%rdx)
    vextracti128 $1, %ymm0, 32(%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vextracti128 $1, %ymm1, 48(%rdx)
    vmovdqu %xmm2, 64(%rdx)
    vextracti128 $1, %ymm2, 96(%rdx)
    vmovdqu %xmm3, 80(%rdx)
    vextracti128 $1, %ymm3, 112(%rdx)
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
    xorq %rax, %rax
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
    addq $72, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(rijndael256Encrypt4BlocksYmmAsm)

AREION_FUNC_START(rijndael256Decrypt4BlocksYmmAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
#else
    subq $72, %rsp
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm7, 16(%rsp)
    vmovdqu %xmm8, 32(%rsp)
    vmovdqu %xmm9, 48(%rsp)
    movq %rcx, %rax
    movq %r8, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vinserti128 $1, 32(%rcx), %ymm0, %ymm0
    vmovdqu 16(%rcx), %xmm1
    vinserti128 $1, 48(%rcx), %ymm1, %ymm1
    vmovdqu 64(%rcx), %xmm2
    vinserti128 $1, 96(%rcx), %ymm2, %ymm2
    vmovdqu 80(%rcx), %xmm3
    vinserti128 $1, 112(%rcx), %ymm3, %ymm3
    vbroadcasti128 64+AREION_SYM(rijndael256Consts)(%rip), %ymm8
    vbroadcasti128 80+AREION_SYM(rijndael256Consts)(%rip), %ymm9
    vbroadcasti128 (%rax), %ymm4
    vbroadcasti128 16(%rax), %ymm5
    vpxor %ymm4, %ymm0, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vpxor %ymm4, %ymm2, %ymm2
    vpxor %ymm5, %ymm3, %ymm3
    vbroadcasti128 32(%rax), %ymm4
    vbroadcasti128 48(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm5, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm5, %ymm3, %ymm3
    vbroadcasti128 64(%rax), %ymm4
    vbroadcasti128 80(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm5, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm5, %ymm3, %ymm3
    vbroadcasti128 96(%rax), %ymm4
    vbroadcasti128 112(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm5, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm5, %ymm3, %ymm3
    vbroadcasti128 128(%rax), %ymm4
    vbroadcasti128 144(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm5, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm5, %ymm3, %ymm3
    vbroadcasti128 160(%rax), %ymm4
    vbroadcasti128 176(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm5, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm5, %ymm3, %ymm3
    vbroadcasti128 192(%rax), %ymm4
    vbroadcasti128 208(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm5, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm5, %ymm3, %ymm3
    vbroadcasti128 224(%rax), %ymm4
    vbroadcasti128 240(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm5, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm5, %ymm3, %ymm3
    vbroadcasti128 256(%rax), %ymm4
    vbroadcasti128 272(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm5, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm5, %ymm3, %ymm3
    vbroadcasti128 288(%rax), %ymm4
    vbroadcasti128 304(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm5, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm5, %ymm3, %ymm3
    vbroadcasti128 320(%rax), %ymm4
    vbroadcasti128 336(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm5, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm5, %ymm3, %ymm3
    vbroadcasti128 352(%rax), %ymm4
    vbroadcasti128 368(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm5, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm5, %ymm3, %ymm3
    vbroadcasti128 384(%rax), %ymm4
    vbroadcasti128 400(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm5, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm5, %ymm3, %ymm3
    vbroadcasti128 416(%rax), %ymm4
    vbroadcasti128 432(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesdec %ymm4, %ymm0, %ymm0
    vaesdec %ymm5, %ymm1, %ymm1
    vaesdec %ymm4, %ymm2, %ymm2
    vaesdec %ymm5, %ymm3, %ymm3
    vbroadcasti128 448(%rax), %ymm4
    vbroadcasti128 464(%rax), %ymm5
    vpblendvb %ymm8, %ymm1, %ymm0, %ymm6
    vpblendvb %ymm8, %ymm0, %ymm1, %ymm1
    vpblendvb %ymm8, %ymm3, %ymm2, %ymm7
    vpblendvb %ymm8, %ymm2, %ymm3, %ymm3
    vpshufb %ymm9, %ymm6, %ymm0
    vpshufb %ymm9, %ymm1, %ymm1
    vpshufb %ymm9, %ymm7, %ymm2
    vpshufb %ymm9, %ymm3, %ymm3
    vaesdeclast %ymm4, %ymm0, %ymm0
    vaesdeclast %ymm5, %ymm1, %ymm1
    vaesdeclast %ymm4, %ymm2, %ymm2
    vaesdeclast %ymm5, %ymm3, %ymm3
    vmovdqu %xmm0, (%rdx)
    vextracti128 $1, %ymm0, 32(%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vextracti128 $1, %ymm1, 48(%rdx)
    vmovdqu %xmm2, 64(%rdx)
    vextracti128 $1, %ymm2, 96(%rdx)
    vmovdqu %xmm3, 80(%rdx)
    vextracti128 $1, %ymm3, 112(%rdx)
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
    xorq %rax, %rax
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
    addq $72, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(rijndael256Decrypt4BlocksYmmAsm)

AREION_FUNC_START(rijndael256Encrypt4BlocksVexAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
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
    movq %r8, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vmovdqu 16(%rcx), %xmm1
    vmovdqu 32(%rcx), %xmm2
    vmovdqu 48(%rcx), %xmm3
    vmovdqu 64(%rcx), %xmm4
    vmovdqu 80(%rcx), %xmm5
    vmovdqu 96(%rcx), %xmm6
    vmovdqu 112(%rcx), %xmm7
    vmovdqu AREION_SYM(rijndael256Consts)(%rip), %xmm8
    vmovdqu 16+AREION_SYM(rijndael256Consts)(%rip), %xmm9
    vmovdqu (%rax), %xmm10
    vmovdqu 16(%rax), %xmm11
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm10, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm10, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    vmovdqu 32(%rax), %xmm10
    vmovdqu 48(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesenc %xmm10, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesenc %xmm10, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesenc %xmm10, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesenc %xmm10, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vmovdqu 64(%rax), %xmm10
    vmovdqu 80(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesenc %xmm10, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesenc %xmm10, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesenc %xmm10, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesenc %xmm10, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vmovdqu 96(%rax), %xmm10
    vmovdqu 112(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesenc %xmm10, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesenc %xmm10, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesenc %xmm10, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesenc %xmm10, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vmovdqu 128(%rax), %xmm10
    vmovdqu 144(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesenc %xmm10, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesenc %xmm10, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesenc %xmm10, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesenc %xmm10, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vmovdqu 160(%rax), %xmm10
    vmovdqu 176(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesenc %xmm10, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesenc %xmm10, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesenc %xmm10, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesenc %xmm10, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vmovdqu 192(%rax), %xmm10
    vmovdqu 208(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesenc %xmm10, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesenc %xmm10, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesenc %xmm10, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesenc %xmm10, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vmovdqu 224(%rax), %xmm10
    vmovdqu 240(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesenc %xmm10, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesenc %xmm10, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesenc %xmm10, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesenc %xmm10, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vmovdqu 256(%rax), %xmm10
    vmovdqu 272(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesenc %xmm10, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesenc %xmm10, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesenc %xmm10, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesenc %xmm10, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vmovdqu 288(%rax), %xmm10
    vmovdqu 304(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesenc %xmm10, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesenc %xmm10, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesenc %xmm10, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesenc %xmm10, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vmovdqu 320(%rax), %xmm10
    vmovdqu 336(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesenc %xmm10, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesenc %xmm10, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesenc %xmm10, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesenc %xmm10, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vmovdqu 352(%rax), %xmm10
    vmovdqu 368(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesenc %xmm10, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesenc %xmm10, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesenc %xmm10, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesenc %xmm10, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vmovdqu 384(%rax), %xmm10
    vmovdqu 400(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesenc %xmm10, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesenc %xmm10, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesenc %xmm10, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesenc %xmm10, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vmovdqu 416(%rax), %xmm10
    vmovdqu 432(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesenc %xmm10, %xmm0, %xmm0
    vaesenc %xmm11, %xmm1, %xmm1
    vaesenc %xmm10, %xmm2, %xmm2
    vaesenc %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesenc %xmm10, %xmm4, %xmm4
    vaesenc %xmm11, %xmm5, %xmm5
    vaesenc %xmm10, %xmm6, %xmm6
    vaesenc %xmm11, %xmm7, %xmm7
    vmovdqu 448(%rax), %xmm10
    vmovdqu 464(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesenclast %xmm10, %xmm0, %xmm0
    vaesenclast %xmm11, %xmm1, %xmm1
    vaesenclast %xmm10, %xmm2, %xmm2
    vaesenclast %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesenclast %xmm10, %xmm4, %xmm4
    vaesenclast %xmm11, %xmm5, %xmm5
    vaesenclast %xmm10, %xmm6, %xmm6
    vaesenclast %xmm11, %xmm7, %xmm7
    vmovdqu %xmm0, (%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vmovdqu %xmm2, 32(%rdx)
    vmovdqu %xmm3, 48(%rdx)
    vmovdqu %xmm4, 64(%rdx)
    vmovdqu %xmm5, 80(%rdx)
    vmovdqu %xmm6, 96(%rdx)
    vmovdqu %xmm7, 112(%rdx)
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
    addq $136, %rsp
#endif
    ret
AREION_FUNC_END(rijndael256Encrypt4BlocksVexAsm)

AREION_FUNC_START(rijndael256Decrypt4BlocksVexAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
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
    movq %r8, %rcx
#endif
    vmovdqu (%rcx), %xmm0
    vmovdqu 16(%rcx), %xmm1
    vmovdqu 32(%rcx), %xmm2
    vmovdqu 48(%rcx), %xmm3
    vmovdqu 64(%rcx), %xmm4
    vmovdqu 80(%rcx), %xmm5
    vmovdqu 96(%rcx), %xmm6
    vmovdqu 112(%rcx), %xmm7
    vmovdqu 64+AREION_SYM(rijndael256Consts)(%rip), %xmm8
    vmovdqu 80+AREION_SYM(rijndael256Consts)(%rip), %xmm9
    vmovdqu (%rax), %xmm10
    vmovdqu 16(%rax), %xmm11
    vpxor %xmm10, %xmm0, %xmm0
    vpxor %xmm11, %xmm1, %xmm1
    vpxor %xmm10, %xmm2, %xmm2
    vpxor %xmm11, %xmm3, %xmm3
    vpxor %xmm10, %xmm4, %xmm4
    vpxor %xmm11, %xmm5, %xmm5
    vpxor %xmm10, %xmm6, %xmm6
    vpxor %xmm11, %xmm7, %xmm7
    vmovdqu 32(%rax), %xmm10
    vmovdqu 48(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vmovdqu 64(%rax), %xmm10
    vmovdqu 80(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vmovdqu 96(%rax), %xmm10
    vmovdqu 112(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vmovdqu 128(%rax), %xmm10
    vmovdqu 144(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vmovdqu 160(%rax), %xmm10
    vmovdqu 176(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vmovdqu 192(%rax), %xmm10
    vmovdqu 208(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vmovdqu 224(%rax), %xmm10
    vmovdqu 240(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vmovdqu 256(%rax), %xmm10
    vmovdqu 272(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vmovdqu 288(%rax), %xmm10
    vmovdqu 304(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vmovdqu 320(%rax), %xmm10
    vmovdqu 336(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vmovdqu 352(%rax), %xmm10
    vmovdqu 368(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vmovdqu 384(%rax), %xmm10
    vmovdqu 400(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vmovdqu 416(%rax), %xmm10
    vmovdqu 432(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesdec %xmm10, %xmm0, %xmm0
    vaesdec %xmm11, %xmm1, %xmm1
    vaesdec %xmm10, %xmm2, %xmm2
    vaesdec %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesdec %xmm10, %xmm4, %xmm4
    vaesdec %xmm11, %xmm5, %xmm5
    vaesdec %xmm10, %xmm6, %xmm6
    vaesdec %xmm11, %xmm7, %xmm7
    vmovdqu 448(%rax), %xmm10
    vmovdqu 464(%rax), %xmm11
    vpblendvb %xmm8, %xmm1, %xmm0, %xmm12
    vpblendvb %xmm8, %xmm0, %xmm1, %xmm1
    vpblendvb %xmm8, %xmm3, %xmm2, %xmm13
    vpblendvb %xmm8, %xmm2, %xmm3, %xmm3
    vpshufb %xmm9, %xmm12, %xmm0
    vpshufb %xmm9, %xmm1, %xmm1
    vpshufb %xmm9, %xmm13, %xmm2
    vpshufb %xmm9, %xmm3, %xmm3
    vaesdeclast %xmm10, %xmm0, %xmm0
    vaesdeclast %xmm11, %xmm1, %xmm1
    vaesdeclast %xmm10, %xmm2, %xmm2
    vaesdeclast %xmm11, %xmm3, %xmm3
    vpblendvb %xmm8, %xmm5, %xmm4, %xmm12
    vpblendvb %xmm8, %xmm4, %xmm5, %xmm5
    vpblendvb %xmm8, %xmm7, %xmm6, %xmm13
    vpblendvb %xmm8, %xmm6, %xmm7, %xmm7
    vpshufb %xmm9, %xmm12, %xmm4
    vpshufb %xmm9, %xmm5, %xmm5
    vpshufb %xmm9, %xmm13, %xmm6
    vpshufb %xmm9, %xmm7, %xmm7
    vaesdeclast %xmm10, %xmm4, %xmm4
    vaesdeclast %xmm11, %xmm5, %xmm5
    vaesdeclast %xmm10, %xmm6, %xmm6
    vaesdeclast %xmm11, %xmm7, %xmm7
    vmovdqu %xmm0, (%rdx)
    vmovdqu %xmm1, 16(%rdx)
    vmovdqu %xmm2, 32(%rdx)
    vmovdqu %xmm3, 48(%rdx)
    vmovdqu %xmm4, 64(%rdx)
    vmovdqu %xmm5, 80(%rdx)
    vmovdqu %xmm6, 96(%rdx)
    vmovdqu %xmm7, 112(%rdx)
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
    addq $136, %rsp
#endif
    ret
AREION_FUNC_END(rijndael256Decrypt4BlocksVexAsm)

AREION_FUNC_START(rijndael256Encrypt4BlocksAesNiAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
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
    movq %r8, %rcx
#endif
    movdqu AREION_SYM(rijndael256Consts)(%rip), %xmm0
    movdqu 16+AREION_SYM(rijndael256Consts)(%rip), %xmm9
    movdqu (%rcx), %xmm1
    movdqu 16(%rcx), %xmm2
    movdqu 32(%rcx), %xmm3
    movdqu 48(%rcx), %xmm4
    movdqu 64(%rcx), %xmm5
    movdqu 80(%rcx), %xmm6
    movdqu 96(%rcx), %xmm7
    movdqu 112(%rcx), %xmm8
    movdqu (%rax), %xmm10
    movdqu 16(%rax), %xmm11
    pxor %xmm10, %xmm1
    pxor %xmm11, %xmm2
    pxor %xmm10, %xmm3
    pxor %xmm11, %xmm4
    pxor %xmm10, %xmm5
    pxor %xmm11, %xmm6
    pxor %xmm10, %xmm7
    pxor %xmm11, %xmm8
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesenc %xmm10, %xmm1
    aesenc %xmm11, %xmm2
    aesenc %xmm10, %xmm3
    aesenc %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesenc %xmm10, %xmm5
    aesenc %xmm11, %xmm6
    aesenc %xmm10, %xmm7
    aesenc %xmm11, %xmm8
    movdqu 64(%rax), %xmm10
    movdqu 80(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesenc %xmm10, %xmm1
    aesenc %xmm11, %xmm2
    aesenc %xmm10, %xmm3
    aesenc %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesenc %xmm10, %xmm5
    aesenc %xmm11, %xmm6
    aesenc %xmm10, %xmm7
    aesenc %xmm11, %xmm8
    movdqu 96(%rax), %xmm10
    movdqu 112(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesenc %xmm10, %xmm1
    aesenc %xmm11, %xmm2
    aesenc %xmm10, %xmm3
    aesenc %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesenc %xmm10, %xmm5
    aesenc %xmm11, %xmm6
    aesenc %xmm10, %xmm7
    aesenc %xmm11, %xmm8
    movdqu 128(%rax), %xmm10
    movdqu 144(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesenc %xmm10, %xmm1
    aesenc %xmm11, %xmm2
    aesenc %xmm10, %xmm3
    aesenc %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesenc %xmm10, %xmm5
    aesenc %xmm11, %xmm6
    aesenc %xmm10, %xmm7
    aesenc %xmm11, %xmm8
    movdqu 160(%rax), %xmm10
    movdqu 176(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesenc %xmm10, %xmm1
    aesenc %xmm11, %xmm2
    aesenc %xmm10, %xmm3
    aesenc %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesenc %xmm10, %xmm5
    aesenc %xmm11, %xmm6
    aesenc %xmm10, %xmm7
    aesenc %xmm11, %xmm8
    movdqu 192(%rax), %xmm10
    movdqu 208(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesenc %xmm10, %xmm1
    aesenc %xmm11, %xmm2
    aesenc %xmm10, %xmm3
    aesenc %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesenc %xmm10, %xmm5
    aesenc %xmm11, %xmm6
    aesenc %xmm10, %xmm7
    aesenc %xmm11, %xmm8
    movdqu 224(%rax), %xmm10
    movdqu 240(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesenc %xmm10, %xmm1
    aesenc %xmm11, %xmm2
    aesenc %xmm10, %xmm3
    aesenc %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesenc %xmm10, %xmm5
    aesenc %xmm11, %xmm6
    aesenc %xmm10, %xmm7
    aesenc %xmm11, %xmm8
    movdqu 256(%rax), %xmm10
    movdqu 272(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesenc %xmm10, %xmm1
    aesenc %xmm11, %xmm2
    aesenc %xmm10, %xmm3
    aesenc %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesenc %xmm10, %xmm5
    aesenc %xmm11, %xmm6
    aesenc %xmm10, %xmm7
    aesenc %xmm11, %xmm8
    movdqu 288(%rax), %xmm10
    movdqu 304(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesenc %xmm10, %xmm1
    aesenc %xmm11, %xmm2
    aesenc %xmm10, %xmm3
    aesenc %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesenc %xmm10, %xmm5
    aesenc %xmm11, %xmm6
    aesenc %xmm10, %xmm7
    aesenc %xmm11, %xmm8
    movdqu 320(%rax), %xmm10
    movdqu 336(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesenc %xmm10, %xmm1
    aesenc %xmm11, %xmm2
    aesenc %xmm10, %xmm3
    aesenc %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesenc %xmm10, %xmm5
    aesenc %xmm11, %xmm6
    aesenc %xmm10, %xmm7
    aesenc %xmm11, %xmm8
    movdqu 352(%rax), %xmm10
    movdqu 368(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesenc %xmm10, %xmm1
    aesenc %xmm11, %xmm2
    aesenc %xmm10, %xmm3
    aesenc %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesenc %xmm10, %xmm5
    aesenc %xmm11, %xmm6
    aesenc %xmm10, %xmm7
    aesenc %xmm11, %xmm8
    movdqu 384(%rax), %xmm10
    movdqu 400(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesenc %xmm10, %xmm1
    aesenc %xmm11, %xmm2
    aesenc %xmm10, %xmm3
    aesenc %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesenc %xmm10, %xmm5
    aesenc %xmm11, %xmm6
    aesenc %xmm10, %xmm7
    aesenc %xmm11, %xmm8
    movdqu 416(%rax), %xmm10
    movdqu 432(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesenc %xmm10, %xmm1
    aesenc %xmm11, %xmm2
    aesenc %xmm10, %xmm3
    aesenc %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesenc %xmm10, %xmm5
    aesenc %xmm11, %xmm6
    aesenc %xmm10, %xmm7
    aesenc %xmm11, %xmm8
    movdqu 448(%rax), %xmm10
    movdqu 464(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesenclast %xmm10, %xmm1
    aesenclast %xmm11, %xmm2
    aesenclast %xmm10, %xmm3
    aesenclast %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesenclast %xmm10, %xmm5
    aesenclast %xmm11, %xmm6
    aesenclast %xmm10, %xmm7
    aesenclast %xmm11, %xmm8
    movdqu %xmm1, (%rdx)
    movdqu %xmm2, 16(%rdx)
    movdqu %xmm3, 32(%rdx)
    movdqu %xmm4, 48(%rdx)
    movdqu %xmm5, 64(%rdx)
    movdqu %xmm6, 80(%rdx)
    movdqu %xmm7, 96(%rdx)
    movdqu %xmm8, 112(%rdx)
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
    addq $136, %rsp
#endif
    ret
AREION_FUNC_END(rijndael256Encrypt4BlocksAesNiAsm)

AREION_FUNC_START(rijndael256Decrypt4BlocksAesNiAsm)
#if !defined(_WIN64)
    movq %rdi, %rax
    movq %rdx, %rcx
    movq %rsi, %rdx
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
    movq %r8, %rcx
#endif
    movdqu 64+AREION_SYM(rijndael256Consts)(%rip), %xmm0
    movdqu 80+AREION_SYM(rijndael256Consts)(%rip), %xmm9
    movdqu (%rcx), %xmm1
    movdqu 16(%rcx), %xmm2
    movdqu 32(%rcx), %xmm3
    movdqu 48(%rcx), %xmm4
    movdqu 64(%rcx), %xmm5
    movdqu 80(%rcx), %xmm6
    movdqu 96(%rcx), %xmm7
    movdqu 112(%rcx), %xmm8
    movdqu (%rax), %xmm10
    movdqu 16(%rax), %xmm11
    pxor %xmm10, %xmm1
    pxor %xmm11, %xmm2
    pxor %xmm10, %xmm3
    pxor %xmm11, %xmm4
    pxor %xmm10, %xmm5
    pxor %xmm11, %xmm6
    pxor %xmm10, %xmm7
    pxor %xmm11, %xmm8
    movdqu 32(%rax), %xmm10
    movdqu 48(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesdec %xmm10, %xmm1
    aesdec %xmm11, %xmm2
    aesdec %xmm10, %xmm3
    aesdec %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesdec %xmm10, %xmm5
    aesdec %xmm11, %xmm6
    aesdec %xmm10, %xmm7
    aesdec %xmm11, %xmm8
    movdqu 64(%rax), %xmm10
    movdqu 80(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesdec %xmm10, %xmm1
    aesdec %xmm11, %xmm2
    aesdec %xmm10, %xmm3
    aesdec %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesdec %xmm10, %xmm5
    aesdec %xmm11, %xmm6
    aesdec %xmm10, %xmm7
    aesdec %xmm11, %xmm8
    movdqu 96(%rax), %xmm10
    movdqu 112(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesdec %xmm10, %xmm1
    aesdec %xmm11, %xmm2
    aesdec %xmm10, %xmm3
    aesdec %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesdec %xmm10, %xmm5
    aesdec %xmm11, %xmm6
    aesdec %xmm10, %xmm7
    aesdec %xmm11, %xmm8
    movdqu 128(%rax), %xmm10
    movdqu 144(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesdec %xmm10, %xmm1
    aesdec %xmm11, %xmm2
    aesdec %xmm10, %xmm3
    aesdec %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesdec %xmm10, %xmm5
    aesdec %xmm11, %xmm6
    aesdec %xmm10, %xmm7
    aesdec %xmm11, %xmm8
    movdqu 160(%rax), %xmm10
    movdqu 176(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesdec %xmm10, %xmm1
    aesdec %xmm11, %xmm2
    aesdec %xmm10, %xmm3
    aesdec %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesdec %xmm10, %xmm5
    aesdec %xmm11, %xmm6
    aesdec %xmm10, %xmm7
    aesdec %xmm11, %xmm8
    movdqu 192(%rax), %xmm10
    movdqu 208(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesdec %xmm10, %xmm1
    aesdec %xmm11, %xmm2
    aesdec %xmm10, %xmm3
    aesdec %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesdec %xmm10, %xmm5
    aesdec %xmm11, %xmm6
    aesdec %xmm10, %xmm7
    aesdec %xmm11, %xmm8
    movdqu 224(%rax), %xmm10
    movdqu 240(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesdec %xmm10, %xmm1
    aesdec %xmm11, %xmm2
    aesdec %xmm10, %xmm3
    aesdec %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesdec %xmm10, %xmm5
    aesdec %xmm11, %xmm6
    aesdec %xmm10, %xmm7
    aesdec %xmm11, %xmm8
    movdqu 256(%rax), %xmm10
    movdqu 272(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesdec %xmm10, %xmm1
    aesdec %xmm11, %xmm2
    aesdec %xmm10, %xmm3
    aesdec %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesdec %xmm10, %xmm5
    aesdec %xmm11, %xmm6
    aesdec %xmm10, %xmm7
    aesdec %xmm11, %xmm8
    movdqu 288(%rax), %xmm10
    movdqu 304(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesdec %xmm10, %xmm1
    aesdec %xmm11, %xmm2
    aesdec %xmm10, %xmm3
    aesdec %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesdec %xmm10, %xmm5
    aesdec %xmm11, %xmm6
    aesdec %xmm10, %xmm7
    aesdec %xmm11, %xmm8
    movdqu 320(%rax), %xmm10
    movdqu 336(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesdec %xmm10, %xmm1
    aesdec %xmm11, %xmm2
    aesdec %xmm10, %xmm3
    aesdec %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesdec %xmm10, %xmm5
    aesdec %xmm11, %xmm6
    aesdec %xmm10, %xmm7
    aesdec %xmm11, %xmm8
    movdqu 352(%rax), %xmm10
    movdqu 368(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesdec %xmm10, %xmm1
    aesdec %xmm11, %xmm2
    aesdec %xmm10, %xmm3
    aesdec %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesdec %xmm10, %xmm5
    aesdec %xmm11, %xmm6
    aesdec %xmm10, %xmm7
    aesdec %xmm11, %xmm8
    movdqu 384(%rax), %xmm10
    movdqu 400(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesdec %xmm10, %xmm1
    aesdec %xmm11, %xmm2
    aesdec %xmm10, %xmm3
    aesdec %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesdec %xmm10, %xmm5
    aesdec %xmm11, %xmm6
    aesdec %xmm10, %xmm7
    aesdec %xmm11, %xmm8
    movdqu 416(%rax), %xmm10
    movdqu 432(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesdec %xmm10, %xmm1
    aesdec %xmm11, %xmm2
    aesdec %xmm10, %xmm3
    aesdec %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesdec %xmm10, %xmm5
    aesdec %xmm11, %xmm6
    aesdec %xmm10, %xmm7
    aesdec %xmm11, %xmm8
    movdqu 448(%rax), %xmm10
    movdqu 464(%rax), %xmm11
    movdqu %xmm1, %xmm12
    pblendvb %xmm0, %xmm2, %xmm12
    pblendvb %xmm0, %xmm1, %xmm2
    movdqu %xmm3, %xmm13
    pblendvb %xmm0, %xmm4, %xmm13
    pblendvb %xmm0, %xmm3, %xmm4
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm2
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm4
    movdqu %xmm12, %xmm1
    movdqu %xmm13, %xmm3
    aesdeclast %xmm10, %xmm1
    aesdeclast %xmm11, %xmm2
    aesdeclast %xmm10, %xmm3
    aesdeclast %xmm11, %xmm4
    movdqu %xmm5, %xmm12
    pblendvb %xmm0, %xmm6, %xmm12
    pblendvb %xmm0, %xmm5, %xmm6
    movdqu %xmm7, %xmm13
    pblendvb %xmm0, %xmm8, %xmm13
    pblendvb %xmm0, %xmm7, %xmm8
    pshufb %xmm9, %xmm12
    pshufb %xmm9, %xmm6
    pshufb %xmm9, %xmm13
    pshufb %xmm9, %xmm8
    movdqu %xmm12, %xmm5
    movdqu %xmm13, %xmm7
    aesdeclast %xmm10, %xmm5
    aesdeclast %xmm11, %xmm6
    aesdeclast %xmm10, %xmm7
    aesdeclast %xmm11, %xmm8
    movdqu %xmm1, (%rdx)
    movdqu %xmm2, 16(%rdx)
    movdqu %xmm3, 32(%rdx)
    movdqu %xmm4, 48(%rdx)
    movdqu %xmm5, 64(%rdx)
    movdqu %xmm6, 80(%rdx)
    movdqu %xmm7, 96(%rdx)
    movdqu %xmm8, 112(%rdx)
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
    addq $136, %rsp
#endif
    ret
AREION_FUNC_END(rijndael256Decrypt4BlocksAesNiAsm)

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
