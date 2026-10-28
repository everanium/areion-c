; Copyright (c) 2026 Andrey Kuvshinov
; SPDX-License-Identifier: Apache-2.0 OR MIT

    AREA |.text|, CODE, READONLY, ALIGN=4
    IMPORT roundConstantsP1
    IMPORT roundConstantsP2
    IMPORT rijndael256Consts
    IMPORT vistrutahRoundConstants
    IMPORT vistrutahConsts

    EXPORT aesRoundAsm
aesRoundAsm PROC
    hint #34 ; bti c
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
    ENDP

    EXPORT aesFinalRoundAsm
aesFinalRoundAsm PROC
    hint #34 ; bti c
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
    ENDP

    EXPORT aesRound4Asm
aesRound4Asm PROC
    hint #34 ; bti c
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
    ENDP

    EXPORT aesFinalRound4Asm
aesFinalRound4Asm PROC
    hint #34 ; bti c
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
    ENDP

    EXPORT aes128EncryptBlockAsm
aes128EncryptBlockAsm PROC
    hint #34 ; bti c
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
    ENDP

    EXPORT aes128Encrypt4BlocksAsm
aes128Encrypt4BlocksAsm PROC
    hint #34 ; bti c
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
    ENDP

    EXPORT rijndael256EncryptBlockAsm
rijndael256EncryptBlockAsm PROC
    hint #34 ; bti c
    adrp x3, rijndael256Consts
    add x3, x3, rijndael256Consts
    add x3, x3, #32
    ld1 { v6.16b, v7.16b }, [x3]
    eor v16.16b, v16.16b, v16.16b
    ld1 { v0.16b, v1.16b }, [x2]
    ld1 { v4.16b, v5.16b }, [x0], #32
    eor v0.16b, v0.16b, v4.16b
    eor v1.16b, v1.16b, v5.16b
    ld1 { v4.16b, v5.16b }, [x0], #32
    tbl v2.16b, { v0.16b, v1.16b }, v6.16b
    tbl v3.16b, { v0.16b, v1.16b }, v7.16b
    aese v2.16b, v16.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v2.16b, v2.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v4.16b, v5.16b }, [x0], #32
    tbl v0.16b, { v2.16b, v3.16b }, v6.16b
    tbl v1.16b, { v2.16b, v3.16b }, v7.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v16.16b
    aesmc v1.16b, v1.16b
    eor v0.16b, v0.16b, v4.16b
    eor v1.16b, v1.16b, v5.16b
    ld1 { v4.16b, v5.16b }, [x0], #32
    tbl v2.16b, { v0.16b, v1.16b }, v6.16b
    tbl v3.16b, { v0.16b, v1.16b }, v7.16b
    aese v2.16b, v16.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v2.16b, v2.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v4.16b, v5.16b }, [x0], #32
    tbl v0.16b, { v2.16b, v3.16b }, v6.16b
    tbl v1.16b, { v2.16b, v3.16b }, v7.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v16.16b
    aesmc v1.16b, v1.16b
    eor v0.16b, v0.16b, v4.16b
    eor v1.16b, v1.16b, v5.16b
    ld1 { v4.16b, v5.16b }, [x0], #32
    tbl v2.16b, { v0.16b, v1.16b }, v6.16b
    tbl v3.16b, { v0.16b, v1.16b }, v7.16b
    aese v2.16b, v16.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v2.16b, v2.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v4.16b, v5.16b }, [x0], #32
    tbl v0.16b, { v2.16b, v3.16b }, v6.16b
    tbl v1.16b, { v2.16b, v3.16b }, v7.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v16.16b
    aesmc v1.16b, v1.16b
    eor v0.16b, v0.16b, v4.16b
    eor v1.16b, v1.16b, v5.16b
    ld1 { v4.16b, v5.16b }, [x0], #32
    tbl v2.16b, { v0.16b, v1.16b }, v6.16b
    tbl v3.16b, { v0.16b, v1.16b }, v7.16b
    aese v2.16b, v16.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v2.16b, v2.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v4.16b, v5.16b }, [x0], #32
    tbl v0.16b, { v2.16b, v3.16b }, v6.16b
    tbl v1.16b, { v2.16b, v3.16b }, v7.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v16.16b
    aesmc v1.16b, v1.16b
    eor v0.16b, v0.16b, v4.16b
    eor v1.16b, v1.16b, v5.16b
    ld1 { v4.16b, v5.16b }, [x0], #32
    tbl v2.16b, { v0.16b, v1.16b }, v6.16b
    tbl v3.16b, { v0.16b, v1.16b }, v7.16b
    aese v2.16b, v16.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v2.16b, v2.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v4.16b, v5.16b }, [x0], #32
    tbl v0.16b, { v2.16b, v3.16b }, v6.16b
    tbl v1.16b, { v2.16b, v3.16b }, v7.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v16.16b
    aesmc v1.16b, v1.16b
    eor v0.16b, v0.16b, v4.16b
    eor v1.16b, v1.16b, v5.16b
    ld1 { v4.16b, v5.16b }, [x0], #32
    tbl v2.16b, { v0.16b, v1.16b }, v6.16b
    tbl v3.16b, { v0.16b, v1.16b }, v7.16b
    aese v2.16b, v16.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v2.16b, v2.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v4.16b, v5.16b }, [x0], #32
    tbl v0.16b, { v2.16b, v3.16b }, v6.16b
    tbl v1.16b, { v2.16b, v3.16b }, v7.16b
    aese v0.16b, v16.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v16.16b
    aesmc v1.16b, v1.16b
    eor v0.16b, v0.16b, v4.16b
    eor v1.16b, v1.16b, v5.16b
    ld1 { v4.16b, v5.16b }, [x0], #32
    tbl v2.16b, { v0.16b, v1.16b }, v6.16b
    tbl v3.16b, { v0.16b, v1.16b }, v7.16b
    aese v2.16b, v16.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v2.16b, v2.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v4.16b, v5.16b }, [x0]
    tbl v0.16b, { v2.16b, v3.16b }, v6.16b
    tbl v1.16b, { v2.16b, v3.16b }, v7.16b
    aese v0.16b, v16.16b
    aese v1.16b, v16.16b
    eor v0.16b, v0.16b, v4.16b
    eor v1.16b, v1.16b, v5.16b
    st1 { v0.16b, v1.16b }, [x1]
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
    ret
    ENDP

    EXPORT rijndael256Encrypt4BlocksAsm
rijndael256Encrypt4BlocksAsm PROC
    hint #34 ; bti c
    adrp x3, rijndael256Consts
    add x3, x3, rijndael256Consts
    add x3, x3, #32
    ld1 { v26.16b, v27.16b }, [x3]
    eor v28.16b, v28.16b, v28.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x2], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x2]
    ld1 { v24.16b, v25.16b }, [x0], #32
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    ld1 { v24.16b, v25.16b }, [x0], #32
    tbl v16.16b, { v0.16b, v1.16b }, v26.16b
    tbl v17.16b, { v0.16b, v1.16b }, v27.16b
    aese v16.16b, v28.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v28.16b
    aesmc v17.16b, v17.16b
    eor v16.16b, v16.16b, v24.16b
    eor v17.16b, v17.16b, v25.16b
    tbl v18.16b, { v2.16b, v3.16b }, v26.16b
    tbl v19.16b, { v2.16b, v3.16b }, v27.16b
    aese v18.16b, v28.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v28.16b
    aesmc v19.16b, v19.16b
    eor v18.16b, v18.16b, v24.16b
    eor v19.16b, v19.16b, v25.16b
    tbl v20.16b, { v4.16b, v5.16b }, v26.16b
    tbl v21.16b, { v4.16b, v5.16b }, v27.16b
    aese v20.16b, v28.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v28.16b
    aesmc v21.16b, v21.16b
    eor v20.16b, v20.16b, v24.16b
    eor v21.16b, v21.16b, v25.16b
    tbl v22.16b, { v6.16b, v7.16b }, v26.16b
    tbl v23.16b, { v6.16b, v7.16b }, v27.16b
    aese v22.16b, v28.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v28.16b
    aesmc v23.16b, v23.16b
    eor v22.16b, v22.16b, v24.16b
    eor v23.16b, v23.16b, v25.16b
    ld1 { v24.16b, v25.16b }, [x0], #32
    tbl v0.16b, { v16.16b, v17.16b }, v26.16b
    tbl v1.16b, { v16.16b, v17.16b }, v27.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v28.16b
    aesmc v1.16b, v1.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    tbl v2.16b, { v18.16b, v19.16b }, v26.16b
    tbl v3.16b, { v18.16b, v19.16b }, v27.16b
    aese v2.16b, v28.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v28.16b
    aesmc v3.16b, v3.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    tbl v4.16b, { v20.16b, v21.16b }, v26.16b
    tbl v5.16b, { v20.16b, v21.16b }, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v28.16b
    aesmc v5.16b, v5.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    tbl v6.16b, { v22.16b, v23.16b }, v26.16b
    tbl v7.16b, { v22.16b, v23.16b }, v27.16b
    aese v6.16b, v28.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v28.16b
    aesmc v7.16b, v7.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    ld1 { v24.16b, v25.16b }, [x0], #32
    tbl v16.16b, { v0.16b, v1.16b }, v26.16b
    tbl v17.16b, { v0.16b, v1.16b }, v27.16b
    aese v16.16b, v28.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v28.16b
    aesmc v17.16b, v17.16b
    eor v16.16b, v16.16b, v24.16b
    eor v17.16b, v17.16b, v25.16b
    tbl v18.16b, { v2.16b, v3.16b }, v26.16b
    tbl v19.16b, { v2.16b, v3.16b }, v27.16b
    aese v18.16b, v28.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v28.16b
    aesmc v19.16b, v19.16b
    eor v18.16b, v18.16b, v24.16b
    eor v19.16b, v19.16b, v25.16b
    tbl v20.16b, { v4.16b, v5.16b }, v26.16b
    tbl v21.16b, { v4.16b, v5.16b }, v27.16b
    aese v20.16b, v28.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v28.16b
    aesmc v21.16b, v21.16b
    eor v20.16b, v20.16b, v24.16b
    eor v21.16b, v21.16b, v25.16b
    tbl v22.16b, { v6.16b, v7.16b }, v26.16b
    tbl v23.16b, { v6.16b, v7.16b }, v27.16b
    aese v22.16b, v28.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v28.16b
    aesmc v23.16b, v23.16b
    eor v22.16b, v22.16b, v24.16b
    eor v23.16b, v23.16b, v25.16b
    ld1 { v24.16b, v25.16b }, [x0], #32
    tbl v0.16b, { v16.16b, v17.16b }, v26.16b
    tbl v1.16b, { v16.16b, v17.16b }, v27.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v28.16b
    aesmc v1.16b, v1.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    tbl v2.16b, { v18.16b, v19.16b }, v26.16b
    tbl v3.16b, { v18.16b, v19.16b }, v27.16b
    aese v2.16b, v28.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v28.16b
    aesmc v3.16b, v3.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    tbl v4.16b, { v20.16b, v21.16b }, v26.16b
    tbl v5.16b, { v20.16b, v21.16b }, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v28.16b
    aesmc v5.16b, v5.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    tbl v6.16b, { v22.16b, v23.16b }, v26.16b
    tbl v7.16b, { v22.16b, v23.16b }, v27.16b
    aese v6.16b, v28.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v28.16b
    aesmc v7.16b, v7.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    ld1 { v24.16b, v25.16b }, [x0], #32
    tbl v16.16b, { v0.16b, v1.16b }, v26.16b
    tbl v17.16b, { v0.16b, v1.16b }, v27.16b
    aese v16.16b, v28.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v28.16b
    aesmc v17.16b, v17.16b
    eor v16.16b, v16.16b, v24.16b
    eor v17.16b, v17.16b, v25.16b
    tbl v18.16b, { v2.16b, v3.16b }, v26.16b
    tbl v19.16b, { v2.16b, v3.16b }, v27.16b
    aese v18.16b, v28.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v28.16b
    aesmc v19.16b, v19.16b
    eor v18.16b, v18.16b, v24.16b
    eor v19.16b, v19.16b, v25.16b
    tbl v20.16b, { v4.16b, v5.16b }, v26.16b
    tbl v21.16b, { v4.16b, v5.16b }, v27.16b
    aese v20.16b, v28.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v28.16b
    aesmc v21.16b, v21.16b
    eor v20.16b, v20.16b, v24.16b
    eor v21.16b, v21.16b, v25.16b
    tbl v22.16b, { v6.16b, v7.16b }, v26.16b
    tbl v23.16b, { v6.16b, v7.16b }, v27.16b
    aese v22.16b, v28.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v28.16b
    aesmc v23.16b, v23.16b
    eor v22.16b, v22.16b, v24.16b
    eor v23.16b, v23.16b, v25.16b
    ld1 { v24.16b, v25.16b }, [x0], #32
    tbl v0.16b, { v16.16b, v17.16b }, v26.16b
    tbl v1.16b, { v16.16b, v17.16b }, v27.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v28.16b
    aesmc v1.16b, v1.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    tbl v2.16b, { v18.16b, v19.16b }, v26.16b
    tbl v3.16b, { v18.16b, v19.16b }, v27.16b
    aese v2.16b, v28.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v28.16b
    aesmc v3.16b, v3.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    tbl v4.16b, { v20.16b, v21.16b }, v26.16b
    tbl v5.16b, { v20.16b, v21.16b }, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v28.16b
    aesmc v5.16b, v5.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    tbl v6.16b, { v22.16b, v23.16b }, v26.16b
    tbl v7.16b, { v22.16b, v23.16b }, v27.16b
    aese v6.16b, v28.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v28.16b
    aesmc v7.16b, v7.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    ld1 { v24.16b, v25.16b }, [x0], #32
    tbl v16.16b, { v0.16b, v1.16b }, v26.16b
    tbl v17.16b, { v0.16b, v1.16b }, v27.16b
    aese v16.16b, v28.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v28.16b
    aesmc v17.16b, v17.16b
    eor v16.16b, v16.16b, v24.16b
    eor v17.16b, v17.16b, v25.16b
    tbl v18.16b, { v2.16b, v3.16b }, v26.16b
    tbl v19.16b, { v2.16b, v3.16b }, v27.16b
    aese v18.16b, v28.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v28.16b
    aesmc v19.16b, v19.16b
    eor v18.16b, v18.16b, v24.16b
    eor v19.16b, v19.16b, v25.16b
    tbl v20.16b, { v4.16b, v5.16b }, v26.16b
    tbl v21.16b, { v4.16b, v5.16b }, v27.16b
    aese v20.16b, v28.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v28.16b
    aesmc v21.16b, v21.16b
    eor v20.16b, v20.16b, v24.16b
    eor v21.16b, v21.16b, v25.16b
    tbl v22.16b, { v6.16b, v7.16b }, v26.16b
    tbl v23.16b, { v6.16b, v7.16b }, v27.16b
    aese v22.16b, v28.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v28.16b
    aesmc v23.16b, v23.16b
    eor v22.16b, v22.16b, v24.16b
    eor v23.16b, v23.16b, v25.16b
    ld1 { v24.16b, v25.16b }, [x0], #32
    tbl v0.16b, { v16.16b, v17.16b }, v26.16b
    tbl v1.16b, { v16.16b, v17.16b }, v27.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v28.16b
    aesmc v1.16b, v1.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    tbl v2.16b, { v18.16b, v19.16b }, v26.16b
    tbl v3.16b, { v18.16b, v19.16b }, v27.16b
    aese v2.16b, v28.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v28.16b
    aesmc v3.16b, v3.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    tbl v4.16b, { v20.16b, v21.16b }, v26.16b
    tbl v5.16b, { v20.16b, v21.16b }, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v28.16b
    aesmc v5.16b, v5.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    tbl v6.16b, { v22.16b, v23.16b }, v26.16b
    tbl v7.16b, { v22.16b, v23.16b }, v27.16b
    aese v6.16b, v28.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v28.16b
    aesmc v7.16b, v7.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    ld1 { v24.16b, v25.16b }, [x0], #32
    tbl v16.16b, { v0.16b, v1.16b }, v26.16b
    tbl v17.16b, { v0.16b, v1.16b }, v27.16b
    aese v16.16b, v28.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v28.16b
    aesmc v17.16b, v17.16b
    eor v16.16b, v16.16b, v24.16b
    eor v17.16b, v17.16b, v25.16b
    tbl v18.16b, { v2.16b, v3.16b }, v26.16b
    tbl v19.16b, { v2.16b, v3.16b }, v27.16b
    aese v18.16b, v28.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v28.16b
    aesmc v19.16b, v19.16b
    eor v18.16b, v18.16b, v24.16b
    eor v19.16b, v19.16b, v25.16b
    tbl v20.16b, { v4.16b, v5.16b }, v26.16b
    tbl v21.16b, { v4.16b, v5.16b }, v27.16b
    aese v20.16b, v28.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v28.16b
    aesmc v21.16b, v21.16b
    eor v20.16b, v20.16b, v24.16b
    eor v21.16b, v21.16b, v25.16b
    tbl v22.16b, { v6.16b, v7.16b }, v26.16b
    tbl v23.16b, { v6.16b, v7.16b }, v27.16b
    aese v22.16b, v28.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v28.16b
    aesmc v23.16b, v23.16b
    eor v22.16b, v22.16b, v24.16b
    eor v23.16b, v23.16b, v25.16b
    ld1 { v24.16b, v25.16b }, [x0], #32
    tbl v0.16b, { v16.16b, v17.16b }, v26.16b
    tbl v1.16b, { v16.16b, v17.16b }, v27.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v28.16b
    aesmc v1.16b, v1.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    tbl v2.16b, { v18.16b, v19.16b }, v26.16b
    tbl v3.16b, { v18.16b, v19.16b }, v27.16b
    aese v2.16b, v28.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v28.16b
    aesmc v3.16b, v3.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    tbl v4.16b, { v20.16b, v21.16b }, v26.16b
    tbl v5.16b, { v20.16b, v21.16b }, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v28.16b
    aesmc v5.16b, v5.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    tbl v6.16b, { v22.16b, v23.16b }, v26.16b
    tbl v7.16b, { v22.16b, v23.16b }, v27.16b
    aese v6.16b, v28.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v28.16b
    aesmc v7.16b, v7.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    ld1 { v24.16b, v25.16b }, [x0], #32
    tbl v16.16b, { v0.16b, v1.16b }, v26.16b
    tbl v17.16b, { v0.16b, v1.16b }, v27.16b
    aese v16.16b, v28.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v28.16b
    aesmc v17.16b, v17.16b
    eor v16.16b, v16.16b, v24.16b
    eor v17.16b, v17.16b, v25.16b
    tbl v18.16b, { v2.16b, v3.16b }, v26.16b
    tbl v19.16b, { v2.16b, v3.16b }, v27.16b
    aese v18.16b, v28.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v28.16b
    aesmc v19.16b, v19.16b
    eor v18.16b, v18.16b, v24.16b
    eor v19.16b, v19.16b, v25.16b
    tbl v20.16b, { v4.16b, v5.16b }, v26.16b
    tbl v21.16b, { v4.16b, v5.16b }, v27.16b
    aese v20.16b, v28.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v28.16b
    aesmc v21.16b, v21.16b
    eor v20.16b, v20.16b, v24.16b
    eor v21.16b, v21.16b, v25.16b
    tbl v22.16b, { v6.16b, v7.16b }, v26.16b
    tbl v23.16b, { v6.16b, v7.16b }, v27.16b
    aese v22.16b, v28.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v28.16b
    aesmc v23.16b, v23.16b
    eor v22.16b, v22.16b, v24.16b
    eor v23.16b, v23.16b, v25.16b
    ld1 { v24.16b, v25.16b }, [x0], #32
    tbl v0.16b, { v16.16b, v17.16b }, v26.16b
    tbl v1.16b, { v16.16b, v17.16b }, v27.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v1.16b, v28.16b
    aesmc v1.16b, v1.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    tbl v2.16b, { v18.16b, v19.16b }, v26.16b
    tbl v3.16b, { v18.16b, v19.16b }, v27.16b
    aese v2.16b, v28.16b
    aesmc v2.16b, v2.16b
    aese v3.16b, v28.16b
    aesmc v3.16b, v3.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    tbl v4.16b, { v20.16b, v21.16b }, v26.16b
    tbl v5.16b, { v20.16b, v21.16b }, v27.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v5.16b, v28.16b
    aesmc v5.16b, v5.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    tbl v6.16b, { v22.16b, v23.16b }, v26.16b
    tbl v7.16b, { v22.16b, v23.16b }, v27.16b
    aese v6.16b, v28.16b
    aesmc v6.16b, v6.16b
    aese v7.16b, v28.16b
    aesmc v7.16b, v7.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    ld1 { v24.16b, v25.16b }, [x0], #32
    tbl v16.16b, { v0.16b, v1.16b }, v26.16b
    tbl v17.16b, { v0.16b, v1.16b }, v27.16b
    aese v16.16b, v28.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v28.16b
    aesmc v17.16b, v17.16b
    eor v16.16b, v16.16b, v24.16b
    eor v17.16b, v17.16b, v25.16b
    tbl v18.16b, { v2.16b, v3.16b }, v26.16b
    tbl v19.16b, { v2.16b, v3.16b }, v27.16b
    aese v18.16b, v28.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v28.16b
    aesmc v19.16b, v19.16b
    eor v18.16b, v18.16b, v24.16b
    eor v19.16b, v19.16b, v25.16b
    tbl v20.16b, { v4.16b, v5.16b }, v26.16b
    tbl v21.16b, { v4.16b, v5.16b }, v27.16b
    aese v20.16b, v28.16b
    aesmc v20.16b, v20.16b
    aese v21.16b, v28.16b
    aesmc v21.16b, v21.16b
    eor v20.16b, v20.16b, v24.16b
    eor v21.16b, v21.16b, v25.16b
    tbl v22.16b, { v6.16b, v7.16b }, v26.16b
    tbl v23.16b, { v6.16b, v7.16b }, v27.16b
    aese v22.16b, v28.16b
    aesmc v22.16b, v22.16b
    aese v23.16b, v28.16b
    aesmc v23.16b, v23.16b
    eor v22.16b, v22.16b, v24.16b
    eor v23.16b, v23.16b, v25.16b
    ld1 { v24.16b, v25.16b }, [x0]
    tbl v0.16b, { v16.16b, v17.16b }, v26.16b
    tbl v1.16b, { v16.16b, v17.16b }, v27.16b
    aese v0.16b, v28.16b
    aese v1.16b, v28.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    tbl v2.16b, { v18.16b, v19.16b }, v26.16b
    tbl v3.16b, { v18.16b, v19.16b }, v27.16b
    aese v2.16b, v28.16b
    aese v3.16b, v28.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    tbl v4.16b, { v20.16b, v21.16b }, v26.16b
    tbl v5.16b, { v20.16b, v21.16b }, v27.16b
    aese v4.16b, v28.16b
    aese v5.16b, v28.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    tbl v6.16b, { v22.16b, v23.16b }, v26.16b
    tbl v7.16b, { v22.16b, v23.16b }, v27.16b
    aese v6.16b, v28.16b
    aese v7.16b, v28.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    st1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
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

    EXPORT areion256PermuteRCAsm
