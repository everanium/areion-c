/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#ifndef AREION_H
#define AREION_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#if defined(__clang__) && !defined(__cplusplus) && (!defined(__STDC_VERSION__) || __STDC_VERSION__ < 199901L)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wc99-extensions"
#endif

#if !defined(AREION_API)
#if defined(_WIN32) || defined(__CYGWIN__)
#if defined(AREION_SHARED_EXPORTS)
#define AREION_API __declspec(dllexport)
#else
#define AREION_API
#endif
#elif (defined(__GNUC__) && __GNUC__ >= 4) || defined(__clang__)
#define AREION_API __attribute__((visibility("default")))
#else
#define AREION_API
#endif
#endif

/* =========================================================================
 * Public Constants & Dispatch Tiers
 * ========================================================================= */

#define AREION_VERSION_MAJOR     0
#define AREION_VERSION_MINOR     2
#define AREION_VERSION_PATCH     1
#define AREION_VERSION_STRING    "0.2.1"

#define AREION_BLOCK_SIZE_256    32
#define AREION_BLOCK_SIZE_512    64
#define AREION_256_SIZE          32
#define AREION_512_SIZE          64
#define AREION_DM256_INPUT_SIZE  32
#define AREION_DM256_SIZE        32
#define AREION_DM512_INPUT_SIZE  64
#define AREION_DM512_SIZE        32
#define AREION_SOEM256_KEY_SIZE  64
#define AREION_SOEM256_SIZE      32
#define AREION_SOEM512_KEY_SIZE  128
#define AREION_SOEM512_SIZE      64
#define AREION_ASURA_BLOCK_SIZE  32
#define AREION_ASURA_KEY_SIZE    32
#define AREION_ASURA_TWEAK_SIZE  16
#define AREION_ASURA_ROUNDS      12

typedef enum {
    AREION_TIER_AUTO     = -1,
    AREION_TIER_PUREC    = 0,
    AREION_TIER_AESNI    = 1,
    AREION_TIER_VEX      = 2,
    AREION_TIER_VAESAVX2 = 3,
    AREION_TIER_AVX512   = 4,
    AREION_TIER_ARM64    = 5
} areion_tier_t;

/* Returns the name of the active dispatch tier ("avx512", "vaesavx2",
 * "vex", "aesni", "arm64", or "purec"). */
AREION_API const char *areion_tier(void);

/* Returns the active dispatch tier enum value. */
AREION_API areion_tier_t areion_tier_code(void);

/* Overrides the active dispatch tier. Pass AREION_TIER_AUTO (-1) to restore
 * automatic hardware detection. Returns true if the requested tier is
 * supported by the current CPU and build, false otherwise. */
AREION_API bool areion_set_tier_override(areion_tier_t tier);

/* Overrides the active dispatch tier by string name ("auto", "purec",
 * "purego", "aesni", "vex", "vaesavx2", "avx512", "arm64"). Returns true if
 * the requested tier is supported by the current CPU and build. */
AREION_API bool areion_set_tier(const char *name);

/* Enables (enable = true) or disables (enable = false, forcing "purec")
 * hardware acceleration. */
AREION_API void areion_use_hardware_acceleration(bool enable);

/* Returns true if the specified tier is supported on the current CPU. */
AREION_API bool areion_tier_supported(areion_tier_t tier);

/* Scrubs n bytes at p with zeros in a manner resistant to dead-store
 * elimination (DSE). Safe to call with p == NULL or n == 0. */
AREION_API void areion_zeroize(void *p, size_t n);

/* Runs deterministic FIPS 140-3 Known-Answer Tests (KATs) across all
 * cryptographic primitives on the active dispatch tier and zeroizes all
 * temporary buffers before returning. Returns 0 on success, -1 on failure. */
AREION_API int areion_selftest(void);

/* =========================================================================
 * Single-Block Permutations (In-Place)
 * ========================================================================= */

/* 10-round Areion-256 permutation P1 in-place on a 32-byte state. */
AREION_API void areion_permute256(uint8_t state[32]);

/* 10-round inverse Areion-256 permutation P1^-1 in-place on a 32-byte state. */
AREION_API void areion_inverse_permute256(uint8_t state[32]);

