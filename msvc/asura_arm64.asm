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
    ld1 {v0.16b, v1.16b}, [x2]
    ld1 {v2.16b}, [x3]
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
    fmov x2, d16
    fmov x3, v16.d[1]
    fmov x4, d17
    fmov x5, v17.d[1]
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
    aesmc v16.16b, v16.16b
    aesmc v17.16b, v17.16b
    fmov x6, d16
    fmov x7, v16.d[1]
    fmov x11, d17
    fmov x12, v17.d[1]
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
    fmov x13, d16
    fmov x14, v16.d[1]
    fmov x15, d17
    fmov x16, v17.d[1]
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
    aesmc v16.16b, v16.16b
    aesmc v17.16b, v17.16b
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v7.16b, {v0.16b, v1.16b}, v4.16b
    tbl v1.16b, {v0.16b, v1.16b}, v5.16b
    sshr v0.16b, v7.16b, #7
    and v0.16b, v0.16b, v6.16b
    shl v7.16b, v7.16b, #1
    eor v0.16b, v7.16b, v0.16b
    sshr v7.16b, v1.16b, #7
    and v7.16b, v7.16b, v6.16b
    shl v1.16b, v1.16b, #1
    eor v1.16b, v1.16b, v7.16b
    ld1 {v7.16b}, [x9], #16
    eor v18.16b, v0.16b, v2.16b
    eor v18.16b, v18.16b, v7.16b
    eor v19.16b, v1.16b, v2.16b
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v7.16b, {v0.16b, v1.16b}, v4.16b
    tbl v1.16b, {v0.16b, v1.16b}, v5.16b
    sshr v0.16b, v7.16b, #7
    and v0.16b, v0.16b, v6.16b
    shl v7.16b, v7.16b, #1
    eor v0.16b, v7.16b, v0.16b
    sshr v7.16b, v1.16b, #7
    and v7.16b, v7.16b, v6.16b
    shl v1.16b, v1.16b, #1
    eor v1.16b, v1.16b, v7.16b
    ld1 {v7.16b}, [x9], #16
    eor v20.16b, v0.16b, v2.16b
    eor v20.16b, v20.16b, v7.16b
    eor v21.16b, v1.16b, v2.16b
    aesmc v20.16b, v20.16b
    aesmc v21.16b, v21.16b
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v7.16b, {v0.16b, v1.16b}, v4.16b
    tbl v1.16b, {v0.16b, v1.16b}, v5.16b
    sshr v0.16b, v7.16b, #7
    and v0.16b, v0.16b, v6.16b
    shl v7.16b, v7.16b, #1
    eor v0.16b, v7.16b, v0.16b
    sshr v7.16b, v1.16b, #7
    and v7.16b, v7.16b, v6.16b
    shl v1.16b, v1.16b, #1
    eor v1.16b, v1.16b, v7.16b
    ld1 {v7.16b}, [x9], #16
    eor v22.16b, v0.16b, v2.16b
    eor v22.16b, v22.16b, v7.16b
    eor v23.16b, v1.16b, v2.16b
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v7.16b, {v0.16b, v1.16b}, v4.16b
    tbl v1.16b, {v0.16b, v1.16b}, v5.16b
    sshr v0.16b, v7.16b, #7
    and v0.16b, v0.16b, v6.16b
    shl v7.16b, v7.16b, #1
    eor v0.16b, v7.16b, v0.16b
    sshr v7.16b, v1.16b, #7
    and v7.16b, v7.16b, v6.16b
    shl v1.16b, v1.16b, #1
    eor v1.16b, v1.16b, v7.16b
    ld1 {v7.16b}, [x9], #16
    eor v24.16b, v0.16b, v2.16b
    eor v24.16b, v24.16b, v7.16b
    eor v25.16b, v1.16b, v2.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v7.16b, {v0.16b, v1.16b}, v4.16b
    tbl v1.16b, {v0.16b, v1.16b}, v5.16b
    sshr v0.16b, v7.16b, #7
    and v0.16b, v0.16b, v6.16b
    shl v7.16b, v7.16b, #1
    eor v0.16b, v7.16b, v0.16b
    sshr v7.16b, v1.16b, #7
    and v7.16b, v7.16b, v6.16b
    shl v1.16b, v1.16b, #1
    eor v1.16b, v1.16b, v7.16b
    ld1 {v7.16b}, [x9], #16
    eor v26.16b, v0.16b, v2.16b
    eor v26.16b, v26.16b, v7.16b
    eor v27.16b, v1.16b, v2.16b
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v7.16b, {v0.16b, v1.16b}, v4.16b
    tbl v1.16b, {v0.16b, v1.16b}, v5.16b
    sshr v0.16b, v7.16b, #7
    and v0.16b, v0.16b, v6.16b
    shl v7.16b, v7.16b, #1
    eor v0.16b, v7.16b, v0.16b
    sshr v7.16b, v1.16b, #7
    and v7.16b, v7.16b, v6.16b
    shl v1.16b, v1.16b, #1
    eor v1.16b, v1.16b, v7.16b
    ld1 {v7.16b}, [x9], #16
    eor v28.16b, v0.16b, v2.16b
    eor v28.16b, v28.16b, v7.16b
    eor v29.16b, v1.16b, v2.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v7.16b, {v0.16b, v1.16b}, v4.16b
    tbl v1.16b, {v0.16b, v1.16b}, v5.16b
    sshr v0.16b, v7.16b, #7
    and v0.16b, v0.16b, v6.16b
    shl v7.16b, v7.16b, #1
    eor v0.16b, v7.16b, v0.16b
    sshr v7.16b, v1.16b, #7
    and v7.16b, v7.16b, v6.16b
    shl v1.16b, v1.16b, #1
    eor v1.16b, v1.16b, v7.16b
    ld1 {v7.16b}, [x9], #16
    eor v30.16b, v0.16b, v2.16b
    eor v30.16b, v30.16b, v7.16b
    eor v31.16b, v1.16b, v2.16b
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    tbl v7.16b, {v0.16b, v1.16b}, v4.16b
    tbl v1.16b, {v0.16b, v1.16b}, v5.16b
    sshr v0.16b, v7.16b, #7
    and v0.16b, v0.16b, v6.16b
    shl v7.16b, v7.16b, #1
    eor v0.16b, v7.16b, v0.16b
    sshr v7.16b, v1.16b, #7
    and v7.16b, v7.16b, v6.16b
    shl v1.16b, v1.16b, #1
    eor v1.16b, v1.16b, v7.16b
    tbl v7.16b, {v0.16b, v1.16b}, v4.16b
    tbl v4.16b, {v0.16b, v1.16b}, v5.16b
    ld1 {v5.16b}, [x9], #16
    eor v0.16b, v0.16b, v2.16b
    eor v5.16b, v0.16b, v5.16b
    eor v1.16b, v1.16b, v2.16b
    aesmc v5.16b, v5.16b
    aesmc v1.16b, v1.16b
    aese v2.16b, v3.16b
    aesmc v2.16b, v2.16b
    sshr v0.16b, v7.16b, #7
    and v0.16b, v0.16b, v6.16b
    shl v7.16b, v7.16b, #1
    eor v0.16b, v7.16b, v0.16b
    sshr v7.16b, v4.16b, #7
    and v7.16b, v7.16b, v6.16b
    shl v4.16b, v4.16b, #1
    eor v6.16b, v4.16b, v7.16b
    mov v4.16b, v5.16b
    mov v5.16b, v1.16b
    mov v1.16b, v6.16b
    ld1 {v6.16b}, [x9]
    eor v6.16b, v6.16b, v0.16b
    eor v6.16b, v6.16b, v2.16b
    eor v7.16b, v1.16b, v2.16b
    ld1 {v0.16b, v1.16b}, [x1]
    eor v0.16b, v0.16b, v6.16b
    eor v1.16b, v1.16b, v7.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v3.16b
    aese v1.16b, v3.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v4.16b
    aese v1.16b, v5.16b
    eor v0.16b, v0.16b, v30.16b
    eor v1.16b, v1.16b, v31.16b
    zip1 v7.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v7.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v3.16b
    aese v1.16b, v3.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v28.16b
    aese v1.16b, v29.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    zip1 v7.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v7.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v3.16b
    aese v1.16b, v3.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v24.16b
    aese v1.16b, v25.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v23.16b
    zip1 v7.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v7.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v3.16b
    aese v1.16b, v3.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v20.16b
    aese v1.16b, v21.16b
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    zip1 v7.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v7.16b
    fmov d2, x13
    fmov v2.d[1], x14
    fmov d4, x15
    fmov v4.d[1], x16
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v3.16b
    aese v1.16b, v3.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v16.16b
    aese v1.16b, v17.16b
    eor v0.16b, v0.16b, v2.16b
    eor v1.16b, v1.16b, v4.16b
    zip1 v7.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v7.16b
    fmov d2, x6
    fmov v2.d[1], x7
    fmov d4, x11
    fmov v4.d[1], x12
    fmov d5, x2
    fmov v5.d[1], x3
    fmov d6, x4
    fmov v6.d[1], x5
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v3.16b
    aese v1.16b, v3.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v2.16b
    aese v1.16b, v4.16b
    eor v0.16b, v0.16b, v5.16b
    eor v1.16b, v1.16b, v6.16b
    st1 {v0.16b, v1.16b}, [x0]
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
    mov x4, xzr
    mov x5, xzr
    mov x6, xzr
    mov x7, xzr
    mov x9, xzr
    mov x10, xzr
    mov x11, xzr
    mov x12, xzr
    mov x13, xzr
    mov x14, xzr
    mov x15, xzr
    mov x16, xzr
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
    ld1 {v18.16b, v19.16b, v20.16b, v21.16b}, [x3]
    eor v31.16b, v31.16b, v31.16b
    adrp x9, asuraConsts
    add x9, x9, asuraConsts
    add x9, x9, #128
    ld1 {v22.16b, v23.16b}, [x9]
    adrp x10, asuraGFConsts
    add x10, x10, asuraGFConsts
    ld1 {v24.16b}, [x10]
    adrp x9, asuraRoundConstants
    add x9, x9, asuraRoundConstants
    ld1 {v25.16b}, [x9], #16
    eor v25.16b, v25.16b, v16.16b
    eor v26.16b, v25.16b, v18.16b
    eor v27.16b, v17.16b, v18.16b
    aesd v0.16b, v26.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    eor v26.16b, v25.16b, v19.16b
    eor v27.16b, v17.16b, v19.16b
    aesd v2.16b, v26.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    eor v26.16b, v25.16b, v20.16b
    eor v27.16b, v17.16b, v20.16b
    aesd v4.16b, v26.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    eor v26.16b, v25.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aesd v6.16b, v26.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v24.16b
    and v29.16b, v29.16b, v24.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v25.16b}, [x9], #16
    eor v25.16b, v25.16b, v16.16b
    eor v26.16b, v25.16b, v18.16b
    eor v27.16b, v17.16b, v18.16b
    aese v0.16b, v26.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    uzp1 v28.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v28.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    eor v26.16b, v25.16b, v19.16b
    eor v27.16b, v17.16b, v19.16b
    aese v2.16b, v26.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    uzp1 v28.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v28.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    eor v26.16b, v25.16b, v20.16b
    eor v27.16b, v17.16b, v20.16b
    aese v4.16b, v26.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    uzp1 v28.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v28.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    eor v26.16b, v25.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aese v6.16b, v26.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    uzp1 v28.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v28.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v24.16b
    and v29.16b, v29.16b, v24.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v25.16b}, [x9], #16
    eor v25.16b, v25.16b, v16.16b
    eor v26.16b, v25.16b, v18.16b
    eor v27.16b, v17.16b, v18.16b
    aesd v0.16b, v26.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    eor v26.16b, v25.16b, v19.16b
    eor v27.16b, v17.16b, v19.16b
    aesd v2.16b, v26.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    eor v26.16b, v25.16b, v20.16b
    eor v27.16b, v17.16b, v20.16b
    aesd v4.16b, v26.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    eor v26.16b, v25.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aesd v6.16b, v26.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v24.16b
    and v29.16b, v29.16b, v24.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v25.16b}, [x9], #16
    eor v25.16b, v25.16b, v16.16b
    eor v26.16b, v25.16b, v18.16b
    eor v27.16b, v17.16b, v18.16b
    aese v0.16b, v26.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    uzp1 v28.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v28.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    eor v26.16b, v25.16b, v19.16b
    eor v27.16b, v17.16b, v19.16b
    aese v2.16b, v26.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    uzp1 v28.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v28.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    eor v26.16b, v25.16b, v20.16b
    eor v27.16b, v17.16b, v20.16b
    aese v4.16b, v26.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    uzp1 v28.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v28.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    eor v26.16b, v25.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aese v6.16b, v26.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    uzp1 v28.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v28.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v24.16b
    and v29.16b, v29.16b, v24.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v25.16b}, [x9], #16
    eor v25.16b, v25.16b, v16.16b
    eor v26.16b, v25.16b, v18.16b
    eor v27.16b, v17.16b, v18.16b
    aesd v0.16b, v26.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    eor v26.16b, v25.16b, v19.16b
    eor v27.16b, v17.16b, v19.16b
    aesd v2.16b, v26.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    eor v26.16b, v25.16b, v20.16b
    eor v27.16b, v17.16b, v20.16b
    aesd v4.16b, v26.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    eor v26.16b, v25.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aesd v6.16b, v26.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v24.16b
    and v29.16b, v29.16b, v24.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v25.16b}, [x9], #16
    eor v25.16b, v25.16b, v16.16b
    eor v26.16b, v25.16b, v18.16b
    eor v27.16b, v17.16b, v18.16b
    aese v0.16b, v26.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    uzp1 v28.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v28.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    eor v26.16b, v25.16b, v19.16b
    eor v27.16b, v17.16b, v19.16b
    aese v2.16b, v26.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    uzp1 v28.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v28.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    eor v26.16b, v25.16b, v20.16b
    eor v27.16b, v17.16b, v20.16b
    aese v4.16b, v26.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    uzp1 v28.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v28.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    eor v26.16b, v25.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aese v6.16b, v26.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    uzp1 v28.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v28.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v24.16b
    and v29.16b, v29.16b, v24.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v25.16b}, [x9], #16
    eor v25.16b, v25.16b, v16.16b
    eor v26.16b, v25.16b, v18.16b
    eor v27.16b, v17.16b, v18.16b
    aesd v0.16b, v26.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    eor v26.16b, v25.16b, v19.16b
    eor v27.16b, v17.16b, v19.16b
    aesd v2.16b, v26.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    eor v26.16b, v25.16b, v20.16b
    eor v27.16b, v17.16b, v20.16b
    aesd v4.16b, v26.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    eor v26.16b, v25.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aesd v6.16b, v26.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v24.16b
    and v29.16b, v29.16b, v24.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v25.16b}, [x9], #16
    eor v25.16b, v25.16b, v16.16b
    eor v26.16b, v25.16b, v18.16b
    eor v27.16b, v17.16b, v18.16b
    aese v0.16b, v26.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    uzp1 v28.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v28.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    eor v26.16b, v25.16b, v19.16b
    eor v27.16b, v17.16b, v19.16b
    aese v2.16b, v26.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    uzp1 v28.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v28.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    eor v26.16b, v25.16b, v20.16b
    eor v27.16b, v17.16b, v20.16b
    aese v4.16b, v26.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    uzp1 v28.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v28.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    eor v26.16b, v25.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aese v6.16b, v26.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    uzp1 v28.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v28.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v24.16b
    and v29.16b, v29.16b, v24.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v25.16b}, [x9], #16
    eor v25.16b, v25.16b, v16.16b
    eor v26.16b, v25.16b, v18.16b
    eor v27.16b, v17.16b, v18.16b
    aesd v0.16b, v26.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    eor v26.16b, v25.16b, v19.16b
    eor v27.16b, v17.16b, v19.16b
    aesd v2.16b, v26.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    eor v26.16b, v25.16b, v20.16b
    eor v27.16b, v17.16b, v20.16b
    aesd v4.16b, v26.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    eor v26.16b, v25.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aesd v6.16b, v26.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v24.16b
    and v29.16b, v29.16b, v24.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v25.16b}, [x9], #16
    eor v25.16b, v25.16b, v16.16b
    eor v26.16b, v25.16b, v18.16b
    eor v27.16b, v17.16b, v18.16b
    aese v0.16b, v26.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    uzp1 v28.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v28.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    eor v26.16b, v25.16b, v19.16b
    eor v27.16b, v17.16b, v19.16b
    aese v2.16b, v26.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    uzp1 v28.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v28.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    eor v26.16b, v25.16b, v20.16b
    eor v27.16b, v17.16b, v20.16b
    aese v4.16b, v26.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    uzp1 v28.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v28.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    eor v26.16b, v25.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aese v6.16b, v26.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    uzp1 v28.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v28.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v24.16b
    and v29.16b, v29.16b, v24.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v25.16b}, [x9], #16
    eor v25.16b, v25.16b, v16.16b
    eor v26.16b, v25.16b, v18.16b
    eor v27.16b, v17.16b, v18.16b
    aesd v0.16b, v26.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    eor v26.16b, v25.16b, v19.16b
    eor v27.16b, v17.16b, v19.16b
    aesd v2.16b, v26.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    eor v26.16b, v25.16b, v20.16b
    eor v27.16b, v17.16b, v20.16b
    aesd v4.16b, v26.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    eor v26.16b, v25.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aesd v6.16b, v26.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v24.16b
    and v29.16b, v29.16b, v24.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v25.16b}, [x9], #16
    eor v25.16b, v25.16b, v16.16b
    eor v26.16b, v25.16b, v18.16b
    eor v27.16b, v17.16b, v18.16b
    aese v0.16b, v26.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    eor v26.16b, v25.16b, v19.16b
    eor v27.16b, v17.16b, v19.16b
    aese v2.16b, v26.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    eor v26.16b, v25.16b, v20.16b
    eor v27.16b, v17.16b, v20.16b
    aese v4.16b, v26.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    eor v26.16b, v25.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aese v6.16b, v26.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v28.16b, v26.16b, #7
    sshr v29.16b, v27.16b, #7
    and v28.16b, v28.16b, v24.16b
    and v29.16b, v29.16b, v24.16b
    shl v16.16b, v26.16b, #1
    shl v17.16b, v27.16b, #1
    eor v16.16b, v16.16b, v28.16b
    eor v17.16b, v17.16b, v29.16b
    ld1 {v25.16b}, [x9]
    eor v25.16b, v25.16b, v16.16b
    eor v26.16b, v25.16b, v18.16b
    eor v27.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    eor v26.16b, v25.16b, v19.16b
    eor v27.16b, v17.16b, v19.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    eor v26.16b, v25.16b, v20.16b
    eor v27.16b, v17.16b, v20.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v26.16b, v25.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
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
    eor v31.16b, v31.16b, v31.16b
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
    ld1 {v18.16b, v19.16b, v20.16b, v21.16b}, [x3]
    eor v31.16b, v31.16b, v31.16b
    adrp x9, asuraConsts
    add x9, x9, asuraConsts
    add x9, x9, #128
    ld1 {v22.16b, v23.16b}, [x9], #32
    ld1 {v28.16b, v29.16b}, [x9]
    adrp x10, asuraGFConsts
    add x10, x10, asuraGFConsts
    ld1 {v24.16b}, [x10]
    add x10, x10, #32
    ld1 {v25.16b}, [x10]
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v30.16b, v26.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    sshr v30.16b, v27.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v30.16b, v26.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    sshr v30.16b, v27.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v30.16b, v26.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    sshr v30.16b, v27.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v30.16b, v26.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    sshr v30.16b, v27.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v30.16b, v26.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    sshr v30.16b, v27.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v30.16b, v26.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    sshr v30.16b, v27.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v30.16b, v26.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    sshr v30.16b, v27.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v30.16b, v26.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    sshr v30.16b, v27.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v30.16b, v26.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    sshr v30.16b, v27.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v30.16b, v26.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    sshr v30.16b, v27.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v30.16b, v26.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    sshr v30.16b, v27.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    aese v18.16b, v31.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v31.16b
    aesmc v19.16b, v19.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    tbl v26.16b, {v16.16b, v17.16b}, v22.16b
    tbl v27.16b, {v16.16b, v17.16b}, v23.16b
    sshr v30.16b, v26.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    sshr v30.16b, v27.16b, #7
    and v30.16b, v30.16b, v24.16b
    shl v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    adrp x9, asuraRoundConstants
    add x9, x9, asuraRoundConstants
    add x9, x9, #192
    ld1 {v26.16b}, [x9]
    eor v26.16b, v26.16b, v16.16b
    eor v27.16b, v26.16b, v18.16b
    eor v30.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v27.16b
    eor v1.16b, v1.16b, v30.16b
    eor v27.16b, v26.16b, v19.16b
    eor v30.16b, v17.16b, v19.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v30.16b
    eor v27.16b, v26.16b, v20.16b
    eor v30.16b, v17.16b, v20.16b
    eor v4.16b, v4.16b, v27.16b
    eor v5.16b, v5.16b, v30.16b
    eor v27.16b, v26.16b, v21.16b
    eor v30.16b, v17.16b, v21.16b
    eor v6.16b, v6.16b, v27.16b
    eor v7.16b, v7.16b, v30.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    tbl v26.16b, {v16.16b, v17.16b}, v28.16b
    tbl v27.16b, {v16.16b, v17.16b}, v29.16b
    shl v30.16b, v26.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    shl v30.16b, v27.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    sub x9, x9, #16
    ld1 {v26.16b}, [x9]
    eor v26.16b, v26.16b, v16.16b
    eor v27.16b, v26.16b, v18.16b
    eor v30.16b, v17.16b, v18.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v27.16b
    aese v1.16b, v30.16b
    eor v27.16b, v26.16b, v19.16b
    eor v30.16b, v17.16b, v19.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesd v2.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v27.16b
    aese v3.16b, v30.16b
    eor v27.16b, v26.16b, v20.16b
    eor v30.16b, v17.16b, v20.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesd v4.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v27.16b
    aese v5.16b, v30.16b
    eor v27.16b, v26.16b, v21.16b
    eor v30.16b, v17.16b, v21.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v6.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v27.16b
    aese v7.16b, v30.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    tbl v26.16b, {v16.16b, v17.16b}, v28.16b
    tbl v27.16b, {v16.16b, v17.16b}, v29.16b
    shl v30.16b, v26.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    shl v30.16b, v27.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    sub x9, x9, #16
    ld1 {v26.16b}, [x9]
    eor v26.16b, v26.16b, v16.16b
    eor v27.16b, v26.16b, v18.16b
    eor v30.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v27.16b
    eor v1.16b, v1.16b, v30.16b
    eor v27.16b, v26.16b, v19.16b
    eor v30.16b, v17.16b, v19.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v30.16b
    eor v27.16b, v26.16b, v20.16b
    eor v30.16b, v17.16b, v20.16b
    eor v4.16b, v4.16b, v27.16b
    eor v5.16b, v5.16b, v30.16b
    eor v27.16b, v26.16b, v21.16b
    eor v30.16b, v17.16b, v21.16b
    eor v6.16b, v6.16b, v27.16b
    eor v7.16b, v7.16b, v30.16b
    zip1 v27.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v27.16b
    zip1 v27.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v27.16b
    zip1 v27.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v27.16b
    zip1 v27.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v27.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    tbl v26.16b, {v16.16b, v17.16b}, v28.16b
    tbl v27.16b, {v16.16b, v17.16b}, v29.16b
    shl v30.16b, v26.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    shl v30.16b, v27.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    sub x9, x9, #16
    ld1 {v26.16b}, [x9]
    eor v26.16b, v26.16b, v16.16b
    eor v27.16b, v26.16b, v18.16b
    eor v30.16b, v17.16b, v18.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v27.16b
    aese v1.16b, v30.16b
    eor v27.16b, v26.16b, v19.16b
    eor v30.16b, v17.16b, v19.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesd v2.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v27.16b
    aese v3.16b, v30.16b
    eor v27.16b, v26.16b, v20.16b
    eor v30.16b, v17.16b, v20.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesd v4.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v27.16b
    aese v5.16b, v30.16b
    eor v27.16b, v26.16b, v21.16b
    eor v30.16b, v17.16b, v21.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v6.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v27.16b
    aese v7.16b, v30.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    tbl v26.16b, {v16.16b, v17.16b}, v28.16b
    tbl v27.16b, {v16.16b, v17.16b}, v29.16b
    shl v30.16b, v26.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    shl v30.16b, v27.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    sub x9, x9, #16
    ld1 {v26.16b}, [x9]
    eor v26.16b, v26.16b, v16.16b
    eor v27.16b, v26.16b, v18.16b
    eor v30.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v27.16b
    eor v1.16b, v1.16b, v30.16b
    eor v27.16b, v26.16b, v19.16b
    eor v30.16b, v17.16b, v19.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v30.16b
    eor v27.16b, v26.16b, v20.16b
    eor v30.16b, v17.16b, v20.16b
    eor v4.16b, v4.16b, v27.16b
    eor v5.16b, v5.16b, v30.16b
    eor v27.16b, v26.16b, v21.16b
    eor v30.16b, v17.16b, v21.16b
    eor v6.16b, v6.16b, v27.16b
    eor v7.16b, v7.16b, v30.16b
    zip1 v27.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v27.16b
    zip1 v27.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v27.16b
    zip1 v27.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v27.16b
    zip1 v27.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v27.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    tbl v26.16b, {v16.16b, v17.16b}, v28.16b
    tbl v27.16b, {v16.16b, v17.16b}, v29.16b
    shl v30.16b, v26.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    shl v30.16b, v27.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    sub x9, x9, #16
    ld1 {v26.16b}, [x9]
    eor v26.16b, v26.16b, v16.16b
    eor v27.16b, v26.16b, v18.16b
    eor v30.16b, v17.16b, v18.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v27.16b
    aese v1.16b, v30.16b
    eor v27.16b, v26.16b, v19.16b
    eor v30.16b, v17.16b, v19.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesd v2.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v27.16b
    aese v3.16b, v30.16b
    eor v27.16b, v26.16b, v20.16b
    eor v30.16b, v17.16b, v20.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesd v4.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v27.16b
    aese v5.16b, v30.16b
    eor v27.16b, v26.16b, v21.16b
    eor v30.16b, v17.16b, v21.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v6.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v27.16b
    aese v7.16b, v30.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    tbl v26.16b, {v16.16b, v17.16b}, v28.16b
    tbl v27.16b, {v16.16b, v17.16b}, v29.16b
    shl v30.16b, v26.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    shl v30.16b, v27.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    sub x9, x9, #16
    ld1 {v26.16b}, [x9]
    eor v26.16b, v26.16b, v16.16b
    eor v27.16b, v26.16b, v18.16b
    eor v30.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v27.16b
    eor v1.16b, v1.16b, v30.16b
    eor v27.16b, v26.16b, v19.16b
    eor v30.16b, v17.16b, v19.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v30.16b
    eor v27.16b, v26.16b, v20.16b
    eor v30.16b, v17.16b, v20.16b
    eor v4.16b, v4.16b, v27.16b
    eor v5.16b, v5.16b, v30.16b
    eor v27.16b, v26.16b, v21.16b
    eor v30.16b, v17.16b, v21.16b
    eor v6.16b, v6.16b, v27.16b
    eor v7.16b, v7.16b, v30.16b
    zip1 v27.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v27.16b
    zip1 v27.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v27.16b
    zip1 v27.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v27.16b
    zip1 v27.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v27.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    tbl v26.16b, {v16.16b, v17.16b}, v28.16b
    tbl v27.16b, {v16.16b, v17.16b}, v29.16b
    shl v30.16b, v26.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    shl v30.16b, v27.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    sub x9, x9, #16
    ld1 {v26.16b}, [x9]
    eor v26.16b, v26.16b, v16.16b
    eor v27.16b, v26.16b, v18.16b
    eor v30.16b, v17.16b, v18.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v27.16b
    aese v1.16b, v30.16b
    eor v27.16b, v26.16b, v19.16b
    eor v30.16b, v17.16b, v19.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesd v2.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v27.16b
    aese v3.16b, v30.16b
    eor v27.16b, v26.16b, v20.16b
    eor v30.16b, v17.16b, v20.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesd v4.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v27.16b
    aese v5.16b, v30.16b
    eor v27.16b, v26.16b, v21.16b
    eor v30.16b, v17.16b, v21.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v6.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v27.16b
    aese v7.16b, v30.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    tbl v26.16b, {v16.16b, v17.16b}, v28.16b
    tbl v27.16b, {v16.16b, v17.16b}, v29.16b
    shl v30.16b, v26.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    shl v30.16b, v27.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    sub x9, x9, #16
    ld1 {v26.16b}, [x9]
    eor v26.16b, v26.16b, v16.16b
    eor v27.16b, v26.16b, v18.16b
    eor v30.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v27.16b
    eor v1.16b, v1.16b, v30.16b
    eor v27.16b, v26.16b, v19.16b
    eor v30.16b, v17.16b, v19.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v30.16b
    eor v27.16b, v26.16b, v20.16b
    eor v30.16b, v17.16b, v20.16b
    eor v4.16b, v4.16b, v27.16b
    eor v5.16b, v5.16b, v30.16b
    eor v27.16b, v26.16b, v21.16b
    eor v30.16b, v17.16b, v21.16b
    eor v6.16b, v6.16b, v27.16b
    eor v7.16b, v7.16b, v30.16b
    zip1 v27.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v27.16b
    zip1 v27.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v27.16b
    zip1 v27.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v27.16b
    zip1 v27.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v27.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    tbl v26.16b, {v16.16b, v17.16b}, v28.16b
    tbl v27.16b, {v16.16b, v17.16b}, v29.16b
    shl v30.16b, v26.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    shl v30.16b, v27.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    sub x9, x9, #16
    ld1 {v26.16b}, [x9]
    eor v26.16b, v26.16b, v16.16b
    eor v27.16b, v26.16b, v18.16b
    eor v30.16b, v17.16b, v18.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v27.16b
    aese v1.16b, v30.16b
    eor v27.16b, v26.16b, v19.16b
    eor v30.16b, v17.16b, v19.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesd v2.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v27.16b
    aese v3.16b, v30.16b
    eor v27.16b, v26.16b, v20.16b
    eor v30.16b, v17.16b, v20.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesd v4.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v27.16b
    aese v5.16b, v30.16b
    eor v27.16b, v26.16b, v21.16b
    eor v30.16b, v17.16b, v21.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v6.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v27.16b
    aese v7.16b, v30.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    tbl v26.16b, {v16.16b, v17.16b}, v28.16b
    tbl v27.16b, {v16.16b, v17.16b}, v29.16b
    shl v30.16b, v26.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    shl v30.16b, v27.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    sub x9, x9, #16
    ld1 {v26.16b}, [x9]
    eor v26.16b, v26.16b, v16.16b
    eor v27.16b, v26.16b, v18.16b
    eor v30.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v27.16b
    eor v1.16b, v1.16b, v30.16b
    eor v27.16b, v26.16b, v19.16b
    eor v30.16b, v17.16b, v19.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v30.16b
    eor v27.16b, v26.16b, v20.16b
    eor v30.16b, v17.16b, v20.16b
    eor v4.16b, v4.16b, v27.16b
    eor v5.16b, v5.16b, v30.16b
    eor v27.16b, v26.16b, v21.16b
    eor v30.16b, v17.16b, v21.16b
    eor v6.16b, v6.16b, v27.16b
    eor v7.16b, v7.16b, v30.16b
    zip1 v27.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v27.16b
    zip1 v27.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v27.16b
    zip1 v27.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v27.16b
    zip1 v27.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v27.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    tbl v26.16b, {v16.16b, v17.16b}, v28.16b
    tbl v27.16b, {v16.16b, v17.16b}, v29.16b
    shl v30.16b, v26.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    shl v30.16b, v27.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    sub x9, x9, #16
    ld1 {v26.16b}, [x9]
    eor v26.16b, v26.16b, v16.16b
    eor v27.16b, v26.16b, v18.16b
    eor v30.16b, v17.16b, v18.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v27.16b
    aese v1.16b, v30.16b
    eor v27.16b, v26.16b, v19.16b
    eor v30.16b, v17.16b, v19.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesd v2.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v27.16b
    aese v3.16b, v30.16b
    eor v27.16b, v26.16b, v20.16b
    eor v30.16b, v17.16b, v20.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesd v4.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v27.16b
    aese v5.16b, v30.16b
    eor v27.16b, v26.16b, v21.16b
    eor v30.16b, v17.16b, v21.16b
    aesmc v27.16b, v27.16b
    aesmc v30.16b, v30.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v6.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v27.16b
    aese v7.16b, v30.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    tbl v26.16b, {v16.16b, v17.16b}, v28.16b
    tbl v27.16b, {v16.16b, v17.16b}, v29.16b
    shl v30.16b, v26.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v16.16b, v26.16b, #1
    eor v16.16b, v16.16b, v30.16b
    shl v30.16b, v27.16b, #7
    sshr v30.16b, v30.16b, #7
    and v30.16b, v30.16b, v25.16b
    ushr v17.16b, v27.16b, #1
    eor v17.16b, v17.16b, v30.16b
    sub x9, x9, #16
    ld1 {v26.16b}, [x9]
    eor v26.16b, v26.16b, v16.16b
    eor v27.16b, v26.16b, v18.16b
    eor v30.16b, v17.16b, v18.16b
    eor v0.16b, v0.16b, v27.16b
    eor v1.16b, v1.16b, v30.16b
    eor v27.16b, v26.16b, v19.16b
    eor v30.16b, v17.16b, v19.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v30.16b
    eor v27.16b, v26.16b, v20.16b
    eor v30.16b, v17.16b, v20.16b
    eor v4.16b, v4.16b, v27.16b
    eor v5.16b, v5.16b, v30.16b
    eor v27.16b, v26.16b, v21.16b
    eor v30.16b, v17.16b, v21.16b
    eor v6.16b, v6.16b, v27.16b
    eor v7.16b, v7.16b, v30.16b
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

    EXPORT areion_asura_expand_key_asm
