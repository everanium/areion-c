/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#ifndef AREION_SOA_H
#define AREION_SOA_H

#include "areion_internal.h"

static inline void unpack256x4SoA(
    const uint8_t b0[64],
    const uint8_t b1[64],
    uint8_t s0[32],
    uint8_t s1[32],
    uint8_t s2[32],
    uint8_t s3[32]) {
    memcpy(&s0[0], &b0[0], 16);
    memcpy(&s1[0], &b0[16], 16);
    memcpy(&s2[0], &b0[32], 16);
    memcpy(&s3[0], &b0[48], 16);
    memcpy(&s0[16], &b1[0], 16);
    memcpy(&s1[16], &b1[16], 16);
    memcpy(&s2[16], &b1[32], 16);
    memcpy(&s3[16], &b1[48], 16);
}

static inline void unpack512x4SoA(
    const uint8_t b0[64],
    const uint8_t b1[64],
    const uint8_t b2[64],
    const uint8_t b3[64],
    uint8_t s0[64],
    uint8_t s1[64],
    uint8_t s2[64],
    uint8_t s3[64]) {
    memcpy(&s0[0], &b0[0], 16);
    memcpy(&s1[0], &b0[16], 16);
    memcpy(&s2[0], &b0[32], 16);
    memcpy(&s3[0], &b0[48], 16);
    memcpy(&s0[16], &b1[0], 16);
    memcpy(&s1[16], &b1[16], 16);
    memcpy(&s2[16], &b1[32], 16);
    memcpy(&s3[16], &b1[48], 16);
    memcpy(&s0[32], &b2[0], 16);
    memcpy(&s1[32], &b2[16], 16);
    memcpy(&s2[32], &b2[32], 16);
    memcpy(&s3[32], &b2[48], 16);
    memcpy(&s0[48], &b3[0], 16);
    memcpy(&s1[48], &b3[16], 16);
    memcpy(&s2[48], &b3[32], 16);
    memcpy(&s3[48], &b3[48], 16);
}

static inline void pack256x4SoAInto(
    const uint8_t s0[32],
    const uint8_t s1[32],
    const uint8_t s2[32],
    const uint8_t s3[32],
    uint8_t b0[64],
    uint8_t b1[64]) {
    memcpy(&b0[0], &s0[0], 16);
    memcpy(&b0[16], &s1[0], 16);
    memcpy(&b0[32], &s2[0], 16);
    memcpy(&b0[48], &s3[0], 16);
    memcpy(&b1[0], &s0[16], 16);
    memcpy(&b1[16], &s1[16], 16);
    memcpy(&b1[32], &s2[16], 16);
    memcpy(&b1[48], &s3[16], 16);
}

static inline void pack512x4SoAInto(
    const uint8_t s0[64],
    const uint8_t s1[64],
    const uint8_t s2[64],
    const uint8_t s3[64],
    uint8_t b0[64],
    uint8_t b1[64],
    uint8_t b2[64],
    uint8_t b3[64]) {
    memcpy(&b0[0], &s0[0], 16);
    memcpy(&b0[16], &s1[0], 16);
    memcpy(&b0[32], &s2[0], 16);
    memcpy(&b0[48], &s3[0], 16);
    memcpy(&b1[0], &s0[16], 16);
    memcpy(&b1[16], &s1[16], 16);
    memcpy(&b1[32], &s2[16], 16);
    memcpy(&b1[48], &s3[16], 16);
    memcpy(&b2[0], &s0[32], 16);
    memcpy(&b2[16], &s1[32], 16);
    memcpy(&b2[32], &s2[32], 16);
    memcpy(&b2[48], &s3[32], 16);
    memcpy(&b3[0], &s0[48], 16);
    memcpy(&b3[16], &s1[48], 16);
    memcpy(&b3[32], &s2[48], 16);
    memcpy(&b3[48], &s3[48], 16);
}

