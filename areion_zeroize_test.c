/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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

#define AREION_RESIDUE_PAD_WORDS   256U
#define AREION_RESIDUE_WINDOW      (16UL * 1024UL)
#define AREION_STACK_WORDS         (AREION_RESIDUE_WINDOW / 8UL)
#define AREION_SIMD_WORDS          96U
#define AREION_TOTAL_WORDS         (AREION_STACK_WORDS + AREION_SIMD_WORDS)
#define AREION_RESIDUE_SENTINEL    0x5A5A5A5A5A5A5A5AULL
#define AREION_MAX_TARGETS         256U

#if defined(__SANITIZE_ADDRESS__) || __has_feature(address_sanitizer) || __has_feature(memory_sanitizer)
#define AREION_SANITIZER_NO_STACK_PROBE 1
#else
#define AREION_SANITIZER_NO_STACK_PROBE 0
#endif

static int g_zeroize_failures = 0;
static volatile uint64_t g_areion_sink = 0;

#if !defined(AREION_FORCE_PORTABLE) && (defined(__x86_64__) || defined(_M_X64) || defined(__aarch64__) || defined(_M_ARM64))
#define AREION_HAS_ASM_TEST_HELPERS 1
extern void dumpSIMDRegs(uint64_t *dst, int has_avx512) AREION_INTERNAL;
extern void dirtySIMDRegForTest(uint64_t masked) AREION_INTERNAL;
#else
#define AREION_HAS_ASM_TEST_HELPERS 0
static void dumpSIMDRegs(uint64_t *dst, int has_avx512) {
    (void)has_avx512;
    memset(dst, 0, AREION_SIMD_WORDS * sizeof(uint64_t));
}
#endif

