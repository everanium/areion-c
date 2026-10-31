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

AREION_FUNC_START(vistrutah256EncryptBlockAsm)
    AREION_ARM64_ADR(x4, vistrutahConsts)
    ld1 { v6.16b, v7.16b }, [x4]
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    ld1 { v0.16b, v1.16b }, [x1]
    ld1 { v2.16b, v3.16b }, [x2]
    mov v4.16b, v3.16b
    mov v5.16b, v2.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v2.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v3.16b
    aesmc v1.16b, v1.16b
    uzp1 v16.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v16.16b
    tbl v4.16b, { v4.16b }, v6.16b
    tbl v5.16b, { v5.16b }, v7.16b
    ld1 { v16.16b }, [x4], #16
    eor v16.16b, v16.16b, v4.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v2.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v3.16b
    aesmc v1.16b, v1.16b
    uzp1 v16.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v16.16b
    tbl v4.16b, { v4.16b }, v6.16b
    tbl v5.16b, { v5.16b }, v7.16b
    ld1 { v16.16b }, [x4], #16
    eor v16.16b, v16.16b, v4.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v2.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v3.16b
    aesmc v1.16b, v1.16b
    uzp1 v16.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v16.16b
    tbl v4.16b, { v4.16b }, v6.16b
    tbl v5.16b, { v5.16b }, v7.16b
    ld1 { v16.16b }, [x4], #16
    eor v16.16b, v16.16b, v4.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v2.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v3.16b
    aesmc v1.16b, v1.16b
    uzp1 v16.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v16.16b
    tbl v4.16b, { v4.16b }, v6.16b
    tbl v5.16b, { v5.16b }, v7.16b
    cmp x3, #10
    b.eq .Lv256_blk_arm64_final
    ld1 { v16.16b }, [x4], #16
    eor v16.16b, v16.16b, v4.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v2.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v3.16b
    aesmc v1.16b, v1.16b
    uzp1 v16.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v16.16b
    tbl v4.16b, { v4.16b }, v6.16b
    tbl v5.16b, { v5.16b }, v7.16b
    ld1 { v16.16b }, [x4], #16
    eor v16.16b, v16.16b, v4.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v2.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v3.16b
    aesmc v1.16b, v1.16b
    uzp1 v16.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v16.16b
    tbl v4.16b, { v4.16b }, v6.16b
    tbl v5.16b, { v5.16b }, v7.16b
.Lv256_blk_arm64_final:
    ld1 { v16.16b }, [x4], #16
    eor v16.16b, v16.16b, v4.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v2.16b
    aese v1.16b, v3.16b
    tbl v4.16b, { v4.16b }, v6.16b
    tbl v5.16b, { v5.16b }, v7.16b
    eor v0.16b, v0.16b, v4.16b
    eor v1.16b, v1.16b, v5.16b
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
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(vistrutah256EncryptBlockAsm)

AREION_FUNC_START(vistrutah256DecryptBlockAsm)
    AREION_ARM64_ADR(x4, vistrutahConsts)
    ld1 { v6.16b, v7.16b }, [x4]
    add x4, x4, #288
    ld1 { v17.16b, v18.16b }, [x4]
    add x4, x4, #64
    ld1 { v19.16b, v20.16b }, [x4]
    ld1 { v0.16b, v1.16b }, [x1]
    ld1 { v2.16b, v3.16b }, [x2]
    mov v4.16b, v3.16b
    mov v5.16b, v2.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    eor v21.16b, v21.16b, v21.16b
    tbl v4.16b, { v4.16b }, v19.16b
    tbl v5.16b, { v5.16b }, v20.16b
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    add x4, x4, #48
    cmp x3, #10
    b.eq .Lv256_dec_blk_arm64_init_done
    tbl v4.16b, { v4.16b }, v6.16b
    tbl v5.16b, { v5.16b }, v7.16b
    tbl v4.16b, { v4.16b }, v6.16b
    tbl v5.16b, { v5.16b }, v7.16b
    add x4, x4, #32
.Lv256_dec_blk_arm64_init_done:
    aesd v0.16b, v4.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v5.16b
    aesimc v1.16b, v1.16b
    cmp x3, #10
    b.eq .Lv256_dec_blk_arm64_step4
    aesd v0.16b, v2.16b
    aesd v1.16b, v3.16b
    tbl v4.16b, { v4.16b }, v17.16b
    tbl v5.16b, { v5.16b }, v18.16b
    ld1 { v16.16b }, [x4]
    sub x4, x4, #16
    eor v16.16b, v16.16b, v4.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v5.16b
    zip1 v16.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v16.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v21.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v21.16b
    aesimc v1.16b, v1.16b
    aesd v0.16b, v2.16b
    aesd v1.16b, v3.16b
    tbl v4.16b, { v4.16b }, v17.16b
    tbl v5.16b, { v5.16b }, v18.16b
    ld1 { v16.16b }, [x4]
    sub x4, x4, #16
    eor v16.16b, v16.16b, v4.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v5.16b
    zip1 v16.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v16.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v21.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v21.16b
    aesimc v1.16b, v1.16b
