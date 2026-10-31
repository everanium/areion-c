/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#ifndef AREION_INTERNAL_H
#define AREION_INTERNAL_H

#include "areion.h"
#include <string.h>

#ifndef __has_attribute
#define __has_attribute(x) 0
#endif

#ifndef __has_feature
#define __has_feature(x) 0
#endif

#if __has_feature(memory_sanitizer)
#include <sanitizer/msan_interface.h>
#define AREION_MSAN_UNPOISON(p, n) __msan_unpoison((p), (n))
#else
#define AREION_MSAN_UNPOISON(p, n) ((void)(p), (void)(n))
#endif

#if defined(_MSC_VER)
#include <intrin.h>
#ifndef InterlockedCompareExchange
#define InterlockedCompareExchange _InterlockedCompareExchange
#endif
#define AREION_ALIGN64 __declspec(align(64))
#define AREION_NOINLINE __declspec(noinline)
#define AREION_NO_STACK_PROTECTOR __declspec(safebuffers)
#define AREION_INTERNAL
#elif defined(__clang__)
#define AREION_ALIGN64 __attribute__((aligned(64)))
#if __has_attribute(noipa)
#define AREION_NOINLINE __attribute__((noinline, noipa))
#else
#define AREION_NOINLINE __attribute__((noinline))
#endif
#if __has_attribute(no_stack_protector)
#define AREION_NO_STACK_PROTECTOR __attribute__((no_stack_protector))
#else
#define AREION_NO_STACK_PROTECTOR
#endif
#if defined(__ELF__)
#define AREION_INTERNAL __attribute__((visibility("hidden")))
#else
#define AREION_INTERNAL
#endif
#elif defined(__GNUC__)
#define AREION_ALIGN64 __attribute__((aligned(64)))
#if __GNUC__ >= 8
#define AREION_NOINLINE __attribute__((noinline, noipa))
#define AREION_NO_STACK_PROTECTOR __attribute__((no_stack_protector))
#else
#define AREION_NOINLINE __attribute__((noinline, noclone))
#define AREION_NO_STACK_PROTECTOR
#endif
#if defined(__ELF__)
#define AREION_INTERNAL __attribute__((visibility("hidden")))
#else
#define AREION_INTERNAL
#endif
#else
#define AREION_ALIGN64
#define AREION_NOINLINE
#define AREION_NO_STACK_PROTECTOR
#define AREION_INTERNAL
#endif

/* Prevents interprocedural argument promotion of const pointer parameters. */
#if defined(__GNUC__) || defined(__clang__)
#define AREION_OPAQUE_PTR(p) __asm__ __volatile__("" : : "r"(p) : "memory")
#else
#define AREION_OPAQUE_PTR(p) ((void)(p))
#endif

/* Compiler memory barrier to prevent dead-store elimination and reordering. */
static inline void areion_compiler_barrier(void) {
#if defined(__GNUC__) || defined(__clang__)
    __asm__ __volatile__("" : : : "memory");
#elif defined(_MSC_VER)
    _ReadWriteBarrier();
#endif
}

/* DSE-resistant buffer zeroization. */
static inline void areion_secure_wipe(void *ptr, size_t len) {
#if defined(__GNUC__) || defined(__clang__)
    memset(ptr, 0, len);
    __asm__ __volatile__("" : : "r"(ptr) : "memory");
#else
    volatile uint8_t *p = (volatile uint8_t *)ptr;
    size_t i;
    for (i = 0; i < len; i++) {
        p[i] = 0;
    }
#if defined(_MSC_VER)
    _ReadWriteBarrier();
#endif
#endif
}

#ifndef AREION_IS_LITTLE_ENDIAN
#if (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)) || \
    defined(__x86_64__) || defined(_M_X64) || defined(__i386__) || defined(_M_IX86) || \
    defined(__aarch64__) || defined(_M_ARM64) || defined(__ARMEL__) || defined(__riscv)