areion256PermuteRCAsm PROC
    hint #34 ; bti c
    mov x2, x1
    ld1 { v0.16b, v1.16b }, [x0]
    eor v31.16b, v31.16b, v31.16b
    ld1 { v2.16b }, [x2], #16
    aese v0.16b, v31.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v1.16b, v31.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v0.16b, v31.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v1.16b, v31.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v0.16b, v31.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v1.16b, v31.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v0.16b, v31.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v1.16b, v31.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v0.16b, v31.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v1.16b, v31.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    st1 { v0.16b, v1.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    ret
    ENDP

    EXPORT areion256InversePermuteRCAsm
areion256InversePermuteRCAsm PROC
    hint #34 ; bti c
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
    aesmc v3.16b, v1.16b
    aesd v1.16b, v31.16b
    aese v3.16b, v25.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v31.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v31.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v31.16b
    aese v3.16b, v22.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v31.16b
    aese v3.16b, v21.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v31.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v31.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v31.16b
    aese v3.16b, v18.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v31.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v31.16b
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
    mov x1, xzr
    mov x2, xzr
    ret
    ENDP

    EXPORT areion512PermuteRCAsm
areion512PermuteRCAsm PROC
    hint #34 ; bti c
    mov x2, x1
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    eor v31.16b, v31.16b, v31.16b
    ld1 { v4.16b }, [x2], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x2], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x2], #16
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x2], #16
    aese v3.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x2], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x2], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x2], #16
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x2], #16
    aese v3.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x2], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x2], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x2], #16
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x2], #16
    aese v3.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x2], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x2], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x2], #16
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
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
    ENDP

    EXPORT areion512InversePermuteRCAsm
areion512InversePermuteRCAsm PROC
    hint #34 ; bti c
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
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v5.16b, v3.16b, v29.16b
    aesd v3.16b, v29.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v5.16b, v2.16b, v28.16b
    aesd v2.16b, v28.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v5.16b, v1.16b, v27.16b
    aesd v1.16b, v27.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v5.16b, v0.16b, v26.16b
    aesd v0.16b, v26.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v5.16b, v3.16b, v25.16b
    aesd v3.16b, v25.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v5.16b, v2.16b, v24.16b
    aesd v2.16b, v24.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v5.16b, v1.16b, v23.16b
    aesd v1.16b, v23.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v5.16b, v0.16b, v22.16b
    aesd v0.16b, v22.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v5.16b, v3.16b, v21.16b
    aesd v3.16b, v21.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v5.16b, v2.16b, v20.16b
    aesd v2.16b, v20.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v5.16b, v1.16b, v19.16b
    aesd v1.16b, v19.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v5.16b, v0.16b, v18.16b
    aesd v0.16b, v18.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v5.16b, v3.16b, v17.16b
    aesd v3.16b, v17.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v5.16b, v2.16b, v16.16b
    aesd v2.16b, v16.16b
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
    ENDP

    EXPORT areionSoEM256Asm
areionSoEM256Asm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b }, [x2]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x1]
    eor v2.16b, v0.16b, v18.16b
    eor v3.16b, v1.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v20.16b, v20.16b, v20.16b
    adrp x3, roundConstantsP1
    add x3, x3, roundConstantsP1
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    aesmc v4.16b, v0.16b
    aesmc v5.16b, v2.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    aesmc v4.16b, v1.16b
    aesmc v5.16b, v3.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    aesmc v4.16b, v0.16b
    aesmc v5.16b, v2.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    aesmc v4.16b, v1.16b
    aesmc v5.16b, v3.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    aesmc v4.16b, v0.16b
    aesmc v5.16b, v2.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    aesmc v4.16b, v1.16b
    aesmc v5.16b, v3.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    aesmc v4.16b, v0.16b
    aesmc v5.16b, v2.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    aesmc v4.16b, v1.16b
    aesmc v5.16b, v3.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    aesmc v4.16b, v0.16b
    aesmc v5.16b, v2.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v6.16b }, [x3], #16
    ld1 { v7.16b }, [x4], #16
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    aesmc v4.16b, v1.16b
    aesmc v5.16b, v3.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
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
    ENDP

    EXPORT areionSoEM512Asm
areionSoEM512Asm PROC
    hint #34 ; bti c
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
    adrp x3, roundConstantsP1
    add x3, x3, roundConstantsP1
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    aesmc v26.16b, v2.16b
    aesmc v27.16b, v6.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    aesmc v26.16b, v3.16b
    aesmc v27.16b, v7.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesmc v26.16b, v0.16b
    aesmc v27.16b, v4.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    aesmc v26.16b, v1.16b
    aesmc v27.16b, v5.16b
    eor v2.16b, v2.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aese v1.16b, v28.16b
    aese v5.16b, v29.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    aesmc v26.16b, v2.16b
    aesmc v27.16b, v6.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    aesmc v26.16b, v3.16b
    aesmc v27.16b, v7.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesmc v26.16b, v0.16b
    aesmc v27.16b, v4.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    aesmc v26.16b, v1.16b
    aesmc v27.16b, v5.16b
    eor v2.16b, v2.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aese v1.16b, v28.16b
    aese v5.16b, v29.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    aesmc v26.16b, v2.16b
    aesmc v27.16b, v6.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    aesmc v26.16b, v3.16b
    aesmc v27.16b, v7.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesmc v26.16b, v0.16b
    aesmc v27.16b, v4.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    aesmc v26.16b, v1.16b
    aesmc v27.16b, v5.16b
    eor v2.16b, v2.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aese v1.16b, v28.16b
    aese v5.16b, v29.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    aesmc v26.16b, v2.16b
    aesmc v27.16b, v6.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    aesmc v26.16b, v3.16b
    aesmc v27.16b, v7.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesmc v26.16b, v0.16b
    aesmc v27.16b, v4.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
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
    ENDP

    EXPORT areion256Permutex4RC
areion256Permutex4RC PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b }, [x0]
    ld1 { v2.16b, v3.16b }, [x1]
    ld1 { v4.16b, v5.16b }, [x2]
    ld1 { v6.16b, v7.16b }, [x3]
    eor v31.16b, v31.16b, v31.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    st1 { v0.16b, v1.16b }, [x0]
    st1 { v2.16b, v3.16b }, [x1]
    st1 { v4.16b, v5.16b }, [x2]
    st1 { v6.16b, v7.16b }, [x3]
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
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT areion256InversePermutex4RC
areion256InversePermutex4RC PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b }, [x0]
    ld1 { v2.16b, v3.16b }, [x1]
    ld1 { v4.16b, v5.16b }, [x2]
    ld1 { v6.16b, v7.16b }, [x3]
    eor v31.16b, v31.16b, v31.16b
    add x4, x4, #144
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    st1 { v0.16b, v1.16b }, [x0]
    st1 { v2.16b, v3.16b }, [x1]
    st1 { v4.16b, v5.16b }, [x2]
    st1 { v6.16b, v7.16b }, [x3]
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
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT areion512Permutex4RC
areion512Permutex4RC PROC
    hint #34 ; bti c
    eor v31.16b, v31.16b, v31.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x3]
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v30.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v30.16b
    aesmc v20.16b, v20.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v30.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v30.16b
    aesmc v21.16b, v21.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v30.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v30.16b
    aesmc v20.16b, v20.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v30.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v30.16b
    aesmc v21.16b, v21.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v30.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v30.16b
    aesmc v20.16b, v20.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v30.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v30.16b
    aesmc v21.16b, v21.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v30.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v30.16b
    aesmc v20.16b, v20.16b
    st1 { v3.16b }, [x0], #16
    st1 { v0.16b, v1.16b, v2.16b }, [x0]
    st1 { v7.16b }, [x1], #16
    st1 { v4.16b, v5.16b, v6.16b }, [x1]
    st1 { v19.16b }, [x2], #16
    st1 { v16.16b, v17.16b, v18.16b }, [x2]
    st1 { v23.16b }, [x3], #16
    st1 { v20.16b, v21.16b, v22.16b }, [x3]
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
    eor v30.16b, v30.16b, v30.16b
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT areion512InversePermutex4RC
areion512InversePermutex4RC PROC
    hint #34 ; bti c
    eor v31.16b, v31.16b, v31.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x3]
    add x4, x4, #224
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v17.16b, v31.16b
    aesd v21.16b, v31.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v3.16b, v30.16b
    eor v25.16b, v7.16b, v30.16b
    eor v26.16b, v19.16b, v30.16b
    eor v27.16b, v23.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesd v19.16b, v30.16b
    aesd v23.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v16.16b, v31.16b
    aesd v20.16b, v31.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    eor v24.16b, v2.16b, v30.16b
    eor v25.16b, v6.16b, v30.16b
    eor v26.16b, v18.16b, v30.16b
    eor v27.16b, v22.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v18.16b, v30.16b
    aesd v22.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v17.16b, v31.16b
    aesd v21.16b, v31.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v3.16b, v30.16b
    eor v25.16b, v7.16b, v30.16b
    eor v26.16b, v19.16b, v30.16b
    eor v27.16b, v23.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesd v19.16b, v30.16b
    aesd v23.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v16.16b, v31.16b
    aesd v20.16b, v31.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    eor v24.16b, v2.16b, v30.16b
    eor v25.16b, v6.16b, v30.16b
    eor v26.16b, v18.16b, v30.16b
    eor v27.16b, v22.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v18.16b, v30.16b
    aesd v22.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v17.16b, v31.16b
    aesd v21.16b, v31.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v3.16b, v30.16b
    eor v25.16b, v7.16b, v30.16b
    eor v26.16b, v19.16b, v30.16b
    eor v27.16b, v23.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesd v19.16b, v30.16b
    aesd v23.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v16.16b, v31.16b
    aesd v20.16b, v31.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    eor v24.16b, v2.16b, v30.16b
    eor v25.16b, v6.16b, v30.16b
    eor v26.16b, v18.16b, v30.16b
    eor v27.16b, v22.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v18.16b, v30.16b
    aesd v22.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v30.16b }, [x4]
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v17.16b, v31.16b
    aesd v21.16b, v31.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v3.16b, v30.16b
    eor v25.16b, v7.16b, v30.16b
    eor v26.16b, v19.16b, v30.16b
    eor v27.16b, v23.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesd v19.16b, v30.16b
    aesd v23.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    st1 { v1.16b, v2.16b, v3.16b }, [x0], #48
    st1 { v0.16b }, [x0]
    st1 { v5.16b, v6.16b, v7.16b }, [x1], #48
    st1 { v4.16b }, [x1]
    st1 { v17.16b, v18.16b, v19.16b }, [x2], #48
    st1 { v16.16b }, [x2]
    st1 { v21.16b, v22.16b, v23.16b }, [x3], #48
    st1 { v20.16b }, [x3]
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
    eor v30.16b, v30.16b, v30.16b
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT areion256SoEMPermutex4NEON
areion256SoEMPermutex4NEON PROC
    hint #34 ; bti c
    eor v31.16b, v31.16b, v31.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    mov x5, x2
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5], #64
    eor v16.16b, v0.16b, v26.16b
    eor v17.16b, v1.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5], #64
    eor v18.16b, v2.16b, v26.16b
    eor v19.16b, v3.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5], #64
    eor v20.16b, v4.16b, v26.16b
    eor v21.16b, v5.16b, v27.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    eor v22.16b, v6.16b, v26.16b
    eor v23.16b, v7.16b, v27.16b
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    adrp x3, roundConstantsP1
    add x3, x3, roundConstantsP1
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aese v16.16b, v31.16b
    aese v18.16b, v31.16b
    aese v20.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v2.16b
    aesmc v26.16b, v4.16b
    aesmc v27.16b, v6.16b
    aese v24.16b, v28.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v28.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v28.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v28.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v5.16b, v5.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aesmc v24.16b, v16.16b
    aesmc v25.16b, v18.16b
    aesmc v26.16b, v20.16b
    aesmc v27.16b, v22.16b
    aese v24.16b, v29.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v29.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v29.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v29.16b
    aesmc v27.16b, v27.16b
    eor v17.16b, v17.16b, v24.16b
    eor v19.16b, v19.16b, v25.16b
    eor v21.16b, v21.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aese v17.16b, v31.16b
    aese v19.16b, v31.16b
    aese v21.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v3.16b
    aesmc v26.16b, v5.16b
    aesmc v27.16b, v7.16b
    aese v24.16b, v28.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v28.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v28.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v28.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v2.16b, v2.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aesmc v24.16b, v17.16b
    aesmc v25.16b, v19.16b
    aesmc v26.16b, v21.16b
    aesmc v27.16b, v23.16b
    aese v24.16b, v29.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v29.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v29.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v29.16b
    aesmc v27.16b, v27.16b
    eor v16.16b, v16.16b, v24.16b
    eor v18.16b, v18.16b, v25.16b
    eor v20.16b, v20.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aese v16.16b, v31.16b
    aese v18.16b, v31.16b
    aese v20.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v2.16b
    aesmc v26.16b, v4.16b
    aesmc v27.16b, v6.16b
    aese v24.16b, v28.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v28.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v28.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v28.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v5.16b, v5.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aesmc v24.16b, v16.16b
    aesmc v25.16b, v18.16b
    aesmc v26.16b, v20.16b
    aesmc v27.16b, v22.16b
    aese v24.16b, v29.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v29.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v29.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v29.16b
    aesmc v27.16b, v27.16b
    eor v17.16b, v17.16b, v24.16b
    eor v19.16b, v19.16b, v25.16b
    eor v21.16b, v21.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aese v17.16b, v31.16b
    aese v19.16b, v31.16b
    aese v21.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v3.16b
    aesmc v26.16b, v5.16b
    aesmc v27.16b, v7.16b
    aese v24.16b, v28.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v28.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v28.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v28.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v2.16b, v2.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aesmc v24.16b, v17.16b
    aesmc v25.16b, v19.16b
    aesmc v26.16b, v21.16b
    aesmc v27.16b, v23.16b
    aese v24.16b, v29.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v29.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v29.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v29.16b
    aesmc v27.16b, v27.16b
    eor v16.16b, v16.16b, v24.16b
    eor v18.16b, v18.16b, v25.16b
    eor v20.16b, v20.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aese v16.16b, v31.16b
    aese v18.16b, v31.16b
    aese v20.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v2.16b
    aesmc v26.16b, v4.16b
    aesmc v27.16b, v6.16b
    aese v24.16b, v28.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v28.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v28.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v28.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v5.16b, v5.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aesmc v24.16b, v16.16b
    aesmc v25.16b, v18.16b
    aesmc v26.16b, v20.16b
    aesmc v27.16b, v22.16b
    aese v24.16b, v29.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v29.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v29.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v29.16b
    aesmc v27.16b, v27.16b
    eor v17.16b, v17.16b, v24.16b
    eor v19.16b, v19.16b, v25.16b
    eor v21.16b, v21.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aese v17.16b, v31.16b
    aese v19.16b, v31.16b
    aese v21.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v3.16b
    aesmc v26.16b, v5.16b
    aesmc v27.16b, v7.16b
    aese v24.16b, v28.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v28.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v28.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v28.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v2.16b, v2.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aesmc v24.16b, v17.16b
    aesmc v25.16b, v19.16b
    aesmc v26.16b, v21.16b
    aesmc v27.16b, v23.16b
    aese v24.16b, v29.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v29.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v29.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v29.16b
    aesmc v27.16b, v27.16b
    eor v16.16b, v16.16b, v24.16b
    eor v18.16b, v18.16b, v25.16b
    eor v20.16b, v20.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aese v16.16b, v31.16b
    aese v18.16b, v31.16b
    aese v20.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v2.16b
    aesmc v26.16b, v4.16b
    aesmc v27.16b, v6.16b
    aese v24.16b, v28.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v28.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v28.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v28.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v5.16b, v5.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aesmc v24.16b, v16.16b
    aesmc v25.16b, v18.16b
    aesmc v26.16b, v20.16b
    aesmc v27.16b, v22.16b
    aese v24.16b, v29.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v29.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v29.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v29.16b
    aesmc v27.16b, v27.16b
    eor v17.16b, v17.16b, v24.16b
    eor v19.16b, v19.16b, v25.16b
    eor v21.16b, v21.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aese v17.16b, v31.16b
    aese v19.16b, v31.16b
    aese v21.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v3.16b
    aesmc v26.16b, v5.16b
    aesmc v27.16b, v7.16b
    aese v24.16b, v28.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v28.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v28.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v28.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v2.16b, v2.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aesmc v24.16b, v17.16b
    aesmc v25.16b, v19.16b
    aesmc v26.16b, v21.16b
    aesmc v27.16b, v23.16b
    aese v24.16b, v29.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v29.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v29.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v29.16b
    aesmc v27.16b, v27.16b
    eor v16.16b, v16.16b, v24.16b
    eor v18.16b, v18.16b, v25.16b
    eor v20.16b, v20.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aese v16.16b, v31.16b
    aese v18.16b, v31.16b
    aese v20.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v2.16b
    aesmc v26.16b, v4.16b
    aesmc v27.16b, v6.16b
    aese v24.16b, v28.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v28.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v28.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v28.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v5.16b, v5.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aesmc v24.16b, v16.16b
    aesmc v25.16b, v18.16b
    aesmc v26.16b, v20.16b
    aesmc v27.16b, v22.16b
    aese v24.16b, v29.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v29.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v29.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v29.16b
    aesmc v27.16b, v27.16b
    eor v17.16b, v17.16b, v24.16b
    eor v19.16b, v19.16b, v25.16b
    eor v21.16b, v21.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aese v17.16b, v31.16b
    aese v19.16b, v31.16b
    aese v21.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v3.16b
    aesmc v26.16b, v5.16b
    aesmc v27.16b, v7.16b
    aese v24.16b, v28.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v28.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v28.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v28.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v2.16b, v2.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aesmc v24.16b, v17.16b
    aesmc v25.16b, v19.16b
    aesmc v26.16b, v21.16b
    aesmc v27.16b, v23.16b
    aese v24.16b, v29.16b
    aesmc v24.16b, v24.16b
    aese v25.16b, v29.16b
    aesmc v25.16b, v25.16b
    aese v26.16b, v29.16b
    aesmc v26.16b, v26.16b
    aese v27.16b, v29.16b
    aesmc v27.16b, v27.16b
    eor v16.16b, v16.16b, v24.16b
    eor v18.16b, v18.16b, v25.16b
    eor v20.16b, v20.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2], #64
    eor v16.16b, v16.16b, v18.16b
    eor v17.16b, v17.16b, v19.16b
    eor v20.16b, v20.16b, v22.16b
    eor v21.16b, v21.16b, v23.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v20.16b
    eor v3.16b, v3.16b, v21.16b
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2]
    eor v16.16b, v16.16b, v18.16b
    eor v17.16b, v17.16b, v19.16b
    eor v20.16b, v20.16b, v22.16b
    eor v21.16b, v21.16b, v23.16b
    eor v4.16b, v4.16b, v16.16b
    eor v5.16b, v5.16b, v17.16b
    eor v6.16b, v6.16b, v20.16b
    eor v7.16b, v7.16b, v21.16b
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
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    mov x5, xzr
    ret
    ENDP

    EXPORT areion512SoEMPermutex4NEON
