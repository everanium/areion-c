/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

#if (defined(__x86_64__) || defined(_M_X64)) && !defined(AREION_FORCE_PORTABLE)

extern void rijndael256EncryptBlockAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256DecryptBlockAsm(const uint8_t *drk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256EncryptBlockVexAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256DecryptBlockVexAsm(const uint8_t *drk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256Encrypt4BlocksZmmAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256Decrypt4BlocksZmmAsm(const uint8_t *drk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256Encrypt4BlocksYmmAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256Decrypt4BlocksYmmAsm(const uint8_t *drk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256Encrypt4BlocksVexAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256Decrypt4BlocksVexAsm(const uint8_t *drk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256Encrypt4BlocksAesNiAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256Decrypt4BlocksAesNiAsm(const uint8_t *drk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;

void areion_rijndael256_encrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[15][32]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_rijndael256_encrypt_block_purec(dst, src, rk);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        rijndael256EncryptBlockVexAsm(&rk[0][0], dst, src);
    } else {
        rijndael256EncryptBlockAsm(&rk[0][0], dst, src);
    }
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_rijndael256_decrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t drk[15][32]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_rijndael256_decrypt_block_purec(dst, src, drk);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        rijndael256DecryptBlockVexAsm(&drk[0][0], dst, src);
    } else {
        rijndael256DecryptBlockAsm(&drk[0][0], dst, src);
    }
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_rijndael256_encrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[15][32]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_rijndael256_encrypt4_blocks_purec(dst, src, rk);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        rijndael256Encrypt4BlocksZmmAsm(&rk[0][0], &dst[0][0], &src[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        rijndael256Encrypt4BlocksYmmAsm(&rk[0][0], &dst[0][0], &src[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        rijndael256Encrypt4BlocksVexAsm(&rk[0][0], &dst[0][0], &src[0][0]);
    } else {
        rijndael256Encrypt4BlocksAesNiAsm(&rk[0][0], &dst[0][0], &src[0][0]);
    }
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_rijndael256_decrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t drk[15][32]) {
    areion_tier_t tier = areion_active_tier();
    if (tier == AREION_TIER_PUREC) {
        areion_rijndael256_decrypt4_blocks_purec(dst, src, drk);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        rijndael256Decrypt4BlocksZmmAsm(&drk[0][0], &dst[0][0], &src[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        rijndael256Decrypt4BlocksYmmAsm(&drk[0][0], &dst[0][0], &src[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        rijndael256Decrypt4BlocksVexAsm(&drk[0][0], &dst[0][0], &src[0][0]);
    } else {
        rijndael256Decrypt4BlocksAesNiAsm(&drk[0][0], &dst[0][0], &src[0][0]);
    }
    AREION_MSAN_UNPOISON(dst, 128U);
}

#else
typedef int areion_rijndael_amd64_unused_t;
#endif
