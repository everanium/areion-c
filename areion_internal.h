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

/* =========================================================================
 * CPU Detection (cpu.c, cpu_amd64.c, cpu_arm64.c, cpu_other.c)
 * ========================================================================= */

AREION_INTERNAL areion_tier_t areion_detect_hardware_tier(void);
AREION_INTERNAL bool areion_check_tier_supported(areion_tier_t tier);

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

#endif /* AREION_INTERNAL_H */