#define AREION_IS_LITTLE_ENDIAN 1
#else
#define AREION_IS_LITTLE_ENDIAN 0
#endif
#endif

/* Endian-neutral, unaligned-safe 32-bit and 64-bit little-endian load/store. */
static inline uint32_t areion_load_le32(const uint8_t *p) {
#if AREION_IS_LITTLE_ENDIAN
    uint32_t v;
#if defined(__GNUC__) || defined(__clang__)
    __builtin_memcpy(&v, p, sizeof(v));
#else
    memcpy(&v, p, sizeof(v));
#endif
    return v;
#else
    return ((uint32_t)p[0]) |
           ((uint32_t)p[1] << 8U) |
           ((uint32_t)p[2] << 16U) |
           ((uint32_t)p[3] << 24U);
#endif
}

static inline void areion_store_le32(uint8_t *p, uint32_t v) {
#if AREION_IS_LITTLE_ENDIAN
#if defined(__GNUC__) || defined(__clang__)
    __builtin_memcpy(p, &v, sizeof(v));
#else
    memcpy(p, &v, sizeof(v));
#endif
#else
    p[0] = (uint8_t)(v);
    p[1] = (uint8_t)(v >> 8U);
    p[2] = (uint8_t)(v >> 16U);
    p[3] = (uint8_t)(v >> 24U);
#endif
}

static inline uint64_t areion_load_le64(const uint8_t *p) {
#if AREION_IS_LITTLE_ENDIAN
    uint64_t v;
#if defined(__GNUC__) || defined(__clang__)
    __builtin_memcpy(&v, p, sizeof(v));
#else
    memcpy(&v, p, sizeof(v));
#endif
    return v;
#else
    return ((uint64_t)p[0]) |
           ((uint64_t)p[1] << 8U) |
           ((uint64_t)p[2] << 16U) |
           ((uint64_t)p[3] << 24U) |
           ((uint64_t)p[4] << 32U) |
           ((uint64_t)p[5] << 40U) |
           ((uint64_t)p[6] << 48U) |
           ((uint64_t)p[7] << 56U);
#endif
}

static inline void areion_store_le64(uint8_t *p, uint64_t v) {
#if AREION_IS_LITTLE_ENDIAN
#if defined(__GNUC__) || defined(__clang__)
    __builtin_memcpy(p, &v, sizeof(v));
#else
    memcpy(p, &v, sizeof(v));
#endif
#else
    p[0] = (uint8_t)(v);
    p[1] = (uint8_t)(v >> 8U);
    p[2] = (uint8_t)(v >> 16U);
    p[3] = (uint8_t)(v >> 24U);
    p[4] = (uint8_t)(v >> 32U);
    p[5] = (uint8_t)(v >> 40U);
    p[6] = (uint8_t)(v >> 48U);
    p[7] = (uint8_t)(v >> 56U);
#endif
}

/* =========================================================================
 * Internal Constants (constants.c)
 * ========================================================================= */

extern AREION_ALIGN64 const uint8_t roundConstantsP1[15][16] AREION_INTERNAL;
extern AREION_ALIGN64 const uint8_t roundConstantsP2[15][16] AREION_INTERNAL;
extern AREION_ALIGN64 const uint8_t areionRC4x[15][64] AREION_INTERNAL;
extern AREION_ALIGN64 const uint8_t areionRC4x2[15][64] AREION_INTERNAL;
extern AREION_ALIGN64 const uint64_t roundConstantsP1BS[15][8] AREION_INTERNAL;
extern AREION_ALIGN64 const uint64_t roundConstantsP2BS[15][8] AREION_INTERNAL;
extern AREION_ALIGN64 const uint64_t roundConstantsP1P2BS[15][8] AREION_INTERNAL;
extern const uint8_t areion_aes_rcon[10] AREION_INTERNAL;
extern AREION_ALIGN64 const uint8_t rijndael256Consts[8][16] AREION_INTERNAL;
extern AREION_ALIGN64 const uint8_t vistrutahRoundConstants[16][16] AREION_INTERNAL;
extern AREION_ALIGN64 const uint8_t vistrutahConsts[40][16] AREION_INTERNAL;
extern AREION_ALIGN64 const uint8_t asuraRoundConstants[13][16] AREION_INTERNAL;
extern AREION_ALIGN64 const uint8_t areion_asura_rc[13][16] AREION_INTERNAL;
extern AREION_ALIGN64 const uint8_t asuraConsts[12][16] AREION_INTERNAL;
extern AREION_ALIGN64 const uint8_t asuraGFConsts[6][16] AREION_INTERNAL;