.Lv256_dec_blk_arm64_step4:
    aesd v0.16b, v2.16b
    aesd v1.16b, v3.16b
    tbl v4.16b, { v4.16b }, v17.16b
    tbl v5.16b, { v5.16b }, v18.16b
    ld1 { v16.16b }, [x4]
    sub x4, x4, #16
    eor v16.16b, v16.16b, v4.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v5.16b
    zip1 v16.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v16.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v21.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v21.16b
    aesimc v1.16b, v1.16b
    aesd v0.16b, v2.16b
    aesd v1.16b, v3.16b
    tbl v4.16b, { v4.16b }, v17.16b
    tbl v5.16b, { v5.16b }, v18.16b
    ld1 { v16.16b }, [x4]
    sub x4, x4, #16
    eor v16.16b, v16.16b, v4.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v5.16b
    zip1 v16.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v16.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v21.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v21.16b
    aesimc v1.16b, v1.16b
    aesd v0.16b, v2.16b
    aesd v1.16b, v3.16b
    tbl v4.16b, { v4.16b }, v17.16b
    tbl v5.16b, { v5.16b }, v18.16b
    ld1 { v16.16b }, [x4]
    sub x4, x4, #16
    eor v16.16b, v16.16b, v4.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v5.16b
    zip1 v16.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v16.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v21.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v21.16b
    aesimc v1.16b, v1.16b
    aesd v0.16b, v2.16b
    aesd v1.16b, v3.16b
    tbl v4.16b, { v4.16b }, v17.16b
    tbl v5.16b, { v5.16b }, v18.16b
    ld1 { v16.16b }, [x4]
    sub x4, x4, #16
    eor v16.16b, v16.16b, v4.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v5.16b
    zip1 v16.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v16.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v21.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v21.16b
    aesimc v1.16b, v1.16b
    aesd v0.16b, v2.16b
    aesd v1.16b, v3.16b
    tbl v4.16b, { v4.16b }, v17.16b
    tbl v5.16b, { v5.16b }, v18.16b
    eor v0.16b, v0.16b, v4.16b
    eor v1.16b, v1.16b, v5.16b
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
    eor v21.16b, v21.16b, v21.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(vistrutah256DecryptBlockAsm)

AREION_FUNC_START(vistrutah256Encrypt4BlocksAsm)
    AREION_ARM64_ADR(x4, vistrutahConsts)
    ld1 { v20.16b, v21.16b }, [x4]
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    ld1 { v16.16b, v17.16b }, [x2]
    mov v18.16b, v17.16b
    mov v19.16b, v16.16b
    aese v0.16b, v18.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v19.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    uzp1 v23.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v23.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v16.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    uzp1 v23.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v23.16b
    aese v4.16b, v18.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v19.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    uzp1 v23.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v23.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v16.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v17.16b
    aesmc v7.16b, v7.16b
    uzp1 v23.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v23.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v18.16b
    aese v0.16b, v22.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v19.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    uzp1 v23.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v23.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v16.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    uzp1 v23.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v23.16b
    aese v4.16b, v22.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v19.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    uzp1 v23.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v23.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v16.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v17.16b
    aesmc v7.16b, v7.16b
    uzp1 v23.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v23.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v18.16b
    aese v0.16b, v22.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v19.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    uzp1 v23.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v23.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v16.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    uzp1 v23.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v23.16b
    aese v4.16b, v22.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v19.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    uzp1 v23.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v23.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v16.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v17.16b
    aesmc v7.16b, v7.16b
    uzp1 v23.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v23.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v18.16b
    aese v0.16b, v22.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v19.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    uzp1 v23.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v23.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v16.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    uzp1 v23.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v23.16b
    aese v4.16b, v22.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v19.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    uzp1 v23.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v23.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v16.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v17.16b
    aesmc v7.16b, v7.16b
    uzp1 v23.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v23.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    cmp x3, #10
    b.eq .Lv256_4blk_arm64_final
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v18.16b
    aese v0.16b, v22.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v19.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    uzp1 v23.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v23.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v16.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    uzp1 v23.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v23.16b
    aese v4.16b, v22.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v19.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    uzp1 v23.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v23.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v16.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v17.16b
    aesmc v7.16b, v7.16b
    uzp1 v23.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v23.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v18.16b
    aese v0.16b, v22.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v19.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    uzp1 v23.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v23.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v16.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    uzp1 v23.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v23.16b
    aese v4.16b, v22.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v19.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    uzp1 v23.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v23.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v16.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v17.16b
    aesmc v7.16b, v7.16b
    uzp1 v23.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v23.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
