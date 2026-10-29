/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

#if (defined(__aarch64__) || defined(_M_ARM64)) && !defined(AREION_FORCE_PORTABLE)

extern void areion_asura_expand_tweakey_asm(uint8_t *rk, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_encrypt_block_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_decrypt_block_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_encrypt_4blocks_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_decrypt_4blocks_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_encrypt_block_otf_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_block_otf_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_encrypt_4blocks_otf_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_4blocks_otf_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;

void areion_asura_expand_tweakey_hw(
    uint8_t rk[13][32], const uint8_t key[32], const uint8_t tweak[16]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_expand_tweakey_soft(rk, key, tweak);
        return;
    }
    areion_asura_expand_tweakey_asm(&rk[0][0], key, tweak);
    AREION_MSAN_UNPOISON(rk, 416U);
}

void areion_asura_encrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_encrypt_block_soft(dst, src, rk);
        return;
    }
    areion_asura_encrypt_block_asm(dst, src, &rk[0][0]);
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_decrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_decrypt_block_soft(dst, src, rk);
        return;
    }
    areion_asura_decrypt_block_asm(dst, src, &rk[0][0]);
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_encrypt_4blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_encrypt_4blocks_soft(dst, src, rk);
        return;
    }
    areion_asura_encrypt_4blocks_asm(&dst[0][0], &src[0][0], &rk[0][0]);
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_asura_decrypt_4blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_decrypt_4blocks_soft(dst, src, rk);
        return;
    }
    areion_asura_decrypt_4blocks_asm(&dst[0][0], &src[0][0], &rk[0][0]);
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_asura_encrypt_block_otf_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_encrypt_block_otf_soft(dst, src, key, tweak);
        return;
    }
    areion_asura_encrypt_block_otf_asm(dst, src, key, tweak);
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_decrypt_block_otf_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_decrypt_block_otf_soft(dst, src, key, tweak);
        return;
    }
    areion_asura_decrypt_block_otf_asm(dst, src, key, tweak);
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_encrypt_4blocks_otf_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweak[16]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_encrypt_4blocks_otf_soft(dst, src, key, tweak);
        return;
    }
    areion_asura_encrypt_4blocks_otf_asm(&dst[0][0], &src[0][0], key, tweak);
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_asura_decrypt_4blocks_otf_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweak[16]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_decrypt_4blocks_otf_soft(dst, src, key, tweak);
        return;
    }
    areion_asura_decrypt_4blocks_otf_asm(&dst[0][0], &src[0][0], key, tweak);
    AREION_MSAN_UNPOISON(dst, 128U);
}

#else
typedef int areion_asura_arm64_unused_t;
#endif