/* =========================================================================
 * CPU Detection (cpu.c, cpu_amd64.c, cpu_arm64.c, cpu_other.c)
 * ========================================================================= */

AREION_INTERNAL areion_tier_t areion_detect_hardware_tier(void);
AREION_INTERNAL bool areion_check_tier_supported(areion_tier_t tier);

#if defined(_MSC_VER)
extern volatile long areion_g_active_tier;
#elif defined(__GNUC__) || defined(__clang__)
extern int areion_g_active_tier AREION_INTERNAL;
#else
extern volatile int areion_g_active_tier;
#endif

static inline areion_tier_t areion_active_tier(void) {
#if defined(_MSC_VER)
    return (areion_tier_t)InterlockedCompareExchange((volatile long *)&areion_g_active_tier, 0, 0);
#elif defined(__GNUC__) || defined(__clang__)
    return (areion_tier_t)__atomic_load_n(&areion_g_active_tier, __ATOMIC_ACQUIRE);
#else
    return areion_tier_code();
#endif
}

/* =========================================================================
 * Software Stack Frame Zeroization & 64-Bit Bitsliced AES Primitives
 * ========================================================================= */

AREION_INTERNAL void areion_wipe_software_stack(void);

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

static inline void bs_pack_broadcast(uint64_t q[8], const uint8_t b0[16]) {
    size_t k;
    bs_pack1(q, b0);
    for (k = 0; k < 8; k++) {
        q[k] *= 0xfULL;
    }
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
}

AREION_INTERNAL void areion_bs_sub_bytes(uint64_t q[8]);
AREION_INTERNAL void areion_bs_inv_sub_bytes(uint64_t q[8]);
AREION_INTERNAL void areion_bs_mix_columns(uint64_t q[8]);
AREION_INTERNAL void areion_bs_inv_mix_columns(uint64_t q[8]);

#define bs_sub_bytes     areion_bs_sub_bytes
#define bs_inv_sub_bytes areion_bs_inv_sub_bytes
#define bs_mix_columns     areion_bs_mix_columns
#define bs_inv_mix_columns areion_bs_inv_mix_columns

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
 * Pure-C Software Fallback Entry Points (areion_purec.c)
 * ========================================================================= */

#if !defined(AREION_FORCE_PORTABLE) && (defined(__x86_64__) || defined(_M_X64) || defined(__aarch64__) || defined(_M_ARM64))
extern void clobberScratchGPRs(void) AREION_INTERNAL;
static inline void areion_clobber_scratch_gprs(void) {
#if (defined(__GNUC__) || defined(__clang__)) && (defined(__x86_64__) || defined(_M_X64))
    if (areion_tier_code() == AREION_TIER_AVX512) {
        __asm__ __volatile__(
            "vpxord %%zmm16, %%zmm16, %%zmm16\n\t"
            "vpxord %%zmm17, %%zmm17, %%zmm17\n\t"
            "vpxord %%zmm18, %%zmm18, %%zmm18\n\t"
            "vpxord %%zmm19, %%zmm19, %%zmm19\n\t"
            "vpxord %%zmm20, %%zmm20, %%zmm20\n\t"
            "vpxord %%zmm21, %%zmm21, %%zmm21\n\t"
            "vpxord %%zmm22, %%zmm22, %%zmm22\n\t"
            "vpxord %%zmm23, %%zmm23, %%zmm23\n\t"
            "vpxord %%zmm24, %%zmm24, %%zmm24\n\t"
            "vpxord %%zmm25, %%zmm25, %%zmm25\n\t"
            "vpxord %%zmm26, %%zmm26, %%zmm26\n\t"
            "vpxord %%zmm27, %%zmm27, %%zmm27\n\t"
            "vpxord %%zmm28, %%zmm28, %%zmm28\n\t"
            "vpxord %%zmm29, %%zmm29, %%zmm29\n\t"
            "vpxord %%zmm30, %%zmm30, %%zmm30\n\t"
            "vpxord %%zmm31, %%zmm31, %%zmm31\n\t"
            "vzeroupper"
            : : : "memory");
    }
#endif
    clobberScratchGPRs();
}
#else
static inline void areion_clobber_scratch_gprs(void) {
    areion_compiler_barrier();
}
#endif

