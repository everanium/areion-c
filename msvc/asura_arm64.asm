; Copyright (c) 2026 Andrey Kuvshinov
; SPDX-License-Identifier: Apache-2.0 OR MIT

    AREA |.text|, CODE, READONLY, ALIGN=4
    IMPORT asuraRoundConstants
    IMPORT areion_asura_rc
    IMPORT asuraConsts
    IMPORT asuraGFConsts

    EXPORT areion_asura_expand_tweakey_asm
areion_asura_expand_tweakey_asm PROC
    hint #34 ; bti c
    ld1 {v0.16b, v1.16b}, [x1]
    ld1 {v2.16b}, [x2]
    eor v3.16b, v3.16b, v3.16b
    adrp x9, asuraConsts
    add x9, x9, asuraConsts
    add x9, x9, #128
    ld1 {v4.16b, v5.16b}, [x9]
    adrp x10, asuraGFConsts
    add x10, x10, asuraGFConsts
    ld1 {v6.16b}, [x10]
    adrp x9, asuraRoundConstants
    add x9, x9, asuraRoundConstants
    ld1 {v7.16b}, [x9], #16
    eor v16.16b, v0.16b, v2.16b
    eor v16.16b, v16.16b, v7.16b
    eor v17.16b, v1.16b, v2.16b
    st1 {v16.16b, v17.16b}, [x0], #32
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v16.16b, {v0.16b, v1.16b}, v4.16b
    tbl v17.16b, {v0.16b, v1.16b}, v5.16b
    sshr v18.16b, v16.16b, #7
    sshr v19.16b, v17.16b, #7
    and v18.16b, v18.16b, v6.16b
    and v19.16b, v19.16b, v6.16b
    shl v0.16b, v16.16b, #1
    shl v1.16b, v17.16b, #1
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    ld1 {v7.16b}, [x9], #16
    eor v16.16b, v0.16b, v2.16b
    eor v16.16b, v16.16b, v7.16b
    eor v17.16b, v1.16b, v2.16b
    st1 {v16.16b, v17.16b}, [x0], #32
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v16.16b, {v0.16b, v1.16b}, v4.16b
    tbl v17.16b, {v0.16b, v1.16b}, v5.16b
    sshr v18.16b, v16.16b, #7
    sshr v19.16b, v17.16b, #7
    and v18.16b, v18.16b, v6.16b
    and v19.16b, v19.16b, v6.16b
    shl v0.16b, v16.16b, #1
    shl v1.16b, v17.16b, #1
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    ld1 {v7.16b}, [x9], #16
    eor v16.16b, v0.16b, v2.16b
    eor v16.16b, v16.16b, v7.16b
    eor v17.16b, v1.16b, v2.16b
    st1 {v16.16b, v17.16b}, [x0], #32
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v16.16b, {v0.16b, v1.16b}, v4.16b
    tbl v17.16b, {v0.16b, v1.16b}, v5.16b
    sshr v18.16b, v16.16b, #7
    sshr v19.16b, v17.16b, #7
    and v18.16b, v18.16b, v6.16b
    and v19.16b, v19.16b, v6.16b
    shl v0.16b, v16.16b, #1
    shl v1.16b, v17.16b, #1
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    ld1 {v7.16b}, [x9], #16
    eor v16.16b, v0.16b, v2.16b
    eor v16.16b, v16.16b, v7.16b
    eor v17.16b, v1.16b, v2.16b
    st1 {v16.16b, v17.16b}, [x0], #32
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v16.16b, {v0.16b, v1.16b}, v4.16b
    tbl v17.16b, {v0.16b, v1.16b}, v5.16b
    sshr v18.16b, v16.16b, #7
    sshr v19.16b, v17.16b, #7
    and v18.16b, v18.16b, v6.16b
    and v19.16b, v19.16b, v6.16b
    shl v0.16b, v16.16b, #1
    shl v1.16b, v17.16b, #1
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    ld1 {v7.16b}, [x9], #16
    eor v16.16b, v0.16b, v2.16b
    eor v16.16b, v16.16b, v7.16b
    eor v17.16b, v1.16b, v2.16b
    st1 {v16.16b, v17.16b}, [x0], #32
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v16.16b, {v0.16b, v1.16b}, v4.16b
    tbl v17.16b, {v0.16b, v1.16b}, v5.16b
    sshr v18.16b, v16.16b, #7
    sshr v19.16b, v17.16b, #7
    and v18.16b, v18.16b, v6.16b
    and v19.16b, v19.16b, v6.16b
    shl v0.16b, v16.16b, #1
    shl v1.16b, v17.16b, #1
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    ld1 {v7.16b}, [x9], #16
    eor v16.16b, v0.16b, v2.16b
    eor v16.16b, v16.16b, v7.16b
    eor v17.16b, v1.16b, v2.16b
    st1 {v16.16b, v17.16b}, [x0], #32
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v16.16b, {v0.16b, v1.16b}, v4.16b
    tbl v17.16b, {v0.16b, v1.16b}, v5.16b
    sshr v18.16b, v16.16b, #7
    sshr v19.16b, v17.16b, #7
    and v18.16b, v18.16b, v6.16b
    and v19.16b, v19.16b, v6.16b
    shl v0.16b, v16.16b, #1
    shl v1.16b, v17.16b, #1
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    ld1 {v7.16b}, [x9], #16
    eor v16.16b, v0.16b, v2.16b
    eor v16.16b, v16.16b, v7.16b
    eor v17.16b, v1.16b, v2.16b
    st1 {v16.16b, v17.16b}, [x0], #32
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v16.16b, {v0.16b, v1.16b}, v4.16b
    tbl v17.16b, {v0.16b, v1.16b}, v5.16b
    sshr v18.16b, v16.16b, #7
    sshr v19.16b, v17.16b, #7
    and v18.16b, v18.16b, v6.16b
    and v19.16b, v19.16b, v6.16b
    shl v0.16b, v16.16b, #1
    shl v1.16b, v17.16b, #1
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    ld1 {v7.16b}, [x9], #16
    eor v16.16b, v0.16b, v2.16b
    eor v16.16b, v16.16b, v7.16b
    eor v17.16b, v1.16b, v2.16b
    st1 {v16.16b, v17.16b}, [x0], #32
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v16.16b, {v0.16b, v1.16b}, v4.16b
    tbl v17.16b, {v0.16b, v1.16b}, v5.16b
    sshr v18.16b, v16.16b, #7
    sshr v19.16b, v17.16b, #7
    and v18.16b, v18.16b, v6.16b
    and v19.16b, v19.16b, v6.16b
    shl v0.16b, v16.16b, #1
    shl v1.16b, v17.16b, #1
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    ld1 {v7.16b}, [x9], #16
    eor v16.16b, v0.16b, v2.16b
    eor v16.16b, v16.16b, v7.16b
    eor v17.16b, v1.16b, v2.16b
    st1 {v16.16b, v17.16b}, [x0], #32
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v16.16b, {v0.16b, v1.16b}, v4.16b
    tbl v17.16b, {v0.16b, v1.16b}, v5.16b
    sshr v18.16b, v16.16b, #7
    sshr v19.16b, v17.16b, #7
    and v18.16b, v18.16b, v6.16b
    and v19.16b, v19.16b, v6.16b
    shl v0.16b, v16.16b, #1
    shl v1.16b, v17.16b, #1
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    ld1 {v7.16b}, [x9], #16
    eor v16.16b, v0.16b, v2.16b
    eor v16.16b, v16.16b, v7.16b
    eor v17.16b, v1.16b, v2.16b
    st1 {v16.16b, v17.16b}, [x0], #32
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v16.16b, {v0.16b, v1.16b}, v4.16b
    tbl v17.16b, {v0.16b, v1.16b}, v5.16b
    sshr v18.16b, v16.16b, #7
    sshr v19.16b, v17.16b, #7
    and v18.16b, v18.16b, v6.16b
    and v19.16b, v19.16b, v6.16b
    shl v0.16b, v16.16b, #1
    shl v1.16b, v17.16b, #1
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    ld1 {v7.16b}, [x9], #16
    eor v16.16b, v0.16b, v2.16b
    eor v16.16b, v16.16b, v7.16b
    eor v17.16b, v1.16b, v2.16b
    st1 {v16.16b, v17.16b}, [x0], #32
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v16.16b, {v0.16b, v1.16b}, v4.16b
    tbl v17.16b, {v0.16b, v1.16b}, v5.16b
    sshr v18.16b, v16.16b, #7
    sshr v19.16b, v17.16b, #7
    and v18.16b, v18.16b, v6.16b
    and v19.16b, v19.16b, v6.16b
    shl v0.16b, v16.16b, #1
    shl v1.16b, v17.16b, #1
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    ld1 {v7.16b}, [x9], #16
    eor v16.16b, v0.16b, v2.16b
    eor v16.16b, v16.16b, v7.16b
    eor v17.16b, v1.16b, v2.16b
    st1 {v16.16b, v17.16b}, [x0], #32
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v16.16b, {v0.16b, v1.16b}, v4.16b
    tbl v17.16b, {v0.16b, v1.16b}, v5.16b
    sshr v18.16b, v16.16b, #7
    sshr v19.16b, v17.16b, #7
    and v18.16b, v18.16b, v6.16b
    and v19.16b, v19.16b, v6.16b
    shl v0.16b, v16.16b, #1
    shl v1.16b, v17.16b, #1
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    ld1 {v7.16b}, [x9]
    eor v16.16b, v0.16b, v2.16b
    eor v16.16b, v16.16b, v7.16b
    eor v17.16b, v1.16b, v2.16b
    st1 {v16.16b, v17.16b}, [x0]
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
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x9, xzr
    mov x10, xzr
    ret
    ENDP

    EXPORT areion_asura_encrypt_block_asm
