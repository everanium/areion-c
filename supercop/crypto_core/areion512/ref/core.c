/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include <stddef.h>
#include "api.h"
#include "../../../../areion.h"

int crypto_core(
    unsigned char *out,
    const unsigned char *in,
    const unsigned char *k,
    const unsigned char *c)
{
    (void)k;
    (void)c;
    if (out != in) {
        size_t i;
        for (i = 0; i < (size_t)CRYPTO_INPUTBYTES; i++) {
            out[i] = in[i];
        }
    }
    areion_permute512(out);
    return 0;
}