AREION_INTERNAL void areion_permute256_purec(uint8_t state[32]);
AREION_INTERNAL void areion_inverse_permute256_purec(uint8_t state[32]);
AREION_INTERNAL void areion_permute512_purec(uint8_t state[64]);
AREION_INTERNAL void areion_inverse_permute512_purec(uint8_t state[64]);

AREION_INTERNAL void areion_permute256_p2_purec(uint8_t state[32]);
AREION_INTERNAL void areion_inverse_permute256_p2_purec(uint8_t state[32]);
AREION_INTERNAL void areion_permute512_p2_purec(uint8_t state[64]);
AREION_INTERNAL void areion_inverse_permute512_p2_purec(uint8_t state[64]);

AREION_INTERNAL void areion_dm256_purec(uint8_t out[32], const uint8_t in[32]);
AREION_INTERNAL void areion_dm512_purec(uint8_t out[32], const uint8_t in[64]);

AREION_INTERNAL void areion_soem256_purec(uint8_t out[32], const uint8_t key[64], const uint8_t in[32]);
AREION_INTERNAL void areion_soem512_purec(uint8_t out[64], const uint8_t key[128], const uint8_t in[64]);
AREION_INTERNAL void areion_soem256x4_purec(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t inputs[4][32]);
AREION_INTERNAL void areion_soem512x4_purec(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t inputs[4][64]);

AREION_INTERNAL void areion_em_encrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]);
AREION_INTERNAL void areion_em_decrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]);
AREION_INTERNAL void areion_em_encrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]);
AREION_INTERNAL void areion_em_decrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]);
AREION_INTERNAL void areion_em_encrypt256x4_purec(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]);
AREION_INTERNAL void areion_em_decrypt256x4_purec(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]);
AREION_INTERNAL void areion_em_encrypt512x4_purec(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]);
AREION_INTERNAL void areion_em_decrypt512x4_purec(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]);

AREION_INTERNAL void areion_em2_encrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]);
AREION_INTERNAL void areion_em2_decrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]);
AREION_INTERNAL void areion_em2_encrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]);
AREION_INTERNAL void areion_em2_decrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]);
AREION_INTERNAL void areion_em2_encrypt256x4_purec(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]);
AREION_INTERNAL void areion_em2_decrypt256x4_purec(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]);
AREION_INTERNAL void areion_em2_encrypt512x4_purec(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]);
AREION_INTERNAL void areion_em2_decrypt512x4_purec(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]);

AREION_INTERNAL void areion_tem_encrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]);
AREION_INTERNAL void areion_tem_decrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]);
AREION_INTERNAL void areion_tem_encrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]);
AREION_INTERNAL void areion_tem_decrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]);
AREION_INTERNAL void areion_tem_encrypt256x4_purec(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]);
AREION_INTERNAL void areion_tem_decrypt256x4_purec(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]);
AREION_INTERNAL void areion_tem_encrypt512x4_purec(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]);
AREION_INTERNAL void areion_tem_decrypt512x4_purec(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]);