areion_asura_encrypt_block_asm PROC
    hint #34 ; bti c
    ld1 {v0.16b, v1.16b}, [x1]
    ld1 {v2.16b, v3.16b, v4.16b, v5.16b}, [x2], #64
    aesd v0.16b, v2.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v3.16b
    aesimc v1.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v5.16b
    aesimc v1.16b, v1.16b
    uzp1 v6.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v6.16b
    ld1 {v2.16b, v3.16b, v4.16b, v5.16b}, [x2], #64
    aesd v0.16b, v2.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v3.16b
    aesimc v1.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v5.16b
    aesimc v1.16b, v1.16b
    uzp1 v6.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v6.16b
    ld1 {v2.16b, v3.16b, v4.16b, v5.16b}, [x2], #64
    aesd v0.16b, v2.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v3.16b
    aesimc v1.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v5.16b
    aesimc v1.16b, v1.16b
    uzp1 v6.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v6.16b
    ld1 {v2.16b, v3.16b, v4.16b, v5.16b}, [x2], #64
    aesd v0.16b, v2.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v3.16b
    aesimc v1.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v5.16b
    aesimc v1.16b, v1.16b
    uzp1 v6.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v6.16b
    ld1 {v2.16b, v3.16b, v4.16b, v5.16b}, [x2], #64
    aesd v0.16b, v2.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v3.16b
    aesimc v1.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v5.16b
    aesimc v1.16b, v1.16b
    uzp1 v6.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v6.16b
    ld1 {v2.16b, v3.16b, v4.16b, v5.16b}, [x2], #64
    aesd v0.16b, v2.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v3.16b
    aesimc v1.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v5.16b
    aesimc v1.16b, v1.16b
    ld1 {v2.16b, v3.16b}, [x2]
    eor v0.16b, v0.16b, v2.16b
    eor v1.16b, v1.16b, v3.16b
    st1 {v0.16b, v1.16b}, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    ret
    ENDP

    EXPORT areion_asura_decrypt_block_asm
areion_asura_decrypt_block_asm PROC
    hint #34 ; bti c
    ld1 {v0.16b, v1.16b}, [x1]
    eor v2.16b, v2.16b, v2.16b
    add x2, x2, #384
    ld1 {v3.16b, v4.16b}, [x2]
    eor v0.16b, v0.16b, v3.16b
    eor v1.16b, v1.16b, v4.16b
    sub x2, x2, #64
    ld1 {v3.16b, v4.16b, v5.16b, v6.16b}, [x2]
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v2.16b
    aese v1.16b, v2.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v5.16b
    aese v1.16b, v6.16b
    eor v0.16b, v0.16b, v3.16b
    eor v1.16b, v1.16b, v4.16b
    sub x2, x2, #64
    ld1 {v3.16b, v4.16b, v5.16b, v6.16b}, [x2]
    zip1 v7.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v7.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v2.16b
    aese v1.16b, v2.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v5.16b
    aese v1.16b, v6.16b
    eor v0.16b, v0.16b, v3.16b
    eor v1.16b, v1.16b, v4.16b
    sub x2, x2, #64
    ld1 {v3.16b, v4.16b, v5.16b, v6.16b}, [x2]
    zip1 v7.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v7.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v2.16b
    aese v1.16b, v2.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v5.16b
    aese v1.16b, v6.16b
    eor v0.16b, v0.16b, v3.16b
    eor v1.16b, v1.16b, v4.16b
    sub x2, x2, #64
    ld1 {v3.16b, v4.16b, v5.16b, v6.16b}, [x2]
    zip1 v7.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v7.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v2.16b
    aese v1.16b, v2.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v5.16b
    aese v1.16b, v6.16b
    eor v0.16b, v0.16b, v3.16b
    eor v1.16b, v1.16b, v4.16b
    sub x2, x2, #64
    ld1 {v3.16b, v4.16b, v5.16b, v6.16b}, [x2]
    zip1 v7.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v7.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v2.16b
    aese v1.16b, v2.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v5.16b
    aese v1.16b, v6.16b
    eor v0.16b, v0.16b, v3.16b
    eor v1.16b, v1.16b, v4.16b
    sub x2, x2, #64
    ld1 {v3.16b, v4.16b, v5.16b, v6.16b}, [x2]
    zip1 v7.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v7.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v2.16b
    aese v1.16b, v2.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v5.16b
    aese v1.16b, v6.16b
    eor v0.16b, v0.16b, v3.16b
    eor v1.16b, v1.16b, v4.16b
    st1 {v0.16b, v1.16b}, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
    eor v6.16b, v6.16b, v6.16b
    eor v7.16b, v7.16b, v7.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    ret
    ENDP

    EXPORT areion_asura_encrypt_block_otf_asm
