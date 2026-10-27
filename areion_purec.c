/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

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
 * Software Stack Frame Zeroization
 * ========================================================================= */

static AREION_NOINLINE AREION_NO_STACK_PROTECTOR void areion_wipe_software_stack(void) {
    volatile uint64_t frame[512];
    size_t i;
#if defined(__GNUC__) || defined(__clang__)
    const void *fp = __builtin_frame_address(0);
#endif
    for (i = 0; i < 512; i++) {
        frame[i] = 0;
    }
#if defined(__GNUC__) || defined(__clang__)
    __asm__ __volatile__("" : : "r"(frame), "r"(fp) : "memory");
#else
    areion_compiler_barrier();
#endif
}

/* =========================================================================
 * 64-Bit Bitsliced AES Primitives (1-to-1 with areion_purego.go)
 * ========================================================================= */

#define BS_LANE01_MASK 0x3333333333333333ULL
#define BS_LANE0_MASK  0x1111111111111111ULL
#define BS_BYTE0_MASK  0x0101010101010101ULL

static inline uint64_t bs_rotl64(uint64_t x, unsigned int n) {
    return (x << (n & 63U)) | (x >> ((64U - n) & 63U));
}

static inline uint16_t bs_rotl16_4(uint16_t x) {
    return (uint16_t)(((uint32_t)x << 4U) | ((uint32_t)x >> 12U));
}

static inline uint16_t bs_rotr16_4(uint16_t x) {
    return (uint16_t)(((uint32_t)x >> 4U) | ((uint32_t)x << 12U));
}

static inline uint16_t bs_rot16_8(uint16_t x) {
    return (uint16_t)(((uint32_t)x << 8U) | ((uint32_t)x >> 8U));
}

static inline uint64_t bs_prep_word(uint64_t u) {
    uint64_t t = ((u >> 24U) ^ u) & 0x00000000ff00ff00ULL;
    u ^= t ^ (t << 24U);
    t = ((u >> 16U) ^ u) & 0x00000000ffff0000ULL;
    u ^= t ^ (t << 16U);
    return u;
}

static inline uint64_t bs_unprep_word(uint64_t u) {
    uint64_t t = ((u >> 16U) ^ u) & 0x00000000ffff0000ULL;
    u ^= t ^ (t << 16U);
    t = ((u >> 24U) ^ u) & 0x00000000ff00ff00ULL;
    u ^= t ^ (t << 24U);
    return u;
}

static inline void bs_prep_block(uint64_t lo, uint64_t hi, uint64_t *u0, uint64_t *u1) {
    uint64_t a0 = (lo & 0x00000000ffffffffULL) | (hi << 32U);
    uint64_t a1 = (lo >> 32U) | (hi & 0xffffffff00000000ULL);
    *u0 = bs_prep_word(a0);
    *u1 = bs_prep_word(a1);
}

static inline void bs_unprep_block(uint64_t u0, uint64_t u1, uint64_t *lo, uint64_t *hi) {
    u0 = bs_unprep_word(u0);
    u1 = bs_unprep_word(u1);
    *lo = (u0 & 0x00000000ffffffffULL) | (u1 << 32U);
    *hi = (u0 >> 32U) | (u1 & 0xffffffff00000000ULL);
}

static inline void bs_ortho(uint64_t w[8]) {
    const uint64_t m1 = 0x5555555555555555ULL;
    const uint64_t m2 = 0x3333333333333333ULL;
    const uint64_t m4 = 0x0f0f0f0f0f0f0f0fULL;
    uint64_t t;

    t = ((w[0] >> 1U) ^ w[1]) & m1;
    w[0] ^= t << 1U;
    w[1] ^= t;
    t = ((w[2] >> 1U) ^ w[3]) & m1;
    w[2] ^= t << 1U;
    w[3] ^= t;
    t = ((w[4] >> 1U) ^ w[5]) & m1;
    w[4] ^= t << 1U;
    w[5] ^= t;
    t = ((w[6] >> 1U) ^ w[7]) & m1;
    w[6] ^= t << 1U;
    w[7] ^= t;

    t = ((w[0] >> 2U) ^ w[2]) & m2;
    w[0] ^= t << 2U;
    w[2] ^= t;
    t = ((w[1] >> 2U) ^ w[3]) & m2;
    w[1] ^= t << 2U;
    w[3] ^= t;
    t = ((w[4] >> 2U) ^ w[6]) & m2;
    w[4] ^= t << 2U;
    w[6] ^= t;
    t = ((w[5] >> 2U) ^ w[7]) & m2;
    w[5] ^= t << 2U;
    w[7] ^= t;

    t = ((w[0] >> 4U) ^ w[4]) & m4;
    w[0] ^= t << 4U;
    w[4] ^= t;
    t = ((w[1] >> 4U) ^ w[5]) & m4;
    w[1] ^= t << 4U;
    w[5] ^= t;
    t = ((w[2] >> 4U) ^ w[6]) & m4;
    w[2] ^= t << 4U;
    w[6] ^= t;
    t = ((w[3] >> 4U) ^ w[7]) & m4;
    w[3] ^= t << 4U;
    w[7] ^= t;
}

static inline void bs_pack1(uint64_t q[8], const uint8_t b0[16]) {
    uint64_t lo = areion_load_le64(&b0[0]);
    uint64_t hi = areion_load_le64(&b0[8]);
    uint64_t u0, u1;
    bs_prep_block(lo, hi, &u0, &u1);
    q[0] = (u0 & BS_BYTE0_MASK) | ((u1 & BS_BYTE0_MASK) << 4U);
    q[1] = ((u0 >> 1U) & BS_BYTE0_MASK) | (((u1 >> 1U) & BS_BYTE0_MASK) << 4U);
    q[2] = ((u0 >> 2U) & BS_BYTE0_MASK) | (((u1 >> 2U) & BS_BYTE0_MASK) << 4U);
    q[3] = ((u0 >> 3U) & BS_BYTE0_MASK) | (((u1 >> 3U) & BS_BYTE0_MASK) << 4U);
    q[4] = ((u0 >> 4U) & BS_BYTE0_MASK) | (((u1 >> 4U) & BS_BYTE0_MASK) << 4U);
    q[5] = ((u0 >> 5U) & BS_BYTE0_MASK) | (((u1 >> 5U) & BS_BYTE0_MASK) << 4U);
    q[6] = ((u0 >> 6U) & BS_BYTE0_MASK) | (((u1 >> 6U) & BS_BYTE0_MASK) << 4U);
    q[7] = ((u0 >> 7U) & BS_BYTE0_MASK) | (((u1 >> 7U) & BS_BYTE0_MASK) << 4U);
}

static inline void bs_unpack1(const uint64_t q[8], uint8_t b0[16]) {
    uint64_t u0 = (q[0] & BS_BYTE0_MASK) |
                  ((q[1] & BS_BYTE0_MASK) << 1U) |
                  ((q[2] & BS_BYTE0_MASK) << 2U) |
                  ((q[3] & BS_BYTE0_MASK) << 3U) |
                  ((q[4] & BS_BYTE0_MASK) << 4U) |
                  ((q[5] & BS_BYTE0_MASK) << 5U) |
                  ((q[6] & BS_BYTE0_MASK) << 6U) |
                  ((q[7] & BS_BYTE0_MASK) << 7U);
    uint64_t u1 = ((q[0] >> 4U) & BS_BYTE0_MASK) |
                  (((q[1] >> 4U) & BS_BYTE0_MASK) << 1U) |
                  (((q[2] >> 4U) & BS_BYTE0_MASK) << 2U) |
                  (((q[3] >> 4U) & BS_BYTE0_MASK) << 3U) |
                  (((q[4] >> 4U) & BS_BYTE0_MASK) << 4U) |
                  (((q[5] >> 4U) & BS_BYTE0_MASK) << 5U) |
                  (((q[6] >> 4U) & BS_BYTE0_MASK) << 6U) |
                  (((q[7] >> 4U) & BS_BYTE0_MASK) << 7U);
    uint64_t lo, hi;
    bs_unprep_block(u0, u1, &lo, &hi);
    areion_store_le64(&b0[0], lo);
    areion_store_le64(&b0[8], hi);
}

static inline void bs_pack2(uint64_t q[8], const uint8_t b0[16], const uint8_t b1[16]) {
    uint64_t u00, u10, u01, u11;
    unsigned int k;
    bs_prep_block(areion_load_le64(&b0[0]), areion_load_le64(&b0[8]), &u00, &u10);
    bs_prep_block(areion_load_le64(&b1[0]), areion_load_le64(&b1[8]), &u01, &u11);
    for (k = 0; k < 8U; k++) {
        uint64_t c0 = ((u00 >> k) & BS_BYTE0_MASK) | (((u01 >> k) & BS_BYTE0_MASK) << 1U);
        uint64_t c1 = ((u10 >> k) & BS_BYTE0_MASK) | (((u11 >> k) & BS_BYTE0_MASK) << 1U);
        q[k] = c0 | (c1 << 4U);
    }
}

static inline void bs_unpack2(const uint64_t q[8], uint8_t b0[16], uint8_t b1[16]) {
    uint64_t u00 = 0, u10 = 0, u01 = 0, u11 = 0;
    uint64_t lo0, hi0, lo1, hi1;
    unsigned int k;
    for (k = 0; k < 8U; k++) {
        uint64_t xk = q[k];
        u00 |= (xk & BS_BYTE0_MASK) << k;
        u01 |= ((xk >> 1U) & BS_BYTE0_MASK) << k;
        u10 |= ((xk >> 4U) & BS_BYTE0_MASK) << k;
        u11 |= ((xk >> 5U) & BS_BYTE0_MASK) << k;
    }
    bs_unprep_block(u00, u10, &lo0, &hi0);
    bs_unprep_block(u01, u11, &lo1, &hi1);
    areion_store_le64(&b0[0], lo0);
    areion_store_le64(&b0[8], hi0);
    areion_store_le64(&b1[0], lo1);
    areion_store_le64(&b1[8], hi1);
}

static inline void bs_pack4(
    uint64_t q[8],
    const uint8_t b0[16],
    const uint8_t b1[16],
    const uint8_t b2[16],
    const uint8_t b3[16]) {
    bs_prep_block(areion_load_le64(&b0[0]), areion_load_le64(&b0[8]), &q[0], &q[4]);
    bs_prep_block(areion_load_le64(&b1[0]), areion_load_le64(&b1[8]), &q[1], &q[5]);
    bs_prep_block(areion_load_le64(&b2[0]), areion_load_le64(&b2[8]), &q[2], &q[6]);
    bs_prep_block(areion_load_le64(&b3[0]), areion_load_le64(&b3[8]), &q[3], &q[7]);
    bs_ortho(q);
}

static inline void bs_unpack4(
    const uint64_t q[8],
    uint8_t b0[16],
    uint8_t b1[16],
    uint8_t b2[16],
    uint8_t b3[16]) {
    uint64_t w[8];
    uint64_t lo0, hi0, lo1, hi1, lo2, hi2, lo3, hi3;
    size_t i;
    for (i = 0; i < 8; i++) {
        w[i] = q[i];
    }
    bs_ortho(w);
    bs_unprep_block(w[0], w[4], &lo0, &hi0);
    bs_unprep_block(w[1], w[5], &lo1, &hi1);
    bs_unprep_block(w[2], w[6], &lo2, &hi2);
    bs_unprep_block(w[3], w[7], &lo3, &hi3);
    areion_store_le64(&b0[0], lo0);
    areion_store_le64(&b0[8], hi0);
    areion_store_le64(&b1[0], lo1);
    areion_store_le64(&b1[8], hi1);
    areion_store_le64(&b2[0], lo2);
    areion_store_le64(&b2[8], hi2);
    areion_store_le64(&b3[0], lo3);
    areion_store_le64(&b3[8], hi3);
    areion_secure_wipe(w, sizeof(w));
}

