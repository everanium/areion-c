/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

#if (defined(__x86_64__) || defined(_M_X64)) && !defined(AREION_FORCE_PORTABLE)

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
 * External Assembly Kernel Declarations (areion_*_amd64.S)
 * ========================================================================= */

extern void aesRoundAsm(uint8_t *block, const uint8_t *roundKey) AREION_INTERNAL;
extern void aesRoundVexAsm(uint8_t *block, const uint8_t *roundKey) AREION_INTERNAL;
extern void aesFinalRoundAsm(uint8_t *block, const uint8_t *roundKey) AREION_INTERNAL;
extern void aesFinalRoundVexAsm(uint8_t *block, const uint8_t *roundKey) AREION_INTERNAL;

extern void aesRoundWordsAsm(uint32_t *out, const uint32_t *in) AREION_INTERNAL;
extern void aesRoundWordsVexAsm(uint32_t *out, const uint32_t *in) AREION_INTERNAL;
extern void aesFinalRoundWordsAsm(uint32_t *out, const uint32_t *in) AREION_INTERNAL;
extern void aesFinalRoundWordsVexAsm(uint32_t *out, const uint32_t *in) AREION_INTERNAL;

extern void aesRound4ZmmAsm(uint8_t *blocks, const uint8_t *roundKeys) AREION_INTERNAL;
extern void aesFinalRound4ZmmAsm(uint8_t *blocks, const uint8_t *roundKeys) AREION_INTERNAL;
extern void aesRound4YmmAsm(uint8_t *blocks, const uint8_t *roundKeys) AREION_INTERNAL;
extern void aesFinalRound4YmmAsm(uint8_t *blocks, const uint8_t *roundKeys) AREION_INTERNAL;
extern void aesRound4VexAsm(uint8_t *blocks, const uint8_t *roundKeys) AREION_INTERNAL;
extern void aesFinalRound4VexAsm(uint8_t *blocks, const uint8_t *roundKeys) AREION_INTERNAL;
extern void aesRound4AesNiAsm(uint8_t *blocks, const uint8_t *roundKeys) AREION_INTERNAL;
extern void aesFinalRound4AesNiAsm(uint8_t *blocks, const uint8_t *roundKeys) AREION_INTERNAL;

extern void aesRound4PtrsZmmAsm(
    uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3,
    const uint8_t *rk0, const uint8_t *rk1, const uint8_t *rk2, const uint8_t *rk3) AREION_INTERNAL;
extern void aesRound4PtrsYmmAsm(
    uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3,
    const uint8_t *rk0, const uint8_t *rk1, const uint8_t *rk2, const uint8_t *rk3) AREION_INTERNAL;
extern void aesRound4PtrsVexAsm(
    uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3,
    const uint8_t *rk0, const uint8_t *rk1, const uint8_t *rk2, const uint8_t *rk3) AREION_INTERNAL;
extern void aesRound4PtrsAesNiAsm(
    uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3,
    const uint8_t *rk0, const uint8_t *rk1, const uint8_t *rk2, const uint8_t *rk3) AREION_INTERNAL;

extern void aesFinalRound4PtrsZmmAsm(
    uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3,
    const uint8_t *rk0, const uint8_t *rk1, const uint8_t *rk2, const uint8_t *rk3) AREION_INTERNAL;
extern void aesFinalRound4PtrsYmmAsm(
    uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3,
    const uint8_t *rk0, const uint8_t *rk1, const uint8_t *rk2, const uint8_t *rk3) AREION_INTERNAL;
extern void aesFinalRound4PtrsVexAsm(
    uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3,
    const uint8_t *rk0, const uint8_t *rk1, const uint8_t *rk2, const uint8_t *rk3) AREION_INTERNAL;
extern void aesFinalRound4PtrsAesNiAsm(
    uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3,
    const uint8_t *rk0, const uint8_t *rk1, const uint8_t *rk2, const uint8_t *rk3) AREION_INTERNAL;

extern void aes128ExpandKeyAsm(const uint8_t *key, uint8_t *rk) AREION_INTERNAL;
extern void aes128ExpandKeyVexAsm(const uint8_t *key, uint8_t *rk) AREION_INTERNAL;

extern void aes128EncryptBlockAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void aes128EncryptBlockVexAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void aes128Encrypt4BlocksZmmAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void aes128Encrypt4BlocksYmmAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void aes128Encrypt4BlocksVexAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void aes128Encrypt4BlocksAesNiAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;

extern void rijndael256EncryptBlockAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256EncryptBlockVexAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256Encrypt4BlocksZmmAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256Encrypt4BlocksYmmAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256Encrypt4BlocksVexAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256Encrypt4BlocksAesNiAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;

extern void vistrutah256EncryptBlockAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256EncryptBlockVexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256EncryptBlockYmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Encrypt4BlocksAesNiAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Encrypt4BlocksVexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Encrypt4BlocksYmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Encrypt4BlocksZmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;

extern void vistrutah512EncryptBlock256Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock256VexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock256YmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock256ZmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;

extern void vistrutah512EncryptBlock512Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock512VexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock512YmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock512ZmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;

extern void vistrutah512Encrypt4Blocks256AesNiAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks256VexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks256YmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks256ZmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;

extern void vistrutah512Encrypt4Blocks512AesNiAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks512VexAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks512YmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks512ZmmAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;

extern void areion256PermuteRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;
extern void areion256PermuteVexRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;
extern void areion256InversePermuteRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;
extern void areion256InversePermuteVexRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;

extern void areion512PermuteRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;
extern void areion512PermuteVexRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;
extern void areion512InversePermuteRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;
extern void areion512InversePermuteVexRCAsm(uint8_t *state, const uint8_t *rc) AREION_INTERNAL;