#if !defined(AREION_FORCE_PORTABLE) && (defined(__x86_64__) || defined(_M_X64))
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
#elif !defined(AREION_FORCE_PORTABLE) && (defined(__aarch64__) || defined(_M_ARM64))
extern void areion256Permutex4RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion256InversePermutex4RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion512Permutex4RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion512InversePermutex4RC(uint8_t *b0, uint8_t *b1, uint8_t *b2, uint8_t *b3, const uint8_t *rc) AREION_INTERNAL;
extern void areion256SoEMPermutex4NEON(uint8_t *out, const uint8_t *in, const uint8_t *k) AREION_INTERNAL;
extern void areion512SoEMPermutex4NEON(uint8_t *out, const uint8_t *in, const uint8_t *k) AREION_INTERNAL;
extern void areion256EMEncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EMDecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMEncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMDecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2EncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2DecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2EncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2DecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion256TEMEncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEMDecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMEncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMDecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2EncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2DecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2EncryptAsm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2DecryptAsm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256EMEncryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EMDecryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMEncryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EMDecryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2Encryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion256EM2Decryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2Encryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k) AREION_INTERNAL;
extern void areion512EM2Decryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k) AREION_INTERNAL;
extern void areion256TEMEncryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEMDecryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMEncryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEMDecryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2Encryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion256TEM2Decryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2Encryptx4Asm(uint8_t *out, const uint8_t *m, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void areion512TEM2Decryptx4Asm(uint8_t *out, const uint8_t *c, const uint8_t *k, const uint8_t *t) AREION_INTERNAL;
extern void rijndael256EncryptBlockAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void rijndael256Encrypt4BlocksAsm(const uint8_t *rk, uint8_t *dst, const uint8_t *src) AREION_INTERNAL;
extern void vistrutah256EncryptBlockAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah256Encrypt4BlocksAsm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock256Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512EncryptBlock512Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks256Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
extern void vistrutah512Encrypt4Blocks512Asm(uint8_t *dst, const uint8_t *src, const uint8_t *key, int64_t rounds) AREION_INTERNAL;
#endif

typedef void (*areion_probe_cb_t)(const void *ctx);

/* =========================================================================
 * 16 KiB Stack Sentinel Window & Register Residue Harness
 * ========================================================================= */

#if !AREION_SANITIZER_NO_STACK_PROBE
static AREION_NOINLINE uintptr_t seed_or_read_stack_window(int read_mode, uint64_t out[AREION_STACK_WORDS]) {
    volatile uint64_t window[AREION_STACK_WORDS];
    volatile uintptr_t addr = (uintptr_t)&window[0];
    size_t i;
    if (read_mode == 0) {
        for (i = 0; i < AREION_STACK_WORDS; i++) {
            window[i] = AREION_RESIDUE_SENTINEL;
        }
    } else {
#if (defined(__GNUC__) || defined(__clang__)) && defined(__x86_64__)
        {
            /* Tell Valgrind Memcheck that the stack window being inspected is defined. */
            volatile unsigned long vg_args[6];
            unsigned long vg_res = 0UL;
            vg_args[0] = 0x4d430002UL; /* VG_USERREQ__MAKE_MEM_DEFINED */
            vg_args[1] = (unsigned long)addr;
            vg_args[2] = (unsigned long)sizeof(window);
            vg_args[3] = 0UL;
            vg_args[4] = 0UL;
            vg_args[5] = 0UL;
            __asm__ __volatile__(
                "rolq $3,  %%rdi ; rolq $13, %%rdi\n\t"
                "rolq $61, %%rdi ; rolq $51, %%rdi\n\t"
                "xchgq %%rbx, %%rbx"
                : "=d"(vg_res)
                : "a"(&vg_args[0]), "0"(0UL)
                : "cc", "memory");
            (void)vg_res;
        }
#endif
        for (i = 0; i < AREION_STACK_WORDS; i++) {
            out[i] = window[i];
        }
    }
    areion_compiler_barrier();
    return addr;
}
#endif

static AREION_NOINLINE uint64_t areion_residue_deep(
    areion_probe_cb_t fn, const void *ctx, size_t idx, uint64_t regs[AREION_SIMD_WORDS], int avx512) {
    volatile uint64_t pad[AREION_RESIDUE_PAD_WORDS];
    volatile size_t vidx = idx;
    pad[vidx % AREION_RESIDUE_PAD_WORDS] = 1ULL;
    pad[(vidx + 7U) % AREION_RESIDUE_PAD_WORDS] = 2ULL;
    pad[(vidx + 63U) % AREION_RESIDUE_PAD_WORDS] = 3ULL;
    pad[(vidx + 255U) % AREION_RESIDUE_PAD_WORDS] = 4ULL;
    dumpSIMDRegs(regs, avx512);
    AREION_MSAN_UNPOISON(regs, AREION_SIMD_WORDS * sizeof(uint64_t));
    areion_clobber_scratch_gprs();
    fn(ctx);
    dumpSIMDRegs(regs, avx512);
    AREION_MSAN_UNPOISON(regs, AREION_SIMD_WORDS * sizeof(uint64_t));
    return pad[(vidx + 7U) % AREION_RESIDUE_PAD_WORDS] ^ pad[(vidx + 255U) % AREION_RESIDUE_PAD_WORDS];
}

static AREION_NOINLINE size_t capture_areion_frame_and_reg_residue(
    areion_probe_cb_t fn, const void *ctx, uint64_t dst[AREION_TOTAL_WORDS]) {
    uint64_t simd[AREION_SIMD_WORDS];
    int avx512 = (areion_tier_code() == AREION_TIER_AVX512) ? 1 : 0;
#if !AREION_SANITIZER_NO_STACK_PROBE
    uintptr_t a0, a1;
    size_t i, written = 0;
#endif

    memset(simd, 0, sizeof(simd));
#if !AREION_SANITIZER_NO_STACK_PROBE
    a0 = seed_or_read_stack_window(0, dst);
#endif
#if (defined(__GNUC__) || defined(__clang__)) && (defined(__x86_64__) || defined(_M_X64))
    __asm__ __volatile__(
        "xorl %%ebx, %%ebx\n\t"
        "xorl %%r12d, %%r12d\n\t"
        "xorl %%r13d, %%r13d\n\t"
        "xorl %%r14d, %%r14d\n\t"
        "xorl %%r15d, %%r15d\n\t"
#if defined(_WIN32) || defined(__CYGWIN__)
        "xorl %%esi, %%esi\n\t"
        "xorl %%edi, %%edi\n\t"
        "pxor %%xmm6, %%xmm6\n\t"
        "pxor %%xmm7, %%xmm7\n\t"
        "pxor %%xmm8, %%xmm8\n\t"
        "pxor %%xmm9, %%xmm9\n\t"
        "pxor %%xmm10, %%xmm10\n\t"
        "pxor %%xmm11, %%xmm11\n\t"
        "pxor %%xmm12, %%xmm12\n\t"
        "pxor %%xmm13, %%xmm13\n\t"
        "pxor %%xmm14, %%xmm14\n\t"
        "pxor %%xmm15, %%xmm15\n\t"
        : : : "rbx", "r12", "r13", "r14", "r15", "rsi", "rdi",
              "xmm6", "xmm7", "xmm8", "xmm9", "xmm10",
              "xmm11", "xmm12", "xmm13", "xmm14", "xmm15", "memory"
#else
        : : : "rbx", "r12", "r13", "r14", "r15", "memory"
#endif
    );
#elif (defined(__GNUC__) || defined(__clang__)) && (defined(__aarch64__) || defined(_M_ARM64))
    __asm__ __volatile__(
        "mov x19, xzr\n\t"
        "mov x20, xzr\n\t"
        "mov x21, xzr\n\t"
        "mov x22, xzr\n\t"
        "mov x23, xzr\n\t"
        "mov x24, xzr\n\t"
        "mov x25, xzr\n\t"
        "mov x26, xzr\n\t"
        "mov x27, xzr\n\t"
        "mov x28, xzr\n\t"
        "eor v8.16b, v8.16b, v8.16b\n\t"
        "eor v9.16b, v9.16b, v9.16b\n\t"
        "eor v10.16b, v10.16b, v10.16b\n\t"
        "eor v11.16b, v11.16b, v11.16b\n\t"
        "eor v12.16b, v12.16b, v12.16b\n\t"
        "eor v13.16b, v13.16b, v13.16b\n\t"
        "eor v14.16b, v14.16b, v14.16b\n\t"
        "eor v15.16b, v15.16b, v15.16b\n\t"
        : : : "x19", "x20", "x21", "x22", "x23", "x24", "x25", "x26", "x27", "x28",
              "v8", "v9", "v10", "v11", "v12", "v13", "v14", "v15", "memory"
    );
#elif (defined(__GNUC__) || defined(__clang__)) && defined(__riscv)
    __asm__ __volatile__(
        "li s1, 0\n\t"
        "li s2, 0\n\t"
        "li s3, 0\n\t"
        "li s4, 0\n\t"
        "li s5, 0\n\t"
        "li s6, 0\n\t"
        "li s7, 0\n\t"
        "li s8, 0\n\t"
        "li s9, 0\n\t"
        "li s10, 0\n\t"
        "li s11, 0\n\t"
        : : : "s1", "s2", "s3", "s4", "s5", "s6", "s7", "s8", "s9", "s10", "s11", "memory"
    );
#endif
    g_areion_sink = areion_residue_deep(fn, ctx, 0U, simd, avx512);
#if !AREION_SANITIZER_NO_STACK_PROBE
    a1 = seed_or_read_stack_window(1, dst);

    if (a0 != a1) {
        (void)fprintf(stderr, "FAIL: stack window address mismatch (0x%llx != 0x%llx)\n",
                (unsigned long long)a0, (unsigned long long)a1);
        g_zeroize_failures++;
    }

    memcpy(&dst[AREION_STACK_WORDS], simd, sizeof(simd));

    for (i = 0; i < AREION_STACK_WORDS; i++) {
        if (dst[i] != AREION_RESIDUE_SENTINEL) {
            written++;
        }
    }
    return written;
#else
    memset(dst, 0, AREION_STACK_WORDS * sizeof(uint64_t));
    memcpy(&dst[AREION_STACK_WORDS], simd, sizeof(simd));
    return 1U;
#endif
}

/* =========================================================================
 * Target Word Extraction & Window Scanners
 * ========================================================================= */

typedef struct {
    uint64_t words[AREION_MAX_TARGETS];
    size_t count;
} target_list_t;

static void targets_init(target_list_t *t) {
    t->count = 0;
}

static void targets_add_bytes(target_list_t *t, const uint8_t *buf, size_t len) {
    size_t i;
    for (i = 0; i + 8 <= len; i += 8) {
        uint64_t w_le = areion_load_le64(&buf[i]);
        uint64_t w_native = 0;
        memcpy(&w_native, &buf[i], 8);
        if (w_le != 0ULL && t->count < AREION_MAX_TARGETS) {
            t->words[t->count++] = w_le;
        }
        if (w_native != 0ULL && w_native != w_le && t->count < AREION_MAX_TARGETS) {
            t->words[t->count++] = w_native;
        }
    }
}

static bool scan_for_areion_words(
    const uint64_t window[AREION_TOTAL_WORDS], const target_list_t *targets,
    uint64_t *leaked_word, size_t *leaked_off) {
    size_t i, j;
    for (i = 0; i < AREION_TOTAL_WORDS; i++) {
        uint64_t w = window[i];
        if (w == 0ULL || (i < AREION_STACK_WORDS && w == AREION_RESIDUE_SENTINEL)) {
            continue;
        }
        for (j = 0; j < targets->count; j++) {
            uint64_t t = targets->words[j];
            if (t != 0ULL && w == t) {
                *leaked_word = t;
                *leaked_off = i * 8U;
                return true;
            }
        }
    }
    return false;
}

#if !AREION_SANITIZER_NO_STACK_PROBE
static bool scan_for_areion_words_in_stack(
    const uint64_t window[AREION_TOTAL_WORDS], const target_list_t *targets,
    uint64_t *leaked_word, size_t *leaked_off) {
    size_t i, j;
    for (i = 0; i < AREION_STACK_WORDS; i++) {
        uint64_t w = window[i];
        if (w == 0ULL || w == AREION_RESIDUE_SENTINEL) {
            continue;
        }
        for (j = 0; j < targets->count; j++) {
            uint64_t t = targets->words[j];
            if (t != 0ULL && w == t) {
                *leaked_word = t;
                *leaked_off = i * 8U;
                return true;
            }
        }
    }
    return false;
}
#endif

#if AREION_HAS_ASM_TEST_HELPERS
static bool scan_for_areion_words_in_regs(
    const uint64_t window[AREION_TOTAL_WORDS], const target_list_t *targets,
    uint64_t *leaked_word, size_t *leaked_off) {
    size_t i, j;
    for (i = AREION_STACK_WORDS; i < AREION_TOTAL_WORDS; i++) {
        uint64_t w = window[i];
        if (w == 0ULL) {
            continue;
        }
        for (j = 0; j < targets->count; j++) {
            uint64_t t = targets->words[j];
            if (t != 0ULL && w == t) {
                *leaked_word = t;
                *leaked_off = i * 8U;
                return true;
            }
        }
    }
    return false;
}
#endif

static void assert_no_leak(
    const char *tier_name, const char *op_name, size_t written,
    const uint64_t res[AREION_TOTAL_WORDS], const target_list_t *targets) {
    uint64_t word = 0;
    size_t off = 0;
    if (written == 0) {
        (void)fprintf(stderr, "FAIL [%s] %s: probe missed stack window\n", tier_name, op_name);
        g_zeroize_failures++;
        return;
    }
    if (scan_for_areion_words(res, targets, &word, &off)) {
        const char *where = (off < AREION_RESIDUE_WINDOW) ? "stack" : "SIMD/GPR register";
        (void)fprintf(stderr, "FAIL [%s] %s leaked word 0x%016llx in %s at offset %u\n",
                tier_name, op_name, (unsigned long long)word, where, (unsigned)off);
        g_zeroize_failures++;
    }
}

/* =========================================================================
 * Negative Controls (Proving Stack & SIMD/GPR Leak Detection)
 * ========================================================================= */

#if !AREION_SANITIZER_NO_STACK_PROBE
typedef struct {
    uint64_t secret;
    size_t idx;
} neg_stack_ctx_t;

static AREION_NOINLINE void leaky_areion_frame(uint64_t secret, size_t idx) {
    volatile uint64_t frame[64];
    size_t j;
    for (j = 0; j < 64; j++) {
        frame[j] = secret;
    }
    g_areion_sink = frame[(idx + 1U) % 64U];
}

static void cb_neg_stack(const void *p) {
    const neg_stack_ctx_t *c = (const neg_stack_ctx_t *)p;
    leaky_areion_frame(c->secret, c->idx);
}
#endif

#if AREION_HAS_ASM_TEST_HELPERS
static void cb_neg_regs(const void *p) {
    const uint64_t *masked = (const uint64_t *)p;
    dirtySIMDRegForTest(*masked);
}
#endif

static void test_negative_controls(uint64_t res[AREION_TOTAL_WORDS]) {
    res[0] = 0;

#if !AREION_SANITIZER_NO_STACK_PROBE
    {
        const uint64_t stack_canary = 0xCAFEBABE13579BDFULL;
        neg_stack_ctx_t sctx;
        target_list_t targets;
        uint64_t leaked = 0;
        size_t off = 0;
        size_t written;

        sctx.secret = stack_canary;
        sctx.idx = 3U;
        written = capture_areion_frame_and_reg_residue(cb_neg_stack, &sctx, res);
        targets_init(&targets);
        targets.words[targets.count++] = stack_canary;
        if (written == 0 || !scan_for_areion_words_in_stack(res, &targets, &leaked, &off)) {
            (void)fprintf(stderr, "FAIL: NegativeControl_Stack did not detect intentional stack canary\n");
            g_zeroize_failures++;
        } else {
            printf("NegativeControl_Stack ... OK (caught 0x%016llx at stack offset %u)\n",
                   (unsigned long long)leaked, (unsigned)off);
        }
    }
#else
    printf("NegativeControl_Stack ... SKIPPED (sanitizer fake-stack/shadow active)\n");
#endif

#if AREION_HAS_ASM_TEST_HELPERS
    {
        const uint64_t mask = 0x5555555555555555ULL;
        const uint64_t reg_secret = 0xFEEDFACECAFEBEEFULL;
        uint64_t masked = reg_secret ^ mask;
        target_list_t targets;
        uint64_t leaked = 0;
        size_t off = 0;
        size_t written;

        written = capture_areion_frame_and_reg_residue(cb_neg_regs, &masked, res);
        targets_init(&targets);
        targets.words[targets.count++] = reg_secret;
        if (written == 0 || !scan_for_areion_words_in_regs(res, &targets, &leaked, &off)) {
            (void)fprintf(stderr, "FAIL: NegativeControl_SIMDAndGPR did not detect intentional SIMD/GPR canary\n");
            g_zeroize_failures++;
        } else {
            printf("NegativeControl_SIMDAndGPR ... OK (caught 0x%016llx at reg dump offset %u)\n",
                   (unsigned long long)leaked, (unsigned)(off - AREION_RESIDUE_WINDOW));
        }
    }
#endif
}

/* =========================================================================
 * Direct Assembly x4 Kernel Callbacks & Verification
 * ========================================================================= */

#if !defined(AREION_FORCE_PORTABLE) && (defined(__x86_64__) || defined(_M_X64) || defined(__aarch64__) || defined(_M_ARM64))
typedef void (*kern_permx4_fn)(uint8_t *, uint8_t *, uint8_t *, uint8_t *, const uint8_t *);

typedef struct {
    kern_permx4_fn fn_permx4;
    uint8_t *b0, *b1, *b2, *b3;
    const uint8_t *rc;
} asm_kern_ctx_t;

static void cb_kern_permx4(const void *p) {
    const asm_kern_ctx_t *c = (const asm_kern_ctx_t *)p;
    c->fn_permx4(c->b0, c->b1, c->b2, c->b3, c->rc);
}

static void run_kern_256x4(
    const char *tier_name, const char *name, kern_permx4_fn fn, const uint8_t *rc,
    uint64_t res[AREION_TOTAL_WORDS]) {
    AREION_ALIGN64 uint8_t orig0[32], orig1[32], orig2[32], orig3[32];
    AREION_ALIGN64 uint8_t b0[32], b1[32], b2[32], b3[32];
    asm_kern_ctx_t ctx;
    target_list_t targets;
    size_t i, w;

    for (i = 0; i < 32; i++) {
        orig0[i] = (uint8_t)(0x13U + i * 3U);
        orig1[i] = (uint8_t)(0x29U + i * 5U);
        orig2[i] = (uint8_t)(0x47U + i * 7U);
        orig3[i] = (uint8_t)(0x61U + i * 11U);
    }
    memcpy(b0, orig0, 32);
    memcpy(b1, orig1, 32);
    memcpy(b2, orig2, 32);
    memcpy(b3, orig3, 32);
    ctx.fn_permx4 = fn;
    ctx.b0 = b0;
    ctx.b1 = b1;
    ctx.b2 = b2;
    ctx.b3 = b3;
    ctx.rc = rc;
    w = capture_areion_frame_and_reg_residue(cb_kern_permx4, &ctx, res);
    AREION_MSAN_UNPOISON(b0, 32);
    AREION_MSAN_UNPOISON(b1, 32);
    AREION_MSAN_UNPOISON(b2, 32);
    AREION_MSAN_UNPOISON(b3, 32);
    targets_init(&targets);
    targets_add_bytes(&targets, orig0, 32);
    targets_add_bytes(&targets, orig1, 32);
    targets_add_bytes(&targets, orig2, 32);
    targets_add_bytes(&targets, orig3, 32);
    targets_add_bytes(&targets, b0, 32);
    targets_add_bytes(&targets, b1, 32);
    targets_add_bytes(&targets, b2, 32);
    targets_add_bytes(&targets, b3, 32);
    assert_no_leak(tier_name, name, w, res, &targets);
}

static void run_kern_512x4(
    const char *tier_name, const char *name, kern_permx4_fn fn, const uint8_t *rc,
    uint64_t res[AREION_TOTAL_WORDS]) {
    AREION_ALIGN64 uint8_t orig0[64], orig1[64], orig2[64], orig3[64];
    AREION_ALIGN64 uint8_t b0[64], b1[64], b2[64], b3[64];
    asm_kern_ctx_t ctx;
    target_list_t targets;
    size_t i, w;

    for (i = 0; i < 64; i++) {
        orig0[i] = (uint8_t)(0x13U + i * 3U);
        orig1[i] = (uint8_t)(0x29U + i * 5U);
        orig2[i] = (uint8_t)(0x47U + i * 7U);
        orig3[i] = (uint8_t)(0x61U + i * 11U);
    }
    memcpy(b0, orig0, 64);
    memcpy(b1, orig1, 64);
    memcpy(b2, orig2, 64);
    memcpy(b3, orig3, 64);
    ctx.fn_permx4 = fn;
    ctx.b0 = b0;
    ctx.b1 = b1;
    ctx.b2 = b2;
    ctx.b3 = b3;
    ctx.rc = rc;
    w = capture_areion_frame_and_reg_residue(cb_kern_permx4, &ctx, res);
    AREION_MSAN_UNPOISON(b0, 64);
    AREION_MSAN_UNPOISON(b1, 64);
    AREION_MSAN_UNPOISON(b2, 64);
    AREION_MSAN_UNPOISON(b3, 64);
    targets_init(&targets);
    targets_add_bytes(&targets, orig0, 64);
    targets_add_bytes(&targets, orig1, 64);
    targets_add_bytes(&targets, orig2, 64);
    targets_add_bytes(&targets, orig3, 64);
    targets_add_bytes(&targets, b0, 64);
    targets_add_bytes(&targets, b1, 64);
    targets_add_bytes(&targets, b2, 64);
    targets_add_bytes(&targets, b3, 64);
    assert_no_leak(tier_name, name, w, res, &targets);
}

typedef void (*kern_em_fn)(uint8_t *, const uint8_t *, const uint8_t *);
typedef void (*kern_tem_fn)(uint8_t *, const uint8_t *, const uint8_t *, const uint8_t *);

typedef struct {
    kern_em_fn fn_em;
    kern_tem_fn fn_tem;
    uint8_t *out;
    const uint8_t *m;
    const uint8_t *k;
    const uint8_t *t;
} asm_wb_kern_ctx_t;

static void cb_kern_em(const void *p) {
    const asm_wb_kern_ctx_t *c = (const asm_wb_kern_ctx_t *)p;
    c->fn_em(c->out, c->m, c->k);
}

static void cb_kern_tem(const void *p) {
    const asm_wb_kern_ctx_t *c = (const asm_wb_kern_ctx_t *)p;
    c->fn_tem(c->out, c->m, c->k, c->t);
}

static void run_kern_em(
    const char *tier_name, const char *name, kern_em_fn fn, size_t block_len,
    uint64_t res[AREION_TOTAL_WORDS]) {
    AREION_ALIGN64 uint8_t out[256], m[256], k[512];
    asm_wb_kern_ctx_t ctx;
    target_list_t targets;
    size_t i, w;
    size_t key_len = block_len * 2U;

    for (i = 0; i < block_len; i++) {
        m[i] = (uint8_t)(0x13U + i * 3U);
    }
    for (i = 0; i < key_len; i++) {
        k[i] = (uint8_t)(0x29U + i * 5U);
    }
    memset(out, 0, sizeof(out));
    ctx.fn_em = fn;
    ctx.out = out;
    ctx.m = m;
    ctx.k = k;
    ctx.t = NULL;
    w = capture_areion_frame_and_reg_residue(cb_kern_em, &ctx, res);
    AREION_MSAN_UNPOISON(out, block_len);
    targets_init(&targets);
    targets_add_bytes(&targets, m, block_len);
    targets_add_bytes(&targets, k, key_len);
    targets_add_bytes(&targets, out, block_len);
    assert_no_leak(tier_name, name, w, res, &targets);
}

static void run_kern_tem(
    const char *tier_name, const char *name, kern_tem_fn fn, size_t block_len,
    uint64_t res[AREION_TOTAL_WORDS]) {
    AREION_ALIGN64 uint8_t out[256], m[256], k[512], t[256];
    asm_wb_kern_ctx_t ctx;
    target_list_t targets;
    size_t i, w;
    size_t key_len = block_len * 2U;

    for (i = 0; i < block_len; i++) {
        m[i] = (uint8_t)(0x13U + i * 3U);
        t[i] = (uint8_t)(0x47U + i * 7U);
    }
    for (i = 0; i < key_len; i++) {
        k[i] = (uint8_t)(0x29U + i * 5U);
    }
    memset(out, 0, sizeof(out));
    ctx.fn_em = NULL;
    ctx.fn_tem = fn;
    ctx.out = out;
    ctx.m = m;
    ctx.k = k;
    ctx.t = t;
    w = capture_areion_frame_and_reg_residue(cb_kern_tem, &ctx, res);
    AREION_MSAN_UNPOISON(out, block_len);
    targets_init(&targets);
    targets_add_bytes(&targets, m, block_len);
    targets_add_bytes(&targets, k, key_len);
    targets_add_bytes(&targets, t, block_len);
    targets_add_bytes(&targets, out, block_len);
    assert_no_leak(tier_name, name, w, res, &targets);
}

typedef void (*kern_r256_fn)(const uint8_t *, uint8_t *, const uint8_t *);

typedef struct {
    kern_r256_fn fn_r256;
    const uint8_t *rk;
    uint8_t *out;
    const uint8_t *m;
} asm_r256_kern_ctx_t;

static void cb_kern_r256(const void *p) {
    const asm_r256_kern_ctx_t *c = (const asm_r256_kern_ctx_t *)p;
    c->fn_r256(c->rk, c->out, c->m);
}

static void run_kern_r256(
    const char *tier_name, const char *name, kern_r256_fn fn, size_t total_len,
    uint64_t res[AREION_TOTAL_WORDS]) {
    AREION_ALIGN64 uint8_t out[128], m[128], rk[15][32];
    asm_r256_kern_ctx_t ctx;
    target_list_t targets;
    size_t i, r, w;

    memset(m, 0, sizeof(m));
    for (i = 0; i < total_len; i++) {
        m[i] = (uint8_t)(0x13U + i * 3U);
    }
    for (r = 0; r < 15; r++) {
        for (i = 0; i < 32; i++) {
            rk[r][i] = (uint8_t)(0x29U + r * 17U + i * 5U);
        }
    }
    memset(out, 0, sizeof(out));
    ctx.fn_r256 = fn;
    ctx.rk = &rk[0][0];
    ctx.out = out;
    ctx.m = m;
    w = capture_areion_frame_and_reg_residue(cb_kern_r256, &ctx, res);
    AREION_MSAN_UNPOISON(out, total_len);
    targets_init(&targets);
    targets_add_bytes(&targets, m, total_len);
    targets_add_bytes(&targets, &rk[0][0], 64);
    targets_add_bytes(&targets, &rk[7][0], 64);
    targets_add_bytes(&targets, &rk[13][0], 64);
    targets_add_bytes(&targets, out, total_len);
    assert_no_leak(tier_name, name, w, res, &targets);
}

typedef void (*kern_vistrutah_fn)(uint8_t *, const uint8_t *, const uint8_t *, int64_t);

typedef struct {
    kern_vistrutah_fn fn_vis;
    uint8_t *out;
    const uint8_t *m;
    const uint8_t *k;
    int64_t rounds;
} asm_vis_kern_ctx_t;

static void cb_kern_vistrutah(const void *p) {
    const asm_vis_kern_ctx_t *c = (const asm_vis_kern_ctx_t *)p;
    c->fn_vis(c->out, c->m, c->k, c->rounds);
}

static void run_kern_vistrutah(
    const char *tier_name, const char *name, kern_vistrutah_fn fn,
    size_t total_len, size_t key_len, int64_t rounds,
    uint64_t res[AREION_TOTAL_WORDS]) {
    AREION_ALIGN64 uint8_t out[256], m[256], k[64];
    asm_vis_kern_ctx_t ctx;
    target_list_t targets;
    size_t i, w;

    memset(m, 0, sizeof(m));
    for (i = 0; i < total_len; i++) {
        m[i] = (uint8_t)(0x13U + i * 3U);
    }
    for (i = 0; i < key_len; i++) {
        k[i] = (uint8_t)(0x29U + i * 5U);
    }
    memset(out, 0, sizeof(out));
    ctx.fn_vis = fn;
    ctx.out = out;
    ctx.m = m;
    ctx.k = k;
    ctx.rounds = rounds;
    w = capture_areion_frame_and_reg_residue(cb_kern_vistrutah, &ctx, res);
    AREION_MSAN_UNPOISON(out, total_len);
    targets_init(&targets);
    targets_add_bytes(&targets, m, total_len);
    targets_add_bytes(&targets, k, key_len);
    targets_add_bytes(&targets, out, total_len);
    assert_no_leak(tier_name, name, w, res, &targets);
}

static void test_areion_arch_asm_kernels(areion_tier_t tier, const char *tier_name, uint64_t res[AREION_TOTAL_WORDS]) {
#if !defined(AREION_FORCE_PORTABLE) && (defined(__x86_64__) || defined(_M_X64))
    const uint8_t *rc = &areionRC4x[0][0];
    const uint8_t *rc2 = &areionRC4x2[0][0];
    if (tier == AREION_TIER_AESNI) {
        run_kern_256x4(tier_name, "areion256Permutex4AesNiRC", areion256Permutex4AesNiRC, rc, res);
        run_kern_256x4(tier_name, "areion256Permutex4AesNiRC_P2", areion256Permutex4AesNiRC, rc2, res);
        run_kern_256x4(tier_name, "areion256InversePermutex4AesNiRC", areion256InversePermutex4AesNiRC, rc, res);
        run_kern_256x4(tier_name, "areion256InversePermutex4AesNiRC_P2", areion256InversePermutex4AesNiRC, rc2, res);
        run_kern_512x4(tier_name, "areion512Permutex4AesNiRC", areion512Permutex4AesNiRC, rc, res);
        run_kern_512x4(tier_name, "areion512Permutex4AesNiRC_P2", areion512Permutex4AesNiRC, rc2, res);
        run_kern_512x4(tier_name, "areion512InversePermutex4AesNiRC", areion512InversePermutex4AesNiRC, rc, res);
        run_kern_512x4(tier_name, "areion512InversePermutex4AesNiRC_P2", areion512InversePermutex4AesNiRC, rc2, res);
        run_kern_em(tier_name, "areion256SoEMPermutex4AesNi", areion256SoEMPermutex4AesNi, 128U, res);
        run_kern_em(tier_name, "areion512SoEMPermutex4AesNi", areion512SoEMPermutex4AesNi, 256U, res);
        run_kern_em(tier_name, "areion256EMEncryptAESNI", areion256EMEncryptAESNI, 32U, res);
        run_kern_em(tier_name, "areion256EMDecryptAESNI", areion256EMDecryptAESNI, 32U, res);
        run_kern_em(tier_name, "areion512EMEncryptAESNI", areion512EMEncryptAESNI, 64U, res);
        run_kern_em(tier_name, "areion512EMDecryptAESNI", areion512EMDecryptAESNI, 64U, res);
        run_kern_em(tier_name, "areion256EM2EncryptAESNI", areion256EM2EncryptAESNI, 32U, res);
        run_kern_em(tier_name, "areion256EM2DecryptAESNI", areion256EM2DecryptAESNI, 32U, res);
        run_kern_em(tier_name, "areion512EM2EncryptAESNI", areion512EM2EncryptAESNI, 64U, res);
        run_kern_em(tier_name, "areion512EM2DecryptAESNI", areion512EM2DecryptAESNI, 64U, res);
        run_kern_tem(tier_name, "areion256TEMEncryptAESNI", areion256TEMEncryptAESNI, 32U, res);
        run_kern_tem(tier_name, "areion256TEMDecryptAESNI", areion256TEMDecryptAESNI, 32U, res);
        run_kern_tem(tier_name, "areion512TEMEncryptAESNI", areion512TEMEncryptAESNI, 64U, res);
        run_kern_tem(tier_name, "areion512TEMDecryptAESNI", areion512TEMDecryptAESNI, 64U, res);
        run_kern_tem(tier_name, "areion256TEM2EncryptAESNI", areion256TEM2EncryptAESNI, 32U, res);
        run_kern_tem(tier_name, "areion256TEM2DecryptAESNI", areion256TEM2DecryptAESNI, 32U, res);
        run_kern_tem(tier_name, "areion512TEM2EncryptAESNI", areion512TEM2EncryptAESNI, 64U, res);
        run_kern_tem(tier_name, "areion512TEM2DecryptAESNI", areion512TEM2DecryptAESNI, 64U, res);
        run_kern_em(tier_name, "areion256EMEncryptx4AESNI", areion256EMEncryptx4AESNI, 128U, res);
        run_kern_em(tier_name, "areion256EMDecryptx4AESNI", areion256EMDecryptx4AESNI, 128U, res);
        run_kern_em(tier_name, "areion512EMEncryptx4AESNI", areion512EMEncryptx4AESNI, 256U, res);
        run_kern_em(tier_name, "areion512EMDecryptx4AESNI", areion512EMDecryptx4AESNI, 256U, res);
        run_kern_em(tier_name, "areion256EM2Encryptx4AESNI", areion256EM2Encryptx4AESNI, 128U, res);
        run_kern_em(tier_name, "areion256EM2Decryptx4AESNI", areion256EM2Decryptx4AESNI, 128U, res);
        run_kern_em(tier_name, "areion512EM2Encryptx4AESNI", areion512EM2Encryptx4AESNI, 256U, res);
        run_kern_em(tier_name, "areion512EM2Decryptx4AESNI", areion512EM2Decryptx4AESNI, 256U, res);
        run_kern_tem(tier_name, "areion256TEMEncryptx4AESNI", areion256TEMEncryptx4AESNI, 128U, res);
        run_kern_tem(tier_name, "areion256TEMDecryptx4AESNI", areion256TEMDecryptx4AESNI, 128U, res);
        run_kern_tem(tier_name, "areion512TEMEncryptx4AESNI", areion512TEMEncryptx4AESNI, 256U, res);
        run_kern_tem(tier_name, "areion512TEMDecryptx4AESNI", areion512TEMDecryptx4AESNI, 256U, res);
        run_kern_tem(tier_name, "areion256TEM2Encryptx4AESNI", areion256TEM2Encryptx4AESNI, 128U, res);
        run_kern_tem(tier_name, "areion256TEM2Decryptx4AESNI", areion256TEM2Decryptx4AESNI, 128U, res);
        run_kern_tem(tier_name, "areion512TEM2Encryptx4AESNI", areion512TEM2Encryptx4AESNI, 256U, res);
        run_kern_tem(tier_name, "areion512TEM2Decryptx4AESNI", areion512TEM2Decryptx4AESNI, 256U, res);
        run_kern_r256(tier_name, "rijndael256EncryptBlockAsm", rijndael256EncryptBlockAsm, 32U, res);
        run_kern_r256(tier_name, "rijndael256Encrypt4BlocksAesNiAsm", rijndael256Encrypt4BlocksAesNiAsm, 128U, res);
        run_kern_vistrutah(tier_name, "vistrutah256EncryptBlockAsm_10", vistrutah256EncryptBlockAsm, 32U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah256EncryptBlockAsm_14", vistrutah256EncryptBlockAsm, 32U, 32U, 14, res);
        run_kern_vistrutah(tier_name, "vistrutah256Encrypt4BlocksAesNiAsm_10", vistrutah256Encrypt4BlocksAesNiAsm, 128U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah256Encrypt4BlocksAesNiAsm_14", vistrutah256Encrypt4BlocksAesNiAsm, 128U, 32U, 14, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock256Asm_10", vistrutah512EncryptBlock256Asm, 64U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock256Asm_18", vistrutah512EncryptBlock256Asm, 64U, 32U, 18, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock512Asm_12", vistrutah512EncryptBlock512Asm, 64U, 64U, 12, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock512Asm_18", vistrutah512EncryptBlock512Asm, 64U, 64U, 18, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks256AesNiAsm_10", vistrutah512Encrypt4Blocks256AesNiAsm, 256U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks256AesNiAsm_18", vistrutah512Encrypt4Blocks256AesNiAsm, 256U, 32U, 18, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks512AesNiAsm_12", vistrutah512Encrypt4Blocks512AesNiAsm, 256U, 64U, 12, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks512AesNiAsm_18", vistrutah512Encrypt4Blocks512AesNiAsm, 256U, 64U, 18, res);
    } else if (tier == AREION_TIER_VEX) {
        run_kern_256x4(tier_name, "areion256Permutex4VexRC", areion256Permutex4VexRC, rc, res);
        run_kern_256x4(tier_name, "areion256Permutex4VexRC_P2", areion256Permutex4VexRC, rc2, res);
        run_kern_256x4(tier_name, "areion256InversePermutex4VexRC", areion256InversePermutex4VexRC, rc, res);
        run_kern_256x4(tier_name, "areion256InversePermutex4VexRC_P2", areion256InversePermutex4VexRC, rc2, res);
        run_kern_512x4(tier_name, "areion512Permutex4VexRC", areion512Permutex4VexRC, rc, res);
        run_kern_512x4(tier_name, "areion512Permutex4VexRC_P2", areion512Permutex4VexRC, rc2, res);
        run_kern_512x4(tier_name, "areion512InversePermutex4VexRC", areion512InversePermutex4VexRC, rc, res);
        run_kern_512x4(tier_name, "areion512InversePermutex4VexRC_P2", areion512InversePermutex4VexRC, rc2, res);
        run_kern_em(tier_name, "areion256SoEMPermutex4Vex", areion256SoEMPermutex4Vex, 128U, res);
        run_kern_em(tier_name, "areion512SoEMPermutex4Vex", areion512SoEMPermutex4Vex, 256U, res);
        run_kern_em(tier_name, "areion256EMEncryptVEX", areion256EMEncryptVEX, 32U, res);
        run_kern_em(tier_name, "areion256EMDecryptVEX", areion256EMDecryptVEX, 32U, res);
        run_kern_em(tier_name, "areion512EMEncryptVEX", areion512EMEncryptVEX, 64U, res);
        run_kern_em(tier_name, "areion512EMDecryptVEX", areion512EMDecryptVEX, 64U, res);
        run_kern_em(tier_name, "areion256EM2EncryptVEX", areion256EM2EncryptVEX, 32U, res);
        run_kern_em(tier_name, "areion256EM2DecryptVEX", areion256EM2DecryptVEX, 32U, res);
        run_kern_em(tier_name, "areion512EM2EncryptVEX", areion512EM2EncryptVEX, 64U, res);
        run_kern_em(tier_name, "areion512EM2DecryptVEX", areion512EM2DecryptVEX, 64U, res);
        run_kern_tem(tier_name, "areion256TEMEncryptVEX", areion256TEMEncryptVEX, 32U, res);
        run_kern_tem(tier_name, "areion256TEMDecryptVEX", areion256TEMDecryptVEX, 32U, res);
        run_kern_tem(tier_name, "areion512TEMEncryptVEX", areion512TEMEncryptVEX, 64U, res);
        run_kern_tem(tier_name, "areion512TEMDecryptVEX", areion512TEMDecryptVEX, 64U, res);
        run_kern_tem(tier_name, "areion256TEM2EncryptVEX", areion256TEM2EncryptVEX, 32U, res);
        run_kern_tem(tier_name, "areion256TEM2DecryptVEX", areion256TEM2DecryptVEX, 32U, res);
        run_kern_tem(tier_name, "areion512TEM2EncryptVEX", areion512TEM2EncryptVEX, 64U, res);
        run_kern_tem(tier_name, "areion512TEM2DecryptVEX", areion512TEM2DecryptVEX, 64U, res);
        run_kern_em(tier_name, "areion256EMEncryptx4VEX", areion256EMEncryptx4VEX, 128U, res);
        run_kern_em(tier_name, "areion256EMDecryptx4VEX", areion256EMDecryptx4VEX, 128U, res);
        run_kern_em(tier_name, "areion512EMEncryptx4VEX", areion512EMEncryptx4VEX, 256U, res);
        run_kern_em(tier_name, "areion512EMDecryptx4VEX", areion512EMDecryptx4VEX, 256U, res);
        run_kern_em(tier_name, "areion256EM2Encryptx4VEX", areion256EM2Encryptx4VEX, 128U, res);
        run_kern_em(tier_name, "areion256EM2Decryptx4VEX", areion256EM2Decryptx4VEX, 128U, res);
        run_kern_em(tier_name, "areion512EM2Encryptx4VEX", areion512EM2Encryptx4VEX, 256U, res);
        run_kern_em(tier_name, "areion512EM2Decryptx4VEX", areion512EM2Decryptx4VEX, 256U, res);
        run_kern_tem(tier_name, "areion256TEMEncryptx4VEX", areion256TEMEncryptx4VEX, 128U, res);
        run_kern_tem(tier_name, "areion256TEMDecryptx4VEX", areion256TEMDecryptx4VEX, 128U, res);
        run_kern_tem(tier_name, "areion512TEMEncryptx4VEX", areion512TEMEncryptx4VEX, 256U, res);
        run_kern_tem(tier_name, "areion512TEMDecryptx4VEX", areion512TEMDecryptx4VEX, 256U, res);
        run_kern_tem(tier_name, "areion256TEM2Encryptx4VEX", areion256TEM2Encryptx4VEX, 128U, res);
        run_kern_tem(tier_name, "areion256TEM2Decryptx4VEX", areion256TEM2Decryptx4VEX, 128U, res);
        run_kern_tem(tier_name, "areion512TEM2Encryptx4VEX", areion512TEM2Encryptx4VEX, 256U, res);
        run_kern_tem(tier_name, "areion512TEM2Decryptx4VEX", areion512TEM2Decryptx4VEX, 256U, res);
        run_kern_r256(tier_name, "rijndael256EncryptBlockVexAsm", rijndael256EncryptBlockVexAsm, 32U, res);
        run_kern_r256(tier_name, "rijndael256Encrypt4BlocksVexAsm", rijndael256Encrypt4BlocksVexAsm, 128U, res);
        run_kern_vistrutah(tier_name, "vistrutah256EncryptBlockVexAsm_10", vistrutah256EncryptBlockVexAsm, 32U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah256EncryptBlockVexAsm_14", vistrutah256EncryptBlockVexAsm, 32U, 32U, 14, res);
        run_kern_vistrutah(tier_name, "vistrutah256Encrypt4BlocksVexAsm_10", vistrutah256Encrypt4BlocksVexAsm, 128U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah256Encrypt4BlocksVexAsm_14", vistrutah256Encrypt4BlocksVexAsm, 128U, 32U, 14, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock256VexAsm_10", vistrutah512EncryptBlock256VexAsm, 64U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock256VexAsm_18", vistrutah512EncryptBlock256VexAsm, 64U, 32U, 18, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock512VexAsm_12", vistrutah512EncryptBlock512VexAsm, 64U, 64U, 12, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock512VexAsm_18", vistrutah512EncryptBlock512VexAsm, 64U, 64U, 18, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks256VexAsm_10", vistrutah512Encrypt4Blocks256VexAsm, 256U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks256VexAsm_18", vistrutah512Encrypt4Blocks256VexAsm, 256U, 32U, 18, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks512VexAsm_12", vistrutah512Encrypt4Blocks512VexAsm, 256U, 64U, 12, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks512VexAsm_18", vistrutah512Encrypt4Blocks512VexAsm, 256U, 64U, 18, res);
    } else if (tier == AREION_TIER_VAESAVX2) {
        run_kern_256x4(tier_name, "areion256Permutex4Avx2RC", areion256Permutex4Avx2RC, rc, res);
        run_kern_256x4(tier_name, "areion256Permutex4Avx2RC_P2", areion256Permutex4Avx2RC, rc2, res);
        run_kern_256x4(tier_name, "areion256InversePermutex4Avx2RC", areion256InversePermutex4Avx2RC, rc, res);
        run_kern_256x4(tier_name, "areion256InversePermutex4Avx2RC_P2", areion256InversePermutex4Avx2RC, rc2, res);
        run_kern_512x4(tier_name, "areion512Permutex4Avx2RC", areion512Permutex4Avx2RC, rc, res);
        run_kern_512x4(tier_name, "areion512Permutex4Avx2RC_P2", areion512Permutex4Avx2RC, rc2, res);
        run_kern_512x4(tier_name, "areion512InversePermutex4Avx2RC", areion512InversePermutex4Avx2RC, rc, res);
        run_kern_512x4(tier_name, "areion512InversePermutex4Avx2RC_P2", areion512InversePermutex4Avx2RC, rc2, res);
        run_kern_em(tier_name, "areion256SoEMPermutex4VaesAvx2", areion256SoEMPermutex4VaesAvx2, 128U, res);
        run_kern_em(tier_name, "areion512SoEMPermutex4VaesAvx2", areion512SoEMPermutex4VaesAvx2, 256U, res);
        run_kern_em(tier_name, "areion256EMEncryptx4VAESAVX2", areion256EMEncryptx4VAESAVX2, 128U, res);
        run_kern_em(tier_name, "areion256EMDecryptx4VAESAVX2", areion256EMDecryptx4VAESAVX2, 128U, res);
        run_kern_em(tier_name, "areion512EMEncryptx4VAESAVX2", areion512EMEncryptx4VAESAVX2, 256U, res);
        run_kern_em(tier_name, "areion512EMDecryptx4VAESAVX2", areion512EMDecryptx4VAESAVX2, 256U, res);
        run_kern_em(tier_name, "areion256EM2Encryptx4VAESAVX2", areion256EM2Encryptx4VAESAVX2, 128U, res);
        run_kern_em(tier_name, "areion256EM2Decryptx4VAESAVX2", areion256EM2Decryptx4VAESAVX2, 128U, res);
        run_kern_em(tier_name, "areion512EM2Encryptx4VAESAVX2", areion512EM2Encryptx4VAESAVX2, 256U, res);
        run_kern_em(tier_name, "areion512EM2Decryptx4VAESAVX2", areion512EM2Decryptx4VAESAVX2, 256U, res);
        run_kern_tem(tier_name, "areion256TEMEncryptx4VAESAVX2", areion256TEMEncryptx4VAESAVX2, 128U, res);
        run_kern_tem(tier_name, "areion256TEMDecryptx4VAESAVX2", areion256TEMDecryptx4VAESAVX2, 128U, res);
        run_kern_tem(tier_name, "areion512TEMEncryptx4VAESAVX2", areion512TEMEncryptx4VAESAVX2, 256U, res);
        run_kern_tem(tier_name, "areion512TEMDecryptx4VAESAVX2", areion512TEMDecryptx4VAESAVX2, 256U, res);
        run_kern_tem(tier_name, "areion256TEM2Encryptx4VAESAVX2", areion256TEM2Encryptx4VAESAVX2, 128U, res);
        run_kern_tem(tier_name, "areion256TEM2Decryptx4VAESAVX2", areion256TEM2Decryptx4VAESAVX2, 128U, res);
        run_kern_tem(tier_name, "areion512TEM2Encryptx4VAESAVX2", areion512TEM2Encryptx4VAESAVX2, 256U, res);
        run_kern_tem(tier_name, "areion512TEM2Decryptx4VAESAVX2", areion512TEM2Decryptx4VAESAVX2, 256U, res);
        run_kern_r256(tier_name, "rijndael256Encrypt4BlocksYmmAsm", rijndael256Encrypt4BlocksYmmAsm, 128U, res);
        run_kern_vistrutah(tier_name, "vistrutah256EncryptBlockYmmAsm_10", vistrutah256EncryptBlockYmmAsm, 32U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah256EncryptBlockYmmAsm_14", vistrutah256EncryptBlockYmmAsm, 32U, 32U, 14, res);
        run_kern_vistrutah(tier_name, "vistrutah256Encrypt4BlocksYmmAsm_10", vistrutah256Encrypt4BlocksYmmAsm, 128U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah256Encrypt4BlocksYmmAsm_14", vistrutah256Encrypt4BlocksYmmAsm, 128U, 32U, 14, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock256YmmAsm_10", vistrutah512EncryptBlock256YmmAsm, 64U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock256YmmAsm_18", vistrutah512EncryptBlock256YmmAsm, 64U, 32U, 18, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock512YmmAsm_12", vistrutah512EncryptBlock512YmmAsm, 64U, 64U, 12, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock512YmmAsm_18", vistrutah512EncryptBlock512YmmAsm, 64U, 64U, 18, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks256YmmAsm_10", vistrutah512Encrypt4Blocks256YmmAsm, 256U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks256YmmAsm_18", vistrutah512Encrypt4Blocks256YmmAsm, 256U, 32U, 18, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks512YmmAsm_12", vistrutah512Encrypt4Blocks512YmmAsm, 256U, 64U, 12, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks512YmmAsm_18", vistrutah512Encrypt4Blocks512YmmAsm, 256U, 64U, 18, res);
    } else if (tier == AREION_TIER_AVX512) {
        run_kern_256x4(tier_name, "areion256Permutex4RC", areion256Permutex4RC, rc, res);
        run_kern_256x4(tier_name, "areion256Permutex4RC_P2", areion256Permutex4RC, rc2, res);
        run_kern_256x4(tier_name, "areion256InversePermutex4RC", areion256InversePermutex4RC, rc, res);
        run_kern_256x4(tier_name, "areion256InversePermutex4RC_P2", areion256InversePermutex4RC, rc2, res);
        run_kern_512x4(tier_name, "areion512Permutex4RC", areion512Permutex4RC, rc, res);
        run_kern_512x4(tier_name, "areion512Permutex4RC_P2", areion512Permutex4RC, rc2, res);
        run_kern_512x4(tier_name, "areion512InversePermutex4RC", areion512InversePermutex4RC, rc, res);
        run_kern_512x4(tier_name, "areion512InversePermutex4RC_P2", areion512InversePermutex4RC, rc2, res);
        run_kern_em(tier_name, "areion256SoEMPermutex4Interleaved", areion256SoEMPermutex4Interleaved, 128U, res);
        run_kern_em(tier_name, "areion512SoEMPermutex4Interleaved", areion512SoEMPermutex4Interleaved, 256U, res);
        run_kern_em(tier_name, "areion256EMEncryptx4AVX512", areion256EMEncryptx4AVX512, 128U, res);
        run_kern_em(tier_name, "areion256EMDecryptx4AVX512", areion256EMDecryptx4AVX512, 128U, res);
        run_kern_em(tier_name, "areion512EMEncryptx4AVX512", areion512EMEncryptx4AVX512, 256U, res);
        run_kern_em(tier_name, "areion512EMDecryptx4AVX512", areion512EMDecryptx4AVX512, 256U, res);
        run_kern_em(tier_name, "areion256EM2Encryptx4AVX512", areion256EM2Encryptx4AVX512, 128U, res);
        run_kern_em(tier_name, "areion256EM2Decryptx4AVX512", areion256EM2Decryptx4AVX512, 128U, res);
        run_kern_em(tier_name, "areion512EM2Encryptx4AVX512", areion512EM2Encryptx4AVX512, 256U, res);
        run_kern_em(tier_name, "areion512EM2Decryptx4AVX512", areion512EM2Decryptx4AVX512, 256U, res);
        run_kern_tem(tier_name, "areion256TEMEncryptx4AVX512", areion256TEMEncryptx4AVX512, 128U, res);
        run_kern_tem(tier_name, "areion256TEMDecryptx4AVX512", areion256TEMDecryptx4AVX512, 128U, res);
        run_kern_tem(tier_name, "areion512TEMEncryptx4AVX512", areion512TEMEncryptx4AVX512, 256U, res);
        run_kern_tem(tier_name, "areion512TEMDecryptx4AVX512", areion512TEMDecryptx4AVX512, 256U, res);
        run_kern_tem(tier_name, "areion256TEM2Encryptx4AVX512", areion256TEM2Encryptx4AVX512, 128U, res);
        run_kern_tem(tier_name, "areion256TEM2Decryptx4AVX512", areion256TEM2Decryptx4AVX512, 128U, res);
        run_kern_tem(tier_name, "areion512TEM2Encryptx4AVX512", areion512TEM2Encryptx4AVX512, 256U, res);
        run_kern_tem(tier_name, "areion512TEM2Decryptx4AVX512", areion512TEM2Decryptx4AVX512, 256U, res);
        run_kern_r256(tier_name, "rijndael256Encrypt4BlocksZmmAsm", rijndael256Encrypt4BlocksZmmAsm, 128U, res);
        run_kern_vistrutah(tier_name, "vistrutah256Encrypt4BlocksZmmAsm_10", vistrutah256Encrypt4BlocksZmmAsm, 128U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah256Encrypt4BlocksZmmAsm_14", vistrutah256Encrypt4BlocksZmmAsm, 128U, 32U, 14, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock256ZmmAsm_10", vistrutah512EncryptBlock256ZmmAsm, 64U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock256ZmmAsm_18", vistrutah512EncryptBlock256ZmmAsm, 64U, 32U, 18, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock512ZmmAsm_12", vistrutah512EncryptBlock512ZmmAsm, 64U, 64U, 12, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock512ZmmAsm_18", vistrutah512EncryptBlock512ZmmAsm, 64U, 64U, 18, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks256ZmmAsm_10", vistrutah512Encrypt4Blocks256ZmmAsm, 256U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks256ZmmAsm_18", vistrutah512Encrypt4Blocks256ZmmAsm, 256U, 32U, 18, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks512ZmmAsm_12", vistrutah512Encrypt4Blocks512ZmmAsm, 256U, 64U, 12, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks512ZmmAsm_18", vistrutah512Encrypt4Blocks512ZmmAsm, 256U, 64U, 18, res);
    }
#elif !defined(AREION_FORCE_PORTABLE) && (defined(__aarch64__) || defined(_M_ARM64))
    const uint8_t *rc = &roundConstantsP1[0][0];
    const uint8_t *rc2 = &roundConstantsP2[0][0];
    if (tier == AREION_TIER_ARM64) {
        run_kern_256x4(tier_name, "areion256Permutex4RC", areion256Permutex4RC, rc, res);
        run_kern_256x4(tier_name, "areion256Permutex4RC_P2", areion256Permutex4RC, rc2, res);
        run_kern_256x4(tier_name, "areion256InversePermutex4RC", areion256InversePermutex4RC, rc, res);
        run_kern_256x4(tier_name, "areion256InversePermutex4RC_P2", areion256InversePermutex4RC, rc2, res);
        run_kern_512x4(tier_name, "areion512Permutex4RC", areion512Permutex4RC, rc, res);
        run_kern_512x4(tier_name, "areion512Permutex4RC_P2", areion512Permutex4RC, rc2, res);
        run_kern_512x4(tier_name, "areion512InversePermutex4RC", areion512InversePermutex4RC, rc, res);
        run_kern_512x4(tier_name, "areion512InversePermutex4RC_P2", areion512InversePermutex4RC, rc2, res);
        run_kern_em(tier_name, "areion256SoEMPermutex4NEON", areion256SoEMPermutex4NEON, 128U, res);
        run_kern_em(tier_name, "areion512SoEMPermutex4NEON", areion512SoEMPermutex4NEON, 256U, res);
        run_kern_em(tier_name, "areion256EMEncryptAsm", areion256EMEncryptAsm, 32U, res);
        run_kern_em(tier_name, "areion256EMDecryptAsm", areion256EMDecryptAsm, 32U, res);
        run_kern_em(tier_name, "areion512EMEncryptAsm", areion512EMEncryptAsm, 64U, res);
        run_kern_em(tier_name, "areion512EMDecryptAsm", areion512EMDecryptAsm, 64U, res);
        run_kern_em(tier_name, "areion256EM2EncryptAsm", areion256EM2EncryptAsm, 32U, res);
        run_kern_em(tier_name, "areion256EM2DecryptAsm", areion256EM2DecryptAsm, 32U, res);
        run_kern_em(tier_name, "areion512EM2EncryptAsm", areion512EM2EncryptAsm, 64U, res);
        run_kern_em(tier_name, "areion512EM2DecryptAsm", areion512EM2DecryptAsm, 64U, res);
        run_kern_tem(tier_name, "areion256TEMEncryptAsm", areion256TEMEncryptAsm, 32U, res);
        run_kern_tem(tier_name, "areion256TEMDecryptAsm", areion256TEMDecryptAsm, 32U, res);
        run_kern_tem(tier_name, "areion512TEMEncryptAsm", areion512TEMEncryptAsm, 64U, res);
        run_kern_tem(tier_name, "areion512TEMDecryptAsm", areion512TEMDecryptAsm, 64U, res);
        run_kern_tem(tier_name, "areion256TEM2EncryptAsm", areion256TEM2EncryptAsm, 32U, res);
        run_kern_tem(tier_name, "areion256TEM2DecryptAsm", areion256TEM2DecryptAsm, 32U, res);
        run_kern_tem(tier_name, "areion512TEM2EncryptAsm", areion512TEM2EncryptAsm, 64U, res);
        run_kern_tem(tier_name, "areion512TEM2DecryptAsm", areion512TEM2DecryptAsm, 64U, res);
        run_kern_em(tier_name, "areion256EMEncryptx4Asm", areion256EMEncryptx4Asm, 128U, res);
        run_kern_em(tier_name, "areion256EMDecryptx4Asm", areion256EMDecryptx4Asm, 128U, res);
        run_kern_em(tier_name, "areion512EMEncryptx4Asm", areion512EMEncryptx4Asm, 256U, res);
        run_kern_em(tier_name, "areion512EMDecryptx4Asm", areion512EMDecryptx4Asm, 256U, res);
        run_kern_em(tier_name, "areion256EM2Encryptx4Asm", areion256EM2Encryptx4Asm, 128U, res);
        run_kern_em(tier_name, "areion256EM2Decryptx4Asm", areion256EM2Decryptx4Asm, 128U, res);
        run_kern_em(tier_name, "areion512EM2Encryptx4Asm", areion512EM2Encryptx4Asm, 256U, res);
        run_kern_em(tier_name, "areion512EM2Decryptx4Asm", areion512EM2Decryptx4Asm, 256U, res);
        run_kern_tem(tier_name, "areion256TEMEncryptx4Asm", areion256TEMEncryptx4Asm, 128U, res);
        run_kern_tem(tier_name, "areion256TEMDecryptx4Asm", areion256TEMDecryptx4Asm, 128U, res);
        run_kern_tem(tier_name, "areion512TEMEncryptx4Asm", areion512TEMEncryptx4Asm, 256U, res);
        run_kern_tem(tier_name, "areion512TEMDecryptx4Asm", areion512TEMDecryptx4Asm, 256U, res);
        run_kern_tem(tier_name, "areion256TEM2Encryptx4Asm", areion256TEM2Encryptx4Asm, 128U, res);
        run_kern_tem(tier_name, "areion256TEM2Decryptx4Asm", areion256TEM2Decryptx4Asm, 128U, res);
        run_kern_tem(tier_name, "areion512TEM2Encryptx4Asm", areion512TEM2Encryptx4Asm, 256U, res);
        run_kern_tem(tier_name, "areion512TEM2Decryptx4Asm", areion512TEM2Decryptx4Asm, 256U, res);
        run_kern_r256(tier_name, "rijndael256EncryptBlockAsm", rijndael256EncryptBlockAsm, 32U, res);
        run_kern_r256(tier_name, "rijndael256Encrypt4BlocksAsm", rijndael256Encrypt4BlocksAsm, 128U, res);
        run_kern_vistrutah(tier_name, "vistrutah256EncryptBlockAsm_10", vistrutah256EncryptBlockAsm, 32U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah256EncryptBlockAsm_14", vistrutah256EncryptBlockAsm, 32U, 32U, 14, res);
        run_kern_vistrutah(tier_name, "vistrutah256Encrypt4BlocksAsm_10", vistrutah256Encrypt4BlocksAsm, 128U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah256Encrypt4BlocksAsm_14", vistrutah256Encrypt4BlocksAsm, 128U, 32U, 14, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock256Asm_10", vistrutah512EncryptBlock256Asm, 64U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock256Asm_18", vistrutah512EncryptBlock256Asm, 64U, 32U, 18, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock512Asm_12", vistrutah512EncryptBlock512Asm, 64U, 64U, 12, res);
        run_kern_vistrutah(tier_name, "vistrutah512EncryptBlock512Asm_18", vistrutah512EncryptBlock512Asm, 64U, 64U, 18, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks256Asm_10", vistrutah512Encrypt4Blocks256Asm, 256U, 32U, 10, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks256Asm_18", vistrutah512Encrypt4Blocks256Asm, 256U, 32U, 18, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks512Asm_12", vistrutah512Encrypt4Blocks512Asm, 256U, 64U, 12, res);
        run_kern_vistrutah(tier_name, "vistrutah512Encrypt4Blocks512Asm_18", vistrutah512Encrypt4Blocks512Asm, 256U, 64U, 18, res);
    }
#else
    (void)tier;
    (void)tier_name;
    (void)res;
#endif
}
#endif

/* =========================================================================
 * Public API Zeroization Callbacks
 * ========================================================================= */

typedef void (*fn_perm256_t)(uint8_t state[32]);
typedef void (*fn_perm512_t)(uint8_t state[64]);
typedef void (*fn_perm256_words_t)(uint32_t state[8]);
typedef void (*fn_perm512_words_t)(uint32_t state[16]);
typedef void (*fn_perm256x4_t)(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32]);
typedef void (*fn_perm512x4_t)(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64]);
typedef void (*fn_round_words_t)(const uint32_t in[4], uint32_t out[4]);
typedef void (*fn_em256_t)(uint8_t out[32], const uint8_t k[64], const uint8_t m[32]);
typedef void (*fn_em512_t)(uint8_t out[64], const uint8_t k[128], const uint8_t m[64]);
typedef void (*fn_tem256_t)(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32]);
typedef void (*fn_tem512_t)(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64]);
typedef void (*fn_em256x4_t)(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32]);
typedef void (*fn_em512x4_t)(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64]);
typedef void (*fn_tem256x4_t)(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32]);
typedef void (*fn_tem512x4_t)(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64]);

typedef struct { fn_perm256_t fn; uint8_t *s; } ctx_perm256_t;
typedef struct { fn_perm512_t fn; uint8_t *s; } ctx_perm512_t;
typedef struct { fn_perm256_words_t fn; uint32_t *s; } ctx_perm256_words_t;
typedef struct { fn_perm512_words_t fn; uint32_t *s; } ctx_perm512_words_t;
typedef struct { fn_perm256x4_t fn; uint8_t (*s)[32]; } ctx_perm256x4_t;
typedef struct { fn_perm512x4_t fn; uint8_t (*s)[64]; } ctx_perm512x4_t;
typedef struct { fn_round_words_t fn; const uint32_t *in; uint32_t *out; } ctx_round_words_t;
typedef struct { uint8_t *out; const uint8_t *in; } ctx_dm_t;
typedef struct { uint8_t *out; const uint8_t *key; const uint8_t *in; } ctx_soem_t;
typedef struct { uint8_t (*out)[32]; const uint8_t (*keys)[64]; const uint8_t (*inputs)[32]; } ctx_soem256x4_t;
typedef struct { uint8_t (*out)[64]; const uint8_t (*keys)[128]; const uint8_t (*inputs)[64]; } ctx_soem512x4_t;
typedef struct { fn_em256_t fn; uint8_t *out; const uint8_t *k; const uint8_t *m; } ctx_em256_t;
typedef struct { fn_em512_t fn; uint8_t *out; const uint8_t *k; const uint8_t *m; } ctx_em512_t;
typedef struct { fn_tem256_t fn; uint8_t *out; const uint8_t *k; const uint8_t *t; const uint8_t *m; } ctx_tem256_t;
typedef struct { fn_tem512_t fn; uint8_t *out; const uint8_t *k; const uint8_t *t; const uint8_t *m; } ctx_tem512_t;
typedef struct { fn_em256x4_t fn; uint8_t (*out)[32]; const uint8_t (*keys)[64]; const uint8_t (*msgs)[32]; } ctx_em256x4_t;
typedef struct { fn_em512x4_t fn; uint8_t (*out)[64]; const uint8_t (*keys)[128]; const uint8_t (*msgs)[64]; } ctx_em512x4_t;
typedef struct { fn_tem256x4_t fn; uint8_t (*out)[32]; const uint8_t (*keys)[64]; const uint8_t (*tweaks)[32]; const uint8_t (*msgs)[32]; } ctx_tem256x4_t;
typedef struct { fn_tem512x4_t fn; uint8_t (*out)[64]; const uint8_t (*keys)[128]; const uint8_t (*tweaks)[64]; const uint8_t (*msgs)[64]; } ctx_tem512x4_t;
typedef struct { const uint8_t *key; uint8_t (*rk)[16]; uint8_t *dst; const uint8_t *src; } ctx_aes_t;
typedef struct { uint8_t (*dst)[16]; const uint8_t (*src)[16]; const uint8_t (*rk)[16]; } ctx_aes4_t;
typedef struct { uint8_t (*b)[16]; const uint8_t (*rk)[16]; } ctx_round4_t;
typedef struct { uint8_t *dst; const uint8_t *src; const uint8_t (*rk)[32]; } ctx_r256_t;
typedef struct { uint8_t (*dst)[32]; const uint8_t (*src)[32]; const uint8_t (*rk)[32]; } ctx_r256x4_t;

static void cb_perm256(const void *p) { const ctx_perm256_t *c = (const ctx_perm256_t *)p; c->fn(c->s); }
static void cb_perm512(const void *p) { const ctx_perm512_t *c = (const ctx_perm512_t *)p; c->fn(c->s); }
static void cb_perm256_words(const void *p) { const ctx_perm256_words_t *c = (const ctx_perm256_words_t *)p; c->fn(c->s); }
static void cb_perm512_words(const void *p) { const ctx_perm512_words_t *c = (const ctx_perm512_words_t *)p; c->fn(c->s); }
static void cb_perm256x4(const void *p) { const ctx_perm256x4_t *c = (const ctx_perm256x4_t *)p; c->fn(c->s[0], c->s[1], c->s[2], c->s[3]); }
static void cb_perm512x4(const void *p) { const ctx_perm512x4_t *c = (const ctx_perm512x4_t *)p; c->fn(c->s[0], c->s[1], c->s[2], c->s[3]); }
static void cb_round_words(const void *p) { const ctx_round_words_t *c = (const ctx_round_words_t *)p; c->fn(c->in, c->out); }
static void cb_dm256(const void *p) { const ctx_dm_t *c = (const ctx_dm_t *)p; areion_dm256(c->out, c->in); }
static void cb_dm512(const void *p) { const ctx_dm_t *c = (const ctx_dm_t *)p; areion_dm512(c->out, c->in); }
static void cb_soem256(const void *p) { const ctx_soem_t *c = (const ctx_soem_t *)p; areion_soem256(c->out, c->key, c->in); }
static void cb_soem512(const void *p) { const ctx_soem_t *c = (const ctx_soem_t *)p; areion_soem512(c->out, c->key, c->in); }
static void cb_soem256x4(const void *p) { const ctx_soem256x4_t *c = (const ctx_soem256x4_t *)p; areion_soem256x4(c->out, c->keys, c->inputs); }
static void cb_soem512x4(const void *p) { const ctx_soem512x4_t *c = (const ctx_soem512x4_t *)p; areion_soem512x4(c->out, c->keys, c->inputs); }
static void cb_em256(const void *p) { const ctx_em256_t *c = (const ctx_em256_t *)p; c->fn(c->out, c->k, c->m); }
static void cb_em512(const void *p) { const ctx_em512_t *c = (const ctx_em512_t *)p; c->fn(c->out, c->k, c->m); }
static void cb_tem256(const void *p) { const ctx_tem256_t *c = (const ctx_tem256_t *)p; c->fn(c->out, c->k, c->t, c->m); }
static void cb_tem512(const void *p) { const ctx_tem512_t *c = (const ctx_tem512_t *)p; c->fn(c->out, c->k, c->t, c->m); }
static void cb_em256x4(const void *p) { const ctx_em256x4_t *c = (const ctx_em256x4_t *)p; c->fn(c->out, c->keys, c->msgs); }
static void cb_em512x4(const void *p) { const ctx_em512x4_t *c = (const ctx_em512x4_t *)p; c->fn(c->out, c->keys, c->msgs); }
static void cb_tem256x4(const void *p) { const ctx_tem256x4_t *c = (const ctx_tem256x4_t *)p; c->fn(c->out, c->keys, c->tweaks, c->msgs); }
static void cb_tem512x4(const void *p) { const ctx_tem512x4_t *c = (const ctx_tem512x4_t *)p; c->fn(c->out, c->keys, c->tweaks, c->msgs); }
static void cb_expand_key(const void *p) { const ctx_aes_t *c = (const ctx_aes_t *)p; areion_expand_key128(c->key, c->rk); }
static void cb_aes_enc1(const void *p) { const ctx_aes_t *c = (const ctx_aes_t *)p; areion_aes128_encrypt_block(c->dst, c->src, (const uint8_t (*)[16])c->rk); }
static void cb_aes_enc4(const void *p) { const ctx_aes4_t *c = (const ctx_aes4_t *)p; areion_aes128_encrypt4_blocks(c->dst, c->src, c->rk); }
static void cb_round_hw1(const void *p) { const ctx_aes_t *c = (const ctx_aes_t *)p; areion_round_hw(c->dst); }
static void cb_final_round_hw1(const void *p) { const ctx_aes_t *c = (const ctx_aes_t *)p; areion_final_round_hw(c->dst); }
static void cb_round4_hw(const void *p) { const ctx_round4_t *c = (const ctx_round4_t *)p; areion_round4_hw(c->b[0], c->b[1], c->b[2], c->b[3]); }
static void cb_final_round4_hw(const void *p) { const ctx_round4_t *c = (const ctx_round4_t *)p; areion_final_round4_hw(c->b[0], c->b[1], c->b[2], c->b[3]); }
static void cb_aes_round1(const void *p) { const ctx_aes_t *c = (const ctx_aes_t *)p; areion_aes_round_hw(c->dst, c->key); }
static void cb_aes_final_round1(const void *p) { const ctx_aes_t *c = (const ctx_aes_t *)p; areion_aes_final_round_hw(c->dst, c->key); }
static void cb_aes_round4(const void *p) { const ctx_round4_t *c = (const ctx_round4_t *)p; areion_aes_round4_hw(c->b[0], c->b[1], c->b[2], c->b[3], c->rk[0], c->rk[1], c->rk[2], c->rk[3]); }
static void cb_aes_final_round4(const void *p) { const ctx_round4_t *c = (const ctx_round4_t *)p; areion_aes_final_round4_hw(c->b[0], c->b[1], c->b[2], c->b[3], c->rk[0], c->rk[1], c->rk[2], c->rk[3]); }
static void cb_aes128_round1(const void *p) { const ctx_aes_t *c = (const ctx_aes_t *)p; areion_aes128_round(c->dst, c->key); }
static void cb_aes128_final_round1(const void *p) { const ctx_aes_t *c = (const ctx_aes_t *)p; areion_aes128_final_round(c->dst, c->key); }
static void cb_aes128_round4(const void *p) { const ctx_round4_t *c = (const ctx_round4_t *)p; areion_aes128_round4(c->b[0], c->b[1], c->b[2], c->b[3], c->rk[0], c->rk[1], c->rk[2], c->rk[3]); }
static void cb_aes128_final_round4(const void *p) { const ctx_round4_t *c = (const ctx_round4_t *)p; areion_aes128_final_round4(c->b[0], c->b[1], c->b[2], c->b[3], c->rk[0], c->rk[1], c->rk[2], c->rk[3]); }
static void cb_xor_block(const void *p) { const ctx_aes_t *c = (const ctx_aes_t *)p; areion_xor_block(c->dst, c->key); }
static void cb_xor_block4(const void *p) { const ctx_round4_t *c = (const ctx_round4_t *)p; areion_xor_block4(c->b[0], c->b[1], c->b[2], c->b[3], c->rk[0], c->rk[1], c->rk[2], c->rk[3]); }
static void cb_r256_enc1(const void *p) { const ctx_r256_t *c = (const ctx_r256_t *)p; areion_rijndael256_encrypt_block_hw(c->dst, c->src, c->rk); }
static void cb_r256_enc4(const void *p) { const ctx_r256x4_t *c = (const ctx_r256x4_t *)p; areion_rijndael256_encrypt4_blocks_hw(c->dst, c->src, c->rk); }

typedef struct { uint8_t *dst; const uint8_t *src; const uint8_t *key; int rounds; } ctx_vis1_t;
typedef struct { uint8_t (*dst)[32]; const uint8_t (*src)[32]; const uint8_t *key; int rounds; } ctx_vis256x4_t;
typedef struct { uint8_t (*dst)[64]; const uint8_t (*src)[64]; const uint8_t *key; int rounds; } ctx_vis512x4_t;

static void cb_v256_enc1(const void *p) { const ctx_vis1_t *c = (const ctx_vis1_t *)p; areion_vistrutah256_encrypt_block_hw(c->dst, c->src, c->key, c->rounds); }
static void cb_v256_dec1(const void *p) { const ctx_vis1_t *c = (const ctx_vis1_t *)p; areion_vistrutah256_decrypt_block_purec(c->dst, c->src, c->key, c->rounds); }
static void cb_v256_enc4(const void *p) { const ctx_vis256x4_t *c = (const ctx_vis256x4_t *)p; areion_vistrutah256_encrypt4_blocks_hw(c->dst, c->src, c->key, c->rounds); }
static void cb_v512_256_enc1(const void *p) { const ctx_vis1_t *c = (const ctx_vis1_t *)p; areion_vistrutah512_encrypt_block_256_hw(c->dst, c->src, c->key, c->rounds); }
static void cb_v512_256_dec1(const void *p) { const ctx_vis1_t *c = (const ctx_vis1_t *)p; areion_vistrutah512_decrypt_block_256_purec(c->dst, c->src, c->key, c->rounds); }
static void cb_v512_512_enc1(const void *p) { const ctx_vis1_t *c = (const ctx_vis1_t *)p; areion_vistrutah512_encrypt_block_512_hw(c->dst, c->src, c->key, c->rounds); }
static void cb_v512_512_dec1(const void *p) { const ctx_vis1_t *c = (const ctx_vis1_t *)p; areion_vistrutah512_decrypt_block_512_purec(c->dst, c->src, c->key, c->rounds); }
static void cb_v512_256_enc4(const void *p) { const ctx_vis512x4_t *c = (const ctx_vis512x4_t *)p; areion_vistrutah512_encrypt4_blocks_256_hw(c->dst, c->src, c->key, c->rounds); }
static void cb_v512_512_enc4(const void *p) { const ctx_vis512x4_t *c = (const ctx_vis512x4_t *)p; areion_vistrutah512_encrypt4_blocks_512_hw(c->dst, c->src, c->key, c->rounds); }

static void test_tier_zeroization(areion_tier_t tier, uint64_t res[AREION_TOTAL_WORDS]) {
    static const struct { const char *name; fn_perm256_t fn; } ops256[] = {
        {"Permute256", areion_permute256},
        {"Permute256P2", areion_permute256_p2},
        {"InversePermute256", areion_inverse_permute256},
        {"InversePermute256P2", areion_inverse_permute256_p2}
    };
    static const struct { const char *name; fn_perm512_t fn; } ops512[] = {
        {"Permute512", areion_permute512},
        {"Permute512P2", areion_permute512_p2},
        {"InversePermute512", areion_inverse_permute512},
        {"InversePermute512P2", areion_inverse_permute512_p2}
    };
    static const struct { const char *name; fn_perm256x4_t fn; } ops256x4[] = {
        {"Permute256x4", areion_permute256x4},
        {"Permute256P2x4", areion_permute256_p2x4},
        {"InversePermute256x4", areion_inverse_permute256x4},
        {"InversePermute256P2x4", areion_inverse_permute256_p2x4}
    };
    static const struct { const char *name; fn_perm512x4_t fn; } ops512x4[] = {
        {"Permute512x4", areion_permute512x4},
        {"Permute512P2x4", areion_permute512_p2x4},
        {"InversePermute512x4", areion_inverse_permute512x4},
        {"InversePermute512P2x4", areion_inverse_permute512_p2x4}
    };

    const char *tier_name = areion_tier();
    uint8_t s256[32], orig256[32], out256[32], k256[64];
    uint8_t s512[64], orig512[64], out512[64], k512[128];
    uint8_t s256x4[4][32], orig256x4[4][32], out256x4[4][32], k256x4[4][64];
    uint8_t s512x4[4][64], orig512x4[4][64], out512x4[4][64], k512x4[4][128];
    uint8_t rk[11][16], aes_key[16], aes_in[16], aes_out[16];
    uint8_t aes_in4[4][16], aes_out4[4][16], aes_key4[4][16];
    target_list_t targets;
    size_t i, l, op, w;

#if !defined(AREION_FORCE_PORTABLE) && (defined(__x86_64__) || defined(_M_X64) || defined(__aarch64__) || defined(_M_ARM64))
    if (tier != AREION_TIER_PUREC) {
        test_areion_arch_asm_kernels(tier, tier_name, res);
    }
#else
    (void)tier;
#endif

    /* Single-block 256 */
    for (i = 0; i < 32; i++) {
        orig256[i] = (uint8_t)(0xA1U + i * 3U);
    }
    for (op = 0; op < 4; op++) {
        ctx_perm256_t c;
        memcpy(s256, orig256, 32);
        c.fn = ops256[op].fn;
        c.s = s256;
        w = capture_areion_frame_and_reg_residue(cb_perm256, &c, res);
        targets_init(&targets);
        targets_add_bytes(&targets, orig256, 32);
        targets_add_bytes(&targets, s256, 32);
        assert_no_leak(tier_name, ops256[op].name, w, res, &targets);
    }

    /* Single-block 512 */
    for (i = 0; i < 64; i++) {
        orig512[i] = (uint8_t)(0x53U + i * 5U);
    }
    for (op = 0; op < 4; op++) {
        ctx_perm512_t c;
        memcpy(s512, orig512, 64);
        c.fn = ops512[op].fn;
        c.s = s512;
        w = capture_areion_frame_and_reg_residue(cb_perm512, &c, res);
        targets_init(&targets);
        targets_add_bytes(&targets, orig512, 64);
        targets_add_bytes(&targets, s512, 64);
        assert_no_leak(tier_name, ops512[op].name, w, res, &targets);
    }

    /* 4-way 256x4 */
    for (l = 0; l < 4; l++) {
        for (i = 0; i < 32; i++) {
            orig256x4[l][i] = (uint8_t)(0x19U + l * 37U + i * 7U);
        }
    }
    for (op = 0; op < 4; op++) {
        ctx_perm256x4_t c;
        memcpy(s256x4, orig256x4, sizeof(s256x4));
        c.fn = ops256x4[op].fn;
        c.s = s256x4;
        w = capture_areion_frame_and_reg_residue(cb_perm256x4, &c, res);
        targets_init(&targets);
        targets_add_bytes(&targets, &orig256x4[0][0], sizeof(orig256x4));
        targets_add_bytes(&targets, &s256x4[0][0], sizeof(s256x4));
        assert_no_leak(tier_name, ops256x4[op].name, w, res, &targets);
    }

    /* 4-way 512x4 */
    for (l = 0; l < 4; l++) {
        for (i = 0; i < 64; i++) {
            orig512x4[l][i] = (uint8_t)(0x2BU + l * 41U + i * 3U);
        }
    }
    for (op = 0; op < 4; op++) {
        ctx_perm512x4_t c;
        memcpy(s512x4, orig512x4, sizeof(s512x4));
        c.fn = ops512x4[op].fn;
        c.s = s512x4;
        w = capture_areion_frame_and_reg_residue(cb_perm512x4, &c, res);
        targets_init(&targets);
        targets_add_bytes(&targets, &orig512x4[0][0], sizeof(orig512x4));
        targets_add_bytes(&targets, &s512x4[0][0], sizeof(s512x4));
        assert_no_leak(tier_name, ops512x4[op].name, w, res, &targets);
    }

    /* DM256, DM512, SoEM256, SoEM512 */
    for (i = 0; i < 64; i++) {
        k256[i] = (uint8_t)(0x71U + i * 3U);
    }
    for (i = 0; i < 32; i++) {
        orig256[i] = (uint8_t)(0x3DU + i * 5U);
    }
    {
        ctx_dm_t cdm = { out256, orig256 };
        w = capture_areion_frame_and_reg_residue(cb_dm256, &cdm, res);
        targets_init(&targets);
        targets_add_bytes(&targets, orig256, 32);
        assert_no_leak(tier_name, "DM256", w, res, &targets);
    }
    {
        ctx_soem_t csoem = { out256, k256, orig256 };
        w = capture_areion_frame_and_reg_residue(cb_soem256, &csoem, res);
        targets_init(&targets);
        targets_add_bytes(&targets, k256, 64);
        targets_add_bytes(&targets, orig256, 32);
        assert_no_leak(tier_name, "SoEM256", w, res, &targets);
    }

    for (i = 0; i < 128; i++) {
        k512[i] = (uint8_t)(0x83U + i * 3U);
    }
    for (i = 0; i < 64; i++) {
        orig512[i] = (uint8_t)(0x47U + i * 5U);
    }
    {
        ctx_dm_t cdm = { out256, orig512 };
        w = capture_areion_frame_and_reg_residue(cb_dm512, &cdm, res);
        targets_init(&targets);
        targets_add_bytes(&targets, orig512, 64);
        assert_no_leak(tier_name, "DM512", w, res, &targets);
    }
    {
        ctx_soem_t csoem = { out512, k512, orig512 };
        w = capture_areion_frame_and_reg_residue(cb_soem512, &csoem, res);
        targets_init(&targets);
        targets_add_bytes(&targets, k512, 128);
        targets_add_bytes(&targets, orig512, 64);
        assert_no_leak(tier_name, "SoEM512", w, res, &targets);
    }

    /* SoEM256x4 & SoEM512x4 */
    for (l = 0; l < 4; l++) {
        for (i = 0; i < 64; i++) {
            k256x4[l][i] = (uint8_t)(0x91U + l * 29U + i * 3U);
        }
        for (i = 0; i < 32; i++) {
            orig256x4[l][i] = (uint8_t)(0x4BU + l * 31U + i * 5U);
        }
        for (i = 0; i < 128; i++) {
            k512x4[l][i] = (uint8_t)(0xA7U + l * 23U + i * 3U);
        }
        for (i = 0; i < 64; i++) {
            orig512x4[l][i] = (uint8_t)(0x59U + l * 19U + i * 5U);
        }
    }
    {
        ctx_soem256x4_t c4 = { out256x4, (const uint8_t (*)[64])k256x4, (const uint8_t (*)[32])orig256x4 };
        w = capture_areion_frame_and_reg_residue(cb_soem256x4, &c4, res);
        targets_init(&targets);
        targets_add_bytes(&targets, &k256x4[0][0], sizeof(k256x4));
        targets_add_bytes(&targets, &orig256x4[0][0], sizeof(orig256x4));
        assert_no_leak(tier_name, "SoEM256x4", w, res, &targets);
    }
    {
        ctx_soem512x4_t c4 = { out512x4, (const uint8_t (*)[128])k512x4, (const uint8_t (*)[64])orig512x4 };
        w = capture_areion_frame_and_reg_residue(cb_soem512x4, &c4, res);
        targets_init(&targets);
        targets_add_bytes(&targets, &k512x4[0][0], sizeof(k512x4));
        targets_add_bytes(&targets, &orig512x4[0][0], sizeof(orig512x4));
        assert_no_leak(tier_name, "SoEM512x4", w, res, &targets);
    }

    /* Wide-block EM / EM2 / TEM / TEM2 (single & x4) */
    {
        static const struct { const char *name; fn_em256_t fn; } ops_em256[] = {
            {"EMEncrypt256", areion_em_encrypt256},
            {"EMDecrypt256", areion_em_decrypt256},
            {"EM2Encrypt256", areion_em2_encrypt256},
            {"EM2Decrypt256", areion_em2_decrypt256}
        };
        static const struct { const char *name; fn_em512_t fn; } ops_em512[] = {
            {"EMEncrypt512", areion_em_encrypt512},
            {"EMDecrypt512", areion_em_decrypt512},
            {"EM2Encrypt512", areion_em2_encrypt512},
            {"EM2Decrypt512", areion_em2_decrypt512}
        };
        static const struct { const char *name; fn_tem256_t fn; } ops_tem256[] = {
            {"TEMEncrypt256", areion_tem_encrypt256},
            {"TEMDecrypt256", areion_tem_decrypt256},
            {"TEM2Encrypt256", areion_tem2_encrypt256},
            {"TEM2Decrypt256", areion_tem2_decrypt256}
        };
        static const struct { const char *name; fn_tem512_t fn; } ops_tem512[] = {
            {"TEMEncrypt512", areion_tem_encrypt512},
            {"TEMDecrypt512", areion_tem_decrypt512},
            {"TEM2Encrypt512", areion_tem2_encrypt512},
            {"TEM2Decrypt512", areion_tem2_decrypt512}
        };
        static const struct { const char *name; fn_em256x4_t fn; } ops_em256x4[] = {
            {"EMEncrypt256x4", areion_em_encrypt256x4},
            {"EMDecrypt256x4", areion_em_decrypt256x4},
            {"EM2Encrypt256x4", areion_em2_encrypt256x4},
            {"EM2Decrypt256x4", areion_em2_decrypt256x4}
        };
        static const struct { const char *name; fn_em512x4_t fn; } ops_em512x4[] = {
            {"EMEncrypt512x4", areion_em_encrypt512x4},
            {"EMDecrypt512x4", areion_em_decrypt512x4},
            {"EM2Encrypt512x4", areion_em2_encrypt512x4},
            {"EM2Decrypt512x4", areion_em2_decrypt512x4}
        };
        static const struct { const char *name; fn_tem256x4_t fn; } ops_tem256x4[] = {
            {"TEMEncrypt256x4", areion_tem_encrypt256x4},
            {"TEMDecrypt256x4", areion_tem_decrypt256x4},
            {"TEM2Encrypt256x4", areion_tem2_encrypt256x4},
            {"TEM2Decrypt256x4", areion_tem2_decrypt256x4}
        };
        static const struct { const char *name; fn_tem512x4_t fn; } ops_tem512x4[] = {
            {"TEMEncrypt512x4", areion_tem_encrypt512x4},
            {"TEMDecrypt512x4", areion_tem_decrypt512x4},
            {"TEM2Encrypt512x4", areion_tem2_encrypt512x4},
            {"TEM2Decrypt512x4", areion_tem2_decrypt512x4}
        };
        uint8_t tw256[32], tw512[64];
        uint8_t tw256x4[4][32], tw512x4[4][64];

        for (i = 0; i < 32; i++) {
            tw256[i] = (uint8_t)(0xB3U + i * 7U);
        }
        for (i = 0; i < 64; i++) {
            tw512[i] = (uint8_t)(0xC5U + i * 7U);
        }
        for (l = 0; l < 4; l++) {
            for (i = 0; i < 32; i++) {
                tw256x4[l][i] = (uint8_t)(0xD7U + l * 17U + i * 7U);
            }
            for (i = 0; i < 64; i++) {
                tw512x4[l][i] = (uint8_t)(0xE9U + l * 13U + i * 7U);
            }
        }

        for (op = 0; op < 4; op++) {
            ctx_em256_t cem256 = { ops_em256[op].fn, out256, k256, orig256 };
            w = capture_areion_frame_and_reg_residue(cb_em256, &cem256, res);
            targets_init(&targets);
            targets_add_bytes(&targets, k256, 64);
            targets_add_bytes(&targets, orig256, 32);
            targets_add_bytes(&targets, out256, 32);
            assert_no_leak(tier_name, ops_em256[op].name, w, res, &targets);
        }
        for (op = 0; op < 4; op++) {
            ctx_em512_t cem512 = { ops_em512[op].fn, out512, k512, orig512 };
            w = capture_areion_frame_and_reg_residue(cb_em512, &cem512, res);
            targets_init(&targets);
            targets_add_bytes(&targets, k512, 128);
            targets_add_bytes(&targets, orig512, 64);
            targets_add_bytes(&targets, out512, 64);
            assert_no_leak(tier_name, ops_em512[op].name, w, res, &targets);
        }
        for (op = 0; op < 4; op++) {
            ctx_tem256_t ctem256 = { ops_tem256[op].fn, out256, k256, tw256, orig256 };
            w = capture_areion_frame_and_reg_residue(cb_tem256, &ctem256, res);
            targets_init(&targets);
            targets_add_bytes(&targets, k256, 64);
            targets_add_bytes(&targets, tw256, 32);
            targets_add_bytes(&targets, orig256, 32);
            targets_add_bytes(&targets, out256, 32);
            assert_no_leak(tier_name, ops_tem256[op].name, w, res, &targets);
        }
        for (op = 0; op < 4; op++) {
            ctx_tem512_t ctem512 = { ops_tem512[op].fn, out512, k512, tw512, orig512 };
            w = capture_areion_frame_and_reg_residue(cb_tem512, &ctem512, res);
            targets_init(&targets);
            targets_add_bytes(&targets, k512, 128);
            targets_add_bytes(&targets, tw512, 64);
            targets_add_bytes(&targets, orig512, 64);
            targets_add_bytes(&targets, out512, 64);
            assert_no_leak(tier_name, ops_tem512[op].name, w, res, &targets);
        }
        for (op = 0; op < 4; op++) {
            ctx_em256x4_t c4 = { ops_em256x4[op].fn, out256x4, (const uint8_t (*)[64])k256x4, (const uint8_t (*)[32])orig256x4 };
            w = capture_areion_frame_and_reg_residue(cb_em256x4, &c4, res);
            targets_init(&targets);
            targets_add_bytes(&targets, &k256x4[0][0], sizeof(k256x4));
            targets_add_bytes(&targets, &orig256x4[0][0], sizeof(orig256x4));
            targets_add_bytes(&targets, &out256x4[0][0], sizeof(out256x4));
            assert_no_leak(tier_name, ops_em256x4[op].name, w, res, &targets);
        }
        for (op = 0; op < 4; op++) {
            ctx_em512x4_t c4 = { ops_em512x4[op].fn, out512x4, (const uint8_t (*)[128])k512x4, (const uint8_t (*)[64])orig512x4 };
            w = capture_areion_frame_and_reg_residue(cb_em512x4, &c4, res);
            targets_init(&targets);
            targets_add_bytes(&targets, &k512x4[0][0], sizeof(k512x4));
            targets_add_bytes(&targets, &orig512x4[0][0], sizeof(orig512x4));
            targets_add_bytes(&targets, &out512x4[0][0], sizeof(out512x4));
            assert_no_leak(tier_name, ops_em512x4[op].name, w, res, &targets);
        }
        for (op = 0; op < 4; op++) {
            ctx_tem256x4_t c4 = {
                ops_tem256x4[op].fn, out256x4, (const uint8_t (*)[64])k256x4,
                (const uint8_t (*)[32])tw256x4, (const uint8_t (*)[32])orig256x4
            };
            w = capture_areion_frame_and_reg_residue(cb_tem256x4, &c4, res);
            targets_init(&targets);
            targets_add_bytes(&targets, &k256x4[0][0], sizeof(k256x4));
            targets_add_bytes(&targets, &tw256x4[0][0], sizeof(tw256x4));
            targets_add_bytes(&targets, &orig256x4[0][0], sizeof(orig256x4));
            targets_add_bytes(&targets, &out256x4[0][0], sizeof(out256x4));
            assert_no_leak(tier_name, ops_tem256x4[op].name, w, res, &targets);
        }
        for (op = 0; op < 4; op++) {
            ctx_tem512x4_t c4 = {
                ops_tem512x4[op].fn, out512x4, (const uint8_t (*)[128])k512x4,
                (const uint8_t (*)[64])tw512x4, (const uint8_t (*)[64])orig512x4
            };
            w = capture_areion_frame_and_reg_residue(cb_tem512x4, &c4, res);
            targets_init(&targets);
            targets_add_bytes(&targets, &k512x4[0][0], sizeof(k512x4));
            targets_add_bytes(&targets, &tw512x4[0][0], sizeof(tw512x4));
            targets_add_bytes(&targets, &orig512x4[0][0], sizeof(orig512x4));
            targets_add_bytes(&targets, &out512x4[0][0], sizeof(out512x4));
            assert_no_leak(tier_name, ops_tem512x4[op].name, w, res, &targets);
        }
    }

    /* AES-128 block and 4-block primitives */
    for (i = 0; i < 16; i++) {
        aes_key[i] = (uint8_t)(0x61U + i * 7U);
        aes_in[i] = (uint8_t)(0xC3U + i * 11U);
    }
    {
        ctx_aes_t caes = { aes_key, rk, aes_out, aes_in };
        w = capture_areion_frame_and_reg_residue(cb_expand_key, &caes, res);
        targets_init(&targets);
        targets_add_bytes(&targets, aes_key, 16);
        assert_no_leak(tier_name, "ExpandKey128", w, res, &targets);

        w = capture_areion_frame_and_reg_residue(cb_aes_enc1, &caes, res);
        targets_init(&targets);
        targets_add_bytes(&targets, aes_key, 16);
        targets_add_bytes(&targets, aes_in, 16);
        targets_add_bytes(&targets, aes_out, 16);
        assert_no_leak(tier_name, "AES128EncryptBlock", w, res, &targets);

        memcpy(aes_out, aes_in, 16);
        w = capture_areion_frame_and_reg_residue(cb_round_hw1, &caes, res);
        targets_init(&targets);
        targets_add_bytes(&targets, aes_in, 16);
        targets_add_bytes(&targets, aes_out, 16);
        assert_no_leak(tier_name, "RoundHW", w, res, &targets);

        memcpy(aes_out, aes_in, 16);
        w = capture_areion_frame_and_reg_residue(cb_final_round_hw1, &caes, res);
        targets_init(&targets);
        targets_add_bytes(&targets, aes_in, 16);
        targets_add_bytes(&targets, aes_out, 16);
        assert_no_leak(tier_name, "FinalRoundHW", w, res, &targets);

        memcpy(aes_out, aes_in, 16);
        w = capture_areion_frame_and_reg_residue(cb_aes_round1, &caes, res);
        targets_init(&targets);
        targets_add_bytes(&targets, aes_key, 16);
        targets_add_bytes(&targets, aes_in, 16);
        targets_add_bytes(&targets, aes_out, 16);
        assert_no_leak(tier_name, "AESRoundHW", w, res, &targets);

        memcpy(aes_out, aes_in, 16);
        w = capture_areion_frame_and_reg_residue(cb_aes_final_round1, &caes, res);
        targets_init(&targets);
        targets_add_bytes(&targets, aes_key, 16);
        targets_add_bytes(&targets, aes_in, 16);
        targets_add_bytes(&targets, aes_out, 16);
        assert_no_leak(tier_name, "AESFinalRoundHW", w, res, &targets);

        memcpy(aes_out, aes_in, 16);
        w = capture_areion_frame_and_reg_residue(cb_aes128_round1, &caes, res);
        targets_init(&targets);
        targets_add_bytes(&targets, aes_key, 16);
        targets_add_bytes(&targets, aes_in, 16);
        targets_add_bytes(&targets, aes_out, 16);
        assert_no_leak(tier_name, "AES128Round", w, res, &targets);

        memcpy(aes_out, aes_in, 16);
        w = capture_areion_frame_and_reg_residue(cb_aes128_final_round1, &caes, res);
        targets_init(&targets);
        targets_add_bytes(&targets, aes_key, 16);
        targets_add_bytes(&targets, aes_in, 16);
        targets_add_bytes(&targets, aes_out, 16);
        assert_no_leak(tier_name, "AES128FinalRound", w, res, &targets);

        memcpy(aes_out, aes_in, 16);
        w = capture_areion_frame_and_reg_residue(cb_xor_block, &caes, res);
        targets_init(&targets);
        targets_add_bytes(&targets, aes_key, 16);
        targets_add_bytes(&targets, aes_in, 16);
        targets_add_bytes(&targets, aes_out, 16);
        assert_no_leak(tier_name, "XorBlock", w, res, &targets);
    }

    for (l = 0; l < 4; l++) {
        for (i = 0; i < 16; i++) {
            aes_in4[l][i] = (uint8_t)(0xD1U + (l * 16U + i) * 3U);
            aes_key4[l][i] = (uint8_t)(0xE3U + (l * 16U + i) * 5U);
        }
    }
    {
        ctx_aes4_t c4 = { aes_out4, (const uint8_t (*)[16])aes_in4, (const uint8_t (*)[16])rk };
        w = capture_areion_frame_and_reg_residue(cb_aes_enc4, &c4, res);
        targets_init(&targets);
        targets_add_bytes(&targets, aes_key, 16);
        targets_add_bytes(&targets, &aes_in4[0][0], 64);
        targets_add_bytes(&targets, &aes_out4[0][0], 64);
        assert_no_leak(tier_name, "AES128Encrypt4Blocks", w, res, &targets);
    }
    {
        ctx_round4_t cr4 = { aes_out4, (const uint8_t (*)[16])aes_key4 };
        memcpy(aes_out4, aes_in4, 64);
        w = capture_areion_frame_and_reg_residue(cb_round4_hw, &cr4, res);
        targets_init(&targets);
        targets_add_bytes(&targets, &aes_in4[0][0], 64);
        targets_add_bytes(&targets, &aes_out4[0][0], 64);
        assert_no_leak(tier_name, "Round4HW", w, res, &targets);

        memcpy(aes_out4, aes_in4, 64);
        w = capture_areion_frame_and_reg_residue(cb_final_round4_hw, &cr4, res);
        targets_init(&targets);
        targets_add_bytes(&targets, &aes_in4[0][0], 64);
        targets_add_bytes(&targets, &aes_out4[0][0], 64);
        assert_no_leak(tier_name, "FinalRound4HW", w, res, &targets);

        memcpy(aes_out4, aes_in4, 64);
        w = capture_areion_frame_and_reg_residue(cb_aes_round4, &cr4, res);
        targets_init(&targets);
        targets_add_bytes(&targets, &aes_key4[0][0], 64);
        targets_add_bytes(&targets, &aes_in4[0][0], 64);
        targets_add_bytes(&targets, &aes_out4[0][0], 64);
        assert_no_leak(tier_name, "AESRound4HW", w, res, &targets);

        memcpy(aes_out4, aes_in4, 64);
        w = capture_areion_frame_and_reg_residue(cb_aes_final_round4, &cr4, res);
        targets_init(&targets);
        targets_add_bytes(&targets, &aes_key4[0][0], 64);
        targets_add_bytes(&targets, &aes_in4[0][0], 64);
        targets_add_bytes(&targets, &aes_out4[0][0], 64);
        assert_no_leak(tier_name, "AESFinalRound4HW", w, res, &targets);

        memcpy(aes_out4, aes_in4, 64);
        w = capture_areion_frame_and_reg_residue(cb_aes128_round4, &cr4, res);
        targets_init(&targets);
        targets_add_bytes(&targets, &aes_key4[0][0], 64);
        targets_add_bytes(&targets, &aes_in4[0][0], 64);
        targets_add_bytes(&targets, &aes_out4[0][0], 64);
        assert_no_leak(tier_name, "AES128Round4", w, res, &targets);

        memcpy(aes_out4, aes_in4, 64);
        w = capture_areion_frame_and_reg_residue(cb_aes128_final_round4, &cr4, res);
        targets_init(&targets);
        targets_add_bytes(&targets, &aes_key4[0][0], 64);
        targets_add_bytes(&targets, &aes_in4[0][0], 64);
        targets_add_bytes(&targets, &aes_out4[0][0], 64);
        assert_no_leak(tier_name, "AES128FinalRound4", w, res, &targets);

        memcpy(aes_out4, aes_in4, 64);
        w = capture_areion_frame_and_reg_residue(cb_xor_block4, &cr4, res);
        targets_init(&targets);
        targets_add_bytes(&targets, &aes_key4[0][0], 64);
        targets_add_bytes(&targets, &aes_in4[0][0], 64);
        targets_add_bytes(&targets, &aes_out4[0][0], 64);
        assert_no_leak(tier_name, "XorBlock4", w, res, &targets);
    }

    /* Rijndael-256 single-block and 4-block primitives */
    {
        uint8_t r256_rk[15][32];
        ctx_r256_t cr256;
        ctx_r256x4_t cr256x4;
        size_t r;

        for (r = 0; r < 15; r++) {
            for (i = 0; i < 32; i++) {
                r256_rk[r][i] = (uint8_t)(0x41U + r * 17U + i * 5U);
            }
        }
        for (i = 0; i < 32; i++) {
            orig256[i] = (uint8_t)(0x5BU + i * 7U);
        }
        cr256.dst = out256;
        cr256.src = orig256;
        cr256.rk = (const uint8_t (*)[32])r256_rk;
        w = capture_areion_frame_and_reg_residue(cb_r256_enc1, &cr256, res);
        targets_init(&targets);
        targets_add_bytes(&targets, orig256, 32);
        targets_add_bytes(&targets, &r256_rk[0][0], 64);
        targets_add_bytes(&targets, &r256_rk[7][0], 64);
        targets_add_bytes(&targets, &r256_rk[13][0], 64);
        targets_add_bytes(&targets, out256, 32);
        assert_no_leak(tier_name, "Rijndael256EncryptBlockHW", w, res, &targets);

        for (l = 0; l < 4; l++) {
            for (i = 0; i < 32; i++) {
                orig256x4[l][i] = (uint8_t)(0x73U + (l * 32U + i) * 3U);
            }
        }
        cr256x4.dst = out256x4;
        cr256x4.src = (const uint8_t (*)[32])orig256x4;
        cr256x4.rk = (const uint8_t (*)[32])r256_rk;
        w = capture_areion_frame_and_reg_residue(cb_r256_enc4, &cr256x4, res);
        targets_init(&targets);
        targets_add_bytes(&targets, &orig256x4[0][0], sizeof(orig256x4));
        targets_add_bytes(&targets, &r256_rk[0][0], 64);
        targets_add_bytes(&targets, &r256_rk[7][0], 64);
        targets_add_bytes(&targets, &r256_rk[13][0], 64);
        targets_add_bytes(&targets, &out256x4[0][0], sizeof(out256x4));
        assert_no_leak(tier_name, "Rijndael256Encrypt4BlocksHW", w, res, &targets);
    }

    /* Vistrutah-256 and Vistrutah-512 single-block and 4-block primitives */
    {
        ctx_vis1_t cv1;
        ctx_vis256x4_t cv256x4;
        ctx_vis512x4_t cv512x4;

        for (i = 0; i < 64; i++) {
            k256[i] = (uint8_t)(0x43U + i * 5U);
            orig512[i] = (uint8_t)(0x59U + i * 7U);
        }
        for (i = 0; i < 32; i++) {
            orig256[i] = (uint8_t)(0x6BU + i * 3U);
        }
        cv1.dst = out256;
        cv1.src = orig256;
        cv1.key = k256;
        cv1.rounds = 14;
        w = capture_areion_frame_and_reg_residue(cb_v256_enc1, &cv1, res);
        targets_init(&targets);
        targets_add_bytes(&targets, orig256, 32);
        targets_add_bytes(&targets, k256, 32);
        targets_add_bytes(&targets, out256, 32);
        assert_no_leak(tier_name, "Vistrutah256EncryptBlockHW", w, res, &targets);

        w = capture_areion_frame_and_reg_residue(cb_v256_dec1, &cv1, res);
        targets_init(&targets);
        targets_add_bytes(&targets, orig256, 32);
        targets_add_bytes(&targets, k256, 32);
        targets_add_bytes(&targets, out256, 32);
        assert_no_leak(tier_name, "Vistrutah256DecryptBlockPureC", w, res, &targets);

        cv256x4.dst = out256x4;
        cv256x4.src = (const uint8_t (*)[32])orig256x4;
        cv256x4.key = k256;
        cv256x4.rounds = 14;
        w = capture_areion_frame_and_reg_residue(cb_v256_enc4, &cv256x4, res);
        targets_init(&targets);
        targets_add_bytes(&targets, &orig256x4[0][0], sizeof(orig256x4));
        targets_add_bytes(&targets, k256, 32);
        targets_add_bytes(&targets, &out256x4[0][0], sizeof(out256x4));
        assert_no_leak(tier_name, "Vistrutah256Encrypt4BlocksHW", w, res, &targets);

        cv1.dst = out512;
        cv1.src = orig512;
        cv1.key = k256;
        cv1.rounds = 14;
        w = capture_areion_frame_and_reg_residue(cb_v512_256_enc1, &cv1, res);
        targets_init(&targets);
        targets_add_bytes(&targets, orig512, 64);
        targets_add_bytes(&targets, k256, 32);
        targets_add_bytes(&targets, out512, 64);
        assert_no_leak(tier_name, "Vistrutah512EncryptBlock256HW", w, res, &targets);

        w = capture_areion_frame_and_reg_residue(cb_v512_256_dec1, &cv1, res);
        targets_init(&targets);
        targets_add_bytes(&targets, orig512, 64);
        targets_add_bytes(&targets, k256, 32);
        targets_add_bytes(&targets, out512, 64);
        assert_no_leak(tier_name, "Vistrutah512DecryptBlock256PureC", w, res, &targets);

        cv1.rounds = 18;
        w = capture_areion_frame_and_reg_residue(cb_v512_512_enc1, &cv1, res);
        targets_init(&targets);
        targets_add_bytes(&targets, orig512, 64);
        targets_add_bytes(&targets, k256, 64);
        targets_add_bytes(&targets, out512, 64);
        assert_no_leak(tier_name, "Vistrutah512EncryptBlock512HW", w, res, &targets);

        w = capture_areion_frame_and_reg_residue(cb_v512_512_dec1, &cv1, res);
        targets_init(&targets);
        targets_add_bytes(&targets, orig512, 64);
        targets_add_bytes(&targets, k256, 64);
        targets_add_bytes(&targets, out512, 64);
        assert_no_leak(tier_name, "Vistrutah512DecryptBlock512PureC", w, res, &targets);

        cv512x4.dst = out512x4;
        cv512x4.src = (const uint8_t (*)[64])orig512x4;
        cv512x4.key = k256;
        cv512x4.rounds = 14;
        w = capture_areion_frame_and_reg_residue(cb_v512_256_enc4, &cv512x4, res);
        targets_init(&targets);
        targets_add_bytes(&targets, &orig512x4[0][0], sizeof(orig512x4));
        targets_add_bytes(&targets, k256, 32);
        targets_add_bytes(&targets, &out512x4[0][0], sizeof(out512x4));
        assert_no_leak(tier_name, "Vistrutah512Encrypt4Blocks256HW", w, res, &targets);

        cv512x4.rounds = 18;
        w = capture_areion_frame_and_reg_residue(cb_v512_512_enc4, &cv512x4, res);
        targets_init(&targets);
        targets_add_bytes(&targets, &orig512x4[0][0], sizeof(orig512x4));
        targets_add_bytes(&targets, k256, 64);
        targets_add_bytes(&targets, &out512x4[0][0], sizeof(out512x4));
        assert_no_leak(tier_name, "Vistrutah512Encrypt4Blocks512HW", w, res, &targets);
    }

    /* Word-level permutations and AES round primitives */
    {
        static const struct { const char *name; fn_perm256_words_t fn; } ops256w[] = {
            {"Permute256Words", areion_permute256_words},
            {"InversePermute256Words", areion_inverse_permute256_words}
        };
        static const struct { const char *name; fn_perm512_words_t fn; } ops512w[] = {
            {"Permute512Words", areion_permute512_words},
            {"InversePermute512Words", areion_inverse_permute512_words}
        };
        static const struct { const char *name; fn_round_words_t fn; } ops_rw[] = {
            {"Round", areion_round},
            {"FinalRound", areion_final_round},
            {"InvRound", areion_inv_round},
            {"InvFinalRound", areion_inv_final_round},
            {"InvMixColumns", areion_inv_mix_columns}
        };
        uint32_t orig_w256[8], w256[8];
        uint32_t orig_w512[16], w512[16];
        uint32_t rw_in[4], rw_out[4];
        uint8_t bytes_buf[64];

        for (i = 0; i < 8; i++) {
            orig_w256[i] = 0x13572468U + (uint32_t)i * 0x11111111U;
        }
        for (op = 0; op < 2; op++) {
            const uint32_t *p_orig256 = orig_w256;
            ctx_perm256_words_t cw = { ops256w[op].fn, w256 };
            AREION_OPAQUE_PTR(p_orig256);
            memcpy(w256, p_orig256, sizeof(w256));
            w = capture_areion_frame_and_reg_residue(cb_perm256_words, &cw, res);
            AREION_OPAQUE_PTR(p_orig256);
            targets_init(&targets);
            for (i = 0; i < 8; i++) {
                areion_store_le32(&bytes_buf[i * 4], p_orig256[i]);
            }
            targets_add_bytes(&targets, bytes_buf, 32);
            for (i = 0; i < 8; i++) {
                areion_store_le32(&bytes_buf[i * 4], w256[i]);
            }
            targets_add_bytes(&targets, bytes_buf, 32);
            assert_no_leak(tier_name, ops256w[op].name, w, res, &targets);
        }

        for (i = 0; i < 16; i++) {
            orig_w512[i] = 0x24681357U + (uint32_t)i * 0x07070707U;
        }
        for (op = 0; op < 2; op++) {
            const uint32_t *p_orig512 = orig_w512;
            ctx_perm512_words_t cw = { ops512w[op].fn, w512 };
            AREION_OPAQUE_PTR(p_orig512);
            memcpy(w512, p_orig512, sizeof(w512));
            w = capture_areion_frame_and_reg_residue(cb_perm512_words, &cw, res);
            AREION_OPAQUE_PTR(p_orig512);
            targets_init(&targets);
            for (i = 0; i < 16; i++) {
                areion_store_le32(&bytes_buf[i * 4], p_orig512[i]);
            }
            targets_add_bytes(&targets, bytes_buf, 64);
            for (i = 0; i < 16; i++) {
                areion_store_le32(&bytes_buf[i * 4], w512[i]);
            }
            targets_add_bytes(&targets, bytes_buf, 64);
            assert_no_leak(tier_name, ops512w[op].name, w, res, &targets);
        }

        for (i = 0; i < 4; i++) {
            rw_in[i] = 0x9ABCDEF0U + (uint32_t)i * 0x12345678U;
        }
        for (op = 0; op < 5; op++) {
            ctx_round_words_t crw = { ops_rw[op].fn, rw_in, rw_out };
            w = capture_areion_frame_and_reg_residue(cb_round_words, &crw, res);
            targets_init(&targets);
            for (i = 0; i < 4; i++) {
                areion_store_le32(&bytes_buf[i * 4], rw_in[i]);
            }
            targets_add_bytes(&targets, bytes_buf, 16);
            for (i = 0; i < 4; i++) {
                areion_store_le32(&bytes_buf[i * 4], rw_out[i]);
            }
            targets_add_bytes(&targets, bytes_buf, 16);
            assert_no_leak(tier_name, ops_rw[op].name, w, res, &targets);
        }
    }

    areion_wipe_expanded_key128(rk);
}

static AREION_NOINLINE void cb_dse_zeroize_stack(const void *p) {
    const uint8_t *seed = (const uint8_t *)p;
    uint8_t secret_stack[64];
    volatile uint8_t *vs = secret_stack;
    size_t i;
    for (i = 0; i < sizeof(secret_stack); i++) {
        vs[i] = (uint8_t)(seed[i] ^ 0x5AU);
    }
    g_areion_sink ^= (uint64_t)secret_stack[0];
    areion_zeroize(secret_stack, sizeof(secret_stack));
}

static void cb_selftest_wrap(const void *p) {
    (void)p;
    if (areion_selftest() != 0) {
        g_zeroize_failures++;
    }
}

static void test_public_zeroize_and_selftest(uint64_t res[AREION_TOTAL_WORDS]) {
    uint8_t buf[128], seed[64], expected_secret[64], selftest_pat[24];
    target_list_t targets;
    size_t i, w;

    areion_zeroize(NULL, 0);
    areion_zeroize(NULL, 64);

    for (i = 0; i < sizeof(buf); i++) {
        buf[i] = (uint8_t)(0xA5U ^ (uint8_t)i);
    }
    areion_zeroize(buf, 0);
    for (i = 0; i < sizeof(buf); i++) {
        if (buf[i] != (uint8_t)(0xA5U ^ (uint8_t)i)) {
            (void)fprintf(stderr, "FAIL: areion_zeroize(buf, 0) modified buffer at %u\n", (unsigned)i);
            g_zeroize_failures++;
        }
    }

    areion_zeroize(buf + 7, 73);
    for (i = 0; i < sizeof(buf); i++) {
        uint8_t want = (i >= 7U && i < 80U) ? 0U : (uint8_t)(0xA5U ^ (uint8_t)i);
        if (buf[i] != want) {
            (void)fprintf(stderr, "FAIL: areion_zeroize partial unaligned scrub mismatch at %u\n", (unsigned)i);
            g_zeroize_failures++;
        }
    }

    for (i = 0; i < sizeof(seed); i++) {
        seed[i] = (uint8_t)(0x33U + i * 7U);
        expected_secret[i] = (uint8_t)(seed[i] ^ 0x5AU);
    }
    w = capture_areion_frame_and_reg_residue(cb_dse_zeroize_stack, seed, res);
    targets_init(&targets);
    targets_add_bytes(&targets, expected_secret, sizeof(expected_secret));
    assert_no_leak(areion_tier(), "areion_zeroize_DSE_stack", w, res, &targets);

    for (i = 0; i < 8U; i++) {
        selftest_pat[i] = (uint8_t)(8U + i);
        selftest_pat[8U + i] = (uint8_t)(0x80U + i);
        selftest_pat[16U + i] = (uint8_t)(0x40U + i);
    }
    w = capture_areion_frame_and_reg_residue(cb_selftest_wrap, NULL, res);
    targets_init(&targets);
    targets_add_bytes(&targets, selftest_pat, sizeof(selftest_pat));
    assert_no_leak(areion_tier(), "areion_selftest", w, res, &targets);
}

int main(void) {
    static const areion_tier_t all_tiers[] = {
        AREION_TIER_PUREC,
        AREION_TIER_AESNI,
        AREION_TIER_VEX,
        AREION_TIER_VAESAVX2,
        AREION_TIER_AVX512,
        AREION_TIER_ARM64
    };
    uint64_t res[AREION_TOTAL_WORDS];
    size_t t;

    (void)setvbuf(stdout, NULL, _IONBF, 0);
    printf("=== Areion Stack & Register Zeroization Verification ===\n");
    test_negative_controls(res);

    for (t = 0; t < sizeof(all_tiers) / sizeof(all_tiers[0]); t++) {
        areion_tier_t tier = all_tiers[t];
        if (!areion_tier_supported(tier)) {
            continue;
        }
        (void)areion_set_tier_override(tier);
        printf("Zeroization test tier: %s ... ", areion_tier());
        (void)fflush(stdout);
        test_public_zeroize_and_selftest(res);
        test_tier_zeroization(tier, res);
        printf("OK\n");
    }

    (void)areion_set_tier_override(AREION_TIER_AUTO);
    (void)g_areion_sink;

    if (g_zeroize_failures != 0) {
        (void)fprintf(stderr, "FAILED: %d zeroization check(s) failed.\n", g_zeroize_failures);
        return 1;
    }
    printf("ALL ZEROIZATION TESTS PASSED.\n");
    return 0;
}
