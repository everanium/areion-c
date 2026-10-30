/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

#undef areion_asura_encrypt
#undef areion_asura_decrypt
#undef areion_asura_encryptx4
#undef areion_asura_decryptx4
#undef areion_asura_encryptx4_otf
#undef areion_asura_decryptx4_otf
#undef areion_asura_encrypt_rk
#undef areion_asura_decrypt_rk
#undef areion_asura_encryptx4_rk
#undef areion_asura_decryptx4_rk

#if defined(AREION_FORCE_PORTABLE) || \
    (!defined(__x86_64__) && !defined(_M_X64) && !defined(__aarch64__) && !defined(_M_ARM64))

void areion_asura_expand_tweakey(
    uint8_t rk[13][32], const uint8_t key[32], const uint8_t tweak[16]) {
    areion_asura_expand_tweakey_soft(rk, key, tweak);
}

void areion_asura_encrypt(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]) {
    areion_asura_encrypt_block_soft(dst, src, rk);
}

void areion_asura_decrypt(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32]) {
    areion_asura_decrypt_block_soft(dst, src, rk);
}

void areion_asura_encryptx4(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]) {
    areion_asura_encrypt_4blocks_soft(dst, src, rk);
}

void areion_asura_decryptx4(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32]) {
    areion_asura_decrypt_4blocks_soft(dst, src, rk);
}

void areion_asura_encrypt_otf(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]) {
    areion_asura_encrypt_block_otf_soft(dst, src, key, tweak);
}

void areion_asura_decrypt_otf(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], const uint8_t tweak[16]) {
    areion_asura_decrypt_block_otf_soft(dst, src, key, tweak);
}

void areion_asura_encryptx4_otf(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweaks[4][16]) {
    areion_asura_encrypt_4blocks_otf_soft(dst, src, key, tweaks);
}

void areion_asura_decryptx4_otf(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], const uint8_t tweaks[4][16]) {
    areion_asura_decrypt_4blocks_otf_soft(dst, src, key, tweaks);
}

void areion_asura_expand_key(
    uint8_t rk[13][32], const uint8_t key[32]) {
    areion_asura_expand_key_soft(rk, key);
}

void areion_asura_encrypt_rk(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32], const uint8_t tweak[16]) {
    areion_asura_encrypt_block_rk_soft(dst, src, rk, tweak);
}

void areion_asura_decrypt_rk(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[13][32], const uint8_t tweak[16]) {
    areion_asura_decrypt_block_rk_soft(dst, src, rk, tweak);
}

void areion_asura_encryptx4_rk(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32], const uint8_t tweaks[4][16]) {
    areion_asura_encrypt_4blocks_rk_soft(dst, src, rk, tweaks);
}

void areion_asura_decryptx4_rk(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[13][32], const uint8_t tweaks[4][16]) {
    areion_asura_decrypt_4blocks_rk_soft(dst, src, rk, tweaks);
}

#else
typedef int areion_asura_other_unused_t;
#endif
