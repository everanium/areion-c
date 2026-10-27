/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#if defined(__x86_64__) || defined(_M_X64)
#include "asm_abi.h"

.text

AREION_FUNC_START(areion256SoEMPermutex4Interleaved)
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
    vmovdqu64 0(%r10), %zmm16
    vmovdqu64 64(%r10), %zmm17
    vshufi64x2 $0x88, %zmm17, %zmm16, %zmm0
    vshufi64x2 $0xdd, %zmm17, %zmm16, %zmm1
    vmovdqu64 0(%rax), %ymm16
    vinserti64x4 $1, 64(%rax), %zmm16, %zmm16
    vmovdqu64 128(%rax), %ymm17
    vinserti64x4 $1, 192(%rax), %zmm17, %zmm17
    vshufi64x2 $0x88, %zmm17, %zmm16, %zmm8
    vshufi64x2 $0xdd, %zmm17, %zmm16, %zmm9
    vmovdqu64 32(%rax), %ymm16
    vinserti64x4 $1, 96(%rax), %zmm16, %zmm16
    vmovdqu64 160(%rax), %ymm17
    vinserti64x4 $1, 224(%rax), %zmm17, %zmm17
    vshufi64x2 $0x88, %zmm17, %zmm16, %zmm10
    vshufi64x2 $0xdd, %zmm17, %zmm16, %zmm11
    vpxord %zmm10, %zmm0, %zmm2
    vpxord %zmm11, %zmm1, %zmm3
    vpxord %zmm8, %zmm0, %zmm0
    vpxord %zmm9, %zmm1, %zmm1
    vpxord %zmm15, %zmm15, %zmm15
    vaesenc AREION_SYM(areionRC4x)(%rip), %zmm0, %zmm4
    vaesenc AREION_SYM(areionRC4x2)(%rip), %zmm2, %zmm5
    vaesenclast %zmm15, %zmm0, %zmm0
    vaesenclast %zmm15, %zmm2, %zmm2
    vaesenc %zmm1, %zmm4, %zmm1
    vaesenc %zmm3, %zmm5, %zmm3
    vaesenc 64+AREION_SYM(areionRC4x)(%rip), %zmm1, %zmm4
    vaesenc 64+AREION_SYM(areionRC4x2)(%rip), %zmm3, %zmm5
    vaesenclast %zmm15, %zmm1, %zmm1
    vaesenclast %zmm15, %zmm3, %zmm3
    vaesenc %zmm0, %zmm4, %zmm0
    vaesenc %zmm2, %zmm5, %zmm2
    vaesenc 128+AREION_SYM(areionRC4x)(%rip), %zmm0, %zmm4
    vaesenc 128+AREION_SYM(areionRC4x2)(%rip), %zmm2, %zmm5
    vaesenclast %zmm15, %zmm0, %zmm0
    vaesenclast %zmm15, %zmm2, %zmm2
    vaesenc %zmm1, %zmm4, %zmm1
    vaesenc %zmm3, %zmm5, %zmm3
    vaesenc 192+AREION_SYM(areionRC4x)(%rip), %zmm1, %zmm4
    vaesenc 192+AREION_SYM(areionRC4x2)(%rip), %zmm3, %zmm5
    vaesenclast %zmm15, %zmm1, %zmm1
    vaesenclast %zmm15, %zmm3, %zmm3
    vaesenc %zmm0, %zmm4, %zmm0
    vaesenc %zmm2, %zmm5, %zmm2
    vaesenc 256+AREION_SYM(areionRC4x)(%rip), %zmm0, %zmm4
    vaesenc 256+AREION_SYM(areionRC4x2)(%rip), %zmm2, %zmm5
    vaesenclast %zmm15, %zmm0, %zmm0
    vaesenclast %zmm15, %zmm2, %zmm2
    vaesenc %zmm1, %zmm4, %zmm1
    vaesenc %zmm3, %zmm5, %zmm3
    vaesenc 320+AREION_SYM(areionRC4x)(%rip), %zmm1, %zmm4
    vaesenc 320+AREION_SYM(areionRC4x2)(%rip), %zmm3, %zmm5
    vaesenclast %zmm15, %zmm1, %zmm1
    vaesenclast %zmm15, %zmm3, %zmm3
    vaesenc %zmm0, %zmm4, %zmm0
    vaesenc %zmm2, %zmm5, %zmm2
    vaesenc 384+AREION_SYM(areionRC4x)(%rip), %zmm0, %zmm4
    vaesenc 384+AREION_SYM(areionRC4x2)(%rip), %zmm2, %zmm5
    vaesenclast %zmm15, %zmm0, %zmm0
    vaesenclast %zmm15, %zmm2, %zmm2
    vaesenc %zmm1, %zmm4, %zmm1
    vaesenc %zmm3, %zmm5, %zmm3
    vaesenc 448+AREION_SYM(areionRC4x)(%rip), %zmm1, %zmm4
    vaesenc 448+AREION_SYM(areionRC4x2)(%rip), %zmm3, %zmm5
    vaesenclast %zmm15, %zmm1, %zmm1
    vaesenclast %zmm15, %zmm3, %zmm3
    vaesenc %zmm0, %zmm4, %zmm0
    vaesenc %zmm2, %zmm5, %zmm2
    vaesenc 512+AREION_SYM(areionRC4x)(%rip), %zmm0, %zmm4
    vaesenc 512+AREION_SYM(areionRC4x2)(%rip), %zmm2, %zmm5
    vaesenclast %zmm15, %zmm0, %zmm0
    vaesenclast %zmm15, %zmm2, %zmm2
    vaesenc %zmm1, %zmm4, %zmm1
    vaesenc %zmm3, %zmm5, %zmm3
    vaesenc 576+AREION_SYM(areionRC4x)(%rip), %zmm1, %zmm4
    vaesenc 576+AREION_SYM(areionRC4x2)(%rip), %zmm3, %zmm5
    vaesenclast %zmm15, %zmm1, %zmm1
    vaesenclast %zmm15, %zmm3, %zmm3
    vaesenc %zmm0, %zmm4, %zmm0
    vaesenc %zmm2, %zmm5, %zmm2
    vpxord %zmm2, %zmm0, %zmm0
    vpxord %zmm3, %zmm1, %zmm1
    vpxord %zmm8, %zmm10, %zmm8
    vpxord %zmm9, %zmm11, %zmm9
    vpxord %zmm8, %zmm0, %zmm0
    vpxord %zmm9, %zmm1, %zmm1
    vshufi64x2 $0x44, %zmm1, %zmm0, %zmm16
    vshufi64x2 $0xee, %zmm1, %zmm0, %zmm17
    vshufi64x2 $0xd8, %zmm16, %zmm16, %zmm16
    vshufi64x2 $0xd8, %zmm17, %zmm17, %zmm17
    vmovdqu64 %zmm16, 0(%rdx)
    vmovdqu64 %zmm17, 64(%rdx)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    vpxord %xmm8, %xmm8, %xmm8
    vpxord %xmm9, %xmm9, %xmm9
    vpxord %xmm10, %xmm10, %xmm10
    vpxord %xmm11, %xmm11, %xmm11
    vpxord %xmm15, %xmm15, %xmm15
    vpxord %xmm16, %xmm16, %xmm16
    vpxord %xmm17, %xmm17, %xmm17
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
    vzeroupper
    ret
