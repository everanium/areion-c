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

#if (defined(__x86_64__) || defined(_M_X64)) && !defined(AREION_FORCE_PORTABLE)

extern void areion_asura_expand_tweakey_asm(uint8_t *rk, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_expand_tweakey_vex_asm(uint8_t *rk, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_encrypt_block_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_encrypt_block_vex_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_decrypt_block_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_decrypt_block_vex_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_encrypt_4blocks_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_encrypt_4blocks_vex_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_encrypt_4blocks_vaes256_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_encrypt_4blocks_vaes512_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_decrypt_4blocks_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_decrypt_4blocks_vex_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_decrypt_4blocks_vaes256_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_decrypt_4blocks_vaes512_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk) AREION_INTERNAL;
extern void areion_asura_encrypt_block_otf_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_encrypt_block_otf_vex_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_block_otf_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_block_otf_vex_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_encrypt_4blocks_otf_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_encrypt_4blocks_otf_vex_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_encrypt_4blocks_otf_vaes256_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_encrypt_4blocks_otf_vaes512_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_4blocks_otf_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_4blocks_otf_vex_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_4blocks_otf_vaes256_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_4blocks_otf_vaes512_asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_expand_key_aesni_asm(uint8_t *rk, const uint8_t *key) AREION_INTERNAL;
extern void areion_asura_expand_key_vex_asm(uint8_t *rk, const uint8_t *key) AREION_INTERNAL;
extern void areion_asura_encrypt_block_rk_aesni_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_encrypt_block_rk_vex_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_block_rk_aesni_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_block_rk_vex_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_encrypt_4blocks_rk_aesni_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_encrypt_4blocks_rk_vex_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_encrypt_4blocks_rk_vaes256_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_encrypt_4blocks_rk_vaes512_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_4blocks_rk_aesni_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_4blocks_rk_vex_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_4blocks_rk_vaes256_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;
extern void areion_asura_decrypt_4blocks_rk_vaes512_asm(uint8_t *dst, const uint8_t *src, const uint8_t *rk, const uint8_t *tweak) AREION_INTERNAL;

void areion_asura_expand_tweakey(
    uint8_t rk[13][32], const uint8_t key[32], const uint8_t tweak[16]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_asura_expand_tweakey_soft(rk, key, tweak);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion_asura_expand_tweakey_vex_asm(&rk[0][0], key, tweak);
    } else {
        areion_asura_expand_tweakey_asm(&rk[0][0], key, tweak);
    }
    AREION_MSAN_UNPOISON(rk, 416U);
}