/* 15-round Areion-512 permutation P1 in-place on a 64-byte state. */
AREION_API void areion_permute512(uint8_t state[64]);

/* 15-round inverse Areion-512 permutation P1^-1 in-place on a 64-byte state. */
AREION_API void areion_inverse_permute512(uint8_t state[64]);

/* 10-round Areion-256 domain-separated permutation P2 in-place on a 32-byte state. */
AREION_API void areion_permute256_p2(uint8_t state[32]);

/* 10-round inverse Areion-256 domain-separated permutation P2^-1 in-place. */
AREION_API void areion_inverse_permute256_p2(uint8_t state[32]);

/* 15-round Areion-512 domain-separated permutation P2 in-place on a 64-byte state. */
AREION_API void areion_permute512_p2(uint8_t state[64]);

/* 15-round inverse Areion-512 domain-separated permutation P2^-1 in-place. */
AREION_API void areion_inverse_permute512_p2(uint8_t state[64]);

/* =========================================================================
 * Word-Level Permutations (Little-Endian uint32_t Words)
 * ========================================================================= */

AREION_API void areion_permute256_words(uint32_t state[8]);
AREION_API void areion_inverse_permute256_words(uint32_t state[8]);
AREION_API void areion_permute512_words(uint32_t state[16]);
AREION_API void areion_inverse_permute512_words(uint32_t state[16]);

/* =========================================================================
 * Davies-Meyer Compression Functions
 * ========================================================================= */

/* Computes Davies-Meyer Areion-256 compression: out = P1(in) ^ in (32 bytes).
 * Safe for in-place operation (out == in). */
AREION_API void areion_dm256(uint8_t out[32], const uint8_t in[32]);

/* Computes Davies-Meyer Areion-512 compression: out = Trunc256(P1(in) ^ in)
 * (32 bytes, words x2 || x3 || x6 || x7 || x8 || x9 || x12 || x13,
 * bytes [8:16] || [24:32] || [32:40] || [48:56]).
 * Safe for in-place operation (out == in). */
AREION_API void areion_dm512(uint8_t out[32], const uint8_t in[64]);

/* =========================================================================
 * Sum-of-Even-Mansour (SoEM) PRF / MAC Primitives
 * ========================================================================= */

/* Single-message SoEM256: 64-byte key (K1 || K2), 32-byte input -> 32-byte tag:
 * out = P1(in ^ K1) ^ P2(in ^ K2) ^ K1 ^ K2.
 * Safe for in-place operation (out == in or out == key). */
AREION_API void areion_soem256(uint8_t out[32], const uint8_t key[64], const uint8_t in[32]);

/* Single-message SoEM512: 128-byte key (K1 || K2), 64-byte input -> 64-byte tag:
 * out = P1(in ^ K1) ^ P2(in ^ K2) ^ K1 ^ K2.
 * Safe for in-place operation (out == in or out == key). */
AREION_API void areion_soem512(uint8_t out[64], const uint8_t key[128], const uint8_t in[64]);

/* 4-way batched SoEM256: 4 independent (64-byte key, 32-byte input) -> 4 x 32-byte tags. */
AREION_API void areion_soem256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t inputs[4][32]);

/* 4-way batched SoEM512: 4 independent (128-byte key, 64-byte input) -> 4 x 64-byte tags. */
AREION_API void areion_soem512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t inputs[4][64]);

/* =========================================================================
 * Wide-Block Even-Mansour (EM / EM2) and Tweakable Even-Mansour (TEM / TEM2)
 * ========================================================================= */

/* --- Even-Mansour (EM) Wide-Block Cipher: C = P1(M ^ K1) ^ K2, M = P1^-1(C ^ K2) ^ K1 --- */
AREION_API void areion_em_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]);
AREION_API void areion_em_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]);
AREION_API void areion_em_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]);
AREION_API void areion_em_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]);

AREION_API void areion_em_encrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]);
AREION_API void areion_em_decrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]);
AREION_API void areion_em_encrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]);
AREION_API void areion_em_decrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]);

