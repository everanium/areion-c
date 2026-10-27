/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

#if (defined(__aarch64__) || defined(_M_ARM64)) && !defined(AREION_FORCE_PORTABLE)

#undef areion_soem256x4
#undef areion_soem512x4
#undef areion_em_encrypt256x4
#undef areion_em_decrypt256x4
#undef areion_em_encrypt512x4
#undef areion_em_decrypt512x4
#undef areion_em2_encrypt256x4
#undef areion_em2_decrypt256x4
#undef areion_em2_encrypt512x4
#undef areion_em2_decrypt512x4
#undef areion_tem_encrypt256x4
#undef areion_tem_decrypt256x4
#undef areion_tem_encrypt512x4
#undef areion_tem_decrypt512x4
#undef areion_tem2_encrypt256x4
#undef areion_tem2_decrypt256x4
#undef areion_tem2_encrypt512x4
#undef areion_tem2_decrypt512x4
#undef areion_aes128_encrypt_block
#undef areion_aes128_encrypt4_blocks

/* =========================================================================
 * External Assembly Kernel Declarations (areion_arm64.S)
 * ========================================================================= */

extern void aesRoundAsm(uint8_t *block, const uint8_t *roundKey) AREION_INTERNAL;
extern void aesFinalRoundAsm(uint8_t *block, const uint8_t *roundKey) AREION_INTERNAL;
extern void aesRoundWordsAsm(uint32_t *out, const uint32_t *in) AREION_INTERNAL;
extern void aesFinalRoundWordsAsm(uint32_t *out, const uint32_t *in) AREION_INTERNAL;
extern void aesRound4Asm(uint8_t *blocks, const uint8_t *roundKeys) AREION_INTERNAL;
extern void aesFinalRound4Asm(uint8_t *blocks, const uint8_t *roundKeys) AREION_INTERNAL;
extern void aesRound4PtrsAsm(
    uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3,
    const uint8_t *rk0, const uint8_t *rk1, const uint8_t *rk2, const uint8_t *rk3) AREION_INTERNAL;
extern void aesFinalRound4PtrsAsm(
    uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3,
    const uint8_t *rk0, const uint8_t *rk1, const uint8_t *rk2, const uint8_t *rk3) AREION_INTERNAL;
extern void aes128ExpandKeyAsm(const uint8_t *key, uint8_t *rk) AREION_INTERNAL;

extern void aes128EncryptBlockAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void aes128Encrypt4BlocksAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256EncryptBlockAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256Encrypt4BlocksAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;

extern void vistrutah256EncryptBlockAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Encrypt4BlocksAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock256Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock512Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks256Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks512Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;

extern void areion256PermuteRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;
extern void areion256InversePermuteRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;
extern void areion512PermuteRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;
extern void areion512InversePermuteRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;

extern void areion256DMAsm(uint8_t *out, const uint8_t *in) AREION_INTERNAL;
extern void areion512DMAsm(uint8_t *out, const uint8_t *in) AREION_INTERNAL;

extern void areionSoEM256Asm(uint8_t *out, const uint8_t *key, const uint8_t *m) AREION_INTERNAL;
extern void areionSoEM512Asm(uint8_t *out, const uint8_t *key, const uint8_t *m) AREION_INTERNAL;

extern void areion256Permutex4RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion256InversePermutex4RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion512Permutex4RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion512InversePermutex4RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;

extern void areion256SoEMPermutex4NEON(uint8_t *out, const uint8_t *in, const uint8_t *k) AREION_INTERNAL;
extern void areion512SoEMPermutex4NEON(uint8_t *out, const uint8_t *in, const uint8_t *k) AREION_INTERNAL;

extern void areion256EMEncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EMDecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMEncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMDecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;

extern void areion256EM2EncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2DecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2EncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2DecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;

extern void areion256TEMEncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEMDecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMEncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMDecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;

extern void areion256TEM2EncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2DecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2EncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2DecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;

extern void areion256EMEncryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EMDecryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMEncryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMDecryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;