areion_asura_encrypt_block_otf_asm PROC
    hint #34 ; bti c
    ld1 {v0.16b, v1.16b}, [x1]
    ld1 {v2.16b, v3.16b}, [x2]
    ld1 {v4.16b}, [x3]
    eor v5.16b, v5.16b, v5.16b
    adrp x9, asuraConsts
    add x9, x9, asuraConsts
    add x9, x9, #128
    ld1 {v16.16b, v17.16b}, [x9]
    adrp x10, asuraGFConsts
    add x10, x10, asuraGFConsts
    ld1 {v7.16b}, [x10]
    adrp x9, asuraRoundConstants
    add x9, x9, asuraRoundConstants
    ld1 {v18.16b}, [x9], #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    aesd v0.16b, v19.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v20.16b
    aesimc v1.16b, v1.16b
    aese v4.16b, v5.16b
    aesmc v4.16b, v4.16b
    tbl v21.16b, {v2.16b, v3.16b}, v16.16b
    tbl v22.16b, {v2.16b, v3.16b}, v17.16b
    sshr v23.16b, v21.16b, #7
    sshr v24.16b, v22.16b, #7
    and v23.16b, v23.16b, v7.16b
    and v24.16b, v24.16b, v7.16b
    shl v2.16b, v21.16b, #1
    shl v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9], #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    aese v0.16b, v19.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v20.16b
    aesimc v1.16b, v1.16b
    uzp1 v21.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v21.16b
    aese v4.16b, v5.16b
    aesmc v4.16b, v4.16b
    tbl v21.16b, {v2.16b, v3.16b}, v16.16b
    tbl v22.16b, {v2.16b, v3.16b}, v17.16b
    sshr v23.16b, v21.16b, #7
    sshr v24.16b, v22.16b, #7
    and v23.16b, v23.16b, v7.16b
    and v24.16b, v24.16b, v7.16b
    shl v2.16b, v21.16b, #1
    shl v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9], #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    aesd v0.16b, v19.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v20.16b
    aesimc v1.16b, v1.16b
    aese v4.16b, v5.16b
    aesmc v4.16b, v4.16b
    tbl v21.16b, {v2.16b, v3.16b}, v16.16b
    tbl v22.16b, {v2.16b, v3.16b}, v17.16b
    sshr v23.16b, v21.16b, #7
    sshr v24.16b, v22.16b, #7
    and v23.16b, v23.16b, v7.16b
    and v24.16b, v24.16b, v7.16b
    shl v2.16b, v21.16b, #1
    shl v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9], #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    aese v0.16b, v19.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v20.16b
    aesimc v1.16b, v1.16b
    uzp1 v21.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v21.16b
    aese v4.16b, v5.16b
    aesmc v4.16b, v4.16b
    tbl v21.16b, {v2.16b, v3.16b}, v16.16b
    tbl v22.16b, {v2.16b, v3.16b}, v17.16b
    sshr v23.16b, v21.16b, #7
    sshr v24.16b, v22.16b, #7
    and v23.16b, v23.16b, v7.16b
    and v24.16b, v24.16b, v7.16b
    shl v2.16b, v21.16b, #1
    shl v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9], #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    aesd v0.16b, v19.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v20.16b
    aesimc v1.16b, v1.16b
    aese v4.16b, v5.16b
    aesmc v4.16b, v4.16b
    tbl v21.16b, {v2.16b, v3.16b}, v16.16b
    tbl v22.16b, {v2.16b, v3.16b}, v17.16b
    sshr v23.16b, v21.16b, #7
    sshr v24.16b, v22.16b, #7
    and v23.16b, v23.16b, v7.16b
    and v24.16b, v24.16b, v7.16b
    shl v2.16b, v21.16b, #1
    shl v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9], #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    aese v0.16b, v19.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v20.16b
    aesimc v1.16b, v1.16b
    uzp1 v21.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v21.16b
    aese v4.16b, v5.16b
    aesmc v4.16b, v4.16b
    tbl v21.16b, {v2.16b, v3.16b}, v16.16b
    tbl v22.16b, {v2.16b, v3.16b}, v17.16b
    sshr v23.16b, v21.16b, #7
    sshr v24.16b, v22.16b, #7
    and v23.16b, v23.16b, v7.16b
    and v24.16b, v24.16b, v7.16b
    shl v2.16b, v21.16b, #1
    shl v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9], #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    aesd v0.16b, v19.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v20.16b
    aesimc v1.16b, v1.16b
    aese v4.16b, v5.16b
    aesmc v4.16b, v4.16b
    tbl v21.16b, {v2.16b, v3.16b}, v16.16b
    tbl v22.16b, {v2.16b, v3.16b}, v17.16b
    sshr v23.16b, v21.16b, #7
    sshr v24.16b, v22.16b, #7
    and v23.16b, v23.16b, v7.16b
    and v24.16b, v24.16b, v7.16b
    shl v2.16b, v21.16b, #1
    shl v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9], #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    aese v0.16b, v19.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v20.16b
    aesimc v1.16b, v1.16b
    uzp1 v21.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v21.16b
    aese v4.16b, v5.16b
    aesmc v4.16b, v4.16b
    tbl v21.16b, {v2.16b, v3.16b}, v16.16b
    tbl v22.16b, {v2.16b, v3.16b}, v17.16b
    sshr v23.16b, v21.16b, #7
    sshr v24.16b, v22.16b, #7
    and v23.16b, v23.16b, v7.16b
    and v24.16b, v24.16b, v7.16b
    shl v2.16b, v21.16b, #1
    shl v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9], #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    aesd v0.16b, v19.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v20.16b
    aesimc v1.16b, v1.16b
    aese v4.16b, v5.16b
    aesmc v4.16b, v4.16b
    tbl v21.16b, {v2.16b, v3.16b}, v16.16b
    tbl v22.16b, {v2.16b, v3.16b}, v17.16b
    sshr v23.16b, v21.16b, #7
    sshr v24.16b, v22.16b, #7
    and v23.16b, v23.16b, v7.16b
    and v24.16b, v24.16b, v7.16b
    shl v2.16b, v21.16b, #1
    shl v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9], #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    aese v0.16b, v19.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v20.16b
    aesimc v1.16b, v1.16b
    uzp1 v21.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v21.16b
    aese v4.16b, v5.16b
    aesmc v4.16b, v4.16b
    tbl v21.16b, {v2.16b, v3.16b}, v16.16b
    tbl v22.16b, {v2.16b, v3.16b}, v17.16b
    sshr v23.16b, v21.16b, #7
    sshr v24.16b, v22.16b, #7
    and v23.16b, v23.16b, v7.16b
    and v24.16b, v24.16b, v7.16b
    shl v2.16b, v21.16b, #1
    shl v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9], #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    aesd v0.16b, v19.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v20.16b
    aesimc v1.16b, v1.16b
    aese v4.16b, v5.16b
    aesmc v4.16b, v4.16b
    tbl v21.16b, {v2.16b, v3.16b}, v16.16b
    tbl v22.16b, {v2.16b, v3.16b}, v17.16b
    sshr v23.16b, v21.16b, #7
    sshr v24.16b, v22.16b, #7
    and v23.16b, v23.16b, v7.16b
    and v24.16b, v24.16b, v7.16b
    shl v2.16b, v21.16b, #1
    shl v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9], #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    aese v0.16b, v19.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v20.16b
    aesimc v1.16b, v1.16b
    aese v4.16b, v5.16b
    aesmc v4.16b, v4.16b
    tbl v21.16b, {v2.16b, v3.16b}, v16.16b
    tbl v22.16b, {v2.16b, v3.16b}, v17.16b
    sshr v23.16b, v21.16b, #7
    sshr v24.16b, v22.16b, #7
    and v23.16b, v23.16b, v7.16b
    and v24.16b, v24.16b, v7.16b
    shl v2.16b, v21.16b, #1
    shl v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9]
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    eor v0.16b, v0.16b, v19.16b
    eor v1.16b, v1.16b, v20.16b
    st1 {v0.16b, v1.16b}, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
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
    mov x9, xzr
    mov x10, xzr
    ret
    ENDP

    EXPORT areion_asura_decrypt_block_otf_asm
areion_asura_decrypt_block_otf_asm PROC
    hint #34 ; bti c
    ld1 {v0.16b, v1.16b}, [x1]
    ld1 {v2.16b, v3.16b}, [x2]
    ld1 {v4.16b}, [x3]
    eor v5.16b, v5.16b, v5.16b
    adrp x9, asuraConsts
    add x9, x9, asuraConsts
    add x9, x9, #128
    ld1 {v16.16b, v17.16b}, [x9], #32
    ld1 {v26.16b, v27.16b}, [x9]
    adrp x10, asuraGFConsts
    add x10, x10, asuraGFConsts
    ld1 {v7.16b}, [x10]
    add x10, x10, #32
    ld1 {v28.16b}, [x10]
    mov x10, #12
