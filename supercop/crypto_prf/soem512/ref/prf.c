/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "api.h"
#include "../../../../areion.h"

int crypto_prf(
    unsigned char *out,
    const unsigned char *in,
    const unsigned char *k)
{
    areion_soem512(out, k, in);
    return 0;
}
