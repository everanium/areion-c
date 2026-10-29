/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

/* =========================================================================
 * Vistrutah-256 and Vistrutah-512 Constant-Time Bitsliced Reference
 * ========================================================================= */

static inline void vistrutah_perm16(uint8_t dst[16], const uint8_t src[16], const uint8_t p[16]) {
    uint8_t tmp[16];
    size_t i;
    for (i = 0; i < 16; i++) {
        tmp[i] = src[p[i]];
    }
    memcpy(dst, tmp, 16);
}

static inline void vistrutah_rot16(uint8_t dst[16], const uint8_t src[16], size_t k) {
    uint8_t tmp[16];
    size_t i;
    for (i = 0; i < 16; i++) {
        tmp[i] = src[(i + k) & 15U];
    }
    memcpy(dst, tmp, 16);
}

static inline void vistrutah_mix256(uint8_t s0[16], uint8_t s1[16]) {
    uint8_t t0[16], t1[16];
    size_t i;
    for (i = 0; i < 8; i++) {
        t0[i] = s0[2 * i];
        t0[8 + i] = s1[2 * i];
        t1[i] = s0[2 * i + 1];
        t1[8 + i] = s1[2 * i + 1];
    }
    memcpy(s0, t0, 16);
    memcpy(s1, t1, 16);
}

static inline void vistrutah_inv_mix256(uint8_t s0[16], uint8_t s1[16]) {
    uint8_t t0[16], t1[16];
    size_t i;
    for (i = 0; i < 8; i++) {
        t0[2 * i] = s0[i];
        t0[2 * i + 1] = s1[i];
        t1[2 * i] = s0[8 + i];
        t1[2 * i + 1] = s1[8 + i];
    }
    memcpy(s0, t0, 16);
    memcpy(s1, t1, 16);
}

static inline void vistrutah_mix512(uint8_t s0[16], uint8_t s1[16], uint8_t s2[16], uint8_t s3[16]) {
    uint8_t in[64], out[64];
    size_t j, c;
    memcpy(&in[0], s0, 16);
    memcpy(&in[16], s1, 16);
    memcpy(&in[32], s2, 16);
    memcpy(&in[48], s3, 16);
    for (j = 0; j < 16; j++) {
        for (c = 0; c < 4; c++) {
            out[4 * j + c] = in[16 * c + j];
        }
    }
    memcpy(s0, &out[0], 16);
    memcpy(s1, &out[32], 16);
    memcpy(s2, &out[16], 16);
    memcpy(s3, &out[48], 16);
}

static inline void vistrutah_inv_mix512(uint8_t s0[16], uint8_t s1[16], uint8_t s2[16], uint8_t s3[16]) {
    uint8_t in[64], out[64];
    size_t j, c;
    memcpy(&in[0], s0, 16);
    memcpy(&in[16], s2, 16);
    memcpy(&in[32], s1, 16);
    memcpy(&in[48], s3, 16);
    for (j = 0; j < 16; j++) {
        for (c = 0; c < 4; c++) {
            out[16 * c + j] = in[4 * j + c];
        }
    }
    memcpy(s0, &out[0], 16);
    memcpy(s1, &out[16], 16);
    memcpy(s2, &out[32], 16);
    memcpy(s3, &out[48], 16);
}

static AREION_NOINLINE void vistrutah256_encrypt_block_purec_body(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds) {
    const uint8_t *p4 = vistrutahConsts[0];
    const uint8_t *p5 = vistrutahConsts[1];
    uint8_t s0[16], s1[16], fk0[16], fk1[16], rk0[16], rk1[16];
    uint64_t q[8], q_fk[8];
    int steps = rounds / 2;
    int step;
    size_t i;
    if (steps < 1 || steps > 16) {
        return;
    }
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(key);
    memcpy(s0, &src[0], 16);
    memcpy(s1, &src[16], 16);
    memcpy(fk0, &key[0], 16);
    memcpy(fk1, &key[16], 16);
    memcpy(rk0, fk1, 16);
    memcpy(rk1, fk0, 16);

    bs_pack2(q_fk, fk0, fk1);

    for (step = 0; step < steps; step++) {
        for (i = 0; i < 16; i++) {
            s0[i] ^= rk0[i];
            s1[i] ^= rk1[i];
        }
        if (step > 0) {
            for (i = 0; i < 16; i++) {
                s0[i] ^= vistrutahRoundConstants[step - 1][i];
            }
        }
        bs_pack2(q, s0, s1);
        bs_round_no_key(q);
        bs_xor(q, q_fk);
        if (step < steps - 1) {
            bs_round_no_key(q);
            bs_unpack2(q, s0, s1);
            vistrutah_mix256(s0, s1);
            vistrutah_perm16(rk0, rk0, p4);
            vistrutah_perm16(rk1, rk1, p5);
        } else {
            bs_final_round_no_key(q);
            bs_unpack2(q, s0, s1);
            vistrutah_perm16(rk0, rk0, p4);
            vistrutah_perm16(rk1, rk1, p5);
            for (i = 0; i < 16; i++) {
                dst[i] = (uint8_t)(s0[i] ^ rk0[i]);
                dst[16 + i] = (uint8_t)(s1[i] ^ rk1[i]);
            }
        }
    }
}