AREION_FUNC_END(areion256SoEMPermutex4Interleaved)

AREION_FUNC_START(areion256SoEMPermutex4VaesAvx2)
#if !defined(_WIN64)
    movq %rsi, %r10
    movq %rdx, %rax
    movq %rdi, %rdx
#else
    subq $104, %rsp
    vmovdqu %xmm8, 0(%rsp)
    vmovdqu %xmm9, 16(%rsp)
    vmovdqu %xmm10, 32(%rsp)
    vmovdqu %xmm11, 48(%rsp)
    vmovdqu %xmm14, 64(%rsp)
    vmovdqu %xmm15, 80(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    vmovdqu 0(%r10), %ymm14
    vmovdqu 32(%r10), %ymm1
    vperm2i128 $0x20, %ymm1, %ymm14, %ymm0
    vperm2i128 $0x31, %ymm1, %ymm14, %ymm1
    vmovdqu 0(%rax), %ymm14
    vmovdqu 64(%rax), %ymm9
    vperm2i128 $0x20, %ymm9, %ymm14, %ymm8
    vperm2i128 $0x31, %ymm9, %ymm14, %ymm9
    vmovdqu 32(%rax), %ymm14
    vmovdqu 96(%rax), %ymm11
    vperm2i128 $0x20, %ymm11, %ymm14, %ymm10
    vperm2i128 $0x31, %ymm11, %ymm14, %ymm11
    vpxor %ymm10, %ymm0, %ymm2
    vpxor %ymm11, %ymm1, %ymm3
    vpxor %ymm8, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vpxor %ymm15, %ymm15, %ymm15
    vaesenc AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm4
    vaesenc AREION_SYM(areionRC4x2)(%rip), %ymm2, %ymm5
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenc %ymm1, %ymm4, %ymm1
    vaesenc %ymm3, %ymm5, %ymm3
    vaesenc 64+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm4
    vaesenc 64+AREION_SYM(areionRC4x2)(%rip), %ymm3, %ymm5
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm2, %ymm5, %ymm2
    vaesenc 128+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm4
    vaesenc 128+AREION_SYM(areionRC4x2)(%rip), %ymm2, %ymm5
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenc %ymm1, %ymm4, %ymm1
    vaesenc %ymm3, %ymm5, %ymm3
    vaesenc 192+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm4
    vaesenc 192+AREION_SYM(areionRC4x2)(%rip), %ymm3, %ymm5
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm2, %ymm5, %ymm2
    vaesenc 256+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm4
    vaesenc 256+AREION_SYM(areionRC4x2)(%rip), %ymm2, %ymm5
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenc %ymm1, %ymm4, %ymm1
    vaesenc %ymm3, %ymm5, %ymm3
    vaesenc 320+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm4
    vaesenc 320+AREION_SYM(areionRC4x2)(%rip), %ymm3, %ymm5
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm2, %ymm5, %ymm2
    vaesenc 384+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm4
    vaesenc 384+AREION_SYM(areionRC4x2)(%rip), %ymm2, %ymm5
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenc %ymm1, %ymm4, %ymm1
    vaesenc %ymm3, %ymm5, %ymm3
    vaesenc 448+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm4
    vaesenc 448+AREION_SYM(areionRC4x2)(%rip), %ymm3, %ymm5
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm2, %ymm5, %ymm2
    vaesenc 512+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm4
    vaesenc 512+AREION_SYM(areionRC4x2)(%rip), %ymm2, %ymm5
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenc %ymm1, %ymm4, %ymm1
    vaesenc %ymm3, %ymm5, %ymm3
    vaesenc 576+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm4
    vaesenc 576+AREION_SYM(areionRC4x2)(%rip), %ymm3, %ymm5
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm2, %ymm5, %ymm2
    vpxor %ymm2, %ymm0, %ymm0
    vpxor %ymm3, %ymm1, %ymm1
    vpxor %ymm8, %ymm10, %ymm8
    vpxor %ymm9, %ymm11, %ymm9
    vpxor %ymm8, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vperm2i128 $0x20, %ymm1, %ymm0, %ymm14
    vperm2i128 $0x31, %ymm1, %ymm0, %ymm1
    vmovdqu %ymm14, 0(%rdx)
    vmovdqu %ymm1, 32(%rdx)
    vmovdqu 64(%r10), %ymm14
    vmovdqu 96(%r10), %ymm1
    vperm2i128 $0x20, %ymm1, %ymm14, %ymm0
    vperm2i128 $0x31, %ymm1, %ymm14, %ymm1
    vmovdqu 128(%rax), %ymm14
    vmovdqu 192(%rax), %ymm9
    vperm2i128 $0x20, %ymm9, %ymm14, %ymm8
    vperm2i128 $0x31, %ymm9, %ymm14, %ymm9
    vmovdqu 160(%rax), %ymm14
    vmovdqu 224(%rax), %ymm11
    vperm2i128 $0x20, %ymm11, %ymm14, %ymm10
    vperm2i128 $0x31, %ymm11, %ymm14, %ymm11
    vpxor %ymm10, %ymm0, %ymm2
    vpxor %ymm11, %ymm1, %ymm3
    vpxor %ymm8, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vpxor %ymm15, %ymm15, %ymm15
    vaesenc AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm4
    vaesenc AREION_SYM(areionRC4x2)(%rip), %ymm2, %ymm5
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenc %ymm1, %ymm4, %ymm1
    vaesenc %ymm3, %ymm5, %ymm3
    vaesenc 64+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm4
    vaesenc 64+AREION_SYM(areionRC4x2)(%rip), %ymm3, %ymm5
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm2, %ymm5, %ymm2
    vaesenc 128+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm4
    vaesenc 128+AREION_SYM(areionRC4x2)(%rip), %ymm2, %ymm5
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenc %ymm1, %ymm4, %ymm1
    vaesenc %ymm3, %ymm5, %ymm3
    vaesenc 192+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm4
    vaesenc 192+AREION_SYM(areionRC4x2)(%rip), %ymm3, %ymm5
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm2, %ymm5, %ymm2
    vaesenc 256+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm4
    vaesenc 256+AREION_SYM(areionRC4x2)(%rip), %ymm2, %ymm5
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenc %ymm1, %ymm4, %ymm1
    vaesenc %ymm3, %ymm5, %ymm3
    vaesenc 320+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm4
    vaesenc 320+AREION_SYM(areionRC4x2)(%rip), %ymm3, %ymm5
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm2, %ymm5, %ymm2
    vaesenc 384+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm4
    vaesenc 384+AREION_SYM(areionRC4x2)(%rip), %ymm2, %ymm5
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenc %ymm1, %ymm4, %ymm1
    vaesenc %ymm3, %ymm5, %ymm3
    vaesenc 448+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm4
    vaesenc 448+AREION_SYM(areionRC4x2)(%rip), %ymm3, %ymm5
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm2, %ymm5, %ymm2
    vaesenc 512+AREION_SYM(areionRC4x)(%rip), %ymm0, %ymm4
    vaesenc 512+AREION_SYM(areionRC4x2)(%rip), %ymm2, %ymm5
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenc %ymm1, %ymm4, %ymm1
    vaesenc %ymm3, %ymm5, %ymm3
    vaesenc 576+AREION_SYM(areionRC4x)(%rip), %ymm1, %ymm4
    vaesenc 576+AREION_SYM(areionRC4x2)(%rip), %ymm3, %ymm5
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenc %ymm0, %ymm4, %ymm0
    vaesenc %ymm2, %ymm5, %ymm2
    vpxor %ymm2, %ymm0, %ymm0
    vpxor %ymm3, %ymm1, %ymm1
    vpxor %ymm8, %ymm10, %ymm8
    vpxor %ymm9, %ymm11, %ymm9
    vpxor %ymm8, %ymm0, %ymm0
    vpxor %ymm9, %ymm1, %ymm1
    vperm2i128 $0x20, %ymm1, %ymm0, %ymm14
    vperm2i128 $0x31, %ymm1, %ymm0, %ymm1
    vmovdqu %ymm14, 64(%rdx)
    vmovdqu %ymm1, 96(%rdx)
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
    vpxor %xmm14, %xmm14, %xmm14
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
    vmovdqu 64(%rsp), %xmm14
    movq $0, 64(%rsp)
    movq $0, 72(%rsp)
    vmovdqu 80(%rsp), %xmm15
    movq $0, 80(%rsp)
    movq $0, 88(%rsp)
    addq $104, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion256SoEMPermutex4VaesAvx2)

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