areion512SoEMPermutex4NEON PROC
    hint #34 ; bti c
    eor v31.16b, v31.16b, v31.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
    mov x5, x2
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5], #64
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x5], #64
    eor v16.16b, v0.16b, v16.16b
    eor v17.16b, v1.16b, v17.16b
    eor v18.16b, v2.16b, v18.16b
    eor v19.16b, v3.16b, v19.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x5]
    eor v20.16b, v4.16b, v20.16b
    eor v21.16b, v5.16b, v21.16b
    eor v22.16b, v6.16b, v22.16b
    eor v23.16b, v7.16b, v23.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    adrp x3, roundConstantsP1
    add x3, x3, roundConstantsP1
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v28.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v28.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v29.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v29.16b
    aesmc v22.16b, v22.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v28.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v28.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v29.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v29.16b
    aesmc v23.16b, v23.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v29.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v29.16b
    aesmc v20.16b, v20.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v28.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v28.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v29.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v29.16b
    aesmc v21.16b, v21.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v28.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v28.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v29.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v29.16b
    aesmc v22.16b, v22.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v28.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v28.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v29.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v29.16b
    aesmc v23.16b, v23.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v29.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v29.16b
    aesmc v20.16b, v20.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v28.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v28.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v29.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v29.16b
    aesmc v21.16b, v21.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v28.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v28.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v29.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v29.16b
    aesmc v22.16b, v22.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v28.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v28.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v29.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v29.16b
    aesmc v23.16b, v23.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v29.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v29.16b
    aesmc v20.16b, v20.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v28.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v28.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v29.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v29.16b
    aesmc v21.16b, v21.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v28.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v28.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v29.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v29.16b
    aesmc v22.16b, v22.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v28.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v28.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v29.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v29.16b
    aesmc v23.16b, v23.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v29.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v29.16b
    aesmc v20.16b, v20.16b
    eor v3.16b, v3.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v7.16b, v7.16b, v23.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2], #64
    eor v16.16b, v16.16b, v20.16b
    eor v17.16b, v17.16b, v21.16b
    eor v18.16b, v18.16b, v22.16b
    eor v19.16b, v19.16b, v23.16b
    eor v3.16b, v3.16b, v16.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v19.16b
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2], #64
    eor v16.16b, v16.16b, v20.16b
    eor v17.16b, v17.16b, v21.16b
    eor v18.16b, v18.16b, v22.16b
    eor v19.16b, v19.16b, v23.16b
    eor v7.16b, v7.16b, v16.16b
    eor v4.16b, v4.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    st1 { v3.16b }, [x0], #16
    st1 { v0.16b, v1.16b, v2.16b }, [x0], #48
    st1 { v7.16b }, [x0], #16
    st1 { v4.16b, v5.16b, v6.16b }, [x0], #48
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    mov x5, x2
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5], #64
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x5], #64
    eor v16.16b, v0.16b, v16.16b
    eor v17.16b, v1.16b, v17.16b
    eor v18.16b, v2.16b, v18.16b
    eor v19.16b, v3.16b, v19.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x5]
    eor v20.16b, v4.16b, v20.16b
    eor v21.16b, v5.16b, v21.16b
    eor v22.16b, v6.16b, v22.16b
    eor v23.16b, v7.16b, v23.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    adrp x3, roundConstantsP1
    add x3, x3, roundConstantsP1
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v28.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v28.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v29.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v29.16b
    aesmc v22.16b, v22.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v28.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v28.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v29.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v29.16b
    aesmc v23.16b, v23.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v29.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v29.16b
    aesmc v20.16b, v20.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v28.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v28.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v29.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v29.16b
    aesmc v21.16b, v21.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v28.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v28.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v29.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v29.16b
    aesmc v22.16b, v22.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v28.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v28.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v29.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v29.16b
    aesmc v23.16b, v23.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v29.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v29.16b
    aesmc v20.16b, v20.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v28.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v28.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v29.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v29.16b
    aesmc v21.16b, v21.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v28.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v28.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v29.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v29.16b
    aesmc v22.16b, v22.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v28.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v28.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v29.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v29.16b
    aesmc v23.16b, v23.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v29.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v29.16b
    aesmc v20.16b, v20.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v28.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v28.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v29.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v29.16b
    aesmc v21.16b, v21.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v28.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v28.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v29.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v29.16b
    aesmc v22.16b, v22.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v28.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v28.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v29.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v29.16b
    aesmc v23.16b, v23.16b
    ld1 { v28.16b }, [x3], #16
    ld1 { v29.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v28.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v28.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v29.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v29.16b
    aesmc v20.16b, v20.16b
    eor v3.16b, v3.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v7.16b, v7.16b, v23.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2], #64
    eor v16.16b, v16.16b, v20.16b
    eor v17.16b, v17.16b, v21.16b
    eor v18.16b, v18.16b, v22.16b
    eor v19.16b, v19.16b, v23.16b
    eor v3.16b, v3.16b, v16.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v19.16b
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2]
    eor v16.16b, v16.16b, v20.16b
    eor v17.16b, v17.16b, v21.16b
    eor v18.16b, v18.16b, v22.16b
    eor v19.16b, v19.16b, v23.16b
    eor v7.16b, v7.16b, v16.16b
    eor v4.16b, v4.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    st1 { v3.16b }, [x0], #16
    st1 { v0.16b, v1.16b, v2.16b }, [x0], #48
    st1 { v7.16b }, [x0], #16
    st1 { v4.16b, v5.16b, v6.16b }, [x0]
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
    mov x4, xzr
    mov x5, xzr
    ret
    ENDP

    EXPORT dumpSIMDRegs
dumpSIMDRegs PROC
    hint #34 ; bti c
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
    ENDP

    EXPORT clobberScratchGPRs
clobberScratchGPRs PROC
    hint #34 ; bti c
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
    ENDP

    EXPORT dirtySIMDRegForTest
dirtySIMDRegForTest PROC
    hint #34 ; bti c
    mov x12, x0
    mov x0, #0x5555555555555555
    eor x12, x12, x0
    mov v2.d[0], x12
    mov x0, xzr
    ret
    ENDP

    EXPORT areion256EMEncryptAsm
areion256EMEncryptAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b }, [x1]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    eor v20.16b, v20.16b, v20.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
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
    ENDP

    EXPORT areion256EMDecryptAsm
areion256EMDecryptAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b }, [x1]
    ld1 { v26.16b, v27.16b, v28.16b, v29.16b }, [x2]
    eor v30.16b, v30.16b, v30.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v29.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
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
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v25.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v22.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v21.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v18.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
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
    ENDP

    EXPORT areion512EMEncryptAsm
areion512EMEncryptAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2]
    eor v24.16b, v24.16b, v24.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
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
    ENDP

    EXPORT areion512EMDecryptAsm
areion512EMDecryptAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2]
    eor v31.16b, v31.16b, v31.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    add x4, x4, #224
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    eor v1.16b, v1.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v3.16b, v3.16b, v18.16b
    eor v0.16b, v0.16b, v19.16b
    st1 { v1.16b }, [x0], #16
    st1 { v2.16b }, [x0], #16
    st1 { v3.16b }, [x0], #16
    st1 { v0.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v2.16b, v2.16b, v2.16b
    eor v3.16b, v3.16b, v3.16b
    eor v5.16b, v5.16b, v5.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v30.16b, v30.16b, v30.16b
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT areion256EM2EncryptAsm
areion256EM2EncryptAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b }, [x1]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    eor v20.16b, v20.16b, v20.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
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
    ENDP

    EXPORT areion256EM2DecryptAsm
areion256EM2DecryptAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b }, [x1]
    ld1 { v26.16b, v27.16b, v28.16b, v29.16b }, [x2]
    eor v30.16b, v30.16b, v30.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v29.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
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
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v25.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v22.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v21.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v18.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v29.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
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
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v25.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v22.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v21.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v18.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
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
    ENDP

    EXPORT areion512EM2EncryptAsm
areion512EM2EncryptAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2]
    eor v24.16b, v24.16b, v24.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    eor v3.16b, v3.16b, v20.16b
    eor v0.16b, v0.16b, v21.16b
    eor v1.16b, v1.16b, v22.16b
    eor v2.16b, v2.16b, v23.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
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
    ENDP

    EXPORT areion512EM2DecryptAsm
areion512EM2DecryptAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2]
    eor v31.16b, v31.16b, v31.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    add x4, x4, #224
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    eor v1.16b, v1.16b, v20.16b
    eor v2.16b, v2.16b, v21.16b
    eor v3.16b, v3.16b, v22.16b
    eor v0.16b, v0.16b, v23.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    add x4, x4, #224
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
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
    eor v5.16b, v5.16b, v5.16b
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v30.16b, v30.16b, v30.16b
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT areion256TEMEncryptAsm
areion256TEMEncryptAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b }, [x3]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    eor v16.16b, v16.16b, v0.16b
    eor v17.16b, v17.16b, v1.16b
    ld1 { v0.16b, v1.16b }, [x1]
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
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
    ENDP

    EXPORT areion256TEMDecryptAsm
areion256TEMDecryptAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b }, [x3]
    ld1 { v26.16b, v27.16b, v28.16b, v29.16b }, [x2]
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v29.16b
    eor v30.16b, v30.16b, v30.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v30.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v30.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v30.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v30.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v30.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v30.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v30.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v30.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v30.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v30.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    eor v26.16b, v26.16b, v0.16b
    eor v27.16b, v27.16b, v1.16b
    ld1 { v0.16b, v1.16b }, [x1]
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
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
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v25.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v22.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v21.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v18.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
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
    ENDP

    EXPORT areion512TEMEncryptAsm
areion512TEMEncryptAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2]
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    eor v24.16b, v24.16b, v24.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
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
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v24.16b
    aese v1.16b, v24.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v24.16b
    aese v2.16b, v24.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v24.16b
    aese v3.16b, v24.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v24.16b
    aese v0.16b, v24.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
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
    ENDP

    EXPORT areion512TEMDecryptAsm
areion512TEMDecryptAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2]
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    eor v2.16b, v2.16b, v22.16b
    eor v3.16b, v3.16b, v23.16b
    eor v31.16b, v31.16b, v31.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
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
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    add x4, x4, #224
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    eor v1.16b, v1.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v3.16b, v3.16b, v18.16b
    eor v0.16b, v0.16b, v19.16b
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
    eor v16.16b, v16.16b, v16.16b
    eor v17.16b, v17.16b, v17.16b
    eor v18.16b, v18.16b, v18.16b
    eor v19.16b, v19.16b, v19.16b
    eor v20.16b, v20.16b, v20.16b
    eor v21.16b, v21.16b, v21.16b
    eor v22.16b, v22.16b, v22.16b
    eor v23.16b, v23.16b, v23.16b
    eor v30.16b, v30.16b, v30.16b
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT areion256TEM2EncryptAsm
areion256TEM2EncryptAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b }, [x3]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    eor v2.16b, v0.16b, v18.16b
    eor v3.16b, v1.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v20.16b, v20.16b, v20.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    adrp x5, roundConstantsP2
    add x5, x5, roundConstantsP2
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    aesmc v4.16b, v0.16b
    aesmc v5.16b, v2.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    aesmc v4.16b, v1.16b
    aesmc v5.16b, v3.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    aesmc v4.16b, v0.16b
    aesmc v5.16b, v2.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    aesmc v4.16b, v1.16b
    aesmc v5.16b, v3.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    aesmc v4.16b, v0.16b
    aesmc v5.16b, v2.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    aesmc v4.16b, v1.16b
    aesmc v5.16b, v3.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    aesmc v4.16b, v0.16b
    aesmc v5.16b, v2.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    aesmc v4.16b, v1.16b
    aesmc v5.16b, v3.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v0.16b, v20.16b
    aese v2.16b, v20.16b
    aesmc v4.16b, v0.16b
    aesmc v5.16b, v2.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v1.16b, v20.16b
    aese v3.16b, v20.16b
    aesmc v4.16b, v1.16b
    aesmc v5.16b, v3.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    eor v16.16b, v16.16b, v0.16b
    eor v17.16b, v17.16b, v1.16b
    eor v18.16b, v18.16b, v2.16b
    eor v19.16b, v19.16b, v3.16b
    ld1 { v0.16b, v1.16b }, [x1]
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v0.16b, v20.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x4], #16
    aese v1.16b, v20.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
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
    ENDP

    EXPORT areion256TEM2DecryptAsm