/* Boyar-Peralta forward AES S-box circuit. */
static AREION_NOINLINE void bs_sub_bytes(uint64_t q[8]) {
    uint64_t u0 = q[7], u1 = q[6], u2 = q[5], u3 = q[4];
    uint64_t u4 = q[3], u5 = q[2], u6 = q[1], u7 = q[0];

    uint64_t y14 = u3 ^ u5;
    uint64_t y13 = u0 ^ u6;
    uint64_t y9 = u0 ^ u3;
    uint64_t y8 = u0 ^ u5;
    uint64_t t0 = u1 ^ u2;
    uint64_t y1 = t0 ^ u7;
    uint64_t y4 = y1 ^ u3;
    uint64_t y12 = y13 ^ y14;
    uint64_t y2 = y1 ^ u0;
    uint64_t y5 = y1 ^ u6;
    uint64_t y3 = y5 ^ y8;
    uint64_t t1 = u4 ^ y12;
    uint64_t y15 = t1 ^ u5;
    uint64_t y20 = t1 ^ u1;
    uint64_t y6 = y15 ^ u7;
    uint64_t y10 = y15 ^ t0;
    uint64_t y11 = y20 ^ y9;
    uint64_t y7 = u7 ^ y11;
    uint64_t y17 = y10 ^ y11;
    uint64_t y19 = y10 ^ y8;
    uint64_t y16 = t0 ^ y11;
    uint64_t y21 = y13 ^ y16;
    uint64_t y18 = u0 ^ y16;

    uint64_t t2 = y12 & y15;
    uint64_t t3 = y3 & y6;
    uint64_t t4 = t3 ^ t2;
    uint64_t t5 = y4 & u7;
    uint64_t t6 = t5 ^ t2;
    uint64_t t7 = y13 & y16;
    uint64_t t8 = y5 & y1;
    uint64_t t9 = t8 ^ t7;
    uint64_t t10 = y2 & y7;
    uint64_t t11 = t10 ^ t7;
    uint64_t t12 = y9 & y11;
    uint64_t t13 = y14 & y17;
    uint64_t t14 = t13 ^ t12;
    uint64_t t15 = y8 & y10;
    uint64_t t16 = t15 ^ t12;
    uint64_t t17 = t4 ^ t14;
    uint64_t t18 = t6 ^ t16;
    uint64_t t19 = t9 ^ t14;
    uint64_t t20 = t11 ^ t16;
    uint64_t t21 = t17 ^ y20;
    uint64_t t22 = t18 ^ y19;
    uint64_t t23 = t19 ^ y21;
    uint64_t t24 = t20 ^ y18;

    uint64_t t25 = t21 ^ t22;
    uint64_t t26 = t21 & t23;
    uint64_t t27 = t24 ^ t26;
    uint64_t t28 = t25 & t27;
    uint64_t t29 = t28 ^ t22;
    uint64_t t30 = t23 ^ t24;
    uint64_t t31 = t22 ^ t26;
    uint64_t t32 = t31 & t30;
    uint64_t t33 = t32 ^ t24;
    uint64_t t34 = t23 ^ t33;
    uint64_t t35 = t27 ^ t33;
    uint64_t t36 = t24 & t35;
    uint64_t t37 = t36 ^ t34;
    uint64_t t38 = t27 ^ t36;
    uint64_t t39 = t29 & t38;
    uint64_t t40 = t25 ^ t39;
    uint64_t t41 = t40 ^ t37;
    uint64_t t42 = t29 ^ t33;
    uint64_t t43 = t29 ^ t40;
    uint64_t t44 = t33 ^ t37;
    uint64_t t45 = t42 ^ t41;

    uint64_t z0 = t44 & y15;
    uint64_t z1 = t37 & y6;
    uint64_t z2 = t33 & u7;
    uint64_t z3 = t43 & y16;
    uint64_t z4 = t40 & y1;
    uint64_t z5 = t29 & y7;
    uint64_t z6 = t42 & y11;
    uint64_t z7 = t45 & y17;
    uint64_t z8 = t41 & y10;
    uint64_t z9 = t44 & y12;
    uint64_t z10 = t37 & y3;
    uint64_t z11 = t33 & y4;
    uint64_t z12 = t43 & y13;
    uint64_t z13 = t40 & y5;
    uint64_t z14 = t29 & y2;
    uint64_t z15 = t42 & y9;
    uint64_t z16 = t45 & y14;
    uint64_t z17 = t41 & y8;

    uint64_t t46 = z15 ^ z16;
    uint64_t t47 = z10 ^ z11;
    uint64_t t48 = z5 ^ z13;
    uint64_t t49 = z9 ^ z10;
    uint64_t t50 = z2 ^ z12;
    uint64_t t51 = z2 ^ z5;
    uint64_t t52 = z7 ^ z8;
    uint64_t t53 = z0 ^ z3;
    uint64_t t54 = z6 ^ z7;
    uint64_t t55 = z16 ^ z17;
    uint64_t t56 = z12 ^ t48;
    uint64_t t57 = t50 ^ t53;
    uint64_t t58 = z4 ^ t46;
    uint64_t t59 = z3 ^ t54;
    uint64_t t60 = t46 ^ t57;
    uint64_t t61 = z14 ^ t57;
    uint64_t t62 = t52 ^ t58;
    uint64_t t63 = t49 ^ t58;
    uint64_t t64 = z4 ^ t59;
    uint64_t t65 = t61 ^ t62;
    uint64_t t66 = z1 ^ t63;
    uint64_t s0 = t59 ^ t63;
    uint64_t s6 = ~(t56 ^ t62);
    uint64_t s7 = ~(t48 ^ t60);
    uint64_t t67 = t64 ^ t65;
    uint64_t s3 = t53 ^ t66;
    uint64_t s4 = t51 ^ t66;
    uint64_t s5 = t47 ^ t65;
    uint64_t s1 = ~(t64 ^ s3);
    uint64_t s2 = ~(t55 ^ t67);

    q[7] = s0;
    q[6] = s1;
    q[5] = s2;
    q[4] = s3;
    q[3] = s4;
    q[2] = s5;
    q[1] = s6;
    q[0] = s7;
}

/* Boyar-Peralta inverse AES S-box circuit. */
static AREION_NOINLINE void bs_inv_sub_bytes(uint64_t q[8]) {
    uint64_t p05 = q[0] ^ q[5];
    uint64_t p14 = q[1] ^ q[4];
    uint64_t p27 = q[2] ^ q[7];
    uint64_t p36 = q[3] ^ q[6];

    uint64_t u7 = ~(p27 ^ q[5]);
    uint64_t u6 = p36 ^ q[0];
    uint64_t u5 = ~(p14 ^ q[7]);
    uint64_t u4 = p05 ^ q[2];
    uint64_t u3 = p36 ^ q[1];
    uint64_t u2 = p27 ^ q[4];
    uint64_t u1 = p05 ^ q[3];
    uint64_t u0 = p14 ^ q[6];

    uint64_t y14 = u3 ^ u5;
    uint64_t y13 = u0 ^ u6;
    uint64_t y9 = u0 ^ u3;
    uint64_t y8 = u0 ^ u5;
    uint64_t t0 = u1 ^ u2;
    uint64_t y1 = t0 ^ u7;
    uint64_t y4 = y1 ^ u3;
    uint64_t y12 = y13 ^ y14;
    uint64_t y2 = y1 ^ u0;
    uint64_t y5 = y1 ^ u6;
    uint64_t y3 = y5 ^ y8;
    uint64_t t1 = u4 ^ y12;
    uint64_t y15 = t1 ^ u5;
    uint64_t y20 = t1 ^ u1;
    uint64_t y6 = y15 ^ u7;
    uint64_t y10 = y15 ^ t0;
    uint64_t y11 = y20 ^ y9;
    uint64_t y7 = u7 ^ y11;
    uint64_t y17 = y10 ^ y11;
    uint64_t y19 = y10 ^ y8;
    uint64_t y16 = t0 ^ y11;
    uint64_t y21 = y13 ^ y16;
    uint64_t y18 = u0 ^ y16;

    uint64_t t2 = y12 & y15;
    uint64_t t3 = y3 & y6;
    uint64_t t4 = t3 ^ t2;
    uint64_t t5 = y4 & u7;
    uint64_t t6 = t5 ^ t2;
    uint64_t t7 = y13 & y16;
    uint64_t t8 = y5 & y1;
    uint64_t t9 = t8 ^ t7;
    uint64_t t10 = y2 & y7;
    uint64_t t11 = t10 ^ t7;
    uint64_t t12 = y9 & y11;
    uint64_t t13 = y14 & y17;
    uint64_t t14 = t13 ^ t12;
    uint64_t t15 = y8 & y10;
    uint64_t t16 = t15 ^ t12;
    uint64_t t17 = t4 ^ t14;
    uint64_t t18 = t6 ^ t16;
    uint64_t t19 = t9 ^ t14;
    uint64_t t20 = t11 ^ t16;
    uint64_t t21 = t17 ^ y20;
    uint64_t t22 = t18 ^ y19;
    uint64_t t23 = t19 ^ y21;
    uint64_t t24 = t20 ^ y18;

    uint64_t t25 = t21 ^ t22;
    uint64_t t26 = t21 & t23;
    uint64_t t27 = t24 ^ t26;
    uint64_t t28 = t25 & t27;
    uint64_t t29 = t28 ^ t22;
    uint64_t t30 = t23 ^ t24;
    uint64_t t31 = t22 ^ t26;
    uint64_t t32 = t31 & t30;
    uint64_t t33 = t32 ^ t24;
    uint64_t t34 = t23 ^ t33;
    uint64_t t35 = t27 ^ t33;
    uint64_t t36 = t24 & t35;
    uint64_t t37 = t36 ^ t34;
    uint64_t t38 = t27 ^ t36;
    uint64_t t39 = t29 & t38;
    uint64_t t40 = t25 ^ t39;
    uint64_t t41 = t40 ^ t37;
    uint64_t t42 = t29 ^ t33;
    uint64_t t43 = t29 ^ t40;
    uint64_t t44 = t33 ^ t37;
    uint64_t t45 = t42 ^ t41;

    uint64_t z0 = t44 & y15;
    uint64_t z1 = t37 & y6;
    uint64_t z2 = t33 & u7;
    uint64_t z3 = t43 & y16;
    uint64_t z4 = t40 & y1;
    uint64_t z5 = t29 & y7;
    uint64_t z6 = t42 & y11;
    uint64_t z7 = t45 & y17;
    uint64_t z8 = t41 & y10;
    uint64_t z9 = t44 & y12;
    uint64_t z10 = t37 & y3;
    uint64_t z11 = t33 & y4;
    uint64_t z12 = t43 & y13;
    uint64_t z13 = t40 & y5;
    uint64_t z14 = t29 & y2;
    uint64_t z15 = t42 & y9;
    uint64_t z16 = t45 & y14;
    uint64_t z17 = t41 & y8;

    uint64_t t46 = z15 ^ z16;
    uint64_t t47 = z10 ^ z11;
    uint64_t t48 = z5 ^ z13;
    uint64_t t49 = z9 ^ z10;
    uint64_t t50 = z2 ^ z12;
    uint64_t t51 = z2 ^ z5;
    uint64_t t52 = z7 ^ z8;
    uint64_t t53 = z0 ^ z3;
    uint64_t t54 = z6 ^ z7;
    uint64_t t55 = z16 ^ z17;
    uint64_t t56 = z12 ^ t48;
    uint64_t t57 = t50 ^ t53;
    uint64_t t58 = z4 ^ t46;
    uint64_t t59 = z3 ^ t54;
    uint64_t t60 = t46 ^ t57;
    uint64_t t61 = z14 ^ t57;
    uint64_t t62 = t52 ^ t58;
    uint64_t t63 = t49 ^ t58;
    uint64_t t64 = z4 ^ t59;
    uint64_t t65 = t61 ^ t62;
    uint64_t t66 = z1 ^ t63;
    uint64_t w7 = t59 ^ t63;
    uint64_t w1 = t56 ^ t62;
    uint64_t w0 = t48 ^ t60;
    uint64_t t67 = t64 ^ t65;
    uint64_t w4 = t53 ^ t66;
    uint64_t w3 = t51 ^ t66;
    uint64_t w2 = t47 ^ t65;
    uint64_t w6 = t64 ^ w4;
    uint64_t w5 = t55 ^ t67;

    uint64_t q05 = w0 ^ w5;
    uint64_t q14 = w1 ^ w4;
    uint64_t q27 = w2 ^ w7;
    uint64_t q36 = w3 ^ w6;

    q[0] = q27 ^ w5;
    q[1] = q36 ^ w0;
    q[2] = q14 ^ w7;
    q[3] = q05 ^ w2;
    q[4] = q36 ^ w1;
    q[5] = q27 ^ w4;
    q[6] = q05 ^ w3;
    q[7] = q14 ^ w6;
}