AREION_INTERNAL void areion_tem2_encrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]);
AREION_INTERNAL void areion_tem2_decrypt256_purec(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]);
AREION_INTERNAL void areion_tem2_encrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]);
AREION_INTERNAL void areion_tem2_decrypt512_purec(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]);
AREION_INTERNAL void areion_tem2_encrypt256x4_purec(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]);
AREION_INTERNAL void areion_tem2_decrypt256x4_purec(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]);
AREION_INTERNAL void areion_tem2_encrypt512x4_purec(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]);
AREION_INTERNAL void areion_tem2_decrypt512x4_purec(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]);

AREION_INTERNAL void areion_permute256x4_purec(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]);
AREION_INTERNAL void areion_permute256_p2x4_purec(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]);
AREION_INTERNAL void areion_inverse_permute256x4_purec(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]);
AREION_INTERNAL void areion_inverse_permute256_p2x4_purec(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]);

AREION_INTERNAL void areion_permute512x4_purec(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]);
AREION_INTERNAL void areion_permute512_p2x4_purec(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]);
AREION_INTERNAL void areion_inverse_permute512x4_purec(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]);
AREION_INTERNAL void areion_inverse_permute512_p2x4_purec(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]);

AREION_INTERNAL void areion_round_purec(const uint32_t in[4], uint32_t out[4]);
AREION_INTERNAL void areion_final_round_purec(const uint32_t in[4], uint32_t out[4]);
AREION_INTERNAL void areion_inv_round_purec(const uint32_t in[4], uint32_t out[4]);
AREION_INTERNAL void areion_inv_final_round_purec(const uint32_t in[4], uint32_t out[4]);
AREION_INTERNAL void areion_inv_mix_columns_purec(const uint32_t in[4], uint32_t out[4]);

AREION_INTERNAL void areion_round4_purec(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16]);
AREION_INTERNAL void areion_final_round4_purec(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16]);

AREION_INTERNAL void areion_aes_round_purec(uint8_t block[16], const uint8_t rk[16]);
AREION_INTERNAL void areion_aes_final_round_purec(uint8_t block[16], const uint8_t rk[16]);
AREION_INTERNAL void areion_aes_round4_purec(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]);
AREION_INTERNAL void areion_aes_final_round4_purec(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]);

AREION_INTERNAL void areion_expand_key128_purec(const uint8_t key[16], uint8_t rk[11][16]);
AREION_INTERNAL void areion_aes128_encrypt_block_purec(uint8_t dst[16], const uint8_t src[16], const uint8_t rk[11][16]);
AREION_INTERNAL void areion_aes128_encrypt4_blocks_purec(
    uint8_t dst[4][16], const uint8_t src[4][16], const uint8_t rk[11][16]);

AREION_INTERNAL void areion_rijndael256_encrypt_block_purec(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[15][32]);
AREION_INTERNAL void areion_rijndael256_decrypt_block_purec(
    uint8_t dst[32], const uint8_t src[32], const uint8_t drk[15][32]);
AREION_INTERNAL void areion_rijndael256_encrypt4_blocks_purec(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[15][32]);
AREION_INTERNAL void areion_rijndael256_decrypt4_blocks_purec(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t drk[15][32]);
#define areion_rijndael256_encrypt_block_soft areion_rijndael256_encrypt_block_purec
#define areion_rijndael256_decrypt_block_soft areion_rijndael256_decrypt_block_purec
#define areion_rijndael256_encrypt4_blocks_soft areion_rijndael256_encrypt4_blocks_purec
#define areion_rijndael256_decrypt4_blocks_soft areion_rijndael256_decrypt4_blocks_purec
AREION_INTERNAL void areion_rijndael256_encrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[15][32]);
AREION_INTERNAL void areion_rijndael256_decrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t drk[15][32]);
AREION_INTERNAL void areion_rijndael256_encrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[15][32]);
AREION_INTERNAL void areion_rijndael256_decrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t drk[15][32]);