/* --- 2-Round Iterated Even-Mansour (EM2) Wide-Block Cipher: C = P2(P1(M ^ K1) ^ K2) ^ K1 ^ K2, M = P1^-1(P2^-1(C ^ K1 ^ K2) ^ K2) ^ K1 --- */
AREION_API void areion_em2_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]);
AREION_API void areion_em2_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]);
AREION_API void areion_em2_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]);
AREION_API void areion_em2_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]);

AREION_API void areion_em2_encrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]);
AREION_API void areion_em2_decrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]);
AREION_API void areion_em2_encrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]);
AREION_API void areion_em2_decrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]);

/* --- Tweakable Even-Mansour (TEM) Wide-Block Cipher: W = P2(T ^ K2) ^ K1, C = P1(M ^ W) ^ W, M = P1^-1(C ^ W) ^ W --- */
AREION_API void areion_tem_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]);
AREION_API void areion_tem_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]);
AREION_API void areion_tem_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]);
AREION_API void areion_tem_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]);

AREION_API void areion_tem_encrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]);
AREION_API void areion_tem_decrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]);
AREION_API void areion_tem_encrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]);
AREION_API void areion_tem_decrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]);

/* --- 2-Round Tweakable Even-Mansour (TEM2) Wide-Block Cipher: W1 = P1(T ^ K1) ^ K1, W2 = P2(T ^ K2) ^ K2, C = P2(P1(M ^ W1) ^ W2) ^ W1 ^ W2, M = P1^-1(P2^-1(C ^ W1 ^ W2) ^ W2) ^ W1 --- */
AREION_API void areion_tem2_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]);
AREION_API void areion_tem2_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]);
AREION_API void areion_tem2_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]);
AREION_API void areion_tem2_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]);

AREION_API void areion_tem2_encrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]);
AREION_API void areion_tem2_decrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]);
AREION_API void areion_tem2_encrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]);
AREION_API void areion_tem2_decrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]);

/* =========================================================================
 * ASURA 256-Bit Tweakable Block Cipher (12-Round, 256-Bit Key, 128-Bit Tweak)
 * ========================================================================= */

/* Expands 256-bit key and 128-bit tweak into 13 round tweakeys (rtk[0..12][32]). */
AREION_API void areion_asura_expand_tweakey(
    uint8_t rtk[13][32], const uint8_t key[32], const uint8_t tweak[16]);

/* Scrubs expanded ASURA round tweakeys rtk[13][32] via areion_zeroize. */
AREION_API void areion_wipe_asura_tweakey(uint8_t rtk[13][32]);

/* Single-block ASURA encryption and decryption with pre-expanded round tweakeys. */
AREION_API void areion_asura_encrypt(
    uint8_t ct[32], const uint8_t pt[32], const uint8_t rtk[13][32]);
AREION_API void areion_asura_decrypt(
    uint8_t pt[32], const uint8_t ct[32], const uint8_t rtk[13][32]);

/* 4-block parallel ASURA encryption and decryption with pre-expanded round tweakeys. */
AREION_API void areion_asura_encryptx4(
    uint8_t ct[4][32], const uint8_t pt[4][32], const uint8_t rtk[13][32]);
AREION_API void areion_asura_decryptx4(
    uint8_t pt[4][32], const uint8_t ct[4][32], const uint8_t rtk[13][32]);

/* On-the-fly single-block ASURA encryption and decryption. */
AREION_API void areion_asura_encrypt_otf(
    uint8_t ct[32], const uint8_t pt[32], const uint8_t key[32], const uint8_t tweak[16]);
AREION_API void areion_asura_decrypt_otf(
    uint8_t pt[32], const uint8_t ct[32], const uint8_t key[32], const uint8_t tweak[16]);

/* On-the-fly 4-block parallel ASURA encryption and decryption. */
AREION_API void areion_asura_encryptx4_otf(
    uint8_t ct[4][32], const uint8_t pt[4][32], const uint8_t key[32], const uint8_t tweaks[4][16]);
AREION_API void areion_asura_decryptx4_otf(
    uint8_t pt[4][32], const uint8_t ct[4][32], const uint8_t key[32], const uint8_t tweaks[4][16]);

/* Expands 256-bit key into 13 tweak-independent round keys (rk[0..12][32]). */
AREION_API void areion_asura_expand_key(
    uint8_t rk[13][32], const uint8_t key[32]);

