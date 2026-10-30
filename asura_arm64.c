/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

#undef areion_asura_encrypt
#undef areion_asura_decrypt
#undef areion_asura_encryptx4
#undef areion_asura_decryptx4
#undef areion_asura_encryptx4_otf
#undef areion_asura_decryptx4_otf
#undef areion_asura_encrypt_rk
#undef areion_asura_decrypt_rk
#undef areion_asura_encryptx4_rk
#undef areion_asura_decryptx4_rk

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
extern void areion_asura_expand_key_asm(uint8_t *rk, const uint8_t *key) AREION_INTERNAL;
extern void areion_asura_encrypt_block_rk_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_block_rk_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_encrypt_4blocks_rk_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_4blocks_rk_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;

void areion_asura_expand_tweakey(
    uint8_t rk[13][32], const uint8_t key[32], const uint8_t tweak[16]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_expand_tweakey_soft(rk, key, tweak);
        return;
    }
    areion_asura_expand_tweakey_asm(&rk[0][0], key, tweak);
    AREION_MSAN_UNPOISON(rk, 416U);
}

void areion_asura_encrypt(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_encrypt_block_soft(dst, src, rk);
        return;
    }
    areion_asura_encrypt_block_asm(dst, src, &rk[0][0]);
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_decrypt(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_decrypt_block_soft(dst, src, rk);
        return;
    }
    areion_asura_decrypt_block_asm(dst, src, &rk[0][0]);
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_encryptx4(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_encrypt_4blocks_soft(dst, src, rk);
        return;
    }
    areion_asura_encrypt_4blocks_asm(&dst[0][0], &src[0][0], &rk[0][0]);
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_asura_decryptx4(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_decrypt_4blocks_soft(dst, src, rk);
        return;
    }
    areion_asura_decrypt_4blocks_asm(&dst[0][0], &src[0][0], &rk[0][0]);
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_asura_encrypt_otf(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_encrypt_block_otf_soft(dst, src, key, tweak);
        return;
    }
    areion_asura_encrypt_block_otf_asm(dst, src, key, tweak);
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_decrypt_otf(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_decrypt_block_otf_soft(dst, src, key, tweak);
        return;
    }
    areion_asura_decrypt_block_otf_asm(dst, src, key, tweak);
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_encryptx4_otf(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweaks[4][16]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_encrypt_4blocks_otf_soft(dst, src, key, tweaks);
        return;
    }
    areion_asura_encrypt_4blocks_otf_asm(&dst[0][0], &src[0][0], key, &tweaks[0][0]);
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_asura_decryptx4_otf(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweaks[4][16]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_decrypt_4blocks_otf_soft(dst, src, key, tweaks);
        return;
    }
    areion_asura_decrypt_4blocks_otf_asm(&dst[0][0], &src[0][0], key, &tweaks[0][0]);
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_asura_expand_key(
    uint8_t rk[13][32], const uint8_t key[32]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_expand_key_soft(rk, key);
        return;
    }
    areion_asura_expand_key_asm(&rk[0][0], key);
    AREION_MSAN_UNPOISON(rk, 416U);
}

void areion_asura_encrypt_rk(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32], const uint8_t tweak[16]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_encrypt_block_rk_soft(dst, src, rk, tweak);
        return;
    }
    areion_asura_encrypt_block_rk_asm(dst, src, &rk[0][0], tweak);
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_decrypt_rk(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32], const uint8_t tweak[16]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_decrypt_block_rk_soft(dst, src, rk, tweak);
        return;
    }
    areion_asura_decrypt_block_rk_asm(dst, src, &rk[0][0], tweak);
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_encryptx4_rk(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32], const uint8_t tweaks[4][16]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_encrypt_4blocks_rk_soft(dst, src, rk, tweaks);
        return;
    }
    areion_asura_encrypt_4blocks_rk_asm(&dst[0][0], &src[0][0], &rk[0][0], &tweaks[0][0]);
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_asura_decryptx4_rk(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32], const uint8_t tweaks[4][16]) {
    if (areion_active_tier() != AREION_TIER_ARM64) {
        areion_asura_decrypt_4blocks_rk_soft(dst, src, rk, tweaks);
        return;
    }
    areion_asura_decrypt_4blocks_rk_asm(&dst[0][0], &src[0][0], &rk[0][0], &tweaks[0][0]);
    AREION_MSAN_UNPOISON(dst, 128U);
}

#else
typedef int areion_asura_arm64_unused_t;
#endif
