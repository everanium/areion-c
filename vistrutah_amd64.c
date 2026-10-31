/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

#if (defined(__x86_64__) || defined(_M_X64)) && !defined(AREION_FORCE_PORTABLE)

extern void vistrutah256EncryptBlockAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256EncryptBlockVexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256EncryptBlockYmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256DecryptBlockAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256DecryptBlockVexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256DecryptBlockYmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Encrypt4BlocksAesNiAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Encrypt4BlocksVexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Encrypt4BlocksYmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Encrypt4BlocksZmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Decrypt4BlocksAesNiAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Decrypt4BlocksVexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Decrypt4BlocksYmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Decrypt4BlocksZmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;

extern void vistrutah512EncryptBlock256Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock256VexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock256YmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock256ZmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512DecryptBlock256Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512DecryptBlock256VexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512DecryptBlock256YmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512DecryptBlock256ZmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;

extern void vistrutah512EncryptBlock512Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock512VexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock512YmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock512ZmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512DecryptBlock512Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512DecryptBlock512VexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512DecryptBlock512YmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512DecryptBlock512ZmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;

extern void vistrutah512Encrypt4Blocks256AesNiAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks256VexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks256YmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks256ZmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Decrypt4Blocks256AesNiAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Decrypt4Blocks256VexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Decrypt4Blocks256YmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Decrypt4Blocks256ZmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;

extern void vistrutah512Encrypt4Blocks512AesNiAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks512VexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks512YmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks512ZmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Decrypt4Blocks512AesNiAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Decrypt4Blocks512VexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Decrypt4Blocks512YmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Decrypt4Blocks512ZmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;

void areion_vistrutah256_encrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 14)) {
        areion_vistrutah256_encrypt_block_purec(dst, src, key, rounds);
        return;
    }
    if (tier >= AREION_TIER_VAESAVX2) {
        vistrutah256EncryptBlockYmmAsm(dst, src, key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah256EncryptBlockVexAsm(dst, src, key, (int64_t)rounds);
    } else {
        vistrutah256EncryptBlockAsm(dst, src, key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_vistrutah256_decrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 14)) {
        areion_vistrutah256_decrypt_block_purec(dst, src, key, rounds);
        return;
    }
    if (tier >= AREION_TIER_VAESAVX2) {
        vistrutah256DecryptBlockYmmAsm(dst, src, key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah256DecryptBlockVexAsm(dst, src, key, (int64_t)rounds);
    } else {
        vistrutah256DecryptBlockAsm(dst, src, key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_vistrutah256_encrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 14)) {
        areion_vistrutah256_encrypt4_blocks_purec(dst, src, key, rounds);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        vistrutah256Encrypt4BlocksZmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VAESAVX2) {
        vistrutah256Encrypt4BlocksYmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah256Encrypt4BlocksVexAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else {
        vistrutah256Encrypt4BlocksAesNiAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_vistrutah256_decrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 14)) {
        areion_vistrutah256_decrypt4_blocks_purec(dst, src, key, rounds);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        vistrutah256Decrypt4BlocksZmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VAESAVX2) {
        vistrutah256Decrypt4BlocksYmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah256Decrypt4BlocksVexAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else {
        vistrutah256Decrypt4BlocksAesNiAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_vistrutah512_encrypt_block_256_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt_block_256_purec(dst, src, key, rounds);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        vistrutah512EncryptBlock256ZmmAsm(dst, src, key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VAESAVX2) {
        vistrutah512EncryptBlock256YmmAsm(dst, src, key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah512EncryptBlock256VexAsm(dst, src, key, (int64_t)rounds);
    } else {
        vistrutah512EncryptBlock256Asm(dst, src, key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 64U);
}

void areion_vistrutah512_decrypt_block_256_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_decrypt_block_256_purec(dst, src, key, rounds);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        vistrutah512DecryptBlock256ZmmAsm(dst, src, key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VAESAVX2) {
        vistrutah512DecryptBlock256YmmAsm(dst, src, key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah512DecryptBlock256VexAsm(dst, src, key, (int64_t)rounds);
    } else {
        vistrutah512DecryptBlock256Asm(dst, src, key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 64U);
}

void areion_vistrutah512_encrypt_block_512_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt_block_512_purec(dst, src, key, rounds);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        vistrutah512EncryptBlock512ZmmAsm(dst, src, key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VAESAVX2) {
        vistrutah512EncryptBlock512YmmAsm(dst, src, key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah512EncryptBlock512VexAsm(dst, src, key, (int64_t)rounds);
    } else {
        vistrutah512EncryptBlock512Asm(dst, src, key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 64U);
}

void areion_vistrutah512_decrypt_block_512_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_decrypt_block_512_purec(dst, src, key, rounds);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        vistrutah512DecryptBlock512ZmmAsm(dst, src, key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VAESAVX2) {
        vistrutah512DecryptBlock512YmmAsm(dst, src, key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah512DecryptBlock512VexAsm(dst, src, key, (int64_t)rounds);
    } else {
        vistrutah512DecryptBlock512Asm(dst, src, key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 64U);
}

void areion_vistrutah512_encrypt4_blocks_256_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt4_blocks_256_purec(dst, src, key, rounds);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        vistrutah512Encrypt4Blocks256ZmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VAESAVX2) {
        vistrutah512Encrypt4Blocks256YmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah512Encrypt4Blocks256VexAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else {
        vistrutah512Encrypt4Blocks256AesNiAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 256U);
}

void areion_vistrutah512_decrypt4_blocks_256_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_decrypt4_blocks_256_purec(dst, src, key, rounds);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        vistrutah512Decrypt4Blocks256ZmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VAESAVX2) {
        vistrutah512Decrypt4Blocks256YmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah512Decrypt4Blocks256VexAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else {
        vistrutah512Decrypt4Blocks256AesNiAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 256U);
}

void areion_vistrutah512_encrypt4_blocks_512_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt4_blocks_512_purec(dst, src, key, rounds);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        vistrutah512Encrypt4Blocks512ZmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VAESAVX2) {
        vistrutah512Encrypt4Blocks512YmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah512Encrypt4Blocks512VexAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else {
        vistrutah512Encrypt4Blocks512AesNiAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 256U);
}

void areion_vistrutah512_decrypt4_blocks_512_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_decrypt4_blocks_512_purec(dst, src, key, rounds);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        vistrutah512Decrypt4Blocks512ZmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VAESAVX2) {
        vistrutah512Decrypt4Blocks512YmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah512Decrypt4Blocks512VexAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else {
        vistrutah512Decrypt4Blocks512AesNiAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 256U);
}

#else
typedef int areion_vistrutah_amd64_unused_t;
#endif