/* Scrubs expanded ASURA round keys rk[13][32] via areion_zeroize. */
AREION_API void areion_wipe_asura_key(uint8_t rk[13][32]);

/* Single-block ASURA encryption and decryption with pre-expanded round keys and on-the-fly tweak. */
AREION_API void areion_asura_encrypt_rk(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32], const uint8_t tweak[16]);
AREION_API void areion_asura_decrypt_rk(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32], const uint8_t tweak[16]);

/* 4-block parallel ASURA encryption and decryption with pre-expanded round keys and on-the-fly tweaks. */
AREION_API void areion_asura_encryptx4_rk(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32], const uint8_t tweaks[4][16]);
AREION_API void areion_asura_decryptx4_rk(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32], const uint8_t tweaks[4][16]);

/* =========================================================================
 * 4-Way Parallel Permutations (In-Place)
 * ========================================================================= */

AREION_API void areion_permute256x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]);
AREION_API void areion_permute256_p2x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]);
AREION_API void areion_inverse_permute256x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]);
AREION_API void areion_inverse_permute256_p2x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]);

AREION_API void areion_permute512x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]);
AREION_API void areion_permute512_p2x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]);
AREION_API void areion_inverse_permute512x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]);
AREION_API void areion_inverse_permute512_p2x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]);

/* =========================================================================
 * AES Round Primitives & AES-128 Block Helpers
 * ========================================================================= */

/* Unkeyed AES round primitives on 4 x 32-bit little-endian words. */
AREION_API void areion_round(const uint32_t in[4], uint32_t out[4]);
AREION_API void areion_final_round(const uint32_t in[4], uint32_t out[4]);
AREION_API void areion_inv_round(const uint32_t in[4], uint32_t out[4]);
AREION_API void areion_inv_final_round(const uint32_t in[4], uint32_t out[4]);
AREION_API void areion_inv_mix_columns(const uint32_t in[4], uint32_t out[4]);

/* Unkeyed 16-byte AES round primitives (in-place). */
AREION_API void areion_round_hw(uint8_t block[16]);
AREION_API void areion_final_round_hw(uint8_t block[16]);
AREION_API void areion_round4_hw(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16]);
AREION_API void areion_final_round4_hw(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16]);

/* Keyed 16-byte AES round primitives: SubBytes -> ShiftRows -> [MixColumns] -> AddRoundKey(rk). */
AREION_API void areion_aes_round_hw(uint8_t block[16], const uint8_t rk[16]);
AREION_API void areion_aes_final_round_hw(uint8_t block[16], const uint8_t rk[16]);
AREION_API void areion_aes_round4_hw(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]);
AREION_API void areion_aes_final_round4_hw(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]);

/* Aliases matching Go's AES128Round / AES128FinalRound / XORBlock helpers. */
AREION_API void areion_aes128_round(uint8_t block[16], const uint8_t rk[16]);
AREION_API void areion_aes128_final_round(uint8_t block[16], const uint8_t rk[16]);
AREION_API void areion_aes128_round4(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]);
AREION_API void areion_aes128_final_round4(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]);
AREION_API void areion_xor_block(uint8_t dst[16], const uint8_t src[16]);
AREION_API void areion_xor_block4(
    uint8_t d0[16], uint8_t d1[16], uint8_t d2[16], uint8_t d3[16],
    const uint8_t s0[16], const uint8_t s1[16], const uint8_t s2[16], const uint8_t s3[16]);

/* Full AES-128 key expansion, secure wipe, and 1-block / 4-block encryption. */
AREION_API void areion_expand_key128(const uint8_t key[16], uint8_t rk[11][16]);
AREION_API void areion_wipe_expanded_key128(uint8_t rk[11][16]);
AREION_API void areion_aes128_encrypt_block(uint8_t dst[16], const uint8_t src[16], const uint8_t rk[11][16]);
AREION_API void areion_aes128_encrypt4_blocks(
    uint8_t dst[4][16], const uint8_t src[4][16], const uint8_t rk[11][16]);

