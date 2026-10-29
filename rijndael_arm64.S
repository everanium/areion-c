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

AREION_FUNC_START(rijndael256EncryptBlockAsm)
    AREION_ARM64_ADR(x3, rijndael256Consts)
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
AREION_FUNC_END(rijndael256EncryptBlockAsm)

AREION_FUNC_START(rijndael256Encrypt4BlocksAsm)
    AREION_ARM64_ADR(x3, rijndael256Consts)
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
AREION_FUNC_END(rijndael256Encrypt4BlocksAsm)

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