static inline void prepareSoEM256x4SoA(
    const uint8_t keys[4][64],
    const uint8_t inputs[4][32],
    uint8_t s1b0[64],
    uint8_t s1b1[64],
    uint8_t s2b0[64],
    uint8_t s2b1[64]) {
    size_t lane;
    for (lane = 0; lane < 4; lane++) {
        uint64_t m;
        m = areion_load_le64(&inputs[lane][0]);
        areion_store_le64(&s1b0[lane * 16 + 0], m ^ areion_load_le64(&keys[lane][0]));
        areion_store_le64(&s2b0[lane * 16 + 0], m ^ areion_load_le64(&keys[lane][32]));

        m = areion_load_le64(&inputs[lane][8]);
        areion_store_le64(&s1b0[lane * 16 + 8], m ^ areion_load_le64(&keys[lane][8]));
        areion_store_le64(&s2b0[lane * 16 + 8], m ^ areion_load_le64(&keys[lane][40]));

        m = areion_load_le64(&inputs[lane][16]);
        areion_store_le64(&s1b1[lane * 16 + 0], m ^ areion_load_le64(&keys[lane][16]));
        areion_store_le64(&s2b1[lane * 16 + 0], m ^ areion_load_le64(&keys[lane][48]));

        m = areion_load_le64(&inputs[lane][24]);
        areion_store_le64(&s1b1[lane * 16 + 8], m ^ areion_load_le64(&keys[lane][24]));
        areion_store_le64(&s2b1[lane * 16 + 8], m ^ areion_load_le64(&keys[lane][56]));
        areion_compiler_barrier();
    }
}

static inline void finishSoEM256x4SoA(
    uint8_t s1b0[64],
    uint8_t s1b1[64],
    const uint8_t keys[4][64],
    uint8_t out[4][32]) {
    size_t lane;
    for (lane = 0; lane < 4; lane++) {
        areion_store_le64(&s1b0[lane * 16 + 0],
            areion_load_le64(&s1b0[lane * 16 + 0]) ^ areion_load_le64(&keys[lane][0]) ^ areion_load_le64(&keys[lane][32]));
        areion_store_le64(&s1b0[lane * 16 + 8],
            areion_load_le64(&s1b0[lane * 16 + 8]) ^ areion_load_le64(&keys[lane][8]) ^ areion_load_le64(&keys[lane][40]));
        areion_store_le64(&s1b1[lane * 16 + 0],
            areion_load_le64(&s1b1[lane * 16 + 0]) ^ areion_load_le64(&keys[lane][16]) ^ areion_load_le64(&keys[lane][48]));
        areion_store_le64(&s1b1[lane * 16 + 8],
            areion_load_le64(&s1b1[lane * 16 + 8]) ^ areion_load_le64(&keys[lane][24]) ^ areion_load_le64(&keys[lane][56]));
        areion_compiler_barrier();
    }
    for (lane = 0; lane < 4; lane++) {
        memcpy(&out[lane][0], &s1b0[lane * 16], 16);
        memcpy(&out[lane][16], &s1b1[lane * 16], 16);
        areion_compiler_barrier();
    }
}

static inline void prepareSoEM512x4SoA(
    const uint8_t keys[4][128],
    const uint8_t inputs[4][64],
    uint8_t a1[64],
    uint8_t b1[64],
    uint8_t c1[64],
    uint8_t d1[64],
    uint8_t a2[64],
    uint8_t b2[64],
    uint8_t c2[64],
    uint8_t d2[64]) {
    size_t lane;
    for (lane = 0; lane < 4; lane++) {
        uint64_t m;
        m = areion_load_le64(&inputs[lane][0]);
        areion_store_le64(&a1[lane * 16 + 0], m ^ areion_load_le64(&keys[lane][0]));
        areion_store_le64(&a2[lane * 16 + 0], m ^ areion_load_le64(&keys[lane][64]));

        m = areion_load_le64(&inputs[lane][8]);
        areion_store_le64(&a1[lane * 16 + 8], m ^ areion_load_le64(&keys[lane][8]));
        areion_store_le64(&a2[lane * 16 + 8], m ^ areion_load_le64(&keys[lane][72]));

        m = areion_load_le64(&inputs[lane][16]);
        areion_store_le64(&b1[lane * 16 + 0], m ^ areion_load_le64(&keys[lane][16]));
        areion_store_le64(&b2[lane * 16 + 0], m ^ areion_load_le64(&keys[lane][80]));

        m = areion_load_le64(&inputs[lane][24]);
        areion_store_le64(&b1[lane * 16 + 8], m ^ areion_load_le64(&keys[lane][24]));
        areion_store_le64(&b2[lane * 16 + 8], m ^ areion_load_le64(&keys[lane][88]));

        m = areion_load_le64(&inputs[lane][32]);
        areion_store_le64(&c1[lane * 16 + 0], m ^ areion_load_le64(&keys[lane][32]));
        areion_store_le64(&c2[lane * 16 + 0], m ^ areion_load_le64(&keys[lane][96]));

        m = areion_load_le64(&inputs[lane][40]);
        areion_store_le64(&c1[lane * 16 + 8], m ^ areion_load_le64(&keys[lane][40]));
        areion_store_le64(&c2[lane * 16 + 8], m ^ areion_load_le64(&keys[lane][104]));

        m = areion_load_le64(&inputs[lane][48]);
        areion_store_le64(&d1[lane * 16 + 0], m ^ areion_load_le64(&keys[lane][48]));
        areion_store_le64(&d2[lane * 16 + 0], m ^ areion_load_le64(&keys[lane][112]));

        m = areion_load_le64(&inputs[lane][56]);
        areion_store_le64(&d1[lane * 16 + 8], m ^ areion_load_le64(&keys[lane][56]));
        areion_store_le64(&d2[lane * 16 + 8], m ^ areion_load_le64(&keys[lane][120]));
        areion_compiler_barrier();
    }
}