extern void areion256DMAsm(uint8_t *out, const uint8_t *in) AREION_INTERNAL;
extern void areion256DMVexAsm(uint8_t *out, const uint8_t *in) AREION_INTERNAL;
extern void areion512DMAsm(uint8_t *out, const uint8_t *in) AREION_INTERNAL;
extern void areion512DMVexAsm(uint8_t *out, const uint8_t *in) AREION_INTERNAL;

extern void areionSoEM256Asm(uint8_t *out, const uint8_t *key, const uint8_t *m) AREION_INTERNAL;
extern void areionSoEM256VexAsm(uint8_t *out, const uint8_t *key, const uint8_t *m) AREION_INTERNAL;

extern void areionSoEM512Asm(uint8_t *out, const uint8_t *key, const uint8_t *m) AREION_INTERNAL;
extern void areionSoEM512VexAsm(uint8_t *out, const uint8_t *key, const uint8_t *m) AREION_INTERNAL;

extern void areion256Permutex4RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion256InversePermutex4RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion256Permutex4Avx2RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion256InversePermutex4Avx2RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion256Permutex4VexRC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion256InversePermutex4VexRC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion256Permutex4AesNiRC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion256InversePermutex4AesNiRC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;

extern void areion512Permutex4RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion512InversePermutex4RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion512Permutex4Avx2RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion512InversePermutex4Avx2RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion512Permutex4VexRC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion512InversePermutex4VexRC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion512Permutex4AesNiRC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion512InversePermutex4AesNiRC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;

extern void areion256SoEMPermutex4Interleaved(uint8_t *out, const uint8_t *in, const uint8_t *k) AREION_INTERNAL;
extern void areion256SoEMPermutex4VaesAvx2(uint8_t *out, const uint8_t *in, const uint8_t *k) AREION_INTERNAL;
extern void areion256SoEMPermutex4Vex(uint8_t *out, const uint8_t *in, const uint8_t *k) AREION_INTERNAL;
extern void areion256SoEMPermutex4AesNi(uint8_t *out, const uint8_t *in, const uint8_t *k) AREION_INTERNAL;

extern void areion512SoEMPermutex4Interleaved(uint8_t *out, const uint8_t *in, const uint8_t *k) AREION_INTERNAL;
extern void areion512SoEMPermutex4VaesAvx2(uint8_t *out, const uint8_t *in, const uint8_t *k) AREION_INTERNAL;
extern void areion512SoEMPermutex4Vex(uint8_t *out, const uint8_t *in, const uint8_t *k) AREION_INTERNAL;
extern void areion512SoEMPermutex4AesNi(uint8_t *out, const uint8_t *in, const uint8_t *k) AREION_INTERNAL;