areion_asura_expand_key_asm PROC
    hint #34 ; bti c
    ld1 {v0.16b, v1.16b}, [x1]
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
    eor v16.16b, v0.16b, v7.16b
    mov v17.16b, v1.16b
    st1 {v16.16b, v17.16b}, [x0], #32
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
    eor v16.16b, v0.16b, v7.16b
    mov v17.16b, v1.16b
    st1 {v16.16b, v17.16b}, [x0], #32
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
    eor v16.16b, v0.16b, v7.16b
    mov v17.16b, v1.16b
    st1 {v16.16b, v17.16b}, [x0], #32
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
    eor v16.16b, v0.16b, v7.16b
    mov v17.16b, v1.16b
    st1 {v16.16b, v17.16b}, [x0], #32
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
    eor v16.16b, v0.16b, v7.16b
    mov v17.16b, v1.16b
    st1 {v16.16b, v17.16b}, [x0], #32
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
    eor v16.16b, v0.16b, v7.16b
    mov v17.16b, v1.16b
    st1 {v16.16b, v17.16b}, [x0], #32
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
    eor v16.16b, v0.16b, v7.16b
    mov v17.16b, v1.16b
    st1 {v16.16b, v17.16b}, [x0], #32
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
    eor v16.16b, v0.16b, v7.16b
    mov v17.16b, v1.16b
    st1 {v16.16b, v17.16b}, [x0], #32
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
    eor v16.16b, v0.16b, v7.16b
    mov v17.16b, v1.16b
    st1 {v16.16b, v17.16b}, [x0], #32
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
    eor v16.16b, v0.16b, v7.16b
    mov v17.16b, v1.16b
    st1 {v16.16b, v17.16b}, [x0], #32
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
    eor v16.16b, v0.16b, v7.16b
    mov v17.16b, v1.16b
    st1 {v16.16b, v17.16b}, [x0], #32
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
    eor v16.16b, v0.16b, v7.16b
    mov v17.16b, v1.16b
    st1 {v16.16b, v17.16b}, [x0], #32
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
    eor v16.16b, v0.16b, v7.16b
    mov v17.16b, v1.16b
    st1 {v16.16b, v17.16b}, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
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
    mov x9, xzr
    mov x10, xzr
    ret
    ENDP

    EXPORT areion_asura_encrypt_block_rk_asm
