/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#if defined(__aarch64__) || defined(_M_ARM64)
#include "asm_abi.h"

#if !defined(__APPLE__)
.arch armv8-a+crypto
#endif
.text

AREION_FUNC_START(aesRoundAsm)
    ld1 { v0.16b }, [x0]
    ld1 { v1.16b }, [x1]
    eor v2.16b, v2.16b, v2.16b
    aese v0.16b, v2.16b
    aesmc v0.16b, v0.16b
    eor v0.16b, v0.16b, v1.16b
    st1 { v0.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    mov x0, xzr
    mov x1, xzr
    ret
AREION_FUNC_END(aesRoundAsm)

AREION_FUNC_START(aesFinalRoundAsm)
    ld1 { v0.16b }, [x0]
    ld1 { v1.16b }, [x1]
    eor v2.16b, v2.16b, v2.16b
    aese v0.16b, v2.16b
    eor v0.16b, v0.16b, v1.16b
    st1 { v0.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    mov x0, xzr
    mov x1, xzr
    ret
AREION_FUNC_END(aesFinalRoundAsm)

AREION_FUNC_START(aesRound4Asm)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    eor v16.16b, v16.16b, v16.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    eor v0.16b, v0.16b, v4.16b
    aese v1.16b, v16.16b
    aesmc v1.16b, v1.16b
    eor v1.16b, v1.16b, v5.16b
    aese v2.16b, v16.16b
    aesmc v2.16b, v2.16b
    eor v2.16b, v2.16b, v6.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v3.16b, v3.16b, v7.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v16.16b, v16.16b, v16.16b
    mov x0, xzr
    mov x1, xzr
    ret
AREION_FUNC_END(aesRound4Asm)

AREION_FUNC_START(aesFinalRound4Asm)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    eor v16.16b, v16.16b, v16.16b
    aese v0.16b, v16.16b
    eor v0.16b, v0.16b, v4.16b
    aese v1.16b, v16.16b
    eor v1.16b, v1.16b, v5.16b
    aese v2.16b, v16.16b
    eor v2.16b, v2.16b, v6.16b
    aese v3.16b, v16.16b
    eor v3.16b, v3.16b, v7.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v16.16b, v16.16b, v16.16b
    mov x0, xzr
    mov x1, xzr
    ret
AREION_FUNC_END(aesFinalRound4Asm)

AREION_FUNC_START(aes128EncryptBlockAsm)
    ld1 { v0.16b }, [x2]
    ld1 { v1.16b }, [x0], #16
    aese v0.16b, v1.16b
    aesmc v0.16b, v0.16b
    ld1 { v1.16b }, [x0], #16
    aese v0.16b, v1.16b
    aesmc v0.16b, v0.16b
    ld1 { v1.16b }, [x0], #16
    aese v0.16b, v1.16b
    aesmc v0.16b, v0.16b
    ld1 { v1.16b }, [x0], #16
    aese v0.16b, v1.16b
    aesmc v0.16b, v0.16b
    ld1 { v1.16b }, [x0], #16
    aese v0.16b, v1.16b
    aesmc v0.16b, v0.16b
    ld1 { v1.16b }, [x0], #16
    aese v0.16b, v1.16b
    aesmc v0.16b, v0.16b
    ld1 { v1.16b }, [x0], #16
    aese v0.16b, v1.16b
    aesmc v0.16b, v0.16b
    ld1 { v1.16b }, [x0], #16
    aese v0.16b, v1.16b
    aesmc v0.16b, v0.16b
    ld1 { v1.16b }, [x0], #16
    aese v0.16b, v1.16b
    aesmc v0.16b, v0.16b
    ld1 { v1.16b }, [x0], #16
    ld1 { v2.16b }, [x0]
    aese v0.16b, v1.16b
    eor v0.16b, v0.16b, v2.16b
    st1 { v0.16b }, [x1]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    ret
AREION_FUNC_END(aes128EncryptBlockAsm)

AREION_FUNC_START(aes128Encrypt4BlocksAsm)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x2]
    ld1 { v4.16b }, [x0], #16
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x0], #16
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x0], #16
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x0], #16
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x0], #16
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x0], #16
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x0], #16
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x0], #16
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x0], #16
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x0], #16
    ld1 { v5.16b }, [x0]
    aese v0.16b, v4.16b
    aese v1.16b, v4.16b
    aese v2.16b, v4.16b
    aese v3.16b, v4.16b
    eor v0.16b, v0.16b, v5.16b
    eor v1.16b, v1.16b, v5.16b
    eor v2.16b, v2.16b, v5.16b
    eor v3.16b, v3.16b, v5.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    ret
AREION_FUNC_END(aes128Encrypt4BlocksAsm)

AREION_FUNC_START(areion256PermuteRCAsm)
    mov x2, x1
    ld1 { v0.16b, v1.16b }, [x0]
    eor v31.16b, v31.16b, v31.16b
    ld1 { v2.16b }, [x2], #16
    mov v3.16b, v0.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v31.16b
    ld1 { v2.16b }, [x2], #16
    mov v3.16b, v1.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v31.16b
    ld1 { v2.16b }, [x2], #16
    mov v3.16b, v0.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v31.16b
    ld1 { v2.16b }, [x2], #16
    mov v3.16b, v1.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v31.16b
    ld1 { v2.16b }, [x2], #16
    mov v3.16b, v0.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v31.16b
    ld1 { v2.16b }, [x2], #16
    mov v3.16b, v1.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v31.16b
    ld1 { v2.16b }, [x2], #16
    mov v3.16b, v0.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v31.16b
    ld1 { v2.16b }, [x2], #16
    mov v3.16b, v1.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v31.16b
    ld1 { v2.16b }, [x2], #16
    mov v3.16b, v0.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v31.16b
    ld1 { v2.16b }, [x2], #16
    mov v3.16b, v1.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v31.16b
    st1 { v0.16b, v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x2, xzr
    ret
AREION_FUNC_END(areion256PermuteRCAsm)

AREION_FUNC_START(areion256InversePermuteRCAsm)
    mov x2, x1
    ld1 { v0.16b, v1.16b }, [x0]
    eor v31.16b, v31.16b, v31.16b
    ld1 { v16.16b }, [x2], #16
    ld1 { v17.16b }, [x2], #16
    ld1 { v18.16b }, [x2], #16
    ld1 { v19.16b }, [x2], #16
    ld1 { v20.16b }, [x2], #16
    ld1 { v21.16b }, [x2], #16
    ld1 { v22.16b }, [x2], #16
    ld1 { v23.16b }, [x2], #16
    ld1 { v24.16b }, [x2], #16
    ld1 { v25.16b }, [x2], #16
    aesd v1.16b, v31.16b
    mov v3.16b, v1.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v25.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v31.16b
    mov v3.16b, v0.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v31.16b
    mov v3.16b, v1.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v31.16b
    mov v3.16b, v0.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v22.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v31.16b
    mov v3.16b, v1.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v21.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v31.16b
    mov v3.16b, v0.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v31.16b
    mov v3.16b, v1.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v31.16b
    mov v3.16b, v0.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v18.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v31.16b
    mov v3.16b, v1.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v31.16b
    mov v3.16b, v0.16b
    aese v3.16b, v31.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    st1 { v0.16b, v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v3.16b, v3.16b, v3.16b
    eor v31.16b, v31.16b, v31.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    mov x0, xzr
    mov x2, xzr
    ret
AREION_FUNC_END(areion256InversePermuteRCAsm)

AREION_FUNC_START(areion512PermuteRCAsm)
    mov x2, x1
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    eor v31.16b, v31.16b, v31.16b
    ld1 { v4.16b }, [x2], #16
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x2], #16
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x2], #16
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x2], #16
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v31.16b
    aese v1.16b, v31.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x2], #16
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x2], #16
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x2], #16
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x2], #16
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v31.16b
    aese v1.16b, v31.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x2], #16
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x2], #16
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x2], #16
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x2], #16
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v31.16b
    aese v1.16b, v31.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x2], #16
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x2], #16
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x2], #16
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    st1 { v3.16b }, [x0]
    add x1, x0, #16
    st1 { v0.16b, v1.16b, v2.16b }, [x1]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    ret
AREION_FUNC_END(areion512PermuteRCAsm)

AREION_FUNC_START(areion512InversePermuteRCAsm)
    mov x2, x1
    ld1 { v3.16b }, [x0]
    add x1, x0, #16
    ld1 { v0.16b, v1.16b, v2.16b }, [x1]
    eor v31.16b, v31.16b, v31.16b
    ld1 { v16.16b }, [x2], #16
    ld1 { v17.16b }, [x2], #16
    ld1 { v18.16b }, [x2], #16
    ld1 { v19.16b }, [x2], #16
    ld1 { v20.16b }, [x2], #16
    ld1 { v21.16b }, [x2], #16
    ld1 { v22.16b }, [x2], #16
    ld1 { v23.16b }, [x2], #16
    ld1 { v24.16b }, [x2], #16
    ld1 { v25.16b }, [x2], #16
    ld1 { v26.16b }, [x2], #16
    ld1 { v27.16b }, [x2], #16
    ld1 { v28.16b }, [x2], #16
    ld1 { v29.16b }, [x2], #16
    ld1 { v30.16b }, [x2], #16
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v30.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v29.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v28.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v27.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v26.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v25.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v24.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v23.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v22.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v21.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v20.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v19.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v18.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v17.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v16.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v5.16b, v5.16b, v5.16b
    eor v31.16b, v31.16b, v31.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    ret
AREION_FUNC_END(areion512InversePermuteRCAsm)

AREION_FUNC_START(areionSoEM256Asm)
    ld1 { v0.16b, v1.16b }, [x2]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x1]
    eor v2.16b, v0.16b, v18.16b
    eor v3.16b, v1.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v20.16b, v20.16b, v20.16b
    AREION_ARM64_ADR(x3, roundConstantsP1)
    AREION_ARM64_ADR(x4, roundConstantsP2)
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    mov v4.16b, v0.16b
    mov v5.16b, v2.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    mov v4.16b, v1.16b
    mov v5.16b, v3.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    mov v4.16b, v0.16b
    mov v5.16b, v2.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    mov v4.16b, v1.16b
    mov v5.16b, v3.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    mov v4.16b, v0.16b
    mov v5.16b, v2.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    mov v4.16b, v1.16b
    mov v5.16b, v3.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    mov v4.16b, v0.16b
    mov v5.16b, v2.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    mov v4.16b, v1.16b
    mov v5.16b, v3.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    mov v4.16b, v0.16b
    mov v5.16b, v2.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    mov v4.16b, v1.16b
    mov v5.16b, v3.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    eor v0.16b, v0.16b, v2.16b
    eor v1.16b, v1.16b, v3.16b
    eor v16.16b, v18.16b, v16.16b
    eor v17.16b, v19.16b, v17.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    st1 { v0.16b, v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(areionSoEM256Asm)

AREION_FUNC_START(areionSoEM512Asm)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x2]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x1]
    add x5, x1, #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x5]
    eor v4.16b, v0.16b, v20.16b
    eor v5.16b, v1.16b, v21.16b
    eor v6.16b, v2.16b, v22.16b
    eor v7.16b, v3.16b, v23.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v30.16b, v30.16b, v30.16b
    AREION_ARM64_ADR(x3, roundConstantsP1)
    AREION_ARM64_ADR(x4, roundConstantsP2)
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    mov v24.16b, v0.16b
    mov v25.16b, v4.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    mov v26.16b, v2.16b
    mov v27.16b, v6.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    mov v24.16b, v1.16b
    mov v25.16b, v5.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    mov v26.16b, v3.16b
    mov v27.16b, v7.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    mov v24.16b, v2.16b
    mov v25.16b, v6.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    mov v26.16b, v0.16b
    mov v27.16b, v4.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    mov v24.16b, v3.16b
    mov v25.16b, v7.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    mov v26.16b, v1.16b
    mov v27.16b, v5.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v1.16b, v28.16b
    aese v5.16b, v29.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    mov v24.16b, v0.16b
    mov v25.16b, v4.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    mov v26.16b, v2.16b
    mov v27.16b, v6.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    mov v24.16b, v1.16b
    mov v25.16b, v5.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    mov v26.16b, v3.16b
    mov v27.16b, v7.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    mov v24.16b, v2.16b
    mov v25.16b, v6.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    mov v26.16b, v0.16b
    mov v27.16b, v4.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    mov v24.16b, v3.16b
    mov v25.16b, v7.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    mov v26.16b, v1.16b
    mov v27.16b, v5.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v1.16b, v28.16b
    aese v5.16b, v29.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    mov v24.16b, v0.16b
    mov v25.16b, v4.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    mov v26.16b, v2.16b
    mov v27.16b, v6.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    mov v24.16b, v1.16b
    mov v25.16b, v5.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    mov v26.16b, v3.16b
    mov v27.16b, v7.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    mov v24.16b, v2.16b
    mov v25.16b, v6.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    mov v26.16b, v0.16b
    mov v27.16b, v4.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    mov v24.16b, v3.16b
    mov v25.16b, v7.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    mov v26.16b, v1.16b
    mov v27.16b, v5.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v1.16b, v28.16b
    aese v5.16b, v29.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    mov v24.16b, v0.16b
    mov v25.16b, v4.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    mov v26.16b, v2.16b
    mov v27.16b, v6.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    mov v24.16b, v1.16b
    mov v25.16b, v5.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    mov v26.16b, v3.16b
    mov v27.16b, v7.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    mov v24.16b, v2.16b
    mov v25.16b, v6.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    mov v26.16b, v0.16b
    mov v27.16b, v4.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    eor v3.16b, v3.16b, v7.16b
    eor v0.16b, v0.16b, v4.16b
    eor v1.16b, v1.16b, v5.16b
    eor v2.16b, v2.16b, v6.16b
    eor v16.16b, v20.16b, v16.16b
    eor v17.16b, v21.16b, v17.16b
    eor v18.16b, v22.16b, v18.16b
    eor v19.16b, v23.16b, v19.16b
    eor v3.16b, v3.16b, v16.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v19.16b
    st1 { v3.16b }, [x0]
    add x1, x0, #16
    st1 { v0.16b, v1.16b, v2.16b }, [x1]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    mov x5, xzr
    ret
AREION_FUNC_END(areionSoEM512Asm)

AREION_FUNC_START(areion256Permutex4RC)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    eor v21.16b, v21.16b, v21.16b
    ld1 { v16.16b }, [x2], #16
    mov v17.16b, v0.16b
    mov v18.16b, v1.16b
    mov v19.16b, v2.16b
    mov v20.16b, v3.16b
    aese v17.16b, v21.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v21.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v21.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v21.16b
    aesmc v20.16b, v20.16b
    aese v17.16b, v16.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v16.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v16.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v16.16b
    aesmc v20.16b, v20.16b
    eor v4.16b, v4.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    eor v7.16b, v7.16b, v20.16b
    aese v0.16b, v21.16b
    aese v1.16b, v21.16b
    aese v2.16b, v21.16b
    aese v3.16b, v21.16b
    ld1 { v16.16b }, [x2], #16
    mov v17.16b, v4.16b
    mov v18.16b, v5.16b
    mov v19.16b, v6.16b
    mov v20.16b, v7.16b
    aese v17.16b, v21.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v21.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v21.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v21.16b
    aesmc v20.16b, v20.16b
    aese v17.16b, v16.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v16.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v16.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v16.16b
    aesmc v20.16b, v20.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v19.16b
    eor v3.16b, v3.16b, v20.16b
    aese v4.16b, v21.16b
    aese v5.16b, v21.16b
    aese v6.16b, v21.16b
    aese v7.16b, v21.16b
    ld1 { v16.16b }, [x2], #16
    mov v17.16b, v0.16b
    mov v18.16b, v1.16b
    mov v19.16b, v2.16b
    mov v20.16b, v3.16b
    aese v17.16b, v21.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v21.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v21.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v21.16b
    aesmc v20.16b, v20.16b
    aese v17.16b, v16.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v16.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v16.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v16.16b
    aesmc v20.16b, v20.16b
    eor v4.16b, v4.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    eor v7.16b, v7.16b, v20.16b
    aese v0.16b, v21.16b
    aese v1.16b, v21.16b
    aese v2.16b, v21.16b
    aese v3.16b, v21.16b
    ld1 { v16.16b }, [x2], #16
    mov v17.16b, v4.16b
    mov v18.16b, v5.16b
    mov v19.16b, v6.16b
    mov v20.16b, v7.16b
    aese v17.16b, v21.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v21.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v21.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v21.16b
    aesmc v20.16b, v20.16b
    aese v17.16b, v16.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v16.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v16.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v16.16b
    aesmc v20.16b, v20.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v19.16b
    eor v3.16b, v3.16b, v20.16b
    aese v4.16b, v21.16b
    aese v5.16b, v21.16b
    aese v6.16b, v21.16b
    aese v7.16b, v21.16b
    ld1 { v16.16b }, [x2], #16
    mov v17.16b, v0.16b
    mov v18.16b, v1.16b
    mov v19.16b, v2.16b
    mov v20.16b, v3.16b
    aese v17.16b, v21.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v21.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v21.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v21.16b
    aesmc v20.16b, v20.16b
    aese v17.16b, v16.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v16.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v16.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v16.16b
    aesmc v20.16b, v20.16b
    eor v4.16b, v4.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    eor v7.16b, v7.16b, v20.16b
    aese v0.16b, v21.16b
    aese v1.16b, v21.16b
    aese v2.16b, v21.16b
    aese v3.16b, v21.16b
    ld1 { v16.16b }, [x2], #16
    mov v17.16b, v4.16b
    mov v18.16b, v5.16b
    mov v19.16b, v6.16b
    mov v20.16b, v7.16b
    aese v17.16b, v21.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v21.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v21.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v21.16b
    aesmc v20.16b, v20.16b
    aese v17.16b, v16.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v16.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v16.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v16.16b
    aesmc v20.16b, v20.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v19.16b
    eor v3.16b, v3.16b, v20.16b
    aese v4.16b, v21.16b
    aese v5.16b, v21.16b
    aese v6.16b, v21.16b
    aese v7.16b, v21.16b
    ld1 { v16.16b }, [x2], #16
    mov v17.16b, v0.16b
    mov v18.16b, v1.16b
    mov v19.16b, v2.16b
    mov v20.16b, v3.16b
    aese v17.16b, v21.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v21.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v21.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v21.16b
    aesmc v20.16b, v20.16b
    aese v17.16b, v16.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v16.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v16.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v16.16b
    aesmc v20.16b, v20.16b
    eor v4.16b, v4.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    eor v7.16b, v7.16b, v20.16b
    aese v0.16b, v21.16b
    aese v1.16b, v21.16b
    aese v2.16b, v21.16b
    aese v3.16b, v21.16b
    ld1 { v16.16b }, [x2], #16
    mov v17.16b, v4.16b
    mov v18.16b, v5.16b
    mov v19.16b, v6.16b
    mov v20.16b, v7.16b
    aese v17.16b, v21.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v21.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v21.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v21.16b
    aesmc v20.16b, v20.16b
    aese v17.16b, v16.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v16.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v16.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v16.16b
    aesmc v20.16b, v20.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v19.16b
    eor v3.16b, v3.16b, v20.16b
    aese v4.16b, v21.16b
    aese v5.16b, v21.16b
    aese v6.16b, v21.16b
    aese v7.16b, v21.16b
    ld1 { v16.16b }, [x2], #16
    mov v17.16b, v0.16b
    mov v18.16b, v1.16b
    mov v19.16b, v2.16b
    mov v20.16b, v3.16b
    aese v17.16b, v21.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v21.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v21.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v21.16b
    aesmc v20.16b, v20.16b
    aese v17.16b, v16.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v16.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v16.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v16.16b
    aesmc v20.16b, v20.16b
    eor v4.16b, v4.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    eor v7.16b, v7.16b, v20.16b
    aese v0.16b, v21.16b
    aese v1.16b, v21.16b
    aese v2.16b, v21.16b
    aese v3.16b, v21.16b
    ld1 { v16.16b }, [x2], #16
    mov v17.16b, v4.16b
    mov v18.16b, v5.16b
    mov v19.16b, v6.16b
    mov v20.16b, v7.16b
    aese v17.16b, v21.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v21.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v21.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v21.16b
    aesmc v20.16b, v20.16b
    aese v17.16b, v16.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v16.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v16.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v16.16b
    aesmc v20.16b, v20.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v19.16b
    eor v3.16b, v3.16b, v20.16b
    aese v4.16b, v21.16b
    aese v5.16b, v21.16b
    aese v6.16b, v21.16b
    aese v7.16b, v21.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    st1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v16.16b, v16.16b, v16.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    ret
