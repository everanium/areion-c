/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"
#include "soa.h"

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
extern void aesRound4Asm(uint8_t *blocks, const uint8_t *roundKeys) AREION_INTERNAL;
extern void aesFinalRound4Asm(uint8_t *blocks, const uint8_t *roundKeys) AREION_INTERNAL;

extern void aes128EncryptBlockAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void aes128Encrypt4BlocksAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;

extern void areion256PermuteRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;
extern void areion256InversePermuteRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;
extern void areion512PermuteRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;
extern void areion512InversePermuteRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;

extern void areionSoEM256Asm(uint8_t *out, const uint8_t *key, const uint8_t *m) AREION_INTERNAL;
extern void areionSoEM512Asm(uint8_t *out, const uint8_t *key, const uint8_t *m) AREION_INTERNAL;

extern void areion256Permutex4RC(uint8_t *x0, uint8_t *x1, const uint8_t *rc) AREION_INTERNAL;
extern void areion256InversePermutex4RC(uint8_t *x0, uint8_t *x1, const uint8_t *rc) AREION_INTERNAL;
extern void areion512Permutex4RC(uint8_t *x0, uint8_t *x1, uint8_t *x2, uint8_t *x3, const uint8_t *rc) AREION_INTERNAL;
extern void areion512InversePermutex4RC(uint8_t *x0, uint8_t *x1, uint8_t *x2, uint8_t *x3, const uint8_t *rc) AREION_INTERNAL;

extern void areion256SoEMPermutex4NEON(uint8_t *u0, uint8_t *u1, uint8_t *v0, uint8_t *v1) AREION_INTERNAL;
extern void areion512SoEMPermutex4NEON(
    uint8_t *u0, uint8_t *u1, uint8_t *u2, uint8_t *u3,
    uint8_t *v0, uint8_t *v1, uint8_t *v2, uint8_t *v3) AREION_INTERNAL;

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

/* =========================================================================
 * Single-Block Permutations
 * ========================================================================= */

void areion_permute256(uint8_t state[32]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion256PermuteRCAsm(state, &roundConstantsP1[0][0]);
        return;
    }
    areion_permute256_purec(state);
}

void areion_inverse_permute256(uint8_t state[32]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion256InversePermuteRCAsm(state, &roundConstantsP1[0][0]);
        return;
    }
    areion_inverse_permute256_purec(state);
}

void areion_permute512(uint8_t state[64]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion512PermuteRCAsm(state, &roundConstantsP1[0][0]);
        return;
    }
    areion_permute512_purec(state);
}

void areion_inverse_permute512(uint8_t state[64]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion512InversePermuteRCAsm(state, &roundConstantsP1[0][0]);
        return;
    }
    areion_inverse_permute512_purec(state);
}

void areion_permute256_p2(uint8_t state[32]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion256PermuteRCAsm(state, &roundConstantsP2[0][0]);
        return;
    }
    areion_permute256_p2_purec(state);
}

void areion_inverse_permute256_p2(uint8_t state[32]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion256InversePermuteRCAsm(state, &roundConstantsP2[0][0]);
        return;
    }
    areion_inverse_permute256_p2_purec(state);
}

void areion_permute512_p2(uint8_t state[64]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion512PermuteRCAsm(state, &roundConstantsP2[0][0]);
        return;
    }
    areion_permute512_p2_purec(state);
}

void areion_inverse_permute512_p2(uint8_t state[64]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        areion512InversePermuteRCAsm(state, &roundConstantsP2[0][0]);
        return;
    }
    areion_inverse_permute512_p2_purec(state);
}

/* =========================================================================
 * Davies-Meyer Compression Functions
 * ========================================================================= */

static AREION_NOINLINE void dm256_arm64_body(uint8_t out[32], const uint8_t in[32]) {
    uint8_t buf[32], in_copy[32];
    size_t i;
    AREION_OPAQUE_PTR(in);
    memcpy(buf, in, 32);
    memcpy(in_copy, in, 32);
    areion256PermuteRCAsm(buf, &roundConstantsP1[0][0]);
    for (i = 0; i < 32; i++) {
        out[i] = (uint8_t)(buf[i] ^ in_copy[i]);
    }
    areion_secure_wipe(buf, sizeof(buf));
    areion_secure_wipe(in_copy, sizeof(in_copy));
}