.Lv256_4blk_arm64_final:
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v18.16b
    aese v0.16b, v22.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v19.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v16.16b
    aese v1.16b, v17.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v16.16b
    aese v3.16b, v17.16b
    aese v4.16b, v22.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v19.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v16.16b
    aese v5.16b, v17.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v16.16b
    aese v7.16b, v17.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v18.16b
    eor v5.16b, v5.16b, v19.16b
    eor v6.16b, v6.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0], #64
    st1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x0]
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
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(vistrutah256Encrypt4BlocksAsm)

AREION_FUNC_START(vistrutah256Decrypt4BlocksAsm)
    AREION_ARM64_ADR(x4, vistrutahConsts)
    ld1 { v20.16b, v21.16b }, [x4]
    add x4, x4, #352
    ld1 { v22.16b, v23.16b }, [x4]
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    ld1 { v16.16b, v17.16b }, [x2]
    mov v18.16b, v17.16b
    mov v19.16b, v16.16b
    aesimc v16.16b, v16.16b
    aesimc v17.16b, v17.16b
    eor v24.16b, v24.16b, v24.16b
    tbl v18.16b, { v18.16b }, v22.16b
    tbl v19.16b, { v19.16b }, v23.16b
    sub x4, x4, #64
    ld1 { v22.16b, v23.16b }, [x4]
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    add x4, x4, #48
    cmp x3, #10
    b.eq .Lv256_dec_4blk_arm64_init_done
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    add x4, x4, #32
.Lv256_dec_4blk_arm64_init_done:
    mov v20.16b, v22.16b
    mov v21.16b, v23.16b
    aesd v0.16b, v18.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v19.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v18.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v19.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v18.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v19.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v18.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v19.16b
    aesimc v7.16b, v7.16b
    cmp x3, #10
    b.eq .Lv256_dec_4blk_arm64_step4
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4]
    sub x4, x4, #16
    eor v22.16b, v22.16b, v18.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v19.16b
    zip1 v23.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v16.16b
    aesd v3.16b, v17.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v19.16b
    zip1 v23.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v23.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    eor v4.16b, v4.16b, v22.16b
    eor v5.16b, v5.16b, v19.16b
    zip1 v23.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v23.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v24.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v24.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v16.16b
    aesd v7.16b, v17.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v19.16b
    zip1 v23.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v23.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v24.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v24.16b
    aesimc v7.16b, v7.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4]
    sub x4, x4, #16
    eor v22.16b, v22.16b, v18.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v19.16b
    zip1 v23.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v16.16b
    aesd v3.16b, v17.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v19.16b
    zip1 v23.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v23.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    eor v4.16b, v4.16b, v22.16b
    eor v5.16b, v5.16b, v19.16b
    zip1 v23.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v23.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v24.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v24.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v16.16b
    aesd v7.16b, v17.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v19.16b
    zip1 v23.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v23.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v24.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v24.16b
    aesimc v7.16b, v7.16b
.Lv256_dec_4blk_arm64_step4:
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4]
    sub x4, x4, #16
    eor v22.16b, v22.16b, v18.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v19.16b
    zip1 v23.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v16.16b
    aesd v3.16b, v17.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v19.16b
    zip1 v23.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v23.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    eor v4.16b, v4.16b, v22.16b
    eor v5.16b, v5.16b, v19.16b
    zip1 v23.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v23.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v24.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v24.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v16.16b
    aesd v7.16b, v17.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v19.16b
    zip1 v23.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v23.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v24.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v24.16b
    aesimc v7.16b, v7.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4]
    sub x4, x4, #16
    eor v22.16b, v22.16b, v18.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v19.16b
    zip1 v23.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v16.16b
    aesd v3.16b, v17.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v19.16b
    zip1 v23.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v23.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    eor v4.16b, v4.16b, v22.16b
    eor v5.16b, v5.16b, v19.16b
    zip1 v23.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v23.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v24.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v24.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v16.16b
    aesd v7.16b, v17.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v19.16b
    zip1 v23.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v23.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v24.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v24.16b
    aesimc v7.16b, v7.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4]
    sub x4, x4, #16
    eor v22.16b, v22.16b, v18.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v19.16b
    zip1 v23.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v16.16b
    aesd v3.16b, v17.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v19.16b
    zip1 v23.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v23.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    eor v4.16b, v4.16b, v22.16b
    eor v5.16b, v5.16b, v19.16b
    zip1 v23.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v23.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v24.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v24.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v16.16b
    aesd v7.16b, v17.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v19.16b
    zip1 v23.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v23.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v24.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v24.16b
    aesimc v7.16b, v7.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4]
    sub x4, x4, #16
    eor v22.16b, v22.16b, v18.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v19.16b
    zip1 v23.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v16.16b
    aesd v3.16b, v17.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v19.16b
    zip1 v23.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v23.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    eor v4.16b, v4.16b, v22.16b
    eor v5.16b, v5.16b, v19.16b
    zip1 v23.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v23.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v24.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v24.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v16.16b
    aesd v7.16b, v17.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v19.16b
    zip1 v23.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v23.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v24.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v24.16b
    aesimc v7.16b, v7.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    aesd v2.16b, v16.16b
    aesd v3.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v5.16b, v5.16b, v19.16b
    aesd v6.16b, v16.16b
    aesd v7.16b, v17.16b
    eor v6.16b, v6.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0], #64
    st1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x0]
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
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(vistrutah256Decrypt4BlocksAsm)

