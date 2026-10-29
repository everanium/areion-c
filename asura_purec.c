/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

/* =========================================================================
 * ASURA 256-Bit Tweakable Block Cipher (INDOCRYPT 2024)
 * ========================================================================= */

static inline uint8_t asura_gf_mul2_byte(uint8_t b) {
    uint8_t mask = (uint8_t)(0U - (uint8_t)(b >> 7U));
    return (uint8_t)((uint8_t)(b << 1U) ^ (uint8_t)(mask & 0x1bU));
}

static inline uint8_t asura_gf_mul141_byte(uint8_t b) {
    uint8_t mask = (uint8_t)(0U - (uint8_t)(b & 1U));
    return (uint8_t)((uint8_t)(b >> 1U) ^ (uint8_t)(mask & 0x8dU));
}

static inline void asura_kappa_soft(uint8_t k[32]) {
    const uint8_t *idx0 = asuraConsts[8];
    const uint8_t *idx1 = asuraConsts[9];
    uint8_t tmp[32];
    size_t i;
    for (i = 0; i < 16; i++) {
        tmp[i] = asura_gf_mul2_byte(k[idx0[i]]);
        tmp[16 + i] = asura_gf_mul2_byte(k[idx1[i]]);
    }
    memcpy(k, tmp, 32);
}

static inline void asura_kappa_inv_soft(uint8_t k[32]) {
    const uint8_t *idx0 = asuraConsts[10];
    const uint8_t *idx1 = asuraConsts[11];
    uint8_t tmp[32];
    size_t i;
    for (i = 0; i < 16; i++) {
        tmp[i] = asura_gf_mul141_byte(k[idx0[i]]);
        tmp[16 + i] = asura_gf_mul141_byte(k[idx1[i]]);
    }
    memcpy(k, tmp, 32);
}

static inline void asura_perm256(uint8_t s0[16], uint8_t s1[16]) {
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

static inline void asura_inv_perm256(uint8_t s0[16], uint8_t s1[16]) {
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

static AREION_NOINLINE void asura_expand_tweakey_core(
    uint8_t rk[13][32], const uint8_t key[32], const uint8_t tweak[16]) {
    uint8_t k[32], t[16];
    uint64_t q_t[8];
    size_t r, i;
    memcpy(k, key, 32);
    memcpy(t, tweak, 16);

    for (i = 0; i < 16; i++) {
        rk[0][i] = (uint8_t)((uint8_t)(t[i] ^ k[i]) ^ asuraRoundConstants[0][i]);
        rk[0][16 + i] = (uint8_t)(t[i] ^ k[16 + i]);
    }

    bs_pack1(q_t, t);
    for (r = 1; r < 13; r++) {
        bs_round_no_key(q_t);
        bs_unpack1(q_t, t);
        asura_kappa_soft(k);
        for (i = 0; i < 16; i++) {
            rk[r][i] = (uint8_t)((uint8_t)(t[i] ^ k[i]) ^ asuraRoundConstants[r][i]);
            rk[r][16 + i] = (uint8_t)(t[i] ^ k[16 + i]);
        }
    }
}

static AREION_NOINLINE void asura_encrypt_block_core(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]) {
    uint8_t s0[16], s1[16];
    uint64_t q[8], q0[8], q1[8];
    size_t r, i;
    memcpy(s0, &src[0], 16);
    memcpy(s1, &src[16], 16);

    for (r = 0; r < 6; r++) {
        for (i = 0; i < 16; i++) {
            s0[i] ^= rk[2 * r][i];
            s1[i] ^= rk[2 * r][16 + i];
        }
        bs_pack2(q, s0, s1);
        bs_inv_final_round_no_key(q);
        bs_inv_mix_columns(q);
        bs_unpack2(q, s0, s1);

        for (i = 0; i < 16; i++) {
            s0[i] ^= rk[2 * r + 1][i];
            s1[i] ^= rk[2 * r + 1][16 + i];
        }
        bs_pack1(q0, s0);
        bs_round_no_key(q0);
        bs_unpack1(q0, s0);

        bs_pack1(q1, s1);
        bs_inv_final_round_no_key(q1);
        bs_inv_mix_columns(q1);
        bs_unpack1(q1, s1);

        if (r < 5) {
            asura_perm256(s0, s1);
        }
    }

    for (i = 0; i < 16; i++) {
        dst[i] = (uint8_t)(s0[i] ^ rk[12][i]);
        dst[16 + i] = (uint8_t)(s1[i] ^ rk[12][16 + i]);
    }
}

static AREION_NOINLINE void asura_decrypt_block_core(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]) {
    uint8_t s0[16], s1[16];
    uint64_t q[8], q0[8], q1[8];
    int r;
    size_t i;
    for (i = 0; i < 16; i++) {
        s0[i] = (uint8_t)(src[i] ^ rk[12][i]);
        s1[i] = (uint8_t)(src[16 + i] ^ rk[12][16 + i]);
    }

    for (r = 5; r >= 0; r--) {
        size_t sr = (size_t)r;
        if (r < 5) {
            asura_inv_perm256(s0, s1);
        }

        bs_pack1(q0, s0);
        bs_inv_mix_columns(q0);
        bs_inv_final_round_no_key(q0);
        bs_unpack1(q0, s0);

        bs_pack1(q1, s1);
        bs_mix_columns(q1);
        bs_final_round_no_key(q1);
        bs_unpack1(q1, s1);

        for (i = 0; i < 16; i++) {
            s0[i] ^= rk[2 * sr + 1][i];
            s1[i] ^= rk[2 * sr + 1][16 + i];
        }

        bs_pack2(q, s0, s1);
        bs_mix_columns(q);
        bs_final_round_no_key(q);
        bs_unpack2(q, s0, s1);

        for (i = 0; i < 16; i++) {
            s0[i] ^= rk[2 * sr][i];
            s1[i] ^= rk[2 * sr][16 + i];
        }
    }

    memcpy(&dst[0], s0, 16);
    memcpy(&dst[16], s1, 16);
}