extern void areion256EM2Encryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2Decryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2Encryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2Decryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;

extern void areion256TEMEncryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEMDecryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMEncryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMDecryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;

extern void areion256TEM2Encryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2Decryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2Encryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2Decryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;

/* =========================================================================
 * Single-Block Permutations
 * ========================================================================= */

void areion_permute256(uint8_t state[32]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion256PermuteRCAsm(state, &roundConstantsP1[0][0]);
        AREION_MSAN_UNPOISON(state, 32U);
            return;
    }
    areion_permute256_purec(state);
}

void areion_inverse_permute256(uint8_t state[32]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion256InversePermuteRCAsm(state, &roundConstantsP1[0][0]);
        AREION_MSAN_UNPOISON(state, 32U);
            return;
    }
    areion_inverse_permute256_purec(state);
}

void areion_permute512(uint8_t state[64]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion512PermuteRCAsm(state, &roundConstantsP1[0][0]);
        AREION_MSAN_UNPOISON(state, 64U);
            return;
    }
    areion_permute512_purec(state);
}

void areion_inverse_permute512(uint8_t state[64]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion512InversePermuteRCAsm(state, &roundConstantsP1[0][0]);
        AREION_MSAN_UNPOISON(state, 64U);
            return;
    }
    areion_inverse_permute512_purec(state);
}

void areion_permute256_p2(uint8_t state[32]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion256PermuteRCAsm(state, &roundConstantsP2[0][0]);
        AREION_MSAN_UNPOISON(state, 32U);
            return;
    }
    areion_permute256_p2_purec(state);
}

void areion_inverse_permute256_p2(uint8_t state[32]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion256InversePermuteRCAsm(state, &roundConstantsP2[0][0]);
        AREION_MSAN_UNPOISON(state, 32U);
            return;
    }
    areion_inverse_permute256_p2_purec(state);
}

void areion_permute512_p2(uint8_t state[64]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion512PermuteRCAsm(state, &roundConstantsP2[0][0]);
        AREION_MSAN_UNPOISON(state, 64U);
            return;
    }
    areion_permute512_p2_purec(state);
}

void areion_inverse_permute512_p2(uint8_t state[64]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion512InversePermuteRCAsm(state, &roundConstantsP2[0][0]);
        AREION_MSAN_UNPOISON(state, 64U);
            return;
    }
    areion_inverse_permute512_p2_purec(state);
}

/* =========================================================================
 * Davies-Meyer Compression Functions
 * ========================================================================= */

void areion_dm256(uint8_t out[32], const uint8_t in[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_dm256_purec(out, in);
        return;
    }
    areion256DMAsm(out, in);
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_dm512(uint8_t out[32], const uint8_t in[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_dm512_purec(out, in);
        return;
    }
    areion512DMAsm(out, in);
    AREION_MSAN_UNPOISON(out, 32U);
}

/* =========================================================================
 * Sum-of-Even-Mansour (SoEM) Single & 4-Way
 * ========================================================================= */

void areion_soem256(uint8_t out[32], const uint8_t key[64], const uint8_t in[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_soem256_purec(out, key, in);
        return;
    }
    areionSoEM256Asm(out, key, in);
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_soem512(uint8_t out[64], const uint8_t key[128], const uint8_t in[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_soem512_purec(out, key, in);
        return;
    }
    areionSoEM512Asm(out, key, in);
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_soem256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t inputs[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_soem256x4_purec(out, keys, inputs);
        return;
    }
    areion256SoEMPermutex4NEON(&out[0][0], &inputs[0][0], &keys[0][0]);
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_soem512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t inputs[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_soem512x4_purec(out, keys, inputs);
        return;
    }
    areion512SoEMPermutex4NEON(&out[0][0], &inputs[0][0], &keys[0][0]);
    AREION_MSAN_UNPOISON(out, 256U);
}

/* =========================================================================
 * 4-Way Parallel Permutations
 * ========================================================================= */

void areion_permute256x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_permute256x4_purec(b0, b1, b2, b3);
        return;
    }
    areion256Permutex4RC(b0, b1, b2, b3, &roundConstantsP1[0][0]);
    AREION_MSAN_UNPOISON(b0, 32U);
    AREION_MSAN_UNPOISON(b1, 32U);
    AREION_MSAN_UNPOISON(b2, 32U);
    AREION_MSAN_UNPOISON(b3, 32U);
}