AREION_FUNC_START(vistrutah512EncryptBlock256Asm)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    ld1 { v4.16b, v5.16b }, [x2]
    AREION_ARM64_ADR(x4, vistrutahConsts)
    add x4, x4, #256
    ld1 { v20.16b, v21.16b }, [x4]
    tbl v6.16b, { v4.16b, v5.16b }, v20.16b
    tbl v7.16b, { v4.16b, v5.16b }, v21.16b
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    mov v16.16b, v5.16b
    mov v17.16b, v4.16b
    mov v18.16b, v7.16b
    mov v19.16b, v6.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    cmp x3, #10
    b.eq .Lv512_blk256_arm64_final
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    cmp x3, #12
    b.eq .Lv512_blk256_arm64_final
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    cmp x3, #14
    b.eq .Lv512_blk256_arm64_final
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
.Lv512_blk256_arm64_final:
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aese v1.16b, v5.16b
    aese v2.16b, v6.16b
    aese v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
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
    ret
AREION_FUNC_END(vistrutah512EncryptBlock256Asm)

AREION_FUNC_START(vistrutah512DecryptBlock256Asm)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    ld1 { v4.16b, v5.16b }, [x2]
    AREION_ARM64_ADR(x4, vistrutahConsts)
    add x4, x4, #256
    ld1 { v20.16b, v21.16b }, [x4]
    tbl v6.16b, { v4.16b, v5.16b }, v20.16b
    tbl v7.16b, { v4.16b, v5.16b }, v21.16b
    mov v16.16b, v5.16b
    mov v17.16b, v4.16b
    mov v18.16b, v7.16b
    mov v19.16b, v6.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    eor v24.16b, v24.16b, v24.16b
    ext v16.16b, v16.16b, v16.16b, #9
    ext v17.16b, v17.16b, v17.16b, #2
    ext v18.16b, v18.16b, v18.16b, #9
    ext v19.16b, v19.16b, v19.16b, #2
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    add x4, x4, #48
    cmp x3, #10
    b.eq .Lv512_dec_blk256_arm64_init_done
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    add x4, x4, #16
    cmp x3, #12
    b.eq .Lv512_dec_blk256_arm64_init_done
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    add x4, x4, #16
    cmp x3, #14
    b.eq .Lv512_dec_blk256_arm64_init_done
    ext v16.16b, v16.16b, v16.16b, #10
    ext v17.16b, v17.16b, v17.16b, #4
    ext v18.16b, v18.16b, v18.16b, #10
    ext v19.16b, v19.16b, v19.16b, #4
    add x4, x4, #32
.Lv512_dec_blk256_arm64_init_done:
    aesd v0.16b, v16.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v17.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v18.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v19.16b
    aesimc v3.16b, v3.16b
    cmp x3, #10
    b.eq .Lv512_dec_blk256_arm64_step4
    cmp x3, #12
    b.eq .Lv512_dec_blk256_arm64_step5
    cmp x3, #14
    b.eq .Lv512_dec_blk256_arm64_step6
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
.Lv512_dec_blk256_arm64_step6:
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
.Lv512_dec_blk256_arm64_step5:
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
.Lv512_dec_blk256_arm64_step4:
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
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
AREION_FUNC_END(vistrutah512DecryptBlock256Asm)

AREION_FUNC_START(vistrutah512EncryptBlock512Asm)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x2]
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    mov v16.16b, v5.16b
    mov v17.16b, v4.16b
    mov v18.16b, v7.16b
    mov v19.16b, v6.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    cmp x3, #10
    b.eq .Lv512_blk512_arm64_final
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    cmp x3, #12
    b.eq .Lv512_blk512_arm64_final
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    cmp x3, #14
    b.eq .Lv512_blk512_arm64_final
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v6.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v7.16b
    aesmc v3.16b, v3.16b
    zip1 v20.16b, v0.16b, v2.16b
    zip2 v21.16b, v0.16b, v2.16b
    zip1 v22.16b, v1.16b, v3.16b
    zip2 v23.16b, v1.16b, v3.16b
    zip1 v0.16b, v20.16b, v22.16b
    zip2 v2.16b, v20.16b, v22.16b
    zip1 v1.16b, v21.16b, v23.16b
    zip2 v3.16b, v21.16b, v23.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
