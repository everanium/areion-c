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
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    vmovdqu64 0(%r10), %zmm16
    vmovdqu64 64(%r10), %zmm17
    vmovdqu64 0(%rax), %ymm18
    vinserti64x4 $1, 64(%rax), %zmm18, %zmm18
    vmovdqu64 128(%rax), %ymm19
    vinserti64x4 $1, 192(%rax), %zmm19, %zmm19
    vmovdqu64 32(%rax), %ymm20
    vinserti64x4 $1, 96(%rax), %zmm20, %zmm20
    vmovdqu64 160(%rax), %ymm21
    vinserti64x4 $1, 224(%rax), %zmm21, %zmm21
    vpxord %zmm18, %zmm16, %zmm22
    vpxord %zmm19, %zmm17, %zmm23
    vshufi64x2 $0x88, %zmm23, %zmm22, %zmm0
    vshufi64x2 $0xdd, %zmm23, %zmm22, %zmm1
    vpxord %zmm20, %zmm16, %zmm22
    vpxord %zmm21, %zmm17, %zmm23
    vshufi64x2 $0x88, %zmm23, %zmm22, %zmm2
    vshufi64x2 $0xdd, %zmm23, %zmm22, %zmm3
    vpxord %zmm20, %zmm18, %zmm18
    vpxord %zmm21, %zmm19, %zmm19
    vpxord %zmm24, %zmm24, %zmm24
    vaesenc AREION_SYM(areionRC4x)(%rip), %zmm0, %zmm4
    vaesenc AREION_SYM(areionRC4x2)(%rip), %zmm2, %zmm5
    vaesenclast %zmm24, %zmm0, %zmm0
    vaesenclast %zmm24, %zmm2, %zmm2
    vaesenc %zmm1, %zmm4, %zmm1
    vaesenc %zmm3, %zmm5, %zmm3
    vaesenc 64+AREION_SYM(areionRC4x)(%rip), %zmm1, %zmm4
    vaesenc 64+AREION_SYM(areionRC4x2)(%rip), %zmm3, %zmm5
    vaesenclast %zmm24, %zmm1, %zmm1
    vaesenclast %zmm24, %zmm3, %zmm3
    vaesenc %zmm0, %zmm4, %zmm0
    vaesenc %zmm2, %zmm5, %zmm2
    vaesenc 128+AREION_SYM(areionRC4x)(%rip), %zmm0, %zmm4
    vaesenc 128+AREION_SYM(areionRC4x2)(%rip), %zmm2, %zmm5
    vaesenclast %zmm24, %zmm0, %zmm0
    vaesenclast %zmm24, %zmm2, %zmm2
    vaesenc %zmm1, %zmm4, %zmm1
    vaesenc %zmm3, %zmm5, %zmm3
    vaesenc 192+AREION_SYM(areionRC4x)(%rip), %zmm1, %zmm4
    vaesenc 192+AREION_SYM(areionRC4x2)(%rip), %zmm3, %zmm5
    vaesenclast %zmm24, %zmm1, %zmm1
    vaesenclast %zmm24, %zmm3, %zmm3
    vaesenc %zmm0, %zmm4, %zmm0
    vaesenc %zmm2, %zmm5, %zmm2
    vaesenc 256+AREION_SYM(areionRC4x)(%rip), %zmm0, %zmm4
    vaesenc 256+AREION_SYM(areionRC4x2)(%rip), %zmm2, %zmm5
    vaesenclast %zmm24, %zmm0, %zmm0
    vaesenclast %zmm24, %zmm2, %zmm2
    vaesenc %zmm1, %zmm4, %zmm1
    vaesenc %zmm3, %zmm5, %zmm3
    vaesenc 320+AREION_SYM(areionRC4x)(%rip), %zmm1, %zmm4
    vaesenc 320+AREION_SYM(areionRC4x2)(%rip), %zmm3, %zmm5
    vaesenclast %zmm24, %zmm1, %zmm1
    vaesenclast %zmm24, %zmm3, %zmm3
    vaesenc %zmm0, %zmm4, %zmm0
    vaesenc %zmm2, %zmm5, %zmm2
    vaesenc 384+AREION_SYM(areionRC4x)(%rip), %zmm0, %zmm4
    vaesenc 384+AREION_SYM(areionRC4x2)(%rip), %zmm2, %zmm5
    vaesenclast %zmm24, %zmm0, %zmm0
    vaesenclast %zmm24, %zmm2, %zmm2
    vaesenc %zmm1, %zmm4, %zmm1
    vaesenc %zmm3, %zmm5, %zmm3
    vaesenc 448+AREION_SYM(areionRC4x)(%rip), %zmm1, %zmm4
    vaesenc 448+AREION_SYM(areionRC4x2)(%rip), %zmm3, %zmm5
    vaesenclast %zmm24, %zmm1, %zmm1
    vaesenclast %zmm24, %zmm3, %zmm3
    vaesenc %zmm0, %zmm4, %zmm0
    vaesenc %zmm2, %zmm5, %zmm2
    vaesenc 512+AREION_SYM(areionRC4x)(%rip), %zmm0, %zmm4
    vaesenc 512+AREION_SYM(areionRC4x2)(%rip), %zmm2, %zmm5
    vaesenclast %zmm24, %zmm0, %zmm0
    vaesenclast %zmm24, %zmm2, %zmm2
    vaesenc %zmm1, %zmm4, %zmm1
    vaesenc %zmm3, %zmm5, %zmm3
    vaesenc 576+AREION_SYM(areionRC4x)(%rip), %zmm1, %zmm4
    vaesenc 576+AREION_SYM(areionRC4x2)(%rip), %zmm3, %zmm5
    vaesenclast %zmm24, %zmm1, %zmm1
    vaesenclast %zmm24, %zmm3, %zmm3
    vaesenc %zmm0, %zmm4, %zmm0
    vaesenc %zmm2, %zmm5, %zmm2
    vpxord %zmm2, %zmm0, %zmm0
    vpxord %zmm3, %zmm1, %zmm1
    vshufi64x2 $0x44, %zmm1, %zmm0, %zmm16
    vshufi64x2 $0xee, %zmm1, %zmm0, %zmm17
    vshufi64x2 $0xd8, %zmm16, %zmm16, %zmm16
    vshufi64x2 $0xd8, %zmm17, %zmm17, %zmm17
    vpxord %zmm18, %zmm16, %zmm16
    vpxord %zmm19, %zmm17, %zmm17
    vmovdqu64 %zmm16, 0(%rdx)
    vmovdqu64 %zmm17, 64(%rdx)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm3, %xmm3, %xmm3
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    vpxord %xmm16, %xmm16, %xmm16
    vpxord %xmm17, %xmm17, %xmm17
    vpxord %xmm18, %xmm18, %xmm18
    vpxord %xmm19, %xmm19, %xmm19
    vpxord %xmm20, %xmm20, %xmm20
    vpxord %xmm21, %xmm21, %xmm21
    vpxord %xmm22, %xmm22, %xmm22
    vpxord %xmm23, %xmm23, %xmm23
    vpxord %xmm24, %xmm24, %xmm24
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rdx, %rdx
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
    vmovdqu %xmm6, 0(%rsp)
    vmovdqu %xmm7, 16(%rsp)
    vmovdqu %xmm8, 32(%rsp)
    vmovdqu %xmm9, 48(%rsp)
    vmovdqu %xmm10, 64(%rsp)
    vmovdqu %xmm11, 80(%rsp)
    movq %rdx, %r10
    movq %rcx, %rdx
    movq %r8, %rax