static inline void finishSoEM512x4SoA(
    uint8_t a1[64],
    uint8_t b1[64],
    uint8_t c1[64],
    uint8_t d1[64],
    const uint8_t keys[4][128],
    uint8_t out[4][64]) {
    size_t lane;
    for (lane = 0; lane < 4; lane++) {
        areion_store_le64(&a1[lane * 16 + 0],
            areion_load_le64(&a1[lane * 16 + 0]) ^ areion_load_le64(&keys[lane][0]) ^ areion_load_le64(&keys[lane][64]));
        areion_store_le64(&a1[lane * 16 + 8],
            areion_load_le64(&a1[lane * 16 + 8]) ^ areion_load_le64(&keys[lane][8]) ^ areion_load_le64(&keys[lane][72]));
        areion_store_le64(&b1[lane * 16 + 0],
            areion_load_le64(&b1[lane * 16 + 0]) ^ areion_load_le64(&keys[lane][16]) ^ areion_load_le64(&keys[lane][80]));
        areion_store_le64(&b1[lane * 16 + 8],
            areion_load_le64(&b1[lane * 16 + 8]) ^ areion_load_le64(&keys[lane][24]) ^ areion_load_le64(&keys[lane][88]));
        areion_store_le64(&c1[lane * 16 + 0],
            areion_load_le64(&c1[lane * 16 + 0]) ^ areion_load_le64(&keys[lane][32]) ^ areion_load_le64(&keys[lane][96]));
        areion_store_le64(&c1[lane * 16 + 8],
            areion_load_le64(&c1[lane * 16 + 8]) ^ areion_load_le64(&keys[lane][40]) ^ areion_load_le64(&keys[lane][104]));
        areion_store_le64(&d1[lane * 16 + 0],
            areion_load_le64(&d1[lane * 16 + 0]) ^ areion_load_le64(&keys[lane][48]) ^ areion_load_le64(&keys[lane][112]));
        areion_store_le64(&d1[lane * 16 + 8],
            areion_load_le64(&d1[lane * 16 + 8]) ^ areion_load_le64(&keys[lane][56]) ^ areion_load_le64(&keys[lane][120]));
        areion_compiler_barrier();
    }
    for (lane = 0; lane < 4; lane++) {
        memcpy(&out[lane][0], &a1[lane * 16], 16);
        memcpy(&out[lane][16], &b1[lane * 16], 16);
        memcpy(&out[lane][32], &c1[lane * 16], 16);
        memcpy(&out[lane][48], &d1[lane * 16], 16);
        areion_compiler_barrier();
    }
}

static inline void xor16(uint8_t dst[16], const uint8_t a[16], const uint8_t b[16]) {
    areion_store_le64(&dst[0], areion_load_le64(&a[0]) ^ areion_load_le64(&b[0]));
    areion_store_le64(&dst[8], areion_load_le64(&a[8]) ^ areion_load_le64(&b[8]));
}

static inline void xor16_3(uint8_t dst[16], const uint8_t a[16], const uint8_t b[16], const uint8_t c[16]) {
    areion_store_le64(&dst[0], areion_load_le64(&a[0]) ^ areion_load_le64(&b[0]) ^ areion_load_le64(&c[0]));
    areion_store_le64(&dst[8], areion_load_le64(&a[8]) ^ areion_load_le64(&b[8]) ^ areion_load_le64(&c[8]));
}

#endif /* AREION_SOA_H */