void areion_permute256_p2x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_permute256_p2x4_purec(b0, b1, b2, b3);
        return;
    }
    areion256Permutex4RC(b0, b1, b2, b3, &roundConstantsP2[0][0]);
    AREION_MSAN_UNPOISON(b0, 32U);
    AREION_MSAN_UNPOISON(b1, 32U);
    AREION_MSAN_UNPOISON(b2, 32U);
    AREION_MSAN_UNPOISON(b3, 32U);
}

void areion_inverse_permute256x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_inverse_permute256x4_purec(b0, b1, b2, b3);
        return;
    }
    areion256InversePermutex4RC(b0, b1, b2, b3, &roundConstantsP1[0][0]);
    AREION_MSAN_UNPOISON(b0, 32U);
    AREION_MSAN_UNPOISON(b1, 32U);
    AREION_MSAN_UNPOISON(b2, 32U);
    AREION_MSAN_UNPOISON(b3, 32U);
}

void areion_inverse_permute256_p2x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_inverse_permute256_p2x4_purec(b0, b1, b2, b3);
        return;
    }
    areion256InversePermutex4RC(b0, b1, b2, b3, &roundConstantsP2[0][0]);
    AREION_MSAN_UNPOISON(b0, 32U);
    AREION_MSAN_UNPOISON(b1, 32U);
    AREION_MSAN_UNPOISON(b2, 32U);
    AREION_MSAN_UNPOISON(b3, 32U);
}

void areion_permute512x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_permute512x4_purec(b0, b1, b2, b3);
        return;
    }
    areion512Permutex4RC(b0, b1, b2, b3, &roundConstantsP1[0][0]);
    AREION_MSAN_UNPOISON(b0, 64U);
    AREION_MSAN_UNPOISON(b1, 64U);
    AREION_MSAN_UNPOISON(b2, 64U);
    AREION_MSAN_UNPOISON(b3, 64U);
}

void areion_permute512_p2x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_permute512_p2x4_purec(b0, b1, b2, b3);
        return;
    }
    areion512Permutex4RC(b0, b1, b2, b3, &roundConstantsP2[0][0]);
    AREION_MSAN_UNPOISON(b0, 64U);
    AREION_MSAN_UNPOISON(b1, 64U);
    AREION_MSAN_UNPOISON(b2, 64U);
    AREION_MSAN_UNPOISON(b3, 64U);
}

void areion_inverse_permute512x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_inverse_permute512x4_purec(b0, b1, b2, b3);
        return;
    }
    areion512InversePermutex4RC(b0, b1, b2, b3, &roundConstantsP1[0][0]);
    AREION_MSAN_UNPOISON(b0, 64U);
    AREION_MSAN_UNPOISON(b1, 64U);
    AREION_MSAN_UNPOISON(b2, 64U);
    AREION_MSAN_UNPOISON(b3, 64U);
}

void areion_inverse_permute512_p2x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_inverse_permute512_p2x4_purec(b0, b1, b2, b3);
        return;
    }
    areion512InversePermutex4RC(b0, b1, b2, b3, &roundConstantsP2[0][0]);
    AREION_MSAN_UNPOISON(b0, 64U);
    AREION_MSAN_UNPOISON(b1, 64U);
    AREION_MSAN_UNPOISON(b2, 64U);
    AREION_MSAN_UNPOISON(b3, 64U);
}

/* =========================================================================
 * Wide-Block Even-Mansour (EM / EM2) and Tweakable Even-Mansour (TEM / TEM2)
 * ========================================================================= */