AREION_FUNC_END(areion256Permutex4RC)

AREION_FUNC_START(areion256InversePermutex4RC)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    eor v30.16b, v30.16b, v30.16b
    ld1 { v16.16b }, [x2], #16
    ld1 { v17.16b }, [x2], #16
    ld1 { v18.16b }, [x2], #16
    ld1 { v19.16b }, [x2], #16
    ld1 { v20.16b }, [x2], #16
    ld1 { v21.16b }, [x2], #16
    ld1 { v22.16b }, [x2], #16
    ld1 { v23.16b }, [x2], #16
    ld1 { v24.16b }, [x2], #16
    ld1 { v25.16b }, [x2], #16
    aesd v4.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v7.16b, v30.16b
    mov v26.16b, v4.16b
    mov v27.16b, v5.16b
    mov v28.16b, v6.16b
    mov v29.16b, v7.16b
    aese v26.16b, v30.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v30.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v30.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v30.16b
    aesmc v29.16b, v29.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    eor v2.16b, v2.16b, v28.16b
    eor v3.16b, v3.16b, v29.16b
    aesd v0.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v3.16b, v30.16b
    mov v26.16b, v0.16b
    mov v27.16b, v1.16b
    mov v28.16b, v2.16b
    mov v29.16b, v3.16b
    aese v26.16b, v30.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v30.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v30.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v30.16b
    aesmc v29.16b, v29.16b
    aese v26.16b, v24.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v24.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v24.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v24.16b
    aesmc v29.16b, v29.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesd v4.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v7.16b, v30.16b
    mov v26.16b, v4.16b
    mov v27.16b, v5.16b
    mov v28.16b, v6.16b
    mov v29.16b, v7.16b
    aese v26.16b, v30.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v30.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v30.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v30.16b
    aesmc v29.16b, v29.16b
    aese v26.16b, v23.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v23.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v23.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v23.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    eor v2.16b, v2.16b, v28.16b
    eor v3.16b, v3.16b, v29.16b
    aesd v0.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v3.16b, v30.16b
    mov v26.16b, v0.16b
    mov v27.16b, v1.16b
    mov v28.16b, v2.16b
    mov v29.16b, v3.16b
    aese v26.16b, v30.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v30.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v30.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v30.16b
    aesmc v29.16b, v29.16b
    aese v26.16b, v22.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v22.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v22.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v22.16b
    aesmc v29.16b, v29.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesd v4.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v7.16b, v30.16b
    mov v26.16b, v4.16b
    mov v27.16b, v5.16b
    mov v28.16b, v6.16b
    mov v29.16b, v7.16b
    aese v26.16b, v30.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v30.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v30.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v30.16b
    aesmc v29.16b, v29.16b
    aese v26.16b, v21.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v21.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v21.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v21.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    eor v2.16b, v2.16b, v28.16b
    eor v3.16b, v3.16b, v29.16b
    aesd v0.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v3.16b, v30.16b
    mov v26.16b, v0.16b
    mov v27.16b, v1.16b
    mov v28.16b, v2.16b
    mov v29.16b, v3.16b
    aese v26.16b, v30.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v30.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v30.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v30.16b
    aesmc v29.16b, v29.16b
    aese v26.16b, v20.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v20.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v20.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v20.16b
    aesmc v29.16b, v29.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesd v4.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v7.16b, v30.16b
    mov v26.16b, v4.16b
    mov v27.16b, v5.16b
    mov v28.16b, v6.16b
    mov v29.16b, v7.16b
    aese v26.16b, v30.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v30.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v30.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v30.16b
    aesmc v29.16b, v29.16b
    aese v26.16b, v19.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v19.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v19.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v19.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    eor v2.16b, v2.16b, v28.16b
    eor v3.16b, v3.16b, v29.16b
    aesd v0.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v3.16b, v30.16b
    mov v26.16b, v0.16b
    mov v27.16b, v1.16b
    mov v28.16b, v2.16b
    mov v29.16b, v3.16b
    aese v26.16b, v30.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v30.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v30.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v30.16b
    aesmc v29.16b, v29.16b
    aese v26.16b, v18.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v18.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v18.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v18.16b
    aesmc v29.16b, v29.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesd v4.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v7.16b, v30.16b
    mov v26.16b, v4.16b
    mov v27.16b, v5.16b
    mov v28.16b, v6.16b
    mov v29.16b, v7.16b
    aese v26.16b, v30.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v30.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v30.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v30.16b
    aesmc v29.16b, v29.16b
    aese v26.16b, v17.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v17.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v17.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v17.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    eor v2.16b, v2.16b, v28.16b
    eor v3.16b, v3.16b, v29.16b
    aesd v0.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v3.16b, v30.16b
    mov v26.16b, v0.16b
    mov v27.16b, v1.16b
    mov v28.16b, v2.16b
    mov v29.16b, v3.16b
    aese v26.16b, v30.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v30.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v30.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v30.16b
    aesmc v29.16b, v29.16b
    aese v26.16b, v16.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v16.16b
    aesmc v27.16b, v27.16b
    aese v28.16b, v16.16b
    aesmc v28.16b, v28.16b
    aese v29.16b, v16.16b
    aesmc v29.16b, v29.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    st1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    ret
AREION_FUNC_END(areion256InversePermutex4RC)

AREION_FUNC_START(areion512Permutex4RC)
    stp d8, d9, [sp, #-16]!
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x3]
    eor v25.16b, v25.16b, v25.16b
    ld1 { v24.16b }, [x4], #16
    mov v26.16b, v0.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v4.16b, v26.16b, v4.16b
    mov v27.16b, v1.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v5.16b, v27.16b, v5.16b
    mov v28.16b, v2.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v6.16b, v28.16b, v6.16b
    mov v29.16b, v3.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v7.16b, v29.16b, v7.16b
    mov v30.16b, v16.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v20.16b, v30.16b, v20.16b
    mov v31.16b, v17.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v21.16b, v31.16b, v21.16b
    mov v8.16b, v18.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v22.16b, v8.16b, v22.16b
    mov v9.16b, v19.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v23.16b, v9.16b, v23.16b
    aese v0.16b, v25.16b
    aese v16.16b, v25.16b
    aese v16.16b, v24.16b
    aesmc v16.16b, v16.16b
    aese v1.16b, v25.16b
    aese v17.16b, v25.16b
    aese v17.16b, v24.16b
    aesmc v17.16b, v17.16b
    aese v2.16b, v25.16b
    aese v18.16b, v25.16b
    aese v18.16b, v24.16b
    aesmc v18.16b, v18.16b
    aese v3.16b, v25.16b
    aese v19.16b, v25.16b
    aese v19.16b, v24.16b
    aesmc v19.16b, v19.16b
    ld1 { v24.16b }, [x4], #16
    mov v26.16b, v4.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v16.16b, v26.16b, v16.16b
    mov v27.16b, v5.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v17.16b, v27.16b, v17.16b
    mov v28.16b, v6.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v18.16b, v28.16b, v18.16b
    mov v29.16b, v7.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v19.16b, v29.16b, v19.16b
    mov v30.16b, v20.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v0.16b, v30.16b, v0.16b
    mov v31.16b, v21.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v1.16b, v31.16b, v1.16b
    mov v8.16b, v22.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v2.16b, v8.16b, v2.16b
    mov v9.16b, v23.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v3.16b, v9.16b, v3.16b
    aese v4.16b, v25.16b
    aese v20.16b, v25.16b
    aese v20.16b, v24.16b
    aesmc v20.16b, v20.16b
    aese v5.16b, v25.16b
    aese v21.16b, v25.16b
    aese v21.16b, v24.16b
    aesmc v21.16b, v21.16b
    aese v6.16b, v25.16b
    aese v22.16b, v25.16b
    aese v22.16b, v24.16b
    aesmc v22.16b, v22.16b
    aese v7.16b, v25.16b
    aese v23.16b, v25.16b
    aese v23.16b, v24.16b
    aesmc v23.16b, v23.16b
    ld1 { v24.16b }, [x4], #16
    mov v26.16b, v16.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v20.16b, v26.16b, v20.16b
    mov v27.16b, v17.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v21.16b, v27.16b, v21.16b
    mov v28.16b, v18.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v22.16b, v28.16b, v22.16b
    mov v29.16b, v19.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v23.16b, v29.16b, v23.16b
    mov v30.16b, v0.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v30.16b, v4.16b
    mov v31.16b, v1.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v5.16b, v31.16b, v5.16b
    mov v8.16b, v2.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v6.16b, v8.16b, v6.16b
    mov v9.16b, v3.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v7.16b, v9.16b, v7.16b
    aese v16.16b, v25.16b
    aese v0.16b, v25.16b
    aese v0.16b, v24.16b
    aesmc v0.16b, v0.16b
    aese v17.16b, v25.16b
    aese v1.16b, v25.16b
    aese v1.16b, v24.16b
    aesmc v1.16b, v1.16b
    aese v18.16b, v25.16b
    aese v2.16b, v25.16b
    aese v2.16b, v24.16b
    aesmc v2.16b, v2.16b
    aese v19.16b, v25.16b
    aese v3.16b, v25.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    ld1 { v24.16b }, [x4], #16
    mov v26.16b, v20.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v0.16b, v26.16b, v0.16b
    mov v27.16b, v21.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v27.16b, v1.16b
    mov v28.16b, v22.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v2.16b, v28.16b, v2.16b
    mov v29.16b, v23.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v29.16b, v3.16b
    mov v30.16b, v4.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v16.16b, v30.16b, v16.16b
    mov v31.16b, v5.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v17.16b, v31.16b, v17.16b
    mov v8.16b, v6.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v18.16b, v8.16b, v18.16b
    mov v9.16b, v7.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v19.16b, v9.16b, v19.16b
    aese v20.16b, v25.16b
    aese v4.16b, v25.16b
    aese v4.16b, v24.16b
    aesmc v4.16b, v4.16b
    aese v21.16b, v25.16b
    aese v5.16b, v25.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    aese v22.16b, v25.16b
    aese v6.16b, v25.16b
    aese v6.16b, v24.16b
    aesmc v6.16b, v6.16b
    aese v23.16b, v25.16b
    aese v7.16b, v25.16b
    aese v7.16b, v24.16b
    aesmc v7.16b, v7.16b
    ld1 { v24.16b }, [x4], #16
    mov v26.16b, v0.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v4.16b, v26.16b, v4.16b
    mov v27.16b, v1.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v5.16b, v27.16b, v5.16b
    mov v28.16b, v2.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v6.16b, v28.16b, v6.16b
    mov v29.16b, v3.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v7.16b, v29.16b, v7.16b
    mov v30.16b, v16.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v20.16b, v30.16b, v20.16b
    mov v31.16b, v17.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v21.16b, v31.16b, v21.16b
    mov v8.16b, v18.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v22.16b, v8.16b, v22.16b
    mov v9.16b, v19.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v23.16b, v9.16b, v23.16b
    aese v0.16b, v25.16b
    aese v16.16b, v25.16b
    aese v16.16b, v24.16b
    aesmc v16.16b, v16.16b
    aese v1.16b, v25.16b
    aese v17.16b, v25.16b
    aese v17.16b, v24.16b
    aesmc v17.16b, v17.16b
    aese v2.16b, v25.16b
    aese v18.16b, v25.16b
    aese v18.16b, v24.16b
    aesmc v18.16b, v18.16b
    aese v3.16b, v25.16b
    aese v19.16b, v25.16b
    aese v19.16b, v24.16b
    aesmc v19.16b, v19.16b
    ld1 { v24.16b }, [x4], #16
    mov v26.16b, v4.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v16.16b, v26.16b, v16.16b
    mov v27.16b, v5.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v17.16b, v27.16b, v17.16b
    mov v28.16b, v6.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v18.16b, v28.16b, v18.16b
    mov v29.16b, v7.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v19.16b, v29.16b, v19.16b
    mov v30.16b, v20.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v0.16b, v30.16b, v0.16b
    mov v31.16b, v21.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v1.16b, v31.16b, v1.16b
    mov v8.16b, v22.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v2.16b, v8.16b, v2.16b
    mov v9.16b, v23.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v3.16b, v9.16b, v3.16b
    aese v4.16b, v25.16b
    aese v20.16b, v25.16b
    aese v20.16b, v24.16b
    aesmc v20.16b, v20.16b
    aese v5.16b, v25.16b
    aese v21.16b, v25.16b
    aese v21.16b, v24.16b
    aesmc v21.16b, v21.16b
    aese v6.16b, v25.16b
    aese v22.16b, v25.16b
    aese v22.16b, v24.16b
    aesmc v22.16b, v22.16b
    aese v7.16b, v25.16b
    aese v23.16b, v25.16b
    aese v23.16b, v24.16b
    aesmc v23.16b, v23.16b
    ld1 { v24.16b }, [x4], #16
    mov v26.16b, v16.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v20.16b, v26.16b, v20.16b
    mov v27.16b, v17.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v21.16b, v27.16b, v21.16b
    mov v28.16b, v18.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v22.16b, v28.16b, v22.16b
    mov v29.16b, v19.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v23.16b, v29.16b, v23.16b
    mov v30.16b, v0.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v30.16b, v4.16b
    mov v31.16b, v1.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v5.16b, v31.16b, v5.16b
    mov v8.16b, v2.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v6.16b, v8.16b, v6.16b
    mov v9.16b, v3.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v7.16b, v9.16b, v7.16b
    aese v16.16b, v25.16b
    aese v0.16b, v25.16b
    aese v0.16b, v24.16b
    aesmc v0.16b, v0.16b
    aese v17.16b, v25.16b
    aese v1.16b, v25.16b
    aese v1.16b, v24.16b
    aesmc v1.16b, v1.16b
    aese v18.16b, v25.16b
    aese v2.16b, v25.16b
    aese v2.16b, v24.16b
    aesmc v2.16b, v2.16b
    aese v19.16b, v25.16b
    aese v3.16b, v25.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    ld1 { v24.16b }, [x4], #16
    mov v26.16b, v20.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v0.16b, v26.16b, v0.16b
    mov v27.16b, v21.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v27.16b, v1.16b
    mov v28.16b, v22.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v2.16b, v28.16b, v2.16b
    mov v29.16b, v23.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v29.16b, v3.16b
    mov v30.16b, v4.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v16.16b, v30.16b, v16.16b
    mov v31.16b, v5.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v17.16b, v31.16b, v17.16b
    mov v8.16b, v6.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v18.16b, v8.16b, v18.16b
    mov v9.16b, v7.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v19.16b, v9.16b, v19.16b
    aese v20.16b, v25.16b
    aese v4.16b, v25.16b
    aese v4.16b, v24.16b
    aesmc v4.16b, v4.16b
    aese v21.16b, v25.16b
    aese v5.16b, v25.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    aese v22.16b, v25.16b
    aese v6.16b, v25.16b
    aese v6.16b, v24.16b
    aesmc v6.16b, v6.16b
    aese v23.16b, v25.16b
    aese v7.16b, v25.16b
    aese v7.16b, v24.16b
    aesmc v7.16b, v7.16b
    ld1 { v24.16b }, [x4], #16
    mov v26.16b, v0.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v4.16b, v26.16b, v4.16b
    mov v27.16b, v1.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v5.16b, v27.16b, v5.16b
    mov v28.16b, v2.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v6.16b, v28.16b, v6.16b
    mov v29.16b, v3.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v7.16b, v29.16b, v7.16b
    mov v30.16b, v16.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v20.16b, v30.16b, v20.16b
    mov v31.16b, v17.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v21.16b, v31.16b, v21.16b
    mov v8.16b, v18.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v22.16b, v8.16b, v22.16b
    mov v9.16b, v19.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v23.16b, v9.16b, v23.16b
    aese v0.16b, v25.16b
    aese v16.16b, v25.16b
    aese v16.16b, v24.16b
    aesmc v16.16b, v16.16b
    aese v1.16b, v25.16b
    aese v17.16b, v25.16b
    aese v17.16b, v24.16b
    aesmc v17.16b, v17.16b
    aese v2.16b, v25.16b
    aese v18.16b, v25.16b
    aese v18.16b, v24.16b
    aesmc v18.16b, v18.16b
    aese v3.16b, v25.16b
    aese v19.16b, v25.16b
    aese v19.16b, v24.16b
    aesmc v19.16b, v19.16b
    ld1 { v24.16b }, [x4], #16
    mov v26.16b, v4.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v16.16b, v26.16b, v16.16b
    mov v27.16b, v5.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v17.16b, v27.16b, v17.16b
    mov v28.16b, v6.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v18.16b, v28.16b, v18.16b
    mov v29.16b, v7.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v19.16b, v29.16b, v19.16b
    mov v30.16b, v20.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v0.16b, v30.16b, v0.16b
    mov v31.16b, v21.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v1.16b, v31.16b, v1.16b
    mov v8.16b, v22.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v2.16b, v8.16b, v2.16b
    mov v9.16b, v23.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v3.16b, v9.16b, v3.16b
    aese v4.16b, v25.16b
    aese v20.16b, v25.16b
    aese v20.16b, v24.16b
    aesmc v20.16b, v20.16b
    aese v5.16b, v25.16b
    aese v21.16b, v25.16b
    aese v21.16b, v24.16b
    aesmc v21.16b, v21.16b
    aese v6.16b, v25.16b
    aese v22.16b, v25.16b
    aese v22.16b, v24.16b
    aesmc v22.16b, v22.16b
    aese v7.16b, v25.16b
    aese v23.16b, v25.16b
    aese v23.16b, v24.16b
    aesmc v23.16b, v23.16b
    ld1 { v24.16b }, [x4], #16
    mov v26.16b, v16.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v20.16b, v26.16b, v20.16b
    mov v27.16b, v17.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v21.16b, v27.16b, v21.16b
    mov v28.16b, v18.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v22.16b, v28.16b, v22.16b
    mov v29.16b, v19.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v23.16b, v29.16b, v23.16b
    mov v30.16b, v0.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v30.16b, v4.16b
    mov v31.16b, v1.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v5.16b, v31.16b, v5.16b
    mov v8.16b, v2.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v6.16b, v8.16b, v6.16b
    mov v9.16b, v3.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v7.16b, v9.16b, v7.16b
    aese v16.16b, v25.16b
    aese v0.16b, v25.16b
    aese v0.16b, v24.16b
    aesmc v0.16b, v0.16b
    aese v17.16b, v25.16b
    aese v1.16b, v25.16b
    aese v1.16b, v24.16b
    aesmc v1.16b, v1.16b
    aese v18.16b, v25.16b
    aese v2.16b, v25.16b
    aese v2.16b, v24.16b
    aesmc v2.16b, v2.16b
    aese v19.16b, v25.16b
    aese v3.16b, v25.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    ld1 { v24.16b }, [x4], #16
    mov v26.16b, v20.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v0.16b, v26.16b, v0.16b
    mov v27.16b, v21.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v27.16b, v1.16b
    mov v28.16b, v22.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v2.16b, v28.16b, v2.16b
    mov v29.16b, v23.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v29.16b, v3.16b
    mov v30.16b, v4.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v16.16b, v30.16b, v16.16b
    mov v31.16b, v5.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v17.16b, v31.16b, v17.16b
    mov v8.16b, v6.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v18.16b, v8.16b, v18.16b
    mov v9.16b, v7.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v19.16b, v9.16b, v19.16b
    aese v20.16b, v25.16b
    aese v4.16b, v25.16b
    aese v4.16b, v24.16b
    aesmc v4.16b, v4.16b
    aese v21.16b, v25.16b
    aese v5.16b, v25.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    aese v22.16b, v25.16b
    aese v6.16b, v25.16b
    aese v6.16b, v24.16b
    aesmc v6.16b, v6.16b
    aese v23.16b, v25.16b
    aese v7.16b, v25.16b
    aese v7.16b, v24.16b
    aesmc v7.16b, v7.16b
    ld1 { v24.16b }, [x4], #16
    mov v26.16b, v0.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v4.16b, v26.16b, v4.16b
    mov v27.16b, v1.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v5.16b, v27.16b, v5.16b
    mov v28.16b, v2.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v6.16b, v28.16b, v6.16b
    mov v29.16b, v3.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v7.16b, v29.16b, v7.16b
    mov v30.16b, v16.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v20.16b, v30.16b, v20.16b
    mov v31.16b, v17.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v21.16b, v31.16b, v21.16b
    mov v8.16b, v18.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v22.16b, v8.16b, v22.16b
    mov v9.16b, v19.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v23.16b, v9.16b, v23.16b
    aese v0.16b, v25.16b
    aese v16.16b, v25.16b
    aese v16.16b, v24.16b
    aesmc v16.16b, v16.16b
    aese v1.16b, v25.16b
    aese v17.16b, v25.16b
    aese v17.16b, v24.16b
    aesmc v17.16b, v17.16b
    aese v2.16b, v25.16b
    aese v18.16b, v25.16b
    aese v18.16b, v24.16b
    aesmc v18.16b, v18.16b
    aese v3.16b, v25.16b
    aese v19.16b, v25.16b
    aese v19.16b, v24.16b
    aesmc v19.16b, v19.16b
    ld1 { v24.16b }, [x4], #16
    mov v26.16b, v4.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v16.16b, v26.16b, v16.16b
    mov v27.16b, v5.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v17.16b, v27.16b, v17.16b
    mov v28.16b, v6.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v18.16b, v28.16b, v18.16b
    mov v29.16b, v7.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v19.16b, v29.16b, v19.16b
    mov v30.16b, v20.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v0.16b, v30.16b, v0.16b
    mov v31.16b, v21.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v1.16b, v31.16b, v1.16b
    mov v8.16b, v22.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v2.16b, v8.16b, v2.16b
    mov v9.16b, v23.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v3.16b, v9.16b, v3.16b
    aese v4.16b, v25.16b
    aese v20.16b, v25.16b
    aese v20.16b, v24.16b
    aesmc v20.16b, v20.16b
    aese v5.16b, v25.16b
    aese v21.16b, v25.16b
    aese v21.16b, v24.16b
    aesmc v21.16b, v21.16b
    aese v6.16b, v25.16b
    aese v22.16b, v25.16b
    aese v22.16b, v24.16b
    aesmc v22.16b, v22.16b
    aese v7.16b, v25.16b
    aese v23.16b, v25.16b
    aese v23.16b, v24.16b
    aesmc v23.16b, v23.16b
    ld1 { v24.16b }, [x4], #16
    mov v26.16b, v16.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v20.16b, v26.16b, v20.16b
    mov v27.16b, v17.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v21.16b, v27.16b, v21.16b
    mov v28.16b, v18.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v22.16b, v28.16b, v22.16b
    mov v29.16b, v19.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v23.16b, v29.16b, v23.16b
    mov v30.16b, v0.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v30.16b, v4.16b
    mov v31.16b, v1.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v5.16b, v31.16b, v5.16b
    mov v8.16b, v2.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v6.16b, v8.16b, v6.16b
    mov v9.16b, v3.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v7.16b, v9.16b, v7.16b
    aese v16.16b, v25.16b
    aese v0.16b, v25.16b
    aese v0.16b, v24.16b
    aesmc v0.16b, v0.16b
    aese v17.16b, v25.16b
    aese v1.16b, v25.16b
    aese v1.16b, v24.16b
    aesmc v1.16b, v1.16b
    aese v18.16b, v25.16b
    aese v2.16b, v25.16b
    aese v2.16b, v24.16b
    aesmc v2.16b, v2.16b
    aese v19.16b, v25.16b
    aese v3.16b, v25.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    st1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x0]
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    st1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x2]
    st1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x3]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    eor v31.16b, v31.16b, v31.16b
    eor v8.16b, v8.16b, v8.16b
    eor v9.16b, v9.16b, v9.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ldp d8, d9, [sp]
    stp xzr, xzr, [sp], #16
    ret