asura_dec_otf_fwd_loop:
    aese v4.16b, v5.16b
    aesmc v4.16b, v4.16b
    tbl v21.16b, {v2.16b, v3.16b}, v16.16b
    tbl v22.16b, {v2.16b, v3.16b}, v17.16b
    sshr v23.16b, v21.16b, #7
    sshr v24.16b, v22.16b, #7
    and v23.16b, v23.16b, v7.16b
    and v24.16b, v24.16b, v7.16b
    shl v2.16b, v21.16b, #1
    shl v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    subs x10, x10, #1
    b.ne asura_dec_otf_fwd_loop
    adrp x9, asuraRoundConstants
    add x9, x9, asuraRoundConstants
    add x9, x9, #192
    ld1 {v18.16b}, [x9]
    sub x9, x9, #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    eor v0.16b, v0.16b, v19.16b
    eor v1.16b, v1.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v5.16b
    tbl v21.16b, {v2.16b, v3.16b}, v26.16b
    tbl v22.16b, {v2.16b, v3.16b}, v27.16b
    shl v23.16b, v21.16b, #7
    shl v24.16b, v22.16b, #7
    sshr v23.16b, v23.16b, #7
    sshr v24.16b, v24.16b, #7
    and v23.16b, v23.16b, v28.16b
    and v24.16b, v24.16b, v28.16b
    ushr v2.16b, v21.16b, #1
    ushr v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9]
    sub x9, x9, #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    aesmc v19.16b, v19.16b
    aesmc v20.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v5.16b
    aese v1.16b, v5.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v19.16b
    aese v1.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v5.16b
    tbl v21.16b, {v2.16b, v3.16b}, v26.16b
    tbl v22.16b, {v2.16b, v3.16b}, v27.16b
    shl v23.16b, v21.16b, #7
    shl v24.16b, v22.16b, #7
    sshr v23.16b, v23.16b, #7
    sshr v24.16b, v24.16b, #7
    and v23.16b, v23.16b, v28.16b
    and v24.16b, v24.16b, v28.16b
    ushr v2.16b, v21.16b, #1
    ushr v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9]
    sub x9, x9, #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    eor v0.16b, v0.16b, v19.16b
    eor v1.16b, v1.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v5.16b
    tbl v21.16b, {v2.16b, v3.16b}, v26.16b
    tbl v22.16b, {v2.16b, v3.16b}, v27.16b
    shl v23.16b, v21.16b, #7
    shl v24.16b, v22.16b, #7
    sshr v23.16b, v23.16b, #7
    sshr v24.16b, v24.16b, #7
    and v23.16b, v23.16b, v28.16b
    and v24.16b, v24.16b, v28.16b
    ushr v2.16b, v21.16b, #1
    ushr v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9]
    sub x9, x9, #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    zip1 v21.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v21.16b
    aesmc v19.16b, v19.16b
    aesmc v20.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v5.16b
    aese v1.16b, v5.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v19.16b
    aese v1.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v5.16b
    tbl v21.16b, {v2.16b, v3.16b}, v26.16b
    tbl v22.16b, {v2.16b, v3.16b}, v27.16b
    shl v23.16b, v21.16b, #7
    shl v24.16b, v22.16b, #7
    sshr v23.16b, v23.16b, #7
    sshr v24.16b, v24.16b, #7
    and v23.16b, v23.16b, v28.16b
    and v24.16b, v24.16b, v28.16b
    ushr v2.16b, v21.16b, #1
    ushr v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9]
    sub x9, x9, #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    eor v0.16b, v0.16b, v19.16b
    eor v1.16b, v1.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v5.16b
    tbl v21.16b, {v2.16b, v3.16b}, v26.16b
    tbl v22.16b, {v2.16b, v3.16b}, v27.16b
    shl v23.16b, v21.16b, #7
    shl v24.16b, v22.16b, #7
    sshr v23.16b, v23.16b, #7
    sshr v24.16b, v24.16b, #7
    and v23.16b, v23.16b, v28.16b
    and v24.16b, v24.16b, v28.16b
    ushr v2.16b, v21.16b, #1
    ushr v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9]
    sub x9, x9, #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    zip1 v21.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v21.16b
    aesmc v19.16b, v19.16b
    aesmc v20.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v5.16b
    aese v1.16b, v5.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v19.16b
    aese v1.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v5.16b
    tbl v21.16b, {v2.16b, v3.16b}, v26.16b
    tbl v22.16b, {v2.16b, v3.16b}, v27.16b
    shl v23.16b, v21.16b, #7
    shl v24.16b, v22.16b, #7
    sshr v23.16b, v23.16b, #7
    sshr v24.16b, v24.16b, #7
    and v23.16b, v23.16b, v28.16b
    and v24.16b, v24.16b, v28.16b
    ushr v2.16b, v21.16b, #1
    ushr v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9]
    sub x9, x9, #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    eor v0.16b, v0.16b, v19.16b
    eor v1.16b, v1.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v5.16b
    tbl v21.16b, {v2.16b, v3.16b}, v26.16b
    tbl v22.16b, {v2.16b, v3.16b}, v27.16b
    shl v23.16b, v21.16b, #7
    shl v24.16b, v22.16b, #7
    sshr v23.16b, v23.16b, #7
    sshr v24.16b, v24.16b, #7
    and v23.16b, v23.16b, v28.16b
    and v24.16b, v24.16b, v28.16b
    ushr v2.16b, v21.16b, #1
    ushr v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9]
    sub x9, x9, #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    zip1 v21.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v21.16b
    aesmc v19.16b, v19.16b
    aesmc v20.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v5.16b
    aese v1.16b, v5.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v19.16b
    aese v1.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v5.16b
    tbl v21.16b, {v2.16b, v3.16b}, v26.16b
    tbl v22.16b, {v2.16b, v3.16b}, v27.16b
    shl v23.16b, v21.16b, #7
    shl v24.16b, v22.16b, #7
    sshr v23.16b, v23.16b, #7
    sshr v24.16b, v24.16b, #7
    and v23.16b, v23.16b, v28.16b
    and v24.16b, v24.16b, v28.16b
    ushr v2.16b, v21.16b, #1
    ushr v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9]
    sub x9, x9, #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    eor v0.16b, v0.16b, v19.16b
    eor v1.16b, v1.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v5.16b
    tbl v21.16b, {v2.16b, v3.16b}, v26.16b
    tbl v22.16b, {v2.16b, v3.16b}, v27.16b
    shl v23.16b, v21.16b, #7
    shl v24.16b, v22.16b, #7
    sshr v23.16b, v23.16b, #7
    sshr v24.16b, v24.16b, #7
    and v23.16b, v23.16b, v28.16b
    and v24.16b, v24.16b, v28.16b
    ushr v2.16b, v21.16b, #1
    ushr v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9]
    sub x9, x9, #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    zip1 v21.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v21.16b
    aesmc v19.16b, v19.16b
    aesmc v20.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v5.16b
    aese v1.16b, v5.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v19.16b
    aese v1.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v5.16b
    tbl v21.16b, {v2.16b, v3.16b}, v26.16b
    tbl v22.16b, {v2.16b, v3.16b}, v27.16b
    shl v23.16b, v21.16b, #7
    shl v24.16b, v22.16b, #7
    sshr v23.16b, v23.16b, #7
    sshr v24.16b, v24.16b, #7
    and v23.16b, v23.16b, v28.16b
    and v24.16b, v24.16b, v28.16b
    ushr v2.16b, v21.16b, #1
    ushr v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9]
    sub x9, x9, #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    eor v0.16b, v0.16b, v19.16b
    eor v1.16b, v1.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v5.16b
    tbl v21.16b, {v2.16b, v3.16b}, v26.16b
    tbl v22.16b, {v2.16b, v3.16b}, v27.16b
    shl v23.16b, v21.16b, #7
    shl v24.16b, v22.16b, #7
    sshr v23.16b, v23.16b, #7
    sshr v24.16b, v24.16b, #7
    and v23.16b, v23.16b, v28.16b
    and v24.16b, v24.16b, v28.16b
    ushr v2.16b, v21.16b, #1
    ushr v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9]
    sub x9, x9, #16
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    zip1 v21.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v21.16b
    aesmc v19.16b, v19.16b
    aesmc v20.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v5.16b
    aese v1.16b, v5.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v19.16b
    aese v1.16b, v20.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v5.16b
    tbl v21.16b, {v2.16b, v3.16b}, v26.16b
    tbl v22.16b, {v2.16b, v3.16b}, v27.16b
    shl v23.16b, v21.16b, #7
    shl v24.16b, v22.16b, #7
    sshr v23.16b, v23.16b, #7
    sshr v24.16b, v24.16b, #7
    and v23.16b, v23.16b, v28.16b
    and v24.16b, v24.16b, v28.16b
    ushr v2.16b, v21.16b, #1
    ushr v3.16b, v22.16b, #1
    eor v2.16b, v2.16b, v23.16b
    eor v3.16b, v3.16b, v24.16b
    ld1 {v18.16b}, [x9]
    eor v19.16b, v2.16b, v4.16b
    eor v19.16b, v19.16b, v18.16b
    eor v20.16b, v3.16b, v4.16b
    eor v0.16b, v0.16b, v19.16b
    eor v1.16b, v1.16b, v20.16b
    st1 {v0.16b, v1.16b}, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    eor v5.16b, v5.16b, v5.16b
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
    eor v26.16b, v26.16b, v26.16b
    eor v27.16b, v27.16b, v27.16b
    eor v28.16b, v28.16b, v28.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x9, xzr
    mov x10, xzr
    ret
    ENDP

    EXPORT areion_asura_encrypt_4blocks_asm
