/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

#if (defined(__aarch64__) || defined(_M_ARM64)) && !defined(AREION_FORCE_PORTABLE)

extern void vistrutah256EncryptBlockAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256DecryptBlockAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Encrypt4BlocksAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Decrypt4BlocksAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock256Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512DecryptBlock256Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock512Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512DecryptBlock512Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks256Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Decrypt4Blocks256Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks512Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Decrypt4Blocks512Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;

void areion_vistrutah256_encrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds) {
    if (areion_active_tier() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 14)) {
        areion_vistrutah256_encrypt_block_purec(dst, src, key, rounds);
        return;
    }
    vistrutah256EncryptBlockAsm(dst, src, key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_vistrutah256_decrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds) {
    if (areion_active_tier() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 14)) {
        areion_vistrutah256_decrypt_block_purec(dst, src, key, rounds);
        return;
    }
    vistrutah256DecryptBlockAsm(dst, src, key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_vistrutah256_encrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds) {
    if (areion_active_tier() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 14)) {
        areion_vistrutah256_encrypt4_blocks_purec(dst, src, key, rounds);
        return;
    }
    vistrutah256Encrypt4BlocksAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_vistrutah256_decrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds) {
    if (areion_active_tier() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 14)) {
        areion_vistrutah256_decrypt4_blocks_purec(dst, src, key, rounds);
        return;
    }
    vistrutah256Decrypt4BlocksAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_vistrutah512_encrypt_block_256_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds) {
    if (areion_active_tier() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt_block_256_purec(dst, src, key, rounds);
        return;
    }
    vistrutah512EncryptBlock256Asm(dst, src, key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 64U);
}

void areion_vistrutah512_decrypt_block_256_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds) {
    if (areion_active_tier() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_decrypt_block_256_purec(dst, src, key, rounds);
        return;
    }
    vistrutah512DecryptBlock256Asm(dst, src, key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 64U);
}

void areion_vistrutah512_encrypt_block_512_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds) {
    if (areion_active_tier() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt_block_512_purec(dst, src, key, rounds);
        return;
    }
    vistrutah512EncryptBlock512Asm(dst, src, key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 64U);
}

void areion_vistrutah512_decrypt_block_512_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds) {
    if (areion_active_tier() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_decrypt_block_512_purec(dst, src, key, rounds);
        return;
    }
    vistrutah512DecryptBlock512Asm(dst, src, key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 64U);
}

void areion_vistrutah512_encrypt4_blocks_256_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds) {
    if (areion_active_tier() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt4_blocks_256_purec(dst, src, key, rounds);
        return;
    }
    vistrutah512Encrypt4Blocks256Asm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 256U);
}

void areion_vistrutah512_decrypt4_blocks_256_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds) {
    if (areion_active_tier() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_decrypt4_blocks_256_purec(dst, src, key, rounds);
        return;
    }
    vistrutah512Decrypt4Blocks256Asm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 256U);
}

void areion_vistrutah512_encrypt4_blocks_512_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds) {
    if (areion_active_tier() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt4_blocks_512_purec(dst, src, key, rounds);
        return;
    }
    vistrutah512Encrypt4Blocks512Asm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 256U);
}

void areion_vistrutah512_decrypt4_blocks_512_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds) {
    if (areion_active_tier() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_decrypt4_blocks_512_purec(dst, src, key, rounds);
        return;
    }
    vistrutah512Decrypt4Blocks512Asm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 256U);
}

#else
typedef int areion_vistrutah_arm64_unused_t;
#endif
