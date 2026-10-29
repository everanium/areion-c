/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

#if (defined(__aarch64__) || defined(_M_ARM64)) && !defined(AREION_FORCE_PORTABLE)

extern void rijndael256EncryptBlockAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256Encrypt4BlocksAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;

void areion_rijndael256_encrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[15][32]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_rijndael256_encrypt_block_purec(dst, src, rk);
        return;
    }
    rijndael256EncryptBlockAsm(&rk[0][0], dst, src);
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_rijndael256_encrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[15][32]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_rijndael256_encrypt4_blocks_purec(dst, src, rk);
        return;
    }
    rijndael256Encrypt4BlocksAsm(&rk[0][0], &dst[0][0], &src[0][0]);
    AREION_MSAN_UNPOISON(dst, 128U);
}

#else
typedef int areion_rijndael_arm64_unused_t;
#endif