static inline void bs_shift_rows(uint64_t q[8]) {
    size_t k;
    for (k = 0; k < 8; k++) {
        uint64_t x = q[k];
        q[k] = (uint64_t)((uint16_t)x) |
               ((uint64_t)bs_rotr16_4((uint16_t)(x >> 16U)) << 16U) |
               ((uint64_t)bs_rot16_8((uint16_t)(x >> 32U)) << 32U) |
               ((uint64_t)bs_rotl16_4((uint16_t)(x >> 48U)) << 48U);
    }
}

static inline void bs_inv_shift_rows(uint64_t q[8]) {
    size_t k;
    for (k = 0; k < 8; k++) {
        uint64_t x = q[k];
        q[k] = (uint64_t)((uint16_t)x) |
               ((uint64_t)bs_rotl16_4((uint16_t)(x >> 16U)) << 16U) |
               ((uint64_t)bs_rot16_8((uint16_t)(x >> 32U)) << 32U) |
               ((uint64_t)bs_rotr16_4((uint16_t)(x >> 48U)) << 48U);
    }
}

static AREION_NOINLINE void bs_mix_columns(uint64_t q[8]) {
    uint64_t a[8], b[8];
    uint64_t a7;
    size_t k;
    for (k = 0; k < 8; k++) {
        uint64_t r1 = bs_rotl64(q[k], 48);
        uint64_t ak = q[k] ^ r1;
        a[k] = ak;
        b[k] = r1 ^ bs_rotl64(ak, 32);
    }
    a7 = a[7];
    q[0] = a7 ^ b[0];
    q[1] = a[0] ^ a7 ^ b[1];
    q[2] = a[1] ^ b[2];
    q[3] = a[2] ^ a7 ^ b[3];
    q[4] = a[3] ^ a7 ^ b[4];
    q[5] = a[4] ^ b[5];
    q[6] = a[5] ^ b[6];
    q[7] = a[6] ^ b[7];
    areion_secure_wipe(a, sizeof(a));
    areion_secure_wipe(b, sizeof(b));
}

static AREION_NOINLINE void bs_inv_mix_columns(uint64_t q[8]) {
    uint64_t d[8], u[8], f[8];
    uint64_t d6, d7, d67, f7;
    size_t k;
    for (k = 0; k < 8; k++) {
        d[k] = q[k] ^ bs_rotl64(q[k], 32);
    }
    d6 = d[6];
    d7 = d[7];
    d67 = d6 ^ d7;
    u[0] = d6;
    u[1] = d67;
    u[2] = d[0] ^ d7;
    u[3] = d[1] ^ d6;
    u[4] = d[2] ^ d67;
    u[5] = d[3] ^ d7;
    u[6] = d[4];
    u[7] = d[5];

    for (k = 0; k < 8; k++) {
        f[k] = u[k] ^ bs_rotl64(u[k], 48);
    }
    bs_mix_columns(q);
    f7 = f[7];
    q[0] ^= u[0] ^ f7;
    q[1] ^= u[1] ^ f[0] ^ f7;
    q[2] ^= u[2] ^ f[1];
    q[3] ^= u[3] ^ f[2] ^ f7;
    q[4] ^= u[4] ^ f[3] ^ f7;
    q[5] ^= u[5] ^ f[4];
    q[6] ^= u[6] ^ f[5];
    q[7] ^= u[7] ^ f[6];
    areion_secure_wipe(d, sizeof(d));
    areion_secure_wipe(u, sizeof(u));
    areion_secure_wipe(f, sizeof(f));
}

static inline void bs_xor(uint64_t dst[8], const uint64_t src[8]) {
    size_t k;
    for (k = 0; k < 8; k++) {
        dst[k] ^= src[k];
    }
}

static inline void bs_copy(uint64_t dst[8], const uint64_t src[8]) {
    size_t k;
    for (k = 0; k < 8; k++) {
        dst[k] = src[k];
    }
}

static inline void bs_round_no_key(uint64_t q[8]) {
    bs_sub_bytes(q);
    bs_shift_rows(q);
    bs_mix_columns(q);
}

static inline void bs_final_round_no_key(uint64_t q[8]) {
    bs_sub_bytes(q);
    bs_shift_rows(q);
}

static inline void bs_inv_final_round_no_key(uint64_t q[8]) {
    bs_inv_shift_rows(q);
    bs_inv_sub_bytes(q);
}

/* =========================================================================
 * Bitsliced Areion-256 and Areion-512 Core Permutations
 * ========================================================================= */

static void areion256_permute_bs(uint64_t x0[8], uint64_t x1[8], const uint64_t rcs[15][8]) {
    uint64_t temp[8];
    size_t r;
    for (r = 0; r < 10; r += 2) {
        bs_sub_bytes(x0);
        bs_shift_rows(x0);
        bs_copy(temp, x0);
        bs_mix_columns(temp);
        bs_xor(temp, rcs[r]);
        bs_round_no_key(temp);
        bs_xor(x1, temp);

        bs_sub_bytes(x1);
        bs_shift_rows(x1);
        bs_copy(temp, x1);
        bs_mix_columns(temp);
        bs_xor(temp, rcs[r + 1]);
        bs_round_no_key(temp);
        bs_xor(x0, temp);
    }
    areion_secure_wipe(temp, sizeof(temp));
}

static void areion256_inverse_permute_bs(uint64_t x0[8], uint64_t x1[8], const uint64_t rcs[15][8]) {
    uint64_t temp[8];
    size_t i;
    for (i = 0; i < 10; i += 2) {
        bs_copy(temp, x1);
        bs_mix_columns(temp);
        bs_xor(temp, rcs[9 - i]);
        bs_round_no_key(temp);
        bs_xor(x0, temp);
        bs_inv_final_round_no_key(x1);

        bs_copy(temp, x0);
        bs_mix_columns(temp);
        bs_xor(temp, rcs[8 - i]);
        bs_round_no_key(temp);
        bs_xor(x1, temp);
        bs_inv_final_round_no_key(x0);
    }
    areion_secure_wipe(temp, sizeof(temp));
}

static void areion512_round_bs12(
    uint64_t a[8], uint64_t b[8], uint64_t c[8], uint64_t d[8],
    uint64_t ac[8], uint64_t tmp[8], const uint64_t rc[8]) {
    size_t k;
    for (k = 0; k < 8; k++) {
        ac[k] = (a[k] & BS_LANE01_MASK) | ((c[k] & BS_LANE01_MASK) << 2U);
    }
    bs_sub_bytes(ac);
    bs_shift_rows(ac);
    bs_copy(tmp, ac);
    bs_mix_columns(tmp);
    for (k = 0; k < 8; k++) {
        a[k] = ac[k] & BS_LANE01_MASK;
        b[k] ^= tmp[k] & BS_LANE01_MASK;
        d[k] ^= (tmp[k] >> 2U) & BS_LANE01_MASK;
        c[k] = ((ac[k] >> 2U) & BS_LANE01_MASK) ^ (rc[k] & BS_LANE01_MASK);
    }
    bs_round_no_key(c);
}

static void areion512_permute_bs12(
    uint64_t x0[8], uint64_t x1[8], uint64_t x2[8], uint64_t x3[8],
    const uint64_t rcs[15][8]) {
    uint64_t ac[8], tmp[8];
    size_t i;
    for (i = 0; i < 12; i += 4) {
        areion512_round_bs12(x0, x1, x2, x3, ac, tmp, rcs[i + 0]);
        areion512_round_bs12(x1, x2, x3, x0, ac, tmp, rcs[i + 1]);
        areion512_round_bs12(x2, x3, x0, x1, ac, tmp, rcs[i + 2]);
        areion512_round_bs12(x3, x0, x1, x2, ac, tmp, rcs[i + 3]);
    }
    areion512_round_bs12(x0, x1, x2, x3, ac, tmp, rcs[12]);
    areion512_round_bs12(x1, x2, x3, x0, ac, tmp, rcs[13]);
    areion512_round_bs12(x2, x3, x0, x1, ac, tmp, rcs[14]);

    /* *x0, *x1, *x2, *x3 = *x3, *x0, *x1, *x2 */
    bs_copy(tmp, x3);
    bs_copy(x3, x2);
    bs_copy(x2, x1);
    bs_copy(x1, x0);
    bs_copy(x0, tmp);

    areion_secure_wipe(ac, sizeof(ac));
    areion_secure_wipe(tmp, sizeof(tmp));
}

static void areion512_round_bs4(
    uint64_t a[8], uint64_t b[8], uint64_t c[8], uint64_t d[8],
    uint64_t tmp[8], const uint64_t rc[8]) {
    bs_sub_bytes(a);
    bs_shift_rows(a);
    bs_copy(tmp, a);
    bs_mix_columns(tmp);
    bs_xor(b, tmp);

    bs_sub_bytes(c);
    bs_shift_rows(c);
    bs_copy(tmp, c);
    bs_mix_columns(tmp);
    bs_xor(d, tmp);

    bs_xor(c, rc);
    bs_round_no_key(c);
}

static void areion512_permute_bs4(
    uint64_t x0[8], uint64_t x1[8], uint64_t x2[8], uint64_t x3[8],
    const uint64_t rcs[15][8]) {
    uint64_t tmp[8];
    size_t i;
    for (i = 0; i < 12; i += 4) {
        areion512_round_bs4(x0, x1, x2, x3, tmp, rcs[i + 0]);
        areion512_round_bs4(x1, x2, x3, x0, tmp, rcs[i + 1]);
        areion512_round_bs4(x2, x3, x0, x1, tmp, rcs[i + 2]);
        areion512_round_bs4(x3, x0, x1, x2, tmp, rcs[i + 3]);
    }
    areion512_round_bs4(x0, x1, x2, x3, tmp, rcs[12]);
    areion512_round_bs4(x1, x2, x3, x0, tmp, rcs[13]);
    areion512_round_bs4(x2, x3, x0, x1, tmp, rcs[14]);

    bs_copy(tmp, x3);
    bs_copy(x3, x2);
    bs_copy(x2, x1);
    bs_copy(x1, x0);
    bs_copy(x0, tmp);

    areion_secure_wipe(tmp, sizeof(tmp));
}

static void areion512_inv_round_bs12(
    uint64_t a[8], uint64_t b[8], uint64_t c[8], uint64_t d[8],
    uint64_t ac[8], uint64_t tmp[8], const uint64_t rc[8]) {
    size_t k;
    bs_copy(tmp, a);
    bs_mix_columns(tmp);
    bs_xor(b, tmp);

    bs_inv_mix_columns(c);
    for (k = 0; k < 8; k++) {
        ac[k] = (a[k] & BS_LANE01_MASK) | ((c[k] & BS_LANE01_MASK) << 2U);
    }
    bs_inv_shift_rows(ac);
    bs_inv_sub_bytes(ac);
    for (k = 0; k < 8; k++) {
        a[k] = ac[k] & BS_LANE01_MASK;
        c[k] = ((ac[k] >> 2U) & BS_LANE01_MASK) ^ (rc[k] & BS_LANE01_MASK);
    }
    bs_copy(tmp, c);
    bs_mix_columns(tmp);
    bs_xor(d, tmp);
    bs_inv_final_round_no_key(c);
}

static void areion512_inverse_permute_bs12(
    uint64_t x0[8], uint64_t x1[8], uint64_t x2[8], uint64_t x3[8],
    const uint64_t rcs[15][8]) {
    uint64_t ac[8], tmp[8];
    size_t i;

    /* *x0, *x1, *x2, *x3 = *x1, *x2, *x3, *x0 */
    bs_copy(tmp, x0);
    bs_copy(x0, x1);
    bs_copy(x1, x2);
    bs_copy(x2, x3);
    bs_copy(x3, tmp);

    areion512_inv_round_bs12(x2, x3, x0, x1, ac, tmp, rcs[14]);
    areion512_inv_round_bs12(x1, x2, x3, x0, ac, tmp, rcs[13]);
    areion512_inv_round_bs12(x0, x1, x2, x3, ac, tmp, rcs[12]);

    for (i = 0; i < 12; i += 4) {
        areion512_inv_round_bs12(x3, x0, x1, x2, ac, tmp, rcs[11 - i]);
        areion512_inv_round_bs12(x2, x3, x0, x1, ac, tmp, rcs[10 - i]);
        areion512_inv_round_bs12(x1, x2, x3, x0, ac, tmp, rcs[9 - i]);
        areion512_inv_round_bs12(x0, x1, x2, x3, ac, tmp, rcs[8 - i]);
    }
    areion_secure_wipe(ac, sizeof(ac));
    areion_secure_wipe(tmp, sizeof(tmp));
}