/* In ISO C99 / C11 / C17 (prior to C23), passing a non-const multi-dimensional
 * array (e.g., uint8_t keys[4][64]) to a parameter of type const uint8_t (*)[64]
 * triggers a pedantic diagnostic because the const qualifier applies to the
 * inner element type rather than the array type itself. These function-like
 * macros transparently cast multi-dimensional const array arguments in pre-C23 C
 * while leaving &func pointer expressions untouched. */
#if !defined(__cplusplus) && !defined(S_SPLINT_S) && (!defined(__STDC_VERSION__) || __STDC_VERSION__ < 202311L)
#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L
#define AREION_CONST_U8_16(p)  _Generic((p), uint8_t (*)[16]: (const uint8_t (*)[16])(p), const uint8_t (*)[16]: (p))
#define AREION_CONST_U8_32(p)  _Generic((p), uint8_t (*)[32]: (const uint8_t (*)[32])(p), const uint8_t (*)[32]: (p))
#define AREION_CONST_U8_64(p)  _Generic((p), uint8_t (*)[64]: (const uint8_t (*)[64])(p), const uint8_t (*)[64]: (p))
#define AREION_CONST_U8_128(p) _Generic((p), uint8_t (*)[128]: (const uint8_t (*)[128])(p), const uint8_t (*)[128]: (p))
#else
#define AREION_CONST_U8_16(p)  ((const uint8_t (*)[16])(p))
#define AREION_CONST_U8_32(p)  ((const uint8_t (*)[32])(p))
#define AREION_CONST_U8_64(p)  ((const uint8_t (*)[64])(p))
#define AREION_CONST_U8_128(p) ((const uint8_t (*)[128])(p))
#endif
#define areion_soem256x4(out, keys, inputs) \
    (areion_soem256x4)((out), AREION_CONST_U8_64(keys), AREION_CONST_U8_32(inputs))
#define areion_soem512x4(out, keys, inputs) \
    (areion_soem512x4)((out), AREION_CONST_U8_128(keys), AREION_CONST_U8_64(inputs))
#define areion_em_encrypt256x4(out, keys, msgs) \
    (areion_em_encrypt256x4)((out), AREION_CONST_U8_64(keys), AREION_CONST_U8_32(msgs))
#define areion_em_decrypt256x4(out, keys, ct) \
    (areion_em_decrypt256x4)((out), AREION_CONST_U8_64(keys), AREION_CONST_U8_32(ct))
#define areion_em_encrypt512x4(out, keys, msgs) \
    (areion_em_encrypt512x4)((out), AREION_CONST_U8_128(keys), AREION_CONST_U8_64(msgs))
#define areion_em_decrypt512x4(out, keys, ct) \
    (areion_em_decrypt512x4)((out), AREION_CONST_U8_128(keys), AREION_CONST_U8_64(ct))
#define areion_em2_encrypt256x4(out, keys, msgs) \
    (areion_em2_encrypt256x4)((out), AREION_CONST_U8_64(keys), AREION_CONST_U8_32(msgs))
#define areion_em2_decrypt256x4(out, keys, ct) \
    (areion_em2_decrypt256x4)((out), AREION_CONST_U8_64(keys), AREION_CONST_U8_32(ct))
#define areion_em2_encrypt512x4(out, keys, msgs) \
    (areion_em2_encrypt512x4)((out), AREION_CONST_U8_128(keys), AREION_CONST_U8_64(msgs))
#define areion_em2_decrypt512x4(out, keys, ct) \
    (areion_em2_decrypt512x4)((out), AREION_CONST_U8_128(keys), AREION_CONST_U8_64(ct))
#define areion_tem_encrypt256x4(out, keys, tweaks, msgs) \
    (areion_tem_encrypt256x4)((out), AREION_CONST_U8_64(keys), AREION_CONST_U8_32(tweaks), AREION_CONST_U8_32(msgs))
#define areion_tem_decrypt256x4(out, keys, tweaks, ct) \
    (areion_tem_decrypt256x4)((out), AREION_CONST_U8_64(keys), AREION_CONST_U8_32(tweaks), AREION_CONST_U8_32(ct))
