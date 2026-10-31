/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

static inline void bs_shift_rows_r256_single(uint64_t q[8]) {
    size_t k;
    for (k = 0; k < 8; k++) {
        uint64_t x = q[k];
        uint64_t r0 = x & 0xFFFFULL;

        uint32_t x1 = (uint32_t)((x >> 16U) & 0xFFFFULL);
        uint32_t lo1 = x1 & 0x1111U;
        uint32_t hi1 = (x1 >> 1U) & 0x1111U;
        uint32_t nlo1 = (lo1 >> 4U) | ((hi1 & 0x0001U) << 12U);
        uint32_t nhi1 = (hi1 >> 4U) | ((lo1 & 0x0001U) << 12U);
        uint64_t r1 = (uint64_t)(nlo1 | (nhi1 << 1U)) << 16U;

        uint32_t x2 = (uint32_t)((x >> 32U) & 0xFFFFULL);
        uint32_t lo2 = x2 & 0x1111U;
        uint32_t hi2 = (x2 >> 1U) & 0x1111U;
        uint32_t nlo2 = (lo2 >> 12U) | ((hi2 & 0x0111U) << 4U);
        uint32_t nhi2 = (hi2 >> 12U) | ((lo2 & 0x0111U) << 4U);
        uint64_t r2 = (uint64_t)(nlo2 | (nhi2 << 1U)) << 32U;

        uint32_t x3 = (uint32_t)((x >> 48U) & 0xFFFFULL);
        uint64_t r3 = (uint64_t)(((x3 & 0x1111U) << 1U) | ((x3 >> 1U) & 0x1111U)) << 48U;

        q[k] = r0 | r1 | r2 | r3;
    }
}

static inline void bs_inv_shift_rows_r256_single(uint64_t q[8]) {
    size_t k;
    for (k = 0; k < 8; k++) {
        uint64_t x = q[k];
        uint64_t r0 = x & 0xFFFFULL;

        uint32_t x1 = (uint32_t)((x >> 16U) & 0xFFFFULL);
        uint32_t lo1 = x1 & 0x1111U;
        uint32_t hi1 = (x1 >> 1U) & 0x1111U;
        uint32_t nlo1 = ((lo1 & 0x0111U) << 4U) | ((hi1 >> 12U) & 0x0001U);
        uint32_t nhi1 = ((hi1 & 0x0111U) << 4U) | ((lo1 >> 12U) & 0x0001U);
        uint64_t r1 = (uint64_t)(nlo1 | (nhi1 << 1U)) << 16U;

        uint32_t x2 = (uint32_t)((x >> 32U) & 0xFFFFULL);
        uint32_t lo2 = x2 & 0x1111U;
        uint32_t hi2 = (x2 >> 1U) & 0x1111U;
        uint32_t nlo2 = ((lo2 & 0x0001U) << 12U) | (hi2 >> 4U);
        uint32_t nhi2 = ((hi2 & 0x0001U) << 12U) | (lo2 >> 4U);
        uint64_t r2 = (uint64_t)(nlo2 | (nhi2 << 1U)) << 32U;

        uint32_t x3 = (uint32_t)((x >> 48U) & 0xFFFFULL);
        uint64_t r3 = (uint64_t)(((x3 & 0x1111U) << 1U) | ((x3 >> 1U) & 0x1111U)) << 48U;

        q[k] = r0 | r1 | r2 | r3;
    }
}

static inline void bs_shift_rows_r256_pair(uint64_t q_lo[8], uint64_t q_hi[8]) {
    size_t k;
    for (k = 0; k < 8; k++) {
        uint64_t lo = q_lo[k];
        uint64_t hi = q_hi[k];

        uint32_t w1 = (uint32_t)((uint16_t)(lo >> 16U)) | ((uint32_t)((uint16_t)(hi >> 16U)) << 16U);
        uint32_t r1 = (w1 >> 4U) | (w1 << 28U);
        uint32_t w2 = (uint32_t)((uint16_t)(lo >> 32U)) | ((uint32_t)((uint16_t)(hi >> 32U)) << 16U);
        uint32_t r2 = (w2 >> 12U) | (w2 << 20U);

        q_lo[k] = (uint64_t)((uint16_t)lo) |
                  ((uint64_t)((uint16_t)r1) << 16U) |
                  ((uint64_t)((uint16_t)r2) << 32U) |
                  ((hi >> 48U) << 48U);
        q_hi[k] = (uint64_t)((uint16_t)hi) |
                  ((uint64_t)((uint16_t)(r1 >> 16U)) << 16U) |
                  ((uint64_t)((uint16_t)(r2 >> 16U)) << 32U) |
                  ((lo >> 48U) << 48U);
    }
}