areion256TEM2DecryptAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b }, [x3]
    ld1 { v26.16b, v27.16b, v28.16b, v29.16b }, [x2]
    eor v2.16b, v0.16b, v28.16b
    eor v3.16b, v1.16b, v29.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    eor v30.16b, v30.16b, v30.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    adrp x5, roundConstantsP2
    add x5, x5, roundConstantsP2
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aesmc v4.16b, v0.16b
    aesmc v5.16b, v2.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aesmc v4.16b, v1.16b
    aesmc v5.16b, v3.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aesmc v4.16b, v0.16b
    aesmc v5.16b, v2.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aesmc v4.16b, v1.16b
    aesmc v5.16b, v3.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aesmc v4.16b, v0.16b
    aesmc v5.16b, v2.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aesmc v4.16b, v1.16b
    aesmc v5.16b, v3.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aesmc v4.16b, v0.16b
    aesmc v5.16b, v2.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aesmc v4.16b, v1.16b
    aesmc v5.16b, v3.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aesmc v4.16b, v0.16b
    aesmc v5.16b, v2.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v1.16b, v4.16b
    eor v3.16b, v3.16b, v5.16b
    ld1 { v6.16b }, [x4], #16
    ld1 { v7.16b }, [x5], #16
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aesmc v4.16b, v1.16b
    aesmc v5.16b, v3.16b
    aese v4.16b, v6.16b
    aese v5.16b, v7.16b
    aesmc v4.16b, v4.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v0.16b, v4.16b
    eor v2.16b, v2.16b, v5.16b
    eor v26.16b, v26.16b, v0.16b
    eor v27.16b, v27.16b, v1.16b
    eor v28.16b, v28.16b, v2.16b
    eor v29.16b, v29.16b, v3.16b
    ld1 { v0.16b, v1.16b }, [x1]
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v29.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
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
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v25.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v22.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v21.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v18.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v16.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v29.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
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
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v25.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v24.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v23.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v22.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v21.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v20.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v19.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
    aese v3.16b, v18.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    aesmc v3.16b, v1.16b
    aesd v1.16b, v30.16b
    aese v3.16b, v17.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    aesmc v3.16b, v0.16b
    aesd v0.16b, v30.16b
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
    ENDP

    EXPORT areion512TEM2EncryptAsm
areion512TEM2EncryptAsm PROC
    hint #34 ; bti c
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
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    adrp x5, roundConstantsP2
    add x5, x5, roundConstantsP2
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    aesmc v26.16b, v2.16b
    aesmc v27.16b, v6.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    aesmc v26.16b, v3.16b
    aesmc v27.16b, v7.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesmc v26.16b, v0.16b
    aesmc v27.16b, v4.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    aesmc v26.16b, v1.16b
    aesmc v27.16b, v5.16b
    eor v2.16b, v2.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aese v1.16b, v28.16b
    aese v5.16b, v29.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    aesmc v26.16b, v2.16b
    aesmc v27.16b, v6.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    aesmc v26.16b, v3.16b
    aesmc v27.16b, v7.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesmc v26.16b, v0.16b
    aesmc v27.16b, v4.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    aesmc v26.16b, v1.16b
    aesmc v27.16b, v5.16b
    eor v2.16b, v2.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aese v1.16b, v28.16b
    aese v5.16b, v29.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    aesmc v26.16b, v2.16b
    aesmc v27.16b, v6.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    aesmc v26.16b, v3.16b
    aesmc v27.16b, v7.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesmc v26.16b, v0.16b
    aesmc v27.16b, v4.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    aesmc v26.16b, v1.16b
    aesmc v27.16b, v5.16b
    eor v2.16b, v2.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aese v1.16b, v28.16b
    aese v5.16b, v29.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    aesmc v26.16b, v2.16b
    aesmc v27.16b, v6.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v1.16b, v30.16b
    aese v5.16b, v30.16b
    aese v3.16b, v30.16b
    aese v7.16b, v30.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    aesmc v26.16b, v3.16b
    aesmc v27.16b, v7.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v2.16b, v30.16b
    aese v6.16b, v30.16b
    aese v0.16b, v30.16b
    aese v4.16b, v30.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesmc v26.16b, v0.16b
    aesmc v27.16b, v4.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
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
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v30.16b
    aese v0.16b, v30.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v30.16b
    aese v1.16b, v30.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v30.16b
    aese v0.16b, v30.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v30.16b
    aese v1.16b, v30.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v30.16b
    aese v0.16b, v30.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v30.16b
    aese v1.16b, v30.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v30.16b
    aese v0.16b, v30.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    eor v3.16b, v3.16b, v26.16b
    eor v0.16b, v0.16b, v27.16b
    eor v1.16b, v1.16b, v28.16b
    eor v2.16b, v2.16b, v29.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v30.16b
    aese v1.16b, v30.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v30.16b
    aese v0.16b, v30.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v30.16b
    aese v1.16b, v30.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v30.16b
    aese v0.16b, v30.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v30.16b
    aese v1.16b, v30.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x4], #16
    aese v2.16b, v30.16b
    aese v0.16b, v30.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x4], #16
    aese v3.16b, v30.16b
    aese v1.16b, v30.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x4], #16
    aese v0.16b, v30.16b
    aese v2.16b, v30.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x4], #16
    aese v1.16b, v30.16b
    aese v3.16b, v30.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
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
    ENDP

    EXPORT areion512TEM2DecryptAsm
areion512TEM2DecryptAsm PROC
    hint #34 ; bti c
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
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    adrp x5, roundConstantsP2
    add x5, x5, roundConstantsP2
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    aesmc v26.16b, v2.16b
    aesmc v27.16b, v6.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    aesmc v26.16b, v3.16b
    aesmc v27.16b, v7.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesmc v26.16b, v0.16b
    aesmc v27.16b, v4.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    aesmc v26.16b, v1.16b
    aesmc v27.16b, v5.16b
    eor v2.16b, v2.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aese v1.16b, v28.16b
    aese v5.16b, v29.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    aesmc v26.16b, v2.16b
    aesmc v27.16b, v6.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    aesmc v26.16b, v3.16b
    aesmc v27.16b, v7.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesmc v26.16b, v0.16b
    aesmc v27.16b, v4.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    aesmc v26.16b, v1.16b
    aesmc v27.16b, v5.16b
    eor v2.16b, v2.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aese v1.16b, v28.16b
    aese v5.16b, v29.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    aesmc v26.16b, v2.16b
    aesmc v27.16b, v6.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    aesmc v26.16b, v3.16b
    aesmc v27.16b, v7.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesmc v26.16b, v0.16b
    aesmc v27.16b, v4.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    aese v0.16b, v28.16b
    aese v4.16b, v29.16b
    aesmc v0.16b, v0.16b
    aesmc v4.16b, v4.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    aesmc v26.16b, v1.16b
    aesmc v27.16b, v5.16b
    eor v2.16b, v2.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    aese v1.16b, v28.16b
    aese v5.16b, v29.16b
    aesmc v1.16b, v1.16b
    aesmc v5.16b, v5.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    aesmc v26.16b, v2.16b
    aesmc v27.16b, v6.16b
    eor v3.16b, v3.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    aese v2.16b, v28.16b
    aese v6.16b, v29.16b
    aesmc v2.16b, v2.16b
    aesmc v6.16b, v6.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    aesmc v26.16b, v3.16b
    aesmc v27.16b, v7.16b
    eor v0.16b, v0.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    aese v3.16b, v28.16b
    aese v7.16b, v29.16b
    aesmc v3.16b, v3.16b
    aesmc v7.16b, v7.16b
    ld1 { v28.16b }, [x4], #16
    ld1 { v29.16b }, [x5], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    aesmc v26.16b, v0.16b
    aesmc v27.16b, v4.16b
    eor v1.16b, v1.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
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
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    eor v2.16b, v2.16b, v28.16b
    eor v3.16b, v3.16b, v29.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    add x4, x4, #224
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    eor v1.16b, v1.16b, v26.16b
    eor v2.16b, v2.16b, v27.16b
    eor v3.16b, v3.16b, v28.16b
    eor v0.16b, v0.16b, v29.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    add x4, x4, #224
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v1.16b
    aesd v1.16b, v31.16b
    eor v2.16b, v5.16b, v2.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v3.16b, v30.16b
    aesd v3.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v0.16b
    aesd v0.16b, v31.16b
    eor v1.16b, v5.16b, v1.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v2.16b, v30.16b
    aesd v2.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v3.16b
    aesd v3.16b, v31.16b
    eor v0.16b, v5.16b, v0.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v1.16b, v30.16b
    aesd v1.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v2.16b
    aesd v2.16b, v31.16b
    eor v3.16b, v5.16b, v3.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    eor v5.16b, v0.16b, v30.16b
    aesd v0.16b, v30.16b
    aesmc v5.16b, v5.16b
    eor v1.16b, v5.16b, v1.16b
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
    ret
    ENDP

    EXPORT vistrutah256EncryptBlockAsm
vistrutah256EncryptBlockAsm PROC
    hint #34 ; bti c
    adrp x4, vistrutahConsts
    add x4, x4, vistrutahConsts
    ld1 { v6.16b, v7.16b }, [x4]
    adrp x4, vistrutahRoundConstants
    add x4, x4, vistrutahRoundConstants
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
    b.eq v256_blk_arm64_final
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
v256_blk_arm64_final:
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
    ENDP

    EXPORT vistrutah256Encrypt4BlocksAsm
vistrutah256Encrypt4BlocksAsm PROC
    hint #34 ; bti c
    adrp x4, vistrutahConsts
    add x4, x4, vistrutahConsts
    ld1 { v20.16b, v21.16b }, [x4]
    adrp x4, vistrutahRoundConstants
    add x4, x4, vistrutahRoundConstants
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
    b.eq v256_4blk_arm64_final
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
v256_4blk_arm64_final:
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
    ENDP

    EXPORT vistrutah512EncryptBlock256Asm
vistrutah512EncryptBlock256Asm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    ld1 { v4.16b, v5.16b }, [x2]
    adrp x4, vistrutahConsts
    add x4, x4, vistrutahConsts
    add x4, x4, #128
    ld1 { v20.16b, v21.16b }, [x4]
    add x4, x4, #128
    ld1 { v22.16b, v23.16b }, [x4]
    tbl v6.16b, { v4.16b, v5.16b }, v22.16b
    tbl v7.16b, { v4.16b, v5.16b }, v23.16b
    adrp x4, vistrutahRoundConstants
    add x4, x4, vistrutahRoundConstants
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    cmp x3, #10
    b.eq v512_blk256_arm64_final
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    cmp x3, #12
    b.eq v512_blk256_arm64_final
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    cmp x3, #14
    b.eq v512_blk256_arm64_final
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
v512_blk256_arm64_final:
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
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
    eor v25.16b, v25.16b, v25.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT vistrutah512EncryptBlock512Asm
vistrutah512EncryptBlock512Asm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x2]
    adrp x4, vistrutahConsts
    add x4, x4, vistrutahConsts
    add x4, x4, #128
    ld1 { v20.16b, v21.16b }, [x4]
    adrp x4, vistrutahRoundConstants
    add x4, x4, vistrutahRoundConstants
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    cmp x3, #10
    b.eq v512_blk512_arm64_final
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    cmp x3, #12
    b.eq v512_blk512_arm64_final
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    cmp x3, #14
    b.eq v512_blk512_arm64_final
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    zip1 v22.16b, v0.16b, v2.16b
    zip2 v23.16b, v0.16b, v2.16b
    zip1 v24.16b, v1.16b, v3.16b
    zip2 v25.16b, v1.16b, v3.16b
    zip1 v0.16b, v22.16b, v24.16b
    zip2 v2.16b, v22.16b, v24.16b
    zip1 v1.16b, v23.16b, v25.16b
    zip2 v3.16b, v23.16b, v25.16b
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
v512_blk512_arm64_final:
    ld1 { v22.16b }, [x4], #16
    eor v22.16b, v22.16b, v16.16b
    aese v0.16b, v22.16b
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
    tbl v16.16b, { v16.16b }, v20.16b
    tbl v17.16b, { v17.16b }, v21.16b
    tbl v18.16b, { v18.16b }, v20.16b
    tbl v19.16b, { v19.16b }, v21.16b
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
    eor v25.16b, v25.16b, v25.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT vistrutah512Encrypt4Blocks256Asm
vistrutah512Encrypt4Blocks256Asm PROC
    hint #34 ; bti c
    ld1 { v16.16b, v17.16b }, [x2]
    adrp x4, vistrutahConsts
    add x4, x4, vistrutahConsts
    add x4, x4, #128
    ld1 { v24.16b, v25.16b }, [x4]
    add x4, x4, #128
    ld1 { v26.16b, v27.16b }, [x4]
    tbl v18.16b, { v16.16b, v17.16b }, v26.16b
    tbl v19.16b, { v16.16b, v17.16b }, v27.16b
    adrp x4, vistrutahRoundConstants
    add x4, x4, vistrutahRoundConstants
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    cmp x3, #10
    b.eq v512_4blk256_arm64_p0_final
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    cmp x3, #12
    b.eq v512_4blk256_arm64_p0_final
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    cmp x3, #14
    b.eq v512_4blk256_arm64_p0_final
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
v512_4blk256_arm64_p0_final:
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    aese v4.16b, v30.16b
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
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
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
    adrp x4, vistrutahRoundConstants
    add x4, x4, vistrutahRoundConstants
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    cmp x3, #10
    b.eq v512_4blk256_arm64_p1_final
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    cmp x3, #12
    b.eq v512_4blk256_arm64_p1_final
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    cmp x3, #14
    b.eq v512_4blk256_arm64_p1_final
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
v512_4blk256_arm64_p1_final:
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    aese v4.16b, v30.16b
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
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
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
    eor v30.16b, v30.16b, v30.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT vistrutah512Encrypt4Blocks512Asm
vistrutah512Encrypt4Blocks512Asm PROC
    hint #34 ; bti c
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2]
    adrp x4, vistrutahConsts
    add x4, x4, vistrutahConsts
    add x4, x4, #128
    ld1 { v24.16b, v25.16b }, [x4]
    adrp x4, vistrutahRoundConstants
    add x4, x4, vistrutahRoundConstants
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    cmp x3, #10
    b.eq v512_4blk512_arm64_p0_final
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    cmp x3, #12
    b.eq v512_4blk512_arm64_p0_final
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    cmp x3, #14
    b.eq v512_4blk512_arm64_p0_final
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
v512_4blk512_arm64_p0_final:
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    aese v4.16b, v30.16b
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
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
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
    adrp x4, vistrutahRoundConstants
    add x4, x4, vistrutahRoundConstants
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    cmp x3, #10
    b.eq v512_4blk512_arm64_p1_final
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    cmp x3, #12
    b.eq v512_4blk512_arm64_p1_final
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    cmp x3, #14
    b.eq v512_4blk512_arm64_p1_final
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    zip1 v26.16b, v0.16b, v2.16b
    zip2 v27.16b, v0.16b, v2.16b
    zip1 v28.16b, v1.16b, v3.16b
    zip2 v29.16b, v1.16b, v3.16b
    zip1 v0.16b, v26.16b, v28.16b
    zip2 v2.16b, v26.16b, v28.16b
    zip1 v1.16b, v27.16b, v29.16b
    zip2 v3.16b, v27.16b, v29.16b
    aese v4.16b, v30.16b
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
    zip1 v26.16b, v4.16b, v6.16b
    zip2 v27.16b, v4.16b, v6.16b
    zip1 v28.16b, v5.16b, v7.16b
    zip2 v29.16b, v5.16b, v7.16b
    zip1 v4.16b, v26.16b, v28.16b
    zip2 v6.16b, v26.16b, v28.16b
    zip1 v5.16b, v27.16b, v29.16b
    zip2 v7.16b, v27.16b, v29.16b
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
v512_4blk512_arm64_p1_final:
    ld1 { v30.16b }, [x4], #16
    eor v30.16b, v30.16b, v20.16b
    aese v0.16b, v30.16b
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
    aese v4.16b, v30.16b
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
    tbl v20.16b, { v20.16b }, v24.16b
    tbl v21.16b, { v21.16b }, v25.16b
    tbl v22.16b, { v22.16b }, v24.16b
    tbl v23.16b, { v23.16b }, v25.16b
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
    eor v30.16b, v30.16b, v30.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT areion256EMEncryptx4Asm