areion_asura_encrypt_4blocks_asm PROC
    hint #34 ; bti c
    ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x1], #64
    ld1 {v4.16b, v5.16b, v6.16b, v7.16b}, [x1]
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2], #64
    aesd v0.16b, v16.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v17.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v16.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v17.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v17.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v16.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v17.16b
    aesimc v7.16b, v7.16b
    aese v0.16b, v18.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v19.16b
    aesimc v1.16b, v1.16b
    uzp1 v20.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v20.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v19.16b
    aesimc v3.16b, v3.16b
    uzp1 v20.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v20.16b
    aese v4.16b, v18.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v19.16b
    aesimc v5.16b, v5.16b
    uzp1 v20.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v20.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v19.16b
    aesimc v7.16b, v7.16b
    uzp1 v20.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v20.16b
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2], #64
    aesd v0.16b, v16.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v17.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v16.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v17.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v17.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v16.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v17.16b
    aesimc v7.16b, v7.16b
    aese v0.16b, v18.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v19.16b
    aesimc v1.16b, v1.16b
    uzp1 v20.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v20.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v19.16b
    aesimc v3.16b, v3.16b
    uzp1 v20.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v20.16b
    aese v4.16b, v18.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v19.16b
    aesimc v5.16b, v5.16b
    uzp1 v20.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v20.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v19.16b
    aesimc v7.16b, v7.16b
    uzp1 v20.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v20.16b
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2], #64
    aesd v0.16b, v16.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v17.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v16.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v17.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v17.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v16.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v17.16b
    aesimc v7.16b, v7.16b
    aese v0.16b, v18.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v19.16b
    aesimc v1.16b, v1.16b
    uzp1 v20.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v20.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v19.16b
    aesimc v3.16b, v3.16b
    uzp1 v20.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v20.16b
    aese v4.16b, v18.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v19.16b
    aesimc v5.16b, v5.16b
    uzp1 v20.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v20.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v19.16b
    aesimc v7.16b, v7.16b
    uzp1 v20.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v20.16b
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2], #64
    aesd v0.16b, v16.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v17.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v16.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v17.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v17.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v16.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v17.16b
    aesimc v7.16b, v7.16b
    aese v0.16b, v18.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v19.16b
    aesimc v1.16b, v1.16b
    uzp1 v20.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v20.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v19.16b
    aesimc v3.16b, v3.16b
    uzp1 v20.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v20.16b
    aese v4.16b, v18.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v19.16b
    aesimc v5.16b, v5.16b
    uzp1 v20.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v20.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v19.16b
    aesimc v7.16b, v7.16b
    uzp1 v20.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v20.16b
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2], #64
    aesd v0.16b, v16.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v17.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v16.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v17.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v17.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v16.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v17.16b
    aesimc v7.16b, v7.16b
    aese v0.16b, v18.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v19.16b
    aesimc v1.16b, v1.16b
    uzp1 v20.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v20.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v19.16b
    aesimc v3.16b, v3.16b
    uzp1 v20.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v20.16b
    aese v4.16b, v18.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v19.16b
    aesimc v5.16b, v5.16b
    uzp1 v20.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v20.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v19.16b
    aesimc v7.16b, v7.16b
    uzp1 v20.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v20.16b
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2], #64
    aesd v0.16b, v16.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v17.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v16.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v17.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v16.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v17.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v16.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v17.16b
    aesimc v7.16b, v7.16b
    aese v0.16b, v18.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v19.16b
    aesimc v1.16b, v1.16b
    aese v2.16b, v18.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v19.16b
    aesimc v3.16b, v3.16b
    aese v4.16b, v18.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v19.16b
    aesimc v5.16b, v5.16b
    aese v6.16b, v18.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v19.16b
    aesimc v7.16b, v7.16b
    ld1 {v16.16b, v17.16b}, [x2]
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v4.16b, v4.16b, v16.16b
    eor v5.16b, v5.16b, v17.16b
    eor v6.16b, v6.16b, v16.16b
    eor v7.16b, v7.16b, v17.16b
    st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x0], #64
    st1 {v4.16b, v5.16b, v6.16b, v7.16b}, [x0]
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
    ret
    ENDP

    EXPORT areion_asura_decrypt_4blocks_asm