void areion_em_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_encrypt256_purec(out, k, m);
        return;
    }
    areion256EMEncryptAsm(out, m, k);
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_em_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_decrypt256_purec(out, k, c);
        return;
    }
    areion256EMDecryptAsm(out, c, k);
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_em_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_encrypt512_purec(out, k, m);
        return;
    }
    areion512EMEncryptAsm(out, m, k);
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_em_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_decrypt512_purec(out, k, c);
        return;
    }
    areion512EMDecryptAsm(out, c, k);
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_em_encrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_encrypt256x4_purec(out, keys, msgs);
        return;
    }
    areion256EMEncryptx4Asm(&out[0][0], &msgs[0][0], &keys[0][0]);
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_em_decrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_decrypt256x4_purec(out, keys, ct);
        return;
    }
    areion256EMDecryptx4Asm(&out[0][0], &ct[0][0], &keys[0][0]);
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_em_encrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_encrypt512x4_purec(out, keys, msgs);
        return;
    }
    areion512EMEncryptx4Asm(&out[0][0], &msgs[0][0], &keys[0][0]);
    AREION_MSAN_UNPOISON(out, 256U);
}

void areion_em_decrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_decrypt512x4_purec(out, keys, ct);
        return;
    }
    areion512EMDecryptx4Asm(&out[0][0], &ct[0][0], &keys[0][0]);
    AREION_MSAN_UNPOISON(out, 256U);
}

void areion_em2_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_encrypt256_purec(out, k, m);
        return;
    }
    areion256EM2EncryptAsm(out, m, k);
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_em2_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_decrypt256_purec(out, k, c);
        return;
    }
    areion256EM2DecryptAsm(out, c, k);
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_em2_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_encrypt512_purec(out, k, m);
        return;
    }
    areion512EM2EncryptAsm(out, m, k);
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_em2_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_decrypt512_purec(out, k, c);
        return;
    }
    areion512EM2DecryptAsm(out, c, k);
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_em2_encrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_encrypt256x4_purec(out, keys, msgs);
        return;
    }
    areion256EM2Encryptx4Asm(&out[0][0], &msgs[0][0], &keys[0][0]);
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_em2_decrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_decrypt256x4_purec(out, keys, ct);
        return;
    }
    areion256EM2Decryptx4Asm(&out[0][0], &ct[0][0], &keys[0][0]);
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_em2_encrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_encrypt512x4_purec(out, keys, msgs);
        return;
    }
    areion512EM2Encryptx4Asm(&out[0][0], &msgs[0][0], &keys[0][0]);
    AREION_MSAN_UNPOISON(out, 256U);
}

void areion_em2_decrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_decrypt512x4_purec(out, keys, ct);
        return;
    }
    areion512EM2Decryptx4Asm(&out[0][0], &ct[0][0], &keys[0][0]);
    AREION_MSAN_UNPOISON(out, 256U);
}

void areion_tem_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_encrypt256_purec(out, k, t, m);
        return;
    }
    areion256TEMEncryptAsm(out, m, k, t);
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_tem_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_decrypt256_purec(out, k, t, c);
        return;
    }
    areion256TEMDecryptAsm(out, c, k, t);
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_tem_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_encrypt512_purec(out, k, t, m);
        return;
    }
    areion512TEMEncryptAsm(out, m, k, t);
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_tem_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_decrypt512_purec(out, k, t, c);
        return;
    }
    areion512TEMDecryptAsm(out, c, k, t);
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_tem_encrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_encrypt256x4_purec(out, keys, tweaks, msgs);
        return;
    }
    areion256TEMEncryptx4Asm(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_tem_decrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_decrypt256x4_purec(out, keys, tweaks, ct);
        return;
    }
    areion256TEMDecryptx4Asm(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_tem_encrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_encrypt512x4_purec(out, keys, tweaks, msgs);
        return;
    }
    areion512TEMEncryptx4Asm(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    AREION_MSAN_UNPOISON(out, 256U);
}