extern void areion256EMEncryptAESNI(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EMEncryptVEX(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EMDecryptAESNI(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion256EMDecryptVEX(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMEncryptAESNI(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMEncryptVEX(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMDecryptAESNI(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMDecryptVEX(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;

extern void areion256EM2EncryptAESNI(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2EncryptVEX(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2DecryptAESNI(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2DecryptVEX(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2EncryptAESNI(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2EncryptVEX(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2DecryptAESNI(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2DecryptVEX(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;

extern void areion256TEMEncryptAESNI(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEMEncryptVEX(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEMDecryptAESNI(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEMDecryptVEX(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMEncryptAESNI(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMEncryptVEX(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMDecryptAESNI(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMDecryptVEX(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;

extern void areion256TEM2EncryptAESNI(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2EncryptVEX(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2DecryptAESNI(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2DecryptVEX(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2EncryptAESNI(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2EncryptVEX(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2DecryptAESNI(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2DecryptVEX(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;

extern void areion256EMEncryptx4AESNI(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EMEncryptx4VEX(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EMEncryptx4VAESAVX2(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EMEncryptx4AVX512(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EMDecryptx4AESNI(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion256EMDecryptx4VEX(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion256EMDecryptx4VAESAVX2(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion256EMDecryptx4AVX512(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;

extern void areion512EMEncryptx4AESNI(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMEncryptx4VEX(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMEncryptx4VAESAVX2(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMEncryptx4AVX512(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMDecryptx4AESNI(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMDecryptx4VEX(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMDecryptx4VAESAVX2(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMDecryptx4AVX512(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;

extern void areion256EM2Encryptx4AESNI(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2Encryptx4VEX(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2Encryptx4VAESAVX2(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2Encryptx4AVX512(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2Decryptx4AESNI(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2Decryptx4VEX(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2Decryptx4VAESAVX2(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2Decryptx4AVX512(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;

extern void areion512EM2Encryptx4AESNI(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2Encryptx4VEX(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2Encryptx4VAESAVX2(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2Encryptx4AVX512(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2Decryptx4AESNI(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2Decryptx4VEX(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2Decryptx4VAESAVX2(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2Decryptx4AVX512(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;

extern void areion256TEMEncryptx4AESNI(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEMEncryptx4VEX(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEMEncryptx4VAESAVX2(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEMEncryptx4AVX512(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEMDecryptx4AESNI(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEMDecryptx4VEX(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEMDecryptx4VAESAVX2(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEMDecryptx4AVX512(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;

extern void areion512TEMEncryptx4AESNI(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMEncryptx4VEX(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMEncryptx4VAESAVX2(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMEncryptx4AVX512(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMDecryptx4AESNI(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMDecryptx4VEX(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMDecryptx4VAESAVX2(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMDecryptx4AVX512(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;

extern void areion256TEM2Encryptx4AESNI(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2Encryptx4VEX(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2Encryptx4VAESAVX2(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2Encryptx4AVX512(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2Decryptx4AESNI(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2Decryptx4VEX(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2Decryptx4VAESAVX2(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2Decryptx4AVX512(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;

extern void areion512TEM2Encryptx4AESNI(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2Encryptx4VEX(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2Encryptx4VAESAVX2(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2Encryptx4AVX512(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2Decryptx4AESNI(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2Decryptx4VEX(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2Decryptx4VAESAVX2(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2Decryptx4AVX512(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;

/* =========================================================================
 * Single-Block Permutations
 * ========================================================================= */

void areion_permute256(uint8_t state[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier >= AREION_TIER_VEX) {
        areion256PermuteVexRCAsm(state, &roundConstantsP1[0][0]);
        AREION_MSAN_UNPOISON(state, 32U);
            return;
    }
    if (tier == AREION_TIER_AESNI) {
        areion256PermuteRCAsm(state, &roundConstantsP1[0][0]);
        AREION_MSAN_UNPOISON(state, 32U);
            return;
    }
    areion_permute256_purec(state);
}

void areion_inverse_permute256(uint8_t state[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier >= AREION_TIER_VEX) {
        areion256InversePermuteVexRCAsm(state, &roundConstantsP1[0][0]);
        AREION_MSAN_UNPOISON(state, 32U);
            return;
    }
    if (tier == AREION_TIER_AESNI) {
        areion256InversePermuteRCAsm(state, &roundConstantsP1[0][0]);
        AREION_MSAN_UNPOISON(state, 32U);
            return;
    }
    areion_inverse_permute256_purec(state);
}

void areion_permute512(uint8_t state[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier >= AREION_TIER_VEX) {
        areion512PermuteVexRCAsm(state, &roundConstantsP1[0][0]);
        AREION_MSAN_UNPOISON(state, 64U);
            return;
    }
    if (tier == AREION_TIER_AESNI) {
        areion512PermuteRCAsm(state, &roundConstantsP1[0][0]);
        AREION_MSAN_UNPOISON(state, 64U);
            return;
    }
    areion_permute512_purec(state);
}

void areion_inverse_permute512(uint8_t state[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier >= AREION_TIER_VEX) {
        areion512InversePermuteVexRCAsm(state, &roundConstantsP1[0][0]);
        AREION_MSAN_UNPOISON(state, 64U);
            return;
    }
    if (tier == AREION_TIER_AESNI) {
        areion512InversePermuteRCAsm(state, &roundConstantsP1[0][0]);
        AREION_MSAN_UNPOISON(state, 64U);
            return;
    }
    areion_inverse_permute512_purec(state);
}

void areion_permute256_p2(uint8_t state[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier >= AREION_TIER_VEX) {
        areion256PermuteVexRCAsm(state, &roundConstantsP2[0][0]);
        AREION_MSAN_UNPOISON(state, 32U);
            return;
    }
    if (tier == AREION_TIER_AESNI) {
        areion256PermuteRCAsm(state, &roundConstantsP2[0][0]);
        AREION_MSAN_UNPOISON(state, 32U);
            return;
    }
    areion_permute256_p2_purec(state);
}

void areion_inverse_permute256_p2(uint8_t state[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier >= AREION_TIER_VEX) {
        areion256InversePermuteVexRCAsm(state, &roundConstantsP2[0][0]);
        AREION_MSAN_UNPOISON(state, 32U);
            return;
    }
    if (tier == AREION_TIER_AESNI) {
        areion256InversePermuteRCAsm(state, &roundConstantsP2[0][0]);
        AREION_MSAN_UNPOISON(state, 32U);
            return;
    }
    areion_inverse_permute256_p2_purec(state);
}

void areion_permute512_p2(uint8_t state[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier >= AREION_TIER_VEX) {
        areion512PermuteVexRCAsm(state, &roundConstantsP2[0][0]);
        AREION_MSAN_UNPOISON(state, 64U);
            return;
    }
    if (tier == AREION_TIER_AESNI) {
        areion512PermuteRCAsm(state, &roundConstantsP2[0][0]);
        AREION_MSAN_UNPOISON(state, 64U);
            return;
    }
    areion_permute512_p2_purec(state);
}

void areion_inverse_permute512_p2(uint8_t state[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier >= AREION_TIER_VEX) {
        areion512InversePermuteVexRCAsm(state, &roundConstantsP2[0][0]);
        AREION_MSAN_UNPOISON(state, 64U);
            return;
    }
    if (tier == AREION_TIER_AESNI) {
        areion512InversePermuteRCAsm(state, &roundConstantsP2[0][0]);
        AREION_MSAN_UNPOISON(state, 64U);
            return;
    }
    areion_inverse_permute512_p2_purec(state);
}

/* =========================================================================
 * Davies-Meyer Compression Functions
 * ========================================================================= */

void areion_dm256(uint8_t out[32], const uint8_t in[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_dm256_purec(out, in);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion256DMVexAsm(out, in);
    } else {
        areion256DMAsm(out, in);
    }
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_dm512(uint8_t out[32], const uint8_t in[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_dm512_purec(out, in);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion512DMVexAsm(out, in);
    } else {
        areion512DMAsm(out, in);
    }
    AREION_MSAN_UNPOISON(out, 32U);
}

/* =========================================================================
 * Sum-of-Even-Mansour (SoEM) Single & 4-Way
 * ========================================================================= */

void areion_soem256(uint8_t out[32], const uint8_t key[64], const uint8_t in[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_soem256_purec(out, key, in);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areionSoEM256VexAsm(out, key, in);
    } else {
        areionSoEM256Asm(out, key, in);
    }
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_soem512(uint8_t out[64], const uint8_t key[128], const uint8_t in[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_soem512_purec(out, key, in);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areionSoEM512VexAsm(out, key, in);
    } else {
        areionSoEM512Asm(out, key, in);
    }
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_soem256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t inputs[4][32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_soem256x4_purec(out, keys, inputs);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion256SoEMPermutex4Interleaved(&out[0][0], &inputs[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion256SoEMPermutex4VaesAvx2(&out[0][0], &inputs[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion256SoEMPermutex4Vex(&out[0][0], &inputs[0][0], &keys[0][0]);
    } else {
        areion256SoEMPermutex4AesNi(&out[0][0], &inputs[0][0], &keys[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_soem512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t inputs[4][64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_soem512x4_purec(out, keys, inputs);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion512SoEMPermutex4Interleaved(&out[0][0], &inputs[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion512SoEMPermutex4VaesAvx2(&out[0][0], &inputs[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion512SoEMPermutex4Vex(&out[0][0], &inputs[0][0], &keys[0][0]);
    } else {
        areion512SoEMPermutex4AesNi(&out[0][0], &inputs[0][0], &keys[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 256U);
}

/* =========================================================================
 * 4-Way Parallel Permutations
 * ========================================================================= */

void areion_permute256x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_permute256x4_purec(b0, b1, b2, b3);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion256Permutex4RC(b0, b1, b2, b3, &areionRC4x[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion256Permutex4Avx2RC(b0, b1, b2, b3, &areionRC4x[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion256Permutex4VexRC(b0, b1, b2, b3, &areionRC4x[0][0]);
    } else {
        areion256Permutex4AesNiRC(b0, b1, b2, b3, &areionRC4x[0][0]);
    }
    AREION_MSAN_UNPOISON(b0, 32U);
    AREION_MSAN_UNPOISON(b1, 32U);
    AREION_MSAN_UNPOISON(b2, 32U);
    AREION_MSAN_UNPOISON(b3, 32U);
}

void areion_permute256_p2x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_permute256_p2x4_purec(b0, b1, b2, b3);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion256Permutex4RC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion256Permutex4Avx2RC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion256Permutex4VexRC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    } else {
        areion256Permutex4AesNiRC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    }
    AREION_MSAN_UNPOISON(b0, 32U);
    AREION_MSAN_UNPOISON(b1, 32U);
    AREION_MSAN_UNPOISON(b2, 32U);
    AREION_MSAN_UNPOISON(b3, 32U);
}

void areion_inverse_permute256x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_inverse_permute256x4_purec(b0, b1, b2, b3);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion256InversePermutex4RC(b0, b1, b2, b3, &areionRC4x[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion256InversePermutex4Avx2RC(b0, b1, b2, b3, &areionRC4x[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion256InversePermutex4VexRC(b0, b1, b2, b3, &areionRC4x[0][0]);
    } else {
        areion256InversePermutex4AesNiRC(b0, b1, b2, b3, &areionRC4x[0][0]);
    }
    AREION_MSAN_UNPOISON(b0, 32U);
    AREION_MSAN_UNPOISON(b1, 32U);
    AREION_MSAN_UNPOISON(b2, 32U);
    AREION_MSAN_UNPOISON(b3, 32U);
}

void areion_inverse_permute256_p2x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_inverse_permute256_p2x4_purec(b0, b1, b2, b3);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion256InversePermutex4RC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion256InversePermutex4Avx2RC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion256InversePermutex4VexRC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    } else {
        areion256InversePermutex4AesNiRC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    }
    AREION_MSAN_UNPOISON(b0, 32U);
    AREION_MSAN_UNPOISON(b1, 32U);
    AREION_MSAN_UNPOISON(b2, 32U);
    AREION_MSAN_UNPOISON(b3, 32U);
}

void areion_permute512x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_permute512x4_purec(b0, b1, b2, b3);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion512Permutex4RC(b0, b1, b2, b3, &areionRC4x[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion512Permutex4Avx2RC(b0, b1, b2, b3, &areionRC4x[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion512Permutex4VexRC(b0, b1, b2, b3, &areionRC4x[0][0]);
    } else {
        areion512Permutex4AesNiRC(b0, b1, b2, b3, &areionRC4x[0][0]);
    }
    AREION_MSAN_UNPOISON(b0, 64U);
    AREION_MSAN_UNPOISON(b1, 64U);
    AREION_MSAN_UNPOISON(b2, 64U);
    AREION_MSAN_UNPOISON(b3, 64U);
}

void areion_permute512_p2x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_permute512_p2x4_purec(b0, b1, b2, b3);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion512Permutex4RC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion512Permutex4Avx2RC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion512Permutex4VexRC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    } else {
        areion512Permutex4AesNiRC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    }
    AREION_MSAN_UNPOISON(b0, 64U);
    AREION_MSAN_UNPOISON(b1, 64U);
    AREION_MSAN_UNPOISON(b2, 64U);
    AREION_MSAN_UNPOISON(b3, 64U);
}

void areion_inverse_permute512x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_inverse_permute512x4_purec(b0, b1, b2, b3);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion512InversePermutex4RC(b0, b1, b2, b3, &areionRC4x[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion512InversePermutex4Avx2RC(b0, b1, b2, b3, &areionRC4x[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion512InversePermutex4VexRC(b0, b1, b2, b3, &areionRC4x[0][0]);
    } else {
        areion512InversePermutex4AesNiRC(b0, b1, b2, b3, &areionRC4x[0][0]);
    }
    AREION_MSAN_UNPOISON(b0, 64U);
    AREION_MSAN_UNPOISON(b1, 64U);
    AREION_MSAN_UNPOISON(b2, 64U);
    AREION_MSAN_UNPOISON(b3, 64U);
}

void areion_inverse_permute512_p2x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_inverse_permute512_p2x4_purec(b0, b1, b2, b3);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion512InversePermutex4RC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion512InversePermutex4Avx2RC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion512InversePermutex4VexRC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    } else {
        areion512InversePermutex4AesNiRC(b0, b1, b2, b3, &areionRC4x2[0][0]);
    }
    AREION_MSAN_UNPOISON(b0, 64U);
    AREION_MSAN_UNPOISON(b1, 64U);
    AREION_MSAN_UNPOISON(b2, 64U);
    AREION_MSAN_UNPOISON(b3, 64U);
}

/* =========================================================================
 * Wide-Block Even-Mansour (EM / EM2) and Tweakable Even-Mansour (TEM / TEM2)
 * ========================================================================= */

void areion_em_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em_encrypt256_purec(out, k, m);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion256EMEncryptVEX(out, m, k);
    } else {
        areion256EMEncryptAESNI(out, m, k);
    }
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_em_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em_decrypt256_purec(out, k, c);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion256EMDecryptVEX(out, c, k);
    } else {
        areion256EMDecryptAESNI(out, c, k);
    }
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_em_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em_encrypt512_purec(out, k, m);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion512EMEncryptVEX(out, m, k);
    } else {
        areion512EMEncryptAESNI(out, m, k);
    }
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_em_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em_decrypt512_purec(out, k, c);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion512EMDecryptVEX(out, c, k);
    } else {
        areion512EMDecryptAESNI(out, c, k);
    }
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_em_encrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em_encrypt256x4_purec(out, keys, msgs);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion256EMEncryptx4AVX512(&out[0][0], &msgs[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion256EMEncryptx4VAESAVX2(&out[0][0], &msgs[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion256EMEncryptx4VEX(&out[0][0], &msgs[0][0], &keys[0][0]);
    } else {
        areion256EMEncryptx4AESNI(&out[0][0], &msgs[0][0], &keys[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_em_decrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em_decrypt256x4_purec(out, keys, ct);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion256EMDecryptx4AVX512(&out[0][0], &ct[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion256EMDecryptx4VAESAVX2(&out[0][0], &ct[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion256EMDecryptx4VEX(&out[0][0], &ct[0][0], &keys[0][0]);
    } else {
        areion256EMDecryptx4AESNI(&out[0][0], &ct[0][0], &keys[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_em_encrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em_encrypt512x4_purec(out, keys, msgs);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion512EMEncryptx4AVX512(&out[0][0], &msgs[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion512EMEncryptx4VAESAVX2(&out[0][0], &msgs[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion512EMEncryptx4VEX(&out[0][0], &msgs[0][0], &keys[0][0]);
    } else {
        areion512EMEncryptx4AESNI(&out[0][0], &msgs[0][0], &keys[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 256U);
}

void areion_em_decrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em_decrypt512x4_purec(out, keys, ct);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion512EMDecryptx4AVX512(&out[0][0], &ct[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion512EMDecryptx4VAESAVX2(&out[0][0], &ct[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion512EMDecryptx4VEX(&out[0][0], &ct[0][0], &keys[0][0]);
    } else {
        areion512EMDecryptx4AESNI(&out[0][0], &ct[0][0], &keys[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 256U);
}

void areion_em2_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em2_encrypt256_purec(out, k, m);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion256EM2EncryptVEX(out, m, k);
    } else {
        areion256EM2EncryptAESNI(out, m, k);
    }
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_em2_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t c[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em2_decrypt256_purec(out, k, c);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion256EM2DecryptVEX(out, c, k);
    } else {
        areion256EM2DecryptAESNI(out, c, k);
    }
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_em2_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em2_encrypt512_purec(out, k, m);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion512EM2EncryptVEX(out, m, k);
    } else {
        areion512EM2EncryptAESNI(out, m, k);
    }
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_em2_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t c[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em2_decrypt512_purec(out, k, c);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion512EM2DecryptVEX(out, c, k);
    } else {
        areion512EM2DecryptAESNI(out, c, k);
    }
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_em2_encrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em2_encrypt256x4_purec(out, keys, msgs);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion256EM2Encryptx4AVX512(&out[0][0], &msgs[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion256EM2Encryptx4VAESAVX2(&out[0][0], &msgs[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion256EM2Encryptx4VEX(&out[0][0], &msgs[0][0], &keys[0][0]);
    } else {
        areion256EM2Encryptx4AESNI(&out[0][0], &msgs[0][0], &keys[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_em2_decrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em2_decrypt256x4_purec(out, keys, ct);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion256EM2Decryptx4AVX512(&out[0][0], &ct[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion256EM2Decryptx4VAESAVX2(&out[0][0], &ct[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion256EM2Decryptx4VEX(&out[0][0], &ct[0][0], &keys[0][0]);
    } else {
        areion256EM2Decryptx4AESNI(&out[0][0], &ct[0][0], &keys[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_em2_encrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em2_encrypt512x4_purec(out, keys, msgs);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion512EM2Encryptx4AVX512(&out[0][0], &msgs[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion512EM2Encryptx4VAESAVX2(&out[0][0], &msgs[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion512EM2Encryptx4VEX(&out[0][0], &msgs[0][0], &keys[0][0]);
    } else {
        areion512EM2Encryptx4AESNI(&out[0][0], &msgs[0][0], &keys[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 256U);
}

void areion_em2_decrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_em2_decrypt512x4_purec(out, keys, ct);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion512EM2Decryptx4AVX512(&out[0][0], &ct[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion512EM2Decryptx4VAESAVX2(&out[0][0], &ct[0][0], &keys[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion512EM2Decryptx4VEX(&out[0][0], &ct[0][0], &keys[0][0]);
    } else {
        areion512EM2Decryptx4AESNI(&out[0][0], &ct[0][0], &keys[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 256U);
}

void areion_tem_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem_encrypt256_purec(out, k, t, m);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion256TEMEncryptVEX(out, m, k, t);
    } else {
        areion256TEMEncryptAESNI(out, m, k, t);
    }
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_tem_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem_decrypt256_purec(out, k, t, c);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion256TEMDecryptVEX(out, c, k, t);
    } else {
        areion256TEMDecryptAESNI(out, c, k, t);
    }
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_tem_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem_encrypt512_purec(out, k, t, m);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion512TEMEncryptVEX(out, m, k, t);
    } else {
        areion512TEMEncryptAESNI(out, m, k, t);
    }
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_tem_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem_decrypt512_purec(out, k, t, c);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion512TEMDecryptVEX(out, c, k, t);
    } else {
        areion512TEMDecryptAESNI(out, c, k, t);
    }
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_tem_encrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem_encrypt256x4_purec(out, keys, tweaks, msgs);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion256TEMEncryptx4AVX512(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion256TEMEncryptx4VAESAVX2(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion256TEMEncryptx4VEX(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    } else {
        areion256TEMEncryptx4AESNI(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_tem_decrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem_decrypt256x4_purec(out, keys, tweaks, ct);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion256TEMDecryptx4AVX512(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion256TEMDecryptx4VAESAVX2(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion256TEMDecryptx4VEX(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    } else {
        areion256TEMDecryptx4AESNI(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_tem_encrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem_encrypt512x4_purec(out, keys, tweaks, msgs);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion512TEMEncryptx4AVX512(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion512TEMEncryptx4VAESAVX2(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion512TEMEncryptx4VEX(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    } else {
        areion512TEMEncryptx4AESNI(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 256U);
}

void areion_tem_decrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem_decrypt512x4_purec(out, keys, tweaks, ct);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion512TEMDecryptx4AVX512(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion512TEMDecryptx4VAESAVX2(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion512TEMDecryptx4VEX(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    } else {
        areion512TEMDecryptx4AESNI(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 256U);
}

void areion_tem2_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem2_encrypt256_purec(out, k, t, m);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion256TEM2EncryptVEX(out, m, k, t);
    } else {
        areion256TEM2EncryptAESNI(out, m, k, t);
    }
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_tem2_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem2_decrypt256_purec(out, k, t, c);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion256TEM2DecryptVEX(out, c, k, t);
    } else {
        areion256TEM2DecryptAESNI(out, c, k, t);
    }
    AREION_MSAN_UNPOISON(out, 32U);
}

void areion_tem2_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem2_encrypt512_purec(out, k, t, m);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion512TEM2EncryptVEX(out, m, k, t);
    } else {
        areion512TEM2EncryptAESNI(out, m, k, t);
    }
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_tem2_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem2_decrypt512_purec(out, k, t, c);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        areion512TEM2DecryptVEX(out, c, k, t);
    } else {
        areion512TEM2DecryptAESNI(out, c, k, t);
    }
    AREION_MSAN_UNPOISON(out, 64U);
}

void areion_tem2_encrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem2_encrypt256x4_purec(out, keys, tweaks, msgs);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion256TEM2Encryptx4AVX512(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion256TEM2Encryptx4VAESAVX2(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion256TEM2Encryptx4VEX(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    } else {
        areion256TEM2Encryptx4AESNI(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_tem2_decrypt256x4(
    uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem2_decrypt256x4_purec(out, keys, tweaks, ct);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion256TEM2Decryptx4AVX512(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion256TEM2Decryptx4VAESAVX2(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion256TEM2Decryptx4VEX(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    } else {
        areion256TEM2Decryptx4AESNI(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 128U);
}

void areion_tem2_encrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem2_encrypt512x4_purec(out, keys, tweaks, msgs);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion512TEM2Encryptx4AVX512(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion512TEM2Encryptx4VAESAVX2(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion512TEM2Encryptx4VEX(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    } else {
        areion512TEM2Encryptx4AESNI(&out[0][0], &msgs[0][0], &keys[0][0], &tweaks[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 256U);
}

void areion_tem2_decrypt512x4(
    uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_tem2_decrypt512x4_purec(out, keys, tweaks, ct);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        areion512TEM2Decryptx4AVX512(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        areion512TEM2Decryptx4VAESAVX2(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        areion512TEM2Decryptx4VEX(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    } else {
        areion512TEM2Decryptx4AESNI(&out[0][0], &ct[0][0], &keys[0][0], &tweaks[0][0]);
    }
    AREION_MSAN_UNPOISON(out, 256U);
}

/* =========================================================================
 * AES Round Primitives & AES-128 Block Helpers
 * ========================================================================= */

void areion_round(const uint32_t in[4], uint32_t out[4]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_round_purec(in, out);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        aesRoundWordsVexAsm(out, in);
    } else {
        aesRoundWordsAsm(out, in);
    }
    AREION_MSAN_UNPOISON(out, 16U);
}

void areion_final_round(const uint32_t in[4], uint32_t out[4]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_final_round_purec(in, out);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        aesFinalRoundWordsVexAsm(out, in);
    } else {
        aesFinalRoundWordsAsm(out, in);
    }
    AREION_MSAN_UNPOISON(out, 16U);
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

void areion_aes_round_hw(uint8_t block[16], const uint8_t rk[16]) {
    areion_tier_t tier = areion_tier_code();
    if (tier >= AREION_TIER_VEX) {
        aesRoundVexAsm(block, rk);
        AREION_MSAN_UNPOISON(block, 16U);
            return;
    }
    if (tier == AREION_TIER_AESNI) {
        aesRoundAsm(block, rk);
        AREION_MSAN_UNPOISON(block, 16U);
            return;
    }
    areion_aes_round_purec(block, rk);
}

void areion_aes_final_round_hw(uint8_t block[16], const uint8_t rk[16]) {
    areion_tier_t tier = areion_tier_code();
    if (tier >= AREION_TIER_VEX) {
        aesFinalRoundVexAsm(block, rk);
        AREION_MSAN_UNPOISON(block, 16U);
            return;
    }
    if (tier == AREION_TIER_AESNI) {
        aesFinalRoundAsm(block, rk);
        AREION_MSAN_UNPOISON(block, 16U);
            return;
    }
    areion_aes_final_round_purec(block, rk);
}

void areion_round4_hw(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16]) {
    static const uint8_t zero_rk[16] = {0};
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_round4_purec(b0, b1, b2, b3);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        aesRound4PtrsZmmAsm(b0, b1, b2, b3, zero_rk, zero_rk, zero_rk, zero_rk);
    } else if (tier == AREION_TIER_VAESAVX2) {
        aesRound4PtrsYmmAsm(b0, b1, b2, b3, zero_rk, zero_rk, zero_rk, zero_rk);
    } else if (tier == AREION_TIER_VEX) {
        aesRound4PtrsVexAsm(b0, b1, b2, b3, zero_rk, zero_rk, zero_rk, zero_rk);
    } else {
        aesRound4PtrsAesNiAsm(b0, b1, b2, b3, zero_rk, zero_rk, zero_rk, zero_rk);
    }
    AREION_MSAN_UNPOISON(b0, 16U);
    AREION_MSAN_UNPOISON(b1, 16U);
    AREION_MSAN_UNPOISON(b2, 16U);
    AREION_MSAN_UNPOISON(b3, 16U);
}

void areion_final_round4_hw(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16]) {
    static const uint8_t zero_rk[16] = {0};
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_final_round4_purec(b0, b1, b2, b3);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        aesFinalRound4PtrsZmmAsm(b0, b1, b2, b3, zero_rk, zero_rk, zero_rk, zero_rk);
    } else if (tier == AREION_TIER_VAESAVX2) {
        aesFinalRound4PtrsYmmAsm(b0, b1, b2, b3, zero_rk, zero_rk, zero_rk, zero_rk);
    } else if (tier == AREION_TIER_VEX) {
        aesFinalRound4PtrsVexAsm(b0, b1, b2, b3, zero_rk, zero_rk, zero_rk, zero_rk);
    } else {
        aesFinalRound4PtrsAesNiAsm(b0, b1, b2, b3, zero_rk, zero_rk, zero_rk, zero_rk);
    }
    AREION_MSAN_UNPOISON(b0, 16U);
    AREION_MSAN_UNPOISON(b1, 16U);
    AREION_MSAN_UNPOISON(b2, 16U);
    AREION_MSAN_UNPOISON(b3, 16U);
}

void areion_aes_round4_hw(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_aes_round4_purec(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        aesRound4PtrsZmmAsm(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
    } else if (tier == AREION_TIER_VAESAVX2) {
        aesRound4PtrsYmmAsm(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
    } else if (tier == AREION_TIER_VEX) {
        aesRound4PtrsVexAsm(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
    } else {
        aesRound4PtrsAesNiAsm(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
    }
    AREION_MSAN_UNPOISON(b0, 16U);
    AREION_MSAN_UNPOISON(b1, 16U);
    AREION_MSAN_UNPOISON(b2, 16U);
    AREION_MSAN_UNPOISON(b3, 16U);
}

void areion_aes_final_round4_hw(
    uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16],
    const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_aes_final_round4_purec(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        aesFinalRound4PtrsZmmAsm(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
    } else if (tier == AREION_TIER_VAESAVX2) {
        aesFinalRound4PtrsYmmAsm(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
    } else if (tier == AREION_TIER_VEX) {
        aesFinalRound4PtrsVexAsm(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
    } else {
        aesFinalRound4PtrsAesNiAsm(b0, b1, b2, b3, rk0, rk1, rk2, rk3);
    }
    AREION_MSAN_UNPOISON(b0, 16U);
    AREION_MSAN_UNPOISON(b1, 16U);
    AREION_MSAN_UNPOISON(b2, 16U);
    AREION_MSAN_UNPOISON(b3, 16U);
}

void areion_expand_key128(const uint8_t key[16], uint8_t rk[11][16]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_expand_key128_purec(key, rk);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        aes128ExpandKeyVexAsm(key, &rk[0][0]);
    } else {
        aes128ExpandKeyAsm(key, &rk[0][0]);
    }
    AREION_MSAN_UNPOISON(rk, 176U);
}

void areion_aes128_encrypt_block(uint8_t dst[16], const uint8_t src[16], const uint8_t rk[11][16]) {
    areion_tier_t tier = areion_tier_code();
    if (tier >= AREION_TIER_VEX) {
        aes128EncryptBlockVexAsm(&rk[0][0], dst, src);
        AREION_MSAN_UNPOISON(dst, 16U);
            return;
    }
    if (tier == AREION_TIER_AESNI) {
        aes128EncryptBlockAsm(&rk[0][0], dst, src);
        AREION_MSAN_UNPOISON(dst, 16U);
            return;
    }
    areion_aes128_encrypt_block_purec(dst, src, rk);
}

void areion_aes128_encrypt4_blocks(
    uint8_t dst[4][16], const uint8_t src[4][16], const uint8_t rk[11][16]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_AVX512) {
        aes128Encrypt4BlocksZmmAsm(&rk[0][0], &dst[0][0], &src[0][0]);
        AREION_MSAN_UNPOISON(dst, 64U);
            return;
    }
    if (tier == AREION_TIER_VAESAVX2) {
        aes128Encrypt4BlocksYmmAsm(&rk[0][0], &dst[0][0], &src[0][0]);
        AREION_MSAN_UNPOISON(dst, 64U);
            return;
    }
    if (tier == AREION_TIER_VEX) {
        aes128Encrypt4BlocksVexAsm(&rk[0][0], &dst[0][0], &src[0][0]);
        AREION_MSAN_UNPOISON(dst, 64U);
            return;
    }
    if (tier == AREION_TIER_AESNI) {
        aes128Encrypt4BlocksAesNiAsm(&rk[0][0], &dst[0][0], &src[0][0]);
        AREION_MSAN_UNPOISON(dst, 64U);
            return;
    }
    areion_aes128_encrypt4_blocks_purec(dst, src, rk);
}

void areion_rijndael256_encrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t rk[15][32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_rijndael256_encrypt_block_purec(dst, src, rk);
        return;
    }
    if (tier >= AREION_TIER_VEX) {
        rijndael256EncryptBlockVexAsm(&rk[0][0], dst, src);
    } else {
        rijndael256EncryptBlockAsm(&rk[0][0], dst, src);
    }
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_rijndael256_encrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t rk[15][32]) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC) {
        areion_rijndael256_encrypt4_blocks_purec(dst, src, rk);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        rijndael256Encrypt4BlocksZmmAsm(&rk[0][0], &dst[0][0], &src[0][0]);
    } else if (tier == AREION_TIER_VAESAVX2) {
        rijndael256Encrypt4BlocksYmmAsm(&rk[0][0], &dst[0][0], &src[0][0]);
    } else if (tier == AREION_TIER_VEX) {
        rijndael256Encrypt4BlocksVexAsm(&rk[0][0], &dst[0][0], &src[0][0]);
    } else {
        rijndael256Encrypt4BlocksAesNiAsm(&rk[0][0], &dst[0][0], &src[0][0]);
    }
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_vistrutah256_encrypt_block_hw(
    uint8_t dst[32], const uint8_t src[32], const uint8_t key[32], int rounds) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 14)) {
        areion_vistrutah256_encrypt_block_purec(dst, src, key, rounds);
        return;
    }
    if (tier >= AREION_TIER_VAESAVX2) {
        vistrutah256EncryptBlockYmmAsm(dst, src, key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah256EncryptBlockVexAsm(dst, src, key, (int64_t)rounds);
    } else {
        vistrutah256EncryptBlockAsm(dst, src, key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 32U);
}

void areion_vistrutah256_encrypt4_blocks_hw(
    uint8_t dst[4][32], const uint8_t src[4][32], const uint8_t key[32], int rounds) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 14)) {
        areion_vistrutah256_encrypt4_blocks_purec(dst, src, key, rounds);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        vistrutah256Encrypt4BlocksZmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VAESAVX2) {
        vistrutah256Encrypt4BlocksYmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah256Encrypt4BlocksVexAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else {
        vistrutah256Encrypt4BlocksAesNiAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 128U);
}

void areion_vistrutah512_encrypt_block_256_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[32], int rounds) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt_block_256_purec(dst, src, key, rounds);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        vistrutah512EncryptBlock256ZmmAsm(dst, src, key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VAESAVX2) {
        vistrutah512EncryptBlock256YmmAsm(dst, src, key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah512EncryptBlock256VexAsm(dst, src, key, (int64_t)rounds);
    } else {
        vistrutah512EncryptBlock256Asm(dst, src, key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 64U);
}

void areion_vistrutah512_encrypt_block_512_hw(
    uint8_t dst[64], const uint8_t src[64], const uint8_t key[64], int rounds) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt_block_512_purec(dst, src, key, rounds);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        vistrutah512EncryptBlock512ZmmAsm(dst, src, key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VAESAVX2) {
        vistrutah512EncryptBlock512YmmAsm(dst, src, key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah512EncryptBlock512VexAsm(dst, src, key, (int64_t)rounds);
    } else {
        vistrutah512EncryptBlock512Asm(dst, src, key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 64U);
}

void areion_vistrutah512_encrypt4_blocks_256_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[32], int rounds) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt4_blocks_256_purec(dst, src, key, rounds);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        vistrutah512Encrypt4Blocks256ZmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VAESAVX2) {
        vistrutah512Encrypt4Blocks256YmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah512Encrypt4Blocks256VexAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else {
        vistrutah512Encrypt4Blocks256AesNiAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 256U);
}

void areion_vistrutah512_encrypt4_blocks_512_hw(
    uint8_t dst[4][64], const uint8_t src[4][64], const uint8_t key[64], int rounds) {
    areion_tier_t tier = areion_tier_code();
    if (tier == AREION_TIER_PUREC || (rounds != 10 && rounds != 12 && rounds != 14 && rounds != 18)) {
        areion_vistrutah512_encrypt4_blocks_512_purec(dst, src, key, rounds);
        return;
    }
    if (tier == AREION_TIER_AVX512) {
        vistrutah512Encrypt4Blocks512ZmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VAESAVX2) {
        vistrutah512Encrypt4Blocks512YmmAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else if (tier == AREION_TIER_VEX) {
        vistrutah512Encrypt4Blocks512VexAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    } else {
        vistrutah512Encrypt4Blocks512AesNiAsm(&dst[0][0], &src[0][0], key, (int64_t)rounds);
    }
    AREION_MSAN_UNPOISON(dst, 256U);
}

#else
typedef int areion_amd64_unused_t;
#endif