static inline void bs_inv_shift_rows_r256_pair(uint64_t q_lo[8], uint64_t q_hi[8]) {
    size_t k;
    for (k = 0; k < 8; k++) {
        uint64_t lo = q_lo[k];
        uint64_t hi = q_hi[k];

        uint32_t w1 = (uint32_t)((uint16_t)(lo >> 16U)) | ((uint32_t)((uint16_t)(hi >> 16U)) << 16U);
        uint32_t r1 = (w1 << 4U) | (w1 >> 28U);
        uint32_t w2 = (uint32_t)((uint16_t)(lo >> 32U)) | ((uint32_t)((uint16_t)(hi >> 32U)) << 16U);
        uint32_t r2 = (w2 << 12U) | (w2 >> 20U);

        q_lo[k] = (uint64_t)((uint16_t)lo) |
                  ((uint64_t)((uint16_t)r1) << 16U) |
                  ((uint64_t)((uint16_t)r2) << 32U) |
                  ((hi >> 48U) << 48U);
        q_hi[k] = (uint64_t)((uint16_t)hi) |
                  ((uint64_t)((uint16_t)(r1 >> 16U)) << 16U) |
                  ((uint64_t)((uint16_t)(r2 >> 16U)) << 32U) |
                  ((lo >> 48U) << 48U);
    }
}

static AREION_NOINLINE void rijndael256_encrypt_block_purec_body(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[15][32]) {
    uint8_t lo[16], hi[16];
    uint64_t q[8], kr[8];
    size_t i, k, r;
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(rk);

    for (i = 0; i < 16; i++) {
        lo[i] = (uint8_t)(src[i] ^ rk[0][i]);
        hi[i] = (uint8_t)(src[16 + i] ^ rk[0][16 + i]);
    }
    bs_pack2(q, lo, hi);

    for (r = 1; r <= 11; r += 2) {
        bs_pack4(kr, &rk[r][0], &rk[r][16], &rk[r + 1][0], &rk[r + 1][16]);
        bs_sub_bytes(q);
        bs_shift_rows_r256_single(q);
        bs_mix_columns(q);
        for (k = 0; k < 8; k++) {
            q[k] ^= kr[k] & BS_LANE01_MASK;
        }
        bs_sub_bytes(q);
        bs_shift_rows_r256_single(q);
        bs_mix_columns(q);
        for (k = 0; k < 8; k++) {
            q[k] ^= (kr[k] >> 2U) & BS_LANE01_MASK;
        }
    }

    bs_pack4(kr, &rk[13][0], &rk[13][16], &rk[14][0], &rk[14][16]);
    bs_sub_bytes(q);
    bs_shift_rows_r256_single(q);
    bs_mix_columns(q);
    for (k = 0; k < 8; k++) {
        q[k] ^= kr[k] & BS_LANE01_MASK;
    }
    bs_sub_bytes(q);
    bs_shift_rows_r256_single(q);
    for (k = 0; k < 8; k++) {
        q[k] ^= (kr[k] >> 2U) & BS_LANE01_MASK;
    }

    bs_unpack2(q, &dst[0], &dst[16]);
}