void areion_vistrutah256_encrypt_block_purec(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds) {
    vistrutah256_encrypt_block_purec_body(dst, src, key, rounds);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void vistrutah256_decrypt_block_purec_body(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds) {
    static const uint8_t p4_inv[16] = {4, 8, 9, 6, 11, 7, 12, 1, 15, 0, 5, 14, 13, 2, 3, 10};
    static const uint8_t p5_inv[16] = {6, 2, 12, 7, 5, 13, 10, 11, 1, 3, 9, 15, 0, 14, 8, 4};
    const uint8_t *p4 = vistrutahConsts[0];
    const uint8_t *p5 = vistrutahConsts[1];
    uint8_t s0[16], s1[16], fk0[16], fk1[16], rk0[16], rk1[16];
    uint64_t q[8], q_fk[8];
    int steps = rounds / 2;
    int step;
    size_t i;
    if (steps < 1 || steps > 16) {
        return;
    }
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(key);
    memcpy(s0, &src[0], 16);
    memcpy(s1, &src[16], 16);
    memcpy(fk0, &key[0], 16);
    memcpy(fk1, &key[16], 16);
    memcpy(rk0, fk1, 16);
    memcpy(rk1, fk0, 16);

    for (step = 0; step < steps; step++) {
        vistrutah_perm16(rk0, rk0, p4);
        vistrutah_perm16(rk1, rk1, p5);
    }

    bs_pack2(q_fk, fk0, fk1);

    for (step = steps - 1; step >= 0; step--) {
        if (step == steps - 1) {
            for (i = 0; i < 16; i++) {
                s0[i] ^= rk0[i];
                s1[i] ^= rk1[i];
            }
            bs_pack2(q, s0, s1);
            bs_inv_final_round_no_key(q);
        } else {
            vistrutah_inv_mix256(s0, s1);
            bs_pack2(q, s0, s1);
            bs_inv_mix_columns(q);
            bs_inv_final_round_no_key(q);
        }
        vistrutah_perm16(rk0, rk0, p4_inv);
        vistrutah_perm16(rk1, rk1, p5_inv);
        bs_xor(q, q_fk);
        bs_inv_mix_columns(q);
        bs_inv_final_round_no_key(q);
        bs_unpack2(q, s0, s1);
        for (i = 0; i < 16; i++) {
            s0[i] ^= rk0[i];
            s1[i] ^= rk1[i];
        }
        if (step > 0) {
            for (i = 0; i < 16; i++) {
                s0[i] ^= vistrutahRoundConstants[step - 1][i];
            }
        }
    }

    memcpy(&dst[0], s0, 16);
    memcpy(&dst[16], s1, 16);
}

void areion_vistrutah256_decrypt_block_purec(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds) {
    vistrutah256_decrypt_block_purec_body(dst, src, key, rounds);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void vistrutah256_encrypt4_blocks_purec_body(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds) {
    const uint8_t *p4 = vistrutahConsts[0];
    const uint8_t *p5 = vistrutahConsts[1];
    uint8_t s0[4][16], s1[4][16];
    uint8_t fk0[16], fk1[16], rk0[16], rk1[16], rk0rc[16];
    uint64_t q0[8], q1[8], q_fk0[8], q_fk1[8];
    int steps = rounds / 2;
    int step;
    size_t lane, i;
    if (steps < 1 || steps > 16) {
        return;
    }
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(key);
    for (lane = 0; lane < 4; lane++) {
        memcpy(s0[lane], &src[lane][0], 16);
        memcpy(s1[lane], &src[lane][16], 16);
    }
    memcpy(fk0, &key[0], 16);
    memcpy(fk1, &key[16], 16);
    memcpy(rk0, fk1, 16);
    memcpy(rk1, fk0, 16);

    bs_pack_broadcast(q_fk0, fk0);
    bs_pack_broadcast(q_fk1, fk1);

    for (step = 0; step < steps; step++) {
        memcpy(rk0rc, rk0, 16);
        if (step > 0) {
            for (i = 0; i < 16; i++) {
                rk0rc[i] ^= vistrutahRoundConstants[step - 1][i];
            }
        }
        for (lane = 0; lane < 4; lane++) {
            for (i = 0; i < 16; i++) {
                s0[lane][i] ^= rk0rc[i];
                s1[lane][i] ^= rk1[i];
            }
        }
        bs_pack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_pack4(q1, s1[0], s1[1], s1[2], s1[3]);
        bs_round_no_key(q0);
        bs_round_no_key(q1);
        bs_xor(q0, q_fk0);
        bs_xor(q1, q_fk1);
        if (step < steps - 1) {
            bs_round_no_key(q0);
            bs_round_no_key(q1);
            bs_unpack4(q0, s0[0], s0[1], s0[2], s0[3]);
            bs_unpack4(q1, s1[0], s1[1], s1[2], s1[3]);
            for (lane = 0; lane < 4; lane++) {
                vistrutah_mix256(s0[lane], s1[lane]);
            }
            vistrutah_perm16(rk0, rk0, p4);
            vistrutah_perm16(rk1, rk1, p5);
        } else {
            bs_final_round_no_key(q0);
            bs_final_round_no_key(q1);
            bs_unpack4(q0, s0[0], s0[1], s0[2], s0[3]);
            bs_unpack4(q1, s1[0], s1[1], s1[2], s1[3]);
            vistrutah_perm16(rk0, rk0, p4);
            vistrutah_perm16(rk1, rk1, p5);
            for (lane = 0; lane < 4; lane++) {
                for (i = 0; i < 16; i++) {
                    dst[lane][i] = (uint8_t)(s0[lane][i] ^ rk0[i]);
                    dst[lane][16 + i] = (uint8_t)(s1[lane][i] ^ rk1[i]);
                }
            }
        }
    }
}

void areion_vistrutah256_encrypt4_blocks_purec(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds) {
    vistrutah256_encrypt4_blocks_purec_body(dst, src, key, rounds);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void vistrutah256_decrypt4_blocks_purec_body(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds) {
    static const uint8_t p4_inv[16] = {4, 8, 9, 6, 11, 7, 12, 1, 15, 0, 5, 14, 13, 2, 3, 10};
    static const uint8_t p5_inv[16] = {6, 2, 12, 7, 5, 13, 10, 11, 1, 3, 9, 15, 0, 14, 8, 4};
    const uint8_t *p4 = vistrutahConsts[0];
    const uint8_t *p5 = vistrutahConsts[1];
    uint8_t s0[4][16], s1[4][16];
    uint8_t fk0[16], fk1[16], rk0[16], rk1[16], rk0rc[16];
    uint64_t q0[8], q1[8], q_fk0[8], q_fk1[8];
    int steps = rounds / 2;
    int step;
    size_t lane, i;
    if (steps < 1 || steps > 16) {
        return;
    }
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(key);
    for (lane = 0; lane < 4; lane++) {
        memcpy(s0[lane], &src[lane][0], 16);
        memcpy(s1[lane], &src[lane][16], 16);
    }
    memcpy(fk0, &key[0], 16);
    memcpy(fk1, &key[16], 16);
    memcpy(rk0, fk1, 16);
    memcpy(rk1, fk0, 16);

    for (step = 0; step < steps; step++) {
        vistrutah_perm16(rk0, rk0, p4);
        vistrutah_perm16(rk1, rk1, p5);
    }

    bs_pack_broadcast(q_fk0, fk0);
    bs_pack_broadcast(q_fk1, fk1);

    for (step = steps - 1; step >= 0; step--) {
        if (step == steps - 1) {
            for (lane = 0; lane < 4; lane++) {
                for (i = 0; i < 16; i++) {
                    s0[lane][i] ^= rk0[i];
                    s1[lane][i] ^= rk1[i];
                }
            }
            bs_pack4(q0, s0[0], s0[1], s0[2], s0[3]);
            bs_pack4(q1, s1[0], s1[1], s1[2], s1[3]);
            bs_inv_final_round_no_key(q0);
            bs_inv_final_round_no_key(q1);
        } else {
            for (lane = 0; lane < 4; lane++) {
                vistrutah_inv_mix256(s0[lane], s1[lane]);
            }
            bs_pack4(q0, s0[0], s0[1], s0[2], s0[3]);
            bs_pack4(q1, s1[0], s1[1], s1[2], s1[3]);
            bs_inv_mix_columns(q0);
            bs_inv_mix_columns(q1);
            bs_inv_final_round_no_key(q0);
            bs_inv_final_round_no_key(q1);
        }
        vistrutah_perm16(rk0, rk0, p4_inv);
        vistrutah_perm16(rk1, rk1, p5_inv);
        bs_xor(q0, q_fk0);
        bs_xor(q1, q_fk1);
        bs_inv_mix_columns(q0);
        bs_inv_mix_columns(q1);
        bs_inv_final_round_no_key(q0);
        bs_inv_final_round_no_key(q1);
        bs_unpack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_unpack4(q1, s1[0], s1[1], s1[2], s1[3]);
        memcpy(rk0rc, rk0, 16);
        if (step > 0) {
            for (i = 0; i < 16; i++) {
                rk0rc[i] ^= vistrutahRoundConstants[step - 1][i];
            }
        }
        for (lane = 0; lane < 4; lane++) {
            for (i = 0; i < 16; i++) {
                s0[lane][i] ^= rk0rc[i];
                s1[lane][i] ^= rk1[i];
            }
        }
    }

    for (lane = 0; lane < 4; lane++) {
        memcpy(&dst[lane][0], s0[lane], 16);
        memcpy(&dst[lane][16], s1[lane], 16);
    }
}

void areion_vistrutah256_decrypt4_blocks_purec(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds) {
    vistrutah256_decrypt4_blocks_purec_body(dst, src, key, rounds);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void vistrutah512_encrypt_core(
    uint8_t dst[64], const uint8_t src[64], const uint8_t fk[4][16], int rounds) {
    uint8_t s0[16], s1[16], s2[16], s3[16];
    uint8_t rk0[16], rk1[16], rk2[16], rk3[16];
    uint64_t q[8], q_fk[8];
    int steps = rounds / 2;
    int step;
    size_t i;
    if (steps < 1 || steps > 16) {
        return;
    }
    memcpy(s0, &src[0], 16);
    memcpy(s1, &src[16], 16);
    memcpy(s2, &src[32], 16);
    memcpy(s3, &src[48], 16);
    memcpy(rk0, fk[1], 16);
    memcpy(rk1, fk[0], 16);
    memcpy(rk2, fk[3], 16);
    memcpy(rk3, fk[2], 16);

    bs_pack4(q_fk, fk[0], fk[1], fk[2], fk[3]);

    for (step = 0; step < steps; step++) {
        for (i = 0; i < 16; i++) {
            s0[i] ^= rk0[i];
            s1[i] ^= rk1[i];
            s2[i] ^= rk2[i];
            s3[i] ^= rk3[i];
        }
        if (step > 0) {
            for (i = 0; i < 16; i++) {
                s0[i] ^= vistrutahRoundConstants[step - 1][i];
            }
        }
        bs_pack4(q, s0, s1, s2, s3);
        bs_round_no_key(q);
        bs_xor(q, q_fk);
        if (step < steps - 1) {
            bs_round_no_key(q);
            bs_unpack4(q, s0, s1, s2, s3);
            vistrutah_mix512(s0, s1, s2, s3);
            vistrutah_rot16(rk0, rk0, 5U);
            vistrutah_rot16(rk1, rk1, 10U);
            vistrutah_rot16(rk2, rk2, 5U);
            vistrutah_rot16(rk3, rk3, 10U);
        } else {
            bs_final_round_no_key(q);
            bs_unpack4(q, s0, s1, s2, s3);
            vistrutah_rot16(rk0, rk0, 5U);
            vistrutah_rot16(rk1, rk1, 10U);
            vistrutah_rot16(rk2, rk2, 5U);
            vistrutah_rot16(rk3, rk3, 10U);
            for (i = 0; i < 16; i++) {
                dst[i] = (uint8_t)(s0[i] ^ rk0[i]);
                dst[16 + i] = (uint8_t)(s1[i] ^ rk1[i]);
                dst[32 + i] = (uint8_t)(s2[i] ^ rk2[i]);
                dst[48 + i] = (uint8_t)(s3[i] ^ rk3[i]);
            }
        }
    }
}

static AREION_NOINLINE void vistrutah512_decrypt_core(
    uint8_t dst[64], const uint8_t src[64], const uint8_t fk[4][16], int rounds) {
    uint8_t s0[16], s1[16], s2[16], s3[16];
    uint8_t rk0[16], rk1[16], rk2[16], rk3[16];
    uint64_t q[8], q_fk[8];
    int steps = rounds / 2;
    size_t rot0;
    size_t rot1;
    int step;
    size_t i;
    if (steps < 1 || steps > 16) {
        return;
    }
    rot0 = ((size_t)steps * 5U) & 15U;
    rot1 = ((size_t)steps * 10U) & 15U;
    memcpy(s0, &src[0], 16);
    memcpy(s1, &src[16], 16);
    memcpy(s2, &src[32], 16);
    memcpy(s3, &src[48], 16);
    vistrutah_rot16(rk0, fk[1], rot0);
    vistrutah_rot16(rk1, fk[0], rot1);
    vistrutah_rot16(rk2, fk[3], rot0);
    vistrutah_rot16(rk3, fk[2], rot1);

    bs_pack4(q_fk, fk[0], fk[1], fk[2], fk[3]);

    for (step = steps - 1; step >= 0; step--) {
        if (step == steps - 1) {
            for (i = 0; i < 16; i++) {
                s0[i] ^= rk0[i];
                s1[i] ^= rk1[i];
                s2[i] ^= rk2[i];
                s3[i] ^= rk3[i];
            }
            bs_pack4(q, s0, s1, s2, s3);
            bs_inv_final_round_no_key(q);
        } else {
            vistrutah_inv_mix512(s0, s1, s2, s3);
            bs_pack4(q, s0, s1, s2, s3);
            bs_inv_mix_columns(q);
            bs_inv_final_round_no_key(q);
        }
        vistrutah_rot16(rk0, rk0, 11U);
        vistrutah_rot16(rk1, rk1, 6U);
        vistrutah_rot16(rk2, rk2, 11U);
        vistrutah_rot16(rk3, rk3, 6U);
        bs_xor(q, q_fk);
        bs_inv_mix_columns(q);
        bs_inv_final_round_no_key(q);
        bs_unpack4(q, s0, s1, s2, s3);
        for (i = 0; i < 16; i++) {
            s0[i] ^= rk0[i];
            s1[i] ^= rk1[i];
            s2[i] ^= rk2[i];
            s3[i] ^= rk3[i];
        }
        if (step > 0) {
            for (i = 0; i < 16; i++) {
                s0[i] ^= vistrutahRoundConstants[step - 1][i];
            }
        }
    }

    memcpy(&dst[0], s0, 16);
    memcpy(&dst[16], s1, 16);
    memcpy(&dst[32], s2, 16);
    memcpy(&dst[48], s3, 16);
}

static inline void vistrutah512_setup_key256(uint8_t fk[4][16], const uint8_t key[32]) {
    const uint8_t *psi = &vistrutahConsts[16][0];
    size_t i;
    AREION_OPAQUE_PTR(key);
    memcpy(fk[0], &key[0], 16);
    memcpy(fk[1], &key[16], 16);
    for (i = 0; i < 16; i++) {
        fk[2][i] = key[psi[i]];
        fk[3][i] = key[psi[16 + i]];
    }
}

static inline void vistrutah512_setup_key512(uint8_t fk[4][16], const uint8_t key[64]) {
    AREION_OPAQUE_PTR(key);
    memcpy(fk[0], &key[0], 16);
    memcpy(fk[1], &key[16], 16);
    memcpy(fk[2], &key[32], 16);
    memcpy(fk[3], &key[48], 16);
}

static AREION_NOINLINE void vistrutah512_encrypt_block_256_purec_body(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds) {
    uint8_t fk[4][16];
    int steps = rounds / 2;
    if (steps < 1 || steps > 16) {
        return;
    }
    AREION_OPAQUE_PTR(src);
    vistrutah512_setup_key256(fk, key);
    vistrutah512_encrypt_core(dst, src, (const uint8_t (*)[16])fk, rounds);
}

void areion_vistrutah512_encrypt_block_256_purec(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds) {
    vistrutah512_encrypt_block_256_purec_body(dst, src, key, rounds);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void vistrutah512_decrypt_block_256_purec_body(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds) {
    uint8_t fk[4][16];
    int steps = rounds / 2;
    if (steps < 1 || steps > 16) {
        return;
    }
    AREION_OPAQUE_PTR(src);
    vistrutah512_setup_key256(fk, key);
    vistrutah512_decrypt_core(dst, src, (const uint8_t (*)[16])fk, rounds);
}

void areion_vistrutah512_decrypt_block_256_purec(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds) {
    vistrutah512_decrypt_block_256_purec_body(dst, src, key, rounds);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void vistrutah512_encrypt_block_512_purec_body(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds) {
    uint8_t fk[4][16];
    int steps = rounds / 2;
    if (steps < 1 || steps > 16) {
        return;
    }
    AREION_OPAQUE_PTR(src);
    vistrutah512_setup_key512(fk, key);
    vistrutah512_encrypt_core(dst, src, (const uint8_t (*)[16])fk, rounds);
}

void areion_vistrutah512_encrypt_block_512_purec(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds) {
    vistrutah512_encrypt_block_512_purec_body(dst, src, key, rounds);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void vistrutah512_decrypt_block_512_purec_body(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds) {
    uint8_t fk[4][16];
    int steps = rounds / 2;
    if (steps < 1 || steps > 16) {
        return;
    }
    AREION_OPAQUE_PTR(src);
    vistrutah512_setup_key512(fk, key);
    vistrutah512_decrypt_core(dst, src, (const uint8_t (*)[16])fk, rounds);
}

void areion_vistrutah512_decrypt_block_512_purec(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds) {
    vistrutah512_decrypt_block_512_purec_body(dst, src, key, rounds);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void vistrutah512_encrypt4_blocks_256_purec_body(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds) {
    uint8_t fk[4][16];
    int steps = rounds / 2;
    size_t i;
    if (steps < 1 || steps > 16) {
        return;
    }
    AREION_OPAQUE_PTR(src);
    vistrutah512_setup_key256(fk, key);
    for (i = 0; i < 4; i++) {
        vistrutah512_encrypt_core(dst[i], src[i], (const uint8_t (*)[16])fk, rounds);
    }
}

void areion_vistrutah512_encrypt4_blocks_256_purec(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds) {
    vistrutah512_encrypt4_blocks_256_purec_body(dst, src, key, rounds);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void vistrutah512_decrypt4_blocks_256_purec_body(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds) {
    uint8_t fk[4][16];
    int steps = rounds / 2;
    size_t i;
    if (steps < 1 || steps > 16) {
        return;
    }
    AREION_OPAQUE_PTR(src);
    vistrutah512_setup_key256(fk, key);
    for (i = 0; i < 4; i++) {
        vistrutah512_decrypt_core(dst[i], src[i], (const uint8_t (*)[16])fk, rounds);
    }
}

void areion_vistrutah512_decrypt4_blocks_256_purec(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds) {
    vistrutah512_decrypt4_blocks_256_purec_body(dst, src, key, rounds);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void vistrutah512_encrypt4_blocks_512_purec_body(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds) {
    uint8_t fk[4][16];
    int steps = rounds / 2;
    size_t i;
    if (steps < 1 || steps > 16) {
        return;
    }
    AREION_OPAQUE_PTR(src);
    vistrutah512_setup_key512(fk, key);
    for (i = 0; i < 4; i++) {
        vistrutah512_encrypt_core(dst[i], src[i], (const uint8_t (*)[16])fk, rounds);
    }
}

void areion_vistrutah512_encrypt4_blocks_512_purec(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds) {
    vistrutah512_encrypt4_blocks_512_purec_body(dst, src, key, rounds);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void vistrutah512_decrypt4_blocks_512_purec_body(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds) {
    uint8_t fk[4][16];
    int steps = rounds / 2;
    size_t i;
    if (steps < 1 || steps > 16) {
        return;
    }
    AREION_OPAQUE_PTR(src);
    vistrutah512_setup_key512(fk, key);
    for (i = 0; i < 4; i++) {
        vistrutah512_decrypt_core(dst[i], src[i], (const uint8_t (*)[16])fk, rounds);
    }
}

void areion_vistrutah512_decrypt4_blocks_512_purec(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds) {
    vistrutah512_decrypt4_blocks_512_purec_body(dst, src, key, rounds);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}