static AREION_NOINLINE void asura_encrypt_4blocks_core(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]) {
    uint8_t s0[4][16], s1[4][16];
    uint64_t q0[8], q1[8];
    size_t lane, r, i;
    for (lane = 0; lane < 4; lane++) {
        memcpy(s0[lane], &src[lane][0], 16);
        memcpy(s1[lane], &src[lane][16], 16);
    }

    for (r = 0; r < 6; r++) {
        for (lane = 0; lane < 4; lane++) {
            for (i = 0; i < 16; i++) {
                s0[lane][i] ^= rk[2 * r][i];
                s1[lane][i] ^= rk[2 * r][16 + i];
            }
        }
        bs_pack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_pack4(q1, s1[0], s1[1], s1[2], s1[3]);
        bs_inv_final_round_no_key(q0);
        bs_inv_mix_columns(q0);
        bs_inv_final_round_no_key(q1);
        bs_inv_mix_columns(q1);
        bs_unpack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_unpack4(q1, s1[0], s1[1], s1[2], s1[3]);

        for (lane = 0; lane < 4; lane++) {
            for (i = 0; i < 16; i++) {
                s0[lane][i] ^= rk[2 * r + 1][i];
                s1[lane][i] ^= rk[2 * r + 1][16 + i];
            }
        }
        bs_pack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_pack4(q1, s1[0], s1[1], s1[2], s1[3]);
        bs_round_no_key(q0);
        bs_inv_final_round_no_key(q1);
        bs_inv_mix_columns(q1);
        bs_unpack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_unpack4(q1, s1[0], s1[1], s1[2], s1[3]);

        if (r < 5) {
            for (lane = 0; lane < 4; lane++) {
                asura_perm256(s0[lane], s1[lane]);
            }
        }
    }

    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 16; i++) {
            dst[lane][i] = (uint8_t)(s0[lane][i] ^ rk[12][i]);
            dst[lane][16 + i] = (uint8_t)(s1[lane][i] ^ rk[12][16 + i]);
        }
    }
}