void areion_asura_encrypt(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_asura_encrypt_block_soft(dst, src, rk);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion_asura_encrypt_block_vex_asm(dst, src, &rk[0][0]);
    } else {
        areion_asura_encrypt_block_asm(dst, src, &rk[0][0]);
    }
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_decrypt(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_asura_decrypt_block_soft(dst, src, rk);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion_asura_decrypt_block_vex_asm(dst, src, &rk[0][0]);
    } else {
        areion_asura_decrypt_block_asm(dst, src, &rk[0][0]);
    }
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_encryptx4(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_asura_encrypt_4blocks_soft(dst, src, rk);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion_asura_encrypt_4blocks_vaes512_asm(&dst[0][0], &src[0][0], &rk[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion_asura_encrypt_4blocks_vaes256_asm(&dst[0][0], &src[0][0], &rk[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion_asura_encrypt_4blocks_vex_asm(&dst[0][0], &src[0][0], &rk[0][0]);
    } else {
        areion_asura_encrypt_4blocks_asm(&dst[0][0], &src[0][0], &rk[0][0]);
    }
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_asura_decryptx4(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_asura_decrypt_4blocks_soft(dst, src, rk);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion_asura_decrypt_4blocks_vaes512_asm(&dst[0][0], &src[0][0], &rk[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion_asura_decrypt_4blocks_vaes256_asm(&dst[0][0], &src[0][0], &rk[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion_asura_decrypt_4blocks_vex_asm(&dst[0][0], &src[0][0], &rk[0][0]);
    } else {
        areion_asura_decrypt_4blocks_asm(&dst[0][0], &src[0][0], &rk[0][0]);
    }
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_asura_encrypt_otf(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_asura_encrypt_block_otf_soft(dst, src, key, tweak);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion_asura_encrypt_block_otf_vex_asm(dst, src, key, tweak);
    } else {
        areion_asura_encrypt_block_otf_asm(dst, src, key, tweak);
    }
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_decrypt_otf(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_asura_decrypt_block_otf_soft(dst, src, key, tweak);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion_asura_decrypt_block_otf_vex_asm(dst, src, key, tweak);
    } else {
        areion_asura_decrypt_block_otf_asm(dst, src, key, tweak);
    }
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_encryptx4_otf(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweaks[4][16]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_asura_encrypt_4blocks_otf_soft(dst, src, key, tweaks);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion_asura_encrypt_4blocks_otf_vaes512_asm(&dst[0][0], &src[0][0], key, &tweaks[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion_asura_encrypt_4blocks_otf_vaes256_asm(&dst[0][0], &src[0][0], key, &tweaks[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion_asura_encrypt_4blocks_otf_vex_asm(&dst[0][0], &src[0][0], key, &tweaks[0][0]);
    } else {
        areion_asura_encrypt_4blocks_otf_asm(&dst[0][0], &src[0][0], key, &tweaks[0][0]);
    }
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_asura_decryptx4_otf(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweaks[4][16]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_asura_decrypt_4blocks_otf_soft(dst, src, key, tweaks);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion_asura_decrypt_4blocks_otf_vaes512_asm(&dst[0][0], &src[0][0], key, &tweaks[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion_asura_decrypt_4blocks_otf_vaes256_asm(&dst[0][0], &src[0][0], key, &tweaks[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion_asura_decrypt_4blocks_otf_vex_asm(&dst[0][0], &src[0][0], key, &tweaks[0][0]);
    } else {
        areion_asura_decrypt_4blocks_otf_asm(&dst[0][0], &src[0][0], key, &tweaks[0][0]);
    }
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_asura_expand_key(
    uint8_t rk[13][32], const uint8_t key[32]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_asura_expand_key_soft(rk, key);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion_asura_expand_key_vex_asm(&rk[0][0], key);
    } else {
        areion_asura_expand_key_aesni_asm(&rk[0][0], key);
    }
    AREION_MSAN_UNPOISON(rk, 416U);
}

void areion_asura_encrypt_rk(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32], const uint8_t tweak[16]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_asura_encrypt_block_rk_soft(dst, src, rk, tweak);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion_asura_encrypt_block_rk_vex_asm(dst, src, &rk[0][0], tweak);
    } else {
        areion_asura_encrypt_block_rk_aesni_asm(dst, src, &rk[0][0], tweak);
    }
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_decrypt_rk(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32], const uint8_t tweak[16]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_asura_decrypt_block_rk_soft(dst, src, rk, tweak);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion_asura_decrypt_block_rk_vex_asm(dst, src, &rk[0][0], tweak);
    } else {
        areion_asura_decrypt_block_rk_aesni_asm(dst, src, &rk[0][0], tweak);
    }
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_asura_encryptx4_rk(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32], const uint8_t tweaks[4][16]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_asura_encrypt_4blocks_rk_soft(dst, src, rk, tweaks);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion_asura_encrypt_4blocks_rk_vaes512_asm(&dst[0][0], &src[0][0], &rk[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion_asura_encrypt_4blocks_rk_vaes256_asm(&dst[0][0], &src[0][0], &rk[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion_asura_encrypt_4blocks_rk_vex_asm(&dst[0][0], &src[0][0], &rk[0][0], &tweaks[0][0]);
    } else {
        areion_asura_encrypt_4blocks_rk_aesni_asm(&dst[0][0], &src[0][0], &rk[0][0], &tweaks[0][0]);
    }
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_asura_decryptx4_rk(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32], const uint8_t tweaks[4][16]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_asura_decrypt_4blocks_rk_soft(dst, src, rk, tweaks);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion_asura_decrypt_4blocks_rk_vaes512_asm(&dst[0][0], &src[0][0], &rk[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion_asura_decrypt_4blocks_rk_vaes256_asm(&dst[0][0], &src[0][0], &rk[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion_asura_decrypt_4blocks_rk_vex_asm(&dst[0][0], &src[0][0], &rk[0][0], &tweaks[0][0]);
    } else {
        areion_asura_decrypt_4blocks_rk_aesni_asm(&dst[0][0], &src[0][0], &rk[0][0], &tweaks[0][0]);
    }
    AREION_MSAN_UNPOISON(dst, 128U);
}

#else
typedef int areion_asura_amd64_unused_t;
#endif