areion256EMEncryptx4Asm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2], #64
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    ld1 { v20.16b, v21.16b }, [x2], #32
    ld1 { v24.16b, v25.16b }, [x2], #32
    eor v2.16b, v2.16b, v20.16b
    eor v3.16b, v3.16b, v21.16b
    ld1 { v20.16b, v21.16b }, [x2], #32
    ld1 { v26.16b, v27.16b }, [x2], #32
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    ld1 { v20.16b, v21.16b }, [x2], #32
    ld1 { v28.16b, v29.16b }, [x2]
    eor v6.16b, v6.16b, v20.16b
    eor v7.16b, v7.16b, v21.16b
    eor v31.16b, v31.16b, v31.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v23.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
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
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT areion256EMDecryptx4Asm
areion256EMDecryptx4Asm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    ld1 { v22.16b, v23.16b }, [x2], #32
    ld1 { v20.16b, v21.16b }, [x2], #32
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    ld1 { v24.16b, v25.16b }, [x2], #32
    ld1 { v20.16b, v21.16b }, [x2], #32
    eor v2.16b, v2.16b, v20.16b
    eor v3.16b, v3.16b, v21.16b
    ld1 { v26.16b, v27.16b }, [x2], #32
    ld1 { v20.16b, v21.16b }, [x2], #32
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    ld1 { v28.16b, v29.16b }, [x2], #32
    ld1 { v20.16b, v21.16b }, [x2]
    eor v6.16b, v6.16b, v20.16b
    eor v7.16b, v7.16b, v21.16b
    eor v31.16b, v31.16b, v31.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    add x4, x4, #144
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v23.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
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
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT areion512EMEncryptx4Asm
areion512EMEncryptx4Asm PROC
    hint #34 ; bti c
    eor v31.16b, v31.16b, v31.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x1], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x1]
    mov x5, x2
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v16.16b, v16.16b, v24.16b
    eor v17.16b, v17.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v19.16b, v19.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    eor v20.16b, v20.16b, v24.16b
    eor v21.16b, v21.16b, v25.16b
    eor v22.16b, v22.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v30.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v30.16b
    aesmc v20.16b, v20.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v30.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v30.16b
    aesmc v21.16b, v21.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v30.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v30.16b
    aesmc v20.16b, v20.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v30.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v30.16b
    aesmc v21.16b, v21.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v30.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v30.16b
    aesmc v20.16b, v20.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v30.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v30.16b
    aesmc v21.16b, v21.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v30.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v30.16b
    aesmc v20.16b, v20.16b
    add x5, x2, #64
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v3.16b, v3.16b, v24.16b
    eor v0.16b, v0.16b, v25.16b
    eor v1.16b, v1.16b, v26.16b
    eor v2.16b, v2.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v7.16b, v7.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v5.16b, v5.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v19.16b, v19.16b, v24.16b
    eor v16.16b, v16.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v18.16b, v18.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    eor v23.16b, v23.16b, v24.16b
    eor v20.16b, v20.16b, v25.16b
    eor v21.16b, v21.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    st1 { v3.16b }, [x0], #16
    st1 { v0.16b, v1.16b, v2.16b }, [x0], #48
    st1 { v7.16b }, [x0], #16
    st1 { v4.16b, v5.16b, v6.16b }, [x0], #48
    st1 { v19.16b }, [x0], #16
    st1 { v16.16b, v17.16b, v18.16b }, [x0], #48
    st1 { v23.16b }, [x0], #16
    st1 { v20.16b, v21.16b, v22.16b }, [x0]
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
    eor v30.16b, v30.16b, v30.16b
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    mov x5, xzr
    ret
    ENDP

    EXPORT areion512EMDecryptx4Asm
areion512EMDecryptx4Asm PROC
    hint #34 ; bti c
    eor v31.16b, v31.16b, v31.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x1], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x1]
    add x5, x2, #64
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v16.16b, v16.16b, v24.16b
    eor v17.16b, v17.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v19.16b, v19.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    eor v20.16b, v20.16b, v24.16b
    eor v21.16b, v21.16b, v25.16b
    eor v22.16b, v22.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    add x4, x4, #224
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v17.16b, v31.16b
    aesd v21.16b, v31.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v3.16b, v30.16b
    eor v25.16b, v7.16b, v30.16b
    eor v26.16b, v19.16b, v30.16b
    eor v27.16b, v23.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesd v19.16b, v30.16b
    aesd v23.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v16.16b, v31.16b
    aesd v20.16b, v31.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    eor v24.16b, v2.16b, v30.16b
    eor v25.16b, v6.16b, v30.16b
    eor v26.16b, v18.16b, v30.16b
    eor v27.16b, v22.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v18.16b, v30.16b
    aesd v22.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v17.16b, v31.16b
    aesd v21.16b, v31.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v3.16b, v30.16b
    eor v25.16b, v7.16b, v30.16b
    eor v26.16b, v19.16b, v30.16b
    eor v27.16b, v23.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesd v19.16b, v30.16b
    aesd v23.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v16.16b, v31.16b
    aesd v20.16b, v31.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    eor v24.16b, v2.16b, v30.16b
    eor v25.16b, v6.16b, v30.16b
    eor v26.16b, v18.16b, v30.16b
    eor v27.16b, v22.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v18.16b, v30.16b
    aesd v22.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v17.16b, v31.16b
    aesd v21.16b, v31.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v3.16b, v30.16b
    eor v25.16b, v7.16b, v30.16b
    eor v26.16b, v19.16b, v30.16b
    eor v27.16b, v23.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesd v19.16b, v30.16b
    aesd v23.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v16.16b, v31.16b
    aesd v20.16b, v31.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    eor v24.16b, v2.16b, v30.16b
    eor v25.16b, v6.16b, v30.16b
    eor v26.16b, v18.16b, v30.16b
    eor v27.16b, v22.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v18.16b, v30.16b
    aesd v22.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v30.16b }, [x4]
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v17.16b, v31.16b
    aesd v21.16b, v31.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v3.16b, v30.16b
    eor v25.16b, v7.16b, v30.16b
    eor v26.16b, v19.16b, v30.16b
    eor v27.16b, v23.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesd v19.16b, v30.16b
    aesd v23.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    mov x5, x2
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v1.16b, v1.16b, v24.16b
    eor v2.16b, v2.16b, v25.16b
    eor v3.16b, v3.16b, v26.16b
    eor v0.16b, v0.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v5.16b, v5.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v7.16b, v7.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v17.16b, v17.16b, v24.16b
    eor v18.16b, v18.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v16.16b, v16.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    eor v21.16b, v21.16b, v24.16b
    eor v22.16b, v22.16b, v25.16b
    eor v23.16b, v23.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    st1 { v1.16b, v2.16b, v3.16b }, [x0], #48
    st1 { v0.16b }, [x0], #16
    st1 { v5.16b, v6.16b, v7.16b }, [x0], #48
    st1 { v4.16b }, [x0], #16
    st1 { v17.16b, v18.16b, v19.16b }, [x0], #48
    st1 { v16.16b }, [x0], #16
    st1 { v21.16b, v22.16b, v23.16b }, [x0], #48
    st1 { v20.16b }, [x0]
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
    eor v30.16b, v30.16b, v30.16b
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    mov x5, xzr
    ret
    ENDP

    EXPORT areion256EM2Encryptx4Asm
areion256EM2Encryptx4Asm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    mov x3, x2
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x3], #64
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    ld1 { v20.16b, v21.16b }, [x3], #32
    ld1 { v24.16b, v25.16b }, [x3], #32
    eor v2.16b, v2.16b, v20.16b
    eor v3.16b, v3.16b, v21.16b
    ld1 { v20.16b, v21.16b }, [x3], #32
    ld1 { v26.16b, v27.16b }, [x3], #32
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    ld1 { v20.16b, v21.16b }, [x3], #32
    ld1 { v28.16b, v29.16b }, [x3]
    eor v6.16b, v6.16b, v20.16b
    eor v7.16b, v7.16b, v21.16b
    eor v31.16b, v31.16b, v31.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v23.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v16.16b, v17.16b }, [x2]
    add x2, x2, #64
    eor v22.16b, v22.16b, v16.16b
    eor v23.16b, v23.16b, v17.16b
    ld1 { v16.16b, v17.16b }, [x2]
    add x2, x2, #64
    eor v24.16b, v24.16b, v16.16b
    eor v25.16b, v25.16b, v17.16b
    ld1 { v16.16b, v17.16b }, [x2]
    add x2, x2, #64
    eor v26.16b, v26.16b, v16.16b
    eor v27.16b, v27.16b, v17.16b
    ld1 { v16.16b, v17.16b }, [x2]
    eor v28.16b, v28.16b, v16.16b
    eor v29.16b, v29.16b, v17.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v23.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
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
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT areion256EM2Decryptx4Asm
areion256EM2Decryptx4Asm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    mov x3, x2
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x3], #64
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v23.16b
    ld1 { v20.16b, v21.16b }, [x3], #32
    ld1 { v24.16b, v25.16b }, [x3], #32
    eor v2.16b, v2.16b, v20.16b
    eor v3.16b, v3.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    ld1 { v20.16b, v21.16b }, [x3], #32
    ld1 { v26.16b, v27.16b }, [x3], #32
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    ld1 { v20.16b, v21.16b }, [x3], #32
    ld1 { v28.16b, v29.16b }, [x3]
    eor v6.16b, v6.16b, v20.16b
    eor v7.16b, v7.16b, v21.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    eor v31.16b, v31.16b, v31.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    add x4, x4, #144
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v23.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v22.16b, v23.16b }, [x2]
    add x2, x2, #64
    ld1 { v24.16b, v25.16b }, [x2]
    add x2, x2, #64
    ld1 { v26.16b, v27.16b }, [x2]
    add x2, x2, #64
    ld1 { v28.16b, v29.16b }, [x2]
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    add x4, x4, #144
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v23.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
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
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT areion512EM2Encryptx4Asm
areion512EM2Encryptx4Asm PROC
    hint #34 ; bti c
    eor v31.16b, v31.16b, v31.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x1], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x1]
    mov x5, x2
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v16.16b, v16.16b, v24.16b
    eor v17.16b, v17.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v19.16b, v19.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    eor v20.16b, v20.16b, v24.16b
    eor v21.16b, v21.16b, v25.16b
    eor v22.16b, v22.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v30.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v30.16b
    aesmc v20.16b, v20.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v30.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v30.16b
    aesmc v21.16b, v21.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v30.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v30.16b
    aesmc v20.16b, v20.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v30.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v30.16b
    aesmc v21.16b, v21.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v30.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v30.16b
    aesmc v20.16b, v20.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v30.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v30.16b
    aesmc v21.16b, v21.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v30.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v30.16b
    aesmc v20.16b, v20.16b
    add x5, x2, #64
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v3.16b, v3.16b, v24.16b
    eor v0.16b, v0.16b, v25.16b
    eor v1.16b, v1.16b, v26.16b
    eor v2.16b, v2.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v7.16b, v7.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v5.16b, v5.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v19.16b, v19.16b, v24.16b
    eor v16.16b, v16.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v18.16b, v18.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    eor v23.16b, v23.16b, v24.16b
    eor v20.16b, v20.16b, v25.16b
    eor v21.16b, v21.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v30.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v30.16b
    aesmc v21.16b, v21.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v30.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v30.16b
    aesmc v20.16b, v20.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v30.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v30.16b
    aesmc v21.16b, v21.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v30.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v30.16b
    aesmc v20.16b, v20.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v30.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v30.16b
    aesmc v21.16b, v21.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    aese v16.16b, v30.16b
    aesmc v16.16b, v16.16b
    aese v20.16b, v30.16b
    aesmc v20.16b, v20.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    aese v17.16b, v30.16b
    aesmc v17.16b, v17.16b
    aese v21.16b, v30.16b
    aesmc v21.16b, v21.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v16.16b, v31.16b
    aese v20.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v18.16b, v31.16b
    aese v22.16b, v31.16b
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    aese v18.16b, v30.16b
    aesmc v18.16b, v18.16b
    aese v22.16b, v30.16b
    aesmc v22.16b, v22.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v17.16b, v31.16b
    aese v21.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v19.16b, v31.16b
    aese v23.16b, v31.16b
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    aese v19.16b, v30.16b
    aesmc v19.16b, v19.16b
    aese v23.16b, v30.16b
    aesmc v23.16b, v23.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2], #64
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2], #64
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2], #64
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2], #64
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2], #64
    eor v18.16b, v18.16b, v24.16b
    eor v19.16b, v19.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v17.16b, v17.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2], #64
    eor v18.16b, v18.16b, v24.16b
    eor v19.16b, v19.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v17.16b, v17.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2], #64
    eor v22.16b, v22.16b, v24.16b
    eor v23.16b, v23.16b, v25.16b
    eor v20.16b, v20.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2]
    eor v22.16b, v22.16b, v24.16b
    eor v23.16b, v23.16b, v25.16b
    eor v20.16b, v20.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    st1 { v2.16b, v3.16b }, [x0], #32
    st1 { v0.16b, v1.16b }, [x0], #32
    st1 { v6.16b, v7.16b }, [x0], #32
    st1 { v4.16b, v5.16b }, [x0], #32
    st1 { v18.16b, v19.16b }, [x0], #32
    st1 { v16.16b, v17.16b }, [x0], #32
    st1 { v22.16b, v23.16b }, [x0], #32
    st1 { v20.16b, v21.16b }, [x0]
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
    eor v30.16b, v30.16b, v30.16b
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    mov x5, xzr
    ret
    ENDP

    EXPORT areion512EM2Decryptx4Asm
areion512EM2Decryptx4Asm PROC
    hint #34 ; bti c
    eor v31.16b, v31.16b, v31.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x1], #64
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x1]
    mov x5, x2
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5], #64
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5], #64
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5], #64
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5], #64
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5], #64
    eor v16.16b, v16.16b, v24.16b
    eor v17.16b, v17.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v19.16b, v19.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5], #64
    eor v16.16b, v16.16b, v24.16b
    eor v17.16b, v17.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v19.16b, v19.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5], #64
    eor v20.16b, v20.16b, v24.16b
    eor v21.16b, v21.16b, v25.16b
    eor v22.16b, v22.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    eor v20.16b, v20.16b, v24.16b
    eor v21.16b, v21.16b, v25.16b
    eor v22.16b, v22.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    add x4, x4, #224
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v17.16b, v31.16b
    aesd v21.16b, v31.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v3.16b, v30.16b
    eor v25.16b, v7.16b, v30.16b
    eor v26.16b, v19.16b, v30.16b
    eor v27.16b, v23.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesd v19.16b, v30.16b
    aesd v23.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v16.16b, v31.16b
    aesd v20.16b, v31.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    eor v24.16b, v2.16b, v30.16b
    eor v25.16b, v6.16b, v30.16b
    eor v26.16b, v18.16b, v30.16b
    eor v27.16b, v22.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v18.16b, v30.16b
    aesd v22.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v17.16b, v31.16b
    aesd v21.16b, v31.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v3.16b, v30.16b
    eor v25.16b, v7.16b, v30.16b
    eor v26.16b, v19.16b, v30.16b
    eor v27.16b, v23.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesd v19.16b, v30.16b
    aesd v23.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v16.16b, v31.16b
    aesd v20.16b, v31.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    eor v24.16b, v2.16b, v30.16b
    eor v25.16b, v6.16b, v30.16b
    eor v26.16b, v18.16b, v30.16b
    eor v27.16b, v22.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v18.16b, v30.16b
    aesd v22.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v17.16b, v31.16b
    aesd v21.16b, v31.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v3.16b, v30.16b
    eor v25.16b, v7.16b, v30.16b
    eor v26.16b, v19.16b, v30.16b
    eor v27.16b, v23.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesd v19.16b, v30.16b
    aesd v23.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v16.16b, v31.16b
    aesd v20.16b, v31.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    eor v24.16b, v2.16b, v30.16b
    eor v25.16b, v6.16b, v30.16b
    eor v26.16b, v18.16b, v30.16b
    eor v27.16b, v22.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v18.16b, v30.16b
    aesd v22.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v30.16b }, [x4]
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v17.16b, v31.16b
    aesd v21.16b, v31.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v3.16b, v30.16b
    eor v25.16b, v7.16b, v30.16b
    eor v26.16b, v19.16b, v30.16b
    eor v27.16b, v23.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesd v19.16b, v30.16b
    aesd v23.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    add x5, x2, #64
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v1.16b, v1.16b, v24.16b
    eor v2.16b, v2.16b, v25.16b
    eor v3.16b, v3.16b, v26.16b
    eor v0.16b, v0.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v5.16b, v5.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v7.16b, v7.16b, v26.16b
    eor v4.16b, v4.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    add x5, x5, #128
    eor v17.16b, v17.16b, v24.16b
    eor v18.16b, v18.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v16.16b, v16.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x5]
    eor v21.16b, v21.16b, v24.16b
    eor v22.16b, v22.16b, v25.16b
    eor v23.16b, v23.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    add x4, x4, #224
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v16.16b, v31.16b
    aesd v20.16b, v31.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    eor v24.16b, v2.16b, v30.16b
    eor v25.16b, v6.16b, v30.16b
    eor v26.16b, v18.16b, v30.16b
    eor v27.16b, v22.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v18.16b, v30.16b
    aesd v22.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v17.16b, v31.16b
    aesd v21.16b, v31.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v3.16b, v30.16b
    eor v25.16b, v7.16b, v30.16b
    eor v26.16b, v19.16b, v30.16b
    eor v27.16b, v23.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesd v19.16b, v30.16b
    aesd v23.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v16.16b, v31.16b
    aesd v20.16b, v31.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    eor v24.16b, v2.16b, v30.16b
    eor v25.16b, v6.16b, v30.16b
    eor v26.16b, v18.16b, v30.16b
    eor v27.16b, v22.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v18.16b, v30.16b
    aesd v22.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v17.16b, v31.16b
    aesd v21.16b, v31.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v3.16b, v30.16b
    eor v25.16b, v7.16b, v30.16b
    eor v26.16b, v19.16b, v30.16b
    eor v27.16b, v23.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesd v19.16b, v30.16b
    aesd v23.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v16.16b, v31.16b
    aesd v20.16b, v31.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    eor v24.16b, v2.16b, v30.16b
    eor v25.16b, v6.16b, v30.16b
    eor v26.16b, v18.16b, v30.16b
    eor v27.16b, v22.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v18.16b, v30.16b
    aesd v22.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v1.16b
    aesmc v25.16b, v5.16b
    aesmc v26.16b, v17.16b
    aesmc v27.16b, v21.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v17.16b, v31.16b
    aesd v21.16b, v31.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    aesimc v19.16b, v19.16b
    aesd v19.16b, v31.16b
    aesimc v23.16b, v23.16b
    aesd v23.16b, v31.16b
    eor v24.16b, v3.16b, v30.16b
    eor v25.16b, v7.16b, v30.16b
    eor v26.16b, v19.16b, v30.16b
    eor v27.16b, v23.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesd v19.16b, v30.16b
    aesd v23.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v0.16b
    aesmc v25.16b, v4.16b
    aesmc v26.16b, v16.16b
    aesmc v27.16b, v20.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v16.16b, v31.16b
    aesd v20.16b, v31.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    aesimc v18.16b, v18.16b
    aesd v18.16b, v31.16b
    aesimc v22.16b, v22.16b
    aesd v22.16b, v31.16b
    eor v24.16b, v2.16b, v30.16b
    eor v25.16b, v6.16b, v30.16b
    eor v26.16b, v18.16b, v30.16b
    eor v27.16b, v22.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesd v18.16b, v30.16b
    aesd v22.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v24.16b, v3.16b
    aesmc v25.16b, v7.16b
    aesmc v26.16b, v19.16b
    aesmc v27.16b, v23.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    aesd v19.16b, v31.16b
    aesd v23.16b, v31.16b
    eor v0.16b, v0.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v20.16b, v20.16b, v27.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    aesimc v17.16b, v17.16b
    aesd v17.16b, v31.16b
    aesimc v21.16b, v21.16b
    aesd v21.16b, v31.16b
    eor v24.16b, v1.16b, v30.16b
    eor v25.16b, v5.16b, v30.16b
    eor v26.16b, v17.16b, v30.16b
    eor v27.16b, v21.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesd v17.16b, v30.16b
    aesd v21.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v2.16b, v2.16b, v24.16b
    eor v6.16b, v6.16b, v25.16b
    eor v18.16b, v18.16b, v26.16b
    eor v22.16b, v22.16b, v27.16b
    ld1 { v30.16b }, [x4]
    aesmc v24.16b, v2.16b
    aesmc v25.16b, v6.16b
    aesmc v26.16b, v18.16b
    aesmc v27.16b, v22.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    aesd v18.16b, v31.16b
    aesd v22.16b, v31.16b
    eor v3.16b, v3.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v19.16b, v19.16b, v26.16b
    eor v23.16b, v23.16b, v27.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    aesimc v16.16b, v16.16b
    aesd v16.16b, v31.16b
    aesimc v20.16b, v20.16b
    aesd v20.16b, v31.16b
    eor v24.16b, v0.16b, v30.16b
    eor v25.16b, v4.16b, v30.16b
    eor v26.16b, v16.16b, v30.16b
    eor v27.16b, v20.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesd v16.16b, v30.16b
    aesd v20.16b, v30.16b
    aesmc v24.16b, v24.16b
    aesmc v25.16b, v25.16b
    aesmc v26.16b, v26.16b
    aesmc v27.16b, v27.16b
    eor v1.16b, v1.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v17.16b, v17.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2]
    add x2, x2, #128
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v0.16b, v0.16b, v26.16b
    eor v1.16b, v1.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2]
    add x2, x2, #128
    eor v6.16b, v6.16b, v24.16b
    eor v7.16b, v7.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2]
    add x2, x2, #128
    eor v18.16b, v18.16b, v24.16b
    eor v19.16b, v19.16b, v25.16b
    eor v16.16b, v16.16b, v26.16b
    eor v17.16b, v17.16b, v27.16b
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2]
    eor v22.16b, v22.16b, v24.16b
    eor v23.16b, v23.16b, v25.16b
    eor v20.16b, v20.16b, v26.16b
    eor v21.16b, v21.16b, v27.16b
    st1 { v2.16b, v3.16b }, [x0], #32
    st1 { v0.16b, v1.16b }, [x0], #32
    st1 { v6.16b, v7.16b }, [x0], #32
    st1 { v4.16b, v5.16b }, [x0], #32
    st1 { v18.16b, v19.16b }, [x0], #32
    st1 { v16.16b, v17.16b }, [x0], #32
    st1 { v22.16b, v23.16b }, [x0], #32
    st1 { v20.16b, v21.16b }, [x0]
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
    eor v30.16b, v30.16b, v30.16b
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x4, xzr
    mov x5, xzr
    ret
    ENDP

    EXPORT areion256TEMEncryptx4Asm