.Lv512_blk512_arm64_final:
    ld1 { v20.16b }, [x4], #16
    eor v20.16b, v20.16b, v16.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v4.16b
    aese v1.16b, v5.16b
    aese v2.16b, v6.16b
    aese v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
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
    ret
AREION_FUNC_END(vistrutah512EncryptBlock512Asm)

AREION_FUNC_START(vistrutah512DecryptBlock512Asm)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x2]
    mov v16.16b, v5.16b
    mov v17.16b, v4.16b
    mov v18.16b, v7.16b
    mov v19.16b, v6.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    eor v24.16b, v24.16b, v24.16b
    ext v16.16b, v16.16b, v16.16b, #9
    ext v17.16b, v17.16b, v17.16b, #2
    ext v18.16b, v18.16b, v18.16b, #9
    ext v19.16b, v19.16b, v19.16b, #2
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    add x4, x4, #48
    cmp x3, #10
    b.eq .Lv512_dec_blk512_arm64_init_done
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    add x4, x4, #16
    cmp x3, #12
    b.eq .Lv512_dec_blk512_arm64_init_done
    ext v16.16b, v16.16b, v16.16b, #5
    ext v17.16b, v17.16b, v17.16b, #10
    ext v18.16b, v18.16b, v18.16b, #5
    ext v19.16b, v19.16b, v19.16b, #10
    add x4, x4, #16
    cmp x3, #14
    b.eq .Lv512_dec_blk512_arm64_init_done
    ext v16.16b, v16.16b, v16.16b, #10
    ext v17.16b, v17.16b, v17.16b, #4
    ext v18.16b, v18.16b, v18.16b, #10
    ext v19.16b, v19.16b, v19.16b, #4
    add x4, x4, #32
.Lv512_dec_blk512_arm64_init_done:
    aesd v0.16b, v16.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v17.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v18.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v19.16b
    aesimc v3.16b, v3.16b
    cmp x3, #10
    b.eq .Lv512_dec_blk512_arm64_step4
    cmp x3, #12
    b.eq .Lv512_dec_blk512_arm64_step5
    cmp x3, #14
    b.eq .Lv512_dec_blk512_arm64_step6
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
.Lv512_dec_blk512_arm64_step6:
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
.Lv512_dec_blk512_arm64_step5:
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
.Lv512_dec_blk512_arm64_step4:
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    eor v20.16b, v20.16b, v16.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    uzp1 v20.16b, v0.16b, v2.16b
    uzp2 v22.16b, v0.16b, v2.16b
    uzp1 v21.16b, v1.16b, v3.16b
    uzp2 v23.16b, v1.16b, v3.16b
    uzp1 v0.16b, v20.16b, v21.16b
    uzp2 v2.16b, v20.16b, v21.16b
    uzp1 v1.16b, v22.16b, v23.16b
    uzp2 v3.16b, v22.16b, v23.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v24.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v24.16b
    aesimc v3.16b, v3.16b
    aesd v0.16b, v4.16b
    aesd v1.16b, v5.16b
    aesd v2.16b, v6.16b
    aesd v3.16b, v7.16b
    ext v16.16b, v16.16b, v16.16b, #11
    ext v17.16b, v17.16b, v17.16b, #6
    ext v18.16b, v18.16b, v18.16b, #11
    ext v19.16b, v19.16b, v19.16b, #6
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
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
AREION_FUNC_END(vistrutah512DecryptBlock512Asm)