void areion_dm256(uint8_t out[32], const uint8_t in[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_dm256_purec(out, in);
        return;
    }
    dm256_arm64_body(out, in);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void dm512_arm64_body(uint8_t out[32], const uint8_t in[64]) {
    uint8_t buf[64], in_copy[64];
    size_t i;
    AREION_OPAQUE_PTR(in);
    memcpy(buf, in, 64);
    memcpy(in_copy, in, 64);
    areion512PermuteRCAsm(buf, &roundConstantsP1[0][0]);
    for (i = 0; i < 64; i++) {
        buf[i] ^= in_copy[i];
    }
    memcpy(&out[0], &buf[8], 8);
    memcpy(&out[8], &buf[24], 8);
    memcpy(&out[16], &buf[32], 8);
    memcpy(&out[24], &buf[48], 8);
    areion_secure_wipe(buf, sizeof(buf));
    areion_secure_wipe(in_copy, sizeof(in_copy));
}

void areion_dm512(uint8_t out[32], const uint8_t in[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_dm512_purec(out, in);
        return;
    }
    dm512_arm64_body(out, in);
    areion_clobber_scratch_gprs();
}

/* =========================================================================
 * Sum-of-Even-Mansour (SoEM) Single & 4-Way
 * ========================================================================= */

static AREION_NOINLINE void soem256_arm64_body(
    uint8_t out[32], const uint8_t key[64], const uint8_t in[32]) {
    uint8_t buf[32];
    AREION_OPAQUE_PTR(key);
    AREION_OPAQUE_PTR(in);
    areionSoEM256Asm(buf, key, in);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 32);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_soem256(uint8_t out[32], const uint8_t key[64], const uint8_t in[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_soem256_purec(out, key, in);
        return;
    }
    soem256_arm64_body(out, key, in);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void soem512_arm64_body(
    uint8_t out[64], const uint8_t key[128], const uint8_t in[64]) {
    uint8_t buf[64];
    AREION_OPAQUE_PTR(key);
    AREION_OPAQUE_PTR(in);
    areionSoEM512Asm(buf, key, in);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 64);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_soem512(uint8_t out[64], const uint8_t key[128], const uint8_t in[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_soem512_purec(out, key, in);
        return;
    }
    soem512_arm64_body(out, key, in);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void soem256x4_arm64_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t inputs[4][32]) {
    uint8_t s1b0[64], s1b1[64], s2b0[64], s2b1[64];
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(inputs);
    prepareSoEM256x4SoA(keys, inputs, s1b0, s1b1, s2b0, s2b1);
    areion_compiler_barrier();
    areion256SoEMPermutex4NEON(s1b0, s1b1, s2b0, s2b1);
    areion_compiler_barrier();
    finishSoEM256x4SoA(s1b0, s1b1, keys, out);
    areion_secure_wipe(s1b0, sizeof(s1b0));
    areion_secure_wipe(s1b1, sizeof(s1b1));
    areion_secure_wipe(s2b0, sizeof(s2b0));
    areion_secure_wipe(s2b1, sizeof(s2b1));
}

void areion_soem256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t inputs[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_soem256x4_purec(out, keys, inputs);
        return;
    }
    soem256x4_arm64_body(out, keys, inputs);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void soem512x4_arm64_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t inputs[4][64]) {
    uint8_t a1[64], b1[64], c1[64], d1[64];
    uint8_t a2[64], b2[64], c2[64], d2[64];
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(inputs);
    prepareSoEM512x4SoA(keys, inputs, a1, b1, c1, d1, a2, b2, c2, d2);
    areion_compiler_barrier();
    areion512SoEMPermutex4NEON(a1, b1, c1, d1, a2, b2, c2, d2);
    areion_compiler_barrier();
    finishSoEM512x4SoA(a1, b1, c1, d1, keys, out);
    areion_secure_wipe(a1, sizeof(a1));
    areion_secure_wipe(b1, sizeof(b1));
    areion_secure_wipe(c1, sizeof(c1));
    areion_secure_wipe(d1, sizeof(d1));
    areion_secure_wipe(a2, sizeof(a2));
    areion_secure_wipe(b2, sizeof(b2));
    areion_secure_wipe(c2, sizeof(c2));
    areion_secure_wipe(d2, sizeof(d2));
}

void areion_soem512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t inputs[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_soem512x4_purec(out, keys, inputs);
        return;
    }
    soem512x4_arm64_body(out, keys, inputs);
    areion_clobber_scratch_gprs();
}

/* =========================================================================
 * 4-Way Parallel Permutations
 * ========================================================================= */

static AREION_NOINLINE void permute256x4_arm64_body(
    uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32],
    const uint8_t *rc, bool inv) {
    uint8_t x0[64], x1[64];
    pack256x4SoAInto(b0, b1, b2, b3, x0, x1);

    areion_compiler_barrier();
    if (!inv) {
        areion256Permutex4RC(x0, x1, rc);
    } else {
        areion256InversePermutex4RC(x0, x1, rc);
    }
    areion_compiler_barrier();

    unpack256x4SoA(x0, x1, b0, b1, b2, b3);

    areion_secure_wipe(x0, sizeof(x0));
    areion_secure_wipe(x1, sizeof(x1));
}

void areion_permute256x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_permute256x4_purec(b0, b1, b2, b3);
        return;
    }
    permute256x4_arm64_body(b0, b1, b2, b3, &roundConstantsP1[0][0], false);
    areion_clobber_scratch_gprs();
}

void areion_permute256_p2x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_permute256_p2x4_purec(b0, b1, b2, b3);
        return;
    }
    permute256x4_arm64_body(b0, b1, b2, b3, &roundConstantsP2[0][0], false);
    areion_clobber_scratch_gprs();
}

void areion_inverse_permute256x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_inverse_permute256x4_purec(b0, b1, b2, b3);
        return;
    }
    permute256x4_arm64_body(b0, b1, b2, b3, &roundConstantsP1[0][0], true);
    areion_clobber_scratch_gprs();
}

void areion_inverse_permute256_p2x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_inverse_permute256_p2x4_purec(b0, b1, b2, b3);
        return;
    }
    permute256x4_arm64_body(b0, b1, b2, b3, &roundConstantsP2[0][0], true);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void permute512x4_arm64_body(
    uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64],
    const uint8_t *rc, bool inv) {
    uint8_t x0[64], x1[64], x2[64], x3[64];
    pack512x4SoAInto(b0, b1, b2, b3, x0, x1, x2, x3);

    areion_compiler_barrier();
    if (!inv) {
        areion512Permutex4RC(x0, x1, x2, x3, rc);
    } else {
        areion512InversePermutex4RC(x0, x1, x2, x3, rc);
    }
    areion_compiler_barrier();

    unpack512x4SoA(x0, x1, x2, x3, b0, b1, b2, b3);

    areion_secure_wipe(x0, sizeof(x0));
    areion_secure_wipe(x1, sizeof(x1));
    areion_secure_wipe(x2, sizeof(x2));
    areion_secure_wipe(x3, sizeof(x3));
}

void areion_permute512x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_permute512x4_purec(b0, b1, b2, b3);
        return;
    }
    permute512x4_arm64_body(b0, b1, b2, b3, &roundConstantsP1[0][0], false);
    areion_clobber_scratch_gprs();
}

void areion_permute512_p2x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_permute512_p2x4_purec(b0, b1, b2, b3);
        return;
    }
    permute512x4_arm64_body(b0, b1, b2, b3, &roundConstantsP2[0][0], false);
    areion_clobber_scratch_gprs();
}

void areion_inverse_permute512x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_inverse_permute512x4_purec(b0, b1, b2, b3);
        return;
    }
    permute512x4_arm64_body(b0, b1, b2, b3, &roundConstantsP1[0][0], true);
    areion_clobber_scratch_gprs();
}

void areion_inverse_permute512_p2x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_inverse_permute512_p2x4_purec(b0, b1, b2, b3);
        return;
    }
    permute512x4_arm64_body(b0, b1, b2, b3, &roundConstantsP2[0][0], true);
    areion_clobber_scratch_gprs();
}

/* =========================================================================
 * Wide-Block Even-Mansour (EM / EM2) and Tweakable Even-Mansour (TEM / TEM2)
 * ========================================================================= */

