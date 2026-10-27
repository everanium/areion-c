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
    const unsigned char *k)
{
    (void)tweak;
    areion_em_encrypt256(out, k, in);
    return 0;
}

int crypto_tbc_decrypt(
    unsigned char *out,
    const unsigned char *in,
    const unsigned char *tweak,
    const unsigned char *k)
{
    (void)tweak;
    areion_em_decrypt256(out, k, in);
    return 0;
}
