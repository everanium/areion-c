/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

#if defined(AREION_FORCE_PORTABLE) || (!defined(__x86_64__) && !defined(_M_X64) && !defined(__aarch64__) && !defined(_M_ARM64))

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

void areion_permute256(uint8_t state[32]) {
    areion_permute256_purec(state);
}

void areion_inverse_permute256(uint8_t state[32]) {
    areion_inverse_permute256_purec(state);
}

void areion_permute512(uint8_t state[64]) {
    areion_permute512_purec(state);
}

void areion_inverse_permute512(uint8_t state[64]) {
    areion_inverse_permute512_purec(state);
}

void areion_permute256_p2(uint8_t state[32]) {
    areion_permute256_p2_purec(state);
}

void areion_inverse_permute256_p2(uint8_t state[32]) {
    areion_inverse_permute256_p2_purec(state);
}

void areion_permute512_p2(uint8_t state[64]) {
    areion_permute512_p2_purec(state);
}

void areion_inverse_permute512_p2(uint8_t state[64]) {
    areion_inverse_permute512_p2_purec(state);
}

void areion_dm256(uint8_t out[32], const uint8_t in[32]) {
    areion_dm256_purec(out, in);
}

void areion_dm512(uint8_t out[32], const uint8_t in[64]) {
    areion_dm512_purec(out, in);
}

void areion_soem256(uint8_t out[32], const uint8_t key[64], const uint8_t in[32]) {
    areion_soem256_purec(out, key, in);
}

void areion_soem512(uint8_t out[64], const uint8_t key[128], const uint8_t in[64]) {
    areion_soem512_purec(out, key, in);
}

void areion_soem256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t inputs[4][32]) {
    areion_soem256x4_purec(out, keys, inputs);
}

void areion_soem512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t inputs[4][64]) {
    areion_soem512x4_purec(out, keys, inputs);
}

void areion_em_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]) {
    areion_em_encrypt256_purec(out, k, m);
}

void areion_em_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]) {
    areion_em_decrypt256_purec(out, k, c);
}

void areion_em_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]) {
    areion_em_encrypt512_purec(out, k, m);
}

void areion_em_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]) {
    areion_em_decrypt512_purec(out, k, c);
}

void areion_em_encrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]) {
    areion_em_encrypt256x4_purec(out, keys, msgs);
}

void areion_em_decrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]) {
    areion_em_decrypt256x4_purec(out, keys, ct);
}

void areion_em_encrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]) {
    areion_em_encrypt512x4_purec(out, keys, msgs);
}

void areion_em_decrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]) {
    areion_em_decrypt512x4_purec(out, keys, ct);
}

void areion_em2_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]) {
    areion_em2_encrypt256_purec(out, k, m);
}

void areion_em2_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]) {
    areion_em2_decrypt256_purec(out, k, c);
}

void areion_em2_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]) {
    areion_em2_encrypt512_purec(out, k, m);
}

void areion_em2_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]) {
    areion_em2_decrypt512_purec(out, k, c);
}

void areion_em2_encrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]) {
    areion_em2_encrypt256x4_purec(out, keys, msgs);
}

void areion_em2_decrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]) {
    areion_em2_decrypt256x4_purec(out, keys, ct);
}

void areion_em2_encrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]) {
    areion_em2_encrypt512x4_purec(out, keys, msgs);
}

void areion_em2_decrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]) {
    areion_em2_decrypt512x4_purec(out, keys, ct);
}

void areion_tem_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]) {
    areion_tem_encrypt256_purec(out, k, t, m);
}

void areion_tem_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]) {
    areion_tem_decrypt256_purec(out, k, t, c);
}

void areion_tem_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]) {
    areion_tem_encrypt512_purec(out, k, t, m);
}

void areion_tem_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]) {
    areion_tem_decrypt512_purec(out, k, t, c);
}

void areion_tem_encrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]) {
    areion_tem_encrypt256x4_purec(out, keys, tweaks, msgs);
}

void areion_tem_decrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]) {
    areion_tem_decrypt256x4_purec(out, keys, tweaks, ct);
}

