/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion.h"
#include "areion_internal.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/* =========================================================================
 * SUPERCOP (eBACS) C99 Wrapper Includes (Macro-Aliased for Unit Testing)
 * ========================================================================= */

#define crypto_core supercop_areion256_core
#include "supercop/crypto_core/areion256/ref/core.c" /* NOLINT(bugprone-suspicious-include) */
#undef crypto_core
#undef CRYPTO_OUTPUTBYTES
#undef CRYPTO_INPUTBYTES
#undef CRYPTO_KEYBYTES
#undef CRYPTO_CONSTBYTES

#define crypto_core supercop_areion512_core
#include "supercop/crypto_core/areion512/ref/core.c" /* NOLINT(bugprone-suspicious-include) */
#undef crypto_core
#undef CRYPTO_OUTPUTBYTES
#undef CRYPTO_INPUTBYTES
#undef CRYPTO_KEYBYTES
#undef CRYPTO_CONSTBYTES

#define crypto_prf supercop_soem256_prf
#include "supercop/crypto_prf/soem256/ref/prf.c" /* NOLINT(bugprone-suspicious-include) */
#undef crypto_prf
#undef CRYPTO_OUTPUTBYTES
#undef CRYPTO_INPUTBYTES
#undef CRYPTO_KEYBYTES

#define crypto_prf supercop_soem512_prf
#include "supercop/crypto_prf/soem512/ref/prf.c" /* NOLINT(bugprone-suspicious-include) */
#undef crypto_prf
#undef CRYPTO_OUTPUTBYTES
#undef CRYPTO_INPUTBYTES
#undef CRYPTO_KEYBYTES

#define crypto_tbc_encrypt supercop_em256_encrypt
#define crypto_tbc_decrypt supercop_em256_decrypt
#include "supercop/crypto_tbc/em256/ref/tbc.c" /* NOLINT(bugprone-suspicious-include) */
#undef crypto_tbc_encrypt
#undef crypto_tbc_decrypt
#undef CRYPTO_BLOCKBYTES
#undef CRYPTO_KEYBYTES
#undef CRYPTO_TWEAKBYTES

#define crypto_tbc_encrypt supercop_em512_encrypt
#define crypto_tbc_decrypt supercop_em512_decrypt
#include "supercop/crypto_tbc/em512/ref/tbc.c" /* NOLINT(bugprone-suspicious-include) */
#undef crypto_tbc_encrypt
#undef crypto_tbc_decrypt
#undef CRYPTO_BLOCKBYTES
#undef CRYPTO_KEYBYTES
#undef CRYPTO_TWEAKBYTES

#define crypto_tbc_encrypt supercop_em2256_encrypt
#define crypto_tbc_decrypt supercop_em2256_decrypt
#include "supercop/crypto_tbc/em2256/ref/tbc.c" /* NOLINT(bugprone-suspicious-include) */
#undef crypto_tbc_encrypt
#undef crypto_tbc_decrypt
#undef CRYPTO_BLOCKBYTES
#undef CRYPTO_KEYBYTES
#undef CRYPTO_TWEAKBYTES

#define crypto_tbc_encrypt supercop_em2512_encrypt
#define crypto_tbc_decrypt supercop_em2512_decrypt
#include "supercop/crypto_tbc/em2512/ref/tbc.c" /* NOLINT(bugprone-suspicious-include) */
#undef crypto_tbc_encrypt
#undef crypto_tbc_decrypt
#undef CRYPTO_BLOCKBYTES
#undef CRYPTO_KEYBYTES
#undef CRYPTO_TWEAKBYTES

#define crypto_tbc_encrypt supercop_tem256_encrypt
#define crypto_tbc_decrypt supercop_tem256_decrypt
#include "supercop/crypto_tbc/tem256/ref/tbc.c" /* NOLINT(bugprone-suspicious-include) */
#undef crypto_tbc_encrypt
#undef crypto_tbc_decrypt
#undef CRYPTO_BLOCKBYTES
#undef CRYPTO_KEYBYTES
#undef CRYPTO_TWEAKBYTES

#define crypto_tbc_encrypt supercop_tem512_encrypt
#define crypto_tbc_decrypt supercop_tem512_decrypt
#include "supercop/crypto_tbc/tem512/ref/tbc.c" /* NOLINT(bugprone-suspicious-include) */
#undef crypto_tbc_encrypt
#undef crypto_tbc_decrypt
#undef CRYPTO_BLOCKBYTES
#undef CRYPTO_KEYBYTES
#undef CRYPTO_TWEAKBYTES

#define crypto_tbc_encrypt supercop_tem2256_encrypt
#define crypto_tbc_decrypt supercop_tem2256_decrypt
#include "supercop/crypto_tbc/tem2256/ref/tbc.c" /* NOLINT(bugprone-suspicious-include) */
#undef crypto_tbc_encrypt
#undef crypto_tbc_decrypt
#undef CRYPTO_BLOCKBYTES
#undef CRYPTO_KEYBYTES
#undef CRYPTO_TWEAKBYTES

#define crypto_tbc_encrypt supercop_tem2512_encrypt
#define crypto_tbc_decrypt supercop_tem2512_decrypt
#include "supercop/crypto_tbc/tem2512/ref/tbc.c" /* NOLINT(bugprone-suspicious-include) */
#undef crypto_tbc_encrypt
#undef crypto_tbc_decrypt
#undef CRYPTO_BLOCKBYTES
#undef CRYPTO_KEYBYTES
#undef CRYPTO_TWEAKBYTES

#define crypto_tbc_encrypt supercop_asura256_encrypt
#define crypto_tbc_decrypt supercop_asura256_decrypt
#include "supercop/crypto_tbc/asura256/ref/tbc.c" /* NOLINT(bugprone-suspicious-include) */
#undef crypto_tbc_encrypt
#undef crypto_tbc_decrypt
#undef CRYPTO_BLOCKBYTES
#undef CRYPTO_KEYBYTES
#undef CRYPTO_TWEAKBYTES
#undef CRYPTO_VERSION

#if defined(__unix__) || defined(__APPLE__)
extern int setenv(const char *name, const char *value, int overwrite);
extern int unsetenv(const char *name);
#endif

#if defined(_REENTRANT) || defined(AREION_TEST_PTHREAD)
#define AREION_HAS_PTHREAD_TEST 1
#include <pthread.h>
#else
#define AREION_HAS_PTHREAD_TEST 0
#endif

static int g_failures = 0;

static void check_bytes_eq(const char *label, const uint8_t *got, const uint8_t *want, size_t len) {
    if (memcmp(got, want, len) != 0) {
        size_t i;
        (void)fprintf(stderr, "FAIL [%s]:\n  got : ", label);
        for (i = 0; i < len; i++) {
            (void)fprintf(stderr, "%02x", got[i]);
        }
        (void)fprintf(stderr, "\n  want: ");
        for (i = 0; i < len; i++) {
            (void)fprintf(stderr, "%02x", want[i]);
        }
        (void)fprintf(stderr, "\n");
        g_failures++;
    }
}

static void print_hex(const char *name, const uint8_t *buf, size_t len) {
    size_t i;
    printf("%s=", name);
    for (i = 0; i < len; i++) {
        printf("%02x", buf[i]);
    }
    printf("\n");
}

static void fill_pattern(uint8_t *buf, size_t len, uint8_t seed) {
    size_t i;
    for (i = 0; i < len; i++) {
        buf[i] = (uint8_t)((i * 37U + (size_t)seed * 13U + 0x5aU) & 0xFFU);
    }
}

/* =========================================================================
 * Official Known-Answer Tests (Isobe et al., TCHES 2023 & FIPS 197)
 * ========================================================================= */

static void test_official_kats(void) {
    /* Areion-256 P1 zero input KAT */
    static const uint8_t kat256_zero_expected[32] = {
        0x28, 0x12, 0xa7, 0x24, 0x65, 0xb2, 0x6e, 0x9f,
        0xca, 0x75, 0x83, 0xf6, 0xe4, 0x12, 0x3a, 0xa1,
        0x49, 0x0e, 0x35, 0xe7, 0xd5, 0x20, 0x3e, 0x4b,
        0xa2, 0xe9, 0x27, 0xb0, 0x48, 0x2f, 0x4d, 0xb8
    };
    /* Areion-256 P1 sequential 00..1f KAT */
    static const uint8_t kat256_seq_expected[32] = {
        0x68, 0x84, 0x5f, 0x13, 0x2e, 0xe4, 0x61, 0x60,
        0x66, 0xc7, 0x02, 0xd9, 0x42, 0xa3, 0xb2, 0xc3,
        0xa3, 0x77, 0xf6, 0x5b, 0x13, 0xbb, 0x05, 0xc7,
        0xcd, 0x1f, 0xb2, 0x9c, 0x89, 0xaf, 0xa1, 0x85
    };
    /* Areion-256 P2 zero input KAT */
    static const uint8_t kat256_p2_zero_expected[32] = {
        0x94, 0x59, 0xad, 0x09, 0x73, 0x2a, 0x12, 0xdf,
        0x68, 0x63, 0x26, 0xcd, 0xb2, 0x91, 0xbd, 0x02,
        0x12, 0x39, 0xb6, 0xec, 0x01, 0xdf, 0x49, 0xd7,
        0x01, 0x89, 0x02, 0xea, 0x09, 0x47, 0x32, 0x84
    };
    /* Areion-256 P2 sequential 00..1f KAT */
    static const uint8_t kat256_p2_seq_expected[32] = {
        0xb5, 0x9b, 0x22, 0xce, 0x15, 0x37, 0xd5, 0x0d,
        0xb9, 0x49, 0xa4, 0x22, 0x26, 0x21, 0xe9, 0x17,
        0x15, 0x25, 0xfc, 0xd6, 0x50, 0xca, 0xe4, 0x41,
        0xa7, 0xc6, 0x61, 0x62, 0x67, 0x5e, 0x65, 0xe6
    };
    /* Areion-512 P1 zero input KAT */
    static const uint8_t kat512_zero_expected[64] = {
        0xb2, 0xad, 0xb0, 0x4f, 0xa9, 0x1f, 0x90, 0x15,
        0x59, 0x36, 0x71, 0x22, 0xcb, 0x3c, 0x96, 0xa9,
        0x78, 0xcf, 0x3e, 0xe4, 0xb7, 0x3c, 0x6a, 0x54,
        0x3f, 0xe6, 0xdc, 0x85, 0x77, 0x91, 0x02, 0xe7,
        0xe3, 0xf5, 0x50, 0x10, 0x16, 0xce, 0xed, 0x1d,
        0xd2, 0xc4, 0x8d, 0x0b, 0xc2, 0x12, 0xfb, 0x07,
        0xad, 0x16, 0x87, 0x94, 0xbd, 0x96, 0xcf, 0xf3,
        0x59, 0x09, 0xcd, 0xd8, 0xe2, 0x27, 0x49, 0x28
    };
    /* Areion-512 P1 sequential 00..3f KAT */
    static const uint8_t kat512_seq_expected[64] = {
        0xb6, 0x90, 0xb8, 0x82, 0x97, 0xec, 0x47, 0x0b,
        0x07, 0xdd, 0xa9, 0x2b, 0x91, 0x95, 0x9c, 0xff,
        0x13, 0x5e, 0x9a, 0xc5, 0xfc, 0x3d, 0xc9, 0xb6,
        0x47, 0xa4, 0x3f, 0x4d, 0xaa, 0x8d, 0xa7, 0xa4,
        0xe0, 0xaf, 0xbd, 0xd8, 0xe6, 0xe2, 0x55, 0xc2,
        0x45, 0x27, 0x73, 0x6b, 0x29, 0x8b, 0xd6, 0x1d,
        0xe4, 0x60, 0xba, 0xb9, 0xea, 0x79, 0x15, 0xc6,
        0xd6, 0xdd, 0xbe, 0x05, 0xfe, 0x8d, 0xde, 0x40
    };
    /* Areion-512 P2 zero input KAT */
    static const uint8_t kat512_p2_zero_expected[64] = {
        0xea, 0xb2, 0xb6, 0x7d, 0x13, 0xb2, 0x77, 0x25,
        0x1c, 0x1b, 0x37, 0xb2, 0x67, 0xf6, 0xe0, 0x95,
        0xed, 0xe5, 0x03, 0x16, 0xc3, 0x23, 0x46, 0xe2,
        0x7f, 0x92, 0x44, 0xdf, 0x53, 0x1f, 0x91, 0x54,
        0x1d, 0xfe, 0xcd, 0xf5, 0xc6, 0xe4, 0x52, 0x92,
        0xbd, 0x10, 0xb1, 0x2a, 0x07, 0x7e, 0x08, 0x13,
        0x0a, 0xe3, 0x72, 0x6f, 0x1e, 0x23, 0xfd, 0x48,
        0xeb, 0x87, 0xd3, 0x9d, 0xb3, 0x05, 0xee, 0xe8
    };
    /* Areion-512 P2 sequential 00..3f KAT */
    static const uint8_t kat512_p2_seq_expected[64] = {
        0xba, 0xd4, 0x30, 0xe7, 0xc4, 0xa1, 0x1e, 0x8c,
        0xfe, 0xc7, 0xcc, 0x58, 0xa4, 0x59, 0x15, 0xda,
        0x0e, 0x88, 0xf4, 0x96, 0x15, 0x20, 0x0c, 0x41,
        0xa4, 0x5f, 0xea, 0x75, 0xe1, 0x72, 0x5f, 0xb9,
        0xf5, 0x98, 0x18, 0xf3, 0xa3, 0x00, 0xcb, 0x89,
        0xab, 0xd6, 0xed, 0x7e, 0x50, 0xba, 0x5c, 0xc5,
        0xb8, 0xc7, 0x8e, 0x52, 0x40, 0xfa, 0xef, 0xf2,
        0xae, 0xd7, 0x23, 0x36, 0x82, 0xbc, 0x29, 0x6d
    };
    /* FIPS 197 AES-128 KAT */
    static const uint8_t aes_key[16] = {
        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
        0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
    };
    static const uint8_t aes_pt[16] = {
        0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
        0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff
    };
    static const uint8_t aes_ct_expected[16] = {
        0x69, 0xc4, 0xe0, 0xd8, 0x6a, 0x7b, 0x04, 0x30,
        0xd8, 0xcd, 0xb7, 0x80, 0x70, 0xb4, 0xc5, 0x5a
    };
    /* Isobe et al. (ePrint 2023/794) Appendix B.3 & B.4 Davies-Meyer KATs */
    static const uint8_t dm256_seq_expected[32] = {
        0x68, 0x85, 0x5d, 0x10, 0x2a, 0xe1, 0x67, 0x67,
        0x6e, 0xce, 0x08, 0xd2, 0x4e, 0xae, 0xbc, 0xcc,
        0xb3, 0x66, 0xe4, 0x48, 0x07, 0xae, 0x13, 0xd0,
        0xd5, 0x06, 0xa8, 0x87, 0x95, 0xb2, 0xbf, 0x9a
    };
    static const uint8_t dm512_zero_expected[32] = {
        0x59, 0x36, 0x71, 0x22, 0xcb, 0x3c, 0x96, 0xa9,
        0x3f, 0xe6, 0xdc, 0x85, 0x77, 0x91, 0x02, 0xe7,
        0xe3, 0xf5, 0x50, 0x10, 0x16, 0xce, 0xed, 0x1d,
        0xad, 0x16, 0x87, 0x94, 0xbd, 0x96, 0xcf, 0xf3
    };
    static const uint8_t dm512_seq_expected[32] = {
        0x0f, 0xd4, 0xa3, 0x20, 0x9d, 0x98, 0x92, 0xf0,
        0x5f, 0xbd, 0x25, 0x56, 0xb6, 0x90, 0xb9, 0xbb,
        0xc0, 0x8e, 0x9f, 0xfb, 0xc2, 0xc7, 0x73, 0xe5,
        0xd4, 0x51, 0x88, 0x8a, 0xde, 0x4c, 0x23, 0xf1
    };

    uint8_t s256[32], orig256[32], dm_out[32];
    uint8_t s512[64], orig512[64];
    uint8_t rk[11][16], ct[16];
    size_t i;

    memset(s256, 0, sizeof(s256));
    areion_dm256(dm_out, s256);
    check_bytes_eq("DM256(zero) [Appendix B.3]", dm_out, kat256_zero_expected, 32);
    areion_permute256(s256);
    check_bytes_eq("Permute256(zero) [Appendix B.1]", s256, kat256_zero_expected, 32);
    areion_inverse_permute256(s256);
    memset(orig256, 0, sizeof(orig256));
    check_bytes_eq("InversePermute256(zero)", s256, orig256, 32);

    memset(s256, 0, sizeof(s256));
    areion_permute256_p2(s256);
    check_bytes_eq("Permute256P2(zero)", s256, kat256_p2_zero_expected, 32);
    areion_inverse_permute256_p2(s256);
    check_bytes_eq("InversePermute256P2(zero)", s256, orig256, 32);

    for (i = 0; i < 32; i++) {
        orig256[i] = (uint8_t)i;
        s256[i] = (uint8_t)i;
    }
    areion_dm256(dm_out, orig256);
    check_bytes_eq("DM256(seq) [Appendix B.3]", dm_out, dm256_seq_expected, 32);
    areion_permute256(s256);
    check_bytes_eq("Permute256(seq) [Appendix B.1]", s256, kat256_seq_expected, 32);
    areion_inverse_permute256(s256);
    check_bytes_eq("InversePermute256(seq)", s256, orig256, 32);

    areion_permute256_p2(s256);
    check_bytes_eq("Permute256P2(seq)", s256, kat256_p2_seq_expected, 32);
    areion_inverse_permute256_p2(s256);
    check_bytes_eq("InversePermute256P2(seq)", s256, orig256, 32);

    memset(s512, 0, sizeof(s512));
    areion_dm512(dm_out, s512);
    check_bytes_eq("DM512(zero) [Appendix B.4]", dm_out, dm512_zero_expected, 32);
    areion_permute512(s512);
    check_bytes_eq("Permute512(zero) [Appendix B.2]", s512, kat512_zero_expected, 64);
    areion_inverse_permute512(s512);
    memset(orig512, 0, sizeof(orig512));
    check_bytes_eq("InversePermute512(zero)", s512, orig512, 64);

    memset(s512, 0, sizeof(s512));
    areion_permute512_p2(s512);
    check_bytes_eq("Permute512P2(zero)", s512, kat512_p2_zero_expected, 64);
    areion_inverse_permute512_p2(s512);
    check_bytes_eq("InversePermute512P2(zero)", s512, orig512, 64);

    for (i = 0; i < 64; i++) {
        orig512[i] = (uint8_t)i;
        s512[i] = (uint8_t)i;
    }
    areion_dm512(dm_out, orig512);
    check_bytes_eq("DM512(seq) [Appendix B.4]", dm_out, dm512_seq_expected, 32);
    areion_permute512(s512);
    check_bytes_eq("Permute512(seq) [Appendix B.2]", s512, kat512_seq_expected, 64);
    areion_inverse_permute512(s512);
    check_bytes_eq("InversePermute512(seq)", s512, orig512, 64);

    areion_permute512_p2(s512);
    check_bytes_eq("Permute512P2(seq)", s512, kat512_p2_seq_expected, 64);
    areion_inverse_permute512_p2(s512);
    check_bytes_eq("InversePermute512P2(seq)", s512, orig512, 64);

    areion_expand_key128(aes_key, rk);
    areion_aes128_encrypt_block(ct, aes_pt, rk);
    check_bytes_eq("AES128EncryptBlock(FIPS-197)", ct, aes_ct_expected, 16);
    areion_wipe_expanded_key128(rk);

    /* NIST Wide-Block KATs (EM, EM2, TEM, TEM2) */
    {
        static const uint8_t kat_em_256_expected[32] = {
            0xb1, 0x59, 0x0d, 0xe6, 0xb0, 0xee, 0x58, 0x9c,
            0x39, 0xdc, 0x13, 0x01, 0x40, 0xc0, 0xb3, 0x8b,
            0x83, 0x20, 0x60, 0x51, 0x82, 0xe5, 0xf3, 0x7a,
            0x01, 0xe5, 0x10, 0x4c, 0x4a, 0x7b, 0xfe, 0xab
        };
        static const uint8_t kat_em_512_expected[64] = {
            0x77, 0x65, 0x0f, 0xae, 0x67, 0x2e, 0x2b, 0x9d,
            0x12, 0xe5, 0xd4, 0x00, 0x43, 0x83, 0xa1, 0x62,
            0xe4, 0x69, 0x93, 0x48, 0x90, 0x94, 0xad, 0xc4,
            0xa4, 0xce, 0xa1, 0x5a, 0x65, 0x8d, 0x78, 0xa5,
            0x3b, 0x7c, 0xc4, 0x57, 0xf1, 0x08, 0xce, 0x51,
            0xfc, 0x2e, 0xb6, 0xf1, 0x23, 0x10, 0xcf, 0xc3,
            0x87, 0x41, 0xef, 0xb0, 0xb0, 0xda, 0xe5, 0x8f,
            0xe5, 0x4e, 0x96, 0x63, 0x79, 0x29, 0x97, 0xe7
        };
        static const uint8_t kat_em2_256_expected[32] = {
            0x06, 0x1a, 0x5e, 0x87, 0x82, 0x64, 0x7a, 0x6b,
            0xae, 0xcc, 0x87, 0x72, 0x2d, 0xdf, 0xf3, 0xbe,
            0xab, 0x73, 0x1f, 0x41, 0xcc, 0x40, 0x09, 0x1b,
            0xaf, 0xa6, 0x83, 0xce, 0x5f, 0x80, 0xca, 0x78
        };
        static const uint8_t kat_em2_512_expected[64] = {
            0x49, 0x65, 0xbb, 0x05, 0x38, 0x0e, 0x69, 0xa5,
            0xd7, 0x7e, 0x4e, 0xe5, 0xe1, 0xb1, 0x6e, 0xc5,
            0x9d, 0x4b, 0x38, 0xdb, 0xe4, 0x4b, 0xd5, 0xf8,
            0xf6, 0x57, 0xd4, 0x72, 0x3f, 0x0b, 0x0a, 0x0c,
            0xca, 0xe9, 0x21, 0xcf, 0x3a, 0xc6, 0x53, 0xca,
            0x95, 0xe8, 0xbd, 0x3d, 0xbb, 0xbf, 0x3d, 0x88,
            0x83, 0x5c, 0x86, 0x98, 0x37, 0x18, 0x0e, 0x3b,
            0xee, 0xcc, 0xc1, 0xf9, 0xf8, 0x1b, 0xa2, 0xf8
        };
        static const uint8_t kat_tem_256_expected[32] = {
            0xde, 0x63, 0x2e, 0x74, 0x54, 0x19, 0xba, 0x1e,
            0xb0, 0xfb, 0x40, 0x00, 0x14, 0xe4, 0xba, 0x88,
            0x31, 0x48, 0x36, 0x53, 0x2f, 0xcb, 0xe6, 0x91,
            0x1a, 0x61, 0x89, 0x61, 0xd6, 0x19, 0x30, 0x5b
        };
        static const uint8_t kat_tem_512_expected[64] = {
            0x90, 0x59, 0x5f, 0x2a, 0x0b, 0x87, 0xfd, 0xa6,
            0xcc, 0x75, 0x1c, 0x95, 0xdc, 0xed, 0xc8, 0xd6,
            0xf3, 0x9b, 0xc1, 0x83, 0x0b, 0xf2, 0x91, 0x8a,
            0x47, 0x0d, 0x70, 0x1f, 0xf8, 0x1b, 0x7d, 0x35,
            0xe8, 0x67, 0xd4, 0xd8, 0xba, 0x3c, 0x86, 0x36,
            0xb7, 0x4f, 0x82, 0xf3, 0x7f, 0x9b, 0x61, 0xac,
            0x8b, 0x34, 0xab, 0x43, 0x54, 0xd3, 0x49, 0x16,
            0x15, 0x99, 0xcb, 0x36, 0x9d, 0x2e, 0xdb, 0xc3
        };
        static const uint8_t kat_tem2_256_expected[32] = {
            0x74, 0xde, 0xe4, 0x0d, 0x0a, 0xe8, 0x2e, 0x8f,
            0x0d, 0x62, 0x67, 0x5e, 0xad, 0x6c, 0x54, 0xf4,
            0x97, 0x6c, 0x53, 0x96, 0x29, 0xc2, 0x1a, 0xeb,
            0x29, 0xc2, 0xdb, 0x43, 0x16, 0x40, 0xf9, 0x54
        };
        static const uint8_t kat_tem2_512_expected[64] = {
            0x6d, 0x6f, 0x7d, 0x5c, 0x0d, 0xe2, 0xfc, 0x65,
            0x77, 0x9f, 0xc4, 0x79, 0x4e, 0xb3, 0x20, 0x75,
            0x10, 0x7c, 0x70, 0xb4, 0x15, 0xb0, 0x09, 0x37,
            0x43, 0x99, 0x39, 0x25, 0x55, 0x9b, 0x54, 0x3c,
            0x83, 0x72, 0xcf, 0x00, 0x1d, 0x9a, 0xdc, 0x5f,
            0xf4, 0xf4, 0xad, 0x02, 0x67, 0x6c, 0xe6, 0xd3,
            0x90, 0x8e, 0x64, 0xfd, 0xff, 0xcb, 0x8a, 0xec,
            0xcd, 0x3f, 0x51, 0xac, 0x72, 0x9b, 0xb2, 0xe1
        };
        uint8_t k256[64], t256_kat[32], m256_kat[32], c256[32], p256[32];
        uint8_t k512[128], t512_kat[64], m512_kat[64], c512[64], p512[64];

        for (i = 0; i < 64; i++) {
            k256[i] = (uint8_t)i;
        }
        for (i = 0; i < 32; i++) {
            t256_kat[i] = (uint8_t)(0x80U + i);
            m256_kat[i] = (uint8_t)(0x40U + i);
        }
        for (i = 0; i < 128; i++) {
            k512[i] = (uint8_t)i;
        }
        for (i = 0; i < 64; i++) {
            t512_kat[i] = (uint8_t)(0x80U + i);
            m512_kat[i] = (uint8_t)(0x40U + i);
        }

        areion_em_encrypt256(c256, k256, m256_kat);
        check_bytes_eq("EMEncrypt256 KAT", c256, kat_em_256_expected, 32);
        areion_em_decrypt256(p256, k256, c256);
        check_bytes_eq("EMDecrypt256 KAT", p256, m256_kat, 32);

        areion_em_encrypt512(c512, k512, m512_kat);
        check_bytes_eq("EMEncrypt512 KAT", c512, kat_em_512_expected, 64);
        areion_em_decrypt512(p512, k512, c512);
        check_bytes_eq("EMDecrypt512 KAT", p512, m512_kat, 64);

        areion_em2_encrypt256(c256, k256, m256_kat);
        check_bytes_eq("EM2Encrypt256 KAT", c256, kat_em2_256_expected, 32);
        areion_em2_decrypt256(p256, k256, c256);
        check_bytes_eq("EM2Decrypt256 KAT", p256, m256_kat, 32);

        areion_em2_encrypt512(c512, k512, m512_kat);
        check_bytes_eq("EM2Encrypt512 KAT", c512, kat_em2_512_expected, 64);
        areion_em2_decrypt512(p512, k512, c512);
        check_bytes_eq("EM2Decrypt512 KAT", p512, m512_kat, 64);

        areion_tem_encrypt256(c256, k256, t256_kat, m256_kat);
        check_bytes_eq("TEMEncrypt256 KAT", c256, kat_tem_256_expected, 32);
        areion_tem_decrypt256(p256, k256, t256_kat, c256);
        check_bytes_eq("TEMDecrypt256 KAT", p256, m256_kat, 32);

        areion_tem_encrypt512(c512, k512, t512_kat, m512_kat);
        check_bytes_eq("TEMEncrypt512 KAT", c512, kat_tem_512_expected, 64);
        areion_tem_decrypt512(p512, k512, t512_kat, c512);
        check_bytes_eq("TEMDecrypt512 KAT", p512, m512_kat, 64);

        areion_tem2_encrypt256(c256, k256, t256_kat, m256_kat);
        check_bytes_eq("TEM2Encrypt256 KAT", c256, kat_tem2_256_expected, 32);
        areion_tem2_decrypt256(p256, k256, t256_kat, c256);
        check_bytes_eq("TEM2Decrypt256 KAT", p256, m256_kat, 32);

        areion_tem2_encrypt512(c512, k512, t512_kat, m512_kat);
        check_bytes_eq("TEM2Encrypt512 KAT", c512, kat_tem2_512_expected, 64);
        areion_tem2_decrypt512(p512, k512, t512_kat, c512);
        check_bytes_eq("TEM2Decrypt512 KAT", p512, m512_kat, 64);
    }
}

/* =========================================================================
 * Comprehensive Per-Tier Functional & In-Place Verification
 * ========================================================================= */

static void test_tier_full(areion_tier_t tier, const uint8_t *ref_digest) {
    uint8_t s256[32], t256[32];
    uint8_t s512[64], t512[64], u512[64], exp_soem512[64];
    uint8_t key256[64], key512[128], out1[32], out2[32], exp_soem256[32];
    uint8_t keys256x4[4][64], keys512x4[4][128];
    uint8_t in256x4[4][32], in512x4[4][64];
    uint8_t out256x4[4][32], exp256x4[4][32];
    uint8_t out512x4[4][64], exp512x4[4][64];
    uint8_t b256[4][32], b256_ref[4][32];
    uint8_t b512[4][64], b512_ref[4][64];
    uint32_t w256[8], w512[16], rw_in[4], rw_out[4], rw_inv[4];
    uint8_t ab0[16], ab1[16], ab2[16], ab3[16], ark0[16], ark1[16], ark2[16], ark3[16];
    uint8_t rk[11][16], pt4[4][16], ct4[4][16], ct1[16];
    size_t i, m;

    (void)ref_digest;
    if (!areion_set_tier_override(tier)) {
        (void)fprintf(stderr, "FAIL: could not set supported tier %d\n", (int)tier);
        g_failures++;
        return;
    }

    test_official_kats();

    /* Words permutations */
    fill_pattern(s256, 32, 0x33U);
    for (i = 0; i < 8; i++) {
        w256[i] = areion_load_le32(&s256[i * 4]);
    }
    areion_permute256(s256);
    areion_permute256_words(w256);
    for (i = 0; i < 8; i++) {
        areion_store_le32(&t256[i * 4], w256[i]);
    }
    check_bytes_eq("Permute256Words", t256, s256, 32);
    areion_inverse_permute256_words(w256);
    for (i = 0; i < 8; i++) {
        areion_store_le32(&t256[i * 4], w256[i]);
    }
    fill_pattern(s256, 32, 0x33U);
    check_bytes_eq("InversePermute256Words", t256, s256, 32);

    fill_pattern(s512, 64, 0x44U);
    for (i = 0; i < 16; i++) {
        w512[i] = areion_load_le32(&s512[i * 4]);
    }
    areion_permute512(s512);
    areion_permute512_words(w512);
    for (i = 0; i < 16; i++) {
        areion_store_le32(&t512[i * 4], w512[i]);
    }
    check_bytes_eq("Permute512Words", t512, s512, 64);
    areion_inverse_permute512_words(w512);
    for (i = 0; i < 16; i++) {
        areion_store_le32(&t512[i * 4], w512[i]);
    }
    fill_pattern(s512, 64, 0x44U);
    check_bytes_eq("InversePermute512Words", t512, s512, 64);

    /* DM256 & DM512 mathematical definition + in-place test */
    fill_pattern(s256, 32, 0x55U);
    memcpy(t256, s256, 32);
    areion_permute256(t256);
    for (i = 0; i < 32; i++) {
        t256[i] ^= s256[i];
    }
    areion_dm256(out1, s256);
    check_bytes_eq("DM256 math definition", out1, t256, 32);
    areion_dm256(s256, s256); /* In-place! */
    check_bytes_eq("DM256 in-place", s256, t256, 32);

    fill_pattern(s512, 64, 0x66U);
    memcpy(t512, s512, 64);
    areion_permute512(t512);
    for (i = 0; i < 64; i++) {
        t512[i] ^= s512[i];
    }
    memcpy(&out2[0], &t512[8], 8);
    memcpy(&out2[8], &t512[24], 8);
    memcpy(&out2[16], &t512[32], 8);
    memcpy(&out2[24], &t512[48], 8);
    areion_dm512(out1, s512);
    check_bytes_eq("DM512 math definition", out1, out2, 32);
    areion_dm512(s512, s512); /* In-place (out == &in[0])! */
    check_bytes_eq("DM512 in-place", s512, out2, 32);

    /* SoEM256 & SoEM512 mathematical definition + in-place test */
    fill_pattern(key256, 64, 0x77U);
    fill_pattern(s256, 32, 0x88U);
    for (i = 0; i < 32; i++) {
        out1[i] = (uint8_t)(s256[i] ^ key256[i]);
        out2[i] = (uint8_t)(s256[i] ^ key256[i + 32]);
    }
    areion_permute256(out1);
    areion_permute256_p2(out2);
    for (i = 0; i < 32; i++) {
        exp_soem256[i] = (uint8_t)((uint32_t)out1[i] ^ (uint32_t)out2[i] ^ (uint32_t)key256[i] ^ (uint32_t)key256[i + 32]);
    }
    areion_soem256(t256, key256, s256);
    check_bytes_eq("SoEM256 math definition", t256, exp_soem256, 32);
    areion_soem256(s256, key256, s256); /* In-place (out == in)! */
    check_bytes_eq("SoEM256 in-place (out==in)", s256, exp_soem256, 32);
    fill_pattern(s256, 32, 0x88U);
    areion_soem256(key256, key256, s256); /* In-place (out == key)! */
    check_bytes_eq("SoEM256 in-place (out==key)", key256, exp_soem256, 32);
    fill_pattern(key256, 64, 0x77U);
    areion_soem256(&key256[32], key256, s256); /* In-place (out == key+32)! */
    check_bytes_eq("SoEM256 in-place (out==key+32)", &key256[32], exp_soem256, 32);
    fill_pattern(key256, 64, 0x77U);

    fill_pattern(key512, 128, 0x79U);
    fill_pattern(s512, 64, 0x89U);
    for (i = 0; i < 64; i++) {
        t512[i] = (uint8_t)(s512[i] ^ key512[i]);
        u512[i] = (uint8_t)(s512[i] ^ key512[i + 64]);
    }
    areion_permute512(t512);
    areion_permute512_p2(u512);
    for (i = 0; i < 64; i++) {
        exp_soem512[i] = (uint8_t)((uint32_t)t512[i] ^ (uint32_t)u512[i] ^ (uint32_t)key512[i] ^ (uint32_t)key512[i + 64]);
    }
    areion_soem512(t512, key512, s512);
    check_bytes_eq("SoEM512 math definition", t512, exp_soem512, 64);
    areion_soem512(s512, key512, s512); /* In-place (out == in)! */
    check_bytes_eq("SoEM512 in-place (out==in)", s512, exp_soem512, 64);
    fill_pattern(s512, 64, 0x89U);
    areion_soem512(key512, key512, s512); /* In-place (out == key)! */
    check_bytes_eq("SoEM512 in-place (out==key)", key512, exp_soem512, 64);
    fill_pattern(key512, 128, 0x79U);
    areion_soem512(&key512[64], key512, s512); /* In-place (out == key+64)! */
    check_bytes_eq("SoEM512 in-place (out==key+64)", &key512[64], exp_soem512, 64);
    fill_pattern(key512, 128, 0x79U);

    /* SoEM256x4 & SoEM512x4 + in-place */
    for (m = 0; m < 4; m++) {
        fill_pattern(keys256x4[m], 64, (uint8_t)(0x90U + m));
        fill_pattern(keys512x4[m], 128, (uint8_t)(0x98U + m));
        fill_pattern(in256x4[m], 32, (uint8_t)(0xA0U + m));
        fill_pattern(in512x4[m], 64, (uint8_t)(0xB0U + m));
        areion_soem256(exp256x4[m], keys256x4[m], in256x4[m]);
        areion_soem512(exp512x4[m], keys512x4[m], in512x4[m]);
    }
    areion_soem256x4(out256x4, keys256x4, in256x4);
    check_bytes_eq("SoEM256x4", &out256x4[0][0], &exp256x4[0][0], 128);
    areion_soem256x4(in256x4, keys256x4, in256x4); /* In-place (out == inputs)! */
    check_bytes_eq("SoEM256x4 in-place (out==inputs)", &in256x4[0][0], &exp256x4[0][0], 128);
    for (m = 0; m < 4; m++) {
        fill_pattern(in256x4[m], 32, (uint8_t)(0xA0U + m));
    }
    {
        void *keys256_ptr = keys256x4;
        areion_soem256x4((uint8_t (*)[32])keys256_ptr, keys256x4, in256x4); /* In-place (out == keys)! */
    }
    check_bytes_eq("SoEM256x4 in-place (out==keys)", &keys256x4[0][0], &exp256x4[0][0], 128);
    for (m = 0; m < 4; m++) {
        fill_pattern(keys256x4[m], 64, (uint8_t)(0x90U + m));
    }

    areion_soem512x4(out512x4, keys512x4, in512x4);
    check_bytes_eq("SoEM512x4", &out512x4[0][0], &exp512x4[0][0], 256);
    areion_soem512x4(in512x4, keys512x4, in512x4); /* In-place (out == inputs)! */
    check_bytes_eq("SoEM512x4 in-place (out==inputs)", &in512x4[0][0], &exp512x4[0][0], 256);
    for (m = 0; m < 4; m++) {
        fill_pattern(in512x4[m], 64, (uint8_t)(0xB0U + m));
    }
    {
        void *keys512_ptr = keys512x4;
        areion_soem512x4((uint8_t (*)[64])keys512_ptr, keys512x4, in512x4); /* In-place (out == keys)! */
    }
    check_bytes_eq("SoEM512x4 in-place (out==keys)", &keys512x4[0][0], &exp512x4[0][0], 256);
    for (m = 0; m < 4; m++) {
        fill_pattern(keys512x4[m], 128, (uint8_t)(0x98U + m));
    }

    /* Wide-block EM / EM2 / TEM / TEM2 mathematical definition, decrypt roundtrip, x4 parity, and in-place overlaps */
    {
        uint8_t wb_tw256[32], wb_tw512[64];
        uint8_t wb_tw256x4[4][32], wb_tw512x4[4][64];
        uint8_t wb_exp256[32], wb_exp512[64];
        uint8_t wb_dec256[32], wb_dec512[64];
        uint8_t wb_dec256x4[4][32], wb_dec512x4[4][64];

        /* 1. EM-256 & EM-512 */
        fill_pattern(key256, 64, 0x7AU);
        fill_pattern(s256, 32, 0x8AU);
        for (i = 0; i < 32; i++) {
            wb_exp256[i] = (uint8_t)(s256[i] ^ key256[i]);
        }
        areion_permute256(wb_exp256);
        for (i = 0; i < 32; i++) {
            wb_exp256[i] ^= key256[32 + i];
        }
        areion_em_encrypt256(t256, key256, s256);
        check_bytes_eq("EMEncrypt256 math definition", t256, wb_exp256, 32);
        areion_em_decrypt256(wb_dec256, key256, t256);
        check_bytes_eq("EMDecrypt256 roundtrip", wb_dec256, s256, 32);
        /* In-place EM-256 */
        areion_em_encrypt256(s256, key256, s256);
        check_bytes_eq("EMEncrypt256 in-place (out==m)", s256, wb_exp256, 32);
        areion_em_decrypt256(s256, key256, s256);
        check_bytes_eq("EMDecrypt256 in-place (out==c)", s256, wb_dec256, 32);
        areion_em_encrypt256(key256, key256, s256);
        check_bytes_eq("EMEncrypt256 in-place (out==k)", key256, wb_exp256, 32);
        fill_pattern(key256, 64, 0x7AU);
        areion_em_encrypt256(&key256[32], key256, s256);
        check_bytes_eq("EMEncrypt256 in-place (out==k+32)", &key256[32], wb_exp256, 32);
        fill_pattern(key256, 64, 0x7AU);
        areion_em_decrypt256(key256, key256, wb_exp256);
        check_bytes_eq("EMDecrypt256 in-place (out==k)", key256, wb_dec256, 32);
        fill_pattern(key256, 64, 0x7AU);
        areion_em_decrypt256(&key256[32], key256, wb_exp256);
        check_bytes_eq("EMDecrypt256 in-place (out==k+32)", &key256[32], wb_dec256, 32);
        fill_pattern(key256, 64, 0x7AU);

        fill_pattern(key512, 128, 0x7BU);
        fill_pattern(s512, 64, 0x8BU);
        for (i = 0; i < 64; i++) {
            wb_exp512[i] = (uint8_t)(s512[i] ^ key512[i]);
        }
        areion_permute512(wb_exp512);
        for (i = 0; i < 64; i++) {
            wb_exp512[i] ^= key512[64 + i];
        }
        areion_em_encrypt512(t512, key512, s512);
        check_bytes_eq("EMEncrypt512 math definition", t512, wb_exp512, 64);
        areion_em_decrypt512(wb_dec512, key512, t512);
        check_bytes_eq("EMDecrypt512 roundtrip", wb_dec512, s512, 64);
        areion_em_encrypt512(s512, key512, s512);
        check_bytes_eq("EMEncrypt512 in-place (out==m)", s512, wb_exp512, 64);
        areion_em_decrypt512(s512, key512, s512);
        check_bytes_eq("EMDecrypt512 in-place (out==c)", s512, wb_dec512, 64);
        areion_em_encrypt512(key512, key512, s512);
        check_bytes_eq("EMEncrypt512 in-place (out==k)", key512, wb_exp512, 64);
        fill_pattern(key512, 128, 0x7BU);
        areion_em_encrypt512(&key512[64], key512, s512);
        check_bytes_eq("EMEncrypt512 in-place (out==k+64)", &key512[64], wb_exp512, 64);
        fill_pattern(key512, 128, 0x7BU);
        areion_em_decrypt512(key512, key512, wb_exp512);
        check_bytes_eq("EMDecrypt512 in-place (out==k)", key512, wb_dec512, 64);
        fill_pattern(key512, 128, 0x7BU);
        areion_em_decrypt512(&key512[64], key512, wb_exp512);
        check_bytes_eq("EMDecrypt512 in-place (out==k+64)", &key512[64], wb_dec512, 64);
        fill_pattern(key512, 128, 0x7BU);

        /* 2. EM2-256 & EM2-512 */
        fill_pattern(s256, 32, 0x8CU);
        for (i = 0; i < 32; i++) {
            wb_exp256[i] = (uint8_t)(s256[i] ^ key256[i]);
        }
        areion_permute256(wb_exp256);
        for (i = 0; i < 32; i++) {
            wb_exp256[i] ^= key256[32 + i];
        }
        areion_permute256_p2(wb_exp256);
        for (i = 0; i < 32; i++) {
            wb_exp256[i] ^= (uint8_t)(key256[i] ^ key256[32 + i]);
        }
        areion_em2_encrypt256(t256, key256, s256);
        check_bytes_eq("EM2Encrypt256 math definition", t256, wb_exp256, 32);
        areion_em2_decrypt256(wb_dec256, key256, t256);
        check_bytes_eq("EM2Decrypt256 roundtrip", wb_dec256, s256, 32);
        areion_em2_encrypt256(s256, key256, s256);
        check_bytes_eq("EM2Encrypt256 in-place (out==m)", s256, wb_exp256, 32);
        areion_em2_decrypt256(s256, key256, s256);
        check_bytes_eq("EM2Decrypt256 in-place (out==c)", s256, wb_dec256, 32);
        areion_em2_encrypt256(key256, key256, s256);
        check_bytes_eq("EM2Encrypt256 in-place (out==k)", key256, wb_exp256, 32);
        fill_pattern(key256, 64, 0x7AU);
        areion_em2_decrypt256(&key256[32], key256, wb_exp256);
        check_bytes_eq("EM2Decrypt256 in-place (out==k+32)", &key256[32], wb_dec256, 32);
        fill_pattern(key256, 64, 0x7AU);

        fill_pattern(s512, 64, 0x8DU);
        for (i = 0; i < 64; i++) {
            wb_exp512[i] = (uint8_t)(s512[i] ^ key512[i]);
        }
        areion_permute512(wb_exp512);
        for (i = 0; i < 64; i++) {
            wb_exp512[i] ^= key512[64 + i];
        }
        areion_permute512_p2(wb_exp512);
        for (i = 0; i < 64; i++) {
            wb_exp512[i] ^= (uint8_t)(key512[i] ^ key512[64 + i]);
        }
        areion_em2_encrypt512(t512, key512, s512);
        check_bytes_eq("EM2Encrypt512 math definition", t512, wb_exp512, 64);
        areion_em2_decrypt512(wb_dec512, key512, t512);
        check_bytes_eq("EM2Decrypt512 roundtrip", wb_dec512, s512, 64);
        areion_em2_encrypt512(s512, key512, s512);
        check_bytes_eq("EM2Encrypt512 in-place (out==m)", s512, wb_exp512, 64);
        areion_em2_decrypt512(s512, key512, s512);
        check_bytes_eq("EM2Decrypt512 in-place (out==c)", s512, wb_dec512, 64);
        areion_em2_encrypt512(key512, key512, s512);
        check_bytes_eq("EM2Encrypt512 in-place (out==k)", key512, wb_exp512, 64);
        fill_pattern(key512, 128, 0x7BU);
        areion_em2_decrypt512(&key512[64], key512, wb_exp512);
        check_bytes_eq("EM2Decrypt512 in-place (out==k+64)", &key512[64], wb_dec512, 64);
        fill_pattern(key512, 128, 0x7BU);

        /* 3. TEM-256 & TEM-512 */
        {
            uint8_t tk256[32], tk512[64];
            fill_pattern(wb_tw256, 32, 0x6AU);
            fill_pattern(s256, 32, 0x8EU);
            for (i = 0; i < 32; i++) {
                tk256[i] = (uint8_t)(wb_tw256[i] ^ key256[32 + i]);
            }
            areion_permute256_p2(tk256);
            for (i = 0; i < 32; i++) {
                tk256[i] ^= key256[i];
                wb_exp256[i] = (uint8_t)(s256[i] ^ tk256[i]);
            }
            areion_permute256(wb_exp256);
            for (i = 0; i < 32; i++) {
                wb_exp256[i] ^= tk256[i];
            }
            areion_tem_encrypt256(t256, key256, wb_tw256, s256);
            check_bytes_eq("TEMEncrypt256 math definition", t256, wb_exp256, 32);
            areion_tem_decrypt256(wb_dec256, key256, wb_tw256, t256);
            check_bytes_eq("TEMDecrypt256 roundtrip", wb_dec256, s256, 32);
            areion_tem_encrypt256(s256, key256, wb_tw256, s256);
            check_bytes_eq("TEMEncrypt256 in-place (out==m)", s256, wb_exp256, 32);
            areion_tem_decrypt256(s256, key256, wb_tw256, s256);
            check_bytes_eq("TEMDecrypt256 in-place (out==c)", s256, wb_dec256, 32);
            areion_tem_encrypt256(wb_tw256, key256, wb_tw256, s256);
            check_bytes_eq("TEMEncrypt256 in-place (out==t)", wb_tw256, wb_exp256, 32);
            fill_pattern(wb_tw256, 32, 0x6AU);
            areion_tem_decrypt256(wb_tw256, key256, wb_tw256, wb_exp256);
            check_bytes_eq("TEMDecrypt256 in-place (out==t)", wb_tw256, wb_dec256, 32);
            fill_pattern(wb_tw256, 32, 0x6AU);
            areion_tem_encrypt256(key256, key256, wb_tw256, s256);
            check_bytes_eq("TEMEncrypt256 in-place (out==k)", key256, wb_exp256, 32);
            fill_pattern(key256, 64, 0x7AU);

            fill_pattern(wb_tw512, 64, 0x6BU);
            fill_pattern(s512, 64, 0x8FU);
            for (i = 0; i < 64; i++) {
                tk512[i] = (uint8_t)(wb_tw512[i] ^ key512[64 + i]);
            }
            areion_permute512_p2(tk512);
            for (i = 0; i < 64; i++) {
                tk512[i] ^= key512[i];
                wb_exp512[i] = (uint8_t)(s512[i] ^ tk512[i]);
            }
            areion_permute512(wb_exp512);
            for (i = 0; i < 64; i++) {
                wb_exp512[i] ^= tk512[i];
            }
            areion_tem_encrypt512(t512, key512, wb_tw512, s512);
            check_bytes_eq("TEMEncrypt512 math definition", t512, wb_exp512, 64);
            areion_tem_decrypt512(wb_dec512, key512, wb_tw512, t512);
            check_bytes_eq("TEMDecrypt512 roundtrip", wb_dec512, s512, 64);
            areion_tem_encrypt512(s512, key512, wb_tw512, s512);
            check_bytes_eq("TEMEncrypt512 in-place (out==m)", s512, wb_exp512, 64);
            areion_tem_decrypt512(s512, key512, wb_tw512, s512);
            check_bytes_eq("TEMDecrypt512 in-place (out==c)", s512, wb_dec512, 64);
            areion_tem_encrypt512(wb_tw512, key512, wb_tw512, s512);
            check_bytes_eq("TEMEncrypt512 in-place (out==t)", wb_tw512, wb_exp512, 64);
            fill_pattern(wb_tw512, 64, 0x6BU);
            areion_tem_decrypt512(wb_tw512, key512, wb_tw512, wb_exp512);
            check_bytes_eq("TEMDecrypt512 in-place (out==t)", wb_tw512, wb_dec512, 64);
            fill_pattern(wb_tw512, 64, 0x6BU);
            areion_tem_encrypt512(key512, key512, wb_tw512, s512);
            check_bytes_eq("TEMEncrypt512 in-place (out==k)", key512, wb_exp512, 64);
            fill_pattern(key512, 128, 0x7BU);
        }

        /* 4. TEM2-256 & TEM2-512 */
        {
            uint8_t w1_256[32], w2_256[32], w1_512[64], w2_512[64];
            fill_pattern(s256, 32, 0x9AU);
            for (i = 0; i < 32; i++) {
                w1_256[i] = (uint8_t)(wb_tw256[i] ^ key256[i]);
                w2_256[i] = (uint8_t)(wb_tw256[i] ^ key256[32 + i]);
            }
            areion_permute256(w1_256);
            areion_permute256_p2(w2_256);
            for (i = 0; i < 32; i++) {
                w1_256[i] ^= key256[i];
                w2_256[i] ^= key256[32 + i];
                wb_exp256[i] = (uint8_t)(s256[i] ^ w1_256[i]);
            }
            areion_permute256(wb_exp256);
            for (i = 0; i < 32; i++) {
                wb_exp256[i] ^= w2_256[i];
            }
            areion_permute256_p2(wb_exp256);
            for (i = 0; i < 32; i++) {
                wb_exp256[i] ^= (uint8_t)(w1_256[i] ^ w2_256[i]);
            }
            areion_tem2_encrypt256(t256, key256, wb_tw256, s256);
            check_bytes_eq("TEM2Encrypt256 math definition", t256, wb_exp256, 32);
            areion_tem2_decrypt256(wb_dec256, key256, wb_tw256, t256);
            check_bytes_eq("TEM2Decrypt256 roundtrip", wb_dec256, s256, 32);
            areion_tem2_encrypt256(s256, key256, wb_tw256, s256);
            check_bytes_eq("TEM2Encrypt256 in-place (out==m)", s256, wb_exp256, 32);
            areion_tem2_decrypt256(s256, key256, wb_tw256, s256);
            check_bytes_eq("TEM2Decrypt256 in-place (out==c)", s256, wb_dec256, 32);
            areion_tem2_encrypt256(wb_tw256, key256, wb_tw256, s256);
            check_bytes_eq("TEM2Encrypt256 in-place (out==t)", wb_tw256, wb_exp256, 32);
            fill_pattern(wb_tw256, 32, 0x6AU);
            areion_tem2_decrypt256(wb_tw256, key256, wb_tw256, wb_exp256);
            check_bytes_eq("TEM2Decrypt256 in-place (out==t)", wb_tw256, wb_dec256, 32);
            fill_pattern(wb_tw256, 32, 0x6AU);

            fill_pattern(s512, 64, 0x9BU);
            for (i = 0; i < 64; i++) {
                w1_512[i] = (uint8_t)(wb_tw512[i] ^ key512[i]);
                w2_512[i] = (uint8_t)(wb_tw512[i] ^ key512[64 + i]);
            }
            areion_permute512(w1_512);
            areion_permute512_p2(w2_512);
            for (i = 0; i < 64; i++) {
                w1_512[i] ^= key512[i];
                w2_512[i] ^= key512[64 + i];
                wb_exp512[i] = (uint8_t)(s512[i] ^ w1_512[i]);
            }
            areion_permute512(wb_exp512);
            for (i = 0; i < 64; i++) {
                wb_exp512[i] ^= w2_512[i];
            }
            areion_permute512_p2(wb_exp512);
            for (i = 0; i < 64; i++) {
                wb_exp512[i] ^= (uint8_t)(w1_512[i] ^ w2_512[i]);
            }
            areion_tem2_encrypt512(t512, key512, wb_tw512, s512);
            check_bytes_eq("TEM2Encrypt512 math definition", t512, wb_exp512, 64);
            areion_tem2_decrypt512(wb_dec512, key512, wb_tw512, t512);
            check_bytes_eq("TEM2Decrypt512 roundtrip", wb_dec512, s512, 64);
            areion_tem2_encrypt512(s512, key512, wb_tw512, s512);
            check_bytes_eq("TEM2Encrypt512 in-place (out==m)", s512, wb_exp512, 64);
            areion_tem2_decrypt512(s512, key512, wb_tw512, s512);
            check_bytes_eq("TEM2Decrypt512 in-place (out==c)", s512, wb_dec512, 64);
            areion_tem2_encrypt512(wb_tw512, key512, wb_tw512, s512);
            check_bytes_eq("TEM2Encrypt512 in-place (out==t)", wb_tw512, wb_exp512, 64);
            fill_pattern(wb_tw512, 64, 0x6BU);
            areion_tem2_decrypt512(wb_tw512, key512, wb_tw512, wb_exp512);
            check_bytes_eq("TEM2Decrypt512 in-place (out==t)", wb_tw512, wb_dec512, 64);
            fill_pattern(wb_tw512, 64, 0x6BU);
        }

        /* 5. 4-Way x4 parity & in-place overlaps for EM, EM2, TEM, TEM2 */
        for (m = 0; m < 4; m++) {
            fill_pattern(wb_tw256x4[m], 32, (uint8_t)(0x70U + m));
            fill_pattern(wb_tw512x4[m], 64, (uint8_t)(0x78U + m));
            areion_em_encrypt256(exp256x4[m], keys256x4[m], in256x4[m]);
            areion_em_encrypt512(exp512x4[m], keys512x4[m], in512x4[m]);
        }
        areion_em_encrypt256x4(out256x4, keys256x4, in256x4);
        check_bytes_eq("EMEncrypt256x4", &out256x4[0][0], &exp256x4[0][0], 128);
        areion_em_decrypt256x4(wb_dec256x4, keys256x4, out256x4);
        check_bytes_eq("EMDecrypt256x4", &wb_dec256x4[0][0], &in256x4[0][0], 128);
        areion_em_encrypt256x4(wb_dec256x4, keys256x4, wb_dec256x4);
        check_bytes_eq("EMEncrypt256x4 in-place", &wb_dec256x4[0][0], &exp256x4[0][0], 128);
        areion_em_decrypt256x4(wb_dec256x4, keys256x4, wb_dec256x4);
        check_bytes_eq("EMDecrypt256x4 in-place", &wb_dec256x4[0][0], &in256x4[0][0], 128);

        areion_em_encrypt512x4(out512x4, keys512x4, in512x4);
        check_bytes_eq("EMEncrypt512x4", &out512x4[0][0], &exp512x4[0][0], 256);
        areion_em_decrypt512x4(wb_dec512x4, keys512x4, out512x4);
        check_bytes_eq("EMDecrypt512x4", &wb_dec512x4[0][0], &in512x4[0][0], 256);
        areion_em_encrypt512x4(wb_dec512x4, keys512x4, wb_dec512x4);
        check_bytes_eq("EMEncrypt512x4 in-place", &wb_dec512x4[0][0], &exp512x4[0][0], 256);
        areion_em_decrypt512x4(wb_dec512x4, keys512x4, wb_dec512x4);
        check_bytes_eq("EMDecrypt512x4 in-place", &wb_dec512x4[0][0], &in512x4[0][0], 256);

        for (m = 0; m < 4; m++) {
            areion_em2_encrypt256(exp256x4[m], keys256x4[m], in256x4[m]);
            areion_em2_encrypt512(exp512x4[m], keys512x4[m], in512x4[m]);
        }
        areion_em2_encrypt256x4(out256x4, keys256x4, in256x4);
        check_bytes_eq("EM2Encrypt256x4", &out256x4[0][0], &exp256x4[0][0], 128);
        areion_em2_decrypt256x4(wb_dec256x4, keys256x4, out256x4);
        check_bytes_eq("EM2Decrypt256x4", &wb_dec256x4[0][0], &in256x4[0][0], 128);
        areion_em2_encrypt256x4(wb_dec256x4, keys256x4, wb_dec256x4);
        check_bytes_eq("EM2Encrypt256x4 in-place", &wb_dec256x4[0][0], &exp256x4[0][0], 128);
        areion_em2_decrypt256x4(wb_dec256x4, keys256x4, wb_dec256x4);
        check_bytes_eq("EM2Decrypt256x4 in-place", &wb_dec256x4[0][0], &in256x4[0][0], 128);

        areion_em2_encrypt512x4(out512x4, keys512x4, in512x4);
        check_bytes_eq("EM2Encrypt512x4", &out512x4[0][0], &exp512x4[0][0], 256);
        areion_em2_decrypt512x4(wb_dec512x4, keys512x4, out512x4);
        check_bytes_eq("EM2Decrypt512x4", &wb_dec512x4[0][0], &in512x4[0][0], 256);
        areion_em2_encrypt512x4(wb_dec512x4, keys512x4, wb_dec512x4);
        check_bytes_eq("EM2Encrypt512x4 in-place", &wb_dec512x4[0][0], &exp512x4[0][0], 256);
        areion_em2_decrypt512x4(wb_dec512x4, keys512x4, wb_dec512x4);
        check_bytes_eq("EM2Decrypt512x4 in-place", &wb_dec512x4[0][0], &in512x4[0][0], 256);

        for (m = 0; m < 4; m++) {
            areion_tem_encrypt256(exp256x4[m], keys256x4[m], wb_tw256x4[m], in256x4[m]);
            areion_tem_encrypt512(exp512x4[m], keys512x4[m], wb_tw512x4[m], in512x4[m]);
        }
        areion_tem_encrypt256x4(out256x4, keys256x4, wb_tw256x4, in256x4);
        check_bytes_eq("TEMEncrypt256x4", &out256x4[0][0], &exp256x4[0][0], 128);
        areion_tem_decrypt256x4(wb_dec256x4, keys256x4, wb_tw256x4, out256x4);
        check_bytes_eq("TEMDecrypt256x4", &wb_dec256x4[0][0], &in256x4[0][0], 128);
        areion_tem_encrypt256x4(wb_dec256x4, keys256x4, wb_tw256x4, wb_dec256x4);
        check_bytes_eq("TEMEncrypt256x4 in-place", &wb_dec256x4[0][0], &exp256x4[0][0], 128);
        areion_tem_decrypt256x4(wb_dec256x4, keys256x4, wb_tw256x4, wb_dec256x4);
        check_bytes_eq("TEMDecrypt256x4 in-place", &wb_dec256x4[0][0], &in256x4[0][0], 128);

        areion_tem_encrypt512x4(out512x4, keys512x4, wb_tw512x4, in512x4);
        check_bytes_eq("TEMEncrypt512x4", &out512x4[0][0], &exp512x4[0][0], 256);
        areion_tem_decrypt512x4(wb_dec512x4, keys512x4, wb_tw512x4, out512x4);
        check_bytes_eq("TEMDecrypt512x4", &wb_dec512x4[0][0], &in512x4[0][0], 256);
        areion_tem_encrypt512x4(wb_dec512x4, keys512x4, wb_tw512x4, wb_dec512x4);
        check_bytes_eq("TEMEncrypt512x4 in-place", &wb_dec512x4[0][0], &exp512x4[0][0], 256);
        areion_tem_decrypt512x4(wb_dec512x4, keys512x4, wb_tw512x4, wb_dec512x4);
        check_bytes_eq("TEMDecrypt512x4 in-place", &wb_dec512x4[0][0], &in512x4[0][0], 256);

        for (m = 0; m < 4; m++) {
            areion_tem2_encrypt256(exp256x4[m], keys256x4[m], wb_tw256x4[m], in256x4[m]);
            areion_tem2_encrypt512(exp512x4[m], keys512x4[m], wb_tw512x4[m], in512x4[m]);
        }
        areion_tem2_encrypt256x4(out256x4, keys256x4, wb_tw256x4, in256x4);
        check_bytes_eq("TEM2Encrypt256x4", &out256x4[0][0], &exp256x4[0][0], 128);
        areion_tem2_decrypt256x4(wb_dec256x4, keys256x4, wb_tw256x4, out256x4);
        check_bytes_eq("TEM2Decrypt256x4", &wb_dec256x4[0][0], &in256x4[0][0], 128);
        areion_tem2_encrypt256x4(wb_dec256x4, keys256x4, wb_tw256x4, wb_dec256x4);
        check_bytes_eq("TEM2Encrypt256x4 in-place", &wb_dec256x4[0][0], &exp256x4[0][0], 128);
        areion_tem2_decrypt256x4(wb_dec256x4, keys256x4, wb_tw256x4, wb_dec256x4);
        check_bytes_eq("TEM2Decrypt256x4 in-place", &wb_dec256x4[0][0], &in256x4[0][0], 128);

        areion_tem2_encrypt512x4(out512x4, keys512x4, wb_tw512x4, in512x4);
        check_bytes_eq("TEM2Encrypt512x4", &out512x4[0][0], &exp512x4[0][0], 256);
        areion_tem2_decrypt512x4(wb_dec512x4, keys512x4, wb_tw512x4, out512x4);
        check_bytes_eq("TEM2Decrypt512x4", &wb_dec512x4[0][0], &in512x4[0][0], 256);
        areion_tem2_encrypt512x4(wb_dec512x4, keys512x4, wb_tw512x4, wb_dec512x4);
        check_bytes_eq("TEM2Encrypt512x4 in-place", &wb_dec512x4[0][0], &exp512x4[0][0], 256);
        areion_tem2_decrypt512x4(wb_dec512x4, keys512x4, wb_tw512x4, wb_dec512x4);
        check_bytes_eq("TEM2Decrypt512x4 in-place", &wb_dec512x4[0][0], &in512x4[0][0], 256);
    }

    /* 4-way Permutations (256x4, 256P2x4, 512x4, 512P2x4 & inverses) */
    for (m = 0; m < 4; m++) {
        fill_pattern(b256[m], 32, (uint8_t)(0xC0U + m));
        memcpy(b256_ref[m], b256[m], 32);
        areion_permute256(b256_ref[m]);
    }
    areion_permute256x4(b256[0], b256[1], b256[2], b256[3]);
    check_bytes_eq("Permute256x4", &b256[0][0], &b256_ref[0][0], 128);
    areion_inverse_permute256x4(b256[0], b256[1], b256[2], b256[3]);
    for (m = 0; m < 4; m++) {
        fill_pattern(b256_ref[m], 32, (uint8_t)(0xC0U + m));
    }
    check_bytes_eq("InversePermute256x4", &b256[0][0], &b256_ref[0][0], 128);

    for (m = 0; m < 4; m++) {
        areion_permute256_p2(b256_ref[m]);
    }
    areion_permute256_p2x4(b256[0], b256[1], b256[2], b256[3]);
    check_bytes_eq("Permute256P2x4", &b256[0][0], &b256_ref[0][0], 128);
    areion_inverse_permute256_p2x4(b256[0], b256[1], b256[2], b256[3]);
    for (m = 0; m < 4; m++) {
        fill_pattern(b256_ref[m], 32, (uint8_t)(0xC0U + m));
    }
    check_bytes_eq("InversePermute256P2x4", &b256[0][0], &b256_ref[0][0], 128);

    for (m = 0; m < 4; m++) {
        fill_pattern(b512[m], 64, (uint8_t)(0xD0U + m));
        memcpy(b512_ref[m], b512[m], 64);
        areion_permute512(b512_ref[m]);
    }
    areion_permute512x4(b512[0], b512[1], b512[2], b512[3]);
    check_bytes_eq("Permute512x4", &b512[0][0], &b512_ref[0][0], 256);
    areion_inverse_permute512x4(b512[0], b512[1], b512[2], b512[3]);
    for (m = 0; m < 4; m++) {
        fill_pattern(b512_ref[m], 64, (uint8_t)(0xD0U + m));
    }
    check_bytes_eq("InversePermute512x4", &b512[0][0], &b512_ref[0][0], 256);

    for (m = 0; m < 4; m++) {
        areion_permute512_p2(b512_ref[m]);
    }
    areion_permute512_p2x4(b512[0], b512[1], b512[2], b512[3]);
    check_bytes_eq("Permute512P2x4", &b512[0][0], &b512_ref[0][0], 256);
    areion_inverse_permute512_p2x4(b512[0], b512[1], b512[2], b512[3]);
    for (m = 0; m < 4; m++) {
        fill_pattern(b512_ref[m], 64, (uint8_t)(0xD0U + m));
    }
    check_bytes_eq("InversePermute512P2x4", &b512[0][0], &b512_ref[0][0], 256);

    /* AES Round primitives & 4-block helpers */
    rw_in[0] = 0x11223344U;
    rw_in[1] = 0x55667788U;
    rw_in[2] = 0x99aabbccU;
    rw_in[3] = 0xddeeff00U;
    areion_round(rw_in, rw_out);
    areion_inv_round(rw_out, rw_inv);
    if (memcmp(rw_in, rw_inv, sizeof(rw_in)) != 0) {
        (void)fprintf(stderr, "FAIL: InvRound(Round(x)) != x\n");
        g_failures++;
    }
    /* In-place Round / InvRound */
    memcpy(rw_inv, rw_in, sizeof(rw_in));
    areion_round(rw_inv, rw_inv);
    if (memcmp(rw_inv, rw_out, sizeof(rw_out)) != 0) {
        (void)fprintf(stderr, "FAIL: Round in-place != Round\n");
        g_failures++;
    }
    areion_inv_round(rw_inv, rw_inv);
    if (memcmp(rw_inv, rw_in, sizeof(rw_in)) != 0) {
        (void)fprintf(stderr, "FAIL: InvRound in-place != x\n");
        g_failures++;
    }

    /* Verify InvMixColumns(Round(x)) == FinalRound(x) */
    {
        uint32_t rw_imc[4], rw_fin[4];
        areion_inv_mix_columns(rw_out, rw_imc);
        areion_final_round(rw_in, rw_fin);
        if (memcmp(rw_imc, rw_fin, sizeof(rw_fin)) != 0) {
            (void)fprintf(stderr, "FAIL: InvMixColumns(Round(x)) != FinalRound(x)\n");
            g_failures++;
        }
        /* In-place InvMixColumns */
        memcpy(rw_imc, rw_out, sizeof(rw_out));
        areion_inv_mix_columns(rw_imc, rw_imc);
        if (memcmp(rw_imc, rw_fin, sizeof(rw_fin)) != 0) {
            (void)fprintf(stderr, "FAIL: InvMixColumns in-place != FinalRound(x)\n");
            g_failures++;
        }
    }

    areion_final_round(rw_in, rw_out);
    areion_inv_final_round(rw_out, rw_inv);
    if (memcmp(rw_in, rw_inv, sizeof(rw_in)) != 0) {
        (void)fprintf(stderr, "FAIL: InvFinalRound(FinalRound(x)) != x\n");
        g_failures++;
    }

    /* Keyless hardware round primitives: areion_round_hw, areion_final_round_hw, areion_round4_hw, areion_final_round4_hw */
    {
        static const uint8_t zero16[16] = {0};
        fill_pattern(ab0, 16, 0xD8U);
        fill_pattern(ab1, 16, 0xD9U);
        fill_pattern(ab2, 16, 0xDAU);
        fill_pattern(ab3, 16, 0xDBU);
        memcpy(pt4[0], ab0, 16);
        memcpy(pt4[1], ab1, 16);
        memcpy(pt4[2], ab2, 16);
        memcpy(pt4[3], ab3, 16);
        areion_round_hw(pt4[0]);
        areion_round_hw(pt4[1]);
        areion_round_hw(pt4[2]);
        areion_round_hw(pt4[3]);
        areion_round4_hw(ab0, ab1, ab2, ab3);
        check_bytes_eq("Round4HW[0] vs RoundHW", ab0, pt4[0], 16);
        check_bytes_eq("Round4HW[1] vs RoundHW", ab1, pt4[1], 16);
        check_bytes_eq("Round4HW[2] vs RoundHW", ab2, pt4[2], 16);
        check_bytes_eq("Round4HW[3] vs RoundHW", ab3, pt4[3], 16);

        fill_pattern(ct1, 16, 0xD8U);
        areion_aes_round_hw(ct1, zero16);
        check_bytes_eq("RoundHW vs AESRoundHW(0)", pt4[0], ct1, 16);

        areion_final_round_hw(pt4[0]);
        areion_final_round_hw(pt4[1]);
        areion_final_round_hw(pt4[2]);
        areion_final_round_hw(pt4[3]);
        areion_final_round4_hw(ab0, ab1, ab2, ab3);
        check_bytes_eq("FinalRound4HW[0] vs FinalRoundHW", ab0, pt4[0], 16);
        check_bytes_eq("FinalRound4HW[1] vs FinalRoundHW", ab1, pt4[1], 16);
        check_bytes_eq("FinalRound4HW[2] vs FinalRoundHW", ab2, pt4[2], 16);
        check_bytes_eq("FinalRound4HW[3] vs FinalRoundHW", ab3, pt4[3], 16);

        areion_aes_final_round_hw(ct1, zero16);
        check_bytes_eq("FinalRoundHW vs AESFinalRoundHW(0)", pt4[0], ct1, 16);
    }

    fill_pattern(ab0, 16, 0xE0U);
    fill_pattern(ab1, 16, 0xE1U);
    fill_pattern(ab2, 16, 0xE2U);
    fill_pattern(ab3, 16, 0xE3U);
    fill_pattern(ark0, 16, 0xF0U);
    fill_pattern(ark1, 16, 0xF1U);
    fill_pattern(ark2, 16, 0xF2U);
    fill_pattern(ark3, 16, 0xF3U);
    memcpy(pt4[0], ab0, 16);
    memcpy(pt4[1], ab1, 16);
    memcpy(pt4[2], ab2, 16);
    memcpy(pt4[3], ab3, 16);
    areion_aes_round_hw(pt4[0], ark0);
    areion_aes_round_hw(pt4[1], ark1);
    areion_aes_round_hw(pt4[2], ark2);
    areion_aes_round_hw(pt4[3], ark3);
    areion_aes_round4_hw(ab0, ab1, ab2, ab3, ark0, ark1, ark2, ark3);
    check_bytes_eq("AESRound4HW[0]", ab0, pt4[0], 16);
    check_bytes_eq("AESRound4HW[1]", ab1, pt4[1], 16);
    check_bytes_eq("AESRound4HW[2]", ab2, pt4[2], 16);
    check_bytes_eq("AESRound4HW[3]", ab3, pt4[3], 16);

    /* Alias entry points: areion_aes128_round, areion_aes128_final_round, areion_aes128_round4, areion_aes128_final_round4 */
    fill_pattern(ct4[0], 16, 0xE0U);
    fill_pattern(ct4[1], 16, 0xE1U);
    fill_pattern(ct4[2], 16, 0xE2U);
    fill_pattern(ct4[3], 16, 0xE3U);
    areion_aes128_round4(ct4[0], ct4[1], ct4[2], ct4[3], ark0, ark1, ark2, ark3);
    check_bytes_eq("AES128Round4 vs AESRound4HW", &ct4[0][0], &pt4[0][0], 64);
    fill_pattern(ct1, 16, 0xE0U);
    areion_aes128_round(ct1, ark0);
    check_bytes_eq("AES128Round vs AESRoundHW", ct1, pt4[0], 16);

    areion_aes_final_round_hw(pt4[0], ark0);
    areion_aes_final_round_hw(pt4[1], ark1);
    areion_aes_final_round_hw(pt4[2], ark2);
    areion_aes_final_round_hw(pt4[3], ark3);
    areion_aes_final_round4_hw(ab0, ab1, ab2, ab3, ark0, ark1, ark2, ark3);
    check_bytes_eq("AESFinalRound4HW[0]", ab0, pt4[0], 16);
    check_bytes_eq("AESFinalRound4HW[1]", ab1, pt4[1], 16);
    check_bytes_eq("AESFinalRound4HW[2]", ab2, pt4[2], 16);
    check_bytes_eq("AESFinalRound4HW[3]", ab3, pt4[3], 16);

    areion_aes128_final_round4(ct4[0], ct4[1], ct4[2], ct4[3], ark0, ark1, ark2, ark3);
    check_bytes_eq("AES128FinalRound4 vs AESFinalRound4HW", &ct4[0][0], &pt4[0][0], 64);
    areion_aes128_final_round(ct1, ark0);
    check_bytes_eq("AES128FinalRound vs AESFinalRoundHW", ct1, pt4[0], 16);

    /* XorBlock & XorBlock4 */
    for (m = 0; m < 4; m++) {
        fill_pattern(pt4[m], 16, (uint8_t)(0x31U + m));
        memcpy(ct4[m], pt4[m], 16);
    }
    areion_xor_block(pt4[0], ark0);
    areion_xor_block(pt4[1], ark1);
    areion_xor_block(pt4[2], ark2);
    areion_xor_block(pt4[3], ark3);
    areion_xor_block4(ct4[0], ct4[1], ct4[2], ct4[3], ark0, ark1, ark2, ark3);
    check_bytes_eq("XorBlock4 vs XorBlock", &ct4[0][0], &pt4[0][0], 64);

    areion_expand_key128(&keys256x4[0][0], rk);
    /* In-place ExpandKey128 where key == rk[0] */
    {
        uint8_t rk_inplace[11][16];
        memcpy(rk_inplace[0], &keys256x4[0][0], 16);
        areion_expand_key128(rk_inplace[0], rk_inplace);
        check_bytes_eq("ExpandKey128 in-place (key==rk[0])", &rk_inplace[0][0], &rk[0][0], sizeof(rk));
        areion_wipe_expanded_key128(rk_inplace);
    }
    for (m = 0; m < 4; m++) {
        fill_pattern(pt4[m], 16, (uint8_t)(0x41U + m));
    }
    areion_aes128_encrypt4_blocks(ct4, pt4, rk);
    for (m = 0; m < 4; m++) {
        areion_aes128_encrypt_block(ct1, pt4[m], rk);
        check_bytes_eq("AES128Encrypt4Blocks vs 1Block", ct4[m], ct1, 16);
        /* In-place 1-block encryption */
        memcpy(ab0, pt4[m], 16);
        areion_aes128_encrypt_block(ab0, ab0, rk);
        check_bytes_eq("AES128EncryptBlock in-place", ab0, ct1, 16);
    }
    /* In-place 4-block encryption */
    areion_aes128_encrypt4_blocks(pt4, pt4, rk);
    check_bytes_eq("AES128Encrypt4Blocks in-place", &pt4[0][0], &ct4[0][0], 64);
    areion_wipe_expanded_key128(rk);
}

/* =========================================================================
 * Rijndael-256 (NIST SP 800-197: 256-bit block, 256-bit key, 14 rounds)
 * ========================================================================= */

static const uint8_t k_rijndael_sbox[256] = {
    0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
    0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
    0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
    0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
    0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
    0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
    0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
    0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
    0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
    0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
    0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
    0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
    0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
    0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
    0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
    0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16
};

static const uint8_t k_rijndael_inv_sbox[256] = {
    0x52, 0x09, 0x6a, 0xd5, 0x30, 0x36, 0xa5, 0x38, 0xbf, 0x40, 0xa3, 0x9e, 0x81, 0xf3, 0xd7, 0xfb,
    0x7c, 0xe3, 0x39, 0x82, 0x9b, 0x2f, 0xff, 0x87, 0x34, 0x8e, 0x43, 0x44, 0xc4, 0xde, 0xe9, 0xcb,
    0x54, 0x7b, 0x94, 0x32, 0xa6, 0xc2, 0x23, 0x3d, 0xee, 0x4c, 0x95, 0x0b, 0x42, 0xfa, 0xc3, 0x4e,
    0x08, 0x2e, 0xa1, 0x66, 0x28, 0xd9, 0x24, 0xb2, 0x76, 0x5b, 0xa2, 0x49, 0x6d, 0x8b, 0xd1, 0x25,
    0x72, 0xf8, 0xf6, 0x64, 0x86, 0x68, 0x98, 0x16, 0xd4, 0xa4, 0x5c, 0xcc, 0x5d, 0x65, 0xb6, 0x92,
    0x6c, 0x70, 0x48, 0x50, 0xfd, 0xed, 0xb9, 0xda, 0x5e, 0x15, 0x46, 0x57, 0xa7, 0x8d, 0x9d, 0x84,
    0x90, 0xd8, 0xab, 0x00, 0x8c, 0xbc, 0xd3, 0x0a, 0xf7, 0xe4, 0x58, 0x05, 0xb8, 0xb3, 0x45, 0x06,
    0xd0, 0x2c, 0x1e, 0x8f, 0xca, 0x3f, 0x0f, 0x02, 0xc1, 0xaf, 0xbd, 0x03, 0x01, 0x13, 0x8a, 0x6b,
    0x3a, 0x91, 0x11, 0x41, 0x4f, 0x67, 0xdc, 0xea, 0x97, 0xf2, 0xcf, 0xce, 0xf0, 0xb4, 0xe6, 0x73,
    0x96, 0xac, 0x74, 0x22, 0xe7, 0xad, 0x35, 0x85, 0xe2, 0xf9, 0x37, 0xe8, 0x1c, 0x75, 0xdf, 0x6e,
    0x47, 0xf1, 0x1a, 0x71, 0x1d, 0x29, 0xc5, 0x89, 0x6f, 0xb7, 0x62, 0x0e, 0xaa, 0x18, 0xbe, 0x1b,
    0xfc, 0x56, 0x3e, 0x4b, 0xc6, 0xd2, 0x79, 0x20, 0x9a, 0xdb, 0xc0, 0xfe, 0x78, 0xcd, 0x5a, 0xf4,
    0x1f, 0xdd, 0xa8, 0x33, 0x88, 0x07, 0xc7, 0x31, 0xb1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xec, 0x5f,
    0x60, 0x51, 0x7f, 0xa9, 0x19, 0xb5, 0x4a, 0x0d, 0x2d, 0xe5, 0x7a, 0x9f, 0x93, 0xc9, 0x9c, 0xef,
    0xa0, 0xe0, 0x3b, 0x4d, 0xae, 0x2a, 0xf5, 0xb0, 0xc8, 0xeb, 0xbb, 0x3c, 0x83, 0x53, 0x99, 0x61,
    0x17, 0x2b, 0x04, 0x7e, 0xba, 0x77, 0xd6, 0x26, 0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d
};

static const uint8_t k_rijndael_rcon[15] = {
    0x00, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40,
    0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d
};

typedef struct {
    uint8_t rk[15][32];
} rijndael256_rk_t;

static void rijndael256_expand_key(const uint8_t key[32], rijndael256_rk_t *ks) {
    uint8_t w[120][4];
    size_t i, j, r, c;
    for (i = 0; i < 8U; i++) {
        memcpy(w[i], &key[4U * i], 4U);
    }
    for (i = 8U; i < 120U; i++) {
        uint8_t tmp[4];
        memcpy(tmp, w[i - 1U], 4U);
        if ((i % 8U) == 0U) {
            uint8_t t0 = (uint8_t)(k_rijndael_sbox[tmp[1]] ^ k_rijndael_rcon[i / 8U]);
            uint8_t t1 = k_rijndael_sbox[tmp[2]];
            uint8_t t2 = k_rijndael_sbox[tmp[3]];
            uint8_t t3 = k_rijndael_sbox[tmp[0]];
            tmp[0] = t0;
            tmp[1] = t1;
            tmp[2] = t2;
            tmp[3] = t3;
        } else if ((i % 8U) == 4U) {
            tmp[0] = k_rijndael_sbox[tmp[0]];
            tmp[1] = k_rijndael_sbox[tmp[1]];
            tmp[2] = k_rijndael_sbox[tmp[2]];
            tmp[3] = k_rijndael_sbox[tmp[3]];
        }
        for (j = 0; j < 4U; j++) {
            w[i][j] = (uint8_t)(w[i - 8U][j] ^ tmp[j]);
        }
    }
    for (r = 0; r < 15U; r++) {
        for (c = 0; c < 8U; c++) {
            memcpy(&ks->rk[r][4U * c], w[8U * r + c], 4U);
        }
    }
}

static uint32_t rijndael_gf_mul(uint32_t a, uint32_t b) {
    uint32_t p = 0U;
    size_t i;
    for (i = 0; i < 8U; i++) {
        uint32_t hi;
        if ((b & 1U) != 0U) {
            p ^= a;
        }
        hi = a & 0x80U;
        a = (a << 1U) & 0xFFU;
        if (hi != 0U) {
            a ^= 0x1bU;
        }
        b >>= 1U;
    }
    return p;
}

static void rijndael256_encrypt_block_ref(
    const rijndael256_rk_t *ks,
    uint8_t dst[32],
    const uint8_t src[32])
{
    static const size_t shifts[4] = {0U, 1U, 3U, 4U};
    uint8_t s[32];
    size_t i, r, c, row;

    for (i = 0; i < 32U; i++) {
        s[i] = (uint8_t)((uint32_t)src[i] ^ (uint32_t)ks->rk[0][i]);
    }
    for (r = 1U; r <= 14U; r++) {
        uint8_t t[32];
        for (c = 0; c < 8U; c++) {
            for (row = 0; row < 4U; row++) {
                t[4U * c + row] = k_rijndael_sbox[s[4U * ((c + shifts[row]) & 7U) + row]];
            }
        }
        if (r < 14U) {
            for (c = 0; c < 8U; c++) {
                uint32_t a0 = t[4U * c + 0U];
                uint32_t a1 = t[4U * c + 1U];
                uint32_t a2 = t[4U * c + 2U];
                uint32_t a3 = t[4U * c + 3U];
                s[4U * c + 0U] = (uint8_t)(rijndael_gf_mul(2U, a0) ^ rijndael_gf_mul(3U, a1) ^ a2 ^ a3 ^ (uint32_t)ks->rk[r][4U * c + 0U]);
                s[4U * c + 1U] = (uint8_t)(a0 ^ rijndael_gf_mul(2U, a1) ^ rijndael_gf_mul(3U, a2) ^ a3 ^ (uint32_t)ks->rk[r][4U * c + 1U]);
                s[4U * c + 2U] = (uint8_t)(a0 ^ a1 ^ rijndael_gf_mul(2U, a2) ^ rijndael_gf_mul(3U, a3) ^ (uint32_t)ks->rk[r][4U * c + 2U]);
                s[4U * c + 3U] = (uint8_t)(rijndael_gf_mul(3U, a0) ^ a1 ^ a2 ^ rijndael_gf_mul(2U, a3) ^ (uint32_t)ks->rk[r][4U * c + 3U]);
            }
        } else {
            for (i = 0; i < 32U; i++) {
                s[i] = (uint8_t)((uint32_t)t[i] ^ (uint32_t)ks->rk[14][i]);
            }
        }
    }
    memcpy(dst, s, 32U);
}

static void rijndael256_decrypt_block_ref(
    const rijndael256_rk_t *ks,
    uint8_t dst[32],
    const uint8_t src[32])
{
    static const size_t shifts[4] = {0U, 1U, 3U, 4U};
    uint8_t s[32];
    size_t i, c, row;
    int r;

    for (i = 0; i < 32U; i++) {
        s[i] = (uint8_t)((uint32_t)src[i] ^ (uint32_t)ks->rk[14][i]);
    }
    for (r = 13; r >= 0; r--) {
        uint8_t t[32];
        for (c = 0; c < 8U; c++) {
            for (row = 0; row < 4U; row++) {
                t[4U * c + row] = (uint8_t)(
                    (uint32_t)k_rijndael_inv_sbox[s[4U * ((c + 8U - shifts[row]) & 7U) + row]] ^
                    (uint32_t)ks->rk[(size_t)r][4U * c + row]);
            }
        }
        if (r > 0) {
            for (c = 0; c < 8U; c++) {
                uint32_t a0 = t[4U * c + 0U];
                uint32_t a1 = t[4U * c + 1U];
                uint32_t a2 = t[4U * c + 2U];
                uint32_t a3 = t[4U * c + 3U];
                s[4U * c + 0U] = (uint8_t)(rijndael_gf_mul(0x0eU, a0) ^ rijndael_gf_mul(0x0bU, a1) ^ rijndael_gf_mul(0x0dU, a2) ^ rijndael_gf_mul(0x09U, a3));
                s[4U * c + 1U] = (uint8_t)(rijndael_gf_mul(0x09U, a0) ^ rijndael_gf_mul(0x0eU, a1) ^ rijndael_gf_mul(0x0bU, a2) ^ rijndael_gf_mul(0x0dU, a3));
                s[4U * c + 2U] = (uint8_t)(rijndael_gf_mul(0x0dU, a0) ^ rijndael_gf_mul(0x09U, a1) ^ rijndael_gf_mul(0x0eU, a2) ^ rijndael_gf_mul(0x0bU, a3));
                s[4U * c + 3U] = (uint8_t)(rijndael_gf_mul(0x0bU, a0) ^ rijndael_gf_mul(0x0dU, a1) ^ rijndael_gf_mul(0x09U, a2) ^ rijndael_gf_mul(0x0eU, a3));
            }
        } else {
            memcpy(s, t, 32U);
        }
    }
    memcpy(dst, s, 32U);
}

static void test_rijndael256(void) {
    rijndael256_rk_t ks;
    uint8_t key[32], pt[32], ct_ref[32], dec_ref[32], ct_hw[32], inplace[32];
    uint8_t pt4[4][32], ct4[4][32], inplace4[4][32], want[32];
    size_t trial, b;

    for (trial = 0; trial < 32U; trial++) {
        fill_pattern(key, 32U, (uint8_t)(0x10U + trial * 3U));
        fill_pattern(pt, 32U, (uint8_t)(0x20U + trial * 5U));
        rijndael256_expand_key(key, &ks);
        rijndael256_encrypt_block_ref(&ks, ct_ref, pt);
        rijndael256_decrypt_block_ref(&ks, dec_ref, ct_ref);
        check_bytes_eq("Rijndael256 ref roundtrip", dec_ref, pt, 32U);
        areion_rijndael256_encrypt_block_hw(ct_hw, pt, (const uint8_t (*)[32])ks.rk);
        check_bytes_eq("Rijndael256 HW vs ref", ct_hw, ct_ref, 32U);
        memcpy(inplace, pt, 32U);
        areion_rijndael256_encrypt_block_hw(inplace, inplace, (const uint8_t (*)[32])ks.rk);
        check_bytes_eq("Rijndael256 HW in-place", inplace, ct_ref, 32U);
    }

    fill_pattern(key, 32U, 0xA5U);
    for (b = 0; b < 4U; b++) {
        fill_pattern(pt4[b], 32U, (uint8_t)(0xB0U + b));
    }
    rijndael256_expand_key(key, &ks);
    areion_rijndael256_encrypt4_blocks_hw(ct4, (const uint8_t (*)[32])pt4, (const uint8_t (*)[32])ks.rk);
    for (b = 0; b < 4U; b++) {
        rijndael256_encrypt_block_ref(&ks, want, pt4[b]);
        check_bytes_eq("Rijndael256 4x HW vs ref", ct4[b], want, 32U);
    }
    memcpy(inplace4, pt4, sizeof(inplace4));
    areion_rijndael256_encrypt4_blocks_hw(inplace4, (const uint8_t (*)[32])inplace4, (const uint8_t (*)[32])ks.rk);
    for (b = 0; b < 4U; b++) {
        check_bytes_eq("Rijndael256 4x HW in-place", inplace4[b], ct4[b], 32U);
    }
}

static void decode_hex_str(uint8_t *dst, const char *hex, size_t nbytes) {
    size_t i;
    for (i = 0; i < nbytes; i++) {
        uint32_t hi = (hex[2U * i] >= 'a') ? (uint32_t)(hex[2U * i] - 'a' + 10) : (uint32_t)(hex[2U * i] - '0');
        uint32_t lo = (hex[2U * i + 1U] >= 'a') ? (uint32_t)(hex[2U * i + 1U] - 'a' + 10) : (uint32_t)(hex[2U * i + 1U] - '0');
        dst[i] = (uint8_t)((hi << 4U) | lo);
    }
}

static uint8_t reverse_bits_byte(uint8_t x) {
    x = (uint8_t)(((x & 0xaaU) >> 1U) | ((x & 0x55U) << 1U));
    x = (uint8_t)(((x & 0xccU) >> 2U) | ((x & 0x33U) << 2U));
    return (uint8_t)((((unsigned int)x & 0xf0U) >> 4U) | (((unsigned int)x & 0x0fU) << 4U));
}

static void test_vistrutah_kat(void) {
    static const struct { int rounds; const char *want_hex; } k_v256_kats[2] = {
        { 10, "a9803cc54f27745366a4f7e799a34e24f4c69e37c27e13c032d80ee57f9fa36e" },
        { 14, "04227d3cd00d1c7be7da786b8c88f9594e114317221c7430b47ed21e8eb15bbd" }
    };
    static const struct { int rounds; const char *want_hex; } k_v512_256_kats[4] = {
        { 10, "09c3876984355041a49acf0cb868e264585235e05820055c808a3a03eaae157b"
              "00100bc9b3011696c0e1e895e2160cccef31a3454e216ca01bcf6366f584e236" },
        { 12, "a6902748c6f1f9333ca612b85f86561fd04662e3c405ac501316826a702fcd4a"
              "234594f8f9a5dda278d44cc723f5b87672000e4237e38239c1bc06591de6297c" },
        { 14, "a875e9f9130be68b6867cb66f40318ec7e16a3a0501651fff3be08fe70b3c796"
              "0d9b1a8344c9eb61c2bfcbf2f6028e1fcd946bffc95bb42f9e0e8761758319e3" },
        { 18, "6d7f18336b35ed4d785df22dce134935af3fc14fd7c38048853eee54021cfb56"
              "bd306696ad4c1e4982fd4136b57d65ee0fe4b0c10543db5c9caffb7cbd266113" }
    };
    static const struct { int rounds; const char *want_hex; } k_v512_512_kats[2] = {
        { 12,
          "0c7e4d93ecea246b9fcba6331f2f31da033435c0de5a4657fd9f7289f5b48add"
          "2ba9919dfb3799eea853d3e3516ba80f795c7f138bcae300a32f12dd2eafd06d" },
        { 18,
          "383deade951e05948fad5e11909854d4b354cadd06d4dc97a060cf5c3450f7ee"
          "206afb2681d98201ddb93610360d5a9b6546bee5f685d2444dad1ff0ead1bc7a" }
    };
    static const char *k_buggy_go_aes_18r =
        "ecccf2d69de352e402b1daee24e23620205a6a42a0794bbe6c96c1a855134605"
        "04e8252d03d847d152c0df6a146792f54519d15c23173dbc5248fcfa202f71b7";
    uint8_t pt256[32], key256[32], pt512[64], key512[64], mut_key512[64];
    uint8_t want256[32], got_soft256[32], got_hw256[32], dec256[32], inplace256[32];
    uint8_t pt256x4[4][32], got256x4_soft[4][32], got256x4_hw[4][32], dec256x4[4][32], want256_b[32];
    uint8_t want512[64], buggy512[64], got_soft512[64], got_hw512[64], dec512[64], inplace512[64];
    uint8_t pt512x4[4][64], got512x4_soft[4][64], got512x4_hw[4][64], dec512x4[4][64], want512_b[64];
    const uint8_t *psi = &vistrutahConsts[16][0];
    size_t i, tc, b;

    for (i = 0; i < 32U; i++) {
        pt256[i] = (uint8_t)i;
        key256[i] = reverse_bits_byte((uint8_t)(i + 1U));
    }
    for (i = 0; i < 64U; i++) {
        pt512[i] = (uint8_t)i;
        key512[i] = reverse_bits_byte((uint8_t)(i + 1U));
    }

    for (tc = 0; tc < 2U; tc++) {
        int r = k_v256_kats[tc].rounds;
        decode_hex_str(want256, k_v256_kats[tc].want_hex, 32U);
        areion_vistrutah256_encrypt_block_purec(got_soft256, pt256, key256, r);
        check_bytes_eq("Vistrutah256 Soft KAT", got_soft256, want256, 32U);
        areion_vistrutah256_encrypt_block_hw(got_hw256, pt256, key256, r);
        check_bytes_eq("Vistrutah256 HW KAT", got_hw256, want256, 32U);
        areion_vistrutah256_decrypt_block_purec(dec256, got_hw256, key256, r);
        check_bytes_eq("Vistrutah256 Decrypt roundtrip", dec256, pt256, 32U);

        memcpy(inplace256, pt256, 32U);
        areion_vistrutah256_encrypt_block_hw(inplace256, inplace256, key256, r);
        check_bytes_eq("Vistrutah256 HW in-place", inplace256, want256, 32U);

        for (b = 0; b < 4U; b++) {
            for (i = 0; i < 32U; i++) {
                pt256x4[b][i] = (uint8_t)(pt256[i] ^ (uint8_t)(b * 0x11U));
            }
        }
        areion_vistrutah256_encrypt4_blocks_purec(got256x4_soft, (const uint8_t (*)[32])pt256x4, key256, r);
        areion_vistrutah256_encrypt4_blocks_hw(got256x4_hw, (const uint8_t (*)[32])pt256x4, key256, r);
        for (b = 0; b < 4U; b++) {
            areion_vistrutah256_encrypt_block_purec(want256_b, pt256x4[b], key256, r);
            check_bytes_eq("Vistrutah256x4 Soft vs 1x", got256x4_soft[b], want256_b, 32U);
            check_bytes_eq("Vistrutah256x4 HW vs 1x", got256x4_hw[b], want256_b, 32U);
        }
        areion_vistrutah256_decrypt4_blocks_purec(dec256x4, (const uint8_t (*)[32])got256x4_hw, key256, r);
        check_bytes_eq("Vistrutah256x4 Decrypt roundtrip", &dec256x4[0][0], &pt256x4[0][0], 128U);
        memcpy(dec256x4, pt256x4, sizeof(pt256x4));
        areion_vistrutah256_encrypt4_blocks_hw(dec256x4, (const uint8_t (*)[32])dec256x4, key256, r);
        check_bytes_eq("Vistrutah256x4 HW in-place", &dec256x4[0][0], &got256x4_hw[0][0], 128U);
    }

    for (tc = 0; tc < 4U; tc++) {
        int r = k_v512_256_kats[tc].rounds;
        decode_hex_str(want512, k_v512_256_kats[tc].want_hex, 64U);
        areion_vistrutah512_encrypt_block_256_purec(got_soft512, pt512, key256, r);
        check_bytes_eq("Vistrutah512-256 Soft KAT", got_soft512, want512, 64U);
        areion_vistrutah512_encrypt_block_256_hw(got_hw512, pt512, key256, r);
        check_bytes_eq("Vistrutah512-256 HW KAT", got_hw512, want512, 64U);
        areion_vistrutah512_decrypt_block_256_purec(dec512, got_hw512, key256, r);
        check_bytes_eq("Vistrutah512-256 Decrypt roundtrip", dec512, pt512, 64U);

        memcpy(inplace512, pt512, 64U);
        areion_vistrutah512_encrypt_block_256_hw(inplace512, inplace512, key256, r);
        check_bytes_eq("Vistrutah512-256 HW in-place", inplace512, want512, 64U);

        for (b = 0; b < 4U; b++) {
            for (i = 0; i < 64U; i++) {
                pt512x4[b][i] = (uint8_t)(pt512[i] ^ (uint8_t)(b * 0x11U));
            }
        }
        areion_vistrutah512_encrypt4_blocks_256_purec(got512x4_soft, (const uint8_t (*)[64])pt512x4, key256, r);
        areion_vistrutah512_encrypt4_blocks_256_hw(got512x4_hw, (const uint8_t (*)[64])pt512x4, key256, r);
        for (b = 0; b < 4U; b++) {
            areion_vistrutah512_encrypt_block_256_purec(want512_b, pt512x4[b], key256, r);
            check_bytes_eq("Vistrutah512x4-256 Soft vs 1x", got512x4_soft[b], want512_b, 64U);
            check_bytes_eq("Vistrutah512x4-256 HW vs 1x", got512x4_hw[b], want512_b, 64U);
        }
        areion_vistrutah512_decrypt4_blocks_256_purec(dec512x4, (const uint8_t (*)[64])got512x4_hw, key256, r);
        check_bytes_eq("Vistrutah512x4-256 Decrypt roundtrip", &dec512x4[0][0], &pt512x4[0][0], 256U);
        memcpy(dec512x4, pt512x4, sizeof(pt512x4));
        areion_vistrutah512_encrypt4_blocks_256_hw(dec512x4, (const uint8_t (*)[64])dec512x4, key256, r);
        check_bytes_eq("Vistrutah512x4-256 HW in-place", &dec512x4[0][0], &got512x4_hw[0][0], 256U);
    }

    memcpy(mut_key512, key512, 32U);
    for (i = 0; i < 32U; i++) {
        mut_key512[32U + i] = key512[32U + psi[i]];
    }

    for (tc = 0; tc < 2U; tc++) {
        int r = k_v512_512_kats[tc].rounds;
        decode_hex_str(want512, k_v512_512_kats[tc].want_hex, 64U);

        areion_vistrutah512_encrypt_block_512_purec(got_soft512, pt512, key512, r);
        check_bytes_eq("Vistrutah512-512 Soft spec-exact KAT", got_soft512, want512, 64U);
        areion_vistrutah512_encrypt_block_512_hw(got_hw512, pt512, key512, r);
        check_bytes_eq("Vistrutah512-512 HW spec-exact KAT", got_hw512, want512, 64U);
        areion_vistrutah512_decrypt_block_512_purec(dec512, got_hw512, key512, r);
        check_bytes_eq("Vistrutah512-512 Decrypt roundtrip", dec512, pt512, 64U);

        memcpy(inplace512, pt512, 64U);
        areion_vistrutah512_encrypt_block_512_hw(inplace512, inplace512, key512, r);
        check_bytes_eq("Vistrutah512-512 HW in-place", inplace512, want512, 64U);

        for (b = 0; b < 4U; b++) {
            for (i = 0; i < 64U; i++) {
                pt512x4[b][i] = (uint8_t)(pt512[i] ^ (uint8_t)(b * 0x11U));
            }
        }
        areion_vistrutah512_encrypt4_blocks_512_purec(got512x4_soft, (const uint8_t (*)[64])pt512x4, key512, r);
        areion_vistrutah512_encrypt4_blocks_512_hw(got512x4_hw, (const uint8_t (*)[64])pt512x4, key512, r);
        for (b = 0; b < 4U; b++) {
            areion_vistrutah512_encrypt_block_512_purec(want512_b, pt512x4[b], key512, r);
            check_bytes_eq("Vistrutah512x4-512 Soft vs 1x", got512x4_soft[b], want512_b, 64U);
            check_bytes_eq("Vistrutah512x4-512 HW vs 1x", got512x4_hw[b], want512_b, 64U);
        }
        areion_vistrutah512_decrypt4_blocks_512_purec(dec512x4, (const uint8_t (*)[64])got512x4_hw, key512, r);
        check_bytes_eq("Vistrutah512x4-512 Decrypt roundtrip", &dec512x4[0][0], &pt512x4[0][0], 256U);
        memcpy(dec512x4, pt512x4, sizeof(pt512x4));
        areion_vistrutah512_encrypt4_blocks_512_hw(dec512x4, (const uint8_t (*)[64])dec512x4, key512, r);
        check_bytes_eq("Vistrutah512x4-512 HW in-place", &dec512x4[0][0], &got512x4_hw[0][0], 256U);
    }

    /* Verify go-aes Psi-mutation regression */
    decode_hex_str(buggy512, k_buggy_go_aes_18r, 64U);
    areion_vistrutah512_encrypt_block_512_hw(got_hw512, pt512, mut_key512, 18);
    check_bytes_eq("Vistrutah512-512 go-aes Psi regression", got_hw512, buggy512, 64U);
}

static void test_asura(void) {
    static const char *k_asura_kat0_hex =
        "74e5189f712dc78c0e6b8d9c8253722a8dd57144fb2698ff1c0654c56099d1cd";
    static const char *k_asura_kat1_hex =
        "a75c46eaa0e513e883375fb0ed587c5793e84dead955f9a835d0bfb3ce1dd521";
    static const char *k_asura_rtk0_hex =
        "fd1be115909ea5d26aa040862c10e46670707070707070707070707070707070";
    static const char *k_asura_rtk1_hex =
        "2f2e1ebf5adf153de8124cbcb3a11e3b846825d410661a41701360166b198a83";
    static const char *k_asura_rtk2_hex =
        "73172f4c1ba9752c70e2c36528af1770075566c57ac64439217e17c153a4d8ad";
    static const char *k_asura_rtk12_hex =
        "8ed37f1e04067aba2599a5a7ac6dcb7c06f8836cef70c3169f2e88967a67277a";
    static const char *k_asura_rk0_hex =
        "bd5aa356d4dbe39522e90acd605daa29303132333435363738393a3b3c3d3e3f";
    static const char *k_asura_rk1_hex =
        "dd1e590f14d94530fe495ede96c8cee4765862645e604a4c664872744e705a5c";
    static const char *k_asura_rk2_hex =
        "9c9ef94d9983b1c199604440a3c76f29e8dcb0c4f8ec80d4c8fc90e4d8cca0f4";
    static const char *k_asura_rk12_hex =
        "81d7b8c3573f48a89c6446af456c322d09fc44b1bc49f10426d36b9e9366de2b";
    uint8_t key[32], tweak[16], tweaks4[4][16], tweaks4_same[4][16], pt[32], want[32], want_rtk[32];
    uint8_t rk_soft[13][32], rk_hw[13][32], k_soft[13][32], k_hw[13][32];
    uint8_t ct_soft[32], ct_hw[32], ct_otf_soft[32], ct_otf_hw[32], ct_rk_soft[32], ct_rk_hw[32];
    uint8_t dec_soft[32], dec_hw[32], dec_otf_soft[32], dec_otf_hw[32], dec_rk_soft[32], dec_rk_hw[32];
    uint8_t inplace[32];
    uint8_t pt4[4][32], ct4_soft[4][32], ct4_hw[4][32], ct4_otf_soft[4][32], ct4_otf_hw[4][32], ct4_rk_soft[4][32], ct4_rk_hw[4][32];
    uint8_t dec4_soft[4][32], dec4_hw[4][32], dec4_otf_soft[4][32], dec4_otf_hw[4][32], dec4_rk_soft[4][32], dec4_rk_hw[4][32];
    uint8_t want_b[32], mut[32], mut_tw[16], out[32];
    uint8_t unaligned_buf[1024];
    size_t i, b, bit_idx;
    unsigned int total_flips = 0U, total_tests = 0U;

    /* KAT 0: all-zero key, tweak, plaintext */
    memset(key, 0, sizeof(key));
    memset(tweak, 0, sizeof(tweak));
    memset(pt, 0, sizeof(pt));
    decode_hex_str(want, k_asura_kat0_hex, 32U);

    areion_asura_expand_tweakey_purec(rk_soft, key, tweak);
    areion_asura_expand_tweakey_hw(rk_hw, key, tweak);
    check_bytes_eq("ASURA KAT0 expand_tweakey HW vs Soft", &rk_hw[0][0], &rk_soft[0][0], sizeof(rk_soft));
    areion_asura_expand_key_purec(k_soft, key);
    areion_asura_expand_key_hw(k_hw, key);
    check_bytes_eq("ASURA KAT0 expand_key HW vs Soft", &k_hw[0][0], &k_soft[0][0], sizeof(k_soft));
    check_bytes_eq("ASURA KAT0 expand_key[0] vs zero-tweak expand_tweakey[0]", k_hw[0], rk_hw[0], 32U);

    areion_asura_encrypt_block_purec(ct_soft, pt, (const uint8_t (*)[32])rk_soft);
    check_bytes_eq("ASURA KAT0 encrypt Soft", ct_soft, want, 32U);
    areion_asura_encrypt_block_hw(ct_hw, pt, (const uint8_t (*)[32])rk_hw);
    check_bytes_eq("ASURA KAT0 encrypt HW", ct_hw, want, 32U);
    areion_asura_encrypt_block_otf_purec(ct_otf_soft, pt, key, tweak);
    check_bytes_eq("ASURA KAT0 encrypt OTF Soft", ct_otf_soft, want, 32U);
    areion_asura_encrypt_block_otf_hw(ct_otf_hw, pt, key, tweak);
    check_bytes_eq("ASURA KAT0 encrypt OTF HW", ct_otf_hw, want, 32U);
    areion_asura_encrypt_block_rk_purec(ct_rk_soft, pt, (const uint8_t (*)[32])k_soft, tweak);
    check_bytes_eq("ASURA KAT0 encrypt RK Soft", ct_rk_soft, want, 32U);
    areion_asura_encrypt_block_rk_hw(ct_rk_hw, pt, (const uint8_t (*)[32])k_hw, tweak);
    check_bytes_eq("ASURA KAT0 encrypt RK HW", ct_rk_hw, want, 32U);

    areion_asura_decrypt_block_purec(dec_soft, want, (const uint8_t (*)[32])rk_soft);
    check_bytes_eq("ASURA KAT0 decrypt Soft", dec_soft, pt, 32U);
    areion_asura_decrypt_block_hw(dec_hw, want, (const uint8_t (*)[32])rk_hw);
    check_bytes_eq("ASURA KAT0 decrypt HW", dec_hw, pt, 32U);
    areion_asura_decrypt_block_otf_purec(dec_otf_soft, want, key, tweak);
    check_bytes_eq("ASURA KAT0 decrypt OTF Soft", dec_otf_soft, pt, 32U);
    areion_asura_decrypt_block_otf_hw(dec_otf_hw, want, key, tweak);
    check_bytes_eq("ASURA KAT0 decrypt OTF HW", dec_otf_hw, pt, 32U);
    areion_asura_decrypt_block_rk_purec(dec_rk_soft, want, (const uint8_t (*)[32])k_soft, tweak);
    check_bytes_eq("ASURA KAT0 decrypt RK Soft", dec_rk_soft, pt, 32U);
    areion_asura_decrypt_block_rk_hw(dec_rk_hw, want, (const uint8_t (*)[32])k_hw, tweak);
    check_bytes_eq("ASURA KAT0 decrypt RK HW", dec_rk_hw, pt, 32U);

    /* KAT 1: sequential bytes pt = 00..1f, key = 20..3f, tweak = 40..4f */
    for (i = 0; i < 32U; i++) {
        pt[i] = (uint8_t)i;
        key[i] = (uint8_t)(0x20U + i);
    }
    for (i = 0; i < 16U; i++) {
        tweak[i] = (uint8_t)(0x40U + i);
    }
    decode_hex_str(want, k_asura_kat1_hex, 32U);

    areion_asura_expand_tweakey_purec(rk_soft, key, tweak);
    areion_asura_expand_tweakey_hw(rk_hw, key, tweak);
    check_bytes_eq("ASURA KAT1 expand_tweakey HW vs Soft", &rk_hw[0][0], &rk_soft[0][0], sizeof(rk_soft));
    decode_hex_str(want_rtk, k_asura_rtk0_hex, 32U);
    check_bytes_eq("ASURA KAT1 RTK[0]", rk_hw[0], want_rtk, 32U);
    decode_hex_str(want_rtk, k_asura_rtk1_hex, 32U);
    check_bytes_eq("ASURA KAT1 RTK[1]", rk_hw[1], want_rtk, 32U);
    decode_hex_str(want_rtk, k_asura_rtk2_hex, 32U);
    check_bytes_eq("ASURA KAT1 RTK[2]", rk_hw[2], want_rtk, 32U);
    decode_hex_str(want_rtk, k_asura_rtk12_hex, 32U);
    check_bytes_eq("ASURA KAT1 RTK[12]", rk_hw[12], want_rtk, 32U);

    areion_asura_expand_key_purec(k_soft, key);
    areion_asura_expand_key_hw(k_hw, key);
    check_bytes_eq("ASURA KAT1 expand_key HW vs Soft", &k_hw[0][0], &k_soft[0][0], sizeof(k_soft));
    decode_hex_str(want_rtk, k_asura_rk0_hex, 32U);
    check_bytes_eq("ASURA KAT1 RK[0]", k_hw[0], want_rtk, 32U);
    decode_hex_str(want_rtk, k_asura_rk1_hex, 32U);
    check_bytes_eq("ASURA KAT1 RK[1]", k_hw[1], want_rtk, 32U);
    decode_hex_str(want_rtk, k_asura_rk2_hex, 32U);
    check_bytes_eq("ASURA KAT1 RK[2]", k_hw[2], want_rtk, 32U);
    decode_hex_str(want_rtk, k_asura_rk12_hex, 32U);
    check_bytes_eq("ASURA KAT1 RK[12]", k_hw[12], want_rtk, 32U);

    areion_asura_encrypt_block_purec(ct_soft, pt, (const uint8_t (*)[32])rk_soft);
    check_bytes_eq("ASURA KAT1 encrypt Soft", ct_soft, want, 32U);
    areion_asura_encrypt_block_hw(ct_hw, pt, (const uint8_t (*)[32])rk_hw);
    check_bytes_eq("ASURA KAT1 encrypt HW", ct_hw, want, 32U);
    areion_asura_encrypt_block_otf_purec(ct_otf_soft, pt, key, tweak);
    check_bytes_eq("ASURA KAT1 encrypt OTF Soft", ct_otf_soft, want, 32U);
    areion_asura_encrypt_block_otf_hw(ct_otf_hw, pt, key, tweak);
    check_bytes_eq("ASURA KAT1 encrypt OTF HW", ct_otf_hw, want, 32U);
    areion_asura_encrypt_block_rk_purec(ct_rk_soft, pt, (const uint8_t (*)[32])k_soft, tweak);
    check_bytes_eq("ASURA KAT1 encrypt RK Soft", ct_rk_soft, want, 32U);
    areion_asura_encrypt_block_rk_hw(ct_rk_hw, pt, (const uint8_t (*)[32])k_hw, tweak);
    check_bytes_eq("ASURA KAT1 encrypt RK HW", ct_rk_hw, want, 32U);

    areion_asura_decrypt_block_purec(dec_soft, want, (const uint8_t (*)[32])rk_soft);
    check_bytes_eq("ASURA KAT1 decrypt Soft", dec_soft, pt, 32U);
    areion_asura_decrypt_block_hw(dec_hw, want, (const uint8_t (*)[32])rk_hw);
    check_bytes_eq("ASURA KAT1 decrypt HW", dec_hw, pt, 32U);
    areion_asura_decrypt_block_otf_purec(dec_otf_soft, want, key, tweak);
    check_bytes_eq("ASURA KAT1 decrypt OTF Soft", dec_otf_soft, pt, 32U);
    areion_asura_decrypt_block_otf_hw(dec_otf_hw, want, key, tweak);
    check_bytes_eq("ASURA KAT1 decrypt OTF HW", dec_otf_hw, pt, 32U);
    areion_asura_decrypt_block_rk_purec(dec_rk_soft, want, (const uint8_t (*)[32])k_soft, tweak);
    check_bytes_eq("ASURA KAT1 decrypt RK Soft", dec_rk_soft, pt, 32U);
    areion_asura_decrypt_block_rk_hw(dec_rk_hw, want, (const uint8_t (*)[32])k_hw, tweak);
    check_bytes_eq("ASURA KAT1 decrypt RK HW", dec_rk_hw, pt, 32U);

    /* In-place 1-block pre-expanded, OTF, and RK */
    memcpy(inplace, pt, 32U);
    areion_asura_encrypt_block_hw(inplace, inplace, (const uint8_t (*)[32])rk_hw);
    check_bytes_eq("ASURA KAT1 in-place encrypt HW", inplace, want, 32U);
    areion_asura_decrypt_block_hw(inplace, inplace, (const uint8_t (*)[32])rk_hw);
    check_bytes_eq("ASURA KAT1 in-place decrypt HW", inplace, pt, 32U);

    memcpy(inplace, pt, 32U);
    areion_asura_encrypt_block_otf_hw(inplace, inplace, key, tweak);
    check_bytes_eq("ASURA KAT1 in-place encrypt OTF HW", inplace, want, 32U);
    areion_asura_decrypt_block_otf_hw(inplace, inplace, key, tweak);
    check_bytes_eq("ASURA KAT1 in-place decrypt OTF HW", inplace, pt, 32U);

    memcpy(inplace, pt, 32U);
    areion_asura_encrypt_block_rk_hw(inplace, inplace, (const uint8_t (*)[32])k_hw, tweak);
    check_bytes_eq("ASURA KAT1 in-place encrypt RK HW", inplace, want, 32U);
    areion_asura_decrypt_block_rk_hw(inplace, inplace, (const uint8_t (*)[32])k_hw, tweak);
    check_bytes_eq("ASURA KAT1 in-place decrypt RK HW", inplace, pt, 32U);

    /* Unaligned 1-block test */
    memcpy(unaligned_buf + 1, pt, 32U);
    memcpy(unaligned_buf + 65, key, 32U);
    memcpy(unaligned_buf + 129, tweak, 16U);
    areion_asura_encrypt_block_otf_hw(unaligned_buf + 193, unaligned_buf + 1, unaligned_buf + 65, unaligned_buf + 129);
    check_bytes_eq("ASURA KAT1 unaligned encrypt OTF HW", unaligned_buf + 193, want, 32U);
    areion_asura_decrypt_block_otf_hw(unaligned_buf + 257, unaligned_buf + 193, unaligned_buf + 65, unaligned_buf + 129);
    check_bytes_eq("ASURA KAT1 unaligned decrypt OTF HW", unaligned_buf + 257, pt, 32U);
    areion_asura_expand_key_hw((uint8_t (*)[32])(unaligned_buf + 321), unaligned_buf + 65);
    areion_asura_encrypt_block_rk_hw(unaligned_buf + 193, unaligned_buf + 1, (const uint8_t (*)[32])(unaligned_buf + 321), unaligned_buf + 129);
    check_bytes_eq("ASURA KAT1 unaligned encrypt RK HW", unaligned_buf + 193, want, 32U);
    areion_asura_decrypt_block_rk_hw(unaligned_buf + 257, unaligned_buf + 193, (const uint8_t (*)[32])(unaligned_buf + 321), unaligned_buf + 129);
    check_bytes_eq("ASURA KAT1 unaligned decrypt RK HW", unaligned_buf + 257, pt, 32U);

    /* 4-block x4 pre-expanded, OTF, and RK */
    for (b = 0; b < 4U; b++) {
        for (i = 0; i < 32U; i++) {
            pt4[b][i] = (uint8_t)(pt[i] ^ (uint8_t)(b * 0x29U));
        }
        for (i = 0; i < 16U; i++) {
            tweaks4[b][i] = (uint8_t)(tweak[i] ^ (uint8_t)(b * 0x17U));
            tweaks4_same[b][i] = tweak[i];
        }
    }
    areion_asura_encrypt_4blocks_purec(ct4_soft, (const uint8_t (*)[32])pt4, (const uint8_t (*)[32])rk_soft);
    areion_asura_encrypt_4blocks_hw(ct4_hw, (const uint8_t (*)[32])pt4, (const uint8_t (*)[32])rk_hw);
    areion_asura_encrypt_4blocks_otf_purec(ct4_otf_soft, (const uint8_t (*)[32])pt4, key, (const uint8_t (*)[16])tweaks4_same);
    areion_asura_encrypt_4blocks_otf_hw(ct4_otf_hw, (const uint8_t (*)[32])pt4, key, (const uint8_t (*)[16])tweaks4_same);
    areion_asura_encrypt_4blocks_rk_purec(ct4_rk_soft, (const uint8_t (*)[32])pt4, (const uint8_t (*)[32])k_soft, (const uint8_t (*)[16])tweaks4_same);
    areion_asura_encrypt_4blocks_rk_hw(ct4_rk_hw, (const uint8_t (*)[32])pt4, (const uint8_t (*)[32])k_hw, (const uint8_t (*)[16])tweaks4_same);
    check_bytes_eq("ASURA 4blocks encrypt OTF same-tweak Soft vs Mode1", &ct4_otf_soft[0][0], &ct4_hw[0][0], 128U);
    check_bytes_eq("ASURA 4blocks encrypt OTF same-tweak HW vs Mode1", &ct4_otf_hw[0][0], &ct4_hw[0][0], 128U);
    check_bytes_eq("ASURA 4blocks encrypt RK same-tweak Soft vs Mode1", &ct4_rk_soft[0][0], &ct4_hw[0][0], 128U);
    check_bytes_eq("ASURA 4blocks encrypt RK same-tweak HW vs Mode1", &ct4_rk_hw[0][0], &ct4_hw[0][0], 128U);

    areion_asura_encrypt_4blocks_otf_purec(ct4_otf_soft, (const uint8_t (*)[32])pt4, key, (const uint8_t (*)[16])tweaks4);
    areion_asura_encrypt_4blocks_otf_hw(ct4_otf_hw, (const uint8_t (*)[32])pt4, key, (const uint8_t (*)[16])tweaks4);
    areion_asura_encrypt_4blocks_rk_purec(ct4_rk_soft, (const uint8_t (*)[32])pt4, (const uint8_t (*)[32])k_soft, (const uint8_t (*)[16])tweaks4);
    areion_asura_encrypt_4blocks_rk_hw(ct4_rk_hw, (const uint8_t (*)[32])pt4, (const uint8_t (*)[32])k_hw, (const uint8_t (*)[16])tweaks4);
    for (b = 0; b < 4U; b++) {
        areion_asura_encrypt_block_purec(want_b, pt4[b], (const uint8_t (*)[32])rk_soft);
        check_bytes_eq("ASURA 4blocks encrypt Soft vs 1x", ct4_soft[b], want_b, 32U);
        check_bytes_eq("ASURA 4blocks encrypt HW vs 1x", ct4_hw[b], want_b, 32U);
        areion_asura_encrypt_block_otf_purec(want_b, pt4[b], key, tweaks4[b]);
        check_bytes_eq("ASURA 4blocks encrypt OTF Soft vs 1x", ct4_otf_soft[b], want_b, 32U);
        check_bytes_eq("ASURA 4blocks encrypt OTF HW vs 1x", ct4_otf_hw[b], want_b, 32U);
        check_bytes_eq("ASURA 4blocks encrypt RK Soft vs 1x", ct4_rk_soft[b], want_b, 32U);
        check_bytes_eq("ASURA 4blocks encrypt RK HW vs 1x", ct4_rk_hw[b], want_b, 32U);
    }

    areion_asura_decrypt_4blocks_purec(dec4_soft, (const uint8_t (*)[32])ct4_hw, (const uint8_t (*)[32])rk_soft);
    areion_asura_decrypt_4blocks_hw(dec4_hw, (const uint8_t (*)[32])ct4_hw, (const uint8_t (*)[32])rk_hw);
    areion_asura_decrypt_4blocks_otf_purec(dec4_otf_soft, (const uint8_t (*)[32])ct4_otf_hw, key, (const uint8_t (*)[16])tweaks4);
    areion_asura_decrypt_4blocks_otf_hw(dec4_otf_hw, (const uint8_t (*)[32])ct4_otf_hw, key, (const uint8_t (*)[16])tweaks4);
    areion_asura_decrypt_4blocks_rk_purec(dec4_rk_soft, (const uint8_t (*)[32])ct4_rk_hw, (const uint8_t (*)[32])k_soft, (const uint8_t (*)[16])tweaks4);
    areion_asura_decrypt_4blocks_rk_hw(dec4_rk_hw, (const uint8_t (*)[32])ct4_rk_hw, (const uint8_t (*)[32])k_hw, (const uint8_t (*)[16])tweaks4);
    check_bytes_eq("ASURA 4blocks decrypt Soft roundtrip", &dec4_soft[0][0], &pt4[0][0], 128U);
    check_bytes_eq("ASURA 4blocks decrypt HW roundtrip", &dec4_hw[0][0], &pt4[0][0], 128U);
    check_bytes_eq("ASURA 4blocks decrypt OTF Soft roundtrip", &dec4_otf_soft[0][0], &pt4[0][0], 128U);
    check_bytes_eq("ASURA 4blocks decrypt OTF HW roundtrip", &dec4_otf_hw[0][0], &pt4[0][0], 128U);
    check_bytes_eq("ASURA 4blocks decrypt RK Soft roundtrip", &dec4_rk_soft[0][0], &pt4[0][0], 128U);
    check_bytes_eq("ASURA 4blocks decrypt RK HW roundtrip", &dec4_rk_hw[0][0], &pt4[0][0], 128U);

    /* Unaligned 4-block OTF and RK test */
    memcpy(unaligned_buf + 1, pt4, 128U);
    memcpy(unaligned_buf + 129, key, 32U);
    memcpy(unaligned_buf + 161, tweaks4, 64U);
    memcpy(unaligned_buf + 225, k_hw, sizeof(k_hw));
    areion_asura_encrypt_4blocks_otf_hw(
        (uint8_t (*)[32])(unaligned_buf + 641),
        (const uint8_t (*)[32])(unaligned_buf + 1),
        unaligned_buf + 129,
        (const uint8_t (*)[16])(unaligned_buf + 161));
    check_bytes_eq("ASURA 4blocks unaligned encrypt OTF HW", unaligned_buf + 641, &ct4_otf_hw[0][0], 128U);
    areion_asura_decrypt_4blocks_otf_hw(
        (uint8_t (*)[32])(unaligned_buf + 769),
        (const uint8_t (*)[32])(unaligned_buf + 641),
        unaligned_buf + 129,
        (const uint8_t (*)[16])(unaligned_buf + 161));
    check_bytes_eq("ASURA 4blocks unaligned decrypt OTF HW", unaligned_buf + 769, &pt4[0][0], 128U);
    areion_asura_encrypt_4blocks_rk_hw(
        (uint8_t (*)[32])(unaligned_buf + 641),
        (const uint8_t (*)[32])(unaligned_buf + 1),
        (const uint8_t (*)[32])(unaligned_buf + 225),
        (const uint8_t (*)[16])(unaligned_buf + 161));
    check_bytes_eq("ASURA 4blocks unaligned encrypt RK HW", unaligned_buf + 641, &ct4_rk_hw[0][0], 128U);
    areion_asura_decrypt_4blocks_rk_hw(
        (uint8_t (*)[32])(unaligned_buf + 769),
        (const uint8_t (*)[32])(unaligned_buf + 641),
        (const uint8_t (*)[32])(unaligned_buf + 225),
        (const uint8_t (*)[16])(unaligned_buf + 161));
    check_bytes_eq("ASURA 4blocks unaligned decrypt RK HW", unaligned_buf + 769, &pt4[0][0], 128U);

    /* In-place 4-block pre-expanded, OTF, and RK */
    memcpy(dec4_hw, pt4, sizeof(pt4));
    areion_asura_encrypt_4blocks_hw(dec4_hw, (const uint8_t (*)[32])dec4_hw, (const uint8_t (*)[32])rk_hw);
    check_bytes_eq("ASURA 4blocks in-place encrypt HW", &dec4_hw[0][0], &ct4_hw[0][0], 128U);
    areion_asura_decrypt_4blocks_hw(dec4_hw, (const uint8_t (*)[32])dec4_hw, (const uint8_t (*)[32])rk_hw);
    check_bytes_eq("ASURA 4blocks in-place decrypt HW", &dec4_hw[0][0], &pt4[0][0], 128U);

    memcpy(dec4_otf_hw, pt4, sizeof(pt4));
    areion_asura_encrypt_4blocks_otf_hw(dec4_otf_hw, (const uint8_t (*)[32])dec4_otf_hw, key, (const uint8_t (*)[16])tweaks4);
    check_bytes_eq("ASURA 4blocks in-place encrypt OTF HW", &dec4_otf_hw[0][0], &ct4_otf_hw[0][0], 128U);
    areion_asura_decrypt_4blocks_otf_hw(dec4_otf_hw, (const uint8_t (*)[32])dec4_otf_hw, key, (const uint8_t (*)[16])tweaks4);
    check_bytes_eq("ASURA 4blocks in-place decrypt OTF HW", &dec4_otf_hw[0][0], &pt4[0][0], 128U);

    memcpy(dec4_rk_hw, pt4, sizeof(pt4));
    areion_asura_encrypt_4blocks_rk_hw(dec4_rk_hw, (const uint8_t (*)[32])dec4_rk_hw, (const uint8_t (*)[32])k_hw, (const uint8_t (*)[16])tweaks4);
    check_bytes_eq("ASURA 4blocks in-place encrypt RK HW", &dec4_rk_hw[0][0], &ct4_rk_hw[0][0], 128U);
    areion_asura_decrypt_4blocks_rk_hw(dec4_rk_hw, (const uint8_t (*)[32])dec4_rk_hw, (const uint8_t (*)[32])k_hw, (const uint8_t (*)[16])tweaks4);
    check_bytes_eq("ASURA 4blocks in-place decrypt RK HW", &dec4_rk_hw[0][0], &pt4[0][0], 128U);

    /* Public API & _Generic macro dispatch without explicit multi-dimensional const casts */
    areion_asura_expand_tweakey(rk_hw, key, tweak);
    areion_asura_encrypt(ct_hw, pt, rk_hw);
    check_bytes_eq("ASURA public areion_asura_encrypt", ct_hw, want, 32U);
    areion_asura_decrypt(dec_hw, ct_hw, rk_hw);
    check_bytes_eq("ASURA public areion_asura_decrypt", dec_hw, pt, 32U);
    areion_asura_encryptx4(ct4_hw, pt4, rk_hw);
    areion_asura_decryptx4(dec4_hw, ct4_hw, rk_hw);
    check_bytes_eq("ASURA public areion_asura_decryptx4", &dec4_hw[0][0], &pt4[0][0], 128U);
    areion_asura_encrypt_otf(ct_otf_hw, pt, key, tweak);
    check_bytes_eq("ASURA public areion_asura_encrypt_otf", ct_otf_hw, want, 32U);
    areion_asura_decrypt_otf(dec_otf_hw, ct_otf_hw, key, tweak);
    check_bytes_eq("ASURA public areion_asura_decrypt_otf", dec_otf_hw, pt, 32U);
    areion_asura_encryptx4_otf(ct4_otf_hw, pt4, key, tweaks4);
    areion_asura_decryptx4_otf(dec4_otf_hw, ct4_otf_hw, key, tweaks4);
    check_bytes_eq("ASURA public areion_asura_decryptx4_otf", &dec4_otf_hw[0][0], &pt4[0][0], 128U);
    areion_asura_expand_key(k_hw, key);
    areion_asura_encrypt_rk(ct_rk_hw, pt, k_hw, tweak);
    check_bytes_eq("ASURA public areion_asura_encrypt_rk", ct_rk_hw, want, 32U);
    areion_asura_decrypt_rk(dec_rk_hw, ct_rk_hw, k_hw, tweak);
    check_bytes_eq("ASURA public areion_asura_decrypt_rk", dec_rk_hw, pt, 32U);
    areion_asura_encryptx4_rk(ct4_rk_hw, pt4, k_hw, tweaks4);
    areion_asura_decryptx4_rk(dec4_rk_hw, ct4_rk_hw, k_hw, tweaks4);
    check_bytes_eq("ASURA public areion_asura_decryptx4_rk", &dec4_rk_hw[0][0], &pt4[0][0], 128U);
    areion_wipe_asura_tweakey(rk_hw);
    areion_wipe_asura_key(k_hw);
    memset(unaligned_buf, 0, sizeof(rk_hw));
    check_bytes_eq("ASURA areion_wipe_asura_tweakey", &rk_hw[0][0], unaligned_buf, sizeof(rk_hw));
    check_bytes_eq("ASURA areion_wipe_asura_key", &k_hw[0][0], unaligned_buf, sizeof(k_hw));

    /* Bit sensitivity & avalanche across key (256b), tweak (128b), plaintext (256b) */
    for (i = 0; i < 32U; i++) {
        for (bit_idx = 0; bit_idx < 8U; bit_idx++) {
            size_t j;
            memcpy(mut, key, 32U);
            mut[i] ^= (uint8_t)(1U << bit_idx);
            areion_asura_encrypt_block_otf_hw(out, pt, mut, tweak);
            if (memcmp(out, want, 32U) == 0) {
                g_failures++;
            }
            for (j = 0; j < 32U; j++) {
                uint8_t diff = (uint8_t)(out[j] ^ want[j]);
                while (diff != 0U) {
                    total_flips += (unsigned int)(diff & 1U);
                    diff = (uint8_t)(diff >> 1U);
                }
            }
            total_tests++;

            memcpy(mut, pt, 32U);
            mut[i] ^= (uint8_t)(1U << bit_idx);
            areion_asura_encrypt_block_otf_hw(out, mut, key, tweak);
            if (memcmp(out, want, 32U) == 0) {
                g_failures++;
            }
            for (j = 0; j < 32U; j++) {
                uint8_t diff = (uint8_t)(out[j] ^ want[j]);
                while (diff != 0U) {
                    total_flips += (unsigned int)(diff & 1U);
                    diff = (uint8_t)(diff >> 1U);
                }
            }
            total_tests++;
        }
    }
    for (i = 0; i < 16U; i++) {
        for (bit_idx = 0; bit_idx < 8U; bit_idx++) {
            size_t j;
            memcpy(mut_tw, tweak, 16U);
            mut_tw[i] ^= (uint8_t)(1U << bit_idx);
            areion_asura_encrypt_block_otf_hw(out, pt, key, mut_tw);
            if (memcmp(out, want, 32U) == 0) {
                g_failures++;
            }
            for (j = 0; j < 32U; j++) {
                uint8_t diff = (uint8_t)(out[j] ^ want[j]);
                while (diff != 0U) {
                    total_flips += (unsigned int)(diff & 1U);
                    diff = (uint8_t)(diff >> 1U);
                }
            }
            total_tests++;
        }
    }
    if (total_flips < total_tests * 110U || total_flips > total_tests * 146U) {
        (void)fprintf(stderr, "FAIL: ASURA avalanche out of range (%u / %u)\n", total_flips, total_tests);
        g_failures++;
    }
}

static void test_supercop_wrappers(void) {
    uint8_t in256[32], out256[32], want256[32], dec256[32], tw256[32], k256[64];
    uint8_t in512[64], out512[64], want512[64], dec512[64], tw512[64], k512[128];

    fill_pattern(in256, 32U, 0x11U);
    fill_pattern(tw256, 32U, 0x22U);
    fill_pattern(k256, 64U, 0x33U);
    fill_pattern(in512, 64U, 0x44U);
    fill_pattern(tw512, 64U, 0x55U);
    fill_pattern(k512, 128U, 0x66U);

    memcpy(want256, in256, 32U);
    areion_permute256(want256);
    g_failures += supercop_areion256_core(out256, in256, NULL, NULL);
    check_bytes_eq("SUPERCOP crypto_core/areion256", out256, want256, 32U);
    memcpy(out256, in256, 32U);
    g_failures += supercop_areion256_core(out256, out256, NULL, NULL);
    check_bytes_eq("SUPERCOP crypto_core/areion256 in-place", out256, want256, 32U);

    memcpy(want512, in512, 64U);
    areion_permute512(want512);
    g_failures += supercop_areion512_core(out512, in512, NULL, NULL);
    check_bytes_eq("SUPERCOP crypto_core/areion512", out512, want512, 64U);
    memcpy(out512, in512, 64U);
    g_failures += supercop_areion512_core(out512, out512, NULL, NULL);
    check_bytes_eq("SUPERCOP crypto_core/areion512 in-place", out512, want512, 64U);

    areion_soem256(want256, k256, in256);
    g_failures += supercop_soem256_prf(out256, in256, k256);
    check_bytes_eq("SUPERCOP crypto_prf/soem256", out256, want256, 32U);

    areion_soem512(want512, k512, in512);
    g_failures += supercop_soem512_prf(out512, in512, k512);
    check_bytes_eq("SUPERCOP crypto_prf/soem512", out512, want512, 64U);

    areion_em_encrypt256(want256, k256, in256);
    g_failures += supercop_em256_encrypt(out256, in256, NULL, k256);
    g_failures += supercop_em256_decrypt(dec256, out256, NULL, k256);
    check_bytes_eq("SUPERCOP crypto_tbc/em256 encrypt", out256, want256, 32U);
    check_bytes_eq("SUPERCOP crypto_tbc/em256 decrypt", dec256, in256, 32U);

    areion_em_encrypt512(want512, k512, in512);
    g_failures += supercop_em512_encrypt(out512, in512, NULL, k512);
    g_failures += supercop_em512_decrypt(dec512, out512, NULL, k512);
    check_bytes_eq("SUPERCOP crypto_tbc/em512 encrypt", out512, want512, 64U);
    check_bytes_eq("SUPERCOP crypto_tbc/em512 decrypt", dec512, in512, 64U);

    areion_em2_encrypt256(want256, k256, in256);
    g_failures += supercop_em2256_encrypt(out256, in256, NULL, k256);
    g_failures += supercop_em2256_decrypt(dec256, out256, NULL, k256);
    check_bytes_eq("SUPERCOP crypto_tbc/em2256 encrypt", out256, want256, 32U);
    check_bytes_eq("SUPERCOP crypto_tbc/em2256 decrypt", dec256, in256, 32U);

    areion_em2_encrypt512(want512, k512, in512);
    g_failures += supercop_em2512_encrypt(out512, in512, NULL, k512);
    g_failures += supercop_em2512_decrypt(dec512, out512, NULL, k512);
    check_bytes_eq("SUPERCOP crypto_tbc/em2512 encrypt", out512, want512, 64U);
    check_bytes_eq("SUPERCOP crypto_tbc/em2512 decrypt", dec512, in512, 64U);

    areion_tem_encrypt256(want256, k256, tw256, in256);
    g_failures += supercop_tem256_encrypt(out256, in256, tw256, k256);
    g_failures += supercop_tem256_decrypt(dec256, out256, tw256, k256);
    check_bytes_eq("SUPERCOP crypto_tbc/tem256 encrypt", out256, want256, 32U);
    check_bytes_eq("SUPERCOP crypto_tbc/tem256 decrypt", dec256, in256, 32U);

    areion_tem_encrypt512(want512, k512, tw512, in512);
    g_failures += supercop_tem512_encrypt(out512, in512, tw512, k512);
    g_failures += supercop_tem512_decrypt(dec512, out512, tw512, k512);
    check_bytes_eq("SUPERCOP crypto_tbc/tem512 encrypt", out512, want512, 64U);
    check_bytes_eq("SUPERCOP crypto_tbc/tem512 decrypt", dec512, in512, 64U);

    areion_tem2_encrypt256(want256, k256, tw256, in256);
    g_failures += supercop_tem2256_encrypt(out256, in256, tw256, k256);
    g_failures += supercop_tem2256_decrypt(dec256, out256, tw256, k256);
    check_bytes_eq("SUPERCOP crypto_tbc/tem2256 encrypt", out256, want256, 32U);
    check_bytes_eq("SUPERCOP crypto_tbc/tem2256 decrypt", dec256, in256, 32U);

    areion_tem2_encrypt512(want512, k512, tw512, in512);
    g_failures += supercop_tem2512_encrypt(out512, in512, tw512, k512);
    g_failures += supercop_tem2512_decrypt(dec512, out512, tw512, k512);
    check_bytes_eq("SUPERCOP crypto_tbc/tem2512 encrypt", out512, want512, 64U);
    check_bytes_eq("SUPERCOP crypto_tbc/tem2512 decrypt", dec512, in512, 64U);

    areion_asura_encrypt_otf(want256, in256, k256, tw256);
    g_failures += supercop_asura256_encrypt(out256, in256, tw256, k256);
    g_failures += supercop_asura256_decrypt(dec256, out256, tw256, k256);
    check_bytes_eq("SUPERCOP crypto_tbc/asura256 encrypt", out256, want256, 32U);
    check_bytes_eq("SUPERCOP crypto_tbc/asura256 decrypt", dec256, in256, 32U);
}

static unsigned int popcount_u8(uint8_t x) {
    unsigned int c = 0;
    while (x != 0) {
        c += (unsigned int)(x & 1U);
        x = (uint8_t)((uint32_t)x >> 1U);
    }
    return c;
}

static void test_wideblock_bit_sensitivity(
    const uint8_t key256[64], const uint8_t m256[32],
    const uint8_t key512[128], const uint8_t m512[64]) {
    uint8_t mut_key256[64], out256[32], tw256[32], mut_tw256[32];
    uint8_t mut_key512[128], out512[64], tw512[64], mut_tw512[64];
    uint8_t b_em_e256[32], b_em_d256[32], b_em2_e256[32], b_em2_d256[32];
    uint8_t b_tem_e256[32], b_tem_d256[32], b_tem2_e256[32], b_tem2_d256[32];
    uint8_t b_em_e512[64], b_em_d512[64], b_em2_e512[64], b_em2_d512[64];
    uint8_t b_tem_e512[64], b_tem_d512[64], b_tem2_e512[64], b_tem2_d512[64];
    size_t byte_idx, bit_idx;

    fill_pattern(tw256, 32, 0x5AU);
    fill_pattern(tw512, 64, 0x6CU);

    areion_em_encrypt256(b_em_e256, key256, m256);
    areion_em_decrypt256(b_em_d256, key256, m256);
    areion_em2_encrypt256(b_em2_e256, key256, m256);
    areion_em2_decrypt256(b_em2_d256, key256, m256);
    areion_tem_encrypt256(b_tem_e256, key256, tw256, m256);
    areion_tem_decrypt256(b_tem_d256, key256, tw256, m256);
    areion_tem2_encrypt256(b_tem2_e256, key256, tw256, m256);
    areion_tem2_decrypt256(b_tem2_d256, key256, tw256, m256);

    for (byte_idx = 0; byte_idx < 64; byte_idx++) {
        for (bit_idx = 0; bit_idx < 8; bit_idx++) {
            memcpy(mut_key256, key256, 64);
            mut_key256[byte_idx] ^= (uint8_t)(1U << bit_idx);
            areion_em_encrypt256(out256, mut_key256, m256);
            if (memcmp(out256, b_em_e256, 32) == 0) { g_failures++; }
            areion_em_decrypt256(out256, mut_key256, m256);
            if (memcmp(out256, b_em_d256, 32) == 0) { g_failures++; }
            areion_em2_encrypt256(out256, mut_key256, m256);
            if (memcmp(out256, b_em2_e256, 32) == 0) { g_failures++; }
            areion_em2_decrypt256(out256, mut_key256, m256);
            if (memcmp(out256, b_em2_d256, 32) == 0) { g_failures++; }
            areion_tem_encrypt256(out256, mut_key256, tw256, m256);
            if (memcmp(out256, b_tem_e256, 32) == 0) { g_failures++; }
            areion_tem_decrypt256(out256, mut_key256, tw256, m256);
            if (memcmp(out256, b_tem_d256, 32) == 0) { g_failures++; }
            areion_tem2_encrypt256(out256, mut_key256, tw256, m256);
            if (memcmp(out256, b_tem2_e256, 32) == 0) { g_failures++; }
            areion_tem2_decrypt256(out256, mut_key256, tw256, m256);
            if (memcmp(out256, b_tem2_d256, 32) == 0) { g_failures++; }
        }
    }
    for (byte_idx = 0; byte_idx < 32; byte_idx++) {
        for (bit_idx = 0; bit_idx < 8; bit_idx++) {
            memcpy(mut_tw256, tw256, 32);
            mut_tw256[byte_idx] ^= (uint8_t)(1U << bit_idx);
            areion_tem_encrypt256(out256, key256, mut_tw256, m256);
            if (memcmp(out256, b_tem_e256, 32) == 0) { g_failures++; }
            areion_tem_decrypt256(out256, key256, mut_tw256, m256);
            if (memcmp(out256, b_tem_d256, 32) == 0) { g_failures++; }
            areion_tem2_encrypt256(out256, key256, mut_tw256, m256);
            if (memcmp(out256, b_tem2_e256, 32) == 0) { g_failures++; }
            areion_tem2_decrypt256(out256, key256, mut_tw256, m256);
            if (memcmp(out256, b_tem2_d256, 32) == 0) { g_failures++; }
        }
    }

    areion_em_encrypt512(b_em_e512, key512, m512);
    areion_em_decrypt512(b_em_d512, key512, m512);
    areion_em2_encrypt512(b_em2_e512, key512, m512);
    areion_em2_decrypt512(b_em2_d512, key512, m512);
    areion_tem_encrypt512(b_tem_e512, key512, tw512, m512);
    areion_tem_decrypt512(b_tem_d512, key512, tw512, m512);
    areion_tem2_encrypt512(b_tem2_e512, key512, tw512, m512);
    areion_tem2_decrypt512(b_tem2_d512, key512, tw512, m512);

    for (byte_idx = 0; byte_idx < 128; byte_idx++) {
        for (bit_idx = 0; bit_idx < 8; bit_idx++) {
            memcpy(mut_key512, key512, 128);
            mut_key512[byte_idx] ^= (uint8_t)(1U << bit_idx);
            areion_em_encrypt512(out512, mut_key512, m512);
            if (memcmp(out512, b_em_e512, 64) == 0) { g_failures++; }
            areion_em_decrypt512(out512, mut_key512, m512);
            if (memcmp(out512, b_em_d512, 64) == 0) { g_failures++; }
            areion_em2_encrypt512(out512, mut_key512, m512);
            if (memcmp(out512, b_em2_e512, 64) == 0) { g_failures++; }
            areion_em2_decrypt512(out512, mut_key512, m512);
            if (memcmp(out512, b_em2_d512, 64) == 0) { g_failures++; }
            areion_tem_encrypt512(out512, mut_key512, tw512, m512);
            if (memcmp(out512, b_tem_e512, 64) == 0) { g_failures++; }
            areion_tem_decrypt512(out512, mut_key512, tw512, m512);
            if (memcmp(out512, b_tem_d512, 64) == 0) { g_failures++; }
            areion_tem2_encrypt512(out512, mut_key512, tw512, m512);
            if (memcmp(out512, b_tem2_e512, 64) == 0) { g_failures++; }
            areion_tem2_decrypt512(out512, mut_key512, tw512, m512);
            if (memcmp(out512, b_tem2_d512, 64) == 0) { g_failures++; }
        }
    }
    for (byte_idx = 0; byte_idx < 64; byte_idx++) {
        for (bit_idx = 0; bit_idx < 8; bit_idx++) {
            memcpy(mut_tw512, tw512, 64);
            mut_tw512[byte_idx] ^= (uint8_t)(1U << bit_idx);
            areion_tem_encrypt512(out512, key512, mut_tw512, m512);
            if (memcmp(out512, b_tem_e512, 64) == 0) { g_failures++; }
            areion_tem_decrypt512(out512, key512, mut_tw512, m512);
            if (memcmp(out512, b_tem_d512, 64) == 0) { g_failures++; }
            areion_tem2_encrypt512(out512, key512, mut_tw512, m512);
            if (memcmp(out512, b_tem2_e512, 64) == 0) { g_failures++; }
            areion_tem2_decrypt512(out512, key512, mut_tw512, m512);
            if (memcmp(out512, b_tem2_d512, 64) == 0) { g_failures++; }
        }
    }
}

static void test_cryptographic_properties(void) {
    uint8_t key256[64], mut_key256[64], m256[32], m256_shift[32], base256[32], out256[32];
    uint8_t key512[128], mut_key512[128], m512[64], m512_shift[64], base512[64], out512[64];
    size_t byte_idx, bit_idx, i;
    unsigned int total_flips, tests;
    double avg_flips;

    /* 1. Key-slot bit sensitivity (all 512 bits of SoEM256 and all 1024 bits of SoEM512) */
    fill_pattern(key256, 64, 0x17U);
    fill_pattern(m256, 32, 0x29U);
    areion_soem256(base256, key256, m256);
    for (byte_idx = 0; byte_idx < 64; byte_idx++) {
        for (bit_idx = 0; bit_idx < 8; bit_idx++) {
            memcpy(mut_key256, key256, 64);
            mut_key256[byte_idx] ^= (uint8_t)(1U << bit_idx);
            areion_soem256(out256, mut_key256, m256);
            if (memcmp(out256, base256, 32) == 0) {
                (void)fprintf(stderr, "FAIL: SoEM256 invariant to key bit flip at byte %u bit %u\n",
                        (unsigned)byte_idx, (unsigned)bit_idx);
                g_failures++;
            }
        }
    }

    fill_pattern(key512, 128, 0x3BU);
    fill_pattern(m512, 64, 0x4DU);
    areion_soem512(base512, key512, m512);
    for (byte_idx = 0; byte_idx < 128; byte_idx++) {
        for (bit_idx = 0; bit_idx < 8; bit_idx++) {
            memcpy(mut_key512, key512, 128);
            mut_key512[byte_idx] ^= (uint8_t)(1U << bit_idx);
            areion_soem512(out512, mut_key512, m512);
            if (memcmp(out512, base512, 64) == 0) {
                (void)fprintf(stderr, "FAIL: SoEM512 invariant to key bit flip at byte %u bit %u\n",
                        (unsigned)byte_idx, (unsigned)bit_idx);
                g_failures++;
            }
        }
    }

    /* 1b. Key and tweak bit-flip sensitivity for EM, EM2, TEM, TEM2 (256 & 512, encrypt & decrypt) */
    test_wideblock_bit_sensitivity(key256, m256, key512, m512);

    /* 2. Shift-symmetry & subkey-swap non-symmetry (P1 != P2) */
    for (i = 0; i < 32; i++) {
        m256_shift[i] = (uint8_t)((uint32_t)m256[i] ^ (uint32_t)key256[i] ^ (uint32_t)key256[32 + i]);
    }
    areion_soem256(out256, key256, m256_shift);
    if (memcmp(out256, base256, 32) == 0) {
        (void)fprintf(stderr, "FAIL: SoEM256 exhibits shift symmetry F(m) == F(m ^ k1 ^ k2)\n");
        g_failures++;
    }
    memcpy(mut_key256, &key256[32], 32);
    memcpy(&mut_key256[32], key256, 32);
    areion_soem256(out256, mut_key256, m256);
    if (memcmp(out256, base256, 32) == 0) {
        (void)fprintf(stderr, "FAIL: SoEM256 invariant under subkey swap k1 <-> k2\n");
        g_failures++;
    }

    for (i = 0; i < 64; i++) {
        m512_shift[i] = (uint8_t)((uint32_t)m512[i] ^ (uint32_t)key512[i] ^ (uint32_t)key512[64 + i]);
    }
    areion_soem512(out512, key512, m512_shift);
    if (memcmp(out512, base512, 64) == 0) {
        (void)fprintf(stderr, "FAIL: SoEM512 exhibits shift symmetry F(m) == F(m ^ k1 ^ k2)\n");
        g_failures++;
    }
    memcpy(mut_key512, &key512[64], 64);
    memcpy(&mut_key512[64], key512, 64);
    areion_soem512(out512, mut_key512, m512);
    if (memcmp(out512, base512, 64) == 0) {
        (void)fprintf(stderr, "FAIL: SoEM512 invariant under subkey swap k1 <-> k2\n");
        g_failures++;
    }

    /* 2b. Shift-symmetry, subkey-swap asymmetry, and tweak/message asymmetry for EM, EM2, TEM, TEM2 */
    {
        uint8_t tw256[32], tw512[64];
        uint8_t swap_k256[64], swap_k512[128];
        uint8_t b256_a[32], b256_b[32], b512_a[64], b512_b[64];

        fill_pattern(tw256, 32, 0x5AU);
        fill_pattern(tw512, 64, 0x6CU);
        memcpy(swap_k256, &key256[32], 32);
        memcpy(&swap_k256[32], key256, 32);
        memcpy(swap_k512, &key512[64], 64);
        memcpy(&swap_k512[64], key512, 64);

        /* EM-256 & EM-512 Encrypt / Decrypt */
        areion_em_encrypt256(b256_a, key256, m256);
        areion_em_encrypt256(b256_b, key256, m256_shift);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: EMEncrypt256 shift symmetry\n");
            g_failures++;
        }
        areion_em_encrypt256(b256_b, swap_k256, m256);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: EMEncrypt256 subkey-swap symmetry\n");
            g_failures++;
        }
        areion_em_decrypt256(b256_a, key256, m256);
        areion_em_decrypt256(b256_b, key256, m256_shift);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: EMDecrypt256 shift symmetry\n");
            g_failures++;
        }
        areion_em_decrypt256(b256_b, swap_k256, m256);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: EMDecrypt256 subkey-swap symmetry\n");
            g_failures++;
        }

        areion_em_encrypt512(b512_a, key512, m512);
        areion_em_encrypt512(b512_b, key512, m512_shift);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: EMEncrypt512 shift symmetry\n");
            g_failures++;
        }
        areion_em_encrypt512(b512_b, swap_k512, m512);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: EMEncrypt512 subkey-swap symmetry\n");
            g_failures++;
        }
        areion_em_decrypt512(b512_a, key512, m512);
        areion_em_decrypt512(b512_b, key512, m512_shift);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: EMDecrypt512 shift symmetry\n");
            g_failures++;
        }
        areion_em_decrypt512(b512_b, swap_k512, m512);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: EMDecrypt512 subkey-swap symmetry\n");
            g_failures++;
        }

        /* EM2-256 & EM2-512 Encrypt / Decrypt */
        areion_em2_encrypt256(b256_a, key256, m256);
        areion_em2_encrypt256(b256_b, key256, m256_shift);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: EM2Encrypt256 shift symmetry\n");
            g_failures++;
        }
        areion_em2_encrypt256(b256_b, swap_k256, m256);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: EM2Encrypt256 subkey-swap symmetry\n");
            g_failures++;
        }
        areion_em2_decrypt256(b256_a, key256, m256);
        areion_em2_decrypt256(b256_b, key256, m256_shift);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: EM2Decrypt256 shift symmetry\n");
            g_failures++;
        }
        areion_em2_decrypt256(b256_b, swap_k256, m256);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: EM2Decrypt256 subkey-swap symmetry\n");
            g_failures++;
        }

        areion_em2_encrypt512(b512_a, key512, m512);
        areion_em2_encrypt512(b512_b, key512, m512_shift);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: EM2Encrypt512 shift symmetry\n");
            g_failures++;
        }
        areion_em2_encrypt512(b512_b, swap_k512, m512);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: EM2Encrypt512 subkey-swap symmetry\n");
            g_failures++;
        }
        areion_em2_decrypt512(b512_a, key512, m512);
        areion_em2_decrypt512(b512_b, key512, m512_shift);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: EM2Decrypt512 shift symmetry\n");
            g_failures++;
        }
        areion_em2_decrypt512(b512_b, swap_k512, m512);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: EM2Decrypt512 subkey-swap symmetry\n");
            g_failures++;
        }

        /* TEM-256 & TEM-512 Encrypt / Decrypt + Tweak/Message asymmetry */
        areion_tem_encrypt256(b256_a, key256, tw256, m256);
        areion_tem_encrypt256(b256_b, key256, tw256, m256_shift);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: TEMEncrypt256 shift symmetry\n");
            g_failures++;
        }
        areion_tem_encrypt256(b256_b, swap_k256, tw256, m256);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: TEMEncrypt256 subkey-swap symmetry\n");
            g_failures++;
        }
        areion_tem_encrypt256(b256_b, key256, m256, tw256);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: TEMEncrypt256 tweak/message symmetry\n");
            g_failures++;
        }
        areion_tem_decrypt256(b256_a, key256, tw256, m256);
        areion_tem_decrypt256(b256_b, key256, tw256, m256_shift);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: TEMDecrypt256 shift symmetry\n");
            g_failures++;
        }
        areion_tem_decrypt256(b256_b, swap_k256, tw256, m256);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: TEMDecrypt256 subkey-swap symmetry\n");
            g_failures++;
        }
        areion_tem_decrypt256(b256_b, key256, m256, tw256);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: TEMDecrypt256 tweak/message symmetry\n");
            g_failures++;
        }

        areion_tem_encrypt512(b512_a, key512, tw512, m512);
        areion_tem_encrypt512(b512_b, key512, tw512, m512_shift);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: TEMEncrypt512 shift symmetry\n");
            g_failures++;
        }
        areion_tem_encrypt512(b512_b, swap_k512, tw512, m512);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: TEMEncrypt512 subkey-swap symmetry\n");
            g_failures++;
        }
        areion_tem_encrypt512(b512_b, key512, m512, tw512);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: TEMEncrypt512 tweak/message symmetry\n");
            g_failures++;
        }
        areion_tem_decrypt512(b512_a, key512, tw512, m512);
        areion_tem_decrypt512(b512_b, key512, tw512, m512_shift);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: TEMDecrypt512 shift symmetry\n");
            g_failures++;
        }
        areion_tem_decrypt512(b512_b, swap_k512, tw512, m512);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: TEMDecrypt512 subkey-swap symmetry\n");
            g_failures++;
        }
        areion_tem_decrypt512(b512_b, key512, m512, tw512);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: TEMDecrypt512 tweak/message symmetry\n");
            g_failures++;
        }

        /* TEM2-256 & TEM2-512 Encrypt / Decrypt + Tweak/Message asymmetry */
        areion_tem2_encrypt256(b256_a, key256, tw256, m256);
        areion_tem2_encrypt256(b256_b, key256, tw256, m256_shift);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: TEM2Encrypt256 shift symmetry\n");
            g_failures++;
        }
        areion_tem2_encrypt256(b256_b, swap_k256, tw256, m256);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: TEM2Encrypt256 subkey-swap symmetry\n");
            g_failures++;
        }
        areion_tem2_encrypt256(b256_b, key256, m256, tw256);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: TEM2Encrypt256 tweak/message symmetry\n");
            g_failures++;
        }
        areion_tem2_decrypt256(b256_a, key256, tw256, m256);
        areion_tem2_decrypt256(b256_b, key256, tw256, m256_shift);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: TEM2Decrypt256 shift symmetry\n");
            g_failures++;
        }
        areion_tem2_decrypt256(b256_b, swap_k256, tw256, m256);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: TEM2Decrypt256 subkey-swap symmetry\n");
            g_failures++;
        }
        areion_tem2_decrypt256(b256_b, key256, m256, tw256);
        if (memcmp(b256_a, b256_b, 32) == 0) {
            (void)fprintf(stderr, "FAIL: TEM2Decrypt256 tweak/message symmetry\n");
            g_failures++;
        }

        areion_tem2_encrypt512(b512_a, key512, tw512, m512);
        areion_tem2_encrypt512(b512_b, key512, tw512, m512_shift);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: TEM2Encrypt512 shift symmetry\n");
            g_failures++;
        }
        areion_tem2_encrypt512(b512_b, swap_k512, tw512, m512);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: TEM2Encrypt512 subkey-swap symmetry\n");
            g_failures++;
        }
        areion_tem2_encrypt512(b512_b, key512, m512, tw512);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: TEM2Encrypt512 tweak/message symmetry\n");
            g_failures++;
        }
        areion_tem2_decrypt512(b512_a, key512, tw512, m512);
        areion_tem2_decrypt512(b512_b, key512, tw512, m512_shift);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: TEM2Decrypt512 shift symmetry\n");
            g_failures++;
        }
        areion_tem2_decrypt512(b512_b, swap_k512, tw512, m512);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: TEM2Decrypt512 subkey-swap symmetry\n");
            g_failures++;
        }
        areion_tem2_decrypt512(b512_b, key512, m512, tw512);
        if (memcmp(b512_a, b512_b, 64) == 0) {
            (void)fprintf(stderr, "FAIL: TEM2Decrypt512 tweak/message symmetry\n");
            g_failures++;
        }
    }

    /* 3. Strict Avalanche Criterion on Permute256 and Permute512 */
    memcpy(base256, m256, 32);
    areion_permute256(base256);
    total_flips = 0;
    tests = 0;
    for (byte_idx = 0; byte_idx < 32; byte_idx++) {
        for (bit_idx = 0; bit_idx < 8; bit_idx++) {
            memcpy(out256, m256, 32);
            out256[byte_idx] ^= (uint8_t)(1U << bit_idx);
            areion_permute256(out256);
            for (i = 0; i < 32; i++) {
                total_flips += popcount_u8((uint8_t)(base256[i] ^ out256[i]));
            }
            tests++;
        }
    }
    avg_flips = (double)total_flips / (double)tests;
    if (avg_flips < 100.0 || avg_flips > 156.0) {
        (void)fprintf(stderr, "FAIL: Permute256 avalanche avg=%.2f outside [100, 156]\n", avg_flips);
        g_failures++;
    }

    memcpy(base512, m512, 64);
    areion_permute512(base512);
    total_flips = 0;
    tests = 0;
    for (byte_idx = 0; byte_idx < 64; byte_idx++) {
        for (bit_idx = 0; bit_idx < 8; bit_idx++) {
            memcpy(out512, m512, 64);
            out512[byte_idx] ^= (uint8_t)(1U << bit_idx);
            areion_permute512(out512);
            for (i = 0; i < 64; i++) {
                total_flips += popcount_u8((uint8_t)(base512[i] ^ out512[i]));
            }
            tests++;
        }
    }
    avg_flips = (double)total_flips / (double)tests;
    if (avg_flips < 200.0 || avg_flips > 312.0) {
        (void)fprintf(stderr, "FAIL: Permute512 avalanche avg=%.2f outside [200, 312]\n", avg_flips);
        g_failures++;
    }

    /* 4. Non-affinity: f(a) ^ f(b) ^ f(c) ^ f(a ^ b ^ c) != 0 */
    {
        uint8_t a256[32], b256_in[32], c256[32], abc256[32], tw256[32];
        uint8_t fa256[32], fb256[32], fc256[32], fabc256[32];
        uint8_t a512[64], b512_in[64], c512[64], abc512[64], tw512[64];
        uint8_t fa512[64], fb512[64], fc512[64], fabc512[64];
        size_t trial;
        fill_pattern(tw256, 32, 0x71U);
        fill_pattern(tw512, 64, 0x82U);
        for (trial = 0; trial < 20; trial++) {
            int nz_soem256 = 0, nz_dm256 = 0, nz_soem512 = 0, nz_dm512 = 0;
            int nz_em_e256 = 0, nz_em_d256 = 0, nz_em2_e256 = 0, nz_em2_d256 = 0;
            int nz_tem_e256 = 0, nz_tem_d256 = 0, nz_tem2_e256 = 0, nz_tem2_d256 = 0;
            int nz_tem_tw_e256 = 0, nz_tem_tw_d256 = 0, nz_tem2_tw_e256 = 0, nz_tem2_tw_d256 = 0;
            int nz_em_e512 = 0, nz_em_d512 = 0, nz_em2_e512 = 0, nz_em2_d512 = 0;
            int nz_tem_e512 = 0, nz_tem_d512 = 0, nz_tem2_e512 = 0, nz_tem2_d512 = 0;
            int nz_tem_tw_e512 = 0, nz_tem_tw_d512 = 0, nz_tem2_tw_e512 = 0, nz_tem2_tw_d512 = 0;
            fill_pattern(a256, 32, (uint8_t)(0x10U + trial * 3U));
            fill_pattern(b256_in, 32, (uint8_t)(0x11U + trial * 3U));
            fill_pattern(c256, 32, (uint8_t)(0x12U + trial * 3U));
            for (i = 0; i < 32; i++) {
                abc256[i] = (uint8_t)((uint32_t)a256[i] ^ (uint32_t)b256_in[i] ^ (uint32_t)c256[i]);
            }
            areion_soem256(fa256, key256, a256);
            areion_soem256(fb256, key256, b256_in);
            areion_soem256(fc256, key256, c256);
            areion_soem256(fabc256, key256, abc256);
            for (i = 0; i < 32; i++) {
                if (((uint32_t)fa256[i] ^ (uint32_t)fb256[i] ^ (uint32_t)fc256[i] ^ (uint32_t)fabc256[i]) != 0U) {
                    nz_soem256 = 1;
                }
            }
            areion_dm256(fa256, a256);
            areion_dm256(fb256, b256_in);
            areion_dm256(fc256, c256);
            areion_dm256(fabc256, abc256);
            for (i = 0; i < 32; i++) {
                if (((uint32_t)fa256[i] ^ (uint32_t)fb256[i] ^ (uint32_t)fc256[i] ^ (uint32_t)fabc256[i]) != 0U) {
                    nz_dm256 = 1;
                }
            }
            areion_em_encrypt256(fa256, key256, a256);
            areion_em_encrypt256(fb256, key256, b256_in);
            areion_em_encrypt256(fc256, key256, c256);
            areion_em_encrypt256(fabc256, key256, abc256);
            for (i = 0; i < 32; i++) {
                if (((uint32_t)fa256[i] ^ (uint32_t)fb256[i] ^ (uint32_t)fc256[i] ^ (uint32_t)fabc256[i]) != 0U) {
                    nz_em_e256 = 1;
                }
            }
            areion_em_decrypt256(fa256, key256, a256);
            areion_em_decrypt256(fb256, key256, b256_in);
            areion_em_decrypt256(fc256, key256, c256);
            areion_em_decrypt256(fabc256, key256, abc256);
            for (i = 0; i < 32; i++) {
                if (((uint32_t)fa256[i] ^ (uint32_t)fb256[i] ^ (uint32_t)fc256[i] ^ (uint32_t)fabc256[i]) != 0U) {
                    nz_em_d256 = 1;
                }
            }
            areion_em2_encrypt256(fa256, key256, a256);
            areion_em2_encrypt256(fb256, key256, b256_in);
            areion_em2_encrypt256(fc256, key256, c256);
            areion_em2_encrypt256(fabc256, key256, abc256);
            for (i = 0; i < 32; i++) {
                if (((uint32_t)fa256[i] ^ (uint32_t)fb256[i] ^ (uint32_t)fc256[i] ^ (uint32_t)fabc256[i]) != 0U) {
                    nz_em2_e256 = 1;
                }
            }
            areion_em2_decrypt256(fa256, key256, a256);
            areion_em2_decrypt256(fb256, key256, b256_in);
            areion_em2_decrypt256(fc256, key256, c256);
            areion_em2_decrypt256(fabc256, key256, abc256);
            for (i = 0; i < 32; i++) {
                if (((uint32_t)fa256[i] ^ (uint32_t)fb256[i] ^ (uint32_t)fc256[i] ^ (uint32_t)fabc256[i]) != 0U) {
                    nz_em2_d256 = 1;
                }
            }
            areion_tem_encrypt256(fa256, key256, tw256, a256);
            areion_tem_encrypt256(fb256, key256, tw256, b256_in);
            areion_tem_encrypt256(fc256, key256, tw256, c256);
            areion_tem_encrypt256(fabc256, key256, tw256, abc256);
            for (i = 0; i < 32; i++) {
                if (((uint32_t)fa256[i] ^ (uint32_t)fb256[i] ^ (uint32_t)fc256[i] ^ (uint32_t)fabc256[i]) != 0U) {
                    nz_tem_e256 = 1;
                }
            }
            areion_tem_decrypt256(fa256, key256, tw256, a256);
            areion_tem_decrypt256(fb256, key256, tw256, b256_in);
            areion_tem_decrypt256(fc256, key256, tw256, c256);
            areion_tem_decrypt256(fabc256, key256, tw256, abc256);
            for (i = 0; i < 32; i++) {
                if (((uint32_t)fa256[i] ^ (uint32_t)fb256[i] ^ (uint32_t)fc256[i] ^ (uint32_t)fabc256[i]) != 0U) {
                    nz_tem_d256 = 1;
                }
            }
            areion_tem2_encrypt256(fa256, key256, tw256, a256);
            areion_tem2_encrypt256(fb256, key256, tw256, b256_in);
            areion_tem2_encrypt256(fc256, key256, tw256, c256);
            areion_tem2_encrypt256(fabc256, key256, tw256, abc256);
            for (i = 0; i < 32; i++) {
                if (((uint32_t)fa256[i] ^ (uint32_t)fb256[i] ^ (uint32_t)fc256[i] ^ (uint32_t)fabc256[i]) != 0U) {
                    nz_tem2_e256 = 1;
                }
            }
            areion_tem2_decrypt256(fa256, key256, tw256, a256);
            areion_tem2_decrypt256(fb256, key256, tw256, b256_in);
            areion_tem2_decrypt256(fc256, key256, tw256, c256);
            areion_tem2_decrypt256(fabc256, key256, tw256, abc256);
            for (i = 0; i < 32; i++) {
                if (((uint32_t)fa256[i] ^ (uint32_t)fb256[i] ^ (uint32_t)fc256[i] ^ (uint32_t)fabc256[i]) != 0U) {
                    nz_tem2_d256 = 1;
                }
            }
            /* Tweak non-affinity for TEM/TEM2-256 */
            areion_tem_encrypt256(fa256, key256, a256, m256);
            areion_tem_encrypt256(fb256, key256, b256_in, m256);
            areion_tem_encrypt256(fc256, key256, c256, m256);
            areion_tem_encrypt256(fabc256, key256, abc256, m256);
            for (i = 0; i < 32; i++) {
                if (((uint32_t)fa256[i] ^ (uint32_t)fb256[i] ^ (uint32_t)fc256[i] ^ (uint32_t)fabc256[i]) != 0U) {
                    nz_tem_tw_e256 = 1;
                }
            }
            areion_tem_decrypt256(fa256, key256, a256, m256);
            areion_tem_decrypt256(fb256, key256, b256_in, m256);
            areion_tem_decrypt256(fc256, key256, c256, m256);
            areion_tem_decrypt256(fabc256, key256, abc256, m256);
            for (i = 0; i < 32; i++) {
                if (((uint32_t)fa256[i] ^ (uint32_t)fb256[i] ^ (uint32_t)fc256[i] ^ (uint32_t)fabc256[i]) != 0U) {
                    nz_tem_tw_d256 = 1;
                }
            }
            areion_tem2_encrypt256(fa256, key256, a256, m256);
            areion_tem2_encrypt256(fb256, key256, b256_in, m256);
            areion_tem2_encrypt256(fc256, key256, c256, m256);
            areion_tem2_encrypt256(fabc256, key256, abc256, m256);
            for (i = 0; i < 32; i++) {
                if (((uint32_t)fa256[i] ^ (uint32_t)fb256[i] ^ (uint32_t)fc256[i] ^ (uint32_t)fabc256[i]) != 0U) {
                    nz_tem2_tw_e256 = 1;
                }
            }
            areion_tem2_decrypt256(fa256, key256, a256, m256);
            areion_tem2_decrypt256(fb256, key256, b256_in, m256);
            areion_tem2_decrypt256(fc256, key256, c256, m256);
            areion_tem2_decrypt256(fabc256, key256, abc256, m256);
            for (i = 0; i < 32; i++) {
                if (((uint32_t)fa256[i] ^ (uint32_t)fb256[i] ^ (uint32_t)fc256[i] ^ (uint32_t)fabc256[i]) != 0U) {
                    nz_tem2_tw_d256 = 1;
                }
            }

            fill_pattern(a512, 64, (uint8_t)(0x50U + trial * 3U));
            fill_pattern(b512_in, 64, (uint8_t)(0x51U + trial * 3U));
            fill_pattern(c512, 64, (uint8_t)(0x52U + trial * 3U));
            for (i = 0; i < 64; i++) {
                abc512[i] = (uint8_t)((uint32_t)a512[i] ^ (uint32_t)b512_in[i] ^ (uint32_t)c512[i]);
            }
            areion_soem512(fa512, key512, a512);
            areion_soem512(fb512, key512, b512_in);
            areion_soem512(fc512, key512, c512);
            areion_soem512(fabc512, key512, abc512);
            for (i = 0; i < 64; i++) {
                if (((uint32_t)fa512[i] ^ (uint32_t)fb512[i] ^ (uint32_t)fc512[i] ^ (uint32_t)fabc512[i]) != 0U) {
                    nz_soem512 = 1;
                }
            }
            areion_dm512(fa256, a512);
            areion_dm512(fb256, b512_in);
            areion_dm512(fc256, c512);
            areion_dm512(fabc256, abc512);
            for (i = 0; i < 32; i++) {
                if (((uint32_t)fa256[i] ^ (uint32_t)fb256[i] ^ (uint32_t)fc256[i] ^ (uint32_t)fabc256[i]) != 0U) {
                    nz_dm512 = 1;
                }
            }
            areion_em_encrypt512(fa512, key512, a512);
            areion_em_encrypt512(fb512, key512, b512_in);
            areion_em_encrypt512(fc512, key512, c512);
            areion_em_encrypt512(fabc512, key512, abc512);
            for (i = 0; i < 64; i++) {
                if (((uint32_t)fa512[i] ^ (uint32_t)fb512[i] ^ (uint32_t)fc512[i] ^ (uint32_t)fabc512[i]) != 0U) {
                    nz_em_e512 = 1;
                }
            }
            areion_em_decrypt512(fa512, key512, a512);
            areion_em_decrypt512(fb512, key512, b512_in);
            areion_em_decrypt512(fc512, key512, c512);
            areion_em_decrypt512(fabc512, key512, abc512);
            for (i = 0; i < 64; i++) {
                if (((uint32_t)fa512[i] ^ (uint32_t)fb512[i] ^ (uint32_t)fc512[i] ^ (uint32_t)fabc512[i]) != 0U) {
                    nz_em_d512 = 1;
                }
            }
            areion_em2_encrypt512(fa512, key512, a512);
            areion_em2_encrypt512(fb512, key512, b512_in);
            areion_em2_encrypt512(fc512, key512, c512);
            areion_em2_encrypt512(fabc512, key512, abc512);
            for (i = 0; i < 64; i++) {
                if (((uint32_t)fa512[i] ^ (uint32_t)fb512[i] ^ (uint32_t)fc512[i] ^ (uint32_t)fabc512[i]) != 0U) {
                    nz_em2_e512 = 1;
                }
            }
            areion_em2_decrypt512(fa512, key512, a512);
            areion_em2_decrypt512(fb512, key512, b512_in);
            areion_em2_decrypt512(fc512, key512, c512);
            areion_em2_decrypt512(fabc512, key512, abc512);
            for (i = 0; i < 64; i++) {
                if (((uint32_t)fa512[i] ^ (uint32_t)fb512[i] ^ (uint32_t)fc512[i] ^ (uint32_t)fabc512[i]) != 0U) {
                    nz_em2_d512 = 1;
                }
            }
            areion_tem_encrypt512(fa512, key512, tw512, a512);
            areion_tem_encrypt512(fb512, key512, tw512, b512_in);
            areion_tem_encrypt512(fc512, key512, tw512, c512);
            areion_tem_encrypt512(fabc512, key512, tw512, abc512);
            for (i = 0; i < 64; i++) {
                if (((uint32_t)fa512[i] ^ (uint32_t)fb512[i] ^ (uint32_t)fc512[i] ^ (uint32_t)fabc512[i]) != 0U) {
                    nz_tem_e512 = 1;
                }
            }
            areion_tem_decrypt512(fa512, key512, tw512, a512);
            areion_tem_decrypt512(fb512, key512, tw512, b512_in);
            areion_tem_decrypt512(fc512, key512, tw512, c512);
            areion_tem_decrypt512(fabc512, key512, tw512, abc512);
            for (i = 0; i < 64; i++) {
                if (((uint32_t)fa512[i] ^ (uint32_t)fb512[i] ^ (uint32_t)fc512[i] ^ (uint32_t)fabc512[i]) != 0U) {
                    nz_tem_d512 = 1;
                }
            }
            areion_tem2_encrypt512(fa512, key512, tw512, a512);
            areion_tem2_encrypt512(fb512, key512, tw512, b512_in);
            areion_tem2_encrypt512(fc512, key512, tw512, c512);
            areion_tem2_encrypt512(fabc512, key512, tw512, abc512);
            for (i = 0; i < 64; i++) {
                if (((uint32_t)fa512[i] ^ (uint32_t)fb512[i] ^ (uint32_t)fc512[i] ^ (uint32_t)fabc512[i]) != 0U) {
                    nz_tem2_e512 = 1;
                }
            }
            areion_tem2_decrypt512(fa512, key512, tw512, a512);
            areion_tem2_decrypt512(fb512, key512, tw512, b512_in);
            areion_tem2_decrypt512(fc512, key512, tw512, c512);
            areion_tem2_decrypt512(fabc512, key512, tw512, abc512);
            for (i = 0; i < 64; i++) {
                if (((uint32_t)fa512[i] ^ (uint32_t)fb512[i] ^ (uint32_t)fc512[i] ^ (uint32_t)fabc512[i]) != 0U) {
                    nz_tem2_d512 = 1;
                }
            }
            /* Tweak non-affinity for TEM/TEM2-512 */
            areion_tem_encrypt512(fa512, key512, a512, m512);
            areion_tem_encrypt512(fb512, key512, b512_in, m512);
            areion_tem_encrypt512(fc512, key512, c512, m512);
            areion_tem_encrypt512(fabc512, key512, abc512, m512);
            for (i = 0; i < 64; i++) {
                if (((uint32_t)fa512[i] ^ (uint32_t)fb512[i] ^ (uint32_t)fc512[i] ^ (uint32_t)fabc512[i]) != 0U) {
                    nz_tem_tw_e512 = 1;
                }
            }
            areion_tem_decrypt512(fa512, key512, a512, m512);
            areion_tem_decrypt512(fb512, key512, b512_in, m512);
            areion_tem_decrypt512(fc512, key512, c512, m512);
            areion_tem_decrypt512(fabc512, key512, abc512, m512);
            for (i = 0; i < 64; i++) {
                if (((uint32_t)fa512[i] ^ (uint32_t)fb512[i] ^ (uint32_t)fc512[i] ^ (uint32_t)fabc512[i]) != 0U) {
                    nz_tem_tw_d512 = 1;
                }
            }
            areion_tem2_encrypt512(fa512, key512, a512, m512);
            areion_tem2_encrypt512(fb512, key512, b512_in, m512);
            areion_tem2_encrypt512(fc512, key512, c512, m512);
            areion_tem2_encrypt512(fabc512, key512, abc512, m512);
            for (i = 0; i < 64; i++) {
                if (((uint32_t)fa512[i] ^ (uint32_t)fb512[i] ^ (uint32_t)fc512[i] ^ (uint32_t)fabc512[i]) != 0U) {
                    nz_tem2_tw_e512 = 1;
                }
            }
            areion_tem2_decrypt512(fa512, key512, a512, m512);
            areion_tem2_decrypt512(fb512, key512, b512_in, m512);
            areion_tem2_decrypt512(fc512, key512, c512, m512);
            areion_tem2_decrypt512(fabc512, key512, abc512, m512);
            for (i = 0; i < 64; i++) {
                if (((uint32_t)fa512[i] ^ (uint32_t)fb512[i] ^ (uint32_t)fc512[i] ^ (uint32_t)fabc512[i]) != 0U) {
                    nz_tem2_tw_d512 = 1;
                }
            }
            if (!nz_soem256 || !nz_dm256 || !nz_soem512 || !nz_dm512 ||
                !nz_em_e256 || !nz_em_d256 || !nz_em2_e256 || !nz_em2_d256 ||
                !nz_tem_e256 || !nz_tem_d256 || !nz_tem2_e256 || !nz_tem2_d256 ||
                !nz_tem_tw_e256 || !nz_tem_tw_d256 || !nz_tem2_tw_e256 || !nz_tem2_tw_d256 ||
                !nz_em_e512 || !nz_em_d512 || !nz_em2_e512 || !nz_em2_d512 ||
                !nz_tem_e512 || !nz_tem_d512 || !nz_tem2_e512 || !nz_tem2_d512 ||
                !nz_tem_tw_e512 || !nz_tem_tw_d512 || !nz_tem2_tw_e512 || !nz_tem2_tw_d512) {
                (void)fprintf(stderr, "FAIL: non-affinity check failed at trial %u\n", (unsigned)trial);
                g_failures++;
            }
        }
    }

    /* 5. Edge-case patterns: all-0x00, all-0xFF, 0x55, 0xAA, Hamming weight 1 and n-1 */
    {
        static const uint8_t fill_vals[4] = {0x00U, 0xFFU, 0x55U, 0xAAU};
        size_t p;
        for (p = 0; p < 6; p++) {
            uint8_t pat256[32], pat512[64], tmp256[32], tmp512[64];
            if (p < 4) {
                memset(pat256, fill_vals[p], 32);
                memset(pat512, fill_vals[p], 64);
            } else if (p == 4) {
                memset(pat256, 0, 32);
                pat256[0] = 1U;
                memset(pat512, 0, 64);
                pat512[0] = 1U;
            } else {
                memset(pat256, 0xFFU, 32);
                pat256[31] = 0xFEU;
                memset(pat512, 0xFFU, 64);
                pat512[63] = 0xFEU;
            }
            memcpy(tmp256, pat256, 32);
            areion_permute256(tmp256);
            if (memcmp(tmp256, pat256, 32) == 0) {
                (void)fprintf(stderr, "FAIL: Permute256 fixed point on edge case %u\n", (unsigned)p);
                g_failures++;
            }
            areion_inverse_permute256(tmp256);
            check_bytes_eq("EdgeCase InversePermute256", tmp256, pat256, 32);

            memcpy(tmp256, pat256, 32);
            areion_permute256_p2(tmp256);
            areion_inverse_permute256_p2(tmp256);
            check_bytes_eq("EdgeCase InversePermute256P2", tmp256, pat256, 32);

            memcpy(tmp512, pat512, 64);
            areion_permute512(tmp512);
            if (memcmp(tmp512, pat512, 64) == 0) {
                (void)fprintf(stderr, "FAIL: Permute512 fixed point on edge case %u\n", (unsigned)p);
                g_failures++;
            }
            areion_inverse_permute512(tmp512);
            check_bytes_eq("EdgeCase InversePermute512", tmp512, pat512, 64);

            memcpy(tmp512, pat512, 64);
            areion_permute512_p2(tmp512);
            areion_inverse_permute512_p2(tmp512);
            check_bytes_eq("EdgeCase InversePermute512P2", tmp512, pat512, 64);
        }
    }
}

/* =========================================================================
 * Cross-Language KAT Dump Mode (--dump-kat [tier]) & Pairwise Tier Matrix
 * ========================================================================= */

#define AREION_KAT_ENTRY_COUNT 98U

typedef struct {
    const char *name;
    size_t len;
    uint8_t data[512];
} kat_entry_t;

typedef struct {
    const char *tier_name;
    areion_tier_t tier_code;
    size_t count;
    kat_entry_t entries[AREION_KAT_ENTRY_COUNT];
} kat_suite_t;

static kat_suite_t *g_kat_capture = NULL;
static kat_suite_t g_tier_kats[6];

static void record_kat(const char *name, const uint8_t *buf, size_t len) {
    if (g_kat_capture != NULL) {
        if (g_kat_capture->count < AREION_KAT_ENTRY_COUNT && len <= sizeof(g_kat_capture->entries[0].data)) {
            kat_entry_t *e = &g_kat_capture->entries[g_kat_capture->count++];
            e->name = name;
            e->len = len;
            memcpy(e->data, buf, len);
        } else {
            g_failures++;
        }
    } else {
        print_hex(name, buf, len);
    }
}

static int dump_kat_for_tier(const char *tier_arg) {
    uint8_t s256[32], s512[64], key256[64], key512[128], out256[32], out512[64];
    uint8_t keys256x4[4][64], keys512x4[4][128];
    uint8_t in256x4[4][32], in512x4[4][64];
    uint8_t out256x4[4][32], out512x4[4][64];
    uint8_t b256[4][32], b512[4][64];
    uint32_t rw_in[4] = {0x01234567U, 0x89abcdefU, 0xfedcba98U, 0x76543210U};
    uint32_t rw_out[4];
    uint8_t rw_bytes[16];
    uint8_t ab[4][16], ark[4][16], rk[11][16], ct[16], ct4[4][16];
    size_t i, m;

    if (tier_arg != NULL && !areion_set_tier(tier_arg)) {
        (void)fprintf(stderr, "Unsupported tier: %s\n", tier_arg);
        return 2;
    }

    fill_pattern(s256, 32, 0x01U);
    areion_permute256(s256);
    record_kat("Permute256", s256, 32);

    fill_pattern(s256, 32, 0x02U);
    areion_inverse_permute256(s256);
    record_kat("InversePermute256", s256, 32);

    fill_pattern(s512, 64, 0x03U);
    areion_permute512(s512);
    record_kat("Permute512", s512, 64);

    fill_pattern(s512, 64, 0x04U);
    areion_inverse_permute512(s512);
    record_kat("InversePermute512", s512, 64);

    fill_pattern(s256, 32, 0x05U);
    areion_permute256_p2(s256);
    record_kat("Permute256P2", s256, 32);

    fill_pattern(s256, 32, 0x06U);
    areion_inverse_permute256_p2(s256);
    record_kat("InversePermute256P2", s256, 32);

    fill_pattern(s512, 64, 0x07U);
    areion_permute512_p2(s512);
    record_kat("Permute512P2", s512, 64);

    fill_pattern(s512, 64, 0x08U);
    areion_inverse_permute512_p2(s512);
    record_kat("InversePermute512P2", s512, 64);

    {
        uint32_t w256[8], w512[16];
        fill_pattern(s256, 32, 0x01U);
        for (i = 0; i < 8; i++) {
            w256[i] = areion_load_le32(&s256[i * 4]);
        }
        areion_permute256_words(w256);
        for (i = 0; i < 8; i++) {
            areion_store_le32(&s256[i * 4], w256[i]);
        }
        record_kat("Permute256Words", s256, 32);

        fill_pattern(s256, 32, 0x02U);
        for (i = 0; i < 8; i++) {
            w256[i] = areion_load_le32(&s256[i * 4]);
        }
        areion_inverse_permute256_words(w256);
        for (i = 0; i < 8; i++) {
            areion_store_le32(&s256[i * 4], w256[i]);
        }
        record_kat("InversePermute256Words", s256, 32);

        fill_pattern(s512, 64, 0x03U);
        for (i = 0; i < 16; i++) {
            w512[i] = areion_load_le32(&s512[i * 4]);
        }
        areion_permute512_words(w512);
        for (i = 0; i < 16; i++) {
            areion_store_le32(&s512[i * 4], w512[i]);
        }
        record_kat("Permute512Words", s512, 64);

        fill_pattern(s512, 64, 0x04U);
        for (i = 0; i < 16; i++) {
            w512[i] = areion_load_le32(&s512[i * 4]);
        }
        areion_inverse_permute512_words(w512);
        for (i = 0; i < 16; i++) {
            areion_store_le32(&s512[i * 4], w512[i]);
        }
        record_kat("InversePermute512Words", s512, 64);
    }

    fill_pattern(s256, 32, 0x09U);
    areion_dm256(out256, s256);
    record_kat("DM256", out256, 32);

    fill_pattern(s512, 64, 0x0AU);
    areion_dm512(out256, s512);
    record_kat("DM512", out256, 32);

    fill_pattern(key256, 64, 0x0BU);
    fill_pattern(s256, 32, 0x0CU);
    areion_soem256(out256, key256, s256);
    record_kat("SoEM256", out256, 32);

    fill_pattern(key512, 128, 0x0DU);
    fill_pattern(s512, 64, 0x0EU);
    areion_soem512(out512, key512, s512);
    record_kat("SoEM512", out512, 64);

    for (m = 0; m < 4; m++) {
        fill_pattern(keys256x4[m], 64, (uint8_t)(0x10U + m));
        fill_pattern(keys512x4[m], 128, (uint8_t)(0x18U + m));
        fill_pattern(in256x4[m], 32, (uint8_t)(0x20U + m));
        fill_pattern(in512x4[m], 64, (uint8_t)(0x30U + m));
    }
    areion_soem256x4(out256x4, keys256x4, in256x4);
    record_kat("SoEM256x4", &out256x4[0][0], 128);

    areion_soem512x4(out512x4, keys512x4, in512x4);
    record_kat("SoEM512x4", &out512x4[0][0], 256);

    for (m = 0; m < 4; m++) {
        fill_pattern(b256[m], 32, (uint8_t)(0x40U + m));
    }
    areion_permute256x4(b256[0], b256[1], b256[2], b256[3]);
    record_kat("Permute256x4", &b256[0][0], 128);

    for (m = 0; m < 4; m++) {
        fill_pattern(b256[m], 32, (uint8_t)(0x44U + m));
    }
    areion_permute256_p2x4(b256[0], b256[1], b256[2], b256[3]);
    record_kat("Permute256P2x4", &b256[0][0], 128);

    for (m = 0; m < 4; m++) {
        fill_pattern(b256[m], 32, (uint8_t)(0x48U + m));
    }
    areion_inverse_permute256x4(b256[0], b256[1], b256[2], b256[3]);
    record_kat("InversePermute256x4", &b256[0][0], 128);

    for (m = 0; m < 4; m++) {
        fill_pattern(b256[m], 32, (uint8_t)(0x4CU + m));
    }
    areion_inverse_permute256_p2x4(b256[0], b256[1], b256[2], b256[3]);
    record_kat("InversePermute256P2x4", &b256[0][0], 128);

    for (m = 0; m < 4; m++) {
        fill_pattern(b512[m], 64, (uint8_t)(0x50U + m));
    }
    areion_permute512x4(b512[0], b512[1], b512[2], b512[3]);
    record_kat("Permute512x4", &b512[0][0], 256);

    for (m = 0; m < 4; m++) {
        fill_pattern(b512[m], 64, (uint8_t)(0x54U + m));
    }
    areion_permute512_p2x4(b512[0], b512[1], b512[2], b512[3]);
    record_kat("Permute512P2x4", &b512[0][0], 256);

    for (m = 0; m < 4; m++) {
        fill_pattern(b512[m], 64, (uint8_t)(0x58U + m));
    }
    areion_inverse_permute512x4(b512[0], b512[1], b512[2], b512[3]);
    record_kat("InversePermute512x4", &b512[0][0], 256);

    for (m = 0; m < 4; m++) {
        fill_pattern(b512[m], 64, (uint8_t)(0x5CU + m));
    }
    areion_inverse_permute512_p2x4(b512[0], b512[1], b512[2], b512[3]);
    record_kat("InversePermute512P2x4", &b512[0][0], 256);

    areion_round(rw_in, rw_out);
    for (i = 0; i < 4; i++) {
        areion_store_le32(&rw_bytes[i * 4], rw_out[i]);
    }
    record_kat("Round", rw_bytes, 16);

    areion_final_round(rw_in, rw_out);
    for (i = 0; i < 4; i++) {
        areion_store_le32(&rw_bytes[i * 4], rw_out[i]);
    }
    record_kat("FinalRound", rw_bytes, 16);

    areion_inv_round(rw_in, rw_out);
    for (i = 0; i < 4; i++) {
        areion_store_le32(&rw_bytes[i * 4], rw_out[i]);
    }
    record_kat("InvRound", rw_bytes, 16);

    areion_inv_final_round(rw_in, rw_out);
    for (i = 0; i < 4; i++) {
        areion_store_le32(&rw_bytes[i * 4], rw_out[i]);
    }
    record_kat("InvFinalRound", rw_bytes, 16);

    areion_inv_mix_columns(rw_in, rw_out);
    for (i = 0; i < 4; i++) {
        areion_store_le32(&rw_bytes[i * 4], rw_out[i]);
    }
    record_kat("InvMixColumns", rw_bytes, 16);

    fill_pattern(ab[0], 16, 0x5CU);
    areion_round_hw(ab[0]);
    record_kat("RoundHW", ab[0], 16);

    fill_pattern(ab[0], 16, 0x5DU);
    areion_final_round_hw(ab[0]);
    record_kat("FinalRoundHW", ab[0], 16);

    for (m = 0; m < 4; m++) {
        fill_pattern(ab[m], 16, (uint8_t)(0x50U + m));
    }
    areion_round4_hw(ab[0], ab[1], ab[2], ab[3]);
    record_kat("Round4HW", &ab[0][0], 64);

    for (m = 0; m < 4; m++) {
        fill_pattern(ab[m], 16, (uint8_t)(0x54U + m));
    }
    areion_final_round4_hw(ab[0], ab[1], ab[2], ab[3]);
    record_kat("FinalRound4HW", &ab[0][0], 64);

    fill_pattern(ab[0], 16, 0x5EU);
    fill_pattern(ark[0], 16, 0x6EU);
    areion_aes_round_hw(ab[0], ark[0]);
    record_kat("AESRoundHW", ab[0], 16);

    fill_pattern(ab[0], 16, 0x5EU);
    fill_pattern(ark[0], 16, 0x6EU);
    areion_aes128_round(ab[0], ark[0]);
    record_kat("AES128Round", ab[0], 16);

    fill_pattern(ab[0], 16, 0x5FU);
    fill_pattern(ark[0], 16, 0x6FU);
    areion_aes_final_round_hw(ab[0], ark[0]);
    record_kat("AESFinalRoundHW", ab[0], 16);

    fill_pattern(ab[0], 16, 0x5FU);
    fill_pattern(ark[0], 16, 0x6FU);
    areion_aes128_final_round(ab[0], ark[0]);
    record_kat("AES128FinalRound", ab[0], 16);

    for (m = 0; m < 4; m++) {
        fill_pattern(ab[m], 16, (uint8_t)(0x60U + m));
        fill_pattern(ark[m], 16, (uint8_t)(0x70U + m));
    }
    areion_aes_round4_hw(ab[0], ab[1], ab[2], ab[3], ark[0], ark[1], ark[2], ark[3]);
    record_kat("AESRound4HW", &ab[0][0], 64);

    for (m = 0; m < 4; m++) {
        fill_pattern(ab[m], 16, (uint8_t)(0x60U + m));
    }
    areion_aes128_round4(ab[0], ab[1], ab[2], ab[3], ark[0], ark[1], ark[2], ark[3]);
    record_kat("AES128Round4", &ab[0][0], 64);

    for (m = 0; m < 4; m++) {
        fill_pattern(ab[m], 16, (uint8_t)(0x64U + m));
    }
    areion_aes_final_round4_hw(ab[0], ab[1], ab[2], ab[3], ark[0], ark[1], ark[2], ark[3]);
    record_kat("AESFinalRound4HW", &ab[0][0], 64);

    for (m = 0; m < 4; m++) {
        fill_pattern(ab[m], 16, (uint8_t)(0x64U + m));
    }
    areion_aes128_final_round4(ab[0], ab[1], ab[2], ab[3], ark[0], ark[1], ark[2], ark[3]);
    record_kat("AES128FinalRound4", &ab[0][0], 64);

    fill_pattern(ab[0], 16, 0x68U);
    areion_xor_block(ab[0], ark[0]);
    record_kat("XorBlock", ab[0], 16);

    for (m = 0; m < 4; m++) {
        fill_pattern(ab[m], 16, (uint8_t)(0x68U + m));
    }
    areion_xor_block4(ab[0], ab[1], ab[2], ab[3], ark[0], ark[1], ark[2], ark[3]);
    record_kat("XorBlock4", &ab[0][0], 64);

    fill_pattern(ab[0], 16, 0x7CU);
    areion_expand_key128(ark[0], rk);
    record_kat("ExpandKey128", &rk[0][0], 176);

    areion_aes128_encrypt_block(ct, ab[0], rk);
    record_kat("AES128EncryptBlock", ct, 16);

    for (m = 0; m < 4; m++) {
        fill_pattern(ab[m], 16, (uint8_t)(0x80U + m));
    }
    areion_aes128_encrypt4_blocks(ct4, ab, rk);
    record_kat("AES128Encrypt4Blocks", &ct4[0][0], 64);

    /* Wide-block EM / EM2 / TEM / TEM2 */
    {
        uint8_t tw256[32], tw512[64];
        uint8_t tw256x4[4][32], tw512x4[4][64];

        fill_pattern(key256, 64, 0x90U);
        fill_pattern(s256, 32, 0x91U);
        areion_em_encrypt256(out256, key256, s256);
        record_kat("EMEncrypt256", out256, 32);
        fill_pattern(s256, 32, 0x92U);
        areion_em_decrypt256(out256, key256, s256);
        record_kat("EMDecrypt256", out256, 32);

        fill_pattern(key512, 128, 0x93U);
        fill_pattern(s512, 64, 0x94U);
        areion_em_encrypt512(out512, key512, s512);
        record_kat("EMEncrypt512", out512, 64);
        fill_pattern(s512, 64, 0x95U);
        areion_em_decrypt512(out512, key512, s512);
        record_kat("EMDecrypt512", out512, 64);

        fill_pattern(key256, 64, 0x96U);
        fill_pattern(s256, 32, 0x97U);
        areion_em2_encrypt256(out256, key256, s256);
        record_kat("EM2Encrypt256", out256, 32);
        fill_pattern(s256, 32, 0x98U);
        areion_em2_decrypt256(out256, key256, s256);
        record_kat("EM2Decrypt256", out256, 32);

        fill_pattern(key512, 128, 0x99U);
        fill_pattern(s512, 64, 0x9AU);
        areion_em2_encrypt512(out512, key512, s512);
        record_kat("EM2Encrypt512", out512, 64);
        fill_pattern(s512, 64, 0x9BU);
        areion_em2_decrypt512(out512, key512, s512);
        record_kat("EM2Decrypt512", out512, 64);

        fill_pattern(key256, 64, 0x9CU);
        fill_pattern(tw256, 32, 0x9DU);
        fill_pattern(s256, 32, 0x9EU);
        areion_tem_encrypt256(out256, key256, tw256, s256);
        record_kat("TEMEncrypt256", out256, 32);
        fill_pattern(s256, 32, 0x9FU);
        areion_tem_decrypt256(out256, key256, tw256, s256);
        record_kat("TEMDecrypt256", out256, 32);

        fill_pattern(key512, 128, 0xA0U);
        fill_pattern(tw512, 64, 0xA1U);
        fill_pattern(s512, 64, 0xA2U);
        areion_tem_encrypt512(out512, key512, tw512, s512);
        record_kat("TEMEncrypt512", out512, 64);
        fill_pattern(s512, 64, 0xA3U);
        areion_tem_decrypt512(out512, key512, tw512, s512);
        record_kat("TEMDecrypt512", out512, 64);

        fill_pattern(key256, 64, 0xA4U);
        fill_pattern(tw256, 32, 0xA5U);
        fill_pattern(s256, 32, 0xA6U);
        areion_tem2_encrypt256(out256, key256, tw256, s256);
        record_kat("TEM2Encrypt256", out256, 32);
        fill_pattern(s256, 32, 0xA7U);
        areion_tem2_decrypt256(out256, key256, tw256, s256);
        record_kat("TEM2Decrypt256", out256, 32);

        fill_pattern(key512, 128, 0xA8U);
        fill_pattern(tw512, 64, 0xA9U);
        fill_pattern(s512, 64, 0xAAU);
        areion_tem2_encrypt512(out512, key512, tw512, s512);
        record_kat("TEM2Encrypt512", out512, 64);
        fill_pattern(s512, 64, 0xABU);
        areion_tem2_decrypt512(out512, key512, tw512, s512);
        record_kat("TEM2Decrypt512", out512, 64);

        for (m = 0; m < 4; m++) {
            fill_pattern(keys256x4[m], 64, (uint8_t)(0xB0U + m));
            fill_pattern(keys512x4[m], 128, (uint8_t)(0xB4U + m));
            fill_pattern(tw256x4[m], 32, (uint8_t)(0xB8U + m));
            fill_pattern(tw512x4[m], 64, (uint8_t)(0xBCU + m));
            fill_pattern(in256x4[m], 32, (uint8_t)(0xC0U + m));
            fill_pattern(in512x4[m], 64, (uint8_t)(0xC4U + m));
        }

        areion_em_encrypt256x4(out256x4, keys256x4, in256x4);
        record_kat("EMEncrypt256x4", &out256x4[0][0], 128);
        areion_em_decrypt256x4(out256x4, keys256x4, in256x4);
        record_kat("EMDecrypt256x4", &out256x4[0][0], 128);
        areion_em_encrypt512x4(out512x4, keys512x4, in512x4);
        record_kat("EMEncrypt512x4", &out512x4[0][0], 256);
        areion_em_decrypt512x4(out512x4, keys512x4, in512x4);
        record_kat("EMDecrypt512x4", &out512x4[0][0], 256);

        areion_em2_encrypt256x4(out256x4, keys256x4, in256x4);
        record_kat("EM2Encrypt256x4", &out256x4[0][0], 128);
        areion_em2_decrypt256x4(out256x4, keys256x4, in256x4);
        record_kat("EM2Decrypt256x4", &out256x4[0][0], 128);
        areion_em2_encrypt512x4(out512x4, keys512x4, in512x4);
        record_kat("EM2Encrypt512x4", &out512x4[0][0], 256);
        areion_em2_decrypt512x4(out512x4, keys512x4, in512x4);
        record_kat("EM2Decrypt512x4", &out512x4[0][0], 256);

        areion_tem_encrypt256x4(out256x4, keys256x4, tw256x4, in256x4);
        record_kat("TEMEncrypt256x4", &out256x4[0][0], 128);
        areion_tem_decrypt256x4(out256x4, keys256x4, tw256x4, in256x4);
        record_kat("TEMDecrypt256x4", &out256x4[0][0], 128);
        areion_tem_encrypt512x4(out512x4, keys512x4, tw512x4, in512x4);
        record_kat("TEMEncrypt512x4", &out512x4[0][0], 256);
        areion_tem_decrypt512x4(out512x4, keys512x4, tw512x4, in512x4);
        record_kat("TEMDecrypt512x4", &out512x4[0][0], 256);

        areion_tem2_encrypt256x4(out256x4, keys256x4, tw256x4, in256x4);
        record_kat("TEM2Encrypt256x4", &out256x4[0][0], 128);
        areion_tem2_decrypt256x4(out256x4, keys256x4, tw256x4, in256x4);
        record_kat("TEM2Decrypt256x4", &out256x4[0][0], 128);
        areion_tem2_encrypt512x4(out512x4, keys512x4, tw512x4, in512x4);
        record_kat("TEM2Encrypt512x4", &out512x4[0][0], 256);
        areion_tem2_decrypt512x4(out512x4, keys512x4, tw512x4, in512x4);
        record_kat("TEM2Decrypt512x4", &out512x4[0][0], 256);
    }

    /* SoA Pack / Unpack helpers */
    {
        uint8_t soa256[2][64], u256[4][32];
        uint8_t soa512[4][64], u512[4][64];
        for (m = 0; m < 4; m++) {
            fill_pattern(b256[m], 32, (uint8_t)(0xD0U + m));
            fill_pattern(b512[m], 64, (uint8_t)(0xD4U + m));
            memcpy(&soa256[0][m * 16], &b256[m][0], 16);
            memcpy(&soa256[1][m * 16], &b256[m][16], 16);
            memcpy(&soa512[0][m * 16], &b512[m][0], 16);
            memcpy(&soa512[1][m * 16], &b512[m][16], 16);
            memcpy(&soa512[2][m * 16], &b512[m][32], 16);
            memcpy(&soa512[3][m * 16], &b512[m][48], 16);
        }
        record_kat("Pack256x4SoA", &soa256[0][0], 128);
        for (m = 0; m < 4; m++) {
            memcpy(&u256[m][0], &soa256[0][m * 16], 16);
            memcpy(&u256[m][16], &soa256[1][m * 16], 16);
        }
        record_kat("Unpack256x4SoA", &u256[0][0], 128);

        record_kat("Pack512x4SoA", &soa512[0][0], 256);
        for (m = 0; m < 4; m++) {
            memcpy(&u512[m][0], &soa512[0][m * 16], 16);
            memcpy(&u512[m][16], &soa512[1][m * 16], 16);
            memcpy(&u512[m][32], &soa512[2][m * 16], 16);
            memcpy(&u512[m][48], &soa512[3][m * 16], 16);
        }
        record_kat("Unpack512x4SoA", &u512[0][0], 256);
    }

    /* ASURA 256-bit Tweakable Block Cipher */
    {
        uint8_t asura_key[32], asura_tweak[16], asura_tweaks4[4][16];
        uint8_t asura_rk[13][32];
        uint8_t asura_pt[32], asura_ct[32], asura_ct_in[32], asura_pt_out[32];
        uint8_t asura_pt4[4][32], asura_ct4[4][32], asura_ct4_in[4][32], asura_pt4_out[4][32];

        fill_pattern(asura_key, 32, 0xE0U);
        fill_pattern(asura_tweak, 16, 0xE1U);
        areion_asura_expand_tweakey_hw(asura_rk, asura_key, asura_tweak);
        record_kat("AsuraExpandTweakey", &asura_rk[0][0], 416);

        fill_pattern(asura_pt, 32, 0xE2U);
        areion_asura_encrypt_block_hw(asura_ct, asura_pt, (const uint8_t (*)[32])asura_rk);
        record_kat("AsuraEncryptBlock", asura_ct, 32);

        fill_pattern(asura_ct_in, 32, 0xE3U);
        areion_asura_decrypt_block_hw(asura_pt_out, asura_ct_in, (const uint8_t (*)[32])asura_rk);
        record_kat("AsuraDecryptBlock", asura_pt_out, 32);

        for (m = 0; m < 4; m++) {
            fill_pattern(asura_pt4[m], 32, (uint8_t)(0xE4U + m));
            fill_pattern(asura_ct4_in[m], 32, (uint8_t)(0xE8U + m));
            fill_pattern(asura_tweaks4[m], 16, (uint8_t)(0xECU + m));
        }
        areion_asura_encrypt_4blocks_hw(asura_ct4, (const uint8_t (*)[32])asura_pt4, (const uint8_t (*)[32])asura_rk);
        record_kat("AsuraEncrypt4Blocks", &asura_ct4[0][0], 128);

        areion_asura_decrypt_4blocks_hw(asura_pt4_out, (const uint8_t (*)[32])asura_ct4_in, (const uint8_t (*)[32])asura_rk);
        record_kat("AsuraDecrypt4Blocks", &asura_pt4_out[0][0], 128);

        areion_asura_encrypt_block_otf_hw(asura_ct, asura_pt, asura_key, asura_tweak);
        record_kat("AsuraEncryptBlockOTF", asura_ct, 32);

        areion_asura_decrypt_block_otf_hw(asura_pt_out, asura_ct_in, asura_key, asura_tweak);
        record_kat("AsuraDecryptBlockOTF", asura_pt_out, 32);

        areion_asura_encrypt_4blocks_otf_hw(asura_ct4, (const uint8_t (*)[32])asura_pt4, asura_key, (const uint8_t (*)[16])asura_tweaks4);
        record_kat("AsuraEncrypt4BlocksOTF", &asura_ct4[0][0], 128);

        areion_asura_decrypt_4blocks_otf_hw(asura_pt4_out, (const uint8_t (*)[32])asura_ct4_in, asura_key, (const uint8_t (*)[16])asura_tweaks4);
        record_kat("AsuraDecrypt4BlocksOTF", &asura_pt4_out[0][0], 128);

        areion_asura_expand_key_hw(asura_rk, asura_key);
        record_kat("AsuraExpandKey", &asura_rk[0][0], 416);

        areion_asura_encrypt_block_rk_hw(asura_ct, asura_pt, (const uint8_t (*)[32])asura_rk, asura_tweak);
        record_kat("AsuraEncryptRK", asura_ct, 32);

        areion_asura_decrypt_block_rk_hw(asura_pt_out, asura_ct_in, (const uint8_t (*)[32])asura_rk, asura_tweak);
        record_kat("AsuraDecryptRK", asura_pt_out, 32);

        areion_asura_encrypt_4blocks_rk_hw(asura_ct4, (const uint8_t (*)[32])asura_pt4, (const uint8_t (*)[32])asura_rk, (const uint8_t (*)[16])asura_tweaks4);
        record_kat("AsuraEncryptx4RK", &asura_ct4[0][0], 128);

        areion_asura_decrypt_4blocks_rk_hw(asura_pt4_out, (const uint8_t (*)[32])asura_ct4_in, (const uint8_t (*)[32])asura_rk, (const uint8_t (*)[16])asura_tweaks4);
        record_kat("AsuraDecryptx4RK", &asura_pt4_out[0][0], 128);
    }

    if (g_kat_capture == NULL) {
        printf("_meta_tier=%s\n", areion_tier());
        printf("_meta_tier_code=%d\n", (int)areion_tier_code());
        printf("_meta_use_hw=%d\n", (areion_tier_code() != AREION_TIER_PUREC) ? 1 : 0);
    }

    return 0;
}

typedef struct {
    const char *name;
    const char *hex_expected;
} canonical_kat_t;

static const canonical_kat_t k_canonical_kats[AREION_KAT_ENTRY_COUNT] = {
    {"Permute256", "e199d6061c38e6913808ed52504ad5bd729c12635f89645ca11112071cec496a"},
    {"InversePermute256", "1fc070770a2b2b663458540ac77efc0d8e60075e571c8a7d1cb2659ee44c8618"},
    {"Permute512", "2c597c20e2346d29c37e0f0d29964c3934efad9a88447980913d5a2850364b292c06d8f58a4d88d7dcd234c5a1b700254c32240cd3d47668b601c4de8bc0680c"},
    {"InversePermute512", "30dbd5833d4d5281410d2a3e58d93905da0bedffdedbfd7f82c0ede21d6618def169996f912ea10d4af2598d9a5a4a3118cdf212324063cb8a6352e2b729ce1e"},
    {"Permute256P2", "0c9f798dca8ee57facf5112f0b7c924ea8d1a34f6d2ce221f444bef8f312196c"},
    {"InversePermute256P2", "f35d05b75a40b7c3180a570a5a3828693b5609e0ef176500216e85375f72549e"},
    {"Permute512P2", "3524bc0e9bfee075ed3203212fd0ca5cd945968962bd5237cca85b1d23349fbf89049ff2ee27eb8e79d234df8be2e6f34f3bb8b3ea5634bf2af690b8a11ee29c"},
    {"InversePermute512P2", "e13892f078d482cbc4f6238388e6f6a94caef0c45f253d429bff4dd8bf2652b5f8669b0752f1e528d9a50d8a9473ffd5c7a559dcbdf6ae452f02cce94d0f696e"},
    {"Permute256Words", "e199d6061c38e6913808ed52504ad5bd729c12635f89645ca11112071cec496a"},
    {"InversePermute256Words", "1fc070770a2b2b663458540ac77efc0d8e60075e571c8a7d1cb2659ee44c8618"},
    {"Permute512Words", "2c597c20e2346d29c37e0f0d29964c3934efad9a88447980913d5a2850364b292c06d8f58a4d88d7dcd234c5a1b700254c32240cd3d47668b601c4de8bc0680c"},
    {"InversePermute512Words", "30dbd5833d4d5281410d2a3e58d93905da0bedffdedbfd7f82c0ede21d6618def169996f912ea10d4af2598d9a5a4a3118cdf212324063cb8a6352e2b729ce1e"},
    {"DM256", "fb7f20b195d3640aa1ce1497ef186d8bd18344374bf867123c5ba64bdaba18a0"},
    {"DM512", "aac80bf21ac01e09f114eb0e0e11f9688b7bfbf50f10ea35ba18ea2041365755"},
    {"SoEM256", "5b6706f2e5d047f9c1c929bd661a69403afa83f36025628065716bb6d59d2f0d"},
    {"SoEM512", "5075dbbbac57f12a0683ea239140ca8dcb1aa085af8fb44b6c7ad8ecf07afc8578bd800b3a02440e5a00dc37cb5d68eb2eb3f4750553a948325661b2386675aa"},
    {"SoEM256x4", "0217fda139f7e2185b82d12e0fae5055aea035110f7006e789885915eaaa73b3e4dce235a6ec40f0d94e8b4f2e58a90182e17825211d988e4e67913fe3ce5f7813d6e861e7b1a25237b122fb28104c71c8991f1c5028ad0c8b95b8ef86b305dc846b4295d8db07a83961c3f2cc357c8d282e3f39fd7c4fc188aacf281d4e5a5e"},
    {"SoEM512x4", "7e75ac5953406269b9727bf9c25fde4c34a871e33061b5f3c8db1c4a019949ebc9e6cc9a2a2ec3092cf5e1aaae62ef0932ff3bd15f39c5131a01728e1ce8618888b1958b880e461fe7ac162093fa83b72bcbb5c9f1e114dafdce6a4e35973a6aabc812115673811bb1af0346ca34b451d4165128eb7177c6799d7953b338bf9589ab09c0be8974229b5e13268fa2a44eb7de0e581c45707767f776c0e7d85f7c3804dd73406e6f431ca30cdc546078f5b2de46dca859d270155827ec5646de12a7571419496155568c4373bcd61117a1e9002b829ed862aa94557e5414b3a9ab4e4506258de1c82d89da350efe4855f70c43fbf7723aa6c2444165a62d4034e8"},
    {"Permute256x4", "0ec7749ed19e7db10014db932949420ff46537f780a95d8846b541b0cb24041b99b896346376816e64749c2f8e1b7efd09d8b18470a22d758bcf54f59fc5dfde315cc46022b861aa59826f42ecf91ddc35e88596a9e3bcceb8f5ff8f7e7573b2eebf589c854f8382bd66d2f0f13bac8246a4e43f27e306ff164edcc22c02a785"},
    {"Permute256P2x4", "0eac98ee8b1c30b23827f94c9ae1e530e01f9291443e8a6fcf21f4b4823bf1196581df8ed8ae6c176ccef1178254f44fb44fdab285e8b9cd3f696664f959ff8565dcf68eab1981f58c3604fd72dbfff36eac374b0752ecd94acb6749df34ba9f9578d53db2e936d63b09beddb2b6b0d4266b99f9be950a6e4ca91a5157e44a04"},
    {"InversePermute256x4", "743006c18cab5d58c3f1c826b62a924580be86b45ef5fb529dede1ed86b1566204439242da073af5077723dccfe225063ee9187d2716141de880a5c0c66bfa30bc61933c325133221b4829588eb5322df2542bf92e619d362e6b7341a8cf6733ed52f9bf1cf023b052912674a089324e9c04a4dced9bea4defeac83373431b92"},
    {"InversePermute256P2x4", "e0e40b4ef76de2d6b10b02081c21b584a25b6456678455930e3f155d3244715184e24dd022d6980ee09df6da8567ed279f02e3820b3977825a683bf0f78773f30bcd8d3ecd9303ea0b0ce4acd31625dbfbe75602d9bd6560e06895ffda6c73ef105852c110016ea84ff41385d676d82ff1cd1e8d002c1ce750ab96d32d3d662f"},
    {"Permute512x4", "e80117449c5ff10f4ec98c12899a00e734f567584fdab29f55b1988d6710264e240c7dcc5aff094d86ab05bcafaae6c40c53f3bc34fdd3ed3e59f9dcd5dc0bba2877d33b59a50c742f8b2ab8d63b7c4b86bfe905ce301ea2c00179576208dde3561582a3472d0a3fccf435fd15e8a9dc307890bab58bdb4aa16360196afb28b03a7dedc776cc10e9786ede6b0eac32676703e74906dc6ecda78b62965a14b776162f918d386fe6e4b00a2b30e2d8575698af5a2850ba7aab20ac7ddfb0238c204d840d4056897daa41c09de285767a5c476b8af74f6535e2fc72aa913ddeb00c0152860b594f574b8dc02e9bf50e34b9b24856ad75a706ec9b39713b27e7fc43"},
    {"Permute512P2x4", "bcb54df4f9927301c6be14e1cbc2b326478bf859304413e151e37fea8fce9cb1ec0175175f1e6d257f1265276c7fc305ab1580e9e3da5c2ebb5c456dd8ffee54cb72cba5ea52299795b73533d0fa06a0c88129057de0055b630c7764c393ca5eb8bd16905a25b22222afaa6e2da6b82b15abdd905918c7e3e639c5eefcd192e7a84cf879b79939e22a296cecb1b99d812ddfee0587906d3b9cd57cfe47ad7b06284ed78081b64abfe145275fb0b76fdb52e89753e8ed2958a053b5142bf4175ed546a07a5e9b7c19d9d05819db19108059a486e079d65846a288d576fd1250fc893abe8e6bce12ba42093c722d16c962eb073ec6add6f70f05941f7ac16383c3"},
    {"InversePermute512x4", "83d814e4f822c03eddab54cec2bd2cc0f373bee965a7c6a1d8228a5a71f0340311bead6aad2ebd8451b1c47da42f476905679d9216c341cace2624e03e9b4fbedc6e968aa5864f5e0d5ec34845efdc52902670e8980f6c11727bc121703a220fe85ae3106ca1fa1c80057d28ff406819d7181955a251b15ca2c1b05b27857770b29a75332e85879f29884e38599675f15aa77c442a8f6007e17d27030b48cd846796f90605e71aa2b1cbefb2bab315e7e7606f019ece7f9fe21ebd50d52b66ac750d84573951f0cfdc6af42aa12ccdda80e229bd2113b607504406eccdeebcf417a8fa480466e597f632a3777b78fcffe483f980be671abf7e3e12a30a695dd8"},
    {"InversePermute512P2x4", "1ec437508ee3bd6c95e41ba831eb5cca655b93c15e764ac065f36fefdfe2096f61e2fd81be04ac13e9cfc01e6f38173d058a685bb7fc5e37f65cb1dd51d6adff7dfcce2c6ab2fc952ab3448562cad961c8a2c4610f90417f68c6164f6b9e9d52b7608deee73a57d3710099ec4122ccc657d84d1fec42eeedf719d16f05238838c0fd97dd1f7d0b5108be07c80ff93d31d16b1b8b6ddf9e520c3e0bed7e2cf0b703d151c6b1e78058b58cbf14e8c29ee46fec23db2478bb858eb82aaffc405835776cc3faa587f18c470e86907fbcbf9da269eeef9dd3ba7b95b0219ab17b1945c217242b9b6f063b47f1240a4911c6f1b81c09fe2e014af83e88465a8900f65f"},
    {"Round", "734d67dffe30ef5668cddb9ae40bb624"},
    {"FinalRound", "85bd8638dff4207c462326a7ca6e62bb"},
    {"InvRound", "ee7722b64711445b0da3b8568413aec7"},
    {"InvFinalRound", "0aa193f26168fd0ce280320f7cc00e09"},
    {"InvMixColumns", "28826cc6a00ae44ed77d93395ff51bb1"},
    {"RoundHW", "bd67569024fd0ee197f600967539e44b"},
    {"FinalRoundHW", "7d4b97b25cd0d413e2bf4c478a07a1ac"},
    {"Round4HW", "c2f54df2e934ef44e182b9974e9ba4dbd9e5836a03875b99b15d34cbb3d01831ecae7776705e78b6729ae84079fe7f2766de0effb2e58c12f724194793a8bab0"},
    {"FinalRound4HW", "0b5bcadd23e949d7b4d29b32be2e10966243a4f67541c8a26664e6e48570a72c6ca3e511296baecce1ee77ea92c19084a6f39a8ccbc91f18552476e80c870a4a"},
    {"AESRoundHW", "26aae89a452d1f521cb722431bf49316"},
    {"AES128Round", "26aae89a452d1f521cb722431bf49316"},
    {"AESFinalRoundHW", "25ac9c06e96c18ded9e19a90a7de2834"},
    {"AES128FinalRound", "25ac9c06e96c18ded9e19a90a7de2834"},
    {"AESRound4HW", "da5037e470ae0828ef7eaefa9bfe9eedffe0cec8095d61977fea6d4ff77f6f9a60c9872f53d5be419d10eba0643430560b285686d03b8c84596429f246e0fe18"},
    {"AES128Round4", "da5037e470ae0828ef7eaefa9bfe9eedffe0cec8095d61977fea6d4ff77f6f9a60c9872f53d5be419d10eba0643430560b285686d03b8c84596429f246e0fe18"},
    {"AESFinalRound4HW", "95e3b597e9297acca2d310022337395e362434a2dd38f99d352e2f5d4918d68be0ca43fe24de1b4fab882386fb90198f1b79be1a60721bc623463d8e3ce6b82d"},
    {"AES128FinalRound4", "95e3b597e9297acca2d310022337395e362434a2dd38f99d352e2f5d4918d68be0ca43fe24de1b4fab882386fb90198f1b79be1a60721bc623463d8e3ce6b82d"},
    {"XorBlock", "a8e8b868a89868a8f8b868989868b8f8"},
    {"XorBlock4", "a8e8b868a89868a8f8b868989868b8f8b8e89898e8b878a8e898a8e8b868a89898a868b8e8a89898a878b8e89898e8a8f8b868989868a8f8a86898a868b8f8a8"},
    {"ExpandKey128", "0a2f54799ec3e80d32577ca1c6eb1035e2e5c2cd7c262ac04e715661889a465458bfe2092499c8c96ae89ea8e272d8fc1cde529138479a5852af04f0b0dddc0cd558ac76ed1f362ebfb032de0f6deed2f9701900146f2f2eabdf1df0a4b2f322ee7d8a49fa12a56751cdb897f57f4bb57cce5faf86dcfac8d711425f226e09ea63cfd83ce51322f4320260ab106c694128365bf6cd257902ff2719a9ef4b70e8ad67c0296042b92b9f65a082702ed06a"},
    {"AES128EncryptBlock", "c9fce4ccc4ca59266d73ed19e390c1aa"},
    {"AES128Encrypt4Blocks", "eca38d1787d711da9be585f98098b2a4626e8a83fdc17293c0fe8350c40310c441e90ac262e4558ff0cf4c1c4cd50917e983ac1d457b2d43be54c7ec560a76fe"},
    {"EMEncrypt256", "78d2d5b64170af7c29a96d92433e14ae030c2618621039fabdaf013953a62df2"},
    {"EMDecrypt256", "9a796e0258c290794a7b1f7acce4e292b3a47c9c5aceb75a3b45a03afd10ce1f"},
    {"EMEncrypt512", "bb4beeba170fff96e900147822afb22d6bc147550f04eecf53c55782f8065457169df26837ba20766c7cffe916e5e7476c4481e9b4f04325d9a61918ac6e3cd3"},
    {"EMDecrypt512", "522228aad890411b63e3f20ae556a6e6dbd6e32cc59581cd788698785c2de6f6d16854df68ecfba6c7af2caacd98b2293c35dbd55e778371d8da348405e84b74"},
    {"EM2Encrypt256", "3673151869c2c07f5c39f27b7908ba2067083d7f6edf6a9cee0dbd6d35f24b58"},
    {"EM2Decrypt256", "2bef27ad641b7c24c735045926e729aa25c19fde56df95ff333869c09fa1bfc7"},
    {"EM2Encrypt512", "2d6128705ba22a4085bbcf8a023560231919181d34effa0975f8dbff60a663508082a336901311c7ecac12ba0099dec540faac2770e10f07b28e33146f990da9"},
    {"EM2Decrypt512", "8ea6f350613a2e7aaf381a6989d2e3685d83ecc1886e20b29a5c22337685c76eaefadeb08ddbe8aaa97b745807391cfd0ca927b82805ef4f5929a4e5abb76e83"},
    {"TEMEncrypt256", "70fca88d6edbfafdabfe4f648adb3113367a811fd6ae44ec1d0a3b942d22ee45"},
    {"TEMDecrypt256", "e0094d9fc07e7221034539da14cc785369f28cbf301d058faa75d535e391412f"},
    {"TEMEncrypt512", "fea90d01225f9869c6b1c5dafd585a9dc42b6263ff2c092949b3f2d146484ee440f11e46ed92fbc8a5779d2049b004c327a6d95b77fa85a82e6c64f4e5b6f5b1"},
    {"TEMDecrypt512", "25b8b2d72ad2c285c8a4b5195a2a2098c6ab64a60746a1ff3074f27856aaf8d2d7bb4ea8f51812ca15a1c7fa3e38ddf02d73eab7ea8bd24f79c4ffda1f5d8843"},
    {"TEM2Encrypt256", "01a338b3980b05cbbcf4562aee51cf8a7ecef3a94f0916347990c208a4210f70"},
    {"TEM2Decrypt256", "27e5da2662727c05ec184e1e4caf4300b3aecbc652b9ce5f0cb7be76b57736ae"},
    {"TEM2Encrypt512", "bbfbaeed2b751c56246ef303454211b82dfde2d57f1759d1af2a4096bc75376dfb4c14078b7dd3568c9797cfe005c3b5e9a036b2121d556c3dd0540dd7d72112"},
    {"TEM2Decrypt512", "e25503e980d1d003896d5c312663e3e56836e4a447eae43c4c0a1c06c5563581b1fda8c59c57672e4d10474ba15330150b565ba5299087e3cbf485d2e62c90a6"},
    {"EMEncrypt256x4", "0bdfdf80fab9b82a41e271bb570aae47f2ca868bade606315e45afa668892f0fce4a09a97bb517d6f0b978436ab7600042929f2af36799e8523a24fde19e3f79fb6a4c4b4a0947a69a39d3ec6e2b8448ddd77ef01be94db05a0ee08851af7fb2608db1fe37e6169d6cde7347272d22ace19be717c2fb6814d36b03b4ebf0d454"},
    {"EMDecrypt256x4", "1a1d528ef496c9b85a6c9e37e6718c77cda72262fdb134f6804ef5222e0d0512c5fe119b0cace4b75d3217499d99c68b46e1985f9248d0259a61e86b6bc42ed96f7305e8954e5d18340ed8b6e8b6c3158a208869d9fe282108e7031a2f4934aa49dcb714c60407d0c7af9bd24e4b0a8347c1a534672daa2625fafb5390e002ca"},
    {"EMEncrypt512x4", "817932ee142bfa903aec62a133ccbf238bd5110fa67f90853edfed13ad403e42cd875e23a3f7c6472b8987fc8a8db713840895df797678afc2a1691ac1f19251c9bdc6ef002d38879fa1c7e3ea9142c4e4423b0300bbfb5a49deccbe6dfe51e1c70d46351841b28d4b37c7f7c47c35fa417aa049f67d69c3616ae6b2bf188f507059ffe0e26c7e10c1850aa6e7a0eb2c30fa2c01a0ab2a26ee3a99a6df0cd8725e593c737ed4e946c79620d31a8f89c914ae6cafee29c0511a931753ed8ebc9ec0d91a57cef5cb174fa6b12d59ac89093ebbffd0a2d118209f434deeb482c375c0cbc67ace12c23a21b74a997f7380b0cb0c63bd827a42af5c846c0723d18058"},
    {"EMDecrypt512x4", "fbc6ee6a000a69280dd44e6eb9ee5aa5fb1d340a223992ee64eaf10d5ecc38ba05f659dbd378f9db277c3782c325baac761911c0afd33083b10fd2cdc3b1bd624a420bc1f618c78ea555211b884f80f3aabf92e45f932351e9ebdda1593d3cbbccb17e3979675f0a6f572cac107ed2fb0669484c504a567f6e80e55244f9bc6774f230ec0d5573af05d0cc4766e4d19c3edfa2b823b27312e1d96e383acddf96047ae77b9853b0b393dedf4a51b22f88c4d794b3d3beccd84828e46163566ecf72c29ce5dbf2bd64fad7990021b5bca9ee7171b39c0822cb355be2b403b57265e4be2510cbf080b7e971398037832e19eb4541c1aee21b794e6055396b7e5653"},
    {"EM2Encrypt256x4", "6a52e2b74b172972aac7bfda88eeba8b2d2d1480e0106e7bdef2fa156c985985493a084b58079f7a1564ebde7cb31f9a2b2a7e5a3e4452defe5b050bcd02a2dc5122b9bf51b31184847133b2453d824010db6cd2ca298bc1b46e2e8ef8ad1c367ac6394aa8a6453788df8c50b0a993d3f4f189136afdb565704ec17a2fb59fdf"},
    {"EM2Decrypt256x4", "f135d4f5ecc6bbe8ee73d9240a536fea3572afa54ca904c153b6c14335720dcce88b573ecc198d8ec391c65b01aa712c8ef2c8f337fc29173f74dc12102383464fd69191d2f7ab6372c02dd8dfba1ebd9f52ae2b0d9600febc1a0b7f42029b8e296ce0c25cc94e46f3ac6a8e6ae0362b3732811ecee8f6165f922bf8509bc401"},
    {"EM2Encrypt512x4", "3cb55ff90ccc17115e123027f22fac6c9a4212bfe0c731bf49c0fe2a9772a0bd2ebf9456a5f0a9ad3202a41a6df312db103113a5fb393286ccf0aeb4d8a032c6dc7377e3af0bdf898132cf76261cbde399bb7f25c540e2f793aebca6b429dacc489ee98e8a6402e901f01a2c062cab000b44a3003d668de285e922ba4e3775722bd4057144d1ee1ef219bbedcb5f7d4c727e402572e02f15ce36e80c38b3b78597d073c018ba3d535e6125db6b2e6be226ed794486c108e3832ffca0500f9f4a82f7d13f62ac459a9a07272c7fd83bbb9b22d2e039573068cee032900308735d0808e701610c2f647099db8039e2c52a53679312ab795790e7fe343f9b7ad41b"},
    {"EM2Decrypt512x4", "301f6dd30ca42f18a364a377c65205f61cc443b1ddbeb939127a94b24914585beba623d84b64c594222b94d1e82710cd0269dfeb3249ddb04ef79877bdc04b5e24bf77f8a68cc8481db71084aa60380e5c26a9ce7decc7c64e877927a56d8f92835de4df6283da148289b5b0a8502234094c5bec1809823764e27c8bb614879b8f727cee83595805cd0b9e57c034aadba293b1b3495b802c2c16fa17c0b38902263423df223aff8a4021fdfb7aecf26fcb4429ba08e6477723dd6f7b4ded41560d4718bfe6e06c7c9fbad51b48a323a4ef6e66aac4ac86365e4c635f666b56631668ad31cb5b3110bf1f6e23841e6e0cf4271a1f83bce425d58def2612f64911"},
    {"TEMEncrypt256x4", "e5b1dc24ec69f4f24197356710349c06e0d6a854e9e2d143517ffe7b4352166235e6e83042de44621fc6316c926d0e3a71880f9a4a496560049171407ee4882375f9374d8e082bea752e564c883a21b0661ffdf6a0d54fcacabef7f0f2cbd112d32c7dcdf0a05d78dd8f7f7380101e926892f17538003a7201bcc13d770171fe"},
    {"TEMDecrypt256x4", "efd9fca25056eca294badd07bd007002e35553c28f55a1549d3534c82a2bb64e5f19e4eba81017192e3e84bd8b6e503c640fc2553893a839e0e38375b84ff319574b9fe34140a19bf13ef1e0d2dfdd232e102e98ecde3bc941d3c41fc5dd815d8e20e295c44041bac5e184834af24ea3e2fb8800a6ff1dbe3f9969ab0391774f"},
    {"TEMEncrypt512x4", "6b4295c6393490afb362b93e54f11843e0e6b4b31bc77330b84f03e1391c9b8b8903a77f2dae9e0b4bb86232e9b66270e8ce345c3751d22e4e376382143f015266da423a21df144bba183c596273c50fe256e6b73c522929f4262dd58fc095cf1e3d89c99bde8166efc975f1b79aa41dd96aeb6c15da20911d077ff06d86984b16063db792d63aa3b2280c989185c3447428cde71dc578c93f28bd5b6dd69ee56fd711e65013c5a441d6c65654294c9a4b8ff823740985eafce87a3237ffd30372d2364569700cfb3d5fffbadb28be0f0a09d51313fb8496b027bbc1dc99949f0a39d4920fcf470a4803a1e7acaa36d5d424de0468acd977cb43769d94c66c3a"},
    {"TEMDecrypt512x4", "b6fc54c6e5f190f75f902761dd987a890163a4cf159cc5f30913a66bdbf569bf394d228e2da4498c232b9606686cb52efe68f3f48f760c4cfb619ff9a34156085ec0e977c0911181436bae48bff0188931f0e2a2cd6ec090867272fc6b6504a2e2b48ea62279735797a86d7989e3b1c934b204aa18ed62082370c60526c10e605af97ada69780d2b3a209b722b6fc7c3cf8c28f5d7012eb85d360834620de1c69b925a502d7687d41dbe22468a868d70dc175d88381f5422b50cda52bb34068181235e1e61e3dc3fb29577a8b4059e00d0e457afd4ec1bea65ffd52c567b506ab2f7872277e50014ed882602cbc17cc8ffebd4dd4c0e811fc72509b4dda6a42a"},
    {"TEM2Encrypt256x4", "af08311f1e7d4be99f5f2e6c470635002f1f0ba45400a8f99536c8093febeb44eefa88424a496a04d9036e51eafcbb874f887e2bf3d4f0b46140475194fa5b04e63b08a292bf2fdec0c00c88d4318dc76b0aebfbeae1c9f18e4279d37cf38ab81232c363de71795b367597dea34728574035d02270f00ffa94c9396e3584225d"},
    {"TEM2Decrypt256x4", "ab428c1415f3e2bf85b828eab317299b05cf713c0b1452e96553abdc272aabc4b085c5a88983f0c85a6aeffc39af1e3c87630013d7e040eddc619667fdd44c460a843d6f819cf0ab04d73123f8556a1840e8edecf2e1df0ea6fdd803d6cf0468efc8042f16d4ad10f2b9aa4245503c1d5d691f186b7a6ef6a95b58b9289800a1"},
    {"TEM2Encrypt512x4", "1becffac351f90200272eaaaec9931d863a7986d86dea7a77fe5448800b5af294ba4bc4c2bb519610891042589d91c5ab1582215daf25d30b92b8cca6993c4caa755546e03a84e7615b1dd413caa17e18a9d03169be80093eafd20f9061b0e74ee00cbe1aefabf2a41b20cede2d2a7ea96b1b2edb1373aaa495e33b0902aa4f594bcf3be748fcbfdd872fcc395e37d7355097a9889fa27ebe22b60e0e1c0fbb6738e02320bc87f4d46667f33cbdf3d5e9ccc6110a24d431a5960416319a66699e14eb82bb5cd99665983f56fcaf65acca55d63eb09dbb692ccc05a08a3c95d8b39abc5f3c0ce3228b5128a05b1b0b3be60128eccd776c6e79cd7dfa912a5a2f2"},
    {"TEM2Decrypt512x4", "93ec234be3ae42ac3f72dc5ce20c445f164fbef3aeb17925b9109723ea5de76222588f3c03f63184f715d7fc8922537e978131a2bd18e1e5dc87c0cf92f47a8af55618a98ab8ee0dad6e736b1af40ba8c4b5a6ab10ce882d6f8904854d8f38209ad4a17ecf3195b58735fb6544e83bc372fce2b885d9fa94e1112ea078c7e982ff092b4f75e8814596a488c264b74d46cfe3b601602ce20753063ce7327438043692e91478462a65c47e87f9203d4c99fb6c28b2888d72ee7c2b63ed95f483f321aac6ec8665796bddcf26df135b4d303ccb8a64b3435322883af8f42081029091e05095800a05ff42d455aec702ff1dbf06439bce2250800c3c85523390ae15"},
    {"Pack256x4SoA", "ea0f34597ea3c8ed12375c81a6cbf015f71c41668bb0d5fa1f44698eb3d8fd2204294e7398bde2072c51769bc0e50a2f11365b80a5caef14395e83a8cdf2173c3a5f84a9cef3183d6287acd1f61b4065476c91b6db00254a6f94b9de03284d7254799ec3e80d32577ca1c6eb10355a7f6186abd0f51a3f6489aed3f81d42678c"},
    {"Unpack256x4SoA", "ea0f34597ea3c8ed12375c81a6cbf0153a5f84a9cef3183d6287acd1f61b4065f71c41668bb0d5fa1f44698eb3d8fd22476c91b6db00254a6f94b9de03284d7204294e7398bde2072c51769bc0e50a2f54799ec3e80d32577ca1c6eb10355a7f11365b80a5caef14395e83a8cdf2173c6186abd0f51a3f6489aed3f81d42678c"},
    {"Pack512x4SoA", "1e43688db2d7fc21466b90b5daff24492b50759abfe4092e53789dc2e70c3156385d82a7ccf1163b6085aacff4193e63456a8fb4d9fe23486d92b7dc01264b706e93b8dd02274c7196bbe0052a4f74997ba0c5ea0f34597ea3c8ed12375c81a688add2f71c41668bb0d5fa1f44698eb395badf04294e7398bde2072c51769bc0bee3082d52779cc1e60b30557a9fc4e9cbf0153a5f84a9cef3183d6287acd1f6d8fd22476c91b6db00254a6f94b9de03e50a2f54799ec3e80d32577ca1c6eb100e33587da2c7ec11365b80a5caef14391b40658aafd4f91e43688db2d7fc2146284d7297bce1062b50759abfe4092e53355a7fa4c9ee13385d82a7ccf1163b60"},
    {"Unpack512x4SoA", "1e43688db2d7fc21466b90b5daff24496e93b8dd02274c7196bbe0052a4f7499bee3082d52779cc1e60b30557a9fc4e90e33587da2c7ec11365b80a5caef14392b50759abfe4092e53789dc2e70c31567ba0c5ea0f34597ea3c8ed12375c81a6cbf0153a5f84a9cef3183d6287acd1f61b40658aafd4f91e43688db2d7fc2146385d82a7ccf1163b6085aacff4193e6388add2f71c41668bb0d5fa1f44698eb3d8fd22476c91b6db00254a6f94b9de03284d7297bce1062b50759abfe4092e53456a8fb4d9fe23486d92b7dc01264b7095badf04294e7398bde2072c51769bc0e50a2f54799ec3e80d32577ca1c6eb10355a7fa4c9ee13385d82a7ccf1163b60"},
    {"AsuraExpandTweakey", "e048946ae50df8c507d335e9b9438911cdc3454fc5434dc7dd4345ff4543ddc7690911c4dff91f91e4af9c00367ebfef1914f12f0e1b4b2dfc35302ab55debcc5c63b848e6835e726c0e20ab1e34bbba3397476caa41d9d126bfd914fe2459fc8899b34316c2beccd7d35fde674d5b86895f44fbe00faded186207e786b46b0fc49d260ccafd7e5a81f471d05677c707a0d84392df138af8c6c76a0890aa229bfd08045a08029e5bc7ad6cf50469e823c634c34505e2c21774e4d739caddcee4cd8c11d12b51e214d13455264f0609c72b1cfd69b25fe7aab57563abacac7bb498b24a8c1c7875ead40bf0e595d8af8f8fed490f2712cc824de93f71d83ecd1ad9176789579db06a5ae60c875966aade8a2b3585b5ced1bd0bfd42826e35a36892435c2231c73222b6b81bd35109fc14764fba2b03cbf19ada29c4e939a218da7f7c9d34396469e10e8597d51404f175390358b74c3d1ad3e514a61baac1731e490ec3cdc2a42fba0b98cc1f2100d8c0db21b476baa90973deaf8f1b16ea558e846c6d30d5dd329f8e248ebd76c7ee93769834e744b2e85091e97cf605ae618c"},
    {"AsuraEncryptBlock", "4b78a47b0e63f935e224d1ad3e811bb2eba0dcc792871d084f40b74626b0c4f1"},
    {"AsuraDecryptBlock", "068e4d36dfb6729d4db69736ac9ab0a61da03f0ba58861a6f2c6f99dfbd17cfc"},
    {"AsuraEncrypt4Blocks", "43bbdada7cdda1dc0fe995f8593bcd78abd03a7a0d0bd89fa091e85f256baf6ba55eb2abe7d5d4e2ead45246876079cc2be0e17e89f28d0862087ba221739082129af5ffa61620f348dc8e45bd1fa4d9367debb04f51a6667e370af0a0d3034b867188a6cb58ea22c59b54613cf91593802cb4cb5bca9f297cf24853a5cd66ae"},
    {"AsuraDecrypt4Blocks", "fa79ee6a54bd7ddab93869914020a2716a752eed5e9377af6bf6431db2f5afde3ae58f5e8ef5b5c451ac9134c534c7039feb2fd500abe0594ee90d704e5c07e29b04334721bb3c39c784f63d428743f70fad207a703da74fef3ec6acf687565dfe2dd05626d4c4fd2f91fbb792911b99b4a8eb9b56b2dd5b301417c08181c181"},
    {"AsuraEncryptBlockOTF", "4b78a47b0e63f935e224d1ad3e811bb2eba0dcc792871d084f40b74626b0c4f1"},
    {"AsuraDecryptBlockOTF", "068e4d36dfb6729d4db69736ac9ab0a61da03f0ba58861a6f2c6f99dfbd17cfc"},
    {"AsuraEncrypt4BlocksOTF", "3344764cae97da9339f7e4394acb3588a71ed6a9dcef1dbbda446f9596219d0a4b8e8d2bf10735e0f94d602b577fa7a10bcacf44ddcf21521cd7144b5f3afbe6ab7a66d52ea33573753750ff23df8e6ba6fce945eb8909a21c56bde1ad9884c84c5bb80d9aca85ed8e4d440047f17c87778a8af252ada6c1cde93ae1e1ba8f22"},
    {"AsuraDecrypt4BlocksOTF", "2dae9e77504011b6cddd8a3869a17067880c3b9afb0ed73cadbcaf04351b1d72759ae9a6ce8a4595f93e020bb445b73c9402dddfc83798d284de4a158308e485f7b2c2fa364a19bce317d1a40536a0ddb504034953a18685e4c3362d9d2207899dea9e9a636befcd146e8728b23b759f72da00a2fc295f326aefa49d714ff8f3"},
    {"AsuraExpandKey", "27a4855cbe8d5d0fe8c70cb73aeb44e30a2f54799ec3e80d32577ca1c6eb103529f1be4300f6b297ea0602d2e24779b859ec5ea8d114e62bf29caef861642d9b84c03c980c7059820165daf86def47c7eb34c3bc40b2de214bd423478dffa5818f6a9f254200ad71acebeb7f546f63028eac689db4cdbe50635ab346b596538be8c1264eb7e9025c6601afa5931ba54d8c8443d0a207f6fe2132b47d55c640d1c167d4995ae3bc550853dfbf00f698a9fa5b13865703e019bb1a6473ce42be6e00455a9e82e189a27328024516c70f46e6d5b6261bef8c1c176934c8f56d7d359c3bb2f4f5bd7364d5411dfce0c851868b64b177ced7ca0c4ca3d268ad2e3313834c9a750d5eca46bfcf13ba31cb2919d070c879ef0dab91eed45dbf069820af813c0682feb721c99edd6c806d6c46766530e08bccbbe271f24cb3ba05c7a2b8290da558f5936606e61ba9b3243a1e3d6f7260db80ca15340d8a987d9aff9c5668f0937bc6d33a1378e14c2f92f0c67ffadfe4c0bede1cdaadd60f2ba51a4b31a424fc04d78040ca848e4555272886ce56d0a5d346ef9a059b43b71e544109d1"},
    {"AsuraEncryptRK", "4b78a47b0e63f935e224d1ad3e811bb2eba0dcc792871d084f40b74626b0c4f1"},
    {"AsuraDecryptRK", "068e4d36dfb6729d4db69736ac9ab0a61da03f0ba58861a6f2c6f99dfbd17cfc"},
    {"AsuraEncryptx4RK", "3344764cae97da9339f7e4394acb3588a71ed6a9dcef1dbbda446f9596219d0a4b8e8d2bf10735e0f94d602b577fa7a10bcacf44ddcf21521cd7144b5f3afbe6ab7a66d52ea33573753750ff23df8e6ba6fce945eb8909a21c56bde1ad9884c84c5bb80d9aca85ed8e4d440047f17c87778a8af252ada6c1cde93ae1e1ba8f22"},
    {"AsuraDecryptx4RK", "2dae9e77504011b6cddd8a3869a17067880c3b9afb0ed73cadbcaf04351b1d72759ae9a6ce8a4595f93e020bb445b73c9402dddfc83798d284de4a158308e485f7b2c2fa364a19bce317d1a40536a0ddb504034953a18685e4c3362d9d2207899dea9e9a636befcd146e8728b23b759f72da00a2fc295f326aefa49d714ff8f3"}
};

static uint32_t hex_nibble(char c) {
    if (c >= '0' && c <= '9') {
        return (uint32_t)(c - '0');
    }
    if (c >= 'a' && c <= 'f') {
        return (uint32_t)(c - 'a' + 10);
    }
    if (c >= 'A' && c <= 'F') {
        return (uint32_t)(c - 'A' + 10);
    }
    return 0U;
}

static void test_all_tiers_pairwise_matrix(void) {
    static const areion_tier_t all_tiers[] = {
        AREION_TIER_PUREC,
        AREION_TIER_AESNI,
        AREION_TIER_VEX,
        AREION_TIER_VAESAVX2,
        AREION_TIER_AVX512,
        AREION_TIER_ARM64
    };
    static const char *const all_tier_names[] = {
        "purec", "aesni", "vex", "vaesavx2", "avx512", "arm64"
    };
    size_t num_supported = 0;
    size_t t, a, b, k, i;

    for (t = 0; t < sizeof(all_tiers) / sizeof(all_tiers[0]); t++) {
        areion_tier_t tier = all_tiers[t];
        uint8_t want_bytes[512];

        if (!areion_tier_supported(tier)) {
            continue;
        }
        if (!areion_set_tier_override(tier)) {
            (void)fprintf(stderr, "FAIL: areion_set_tier_override(%d) failed\n", (int)tier);
            g_failures++;
            continue;
        }
        if (strcmp(areion_tier(), all_tier_names[t]) != 0 || areion_tier_code() != tier) {
            (void)fprintf(stderr, "FAIL: tier introspection mismatch for %s\n", all_tier_names[t]);
            g_failures++;
        }

        memset(&g_tier_kats[num_supported], 0, sizeof(g_tier_kats[0]));
        g_tier_kats[num_supported].tier_name = all_tier_names[t];
        g_tier_kats[num_supported].tier_code = tier;
        g_kat_capture = &g_tier_kats[num_supported];
        (void)dump_kat_for_tier(NULL);
        g_kat_capture = NULL;

        if (g_tier_kats[num_supported].count != AREION_KAT_ENTRY_COUNT) {
            (void)fprintf(stderr, "FAIL: captured %u KAT entries on tier %s, expected %u\n",
                    (unsigned)g_tier_kats[num_supported].count, all_tier_names[t], (unsigned)AREION_KAT_ENTRY_COUNT);
            g_failures++;
        }

        for (k = 0; k < AREION_KAT_ENTRY_COUNT; k++) {
            const kat_entry_t *e = &g_tier_kats[num_supported].entries[k];
            const char *hex = k_canonical_kats[k].hex_expected;
            size_t hex_len = strlen(hex);
            if (strcmp(e->name, k_canonical_kats[k].name) != 0 || hex_len != e->len * 2U) {
                (void)fprintf(stderr, "FAIL [%s]: KAT metadata mismatch at idx %u (%s)\n",
                        all_tier_names[t], (unsigned)k, e->name);
                g_failures++;
                continue;
            }
            for (i = 0; i < e->len; i++) {
                want_bytes[i] = (uint8_t)((hex_nibble(hex[2U * i]) << 4U) | hex_nibble(hex[2U * i + 1U]));
            }
            check_bytes_eq(e->name, e->data, want_bytes, e->len);
        }
        num_supported++;
    }

    printf("Testing pairwise tier_A x tier_B KAT matrix (%u tiers, %u functions) ... ",
           (unsigned)num_supported, (unsigned)AREION_KAT_ENTRY_COUNT);
    (void)fflush(stdout);

    for (a = 0; a < num_supported; a++) {
        for (b = 0; b < num_supported; b++) {
            for (k = 0; k < AREION_KAT_ENTRY_COUNT; k++) {
                const kat_entry_t *ea = &g_tier_kats[a].entries[k];
                const kat_entry_t *eb = &g_tier_kats[b].entries[k];
                if (ea->len != eb->len || memcmp(ea->data, eb->data, ea->len) != 0) {
                    (void)fprintf(stderr, "FAIL: pairwise tier matrix mismatch [%s <-> %s] on %s\n",
                            g_tier_kats[a].tier_name, g_tier_kats[b].tier_name, ea->name);
                    g_failures++;
                }
            }
        }
    }
    printf("OK\n");
}

static volatile uint8_t g_bench_sink = 0;

#define AREION_BENCH_OP(label, bytes_per_op, call_expr) \
    do { \
        size_t iters_ = (areion_tier_code() == AREION_TIER_PUREC) ? 16384U : 262144U; \
        double secs_ = 0.0; \
        for (;;) { \
            size_t i_; \
            clock_t t0_ = clock(); \
            for (i_ = 0; i_ < iters_; i_++) { \
                call_expr; \
            } \
            clock_t t1_ = clock(); \
            secs_ = (double)(t1_ - t0_) / (double)CLOCKS_PER_SEC; \
            if (secs_ >= 0.08 || iters_ >= (1U << 28U)) { \
                break; \
            } \
            if (secs_ < 0.005) { \
                iters_ *= 16U; \
            } else if (secs_ < 0.025) { \
                iters_ *= 4U; \
            } else { \
                iters_ *= 2U; \
            } \
        } \
        if (secs_ > 0.0) { \
            double ns_per_op_ = (secs_ * 1e9) / (double)iters_; \
            double mb_per_s_ = ((double)iters_ * (double)(bytes_per_op) / 1e6) / secs_; \
            printf("  %-28s : %8.1f MB/s (%8.2f ns/op)\n", (label), mb_per_s_, ns_per_op_); \
        } \
    } while (0)

static void run_benchmarks_part1(void) {
    uint8_t state256[32] = {0};
    uint8_t state512[64] = {0};
    uint8_t in256[32] = {0};
    uint8_t in512[64] = {0};
    uint8_t out256[32] = {0};
    uint8_t out512[64] = {0};
    uint8_t key256[64] = {0};
    uint8_t key512[128] = {0};
    uint8_t b256[4][32] = {{0}};
    uint8_t b512[4][64] = {{0}};
    uint8_t keys256x4[4][64] = {{0}};
    uint8_t keys512x4[4][128] = {{0}};
    uint8_t in256x4[4][32] = {{0}};
    uint8_t in512x4[4][64] = {{0}};
    uint8_t out256x4[4][32] = {{0}};
    uint8_t out512x4[4][64] = {{0}};

    AREION_BENCH_OP("areion_permute256", 32U, areion_permute256(state256));
    AREION_BENCH_OP("areion_permute512", 64U, areion_permute512(state512));
    AREION_BENCH_OP("areion_inverse_permute256", 32U, areion_inverse_permute256(state256));
    AREION_BENCH_OP("areion_inverse_permute512", 64U, areion_inverse_permute512(state512));
    AREION_BENCH_OP("areion_permute256_p2", 32U, areion_permute256_p2(state256));
    AREION_BENCH_OP("areion_permute512_p2", 64U, areion_permute512_p2(state512));
    AREION_BENCH_OP("areion_inverse_permute256_p2", 32U, areion_inverse_permute256_p2(state256));
    AREION_BENCH_OP("areion_inverse_permute512_p2", 64U, areion_inverse_permute512_p2(state512));
    AREION_BENCH_OP("areion_dm256", 32U, areion_dm256(out256, in256));
    AREION_BENCH_OP("areion_dm512", 64U, areion_dm512(out256, in512));
    AREION_BENCH_OP("areion_soem256", 32U, areion_soem256(out256, key256, in256));
    AREION_BENCH_OP("areion_soem512", 64U, areion_soem512(out512, key512, in512));
    AREION_BENCH_OP("areion_permute256x4", 128U, areion_permute256x4(b256[0], b256[1], b256[2], b256[3]));
    AREION_BENCH_OP("areion_permute512x4", 256U, areion_permute512x4(b512[0], b512[1], b512[2], b512[3]));
    AREION_BENCH_OP("areion_inverse_permute256x4", 128U, areion_inverse_permute256x4(b256[0], b256[1], b256[2], b256[3]));
    AREION_BENCH_OP("areion_inverse_permute512x4", 256U, areion_inverse_permute512x4(b512[0], b512[1], b512[2], b512[3]));
    AREION_BENCH_OP("areion_permute256_p2x4", 128U, areion_permute256_p2x4(b256[0], b256[1], b256[2], b256[3]));
    AREION_BENCH_OP("areion_permute512_p2x4", 256U, areion_permute512_p2x4(b512[0], b512[1], b512[2], b512[3]));
    AREION_BENCH_OP("areion_inverse_permute256_p2x4", 128U, areion_inverse_permute256_p2x4(b256[0], b256[1], b256[2], b256[3]));
    AREION_BENCH_OP("areion_inverse_permute512_p2x4", 256U, areion_inverse_permute512_p2x4(b512[0], b512[1], b512[2], b512[3]));
    AREION_BENCH_OP("areion_soem256x4", 128U, areion_soem256x4(out256x4, keys256x4, in256x4));
    AREION_BENCH_OP("areion_soem512x4", 256U, areion_soem512x4(out512x4, keys512x4, in512x4));
    AREION_BENCH_OP("areion_em_encrypt256", 32U, areion_em_encrypt256(out256, key256, in256));
    AREION_BENCH_OP("areion_em_decrypt256", 32U, areion_em_decrypt256(out256, key256, in256));
    AREION_BENCH_OP("areion_em_encrypt512", 64U, areion_em_encrypt512(out512, key512, in512));
    AREION_BENCH_OP("areion_em_decrypt512", 64U, areion_em_decrypt512(out512, key512, in512));

    g_bench_sink ^= state256[0];
    g_bench_sink ^= state512[0];
    g_bench_sink ^= out256[0];
    g_bench_sink ^= out512[0];
    g_bench_sink ^= b256[0][0];
    g_bench_sink ^= b512[0][0];
    g_bench_sink ^= out256x4[0][0];
    g_bench_sink ^= out512x4[0][0];
}

static void run_benchmarks_part2(void) {
    uint8_t in256[32] = {0};
    uint8_t in512[64] = {0};
    uint8_t out256[32] = {0};
    uint8_t out512[64] = {0};
    uint8_t key256[64] = {0};
    uint8_t key512[128] = {0};
    uint8_t keys256x4[4][64] = {{0}};
    uint8_t keys512x4[4][128] = {{0}};
    uint8_t in256x4[4][32] = {{0}};
    uint8_t in512x4[4][64] = {{0}};
    uint8_t out256x4[4][32] = {{0}};
    uint8_t out512x4[4][64] = {{0}};

    AREION_BENCH_OP("areion_em_encrypt256x4", 128U, areion_em_encrypt256x4(out256x4, keys256x4, in256x4));
    AREION_BENCH_OP("areion_em_decrypt256x4", 128U, areion_em_decrypt256x4(out256x4, keys256x4, in256x4));
    AREION_BENCH_OP("areion_em_encrypt512x4", 256U, areion_em_encrypt512x4(out512x4, keys512x4, in512x4));
    AREION_BENCH_OP("areion_em_decrypt512x4", 256U, areion_em_decrypt512x4(out512x4, keys512x4, in512x4));
    AREION_BENCH_OP("areion_em2_encrypt256", 32U, areion_em2_encrypt256(out256, key256, in256));
    AREION_BENCH_OP("areion_em2_decrypt256", 32U, areion_em2_decrypt256(out256, key256, in256));
    AREION_BENCH_OP("areion_em2_encrypt512", 64U, areion_em2_encrypt512(out512, key512, in512));
    AREION_BENCH_OP("areion_em2_decrypt512", 64U, areion_em2_decrypt512(out512, key512, in512));
    AREION_BENCH_OP("areion_em2_encrypt256x4", 128U, areion_em2_encrypt256x4(out256x4, keys256x4, in256x4));
    AREION_BENCH_OP("areion_em2_decrypt256x4", 128U, areion_em2_decrypt256x4(out256x4, keys256x4, in256x4));
    AREION_BENCH_OP("areion_em2_encrypt512x4", 256U, areion_em2_encrypt512x4(out512x4, keys512x4, in512x4));
    AREION_BENCH_OP("areion_em2_decrypt512x4", 256U, areion_em2_decrypt512x4(out512x4, keys512x4, in512x4));
    AREION_BENCH_OP("areion_tem_encrypt256", 32U, areion_tem_encrypt256(out256, key256, in256, in256));
    AREION_BENCH_OP("areion_tem_decrypt256", 32U, areion_tem_decrypt256(out256, key256, in256, in256));
    AREION_BENCH_OP("areion_tem_encrypt512", 64U, areion_tem_encrypt512(out512, key512, in512, in512));
    AREION_BENCH_OP("areion_tem_decrypt512", 64U, areion_tem_decrypt512(out512, key512, in512, in512));
    AREION_BENCH_OP("areion_tem_encrypt256x4", 128U, areion_tem_encrypt256x4(out256x4, keys256x4, in256x4, in256x4));
    AREION_BENCH_OP("areion_tem_decrypt256x4", 128U, areion_tem_decrypt256x4(out256x4, keys256x4, in256x4, in256x4));

    g_bench_sink ^= out256[0];
    g_bench_sink ^= out512[0];
    g_bench_sink ^= out256x4[0][0];
    g_bench_sink ^= out512x4[0][0];
}

static void run_benchmarks_part3(void) {
    uint8_t in256[32] = {0};
    uint8_t in512[64] = {0};
    uint8_t out256[32] = {0};
    uint8_t out512[64] = {0};
    uint8_t key256[64] = {0};
    uint8_t key512[128] = {0};
    uint8_t keys256x4[4][64] = {{0}};
    uint8_t keys512x4[4][128] = {{0}};
    uint8_t in256x4[4][32] = {{0}};
    uint8_t in512x4[4][64] = {{0}};
    uint8_t out256x4[4][32] = {{0}};
    uint8_t out512x4[4][64] = {{0}};
    uint8_t blk16[16] = {0};
    uint8_t rk16[16] = {0};
    uint8_t blk4[4][16] = {{0}};
    uint8_t rk4[4][16] = {{0}};
    uint8_t key16[16] = {0};
    uint8_t rk128[11][16] = {{0}};
    rijndael256_rk_t rk256;
    memset(&rk256, 0, sizeof(rk256));
    rijndael256_expand_key(in256, &rk256);

    AREION_BENCH_OP("areion_tem_encrypt512x4", 256U, areion_tem_encrypt512x4(out512x4, keys512x4, in512x4, in512x4));
    AREION_BENCH_OP("areion_tem_decrypt512x4", 256U, areion_tem_decrypt512x4(out512x4, keys512x4, in512x4, in512x4));
    AREION_BENCH_OP("areion_tem2_encrypt256", 32U, areion_tem2_encrypt256(out256, key256, in256, in256));
    AREION_BENCH_OP("areion_tem2_decrypt256", 32U, areion_tem2_decrypt256(out256, key256, in256, in256));
    AREION_BENCH_OP("areion_tem2_encrypt512", 64U, areion_tem2_encrypt512(out512, key512, in512, in512));
    AREION_BENCH_OP("areion_tem2_decrypt512", 64U, areion_tem2_decrypt512(out512, key512, in512, in512));
    AREION_BENCH_OP("areion_tem2_encrypt256x4", 128U, areion_tem2_encrypt256x4(out256x4, keys256x4, in256x4, in256x4));
    AREION_BENCH_OP("areion_tem2_decrypt256x4", 128U, areion_tem2_decrypt256x4(out256x4, keys256x4, in256x4, in256x4));
    AREION_BENCH_OP("areion_tem2_encrypt512x4", 256U, areion_tem2_encrypt512x4(out512x4, keys512x4, in512x4, in512x4));
    AREION_BENCH_OP("areion_tem2_decrypt512x4", 256U, areion_tem2_decrypt512x4(out512x4, keys512x4, in512x4, in512x4));
    {
        uint8_t asura_rk[13][32] = {{0}};
        AREION_BENCH_OP("areion_asura_expand_tweakey", 32U, areion_asura_expand_tweakey(asura_rk, key256, key16));
        AREION_BENCH_OP("areion_asura_encrypt", 32U, areion_asura_encrypt(out256, in256, asura_rk));
        AREION_BENCH_OP("areion_asura_decrypt", 32U, areion_asura_decrypt(out256, in256, asura_rk));
        AREION_BENCH_OP("areion_asura_encryptx4", 128U, areion_asura_encryptx4(out256x4, in256x4, asura_rk));
        AREION_BENCH_OP("areion_asura_decryptx4", 128U, areion_asura_decryptx4(out256x4, in256x4, asura_rk));
        AREION_BENCH_OP("areion_asura_encrypt_otf", 32U, areion_asura_encrypt_otf(out256, in256, key256, key16));
        AREION_BENCH_OP("areion_asura_decrypt_otf", 32U, areion_asura_decrypt_otf(out256, in256, key256, key16));
        AREION_BENCH_OP("areion_asura_encryptx4_otf", 128U, areion_asura_encryptx4_otf(out256x4, in256x4, key256, blk4));
        AREION_BENCH_OP("areion_asura_decryptx4_otf", 128U, areion_asura_decryptx4_otf(out256x4, in256x4, key256, blk4));
        AREION_BENCH_OP("areion_asura_expand_key", 32U, areion_asura_expand_key(asura_rk, key256));
        AREION_BENCH_OP("areion_asura_encrypt_rk", 32U, areion_asura_encrypt_rk(out256, in256, asura_rk, key16));
        AREION_BENCH_OP("areion_asura_decrypt_rk", 32U, areion_asura_decrypt_rk(out256, in256, asura_rk, key16));
        AREION_BENCH_OP("areion_asura_encryptx4_rk", 128U, areion_asura_encryptx4_rk(out256x4, in256x4, asura_rk, blk4));
        AREION_BENCH_OP("areion_asura_decryptx4_rk", 128U, areion_asura_decryptx4_rk(out256x4, in256x4, asura_rk, blk4));
        g_bench_sink ^= asura_rk[0][0];
    }
    AREION_BENCH_OP("areion_aes128_round", 16U, areion_aes128_round(blk16, rk16));
    AREION_BENCH_OP("areion_aes128_round4", 64U, areion_aes128_round4(blk4[0], blk4[1], blk4[2], blk4[3], rk4[0], rk4[1], rk4[2], rk4[3]));
    AREION_BENCH_OP("areion_expand_key128", 176U, areion_expand_key128(key16, rk128));
    AREION_BENCH_OP("areion_aes128_encrypt_block", 16U, areion_aes128_encrypt_block(blk16, blk16, rk128));
    AREION_BENCH_OP("areion_aes128_encrypt4_blocks", 64U, areion_aes128_encrypt4_blocks(blk4, blk4, rk128));
    AREION_BENCH_OP("Rijndael256EncryptBlockHW", 32U, areion_rijndael256_encrypt_block_hw(out256, in256, (const uint8_t (*)[32])rk256.rk));
    AREION_BENCH_OP("Rijndael256Encrypt4BlocksHW", 128U, areion_rijndael256_encrypt4_blocks_hw(out256x4, (const uint8_t (*)[32])in256x4, (const uint8_t (*)[32])rk256.rk));
    AREION_BENCH_OP("Vistrutah256_10r", 32U, areion_vistrutah256_encrypt_block_hw(out256, in256, key256, 10));
    AREION_BENCH_OP("Vistrutah256_14r", 32U, areion_vistrutah256_encrypt_block_hw(out256, in256, key256, 14));
    AREION_BENCH_OP("Vistrutah256x4_10r", 128U, areion_vistrutah256_encrypt4_blocks_hw(out256x4, (const uint8_t (*)[32])in256x4, key256, 10));
    AREION_BENCH_OP("Vistrutah256x4_14r", 128U, areion_vistrutah256_encrypt4_blocks_hw(out256x4, (const uint8_t (*)[32])in256x4, key256, 14));
    AREION_BENCH_OP("Vistrutah512_256_10r", 64U, areion_vistrutah512_encrypt_block_256_hw(out512, in512, key256, 10));
    AREION_BENCH_OP("Vistrutah512_256_14r", 64U, areion_vistrutah512_encrypt_block_256_hw(out512, in512, key256, 14));
    AREION_BENCH_OP("Vistrutah512_256_18r", 64U, areion_vistrutah512_encrypt_block_256_hw(out512, in512, key256, 18));
    AREION_BENCH_OP("Vistrutah512_512_12r", 64U, areion_vistrutah512_encrypt_block_512_hw(out512, in512, key512, 12));
    AREION_BENCH_OP("Vistrutah512_512_18r", 64U, areion_vistrutah512_encrypt_block_512_hw(out512, in512, key512, 18));
    AREION_BENCH_OP("Vistrutah512x4_256_10r", 256U, areion_vistrutah512_encrypt4_blocks_256_hw(out512x4, (const uint8_t (*)[64])in512x4, key256, 10));
    AREION_BENCH_OP("Vistrutah512x4_256_14r", 256U, areion_vistrutah512_encrypt4_blocks_256_hw(out512x4, (const uint8_t (*)[64])in512x4, key256, 14));
    AREION_BENCH_OP("Vistrutah512x4_256_18r", 256U, areion_vistrutah512_encrypt4_blocks_256_hw(out512x4, (const uint8_t (*)[64])in512x4, key256, 18));
    AREION_BENCH_OP("Vistrutah512x4_512_12r", 256U, areion_vistrutah512_encrypt4_blocks_512_hw(out512x4, (const uint8_t (*)[64])in512x4, key512, 12));
    AREION_BENCH_OP("Vistrutah512x4_512_18r", 256U, areion_vistrutah512_encrypt4_blocks_512_hw(out512x4, (const uint8_t (*)[64])in512x4, key512, 18));

    g_bench_sink ^= out256[0];
    g_bench_sink ^= out512[0];
    g_bench_sink ^= out256x4[0][0];
    g_bench_sink ^= out512x4[0][0];
    g_bench_sink ^= blk16[0];
    g_bench_sink ^= blk4[0][0];
    g_bench_sink ^= rk128[0][0];
}

static void run_benchmarks(void) {
    printf("Benchmarking active tier: %s\n", areion_tier());
    run_benchmarks_part1();
    run_benchmarks_part2();
    run_benchmarks_part3();
}

#if AREION_HAS_PTHREAD_TEST
typedef struct {
    uint8_t exp_perm256[32];
    uint8_t key256[64];
    uint8_t in256[32];
    uint8_t exp_soem256[32];
    uint8_t keys512x4[4][128];
    uint8_t in512x4[4][64];
    uint8_t exp_soem512x4[4][64];
    int thread_errors;
} mt_worker_ctx_t;

static void *mt_worker_fn(void *arg) {
    mt_worker_ctx_t *ctx = (mt_worker_ctx_t *)arg;
    uint8_t s256[32], out256[32], out512x4[4][64];
    size_t iter;

    for (iter = 0; iter < 128U; iter++) {
        const char *tname = areion_tier();
        if (tname == NULL || tname[0] == '\0' || !areion_tier_supported(areion_tier_code())) {
            ctx->thread_errors++;
            break;
        }
        memset(s256, 0, sizeof(s256));
        areion_permute256(s256);
        if (memcmp(s256, ctx->exp_perm256, 32) != 0) {
            ctx->thread_errors++;
            break;
        }
        areion_soem256(out256, ctx->key256, ctx->in256);
        if (memcmp(out256, ctx->exp_soem256, 32) != 0) {
            ctx->thread_errors++;
            break;
        }
        areion_soem512x4(out512x4, ctx->keys512x4, ctx->in512x4);
        if (memcmp(out512x4, ctx->exp_soem512x4, sizeof(out512x4)) != 0) {
            ctx->thread_errors++;
            break;
        }
    }
    return NULL;
}

static void test_multithreaded_dispatch(void) {
    pthread_t threads[8];
    mt_worker_ctx_t ctxs[8];
    size_t i, m;

    (void)areion_set_tier_override(AREION_TIER_AUTO);
    for (i = 0; i < 8U; i++) {
        memset(&ctxs[i], 0, sizeof(ctxs[i]));
        areion_permute256(ctxs[i].exp_perm256);
        fill_pattern(ctxs[i].key256, 64, (uint8_t)(0x11U + i));
        fill_pattern(ctxs[i].in256, 32, (uint8_t)(0x21U + i));
        areion_soem256(ctxs[i].exp_soem256, ctxs[i].key256, ctxs[i].in256);
        for (m = 0; m < 4U; m++) {
            fill_pattern(ctxs[i].keys512x4[m], 128, (uint8_t)(0x31U + i * 4U + m));
            fill_pattern(ctxs[i].in512x4[m], 64, (uint8_t)(0x61U + i * 4U + m));
        }
        areion_soem512x4(ctxs[i].exp_soem512x4, ctxs[i].keys512x4, ctxs[i].in512x4);
    }

    printf("Testing 8-thread concurrent dispatch (%s) ... ", areion_tier());
    (void)fflush(stdout);
    for (i = 0; i < 8U; i++) {
        if (pthread_create(&threads[i], NULL, mt_worker_fn, &ctxs[i]) != 0) {
            (void)fprintf(stderr, "FAIL: pthread_create failed on thread %u\n", (unsigned)i);
            g_failures++;
            return;
        }
    }
    for (i = 0; i < 8U; i++) {
        (void)pthread_join(threads[i], NULL);
        if (ctxs[i].thread_errors != 0) {
            (void)fprintf(stderr, "FAIL: thread %u reported %d error(s)\n", (unsigned)i, ctxs[i].thread_errors);
            g_failures++;
        }
    }
    printf("OK\n");
}
#endif

/* =========================================================================
 * Industrial Hardening Tests:
 * 1. Public areion_zeroize() & FIPS 140-3 areion_selftest()
 * 2. Windows x64 ABI (XMM6..XMM15, RSI, RDI) Preservation
 * 3. Unaligned (+1, +2, +3, +7) & In-Place (in == out) Overlap Across All APIs
 * 4. TIMECOP / Valgrind Memcheck Constant-Time Verification
 * 5. Statistical dudect Welch's t-Test (fix vs random)
 * ========================================================================= */

static void test_zeroize_and_selftest_api(void) {
    uint8_t buf[96];
    size_t i;

    areion_zeroize(NULL, 0);
    areion_zeroize(NULL, 32);
    for (i = 0; i < sizeof(buf); i++) {
        buf[i] = (uint8_t)(0x3CU ^ (uint8_t)(i * 5U));
    }
    areion_zeroize(buf, 0);
    for (i = 0; i < sizeof(buf); i++) {
        if (buf[i] != (uint8_t)(0x3CU ^ (uint8_t)(i * 5U))) {
            (void)fprintf(stderr, "FAIL [%s]: areion_zeroize(buf, 0) modified byte %u\n", areion_tier(), (unsigned)i);
            g_failures++;
        }
    }
    areion_zeroize(buf + 5, 43);
    for (i = 0; i < sizeof(buf); i++) {
        uint8_t want = (i >= 5U && i < 48U) ? 0U : (uint8_t)(0x3CU ^ (uint8_t)(i * 5U));
        if (buf[i] != want) {
            (void)fprintf(stderr, "FAIL [%s]: areion_zeroize(buf+5, 43) byte %u mismatch\n", areion_tier(), (unsigned)i);
            g_failures++;
        }
    }
    areion_zeroize(buf, sizeof(buf));
    for (i = 0; i < sizeof(buf); i++) {
        if (buf[i] != 0U) {
            (void)fprintf(stderr, "FAIL [%s]: areion_zeroize full scrub byte %u != 0\n", areion_tier(), (unsigned)i);
            g_failures++;
        }
    }
    if (areion_selftest() != 0) {
        (void)fprintf(stderr, "FAIL [%s]: areion_selftest() failed\n", areion_tier());
        g_failures++;
    }
}

#if defined(_WIN64) && (defined(__x86_64__) || defined(_M_X64)) && (defined(__GNUC__) || defined(__clang__))
typedef void (*win64_cb_fn_t)(void *ctx);

typedef struct {
    win64_cb_fn_t fn;
    void *ctx;
    const uint8_t (*xmm_want)[16];
    const uint64_t *gpr_want;
    uint64_t *gpr_got;
    uint8_t (*xmm_got)[16];
} win64_check_args_t;

static AREION_NOINLINE void win64_invoke_check(const char *label, win64_cb_fn_t fn, void *ctx) {
    AREION_ALIGN64 uint8_t xmm_want[10][16];
    AREION_ALIGN64 uint8_t xmm_got[10][16];
    const uint64_t gpr_want[2] = { 0xCAFEBABE11223344ULL, 0xDEADBEEF55667788ULL };
    uint64_t gpr_got[2];
    win64_check_args_t args;
    size_t r, b;

    gpr_got[0] = 0ULL;
    gpr_got[1] = 0ULL;
    for (r = 0; r < 10U; r++) {
        for (b = 0; b < 16U; b++) {
            xmm_want[r][b] = (uint8_t)(0xA0U + r * 17U + b * 3U);
            xmm_got[r][b] = 0U;
        }
    }

    args.fn = fn;
    args.ctx = ctx;
    args.xmm_want = (const uint8_t (*)[16])xmm_want;
    args.gpr_want = gpr_want;
    args.gpr_got = gpr_got;
    args.xmm_got = xmm_got;

    __asm__ __volatile__(
        "movq 16(%%rbx), %%rax\n\t"
        "movdqu 0(%%rax), %%xmm6\n\t"
        "movdqu 16(%%rax), %%xmm7\n\t"
        "movdqu 32(%%rax), %%xmm8\n\t"
        "movdqu 48(%%rax), %%xmm9\n\t"
        "movdqu 64(%%rax), %%xmm10\n\t"
        "movdqu 80(%%rax), %%xmm11\n\t"
        "movdqu 96(%%rax), %%xmm12\n\t"
        "movdqu 112(%%rax), %%xmm13\n\t"
        "movdqu 128(%%rax), %%xmm14\n\t"
        "movdqu 144(%%rax), %%xmm15\n\t"
        "movq 24(%%rbx), %%rax\n\t"
        "movq 0(%%rax), %%rsi\n\t"
        "movq 8(%%rax), %%rdi\n\t"
        "subq $32, %%rsp\n\t"
        "movq 8(%%rbx), %%rcx\n\t"
        "call *0(%%rbx)\n\t"
        "addq $32, %%rsp\n\t"
        "movq 32(%%rbx), %%rax\n\t"
        "movq %%rsi, 0(%%rax)\n\t"
        "movq %%rdi, 8(%%rax)\n\t"
        "movq 40(%%rbx), %%rax\n\t"
        "movdqu %%xmm6, 0(%%rax)\n\t"
        "movdqu %%xmm7, 16(%%rax)\n\t"
        "movdqu %%xmm8, 32(%%rax)\n\t"
        "movdqu %%xmm9, 48(%%rax)\n\t"
        "movdqu %%xmm10, 64(%%rax)\n\t"
        "movdqu %%xmm11, 80(%%rax)\n\t"
        "movdqu %%xmm12, 96(%%rax)\n\t"
        "movdqu %%xmm13, 112(%%rax)\n\t"
        "movdqu %%xmm14, 128(%%rax)\n\t"
        "movdqu %%xmm15, 144(%%rax)\n\t"
        :
        : "b"(&args)
        : "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10", "r11",
          "xmm0", "xmm1", "xmm2", "xmm3", "xmm4", "xmm5",
          "xmm6", "xmm7", "xmm8", "xmm9", "xmm10", "xmm11", "xmm12", "xmm13", "xmm14", "xmm15",
          "cc", "memory"
    );

    if (gpr_got[0] != gpr_want[0] || gpr_got[1] != gpr_want[1]) {
        (void)fprintf(stderr, "FAIL [%s/_WIN64]: %s clobbered RSI/RDI\n", areion_tier(), label);
        g_failures++;
    }
    if (memcmp(xmm_got, xmm_want, sizeof(xmm_want)) != 0) {
        (void)fprintf(stderr, "FAIL [%s/_WIN64]: %s clobbered XMM6..XMM15\n", areion_tier(), label);
        g_failures++;
    }
}

static void win64_cb_all(void *ctx) {
    uint8_t s256[32] = {0}, s512[64] = {0}, k256[64] = {0}, k512[128] = {0}, t256[32] = {0}, t512[64] = {0};
    uint8_t b256[4][32] = {{0}}, b512[4][64] = {{0}};
    uint8_t k256x4[4][64] = {{0}}, k512x4[4][128] = {{0}};
    uint8_t t256x4[4][32] = {{0}}, t512x4[4][64] = {{0}};
    uint8_t rk256_raw[15][32] = {{0}}, asura_rk[13][32] = {{0}}, tw16[16] = {0}, tw16x4[4][16] = {{0}};
    (void)ctx;
    areion_permute256(s256);
    areion_inverse_permute256(s256);
    areion_permute512(s512);
    areion_inverse_permute512(s512);
    areion_dm256(s256, s256);
    areion_dm512(s256, s512);
    areion_soem256(s256, k256, s256);
    areion_soem512(s512, k512, s512);
    areion_permute256x4(b256[0], b256[1], b256[2], b256[3]);
    areion_inverse_permute256x4(b256[0], b256[1], b256[2], b256[3]);
    areion_permute512x4(b512[0], b512[1], b512[2], b512[3]);
    areion_inverse_permute512x4(b512[0], b512[1], b512[2], b512[3]);
    areion_soem256x4(b256, k256x4, b256);
    areion_soem512x4(b512, k512x4, b512);
    areion_em_encrypt256(s256, k256, s256);
    areion_em_decrypt256(s256, k256, s256);
    areion_em_encrypt512(s512, k512, s512);
    areion_em_decrypt512(s512, k512, s512);
    areion_em2_encrypt256(s256, k256, s256);
    areion_em2_decrypt256(s256, k256, s256);
    areion_em2_encrypt512(s512, k512, s512);
    areion_em2_decrypt512(s512, k512, s512);
    areion_tem_encrypt256(s256, k256, t256, s256);
    areion_tem_decrypt256(s256, k256, t256, s256);
    areion_tem_encrypt512(s512, k512, t512, s512);
    areion_tem_decrypt512(s512, k512, t512, s512);
    areion_tem2_encrypt256(s256, k256, t256, s256);
    areion_tem2_decrypt256(s256, k256, t256, s256);
    areion_tem2_encrypt512(s512, k512, t512, s512);
    areion_tem2_decrypt512(s512, k512, t512, s512);
    areion_em_encrypt256x4(b256, k256x4, b256);
    areion_em_decrypt256x4(b256, k256x4, b256);
    areion_em_encrypt512x4(b512, k512x4, b512);
    areion_em_decrypt512x4(b512, k512x4, b512);
    areion_em2_encrypt256x4(b256, k256x4, b256);
    areion_em2_decrypt256x4(b256, k256x4, b256);
    areion_em2_encrypt512x4(b512, k512x4, b512);
    areion_em2_decrypt512x4(b512, k512x4, b512);
    areion_tem_encrypt256x4(b256, k256x4, t256x4, b256);
    areion_tem_decrypt256x4(b256, k256x4, t256x4, b256);
    areion_tem_encrypt512x4(b512, k512x4, t512x4, b512);
    areion_tem_decrypt512x4(b512, k512x4, t512x4, b512);
    areion_tem2_encrypt256x4(b256, k256x4, t256x4, b256);
    areion_tem2_decrypt256x4(b256, k256x4, t256x4, b256);
    areion_tem2_encrypt512x4(b512, k512x4, t512x4, b512);
    areion_tem2_decrypt512x4(b512, k512x4, t512x4, b512);
    areion_rijndael256_encrypt_block_hw(s256, s256, (const uint8_t (*)[32])rk256_raw);
    areion_vistrutah256_encrypt_block_hw(s256, s256, k256, 10);
    areion_asura_expand_tweakey_hw(asura_rk, s256, tw16);
    areion_asura_encrypt_block_hw(s256, s256, (const uint8_t (*)[32])asura_rk);
    areion_asura_decrypt_block_hw(s256, s256, (const uint8_t (*)[32])asura_rk);
    areion_asura_encrypt_block_otf_hw(s256, s256, k256, tw16);
    areion_asura_decrypt_block_otf_hw(s256, s256, k256, tw16);
    areion_asura_encrypt_4blocks_hw(b256, (const uint8_t (*)[32])b256, (const uint8_t (*)[32])asura_rk);
    areion_asura_decrypt_4blocks_hw(b256, (const uint8_t (*)[32])b256, (const uint8_t (*)[32])asura_rk);
    areion_asura_encrypt_4blocks_otf_hw(b256, (const uint8_t (*)[32])b256, k256, (const uint8_t (*)[16])tw16x4);
    areion_asura_decrypt_4blocks_otf_hw(b256, (const uint8_t (*)[32])b256, k256, (const uint8_t (*)[16])tw16x4);
    areion_asura_expand_key_hw(asura_rk, s256);
    areion_asura_encrypt_block_rk_hw(s256, s256, (const uint8_t (*)[32])asura_rk, tw16);
    areion_asura_decrypt_block_rk_hw(s256, s256, (const uint8_t (*)[32])asura_rk, tw16);
    areion_asura_encrypt_4blocks_rk_hw(b256, (const uint8_t (*)[32])b256, (const uint8_t (*)[32])asura_rk, (const uint8_t (*)[16])tw16x4);
    areion_asura_decrypt_4blocks_rk_hw(b256, (const uint8_t (*)[32])b256, (const uint8_t (*)[32])asura_rk, (const uint8_t (*)[16])tw16x4);
}
#endif

static void test_win64_callee_saved_abi(void) {
#if defined(_WIN64) && (defined(__x86_64__) || defined(_M_X64)) && (defined(__GNUC__) || defined(__clang__))
    win64_invoke_check("all_primitives_win64_abi", win64_cb_all, NULL);
#endif
}

static void test_unaligned_and_overlap_all(void) {
    static const size_t offsets[4] = { 1U, 2U, 3U, 7U };
    uint8_t raw_a[640], raw_b[640], raw_c[640], raw_d[640];
    uint8_t ref256[32], ref512[64], ref256x4[4][32], ref512x4[4][64];
    uint8_t k256[64], t256[32], m256[32];
    uint8_t k512[128], t512[64], m512[64];
    uint8_t k256x4[4][64], t256x4[4][32], m256x4[4][32];
    uint8_t k512x4[4][128], t512x4[4][64], m512x4[4][64];
    size_t idx, lane;

    fill_pattern(k256, 64, 0x11U);
    fill_pattern(t256, 32, 0x22U);
    fill_pattern(m256, 32, 0x33U);
    fill_pattern(k512, 128, 0x44U);
    fill_pattern(t512, 64, 0x55U);
    fill_pattern(m512, 64, 0x66U);
    for (lane = 0; lane < 4U; lane++) {
        fill_pattern(k256x4[lane], 64, (uint8_t)(0x70U + lane));
        fill_pattern(t256x4[lane], 32, (uint8_t)(0x80U + lane));
        fill_pattern(m256x4[lane], 32, (uint8_t)(0x90U + lane));
        fill_pattern(k512x4[lane], 128, (uint8_t)(0xA0U + lane));
        fill_pattern(t512x4[lane], 64, (uint8_t)(0xB0U + lane));
        fill_pattern(m512x4[lane], 64, (uint8_t)(0xC0U + lane));
    }

    for (idx = 0; idx < 4U; idx++) {
        size_t off = offsets[idx];
        uint8_t *pa = raw_a + off;
        uint8_t *pb = raw_b + off;
        uint8_t *pc = raw_c + off;
        uint8_t *pd = raw_d + off;

        /* Permute256 / InversePermute256 / P2 unaligned */
        memcpy(ref256, m256, 32);
        areion_permute256(ref256);
        memcpy(pa, m256, 32);
        areion_permute256(pa);
        check_bytes_eq("unaligned permute256", pa, ref256, 32);
        areion_inverse_permute256(pa);
        check_bytes_eq("unaligned inverse_permute256", pa, m256, 32);

        memcpy(ref256, m256, 32);
        areion_permute256_p2(ref256);
        memcpy(pa, m256, 32);
        areion_permute256_p2(pa);
        check_bytes_eq("unaligned permute256_p2", pa, ref256, 32);
        areion_inverse_permute256_p2(pa);
        check_bytes_eq("unaligned inverse_permute256_p2", pa, m256, 32);

        /* Permute512 / InversePermute512 / P2 unaligned */
        memcpy(ref512, m512, 64);
        areion_permute512(ref512);
        memcpy(pa, m512, 64);
        areion_permute512(pa);
        check_bytes_eq("unaligned permute512", pa, ref512, 64);
        areion_inverse_permute512(pa);
        check_bytes_eq("unaligned inverse_permute512", pa, m512, 64);

        memcpy(ref512, m512, 64);
        areion_permute512_p2(ref512);
        memcpy(pa, m512, 64);
        areion_permute512_p2(pa);
        check_bytes_eq("unaligned permute512_p2", pa, ref512, 64);
        areion_inverse_permute512_p2(pa);
        check_bytes_eq("unaligned inverse_permute512_p2", pa, m512, 64);

        /* DM256 & DM512 unaligned + in == out overlap */
        areion_dm256(ref256, m256);
        memcpy(pa, m256, 32);
        areion_dm256(pb, pa);
        check_bytes_eq("unaligned dm256", pb, ref256, 32);
        areion_dm256(pa, pa);
        check_bytes_eq("unaligned overlap dm256", pa, ref256, 32);

        areion_dm512(ref256, m512);
        memcpy(pa, m512, 64);
        areion_dm512(pb, pa);
        check_bytes_eq("unaligned dm512", pb, ref256, 32);
        areion_dm512(pa, pa);
        check_bytes_eq("unaligned overlap dm512", pa, ref256, 32);

        /* SoEM256 & SoEM512 unaligned + out==in + out==key overlap */
        areion_soem256(ref256, k256, m256);
        memcpy(pa, k256, 64);
        memcpy(pb, m256, 32);
        areion_soem256(pc, pa, pb);
        check_bytes_eq("unaligned soem256", pc, ref256, 32);
        areion_soem256(pb, pa, pb);
        check_bytes_eq("unaligned overlap(out==in) soem256", pb, ref256, 32);
        memcpy(pb, m256, 32);
        areion_soem256(pa, pa, pb);
        check_bytes_eq("unaligned overlap(out==key) soem256", pa, ref256, 32);

        areion_soem512(ref512, k512, m512);
        memcpy(pa, k512, 128);
        memcpy(pb, m512, 64);
        areion_soem512(pc, pa, pb);
        check_bytes_eq("unaligned soem512", pc, ref512, 64);
        areion_soem512(pb, pa, pb);
        check_bytes_eq("unaligned overlap(out==in) soem512", pb, ref512, 64);
        memcpy(pb, m512, 64);
        areion_soem512(pa, pa, pb);
        check_bytes_eq("unaligned overlap(out==key) soem512", pa, ref512, 64);

        /* Permute256x4 & Permute512x4 unaligned */
        memcpy(ref256x4, m256x4, 128);
        areion_permute256x4(ref256x4[0], ref256x4[1], ref256x4[2], ref256x4[3]);
        memcpy(pa, m256x4[0], 32);
        memcpy(pb, m256x4[1], 32);
        memcpy(pc, m256x4[2], 32);
        memcpy(pd, m256x4[3], 32);
        areion_permute256x4(pa, pb, pc, pd);
        check_bytes_eq("unaligned permute256x4[0]", pa, ref256x4[0], 32);
        check_bytes_eq("unaligned permute256x4[3]", pd, ref256x4[3], 32);
        areion_inverse_permute256x4(pa, pb, pc, pd);
        check_bytes_eq("unaligned inverse_permute256x4[0]", pa, m256x4[0], 32);

        memcpy(ref512x4, m512x4, 256);
        areion_permute512x4(ref512x4[0], ref512x4[1], ref512x4[2], ref512x4[3]);
        memcpy(pa, m512x4[0], 64);
        memcpy(pb, m512x4[1], 64);
        memcpy(pc, m512x4[2], 64);
        memcpy(pd, m512x4[3], 64);
        areion_permute512x4(pa, pb, pc, pd);
        check_bytes_eq("unaligned permute512x4[0]", pa, ref512x4[0], 64);
        check_bytes_eq("unaligned permute512x4[3]", pd, ref512x4[3], 64);
        areion_inverse_permute512x4(pa, pb, pc, pd);
        check_bytes_eq("unaligned inverse_permute512x4[0]", pa, m512x4[0], 64);

        /* SoEM256x4 & SoEM512x4 unaligned + out==inputs overlap */
        areion_soem256x4(ref256x4, k256x4, m256x4);
        memcpy(pa, k256x4, 256);
        memcpy(pb, m256x4, 128);
        areion_soem256x4((uint8_t (*)[32])pc, (const uint8_t (*)[64])pa, (const uint8_t (*)[32])pb);
        check_bytes_eq("unaligned soem256x4", pc, &ref256x4[0][0], 128);
        areion_soem256x4((uint8_t (*)[32])pb, (const uint8_t (*)[64])pa, (const uint8_t (*)[32])pb);
        check_bytes_eq("unaligned overlap soem256x4", pb, &ref256x4[0][0], 128);

        areion_soem512x4(ref512x4, k512x4, m512x4);
        memcpy(pa, k512x4, 512);
        memcpy(pb, m512x4, 256);
        areion_soem512x4((uint8_t (*)[64])pc, (const uint8_t (*)[128])pa, (const uint8_t (*)[64])pb);
        check_bytes_eq("unaligned soem512x4", pc, &ref512x4[0][0], 256);
        areion_soem512x4((uint8_t (*)[64])pb, (const uint8_t (*)[128])pa, (const uint8_t (*)[64])pb);
        check_bytes_eq("unaligned overlap soem512x4", pb, &ref512x4[0][0], 256);

        /* Wide-block EM / EM2 / TEM / TEM2 unaligned + out==m / out==t / out==k overlap */
        areion_em_encrypt256(ref256, k256, m256);
        memcpy(pa, k256, 64);
        memcpy(pb, m256, 32);
        areion_em_encrypt256(pb, pa, pb);
        check_bytes_eq("unaligned overlap em_encrypt256", pb, ref256, 32);
        areion_em_decrypt256(pb, pa, pb);
        check_bytes_eq("unaligned overlap em_decrypt256", pb, m256, 32);

        areion_em_encrypt512(ref512, k512, m512);
        memcpy(pa, k512, 128);
        memcpy(pb, m512, 64);
        areion_em_encrypt512(pb, pa, pb);
        check_bytes_eq("unaligned overlap em_encrypt512", pb, ref512, 64);
        areion_em_decrypt512(pb, pa, pb);
        check_bytes_eq("unaligned overlap em_decrypt512", pb, m512, 64);

        areion_em2_encrypt256(ref256, k256, m256);
        memcpy(pa, k256, 64);
        memcpy(pb, m256, 32);
        areion_em2_encrypt256(pb, pa, pb);
        check_bytes_eq("unaligned overlap em2_encrypt256", pb, ref256, 32);
        areion_em2_decrypt256(pb, pa, pb);
        check_bytes_eq("unaligned overlap em2_decrypt256", pb, m256, 32);

        areion_em2_encrypt512(ref512, k512, m512);
        memcpy(pa, k512, 128);
        memcpy(pb, m512, 64);
        areion_em2_encrypt512(pb, pa, pb);
        check_bytes_eq("unaligned overlap em2_encrypt512", pb, ref512, 64);
        areion_em2_decrypt512(pb, pa, pb);
        check_bytes_eq("unaligned overlap em2_decrypt512", pb, m512, 64);

        areion_tem_encrypt256(ref256, k256, t256, m256);
        memcpy(pa, k256, 64);
        memcpy(pb, t256, 32);
        memcpy(pc, m256, 32);
        areion_tem_encrypt256(pc, pa, pb, pc);
        check_bytes_eq("unaligned overlap tem_encrypt256", pc, ref256, 32);
        areion_tem_decrypt256(pc, pa, pb, pc);
        check_bytes_eq("unaligned overlap tem_decrypt256", pc, m256, 32);

        areion_tem_encrypt512(ref512, k512, t512, m512);
        memcpy(pa, k512, 128);
        memcpy(pb, t512, 64);
        memcpy(pc, m512, 64);
        areion_tem_encrypt512(pc, pa, pb, pc);
        check_bytes_eq("unaligned overlap tem_encrypt512", pc, ref512, 64);
        areion_tem_decrypt512(pc, pa, pb, pc);
        check_bytes_eq("unaligned overlap tem_decrypt512", pc, m512, 64);

        areion_tem2_encrypt256(ref256, k256, t256, m256);
        memcpy(pa, k256, 64);
        memcpy(pb, t256, 32);
        memcpy(pc, m256, 32);
        areion_tem2_encrypt256(pc, pa, pb, pc);
        check_bytes_eq("unaligned overlap tem2_encrypt256", pc, ref256, 32);
        areion_tem2_decrypt256(pc, pa, pb, pc);
        check_bytes_eq("unaligned overlap tem2_decrypt256", pc, m256, 32);

        areion_tem2_encrypt512(ref512, k512, t512, m512);
        memcpy(pa, k512, 128);
        memcpy(pb, t512, 64);
        memcpy(pc, m512, 64);
        areion_tem2_encrypt512(pc, pa, pb, pc);
        check_bytes_eq("unaligned overlap tem2_encrypt512", pc, ref512, 64);
        areion_tem2_decrypt512(pc, pa, pb, pc);
        check_bytes_eq("unaligned overlap tem2_decrypt512", pc, m512, 64);

        /* x4 wide-block unaligned + overlap */
        areion_tem2_encrypt512x4(ref512x4, k512x4, t512x4, m512x4);
        memcpy(pa, k512x4, 512);
        memcpy(pb, t512x4, 256);
        memcpy(pc, m512x4, 256);
        areion_tem2_encrypt512x4((uint8_t (*)[64])pc, (const uint8_t (*)[128])pa, (const uint8_t (*)[64])pb, (const uint8_t (*)[64])pc);
        check_bytes_eq("unaligned overlap tem2_encrypt512x4", pc, &ref512x4[0][0], 256);
        areion_tem2_decrypt512x4((uint8_t (*)[64])pc, (const uint8_t (*)[128])pa, (const uint8_t (*)[64])pb, (const uint8_t (*)[64])pc);
        check_bytes_eq("unaligned overlap tem2_decrypt512x4", pc, &m512x4[0][0], 256);
    }
}

static void vg_make_mem_undefined(const void *p, size_t n) {
#if defined(__x86_64__) && (defined(__GNUC__) || defined(__clang__)) && \
    !__has_feature(memory_sanitizer) && !__has_feature(address_sanitizer) && \
    !__has_feature(thread_sanitizer) && !defined(__SANITIZE_ADDRESS__) && !defined(__SANITIZE_THREAD__)
    volatile unsigned long args[6];
    unsigned long vg_res = 0UL;
    args[0] = 0x4d430001UL; /* VG_USERREQ__MAKE_MEM_UNDEFINED */
    args[1] = (unsigned long)(uintptr_t)p;
    args[2] = (unsigned long)n;
    args[3] = 0UL;
    args[4] = 0UL;
    args[5] = 0UL;
    __asm__ __volatile__(
        "rolq $3,  %%rdi ; rolq $13, %%rdi\n\t"
        "rolq $61, %%rdi ; rolq $51, %%rdi\n\t"
        "xchgq %%rbx, %%rbx"
        : "=d"(vg_res)
        : "a"(&args[0]), "0"(0UL)
        : "cc", "memory"
    );
    (void)vg_res;
#else
    (void)p;
    (void)n;
#endif
}

static void vg_make_mem_defined(const void *p, size_t n) {
#if defined(__x86_64__) && (defined(__GNUC__) || defined(__clang__)) && \
    !__has_feature(memory_sanitizer) && !__has_feature(address_sanitizer) && \
    !__has_feature(thread_sanitizer) && !defined(__SANITIZE_ADDRESS__) && !defined(__SANITIZE_THREAD__)
    volatile unsigned long args[6];
    unsigned long vg_res = 0UL;
    args[0] = 0x4d430002UL; /* VG_USERREQ__MAKE_MEM_DEFINED */
    args[1] = (unsigned long)(uintptr_t)p;
    args[2] = (unsigned long)n;
    args[3] = 0UL;
    args[4] = 0UL;
    args[5] = 0UL;
    __asm__ __volatile__(
        "rolq $3,  %%rdi ; rolq $13, %%rdi\n\t"
        "rolq $61, %%rdi ; rolq $51, %%rdi\n\t"
        "xchgq %%rbx, %%rbx"
        : "=d"(vg_res)
        : "a"(&args[0]), "0"(0UL)
        : "cc", "memory"
    );
    (void)vg_res;
#else
    (void)p;
    (void)n;
#endif
}

static void test_timecop_constant_time(void) {
    uint8_t s256[32] = {0}, s512[64] = {0}, out256[32] = {0}, out512[64] = {0};
    uint8_t k256[64] = {0}, k512[128] = {0}, t256[32] = {0}, t512[64] = {0};
    uint8_t b256[4][32] = {{0}}, b512[4][64] = {{0}};
    uint8_t k256x4[4][64] = {{0}}, k512x4[4][128] = {{0}};
    uint8_t t256x4[4][32] = {{0}}, t512x4[4][64] = {{0}};
    uint8_t out256x4[4][32] = {{0}}, out512x4[4][64] = {{0}};
    uint8_t aes_key[16] = {0}, aes_blk[16] = {0}, aes_blk4[4][16] = {{0}}, rk[11][16] = {{0}};
    uint32_t w256[8] = {0}, w512[16] = {0}, rw_in[4] = {0}, rw_out[4] = {0};

    vg_make_mem_undefined(s256, sizeof(s256));
    vg_make_mem_undefined(s512, sizeof(s512));
    vg_make_mem_undefined(k256, sizeof(k256));
    vg_make_mem_undefined(k512, sizeof(k512));
    vg_make_mem_undefined(t256, sizeof(t256));
    vg_make_mem_undefined(t512, sizeof(t512));
    vg_make_mem_undefined(b256, sizeof(b256));
    vg_make_mem_undefined(b512, sizeof(b512));
    vg_make_mem_undefined(k256x4, sizeof(k256x4));
    vg_make_mem_undefined(k512x4, sizeof(k512x4));
    vg_make_mem_undefined(t256x4, sizeof(t256x4));
    vg_make_mem_undefined(t512x4, sizeof(t512x4));
    vg_make_mem_undefined(aes_key, sizeof(aes_key));
    vg_make_mem_undefined(aes_blk, sizeof(aes_blk));
    vg_make_mem_undefined(aes_blk4, sizeof(aes_blk4));
    vg_make_mem_undefined(w256, sizeof(w256));
    vg_make_mem_undefined(w512, sizeof(w512));
    vg_make_mem_undefined(rw_in, sizeof(rw_in));

    areion_permute256(s256);
    areion_inverse_permute256(s256);
    areion_permute256_p2(s256);
    areion_inverse_permute256_p2(s256);
    areion_permute512(s512);
    areion_inverse_permute512(s512);
    areion_permute512_p2(s512);
    areion_inverse_permute512_p2(s512);
    areion_permute256_words(w256);
    areion_inverse_permute256_words(w256);
    areion_permute512_words(w512);
    areion_inverse_permute512_words(w512);
    areion_round(rw_in, rw_out);
    areion_final_round(rw_in, rw_out);
    areion_inv_round(rw_in, rw_out);
    areion_inv_final_round(rw_in, rw_out);
    areion_inv_mix_columns(rw_in, rw_out);

    areion_dm256(out256, s256);
    areion_dm512(out256, s512);
    areion_soem256(out256, k256, s256);
    areion_soem512(out512, k512, s512);
    areion_permute256x4(b256[0], b256[1], b256[2], b256[3]);
    areion_inverse_permute256x4(b256[0], b256[1], b256[2], b256[3]);
    areion_permute256_p2x4(b256[0], b256[1], b256[2], b256[3]);
    areion_inverse_permute256_p2x4(b256[0], b256[1], b256[2], b256[3]);
    areion_permute512x4(b512[0], b512[1], b512[2], b512[3]);
    areion_inverse_permute512x4(b512[0], b512[1], b512[2], b512[3]);
    areion_permute512_p2x4(b512[0], b512[1], b512[2], b512[3]);
    areion_inverse_permute512_p2x4(b512[0], b512[1], b512[2], b512[3]);
    areion_soem256x4(out256x4, k256x4, b256);
    areion_soem512x4(out512x4, k512x4, b512);

    areion_round_hw(aes_blk);
    areion_final_round_hw(aes_blk);
    areion_round4_hw(aes_blk4[0], aes_blk4[1], aes_blk4[2], aes_blk4[3]);
    areion_final_round4_hw(aes_blk4[0], aes_blk4[1], aes_blk4[2], aes_blk4[3]);
    areion_aes_round_hw(aes_blk, aes_key);
    areion_aes_final_round_hw(aes_blk, aes_key);
    areion_aes_round4_hw(aes_blk4[0], aes_blk4[1], aes_blk4[2], aes_blk4[3],
                         aes_key, aes_key, aes_key, aes_key);
    areion_aes_final_round4_hw(aes_blk4[0], aes_blk4[1], aes_blk4[2], aes_blk4[3],
                               aes_key, aes_key, aes_key, aes_key);
    areion_aes128_round(aes_blk, aes_key);
    areion_aes128_final_round(aes_blk, aes_key);
    areion_aes128_round4(aes_blk4[0], aes_blk4[1], aes_blk4[2], aes_blk4[3],
                         aes_key, aes_key, aes_key, aes_key);
    areion_aes128_final_round4(aes_blk4[0], aes_blk4[1], aes_blk4[2], aes_blk4[3],
                               aes_key, aes_key, aes_key, aes_key);
    areion_xor_block(aes_blk, aes_key);
    areion_xor_block4(aes_blk4[0], aes_blk4[1], aes_blk4[2], aes_blk4[3],
                      aes_key, aes_key, aes_key, aes_key);

    areion_em_encrypt256(out256, k256, s256);
    areion_em_decrypt256(out256, k256, out256);
    areion_em_encrypt512(out512, k512, s512);
    areion_em_decrypt512(out512, k512, out512);
    areion_em2_encrypt256(out256, k256, s256);
    areion_em2_decrypt256(out256, k256, out256);
    areion_em2_encrypt512(out512, k512, s512);
    areion_em2_decrypt512(out512, k512, out512);
    areion_tem_encrypt256(out256, k256, t256, s256);
    areion_tem_decrypt256(out256, k256, t256, out256);
    areion_tem_encrypt512(out512, k512, t512, s512);
    areion_tem_decrypt512(out512, k512, t512, out512);
    areion_tem2_encrypt256(out256, k256, t256, s256);
    areion_tem2_decrypt256(out256, k256, t256, out256);
    areion_tem2_encrypt512(out512, k512, t512, s512);
    areion_tem2_decrypt512(out512, k512, t512, out512);

    areion_em_encrypt256x4(out256x4, k256x4, b256);
    areion_em_decrypt256x4(out256x4, k256x4, out256x4);
    areion_em_encrypt512x4(out512x4, k512x4, b512);
    areion_em_decrypt512x4(out512x4, k512x4, out512x4);
    areion_em2_encrypt256x4(out256x4, k256x4, b256);
    areion_em2_decrypt256x4(out256x4, k256x4, out256x4);
    areion_em2_encrypt512x4(out512x4, k512x4, b512);
    areion_em2_decrypt512x4(out512x4, k512x4, out512x4);
    areion_tem_encrypt256x4(out256x4, k256x4, t256x4, b256);
    areion_tem_decrypt256x4(out256x4, k256x4, t256x4, out256x4);
    areion_tem_encrypt512x4(out512x4, k512x4, t512x4, b512);
    areion_tem_decrypt512x4(out512x4, k512x4, t512x4, out512x4);
    areion_tem2_encrypt256x4(out256x4, k256x4, t256x4, b256);
    areion_tem2_decrypt256x4(out256x4, k256x4, t256x4, out256x4);
    areion_tem2_encrypt512x4(out512x4, k512x4, t512x4, b512);
    areion_tem2_decrypt512x4(out512x4, k512x4, t512x4, out512x4);

    areion_expand_key128(aes_key, rk);
    areion_aes128_encrypt_block(aes_blk, aes_blk, rk);
    areion_aes128_encrypt4_blocks(aes_blk4, aes_blk4, rk);
    areion_wipe_expanded_key128(rk);
    {
        uint8_t asura_rk[13][32] = {{0}};
        vg_make_mem_undefined(asura_rk, sizeof(asura_rk));
        areion_asura_expand_tweakey_hw(asura_rk, k256, aes_key);
        areion_asura_encrypt_block_hw(out256, s256, (const uint8_t (*)[32])asura_rk);
        areion_asura_decrypt_block_hw(out256, out256, (const uint8_t (*)[32])asura_rk);
        areion_asura_encrypt_block_otf_hw(out256, s256, k256, aes_key);
        areion_asura_decrypt_block_otf_hw(out256, out256, k256, aes_key);
        areion_asura_encrypt_4blocks_hw(out256x4, (const uint8_t (*)[32])b256, (const uint8_t (*)[32])asura_rk);
        areion_asura_decrypt_4blocks_hw(out256x4, (const uint8_t (*)[32])out256x4, (const uint8_t (*)[32])asura_rk);
        areion_asura_encrypt_4blocks_otf_hw(out256x4, (const uint8_t (*)[32])b256, k256, (const uint8_t (*)[16])aes_blk4);
        areion_asura_decrypt_4blocks_otf_hw(out256x4, (const uint8_t (*)[32])out256x4, k256, (const uint8_t (*)[16])aes_blk4);
        areion_asura_expand_key_hw(asura_rk, k256);
        areion_asura_encrypt_block_rk_hw(out256, s256, (const uint8_t (*)[32])asura_rk, aes_key);
        areion_asura_decrypt_block_rk_hw(out256, out256, (const uint8_t (*)[32])asura_rk, aes_key);
        areion_asura_encrypt_4blocks_rk_hw(out256x4, (const uint8_t (*)[32])b256, (const uint8_t (*)[32])asura_rk, (const uint8_t (*)[16])aes_blk4);
        areion_asura_decrypt_4blocks_rk_hw(out256x4, (const uint8_t (*)[32])out256x4, (const uint8_t (*)[32])asura_rk, (const uint8_t (*)[16])aes_blk4);
        vg_make_mem_defined(asura_rk, sizeof(asura_rk));
    }

    vg_make_mem_defined(s256, sizeof(s256));
    vg_make_mem_defined(s512, sizeof(s512));
    vg_make_mem_defined(out256, sizeof(out256));
    vg_make_mem_defined(out512, sizeof(out512));
    vg_make_mem_defined(k256, sizeof(k256));
    vg_make_mem_defined(k512, sizeof(k512));
    vg_make_mem_defined(t256, sizeof(t256));
    vg_make_mem_defined(t512, sizeof(t512));
    vg_make_mem_defined(b256, sizeof(b256));
    vg_make_mem_defined(b512, sizeof(b512));
    vg_make_mem_defined(k256x4, sizeof(k256x4));
    vg_make_mem_defined(k512x4, sizeof(k512x4));
    vg_make_mem_defined(t256x4, sizeof(t256x4));
    vg_make_mem_defined(t512x4, sizeof(t512x4));
    vg_make_mem_defined(out256x4, sizeof(out256x4));
    vg_make_mem_defined(out512x4, sizeof(out512x4));
    vg_make_mem_defined(aes_key, sizeof(aes_key));
    vg_make_mem_defined(aes_blk, sizeof(aes_blk));
    vg_make_mem_defined(aes_blk4, sizeof(aes_blk4));
    vg_make_mem_defined(rk, sizeof(rk));
    vg_make_mem_defined(w256, sizeof(w256));
    vg_make_mem_defined(w512, sizeof(w512));
    vg_make_mem_defined(rw_in, sizeof(rw_in));
    vg_make_mem_defined(rw_out, sizeof(rw_out));
}

static uint64_t dudect_ticks(void) {
#if defined(__x86_64__) && (defined(__GNUC__) || defined(__clang__))
    uint32_t lo = 0U, hi = 0U;
    __asm__ __volatile__("rdtsc" : "=a"(lo), "=d"(hi));
    return ((uint64_t)hi << 32U) | (uint64_t)lo;
#elif defined(__aarch64__) && (defined(__GNUC__) || defined(__clang__))
    uint64_t v = 0U;
    __asm__ __volatile__("mrs %0, cntvct_el0" : "=r"(v));
    return v;
#else
    return (uint64_t)clock();
#endif
}

static double dudect_sqrt(double x) {
    double g;
    int i;
    if (x <= 0.0) {
        return 0.0;
    }
    g = x;
    for (i = 0; i < 30; i++) {
        g = 0.5 * (g + x / g);
    }
    return g;
}

typedef struct {
    double mean[2];
    double m2[2];
    double n[2];
} dudect_ctx_t;

static void dudect_push(dudect_ctx_t *ctx, size_t cls, double val) {
    double delta;
    ctx->n[cls] += 1.0;
    delta = val - ctx->mean[cls];
    ctx->mean[cls] += delta / ctx->n[cls];
    ctx->m2[cls] += delta * (val - ctx->mean[cls]);
}

static double dudect_t_stat(const dudect_ctx_t *ctx) {
    double var0, var1, denom, diff;
    if (ctx->n[0] < 2.0 || ctx->n[1] < 2.0) {
        return 0.0;
    }
    var0 = ctx->m2[0] / (ctx->n[0] - 1.0);
    var1 = ctx->m2[1] / (ctx->n[1] - 1.0);
    denom = dudect_sqrt(var0 / ctx->n[0] + var1 / ctx->n[1]);
    if (denom <= 0.0) {
        return 0.0;
    }
    diff = ctx->mean[0] - ctx->mean[1];
    return (diff < 0.0) ? -diff / denom : diff / denom;
}

static void test_dudect_timing(int extended) {
    dudect_ctx_t st_perm256 = {{0.0, 0.0}, {0.0, 0.0}, {0.0, 0.0}};
    dudect_ctx_t st_soem256 = {{0.0, 0.0}, {0.0, 0.0}, {0.0, 0.0}};
    dudect_ctx_t st_tem2_512 = {{0.0, 0.0}, {0.0, 0.0}, {0.0, 0.0}};
    uint8_t k512[128], t512[64], m512[64], out512[64];
    size_t samples = extended ? 20000U : 256U;
    uint32_t prng = 0x9E3779B9U;
    size_t s, i;

    for (s = 0; s < samples; s++) {
        size_t cls = (size_t)(prng & 1U);
        uint64_t t0, t1;
        prng ^= prng << 13U;
        prng ^= prng >> 17U;
        prng ^= prng << 5U;

        if (cls == 0U) {
            memset(k512, 0, sizeof(k512));
            memset(t512, 0, sizeof(t512));
            memset(m512, 0, sizeof(m512));
        } else {
            for (i = 0; i < sizeof(k512); i++) {
                prng = prng * 1664525U + 1013904223U;
                k512[i] = (uint8_t)(prng >> 24U);
            }
            for (i = 0; i < sizeof(t512); i++) {
                prng = prng * 1664525U + 1013904223U;
                t512[i] = (uint8_t)(prng >> 24U);
                m512[i] = (uint8_t)(prng >> 16U);
            }
        }

        t0 = dudect_ticks();
        for (i = 0; i < 8U; i++) {
            areion_permute256(m512);
        }
        t1 = dudect_ticks();
        dudect_push(&st_perm256, cls, (double)(t1 - t0));

        t0 = dudect_ticks();
        for (i = 0; i < 8U; i++) {
            areion_soem256(out512, k512, m512);
        }
        t1 = dudect_ticks();
        dudect_push(&st_soem256, cls, (double)(t1 - t0));

        t0 = dudect_ticks();
        for (i = 0; i < 4U; i++) {
            areion_tem2_encrypt512(out512, k512, t512, m512);
        }
        t1 = dudect_ticks();
        dudect_push(&st_tem2_512, cls, (double)(t1 - t0));

        g_bench_sink = (uint8_t)((uint32_t)g_bench_sink ^ (uint32_t)out512[0] ^ (uint32_t)m512[0]);
    }

    if (extended) {
        printf("dudect Welch t-test [%s, N=%u]:\n", areion_tier(), (unsigned)samples);
        printf("  areion_permute256      : |t| = %.2f\n", dudect_t_stat(&st_perm256));
        printf("  areion_soem256         : |t| = %.2f\n", dudect_t_stat(&st_soem256));
        printf("  areion_tem2_encrypt512 : |t| = %.2f\n", dudect_t_stat(&st_tem2_512));
    }
    areion_zeroize(k512, sizeof(k512));
    areion_zeroize(t512, sizeof(t512));
    areion_zeroize(m512, sizeof(m512));
    areion_zeroize(out512, sizeof(out512));
}

int main(int argc, char **argv) {
    static const areion_tier_t all_tiers[] = {
        AREION_TIER_PUREC,
        AREION_TIER_AESNI,
        AREION_TIER_VEX,
        AREION_TIER_VAESAVX2,
        AREION_TIER_AVX512,
        AREION_TIER_ARM64
    };
    size_t t;

    (void)setvbuf(stdout, NULL, _IONBF, 0);

    if (argc >= 2 && strcmp(argv[1], "--dump-kat") == 0) {
        return dump_kat_for_tier(argc >= 3 ? argv[2] : NULL);
    }
    if (argc >= 2 && strcmp(argv[1], "--bench") == 0) {
        if (argc >= 3) {
            (void)areion_set_tier(argv[2]);
        }
        run_benchmarks();
        return 0;
    }
    if (argc >= 2 && strcmp(argv[1], "--dudect") == 0) {
        test_dudect_timing(1);
        return 0;
    }

    /* Verify function-pointer addressability of macro-wrapped functions */
    {
        void (*volatile fn_soem256x4)(uint8_t[4][32], const uint8_t[4][64], const uint8_t[4][32]) = &areion_soem256x4;
        void (*volatile fn_soem512x4)(uint8_t[4][64], const uint8_t[4][128], const uint8_t[4][64]) = &areion_soem512x4;
        void (*volatile fn_em_enc256x4)(uint8_t[4][32], const uint8_t[4][64], const uint8_t[4][32]) = &areion_em_encrypt256x4;
        void (*volatile fn_em_dec256x4)(uint8_t[4][32], const uint8_t[4][64], const uint8_t[4][32]) = &areion_em_decrypt256x4;
        void (*volatile fn_em_enc512x4)(uint8_t[4][64], const uint8_t[4][128], const uint8_t[4][64]) = &areion_em_encrypt512x4;
        void (*volatile fn_em_dec512x4)(uint8_t[4][64], const uint8_t[4][128], const uint8_t[4][64]) = &areion_em_decrypt512x4;
        void (*volatile fn_em2_enc256x4)(uint8_t[4][32], const uint8_t[4][64], const uint8_t[4][32]) = &areion_em2_encrypt256x4;
        void (*volatile fn_em2_dec256x4)(uint8_t[4][32], const uint8_t[4][64], const uint8_t[4][32]) = &areion_em2_decrypt256x4;
        void (*volatile fn_em2_enc512x4)(uint8_t[4][64], const uint8_t[4][128], const uint8_t[4][64]) = &areion_em2_encrypt512x4;
        void (*volatile fn_em2_dec512x4)(uint8_t[4][64], const uint8_t[4][128], const uint8_t[4][64]) = &areion_em2_decrypt512x4;
        void (*volatile fn_tem_enc256x4)(uint8_t[4][32], const uint8_t[4][64], const uint8_t[4][32], const uint8_t[4][32]) = &areion_tem_encrypt256x4;
        void (*volatile fn_tem_dec256x4)(uint8_t[4][32], const uint8_t[4][64], const uint8_t[4][32], const uint8_t[4][32]) = &areion_tem_decrypt256x4;
        void (*volatile fn_tem_enc512x4)(uint8_t[4][64], const uint8_t[4][128], const uint8_t[4][64], const uint8_t[4][64]) = &areion_tem_encrypt512x4;
        void (*volatile fn_tem_dec512x4)(uint8_t[4][64], const uint8_t[4][128], const uint8_t[4][64], const uint8_t[4][64]) = &areion_tem_decrypt512x4;
        void (*volatile fn_tem2_enc256x4)(uint8_t[4][32], const uint8_t[4][64], const uint8_t[4][32], const uint8_t[4][32]) = &areion_tem2_encrypt256x4;
        void (*volatile fn_tem2_dec256x4)(uint8_t[4][32], const uint8_t[4][64], const uint8_t[4][32], const uint8_t[4][32]) = &areion_tem2_decrypt256x4;
        void (*volatile fn_tem2_enc512x4)(uint8_t[4][64], const uint8_t[4][128], const uint8_t[4][64], const uint8_t[4][64]) = &areion_tem2_encrypt512x4;
        void (*volatile fn_tem2_dec512x4)(uint8_t[4][64], const uint8_t[4][128], const uint8_t[4][64], const uint8_t[4][64]) = &areion_tem2_decrypt512x4;
        void (*volatile fn_enc1)(uint8_t[16], const uint8_t[16], const uint8_t[11][16]) = &areion_aes128_encrypt_block;
        void (*volatile fn_enc4)(uint8_t[4][16], const uint8_t[4][16], const uint8_t[11][16]) = &areion_aes128_encrypt4_blocks;
        void (*volatile fn_asura_enc1)(uint8_t[32], const uint8_t[32], const uint8_t[13][32]) = &areion_asura_encrypt;
        void (*volatile fn_asura_dec1)(uint8_t[32], const uint8_t[32], const uint8_t[13][32]) = &areion_asura_decrypt;
        void (*volatile fn_asura_enc4)(uint8_t[4][32], const uint8_t[4][32], const uint8_t[13][32]) = &areion_asura_encryptx4;
        void (*volatile fn_asura_dec4)(uint8_t[4][32], const uint8_t[4][32], const uint8_t[13][32]) = &areion_asura_decryptx4;
        void (*volatile fn_asura_enc4_otf)(uint8_t[4][32], const uint8_t[4][32], const uint8_t[32], const uint8_t[4][16]) = &areion_asura_encryptx4_otf;
        void (*volatile fn_asura_dec4_otf)(uint8_t[4][32], const uint8_t[4][32], const uint8_t[32], const uint8_t[4][16]) = &areion_asura_decryptx4_otf;
        void (*volatile fn_asura_enc1_rk)(uint8_t[32], const uint8_t[32], const uint8_t[13][32], const uint8_t[16]) = &areion_asura_encrypt_rk;
        void (*volatile fn_asura_dec1_rk)(uint8_t[32], const uint8_t[32], const uint8_t[13][32], const uint8_t[16]) = &areion_asura_decrypt_rk;
        void (*volatile fn_asura_enc4_rk)(uint8_t[4][32], const uint8_t[4][32], const uint8_t[13][32], const uint8_t[4][16]) = &areion_asura_encryptx4_rk;
        void (*volatile fn_asura_dec4_rk)(uint8_t[4][32], const uint8_t[4][32], const uint8_t[13][32], const uint8_t[4][16]) = &areion_asura_decryptx4_rk;
        (void)fn_soem256x4;
        (void)fn_soem512x4;
        (void)fn_em_enc256x4;
        (void)fn_em_dec256x4;
        (void)fn_em_enc512x4;
        (void)fn_em_dec512x4;
        (void)fn_em2_enc256x4;
        (void)fn_em2_dec256x4;
        (void)fn_em2_enc512x4;
        (void)fn_em2_dec512x4;
        (void)fn_tem_enc256x4;
        (void)fn_tem_dec256x4;
        (void)fn_tem_enc512x4;
        (void)fn_tem_dec512x4;
        (void)fn_tem2_enc256x4;
        (void)fn_tem2_dec256x4;
        (void)fn_tem2_enc512x4;
        (void)fn_tem2_dec512x4;
        (void)fn_enc1;
        (void)fn_enc4;
        (void)fn_asura_enc1;
        (void)fn_asura_dec1;
        (void)fn_asura_enc4;
        (void)fn_asura_dec4;
        (void)fn_asura_enc4_otf;
        (void)fn_asura_dec4_otf;
        (void)fn_asura_enc1_rk;
        (void)fn_asura_dec1_rk;
        (void)fn_asura_enc4_rk;
        (void)fn_asura_dec4_rk;
    }

#if defined(__unix__) || defined(__APPLE__)
    {
        const char *orig_areion = getenv("AREION_FORCE_TIER");
        char saved_areion[64];
        int had_areion = 0;
        if (orig_areion != NULL) {
            size_t n = strlen(orig_areion);
            if (n < sizeof(saved_areion)) {
                memcpy(saved_areion, orig_areion, n + 1U);
                had_areion = 1;
            }
        }
        (void)unsetenv("AREION_FORCE_TIER");
        (void)setenv("ASURA_FORCE_TIER", "purec", 1);
        if (!areion_set_tier_override(AREION_TIER_AUTO) || strcmp(areion_tier(), "purec") != 0 || areion_tier_code() != AREION_TIER_PUREC) {
            (void)fprintf(stderr, "FAIL: ASURA_FORCE_TIER=purec fallback\n");
            g_failures++;
        }
        (void)unsetenv("ASURA_FORCE_TIER");
        if (had_areion) {
            (void)setenv("AREION_FORCE_TIER", saved_areion, 1);
        }
        (void)areion_set_tier_override(AREION_TIER_AUTO);
    }
#endif

    /* Verify tier name overrides ("purec", "purego", "scalar", "gpr", "auto") & areion_use_hardware_acceleration */
    if (!areion_set_tier("purec") || strcmp(areion_tier(), "purec") != 0 || areion_tier_code() != AREION_TIER_PUREC) {
        (void)fprintf(stderr, "FAIL: areion_set_tier(\"purec\")\n");
        g_failures++;
    }
    if (!areion_set_tier("purego") || strcmp(areion_tier(), "purec") != 0) {
        (void)fprintf(stderr, "FAIL: areion_set_tier(\"purego\")\n");
        g_failures++;
    }
    if (!areion_set_tier("  SCALAR ") || strcmp(areion_tier(), "purec") != 0) {
        (void)fprintf(stderr, "FAIL: areion_set_tier(\"  SCALAR \")\n");
        g_failures++;
    }
    if (!areion_set_tier("gpr") || strcmp(areion_tier(), "purec") != 0) {
        (void)fprintf(stderr, "FAIL: areion_set_tier(\"gpr\")\n");
        g_failures++;
    }
    if (areion_set_tier("") || areion_set_tier("   ") || areion_set_tier(NULL)) {
        (void)fprintf(stderr, "FAIL: empty/NULL tier should return false\n");
        g_failures++;
    }
    if (areion_set_tier("this_tier_name_is_definitely_longer_than_32_bytes")) {
        (void)fprintf(stderr, "FAIL: overly long tier name should return false\n");
        g_failures++;
    }
    if (areion_set_tier("purec extra")) {
        (void)fprintf(stderr, "FAIL: tier name with extra token should return false\n");
        g_failures++;
    }
    (void)areion_set_tier("aesni");
    (void)areion_set_tier("vex");
    (void)areion_set_tier("vaesavx2");
    (void)areion_set_tier("avx512");
    (void)areion_set_tier("arm64");
    (void)areion_set_tier("neon");
    (void)areion_set_tier("sve");
    (void)areion_set_tier("sve2");
    if (areion_set_tier("nonexistent_tier")) {
        (void)fprintf(stderr, "FAIL: areion_set_tier(\"nonexistent_tier\") should return false\n");
        g_failures++;
    }
    areion_use_hardware_acceleration(false);
    if (strcmp(areion_tier(), "purec") != 0 || areion_tier_code() != AREION_TIER_PUREC) {
        (void)fprintf(stderr, "FAIL: areion_use_hardware_acceleration(false)\n");
        g_failures++;
    }
    areion_use_hardware_acceleration(true);
    (void)areion_set_tier("auto");

    printf("Active hardware tier: %s\n", areion_tier());

#if AREION_HAS_PTHREAD_TEST
    test_multithreaded_dispatch();
#endif

    for (t = 0; t < sizeof(all_tiers) / sizeof(all_tiers[0]); t++) {
        areion_tier_t tier = all_tiers[t];
        if (!areion_tier_supported(tier)) {
            continue;
        }
        (void)areion_set_tier_override(tier);
        printf("Testing tier: %s ... ", areion_tier());
        (void)fflush(stdout);
        test_tier_full(tier, NULL);
        test_rijndael256();
        test_vistrutah_kat();
        test_asura();
        test_supercop_wrappers();
        test_cryptographic_properties();
        test_zeroize_and_selftest_api();
        test_win64_callee_saved_abi();
        test_unaligned_and_overlap_all();
        test_timecop_constant_time();
        test_dudect_timing(0);
        printf("OK\n");
    }

    test_all_tiers_pairwise_matrix();

    (void)areion_set_tier_override(AREION_TIER_AUTO);

    if (g_failures != 0) {
        (void)fprintf(stderr, "FAILED: %d check(s) failed.\n", g_failures);
        return 1;
    }
    printf("ALL TESTS PASSED.\n");
    return 0;
}