areion_asura_encrypt_block_rk_asm PROC
    hint #34 ; bti c
    ld1 {v0.16b, v1.16b}, [x1]
    ld1 {v16.16b}, [x3]
    eor v17.16b, v17.16b, v17.16b
    ld1 {v2.16b, v3.16b, v4.16b, v5.16b}, [x2], #64
    eor v2.16b, v2.16b, v16.16b
    eor v3.16b, v3.16b, v16.16b
    aese v16.16b, v17.16b
    aesmc v16.16b, v16.16b
    eor v4.16b, v4.16b, v16.16b
    eor v5.16b, v5.16b, v16.16b
    aese v16.16b, v17.16b
    aesmc v16.16b, v16.16b
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
    eor v2.16b, v2.16b, v16.16b
    eor v3.16b, v3.16b, v16.16b
    aese v16.16b, v17.16b
    aesmc v16.16b, v16.16b
    eor v4.16b, v4.16b, v16.16b
    eor v5.16b, v5.16b, v16.16b
    aese v16.16b, v17.16b
    aesmc v16.16b, v16.16b
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
    eor v2.16b, v2.16b, v16.16b
    eor v3.16b, v3.16b, v16.16b
    aese v16.16b, v17.16b
    aesmc v16.16b, v16.16b
    eor v4.16b, v4.16b, v16.16b
    eor v5.16b, v5.16b, v16.16b
    aese v16.16b, v17.16b
    aesmc v16.16b, v16.16b
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
    eor v2.16b, v2.16b, v16.16b
    eor v3.16b, v3.16b, v16.16b
    aese v16.16b, v17.16b
    aesmc v16.16b, v16.16b
    eor v4.16b, v4.16b, v16.16b
    eor v5.16b, v5.16b, v16.16b
    aese v16.16b, v17.16b
    aesmc v16.16b, v16.16b
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
    eor v2.16b, v2.16b, v16.16b
    eor v3.16b, v3.16b, v16.16b
    aese v16.16b, v17.16b
    aesmc v16.16b, v16.16b
    eor v4.16b, v4.16b, v16.16b
    eor v5.16b, v5.16b, v16.16b
    aese v16.16b, v17.16b
    aesmc v16.16b, v16.16b
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
    eor v2.16b, v2.16b, v16.16b
    eor v3.16b, v3.16b, v16.16b
    aese v16.16b, v17.16b
    aesmc v16.16b, v16.16b
    eor v4.16b, v4.16b, v16.16b
    eor v5.16b, v5.16b, v16.16b
    aese v16.16b, v17.16b
    aesmc v16.16b, v16.16b
    aesd v0.16b, v2.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v3.16b
    aesimc v1.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v5.16b
    aesimc v1.16b, v1.16b
    ld1 {v2.16b, v3.16b}, [x2]
    eor v2.16b, v2.16b, v16.16b
    eor v3.16b, v3.16b, v16.16b
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
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    ret
    ENDP

    EXPORT areion_asura_decrypt_block_rk_asm
