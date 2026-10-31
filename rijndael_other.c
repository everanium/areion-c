/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

#if defined(AREION_FORCE_PORTABLE) || \
    (!defined(__x86_64__) && !defined(_M_X64) && !defined(__aarch64__) && !defined(_M_ARM64))

void areion_rijndael256_encrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[15][32]) {
    areion_rijndael256_encrypt_block_purec(dst, src, rk);
}

void areion_rijndael256_decrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t drk[15][32]) {
    areion_rijndael256_decrypt_block_purec(dst, src, drk);
}

void areion_rijndael256_encrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[15][32]) {
    areion_rijndael256_encrypt4_blocks_purec(dst, src, rk);
}

void areion_rijndael256_decrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t drk[15][32]) {
    areion_rijndael256_decrypt4_blocks_purec(dst, src, drk);
}

#else
typedef int areion_rijndael_other_unused_t;
#endif