areion256TEMEncryptx4Asm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x3]
    ld1 { v22.16b, v23.16b }, [x2], #32
    ld1 { v20.16b, v21.16b }, [x2], #32
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    ld1 { v24.16b, v25.16b }, [x2], #32
    ld1 { v20.16b, v21.16b }, [x2], #32
    eor v2.16b, v2.16b, v20.16b
    eor v3.16b, v3.16b, v21.16b
    ld1 { v26.16b, v27.16b }, [x2], #32
    ld1 { v20.16b, v21.16b }, [x2], #32
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    ld1 { v28.16b, v29.16b }, [x2], #32
    ld1 { v20.16b, v21.16b }, [x2]
    eor v6.16b, v6.16b, v20.16b
    eor v7.16b, v7.16b, v21.16b
    eor v31.16b, v31.16b, v31.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    eor v22.16b, v22.16b, v0.16b
    eor v23.16b, v23.16b, v1.16b
    eor v24.16b, v24.16b, v2.16b
    eor v25.16b, v25.16b, v3.16b
    eor v26.16b, v26.16b, v4.16b
    eor v27.16b, v27.16b, v5.16b
    eor v28.16b, v28.16b, v6.16b
    eor v29.16b, v29.16b, v7.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v23.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v23.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
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
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT areion256TEMDecryptx4Asm
areion256TEMDecryptx4Asm PROC
    hint #34 ; bti c
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x3]
    ld1 { v22.16b, v23.16b }, [x2], #32
    ld1 { v20.16b, v21.16b }, [x2], #32
    eor v0.16b, v0.16b, v20.16b
    eor v1.16b, v1.16b, v21.16b
    ld1 { v24.16b, v25.16b }, [x2], #32
    ld1 { v20.16b, v21.16b }, [x2], #32
    eor v2.16b, v2.16b, v20.16b
    eor v3.16b, v3.16b, v21.16b
    ld1 { v26.16b, v27.16b }, [x2], #32
    ld1 { v20.16b, v21.16b }, [x2], #32
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    ld1 { v28.16b, v29.16b }, [x2], #32
    ld1 { v20.16b, v21.16b }, [x2]
    eor v6.16b, v6.16b, v20.16b
    eor v7.16b, v7.16b, v21.16b
    eor v31.16b, v31.16b, v31.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aese v4.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aese v5.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    eor v22.16b, v22.16b, v0.16b
    eor v23.16b, v23.16b, v1.16b
    eor v24.16b, v24.16b, v2.16b
    eor v25.16b, v25.16b, v3.16b
    eor v26.16b, v26.16b, v4.16b
    eor v27.16b, v27.16b, v5.16b
    eor v28.16b, v28.16b, v6.16b
    eor v29.16b, v29.16b, v7.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v23.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    add x4, x4, #144
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v31.16b
    aesd v3.16b, v31.16b
    aesd v5.16b, v31.16b
    aesd v7.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v31.16b
    aesd v2.16b, v31.16b
    aesd v4.16b, v31.16b
    aesd v6.16b, v31.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    eor v0.16b, v0.16b, v22.16b
    eor v1.16b, v1.16b, v23.16b
    eor v2.16b, v2.16b, v24.16b
    eor v3.16b, v3.16b, v25.16b
    eor v4.16b, v4.16b, v26.16b
    eor v5.16b, v5.16b, v27.16b
    eor v6.16b, v6.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
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
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    mov x3, xzr
    mov x4, xzr
    ret
    ENDP

    EXPORT areion512TEMEncryptx4Asm
areion512TEMEncryptx4Asm PROC
    hint #34 ; bti c
    eor v31.16b, v31.16b, v31.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x3], #64
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2], #64
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2], #64
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2], #64
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    eor v16.16b, v16.16b, v3.16b
    eor v17.16b, v17.16b, v0.16b
    eor v18.16b, v18.16b, v1.16b
    eor v19.16b, v19.16b, v2.16b
    eor v20.16b, v20.16b, v7.16b
    eor v21.16b, v21.16b, v4.16b
    eor v22.16b, v22.16b, v5.16b
    eor v23.16b, v23.16b, v6.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    eor v3.16b, v3.16b, v16.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v19.16b
    eor v7.16b, v7.16b, v20.16b
    eor v4.16b, v4.16b, v21.16b
    eor v5.16b, v5.16b, v22.16b
    eor v6.16b, v6.16b, v23.16b
    st1 { v3.16b }, [x0], #16
    st1 { v0.16b, v1.16b, v2.16b }, [x0], #48
    st1 { v7.16b }, [x0], #16
    st1 { v4.16b, v5.16b, v6.16b }, [x0], #48
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x3]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2], #64
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2], #64
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2]
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    eor v16.16b, v16.16b, v3.16b
    eor v17.16b, v17.16b, v0.16b
    eor v18.16b, v18.16b, v1.16b
    eor v19.16b, v19.16b, v2.16b
    eor v20.16b, v20.16b, v7.16b
    eor v21.16b, v21.16b, v4.16b
    eor v22.16b, v22.16b, v5.16b
    eor v23.16b, v23.16b, v6.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    eor v3.16b, v3.16b, v16.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v19.16b
    eor v7.16b, v7.16b, v20.16b
    eor v4.16b, v4.16b, v21.16b
    eor v5.16b, v5.16b, v22.16b
    eor v6.16b, v6.16b, v23.16b
    st1 { v3.16b }, [x0], #16
    st1 { v0.16b, v1.16b, v2.16b }, [x0], #48
    st1 { v7.16b }, [x0], #16
    st1 { v4.16b, v5.16b, v6.16b }, [x0]
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
    ret
    ENDP

    EXPORT areion512TEMDecryptx4Asm
areion512TEMDecryptx4Asm PROC
    hint #34 ; bti c
    eor v31.16b, v31.16b, v31.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x3], #64
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2], #64
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2], #64
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2], #64
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    eor v16.16b, v16.16b, v3.16b
    eor v17.16b, v17.16b, v0.16b
    eor v18.16b, v18.16b, v1.16b
    eor v19.16b, v19.16b, v2.16b
    eor v20.16b, v20.16b, v7.16b
    eor v21.16b, v21.16b, v4.16b
    eor v22.16b, v22.16b, v5.16b
    eor v23.16b, v23.16b, v6.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    add x4, x4, #224
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    eor v1.16b, v1.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v3.16b, v3.16b, v18.16b
    eor v0.16b, v0.16b, v19.16b
    eor v5.16b, v5.16b, v20.16b
    eor v6.16b, v6.16b, v21.16b
    eor v7.16b, v7.16b, v22.16b
    eor v4.16b, v4.16b, v23.16b
    st1 { v1.16b, v2.16b, v3.16b }, [x0], #48
    st1 { v0.16b }, [x0], #16
    st1 { v5.16b, v6.16b, v7.16b }, [x0], #48
    st1 { v4.16b }, [x0], #16
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x3]
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2], #64
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x2], #64
    ld1 { v24.16b, v25.16b, v26.16b, v27.16b }, [x2]
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    eor v16.16b, v16.16b, v3.16b
    eor v17.16b, v17.16b, v0.16b
    eor v18.16b, v18.16b, v1.16b
    eor v19.16b, v19.16b, v2.16b
    eor v20.16b, v20.16b, v7.16b
    eor v21.16b, v21.16b, v4.16b
    eor v22.16b, v22.16b, v5.16b
    eor v23.16b, v23.16b, v6.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    add x4, x4, #224
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    eor v1.16b, v1.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v3.16b, v3.16b, v18.16b
    eor v0.16b, v0.16b, v19.16b
    eor v5.16b, v5.16b, v20.16b
    eor v6.16b, v6.16b, v21.16b
    eor v7.16b, v7.16b, v22.16b
    eor v4.16b, v4.16b, v23.16b
    st1 { v1.16b, v2.16b, v3.16b }, [x0], #48
    st1 { v0.16b }, [x0], #16
    st1 { v5.16b, v6.16b, v7.16b }, [x0], #48
    st1 { v4.16b }, [x0]
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
    ret
    ENDP

    EXPORT areion256TEM2Encryptx4Asm
areion256TEM2Encryptx4Asm PROC
    hint #34 ; bti c
    mov x5, x3
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x5], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x5]
    mov x5, x2
    ld1 { v24.16b, v25.16b }, [x5]
    add x5, x5, #64
    ld1 { v26.16b, v27.16b }, [x5]
    add x5, x5, #64
    ld1 { v28.16b, v29.16b }, [x5]
    add x5, x5, #64
    ld1 { v30.16b, v31.16b }, [x5]
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    eor v6.16b, v6.16b, v30.16b
    eor v7.16b, v7.16b, v31.16b
    eor v21.16b, v21.16b, v21.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    eor v24.16b, v24.16b, v0.16b
    eor v25.16b, v25.16b, v1.16b
    eor v26.16b, v26.16b, v2.16b
    eor v27.16b, v27.16b, v3.16b
    eor v28.16b, v28.16b, v4.16b
    eor v29.16b, v29.16b, v5.16b
    eor v30.16b, v30.16b, v6.16b
    eor v31.16b, v31.16b, v7.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    eor v6.16b, v6.16b, v30.16b
    eor v7.16b, v7.16b, v31.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    fmov x6, d0
    fmov x7, v0.d[1]
    fmov x8, d1
    fmov x9, v1.d[1]
    fmov x10, d2
    fmov x11, v2.d[1]
    fmov x12, d3
    fmov x13, v3.d[1]
    fmov x14, d4
    fmov x15, v4.d[1]
    fmov x16, d5
    fmov x17, v5.d[1]
    mov v22.16b, v6.16b
    mov v23.16b, v7.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x3]
    add x5, x2, #32
    ld1 { v16.16b, v17.16b }, [x5]
    add x5, x5, #64
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    ld1 { v16.16b, v17.16b }, [x5]
    add x5, x5, #64
    eor v2.16b, v2.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    ld1 { v16.16b, v17.16b }, [x5]
    add x5, x5, #64
    eor v4.16b, v4.16b, v16.16b
    eor v5.16b, v5.16b, v17.16b
    ld1 { v16.16b, v17.16b }, [x5]
    eor v6.16b, v6.16b, v16.16b
    eor v7.16b, v7.16b, v17.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    add x5, x2, #32
    ld1 { v16.16b, v17.16b }, [x5]
    add x5, x5, #64
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    ld1 { v16.16b, v17.16b }, [x5]
    add x5, x5, #64
    eor v2.16b, v2.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    ld1 { v16.16b, v17.16b }, [x5]
    add x5, x5, #64
    eor v4.16b, v4.16b, v16.16b
    eor v5.16b, v5.16b, v17.16b
    ld1 { v16.16b, v17.16b }, [x5]
    eor v6.16b, v6.16b, v16.16b
    eor v7.16b, v7.16b, v17.16b
    eor v24.16b, v24.16b, v0.16b
    eor v25.16b, v25.16b, v1.16b
    eor v26.16b, v26.16b, v2.16b
    eor v27.16b, v27.16b, v3.16b
    eor v28.16b, v28.16b, v4.16b
    eor v29.16b, v29.16b, v5.16b
    eor v30.16b, v30.16b, v6.16b
    eor v31.16b, v31.16b, v7.16b
    fmov d16, x6
    fmov v16.d[1], x7
    eor v0.16b, v0.16b, v16.16b
    fmov d16, x8
    fmov v16.d[1], x9
    eor v1.16b, v1.16b, v16.16b
    fmov d16, x10
    fmov v16.d[1], x11
    eor v2.16b, v2.16b, v16.16b
    fmov d16, x12
    fmov v16.d[1], x13
    eor v3.16b, v3.16b, v16.16b
    fmov d16, x14
    fmov v16.d[1], x15
    eor v4.16b, v4.16b, v16.16b
    fmov d16, x16
    fmov v16.d[1], x17
    eor v5.16b, v5.16b, v16.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    eor v6.16b, v6.16b, v30.16b
    eor v7.16b, v7.16b, v31.16b
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
    ENDP

    EXPORT areion256TEM2Decryptx4Asm