areion_asura_decrypt_4blocks_asm PROC
    hint #34 ; bti c
    ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x1], #64
    ld1 {v4.16b, v5.16b, v6.16b, v7.16b}, [x1]
    eor v16.16b, v16.16b, v16.16b
    add x2, x2, #384
    ld1 {v17.16b, v18.16b}, [x2]
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v17.16b
    eor v3.16b, v3.16b, v18.16b
    eor v4.16b, v4.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v6.16b, v6.16b, v17.16b
    eor v7.16b, v7.16b, v18.16b
    sub x2, x2, #64
    ld1 {v17.16b, v18.16b, v19.16b, v20.16b}, [x2]
    aesmc v19.16b, v19.16b
    aesmc v20.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v0.16b, v16.16b
    aese v1.16b, v16.16b
    aesd v2.16b, v16.16b
    aese v3.16b, v16.16b
    aesd v4.16b, v16.16b
    aese v5.16b, v16.16b
    aesd v6.16b, v16.16b
    aese v7.16b, v16.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v0.16b, v19.16b
    aese v1.16b, v20.16b
    aese v2.16b, v19.16b
    aese v3.16b, v20.16b
    aese v4.16b, v19.16b
    aese v5.16b, v20.16b
    aese v6.16b, v19.16b
    aese v7.16b, v20.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v17.16b
    eor v3.16b, v3.16b, v18.16b
    eor v4.16b, v4.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v6.16b, v6.16b, v17.16b
    eor v7.16b, v7.16b, v18.16b
    sub x2, x2, #64
    ld1 {v17.16b, v18.16b, v19.16b, v20.16b}, [x2]
    zip1 v21.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v21.16b
    zip1 v21.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v21.16b
    zip1 v21.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v21.16b
    zip1 v21.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v21.16b
    aesmc v19.16b, v19.16b
    aesmc v20.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v0.16b, v16.16b
    aese v1.16b, v16.16b
    aesd v2.16b, v16.16b
    aese v3.16b, v16.16b
    aesd v4.16b, v16.16b
    aese v5.16b, v16.16b
    aesd v6.16b, v16.16b
    aese v7.16b, v16.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v0.16b, v19.16b
    aese v1.16b, v20.16b
    aese v2.16b, v19.16b
    aese v3.16b, v20.16b
    aese v4.16b, v19.16b
    aese v5.16b, v20.16b
    aese v6.16b, v19.16b
    aese v7.16b, v20.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v17.16b
    eor v3.16b, v3.16b, v18.16b
    eor v4.16b, v4.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v6.16b, v6.16b, v17.16b
    eor v7.16b, v7.16b, v18.16b
    sub x2, x2, #64
    ld1 {v17.16b, v18.16b, v19.16b, v20.16b}, [x2]
    zip1 v21.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v21.16b
    zip1 v21.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v21.16b
    zip1 v21.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v21.16b
    zip1 v21.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v21.16b
    aesmc v19.16b, v19.16b
    aesmc v20.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v0.16b, v16.16b
    aese v1.16b, v16.16b
    aesd v2.16b, v16.16b
    aese v3.16b, v16.16b
    aesd v4.16b, v16.16b
    aese v5.16b, v16.16b
    aesd v6.16b, v16.16b
    aese v7.16b, v16.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v0.16b, v19.16b
    aese v1.16b, v20.16b
    aese v2.16b, v19.16b
    aese v3.16b, v20.16b
    aese v4.16b, v19.16b
    aese v5.16b, v20.16b
    aese v6.16b, v19.16b
    aese v7.16b, v20.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v17.16b
    eor v3.16b, v3.16b, v18.16b
    eor v4.16b, v4.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v6.16b, v6.16b, v17.16b
    eor v7.16b, v7.16b, v18.16b
    sub x2, x2, #64
    ld1 {v17.16b, v18.16b, v19.16b, v20.16b}, [x2]
    zip1 v21.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v21.16b
    zip1 v21.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v21.16b
    zip1 v21.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v21.16b
    zip1 v21.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v21.16b
    aesmc v19.16b, v19.16b
    aesmc v20.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v0.16b, v16.16b
    aese v1.16b, v16.16b
    aesd v2.16b, v16.16b
    aese v3.16b, v16.16b
    aesd v4.16b, v16.16b
    aese v5.16b, v16.16b
    aesd v6.16b, v16.16b
    aese v7.16b, v16.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v0.16b, v19.16b
    aese v1.16b, v20.16b
    aese v2.16b, v19.16b
    aese v3.16b, v20.16b
    aese v4.16b, v19.16b
    aese v5.16b, v20.16b
    aese v6.16b, v19.16b
    aese v7.16b, v20.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v17.16b
    eor v3.16b, v3.16b, v18.16b
    eor v4.16b, v4.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v6.16b, v6.16b, v17.16b
    eor v7.16b, v7.16b, v18.16b
    sub x2, x2, #64
    ld1 {v17.16b, v18.16b, v19.16b, v20.16b}, [x2]
    zip1 v21.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v21.16b
    zip1 v21.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v21.16b
    zip1 v21.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v21.16b
    zip1 v21.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v21.16b
    aesmc v19.16b, v19.16b
    aesmc v20.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v0.16b, v16.16b
    aese v1.16b, v16.16b
    aesd v2.16b, v16.16b
    aese v3.16b, v16.16b
    aesd v4.16b, v16.16b
    aese v5.16b, v16.16b
    aesd v6.16b, v16.16b
    aese v7.16b, v16.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v0.16b, v19.16b
    aese v1.16b, v20.16b
    aese v2.16b, v19.16b
    aese v3.16b, v20.16b
    aese v4.16b, v19.16b
    aese v5.16b, v20.16b
    aese v6.16b, v19.16b
    aese v7.16b, v20.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v17.16b
    eor v3.16b, v3.16b, v18.16b
    eor v4.16b, v4.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v6.16b, v6.16b, v17.16b
    eor v7.16b, v7.16b, v18.16b
    sub x2, x2, #64
    ld1 {v17.16b, v18.16b, v19.16b, v20.16b}, [x2]
    zip1 v21.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v21.16b
    zip1 v21.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v21.16b
    zip1 v21.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v21.16b
    zip1 v21.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v21.16b
    aesmc v19.16b, v19.16b
    aesmc v20.16b, v20.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v0.16b, v16.16b
    aese v1.16b, v16.16b
    aesd v2.16b, v16.16b
    aese v3.16b, v16.16b
    aesd v4.16b, v16.16b
    aese v5.16b, v16.16b
    aesd v6.16b, v16.16b
    aese v7.16b, v16.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v0.16b, v19.16b
    aese v1.16b, v20.16b
    aese v2.16b, v19.16b
    aese v3.16b, v20.16b
    aese v4.16b, v19.16b
    aese v5.16b, v20.16b
    aese v6.16b, v19.16b
    aese v7.16b, v20.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v17.16b
    eor v3.16b, v3.16b, v18.16b
    eor v4.16b, v4.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v6.16b, v6.16b, v17.16b
    eor v7.16b, v7.16b, v18.16b
    st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x0], #64
    st1 {v4.16b, v5.16b, v6.16b, v7.16b}, [x0]
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
    ret
    ENDP

    EXPORT areion_asura_encrypt_4blocks_otf_asm