static AREION_NOINLINE void asura_decrypt_4blocks_core(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]) {
    uint8_t s0[4][16], s1[4][16];
    uint64_t q0[8], q1[8];
    int r;
    size_t lane, i;
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 16; i++) {
            s0[lane][i] = (uint8_t)(src[lane][i] ^ rk[12][i]);
            s1[lane][i] = (uint8_t)(src[lane][16 + i] ^ rk[12][16 + i]);
        }
    }

    for (r = 5; r >= 0; r--) {
        size_t sr = (size_t)r;
        if (r < 5) {
            for (lane = 0; lane < 4; lane++) {
                asura_inv_perm256(s0[lane], s1[lane]);
            }
        }

        bs_pack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_pack4(q1, s1[0], s1[1], s1[2], s1[3]);
        bs_inv_mix_columns(q0);
        bs_inv_final_round_no_key(q0);
        bs_mix_columns(q1);
        bs_final_round_no_key(q1);
        bs_unpack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_unpack4(q1, s1[0], s1[1], s1[2], s1[3]);

        for (lane = 0; lane < 4; lane++) {
            for (i = 0; i < 16; i++) {
                s0[lane][i] ^= rk[2 * sr + 1][i];
                s1[lane][i] ^= rk[2 * sr + 1][16 + i];
            }
        }

        bs_pack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_pack4(q1, s1[0], s1[1], s1[2], s1[3]);
        bs_mix_columns(q0);
        bs_final_round_no_key(q0);
        bs_mix_columns(q1);
        bs_final_round_no_key(q1);
        bs_unpack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_unpack4(q1, s1[0], s1[1], s1[2], s1[3]);

        for (lane = 0; lane < 4; lane++) {
            for (i = 0; i < 16; i++) {
                s0[lane][i] ^= rk[2 * sr][i];
                s1[lane][i] ^= rk[2 * sr][16 + i];
            }
        }
    }

    for (lane = 0; lane < 4; lane++) {
        memcpy(&dst[lane][0], s0[lane], 16);
        memcpy(&dst[lane][16], s1[lane], 16);
    }
}

static AREION_NOINLINE void asura_encrypt_block_otf_core(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]) {
    uint8_t s0[16], s1[16], k[32], t[16];
    uint64_t q[8], q0[8], q1[8], q_t[8];
    size_t r, i;
    memcpy(s0, &src[0], 16);
    memcpy(s1, &src[16], 16);
    memcpy(k, key, 32);
    memcpy(t, tweak, 16);
    bs_pack1(q_t, t);

    for (r = 0; r < 6; r++) {
        for (i = 0; i < 16; i++) {
            s0[i] ^= (uint8_t)((uint8_t)(t[i] ^ k[i]) ^ asuraRoundConstants[2 * r][i]);
            s1[i] ^= (uint8_t)(t[i] ^ k[16 + i]);
        }
        bs_pack2(q, s0, s1);
        bs_inv_final_round_no_key(q);
        bs_inv_mix_columns(q);
        bs_unpack2(q, s0, s1);

        bs_round_no_key(q_t);
        bs_unpack1(q_t, t);
        asura_kappa_soft(k);
        for (i = 0; i < 16; i++) {
            s0[i] ^= (uint8_t)((uint8_t)(t[i] ^ k[i]) ^ asuraRoundConstants[2 * r + 1][i]);
            s1[i] ^= (uint8_t)(t[i] ^ k[16 + i]);
        }
        bs_pack1(q0, s0);
        bs_round_no_key(q0);
        bs_unpack1(q0, s0);

        bs_pack1(q1, s1);
        bs_inv_final_round_no_key(q1);
        bs_inv_mix_columns(q1);
        bs_unpack1(q1, s1);

        if (r < 5) {
            asura_perm256(s0, s1);
        }

        bs_round_no_key(q_t);
        bs_unpack1(q_t, t);
        asura_kappa_soft(k);
    }

    for (i = 0; i < 16; i++) {
        dst[i] = (uint8_t)((uint8_t)(s0[i] ^ t[i]) ^ (uint8_t)(k[i] ^ asuraRoundConstants[12][i]));
        dst[16 + i] = (uint8_t)((uint8_t)(s1[i] ^ t[i]) ^ k[16 + i]);
    }
}