areion256TEM2Decryptx4Asm PROC
    hint #34 ; bti c
    mov x5, x3
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x5], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x5]
    mov x5, x2
    ld1 { v24.16b, v25.16b }, [x5]
    add x5, x5, #64
    ld1 { v26.16b, v27.16b }, [x5]
    add x5, x5, #64
    ld1 { v28.16b, v29.16b }, [x5]
    add x5, x5, #64
    ld1 { v30.16b, v31.16b }, [x5]
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    eor v6.16b, v6.16b, v30.16b
    eor v7.16b, v7.16b, v31.16b
    eor v21.16b, v21.16b, v21.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    eor v24.16b, v24.16b, v0.16b
    eor v25.16b, v25.16b, v1.16b
    eor v26.16b, v26.16b, v2.16b
    eor v27.16b, v27.16b, v3.16b
    eor v28.16b, v28.16b, v4.16b
    eor v29.16b, v29.16b, v5.16b
    eor v30.16b, v30.16b, v6.16b
    eor v31.16b, v31.16b, v7.16b
    fmov x6, d24
    fmov x7, v24.d[1]
    fmov x8, d25
    fmov x9, v25.d[1]
    fmov x10, d26
    fmov x11, v26.d[1]
    fmov x12, d27
    fmov x13, v27.d[1]
    fmov x14, d28
    fmov x15, v28.d[1]
    fmov x16, d29
    fmov x17, v29.d[1]
    mov v22.16b, v30.16b
    mov v23.16b, v31.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x3]
    add x5, x2, #32
    ld1 { v24.16b, v25.16b }, [x5]
    add x5, x5, #64
    ld1 { v26.16b, v27.16b }, [x5]
    add x5, x5, #64
    ld1 { v28.16b, v29.16b }, [x5]
    add x5, x5, #64
    ld1 { v30.16b, v31.16b }, [x5]
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    eor v6.16b, v6.16b, v30.16b
    eor v7.16b, v7.16b, v31.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v0.16b, v21.16b
    aese v2.16b, v21.16b
    aese v4.16b, v21.16b
    aese v6.16b, v21.16b
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4], #16
    aese v1.16b, v21.16b
    aese v3.16b, v21.16b
    aese v5.16b, v21.16b
    aese v7.16b, v21.16b
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    eor v24.16b, v24.16b, v0.16b
    eor v25.16b, v25.16b, v1.16b
    eor v26.16b, v26.16b, v2.16b
    eor v27.16b, v27.16b, v3.16b
    eor v28.16b, v28.16b, v4.16b
    eor v29.16b, v29.16b, v5.16b
    eor v30.16b, v30.16b, v6.16b
    eor v31.16b, v31.16b, v7.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    eor v6.16b, v6.16b, v30.16b
    eor v7.16b, v7.16b, v31.16b
    fmov d16, x6
    fmov v16.d[1], x7
    eor v0.16b, v0.16b, v16.16b
    fmov d16, x8
    fmov v16.d[1], x9
    eor v1.16b, v1.16b, v16.16b
    fmov d16, x10
    fmov v16.d[1], x11
    eor v2.16b, v2.16b, v16.16b
    fmov d16, x12
    fmov v16.d[1], x13
    eor v3.16b, v3.16b, v16.16b
    fmov d16, x14
    fmov v16.d[1], x15
    eor v4.16b, v4.16b, v16.16b
    fmov d16, x16
    fmov v16.d[1], x17
    eor v5.16b, v5.16b, v16.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    add x4, x4, #144
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v21.16b
    aesd v3.16b, v21.16b
    aesd v5.16b, v21.16b
    aesd v7.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v21.16b
    aesd v2.16b, v21.16b
    aesd v4.16b, v21.16b
    aesd v6.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v21.16b
    aesd v3.16b, v21.16b
    aesd v5.16b, v21.16b
    aesd v7.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v21.16b
    aesd v2.16b, v21.16b
    aesd v4.16b, v21.16b
    aesd v6.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v21.16b
    aesd v3.16b, v21.16b
    aesd v5.16b, v21.16b
    aesd v7.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v21.16b
    aesd v2.16b, v21.16b
    aesd v4.16b, v21.16b
    aesd v6.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v21.16b
    aesd v3.16b, v21.16b
    aesd v5.16b, v21.16b
    aesd v7.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v21.16b
    aesd v2.16b, v21.16b
    aesd v4.16b, v21.16b
    aesd v6.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v21.16b
    aesd v3.16b, v21.16b
    aesd v5.16b, v21.16b
    aesd v7.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v21.16b
    aesd v2.16b, v21.16b
    aesd v4.16b, v21.16b
    aesd v6.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    eor v6.16b, v6.16b, v30.16b
    eor v7.16b, v7.16b, v31.16b
    fmov d24, x6
    fmov v24.d[1], x7
    fmov d25, x8
    fmov v25.d[1], x9
    fmov d26, x10
    fmov v26.d[1], x11
    fmov d27, x12
    fmov v27.d[1], x13
    fmov d28, x14
    fmov v28.d[1], x15
    fmov d29, x16
    fmov v29.d[1], x17
    mov v30.16b, v22.16b
    mov v31.16b, v23.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    add x4, x4, #144
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v21.16b
    aesd v3.16b, v21.16b
    aesd v5.16b, v21.16b
    aesd v7.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v21.16b
    aesd v2.16b, v21.16b
    aesd v4.16b, v21.16b
    aesd v6.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v21.16b
    aesd v3.16b, v21.16b
    aesd v5.16b, v21.16b
    aesd v7.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v21.16b
    aesd v2.16b, v21.16b
    aesd v4.16b, v21.16b
    aesd v6.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v21.16b
    aesd v3.16b, v21.16b
    aesd v5.16b, v21.16b
    aesd v7.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v21.16b
    aesd v2.16b, v21.16b
    aesd v4.16b, v21.16b
    aesd v6.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v21.16b
    aesd v3.16b, v21.16b
    aesd v5.16b, v21.16b
    aesd v7.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v21.16b
    aesd v2.16b, v21.16b
    aesd v4.16b, v21.16b
    aesd v6.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    ld1 { v20.16b }, [x4]
    sub x4, x4, #16
    aesmc v16.16b, v1.16b
    aesmc v17.16b, v3.16b
    aesmc v18.16b, v5.16b
    aesmc v19.16b, v7.16b
    aesd v1.16b, v21.16b
    aesd v3.16b, v21.16b
    aesd v5.16b, v21.16b
    aesd v7.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v0.16b, v0.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v4.16b, v4.16b, v18.16b
    eor v6.16b, v6.16b, v19.16b
    ld1 { v20.16b }, [x4]
    aesmc v16.16b, v0.16b
    aesmc v17.16b, v2.16b
    aesmc v18.16b, v4.16b
    aesmc v19.16b, v6.16b
    aesd v0.16b, v21.16b
    aesd v2.16b, v21.16b
    aesd v4.16b, v21.16b
    aesd v6.16b, v21.16b
    aese v16.16b, v20.16b
    aesmc v16.16b, v16.16b
    aese v17.16b, v20.16b
    aesmc v17.16b, v17.16b
    aese v18.16b, v20.16b
    aesmc v18.16b, v18.16b
    aese v19.16b, v20.16b
    aesmc v19.16b, v19.16b
    eor v1.16b, v1.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v5.16b, v5.16b, v18.16b
    eor v7.16b, v7.16b, v19.16b
    eor v0.16b, v0.16b, v24.16b
    eor v1.16b, v1.16b, v25.16b
    eor v2.16b, v2.16b, v26.16b
    eor v3.16b, v3.16b, v27.16b
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    eor v6.16b, v6.16b, v30.16b
    eor v7.16b, v7.16b, v31.16b
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
    ENDP

    EXPORT areion512TEM2Encryptx4Asm
areion512TEM2Encryptx4Asm PROC
    hint #34 ; bti c
    eor v31.16b, v31.16b, v31.16b
    mov x5, x3
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x5], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x5]
    mov x5, x2
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x5]
    add x5, x5, #128
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x5]
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    eor v16.16b, v16.16b, v3.16b
    eor v17.16b, v17.16b, v0.16b
    eor v18.16b, v18.16b, v1.16b
    eor v19.16b, v19.16b, v2.16b
    eor v20.16b, v20.16b, v7.16b
    eor v21.16b, v21.16b, v4.16b
    eor v22.16b, v22.16b, v5.16b
    eor v23.16b, v23.16b, v6.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    fmov x6, d3
    fmov x7, v3.d[1]
    fmov x8, d0
    fmov x9, v0.d[1]
    fmov x10, d1
    fmov x11, v1.d[1]
    fmov x12, d2
    fmov x13, v2.d[1]
    mov v24.16b, v7.16b
    mov v25.16b, v4.16b
    mov v26.16b, v5.16b
    mov v27.16b, v6.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x3], #64
    add x5, x2, #64
    ld1 { v28.16b, v29.16b, v30.16b, v31.16b }, [x5]
    add x5, x5, #128
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v29.16b
    eor v2.16b, v2.16b, v30.16b
    eor v3.16b, v3.16b, v31.16b
    ld1 { v28.16b, v29.16b, v30.16b, v31.16b }, [x5]
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    eor v6.16b, v6.16b, v30.16b
    eor v7.16b, v7.16b, v31.16b
    eor v31.16b, v31.16b, v31.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    add x5, x2, #64
    ld1 { v28.16b, v29.16b, v30.16b, v31.16b }, [x5]
    add x5, x5, #128
    eor v3.16b, v3.16b, v28.16b
    eor v0.16b, v0.16b, v29.16b
    eor v1.16b, v1.16b, v30.16b
    eor v2.16b, v2.16b, v31.16b
    ld1 { v28.16b, v29.16b, v30.16b, v31.16b }, [x5]
    eor v7.16b, v7.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    eor v5.16b, v5.16b, v30.16b
    eor v6.16b, v6.16b, v31.16b
    add x2, x2, #256
    eor v16.16b, v16.16b, v3.16b
    eor v17.16b, v17.16b, v0.16b
    eor v18.16b, v18.16b, v1.16b
    eor v19.16b, v19.16b, v2.16b
    eor v20.16b, v20.16b, v7.16b
    eor v21.16b, v21.16b, v4.16b
    eor v22.16b, v22.16b, v5.16b
    eor v23.16b, v23.16b, v6.16b
    fmov d28, x6
    fmov v28.d[1], x7
    eor v3.16b, v3.16b, v28.16b
    fmov d28, x8
    fmov v28.d[1], x9
    eor v0.16b, v0.16b, v28.16b
    fmov d28, x10
    fmov v28.d[1], x11
    eor v1.16b, v1.16b, v28.16b
    fmov d28, x12
    fmov v28.d[1], x13
    eor v2.16b, v2.16b, v28.16b
    eor v7.16b, v7.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v5.16b, v5.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    eor v31.16b, v31.16b, v31.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    eor v2.16b, v2.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    eor v6.16b, v6.16b, v20.16b
    eor v7.16b, v7.16b, v21.16b
    eor v4.16b, v4.16b, v22.16b
    eor v5.16b, v5.16b, v23.16b
    st1 { v2.16b, v3.16b }, [x0], #32
    st1 { v0.16b, v1.16b }, [x0], #32
    st1 { v6.16b, v7.16b }, [x0], #32
    st1 { v4.16b, v5.16b }, [x0], #32
    mov x5, x3
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x5], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x5]
    mov x5, x2
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x5]
    add x5, x5, #128
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x5]
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    eor v16.16b, v16.16b, v3.16b
    eor v17.16b, v17.16b, v0.16b
    eor v18.16b, v18.16b, v1.16b
    eor v19.16b, v19.16b, v2.16b
    eor v20.16b, v20.16b, v7.16b
    eor v21.16b, v21.16b, v4.16b
    eor v22.16b, v22.16b, v5.16b
    eor v23.16b, v23.16b, v6.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    fmov x6, d3
    fmov x7, v3.d[1]
    fmov x8, d0
    fmov x9, v0.d[1]
    fmov x10, d1
    fmov x11, v1.d[1]
    fmov x12, d2
    fmov x13, v2.d[1]
    mov v24.16b, v7.16b
    mov v25.16b, v4.16b
    mov v26.16b, v5.16b
    mov v27.16b, v6.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x3]
    add x5, x2, #64
    ld1 { v28.16b, v29.16b, v30.16b, v31.16b }, [x5]
    add x5, x5, #128
    eor v0.16b, v0.16b, v28.16b
    eor v1.16b, v1.16b, v29.16b
    eor v2.16b, v2.16b, v30.16b
    eor v3.16b, v3.16b, v31.16b
    ld1 { v28.16b, v29.16b, v30.16b, v31.16b }, [x5]
    eor v4.16b, v4.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    eor v6.16b, v6.16b, v30.16b
    eor v7.16b, v7.16b, v31.16b
    eor v31.16b, v31.16b, v31.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    add x5, x2, #64
    ld1 { v28.16b, v29.16b, v30.16b, v31.16b }, [x5]
    add x5, x5, #128
    eor v3.16b, v3.16b, v28.16b
    eor v0.16b, v0.16b, v29.16b
    eor v1.16b, v1.16b, v30.16b
    eor v2.16b, v2.16b, v31.16b
    ld1 { v28.16b, v29.16b, v30.16b, v31.16b }, [x5]
    eor v7.16b, v7.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    eor v5.16b, v5.16b, v30.16b
    eor v6.16b, v6.16b, v31.16b
    eor v16.16b, v16.16b, v3.16b
    eor v17.16b, v17.16b, v0.16b
    eor v18.16b, v18.16b, v1.16b
    eor v19.16b, v19.16b, v2.16b
    eor v20.16b, v20.16b, v7.16b
    eor v21.16b, v21.16b, v4.16b
    eor v22.16b, v22.16b, v5.16b
    eor v23.16b, v23.16b, v6.16b
    fmov d28, x6
    fmov v28.d[1], x7
    eor v3.16b, v3.16b, v28.16b
    fmov d28, x8
    fmov v28.d[1], x9
    eor v0.16b, v0.16b, v28.16b
    fmov d28, x10
    fmov v28.d[1], x11
    eor v1.16b, v1.16b, v28.16b
    fmov d28, x12
    fmov v28.d[1], x13
    eor v2.16b, v2.16b, v28.16b
    eor v7.16b, v7.16b, v24.16b
    eor v4.16b, v4.16b, v25.16b
    eor v5.16b, v5.16b, v26.16b
    eor v6.16b, v6.16b, v27.16b
    eor v31.16b, v31.16b, v31.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    eor v2.16b, v2.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    eor v6.16b, v6.16b, v20.16b
    eor v7.16b, v7.16b, v21.16b
    eor v4.16b, v4.16b, v22.16b
    eor v5.16b, v5.16b, v23.16b
    st1 { v2.16b, v3.16b }, [x0], #32
    st1 { v0.16b, v1.16b }, [x0], #32
    st1 { v6.16b, v7.16b }, [x0], #32
    st1 { v4.16b, v5.16b }, [x0]
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
    mov x8, xzr
    mov x9, xzr
    mov x10, xzr
    mov x11, xzr
    mov x12, xzr
    mov x13, xzr
    ret
    ENDP

    EXPORT areion512TEM2Decryptx4Asm