areion_asura_decrypt_block_rk_asm PROC
    hint #34 ; bti c
    ld1 {v0.16b, v1.16b}, [x1]
    eor v2.16b, v2.16b, v2.16b
    ld1 {v16.16b}, [x3]
    mov v17.16b, v16.16b
    aese v17.16b, v2.16b
    aesmc v17.16b, v17.16b
    mov v18.16b, v17.16b
    aese v18.16b, v2.16b
    aesmc v18.16b, v18.16b
    mov v19.16b, v18.16b
    aese v19.16b, v2.16b
    aesmc v19.16b, v19.16b
    mov v20.16b, v19.16b
    aese v20.16b, v2.16b
    aesmc v20.16b, v20.16b
    mov v21.16b, v20.16b
    aese v21.16b, v2.16b
    aesmc v21.16b, v21.16b
    mov v22.16b, v21.16b
    aese v22.16b, v2.16b
    aesmc v22.16b, v22.16b
    mov v23.16b, v22.16b
    aese v23.16b, v2.16b
    aesmc v23.16b, v23.16b
    mov v24.16b, v23.16b
    aese v24.16b, v2.16b
    aesmc v24.16b, v24.16b
    mov v25.16b, v24.16b
    aese v25.16b, v2.16b
    aesmc v25.16b, v25.16b
    mov v26.16b, v25.16b
    aese v26.16b, v2.16b
    aesmc v26.16b, v26.16b
    mov v27.16b, v26.16b
    aese v27.16b, v2.16b
    aesmc v27.16b, v27.16b
    mov v28.16b, v27.16b
    aese v28.16b, v2.16b
    aesmc v28.16b, v28.16b
    add x2, x2, #384
    ld1 {v3.16b, v4.16b}, [x2]
    eor v3.16b, v3.16b, v28.16b
    eor v4.16b, v4.16b, v28.16b
    eor v0.16b, v0.16b, v3.16b
    eor v1.16b, v1.16b, v4.16b
    sub x2, x2, #64
    ld1 {v3.16b, v4.16b, v5.16b, v6.16b}, [x2]
    eor v3.16b, v3.16b, v26.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v27.16b
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
    eor v3.16b, v3.16b, v24.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v25.16b
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
    eor v3.16b, v3.16b, v22.16b
    eor v4.16b, v4.16b, v22.16b
    eor v5.16b, v5.16b, v23.16b
    eor v6.16b, v6.16b, v23.16b
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
    eor v3.16b, v3.16b, v20.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v21.16b
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
    eor v3.16b, v3.16b, v18.16b
    eor v4.16b, v4.16b, v18.16b
    eor v5.16b, v5.16b, v19.16b
    eor v6.16b, v6.16b, v19.16b
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
    eor v3.16b, v3.16b, v16.16b
    eor v4.16b, v4.16b, v16.16b
    eor v5.16b, v5.16b, v17.16b
    eor v6.16b, v6.16b, v17.16b
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
    ret
    ENDP

    EXPORT areion_asura_encrypt_4blocks_rk_asm