static AREION_NOINLINE void asura_decrypt_block_otf_core(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]) {
    uint8_t s0[16], s1[16], k[32], t[16];
    uint64_t q[8], q0[8], q1[8], q_t[8];
    int r;
    size_t step, i;
    memcpy(k, key, 32);
    memcpy(t, tweak, 16);
    bs_pack1(q_t, t);

    for (step = 0; step < 12; step++) {
        bs_round_no_key(q_t);
        asura_kappa_soft(k);
    }
    bs_unpack1(q_t, t);

    for (i = 0; i < 16; i++) {
        s0[i] = (uint8_t)((uint8_t)(src[i] ^ t[i]) ^ (uint8_t)(k[i] ^ asuraRoundConstants[12][i]));
        s1[i] = (uint8_t)((uint8_t)(src[16 + i] ^ t[i]) ^ k[16 + i]);
    }

    for (r = 5; r >= 0; r--) {
        size_t sr = (size_t)r;
        if (r < 5) {
            asura_inv_perm256(s0, s1);
        }

        bs_pack1(q0, s0);
        bs_inv_mix_columns(q0);
        bs_inv_final_round_no_key(q0);
        bs_unpack1(q0, s0);

        bs_pack1(q1, s1);
        bs_mix_columns(q1);
        bs_final_round_no_key(q1);
        bs_unpack1(q1, s1);

        bs_inv_mix_columns(q_t);
        bs_inv_final_round_no_key(q_t);
        bs_unpack1(q_t, t);
        asura_kappa_inv_soft(k);
        for (i = 0; i < 16; i++) {
            s0[i] ^= (uint8_t)((uint8_t)(t[i] ^ k[i]) ^ asuraRoundConstants[2 * sr + 1][i]);
            s1[i] ^= (uint8_t)(t[i] ^ k[16 + i]);
        }

        bs_pack2(q, s0, s1);
        bs_mix_columns(q);
        bs_final_round_no_key(q);
        bs_unpack2(q, s0, s1);

        bs_inv_mix_columns(q_t);
        bs_inv_final_round_no_key(q_t);
        bs_unpack1(q_t, t);
        asura_kappa_inv_soft(k);
        for (i = 0; i < 16; i++) {
            s0[i] ^= (uint8_t)((uint8_t)(t[i] ^ k[i]) ^ asuraRoundConstants[2 * sr][i]);
            s1[i] ^= (uint8_t)(t[i] ^ k[16 + i]);
        }
    }

    memcpy(&dst[0], s0, 16);
    memcpy(&dst[16], s1, 16);
}

static AREION_NOINLINE void asura_encrypt_4blocks_otf_core(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweak[16]) {
    uint8_t s0[4][16], s1[4][16], k[32], t[16], tk0[16], tk1[16];
    uint64_t q0[8], q1[8], q_t[8];
    size_t lane, r, i;
    for (lane = 0; lane < 4; lane++) {
        memcpy(s0[lane], &src[lane][0], 16);
        memcpy(s1[lane], &src[lane][16], 16);
    }
    memcpy(k, key, 32);
    memcpy(t, tweak, 16);
    bs_pack1(q_t, t);

    for (r = 0; r < 6; r++) {
        for (i = 0; i < 16; i++) {
            tk0[i] = (uint8_t)((uint8_t)(t[i] ^ k[i]) ^ asuraRoundConstants[2 * r][i]);
            tk1[i] = (uint8_t)(t[i] ^ k[16 + i]);
        }
        for (lane = 0; lane < 4; lane++) {
            for (i = 0; i < 16; i++) {
                s0[lane][i] ^= tk0[i];
                s1[lane][i] ^= tk1[i];
            }
        }
        bs_pack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_pack4(q1, s1[0], s1[1], s1[2], s1[3]);
        bs_inv_final_round_no_key(q0);
        bs_inv_mix_columns(q0);
        bs_inv_final_round_no_key(q1);
        bs_inv_mix_columns(q1);
        bs_unpack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_unpack4(q1, s1[0], s1[1], s1[2], s1[3]);

        bs_round_no_key(q_t);
        bs_unpack1(q_t, t);
        asura_kappa_soft(k);
        for (i = 0; i < 16; i++) {
            tk0[i] = (uint8_t)((uint8_t)(t[i] ^ k[i]) ^ asuraRoundConstants[2 * r + 1][i]);
            tk1[i] = (uint8_t)(t[i] ^ k[16 + i]);
        }
        for (lane = 0; lane < 4; lane++) {
            for (i = 0; i < 16; i++) {
                s0[lane][i] ^= tk0[i];
                s1[lane][i] ^= tk1[i];
            }
        }
        bs_pack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_pack4(q1, s1[0], s1[1], s1[2], s1[3]);
        bs_round_no_key(q0);
        bs_inv_final_round_no_key(q1);
        bs_inv_mix_columns(q1);
        bs_unpack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_unpack4(q1, s1[0], s1[1], s1[2], s1[3]);

        if (r < 5) {
            for (lane = 0; lane < 4; lane++) {
                asura_perm256(s0[lane], s1[lane]);
            }
        }

        bs_round_no_key(q_t);
        bs_unpack1(q_t, t);
        asura_kappa_soft(k);
    }

    for (i = 0; i < 16; i++) {
        tk0[i] = (uint8_t)((uint8_t)(t[i] ^ k[i]) ^ asuraRoundConstants[12][i]);
        tk1[i] = (uint8_t)(t[i] ^ k[16 + i]);
    }
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 16; i++) {
            dst[lane][i] = (uint8_t)(s0[lane][i] ^ tk0[i]);
            dst[lane][16 + i] = (uint8_t)(s1[lane][i] ^ tk1[i]);
        }
    }
}