static void areion512_inv_round_bs4(
    uint64_t a[8], uint64_t b[8], uint64_t c[8], uint64_t d[8],
    uint64_t tmp[8], const uint64_t rc[8]) {
    bs_copy(tmp, a);
    bs_mix_columns(tmp);
    bs_xor(b, tmp);
    bs_inv_final_round_no_key(a);

    bs_inv_mix_columns(c);
    bs_inv_final_round_no_key(c);
    bs_xor(c, rc);
    bs_copy(tmp, c);
    bs_mix_columns(tmp);
    bs_xor(d, tmp);
    bs_inv_final_round_no_key(c);
}

static void areion512_inverse_permute_bs4(
    uint64_t x0[8], uint64_t x1[8], uint64_t x2[8], uint64_t x3[8],
    const uint64_t rcs[15][8]) {
    uint64_t tmp[8];
    size_t i;

    bs_copy(tmp, x0);
    bs_copy(x0, x1);
    bs_copy(x1, x2);
    bs_copy(x2, x3);
    bs_copy(x3, tmp);

    areion512_inv_round_bs4(x2, x3, x0, x1, tmp, rcs[14]);
    areion512_inv_round_bs4(x1, x2, x3, x0, tmp, rcs[13]);
    areion512_inv_round_bs4(x0, x1, x2, x3, tmp, rcs[12]);

    for (i = 0; i < 12; i += 4) {
        areion512_inv_round_bs4(x3, x0, x1, x2, tmp, rcs[11 - i]);
        areion512_inv_round_bs4(x2, x3, x0, x1, tmp, rcs[10 - i]);
        areion512_inv_round_bs4(x1, x2, x3, x0, tmp, rcs[9 - i]);
        areion512_inv_round_bs4(x0, x1, x2, x3, tmp, rcs[8 - i]);
    }
    areion_secure_wipe(tmp, sizeof(tmp));
}

/* =========================================================================
 * Pure-C Software Entry Points
 * ========================================================================= */

static AREION_NOINLINE void permute256_purec_body(uint8_t state[32], const uint64_t rc[15][8], bool inv) {
    uint64_t x0[8], x1[8];
    AREION_OPAQUE_PTR(rc);
    bs_pack1(x0, &state[0]);
    bs_pack1(x1, &state[16]);
    if (!inv) {
        areion256_permute_bs(x0, x1, rc);
    } else {
        areion256_inverse_permute_bs(x0, x1, rc);
    }
    bs_unpack1(x0, &state[0]);
    bs_unpack1(x1, &state[16]);
    areion_secure_wipe(x0, sizeof(x0));
    areion_secure_wipe(x1, sizeof(x1));
}

void areion_permute256_purec(uint8_t state[32]) {
    permute256_purec_body(state, roundConstantsP1BS, false);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_inverse_permute256_purec(uint8_t state[32]) {
    permute256_purec_body(state, roundConstantsP1BS, true);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_permute256_p2_purec(uint8_t state[32]) {
    permute256_purec_body(state, roundConstantsP2BS, false);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_inverse_permute256_p2_purec(uint8_t state[32]) {
    permute256_purec_body(state, roundConstantsP2BS, true);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void permute512_purec_body(uint8_t state[64], const uint64_t rc[15][8], bool inv) {
    uint64_t x0[8], x1[8], x2[8], x3[8];
    AREION_OPAQUE_PTR(rc);
    bs_pack1(x0, &state[0]);
    bs_pack1(x1, &state[16]);
    bs_pack1(x2, &state[32]);
    bs_pack1(x3, &state[48]);
    if (!inv) {
        areion512_permute_bs12(x0, x1, x2, x3, rc);
    } else {
        areion512_inverse_permute_bs12(x0, x1, x2, x3, rc);
    }
    bs_unpack1(x0, &state[0]);
    bs_unpack1(x1, &state[16]);
    bs_unpack1(x2, &state[32]);
    bs_unpack1(x3, &state[48]);
    areion_secure_wipe(x0, sizeof(x0));
    areion_secure_wipe(x1, sizeof(x1));
    areion_secure_wipe(x2, sizeof(x2));
    areion_secure_wipe(x3, sizeof(x3));
}

void areion_permute512_purec(uint8_t state[64]) {
    permute512_purec_body(state, roundConstantsP1BS, false);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_inverse_permute512_purec(uint8_t state[64]) {
    permute512_purec_body(state, roundConstantsP1BS, true);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_permute512_p2_purec(uint8_t state[64]) {
    permute512_purec_body(state, roundConstantsP2BS, false);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_inverse_permute512_p2_purec(uint8_t state[64]) {
    permute512_purec_body(state, roundConstantsP2BS, true);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void dm256_purec_body(uint8_t out[32], const uint8_t in[32]) {
    uint8_t state[32];
    size_t i;
    AREION_OPAQUE_PTR(in);
    memcpy(state, in, 32);
    permute256_purec_body(state, roundConstantsP1BS, false);
    for (i = 0; i < 32; i++) {
        out[i] = (uint8_t)(state[i] ^ in[i]);
    }
    areion_secure_wipe(state, sizeof(state));
}

void areion_dm256_purec(uint8_t out[32], const uint8_t in[32]) {
    dm256_purec_body(out, in);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void dm512_purec_body(uint8_t out[32], const uint8_t in[64]) {
    uint8_t state[64];
    size_t i;
    AREION_OPAQUE_PTR(in);
    memcpy(state, in, 64);
    permute512_purec_body(state, roundConstantsP1BS, false);
    for (i = 0; i < 64; i++) {
        state[i] ^= in[i];
    }
    /* Words x2||x3||x6||x7||x8||x9||x12||x13: state[8:16] || state[24:32] || state[32:40] || state[48:56] */
    memcpy(&out[0], &state[8], 8);
    memcpy(&out[8], &state[24], 8);
    memcpy(&out[16], &state[32], 8);
    memcpy(&out[24], &state[48], 8);
    areion_secure_wipe(state, sizeof(state));
}

void areion_dm512_purec(uint8_t out[32], const uint8_t in[64]) {
    dm512_purec_body(out, in);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void soem256_purec_body(uint8_t out[32], const uint8_t key[64], const uint8_t in[32]) {
    uint8_t state1[32], state2[32], kcopy[64];
    uint64_t x0[8], x1[8];
    size_t i;
    AREION_OPAQUE_PTR(key);
    AREION_OPAQUE_PTR(in);
    memcpy(kcopy, key, 64);
    for (i = 0; i < 32; i += 8) {
        uint64_t m = areion_load_le64(&in[i]);
        uint64_t k1 = areion_load_le64(&kcopy[i]);
        uint64_t k2 = areion_load_le64(&kcopy[32 + i]);
        areion_store_le64(&state1[i], m ^ k1);
        areion_store_le64(&state2[i], m ^ k2);
    }
    bs_pack2(x0, &state1[0], &state2[0]);
    bs_pack2(x1, &state1[16], &state2[16]);
    areion256_permute_bs(x0, x1, roundConstantsP1P2BS);
    bs_unpack2(x0, &state1[0], &state2[0]);
    bs_unpack2(x1, &state1[16], &state2[16]);
    areion_compiler_barrier();
    for (i = 0; i < 32; i += 8) {
        uint64_t v1 = areion_load_le64(&state1[i]);
        uint64_t v2 = areion_load_le64(&state2[i]);
        uint64_t k1 = areion_load_le64(&kcopy[i]);
        uint64_t k2 = areion_load_le64(&kcopy[32 + i]);
        areion_store_le64(&out[i], v1 ^ v2 ^ k1 ^ k2);
    }
    areion_secure_wipe(x0, sizeof(x0));
    areion_secure_wipe(x1, sizeof(x1));
    areion_secure_wipe(state1, sizeof(state1));
    areion_secure_wipe(state2, sizeof(state2));
    areion_secure_wipe(kcopy, sizeof(kcopy));
}

void areion_soem256_purec(uint8_t out[32], const uint8_t key[64], const uint8_t in[32]) {
    soem256_purec_body(out, key, in);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void soem512_purec_body(uint8_t out[64], const uint8_t key[128], const uint8_t in[64]) {
    uint8_t state1[64], state2[64], kcopy[128];
    uint64_t x0[8], x1[8], x2[8], x3[8];
    size_t i;
    AREION_OPAQUE_PTR(key);
    AREION_OPAQUE_PTR(in);
    memcpy(kcopy, key, 128);
    for (i = 0; i < 64; i += 8) {
        uint64_t m = areion_load_le64(&in[i]);
        uint64_t k1 = areion_load_le64(&kcopy[i]);
        uint64_t k2 = areion_load_le64(&kcopy[64 + i]);
        areion_store_le64(&state1[i], m ^ k1);
        areion_store_le64(&state2[i], m ^ k2);
    }
    bs_pack2(x0, &state1[0], &state2[0]);
    bs_pack2(x1, &state1[16], &state2[16]);
    bs_pack2(x2, &state1[32], &state2[32]);
    bs_pack2(x3, &state1[48], &state2[48]);
    areion512_permute_bs12(x0, x1, x2, x3, roundConstantsP1P2BS);
    bs_unpack2(x0, &state1[0], &state2[0]);
    bs_unpack2(x1, &state1[16], &state2[16]);
    bs_unpack2(x2, &state1[32], &state2[32]);
    bs_unpack2(x3, &state1[48], &state2[48]);
    areion_compiler_barrier();
    for (i = 0; i < 64; i += 8) {
        uint64_t v1 = areion_load_le64(&state1[i]);
        uint64_t v2 = areion_load_le64(&state2[i]);
        uint64_t k1 = areion_load_le64(&kcopy[i]);
        uint64_t k2 = areion_load_le64(&kcopy[64 + i]);
        areion_store_le64(&out[i], v1 ^ v2 ^ k1 ^ k2);
    }
    areion_secure_wipe(x0, sizeof(x0));
    areion_secure_wipe(x1, sizeof(x1));
    areion_secure_wipe(x2, sizeof(x2));
    areion_secure_wipe(x3, sizeof(x3));
    areion_secure_wipe(state1, sizeof(state1));
    areion_secure_wipe(state2, sizeof(state2));
    areion_secure_wipe(kcopy, sizeof(kcopy));
}

void areion_soem512_purec(uint8_t out[64], const uint8_t key[128], const uint8_t in[64]) {
    soem512_purec_body(out, key, in);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void permute256x4_purec_body(
    uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32],
    const uint64_t rc[15][8], bool inv) {
    uint64_t x0[8], x1[8];
    AREION_OPAQUE_PTR(rc);
    bs_pack4(x0, &b0[0], &b1[0], &b2[0], &b3[0]);
    bs_pack4(x1, &b0[16], &b1[16], &b2[16], &b3[16]);
    if (!inv) {
        areion256_permute_bs(x0, x1, rc);
    } else {
        areion256_inverse_permute_bs(x0, x1, rc);
    }
    bs_unpack4(x0, &b0[0], &b1[0], &b2[0], &b3[0]);
    bs_unpack4(x1, &b0[16], &b1[16], &b2[16], &b3[16]);
    areion_secure_wipe(x0, sizeof(x0));
    areion_secure_wipe(x1, sizeof(x1));
}

void areion_permute256x4_purec(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    permute256x4_purec_body(b0, b1, b2, b3, roundConstantsP1BS, false);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_permute256_p2x4_purec(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    permute256x4_purec_body(b0, b1, b2, b3, roundConstantsP2BS, false);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_inverse_permute256x4_purec(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    permute256x4_purec_body(b0, b1, b2, b3, roundConstantsP1BS, true);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_inverse_permute256_p2x4_purec(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    permute256x4_purec_body(b0, b1, b2, b3, roundConstantsP2BS, true);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void permute512x4_purec_body(
    uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64],
    const uint64_t rc[15][8], bool inv) {
    uint64_t x0[8], x1[8], x2[8], x3[8];
    AREION_OPAQUE_PTR(rc);
    bs_pack4(x0, &b0[0], &b1[0], &b2[0], &b3[0]);
    bs_pack4(x1, &b0[16], &b1[16], &b2[16], &b3[16]);
    bs_pack4(x2, &b0[32], &b1[32], &b2[32], &b3[32]);
    bs_pack4(x3, &b0[48], &b1[48], &b2[48], &b3[48]);
    if (!inv) {
        areion512_permute_bs4(x0, x1, x2, x3, rc);
    } else {
        areion512_inverse_permute_bs4(x0, x1, x2, x3, rc);
    }
    bs_unpack4(x0, &b0[0], &b1[0], &b2[0], &b3[0]);
    bs_unpack4(x1, &b0[16], &b1[16], &b2[16], &b3[16]);
    bs_unpack4(x2, &b0[32], &b1[32], &b2[32], &b3[32]);
    bs_unpack4(x3, &b0[48], &b1[48], &b2[48], &b3[48]);
    areion_secure_wipe(x0, sizeof(x0));
    areion_secure_wipe(x1, sizeof(x1));
    areion_secure_wipe(x2, sizeof(x2));
    areion_secure_wipe(x3, sizeof(x3));
}

void areion_permute512x4_purec(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    permute512x4_purec_body(b0, b1, b2, b3, roundConstantsP1BS, false);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_permute512_p2x4_purec(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    permute512x4_purec_body(b0, b1, b2, b3, roundConstantsP2BS, false);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_inverse_permute512x4_purec(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    permute512x4_purec_body(b0, b1, b2, b3, roundConstantsP1BS, true);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_inverse_permute512_p2x4_purec(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    permute512x4_purec_body(b0, b1, b2, b3, roundConstantsP2BS, true);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void soem256x4_purec_body(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t inputs[4][32]) {
    uint8_t state1[4][32], state2[4][32];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(inputs);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            uint64_t m = areion_load_le64(&inputs[lane][i]);
            uint64_t k1 = areion_load_le64(&keys[lane][i]);
            uint64_t k2 = areion_load_le64(&keys[lane][32 + i]);
            areion_store_le64(&state1[lane][i], m ^ k1);
            areion_store_le64(&state2[lane][i], m ^ k2);
        }
    }
    permute256x4_purec_body(state1[0], state1[1], state1[2], state1[3], roundConstantsP1BS, false);
    permute256x4_purec_body(state2[0], state2[1], state2[2], state2[3], roundConstantsP2BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            uint64_t v1 = areion_load_le64(&state1[lane][i]);
            uint64_t v2 = areion_load_le64(&state2[lane][i]);
            uint64_t k1 = areion_load_le64(&keys[lane][i]);
            uint64_t k2 = areion_load_le64(&keys[lane][32 + i]);
            areion_store_le64(&state1[lane][i], v1 ^ v2 ^ k1 ^ k2);
        }
    }
    memcpy(out, state1, sizeof(state1));
    areion_secure_wipe(state1, sizeof(state1));
    areion_secure_wipe(state2, sizeof(state2));
}

void areion_soem256x4_purec(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t inputs[4][32]) {
    soem256x4_purec_body(out, keys, inputs);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void soem512x4_purec_body(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t inputs[4][64]) {
    uint8_t state1[4][64], state2[4][64];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(inputs);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            uint64_t m = areion_load_le64(&inputs[lane][i]);
            uint64_t k1 = areion_load_le64(&keys[lane][i]);
            uint64_t k2 = areion_load_le64(&keys[lane][64 + i]);
            areion_store_le64(&state1[lane][i], m ^ k1);
            areion_store_le64(&state2[lane][i], m ^ k2);
        }
    }
    permute512x4_purec_body(state1[0], state1[1], state1[2], state1[3], roundConstantsP1BS, false);
    permute512x4_purec_body(state2[0], state2[1], state2[2], state2[3], roundConstantsP2BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            uint64_t v1 = areion_load_le64(&state1[lane][i]);
            uint64_t v2 = areion_load_le64(&state2[lane][i]);
            uint64_t k1 = areion_load_le64(&keys[lane][i]);
            uint64_t k2 = areion_load_le64(&keys[lane][64 + i]);
            areion_store_le64(&state1[lane][i], v1 ^ v2 ^ k1 ^ k2);
        }
    }
    memcpy(out, state1, sizeof(state1));
    areion_secure_wipe(state1, sizeof(state1));
    areion_secure_wipe(state2, sizeof(state2));
}

void areion_soem512x4_purec(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t inputs[4][64]) {
    soem512x4_purec_body(out, keys, inputs);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

/* =========================================================================
 * Wide-Block Even-Mansour (EM / EM2) and Tweakable Even-Mansour (TEM / TEM2)
 * ========================================================================= */

static AREION_NOINLINE void em_encrypt256_purec_body(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]) {
    uint8_t state[32];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(m);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&m[i]) ^ areion_load_le64(&k[i]));
    }
    permute256_purec_body(state, roundConstantsP1BS, false);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&k[32 + i]));
    }
    memcpy(out, state, 32);
    areion_secure_wipe(state, sizeof(state));
}

void areion_em_encrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]) {
    em_encrypt256_purec_body(out, k, m);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em_decrypt256_purec_body(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]) {
    uint8_t state[32];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(c);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&c[i]) ^ areion_load_le64(&k[32 + i]));
    }
    permute256_purec_body(state, roundConstantsP1BS, true);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&k[i]));
    }
    memcpy(out, state, 32);
    areion_secure_wipe(state, sizeof(state));
}