areion_asura_encrypt_4blocks_rk_asm PROC
    hint #34 ; bti c
    ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x1], #64
    ld1 {v4.16b, v5.16b, v6.16b, v7.16b}, [x1]
    ld1 {v21.16b, v22.16b, v23.16b, v24.16b}, [x3]
    eor v25.16b, v25.16b, v25.16b
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2], #64
    eor v26.16b, v16.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aesd v0.16b, v26.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    aese v21.16b, v25.16b
    aesmc v21.16b, v21.16b
    eor v26.16b, v16.16b, v22.16b
    eor v27.16b, v17.16b, v22.16b
    aesd v2.16b, v26.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    aese v22.16b, v25.16b
    aesmc v22.16b, v22.16b
    eor v26.16b, v16.16b, v23.16b
    eor v27.16b, v17.16b, v23.16b
    aesd v4.16b, v26.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    aese v23.16b, v25.16b
    aesmc v23.16b, v23.16b
    eor v26.16b, v16.16b, v24.16b
    eor v27.16b, v17.16b, v24.16b
    aesd v6.16b, v26.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    aese v24.16b, v25.16b
    aesmc v24.16b, v24.16b
    eor v26.16b, v18.16b, v21.16b
    eor v27.16b, v19.16b, v21.16b
    aese v0.16b, v26.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    uzp1 v20.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v20.16b
    aese v21.16b, v25.16b
    aesmc v21.16b, v21.16b
    eor v26.16b, v18.16b, v22.16b
    eor v27.16b, v19.16b, v22.16b
    aese v2.16b, v26.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    uzp1 v20.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v20.16b
    aese v22.16b, v25.16b
    aesmc v22.16b, v22.16b
    eor v26.16b, v18.16b, v23.16b
    eor v27.16b, v19.16b, v23.16b
    aese v4.16b, v26.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    uzp1 v20.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v20.16b
    aese v23.16b, v25.16b
    aesmc v23.16b, v23.16b
    eor v26.16b, v18.16b, v24.16b
    eor v27.16b, v19.16b, v24.16b
    aese v6.16b, v26.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    uzp1 v20.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v20.16b
    aese v24.16b, v25.16b
    aesmc v24.16b, v24.16b
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2], #64
    eor v26.16b, v16.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aesd v0.16b, v26.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    aese v21.16b, v25.16b
    aesmc v21.16b, v21.16b
    eor v26.16b, v16.16b, v22.16b
    eor v27.16b, v17.16b, v22.16b
    aesd v2.16b, v26.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    aese v22.16b, v25.16b
    aesmc v22.16b, v22.16b
    eor v26.16b, v16.16b, v23.16b
    eor v27.16b, v17.16b, v23.16b
    aesd v4.16b, v26.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    aese v23.16b, v25.16b
    aesmc v23.16b, v23.16b
    eor v26.16b, v16.16b, v24.16b
    eor v27.16b, v17.16b, v24.16b
    aesd v6.16b, v26.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    aese v24.16b, v25.16b
    aesmc v24.16b, v24.16b
    eor v26.16b, v18.16b, v21.16b
    eor v27.16b, v19.16b, v21.16b
    aese v0.16b, v26.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    uzp1 v20.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v20.16b
    aese v21.16b, v25.16b
    aesmc v21.16b, v21.16b
    eor v26.16b, v18.16b, v22.16b
    eor v27.16b, v19.16b, v22.16b
    aese v2.16b, v26.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    uzp1 v20.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v20.16b
    aese v22.16b, v25.16b
    aesmc v22.16b, v22.16b
    eor v26.16b, v18.16b, v23.16b
    eor v27.16b, v19.16b, v23.16b
    aese v4.16b, v26.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    uzp1 v20.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v20.16b
    aese v23.16b, v25.16b
    aesmc v23.16b, v23.16b
    eor v26.16b, v18.16b, v24.16b
    eor v27.16b, v19.16b, v24.16b
    aese v6.16b, v26.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    uzp1 v20.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v20.16b
    aese v24.16b, v25.16b
    aesmc v24.16b, v24.16b
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2], #64
    eor v26.16b, v16.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aesd v0.16b, v26.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    aese v21.16b, v25.16b
    aesmc v21.16b, v21.16b
    eor v26.16b, v16.16b, v22.16b
    eor v27.16b, v17.16b, v22.16b
    aesd v2.16b, v26.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    aese v22.16b, v25.16b
    aesmc v22.16b, v22.16b
    eor v26.16b, v16.16b, v23.16b
    eor v27.16b, v17.16b, v23.16b
    aesd v4.16b, v26.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    aese v23.16b, v25.16b
    aesmc v23.16b, v23.16b
    eor v26.16b, v16.16b, v24.16b
    eor v27.16b, v17.16b, v24.16b
    aesd v6.16b, v26.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    aese v24.16b, v25.16b
    aesmc v24.16b, v24.16b
    eor v26.16b, v18.16b, v21.16b
    eor v27.16b, v19.16b, v21.16b
    aese v0.16b, v26.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    uzp1 v20.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v20.16b
    aese v21.16b, v25.16b
    aesmc v21.16b, v21.16b
    eor v26.16b, v18.16b, v22.16b
    eor v27.16b, v19.16b, v22.16b
    aese v2.16b, v26.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    uzp1 v20.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v20.16b
    aese v22.16b, v25.16b
    aesmc v22.16b, v22.16b
    eor v26.16b, v18.16b, v23.16b
    eor v27.16b, v19.16b, v23.16b
    aese v4.16b, v26.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    uzp1 v20.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v20.16b
    aese v23.16b, v25.16b
    aesmc v23.16b, v23.16b
    eor v26.16b, v18.16b, v24.16b
    eor v27.16b, v19.16b, v24.16b
    aese v6.16b, v26.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    uzp1 v20.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v20.16b
    aese v24.16b, v25.16b
    aesmc v24.16b, v24.16b
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2], #64
    eor v26.16b, v16.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aesd v0.16b, v26.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    aese v21.16b, v25.16b
    aesmc v21.16b, v21.16b
    eor v26.16b, v16.16b, v22.16b
    eor v27.16b, v17.16b, v22.16b
    aesd v2.16b, v26.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    aese v22.16b, v25.16b
    aesmc v22.16b, v22.16b
    eor v26.16b, v16.16b, v23.16b
    eor v27.16b, v17.16b, v23.16b
    aesd v4.16b, v26.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    aese v23.16b, v25.16b
    aesmc v23.16b, v23.16b
    eor v26.16b, v16.16b, v24.16b
    eor v27.16b, v17.16b, v24.16b
    aesd v6.16b, v26.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    aese v24.16b, v25.16b
    aesmc v24.16b, v24.16b
    eor v26.16b, v18.16b, v21.16b
    eor v27.16b, v19.16b, v21.16b
    aese v0.16b, v26.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    uzp1 v20.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v20.16b
    aese v21.16b, v25.16b
    aesmc v21.16b, v21.16b
    eor v26.16b, v18.16b, v22.16b
    eor v27.16b, v19.16b, v22.16b
    aese v2.16b, v26.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    uzp1 v20.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v20.16b
    aese v22.16b, v25.16b
    aesmc v22.16b, v22.16b
    eor v26.16b, v18.16b, v23.16b
    eor v27.16b, v19.16b, v23.16b
    aese v4.16b, v26.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    uzp1 v20.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v20.16b
    aese v23.16b, v25.16b
    aesmc v23.16b, v23.16b
    eor v26.16b, v18.16b, v24.16b
    eor v27.16b, v19.16b, v24.16b
    aese v6.16b, v26.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    uzp1 v20.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v20.16b
    aese v24.16b, v25.16b
    aesmc v24.16b, v24.16b
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2], #64
    eor v26.16b, v16.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aesd v0.16b, v26.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    aese v21.16b, v25.16b
    aesmc v21.16b, v21.16b
    eor v26.16b, v16.16b, v22.16b
    eor v27.16b, v17.16b, v22.16b
    aesd v2.16b, v26.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    aese v22.16b, v25.16b
    aesmc v22.16b, v22.16b
    eor v26.16b, v16.16b, v23.16b
    eor v27.16b, v17.16b, v23.16b
    aesd v4.16b, v26.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    aese v23.16b, v25.16b
    aesmc v23.16b, v23.16b
    eor v26.16b, v16.16b, v24.16b
    eor v27.16b, v17.16b, v24.16b
    aesd v6.16b, v26.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    aese v24.16b, v25.16b
    aesmc v24.16b, v24.16b
    eor v26.16b, v18.16b, v21.16b
    eor v27.16b, v19.16b, v21.16b
    aese v0.16b, v26.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    uzp1 v20.16b, v0.16b, v1.16b
    uzp2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v20.16b
    aese v21.16b, v25.16b
    aesmc v21.16b, v21.16b
    eor v26.16b, v18.16b, v22.16b
    eor v27.16b, v19.16b, v22.16b
    aese v2.16b, v26.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    uzp1 v20.16b, v2.16b, v3.16b
    uzp2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v20.16b
    aese v22.16b, v25.16b
    aesmc v22.16b, v22.16b
    eor v26.16b, v18.16b, v23.16b
    eor v27.16b, v19.16b, v23.16b
    aese v4.16b, v26.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    uzp1 v20.16b, v4.16b, v5.16b
    uzp2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v20.16b
    aese v23.16b, v25.16b
    aesmc v23.16b, v23.16b
    eor v26.16b, v18.16b, v24.16b
    eor v27.16b, v19.16b, v24.16b
    aese v6.16b, v26.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    uzp1 v20.16b, v6.16b, v7.16b
    uzp2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v20.16b
    aese v24.16b, v25.16b
    aesmc v24.16b, v24.16b
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2], #64
    eor v26.16b, v16.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    aesd v0.16b, v26.16b
    aesimc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    aese v21.16b, v25.16b
    aesmc v21.16b, v21.16b
    eor v26.16b, v16.16b, v22.16b
    eor v27.16b, v17.16b, v22.16b
    aesd v2.16b, v26.16b
    aesimc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    aese v22.16b, v25.16b
    aesmc v22.16b, v22.16b
    eor v26.16b, v16.16b, v23.16b
    eor v27.16b, v17.16b, v23.16b
    aesd v4.16b, v26.16b
    aesimc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    aese v23.16b, v25.16b
    aesmc v23.16b, v23.16b
    eor v26.16b, v16.16b, v24.16b
    eor v27.16b, v17.16b, v24.16b
    aesd v6.16b, v26.16b
    aesimc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    aese v24.16b, v25.16b
    aesmc v24.16b, v24.16b
    eor v26.16b, v18.16b, v21.16b
    eor v27.16b, v19.16b, v21.16b
    aese v0.16b, v26.16b
    aesmc v0.16b, v0.16b
    aesd v1.16b, v27.16b
    aesimc v1.16b, v1.16b
    aese v21.16b, v25.16b
    aesmc v21.16b, v21.16b
    eor v26.16b, v18.16b, v22.16b
    eor v27.16b, v19.16b, v22.16b
    aese v2.16b, v26.16b
    aesmc v2.16b, v2.16b
    aesd v3.16b, v27.16b
    aesimc v3.16b, v3.16b
    aese v22.16b, v25.16b
    aesmc v22.16b, v22.16b
    eor v26.16b, v18.16b, v23.16b
    eor v27.16b, v19.16b, v23.16b
    aese v4.16b, v26.16b
    aesmc v4.16b, v4.16b
    aesd v5.16b, v27.16b
    aesimc v5.16b, v5.16b
    aese v23.16b, v25.16b
    aesmc v23.16b, v23.16b
    eor v26.16b, v18.16b, v24.16b
    eor v27.16b, v19.16b, v24.16b
    aese v6.16b, v26.16b
    aesmc v6.16b, v6.16b
    aesd v7.16b, v27.16b
    aesimc v7.16b, v7.16b
    aese v24.16b, v25.16b
    aesmc v24.16b, v24.16b
    ld1 {v16.16b, v17.16b}, [x2]
    eor v26.16b, v16.16b, v21.16b
    eor v27.16b, v17.16b, v21.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    eor v26.16b, v16.16b, v22.16b
    eor v27.16b, v17.16b, v22.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    eor v26.16b, v16.16b, v23.16b
    eor v27.16b, v17.16b, v23.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v26.16b, v16.16b, v24.16b
    eor v27.16b, v17.16b, v24.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
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
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    ret
    ENDP

    EXPORT areion_asura_decrypt_4blocks_rk_asm