void areion_tem_decrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_decrypt512x4_purec(out, keys, tweaks, ct);
        return;
    }
    areion512TEMDecryptx4Asm(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    AREION_MSAN_UNPOISON(out, 256U);
}

void areion_tem2_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_encrypt256_purec(out, k, t, m);
        return;
    }
    areion256TEM2EncryptAsm(out, m, k, t);
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_tem2_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_decrypt256_purec(out, k, t, c);
        return;
    }
    areion256TEM2DecryptAsm(out, c, k, t);
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_tem2_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_encrypt512_purec(out, k, t, m);
        return;
    }
    areion512TEM2EncryptAsm(out, m, k, t);
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_tem2_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_decrypt512_purec(out, k, t, c);
        return;
    }
    areion512TEM2DecryptAsm(out, c, k, t);
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_tem2_encrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_encrypt256x4_purec(out, keys, tweaks, msgs);
        return;
    }
    areion256TEM2Encryptx4Asm(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_tem2_decrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_decrypt256x4_purec(out, keys, tweaks, ct);
        return;
    }
    areion256TEM2Decryptx4Asm(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_tem2_encrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_encrypt512x4_purec(out, keys, tweaks, msgs);
        return;
    }
    areion512TEM2Encryptx4Asm(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    AREION_MSAN_UNPOISON(out, 256U);
}

void areion_tem2_decrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_decrypt512x4_purec(out, keys, tweaks, ct);
        return;
    }
    areion512TEM2Decryptx4Asm(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    AREION_MSAN_UNPOISON(out, 256U);
}

/* =========================================================================
 * AES Round Primitives & AES-128 Block Helpers
 * ========================================================================= */

void areion_round(const uint32_t in[4], uint32_t out[4]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_round_purec(in, out);
        return;
    }
    aesRoundWordsAsm(out, in);
    AREION_MSAN_UNPOISON(out, 16U);
}

void areion_final_round(const uint32_t in[4], uint32_t out[4]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_final_round_purec(in, out);
        return;
    }
    aesFinalRoundWordsAsm(out, in);
    AREION_MSAN_UNPOISON(out, 16U);
}

void areion_inv_round(const uint32_t in[4], uint32_t out[4]) {
    areion_inv_round_purec(in, out);
}

void areion_inv_final_round(const uint32_t in[4], uint32_t out[4]) {
    areion_inv_final_round_purec(in, out);
}

void areion_inv_mix_columns(const uint32_t in[4], uint32_t out[4]) {
    areion_inv_mix_columns_purec(in, out);
}

void areion_aes_round_hw(uint8_t block[16], const uint8_t rk[16]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        aesRoundAsm(block, rk);
        AREION_MSAN_UNPOISON(block, 16U);
            return;
    }
    areion_aes_round_purec(block, rk);
}

void areion_aes_final_round_hw(uint8_t block[16], const uint8_t rk[16]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        aesFinalRoundAsm(block, rk);
        AREION_MSAN_UNPOISON(block, 16U);
            return;
    }
    areion_aes_final_round_purec(block, rk);
}

void areion_round4_hw(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16]) {
    static const uint8_t zero_rk[16] = {0};
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_round4_purec(b0, b1, b2, b3);
        return;
    }
    aesRound4PtrsAsm(b0, b1, b2, b3, zero_rk, zero_rk, zero_rk, zero_rk);
    AREION_MSAN_UNPOISON(b0, 16U);
    AREION_MSAN_UNPOISON(b1, 16U);
    AREION_MSAN_UNPOISON(b2, 16U);
    AREION_MSAN_UNPOISON(b3, 16U);
}

void areion_final_round4_hw(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16]) {
    static const uint8_t zero_rk[16] = {0};
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_final_round4_purec(b0, b1, b2, b3);
        return;
    }
    aesFinalRound4PtrsAsm(b0, b1, b2, b3, zero_rk, zero_rk, zero_rk, zero_rk);
    AREION_MSAN_UNPOISON(b0, 16U);
    AREION_MSAN_UNPOISON(b1, 16U);
    AREION_MSAN_UNPOISON(b2, 16U);
    AREION_MSAN_UNPOISON(b3, 16U);
}