static AREION_NOINLINE void em_encrypt256_arm64_body(
    uint8_t out[32], const uint8_t k[64], const uint8_t m[32]) {
    uint8_t buf[32];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(m);
    areion256EMEncryptAsm(buf, m, k);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 32);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_em_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_encrypt256_purec(out, k, m);
        return;
    }
    em_encrypt256_arm64_body(out, k, m);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em_decrypt256_arm64_body(
    uint8_t out[32], const uint8_t k[64], const uint8_t c[32]) {
    uint8_t buf[32];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(c);
    areion256EMDecryptAsm(buf, c, k);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 32);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_em_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_decrypt256_purec(out, k, c);
        return;
    }
    em_decrypt256_arm64_body(out, k, c);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em_encrypt512_arm64_body(
    uint8_t out[64], const uint8_t k[128], const uint8_t m[64]) {
    uint8_t buf[64];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(m);
    areion512EMEncryptAsm(buf, m, k);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 64);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_em_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_encrypt512_purec(out, k, m);
        return;
    }
    em_encrypt512_arm64_body(out, k, m);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em_decrypt512_arm64_body(
    uint8_t out[64], const uint8_t k[128], const uint8_t c[64]) {
    uint8_t buf[64];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(c);
    areion512EMDecryptAsm(buf, c, k);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 64);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_em_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_decrypt512_purec(out, k, c);
        return;
    }
    em_decrypt512_arm64_body(out, k, c);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em_encrypt256x4_arm64_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]) {
    uint8_t b0[64], b1[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &msgs[lane][0], &keys[lane][0]);
        xor16(&b1[lane * 16], &msgs[lane][16], &keys[lane][16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256Permutex4RC(b0, b1, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &keys[lane][32]);
        xor16(&b1[lane * 16], &b1[lane * 16], &keys[lane][48]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack256x4SoA(b0, b1, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
}

void areion_em_encrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_encrypt256x4_purec(out, keys, msgs);
        return;
    }
    em_encrypt256x4_arm64_body(out, keys, msgs);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em_decrypt256x4_arm64_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]) {
    uint8_t b0[64], b1[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &ct[lane][0], &keys[lane][32]);
        xor16(&b1[lane * 16], &ct[lane][16], &keys[lane][48]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256InversePermutex4RC(b0, b1, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &keys[lane][0]);
        xor16(&b1[lane * 16], &b1[lane * 16], &keys[lane][16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack256x4SoA(b0, b1, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
}

void areion_em_decrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_decrypt256x4_purec(out, keys, ct);
        return;
    }
    em_decrypt256x4_arm64_body(out, keys, ct);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em_encrypt512x4_arm64_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]) {
    uint8_t b0[64], b1[64], b2[64], b3[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &msgs[lane][0], &keys[lane][0]);
        xor16(&b1[lane * 16], &msgs[lane][16], &keys[lane][16]);
        xor16(&b2[lane * 16], &msgs[lane][32], &keys[lane][32]);
        xor16(&b3[lane * 16], &msgs[lane][48], &keys[lane][48]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512Permutex4RC(b0, b1, b2, b3, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &keys[lane][64]);
        xor16(&b1[lane * 16], &b1[lane * 16], &keys[lane][80]);
        xor16(&b2[lane * 16], &b2[lane * 16], &keys[lane][96]);
        xor16(&b3[lane * 16], &b3[lane * 16], &keys[lane][112]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack512x4SoA(b0, b1, b2, b3, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
    areion_secure_wipe(b2, sizeof(b2));
    areion_secure_wipe(b3, sizeof(b3));
}

void areion_em_encrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_encrypt512x4_purec(out, keys, msgs);
        return;
    }
    em_encrypt512x4_arm64_body(out, keys, msgs);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em_decrypt512x4_arm64_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]) {
    uint8_t b0[64], b1[64], b2[64], b3[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &ct[lane][0], &keys[lane][64]);
        xor16(&b1[lane * 16], &ct[lane][16], &keys[lane][80]);
        xor16(&b2[lane * 16], &ct[lane][32], &keys[lane][96]);
        xor16(&b3[lane * 16], &ct[lane][48], &keys[lane][112]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512InversePermutex4RC(b0, b1, b2, b3, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &keys[lane][0]);
        xor16(&b1[lane * 16], &b1[lane * 16], &keys[lane][16]);
        xor16(&b2[lane * 16], &b2[lane * 16], &keys[lane][32]);
        xor16(&b3[lane * 16], &b3[lane * 16], &keys[lane][48]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack512x4SoA(b0, b1, b2, b3, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
    areion_secure_wipe(b2, sizeof(b2));
    areion_secure_wipe(b3, sizeof(b3));
}

void areion_em_decrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em_decrypt512x4_purec(out, keys, ct);
        return;
    }
    em_decrypt512x4_arm64_body(out, keys, ct);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_encrypt256_arm64_body(
    uint8_t out[32], const uint8_t k[64], const uint8_t m[32]) {
    uint8_t buf[32];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(m);
    areion256EM2EncryptAsm(buf, m, k);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 32);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_em2_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_encrypt256_purec(out, k, m);
        return;
    }
    em2_encrypt256_arm64_body(out, k, m);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_decrypt256_arm64_body(
    uint8_t out[32], const uint8_t k[64], const uint8_t c[32]) {
    uint8_t buf[32];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(c);
    areion256EM2DecryptAsm(buf, c, k);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 32);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_em2_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_decrypt256_purec(out, k, c);
        return;
    }
    em2_decrypt256_arm64_body(out, k, c);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_encrypt512_arm64_body(
    uint8_t out[64], const uint8_t k[128], const uint8_t m[64]) {
    uint8_t buf[64];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(m);
    areion512EM2EncryptAsm(buf, m, k);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 64);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_em2_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_encrypt512_purec(out, k, m);
        return;
    }
    em2_encrypt512_arm64_body(out, k, m);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_decrypt512_arm64_body(
    uint8_t out[64], const uint8_t k[128], const uint8_t c[64]) {
    uint8_t buf[64];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(c);
    areion512EM2DecryptAsm(buf, c, k);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 64);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_em2_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_decrypt512_purec(out, k, c);
        return;
    }
    em2_decrypt512_arm64_body(out, k, c);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_encrypt256x4_arm64_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]) {
    uint8_t b0[64], b1[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &msgs[lane][0], &keys[lane][0]);
        xor16(&b1[lane * 16], &msgs[lane][16], &keys[lane][16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256Permutex4RC(b0, b1, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &keys[lane][32]);
        xor16(&b1[lane * 16], &b1[lane * 16], &keys[lane][48]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256Permutex4RC(b0, b1, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16_3(&b0[lane * 16], &b0[lane * 16], &keys[lane][0], &keys[lane][32]);
        xor16_3(&b1[lane * 16], &b1[lane * 16], &keys[lane][16], &keys[lane][48]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack256x4SoA(b0, b1, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
}

void areion_em2_encrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_encrypt256x4_purec(out, keys, msgs);
        return;
    }
    em2_encrypt256x4_arm64_body(out, keys, msgs);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_decrypt256x4_arm64_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]) {
    uint8_t b0[64], b1[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        xor16_3(&b0[lane * 16], &ct[lane][0], &keys[lane][0], &keys[lane][32]);
        xor16_3(&b1[lane * 16], &ct[lane][16], &keys[lane][16], &keys[lane][48]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256InversePermutex4RC(b0, b1, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &keys[lane][32]);
        xor16(&b1[lane * 16], &b1[lane * 16], &keys[lane][48]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256InversePermutex4RC(b0, b1, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &keys[lane][0]);
        xor16(&b1[lane * 16], &b1[lane * 16], &keys[lane][16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack256x4SoA(b0, b1, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
}

void areion_em2_decrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_decrypt256x4_purec(out, keys, ct);
        return;
    }
    em2_decrypt256x4_arm64_body(out, keys, ct);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_encrypt512x4_arm64_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]) {
    uint8_t b0[64], b1[64], b2[64], b3[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &msgs[lane][0], &keys[lane][0]);
        xor16(&b1[lane * 16], &msgs[lane][16], &keys[lane][16]);
        xor16(&b2[lane * 16], &msgs[lane][32], &keys[lane][32]);
        xor16(&b3[lane * 16], &msgs[lane][48], &keys[lane][48]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512Permutex4RC(b0, b1, b2, b3, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &keys[lane][64]);
        xor16(&b1[lane * 16], &b1[lane * 16], &keys[lane][80]);
        xor16(&b2[lane * 16], &b2[lane * 16], &keys[lane][96]);
        xor16(&b3[lane * 16], &b3[lane * 16], &keys[lane][112]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512Permutex4RC(b0, b1, b2, b3, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16_3(&b0[lane * 16], &b0[lane * 16], &keys[lane][0], &keys[lane][64]);
        xor16_3(&b1[lane * 16], &b1[lane * 16], &keys[lane][16], &keys[lane][80]);
        xor16_3(&b2[lane * 16], &b2[lane * 16], &keys[lane][32], &keys[lane][96]);
        xor16_3(&b3[lane * 16], &b3[lane * 16], &keys[lane][48], &keys[lane][112]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack512x4SoA(b0, b1, b2, b3, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
    areion_secure_wipe(b2, sizeof(b2));
    areion_secure_wipe(b3, sizeof(b3));
}

void areion_em2_encrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_encrypt512x4_purec(out, keys, msgs);
        return;
    }
    em2_encrypt512x4_arm64_body(out, keys, msgs);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_decrypt512x4_arm64_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]) {
    uint8_t b0[64], b1[64], b2[64], b3[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        xor16_3(&b0[lane * 16], &ct[lane][0], &keys[lane][0], &keys[lane][64]);
        xor16_3(&b1[lane * 16], &ct[lane][16], &keys[lane][16], &keys[lane][80]);
        xor16_3(&b2[lane * 16], &ct[lane][32], &keys[lane][32], &keys[lane][96]);
        xor16_3(&b3[lane * 16], &ct[lane][48], &keys[lane][48], &keys[lane][112]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512InversePermutex4RC(b0, b1, b2, b3, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &keys[lane][64]);
        xor16(&b1[lane * 16], &b1[lane * 16], &keys[lane][80]);
        xor16(&b2[lane * 16], &b2[lane * 16], &keys[lane][96]);
        xor16(&b3[lane * 16], &b3[lane * 16], &keys[lane][112]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512InversePermutex4RC(b0, b1, b2, b3, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &keys[lane][0]);
        xor16(&b1[lane * 16], &b1[lane * 16], &keys[lane][16]);
        xor16(&b2[lane * 16], &b2[lane * 16], &keys[lane][32]);
        xor16(&b3[lane * 16], &b3[lane * 16], &keys[lane][48]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack512x4SoA(b0, b1, b2, b3, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
    areion_secure_wipe(b2, sizeof(b2));
    areion_secure_wipe(b3, sizeof(b3));
}

void areion_em2_decrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_em2_decrypt512x4_purec(out, keys, ct);
        return;
    }
    em2_decrypt512x4_arm64_body(out, keys, ct);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_encrypt256_arm64_body(
    uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]) {
    uint8_t buf[32];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(m);
    areion256TEMEncryptAsm(buf, m, k, t);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 32);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_tem_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_encrypt256_purec(out, k, t, m);
        return;
    }
    tem_encrypt256_arm64_body(out, k, t, m);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_decrypt256_arm64_body(
    uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]) {
    uint8_t buf[32];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(c);
    areion256TEMDecryptAsm(buf, c, k, t);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 32);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_tem_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_decrypt256_purec(out, k, t, c);
        return;
    }
    tem_decrypt256_arm64_body(out, k, t, c);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_encrypt512_arm64_body(
    uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]) {
    uint8_t buf[64];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(m);
    areion512TEMEncryptAsm(buf, m, k, t);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 64);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_tem_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_encrypt512_purec(out, k, t, m);
        return;
    }
    tem_encrypt512_arm64_body(out, k, t, m);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_decrypt512_arm64_body(
    uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]) {
    uint8_t buf[64];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(c);
    areion512TEMDecryptAsm(buf, c, k, t);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 64);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_tem_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_decrypt512_purec(out, k, t, c);
        return;
    }
    tem_decrypt512_arm64_body(out, k, t, c);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_encrypt256x4_arm64_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]) {
    uint8_t w0[64], w1[64], b0[64], b1[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        xor16(&w0[lane * 16], &tweaks[lane][0], &keys[lane][32]);
        xor16(&w1[lane * 16], &tweaks[lane][16], &keys[lane][48]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256Permutex4RC(w0, w1, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&w0[lane * 16], &w0[lane * 16], &keys[lane][0]);
        xor16(&w1[lane * 16], &w1[lane * 16], &keys[lane][16]);
        xor16(&b0[lane * 16], &msgs[lane][0], &w0[lane * 16]);
        xor16(&b1[lane * 16], &msgs[lane][16], &w1[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256Permutex4RC(b0, b1, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &w0[lane * 16]);
        xor16(&b1[lane * 16], &b1[lane * 16], &w1[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack256x4SoA(b0, b1, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(w0, sizeof(w0));
    areion_secure_wipe(w1, sizeof(w1));
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
}

void areion_tem_encrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_encrypt256x4_purec(out, keys, tweaks, msgs);
        return;
    }
    tem_encrypt256x4_arm64_body(out, keys, tweaks, msgs);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_decrypt256x4_arm64_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]) {
    uint8_t w0[64], w1[64], b0[64], b1[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        xor16(&w0[lane * 16], &tweaks[lane][0], &keys[lane][32]);
        xor16(&w1[lane * 16], &tweaks[lane][16], &keys[lane][48]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256Permutex4RC(w0, w1, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&w0[lane * 16], &w0[lane * 16], &keys[lane][0]);
        xor16(&w1[lane * 16], &w1[lane * 16], &keys[lane][16]);
        xor16(&b0[lane * 16], &ct[lane][0], &w0[lane * 16]);
        xor16(&b1[lane * 16], &ct[lane][16], &w1[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256InversePermutex4RC(b0, b1, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &w0[lane * 16]);
        xor16(&b1[lane * 16], &b1[lane * 16], &w1[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack256x4SoA(b0, b1, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(w0, sizeof(w0));
    areion_secure_wipe(w1, sizeof(w1));
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
}

void areion_tem_decrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_decrypt256x4_purec(out, keys, tweaks, ct);
        return;
    }
    tem_decrypt256x4_arm64_body(out, keys, tweaks, ct);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_encrypt512x4_arm64_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]) {
    uint8_t w0[64], w1[64], w2[64], w3[64], b0[64], b1[64], b2[64], b3[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        xor16(&w0[lane * 16], &tweaks[lane][0], &keys[lane][64]);
        xor16(&w1[lane * 16], &tweaks[lane][16], &keys[lane][80]);
        xor16(&w2[lane * 16], &tweaks[lane][32], &keys[lane][96]);
        xor16(&w3[lane * 16], &tweaks[lane][48], &keys[lane][112]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512Permutex4RC(w0, w1, w2, w3, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&w0[lane * 16], &w0[lane * 16], &keys[lane][0]);
        xor16(&w1[lane * 16], &w1[lane * 16], &keys[lane][16]);
        xor16(&w2[lane * 16], &w2[lane * 16], &keys[lane][32]);
        xor16(&w3[lane * 16], &w3[lane * 16], &keys[lane][48]);
        xor16(&b0[lane * 16], &msgs[lane][0], &w0[lane * 16]);
        xor16(&b1[lane * 16], &msgs[lane][16], &w1[lane * 16]);
        xor16(&b2[lane * 16], &msgs[lane][32], &w2[lane * 16]);
        xor16(&b3[lane * 16], &msgs[lane][48], &w3[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512Permutex4RC(b0, b1, b2, b3, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &w0[lane * 16]);
        xor16(&b1[lane * 16], &b1[lane * 16], &w1[lane * 16]);
        xor16(&b2[lane * 16], &b2[lane * 16], &w2[lane * 16]);
        xor16(&b3[lane * 16], &b3[lane * 16], &w3[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack512x4SoA(b0, b1, b2, b3, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(w0, sizeof(w0));
    areion_secure_wipe(w1, sizeof(w1));
    areion_secure_wipe(w2, sizeof(w2));
    areion_secure_wipe(w3, sizeof(w3));
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
    areion_secure_wipe(b2, sizeof(b2));
    areion_secure_wipe(b3, sizeof(b3));
}

void areion_tem_encrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_encrypt512x4_purec(out, keys, tweaks, msgs);
        return;
    }
    tem_encrypt512x4_arm64_body(out, keys, tweaks, msgs);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_decrypt512x4_arm64_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]) {
    uint8_t w0[64], w1[64], w2[64], w3[64], b0[64], b1[64], b2[64], b3[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        xor16(&w0[lane * 16], &tweaks[lane][0], &keys[lane][64]);
        xor16(&w1[lane * 16], &tweaks[lane][16], &keys[lane][80]);
        xor16(&w2[lane * 16], &tweaks[lane][32], &keys[lane][96]);
        xor16(&w3[lane * 16], &tweaks[lane][48], &keys[lane][112]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512Permutex4RC(w0, w1, w2, w3, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&w0[lane * 16], &w0[lane * 16], &keys[lane][0]);
        xor16(&w1[lane * 16], &w1[lane * 16], &keys[lane][16]);
        xor16(&w2[lane * 16], &w2[lane * 16], &keys[lane][32]);
        xor16(&w3[lane * 16], &w3[lane * 16], &keys[lane][48]);
        xor16(&b0[lane * 16], &ct[lane][0], &w0[lane * 16]);
        xor16(&b1[lane * 16], &ct[lane][16], &w1[lane * 16]);
        xor16(&b2[lane * 16], &ct[lane][32], &w2[lane * 16]);
        xor16(&b3[lane * 16], &ct[lane][48], &w3[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512InversePermutex4RC(b0, b1, b2, b3, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &w0[lane * 16]);
        xor16(&b1[lane * 16], &b1[lane * 16], &w1[lane * 16]);
        xor16(&b2[lane * 16], &b2[lane * 16], &w2[lane * 16]);
        xor16(&b3[lane * 16], &b3[lane * 16], &w3[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack512x4SoA(b0, b1, b2, b3, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(w0, sizeof(w0));
    areion_secure_wipe(w1, sizeof(w1));
    areion_secure_wipe(w2, sizeof(w2));
    areion_secure_wipe(w3, sizeof(w3));
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
    areion_secure_wipe(b2, sizeof(b2));
    areion_secure_wipe(b3, sizeof(b3));
}

void areion_tem_decrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem_decrypt512x4_purec(out, keys, tweaks, ct);
        return;
    }
    tem_decrypt512x4_arm64_body(out, keys, tweaks, ct);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_encrypt256_arm64_body(
    uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]) {
    uint8_t buf[32];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(m);
    areion256TEM2EncryptAsm(buf, m, k, t);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 32);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_tem2_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_encrypt256_purec(out, k, t, m);
        return;
    }
    tem2_encrypt256_arm64_body(out, k, t, m);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_decrypt256_arm64_body(
    uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]) {
    uint8_t buf[32];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(c);
    areion256TEM2DecryptAsm(buf, c, k, t);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 32);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_tem2_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_decrypt256_purec(out, k, t, c);
        return;
    }
    tem2_decrypt256_arm64_body(out, k, t, c);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_encrypt512_arm64_body(
    uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]) {
    uint8_t buf[64];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(m);
    areion512TEM2EncryptAsm(buf, m, k, t);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 64);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_tem2_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_encrypt512_purec(out, k, t, m);
        return;
    }
    tem2_encrypt512_arm64_body(out, k, t, m);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_decrypt512_arm64_body(
    uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]) {
    uint8_t buf[64];
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(c);
    areion512TEM2DecryptAsm(buf, c, k, t);
    AREION_MSAN_UNPOISON(buf, sizeof(buf));
    memcpy(out, buf, 64);
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_tem2_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_decrypt512_purec(out, k, t, c);
        return;
    }
    tem2_decrypt512_arm64_body(out, k, t, c);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_encrypt256x4_arm64_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]) {
    uint8_t w1b0[64], w1b1[64], w2b0[64], w2b1[64], b0[64], b1[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        xor16(&w1b0[lane * 16], &tweaks[lane][0], &keys[lane][0]);
        xor16(&w1b1[lane * 16], &tweaks[lane][16], &keys[lane][16]);
        xor16(&w2b0[lane * 16], &tweaks[lane][0], &keys[lane][32]);
        xor16(&w2b1[lane * 16], &tweaks[lane][16], &keys[lane][48]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256Permutex4RC(w1b0, w1b1, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    areion256Permutex4RC(w2b0, w2b1, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&w1b0[lane * 16], &w1b0[lane * 16], &keys[lane][0]);
        xor16(&w1b1[lane * 16], &w1b1[lane * 16], &keys[lane][16]);
        xor16(&w2b0[lane * 16], &w2b0[lane * 16], &keys[lane][32]);
        xor16(&w2b1[lane * 16], &w2b1[lane * 16], &keys[lane][48]);
        xor16(&b0[lane * 16], &msgs[lane][0], &w1b0[lane * 16]);
        xor16(&b1[lane * 16], &msgs[lane][16], &w1b1[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256Permutex4RC(b0, b1, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &w2b0[lane * 16]);
        xor16(&b1[lane * 16], &b1[lane * 16], &w2b1[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256Permutex4RC(b0, b1, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16_3(&b0[lane * 16], &b0[lane * 16], &w1b0[lane * 16], &w2b0[lane * 16]);
        xor16_3(&b1[lane * 16], &b1[lane * 16], &w1b1[lane * 16], &w2b1[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack256x4SoA(b0, b1, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(w1b0, sizeof(w1b0));
    areion_secure_wipe(w1b1, sizeof(w1b1));
    areion_secure_wipe(w2b0, sizeof(w2b0));
    areion_secure_wipe(w2b1, sizeof(w2b1));
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
}

void areion_tem2_encrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_encrypt256x4_purec(out, keys, tweaks, msgs);
        return;
    }
    tem2_encrypt256x4_arm64_body(out, keys, tweaks, msgs);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_decrypt256x4_arm64_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]) {
    uint8_t w1b0[64], w1b1[64], w2b0[64], w2b1[64], b0[64], b1[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        xor16(&w1b0[lane * 16], &tweaks[lane][0], &keys[lane][0]);
        xor16(&w1b1[lane * 16], &tweaks[lane][16], &keys[lane][16]);
        xor16(&w2b0[lane * 16], &tweaks[lane][0], &keys[lane][32]);
        xor16(&w2b1[lane * 16], &tweaks[lane][16], &keys[lane][48]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256Permutex4RC(w1b0, w1b1, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    areion256Permutex4RC(w2b0, w2b1, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&w1b0[lane * 16], &w1b0[lane * 16], &keys[lane][0]);
        xor16(&w1b1[lane * 16], &w1b1[lane * 16], &keys[lane][16]);
        xor16(&w2b0[lane * 16], &w2b0[lane * 16], &keys[lane][32]);
        xor16(&w2b1[lane * 16], &w2b1[lane * 16], &keys[lane][48]);
        xor16_3(&b0[lane * 16], &ct[lane][0], &w1b0[lane * 16], &w2b0[lane * 16]);
        xor16_3(&b1[lane * 16], &ct[lane][16], &w1b1[lane * 16], &w2b1[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256InversePermutex4RC(b0, b1, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &w2b0[lane * 16]);
        xor16(&b1[lane * 16], &b1[lane * 16], &w2b1[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion256InversePermutex4RC(b0, b1, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &w1b0[lane * 16]);
        xor16(&b1[lane * 16], &b1[lane * 16], &w1b1[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack256x4SoA(b0, b1, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(w1b0, sizeof(w1b0));
    areion_secure_wipe(w1b1, sizeof(w1b1));
    areion_secure_wipe(w2b0, sizeof(w2b0));
    areion_secure_wipe(w2b1, sizeof(w2b1));
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
}

void areion_tem2_decrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_decrypt256x4_purec(out, keys, tweaks, ct);
        return;
    }
    tem2_decrypt256x4_arm64_body(out, keys, tweaks, ct);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_encrypt512x4_arm64_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]) {
    uint8_t w1b0[64], w1b1[64], w1b2[64], w1b3[64];
    uint8_t w2b0[64], w2b1[64], w2b2[64], w2b3[64];
    uint8_t b0[64], b1[64], b2[64], b3[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        xor16(&w1b0[lane * 16], &tweaks[lane][0], &keys[lane][0]);
        xor16(&w1b1[lane * 16], &tweaks[lane][16], &keys[lane][16]);
        xor16(&w1b2[lane * 16], &tweaks[lane][32], &keys[lane][32]);
        xor16(&w1b3[lane * 16], &tweaks[lane][48], &keys[lane][48]);
        xor16(&w2b0[lane * 16], &tweaks[lane][0], &keys[lane][64]);
        xor16(&w2b1[lane * 16], &tweaks[lane][16], &keys[lane][80]);
        xor16(&w2b2[lane * 16], &tweaks[lane][32], &keys[lane][96]);
        xor16(&w2b3[lane * 16], &tweaks[lane][48], &keys[lane][112]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512Permutex4RC(w1b0, w1b1, w1b2, w1b3, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    areion512Permutex4RC(w2b0, w2b1, w2b2, w2b3, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&w1b0[lane * 16], &w1b0[lane * 16], &keys[lane][0]);
        xor16(&w1b1[lane * 16], &w1b1[lane * 16], &keys[lane][16]);
        xor16(&w1b2[lane * 16], &w1b2[lane * 16], &keys[lane][32]);
        xor16(&w1b3[lane * 16], &w1b3[lane * 16], &keys[lane][48]);
        xor16(&w2b0[lane * 16], &w2b0[lane * 16], &keys[lane][64]);
        xor16(&w2b1[lane * 16], &w2b1[lane * 16], &keys[lane][80]);
        xor16(&w2b2[lane * 16], &w2b2[lane * 16], &keys[lane][96]);
        xor16(&w2b3[lane * 16], &w2b3[lane * 16], &keys[lane][112]);
        xor16(&b0[lane * 16], &msgs[lane][0], &w1b0[lane * 16]);
        xor16(&b1[lane * 16], &msgs[lane][16], &w1b1[lane * 16]);
        xor16(&b2[lane * 16], &msgs[lane][32], &w1b2[lane * 16]);
        xor16(&b3[lane * 16], &msgs[lane][48], &w1b3[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512Permutex4RC(b0, b1, b2, b3, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &w2b0[lane * 16]);
        xor16(&b1[lane * 16], &b1[lane * 16], &w2b1[lane * 16]);
        xor16(&b2[lane * 16], &b2[lane * 16], &w2b2[lane * 16]);
        xor16(&b3[lane * 16], &b3[lane * 16], &w2b3[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512Permutex4RC(b0, b1, b2, b3, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16_3(&b0[lane * 16], &b0[lane * 16], &w1b0[lane * 16], &w2b0[lane * 16]);
        xor16_3(&b1[lane * 16], &b1[lane * 16], &w1b1[lane * 16], &w2b1[lane * 16]);
        xor16_3(&b2[lane * 16], &b2[lane * 16], &w1b2[lane * 16], &w2b2[lane * 16]);
        xor16_3(&b3[lane * 16], &b3[lane * 16], &w1b3[lane * 16], &w2b3[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack512x4SoA(b0, b1, b2, b3, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(w1b0, sizeof(w1b0));
    areion_secure_wipe(w1b1, sizeof(w1b1));
    areion_secure_wipe(w1b2, sizeof(w1b2));
    areion_secure_wipe(w1b3, sizeof(w1b3));
    areion_secure_wipe(w2b0, sizeof(w2b0));
    areion_secure_wipe(w2b1, sizeof(w2b1));
    areion_secure_wipe(w2b2, sizeof(w2b2));
    areion_secure_wipe(w2b3, sizeof(w2b3));
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
    areion_secure_wipe(b2, sizeof(b2));
    areion_secure_wipe(b3, sizeof(b3));
}

void areion_tem2_encrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_encrypt512x4_purec(out, keys, tweaks, msgs);
        return;
    }
    tem2_encrypt512x4_arm64_body(out, keys, tweaks, msgs);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_decrypt512x4_arm64_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]) {
    uint8_t w1b0[64], w1b1[64], w1b2[64], w1b3[64];
    uint8_t w2b0[64], w2b1[64], w2b2[64], w2b3[64];
    uint8_t b0[64], b1[64], b2[64], b3[64];
    size_t lane;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        xor16(&w1b0[lane * 16], &tweaks[lane][0], &keys[lane][0]);
        xor16(&w1b1[lane * 16], &tweaks[lane][16], &keys[lane][16]);
        xor16(&w1b2[lane * 16], &tweaks[lane][32], &keys[lane][32]);
        xor16(&w1b3[lane * 16], &tweaks[lane][48], &keys[lane][48]);
        xor16(&w2b0[lane * 16], &tweaks[lane][0], &keys[lane][64]);
        xor16(&w2b1[lane * 16], &tweaks[lane][16], &keys[lane][80]);
        xor16(&w2b2[lane * 16], &tweaks[lane][32], &keys[lane][96]);
        xor16(&w2b3[lane * 16], &tweaks[lane][48], &keys[lane][112]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512Permutex4RC(w1b0, w1b1, w1b2, w1b3, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    areion512Permutex4RC(w2b0, w2b1, w2b2, w2b3, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&w1b0[lane * 16], &w1b0[lane * 16], &keys[lane][0]);
        xor16(&w1b1[lane * 16], &w1b1[lane * 16], &keys[lane][16]);
        xor16(&w1b2[lane * 16], &w1b2[lane * 16], &keys[lane][32]);
        xor16(&w1b3[lane * 16], &w1b3[lane * 16], &keys[lane][48]);
        xor16(&w2b0[lane * 16], &w2b0[lane * 16], &keys[lane][64]);
        xor16(&w2b1[lane * 16], &w2b1[lane * 16], &keys[lane][80]);
        xor16(&w2b2[lane * 16], &w2b2[lane * 16], &keys[lane][96]);
        xor16(&w2b3[lane * 16], &w2b3[lane * 16], &keys[lane][112]);
        xor16_3(&b0[lane * 16], &ct[lane][0], &w1b0[lane * 16], &w2b0[lane * 16]);
        xor16_3(&b1[lane * 16], &ct[lane][16], &w1b1[lane * 16], &w2b1[lane * 16]);
        xor16_3(&b2[lane * 16], &ct[lane][32], &w1b2[lane * 16], &w2b2[lane * 16]);
        xor16_3(&b3[lane * 16], &ct[lane][48], &w1b3[lane * 16], &w2b3[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512InversePermutex4RC(b0, b1, b2, b3, &roundConstantsP2[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &w2b0[lane * 16]);
        xor16(&b1[lane * 16], &b1[lane * 16], &w2b1[lane * 16]);
        xor16(&b2[lane * 16], &b2[lane * 16], &w2b2[lane * 16]);
        xor16(&b3[lane * 16], &b3[lane * 16], &w2b3[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    areion512InversePermutex4RC(b0, b1, b2, b3, &roundConstantsP1[0][0]);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        xor16(&b0[lane * 16], &b0[lane * 16], &w1b0[lane * 16]);
        xor16(&b1[lane * 16], &b1[lane * 16], &w1b1[lane * 16]);
        xor16(&b2[lane * 16], &b2[lane * 16], &w1b2[lane * 16]);
        xor16(&b3[lane * 16], &b3[lane * 16], &w1b3[lane * 16]);
        areion_compiler_barrier();
    }
    areion_compiler_barrier();
    unpack512x4SoA(b0, b1, b2, b3, out[0], out[1], out[2], out[3]);
    areion_secure_wipe(w1b0, sizeof(w1b0));
    areion_secure_wipe(w1b1, sizeof(w1b1));
    areion_secure_wipe(w1b2, sizeof(w1b2));
    areion_secure_wipe(w1b3, sizeof(w1b3));
    areion_secure_wipe(w2b0, sizeof(w2b0));
    areion_secure_wipe(w2b1, sizeof(w2b1));
    areion_secure_wipe(w2b2, sizeof(w2b2));
    areion_secure_wipe(w2b3, sizeof(w2b3));
    areion_secure_wipe(b0, sizeof(b0));
    areion_secure_wipe(b1, sizeof(b1));
    areion_secure_wipe(b2, sizeof(b2));
    areion_secure_wipe(b3, sizeof(b3));
}

void areion_tem2_decrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_tem2_decrypt512x4_purec(out, keys, tweaks, ct);
        return;
    }
    tem2_decrypt512x4_arm64_body(out, keys, tweaks, ct);
    areion_clobber_scratch_gprs();
}

/* =========================================================================
 * AES Round Primitives & AES-128 Block Helpers
 * ========================================================================= */

static AREION_NOINLINE void round_words_arm64_body(const uint32_t in[4], uint32_t out[4], bool is_final) {
    static const uint8_t zero_rk[16] = {0};
    uint8_t buf[16];
    size_t i;
    AREION_OPAQUE_PTR(in);
    for (i = 0; i < 4; i++) {
        areion_store_le32(&buf[i * 4], in[i]);
    }
    if (is_final) {
        aesFinalRoundAsm(buf, zero_rk);
    } else {
        aesRoundAsm(buf, zero_rk);
    }
    for (i = 0; i < 4; i++) {
        out[i] = areion_load_le32(&buf[i * 4]);
    }
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_round(const uint32_t in[4], uint32_t out[4]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_round_purec(in, out);
        return;
    }
    round_words_arm64_body(in, out, false);
    areion_clobber_scratch_gprs();
}

void areion_final_round(const uint32_t in[4], uint32_t out[4]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_final_round_purec(in, out);
        return;
    }
    round_words_arm64_body(in, out, true);
    areion_clobber_scratch_gprs();
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
        return;
    }
    areion_aes_round_purec(block, rk);
}

void areion_aes_final_round_hw(uint8_t block[16], const uint8_t rk[16]) {
    if (areion_tier_code() == AREION_TIER_ARM64) {
        aesFinalRoundAsm(block, rk);
        return;
    }
    areion_aes_final_round_purec(block, rk);
}

static AREION_NOINLINE void aes_round4_arm64_body(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16],
    bool is_final) {
    uint8_t blocks[64];
    uint8_t rks[64];
    AREION_OPAQUE_PTR(rk0);
    AREION_OPAQUE_PTR(rk1);
    AREION_OPAQUE_PTR(rk2);
    AREION_OPAQUE_PTR(rk3);

    memcpy(&blocks[0], b0, 16);
    memcpy(&blocks[16], b1, 16);
    memcpy(&blocks[32], b2, 16);
    memcpy(&blocks[48], b3, 16);

    if (rk0 != NULL) {
        memcpy(&rks[0], rk0, 16);
        memcpy(&rks[16], rk1, 16);
        memcpy(&rks[32], rk2, 16);
        memcpy(&rks[48], rk3, 16);
    } else {
        memset(rks, 0, sizeof(rks));
    }

    areion_compiler_barrier();
    if (!is_final) {
        aesRound4Asm(blocks, rks);
    } else {
        aesFinalRound4Asm(blocks, rks);
    }
    areion_compiler_barrier();

    memcpy(b0, &blocks[0], 16);
    memcpy(b1, &blocks[16], 16);
    memcpy(b2, &blocks[32], 16);
    memcpy(b3, &blocks[48], 16);

    areion_secure_wipe(blocks, sizeof(blocks));
    areion_secure_wipe(rks, sizeof(rks));
}

void areion_round4_hw(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_round4_purec(b0, b1, b2, b3);
        return;
    }
    aes_round4_arm64_body(b0, b1, b2, b3, NULL, NULL, NULL, NULL, false);
    areion_clobber_scratch_gprs();
}

void areion_final_round4_hw(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_final_round4_purec(b0, b1, b2, b3);
        return;
    }
    aes_round4_arm64_body(b0, b1, b2, b3, NULL, NULL, NULL, NULL, true);
    areion_clobber_scratch_gprs();
}

void areion_aes_round4_hw(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_aes_round4_purec(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
        return;
    }
    aes_round4_arm64_body(b0, b1, b2, b3, rk0, rk1, rk2, rk3, false);
    areion_clobber_scratch_gprs();
}

void areion_aes_final_round4_hw(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_aes_final_round4_purec(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
        return;
    }
    aes_round4_arm64_body(b0, b1, b2, b3, rk0, rk1, rk2, rk3, true);
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void expand_key128_arm64_body(const uint8_t key[16], uint8_t rk[11][16]) {
    static const uint8_t zero_rk[16] = {0};
    uint8_t sbox_in[16];
    unsigned int r, i;
    AREION_OPAQUE_PTR(key);

    memmove(rk[0], key, 16);
    memset(sbox_in, 0, sizeof(sbox_in));

    for (r = 0; r < 10U; r++) {
        sbox_in[0] = rk[r][13];
        sbox_in[4] = rk[r][14];
        sbox_in[8] = rk[r][15];
        sbox_in[12] = rk[r][12];
        aesFinalRoundAsm(sbox_in, zero_rk);
        rk[r + 1U][0] = (uint8_t)((uint32_t)rk[r][0] ^ (uint32_t)sbox_in[0] ^ (uint32_t)areion_aes_rcon[r]);
        rk[r + 1U][1] = (uint8_t)(rk[r][1] ^ sbox_in[4]);
        rk[r + 1U][2] = (uint8_t)(rk[r][2] ^ sbox_in[8]);
        rk[r + 1U][3] = (uint8_t)(rk[r][3] ^ sbox_in[12]);
        for (i = 4U; i < 16U; i++) {
            rk[r + 1U][i] = (uint8_t)(rk[r][i] ^ rk[r + 1U][i - 4U]);
        }
    }

    areion_secure_wipe(sbox_in, sizeof(sbox_in));
}

void areion_expand_key128(const uint8_t key[16], uint8_t rk[11][16]) {
    if (areion_tier_code() != AREION_TIER_ARM64) {
        areion_expand_key128_purec(key, rk);
        return;
    }
    expand_key128_arm64_body(key, rk);
    areion_clobber_scratch_gprs();
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

#else
typedef int areion_arm64_unused_t;
#endif
