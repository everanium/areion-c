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
    movq %rdi, %rax
    movq %rsi, %r10
    movq %rdx, %r11
    movq %rcx, %rdx
    movq %r11, %rcx
#else
    subq $24, %rsp
    vmovdqu %xmm6, 0(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
    movq %r9, %rdx
#endif
    vmovdqu64 (%rax), %zmm0
    vmovdqu64 (%r10), %zmm1
    vmovdqu64 (%rcx), %zmm4
    vmovdqu64 (%rdx), %zmm5
    vpxord %zmm3, %zmm3, %zmm3
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
    vaesenc %zmm16, %zmm0, %zmm2
    vaesenc AREION_SYM(areionRC4x2)(%rip), %zmm4, %zmm6
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm4, %zmm4
    vaesenc %zmm1, %zmm2, %zmm1
    vaesenc %zmm5, %zmm6, %zmm5
    vaesenc %zmm17, %zmm1, %zmm2
    vaesenc 64+AREION_SYM(areionRC4x2)(%rip), %zmm5, %zmm6
    vaesenclast %zmm3, %zmm1, %zmm1
    vaesenclast %zmm3, %zmm5, %zmm5
    vaesenc %zmm0, %zmm2, %zmm0
    vaesenc %zmm4, %zmm6, %zmm4
    vaesenc %zmm18, %zmm0, %zmm2
    vaesenc 128+AREION_SYM(areionRC4x2)(%rip), %zmm4, %zmm6
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm4, %zmm4
    vaesenc %zmm1, %zmm2, %zmm1
    vaesenc %zmm5, %zmm6, %zmm5
    vaesenc %zmm19, %zmm1, %zmm2
    vaesenc 192+AREION_SYM(areionRC4x2)(%rip), %zmm5, %zmm6
    vaesenclast %zmm3, %zmm1, %zmm1
    vaesenclast %zmm3, %zmm5, %zmm5
    vaesenc %zmm0, %zmm2, %zmm0
    vaesenc %zmm4, %zmm6, %zmm4
    vaesenc %zmm20, %zmm0, %zmm2
    vaesenc 256+AREION_SYM(areionRC4x2)(%rip), %zmm4, %zmm6
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm4, %zmm4
    vaesenc %zmm1, %zmm2, %zmm1
    vaesenc %zmm5, %zmm6, %zmm5
    vaesenc %zmm21, %zmm1, %zmm2
    vaesenc 320+AREION_SYM(areionRC4x2)(%rip), %zmm5, %zmm6
    vaesenclast %zmm3, %zmm1, %zmm1
    vaesenclast %zmm3, %zmm5, %zmm5
    vaesenc %zmm0, %zmm2, %zmm0
    vaesenc %zmm4, %zmm6, %zmm4
    vaesenc %zmm22, %zmm0, %zmm2
    vaesenc 384+AREION_SYM(areionRC4x2)(%rip), %zmm4, %zmm6
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm4, %zmm4
    vaesenc %zmm1, %zmm2, %zmm1
    vaesenc %zmm5, %zmm6, %zmm5
    vaesenc %zmm23, %zmm1, %zmm2
    vaesenc 448+AREION_SYM(areionRC4x2)(%rip), %zmm5, %zmm6
    vaesenclast %zmm3, %zmm1, %zmm1
    vaesenclast %zmm3, %zmm5, %zmm5
    vaesenc %zmm0, %zmm2, %zmm0
    vaesenc %zmm4, %zmm6, %zmm4
    vaesenc %zmm24, %zmm0, %zmm2
    vaesenc 512+AREION_SYM(areionRC4x2)(%rip), %zmm4, %zmm6
    vaesenclast %zmm3, %zmm0, %zmm0
    vaesenclast %zmm3, %zmm4, %zmm4
    vaesenc %zmm1, %zmm2, %zmm1
    vaesenc %zmm5, %zmm6, %zmm5
    vaesenc %zmm25, %zmm1, %zmm2
    vaesenc 576+AREION_SYM(areionRC4x2)(%rip), %zmm5, %zmm6
    vaesenclast %zmm3, %zmm1, %zmm1
    vaesenclast %zmm3, %zmm5, %zmm5
    vaesenc %zmm0, %zmm2, %zmm0
    vaesenc %zmm4, %zmm6, %zmm4
    vpxord %zmm4, %zmm0, %zmm0
    vpxord %zmm5, %zmm1, %zmm1
    vmovdqu64 %zmm0, (%rax)
    vmovdqu64 %zmm1, (%r10)
    vpxord %xmm0, %xmm0, %xmm0
    vpxord %xmm1, %xmm1, %xmm1
    vpxord %xmm2, %xmm2, %xmm2
    vpxord %xmm4, %xmm4, %xmm4
    vpxord %xmm5, %xmm5, %xmm5
    vpxord %xmm6, %xmm6, %xmm6
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
    xorq %rax, %rax
    xorq %r10, %r10
    xorq %rcx, %rcx
    xorq %rdx, %rdx
    xorq %r11, %r11
#if defined(_WIN64)
    vmovdqu 0(%rsp), %xmm6
    movq $0, 0(%rsp)
    movq $0, 8(%rsp)
    addq $24, %rsp
#endif
    vzeroupper
    ret
AREION_FUNC_END(areion256SoEMPermutex4Interleaved)

AREION_FUNC_START(areion256SoEMPermutex4VaesAvx2)
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
    vmovdqu %xmm15, 128(%rsp)
    movq %rcx, %rax
    movq %rdx, %r10
    movq %r8, %rcx
    movq %r9, %rdx
#endif
    vmovdqu (%rax), %ymm0
    vmovdqu 32(%rax), %ymm1
    vmovdqu (%r10), %ymm2
    vmovdqu 32(%r10), %ymm3
    vmovdqu (%rcx), %ymm4
    vmovdqu 32(%rcx), %ymm5
    vmovdqu (%rdx), %ymm6
    vmovdqu 32(%rdx), %ymm7
    vpxor %ymm15, %ymm15, %ymm15
    vmovdqu AREION_SYM(areionRC4x)(%rip), %ymm12
    vmovdqu AREION_SYM(areionRC4x2)(%rip), %ymm13
    vaesenc %ymm12, %ymm0, %ymm8
    vaesenc %ymm12, %ymm1, %ymm9
    vaesenc %ymm13, %ymm4, %ymm10
    vaesenc %ymm13, %ymm5, %ymm11
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenc %ymm2, %ymm8, %ymm2
    vaesenc %ymm3, %ymm9, %ymm3
    vaesenc %ymm6, %ymm10, %ymm6
    vaesenc %ymm7, %ymm11, %ymm7
    vmovdqu 64+AREION_SYM(areionRC4x)(%rip), %ymm12
    vmovdqu 64+AREION_SYM(areionRC4x2)(%rip), %ymm13
    vaesenc %ymm12, %ymm2, %ymm8
    vaesenc %ymm12, %ymm3, %ymm9
    vaesenc %ymm13, %ymm6, %ymm10
    vaesenc %ymm13, %ymm7, %ymm11
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast %ymm15, %ymm7, %ymm7
    vaesenc %ymm0, %ymm8, %ymm0
    vaesenc %ymm1, %ymm9, %ymm1
    vaesenc %ymm4, %ymm10, %ymm4
    vaesenc %ymm5, %ymm11, %ymm5
    vmovdqu 128+AREION_SYM(areionRC4x)(%rip), %ymm12
    vmovdqu 128+AREION_SYM(areionRC4x2)(%rip), %ymm13
    vaesenc %ymm12, %ymm0, %ymm8
    vaesenc %ymm12, %ymm1, %ymm9
    vaesenc %ymm13, %ymm4, %ymm10
    vaesenc %ymm13, %ymm5, %ymm11
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenc %ymm2, %ymm8, %ymm2
    vaesenc %ymm3, %ymm9, %ymm3
    vaesenc %ymm6, %ymm10, %ymm6
    vaesenc %ymm7, %ymm11, %ymm7
    vmovdqu 192+AREION_SYM(areionRC4x)(%rip), %ymm12
    vmovdqu 192+AREION_SYM(areionRC4x2)(%rip), %ymm13
    vaesenc %ymm12, %ymm2, %ymm8
    vaesenc %ymm12, %ymm3, %ymm9
    vaesenc %ymm13, %ymm6, %ymm10
    vaesenc %ymm13, %ymm7, %ymm11
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast %ymm15, %ymm7, %ymm7
    vaesenc %ymm0, %ymm8, %ymm0
    vaesenc %ymm1, %ymm9, %ymm1
    vaesenc %ymm4, %ymm10, %ymm4
    vaesenc %ymm5, %ymm11, %ymm5
    vmovdqu 256+AREION_SYM(areionRC4x)(%rip), %ymm12
    vmovdqu 256+AREION_SYM(areionRC4x2)(%rip), %ymm13
    vaesenc %ymm12, %ymm0, %ymm8
    vaesenc %ymm12, %ymm1, %ymm9
    vaesenc %ymm13, %ymm4, %ymm10
    vaesenc %ymm13, %ymm5, %ymm11
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenc %ymm2, %ymm8, %ymm2
    vaesenc %ymm3, %ymm9, %ymm3
    vaesenc %ymm6, %ymm10, %ymm6
    vaesenc %ymm7, %ymm11, %ymm7
    vmovdqu 320+AREION_SYM(areionRC4x)(%rip), %ymm12
    vmovdqu 320+AREION_SYM(areionRC4x2)(%rip), %ymm13
    vaesenc %ymm12, %ymm2, %ymm8
    vaesenc %ymm12, %ymm3, %ymm9
    vaesenc %ymm13, %ymm6, %ymm10
    vaesenc %ymm13, %ymm7, %ymm11
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast %ymm15, %ymm7, %ymm7
    vaesenc %ymm0, %ymm8, %ymm0
    vaesenc %ymm1, %ymm9, %ymm1
    vaesenc %ymm4, %ymm10, %ymm4
    vaesenc %ymm5, %ymm11, %ymm5
    vmovdqu 384+AREION_SYM(areionRC4x)(%rip), %ymm12
    vmovdqu 384+AREION_SYM(areionRC4x2)(%rip), %ymm13
    vaesenc %ymm12, %ymm0, %ymm8
    vaesenc %ymm12, %ymm1, %ymm9
    vaesenc %ymm13, %ymm4, %ymm10
    vaesenc %ymm13, %ymm5, %ymm11
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenc %ymm2, %ymm8, %ymm2
    vaesenc %ymm3, %ymm9, %ymm3
    vaesenc %ymm6, %ymm10, %ymm6
    vaesenc %ymm7, %ymm11, %ymm7
    vmovdqu 448+AREION_SYM(areionRC4x)(%rip), %ymm12
    vmovdqu 448+AREION_SYM(areionRC4x2)(%rip), %ymm13
    vaesenc %ymm12, %ymm2, %ymm8
    vaesenc %ymm12, %ymm3, %ymm9
    vaesenc %ymm13, %ymm6, %ymm10
    vaesenc %ymm13, %ymm7, %ymm11
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast %ymm15, %ymm7, %ymm7
    vaesenc %ymm0, %ymm8, %ymm0
    vaesenc %ymm1, %ymm9, %ymm1
    vaesenc %ymm4, %ymm10, %ymm4
    vaesenc %ymm5, %ymm11, %ymm5
    vmovdqu 512+AREION_SYM(areionRC4x)(%rip), %ymm12
    vmovdqu 512+AREION_SYM(areionRC4x2)(%rip), %ymm13
    vaesenc %ymm12, %ymm0, %ymm8
    vaesenc %ymm12, %ymm1, %ymm9
    vaesenc %ymm13, %ymm4, %ymm10
    vaesenc %ymm13, %ymm5, %ymm11
    vaesenclast %ymm15, %ymm0, %ymm0
    vaesenclast %ymm15, %ymm1, %ymm1
    vaesenclast %ymm15, %ymm4, %ymm4
    vaesenclast %ymm15, %ymm5, %ymm5
    vaesenc %ymm2, %ymm8, %ymm2
    vaesenc %ymm3, %ymm9, %ymm3
    vaesenc %ymm6, %ymm10, %ymm6
    vaesenc %ymm7, %ymm11, %ymm7
    vmovdqu 576+AREION_SYM(areionRC4x)(%rip), %ymm12
    vmovdqu 576+AREION_SYM(areionRC4x2)(%rip), %ymm13
    vaesenc %ymm12, %ymm2, %ymm8
    vaesenc %ymm12, %ymm3, %ymm9
    vaesenc %ymm13, %ymm6, %ymm10
    vaesenc %ymm13, %ymm7, %ymm11
    vaesenclast %ymm15, %ymm2, %ymm2
    vaesenclast %ymm15, %ymm3, %ymm3
    vaesenclast %ymm15, %ymm6, %ymm6
    vaesenclast %ymm15, %ymm7, %ymm7
    vaesenc %ymm0, %ymm8, %ymm0
    vaesenc %ymm1, %ymm9, %ymm1
    vaesenc %ymm4, %ymm10, %ymm4
    vaesenc %ymm5, %ymm11, %ymm5
    vpxor %ymm4, %ymm0, %ymm0
    vpxor %ymm5, %ymm1, %ymm1
    vpxor %ymm6, %ymm2, %ymm2
    vpxor %ymm7, %ymm3, %ymm3
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
    vmovdqu 128(%rsp), %xmm15
    movq $0, 128(%rsp)
    movq $0, 136(%rsp)
    addq $152, %rsp
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