AREION_FUNC_END(areion512Permutex4RC)

AREION_FUNC_START(areion512InversePermutex4RC)
    stp d8, d9, [sp, #-16]!
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x2]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x3]
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x0]
    eor v25.16b, v25.16b, v25.16b
    add x5, x4, #224
    ld1 { v24.16b }, [x5]
    aesd v16.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v25.16b
    aesd v0.16b, v24.16b
    aesd v17.16b, v25.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v25.16b
    aesd v1.16b, v24.16b
    aesd v18.16b, v25.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v25.16b
    aesd v2.16b, v24.16b
    aesd v19.16b, v25.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v25.16b
    aesd v3.16b, v24.16b
    mov v26.16b, v16.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v20.16b, v26.16b, v20.16b
    mov v27.16b, v17.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v21.16b, v27.16b, v21.16b
    mov v28.16b, v18.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v22.16b, v28.16b, v22.16b
    mov v29.16b, v19.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v23.16b, v29.16b, v23.16b
    mov v30.16b, v0.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v30.16b, v4.16b
    mov v31.16b, v1.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v5.16b, v31.16b, v5.16b
    mov v8.16b, v2.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v6.16b, v8.16b, v6.16b
    mov v9.16b, v3.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v7.16b, v9.16b, v7.16b
    add x5, x4, #208
    ld1 { v24.16b }, [x5]
    aesd v4.16b, v25.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v25.16b
    aesd v20.16b, v24.16b
    aesd v5.16b, v25.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v25.16b
    aesd v21.16b, v24.16b
    aesd v6.16b, v25.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v25.16b
    aesd v22.16b, v24.16b
    aesd v7.16b, v25.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v25.16b
    aesd v23.16b, v24.16b
    mov v26.16b, v4.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v16.16b, v26.16b, v16.16b
    mov v27.16b, v5.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v17.16b, v27.16b, v17.16b
    mov v28.16b, v6.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v18.16b, v28.16b, v18.16b
    mov v29.16b, v7.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v19.16b, v29.16b, v19.16b
    mov v30.16b, v20.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v0.16b, v30.16b, v0.16b
    mov v31.16b, v21.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v1.16b, v31.16b, v1.16b
    mov v8.16b, v22.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v2.16b, v8.16b, v2.16b
    mov v9.16b, v23.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v3.16b, v9.16b, v3.16b
    add x5, x4, #192
    ld1 { v24.16b }, [x5]
    aesd v0.16b, v25.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v25.16b
    aesd v16.16b, v24.16b
    aesd v1.16b, v25.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v25.16b
    aesd v17.16b, v24.16b
    aesd v2.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v25.16b
    aesd v18.16b, v24.16b
    aesd v3.16b, v25.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v25.16b
    aesd v19.16b, v24.16b
    mov v26.16b, v0.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v4.16b, v26.16b, v4.16b
    mov v27.16b, v1.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v5.16b, v27.16b, v5.16b
    mov v28.16b, v2.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v6.16b, v28.16b, v6.16b
    mov v29.16b, v3.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v7.16b, v29.16b, v7.16b
    mov v30.16b, v16.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v20.16b, v30.16b, v20.16b
    mov v31.16b, v17.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v21.16b, v31.16b, v21.16b
    mov v8.16b, v18.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v22.16b, v8.16b, v22.16b
    mov v9.16b, v19.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v23.16b, v9.16b, v23.16b
    add x5, x4, #176
    ld1 { v24.16b }, [x5]
    aesd v20.16b, v25.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v25.16b
    aesd v4.16b, v24.16b
    aesd v21.16b, v25.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v25.16b
    aesd v5.16b, v24.16b
    aesd v22.16b, v25.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v25.16b
    aesd v6.16b, v24.16b
    aesd v23.16b, v25.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v25.16b
    aesd v7.16b, v24.16b
    mov v26.16b, v20.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v0.16b, v26.16b, v0.16b
    mov v27.16b, v21.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v27.16b, v1.16b
    mov v28.16b, v22.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v2.16b, v28.16b, v2.16b
    mov v29.16b, v23.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v29.16b, v3.16b
    mov v30.16b, v4.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v16.16b, v30.16b, v16.16b
    mov v31.16b, v5.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v17.16b, v31.16b, v17.16b
    mov v8.16b, v6.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v18.16b, v8.16b, v18.16b
    mov v9.16b, v7.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v19.16b, v9.16b, v19.16b
    add x5, x4, #160
    ld1 { v24.16b }, [x5]
    aesd v16.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v25.16b
    aesd v0.16b, v24.16b
    aesd v17.16b, v25.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v25.16b
    aesd v1.16b, v24.16b
    aesd v18.16b, v25.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v25.16b
    aesd v2.16b, v24.16b
    aesd v19.16b, v25.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v25.16b
    aesd v3.16b, v24.16b
    mov v26.16b, v16.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v20.16b, v26.16b, v20.16b
    mov v27.16b, v17.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v21.16b, v27.16b, v21.16b
    mov v28.16b, v18.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v22.16b, v28.16b, v22.16b
    mov v29.16b, v19.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v23.16b, v29.16b, v23.16b
    mov v30.16b, v0.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v30.16b, v4.16b
    mov v31.16b, v1.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v5.16b, v31.16b, v5.16b
    mov v8.16b, v2.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v6.16b, v8.16b, v6.16b
    mov v9.16b, v3.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v7.16b, v9.16b, v7.16b
    add x5, x4, #144
    ld1 { v24.16b }, [x5]
    aesd v4.16b, v25.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v25.16b
    aesd v20.16b, v24.16b
    aesd v5.16b, v25.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v25.16b
    aesd v21.16b, v24.16b
    aesd v6.16b, v25.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v25.16b
    aesd v22.16b, v24.16b
    aesd v7.16b, v25.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v25.16b
    aesd v23.16b, v24.16b
    mov v26.16b, v4.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v16.16b, v26.16b, v16.16b
    mov v27.16b, v5.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v17.16b, v27.16b, v17.16b
    mov v28.16b, v6.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v18.16b, v28.16b, v18.16b
    mov v29.16b, v7.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v19.16b, v29.16b, v19.16b
    mov v30.16b, v20.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v0.16b, v30.16b, v0.16b
    mov v31.16b, v21.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v1.16b, v31.16b, v1.16b
    mov v8.16b, v22.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v2.16b, v8.16b, v2.16b
    mov v9.16b, v23.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v3.16b, v9.16b, v3.16b
    add x5, x4, #128
    ld1 { v24.16b }, [x5]
    aesd v0.16b, v25.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v25.16b
    aesd v16.16b, v24.16b
    aesd v1.16b, v25.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v25.16b
    aesd v17.16b, v24.16b
    aesd v2.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v25.16b
    aesd v18.16b, v24.16b
    aesd v3.16b, v25.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v25.16b
    aesd v19.16b, v24.16b
    mov v26.16b, v0.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v4.16b, v26.16b, v4.16b
    mov v27.16b, v1.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v5.16b, v27.16b, v5.16b
    mov v28.16b, v2.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v6.16b, v28.16b, v6.16b
    mov v29.16b, v3.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v7.16b, v29.16b, v7.16b
    mov v30.16b, v16.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v20.16b, v30.16b, v20.16b
    mov v31.16b, v17.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v21.16b, v31.16b, v21.16b
    mov v8.16b, v18.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v22.16b, v8.16b, v22.16b
    mov v9.16b, v19.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v23.16b, v9.16b, v23.16b
    add x5, x4, #112
    ld1 { v24.16b }, [x5]
    aesd v20.16b, v25.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v25.16b
    aesd v4.16b, v24.16b
    aesd v21.16b, v25.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v25.16b
    aesd v5.16b, v24.16b
    aesd v22.16b, v25.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v25.16b
    aesd v6.16b, v24.16b
    aesd v23.16b, v25.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v25.16b
    aesd v7.16b, v24.16b
    mov v26.16b, v20.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v0.16b, v26.16b, v0.16b
    mov v27.16b, v21.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v27.16b, v1.16b
    mov v28.16b, v22.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v2.16b, v28.16b, v2.16b
    mov v29.16b, v23.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v29.16b, v3.16b
    mov v30.16b, v4.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v16.16b, v30.16b, v16.16b
    mov v31.16b, v5.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v17.16b, v31.16b, v17.16b
    mov v8.16b, v6.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v18.16b, v8.16b, v18.16b
    mov v9.16b, v7.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v19.16b, v9.16b, v19.16b
    add x5, x4, #96
    ld1 { v24.16b }, [x5]
    aesd v16.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v25.16b
    aesd v0.16b, v24.16b
    aesd v17.16b, v25.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v25.16b
    aesd v1.16b, v24.16b
    aesd v18.16b, v25.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v25.16b
    aesd v2.16b, v24.16b
    aesd v19.16b, v25.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v25.16b
    aesd v3.16b, v24.16b
    mov v26.16b, v16.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v20.16b, v26.16b, v20.16b
    mov v27.16b, v17.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v21.16b, v27.16b, v21.16b
    mov v28.16b, v18.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v22.16b, v28.16b, v22.16b
    mov v29.16b, v19.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v23.16b, v29.16b, v23.16b
    mov v30.16b, v0.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v30.16b, v4.16b
    mov v31.16b, v1.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v5.16b, v31.16b, v5.16b
    mov v8.16b, v2.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v6.16b, v8.16b, v6.16b
    mov v9.16b, v3.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v7.16b, v9.16b, v7.16b
    add x5, x4, #80
    ld1 { v24.16b }, [x5]
    aesd v4.16b, v25.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v25.16b
    aesd v20.16b, v24.16b
    aesd v5.16b, v25.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v25.16b
    aesd v21.16b, v24.16b
    aesd v6.16b, v25.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v25.16b
    aesd v22.16b, v24.16b
    aesd v7.16b, v25.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v25.16b
    aesd v23.16b, v24.16b
    mov v26.16b, v4.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v16.16b, v26.16b, v16.16b
    mov v27.16b, v5.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v17.16b, v27.16b, v17.16b
    mov v28.16b, v6.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v18.16b, v28.16b, v18.16b
    mov v29.16b, v7.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v19.16b, v29.16b, v19.16b
    mov v30.16b, v20.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v0.16b, v30.16b, v0.16b
    mov v31.16b, v21.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v1.16b, v31.16b, v1.16b
    mov v8.16b, v22.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v2.16b, v8.16b, v2.16b
    mov v9.16b, v23.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v3.16b, v9.16b, v3.16b
    add x5, x4, #64
    ld1 { v24.16b }, [x5]
    aesd v0.16b, v25.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v25.16b
    aesd v16.16b, v24.16b
    aesd v1.16b, v25.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v25.16b
    aesd v17.16b, v24.16b
    aesd v2.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v25.16b
    aesd v18.16b, v24.16b
    aesd v3.16b, v25.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v25.16b
    aesd v19.16b, v24.16b
    mov v26.16b, v0.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v4.16b, v26.16b, v4.16b
    mov v27.16b, v1.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v5.16b, v27.16b, v5.16b
    mov v28.16b, v2.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v6.16b, v28.16b, v6.16b
    mov v29.16b, v3.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v7.16b, v29.16b, v7.16b
    mov v30.16b, v16.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v20.16b, v30.16b, v20.16b
    mov v31.16b, v17.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v21.16b, v31.16b, v21.16b
    mov v8.16b, v18.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v22.16b, v8.16b, v22.16b
    mov v9.16b, v19.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v23.16b, v9.16b, v23.16b
    add x5, x4, #48
    ld1 { v24.16b }, [x5]
    aesd v20.16b, v25.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v25.16b
    aesd v4.16b, v24.16b
    aesd v21.16b, v25.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v25.16b
    aesd v5.16b, v24.16b
    aesd v22.16b, v25.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v25.16b
    aesd v6.16b, v24.16b
    aesd v23.16b, v25.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v25.16b
    aesd v7.16b, v24.16b
    mov v26.16b, v20.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v0.16b, v26.16b, v0.16b
    mov v27.16b, v21.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v27.16b, v1.16b
    mov v28.16b, v22.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v2.16b, v28.16b, v2.16b
    mov v29.16b, v23.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v29.16b, v3.16b
    mov v30.16b, v4.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v16.16b, v30.16b, v16.16b
    mov v31.16b, v5.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v17.16b, v31.16b, v17.16b
    mov v8.16b, v6.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v18.16b, v8.16b, v18.16b
    mov v9.16b, v7.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v19.16b, v9.16b, v19.16b
    add x5, x4, #32
    ld1 { v24.16b }, [x5]
    aesd v16.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v25.16b
    aesd v0.16b, v24.16b
    aesd v17.16b, v25.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v25.16b
    aesd v1.16b, v24.16b
    aesd v18.16b, v25.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v25.16b
    aesd v2.16b, v24.16b
    aesd v19.16b, v25.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v25.16b
    aesd v3.16b, v24.16b
    mov v26.16b, v16.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v20.16b, v26.16b, v20.16b
    mov v27.16b, v17.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v21.16b, v27.16b, v21.16b
    mov v28.16b, v18.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v22.16b, v28.16b, v22.16b
    mov v29.16b, v19.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v23.16b, v29.16b, v23.16b
    mov v30.16b, v0.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v30.16b, v4.16b
    mov v31.16b, v1.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v5.16b, v31.16b, v5.16b
    mov v8.16b, v2.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v6.16b, v8.16b, v6.16b
    mov v9.16b, v3.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v7.16b, v9.16b, v7.16b
    add x5, x4, #16
    ld1 { v24.16b }, [x5]
    aesd v4.16b, v25.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v25.16b
    aesd v20.16b, v24.16b
    aesd v5.16b, v25.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v25.16b
    aesd v21.16b, v24.16b
    aesd v6.16b, v25.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v25.16b
    aesd v22.16b, v24.16b
    aesd v7.16b, v25.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v25.16b
    aesd v23.16b, v24.16b
    mov v26.16b, v4.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v16.16b, v26.16b, v16.16b
    mov v27.16b, v5.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v17.16b, v27.16b, v17.16b
    mov v28.16b, v6.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v18.16b, v28.16b, v18.16b
    mov v29.16b, v7.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v19.16b, v29.16b, v19.16b
    mov v30.16b, v20.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v0.16b, v30.16b, v0.16b
    mov v31.16b, v21.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v1.16b, v31.16b, v1.16b
    mov v8.16b, v22.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v2.16b, v8.16b, v2.16b
    mov v9.16b, v23.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v3.16b, v9.16b, v3.16b
    add x5, x4, #0
    ld1 { v24.16b }, [x5]
    aesd v0.16b, v25.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v25.16b
    aesd v16.16b, v24.16b
    aesd v1.16b, v25.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v25.16b
    aesd v17.16b, v24.16b
    aesd v2.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v25.16b
    aesd v18.16b, v24.16b
    aesd v3.16b, v25.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v25.16b
    aesd v19.16b, v24.16b
    mov v26.16b, v0.16b
    aese v26.16b, v25.16b
    aesmc v26.16b, v26.16b
    eor v4.16b, v26.16b, v4.16b
    mov v27.16b, v1.16b
    aese v27.16b, v25.16b
    aesmc v27.16b, v27.16b
    eor v5.16b, v27.16b, v5.16b
    mov v28.16b, v2.16b
    aese v28.16b, v25.16b
    aesmc v28.16b, v28.16b
    eor v6.16b, v28.16b, v6.16b
    mov v29.16b, v3.16b
    aese v29.16b, v25.16b
    aesmc v29.16b, v29.16b
    eor v7.16b, v29.16b, v7.16b
    mov v30.16b, v16.16b
    aese v30.16b, v25.16b
    aesmc v30.16b, v30.16b
    eor v20.16b, v30.16b, v20.16b
    mov v31.16b, v17.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    eor v21.16b, v31.16b, v21.16b
    mov v8.16b, v18.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    eor v22.16b, v8.16b, v22.16b
    mov v9.16b, v19.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    eor v23.16b, v9.16b, v23.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    st1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    st1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    st1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x3]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    eor v31.16b, v31.16b, v31.16b
    eor v8.16b, v8.16b, v8.16b
    eor v9.16b, v9.16b, v9.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    mov x5, xzr
    ldp d8, d9, [sp]
    stp xzr, xzr, [sp], #16
    ret