void areion_aes_round4_hw(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_aes_round4_purec(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
        return;
    }
    aesRound4PtrsAsm(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
    AREION_MSAN_UNPOISON(b0, 16U);
    AREION_MSAN_UNPOISON(b1, 16U);
    AREION_MSAN_UNPOISON(b2, 16U);
    AREION_MSAN_UNPOISON(b3, 16U);
}

void areion_aes_final_round4_hw(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_aes_final_round4_purec(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
        return;
    }
    aesFinalRound4PtrsAsm(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
    AREION_MSAN_UNPOISON(b0, 16U);
    AREION_MSAN_UNPOISON(b1, 16U);
    AREION_MSAN_UNPOISON(b2, 16U);
    AREION_MSAN_UNPOISON(b3, 16U);
}

void areion_expand_key128(const uint8_t key[16], uint8_t rk[11][16]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_expand_key128_purec(key, rk);
        return;
    }
    aes128ExpandKeyAsm(key, &rk[0][0]);
    AREION_MSAN_UNPOISON(rk, 176U);
}

void areion_aes128_encrypt_block(uint8_t dst[16], const uint8_t src[16], const uint8_t rk[11][16]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        aes128EncryptBlockAsm(&rk[0][0], dst, src);
        AREION_MSAN_UNPOISON(dst, 16U);
            return;
    }
    areion_aes128_encrypt_block_purec(dst, src, rk);
}

void areion_aes128_encrypt4_blocks(
    uint8_t dst[4][16], const uint8_t src[4][16], const uint8_t rk[11][16]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        aes128Encrypt4BlocksAsm(&rk[0][0], &dst[0][0], &src[0][0]);
        AREION_MSAN_UNPOISON(dst, 64U);
            return;
    }
    areion_aes128_encrypt4_blocks_purec(dst, src, rk);
}

void areion_rijndael256_encrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[15][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_rijndael256_encrypt_block_purec(dst, src, rk);
        return;
    }
    rijndael256EncryptBlockAsm(&rk[0][0], dst, src);
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_rijndael256_encrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[15][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_rijndael256_encrypt4_blocks_purec(dst, src, rk);
        return;
    }
    rijndael256Encrypt4BlocksAsm(&rk[0][0], &dst[0][0], &src[0][0]);
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_vistrutah256_encrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds) {
    if (areion_tier_code() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 14)) {
        areion_vistrutah256_encrypt_block_purec(dst, src, key, rounds);
        return;
    }
    vistrutah256EncryptBlockAsm(dst, src, key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_vistrutah256_encrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds) {
    if (areion_tier_code() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 14)) {
        areion_vistrutah256_encrypt4_blocks_purec(dst, src, key, rounds);
        return;
    }
    vistrutah256Encrypt4BlocksAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_vistrutah512_encrypt_block_256_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds) {
    if (areion_tier_code() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt_block_256_purec(dst, src, key, rounds);
        return;
    }
    vistrutah512EncryptBlock256Asm(dst, src, key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 64U);
}

void areion_vistrutah512_encrypt_block_512_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds) {
    if (areion_tier_code() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt_block_512_purec(dst, src, key, rounds);
        return;
    }
    vistrutah512EncryptBlock512Asm(dst, src, key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 64U);
}

void areion_vistrutah512_encrypt4_blocks_256_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds) {
    if (areion_tier_code() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt4_blocks_256_purec(dst, src, key, rounds);
        return;
    }
    vistrutah512Encrypt4Blocks256Asm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 256U);
}

void areion_vistrutah512_encrypt4_blocks_512_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds) {
    if (areion_tier_code() != AREION_TIER_ARM64 || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt4_blocks_512_purec(dst, src, key, rounds);
        return;
    }
    vistrutah512Encrypt4Blocks512Asm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    AREION_MSAN_UNPOISON(dst, 256U);
}

#else
typedef int areion_arm64_unused_t;
#endif