void areion_em_decrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]) {
    em_decrypt256_purec_body(out, k, c);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em_encrypt512_purec_body(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]) {
    uint8_t state[64];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(m);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&m[i]) ^ areion_load_le64(&k[i]));
    }
    permute512_purec_body(state, roundConstantsP1BS, false);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&k[64 + i]));
    }
    memcpy(out, state, 64);
    areion_secure_wipe(state, sizeof(state));
}

void areion_em_encrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]) {
    em_encrypt512_purec_body(out, k, m);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em_decrypt512_purec_body(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]) {
    uint8_t state[64];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(c);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&c[i]) ^ areion_load_le64(&k[64 + i]));
    }
    permute512_purec_body(state, roundConstantsP1BS, true);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&k[i]));
    }
    memcpy(out, state, 64);
    areion_secure_wipe(state, sizeof(state));
}

void areion_em_decrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]) {
    em_decrypt512_purec_body(out, k, c);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em_encrypt256x4_purec_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]) {
    uint8_t states[4][32];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&msgs[lane][i]) ^ areion_load_le64(&keys[lane][i]));
        }
    }
    permute256x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&states[lane][i]) ^ areion_load_le64(&keys[lane][32 + i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(states, sizeof(states));
}

void areion_em_encrypt256x4_purec(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]) {
    em_encrypt256x4_purec_body(out, keys, msgs);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em_decrypt256x4_purec_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]) {
    uint8_t states[4][32];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&ct[lane][i]) ^ areion_load_le64(&keys[lane][32 + i]));
        }
    }
    permute256x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, true);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&states[lane][i]) ^ areion_load_le64(&keys[lane][i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(states, sizeof(states));
}

void areion_em_decrypt256x4_purec(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]) {
    em_decrypt256x4_purec_body(out, keys, ct);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em_encrypt512x4_purec_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]) {
    uint8_t states[4][64];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&msgs[lane][i]) ^ areion_load_le64(&keys[lane][i]));
        }
    }
    permute512x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&states[lane][i]) ^ areion_load_le64(&keys[lane][64 + i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(states, sizeof(states));
}

void areion_em_encrypt512x4_purec(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]) {
    em_encrypt512x4_purec_body(out, keys, msgs);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em_decrypt512x4_purec_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]) {
    uint8_t states[4][64];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&ct[lane][i]) ^ areion_load_le64(&keys[lane][64 + i]));
        }
    }
    permute512x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, true);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&states[lane][i]) ^ areion_load_le64(&keys[lane][i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(states, sizeof(states));
}

void areion_em_decrypt512x4_purec(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]) {
    em_decrypt512x4_purec_body(out, keys, ct);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_encrypt256_purec_body(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]) {
    uint8_t state[32];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(m);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&m[i]) ^ areion_load_le64(&k[i]));
    }
    permute256_purec_body(state, roundConstantsP1BS, false);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&k[32 + i]));
    }
    permute256_purec_body(state, roundConstantsP2BS, false);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&k[i]) ^ areion_load_le64(&k[32 + i]));
    }
    memcpy(out, state, 32);
    areion_secure_wipe(state, sizeof(state));
}

void areion_em2_encrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]) {
    em2_encrypt256_purec_body(out, k, m);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_decrypt256_purec_body(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]) {
    uint8_t state[32];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(c);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&c[i]) ^ areion_load_le64(&k[i]) ^ areion_load_le64(&k[32 + i]));
    }
    permute256_purec_body(state, roundConstantsP2BS, true);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&k[32 + i]));
    }
    permute256_purec_body(state, roundConstantsP1BS, true);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&k[i]));
    }
    memcpy(out, state, 32);
    areion_secure_wipe(state, sizeof(state));
}

void areion_em2_decrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]) {
    em2_decrypt256_purec_body(out, k, c);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_encrypt512_purec_body(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]) {
    uint8_t state[64];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(m);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&m[i]) ^ areion_load_le64(&k[i]));
    }
    permute512_purec_body(state, roundConstantsP1BS, false);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&k[64 + i]));
    }
    permute512_purec_body(state, roundConstantsP2BS, false);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&k[i]) ^ areion_load_le64(&k[64 + i]));
    }
    memcpy(out, state, 64);
    areion_secure_wipe(state, sizeof(state));
}

void areion_em2_encrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]) {
    em2_encrypt512_purec_body(out, k, m);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_decrypt512_purec_body(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]) {
    uint8_t state[64];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(c);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&c[i]) ^ areion_load_le64(&k[i]) ^ areion_load_le64(&k[64 + i]));
    }
    permute512_purec_body(state, roundConstantsP2BS, true);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&k[64 + i]));
    }
    permute512_purec_body(state, roundConstantsP1BS, true);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&k[i]));
    }
    memcpy(out, state, 64);
    areion_secure_wipe(state, sizeof(state));
}

void areion_em2_decrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]) {
    em2_decrypt512_purec_body(out, k, c);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_encrypt256x4_purec_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]) {
    uint8_t states[4][32];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&msgs[lane][i]) ^ areion_load_le64(&keys[lane][i]));
        }
    }
    permute256x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&states[lane][i]) ^ areion_load_le64(&keys[lane][32 + i]));
        }
    }
    permute256x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP2BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&states[lane][i]) ^ areion_load_le64(&keys[lane][i]) ^ areion_load_le64(&keys[lane][32 + i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(states, sizeof(states));
}

void areion_em2_encrypt256x4_purec(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]) {
    em2_encrypt256x4_purec_body(out, keys, msgs);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_decrypt256x4_purec_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]) {
    uint8_t states[4][32];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&ct[lane][i]) ^ areion_load_le64(&keys[lane][i]) ^ areion_load_le64(&keys[lane][32 + i]));
        }
    }
    permute256x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP2BS, true);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&states[lane][i]) ^ areion_load_le64(&keys[lane][32 + i]));
        }
    }
    permute256x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, true);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&states[lane][i]) ^ areion_load_le64(&keys[lane][i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(states, sizeof(states));
}

void areion_em2_decrypt256x4_purec(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]) {
    em2_decrypt256x4_purec_body(out, keys, ct);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_encrypt512x4_purec_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]) {
    uint8_t states[4][64];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&msgs[lane][i]) ^ areion_load_le64(&keys[lane][i]));
        }
    }
    permute512x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&states[lane][i]) ^ areion_load_le64(&keys[lane][64 + i]));
        }
    }
    permute512x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP2BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&states[lane][i]) ^ areion_load_le64(&keys[lane][i]) ^ areion_load_le64(&keys[lane][64 + i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(states, sizeof(states));
}

void areion_em2_encrypt512x4_purec(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]) {
    em2_encrypt512x4_purec_body(out, keys, msgs);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void em2_decrypt512x4_purec_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]) {
    uint8_t states[4][64];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&ct[lane][i]) ^ areion_load_le64(&keys[lane][i]) ^ areion_load_le64(&keys[lane][64 + i]));
        }
    }
    permute512x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP2BS, true);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&states[lane][i]) ^ areion_load_le64(&keys[lane][64 + i]));
        }
    }
    permute512x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, true);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(&states[lane][i], areion_load_le64(&states[lane][i]) ^ areion_load_le64(&keys[lane][i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(states, sizeof(states));
}

void areion_em2_decrypt512x4_purec(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]) {
    em2_decrypt512x4_purec_body(out, keys, ct);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_encrypt256_purec_body(
    uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]) {
    uint8_t w[32], state[32];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(m);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&w[i], areion_load_le64(&t[i]) ^ areion_load_le64(&k[32 + i]));
    }
    permute256_purec_body(w, roundConstantsP2BS, false);
    for (i = 0; i < 32; i += 8) {
        uint64_t wi = areion_load_le64(&w[i]) ^ areion_load_le64(&k[i]);
        areion_store_le64(&w[i], wi);
        areion_store_le64(&state[i], areion_load_le64(&m[i]) ^ wi);
    }
    permute256_purec_body(state, roundConstantsP1BS, false);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&w[i]));
    }
    memcpy(out, state, 32);
    areion_secure_wipe(w, sizeof(w));
    areion_secure_wipe(state, sizeof(state));
}