void areion_tem_encrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]) {
    areion_tem_encrypt512x4_purec(out, keys, tweaks, msgs);
}

void areion_tem_decrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]) {
    areion_tem_decrypt512x4_purec(out, keys, tweaks, ct);
}

void areion_tem2_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]) {
    areion_tem2_encrypt256_purec(out, k, t, m);
}

void areion_tem2_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]) {
    areion_tem2_decrypt256_purec(out, k, t, c);
}

void areion_tem2_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]) {
    areion_tem2_encrypt512_purec(out, k, t, m);
}

void areion_tem2_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]) {
    areion_tem2_decrypt512_purec(out, k, t, c);
}

void areion_tem2_encrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]) {
    areion_tem2_encrypt256x4_purec(out, keys, tweaks, msgs);
}

void areion_tem2_decrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]) {
    areion_tem2_decrypt256x4_purec(out, keys, tweaks, ct);
}

void areion_tem2_encrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]) {
    areion_tem2_encrypt512x4_purec(out, keys, tweaks, msgs);
}

void areion_tem2_decrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]) {
    areion_tem2_decrypt512x4_purec(out, keys, tweaks, ct);
}

void areion_permute256x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    areion_permute256x4_purec(b0, b1, b2, b3);
}

void areion_permute256_p2x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    areion_permute256_p2x4_purec(b0, b1, b2, b3);
}

void areion_inverse_permute256x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    areion_inverse_permute256x4_purec(b0, b1, b2, b3);
}

void areion_inverse_permute256_p2x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    areion_inverse_permute256_p2x4_purec(b0, b1, b2, b3);
}

void areion_permute512x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    areion_permute512x4_purec(b0, b1, b2, b3);
}

void areion_permute512_p2x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    areion_permute512_p2x4_purec(b0, b1, b2, b3);
}

void areion_inverse_permute512x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    areion_inverse_permute512x4_purec(b0, b1, b2, b3);
}

void areion_inverse_permute512_p2x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    areion_inverse_permute512_p2x4_purec(b0, b1, b2, b3);
}

void areion_round(const uint32_t in[4], uint32_t out[4]) {
    areion_round_purec(in, out);
}

void areion_final_round(const uint32_t in[4], uint32_t out[4]) {
    areion_final_round_purec(in, out);
}

void areion_inv_round(const uint32_t in[4], uint32_t out[4]) {
    areion_inv_round_purec(in, out);
}

void areion_inv_final_round(const uint32_t in[4], uint32_t out[4]) {
    areion_inv_final_round_purec(in, out);
}

void areion_inv_mix_columns(const uint32_t in[4], uint32_t out[4]) {
    areion_inv_mix_columns_purec(in, out);
}

void areion_round4_hw(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16]) {
    areion_round4_purec(b0, b1, b2, b3);
}

void areion_final_round4_hw(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16]) {
    areion_final_round4_purec(b0, b1, b2, b3);
}

void areion_aes_round_hw(uint8_t block[16], const uint8_t rk[16]) {
    areion_aes_round_purec(block, rk);
}

void areion_aes_final_round_hw(uint8_t block[16], const uint8_t rk[16]) {
    areion_aes_final_round_purec(block, rk);
}

void areion_aes_round4_hw(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]) {
    areion_aes_round4_purec(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
}

void areion_aes_final_round4_hw(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]) {
    areion_aes_final_round4_purec(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
}

void areion_expand_key128(const uint8_t key[16], uint8_t rk[11][16]) {
    areion_expand_key128_purec(key, rk);
}

void areion_aes128_encrypt_block(uint8_t dst[16], const uint8_t src[16], const uint8_t rk[11][16]) {
    areion_aes128_encrypt_block_purec(dst, src, rk);
}

void areion_aes128_encrypt4_blocks(
    uint8_t dst[4][16], const uint8_t src[4][16], const uint8_t rk[11][16]) {
    areion_aes128_encrypt4_blocks_purec(dst, src, rk);
}

#else
typedef int areion_other_unused_t;
#endif