areion_asura_encrypt_4blocks_otf_asm PROC
    hint #34 ; bti c
    ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x1], #64
    ld1 {v4.16b, v5.16b, v6.16b, v7.16b}, [x1]
    ld1 {v16.16b, v17.16b}, [x2]
    ld1 {v18.16b}, [x3]
    eor v19.16b, v19.16b, v19.16b
    adrp x9, asuraConsts
    add x9, x9, asuraConsts
    add x9, x9, #128
    ld1 {v22.16b, v23.16b}, [x9]
    adrp x10, asuraGFConsts
    add x10, x10, asuraGFConsts
    ld1 {v21.16b}, [x10]
    adrp x9, asuraRoundConstants
    add x9, x9, asuraRoundConstants
    ld1 {v24.16b}, [x9], #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v25.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v25.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v24.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v25.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v24.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v25.16b
    aesimc v7.16b, v7.16b
    aese v18.16b, v19.16b
    aesmc v18.16b, v18.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v21.16b
    and v29.16b, v29.16b, v21.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9], #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    aese v0.16b, v24.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v25.16b
    aesimc v1.16b, v1.16b
    uzp1 v26.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v26.16b
    aese v2.16b, v24.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v25.16b
    aesimc v3.16b, v3.16b
    uzp1 v26.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v26.16b
    aese v4.16b, v24.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v25.16b
    aesimc v5.16b, v5.16b
    uzp1 v26.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v26.16b
    aese v6.16b, v24.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v25.16b
    aesimc v7.16b, v7.16b
    uzp1 v26.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v26.16b
    aese v18.16b, v19.16b
    aesmc v18.16b, v18.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v21.16b
    and v29.16b, v29.16b, v21.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9], #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v25.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v25.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v24.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v25.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v24.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v25.16b
    aesimc v7.16b, v7.16b
    aese v18.16b, v19.16b
    aesmc v18.16b, v18.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v21.16b
    and v29.16b, v29.16b, v21.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9], #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    aese v0.16b, v24.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v25.16b
    aesimc v1.16b, v1.16b
    uzp1 v26.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v26.16b
    aese v2.16b, v24.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v25.16b
    aesimc v3.16b, v3.16b
    uzp1 v26.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v26.16b
    aese v4.16b, v24.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v25.16b
    aesimc v5.16b, v5.16b
    uzp1 v26.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v26.16b
    aese v6.16b, v24.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v25.16b
    aesimc v7.16b, v7.16b
    uzp1 v26.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v26.16b
    aese v18.16b, v19.16b
    aesmc v18.16b, v18.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v21.16b
    and v29.16b, v29.16b, v21.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9], #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v25.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v25.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v24.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v25.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v24.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v25.16b
    aesimc v7.16b, v7.16b
    aese v18.16b, v19.16b
    aesmc v18.16b, v18.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v21.16b
    and v29.16b, v29.16b, v21.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9], #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    aese v0.16b, v24.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v25.16b
    aesimc v1.16b, v1.16b
    uzp1 v26.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v26.16b
    aese v2.16b, v24.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v25.16b
    aesimc v3.16b, v3.16b
    uzp1 v26.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v26.16b
    aese v4.16b, v24.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v25.16b
    aesimc v5.16b, v5.16b
    uzp1 v26.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v26.16b
    aese v6.16b, v24.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v25.16b
    aesimc v7.16b, v7.16b
    uzp1 v26.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v26.16b
    aese v18.16b, v19.16b
    aesmc v18.16b, v18.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v21.16b
    and v29.16b, v29.16b, v21.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9], #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v25.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v25.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v24.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v25.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v24.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v25.16b
    aesimc v7.16b, v7.16b
    aese v18.16b, v19.16b
    aesmc v18.16b, v18.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v21.16b
    and v29.16b, v29.16b, v21.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9], #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    aese v0.16b, v24.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v25.16b
    aesimc v1.16b, v1.16b
    uzp1 v26.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v26.16b
    aese v2.16b, v24.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v25.16b
    aesimc v3.16b, v3.16b
    uzp1 v26.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v26.16b
    aese v4.16b, v24.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v25.16b
    aesimc v5.16b, v5.16b
    uzp1 v26.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v26.16b
    aese v6.16b, v24.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v25.16b
    aesimc v7.16b, v7.16b
    uzp1 v26.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v26.16b
    aese v18.16b, v19.16b
    aesmc v18.16b, v18.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v21.16b
    and v29.16b, v29.16b, v21.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9], #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v25.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v25.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v24.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v25.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v24.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v25.16b
    aesimc v7.16b, v7.16b
    aese v18.16b, v19.16b
    aesmc v18.16b, v18.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v21.16b
    and v29.16b, v29.16b, v21.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9], #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    aese v0.16b, v24.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v25.16b
    aesimc v1.16b, v1.16b
    uzp1 v26.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v26.16b
    aese v2.16b, v24.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v25.16b
    aesimc v3.16b, v3.16b
    uzp1 v26.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v26.16b
    aese v4.16b, v24.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v25.16b
    aesimc v5.16b, v5.16b
    uzp1 v26.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v26.16b
    aese v6.16b, v24.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v25.16b
    aesimc v7.16b, v7.16b
    uzp1 v26.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v26.16b
    aese v18.16b, v19.16b
    aesmc v18.16b, v18.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v21.16b
    and v29.16b, v29.16b, v21.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9], #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    aesd v0.16b, v24.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v25.16b
    aesimc v1.16b, v1.16b
    aesd v2.16b, v24.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v25.16b
    aesimc v3.16b, v3.16b
    aesd v4.16b, v24.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v25.16b
    aesimc v5.16b, v5.16b
    aesd v6.16b, v24.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v25.16b
    aesimc v7.16b, v7.16b
    aese v18.16b, v19.16b
    aesmc v18.16b, v18.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v21.16b
    and v29.16b, v29.16b, v21.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9], #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    aese v0.16b, v24.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v25.16b
    aesimc v1.16b, v1.16b
    aese v2.16b, v24.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v25.16b
    aesimc v3.16b, v3.16b
    aese v4.16b, v24.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v25.16b
    aesimc v5.16b, v5.16b
    aese v6.16b, v24.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v25.16b
    aesimc v7.16b, v7.16b
    aese v18.16b, v19.16b
    aesmc v18.16b, v18.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v21.16b
    and v29.16b, v29.16b, v21.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9]
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x0], #64
    st1 {v4.16b, v5.16b, v6.16b, v7.16b}, [x0]
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
    mov x9, xzr
    mov x10, xzr
    ret
    ENDP

    EXPORT areion_asura_decrypt_4blocks_otf_asm
areion_asura_decrypt_4blocks_otf_asm PROC
    hint #34 ; bti c
    ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x1], #64
    ld1 {v4.16b, v5.16b, v6.16b, v7.16b}, [x1]
    ld1 {v16.16b, v17.16b}, [x2]
    ld1 {v18.16b}, [x3]
    eor v19.16b, v19.16b, v19.16b
    adrp x9, asuraConsts
    add x9, x9, asuraConsts
    add x9, x9, #128
    ld1 {v22.16b, v23.16b}, [x9], #32
    ld1 {v30.16b, v31.16b}, [x9]
    adrp x10, asuraGFConsts
    add x10, x10, asuraGFConsts
    ld1 {v21.16b}, [x10]
    add x10, x10, #32
    ld1 {v20.16b}, [x10]
    mov x10, #12