void areion_tem_encrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]) {
    tem_encrypt256_purec_body(out, k, t, m);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_decrypt256_purec_body(
    uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]) {
    uint8_t w[32], state[32];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(c);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&w[i], areion_load_le64(&t[i]) ^ areion_load_le64(&k[32 + i]));
    }
    permute256_purec_body(w, roundConstantsP2BS, false);
    for (i = 0; i < 32; i += 8) {
        uint64_t wi = areion_load_le64(&w[i]) ^ areion_load_le64(&k[i]);
        areion_store_le64(&w[i], wi);
        areion_store_le64(&state[i], areion_load_le64(&c[i]) ^ wi);
    }
    permute256_purec_body(state, roundConstantsP1BS, true);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&w[i]));
    }
    memcpy(out, state, 32);
    areion_secure_wipe(w, sizeof(w));
    areion_secure_wipe(state, sizeof(state));
}

void areion_tem_decrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]) {
    tem_decrypt256_purec_body(out, k, t, c);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_encrypt512_purec_body(
    uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]) {
    uint8_t w[64], state[64];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(m);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&w[i], areion_load_le64(&t[i]) ^ areion_load_le64(&k[64 + i]));
    }
    permute512_purec_body(w, roundConstantsP2BS, false);
    for (i = 0; i < 64; i += 8) {
        uint64_t wi = areion_load_le64(&w[i]) ^ areion_load_le64(&k[i]);
        areion_store_le64(&w[i], wi);
        areion_store_le64(&state[i], areion_load_le64(&m[i]) ^ wi);
    }
    permute512_purec_body(state, roundConstantsP1BS, false);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&w[i]));
    }
    memcpy(out, state, 64);
    areion_secure_wipe(w, sizeof(w));
    areion_secure_wipe(state, sizeof(state));
}

void areion_tem_encrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]) {
    tem_encrypt512_purec_body(out, k, t, m);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_decrypt512_purec_body(
    uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]) {
    uint8_t w[64], state[64];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(c);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&w[i], areion_load_le64(&t[i]) ^ areion_load_le64(&k[64 + i]));
    }
    permute512_purec_body(w, roundConstantsP2BS, false);
    for (i = 0; i < 64; i += 8) {
        uint64_t wi = areion_load_le64(&w[i]) ^ areion_load_le64(&k[i]);
        areion_store_le64(&w[i], wi);
        areion_store_le64(&state[i], areion_load_le64(&c[i]) ^ wi);
    }
    permute512_purec_body(state, roundConstantsP1BS, true);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&w[i]));
    }
    memcpy(out, state, 64);
    areion_secure_wipe(w, sizeof(w));
    areion_secure_wipe(state, sizeof(state));
}

void areion_tem_decrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]) {
    tem_decrypt512_purec_body(out, k, t, c);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_encrypt256x4_purec_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]) {
    uint8_t w[4][32], states[4][32];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(
                &w[lane][i],
                areion_load_le64(&tweaks[lane][i]) ^ areion_load_le64(&keys[lane][32 + i]));
        }
    }
    permute256x4_purec_body(w[0], w[1], w[2], w[3], roundConstantsP2BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            uint64_t wi = areion_load_le64(&w[lane][i]) ^ areion_load_le64(&keys[lane][i]);
            areion_store_le64(&w[lane][i], wi);
            areion_store_le64(&states[lane][i], areion_load_le64(&msgs[lane][i]) ^ wi);
        }
    }
    permute256x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&states[lane][i]) ^ areion_load_le64(&w[lane][i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(w, sizeof(w));
    areion_secure_wipe(states, sizeof(states));
}

void areion_tem_encrypt256x4_purec(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]) {
    tem_encrypt256x4_purec_body(out, keys, tweaks, msgs);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_decrypt256x4_purec_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]) {
    uint8_t w[4][32], states[4][32];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(
                &w[lane][i],
                areion_load_le64(&tweaks[lane][i]) ^ areion_load_le64(&keys[lane][32 + i]));
        }
    }
    permute256x4_purec_body(w[0], w[1], w[2], w[3], roundConstantsP2BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            uint64_t wi = areion_load_le64(&w[lane][i]) ^ areion_load_le64(&keys[lane][i]);
            areion_store_le64(&w[lane][i], wi);
            areion_store_le64(&states[lane][i], areion_load_le64(&ct[lane][i]) ^ wi);
        }
    }
    permute256x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, true);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&states[lane][i]) ^ areion_load_le64(&w[lane][i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(w, sizeof(w));
    areion_secure_wipe(states, sizeof(states));
}

void areion_tem_decrypt256x4_purec(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]) {
    tem_decrypt256x4_purec_body(out, keys, tweaks, ct);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_encrypt512x4_purec_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]) {
    uint8_t w[4][64], states[4][64];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(
                &w[lane][i],
                areion_load_le64(&tweaks[lane][i]) ^ areion_load_le64(&keys[lane][64 + i]));
        }
    }
    permute512x4_purec_body(w[0], w[1], w[2], w[3], roundConstantsP2BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            uint64_t wi = areion_load_le64(&w[lane][i]) ^ areion_load_le64(&keys[lane][i]);
            areion_store_le64(&w[lane][i], wi);
            areion_store_le64(&states[lane][i], areion_load_le64(&msgs[lane][i]) ^ wi);
        }
    }
    permute512x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&states[lane][i]) ^ areion_load_le64(&w[lane][i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(w, sizeof(w));
    areion_secure_wipe(states, sizeof(states));
}

void areion_tem_encrypt512x4_purec(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]) {
    tem_encrypt512x4_purec_body(out, keys, tweaks, msgs);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem_decrypt512x4_purec_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]) {
    uint8_t w[4][64], states[4][64];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(
                &w[lane][i],
                areion_load_le64(&tweaks[lane][i]) ^ areion_load_le64(&keys[lane][64 + i]));
        }
    }
    permute512x4_purec_body(w[0], w[1], w[2], w[3], roundConstantsP2BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            uint64_t wi = areion_load_le64(&w[lane][i]) ^ areion_load_le64(&keys[lane][i]);
            areion_store_le64(&w[lane][i], wi);
            areion_store_le64(&states[lane][i], areion_load_le64(&ct[lane][i]) ^ wi);
        }
    }
    permute512x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, true);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&states[lane][i]) ^ areion_load_le64(&w[lane][i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(w, sizeof(w));
    areion_secure_wipe(states, sizeof(states));
}

void areion_tem_decrypt512x4_purec(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]) {
    tem_decrypt512x4_purec_body(out, keys, tweaks, ct);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_encrypt256_purec_body(
    uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]) {
    uint8_t w1[32], w2[32], state[32];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(m);
    for (i = 0; i < 32; i += 8) {
        uint64_t ti = areion_load_le64(&t[i]);
        areion_store_le64(&w1[i], ti ^ areion_load_le64(&k[i]));
        areion_store_le64(&w2[i], ti ^ areion_load_le64(&k[32 + i]));
    }
    permute256_purec_body(w1, roundConstantsP1BS, false);
    permute256_purec_body(w2, roundConstantsP2BS, false);
    for (i = 0; i < 32; i += 8) {
        uint64_t w1i = areion_load_le64(&w1[i]) ^ areion_load_le64(&k[i]);
        uint64_t w2i = areion_load_le64(&w2[i]) ^ areion_load_le64(&k[32 + i]);
        areion_store_le64(&w1[i], w1i);
        areion_store_le64(&w2[i], w2i);
        areion_store_le64(&state[i], areion_load_le64(&m[i]) ^ w1i);
    }
    permute256_purec_body(state, roundConstantsP1BS, false);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&w2[i]));
    }
    permute256_purec_body(state, roundConstantsP2BS, false);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(
            &state[i],
            areion_load_le64(&state[i]) ^ areion_load_le64(&w1[i]) ^ areion_load_le64(&w2[i]));
    }
    memcpy(out, state, 32);
    areion_secure_wipe(w1, sizeof(w1));
    areion_secure_wipe(w2, sizeof(w2));
    areion_secure_wipe(state, sizeof(state));
}

void areion_tem2_encrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]) {
    tem2_encrypt256_purec_body(out, k, t, m);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_decrypt256_purec_body(
    uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]) {
    uint8_t w1[32], w2[32], state[32];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(c);
    for (i = 0; i < 32; i += 8) {
        uint64_t ti = areion_load_le64(&t[i]);
        areion_store_le64(&w1[i], ti ^ areion_load_le64(&k[i]));
        areion_store_le64(&w2[i], ti ^ areion_load_le64(&k[32 + i]));
    }
    permute256_purec_body(w1, roundConstantsP1BS, false);
    permute256_purec_body(w2, roundConstantsP2BS, false);
    for (i = 0; i < 32; i += 8) {
        uint64_t w1i = areion_load_le64(&w1[i]) ^ areion_load_le64(&k[i]);
        uint64_t w2i = areion_load_le64(&w2[i]) ^ areion_load_le64(&k[32 + i]);
        areion_store_le64(&w1[i], w1i);
        areion_store_le64(&w2[i], w2i);
        areion_store_le64(&state[i], areion_load_le64(&c[i]) ^ w1i ^ w2i);
    }
    permute256_purec_body(state, roundConstantsP2BS, true);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&w2[i]));
    }
    permute256_purec_body(state, roundConstantsP1BS, true);
    for (i = 0; i < 32; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&w1[i]));
    }
    memcpy(out, state, 32);
    areion_secure_wipe(w1, sizeof(w1));
    areion_secure_wipe(w2, sizeof(w2));
    areion_secure_wipe(state, sizeof(state));
}

void areion_tem2_decrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]) {
    tem2_decrypt256_purec_body(out, k, t, c);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_encrypt512_purec_body(
    uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]) {
    uint8_t w1[64], w2[64], state[64];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(m);
    for (i = 0; i < 64; i += 8) {
        uint64_t ti = areion_load_le64(&t[i]);
        areion_store_le64(&w1[i], ti ^ areion_load_le64(&k[i]));
        areion_store_le64(&w2[i], ti ^ areion_load_le64(&k[64 + i]));
    }
    permute512_purec_body(w1, roundConstantsP1BS, false);
    permute512_purec_body(w2, roundConstantsP2BS, false);
    for (i = 0; i < 64; i += 8) {
        uint64_t w1i = areion_load_le64(&w1[i]) ^ areion_load_le64(&k[i]);
        uint64_t w2i = areion_load_le64(&w2[i]) ^ areion_load_le64(&k[64 + i]);
        areion_store_le64(&w1[i], w1i);
        areion_store_le64(&w2[i], w2i);
        areion_store_le64(&state[i], areion_load_le64(&m[i]) ^ w1i);
    }
    permute512_purec_body(state, roundConstantsP1BS, false);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&w2[i]));
    }
    permute512_purec_body(state, roundConstantsP2BS, false);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(
            &state[i],
            areion_load_le64(&state[i]) ^ areion_load_le64(&w1[i]) ^ areion_load_le64(&w2[i]));
    }
    memcpy(out, state, 64);
    areion_secure_wipe(w1, sizeof(w1));
    areion_secure_wipe(w2, sizeof(w2));
    areion_secure_wipe(state, sizeof(state));
}