AREION_FUNC_END(areion512InversePermutex4RC)

AREION_FUNC_START(areion256SoEMPermutex4NEON)
    sub sp, sp, #32
    stp d8, d9, [sp]
    str d10, [sp, #16]
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x3]
    eor v26.16b, v26.16b, v26.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    AREION_ARM64_ADR(x5, roundConstantsP2)
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x5], #16
    mov v27.16b, v0.16b
    mov v31.16b, v16.16b
    mov v28.16b, v1.16b
    mov v8.16b, v17.16b
    mov v29.16b, v2.16b
    mov v9.16b, v18.16b
    mov v30.16b, v3.16b
    mov v10.16b, v19.16b
    aese v27.16b, v26.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v26.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v26.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v26.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v26.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v26.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v26.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v26.16b
    aesmc v10.16b, v10.16b
    aese v27.16b, v24.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v24.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v24.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v24.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v25.16b
    aesmc v10.16b, v10.16b
    eor v4.16b, v4.16b, v27.16b
    eor v20.16b, v20.16b, v31.16b
    aese v0.16b, v26.16b
    aese v16.16b, v26.16b
    eor v5.16b, v5.16b, v28.16b
    eor v21.16b, v21.16b, v8.16b
    aese v1.16b, v26.16b
    aese v17.16b, v26.16b
    eor v6.16b, v6.16b, v29.16b
    eor v22.16b, v22.16b, v9.16b
    aese v2.16b, v26.16b
    aese v18.16b, v26.16b
    eor v7.16b, v7.16b, v30.16b
    eor v23.16b, v23.16b, v10.16b
    aese v3.16b, v26.16b
    aese v19.16b, v26.16b
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x5], #16
    mov v27.16b, v4.16b
    mov v31.16b, v20.16b
    mov v28.16b, v5.16b
    mov v8.16b, v21.16b
    mov v29.16b, v6.16b
    mov v9.16b, v22.16b
    mov v30.16b, v7.16b
    mov v10.16b, v23.16b
    aese v27.16b, v26.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v26.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v26.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v26.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v26.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v26.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v26.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v26.16b
    aesmc v10.16b, v10.16b
    aese v27.16b, v24.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v24.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v24.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v24.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v25.16b
    aesmc v10.16b, v10.16b
    eor v0.16b, v0.16b, v27.16b
    eor v16.16b, v16.16b, v31.16b
    aese v4.16b, v26.16b
    aese v20.16b, v26.16b
    eor v1.16b, v1.16b, v28.16b
    eor v17.16b, v17.16b, v8.16b
    aese v5.16b, v26.16b
    aese v21.16b, v26.16b
    eor v2.16b, v2.16b, v29.16b
    eor v18.16b, v18.16b, v9.16b
    aese v6.16b, v26.16b
    aese v22.16b, v26.16b
    eor v3.16b, v3.16b, v30.16b
    eor v19.16b, v19.16b, v10.16b
    aese v7.16b, v26.16b
    aese v23.16b, v26.16b
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x5], #16
    mov v27.16b, v0.16b
    mov v31.16b, v16.16b
    mov v28.16b, v1.16b
    mov v8.16b, v17.16b
    mov v29.16b, v2.16b
    mov v9.16b, v18.16b
    mov v30.16b, v3.16b
    mov v10.16b, v19.16b
    aese v27.16b, v26.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v26.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v26.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v26.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v26.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v26.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v26.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v26.16b
    aesmc v10.16b, v10.16b
    aese v27.16b, v24.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v24.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v24.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v24.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v25.16b
    aesmc v10.16b, v10.16b
    eor v4.16b, v4.16b, v27.16b
    eor v20.16b, v20.16b, v31.16b
    aese v0.16b, v26.16b
    aese v16.16b, v26.16b
    eor v5.16b, v5.16b, v28.16b
    eor v21.16b, v21.16b, v8.16b
    aese v1.16b, v26.16b
    aese v17.16b, v26.16b
    eor v6.16b, v6.16b, v29.16b
    eor v22.16b, v22.16b, v9.16b
    aese v2.16b, v26.16b
    aese v18.16b, v26.16b
    eor v7.16b, v7.16b, v30.16b
    eor v23.16b, v23.16b, v10.16b
    aese v3.16b, v26.16b
    aese v19.16b, v26.16b
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x5], #16
    mov v27.16b, v4.16b
    mov v31.16b, v20.16b
    mov v28.16b, v5.16b
    mov v8.16b, v21.16b
    mov v29.16b, v6.16b
    mov v9.16b, v22.16b
    mov v30.16b, v7.16b
    mov v10.16b, v23.16b
    aese v27.16b, v26.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v26.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v26.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v26.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v26.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v26.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v26.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v26.16b
    aesmc v10.16b, v10.16b
    aese v27.16b, v24.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v24.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v24.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v24.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v25.16b
    aesmc v10.16b, v10.16b
    eor v0.16b, v0.16b, v27.16b
    eor v16.16b, v16.16b, v31.16b
    aese v4.16b, v26.16b
    aese v20.16b, v26.16b
    eor v1.16b, v1.16b, v28.16b
    eor v17.16b, v17.16b, v8.16b
    aese v5.16b, v26.16b
    aese v21.16b, v26.16b
    eor v2.16b, v2.16b, v29.16b
    eor v18.16b, v18.16b, v9.16b
    aese v6.16b, v26.16b
    aese v22.16b, v26.16b
    eor v3.16b, v3.16b, v30.16b
    eor v19.16b, v19.16b, v10.16b
    aese v7.16b, v26.16b
    aese v23.16b, v26.16b
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x5], #16
    mov v27.16b, v0.16b
    mov v31.16b, v16.16b
    mov v28.16b, v1.16b
    mov v8.16b, v17.16b
    mov v29.16b, v2.16b
    mov v9.16b, v18.16b
    mov v30.16b, v3.16b
    mov v10.16b, v19.16b
    aese v27.16b, v26.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v26.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v26.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v26.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v26.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v26.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v26.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v26.16b
    aesmc v10.16b, v10.16b
    aese v27.16b, v24.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v24.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v24.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v24.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v25.16b
    aesmc v10.16b, v10.16b
    eor v4.16b, v4.16b, v27.16b
    eor v20.16b, v20.16b, v31.16b
    aese v0.16b, v26.16b
    aese v16.16b, v26.16b
    eor v5.16b, v5.16b, v28.16b
    eor v21.16b, v21.16b, v8.16b
    aese v1.16b, v26.16b
    aese v17.16b, v26.16b
    eor v6.16b, v6.16b, v29.16b
    eor v22.16b, v22.16b, v9.16b
    aese v2.16b, v26.16b
    aese v18.16b, v26.16b
    eor v7.16b, v7.16b, v30.16b
    eor v23.16b, v23.16b, v10.16b
    aese v3.16b, v26.16b
    aese v19.16b, v26.16b
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x5], #16
    mov v27.16b, v4.16b
    mov v31.16b, v20.16b
    mov v28.16b, v5.16b
    mov v8.16b, v21.16b
    mov v29.16b, v6.16b
    mov v9.16b, v22.16b
    mov v30.16b, v7.16b
    mov v10.16b, v23.16b
    aese v27.16b, v26.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v26.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v26.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v26.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v26.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v26.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v26.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v26.16b
    aesmc v10.16b, v10.16b
    aese v27.16b, v24.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v24.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v24.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v24.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v25.16b
    aesmc v10.16b, v10.16b
    eor v0.16b, v0.16b, v27.16b
    eor v16.16b, v16.16b, v31.16b
    aese v4.16b, v26.16b
    aese v20.16b, v26.16b
    eor v1.16b, v1.16b, v28.16b
    eor v17.16b, v17.16b, v8.16b
    aese v5.16b, v26.16b
    aese v21.16b, v26.16b
    eor v2.16b, v2.16b, v29.16b
    eor v18.16b, v18.16b, v9.16b
    aese v6.16b, v26.16b
    aese v22.16b, v26.16b
    eor v3.16b, v3.16b, v30.16b
    eor v19.16b, v19.16b, v10.16b
    aese v7.16b, v26.16b
    aese v23.16b, v26.16b
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x5], #16
    mov v27.16b, v0.16b
    mov v31.16b, v16.16b
    mov v28.16b, v1.16b
    mov v8.16b, v17.16b
    mov v29.16b, v2.16b
    mov v9.16b, v18.16b
    mov v30.16b, v3.16b
    mov v10.16b, v19.16b
    aese v27.16b, v26.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v26.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v26.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v26.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v26.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v26.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v26.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v26.16b
    aesmc v10.16b, v10.16b
    aese v27.16b, v24.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v24.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v24.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v24.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v25.16b
    aesmc v10.16b, v10.16b
    eor v4.16b, v4.16b, v27.16b
    eor v20.16b, v20.16b, v31.16b
    aese v0.16b, v26.16b
    aese v16.16b, v26.16b
    eor v5.16b, v5.16b, v28.16b
    eor v21.16b, v21.16b, v8.16b
    aese v1.16b, v26.16b
    aese v17.16b, v26.16b
    eor v6.16b, v6.16b, v29.16b
    eor v22.16b, v22.16b, v9.16b
    aese v2.16b, v26.16b
    aese v18.16b, v26.16b
    eor v7.16b, v7.16b, v30.16b
    eor v23.16b, v23.16b, v10.16b
    aese v3.16b, v26.16b
    aese v19.16b, v26.16b
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x5], #16
    mov v27.16b, v4.16b
    mov v31.16b, v20.16b
    mov v28.16b, v5.16b
    mov v8.16b, v21.16b
    mov v29.16b, v6.16b
    mov v9.16b, v22.16b
    mov v30.16b, v7.16b
    mov v10.16b, v23.16b
    aese v27.16b, v26.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v26.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v26.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v26.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v26.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v26.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v26.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v26.16b
    aesmc v10.16b, v10.16b
    aese v27.16b, v24.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v24.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v24.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v24.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v25.16b
    aesmc v10.16b, v10.16b
    eor v0.16b, v0.16b, v27.16b
    eor v16.16b, v16.16b, v31.16b
    aese v4.16b, v26.16b
    aese v20.16b, v26.16b
    eor v1.16b, v1.16b, v28.16b
    eor v17.16b, v17.16b, v8.16b
    aese v5.16b, v26.16b
    aese v21.16b, v26.16b
    eor v2.16b, v2.16b, v29.16b
    eor v18.16b, v18.16b, v9.16b
    aese v6.16b, v26.16b
    aese v22.16b, v26.16b
    eor v3.16b, v3.16b, v30.16b
    eor v19.16b, v19.16b, v10.16b
    aese v7.16b, v26.16b
    aese v23.16b, v26.16b
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x5], #16
    mov v27.16b, v0.16b
    mov v31.16b, v16.16b
    mov v28.16b, v1.16b
    mov v8.16b, v17.16b
    mov v29.16b, v2.16b
    mov v9.16b, v18.16b
    mov v30.16b, v3.16b
    mov v10.16b, v19.16b
    aese v27.16b, v26.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v26.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v26.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v26.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v26.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v26.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v26.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v26.16b
    aesmc v10.16b, v10.16b
    aese v27.16b, v24.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v24.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v24.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v24.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v25.16b
    aesmc v10.16b, v10.16b
    eor v4.16b, v4.16b, v27.16b
    eor v20.16b, v20.16b, v31.16b
    aese v0.16b, v26.16b
    aese v16.16b, v26.16b
    eor v5.16b, v5.16b, v28.16b
    eor v21.16b, v21.16b, v8.16b
    aese v1.16b, v26.16b
    aese v17.16b, v26.16b
    eor v6.16b, v6.16b, v29.16b
    eor v22.16b, v22.16b, v9.16b
    aese v2.16b, v26.16b
    aese v18.16b, v26.16b
    eor v7.16b, v7.16b, v30.16b
    eor v23.16b, v23.16b, v10.16b
    aese v3.16b, v26.16b
    aese v19.16b, v26.16b
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x5], #16
    mov v27.16b, v4.16b
    mov v31.16b, v20.16b
    mov v28.16b, v5.16b
    mov v8.16b, v21.16b
    mov v29.16b, v6.16b
    mov v9.16b, v22.16b
    mov v30.16b, v7.16b
    mov v10.16b, v23.16b
    aese v27.16b, v26.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v26.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v26.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v26.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v26.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v26.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v26.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v26.16b
    aesmc v10.16b, v10.16b
    aese v27.16b, v24.16b
    aesmc v27.16b, v27.16b
    aese v31.16b, v25.16b
    aesmc v31.16b, v31.16b
    aese v28.16b, v24.16b
    aesmc v28.16b, v28.16b
    aese v8.16b, v25.16b
    aesmc v8.16b, v8.16b
    aese v29.16b, v24.16b
    aesmc v29.16b, v29.16b
    aese v9.16b, v25.16b
    aesmc v9.16b, v9.16b
    aese v30.16b, v24.16b
    aesmc v30.16b, v30.16b
    aese v10.16b, v25.16b
    aesmc v10.16b, v10.16b
    eor v0.16b, v0.16b, v27.16b
    eor v16.16b, v16.16b, v31.16b
    aese v4.16b, v26.16b
    aese v20.16b, v26.16b
    eor v1.16b, v1.16b, v28.16b
    eor v17.16b, v17.16b, v8.16b
    aese v5.16b, v26.16b
    aese v21.16b, v26.16b
    eor v2.16b, v2.16b, v29.16b
    eor v18.16b, v18.16b, v9.16b
    aese v6.16b, v26.16b
    aese v22.16b, v26.16b
    eor v3.16b, v3.16b, v30.16b
    eor v19.16b, v19.16b, v10.16b
    aese v7.16b, v26.16b
    aese v23.16b, v26.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    st1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    eor v31.16b, v31.16b, v31.16b
    eor v8.16b, v8.16b, v8.16b
    eor v9.16b, v9.16b, v9.16b
    eor v10.16b, v10.16b, v10.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    eor v26.16b, v26.16b, v26.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    mov x5, xzr
    ldp d8, d9, [sp]
    ldr d10, [sp, #16]
    stp xzr, xzr, [sp]
    str xzr, [sp, #16]
    add sp, sp, #32
    ret
AREION_FUNC_END(areion256SoEMPermutex4NEON)

AREION_FUNC_START(areion512SoEMPermutex4NEON)
    sub sp, sp, #32
    stp d8, d9, [sp]
    str d10, [sp, #16]
    eor v26.16b, v26.16b, v26.16b
    ld1 { v0.16b, v1.16b }, [x0]
    ld1 { v2.16b, v3.16b }, [x1]
    ld1 { v4.16b, v5.16b }, [x2]
    ld1 { v6.16b, v7.16b }, [x3], #32
    ld1 { v16.16b, v17.16b }, [x4], #32
    ld1 { v18.16b, v19.16b }, [x5], #32
    ld1 { v20.16b, v21.16b }, [x6], #32
    ld1 { v22.16b, v23.16b }, [x7], #32
    AREION_ARM64_ADR(x8, roundConstantsP1)
    AREION_ARM64_ADR(x9, roundConstantsP2)
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v0.16b
    mov v28.16b, v1.16b
    mov v29.16b, v16.16b
    mov v30.16b, v17.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v28.16b
    eor v18.16b, v18.16b, v29.16b
    eor v19.16b, v19.16b, v30.16b
    mov v31.16b, v4.16b
    mov v8.16b, v5.16b
    mov v9.16b, v20.16b
    mov v10.16b, v21.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v6.16b, v6.16b, v31.16b
    eor v7.16b, v7.16b, v8.16b
    eor v22.16b, v22.16b, v9.16b
    eor v23.16b, v23.16b, v10.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v4.16b, v24.16b
    aese v5.16b, v24.16b
    aese v20.16b, v25.16b
    aese v21.16b, v25.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v20.16b, v20.16b
    aesmc v21.16b, v21.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v2.16b
    mov v28.16b, v3.16b
    mov v29.16b, v18.16b
    mov v30.16b, v19.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v4.16b, v27.16b
    eor v5.16b, v5.16b, v28.16b
    eor v20.16b, v20.16b, v29.16b
    eor v21.16b, v21.16b, v30.16b
    mov v31.16b, v6.16b
    mov v8.16b, v7.16b
    mov v9.16b, v22.16b
    mov v10.16b, v23.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v0.16b, v0.16b, v31.16b
    eor v1.16b, v1.16b, v8.16b
    eor v16.16b, v16.16b, v9.16b
    eor v17.16b, v17.16b, v10.16b
    aese v2.16b, v26.16b
    aese v3.16b, v26.16b
    aese v18.16b, v26.16b
    aese v19.16b, v26.16b
    aese v6.16b, v26.16b
    aese v7.16b, v26.16b
    aese v22.16b, v26.16b
    aese v23.16b, v26.16b
    aese v6.16b, v24.16b
    aese v7.16b, v24.16b
    aese v22.16b, v25.16b
    aese v23.16b, v25.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesmc v22.16b, v22.16b
    aesmc v23.16b, v23.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v4.16b
    mov v28.16b, v5.16b
    mov v29.16b, v20.16b
    mov v30.16b, v21.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v6.16b, v6.16b, v27.16b
    eor v7.16b, v7.16b, v28.16b
    eor v22.16b, v22.16b, v29.16b
    eor v23.16b, v23.16b, v30.16b
    mov v31.16b, v0.16b
    mov v8.16b, v1.16b
    mov v9.16b, v16.16b
    mov v10.16b, v17.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v2.16b, v2.16b, v31.16b
    eor v3.16b, v3.16b, v8.16b
    eor v18.16b, v18.16b, v9.16b
    eor v19.16b, v19.16b, v10.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v0.16b, v24.16b
    aese v1.16b, v24.16b
    aese v16.16b, v25.16b
    aese v17.16b, v25.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v16.16b, v16.16b
    aesmc v17.16b, v17.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v6.16b
    mov v28.16b, v7.16b
    mov v29.16b, v22.16b
    mov v30.16b, v23.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v0.16b, v0.16b, v27.16b
    eor v1.16b, v1.16b, v28.16b
    eor v16.16b, v16.16b, v29.16b
    eor v17.16b, v17.16b, v30.16b
    mov v31.16b, v2.16b
    mov v8.16b, v3.16b
    mov v9.16b, v18.16b
    mov v10.16b, v19.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v4.16b, v4.16b, v31.16b
    eor v5.16b, v5.16b, v8.16b
    eor v20.16b, v20.16b, v9.16b
    eor v21.16b, v21.16b, v10.16b
    aese v6.16b, v26.16b
    aese v7.16b, v26.16b
    aese v22.16b, v26.16b
    aese v23.16b, v26.16b
    aese v2.16b, v26.16b
    aese v3.16b, v26.16b
    aese v18.16b, v26.16b
    aese v19.16b, v26.16b
    aese v2.16b, v24.16b
    aese v3.16b, v24.16b
    aese v18.16b, v25.16b
    aese v19.16b, v25.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v18.16b, v18.16b
    aesmc v19.16b, v19.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v0.16b
    mov v28.16b, v1.16b
    mov v29.16b, v16.16b
    mov v30.16b, v17.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v28.16b
    eor v18.16b, v18.16b, v29.16b
    eor v19.16b, v19.16b, v30.16b
    mov v31.16b, v4.16b
    mov v8.16b, v5.16b
    mov v9.16b, v20.16b
    mov v10.16b, v21.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v6.16b, v6.16b, v31.16b
    eor v7.16b, v7.16b, v8.16b
    eor v22.16b, v22.16b, v9.16b
    eor v23.16b, v23.16b, v10.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v4.16b, v24.16b
    aese v5.16b, v24.16b
    aese v20.16b, v25.16b
    aese v21.16b, v25.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v20.16b, v20.16b
    aesmc v21.16b, v21.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v2.16b
    mov v28.16b, v3.16b
    mov v29.16b, v18.16b
    mov v30.16b, v19.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v4.16b, v27.16b
    eor v5.16b, v5.16b, v28.16b
    eor v20.16b, v20.16b, v29.16b
    eor v21.16b, v21.16b, v30.16b
    mov v31.16b, v6.16b
    mov v8.16b, v7.16b
    mov v9.16b, v22.16b
    mov v10.16b, v23.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v0.16b, v0.16b, v31.16b
    eor v1.16b, v1.16b, v8.16b
    eor v16.16b, v16.16b, v9.16b
    eor v17.16b, v17.16b, v10.16b
    aese v2.16b, v26.16b
    aese v3.16b, v26.16b
    aese v18.16b, v26.16b
    aese v19.16b, v26.16b
    aese v6.16b, v26.16b
    aese v7.16b, v26.16b
    aese v22.16b, v26.16b
    aese v23.16b, v26.16b
    aese v6.16b, v24.16b
    aese v7.16b, v24.16b
    aese v22.16b, v25.16b
    aese v23.16b, v25.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesmc v22.16b, v22.16b
    aesmc v23.16b, v23.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v4.16b
    mov v28.16b, v5.16b
    mov v29.16b, v20.16b
    mov v30.16b, v21.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v6.16b, v6.16b, v27.16b
    eor v7.16b, v7.16b, v28.16b
    eor v22.16b, v22.16b, v29.16b
    eor v23.16b, v23.16b, v30.16b
    mov v31.16b, v0.16b
    mov v8.16b, v1.16b
    mov v9.16b, v16.16b
    mov v10.16b, v17.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v2.16b, v2.16b, v31.16b
    eor v3.16b, v3.16b, v8.16b
    eor v18.16b, v18.16b, v9.16b
    eor v19.16b, v19.16b, v10.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v0.16b, v24.16b
    aese v1.16b, v24.16b
    aese v16.16b, v25.16b
    aese v17.16b, v25.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v16.16b, v16.16b
    aesmc v17.16b, v17.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v6.16b
    mov v28.16b, v7.16b
    mov v29.16b, v22.16b
    mov v30.16b, v23.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v0.16b, v0.16b, v27.16b
    eor v1.16b, v1.16b, v28.16b
    eor v16.16b, v16.16b, v29.16b
    eor v17.16b, v17.16b, v30.16b
    mov v31.16b, v2.16b
    mov v8.16b, v3.16b
    mov v9.16b, v18.16b
    mov v10.16b, v19.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v4.16b, v4.16b, v31.16b
    eor v5.16b, v5.16b, v8.16b
    eor v20.16b, v20.16b, v9.16b
    eor v21.16b, v21.16b, v10.16b
    aese v6.16b, v26.16b
    aese v7.16b, v26.16b
    aese v22.16b, v26.16b
    aese v23.16b, v26.16b
    aese v2.16b, v26.16b
    aese v3.16b, v26.16b
    aese v18.16b, v26.16b
    aese v19.16b, v26.16b
    aese v2.16b, v24.16b
    aese v3.16b, v24.16b
    aese v18.16b, v25.16b
    aese v19.16b, v25.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v18.16b, v18.16b
    aesmc v19.16b, v19.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v0.16b
    mov v28.16b, v1.16b
    mov v29.16b, v16.16b
    mov v30.16b, v17.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v28.16b
    eor v18.16b, v18.16b, v29.16b
    eor v19.16b, v19.16b, v30.16b
    mov v31.16b, v4.16b
    mov v8.16b, v5.16b
    mov v9.16b, v20.16b
    mov v10.16b, v21.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v6.16b, v6.16b, v31.16b
    eor v7.16b, v7.16b, v8.16b
    eor v22.16b, v22.16b, v9.16b
    eor v23.16b, v23.16b, v10.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v4.16b, v24.16b
    aese v5.16b, v24.16b
    aese v20.16b, v25.16b
    aese v21.16b, v25.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v20.16b, v20.16b
    aesmc v21.16b, v21.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v2.16b
    mov v28.16b, v3.16b
    mov v29.16b, v18.16b
    mov v30.16b, v19.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v4.16b, v27.16b
    eor v5.16b, v5.16b, v28.16b
    eor v20.16b, v20.16b, v29.16b
    eor v21.16b, v21.16b, v30.16b
    mov v31.16b, v6.16b
    mov v8.16b, v7.16b
    mov v9.16b, v22.16b
    mov v10.16b, v23.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v0.16b, v0.16b, v31.16b
    eor v1.16b, v1.16b, v8.16b
    eor v16.16b, v16.16b, v9.16b
    eor v17.16b, v17.16b, v10.16b
    aese v2.16b, v26.16b
    aese v3.16b, v26.16b
    aese v18.16b, v26.16b
    aese v19.16b, v26.16b
    aese v6.16b, v26.16b
    aese v7.16b, v26.16b
    aese v22.16b, v26.16b
    aese v23.16b, v26.16b
    aese v6.16b, v24.16b
    aese v7.16b, v24.16b
    aese v22.16b, v25.16b
    aese v23.16b, v25.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesmc v22.16b, v22.16b
    aesmc v23.16b, v23.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v4.16b
    mov v28.16b, v5.16b
    mov v29.16b, v20.16b
    mov v30.16b, v21.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v6.16b, v6.16b, v27.16b
    eor v7.16b, v7.16b, v28.16b
    eor v22.16b, v22.16b, v29.16b
    eor v23.16b, v23.16b, v30.16b
    mov v31.16b, v0.16b
    mov v8.16b, v1.16b
    mov v9.16b, v16.16b
    mov v10.16b, v17.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v2.16b, v2.16b, v31.16b
    eor v3.16b, v3.16b, v8.16b
    eor v18.16b, v18.16b, v9.16b
    eor v19.16b, v19.16b, v10.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v0.16b, v24.16b
    aese v1.16b, v24.16b
    aese v16.16b, v25.16b
    aese v17.16b, v25.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v16.16b, v16.16b
    aesmc v17.16b, v17.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v6.16b
    mov v28.16b, v7.16b
    mov v29.16b, v22.16b
    mov v30.16b, v23.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v0.16b, v0.16b, v27.16b
    eor v1.16b, v1.16b, v28.16b
    eor v16.16b, v16.16b, v29.16b
    eor v17.16b, v17.16b, v30.16b
    mov v31.16b, v2.16b
    mov v8.16b, v3.16b
    mov v9.16b, v18.16b
    mov v10.16b, v19.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v4.16b, v4.16b, v31.16b
    eor v5.16b, v5.16b, v8.16b
    eor v20.16b, v20.16b, v9.16b
    eor v21.16b, v21.16b, v10.16b
    aese v6.16b, v26.16b
    aese v7.16b, v26.16b
    aese v22.16b, v26.16b
    aese v23.16b, v26.16b
    aese v2.16b, v26.16b
    aese v3.16b, v26.16b
    aese v18.16b, v26.16b
    aese v19.16b, v26.16b
    aese v2.16b, v24.16b
    aese v3.16b, v24.16b
    aese v18.16b, v25.16b
    aese v19.16b, v25.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v18.16b, v18.16b
    aesmc v19.16b, v19.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v0.16b
    mov v28.16b, v1.16b
    mov v29.16b, v16.16b
    mov v30.16b, v17.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v28.16b
    eor v18.16b, v18.16b, v29.16b
    eor v19.16b, v19.16b, v30.16b
    mov v31.16b, v4.16b
    mov v8.16b, v5.16b
    mov v9.16b, v20.16b
    mov v10.16b, v21.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v6.16b, v6.16b, v31.16b
    eor v7.16b, v7.16b, v8.16b
    eor v22.16b, v22.16b, v9.16b
    eor v23.16b, v23.16b, v10.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v4.16b, v24.16b
    aese v5.16b, v24.16b
    aese v20.16b, v25.16b
    aese v21.16b, v25.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v20.16b, v20.16b
    aesmc v21.16b, v21.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v2.16b
    mov v28.16b, v3.16b
    mov v29.16b, v18.16b
    mov v30.16b, v19.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v4.16b, v27.16b
    eor v5.16b, v5.16b, v28.16b
    eor v20.16b, v20.16b, v29.16b
    eor v21.16b, v21.16b, v30.16b
    mov v31.16b, v6.16b
    mov v8.16b, v7.16b
    mov v9.16b, v22.16b
    mov v10.16b, v23.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v0.16b, v0.16b, v31.16b
    eor v1.16b, v1.16b, v8.16b
    eor v16.16b, v16.16b, v9.16b
    eor v17.16b, v17.16b, v10.16b
    aese v2.16b, v26.16b
    aese v3.16b, v26.16b
    aese v18.16b, v26.16b
    aese v19.16b, v26.16b
    aese v6.16b, v26.16b
    aese v7.16b, v26.16b
    aese v22.16b, v26.16b
    aese v23.16b, v26.16b
    aese v6.16b, v24.16b
    aese v7.16b, v24.16b
    aese v22.16b, v25.16b
    aese v23.16b, v25.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesmc v22.16b, v22.16b
    aesmc v23.16b, v23.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v4.16b
    mov v28.16b, v5.16b
    mov v29.16b, v20.16b
    mov v30.16b, v21.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v6.16b, v6.16b, v27.16b
    eor v7.16b, v7.16b, v28.16b
    eor v22.16b, v22.16b, v29.16b
    eor v23.16b, v23.16b, v30.16b
    mov v31.16b, v0.16b
    mov v8.16b, v1.16b
    mov v9.16b, v16.16b
    mov v10.16b, v17.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v2.16b, v2.16b, v31.16b
    eor v3.16b, v3.16b, v8.16b
    eor v18.16b, v18.16b, v9.16b
    eor v19.16b, v19.16b, v10.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v0.16b, v24.16b
    aese v1.16b, v24.16b
    aese v16.16b, v25.16b
    aese v17.16b, v25.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v16.16b, v16.16b
    aesmc v17.16b, v17.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    st1 { v6.16b, v7.16b }, [x0], #32
    st1 { v0.16b, v1.16b }, [x1], #32
    st1 { v2.16b, v3.16b }, [x2], #32
    sub x10, x3, #32
    st1 { v4.16b, v5.16b }, [x10]
    ld1 { v0.16b, v1.16b }, [x0]
    ld1 { v2.16b, v3.16b }, [x1]
    ld1 { v4.16b, v5.16b }, [x2]
    ld1 { v6.16b, v7.16b }, [x3], #32
    ld1 { v16.16b, v17.16b }, [x4], #32
    ld1 { v18.16b, v19.16b }, [x5], #32
    ld1 { v20.16b, v21.16b }, [x6], #32
    ld1 { v22.16b, v23.16b }, [x7], #32
    AREION_ARM64_ADR(x8, roundConstantsP1)
    AREION_ARM64_ADR(x9, roundConstantsP2)
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v0.16b
    mov v28.16b, v1.16b
    mov v29.16b, v16.16b
    mov v30.16b, v17.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v28.16b
    eor v18.16b, v18.16b, v29.16b
    eor v19.16b, v19.16b, v30.16b
    mov v31.16b, v4.16b
    mov v8.16b, v5.16b
    mov v9.16b, v20.16b
    mov v10.16b, v21.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v6.16b, v6.16b, v31.16b
    eor v7.16b, v7.16b, v8.16b
    eor v22.16b, v22.16b, v9.16b
    eor v23.16b, v23.16b, v10.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v4.16b, v24.16b
    aese v5.16b, v24.16b
    aese v20.16b, v25.16b
    aese v21.16b, v25.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v20.16b, v20.16b
    aesmc v21.16b, v21.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v2.16b
    mov v28.16b, v3.16b
    mov v29.16b, v18.16b
    mov v30.16b, v19.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v4.16b, v27.16b
    eor v5.16b, v5.16b, v28.16b
    eor v20.16b, v20.16b, v29.16b
    eor v21.16b, v21.16b, v30.16b
    mov v31.16b, v6.16b
    mov v8.16b, v7.16b
    mov v9.16b, v22.16b
    mov v10.16b, v23.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v0.16b, v0.16b, v31.16b
    eor v1.16b, v1.16b, v8.16b
    eor v16.16b, v16.16b, v9.16b
    eor v17.16b, v17.16b, v10.16b
    aese v2.16b, v26.16b
    aese v3.16b, v26.16b
    aese v18.16b, v26.16b
    aese v19.16b, v26.16b
    aese v6.16b, v26.16b
    aese v7.16b, v26.16b
    aese v22.16b, v26.16b
    aese v23.16b, v26.16b
    aese v6.16b, v24.16b
    aese v7.16b, v24.16b
    aese v22.16b, v25.16b
    aese v23.16b, v25.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesmc v22.16b, v22.16b
    aesmc v23.16b, v23.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v4.16b
    mov v28.16b, v5.16b
    mov v29.16b, v20.16b
    mov v30.16b, v21.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v6.16b, v6.16b, v27.16b
    eor v7.16b, v7.16b, v28.16b
    eor v22.16b, v22.16b, v29.16b
    eor v23.16b, v23.16b, v30.16b
    mov v31.16b, v0.16b
    mov v8.16b, v1.16b
    mov v9.16b, v16.16b
    mov v10.16b, v17.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v2.16b, v2.16b, v31.16b
    eor v3.16b, v3.16b, v8.16b
    eor v18.16b, v18.16b, v9.16b
    eor v19.16b, v19.16b, v10.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v0.16b, v24.16b
    aese v1.16b, v24.16b
    aese v16.16b, v25.16b
    aese v17.16b, v25.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v16.16b, v16.16b
    aesmc v17.16b, v17.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v6.16b
    mov v28.16b, v7.16b
    mov v29.16b, v22.16b
    mov v30.16b, v23.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v0.16b, v0.16b, v27.16b
    eor v1.16b, v1.16b, v28.16b
    eor v16.16b, v16.16b, v29.16b
    eor v17.16b, v17.16b, v30.16b
    mov v31.16b, v2.16b
    mov v8.16b, v3.16b
    mov v9.16b, v18.16b
    mov v10.16b, v19.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v4.16b, v4.16b, v31.16b
    eor v5.16b, v5.16b, v8.16b
    eor v20.16b, v20.16b, v9.16b
    eor v21.16b, v21.16b, v10.16b
    aese v6.16b, v26.16b
    aese v7.16b, v26.16b
    aese v22.16b, v26.16b
    aese v23.16b, v26.16b
    aese v2.16b, v26.16b
    aese v3.16b, v26.16b
    aese v18.16b, v26.16b
    aese v19.16b, v26.16b
    aese v2.16b, v24.16b
    aese v3.16b, v24.16b
    aese v18.16b, v25.16b
    aese v19.16b, v25.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v18.16b, v18.16b
    aesmc v19.16b, v19.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v0.16b
    mov v28.16b, v1.16b
    mov v29.16b, v16.16b
    mov v30.16b, v17.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v28.16b
    eor v18.16b, v18.16b, v29.16b
    eor v19.16b, v19.16b, v30.16b
    mov v31.16b, v4.16b
    mov v8.16b, v5.16b
    mov v9.16b, v20.16b
    mov v10.16b, v21.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v6.16b, v6.16b, v31.16b
    eor v7.16b, v7.16b, v8.16b
    eor v22.16b, v22.16b, v9.16b
    eor v23.16b, v23.16b, v10.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v4.16b, v24.16b
    aese v5.16b, v24.16b
    aese v20.16b, v25.16b
    aese v21.16b, v25.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v20.16b, v20.16b
    aesmc v21.16b, v21.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v2.16b
    mov v28.16b, v3.16b
    mov v29.16b, v18.16b
    mov v30.16b, v19.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v4.16b, v27.16b
    eor v5.16b, v5.16b, v28.16b
    eor v20.16b, v20.16b, v29.16b
    eor v21.16b, v21.16b, v30.16b
    mov v31.16b, v6.16b
    mov v8.16b, v7.16b
    mov v9.16b, v22.16b
    mov v10.16b, v23.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v0.16b, v0.16b, v31.16b
    eor v1.16b, v1.16b, v8.16b
    eor v16.16b, v16.16b, v9.16b
    eor v17.16b, v17.16b, v10.16b
    aese v2.16b, v26.16b
    aese v3.16b, v26.16b
    aese v18.16b, v26.16b
    aese v19.16b, v26.16b
    aese v6.16b, v26.16b
    aese v7.16b, v26.16b
    aese v22.16b, v26.16b
    aese v23.16b, v26.16b
    aese v6.16b, v24.16b
    aese v7.16b, v24.16b
    aese v22.16b, v25.16b
    aese v23.16b, v25.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesmc v22.16b, v22.16b
    aesmc v23.16b, v23.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v4.16b
    mov v28.16b, v5.16b
    mov v29.16b, v20.16b
    mov v30.16b, v21.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v6.16b, v6.16b, v27.16b
    eor v7.16b, v7.16b, v28.16b
    eor v22.16b, v22.16b, v29.16b
    eor v23.16b, v23.16b, v30.16b
    mov v31.16b, v0.16b
    mov v8.16b, v1.16b
    mov v9.16b, v16.16b
    mov v10.16b, v17.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v2.16b, v2.16b, v31.16b
    eor v3.16b, v3.16b, v8.16b
    eor v18.16b, v18.16b, v9.16b
    eor v19.16b, v19.16b, v10.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v0.16b, v24.16b
    aese v1.16b, v24.16b
    aese v16.16b, v25.16b
    aese v17.16b, v25.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v16.16b, v16.16b
    aesmc v17.16b, v17.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v6.16b
    mov v28.16b, v7.16b
    mov v29.16b, v22.16b
    mov v30.16b, v23.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v0.16b, v0.16b, v27.16b
    eor v1.16b, v1.16b, v28.16b
    eor v16.16b, v16.16b, v29.16b
    eor v17.16b, v17.16b, v30.16b
    mov v31.16b, v2.16b
    mov v8.16b, v3.16b
    mov v9.16b, v18.16b
    mov v10.16b, v19.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v4.16b, v4.16b, v31.16b
    eor v5.16b, v5.16b, v8.16b
    eor v20.16b, v20.16b, v9.16b
    eor v21.16b, v21.16b, v10.16b
    aese v6.16b, v26.16b
    aese v7.16b, v26.16b
    aese v22.16b, v26.16b
    aese v23.16b, v26.16b
    aese v2.16b, v26.16b
    aese v3.16b, v26.16b
    aese v18.16b, v26.16b
    aese v19.16b, v26.16b
    aese v2.16b, v24.16b
    aese v3.16b, v24.16b
    aese v18.16b, v25.16b
    aese v19.16b, v25.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v18.16b, v18.16b
    aesmc v19.16b, v19.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v0.16b
    mov v28.16b, v1.16b
    mov v29.16b, v16.16b
    mov v30.16b, v17.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v28.16b
    eor v18.16b, v18.16b, v29.16b
    eor v19.16b, v19.16b, v30.16b
    mov v31.16b, v4.16b
    mov v8.16b, v5.16b
    mov v9.16b, v20.16b
    mov v10.16b, v21.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v6.16b, v6.16b, v31.16b
    eor v7.16b, v7.16b, v8.16b
    eor v22.16b, v22.16b, v9.16b
    eor v23.16b, v23.16b, v10.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v4.16b, v24.16b
    aese v5.16b, v24.16b
    aese v20.16b, v25.16b
    aese v21.16b, v25.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v20.16b, v20.16b
    aesmc v21.16b, v21.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v2.16b
    mov v28.16b, v3.16b
    mov v29.16b, v18.16b
    mov v30.16b, v19.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v4.16b, v27.16b
    eor v5.16b, v5.16b, v28.16b
    eor v20.16b, v20.16b, v29.16b
    eor v21.16b, v21.16b, v30.16b
    mov v31.16b, v6.16b
    mov v8.16b, v7.16b
    mov v9.16b, v22.16b
    mov v10.16b, v23.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v0.16b, v0.16b, v31.16b
    eor v1.16b, v1.16b, v8.16b
    eor v16.16b, v16.16b, v9.16b
    eor v17.16b, v17.16b, v10.16b
    aese v2.16b, v26.16b
    aese v3.16b, v26.16b
    aese v18.16b, v26.16b
    aese v19.16b, v26.16b
    aese v6.16b, v26.16b
    aese v7.16b, v26.16b
    aese v22.16b, v26.16b
    aese v23.16b, v26.16b
    aese v6.16b, v24.16b
    aese v7.16b, v24.16b
    aese v22.16b, v25.16b
    aese v23.16b, v25.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesmc v22.16b, v22.16b
    aesmc v23.16b, v23.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v4.16b
    mov v28.16b, v5.16b
    mov v29.16b, v20.16b
    mov v30.16b, v21.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v6.16b, v6.16b, v27.16b
    eor v7.16b, v7.16b, v28.16b
    eor v22.16b, v22.16b, v29.16b
    eor v23.16b, v23.16b, v30.16b
    mov v31.16b, v0.16b
    mov v8.16b, v1.16b
    mov v9.16b, v16.16b
    mov v10.16b, v17.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v2.16b, v2.16b, v31.16b
    eor v3.16b, v3.16b, v8.16b
    eor v18.16b, v18.16b, v9.16b
    eor v19.16b, v19.16b, v10.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v0.16b, v24.16b
    aese v1.16b, v24.16b
    aese v16.16b, v25.16b
    aese v17.16b, v25.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v16.16b, v16.16b
    aesmc v17.16b, v17.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v6.16b
    mov v28.16b, v7.16b
    mov v29.16b, v22.16b
    mov v30.16b, v23.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v0.16b, v0.16b, v27.16b
    eor v1.16b, v1.16b, v28.16b
    eor v16.16b, v16.16b, v29.16b
    eor v17.16b, v17.16b, v30.16b
    mov v31.16b, v2.16b
    mov v8.16b, v3.16b
    mov v9.16b, v18.16b
    mov v10.16b, v19.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v4.16b, v4.16b, v31.16b
    eor v5.16b, v5.16b, v8.16b
    eor v20.16b, v20.16b, v9.16b
    eor v21.16b, v21.16b, v10.16b
    aese v6.16b, v26.16b
    aese v7.16b, v26.16b
    aese v22.16b, v26.16b
    aese v23.16b, v26.16b
    aese v2.16b, v26.16b
    aese v3.16b, v26.16b
    aese v18.16b, v26.16b
    aese v19.16b, v26.16b
    aese v2.16b, v24.16b
    aese v3.16b, v24.16b
    aese v18.16b, v25.16b
    aese v19.16b, v25.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v18.16b, v18.16b
    aesmc v19.16b, v19.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v0.16b
    mov v28.16b, v1.16b
    mov v29.16b, v16.16b
    mov v30.16b, v17.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v28.16b
    eor v18.16b, v18.16b, v29.16b
    eor v19.16b, v19.16b, v30.16b
    mov v31.16b, v4.16b
    mov v8.16b, v5.16b
    mov v9.16b, v20.16b
    mov v10.16b, v21.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v6.16b, v6.16b, v31.16b
    eor v7.16b, v7.16b, v8.16b
    eor v22.16b, v22.16b, v9.16b
    eor v23.16b, v23.16b, v10.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v4.16b, v24.16b
    aese v5.16b, v24.16b
    aese v20.16b, v25.16b
    aese v21.16b, v25.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v20.16b, v20.16b
    aesmc v21.16b, v21.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v2.16b
    mov v28.16b, v3.16b
    mov v29.16b, v18.16b
    mov v30.16b, v19.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v4.16b, v4.16b, v27.16b
    eor v5.16b, v5.16b, v28.16b
    eor v20.16b, v20.16b, v29.16b
    eor v21.16b, v21.16b, v30.16b
    mov v31.16b, v6.16b
    mov v8.16b, v7.16b
    mov v9.16b, v22.16b
    mov v10.16b, v23.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v0.16b, v0.16b, v31.16b
    eor v1.16b, v1.16b, v8.16b
    eor v16.16b, v16.16b, v9.16b
    eor v17.16b, v17.16b, v10.16b
    aese v2.16b, v26.16b
    aese v3.16b, v26.16b
    aese v18.16b, v26.16b
    aese v19.16b, v26.16b
    aese v6.16b, v26.16b
    aese v7.16b, v26.16b
    aese v22.16b, v26.16b
    aese v23.16b, v26.16b
    aese v6.16b, v24.16b
    aese v7.16b, v24.16b
    aese v22.16b, v25.16b
    aese v23.16b, v25.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesmc v22.16b, v22.16b
    aesmc v23.16b, v23.16b
    ld1 { v24.16b }, [x8], #16
    ld1 { v25.16b }, [x9], #16
    mov v27.16b, v4.16b
    mov v28.16b, v5.16b
    mov v29.16b, v20.16b
    mov v30.16b, v21.16b
    aese v27.16b, v26.16b
    aese v28.16b, v26.16b
    aese v29.16b, v26.16b
    aese v30.16b, v26.16b
    aesmc v27.16b, v27.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aesmc v30.16b, v30.16b
    eor v6.16b, v6.16b, v27.16b
    eor v7.16b, v7.16b, v28.16b
    eor v22.16b, v22.16b, v29.16b
    eor v23.16b, v23.16b, v30.16b
    mov v31.16b, v0.16b
    mov v8.16b, v1.16b
    mov v9.16b, v16.16b
    mov v10.16b, v17.16b
    aese v31.16b, v26.16b
    aese v8.16b, v26.16b
    aese v9.16b, v26.16b
    aese v10.16b, v26.16b
    aesmc v31.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    aesmc v10.16b, v10.16b
    eor v2.16b, v2.16b, v31.16b
    eor v3.16b, v3.16b, v8.16b
    eor v18.16b, v18.16b, v9.16b
    eor v19.16b, v19.16b, v10.16b
    aese v4.16b, v26.16b
    aese v5.16b, v26.16b
    aese v20.16b, v26.16b
    aese v21.16b, v26.16b
    aese v0.16b, v26.16b
    aese v1.16b, v26.16b
    aese v16.16b, v26.16b
    aese v17.16b, v26.16b
    aese v0.16b, v24.16b
    aese v1.16b, v24.16b
    aese v16.16b, v25.16b
    aese v17.16b, v25.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v16.16b, v16.16b
    aesmc v17.16b, v17.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    st1 { v6.16b, v7.16b }, [x0], #32
    st1 { v0.16b, v1.16b }, [x1], #32
    st1 { v2.16b, v3.16b }, [x2], #32
    sub x10, x3, #32
    st1 { v4.16b, v5.16b }, [x10]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    eor v31.16b, v31.16b, v31.16b
    eor v8.16b, v8.16b, v8.16b
    eor v9.16b, v9.16b, v9.16b
    eor v10.16b, v10.16b, v10.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    eor v26.16b, v26.16b, v26.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    mov x5, xzr
    mov x6, xzr
    mov x7, xzr
    mov x8, xzr
    mov x9, xzr
    mov x10, xzr
    ldp d8, d9, [sp]
    ldr d10, [sp, #16]
    stp xzr, xzr, [sp]
    str xzr, [sp, #16]
    add sp, sp, #32
    ret
AREION_FUNC_END(areion512SoEMPermutex4NEON)

AREION_FUNC_START(dumpSIMDRegs)
    str x1, [x0, #512]
    str x2, [x0, #520]
    str x3, [x0, #528]
    str x4, [x0, #536]
    str x5, [x0, #544]
    str x6, [x0, #552]
    str x7, [x0, #560]
    str x8, [x0, #568]
    str x9, [x0, #576]
    str x10, [x0, #584]
    str x11, [x0, #592]
    str x12, [x0, #600]
    str x13, [x0, #608]
    str x14, [x0, #616]
    str x15, [x0, #624]
    str x16, [x0, #632]
    str x17, [x0, #640]
    str xzr, [x0, #648]
    str xzr, [x0, #656]
    str xzr, [x0, #664]
    str xzr, [x0, #672]
    str xzr, [x0, #680]
    str xzr, [x0, #688]
    str xzr, [x0, #696]
    st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x0], #64
    st1 {v4.16b, v5.16b, v6.16b, v7.16b}, [x0], #64
    st1 {v8.16b, v9.16b, v10.16b, v11.16b}, [x0], #64
    st1 {v12.16b, v13.16b, v14.16b, v15.16b}, [x0], #64
    st1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x0], #64
    st1 {v20.16b, v21.16b, v22.16b, v23.16b}, [x0], #64
    st1 {v24.16b, v25.16b, v26.16b, v27.16b}, [x0], #64
    st1 {v28.16b, v29.16b, v30.16b, v31.16b}, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    eor v31.16b, v31.16b, v31.16b
    mov v8.d[1], xzr
    mov v9.d[1], xzr
    mov v10.d[1], xzr
    mov v11.d[1], xzr
    mov v12.d[1], xzr
    mov v13.d[1], xzr
    mov v14.d[1], xzr
    mov v15.d[1], xzr
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    mov x5, xzr
    mov x6, xzr
    mov x7, xzr
    mov x8, xzr
    mov x9, xzr
    mov x10, xzr
    mov x11, xzr
    mov x12, xzr
    mov x13, xzr
    mov x14, xzr
    mov x15, xzr
    mov x16, xzr
    mov x17, xzr
    ret
AREION_FUNC_END(dumpSIMDRegs)

AREION_FUNC_START(clobberScratchGPRs)
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    eor v31.16b, v31.16b, v31.16b
    mov v8.d[1], xzr
    mov v9.d[1], xzr
    mov v10.d[1], xzr
    mov v11.d[1], xzr
    mov v12.d[1], xzr
    mov v13.d[1], xzr
    mov v14.d[1], xzr
    mov v15.d[1], xzr
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    mov x5, xzr
    mov x6, xzr
    mov x7, xzr
    mov x8, xzr
    mov x9, xzr
    mov x10, xzr
    mov x11, xzr
    mov x12, xzr
    mov x13, xzr
    mov x14, xzr
    mov x15, xzr
    mov x16, xzr
    mov x17, xzr
    ret
AREION_FUNC_END(clobberScratchGPRs)

AREION_FUNC_START(dirtySIMDRegForTest)
    mov x12, x0
    mov x0, #0x5555555555555555
    eor x12, x12, x0
    mov v2.d[0], x12
    mov x0, xzr
    ret
AREION_FUNC_END(dirtySIMDRegForTest)

AREION_FUNC_START(areion256EMEncryptAsm)
    ld1 { v0.16b, v1.16b }, [x1]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    eor v20.16b, v20.16b, v20.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    st1 { v0.16b, v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(areion256EMEncryptAsm)

AREION_FUNC_START(areion256EMDecryptAsm)
    ld1 { v0.16b, v1.16b }, [x1]
    ld1 { v26.16b, v27.16b, v28.16b, v29.16b }, [x2]
    eor v30.16b, v30.16b, v30.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v29.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v16.16b }, [x4], #16
    ld1 { v17.16b }, [x4], #16
    ld1 { v18.16b }, [x4], #16
    ld1 { v19.16b }, [x4], #16
    ld1 { v20.16b }, [x4], #16
    ld1 { v21.16b }, [x4], #16
    ld1 { v22.16b }, [x4], #16
    ld1 { v23.16b }, [x4], #16
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x4], #16
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v25.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v22.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v21.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v18.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    st1 { v0.16b, v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v3.16b, v3.16b, v3.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(areion256EMDecryptAsm)

AREION_FUNC_START(areion512EMEncryptAsm)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2]
    eor v24.16b, v24.16b, v24.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    eor v3.16b, v3.16b, v20.16b
    eor v0.16b, v0.16b, v21.16b
    eor v1.16b, v1.16b, v22.16b
    eor v2.16b, v2.16b, v23.16b
    st1 { v3.16b }, [x0], #16
    st1 { v0.16b }, [x0], #16
    st1 { v1.16b }, [x0], #16
    st1 { v2.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(areion512EMEncryptAsm)

AREION_FUNC_START(areion512EMDecryptAsm)
    sub sp, sp, #48
    stp d8, d9, [sp]
    stp d10, d11, [sp, #16]
    stp d12, d13, [sp, #32]
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    ld1 { v6.16b, v7.16b, v8.16b, v9.16b }, [x2], #64
    ld1 { v10.16b, v11.16b, v12.16b, v13.16b }, [x2]
    eor v31.16b, v31.16b, v31.16b
    eor v0.16b, v0.16b, v10.16b
    eor v1.16b, v1.16b, v11.16b
    eor v2.16b, v2.16b, v12.16b
    eor v3.16b, v3.16b, v13.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v16.16b }, [x4], #16
    ld1 { v17.16b }, [x4], #16
    ld1 { v18.16b }, [x4], #16
    ld1 { v19.16b }, [x4], #16
    ld1 { v20.16b }, [x4], #16
    ld1 { v21.16b }, [x4], #16
    ld1 { v22.16b }, [x4], #16
    ld1 { v23.16b }, [x4], #16
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x4], #16
    ld1 { v26.16b }, [x4], #16
    ld1 { v27.16b }, [x4], #16
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x4], #16
    ld1 { v30.16b }, [x4], #16
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v30.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v29.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v28.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v27.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v26.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v25.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v24.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v23.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v22.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v21.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v20.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v19.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v18.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v17.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v16.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    eor v1.16b, v1.16b, v6.16b
    eor v2.16b, v2.16b, v7.16b
    eor v3.16b, v3.16b, v8.16b
    eor v0.16b, v0.16b, v9.16b
    st1 { v1.16b }, [x0], #16
    st1 { v2.16b }, [x0], #16
    st1 { v3.16b }, [x0], #16
    st1 { v0.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v8.16b, v8.16b, v8.16b
    eor v9.16b, v9.16b, v9.16b
    eor v10.16b, v10.16b, v10.16b
    eor v11.16b, v11.16b, v11.16b
    eor v12.16b, v12.16b, v12.16b
    eor v13.16b, v13.16b, v13.16b
    eor v31.16b, v31.16b, v31.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    ldp d8, d9, [sp]
    ldp d10, d11, [sp, #16]
    ldp d12, d13, [sp, #32]
    stp xzr, xzr, [sp]
    stp xzr, xzr, [sp, #16]
    stp xzr, xzr, [sp, #32]
    add sp, sp, #48
    ret
AREION_FUNC_END(areion512EMDecryptAsm)

AREION_FUNC_START(areion256EM2EncryptAsm)
    ld1 { v0.16b, v1.16b }, [x1]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    eor v20.16b, v20.16b, v20.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    AREION_ARM64_ADR(x4, roundConstantsP2)
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    eor v16.16b, v16.16b, v18.16b
    eor v17.16b, v17.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    st1 { v0.16b, v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(areion256EM2EncryptAsm)

AREION_FUNC_START(areion256EM2DecryptAsm)
    ld1 { v0.16b, v1.16b }, [x1]
    ld1 { v26.16b, v27.16b, v28.16b, v29.16b }, [x2]
    eor v30.16b, v30.16b, v30.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v29.16b
    AREION_ARM64_ADR(x4, roundConstantsP2)
    ld1 { v16.16b }, [x4], #16
    ld1 { v17.16b }, [x4], #16
    ld1 { v18.16b }, [x4], #16
    ld1 { v19.16b }, [x4], #16
    ld1 { v20.16b }, [x4], #16
    ld1 { v21.16b }, [x4], #16
    ld1 { v22.16b }, [x4], #16
    ld1 { v23.16b }, [x4], #16
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x4], #16
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v25.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v22.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v21.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v18.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v29.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v16.16b }, [x4], #16
    ld1 { v17.16b }, [x4], #16
    ld1 { v18.16b }, [x4], #16
    ld1 { v19.16b }, [x4], #16
    ld1 { v20.16b }, [x4], #16
    ld1 { v21.16b }, [x4], #16
    ld1 { v22.16b }, [x4], #16
    ld1 { v23.16b }, [x4], #16
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x4], #16
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v25.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v22.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v21.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v18.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    st1 { v0.16b, v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v3.16b, v3.16b, v3.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(areion256EM2DecryptAsm)

AREION_FUNC_START(areion512EM2EncryptAsm)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2]
    eor v24.16b, v24.16b, v24.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    eor v3.16b, v3.16b, v20.16b
    eor v0.16b, v0.16b, v21.16b
    eor v1.16b, v1.16b, v22.16b
    eor v2.16b, v2.16b, v23.16b
    AREION_ARM64_ADR(x4, roundConstantsP2)
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    eor v16.16b, v16.16b, v20.16b
    eor v17.16b, v17.16b, v21.16b
    eor v18.16b, v18.16b, v22.16b
    eor v19.16b, v19.16b, v23.16b
    eor v2.16b, v2.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    st1 { v2.16b }, [x0], #16
    st1 { v3.16b }, [x0], #16
    st1 { v0.16b }, [x0], #16
    st1 { v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(areion512EM2EncryptAsm)

AREION_FUNC_START(areion512EM2DecryptAsm)
    sub sp, sp, #48
    stp d8, d9, [sp]
    stp d10, d11, [sp, #16]
    stp d12, d13, [sp, #32]
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    ld1 { v6.16b, v7.16b, v8.16b, v9.16b }, [x2], #64
    ld1 { v10.16b, v11.16b, v12.16b, v13.16b }, [x2]
    eor v31.16b, v31.16b, v31.16b
    eor v0.16b, v0.16b, v6.16b
    eor v1.16b, v1.16b, v7.16b
    eor v2.16b, v2.16b, v8.16b
    eor v3.16b, v3.16b, v9.16b
    eor v0.16b, v0.16b, v10.16b
    eor v1.16b, v1.16b, v11.16b
    eor v2.16b, v2.16b, v12.16b
    eor v3.16b, v3.16b, v13.16b
    AREION_ARM64_ADR(x4, roundConstantsP2)
    ld1 { v16.16b }, [x4], #16
    ld1 { v17.16b }, [x4], #16
    ld1 { v18.16b }, [x4], #16
    ld1 { v19.16b }, [x4], #16
    ld1 { v20.16b }, [x4], #16
    ld1 { v21.16b }, [x4], #16
    ld1 { v22.16b }, [x4], #16
    ld1 { v23.16b }, [x4], #16
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x4], #16
    ld1 { v26.16b }, [x4], #16
    ld1 { v27.16b }, [x4], #16
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x4], #16
    ld1 { v30.16b }, [x4], #16
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v30.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v29.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v28.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v27.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v26.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v25.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v24.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v23.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v22.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v21.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v20.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v19.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v18.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v17.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v16.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    eor v1.16b, v1.16b, v10.16b
    eor v2.16b, v2.16b, v11.16b
    eor v3.16b, v3.16b, v12.16b
    eor v0.16b, v0.16b, v13.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v16.16b }, [x4], #16
    ld1 { v17.16b }, [x4], #16
    ld1 { v18.16b }, [x4], #16
    ld1 { v19.16b }, [x4], #16
    ld1 { v20.16b }, [x4], #16
    ld1 { v21.16b }, [x4], #16
    ld1 { v22.16b }, [x4], #16
    ld1 { v23.16b }, [x4], #16
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x4], #16
    ld1 { v26.16b }, [x4], #16
    ld1 { v27.16b }, [x4], #16
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x4], #16
    ld1 { v30.16b }, [x4], #16
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v30.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v29.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v28.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v27.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v26.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v25.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v24.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v23.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v22.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v21.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v20.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v19.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v18.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v17.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v16.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    eor v2.16b, v2.16b, v6.16b
    eor v3.16b, v3.16b, v7.16b
    eor v0.16b, v0.16b, v8.16b
    eor v1.16b, v1.16b, v9.16b
    st1 { v2.16b }, [x0], #16
    st1 { v3.16b }, [x0], #16
    st1 { v0.16b }, [x0], #16
    st1 { v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v8.16b, v8.16b, v8.16b
    eor v9.16b, v9.16b, v9.16b
    eor v10.16b, v10.16b, v10.16b
    eor v11.16b, v11.16b, v11.16b
    eor v12.16b, v12.16b, v12.16b
    eor v13.16b, v13.16b, v13.16b
    eor v31.16b, v31.16b, v31.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    ldp d8, d9, [sp]
    ldp d10, d11, [sp, #16]
    ldp d12, d13, [sp, #32]
    stp xzr, xzr, [sp]
    stp xzr, xzr, [sp, #16]
    stp xzr, xzr, [sp, #32]
    add sp, sp, #48
    ret
AREION_FUNC_END(areion512EM2DecryptAsm)

AREION_FUNC_START(areion256TEMEncryptAsm)
    ld1 { v0.16b, v1.16b }, [x3]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    AREION_ARM64_ADR(x4, roundConstantsP2)
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    eor v16.16b, v16.16b, v0.16b
    eor v17.16b, v17.16b, v1.16b
    ld1 { v0.16b, v1.16b }, [x1]
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    st1 { v0.16b, v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(areion256TEMEncryptAsm)

AREION_FUNC_START(areion256TEMDecryptAsm)
    ld1 { v0.16b, v1.16b }, [x3]
    ld1 { v26.16b, v27.16b, v28.16b, v29.16b }, [x2]
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    AREION_ARM64_ADR(x4, roundConstantsP2)
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v30.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v30.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v30.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v30.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v30.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v30.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v30.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v30.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v30.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v30.16b
    eor v26.16b, v26.16b, v0.16b
    eor v27.16b, v27.16b, v1.16b
    ld1 { v0.16b, v1.16b }, [x1]
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v16.16b }, [x4], #16
    ld1 { v17.16b }, [x4], #16
    ld1 { v18.16b }, [x4], #16
    ld1 { v19.16b }, [x4], #16
    ld1 { v20.16b }, [x4], #16
    ld1 { v21.16b }, [x4], #16
    ld1 { v22.16b }, [x4], #16
    ld1 { v23.16b }, [x4], #16
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x4], #16
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v25.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v22.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v21.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v18.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    st1 { v0.16b, v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(areion256TEMDecryptAsm)

AREION_FUNC_START(areion512TEMEncryptAsm)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2]
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    AREION_ARM64_ADR(x4, roundConstantsP2)
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    eor v16.16b, v16.16b, v3.16b
    eor v17.16b, v17.16b, v0.16b
    eor v18.16b, v18.16b, v1.16b
    eor v19.16b, v19.16b, v2.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    eor v3.16b, v3.16b, v16.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v19.16b
    st1 { v3.16b }, [x0], #16
    st1 { v0.16b }, [x0], #16
    st1 { v1.16b }, [x0], #16
    st1 { v2.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(areion512TEMEncryptAsm)

AREION_FUNC_START(areion512TEMDecryptAsm)
    sub sp, sp, #48
    stp d8, d9, [sp]
    stp d10, d11, [sp, #16]
    stp d12, d13, [sp, #32]
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3]
    ld1 { v6.16b, v7.16b, v8.16b, v9.16b }, [x2], #64
    ld1 { v10.16b, v11.16b, v12.16b, v13.16b }, [x2]
    eor v0.16b, v0.16b, v10.16b
    eor v1.16b, v1.16b, v11.16b
    eor v2.16b, v2.16b, v12.16b
    eor v3.16b, v3.16b, v13.16b
    eor v31.16b, v31.16b, v31.16b
    AREION_ARM64_ADR(x4, roundConstantsP2)
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v31.16b
    aese v1.16b, v31.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v31.16b
    aese v1.16b, v31.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v31.16b
    aese v1.16b, v31.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    eor v6.16b, v6.16b, v3.16b
    eor v7.16b, v7.16b, v0.16b
    eor v8.16b, v8.16b, v1.16b
    eor v9.16b, v9.16b, v2.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    eor v0.16b, v0.16b, v6.16b
    eor v1.16b, v1.16b, v7.16b
    eor v2.16b, v2.16b, v8.16b
    eor v3.16b, v3.16b, v9.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v16.16b }, [x4], #16
    ld1 { v17.16b }, [x4], #16
    ld1 { v18.16b }, [x4], #16
    ld1 { v19.16b }, [x4], #16
    ld1 { v20.16b }, [x4], #16
    ld1 { v21.16b }, [x4], #16
    ld1 { v22.16b }, [x4], #16
    ld1 { v23.16b }, [x4], #16
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x4], #16
    ld1 { v26.16b }, [x4], #16
    ld1 { v27.16b }, [x4], #16
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x4], #16
    ld1 { v30.16b }, [x4], #16
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v30.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v29.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v28.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v27.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v26.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v25.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v24.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v23.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v22.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v21.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v20.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v19.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v18.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v17.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v16.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    eor v1.16b, v1.16b, v6.16b
    eor v2.16b, v2.16b, v7.16b
    eor v3.16b, v3.16b, v8.16b
    eor v0.16b, v0.16b, v9.16b
    st1 { v1.16b }, [x0], #16
    st1 { v2.16b }, [x0], #16
    st1 { v3.16b }, [x0], #16
    st1 { v0.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v8.16b, v8.16b, v8.16b
    eor v9.16b, v9.16b, v9.16b
    eor v10.16b, v10.16b, v10.16b
    eor v11.16b, v11.16b, v11.16b
    eor v12.16b, v12.16b, v12.16b
    eor v13.16b, v13.16b, v13.16b
    eor v31.16b, v31.16b, v31.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ldp d8, d9, [sp]
    ldp d10, d11, [sp, #16]
    ldp d12, d13, [sp, #32]
    stp xzr, xzr, [sp]
    stp xzr, xzr, [sp, #16]
    stp xzr, xzr, [sp, #32]
    add sp, sp, #48
    ret
AREION_FUNC_END(areion512TEMDecryptAsm)

AREION_FUNC_START(areion256TEM2EncryptAsm)
    ld1 { v0.16b, v1.16b }, [x3]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    eor v2.16b, v0.16b, v18.16b
    eor v3.16b, v1.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v20.16b, v20.16b, v20.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    AREION_ARM64_ADR(x5, roundConstantsP2)
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v0.16b
    mov v5.16b, v2.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v1.16b
    mov v5.16b, v3.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v0.16b
    mov v5.16b, v2.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v1.16b
    mov v5.16b, v3.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v0.16b
    mov v5.16b, v2.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v1.16b
    mov v5.16b, v3.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v0.16b
    mov v5.16b, v2.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v1.16b
    mov v5.16b, v3.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v0.16b
    mov v5.16b, v2.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v1.16b
    mov v5.16b, v3.16b
    aese v4.16b, v20.16b
    aese v5.16b, v20.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    eor v16.16b, v16.16b, v0.16b
    eor v17.16b, v17.16b, v1.16b
    eor v18.16b, v18.16b, v2.16b
    eor v19.16b, v19.16b, v3.16b
    ld1 { v0.16b, v1.16b }, [x1]
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    AREION_ARM64_ADR(x4, roundConstantsP2)
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v0.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aese v0.16b, v20.16b
    ld1 { v2.16b }, [x4], #16
    mov v3.16b, v1.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aese v1.16b, v20.16b
    eor v16.16b, v16.16b, v18.16b
    eor v17.16b, v17.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    st1 { v0.16b, v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    mov x5, xzr
    ret
AREION_FUNC_END(areion256TEM2EncryptAsm)

AREION_FUNC_START(areion256TEM2DecryptAsm)
    ld1 { v0.16b, v1.16b }, [x3]
    ld1 { v26.16b, v27.16b, v28.16b, v29.16b }, [x2]
    eor v2.16b, v0.16b, v28.16b
    eor v3.16b, v1.16b, v29.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    eor v30.16b, v30.16b, v30.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    AREION_ARM64_ADR(x5, roundConstantsP2)
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v0.16b
    mov v5.16b, v2.16b
    aese v4.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v1.16b
    mov v5.16b, v3.16b
    aese v4.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v0.16b
    mov v5.16b, v2.16b
    aese v4.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v1.16b
    mov v5.16b, v3.16b
    aese v4.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v0.16b
    mov v5.16b, v2.16b
    aese v4.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v1.16b
    mov v5.16b, v3.16b
    aese v4.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v0.16b
    mov v5.16b, v2.16b
    aese v4.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v1.16b
    mov v5.16b, v3.16b
    aese v4.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v0.16b
    mov v5.16b, v2.16b
    aese v4.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    mov v4.16b, v1.16b
    mov v5.16b, v3.16b
    aese v4.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    eor v26.16b, v26.16b, v0.16b
    eor v27.16b, v27.16b, v1.16b
    eor v28.16b, v28.16b, v2.16b
    eor v29.16b, v29.16b, v3.16b
    ld1 { v0.16b, v1.16b }, [x1]
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v29.16b
    AREION_ARM64_ADR(x4, roundConstantsP2)
    ld1 { v16.16b }, [x4], #16
    ld1 { v17.16b }, [x4], #16
    ld1 { v18.16b }, [x4], #16
    ld1 { v19.16b }, [x4], #16
    ld1 { v20.16b }, [x4], #16
    ld1 { v21.16b }, [x4], #16
    ld1 { v22.16b }, [x4], #16
    ld1 { v23.16b }, [x4], #16
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x4], #16
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v25.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v22.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v21.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v18.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v29.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v16.16b }, [x4], #16
    ld1 { v17.16b }, [x4], #16
    ld1 { v18.16b }, [x4], #16
    ld1 { v19.16b }, [x4], #16
    ld1 { v20.16b }, [x4], #16
    ld1 { v21.16b }, [x4], #16
    ld1 { v22.16b }, [x4], #16
    ld1 { v23.16b }, [x4], #16
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x4], #16
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v25.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v22.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v21.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v18.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesd v1.16b, v30.16b
    mov v3.16b, v1.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesd v0.16b, v30.16b
    mov v3.16b, v0.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    st1 { v0.16b, v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    mov x5, xzr
    ret
AREION_FUNC_END(areion256TEM2DecryptAsm)

AREION_FUNC_START(areion512TEM2EncryptAsm)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2]
    eor v4.16b, v0.16b, v20.16b
    eor v5.16b, v1.16b, v21.16b
    eor v6.16b, v2.16b, v22.16b
    eor v7.16b, v3.16b, v23.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v30.16b, v30.16b, v30.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    AREION_ARM64_ADR(x5, roundConstantsP2)
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    mov v24.16b, v0.16b
    mov v25.16b, v4.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    mov v26.16b, v2.16b
    mov v27.16b, v6.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    mov v24.16b, v1.16b
    mov v25.16b, v5.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    mov v26.16b, v3.16b
    mov v27.16b, v7.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    mov v24.16b, v2.16b
    mov v25.16b, v6.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    mov v26.16b, v0.16b
    mov v27.16b, v4.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    mov v24.16b, v3.16b
    mov v25.16b, v7.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    mov v26.16b, v1.16b
    mov v27.16b, v5.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v1.16b, v28.16b
    aese v5.16b, v29.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    mov v24.16b, v0.16b
    mov v25.16b, v4.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    mov v26.16b, v2.16b
    mov v27.16b, v6.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    mov v24.16b, v1.16b
    mov v25.16b, v5.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    mov v26.16b, v3.16b
    mov v27.16b, v7.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    mov v24.16b, v2.16b
    mov v25.16b, v6.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    mov v26.16b, v0.16b
    mov v27.16b, v4.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    mov v24.16b, v3.16b
    mov v25.16b, v7.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    mov v26.16b, v1.16b
    mov v27.16b, v5.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v1.16b, v28.16b
    aese v5.16b, v29.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    mov v24.16b, v0.16b
    mov v25.16b, v4.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    mov v26.16b, v2.16b
    mov v27.16b, v6.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    mov v24.16b, v1.16b
    mov v25.16b, v5.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    mov v26.16b, v3.16b
    mov v27.16b, v7.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    mov v24.16b, v2.16b
    mov v25.16b, v6.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    mov v26.16b, v0.16b
    mov v27.16b, v4.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    mov v24.16b, v3.16b
    mov v25.16b, v7.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    mov v26.16b, v1.16b
    mov v27.16b, v5.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v1.16b, v28.16b
    aese v5.16b, v29.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    mov v24.16b, v0.16b
    mov v25.16b, v4.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    mov v26.16b, v2.16b
    mov v27.16b, v6.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    mov v24.16b, v1.16b
    mov v25.16b, v5.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    mov v26.16b, v3.16b
    mov v27.16b, v7.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    mov v24.16b, v2.16b
    mov v25.16b, v6.16b
    aese v24.16b, v30.16b
    aese v25.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    mov v26.16b, v0.16b
    mov v27.16b, v4.16b
    aese v26.16b, v30.16b
    aese v27.16b, v30.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    eor v26.16b, v20.16b, v7.16b
    eor v27.16b, v21.16b, v4.16b
    eor v28.16b, v22.16b, v5.16b
    eor v29.16b, v23.16b, v6.16b
    eor v6.16b, v16.16b, v3.16b
    eor v7.16b, v17.16b, v0.16b
    eor v24.16b, v18.16b, v1.16b
    eor v25.16b, v19.16b, v2.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    eor v0.16b, v0.16b, v6.16b
    eor v1.16b, v1.16b, v7.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v30.16b
    aese v0.16b, v30.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v30.16b
    aese v1.16b, v30.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v30.16b
    aese v0.16b, v30.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v30.16b
    aese v1.16b, v30.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v30.16b
    aese v0.16b, v30.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v30.16b
    aese v1.16b, v30.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v30.16b
    aese v0.16b, v30.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    eor v3.16b, v3.16b, v26.16b
    eor v0.16b, v0.16b, v27.16b
    eor v1.16b, v1.16b, v28.16b
    eor v2.16b, v2.16b, v29.16b
    AREION_ARM64_ADR(x4, roundConstantsP2)
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v30.16b
    aese v1.16b, v30.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v30.16b
    aese v0.16b, v30.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v30.16b
    aese v1.16b, v30.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v30.16b
    aese v0.16b, v30.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v30.16b
    aese v1.16b, v30.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v2.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aese v2.16b, v30.16b
    aese v0.16b, v30.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v3.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aese v3.16b, v30.16b
    aese v1.16b, v30.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v0.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    mov v5.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    eor v24.16b, v24.16b, v28.16b
    eor v25.16b, v25.16b, v29.16b
    eor v2.16b, v2.16b, v6.16b
    eor v3.16b, v3.16b, v7.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    st1 { v2.16b }, [x0], #16
    st1 { v3.16b }, [x0], #16
    st1 { v0.16b }, [x0], #16
    st1 { v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    mov x5, xzr
    ret
AREION_FUNC_END(areion512TEM2EncryptAsm)

AREION_FUNC_START(areion512TEM2DecryptAsm)
    sub sp, sp, #48
    stp d8, d9, [sp]
    stp d10, d11, [sp, #16]
    stp d12, d13, [sp, #32]
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2]
    eor v4.16b, v0.16b, v20.16b
    eor v5.16b, v1.16b, v21.16b
    eor v6.16b, v2.16b, v22.16b
    eor v7.16b, v3.16b, v23.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v31.16b, v31.16b, v31.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    AREION_ARM64_ADR(x5, roundConstantsP2)
    ld1 { v12.16b }, [x4], #16
    ld1 { v13.16b }, [x5], #16
    mov v8.16b, v0.16b
    mov v9.16b, v4.16b
    aese v8.16b, v31.16b
    aese v9.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    eor v1.16b, v1.16b, v8.16b
    eor v5.16b, v5.16b, v9.16b
    mov v10.16b, v2.16b
    mov v11.16b, v6.16b
    aese v10.16b, v31.16b
    aese v11.16b, v31.16b
    aesmc v10.16b, v10.16b
    aesmc v11.16b, v11.16b
    eor v3.16b, v3.16b, v10.16b
    eor v7.16b, v7.16b, v11.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v2.16b, v12.16b
    aese v6.16b, v13.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v12.16b }, [x4], #16
    ld1 { v13.16b }, [x5], #16
    mov v8.16b, v1.16b
    mov v9.16b, v5.16b
    aese v8.16b, v31.16b
    aese v9.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    eor v2.16b, v2.16b, v8.16b
    eor v6.16b, v6.16b, v9.16b
    mov v10.16b, v3.16b
    mov v11.16b, v7.16b
    aese v10.16b, v31.16b
    aese v11.16b, v31.16b
    aesmc v10.16b, v10.16b
    aesmc v11.16b, v11.16b
    eor v0.16b, v0.16b, v10.16b
    eor v4.16b, v4.16b, v11.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v3.16b, v12.16b
    aese v7.16b, v13.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v12.16b }, [x4], #16
    ld1 { v13.16b }, [x5], #16
    mov v8.16b, v2.16b
    mov v9.16b, v6.16b
    aese v8.16b, v31.16b
    aese v9.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    eor v3.16b, v3.16b, v8.16b
    eor v7.16b, v7.16b, v9.16b
    mov v10.16b, v0.16b
    mov v11.16b, v4.16b
    aese v10.16b, v31.16b
    aese v11.16b, v31.16b
    aesmc v10.16b, v10.16b
    aesmc v11.16b, v11.16b
    eor v1.16b, v1.16b, v10.16b
    eor v5.16b, v5.16b, v11.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v0.16b, v12.16b
    aese v4.16b, v13.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v12.16b }, [x4], #16
    ld1 { v13.16b }, [x5], #16
    mov v8.16b, v3.16b
    mov v9.16b, v7.16b
    aese v8.16b, v31.16b
    aese v9.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    eor v0.16b, v0.16b, v8.16b
    eor v4.16b, v4.16b, v9.16b
    mov v10.16b, v1.16b
    mov v11.16b, v5.16b
    aese v10.16b, v31.16b
    aese v11.16b, v31.16b
    aesmc v10.16b, v10.16b
    aesmc v11.16b, v11.16b
    eor v2.16b, v2.16b, v10.16b
    eor v6.16b, v6.16b, v11.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v1.16b, v12.16b
    aese v5.16b, v13.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v12.16b }, [x4], #16
    ld1 { v13.16b }, [x5], #16
    mov v8.16b, v0.16b
    mov v9.16b, v4.16b
    aese v8.16b, v31.16b
    aese v9.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    eor v1.16b, v1.16b, v8.16b
    eor v5.16b, v5.16b, v9.16b
    mov v10.16b, v2.16b
    mov v11.16b, v6.16b
    aese v10.16b, v31.16b
    aese v11.16b, v31.16b
    aesmc v10.16b, v10.16b
    aesmc v11.16b, v11.16b
    eor v3.16b, v3.16b, v10.16b
    eor v7.16b, v7.16b, v11.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v2.16b, v12.16b
    aese v6.16b, v13.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v12.16b }, [x4], #16
    ld1 { v13.16b }, [x5], #16
    mov v8.16b, v1.16b
    mov v9.16b, v5.16b
    aese v8.16b, v31.16b
    aese v9.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    eor v2.16b, v2.16b, v8.16b
    eor v6.16b, v6.16b, v9.16b
    mov v10.16b, v3.16b
    mov v11.16b, v7.16b
    aese v10.16b, v31.16b
    aese v11.16b, v31.16b
    aesmc v10.16b, v10.16b
    aesmc v11.16b, v11.16b
    eor v0.16b, v0.16b, v10.16b
    eor v4.16b, v4.16b, v11.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v3.16b, v12.16b
    aese v7.16b, v13.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v12.16b }, [x4], #16
    ld1 { v13.16b }, [x5], #16
    mov v8.16b, v2.16b
    mov v9.16b, v6.16b
    aese v8.16b, v31.16b
    aese v9.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    eor v3.16b, v3.16b, v8.16b
    eor v7.16b, v7.16b, v9.16b
    mov v10.16b, v0.16b
    mov v11.16b, v4.16b
    aese v10.16b, v31.16b
    aese v11.16b, v31.16b
    aesmc v10.16b, v10.16b
    aesmc v11.16b, v11.16b
    eor v1.16b, v1.16b, v10.16b
    eor v5.16b, v5.16b, v11.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v0.16b, v12.16b
    aese v4.16b, v13.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v12.16b }, [x4], #16
    ld1 { v13.16b }, [x5], #16
    mov v8.16b, v3.16b
    mov v9.16b, v7.16b
    aese v8.16b, v31.16b
    aese v9.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    eor v0.16b, v0.16b, v8.16b
    eor v4.16b, v4.16b, v9.16b
    mov v10.16b, v1.16b
    mov v11.16b, v5.16b
    aese v10.16b, v31.16b
    aese v11.16b, v31.16b
    aesmc v10.16b, v10.16b
    aesmc v11.16b, v11.16b
    eor v2.16b, v2.16b, v10.16b
    eor v6.16b, v6.16b, v11.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v1.16b, v12.16b
    aese v5.16b, v13.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v12.16b }, [x4], #16
    ld1 { v13.16b }, [x5], #16
    mov v8.16b, v0.16b
    mov v9.16b, v4.16b
    aese v8.16b, v31.16b
    aese v9.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    eor v1.16b, v1.16b, v8.16b
    eor v5.16b, v5.16b, v9.16b
    mov v10.16b, v2.16b
    mov v11.16b, v6.16b
    aese v10.16b, v31.16b
    aese v11.16b, v31.16b
    aesmc v10.16b, v10.16b
    aesmc v11.16b, v11.16b
    eor v3.16b, v3.16b, v10.16b
    eor v7.16b, v7.16b, v11.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v2.16b, v12.16b
    aese v6.16b, v13.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v12.16b }, [x4], #16
    ld1 { v13.16b }, [x5], #16
    mov v8.16b, v1.16b
    mov v9.16b, v5.16b
    aese v8.16b, v31.16b
    aese v9.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    eor v2.16b, v2.16b, v8.16b
    eor v6.16b, v6.16b, v9.16b
    mov v10.16b, v3.16b
    mov v11.16b, v7.16b
    aese v10.16b, v31.16b
    aese v11.16b, v31.16b
    aesmc v10.16b, v10.16b
    aesmc v11.16b, v11.16b
    eor v0.16b, v0.16b, v10.16b
    eor v4.16b, v4.16b, v11.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v3.16b, v12.16b
    aese v7.16b, v13.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v12.16b }, [x4], #16
    ld1 { v13.16b }, [x5], #16
    mov v8.16b, v2.16b
    mov v9.16b, v6.16b
    aese v8.16b, v31.16b
    aese v9.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    eor v3.16b, v3.16b, v8.16b
    eor v7.16b, v7.16b, v9.16b
    mov v10.16b, v0.16b
    mov v11.16b, v4.16b
    aese v10.16b, v31.16b
    aese v11.16b, v31.16b
    aesmc v10.16b, v10.16b
    aesmc v11.16b, v11.16b
    eor v1.16b, v1.16b, v10.16b
    eor v5.16b, v5.16b, v11.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v0.16b, v12.16b
    aese v4.16b, v13.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v12.16b }, [x4], #16
    ld1 { v13.16b }, [x5], #16
    mov v8.16b, v3.16b
    mov v9.16b, v7.16b
    aese v8.16b, v31.16b
    aese v9.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    eor v0.16b, v0.16b, v8.16b
    eor v4.16b, v4.16b, v9.16b
    mov v10.16b, v1.16b
    mov v11.16b, v5.16b
    aese v10.16b, v31.16b
    aese v11.16b, v31.16b
    aesmc v10.16b, v10.16b
    aesmc v11.16b, v11.16b
    eor v2.16b, v2.16b, v10.16b
    eor v6.16b, v6.16b, v11.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v1.16b, v12.16b
    aese v5.16b, v13.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v12.16b }, [x4], #16
    ld1 { v13.16b }, [x5], #16
    mov v8.16b, v0.16b
    mov v9.16b, v4.16b
    aese v8.16b, v31.16b
    aese v9.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    eor v1.16b, v1.16b, v8.16b
    eor v5.16b, v5.16b, v9.16b
    mov v10.16b, v2.16b
    mov v11.16b, v6.16b
    aese v10.16b, v31.16b
    aese v11.16b, v31.16b
    aesmc v10.16b, v10.16b
    aesmc v11.16b, v11.16b
    eor v3.16b, v3.16b, v10.16b
    eor v7.16b, v7.16b, v11.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v2.16b, v12.16b
    aese v6.16b, v13.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v12.16b }, [x4], #16
    ld1 { v13.16b }, [x5], #16
    mov v8.16b, v1.16b
    mov v9.16b, v5.16b
    aese v8.16b, v31.16b
    aese v9.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    eor v2.16b, v2.16b, v8.16b
    eor v6.16b, v6.16b, v9.16b
    mov v10.16b, v3.16b
    mov v11.16b, v7.16b
    aese v10.16b, v31.16b
    aese v11.16b, v31.16b
    aesmc v10.16b, v10.16b
    aesmc v11.16b, v11.16b
    eor v0.16b, v0.16b, v10.16b
    eor v4.16b, v4.16b, v11.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v3.16b, v12.16b
    aese v7.16b, v13.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v12.16b }, [x4], #16
    ld1 { v13.16b }, [x5], #16
    mov v8.16b, v2.16b
    mov v9.16b, v6.16b
    aese v8.16b, v31.16b
    aese v9.16b, v31.16b
    aesmc v8.16b, v8.16b
    aesmc v9.16b, v9.16b
    eor v3.16b, v3.16b, v8.16b
    eor v7.16b, v7.16b, v9.16b
    mov v10.16b, v0.16b
    mov v11.16b, v4.16b
    aese v10.16b, v31.16b
    aese v11.16b, v31.16b
    aesmc v10.16b, v10.16b
    aesmc v11.16b, v11.16b
    eor v1.16b, v1.16b, v10.16b
    eor v5.16b, v5.16b, v11.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v0.16b, v12.16b
    aese v4.16b, v13.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    eor v10.16b, v20.16b, v7.16b
    eor v11.16b, v21.16b, v4.16b
    eor v12.16b, v22.16b, v5.16b
    eor v13.16b, v23.16b, v6.16b
    eor v6.16b, v16.16b, v3.16b
    eor v7.16b, v17.16b, v0.16b
    eor v8.16b, v18.16b, v1.16b
    eor v9.16b, v19.16b, v2.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    eor v0.16b, v0.16b, v6.16b
    eor v1.16b, v1.16b, v7.16b
    eor v2.16b, v2.16b, v8.16b
    eor v3.16b, v3.16b, v9.16b
    eor v0.16b, v0.16b, v10.16b
    eor v1.16b, v1.16b, v11.16b
    eor v2.16b, v2.16b, v12.16b
    eor v3.16b, v3.16b, v13.16b
    AREION_ARM64_ADR(x4, roundConstantsP2)
    ld1 { v16.16b }, [x4], #16
    ld1 { v17.16b }, [x4], #16
    ld1 { v18.16b }, [x4], #16
    ld1 { v19.16b }, [x4], #16
    ld1 { v20.16b }, [x4], #16
    ld1 { v21.16b }, [x4], #16
    ld1 { v22.16b }, [x4], #16
    ld1 { v23.16b }, [x4], #16
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x4], #16
    ld1 { v26.16b }, [x4], #16
    ld1 { v27.16b }, [x4], #16
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x4], #16
    ld1 { v30.16b }, [x4], #16
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v30.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v29.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v28.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v27.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v26.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v25.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v24.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v23.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v22.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v21.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v20.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v19.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v18.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v17.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v16.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    eor v1.16b, v1.16b, v10.16b
    eor v2.16b, v2.16b, v11.16b
    eor v3.16b, v3.16b, v12.16b
    eor v0.16b, v0.16b, v13.16b
    AREION_ARM64_ADR(x4, roundConstantsP1)
    ld1 { v16.16b }, [x4], #16
    ld1 { v17.16b }, [x4], #16
    ld1 { v18.16b }, [x4], #16
    ld1 { v19.16b }, [x4], #16
    ld1 { v20.16b }, [x4], #16
    ld1 { v21.16b }, [x4], #16
    ld1 { v22.16b }, [x4], #16
    ld1 { v23.16b }, [x4], #16
    ld1 { v24.16b }, [x4], #16
    ld1 { v25.16b }, [x4], #16
    ld1 { v26.16b }, [x4], #16
    ld1 { v27.16b }, [x4], #16
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x4], #16
    ld1 { v30.16b }, [x4], #16
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v30.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v29.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v28.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v27.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v26.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v25.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v24.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v23.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v22.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v21.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v20.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesd v3.16b, v19.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesd v2.16b, v18.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesd v1.16b, v17.16b
    mov v5.16b, v3.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    mov v5.16b, v1.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesd v0.16b, v16.16b
    mov v5.16b, v2.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    mov v5.16b, v0.16b
    aese v5.16b, v31.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    eor v2.16b, v2.16b, v6.16b
    eor v3.16b, v3.16b, v7.16b
    eor v0.16b, v0.16b, v8.16b
    eor v1.16b, v1.16b, v9.16b
    st1 { v2.16b }, [x0], #16
    st1 { v3.16b }, [x0], #16
    st1 { v0.16b }, [x0], #16
    st1 { v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    eor v8.16b, v8.16b, v8.16b
    eor v9.16b, v9.16b, v9.16b
    eor v10.16b, v10.16b, v10.16b
    eor v11.16b, v11.16b, v11.16b
    eor v12.16b, v12.16b, v12.16b
    eor v13.16b, v13.16b, v13.16b
    eor v31.16b, v31.16b, v31.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    eor v25.16b, v25.16b, v25.16b
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    eor v29.16b, v29.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    mov x5, xzr
    ldp d8, d9, [sp]
    ldp d10, d11, [sp, #16]
    ldp d12, d13, [sp, #32]
    stp xzr, xzr, [sp]
    stp xzr, xzr, [sp, #16]
    stp xzr, xzr, [sp, #32]
    add sp, sp, #48
    ret
AREION_FUNC_END(areion512TEM2DecryptAsm)

#endif /* __aarch64__ || _M_ARM64 */

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