AREION_FUNC_START(vistrutah512Encrypt4Blocks256Asm)
    ld1 { v16.16b, v17.16b }, [x2]
    AREION_ARM64_ADR(x4, vistrutahConsts)
    add x4, x4, #256
    ld1 { v24.16b, v25.16b }, [x4]
    tbl v18.16b, { v16.16b, v17.16b }, v24.16b
    tbl v19.16b, { v16.16b, v17.16b }, v25.16b
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
    mov v20.16b, v17.16b
    mov v21.16b, v16.16b
    mov v22.16b, v19.16b
    mov v23.16b, v18.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v20.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    cmp x3, #10
    b.eq .Lv512_4blk256_arm64_p0_final
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    cmp x3, #12
    b.eq .Lv512_4blk256_arm64_p0_final
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    cmp x3, #14
    b.eq .Lv512_4blk256_arm64_p0_final
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
.Lv512_4blk256_arm64_p0_final:
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aese v1.16b, v17.16b
    aese v2.16b, v18.16b
    aese v3.16b, v19.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aese v5.16b, v17.16b
    aese v6.16b, v18.16b
    aese v7.16b, v19.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0], #64
    st1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x0], #64
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    mov v20.16b, v17.16b
    mov v21.16b, v16.16b
    mov v22.16b, v19.16b
    mov v23.16b, v18.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v20.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    cmp x3, #10
    b.eq .Lv512_4blk256_arm64_p1_final
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    cmp x3, #12
    b.eq .Lv512_4blk256_arm64_p1_final
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    cmp x3, #14
    b.eq .Lv512_4blk256_arm64_p1_final
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
.Lv512_4blk256_arm64_p1_final:
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aese v1.16b, v17.16b
    aese v2.16b, v18.16b
    aese v3.16b, v19.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aese v5.16b, v17.16b
    aese v6.16b, v18.16b
    aese v7.16b, v19.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0], #64
    st1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x0]
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
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(vistrutah512Encrypt4Blocks256Asm)

AREION_FUNC_START(vistrutah512Decrypt4Blocks256Asm)
    ld1 { v16.16b, v17.16b }, [x2]
    AREION_ARM64_ADR(x4, vistrutahConsts)
    add x4, x4, #256
    ld1 { v24.16b, v25.16b }, [x4]
    tbl v18.16b, { v16.16b, v17.16b }, v24.16b
    tbl v19.16b, { v16.16b, v17.16b }, v25.16b
    mov v20.16b, v17.16b
    mov v21.16b, v16.16b
    mov v22.16b, v19.16b
    mov v23.16b, v18.16b
    aesimc v16.16b, v16.16b
    aesimc v17.16b, v17.16b
    aesimc v18.16b, v18.16b
    aesimc v19.16b, v19.16b
    eor v29.16b, v29.16b, v29.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
    ext v20.16b, v20.16b, v20.16b, #9
    ext v21.16b, v21.16b, v21.16b, #2
    ext v22.16b, v22.16b, v22.16b, #9
    ext v23.16b, v23.16b, v23.16b, #2
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    add x4, x4, #48
    cmp x3, #10
    b.eq .Lv512_dec_4blk256_arm64_p0_init_done
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    add x4, x4, #16
    cmp x3, #12
    b.eq .Lv512_dec_4blk256_arm64_p0_init_done
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    add x4, x4, #16
    cmp x3, #14
    b.eq .Lv512_dec_4blk256_arm64_p0_init_done
    ext v20.16b, v20.16b, v20.16b, #10
    ext v21.16b, v21.16b, v21.16b, #4
    ext v22.16b, v22.16b, v22.16b, #10
    ext v23.16b, v23.16b, v23.16b, #4
    add x4, x4, #32
.Lv512_dec_4blk256_arm64_p0_init_done:
    aesd v0.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v21.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v22.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v23.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v21.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v22.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v23.16b
    aesimc v7.16b, v7.16b
    cmp x3, #10
    b.eq .Lv512_dec_4blk256_arm64_p0_step4
    cmp x3, #12
    b.eq .Lv512_dec_4blk256_arm64_p0_step5
    cmp x3, #14
    b.eq .Lv512_dec_4blk256_arm64_p0_step6
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
.Lv512_dec_4blk256_arm64_p0_step6:
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
.Lv512_dec_4blk256_arm64_p0_step5:
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
.Lv512_dec_4blk256_arm64_p0_step4:
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0], #64
    st1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x0], #64
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    ext v20.16b, v20.16b, v20.16b, #9
    ext v21.16b, v21.16b, v21.16b, #2
    ext v22.16b, v22.16b, v22.16b, #9
    ext v23.16b, v23.16b, v23.16b, #2
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    add x4, x4, #48
    cmp x3, #10
    b.eq .Lv512_dec_4blk256_arm64_p1_init_done
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    add x4, x4, #16
    cmp x3, #12
    b.eq .Lv512_dec_4blk256_arm64_p1_init_done
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    add x4, x4, #16
    cmp x3, #14
    b.eq .Lv512_dec_4blk256_arm64_p1_init_done
    ext v20.16b, v20.16b, v20.16b, #10
    ext v21.16b, v21.16b, v21.16b, #4
    ext v22.16b, v22.16b, v22.16b, #10
    ext v23.16b, v23.16b, v23.16b, #4
    add x4, x4, #32
