/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "api.h"
#include "../../../../areion.h"

int crypto_tbc_encrypt(
    unsigned char *out,
    const unsigned char *in,
    const unsigned char *tweak,
    const unsigned char *k) {
    areion_asura_encrypt_otf(out, in, k, tweak);
    return 0;
}

int crypto_tbc_decrypt(
    unsigned char *out,
    const unsigned char *in,
    const unsigned char *tweak,
    const unsigned char *k) {
    areion_asura_decrypt_otf(out, in, k, tweak);
    return 0;
}