static AREION_NOINLINE void asura_decrypt_4blocks_otf_core(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweak[16]) {
    uint8_t s0[4][16], s1[4][16], k[32], t[16], tk0[16], tk1[16];
    uint64_t q0[8], q1[8], q_t[8];
    int r;
    size_t step, lane, i;
    memcpy(k, key, 32);
    memcpy(t, tweak, 16);
    bs_pack1(q_t, t);

    for (step = 0; step < 12; step++) {
        bs_round_no_key(q_t);
        asura_kappa_soft(k);
    }
    bs_unpack1(q_t, t);

    for (i = 0; i < 16; i++) {
        tk0[i] = (uint8_t)((uint8_t)(t[i] ^ k[i]) ^ asuraRoundConstants[12][i]);
        tk1[i] = (uint8_t)(t[i] ^ k[16 + i]);
    }
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 16; i++) {
            s0[lane][i] = (uint8_t)(src[lane][i] ^ tk0[i]);
            s1[lane][i] = (uint8_t)(src[lane][16 + i] ^ tk1[i]);
        }
    }

    for (r = 5; r >= 0; r--) {
        size_t sr = (size_t)r;
        if (r < 5) {
            for (lane = 0; lane < 4; lane++) {
                asura_inv_perm256(s0[lane], s1[lane]);
            }
        }

        bs_pack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_pack4(q1, s1[0], s1[1], s1[2], s1[3]);
        bs_inv_mix_columns(q0);
        bs_inv_final_round_no_key(q0);
        bs_mix_columns(q1);
        bs_final_round_no_key(q1);
        bs_unpack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_unpack4(q1, s1[0], s1[1], s1[2], s1[3]);

        bs_inv_mix_columns(q_t);
        bs_inv_final_round_no_key(q_t);
        bs_unpack1(q_t, t);
        asura_kappa_inv_soft(k);
        for (i = 0; i < 16; i++) {
            tk0[i] = (uint8_t)((uint8_t)(t[i] ^ k[i]) ^ asuraRoundConstants[2 * sr + 1][i]);
            tk1[i] = (uint8_t)(t[i] ^ k[16 + i]);
        }
        for (lane = 0; lane < 4; lane++) {
            for (i = 0; i < 16; i++) {
                s0[lane][i] ^= tk0[i];
                s1[lane][i] ^= tk1[i];
            }
        }

        bs_pack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_pack4(q1, s1[0], s1[1], s1[2], s1[3]);
        bs_mix_columns(q0);
        bs_final_round_no_key(q0);
        bs_mix_columns(q1);
        bs_final_round_no_key(q1);
        bs_unpack4(q0, s0[0], s0[1], s0[2], s0[3]);
        bs_unpack4(q1, s1[0], s1[1], s1[2], s1[3]);

        bs_inv_mix_columns(q_t);
        bs_inv_final_round_no_key(q_t);
        bs_unpack1(q_t, t);
        asura_kappa_inv_soft(k);
        for (i = 0; i < 16; i++) {
            tk0[i] = (uint8_t)((uint8_t)(t[i] ^ k[i]) ^ asuraRoundConstants[2 * sr][i]);
            tk1[i] = (uint8_t)(t[i] ^ k[16 + i]);
        }
        for (lane = 0; lane < 4; lane++) {
            for (i = 0; i < 16; i++) {
                s0[lane][i] ^= tk0[i];
                s1[lane][i] ^= tk1[i];
            }
        }
    }

    for (lane = 0; lane < 4; lane++) {
        memcpy(&dst[lane][0], s0[lane], 16);
        memcpy(&dst[lane][16], s1[lane], 16);
    }
}