.Lv512_dec_4blk256_arm64_p1_init_done:
    aesd v0.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v21.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v22.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v23.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v21.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v22.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v23.16b
    aesimc v7.16b, v7.16b
    cmp x3, #10
    b.eq .Lv512_dec_4blk256_arm64_p1_step4
    cmp x3, #12
    b.eq .Lv512_dec_4blk256_arm64_p1_step5
    cmp x3, #14
    b.eq .Lv512_dec_4blk256_arm64_p1_step6
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
.Lv512_dec_4blk256_arm64_p1_step6:
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
.Lv512_dec_4blk256_arm64_p1_step5:
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
.Lv512_dec_4blk256_arm64_p1_step4:
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0], #64
    st1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x0]
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
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(vistrutah512Decrypt4Blocks256Asm)

AREION_FUNC_START(vistrutah512Encrypt4Blocks512Asm)
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
    mov v20.16b, v17.16b
    mov v21.16b, v16.16b
    mov v22.16b, v19.16b
    mov v23.16b, v18.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v20.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    cmp x3, #10
    b.eq .Lv512_4blk512_arm64_p0_final
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    cmp x3, #12
    b.eq .Lv512_4blk512_arm64_p0_final
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    cmp x3, #14
    b.eq .Lv512_4blk512_arm64_p0_final
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
.Lv512_4blk512_arm64_p0_final:
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aese v1.16b, v17.16b
    aese v2.16b, v18.16b
    aese v3.16b, v19.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aese v5.16b, v17.16b
    aese v6.16b, v18.16b
    aese v7.16b, v19.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0], #64
    st1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x0], #64
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    mov v20.16b, v17.16b
    mov v21.16b, v16.16b
    mov v22.16b, v19.16b
    mov v23.16b, v18.16b
    aese v0.16b, v20.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v20.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    cmp x3, #10
    b.eq .Lv512_4blk512_arm64_p1_final
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    cmp x3, #12
    b.eq .Lv512_4blk512_arm64_p1_final
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    cmp x3, #14
    b.eq .Lv512_4blk512_arm64_p1_final
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v17.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    zip1 v24.16b, v0.16b, v2.16b
    zip2 v25.16b, v0.16b, v2.16b
    zip1 v26.16b, v1.16b, v3.16b
    zip2 v27.16b, v1.16b, v3.16b
    zip1 v0.16b, v24.16b, v26.16b
    zip2 v2.16b, v24.16b, v26.16b
    zip1 v1.16b, v25.16b, v27.16b
    zip2 v3.16b, v25.16b, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v17.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v19.16b
    aesmc v7.16b, v7.16b
    zip1 v24.16b, v4.16b, v6.16b
    zip2 v25.16b, v4.16b, v6.16b
    zip1 v26.16b, v5.16b, v7.16b
    zip2 v27.16b, v5.16b, v7.16b
    zip1 v4.16b, v24.16b, v26.16b
    zip2 v6.16b, v24.16b, v26.16b
    zip1 v5.16b, v25.16b, v27.16b
    zip2 v7.16b, v25.16b, v27.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
.Lv512_4blk512_arm64_p1_final:
    ld1 { v28.16b }, [x4], #16
    eor v28.16b, v28.16b, v20.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v21.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v22.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    aese v0.16b, v16.16b
    aese v1.16b, v17.16b
    aese v2.16b, v18.16b
    aese v3.16b, v19.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v21.16b
    aesmc v5.16b, v5.16b
    aese v6.16b, v22.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v23.16b
    aesmc v7.16b, v7.16b
    aese v4.16b, v16.16b
    aese v5.16b, v17.16b
    aese v6.16b, v18.16b
    aese v7.16b, v19.16b
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0], #64
    st1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x0]
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
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(vistrutah512Encrypt4Blocks512Asm)

AREION_FUNC_START(vistrutah512Decrypt4Blocks512Asm)
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    mov v20.16b, v17.16b
    mov v21.16b, v16.16b
    mov v22.16b, v19.16b
    mov v23.16b, v18.16b
    aesimc v16.16b, v16.16b
    aesimc v17.16b, v17.16b
    aesimc v18.16b, v18.16b
    aesimc v19.16b, v19.16b
    eor v29.16b, v29.16b, v29.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
    ext v20.16b, v20.16b, v20.16b, #9
    ext v21.16b, v21.16b, v21.16b, #2
    ext v22.16b, v22.16b, v22.16b, #9
    ext v23.16b, v23.16b, v23.16b, #2
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    add x4, x4, #48
    cmp x3, #10
    b.eq .Lv512_dec_4blk512_arm64_p0_init_done
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    add x4, x4, #16
    cmp x3, #12
    b.eq .Lv512_dec_4blk512_arm64_p0_init_done
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    add x4, x4, #16
    cmp x3, #14
    b.eq .Lv512_dec_4blk512_arm64_p0_init_done
    ext v20.16b, v20.16b, v20.16b, #10
    ext v21.16b, v21.16b, v21.16b, #4
    ext v22.16b, v22.16b, v22.16b, #10
    ext v23.16b, v23.16b, v23.16b, #4
    add x4, x4, #32