areion_asura_decrypt_4blocks_rk_asm PROC
    hint #34 ; bti c
    ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x1], #64
    ld1 {v4.16b, v5.16b, v6.16b, v7.16b}, [x1]
    ld1 {v20.16b, v21.16b, v22.16b, v23.16b}, [x3]
    eor v31.16b, v31.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    aese v22.16b, v31.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v31.16b
    aesmc v23.16b, v23.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    aese v22.16b, v31.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v31.16b
    aesmc v23.16b, v23.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    aese v22.16b, v31.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v31.16b
    aesmc v23.16b, v23.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    aese v22.16b, v31.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v31.16b
    aesmc v23.16b, v23.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    aese v22.16b, v31.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v31.16b
    aesmc v23.16b, v23.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    aese v22.16b, v31.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v31.16b
    aesmc v23.16b, v23.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    aese v22.16b, v31.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v31.16b
    aesmc v23.16b, v23.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    aese v22.16b, v31.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v31.16b
    aesmc v23.16b, v23.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    aese v22.16b, v31.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v31.16b
    aesmc v23.16b, v23.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    aese v22.16b, v31.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v31.16b
    aesmc v23.16b, v23.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    aese v22.16b, v31.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v31.16b
    aesmc v23.16b, v23.16b
    aese v20.16b, v31.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v31.16b
    aesmc v21.16b, v21.16b
    aese v22.16b, v31.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v31.16b
    aesmc v23.16b, v23.16b
    add x2, x2, #384
    ld1 {v16.16b, v17.16b}, [x2]
    eor v24.16b, v16.16b, v20.16b
    eor v25.16b, v17.16b, v20.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v24.16b, v16.16b, v21.16b
    eor v25.16b, v17.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v24.16b, v16.16b, v22.16b
    eor v25.16b, v17.16b, v22.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v24.16b, v16.16b, v23.16b
    eor v25.16b, v17.16b, v23.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    sub x2, x2, #64
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2]
    eor v24.16b, v18.16b, v20.16b
    eor v25.16b, v19.16b, v20.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v24.16b
    aese v1.16b, v25.16b
    eor v24.16b, v18.16b, v21.16b
    eor v25.16b, v19.16b, v21.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesd v2.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v24.16b
    aese v3.16b, v25.16b
    eor v24.16b, v18.16b, v22.16b
    eor v25.16b, v19.16b, v22.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesd v4.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v24.16b
    aese v5.16b, v25.16b
    eor v24.16b, v18.16b, v23.16b
    eor v25.16b, v19.16b, v23.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v6.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v24.16b
    aese v7.16b, v25.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v16.16b, v20.16b
    eor v25.16b, v17.16b, v20.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v24.16b, v16.16b, v21.16b
    eor v25.16b, v17.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v24.16b, v16.16b, v22.16b
    eor v25.16b, v17.16b, v22.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v24.16b, v16.16b, v23.16b
    eor v25.16b, v17.16b, v23.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    zip1 v24.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v24.16b
    zip1 v24.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v24.16b
    zip1 v24.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v24.16b
    zip1 v24.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v24.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    sub x2, x2, #64
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2]
    eor v24.16b, v18.16b, v20.16b
    eor v25.16b, v19.16b, v20.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v24.16b
    aese v1.16b, v25.16b
    eor v24.16b, v18.16b, v21.16b
    eor v25.16b, v19.16b, v21.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesd v2.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v24.16b
    aese v3.16b, v25.16b
    eor v24.16b, v18.16b, v22.16b
    eor v25.16b, v19.16b, v22.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesd v4.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v24.16b
    aese v5.16b, v25.16b
    eor v24.16b, v18.16b, v23.16b
    eor v25.16b, v19.16b, v23.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v6.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v24.16b
    aese v7.16b, v25.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v16.16b, v20.16b
    eor v25.16b, v17.16b, v20.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v24.16b, v16.16b, v21.16b
    eor v25.16b, v17.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v24.16b, v16.16b, v22.16b
    eor v25.16b, v17.16b, v22.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v24.16b, v16.16b, v23.16b
    eor v25.16b, v17.16b, v23.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    zip1 v24.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v24.16b
    zip1 v24.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v24.16b
    zip1 v24.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v24.16b
    zip1 v24.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v24.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    sub x2, x2, #64
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2]
    eor v24.16b, v18.16b, v20.16b
    eor v25.16b, v19.16b, v20.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v24.16b
    aese v1.16b, v25.16b
    eor v24.16b, v18.16b, v21.16b
    eor v25.16b, v19.16b, v21.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesd v2.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v24.16b
    aese v3.16b, v25.16b
    eor v24.16b, v18.16b, v22.16b
    eor v25.16b, v19.16b, v22.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesd v4.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v24.16b
    aese v5.16b, v25.16b
    eor v24.16b, v18.16b, v23.16b
    eor v25.16b, v19.16b, v23.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v6.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v24.16b
    aese v7.16b, v25.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v16.16b, v20.16b
    eor v25.16b, v17.16b, v20.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v24.16b, v16.16b, v21.16b
    eor v25.16b, v17.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v24.16b, v16.16b, v22.16b
    eor v25.16b, v17.16b, v22.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v24.16b, v16.16b, v23.16b
    eor v25.16b, v17.16b, v23.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    zip1 v24.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v24.16b
    zip1 v24.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v24.16b
    zip1 v24.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v24.16b
    zip1 v24.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v24.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    sub x2, x2, #64
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2]
    eor v24.16b, v18.16b, v20.16b
    eor v25.16b, v19.16b, v20.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v24.16b
    aese v1.16b, v25.16b
    eor v24.16b, v18.16b, v21.16b
    eor v25.16b, v19.16b, v21.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesd v2.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v24.16b
    aese v3.16b, v25.16b
    eor v24.16b, v18.16b, v22.16b
    eor v25.16b, v19.16b, v22.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesd v4.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v24.16b
    aese v5.16b, v25.16b
    eor v24.16b, v18.16b, v23.16b
    eor v25.16b, v19.16b, v23.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v6.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v24.16b
    aese v7.16b, v25.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v16.16b, v20.16b
    eor v25.16b, v17.16b, v20.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v24.16b, v16.16b, v21.16b
    eor v25.16b, v17.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v24.16b, v16.16b, v22.16b
    eor v25.16b, v17.16b, v22.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v24.16b, v16.16b, v23.16b
    eor v25.16b, v17.16b, v23.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    zip1 v24.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v24.16b
    zip1 v24.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v24.16b
    zip1 v24.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v24.16b
    zip1 v24.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v24.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    sub x2, x2, #64
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2]
    eor v24.16b, v18.16b, v20.16b
    eor v25.16b, v19.16b, v20.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v24.16b
    aese v1.16b, v25.16b
    eor v24.16b, v18.16b, v21.16b
    eor v25.16b, v19.16b, v21.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesd v2.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v24.16b
    aese v3.16b, v25.16b
    eor v24.16b, v18.16b, v22.16b
    eor v25.16b, v19.16b, v22.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesd v4.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v24.16b
    aese v5.16b, v25.16b
    eor v24.16b, v18.16b, v23.16b
    eor v25.16b, v19.16b, v23.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v6.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v24.16b
    aese v7.16b, v25.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v16.16b, v20.16b
    eor v25.16b, v17.16b, v20.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v24.16b, v16.16b, v21.16b
    eor v25.16b, v17.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v24.16b, v16.16b, v22.16b
    eor v25.16b, v17.16b, v22.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v24.16b, v16.16b, v23.16b
    eor v25.16b, v17.16b, v23.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    zip1 v24.16b, v0.16b, v1.16b
    zip2 v1.16b, v0.16b, v1.16b
    mov v0.16b, v24.16b
    zip1 v24.16b, v2.16b, v3.16b
    zip2 v3.16b, v2.16b, v3.16b
    mov v2.16b, v24.16b
    zip1 v24.16b, v4.16b, v5.16b
    zip2 v5.16b, v4.16b, v5.16b
    mov v4.16b, v24.16b
    zip1 v24.16b, v6.16b, v7.16b
    zip2 v7.16b, v6.16b, v7.16b
    mov v6.16b, v24.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    sub x2, x2, #64
    ld1 {v16.16b, v17.16b, v18.16b, v19.16b}, [x2]
    eor v24.16b, v18.16b, v20.16b
    eor v25.16b, v19.16b, v20.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesd v0.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aese v0.16b, v24.16b
    aese v1.16b, v25.16b
    eor v24.16b, v18.16b, v21.16b
    eor v25.16b, v19.16b, v21.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aesd v2.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    aese v2.16b, v24.16b
    aese v3.16b, v25.16b
    eor v24.16b, v18.16b, v22.16b
    eor v25.16b, v19.16b, v22.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aesd v4.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    aese v4.16b, v24.16b
    aese v5.16b, v25.16b
    eor v24.16b, v18.16b, v23.16b
    eor v25.16b, v19.16b, v23.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesimc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aesd v6.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v6.16b, v6.16b
    aesmc v7.16b, v7.16b
    aese v6.16b, v24.16b
    aese v7.16b, v25.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v16.16b, v20.16b
    eor v25.16b, v17.16b, v20.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v24.16b, v16.16b, v21.16b
    eor v25.16b, v17.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v24.16b, v16.16b, v22.16b
    eor v25.16b, v17.16b, v22.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v24.16b, v16.16b, v23.16b
    eor v25.16b, v17.16b, v23.16b
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
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    ret
    ENDP

    END