AREION_INTERNAL void areion_vistrutah256_encrypt_block_purec(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds);
AREION_INTERNAL void areion_vistrutah256_decrypt_block_purec(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds);
AREION_INTERNAL void areion_vistrutah256_encrypt4_blocks_purec(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds);
AREION_INTERNAL void areion_vistrutah256_decrypt4_blocks_purec(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds);
AREION_INTERNAL void areion_vistrutah256_encrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds);
AREION_INTERNAL void areion_vistrutah256_decrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds);
AREION_INTERNAL void areion_vistrutah256_encrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds);
AREION_INTERNAL void areion_vistrutah256_decrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds);

AREION_INTERNAL void areion_vistrutah512_encrypt_block_256_purec(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds);
AREION_INTERNAL void areion_vistrutah512_decrypt_block_256_purec(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds);
AREION_INTERNAL void areion_vistrutah512_encrypt_block_512_purec(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds);
AREION_INTERNAL void areion_vistrutah512_decrypt_block_512_purec(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds);
AREION_INTERNAL void areion_vistrutah512_encrypt4_blocks_256_purec(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds);
AREION_INTERNAL void areion_vistrutah512_decrypt4_blocks_256_purec(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds);
AREION_INTERNAL void areion_vistrutah512_encrypt4_blocks_512_purec(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds);
AREION_INTERNAL void areion_vistrutah512_decrypt4_blocks_512_purec(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds);
AREION_INTERNAL void areion_vistrutah512_encrypt_block_256_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds);
AREION_INTERNAL void areion_vistrutah512_decrypt_block_256_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds);
AREION_INTERNAL void areion_vistrutah512_encrypt_block_512_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds);
AREION_INTERNAL void areion_vistrutah512_decrypt_block_512_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds);
AREION_INTERNAL void areion_vistrutah512_encrypt4_blocks_256_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds);
AREION_INTERNAL void areion_vistrutah512_decrypt4_blocks_256_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds);
AREION_INTERNAL void areion_vistrutah512_encrypt4_blocks_512_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds);
AREION_INTERNAL void areion_vistrutah512_decrypt4_blocks_512_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds);

AREION_INTERNAL void areion_asura_expand_tweakey_soft(
    uint8_t rk[13][32], const uint8_t key[32], const uint8_t tweak[16]);
AREION_INTERNAL void areion_asura_encrypt_block_soft(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]);
AREION_INTERNAL void areion_asura_decrypt_block_soft(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]);
AREION_INTERNAL void areion_asura_encrypt_4blocks_soft(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]);
AREION_INTERNAL void areion_asura_decrypt_4blocks_soft(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]);
AREION_INTERNAL void areion_asura_encrypt_block_otf_soft(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]);
AREION_INTERNAL void areion_asura_decrypt_block_otf_soft(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]);
AREION_INTERNAL void areion_asura_encrypt_4blocks_otf_soft(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweaks[4][16]);
AREION_INTERNAL void areion_asura_decrypt_4blocks_otf_soft(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweaks[4][16]);
AREION_INTERNAL void areion_asura_expand_key_soft(
    uint8_t rk[13][32], const uint8_t key[32]);
AREION_INTERNAL void areion_asura_encrypt_block_rk_soft(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32], const uint8_t tweak[16]);
AREION_INTERNAL void areion_asura_decrypt_block_rk_soft(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32], const uint8_t tweak[16]);
AREION_INTERNAL void areion_asura_encrypt_4blocks_rk_soft(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32], const uint8_t tweaks[4][16]);
AREION_INTERNAL void areion_asura_decrypt_4blocks_rk_soft(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32], const uint8_t tweaks[4][16]);