static AREION_NOINLINE void asura_expand_tweakey_soft_body(
    uint8_t rk[13][32], const uint8_t key[32], const uint8_t tweak[16]) {
    AREION_OPAQUE_PTR(key);
    AREION_OPAQUE_PTR(tweak);
    asura_expand_tweakey_core(rk, key, tweak);
}

void areion_asura_expand_tweakey_soft(
    uint8_t rk[13][32], const uint8_t key[32], const uint8_t tweak[16]) {
    asura_expand_tweakey_soft_body(rk, key, tweak);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void asura_encrypt_block_soft_body(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]) {
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(rk);
    asura_encrypt_block_core(dst, src, rk);
}

void areion_asura_encrypt_block_soft(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]) {
    asura_encrypt_block_soft_body(dst, src, rk);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void asura_decrypt_block_soft_body(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]) {
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(rk);
    asura_decrypt_block_core(dst, src, rk);
}

void areion_asura_decrypt_block_soft(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]) {
    asura_decrypt_block_soft_body(dst, src, rk);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void asura_encrypt_4blocks_soft_body(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]) {
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(rk);
    asura_encrypt_4blocks_core(dst, src, rk);
}

void areion_asura_encrypt_4blocks_soft(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]) {
    asura_encrypt_4blocks_soft_body(dst, src, rk);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void asura_decrypt_4blocks_soft_body(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]) {
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(rk);
    asura_decrypt_4blocks_core(dst, src, rk);
}

void areion_asura_decrypt_4blocks_soft(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]) {
    asura_decrypt_4blocks_soft_body(dst, src, rk);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void asura_encrypt_block_otf_soft_body(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]) {
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(key);
    AREION_OPAQUE_PTR(tweak);
    asura_encrypt_block_otf_core(dst, src, key, tweak);
}

void areion_asura_encrypt_block_otf_soft(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]) {
    asura_encrypt_block_otf_soft_body(dst, src, key, tweak);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void asura_decrypt_block_otf_soft_body(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]) {
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(key);
    AREION_OPAQUE_PTR(tweak);
    asura_decrypt_block_otf_core(dst, src, key, tweak);
}

void areion_asura_decrypt_block_otf_soft(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]) {
    asura_decrypt_block_otf_soft_body(dst, src, key, tweak);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void asura_encrypt_4blocks_otf_soft_body(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweak[16]) {
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(key);
    AREION_OPAQUE_PTR(tweak);
    asura_encrypt_4blocks_otf_core(dst, src, key, tweak);
}

void areion_asura_encrypt_4blocks_otf_soft(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweak[16]) {
    asura_encrypt_4blocks_otf_soft_body(dst, src, key, tweak);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void asura_decrypt_4blocks_otf_soft_body(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweak[16]) {
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(key);
    AREION_OPAQUE_PTR(tweak);
    asura_decrypt_4blocks_otf_core(dst, src, key, tweak);
}

void areion_asura_decrypt_4blocks_otf_soft(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweak[16]) {
    asura_decrypt_4blocks_otf_soft_body(dst, src, key, tweak);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}
