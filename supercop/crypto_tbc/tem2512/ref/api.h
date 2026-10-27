/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#ifndef SUPERCOP_CRYPTO_TBC_TEM2512_API_H
#define SUPERCOP_CRYPTO_TBC_TEM2512_API_H

#define CRYPTO_BLOCKBYTES 64
#define CRYPTO_KEYBYTES   128
#define CRYPTO_TWEAKBYTES 64

int crypto_tbc_encrypt(
    unsigned char *out,
    const unsigned char *in,
    const unsigned char *tweak,
    const unsigned char *k);

int crypto_tbc_decrypt(
    unsigned char *out,
    const unsigned char *in,
    const unsigned char *tweak,
    const unsigned char *k);

#endif /* SUPERCOP_CRYPTO_TBC_TEM2512_API_H */
