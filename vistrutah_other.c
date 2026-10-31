/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

#if defined(AREION_FORCE_PORTABLE) || \
    (!defined(__x86_64__) && !defined(_M_X64) && !defined(__aarch64__) && !defined(_M_ARM64))

void areion_vistrutah256_encrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds) {
    areion_vistrutah256_encrypt_block_purec(dst, src, key, rounds);
}

void areion_vistrutah256_decrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds) {
    areion_vistrutah256_decrypt_block_purec(dst, src, key, rounds);
}

void areion_vistrutah256_encrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds) {
    areion_vistrutah256_encrypt4_blocks_purec(dst, src, key, rounds);
}

void areion_vistrutah256_decrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds) {
    areion_vistrutah256_decrypt4_blocks_purec(dst, src, key, rounds);
}

void areion_vistrutah512_encrypt_block_256_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds) {
    areion_vistrutah512_encrypt_block_256_purec(dst, src, key, rounds);
}

void areion_vistrutah512_decrypt_block_256_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds) {
    areion_vistrutah512_decrypt_block_256_purec(dst, src, key, rounds);
}

void areion_vistrutah512_encrypt_block_512_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds) {
    areion_vistrutah512_encrypt_block_512_purec(dst, src, key, rounds);
}

void areion_vistrutah512_decrypt_block_512_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds) {
    areion_vistrutah512_decrypt_block_512_purec(dst, src, key, rounds);
}

void areion_vistrutah512_encrypt4_blocks_256_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds) {
    areion_vistrutah512_encrypt4_blocks_256_purec(dst, src, key, rounds);
}

void areion_vistrutah512_decrypt4_blocks_256_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds) {
    areion_vistrutah512_decrypt4_blocks_256_purec(dst, src, key, rounds);
}

void areion_vistrutah512_encrypt4_blocks_512_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds) {
    areion_vistrutah512_encrypt4_blocks_512_purec(dst, src, key, rounds);
}

void areion_vistrutah512_decrypt4_blocks_512_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds) {
    areion_vistrutah512_decrypt4_blocks_512_purec(dst, src, key, rounds);
}

#else
typedef int areion_vistrutah_other_unused_t;
#endif