#endif
    vpxor %ymm11, %ymm11, %ymm11
    vmovdqu 0(%r10), %ymm8
    vmovdqu 32(%r10), %ymm9
    vpxor 0(%rax), %ymm8, %ymm6
    vpxor 64(%rax), %ymm9, %ymm7
    vperm2i128 $0x20, %ymm7, %ymm6, %ymm0
    vperm2i128 $0x31, %ymm7, %ymm6, %ymm2
    vpxor 32(%rax), %ymm8, %ymm6
    vpxor 96(%rax), %ymm9, %ymm7
    vperm2i128 $0x20, %ymm7, %ymm6, %ymm4
    vperm2i128 $0x31, %ymm7, %ymm6, %ymm6
    vmovdqu 64(%r10), %ymm8
    vmovdqu 96(%r10), %ymm9
    vpxor 128(%rax), %ymm8, %ymm10
    vpxor 192(%rax), %ymm9, %ymm7
    vperm2i128 $0x20, %ymm7, %ymm10, %ymm1
    vperm2i128 $0x31, %ymm7, %ymm10, %ymm3
    vpxor 160(%rax), %ymm8, %ymm10
    vpxor 224(%rax), %ymm9, %ymm7
    vperm2i128 $0x20, %ymm7, %ymm10, %ymm5
    vperm2i128 $0x31, %ymm7, %ymm10, %ymm7
    vmovdqu AREION_SYM(areionRC4x)(%rip), %ymm8
    vaesenc %ymm8, %ymm0, %ymm9
    vaesenc %ymm8, %ymm1, %ymm10
    vmovdqu AREION_SYM(areionRC4x2)(%rip), %ymm8
    vaesenc %ymm2, %ymm9, %ymm2
    vaesenc %ymm3, %ymm10, %ymm3
    vaesenclast %ymm11, %ymm0, %ymm0
    vaesenclast %ymm11, %ymm1, %ymm1
    vaesenc %ymm8, %ymm4, %ymm9
    vaesenc %ymm8, %ymm5, %ymm10
    vaesenc %ymm6, %ymm9, %ymm6
    vaesenc %ymm7, %ymm10, %ymm7
    vaesenclast %ymm11, %ymm4, %ymm4
    vaesenclast %ymm11, %ymm5, %ymm5
    vmovdqu 64+AREION_SYM(areionRC4x)(%rip), %ymm8
    vaesenc %ymm8, %ymm2, %ymm9
    vaesenc %ymm8, %ymm3, %ymm10
    vmovdqu 64+AREION_SYM(areionRC4x2)(%rip), %ymm8
    vaesenc %ymm0, %ymm9, %ymm0
    vaesenc %ymm1, %ymm10, %ymm1
    vaesenclast %ymm11, %ymm2, %ymm2
    vaesenclast %ymm11, %ymm3, %ymm3
    vaesenc %ymm8, %ymm6, %ymm9
    vaesenc %ymm8, %ymm7, %ymm10
    vaesenc %ymm4, %ymm9, %ymm4
    vaesenc %ymm5, %ymm10, %ymm5
    vaesenclast %ymm11, %ymm6, %ymm6
    vaesenclast %ymm11, %ymm7, %ymm7
    vmovdqu 128+AREION_SYM(areionRC4x)(%rip), %ymm8
    vaesenc %ymm8, %ymm0, %ymm9
    vaesenc %ymm8, %ymm1, %ymm10
    vmovdqu 128+AREION_SYM(areionRC4x2)(%rip), %ymm8
    vaesenc %ymm2, %ymm9, %ymm2
    vaesenc %ymm3, %ymm10, %ymm3
    vaesenclast %ymm11, %ymm0, %ymm0
    vaesenclast %ymm11, %ymm1, %ymm1
    vaesenc %ymm8, %ymm4, %ymm9
    vaesenc %ymm8, %ymm5, %ymm10
    vaesenc %ymm6, %ymm9, %ymm6
    vaesenc %ymm7, %ymm10, %ymm7
    vaesenclast %ymm11, %ymm4, %ymm4
    vaesenclast %ymm11, %ymm5, %ymm5
    vmovdqu 192+AREION_SYM(areionRC4x)(%rip), %ymm8
    vaesenc %ymm8, %ymm2, %ymm9
    vaesenc %ymm8, %ymm3, %ymm10
    vmovdqu 192+AREION_SYM(areionRC4x2)(%rip), %ymm8
    vaesenc %ymm0, %ymm9, %ymm0
    vaesenc %ymm1, %ymm10, %ymm1
    vaesenclast %ymm11, %ymm2, %ymm2
    vaesenclast %ymm11, %ymm3, %ymm3
    vaesenc %ymm8, %ymm6, %ymm9
    vaesenc %ymm8, %ymm7, %ymm10
    vaesenc %ymm4, %ymm9, %ymm4
    vaesenc %ymm5, %ymm10, %ymm5
    vaesenclast %ymm11, %ymm6, %ymm6
    vaesenclast %ymm11, %ymm7, %ymm7
    vmovdqu 256+AREION_SYM(areionRC4x)(%rip), %ymm8
    vaesenc %ymm8, %ymm0, %ymm9
    vaesenc %ymm8, %ymm1, %ymm10
    vmovdqu 256+AREION_SYM(areionRC4x2)(%rip), %ymm8
    vaesenc %ymm2, %ymm9, %ymm2
    vaesenc %ymm3, %ymm10, %ymm3
    vaesenclast %ymm11, %ymm0, %ymm0
    vaesenclast %ymm11, %ymm1, %ymm1
    vaesenc %ymm8, %ymm4, %ymm9
    vaesenc %ymm8, %ymm5, %ymm10
    vaesenc %ymm6, %ymm9, %ymm6
    vaesenc %ymm7, %ymm10, %ymm7
    vaesenclast %ymm11, %ymm4, %ymm4
    vaesenclast %ymm11, %ymm5, %ymm5
    vmovdqu 320+AREION_SYM(areionRC4x)(%rip), %ymm8
    vaesenc %ymm8, %ymm2, %ymm9
    vaesenc %ymm8, %ymm3, %ymm10
    vmovdqu 320+AREION_SYM(areionRC4x2)(%rip), %ymm8
    vaesenc %ymm0, %ymm9, %ymm0
    vaesenc %ymm1, %ymm10, %ymm1
    vaesenclast %ymm11, %ymm2, %ymm2
    vaesenclast %ymm11, %ymm3, %ymm3
    vaesenc %ymm8, %ymm6, %ymm9
    vaesenc %ymm8, %ymm7, %ymm10
    vaesenc %ymm4, %ymm9, %ymm4
    vaesenc %ymm5, %ymm10, %ymm5
    vaesenclast %ymm11, %ymm6, %ymm6
    vaesenclast %ymm11, %ymm7, %ymm7
    vmovdqu 384+AREION_SYM(areionRC4x)(%rip), %ymm8
    vaesenc %ymm8, %ymm0, %ymm9
    vaesenc %ymm8, %ymm1, %ymm10
    vmovdqu 384+AREION_SYM(areionRC4x2)(%rip), %ymm8
    vaesenc %ymm2, %ymm9, %ymm2
    vaesenc %ymm3, %ymm10, %ymm3
    vaesenclast %ymm11, %ymm0, %ymm0
    vaesenclast %ymm11, %ymm1, %ymm1
    vaesenc %ymm8, %ymm4, %ymm9
    vaesenc %ymm8, %ymm5, %ymm10
    vaesenc %ymm6, %ymm9, %ymm6
    vaesenc %ymm7, %ymm10, %ymm7
    vaesenclast %ymm11, %ymm4, %ymm4
    vaesenclast %ymm11, %ymm5, %ymm5
    vmovdqu 448+AREION_SYM(areionRC4x)(%rip), %ymm8
    vaesenc %ymm8, %ymm2, %ymm9
    vaesenc %ymm8, %ymm3, %ymm10
    vmovdqu 448+AREION_SYM(areionRC4x2)(%rip), %ymm8
    vaesenc %ymm0, %ymm9, %ymm0
    vaesenc %ymm1, %ymm10, %ymm1
    vaesenclast %ymm11, %ymm2, %ymm2
    vaesenclast %ymm11, %ymm3, %ymm3
    vaesenc %ymm8, %ymm6, %ymm9
    vaesenc %ymm8, %ymm7, %ymm10
    vaesenc %ymm4, %ymm9, %ymm4
    vaesenc %ymm5, %ymm10, %ymm5
    vaesenclast %ymm11, %ymm6, %ymm6
    vaesenclast %ymm11, %ymm7, %ymm7
    vmovdqu 512+AREION_SYM(areionRC4x)(%rip), %ymm8
    vaesenc %ymm8, %ymm0, %ymm9
    vaesenc %ymm8, %ymm1, %ymm10
    vmovdqu 512+AREION_SYM(areionRC4x2)(%rip), %ymm8
    vaesenc %ymm2, %ymm9, %ymm2
    vaesenc %ymm3, %ymm10, %ymm3
    vaesenclast %ymm11, %ymm0, %ymm0
    vaesenclast %ymm11, %ymm1, %ymm1
    vaesenc %ymm8, %ymm4, %ymm9
    vaesenc %ymm8, %ymm5, %ymm10
    vaesenc %ymm6, %ymm9, %ymm6
    vaesenc %ymm7, %ymm10, %ymm7
    vaesenclast %ymm11, %ymm4, %ymm4
    vaesenclast %ymm11, %ymm5, %ymm5
    vmovdqu 576+AREION_SYM(areionRC4x)(%rip), %ymm8
    vaesenc %ymm8, %ymm2, %ymm9
    vaesenc %ymm8, %ymm3, %ymm10
    vmovdqu 576+AREION_SYM(areionRC4x2)(%rip), %ymm8
    vaesenc %ymm0, %ymm9, %ymm0
    vaesenc %ymm1, %ymm10, %ymm1
    vaesenclast %ymm11, %ymm2, %ymm2
    vaesenclast %ymm11, %ymm3, %ymm3
    vaesenc %ymm8, %ymm6, %ymm9
    vaesenc %ymm8, %ymm7, %ymm10
    vaesenc %ymm4, %ymm9, %ymm4
    vaesenc %ymm5, %ymm10, %ymm5
    vaesenclast %ymm11, %ymm6, %ymm6
    vaesenclast %ymm11, %ymm7, %ymm7
    vpxor %ymm4, %ymm0, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
    vperm2i128 $0x20, %ymm2, %ymm0, %ymm8
    vperm2i128 $0x31, %ymm2, %ymm0, %ymm9
    vperm2i128 $0x20, %ymm3, %ymm1, %ymm10
    vperm2i128 $0x31, %ymm3, %ymm1, %ymm11
    vpxor 0(%rax), %ymm8, %ymm8
    vpxor 32(%rax), %ymm8, %ymm8
    vmovdqu %ymm8, 0(%rdx)
    vpxor 64(%rax), %ymm9, %ymm9
    vpxor 96(%rax), %ymm9, %ymm9
    vmovdqu %ymm9, 32(%rdx)
    vpxor 128(%rax), %ymm10, %ymm10
    vpxor 160(%rax), %ymm10, %ymm10
    vmovdqu %ymm10, 64(%rdx)
    vpxor 192(%rax), %ymm11, %ymm11
    vpxor 224(%rax), %ymm11, %ymm11
    vmovdqu %ymm11, 96(%rdx)
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
