/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#ifndef SUPERCOP_CRYPTO_CORE_AREION256_API_H
#define SUPERCOP_CRYPTO_CORE_AREION256_API_H

#define CRYPTO_OUTPUTBYTES 32
#define CRYPTO_INPUTBYTES  32
#define CRYPTO_KEYBYTES    0
#define CRYPTO_CONSTBYTES  0

int crypto_core(
    unsigned char *out,
    const unsigned char *in,
    const unsigned char *k,
    const unsigned char *c);

#endif /* SUPERCOP_CRYPTO_CORE_AREION256_API_H */