areion512TEM2Decryptx4Asm PROC
    hint #34 ; bti c
    eor v31.16b, v31.16b, v31.16b
    mov x5, x3
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x5], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x5]
    mov x5, x2
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x5]
    add x5, x5, #128
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x5]
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    eor v16.16b, v16.16b, v3.16b
    eor v17.16b, v17.16b, v0.16b
    eor v18.16b, v18.16b, v1.16b
    eor v19.16b, v19.16b, v2.16b
    eor v20.16b, v20.16b, v7.16b
    eor v21.16b, v21.16b, v4.16b
    eor v22.16b, v22.16b, v5.16b
    eor v23.16b, v23.16b, v6.16b
    fmov x6, d16
    fmov x7, v16.d[1]
    fmov x8, d17
    fmov x9, v17.d[1]
    fmov x10, d18
    fmov x11, v18.d[1]
    fmov x12, d19
    fmov x13, v19.d[1]
    mov v24.16b, v20.16b
    mov v25.16b, v21.16b
    mov v26.16b, v22.16b
    mov v27.16b, v23.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x3], #64
    add x5, x2, #64
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x5]
    add x5, x5, #128
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x5]
    add x2, x2, #256
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    eor v16.16b, v16.16b, v3.16b
    eor v17.16b, v17.16b, v0.16b
    eor v18.16b, v18.16b, v1.16b
    eor v19.16b, v19.16b, v2.16b
    eor v20.16b, v20.16b, v7.16b
    eor v21.16b, v21.16b, v4.16b
    eor v22.16b, v22.16b, v5.16b
    eor v23.16b, v23.16b, v6.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1], #64
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    fmov d28, x6
    fmov v28.d[1], x7
    eor v0.16b, v0.16b, v28.16b
    fmov d28, x8
    fmov v28.d[1], x9
    eor v1.16b, v1.16b, v28.16b
    fmov d28, x10
    fmov v28.d[1], x11
    eor v2.16b, v2.16b, v28.16b
    fmov d28, x12
    fmov v28.d[1], x13
    eor v3.16b, v3.16b, v28.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    add x4, x4, #224
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    eor v1.16b, v1.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v3.16b, v3.16b, v18.16b
    eor v0.16b, v0.16b, v19.16b
    eor v5.16b, v5.16b, v20.16b
    eor v6.16b, v6.16b, v21.16b
    eor v7.16b, v7.16b, v22.16b
    eor v4.16b, v4.16b, v23.16b
    fmov d16, x6
    fmov v16.d[1], x7
    fmov d17, x8
    fmov v17.d[1], x9
    fmov d18, x10
    fmov v18.d[1], x11
    fmov d19, x12
    fmov v19.d[1], x13
    mov v20.16b, v24.16b
    mov v21.16b, v25.16b
    mov v22.16b, v26.16b
    mov v23.16b, v27.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    add x4, x4, #224
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    eor v2.16b, v2.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    eor v6.16b, v6.16b, v20.16b
    eor v7.16b, v7.16b, v21.16b
    eor v4.16b, v4.16b, v22.16b
    eor v5.16b, v5.16b, v23.16b
    st1 { v2.16b, v3.16b }, [x0], #32
    st1 { v0.16b, v1.16b }, [x0], #32
    st1 { v6.16b, v7.16b }, [x0], #32
    st1 { v4.16b, v5.16b }, [x0], #32
    mov x5, x3
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x5], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x5]
    mov x5, x2
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x5]
    add x5, x5, #128
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x5]
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    eor v16.16b, v16.16b, v3.16b
    eor v17.16b, v17.16b, v0.16b
    eor v18.16b, v18.16b, v1.16b
    eor v19.16b, v19.16b, v2.16b
    eor v20.16b, v20.16b, v7.16b
    eor v21.16b, v21.16b, v4.16b
    eor v22.16b, v22.16b, v5.16b
    eor v23.16b, v23.16b, v6.16b
    fmov x6, d16
    fmov x7, v16.d[1]
    fmov x8, d17
    fmov x9, v17.d[1]
    fmov x10, d18
    fmov x11, v18.d[1]
    fmov x12, d19
    fmov x13, v19.d[1]
    mov v24.16b, v20.16b
    mov v25.16b, v21.16b
    mov v26.16b, v22.16b
    mov v27.16b, v23.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x3], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x3]
    add x5, x2, #64
    ld1 { v16.16b, v17.16b, v18.16b, v19.16b }, [x5]
    add x5, x5, #128
    ld1 { v20.16b, v21.16b, v22.16b, v23.16b }, [x5]
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    ld1 { v30.16b }, [x4], #16
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aese v1.16b, v30.16b
    aesmc v1.16b, v1.16b
    aese v5.16b, v30.16b
    aesmc v5.16b, v5.16b
    ld1 { v30.16b }, [x4], #16
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aese v2.16b, v30.16b
    aesmc v2.16b, v2.16b
    aese v6.16b, v30.16b
    aesmc v6.16b, v6.16b
    ld1 { v30.16b }, [x4], #16
    aese v1.16b, v31.16b
    aese v5.16b, v31.16b
    aese v3.16b, v31.16b
    aese v7.16b, v31.16b
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aese v3.16b, v30.16b
    aesmc v3.16b, v3.16b
    aese v7.16b, v30.16b
    aesmc v7.16b, v7.16b
    ld1 { v30.16b }, [x4], #16
    aese v2.16b, v31.16b
    aese v6.16b, v31.16b
    aese v0.16b, v31.16b
    aese v4.16b, v31.16b
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aese v0.16b, v30.16b
    aesmc v0.16b, v0.16b
    aese v4.16b, v30.16b
    aesmc v4.16b, v4.16b
    eor v16.16b, v16.16b, v3.16b
    eor v17.16b, v17.16b, v0.16b
    eor v18.16b, v18.16b, v1.16b
    eor v19.16b, v19.16b, v2.16b
    eor v20.16b, v20.16b, v7.16b
    eor v21.16b, v21.16b, v4.16b
    eor v22.16b, v22.16b, v5.16b
    eor v23.16b, v23.16b, v6.16b
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1], #64
    ld1 { v4.16b, v5.16b, v6.16b, v7.16b }, [x1]
    eor v0.16b, v0.16b, v16.16b
    eor v1.16b, v1.16b, v17.16b
    eor v2.16b, v2.16b, v18.16b
    eor v3.16b, v3.16b, v19.16b
    eor v4.16b, v4.16b, v20.16b
    eor v5.16b, v5.16b, v21.16b
    eor v6.16b, v6.16b, v22.16b
    eor v7.16b, v7.16b, v23.16b
    fmov d28, x6
    fmov v28.d[1], x7
    eor v0.16b, v0.16b, v28.16b
    fmov d28, x8
    fmov v28.d[1], x9
    eor v1.16b, v1.16b, v28.16b
    fmov d28, x10
    fmov v28.d[1], x11
    eor v2.16b, v2.16b, v28.16b
    fmov d28, x12
    fmov v28.d[1], x13
    eor v3.16b, v3.16b, v28.16b
    eor v4.16b, v4.16b, v24.16b
    eor v5.16b, v5.16b, v25.16b
    eor v6.16b, v6.16b, v26.16b
    eor v7.16b, v7.16b, v27.16b
    adrp x4, roundConstantsP2
    add x4, x4, roundConstantsP2
    add x4, x4, #224
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    eor v1.16b, v1.16b, v16.16b
    eor v2.16b, v2.16b, v17.16b
    eor v3.16b, v3.16b, v18.16b
    eor v0.16b, v0.16b, v19.16b
    eor v5.16b, v5.16b, v20.16b
    eor v6.16b, v6.16b, v21.16b
    eor v7.16b, v7.16b, v22.16b
    eor v4.16b, v4.16b, v23.16b
    fmov d16, x6
    fmov v16.d[1], x7
    fmov d17, x8
    fmov v17.d[1], x9
    fmov d18, x10
    fmov v18.d[1], x11
    fmov d19, x12
    fmov v19.d[1], x13
    mov v20.16b, v24.16b
    mov v21.16b, v25.16b
    mov v22.16b, v26.16b
    mov v23.16b, v27.16b
    adrp x4, roundConstantsP1
    add x4, x4, roundConstantsP1
    add x4, x4, #224
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v1.16b
    aesmc v29.16b, v5.16b
    aesd v1.16b, v31.16b
    aesd v5.16b, v31.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    aesimc v3.16b, v3.16b
    aesd v3.16b, v31.16b
    aesimc v7.16b, v7.16b
    aesd v7.16b, v31.16b
    eor v28.16b, v3.16b, v30.16b
    eor v29.16b, v7.16b, v30.16b
    aesd v3.16b, v30.16b
    aesd v7.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v0.16b
    aesmc v29.16b, v4.16b
    aesd v0.16b, v31.16b
    aesd v4.16b, v31.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    aesimc v2.16b, v2.16b
    aesd v2.16b, v31.16b
    aesimc v6.16b, v6.16b
    aesd v6.16b, v31.16b
    eor v28.16b, v2.16b, v30.16b
    eor v29.16b, v6.16b, v30.16b
    aesd v2.16b, v30.16b
    aesd v6.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    ld1 { v30.16b }, [x4]
    sub x4, x4, #16
    aesmc v28.16b, v3.16b
    aesmc v29.16b, v7.16b
    aesd v3.16b, v31.16b
    aesd v7.16b, v31.16b
    eor v0.16b, v0.16b, v28.16b
    eor v4.16b, v4.16b, v29.16b
    aesimc v1.16b, v1.16b
    aesd v1.16b, v31.16b
    aesimc v5.16b, v5.16b
    aesd v5.16b, v31.16b
    eor v28.16b, v1.16b, v30.16b
    eor v29.16b, v5.16b, v30.16b
    aesd v1.16b, v30.16b
    aesd v5.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v2.16b, v2.16b, v28.16b
    eor v6.16b, v6.16b, v29.16b
    ld1 { v30.16b }, [x4]
    aesmc v28.16b, v2.16b
    aesmc v29.16b, v6.16b
    aesd v2.16b, v31.16b
    aesd v6.16b, v31.16b
    eor v3.16b, v3.16b, v28.16b
    eor v7.16b, v7.16b, v29.16b
    aesimc v0.16b, v0.16b
    aesd v0.16b, v31.16b
    aesimc v4.16b, v4.16b
    aesd v4.16b, v31.16b
    eor v28.16b, v0.16b, v30.16b
    eor v29.16b, v4.16b, v30.16b
    aesd v0.16b, v30.16b
    aesd v4.16b, v30.16b
    aesmc v28.16b, v28.16b
    aesmc v29.16b, v29.16b
    eor v1.16b, v1.16b, v28.16b
    eor v5.16b, v5.16b, v29.16b
    eor v2.16b, v2.16b, v16.16b
    eor v3.16b, v3.16b, v17.16b
    eor v0.16b, v0.16b, v18.16b
    eor v1.16b, v1.16b, v19.16b
    eor v6.16b, v6.16b, v20.16b
    eor v7.16b, v7.16b, v21.16b
    eor v4.16b, v4.16b, v22.16b
    eor v5.16b, v5.16b, v23.16b
    st1 { v2.16b, v3.16b }, [x0], #32
    st1 { v0.16b, v1.16b }, [x0], #32
    st1 { v6.16b, v7.16b }, [x0], #32
    st1 { v4.16b, v5.16b }, [x0]
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
    mov x8, xzr
    mov x9, xzr
    mov x10, xzr
    mov x11, xzr
    mov x12, xzr
    mov x13, xzr
    ret
    ENDP

    EXPORT areion256DMAsm
areion256DMAsm PROC
    hint #34 ; bti c
    adrp x2, roundConstantsP1
    add x2, x2, roundConstantsP1
    ld1 { v0.16b, v1.16b }, [x1]
    mov v4.16b, v0.16b
    mov v5.16b, v1.16b
    eor v31.16b, v31.16b, v31.16b
    ld1 { v2.16b }, [x2], #16
    aese v0.16b, v31.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v1.16b, v31.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v0.16b, v31.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v1.16b, v31.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v0.16b, v31.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v1.16b, v31.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v0.16b, v31.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v1.16b, v31.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v0.16b, v31.16b
    aesmc v3.16b, v0.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v1.16b, v1.16b, v3.16b
    ld1 { v2.16b }, [x2], #16
    aese v1.16b, v31.16b
    aesmc v3.16b, v1.16b
    aese v3.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v3.16b
    eor v0.16b, v0.16b, v4.16b
    eor v1.16b, v1.16b, v5.16b
    st1 { v0.16b, v1.16b }, [x0]
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
    ENDP

    EXPORT areion512DMAsm
areion512DMAsm PROC
    hint #34 ; bti c
    adrp x2, roundConstantsP1
    add x2, x2, roundConstantsP1
    ld1 { v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
    mov v16.16b, v0.16b
    mov v17.16b, v1.16b
    mov v18.16b, v2.16b
    mov v19.16b, v3.16b
    eor v31.16b, v31.16b, v31.16b
    ld1 { v4.16b }, [x2], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x2], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x2], #16
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x2], #16
    aese v3.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x2], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x2], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x2], #16
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x2], #16
    aese v3.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x2], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x2], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x2], #16
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    ld1 { v4.16b }, [x2], #16
    aese v3.16b, v31.16b
    aese v1.16b, v31.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aese v1.16b, v4.16b
    aesmc v1.16b, v1.16b
    ld1 { v4.16b }, [x2], #16
    aese v0.16b, v31.16b
    aese v2.16b, v31.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aese v2.16b, v4.16b
    aesmc v2.16b, v2.16b
    ld1 { v4.16b }, [x2], #16
    aese v1.16b, v31.16b
    aese v3.16b, v31.16b
    aesmc v5.16b, v1.16b
    eor v2.16b, v5.16b, v2.16b
    aesmc v5.16b, v3.16b
    eor v0.16b, v5.16b, v0.16b
    aese v3.16b, v4.16b
    aesmc v3.16b, v3.16b
    ld1 { v4.16b }, [x2], #16
    aese v2.16b, v31.16b
    aese v0.16b, v31.16b
    aesmc v5.16b, v2.16b
    eor v3.16b, v5.16b, v3.16b
    aesmc v5.16b, v0.16b
    eor v1.16b, v5.16b, v1.16b
    aese v0.16b, v4.16b
    aesmc v0.16b, v0.16b
    eor v3.16b, v3.16b, v16.16b
    eor v0.16b, v0.16b, v17.16b
    eor v1.16b, v1.16b, v18.16b
    eor v2.16b, v2.16b, v19.16b
    trn2 v3.2d, v3.2d, v0.2d
    trn1 v1.2d, v1.2d, v2.2d
    st1 { v3.16b }, [x0], #16
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
    eor v31.16b, v31.16b, v31.16b
    mov x0, xzr
    mov x1, xzr
    mov x2, xzr
    ret
    ENDP

    EXPORT aesRoundWordsAsm
aesRoundWordsAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b }, [x1]
    eor v1.16b, v1.16b, v1.16b
    aese v0.16b, v1.16b
    aesmc v0.16b, v0.16b
    st1 { v0.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    mov x0, xzr
    mov x1, xzr
    ret
    ENDP

    EXPORT aesFinalRoundWordsAsm
aesFinalRoundWordsAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b }, [x1]
    eor v1.16b, v1.16b, v1.16b
    aese v0.16b, v1.16b
    st1 { v0.16b }, [x0]
    eor v0.16b, v0.16b, v0.16b
    mov x0, xzr
    mov x1, xzr
    ret
    ENDP

    EXPORT aesRound4PtrsAsm
aesRound4PtrsAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b }, [x0]
    ld1 { v1.16b }, [x1]
    ld1 { v2.16b }, [x2]
    ld1 { v3.16b }, [x3]
    ld1 { v4.16b }, [x4]
    ld1 { v5.16b }, [x5]
    ld1 { v6.16b }, [x6]
    ld1 { v7.16b }, [x7]
    eor v16.16b, v16.16b, v16.16b
    aese v0.16b, v16.16b
    aese v1.16b, v16.16b
    aese v2.16b, v16.16b
    aese v3.16b, v16.16b
    aesmc v0.16b, v0.16b
    aesmc v1.16b, v1.16b
    aesmc v2.16b, v2.16b
    aesmc v3.16b, v3.16b
    eor v0.16b, v0.16b, v4.16b
    eor v1.16b, v1.16b, v5.16b
    eor v2.16b, v2.16b, v6.16b
    eor v3.16b, v3.16b, v7.16b
    st1 { v0.16b }, [x0]
    st1 { v1.16b }, [x1]
    st1 { v2.16b }, [x2]
    st1 { v3.16b }, [x3]
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
    mov x3, xzr
    mov x4, xzr
    mov x5, xzr
    mov x6, xzr
    mov x7, xzr
    ret
    ENDP

    EXPORT aesFinalRound4PtrsAsm
aesFinalRound4PtrsAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b }, [x0]
    ld1 { v1.16b }, [x1]
    ld1 { v2.16b }, [x2]
    ld1 { v3.16b }, [x3]
    ld1 { v4.16b }, [x4]
    ld1 { v5.16b }, [x5]
    ld1 { v6.16b }, [x6]
    ld1 { v7.16b }, [x7]
    eor v16.16b, v16.16b, v16.16b
    aese v0.16b, v16.16b
    aese v1.16b, v16.16b
    aese v2.16b, v16.16b
    aese v3.16b, v16.16b
    eor v0.16b, v0.16b, v4.16b
    eor v1.16b, v1.16b, v5.16b
    eor v2.16b, v2.16b, v6.16b
    eor v3.16b, v3.16b, v7.16b
    st1 { v0.16b }, [x0]
    st1 { v1.16b }, [x1]
    st1 { v2.16b }, [x2]
    st1 { v3.16b }, [x3]
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
    mov x3, xzr
    mov x4, xzr
    mov x5, xzr
    mov x6, xzr
    mov x7, xzr
    ret
    ENDP

    EXPORT aes128ExpandKeyAsm
aes128ExpandKeyAsm PROC
    hint #34 ; bti c
    ld1 { v0.16b }, [x0]
    st1 { v0.16b }, [x1], #16
    eor v2.16b, v2.16b, v2.16b
    dup v1.4s, v0.s[3]
    aese v1.16b, v2.16b
    ext v1.16b, v1.16b, v1.16b, #1
    movi v4.4s, #1
    eor v1.16b, v1.16b, v4.16b
    ext v3.16b, v2.16b, v0.16b, #12
    eor v0.16b, v0.16b, v3.16b
    ext v3.16b, v2.16b, v0.16b, #8
    eor v0.16b, v0.16b, v3.16b
    eor v0.16b, v0.16b, v1.16b
    st1 { v0.16b }, [x1], #16
    dup v1.4s, v0.s[3]
    aese v1.16b, v2.16b
    ext v1.16b, v1.16b, v1.16b, #1
    movi v4.4s, #2
    eor v1.16b, v1.16b, v4.16b
    ext v3.16b, v2.16b, v0.16b, #12
    eor v0.16b, v0.16b, v3.16b
    ext v3.16b, v2.16b, v0.16b, #8
    eor v0.16b, v0.16b, v3.16b
    eor v0.16b, v0.16b, v1.16b
    st1 { v0.16b }, [x1], #16
    dup v1.4s, v0.s[3]
    aese v1.16b, v2.16b
    ext v1.16b, v1.16b, v1.16b, #1
    movi v4.4s, #4
    eor v1.16b, v1.16b, v4.16b
    ext v3.16b, v2.16b, v0.16b, #12
    eor v0.16b, v0.16b, v3.16b
    ext v3.16b, v2.16b, v0.16b, #8
    eor v0.16b, v0.16b, v3.16b
    eor v0.16b, v0.16b, v1.16b
    st1 { v0.16b }, [x1], #16
    dup v1.4s, v0.s[3]
    aese v1.16b, v2.16b
    ext v1.16b, v1.16b, v1.16b, #1
    movi v4.4s, #8
    eor v1.16b, v1.16b, v4.16b
    ext v3.16b, v2.16b, v0.16b, #12
    eor v0.16b, v0.16b, v3.16b
    ext v3.16b, v2.16b, v0.16b, #8
    eor v0.16b, v0.16b, v3.16b
    eor v0.16b, v0.16b, v1.16b
    st1 { v0.16b }, [x1], #16
    dup v1.4s, v0.s[3]
    aese v1.16b, v2.16b
    ext v1.16b, v1.16b, v1.16b, #1
    movi v4.4s, #16
    eor v1.16b, v1.16b, v4.16b
    ext v3.16b, v2.16b, v0.16b, #12
    eor v0.16b, v0.16b, v3.16b
    ext v3.16b, v2.16b, v0.16b, #8
    eor v0.16b, v0.16b, v3.16b
    eor v0.16b, v0.16b, v1.16b
    st1 { v0.16b }, [x1], #16
    dup v1.4s, v0.s[3]
    aese v1.16b, v2.16b
    ext v1.16b, v1.16b, v1.16b, #1
    movi v4.4s, #32
    eor v1.16b, v1.16b, v4.16b
    ext v3.16b, v2.16b, v0.16b, #12
    eor v0.16b, v0.16b, v3.16b
    ext v3.16b, v2.16b, v0.16b, #8
    eor v0.16b, v0.16b, v3.16b
    eor v0.16b, v0.16b, v1.16b
    st1 { v0.16b }, [x1], #16
    dup v1.4s, v0.s[3]
    aese v1.16b, v2.16b
    ext v1.16b, v1.16b, v1.16b, #1
    movi v4.4s, #64
    eor v1.16b, v1.16b, v4.16b
    ext v3.16b, v2.16b, v0.16b, #12
    eor v0.16b, v0.16b, v3.16b
    ext v3.16b, v2.16b, v0.16b, #8
    eor v0.16b, v0.16b, v3.16b
    eor v0.16b, v0.16b, v1.16b
    st1 { v0.16b }, [x1], #16
    dup v1.4s, v0.s[3]
    aese v1.16b, v2.16b
    ext v1.16b, v1.16b, v1.16b, #1
    movi v4.4s, #128
    eor v1.16b, v1.16b, v4.16b
    ext v3.16b, v2.16b, v0.16b, #12
    eor v0.16b, v0.16b, v3.16b
    ext v3.16b, v2.16b, v0.16b, #8
    eor v0.16b, v0.16b, v3.16b
    eor v0.16b, v0.16b, v1.16b
    st1 { v0.16b }, [x1], #16
    dup v1.4s, v0.s[3]
    aese v1.16b, v2.16b
    ext v1.16b, v1.16b, v1.16b, #1
    movi v4.4s, #27
    eor v1.16b, v1.16b, v4.16b
    ext v3.16b, v2.16b, v0.16b, #12
    eor v0.16b, v0.16b, v3.16b
    ext v3.16b, v2.16b, v0.16b, #8
    eor v0.16b, v0.16b, v3.16b
    eor v0.16b, v0.16b, v1.16b
    st1 { v0.16b }, [x1], #16
    dup v1.4s, v0.s[3]
    aese v1.16b, v2.16b
    ext v1.16b, v1.16b, v1.16b, #1
    movi v4.4s, #54
    eor v1.16b, v1.16b, v4.16b
    ext v3.16b, v2.16b, v0.16b, #12
    eor v0.16b, v0.16b, v3.16b
    ext v3.16b, v2.16b, v0.16b, #8
    eor v0.16b, v0.16b, v3.16b
    eor v0.16b, v0.16b, v1.16b
    st1 { v0.16b }, [x1], #16
    eor v0.16b, v0.16b, v0.16b
    eor v1.16b, v1.16b, v1.16b
    eor v3.16b, v3.16b, v3.16b
    eor v4.16b, v4.16b, v4.16b
    mov x0, xzr
    mov x1, xzr
    ret
    ENDP

    END