.Lv512_dec_4blk512_arm64_p0_init_done:
    aesd v0.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v21.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v22.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v23.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v21.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v22.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v23.16b
    aesimc v7.16b, v7.16b
    cmp x3, #10
    b.eq .Lv512_dec_4blk512_arm64_p0_step4
    cmp x3, #12
    b.eq .Lv512_dec_4blk512_arm64_p0_step5
    cmp x3, #14
    b.eq .Lv512_dec_4blk512_arm64_p0_step6
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
.Lv512_dec_4blk512_arm64_p0_step6:
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
.Lv512_dec_4blk512_arm64_p0_step5:
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
.Lv512_dec_4blk512_arm64_p0_step4:
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0], #64
    st1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x0], #64
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    ext v20.16b, v20.16b, v20.16b, #9
    ext v21.16b, v21.16b, v21.16b, #2
    ext v22.16b, v22.16b, v22.16b, #9
    ext v23.16b, v23.16b, v23.16b, #2
    AREION_ARM64_ADR(x4, vistrutahRoundConstants)
    add x4, x4, #48
    cmp x3, #10
    b.eq .Lv512_dec_4blk512_arm64_p1_init_done
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    add x4, x4, #16
    cmp x3, #12
    b.eq .Lv512_dec_4blk512_arm64_p1_init_done
    ext v20.16b, v20.16b, v20.16b, #5
    ext v21.16b, v21.16b, v21.16b, #10
    ext v22.16b, v22.16b, v22.16b, #5
    ext v23.16b, v23.16b, v23.16b, #10
    add x4, x4, #16
    cmp x3, #14
    b.eq .Lv512_dec_4blk512_arm64_p1_init_done
    ext v20.16b, v20.16b, v20.16b, #10
    ext v21.16b, v21.16b, v21.16b, #4
    ext v22.16b, v22.16b, v22.16b, #10
    ext v23.16b, v23.16b, v23.16b, #4
    add x4, x4, #32
.Lv512_dec_4blk512_arm64_p1_init_done:
    aesd v0.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v21.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v22.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v23.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v21.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v22.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v23.16b
    aesimc v7.16b, v7.16b
    cmp x3, #10
    b.eq .Lv512_dec_4blk512_arm64_p1_step4
    cmp x3, #12
    b.eq .Lv512_dec_4blk512_arm64_p1_step5
    cmp x3, #14
    b.eq .Lv512_dec_4blk512_arm64_p1_step6
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
.Lv512_dec_4blk512_arm64_p1_step6:
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
.Lv512_dec_4blk512_arm64_p1_step5:
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
.Lv512_dec_4blk512_arm64_p1_step4:
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    ld1 { v28.16b }, [x4]
    sub x4, x4, #16
    eor v28.16b, v28.16b, v20.16b
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    uzp1 v24.16b, v0.16b, v2.16b
    uzp2 v26.16b, v0.16b, v2.16b
    uzp1 v25.16b, v1.16b, v3.16b
    uzp2 v27.16b, v1.16b, v3.16b
    uzp1 v0.16b, v24.16b, v25.16b
    uzp2 v2.16b, v24.16b, v25.16b
    uzp1 v1.16b, v26.16b, v27.16b
    uzp2 v3.16b, v26.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    uzp1 v24.16b, v4.16b, v6.16b
    uzp2 v26.16b, v4.16b, v6.16b
    uzp1 v25.16b, v5.16b, v7.16b
    uzp2 v27.16b, v5.16b, v7.16b
    uzp1 v4.16b, v24.16b, v25.16b
    uzp2 v6.16b, v24.16b, v25.16b
    uzp1 v5.16b, v26.16b, v27.16b
    uzp2 v7.16b, v26.16b, v27.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v29.16b
    aesimc v4.16b, v4.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v29.16b
    aesimc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v29.16b
    aesimc v6.16b, v6.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v29.16b
    aesimc v7.16b, v7.16b
    ext v20.16b, v20.16b, v20.16b, #11
    ext v21.16b, v21.16b, v21.16b, #6
    ext v22.16b, v22.16b, v22.16b, #11
    ext v23.16b, v23.16b, v23.16b, #6
    aesd v0.16b, v16.16b
    aesd v1.16b, v17.16b
    aesd v2.16b, v18.16b
    aesd v3.16b, v19.16b
    aesd v4.16b, v16.16b
    aesd v5.16b, v17.16b
    aesd v6.16b, v18.16b
    aesd v7.16b, v19.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0], #64
    st1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x0]
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
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
AREION_FUNC_END(vistrutah512Decrypt4Blocks512Asm)

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