void areion_rijndael256_encrypt_block_purec(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[15][32]) {
    rijndael256_encrypt_block_purec_body(dst, src, rk);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void rijndael256_decrypt_block_purec_body(
    uint8_t dst[32], const uint8_t src[32], const uint8_t drk[15][32]) {
    uint8_t lo[16], hi[16];
    uint64_t q[8], kr[8];
    size_t i, k, r;
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(drk);

    for (i = 0; i < 16; i++) {
        lo[i] = (uint8_t)(src[i] ^ drk[0][i]);
        hi[i] = (uint8_t)(src[16 + i] ^ drk[0][16 + i]);
    }
    bs_pack2(q, lo, hi);

    for (r = 1; r <= 11; r += 2) {
        bs_pack4(kr, &drk[r][0], &drk[r][16], &drk[r + 1][0], &drk[r + 1][16]);
        bs_inv_shift_rows_r256_single(q);
        bs_inv_sub_bytes(q);
        bs_inv_mix_columns(q);
        for (k = 0; k < 8; k++) {
            q[k] ^= kr[k] & BS_LANE01_MASK;
        }
        bs_inv_shift_rows_r256_single(q);
        bs_inv_sub_bytes(q);
        bs_inv_mix_columns(q);
        for (k = 0; k < 8; k++) {
            q[k] ^= (kr[k] >> 2U) & BS_LANE01_MASK;
        }
    }

    bs_pack4(kr, &drk[13][0], &drk[13][16], &drk[14][0], &drk[14][16]);
    bs_inv_shift_rows_r256_single(q);
    bs_inv_sub_bytes(q);
    bs_inv_mix_columns(q);
    for (k = 0; k < 8; k++) {
        q[k] ^= kr[k] & BS_LANE01_MASK;
    }
    bs_inv_shift_rows_r256_single(q);
    bs_inv_sub_bytes(q);
    for (k = 0; k < 8; k++) {
        q[k] ^= (kr[k] >> 2U) & BS_LANE01_MASK;
    }

    bs_unpack2(q, &dst[0], &dst[16]);
}

void areion_rijndael256_decrypt_block_purec(
    uint8_t dst[32], const uint8_t src[32], const uint8_t drk[15][32]) {
    rijndael256_decrypt_block_purec_body(dst, src, drk);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void rijndael256_encrypt4_blocks_purec_body(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[15][32]) {
    uint8_t b_lo[4][16], b_hi[4][16];
    uint64_t q_lo[8], q_hi[8], k_lo[8], k_hi[8];
    unsigned int lane;
    size_t i, k, base;
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(rk);

    for (lane = 0; lane < 4U; lane++) {
        for (i = 0; i < 16; i++) {
            b_lo[lane][i] = (uint8_t)(src[lane][i] ^ rk[0][i]);
            b_hi[lane][i] = (uint8_t)(src[lane][16 + i] ^ rk[0][16 + i]);
        }
    }

    bs_pack4(q_lo, b_lo[0], b_lo[1], b_lo[2], b_lo[3]);
    bs_pack4(q_hi, b_hi[0], b_hi[1], b_hi[2], b_hi[3]);

    for (base = 1; base <= 9; base += 4) {
        bs_pack4(k_lo, &rk[base][0], &rk[base + 1][0], &rk[base + 2][0], &rk[base + 3][0]);
        bs_pack4(k_hi, &rk[base][16], &rk[base + 1][16], &rk[base + 2][16], &rk[base + 3][16]);
        for (lane = 0; lane < 4U; lane++) {
            bs_sub_bytes(q_lo);
            bs_sub_bytes(q_hi);
            bs_shift_rows_r256_pair(q_lo, q_hi);
            bs_mix_columns(q_lo);
            bs_mix_columns(q_hi);
            for (k = 0; k < 8; k++) {
                q_lo[k] ^= ((k_lo[k] >> lane) & BS_LANE0_MASK) * 0xfULL;
                q_hi[k] ^= ((k_hi[k] >> lane) & BS_LANE0_MASK) * 0xfULL;
            }
        }
    }

    bs_pack2(k_lo, &rk[13][0], &rk[14][0]);
    bs_pack2(k_hi, &rk[13][16], &rk[14][16]);
    bs_sub_bytes(q_lo);
    bs_sub_bytes(q_hi);
    bs_shift_rows_r256_pair(q_lo, q_hi);
    bs_mix_columns(q_lo);
    bs_mix_columns(q_hi);
    for (k = 0; k < 8; k++) {
        q_lo[k] ^= (k_lo[k] & BS_LANE0_MASK) * 0xfULL;
        q_hi[k] ^= (k_hi[k] & BS_LANE0_MASK) * 0xfULL;
    }

    bs_sub_bytes(q_lo);
    bs_sub_bytes(q_hi);
    bs_shift_rows_r256_pair(q_lo, q_hi);
    for (k = 0; k < 8; k++) {
        q_lo[k] ^= ((k_lo[k] >> 1U) & BS_LANE0_MASK) * 0xfULL;
        q_hi[k] ^= ((k_hi[k] >> 1U) & BS_LANE0_MASK) * 0xfULL;
    }

    bs_unpack4(q_lo, &dst[0][0], &dst[1][0], &dst[2][0], &dst[3][0]);
    bs_unpack4(q_hi, &dst[0][16], &dst[1][16], &dst[2][16], &dst[3][16]);
}

void areion_rijndael256_encrypt4_blocks_purec(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[15][32]) {
    rijndael256_encrypt4_blocks_purec_body(dst, src, rk);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void rijndael256_decrypt4_blocks_purec_body(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t drk[15][32]) {
    uint8_t b_lo[4][16], b_hi[4][16];
    uint64_t q_lo[8], q_hi[8], k_lo[8], k_hi[8];
    unsigned int lane;
    size_t i, k, base;
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(drk);

    for (lane = 0; lane < 4U; lane++) {
        for (i = 0; i < 16; i++) {
            b_lo[lane][i] = (uint8_t)(src[lane][i] ^ drk[0][i]);
            b_hi[lane][i] = (uint8_t)(src[lane][16 + i] ^ drk[0][16 + i]);
        }
    }

    bs_pack4(q_lo, b_lo[0], b_lo[1], b_lo[2], b_lo[3]);
    bs_pack4(q_hi, b_hi[0], b_hi[1], b_hi[2], b_hi[3]);

    for (base = 1; base <= 9; base += 4) {
        bs_pack4(k_lo, &drk[base][0], &drk[base + 1][0], &drk[base + 2][0], &drk[base + 3][0]);
        bs_pack4(k_hi, &drk[base][16], &drk[base + 1][16], &drk[base + 2][16], &drk[base + 3][16]);
        for (lane = 0; lane < 4U; lane++) {
            bs_inv_shift_rows_r256_pair(q_lo, q_hi);
            bs_inv_sub_bytes(q_lo);
            bs_inv_sub_bytes(q_hi);
            bs_inv_mix_columns(q_lo);
            bs_inv_mix_columns(q_hi);
            for (k = 0; k < 8; k++) {
                q_lo[k] ^= ((k_lo[k] >> lane) & BS_LANE0_MASK) * 0xfULL;
                q_hi[k] ^= ((k_hi[k] >> lane) & BS_LANE0_MASK) * 0xfULL;
            }
        }
    }

    bs_pack2(k_lo, &drk[13][0], &drk[14][0]);
    bs_pack2(k_hi, &drk[13][16], &drk[14][16]);
    bs_inv_shift_rows_r256_pair(q_lo, q_hi);
    bs_inv_sub_bytes(q_lo);
    bs_inv_sub_bytes(q_hi);
    bs_inv_mix_columns(q_lo);
    bs_inv_mix_columns(q_hi);
    for (k = 0; k < 8; k++) {
        q_lo[k] ^= (k_lo[k] & BS_LANE0_MASK) * 0xfULL;
        q_hi[k] ^= (k_hi[k] & BS_LANE0_MASK) * 0xfULL;
    }

    bs_inv_shift_rows_r256_pair(q_lo, q_hi);
    bs_inv_sub_bytes(q_lo);
    bs_inv_sub_bytes(q_hi);
    for (k = 0; k < 8; k++) {
        q_lo[k] ^= ((k_lo[k] >> 1U) & BS_LANE0_MASK) * 0xfULL;
        q_hi[k] ^= ((k_hi[k] >> 1U) & BS_LANE0_MASK) * 0xfULL;
    }

    bs_unpack4(q_lo, &dst[0][0], &dst[1][0], &dst[2][0], &dst[3][0]);
    bs_unpack4(q_hi, &dst[0][16], &dst[1][16], &dst[2][16], &dst[3][16]);
}

void areion_rijndael256_decrypt4_blocks_purec(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t drk[15][32]) {
    rijndael256_decrypt4_blocks_purec_body(dst, src, drk);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}