#define areion_asura_expand_tweakey_purec areion_asura_expand_tweakey_soft
#define areion_asura_encrypt_block_purec areion_asura_encrypt_block_soft
#define areion_asura_decrypt_block_purec areion_asura_decrypt_block_soft
#define areion_asura_encrypt_4blocks_purec areion_asura_encrypt_4blocks_soft
#define areion_asura_decrypt_4blocks_purec areion_asura_decrypt_4blocks_soft
#define areion_asura_encrypt4_blocks_purec areion_asura_encrypt_4blocks_soft
#define areion_asura_decrypt4_blocks_purec areion_asura_decrypt_4blocks_soft
#define areion_asura_encrypt4_blocks_soft areion_asura_encrypt_4blocks_soft
#define areion_asura_decrypt4_blocks_soft areion_asura_decrypt_4blocks_soft
#define areion_asura_encrypt_block_otf_purec areion_asura_encrypt_block_otf_soft
#define areion_asura_decrypt_block_otf_purec areion_asura_decrypt_block_otf_soft
#define areion_asura_encrypt_4blocks_otf_purec areion_asura_encrypt_4blocks_otf_soft
#define areion_asura_decrypt_4blocks_otf_purec areion_asura_decrypt_4blocks_otf_soft
#define areion_asura_expand_key_purec areion_asura_expand_key_soft
#define areion_asura_encrypt_block_rk_purec areion_asura_encrypt_block_rk_soft
#define areion_asura_decrypt_block_rk_purec areion_asura_decrypt_block_rk_soft
#define areion_asura_encrypt_4blocks_rk_purec areion_asura_encrypt_4blocks_rk_soft
#define areion_asura_decrypt_4blocks_rk_purec areion_asura_decrypt_4blocks_rk_soft
#define areion_asura_tbc_encrypt_block_purec areion_asura_encrypt_block_otf_soft
#define areion_asura_tbc_decrypt_block_purec areion_asura_decrypt_block_otf_soft
#define areion_asura_tbc_encrypt4_blocks_purec areion_asura_encrypt_4blocks_otf_soft
#define areion_asura_tbc_decrypt4_blocks_purec areion_asura_decrypt_4blocks_otf_soft
#define areion_asura_tbc_encrypt_block_soft areion_asura_encrypt_block_otf_soft
#define areion_asura_tbc_decrypt_block_soft areion_asura_decrypt_block_otf_soft
#define areion_asura_tbc_encrypt4_blocks_soft areion_asura_encrypt_4blocks_otf_soft
#define areion_asura_tbc_decrypt4_blocks_soft areion_asura_decrypt_4blocks_otf_soft
#define areion_asura_expand_tweakey_hw       areion_asura_expand_tweakey
#define areion_asura_encrypt_block_hw        areion_asura_encrypt
#define areion_asura_decrypt_block_hw        areion_asura_decrypt
#define areion_asura_encrypt_4blocks_hw      areion_asura_encryptx4
#define areion_asura_decrypt_4blocks_hw      areion_asura_decryptx4
#define areion_asura_encrypt4_blocks_hw      areion_asura_encryptx4
#define areion_asura_decrypt4_blocks_hw      areion_asura_decryptx4
#define areion_asura_encrypt_block_otf_hw    areion_asura_encrypt_otf
#define areion_asura_decrypt_block_otf_hw    areion_asura_decrypt_otf
#define areion_asura_encrypt_4blocks_otf_hw  areion_asura_encryptx4_otf
#define areion_asura_decrypt_4blocks_otf_hw  areion_asura_decryptx4_otf
#define areion_asura_expand_key_hw           areion_asura_expand_key
#define areion_asura_encrypt_block_rk_hw     areion_asura_encrypt_rk
#define areion_asura_decrypt_block_rk_hw     areion_asura_decrypt_rk
#define areion_asura_encrypt_4blocks_rk_hw   areion_asura_encryptx4_rk
#define areion_asura_decrypt_4blocks_rk_hw   areion_asura_decryptx4_rk
#define areion_asura_tbc_encrypt_block_hw    areion_asura_encrypt_otf
#define areion_asura_tbc_decrypt_block_hw    areion_asura_decrypt_otf
#define areion_asura_tbc_encrypt4_blocks_hw  areion_asura_encryptx4_otf
#define areion_asura_tbc_decrypt4_blocks_hw  areion_asura_decryptx4_otf

#endif /* AREION_INTERNAL_H */