void areion_tem2_encrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]) {
    tem2_encrypt512_purec_body(out, k, t, m);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_decrypt512_purec_body(
    uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]) {
    uint8_t w1[64], w2[64], state[64];
    size_t i;
    AREION_OPAQUE_PTR(k);
    AREION_OPAQUE_PTR(t);
    AREION_OPAQUE_PTR(c);
    for (i = 0; i < 64; i += 8) {
        uint64_t ti = areion_load_le64(&t[i]);
        areion_store_le64(&w1[i], ti ^ areion_load_le64(&k[i]));
        areion_store_le64(&w2[i], ti ^ areion_load_le64(&k[64 + i]));
    }
    permute512_purec_body(w1, roundConstantsP1BS, false);
    permute512_purec_body(w2, roundConstantsP2BS, false);
    for (i = 0; i < 64; i += 8) {
        uint64_t w1i = areion_load_le64(&w1[i]) ^ areion_load_le64(&k[i]);
        uint64_t w2i = areion_load_le64(&w2[i]) ^ areion_load_le64(&k[64 + i]);
        areion_store_le64(&w1[i], w1i);
        areion_store_le64(&w2[i], w2i);
        areion_store_le64(&state[i], areion_load_le64(&c[i]) ^ w1i ^ w2i);
    }
    permute512_purec_body(state, roundConstantsP2BS, true);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&w2[i]));
    }
    permute512_purec_body(state, roundConstantsP1BS, true);
    for (i = 0; i < 64; i += 8) {
        areion_store_le64(&state[i], areion_load_le64(&state[i]) ^ areion_load_le64(&w1[i]));
    }
    memcpy(out, state, 64);
    areion_secure_wipe(w1, sizeof(w1));
    areion_secure_wipe(w2, sizeof(w2));
    areion_secure_wipe(state, sizeof(state));
}

void areion_tem2_decrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]) {
    tem2_decrypt512_purec_body(out, k, t, c);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_encrypt256x4_purec_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]) {
    uint8_t w1[4][32], w2[4][32], states[4][32];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            uint64_t ti = areion_load_le64(&tweaks[lane][i]);
            areion_store_le64(&w1[lane][i], ti ^ areion_load_le64(&keys[lane][i]));
            areion_store_le64(&w2[lane][i], ti ^ areion_load_le64(&keys[lane][32 + i]));
        }
    }
    permute256x4_purec_body(w1[0], w1[1], w1[2], w1[3], roundConstantsP1BS, false);
    permute256x4_purec_body(w2[0], w2[1], w2[2], w2[3], roundConstantsP2BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            uint64_t w1i = areion_load_le64(&w1[lane][i]) ^ areion_load_le64(&keys[lane][i]);
            uint64_t w2i = areion_load_le64(&w2[lane][i]) ^ areion_load_le64(&keys[lane][32 + i]);
            areion_store_le64(&w1[lane][i], w1i);
            areion_store_le64(&w2[lane][i], w2i);
            areion_store_le64(&states[lane][i], areion_load_le64(&msgs[lane][i]) ^ w1i);
        }
    }
    permute256x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&states[lane][i]) ^ areion_load_le64(&w2[lane][i]));
        }
    }
    permute256x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP2BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&states[lane][i]) ^ areion_load_le64(&w1[lane][i]) ^ areion_load_le64(&w2[lane][i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(w1, sizeof(w1));
    areion_secure_wipe(w2, sizeof(w2));
    areion_secure_wipe(states, sizeof(states));
}

void areion_tem2_encrypt256x4_purec(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]) {
    tem2_encrypt256x4_purec_body(out, keys, tweaks, msgs);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_decrypt256x4_purec_body(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]) {
    uint8_t w1[4][32], w2[4][32], states[4][32];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            uint64_t ti = areion_load_le64(&tweaks[lane][i]);
            areion_store_le64(&w1[lane][i], ti ^ areion_load_le64(&keys[lane][i]));
            areion_store_le64(&w2[lane][i], ti ^ areion_load_le64(&keys[lane][32 + i]));
        }
    }
    permute256x4_purec_body(w1[0], w1[1], w1[2], w1[3], roundConstantsP1BS, false);
    permute256x4_purec_body(w2[0], w2[1], w2[2], w2[3], roundConstantsP2BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            uint64_t w1i = areion_load_le64(&w1[lane][i]) ^ areion_load_le64(&keys[lane][i]);
            uint64_t w2i = areion_load_le64(&w2[lane][i]) ^ areion_load_le64(&keys[lane][32 + i]);
            areion_store_le64(&w1[lane][i], w1i);
            areion_store_le64(&w2[lane][i], w2i);
            areion_store_le64(&states[lane][i], areion_load_le64(&ct[lane][i]) ^ w1i ^ w2i);
        }
    }
    permute256x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP2BS, true);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&states[lane][i]) ^ areion_load_le64(&w2[lane][i]));
        }
    }
    permute256x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, true);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 32; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&states[lane][i]) ^ areion_load_le64(&w1[lane][i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(w1, sizeof(w1));
    areion_secure_wipe(w2, sizeof(w2));
    areion_secure_wipe(states, sizeof(states));
}

void areion_tem2_decrypt256x4_purec(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]) {
    tem2_decrypt256x4_purec_body(out, keys, tweaks, ct);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_encrypt512x4_purec_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]) {
    uint8_t w1[4][64], w2[4][64], states[4][64];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(msgs);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            uint64_t ti = areion_load_le64(&tweaks[lane][i]);
            areion_store_le64(&w1[lane][i], ti ^ areion_load_le64(&keys[lane][i]));
            areion_store_le64(&w2[lane][i], ti ^ areion_load_le64(&keys[lane][64 + i]));
        }
    }
    permute512x4_purec_body(w1[0], w1[1], w1[2], w1[3], roundConstantsP1BS, false);
    permute512x4_purec_body(w2[0], w2[1], w2[2], w2[3], roundConstantsP2BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            uint64_t w1i = areion_load_le64(&w1[lane][i]) ^ areion_load_le64(&keys[lane][i]);
            uint64_t w2i = areion_load_le64(&w2[lane][i]) ^ areion_load_le64(&keys[lane][64 + i]);
            areion_store_le64(&w1[lane][i], w1i);
            areion_store_le64(&w2[lane][i], w2i);
            areion_store_le64(&states[lane][i], areion_load_le64(&msgs[lane][i]) ^ w1i);
        }
    }
    permute512x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&states[lane][i]) ^ areion_load_le64(&w2[lane][i]));
        }
    }
    permute512x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP2BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&states[lane][i]) ^ areion_load_le64(&w1[lane][i]) ^ areion_load_le64(&w2[lane][i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(w1, sizeof(w1));
    areion_secure_wipe(w2, sizeof(w2));
    areion_secure_wipe(states, sizeof(states));
}

void areion_tem2_encrypt512x4_purec(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]) {
    tem2_encrypt512x4_purec_body(out, keys, tweaks, msgs);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void tem2_decrypt512x4_purec_body(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]) {
    uint8_t w1[4][64], w2[4][64], states[4][64];
    size_t lane, i;
    AREION_OPAQUE_PTR(keys);
    AREION_OPAQUE_PTR(tweaks);
    AREION_OPAQUE_PTR(ct);
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            uint64_t ti = areion_load_le64(&tweaks[lane][i]);
            areion_store_le64(&w1[lane][i], ti ^ areion_load_le64(&keys[lane][i]));
            areion_store_le64(&w2[lane][i], ti ^ areion_load_le64(&keys[lane][64 + i]));
        }
    }
    permute512x4_purec_body(w1[0], w1[1], w1[2], w1[3], roundConstantsP1BS, false);
    permute512x4_purec_body(w2[0], w2[1], w2[2], w2[3], roundConstantsP2BS, false);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            uint64_t w1i = areion_load_le64(&w1[lane][i]) ^ areion_load_le64(&keys[lane][i]);
            uint64_t w2i = areion_load_le64(&w2[lane][i]) ^ areion_load_le64(&keys[lane][64 + i]);
            areion_store_le64(&w1[lane][i], w1i);
            areion_store_le64(&w2[lane][i], w2i);
            areion_store_le64(&states[lane][i], areion_load_le64(&ct[lane][i]) ^ w1i ^ w2i);
        }
    }
    permute512x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP2BS, true);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&states[lane][i]) ^ areion_load_le64(&w2[lane][i]));
        }
    }
    permute512x4_purec_body(states[0], states[1], states[2], states[3], roundConstantsP1BS, true);
    areion_compiler_barrier();
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i += 8) {
            areion_store_le64(
                &states[lane][i],
                areion_load_le64(&states[lane][i]) ^ areion_load_le64(&w1[lane][i]));
        }
    }
    memcpy(out, states, sizeof(states));
    areion_secure_wipe(w1, sizeof(w1));
    areion_secure_wipe(w2, sizeof(w2));
    areion_secure_wipe(states, sizeof(states));
}