asura_dec4_otf_fwd_loop:
    aese v18.16b, v19.16b
    aesmc v18.16b, v18.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v21.16b
    and v29.16b, v29.16b, v21.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    subs x10, x10, #1
    b.ne asura_dec4_otf_fwd_loop
    adrp x9, asuraRoundConstants
    add x9, x9, asuraRoundConstants
    add x9, x9, #192
    ld1 {v24.16b}, [x9]
    sub x9, x9, #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v19.16b
    tbl v26.16b, {v16.16b, v17.16b}, v30.16b
    tbl v27.16b, {v16.16b, v17.16b}, v31.16b
    shl v28.16b, v26.16b, #7
    shl v29.16b, v27.16b, #7
    sshr v28.16b, v28.16b, #7
    sshr v29.16b, v29.16b, #7
    and v28.16b, v28.16b, v20.16b
    and v29.16b, v29.16b, v20.16b
    ushr v16.16b, v26.16b, #1
    ushr v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9]
    sub x9, x9, #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v0.16b, v19.16b
    aese v1.16b, v19.16b
    aesd v2.16b, v19.16b
    aese v3.16b, v19.16b
    aesd v4.16b, v19.16b
    aese v5.16b, v19.16b
    aesd v6.16b, v19.16b
    aese v7.16b, v19.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v0.16b, v24.16b
    aese v1.16b, v25.16b
    aese v2.16b, v24.16b
    aese v3.16b, v25.16b
    aese v4.16b, v24.16b
    aese v5.16b, v25.16b
    aese v6.16b, v24.16b
    aese v7.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v19.16b
    tbl v26.16b, {v16.16b, v17.16b}, v30.16b
    tbl v27.16b, {v16.16b, v17.16b}, v31.16b
    shl v28.16b, v26.16b, #7
    shl v29.16b, v27.16b, #7
    sshr v28.16b, v28.16b, #7
    sshr v29.16b, v29.16b, #7
    and v28.16b, v28.16b, v20.16b
    and v29.16b, v29.16b, v20.16b
    ushr v16.16b, v26.16b, #1
    ushr v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9]
    sub x9, x9, #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v19.16b
    tbl v26.16b, {v16.16b, v17.16b}, v30.16b
    tbl v27.16b, {v16.16b, v17.16b}, v31.16b
    shl v28.16b, v26.16b, #7
    shl v29.16b, v27.16b, #7
    sshr v28.16b, v28.16b, #7
    sshr v29.16b, v29.16b, #7
    and v28.16b, v28.16b, v20.16b
    and v29.16b, v29.16b, v20.16b
    ushr v16.16b, v26.16b, #1
    ushr v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9]
    sub x9, x9, #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    zip1 v26.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v26.16b
    zip1 v26.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v26.16b
    zip1 v26.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v26.16b
    zip1 v26.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v26.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v0.16b, v19.16b
    aese v1.16b, v19.16b
    aesd v2.16b, v19.16b
    aese v3.16b, v19.16b
    aesd v4.16b, v19.16b
    aese v5.16b, v19.16b
    aesd v6.16b, v19.16b
    aese v7.16b, v19.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v0.16b, v24.16b
    aese v1.16b, v25.16b
    aese v2.16b, v24.16b
    aese v3.16b, v25.16b
    aese v4.16b, v24.16b
    aese v5.16b, v25.16b
    aese v6.16b, v24.16b
    aese v7.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v19.16b
    tbl v26.16b, {v16.16b, v17.16b}, v30.16b
    tbl v27.16b, {v16.16b, v17.16b}, v31.16b
    shl v28.16b, v26.16b, #7
    shl v29.16b, v27.16b, #7
    sshr v28.16b, v28.16b, #7
    sshr v29.16b, v29.16b, #7
    and v28.16b, v28.16b, v20.16b
    and v29.16b, v29.16b, v20.16b
    ushr v16.16b, v26.16b, #1
    ushr v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9]
    sub x9, x9, #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v19.16b
    tbl v26.16b, {v16.16b, v17.16b}, v30.16b
    tbl v27.16b, {v16.16b, v17.16b}, v31.16b
    shl v28.16b, v26.16b, #7
    shl v29.16b, v27.16b, #7
    sshr v28.16b, v28.16b, #7
    sshr v29.16b, v29.16b, #7
    and v28.16b, v28.16b, v20.16b
    and v29.16b, v29.16b, v20.16b
    ushr v16.16b, v26.16b, #1
    ushr v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9]
    sub x9, x9, #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    zip1 v26.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v26.16b
    zip1 v26.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v26.16b
    zip1 v26.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v26.16b
    zip1 v26.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v26.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v0.16b, v19.16b
    aese v1.16b, v19.16b
    aesd v2.16b, v19.16b
    aese v3.16b, v19.16b
    aesd v4.16b, v19.16b
    aese v5.16b, v19.16b
    aesd v6.16b, v19.16b
    aese v7.16b, v19.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v0.16b, v24.16b
    aese v1.16b, v25.16b
    aese v2.16b, v24.16b
    aese v3.16b, v25.16b
    aese v4.16b, v24.16b
    aese v5.16b, v25.16b
    aese v6.16b, v24.16b
    aese v7.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v19.16b
    tbl v26.16b, {v16.16b, v17.16b}, v30.16b
    tbl v27.16b, {v16.16b, v17.16b}, v31.16b
    shl v28.16b, v26.16b, #7
    shl v29.16b, v27.16b, #7
    sshr v28.16b, v28.16b, #7
    sshr v29.16b, v29.16b, #7
    and v28.16b, v28.16b, v20.16b
    and v29.16b, v29.16b, v20.16b
    ushr v16.16b, v26.16b, #1
    ushr v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9]
    sub x9, x9, #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v19.16b
    tbl v26.16b, {v16.16b, v17.16b}, v30.16b
    tbl v27.16b, {v16.16b, v17.16b}, v31.16b
    shl v28.16b, v26.16b, #7
    shl v29.16b, v27.16b, #7
    sshr v28.16b, v28.16b, #7
    sshr v29.16b, v29.16b, #7
    and v28.16b, v28.16b, v20.16b
    and v29.16b, v29.16b, v20.16b
    ushr v16.16b, v26.16b, #1
    ushr v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9]
    sub x9, x9, #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    zip1 v26.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v26.16b
    zip1 v26.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v26.16b
    zip1 v26.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v26.16b
    zip1 v26.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v26.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v0.16b, v19.16b
    aese v1.16b, v19.16b
    aesd v2.16b, v19.16b
    aese v3.16b, v19.16b
    aesd v4.16b, v19.16b
    aese v5.16b, v19.16b
    aesd v6.16b, v19.16b
    aese v7.16b, v19.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v0.16b, v24.16b
    aese v1.16b, v25.16b
    aese v2.16b, v24.16b
    aese v3.16b, v25.16b
    aese v4.16b, v24.16b
    aese v5.16b, v25.16b
    aese v6.16b, v24.16b
    aese v7.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v19.16b
    tbl v26.16b, {v16.16b, v17.16b}, v30.16b
    tbl v27.16b, {v16.16b, v17.16b}, v31.16b
    shl v28.16b, v26.16b, #7
    shl v29.16b, v27.16b, #7
    sshr v28.16b, v28.16b, #7
    sshr v29.16b, v29.16b, #7
    and v28.16b, v28.16b, v20.16b
    and v29.16b, v29.16b, v20.16b
    ushr v16.16b, v26.16b, #1
    ushr v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9]
    sub x9, x9, #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v19.16b
    tbl v26.16b, {v16.16b, v17.16b}, v30.16b
    tbl v27.16b, {v16.16b, v17.16b}, v31.16b
    shl v28.16b, v26.16b, #7
    shl v29.16b, v27.16b, #7
    sshr v28.16b, v28.16b, #7
    sshr v29.16b, v29.16b, #7
    and v28.16b, v28.16b, v20.16b
    and v29.16b, v29.16b, v20.16b
    ushr v16.16b, v26.16b, #1
    ushr v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9]
    sub x9, x9, #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    zip1 v26.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v26.16b
    zip1 v26.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v26.16b
    zip1 v26.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v26.16b
    zip1 v26.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v26.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v0.16b, v19.16b
    aese v1.16b, v19.16b
    aesd v2.16b, v19.16b
    aese v3.16b, v19.16b
    aesd v4.16b, v19.16b
    aese v5.16b, v19.16b
    aesd v6.16b, v19.16b
    aese v7.16b, v19.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v0.16b, v24.16b
    aese v1.16b, v25.16b
    aese v2.16b, v24.16b
    aese v3.16b, v25.16b
    aese v4.16b, v24.16b
    aese v5.16b, v25.16b
    aese v6.16b, v24.16b
    aese v7.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v19.16b
    tbl v26.16b, {v16.16b, v17.16b}, v30.16b
    tbl v27.16b, {v16.16b, v17.16b}, v31.16b
    shl v28.16b, v26.16b, #7
    shl v29.16b, v27.16b, #7
    sshr v28.16b, v28.16b, #7
    sshr v29.16b, v29.16b, #7
    and v28.16b, v28.16b, v20.16b
    and v29.16b, v29.16b, v20.16b
    ushr v16.16b, v26.16b, #1
    ushr v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9]
    sub x9, x9, #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v19.16b
    tbl v26.16b, {v16.16b, v17.16b}, v30.16b
    tbl v27.16b, {v16.16b, v17.16b}, v31.16b
    shl v28.16b, v26.16b, #7
    shl v29.16b, v27.16b, #7
    sshr v28.16b, v28.16b, #7
    sshr v29.16b, v29.16b, #7
    and v28.16b, v28.16b, v20.16b
    and v29.16b, v29.16b, v20.16b
    ushr v16.16b, v26.16b, #1
    ushr v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9]
    sub x9, x9, #16
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    zip1 v26.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v26.16b
    zip1 v26.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v26.16b
    zip1 v26.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v26.16b
    zip1 v26.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v26.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v0.16b, v19.16b
    aese v1.16b, v19.16b
    aesd v2.16b, v19.16b
    aese v3.16b, v19.16b
    aesd v4.16b, v19.16b
    aese v5.16b, v19.16b
    aesd v6.16b, v19.16b
    aese v7.16b, v19.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v0.16b, v24.16b
    aese v1.16b, v25.16b
    aese v2.16b, v24.16b
    aese v3.16b, v25.16b
    aese v4.16b, v24.16b
    aese v5.16b, v25.16b
    aese v6.16b, v24.16b
    aese v7.16b, v25.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v19.16b
    tbl v26.16b, {v16.16b, v17.16b}, v30.16b
    tbl v27.16b, {v16.16b, v17.16b}, v31.16b
    shl v28.16b, v26.16b, #7
    shl v29.16b, v27.16b, #7
    sshr v28.16b, v28.16b, #7
    sshr v29.16b, v29.16b, #7
    and v28.16b, v28.16b, v20.16b
    and v29.16b, v29.16b, v20.16b
    ushr v16.16b, v26.16b, #1
    ushr v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v24.16b}, [x9]
    eor v24.16b, v24.16b, v16.16b
    eor v24.16b, v24.16b, v18.16b
    eor v25.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x0], #64
    st1 {v4.16b, v5.16b, v6.16b, v7.16b}, [x0]
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
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x9, xzr
    mov x10, xzr
    ret
    ENDP

    END