#define areion_tem_encrypt512x4(out, keys, tweaks, msgs) \
    (areion_tem_encrypt512x4)((out), AREION_CONST_U8_128(keys), AREION_CONST_U8_64(tweaks), AREION_CONST_U8_64(msgs))
#define areion_tem_decrypt512x4(out, keys, tweaks, ct) \
    (areion_tem_decrypt512x4)((out), AREION_CONST_U8_128(keys), AREION_CONST_U8_64(tweaks), AREION_CONST_U8_64(ct))
#define areion_tem2_encrypt256x4(out, keys, tweaks, msgs) \
    (areion_tem2_encrypt256x4)((out), AREION_CONST_U8_64(keys), AREION_CONST_U8_32(tweaks), AREION_CONST_U8_32(msgs))
#define areion_tem2_decrypt256x4(out, keys, tweaks, ct) \
    (areion_tem2_decrypt256x4)((out), AREION_CONST_U8_64(keys), AREION_CONST_U8_32(tweaks), AREION_CONST_U8_32(ct))
#define areion_tem2_encrypt512x4(out, keys, tweaks, msgs) \
    (areion_tem2_encrypt512x4)((out), AREION_CONST_U8_128(keys), AREION_CONST_U8_64(tweaks), AREION_CONST_U8_64(msgs))
#define areion_tem2_decrypt512x4(out, keys, tweaks, ct) \
    (areion_tem2_decrypt512x4)((out), AREION_CONST_U8_128(keys), AREION_CONST_U8_64(tweaks), AREION_CONST_U8_64(ct))
#define areion_aes128_encrypt_block(dst, src, rk) \
    (areion_aes128_encrypt_block)((dst), (src), AREION_CONST_U8_16(rk))
#define areion_aes128_encrypt4_blocks(dst, src, rk) \
    (areion_aes128_encrypt4_blocks)((dst), AREION_CONST_U8_16(src), AREION_CONST_U8_16(rk))
#define areion_asura_encrypt(ct, pt, rtk) \
    (areion_asura_encrypt)((ct), (pt), AREION_CONST_U8_32(rtk))
#define areion_asura_decrypt(pt, ct, rtk) \
    (areion_asura_decrypt)((pt), (ct), AREION_CONST_U8_32(rtk))
#define areion_asura_encryptx4(ct, pt, rtk) \
    (areion_asura_encryptx4)((ct), AREION_CONST_U8_32(pt), AREION_CONST_U8_32(rtk))
#define areion_asura_decryptx4(pt, ct, rtk) \
    (areion_asura_decryptx4)((pt), AREION_CONST_U8_32(ct), AREION_CONST_U8_32(rtk))
#define areion_asura_encryptx4_otf(ct, pt, key, tweaks) \
    (areion_asura_encryptx4_otf)((ct), AREION_CONST_U8_32(pt), (key), AREION_CONST_U8_16(tweaks))
#define areion_asura_decryptx4_otf(pt, ct, key, tweaks) \
    (areion_asura_decryptx4_otf)((pt), AREION_CONST_U8_32(ct), (key), AREION_CONST_U8_16(tweaks))
#define areion_asura_encrypt_rk(dst, src, rk, tweak) \
    (areion_asura_encrypt_rk)((dst), (src), AREION_CONST_U8_32(rk), (tweak))
#define areion_asura_decrypt_rk(dst, src, rk, tweak) \
    (areion_asura_decrypt_rk)((dst), (src), AREION_CONST_U8_32(rk), (tweak))
#define areion_asura_encryptx4_rk(dst, src, rk, tweaks) \
    (areion_asura_encryptx4_rk)((dst), AREION_CONST_U8_32(src), AREION_CONST_U8_32(rk), AREION_CONST_U8_16(tweaks))
#define areion_asura_decryptx4_rk(dst, src, rk, tweaks) \
    (areion_asura_decryptx4_rk)((dst), AREION_CONST_U8_32(src), AREION_CONST_U8_32(rk), AREION_CONST_U8_16(tweaks))
#endif

#if defined(__clang__) && !defined(__cplusplus) && (!defined(__STDC_VERSION__) || __STDC_VERSION__ < 199901L)
#pragma clang diagnostic pop
#endif

#ifdef __cplusplus
}
#endif

#endif /* AREION_H */