void areion_tem2_decrypt512x4_purec(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]) {
    tem2_decrypt512x4_purec_body(out, keys, tweaks, ct);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

/* =========================================================================
 * AES Round Primitives & AES-128 Block Helpers
 * ========================================================================= */

static inline void words4_to_bytes(const uint32_t in[4], uint8_t out[16]) {
    areion_store_le32(&out[0], in[0]);
    areion_store_le32(&out[4], in[1]);
    areion_store_le32(&out[8], in[2]);
    areion_store_le32(&out[12], in[3]);
}

static inline void bytes_to_words4(const uint8_t in[16], uint32_t out[4]) {
    out[0] = areion_load_le32(&in[0]);
    out[1] = areion_load_le32(&in[4]);
    out[2] = areion_load_le32(&in[8]);
    out[3] = areion_load_le32(&in[12]);
}

static AREION_NOINLINE void round_words_purec_body(const uint32_t in[4], uint32_t out[4], unsigned int mode) {
    uint8_t blk[16];
    uint64_t q[8];
    AREION_OPAQUE_PTR(in);
    words4_to_bytes(in, blk);
    bs_pack1(q, blk);
    if (mode == 0U) {
        bs_round_no_key(q);
    } else if (mode == 1U) {
        bs_final_round_no_key(q);
    } else if (mode == 2U) {
        bs_inv_mix_columns(q);
        bs_inv_shift_rows(q);
        bs_inv_sub_bytes(q);
    } else if (mode == 3U) {
        bs_inv_shift_rows(q);
        bs_inv_sub_bytes(q);
    } else {
        bs_inv_mix_columns(q);
    }
    bs_unpack1(q, blk);
    bytes_to_words4(blk, out);
    areion_secure_wipe(q, sizeof(q));
    areion_secure_wipe(blk, sizeof(blk));
}

void areion_round_purec(const uint32_t in[4], uint32_t out[4]) {
    round_words_purec_body(in, out, 0U);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_final_round_purec(const uint32_t in[4], uint32_t out[4]) {
    round_words_purec_body(in, out, 1U);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_inv_round_purec(const uint32_t in[4], uint32_t out[4]) {
    round_words_purec_body(in, out, 2U);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_inv_final_round_purec(const uint32_t in[4], uint32_t out[4]) {
    round_words_purec_body(in, out, 3U);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_inv_mix_columns_purec(const uint32_t in[4], uint32_t out[4]) {
    round_words_purec_body(in, out, 4U);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void round4_purec_body(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16], bool is_final) {
    uint64_t q[8];
    bs_pack4(q, b0, b1, b2, b3);
    if (!is_final) {
        bs_round_no_key(q);
    } else {
        bs_final_round_no_key(q);
    }
    bs_unpack4(q, b0, b1, b2, b3);
    areion_secure_wipe(q, sizeof(q));
}

void areion_round4_purec(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16]) {
    round4_purec_body(b0, b1, b2, b3, false);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_final_round4_purec(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16]) {
    round4_purec_body(b0, b1, b2, b3, true);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void aes_round_purec_body(uint8_t block[16], const uint8_t rk[16], bool is_final) {
    uint64_t q[8];
    uint8_t tmp[16];
    size_t i;
    AREION_OPAQUE_PTR(rk);
    bs_pack1(q, block);
    if (!is_final) {
        bs_round_no_key(q);
    } else {
        bs_final_round_no_key(q);
    }
    bs_unpack1(q, tmp);
    for (i = 0; i < 16; i++) {
        block[i] = (uint8_t)(tmp[i] ^ rk[i]);
    }
    areion_secure_wipe(tmp, sizeof(tmp));
    areion_secure_wipe(q, sizeof(q));
}

void areion_aes_round_purec(uint8_t block[16], const uint8_t rk[16]) {
    aes_round_purec_body(block, rk, false);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_aes_final_round_purec(uint8_t block[16], const uint8_t rk[16]) {
    aes_round_purec_body(block, rk, true);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void aes_round4_purec_body(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16],
    bool is_final) {
    uint64_t q[8];
    uint8_t t0[16], t1[16], t2[16], t3[16];
    size_t i;
    AREION_OPAQUE_PTR(rk0);
    AREION_OPAQUE_PTR(rk1);
    AREION_OPAQUE_PTR(rk2);
    AREION_OPAQUE_PTR(rk3);
    bs_pack4(q, b0, b1, b2, b3);
    if (!is_final) {
        bs_round_no_key(q);
    } else {
        bs_final_round_no_key(q);
    }
    bs_unpack4(q, t0, t1, t2, t3);
    for (i = 0; i < 16; i++) {
        b0[i] = (uint8_t)(t0[i] ^ rk0[i]);
        b1[i] = (uint8_t)(t1[i] ^ rk1[i]);
        b2[i] = (uint8_t)(t2[i] ^ rk2[i]);
        b3[i] = (uint8_t)(t3[i] ^ rk3[i]);
    }
    areion_secure_wipe(t0, sizeof(t0));
    areion_secure_wipe(t1, sizeof(t1));
    areion_secure_wipe(t2, sizeof(t2));
    areion_secure_wipe(t3, sizeof(t3));
    areion_secure_wipe(q, sizeof(q));
}

void areion_aes_round4_purec(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]) {
    aes_round4_purec_body(b0, b1, b2, b3, rk0, rk1, rk2, rk3, false);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_aes_final_round4_purec(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]) {
    aes_round4_purec_body(b0, b1, b2, b3, rk0, rk1, rk2, rk3, true);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static uint32_t bs_sub_word(uint32_t rot) {
    uint64_t r = (uint64_t)rot;
    uint64_t w[8];
    uint64_t out;
    w[0] = r & BS_BYTE0_MASK;
    w[1] = (r >> 1U) & BS_BYTE0_MASK;
    w[2] = (r >> 2U) & BS_BYTE0_MASK;
    w[3] = (r >> 3U) & BS_BYTE0_MASK;
    w[4] = (r >> 4U) & BS_BYTE0_MASK;
    w[5] = (r >> 5U) & BS_BYTE0_MASK;
    w[6] = (r >> 6U) & BS_BYTE0_MASK;
    w[7] = (r >> 7U) & BS_BYTE0_MASK;
    bs_sub_bytes(w);
    out = (w[0] & BS_BYTE0_MASK) |
          ((w[1] & BS_BYTE0_MASK) << 1U) |
          ((w[2] & BS_BYTE0_MASK) << 2U) |
          ((w[3] & BS_BYTE0_MASK) << 3U) |
          ((w[4] & BS_BYTE0_MASK) << 4U) |
          ((w[5] & BS_BYTE0_MASK) << 5U) |
          ((w[6] & BS_BYTE0_MASK) << 6U) |
          ((w[7] & BS_BYTE0_MASK) << 7U);
    areion_secure_wipe(w, sizeof(w));
    return (uint32_t)out;
}

static AREION_NOINLINE void expand_key128_purec_body(const uint8_t key[16], uint8_t rk[11][16]) {
    uint32_t w[44];
    size_t i, r, j;
    AREION_OPAQUE_PTR(key);
    for (i = 0; i < 4; i++) {
        w[i] = areion_load_le32(&key[i * 4]);
    }
    for (i = 4; i < 44; i++) {
        uint32_t temp = w[i - 1];
        if ((i & 3U) == 0U) {
            uint32_t rot = (temp >> 8U) | (temp << 24U);
            temp = bs_sub_word(rot) ^ (uint32_t)areion_aes_rcon[(i / 4) - 1];
        }
        w[i] = w[i - 4] ^ temp;
    }
    for (r = 0; r < 11; r++) {
        for (j = 0; j < 4; j++) {
            areion_store_le32(&rk[r][j * 4], w[r * 4 + j]);
        }
    }
    areion_secure_wipe(w, sizeof(w));
}

void areion_expand_key128_purec(const uint8_t key[16], uint8_t rk[11][16]) {
    expand_key128_purec_body(key, rk);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void aes128_encrypt_block_purec_body(
    uint8_t dst[16], const uint8_t src[16], const uint8_t rk[11][16]) {
    uint8_t state[16];
    uint64_t q[8], k14[8], k58[8], k910[8];
    unsigned int lane;
    size_t i, k;
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(rk);
    for (i = 0; i < 16; i++) {
        state[i] = (uint8_t)(src[i] ^ rk[0][i]);
    }
    bs_pack1(q, state);
    bs_pack4(k14, rk[1], rk[2], rk[3], rk[4]);
    bs_pack4(k58, rk[5], rk[6], rk[7], rk[8]);
    bs_pack2(k910, rk[9], rk[10]);

    for (lane = 0; lane < 4U; lane++) {
        bs_round_no_key(q);
        for (k = 0; k < 8; k++) {
            q[k] ^= (k14[k] >> lane) & BS_LANE0_MASK;
        }
    }
    for (lane = 0; lane < 4U; lane++) {
        bs_round_no_key(q);
        for (k = 0; k < 8; k++) {
            q[k] ^= (k58[k] >> lane) & BS_LANE0_MASK;
        }
    }
    bs_round_no_key(q);
    for (k = 0; k < 8; k++) {
        q[k] ^= k910[k] & BS_LANE0_MASK;
    }
    bs_final_round_no_key(q);
    for (k = 0; k < 8; k++) {
        q[k] ^= (k910[k] >> 1U) & BS_LANE0_MASK;
    }
    bs_unpack1(q, dst);
    areion_secure_wipe(state, sizeof(state));
    areion_secure_wipe(q, sizeof(q));
    areion_secure_wipe(k14, sizeof(k14));
    areion_secure_wipe(k58, sizeof(k58));
    areion_secure_wipe(k910, sizeof(k910));
}

void areion_aes128_encrypt_block_purec(uint8_t dst[16], const uint8_t src[16], const uint8_t rk[11][16]) {
    aes128_encrypt_block_purec_body(dst, src, rk);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void aes128_encrypt4_blocks_purec_body(
    uint8_t dst[4][16], const uint8_t src[4][16], const uint8_t rk[11][16]) {
    uint8_t b[4][16];
    uint64_t q[8], k14[8], k58[8], k910[8];
    unsigned int lane;
    size_t i, k;
    AREION_OPAQUE_PTR(src);
    AREION_OPAQUE_PTR(rk);
    for (lane = 0; lane < 4U; lane++) {
        for (i = 0; i < 16; i++) {
            b[lane][i] = (uint8_t)(src[lane][i] ^ rk[0][i]);
        }
    }
    bs_pack4(q, b[0], b[1], b[2], b[3]);
    bs_pack4(k14, rk[1], rk[2], rk[3], rk[4]);
    bs_pack4(k58, rk[5], rk[6], rk[7], rk[8]);
    bs_pack2(k910, rk[9], rk[10]);

    for (lane = 0; lane < 4U; lane++) {
        bs_round_no_key(q);
        for (k = 0; k < 8; k++) {
            q[k] ^= ((k14[k] >> lane) & BS_LANE0_MASK) * 0xfULL;
        }
    }
    for (lane = 0; lane < 4U; lane++) {
        bs_round_no_key(q);
        for (k = 0; k < 8; k++) {
            q[k] ^= ((k58[k] >> lane) & BS_LANE0_MASK) * 0xfULL;
        }
    }
    bs_round_no_key(q);
    for (k = 0; k < 8; k++) {
        q[k] ^= (k910[k] & BS_LANE0_MASK) * 0xfULL;
    }
    bs_final_round_no_key(q);
    for (k = 0; k < 8; k++) {
        q[k] ^= ((k910[k] >> 1U) & BS_LANE0_MASK) * 0xfULL;
    }
    bs_unpack4(q, dst[0], dst[1], dst[2], dst[3]);
    areion_secure_wipe(b, sizeof(b));
    areion_secure_wipe(q, sizeof(q));
    areion_secure_wipe(k14, sizeof(k14));
    areion_secure_wipe(k58, sizeof(k58));
    areion_secure_wipe(k910, sizeof(k910));
}

void areion_aes128_encrypt4_blocks_purec(
    uint8_t dst[4][16], const uint8_t src[4][16], const uint8_t rk[11][16]) {
    aes128_encrypt4_blocks_purec_body(dst, src, rk);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

/* =========================================================================
 * Architecture-Independent Public Helpers
 * ========================================================================= */

static AREION_NOINLINE void permute256_words_body(uint32_t state[8], bool inv) {
    uint8_t buf[32];
    size_t i;
    for (i = 0; i < 8; i++) {
        areion_store_le32(&buf[i * 4], state[i]);
    }
    if (!inv) {
        areion_permute256(buf);
    } else {
        areion_inverse_permute256(buf);
    }
    for (i = 0; i < 8; i++) {
        state[i] = areion_load_le32(&buf[i * 4]);
    }
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_permute256_words(uint32_t state[8]) {
    permute256_words_body(state, false);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_inverse_permute256_words(uint32_t state[8]) {
    permute256_words_body(state, true);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void permute512_words_body(uint32_t state[16], bool inv) {
    uint8_t buf[64];
    size_t i;
    for (i = 0; i < 16; i++) {
        areion_store_le32(&buf[i * 4], state[i]);
    }
    if (!inv) {
        areion_permute512(buf);
    } else {
        areion_inverse_permute512(buf);
    }
    for (i = 0; i < 16; i++) {
        state[i] = areion_load_le32(&buf[i * 4]);
    }
    areion_secure_wipe(buf, sizeof(buf));
}

void areion_permute512_words(uint32_t state[16]) {
    permute512_words_body(state, false);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_inverse_permute512_words(uint32_t state[16]) {
    permute512_words_body(state, true);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_round_hw(uint8_t block[16]) {
    static const uint8_t zero_rk[16] = {0};
    areion_aes_round_hw(block, zero_rk);
}

void areion_final_round_hw(uint8_t block[16]) {
    static const uint8_t zero_rk[16] = {0};
    areion_aes_final_round_hw(block, zero_rk);
}

void areion_aes128_round(uint8_t block[16], const uint8_t rk[16]) {
    areion_aes_round_hw(block, rk);
}

void areion_aes128_final_round(uint8_t block[16], const uint8_t rk[16]) {
    areion_aes_final_round_hw(block, rk);
}

void areion_aes128_round4(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]) {
    areion_aes_round4_hw(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
}

void areion_aes128_final_round4(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]) {
    areion_aes_final_round4_hw(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
}

static AREION_NOINLINE void xor_block_body(uint8_t dst[16], const uint8_t src[16]) {
    size_t i;
    AREION_OPAQUE_PTR(src);
    for (i = 0; i < 16; i++) {
        dst[i] ^= src[i];
    }
}

void areion_xor_block(uint8_t dst[16], const uint8_t src[16]) {
    xor_block_body(dst, src);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE void xor_block4_body(
    uint8_t d0[16], uint8_t d1[16], uint8_t d2[16], uint8_t d3[16],
    const uint8_t s0[16], const uint8_t s1[16], const uint8_t s2[16], const uint8_t s3[16]) {
    size_t i;
    AREION_OPAQUE_PTR(s0);
    AREION_OPAQUE_PTR(s1);
    AREION_OPAQUE_PTR(s2);
    AREION_OPAQUE_PTR(s3);
    for (i = 0; i < 16; i++) {
        d0[i] ^= s0[i];
        d1[i] ^= s1[i];
        d2[i] ^= s2[i];
        d3[i] ^= s3[i];
    }
}

void areion_xor_block4(
    uint8_t d0[16], uint8_t d1[16], uint8_t d2[16], uint8_t d3[16],
    const uint8_t s0[16], const uint8_t s1[16], const uint8_t s2[16], const uint8_t s3[16]) {
    xor_block4_body(d0, d1, d2, d3, s0, s1, s2, s3);
    areion_wipe_software_stack();
    areion_clobber_scratch_gprs();
}

void areion_wipe_expanded_key128(uint8_t rk[11][16]) {
    areion_secure_wipe(rk, (size_t)11U * 16U);
}
