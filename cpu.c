/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"
#include <stdlib.h>
#include <string.h>

#if defined(_WIN32)
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <windows.h>
#endif

/* Internal state values:
 * areion_g_active_tier holds (int)active areion_tier_t (defaults to 0 = AREION_TIER_PUREC
 * until areion_cpu_early_init constructor / areion_active_tier_init runs). */
#if defined(_MSC_VER)
volatile long areion_g_active_tier = 0;
#elif defined(__GNUC__) || defined(__clang__)
int areion_g_active_tier = 0;
#else
volatile int areion_g_active_tier = 0;
#endif
static int g_active_tier_init_done = 0;
static int g_hw_tier = -2;

static int atomic_load_int(const int *p) {
#if defined(__GNUC__) || defined(__clang__)
    return __atomic_load_n(p, __ATOMIC_ACQUIRE);
#elif defined(_WIN32)
    return (int)InterlockedCompareExchange((volatile LONG *)(uintptr_t)p, 0L, 0L);
#else
    return *(const volatile int *)p;
#endif
}

static void atomic_store_int(int *p, int v) {
#if defined(__GNUC__) || defined(__clang__)
    __atomic_store_n(p, v, __ATOMIC_RELEASE);
#elif defined(_WIN32)
    (void)InterlockedExchange((volatile LONG *)p, (LONG)v);
#else
    *(volatile int *)p = v;
#endif
}

static void atomic_store_active_tier(int v) {
#if defined(_MSC_VER)
    (void)InterlockedExchange((volatile LONG *)&areion_g_active_tier, (LONG)v);
#elif defined(__GNUC__) || defined(__clang__)
    __atomic_store_n(&areion_g_active_tier, v, __ATOMIC_RELEASE);
#elif defined(_WIN32)
    (void)InterlockedExchange((volatile LONG *)&areion_g_active_tier, (LONG)v);
#else
    areion_g_active_tier = v;
#endif
}

static bool parse_tier_name(const char *name, areion_tier_t *out) {
    char buf[32];
    size_t pos = 0, len = 0;
    if (name == NULL) {
        return false;
    }
    while (name[pos] == ' ' || name[pos] == '\t' || name[pos] == '\r' || name[pos] == '\n') {
        pos++;
    }
    while (name[pos] != '\0' && name[pos] != ' ' && name[pos] != '\t' &&
           name[pos] != '\r' && name[pos] != '\n') {
        char c = name[pos++];
        if (len + 1U >= sizeof(buf)) {
            return false;
        }
        if (c >= 'A' && c <= 'Z') {
            c = (char)(c - 'A' + 'a');
        }
        buf[len++] = c;
    }
    while (name[pos] == ' ' || name[pos] == '\t' || name[pos] == '\r' || name[pos] == '\n') {
        pos++;
    }
    if (len == 0 || name[pos] != '\0') {
        return false;
    }
    buf[len] = '\0';

    if (strcmp(buf, "auto") == 0) {
        *out = AREION_TIER_AUTO;
        return true;
    }
    if (strcmp(buf, "purec") == 0 || strcmp(buf, "purego") == 0 ||
        strcmp(buf, "scalar") == 0 || strcmp(buf, "gpr") == 0) {
        *out = AREION_TIER_PUREC;
        return true;
    }
    if (strcmp(buf, "aesni") == 0) {
        *out = AREION_TIER_AESNI;
        return true;
    }
    if (strcmp(buf, "vex") == 0) {
        *out = AREION_TIER_VEX;
        return true;
    }
    if (strcmp(buf, "vaesavx2") == 0) {
        *out = AREION_TIER_VAESAVX2;
        return true;
    }
    if (strcmp(buf, "avx512") == 0) {
        *out = AREION_TIER_AVX512;
        return true;
    }
    if (strcmp(buf, "arm64") == 0 || strcmp(buf, "neon") == 0 ||
        strcmp(buf, "sve") == 0 || strcmp(buf, "sve2") == 0) {
        *out = AREION_TIER_ARM64;
        return true;
    }
    return false;
}

static areion_tier_t get_hw_tier(void) {
    int hw = atomic_load_int(&g_hw_tier);
    if (hw < 0) {
        hw = (int)areion_detect_hardware_tier();
        atomic_store_int(&g_hw_tier, hw);
    }
    return (areion_tier_t)hw;
}

static int areion_active_tier_init(void) {
    areion_tier_t hw = get_hw_tier();
    areion_tier_t selected = hw;
    const char *env = getenv("AREION_FORCE_TIER");
    if (env != NULL && env[0] != '\0') {
        areion_tier_t req = AREION_TIER_AUTO;
        if (parse_tier_name(env, &req) && req != AREION_TIER_AUTO &&
            areion_check_tier_supported(req)) {
            selected = req;
        }
    }
    atomic_store_active_tier((int)selected);
    atomic_store_int(&g_active_tier_init_done, 1);
    return (int)selected;
}

areion_tier_t areion_tier_code(void) {
    if (atomic_load_int(&g_active_tier_init_done) == 0) {
        return (areion_tier_t)areion_active_tier_init();
    }
    return areion_active_tier();
}

#if defined(__GNUC__) || defined(__clang__)
__attribute__((constructor))
static void areion_cpu_early_init(void) {
    (void)areion_tier_code();
}
#elif defined(_MSC_VER)
static void __cdecl areion_cpu_early_init(void) {
    (void)areion_tier_code();
}
#pragma section(".CRT$XCU", read)
__declspec(allocate(".CRT$XCU")) static void (__cdecl *p_areion_cpu_early_init)(void) = areion_cpu_early_init;
#endif

const char *areion_tier(void) {
    switch (areion_tier_code()) {
        case AREION_TIER_AVX512:
            return "avx512";
        case AREION_TIER_VAESAVX2:
            return "vaesavx2";
        case AREION_TIER_VEX:
            return "vex";
        case AREION_TIER_AESNI:
            return "aesni";
        case AREION_TIER_ARM64:
            return "arm64";
        case AREION_TIER_PUREC:
        case AREION_TIER_AUTO:
        default:
            return "purec";
    }
}

bool areion_tier_supported(areion_tier_t tier) {
    if (tier == AREION_TIER_AUTO || tier == AREION_TIER_PUREC) {
        return true;
    }
    return areion_check_tier_supported(tier);
}

bool areion_set_tier_override(areion_tier_t tier) {
    (void)get_hw_tier();
    if (tier == AREION_TIER_AUTO) {
        const char *env = getenv("AREION_FORCE_TIER");
        if (env != NULL && env[0] != '\0') {
            areion_tier_t req = AREION_TIER_AUTO;
            if (parse_tier_name(env, &req) && req != AREION_TIER_AUTO &&
                areion_check_tier_supported(req)) {
                atomic_store_active_tier((int)req);
                atomic_store_int(&g_active_tier_init_done, 1);
                return true;
            }
        }
        atomic_store_active_tier((int)get_hw_tier());
        atomic_store_int(&g_active_tier_init_done, 1);
        return true;
    }
    if (!areion_tier_supported(tier)) {
        return false;
    }
    atomic_store_active_tier((int)tier);
    atomic_store_int(&g_active_tier_init_done, 1);
    return true;
}

bool areion_set_tier(const char *name) {
    areion_tier_t tier = AREION_TIER_AUTO;
    if (!parse_tier_name(name, &tier)) {
        return false;
    }
    return areion_set_tier_override(tier);
}

void areion_use_hardware_acceleration(bool enable) {
    if (enable) {
        (void)areion_set_tier_override(AREION_TIER_AUTO);
    } else {
        (void)areion_set_tier_override(AREION_TIER_PUREC);
    }
}

void areion_zeroize(void *p, size_t n) {
    if (p == NULL || n == 0U) {
        return;
    }
#if defined(_WIN32)
    SecureZeroMemory(p, n);
#endif
    {
        volatile uint8_t *vp = (volatile uint8_t *)p;
        size_t i;
        for (i = 0; i < n; i++) {
            vp[i] = 0;
        }
    }
#if defined(__GNUC__) || defined(__clang__)
    __asm__ __volatile__("" : : "r"(p) : "memory");
#elif defined(_MSC_VER)
    _ReadWriteBarrier();
#endif
    areion_clobber_scratch_gprs();
}

static AREION_NOINLINE AREION_NO_STACK_PROTECTOR void areion_wipe_selftest_stack(void) {
    volatile uint64_t frame[1664];
    size_t i;
#if defined(__GNUC__) || defined(__clang__)
    const void *fp = __builtin_frame_address(0);
#endif
    for (i = 0; i < 1664U; i++) {
        frame[i] = 0;
    }
#if defined(__GNUC__) || defined(__clang__)
    __asm__ __volatile__("" : : "r"(frame), "r"(fp) : "memory");
#else
    areion_compiler_barrier();
#endif
}

static AREION_NOINLINE uint32_t selftest_ct_diff(const uint8_t *a, const uint8_t *b, size_t n) {
    volatile uint32_t diff = 0U;
    size_t i;
    for (i = 0; i < n; i++) {
        diff |= (uint32_t)(a[i] ^ b[i]);
    }
    return diff;
}

static AREION_NOINLINE uint32_t selftest_base_and_256(void) {
    static const uint8_t kat256_p1_zero[32] = {
        0x28, 0x12, 0xa7, 0x24, 0x65, 0xb2, 0x6e, 0x9f,
        0xca, 0x75, 0x83, 0xf6, 0xe4, 0x12, 0x3a, 0xa1,
        0x49, 0x0e, 0x35, 0xe7, 0xd5, 0x20, 0x3e, 0x4b,
        0xa2, 0xe9, 0x27, 0xb0, 0x48, 0x2f, 0x4d, 0xb8
    };
    static const uint8_t kat256_p2_zero[32] = {
        0x94, 0x59, 0xad, 0x09, 0x73, 0x2a, 0x12, 0xdf,
        0x68, 0x63, 0x26, 0xcd, 0xb2, 0x91, 0xbd, 0x02,
        0x12, 0x39, 0xb6, 0xec, 0x01, 0xdf, 0x49, 0xd7,
        0x01, 0x89, 0x02, 0xea, 0x09, 0x47, 0x32, 0x84
    };
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
    static const uint8_t kat_em_256_expected[32] = {
        0xb1, 0x59, 0x0d, 0xe6, 0xb0, 0xee, 0x58, 0x9c,
        0x39, 0xdc, 0x13, 0x01, 0x40, 0xc0, 0xb3, 0x8b,
        0x83, 0x20, 0x60, 0x51, 0x82, 0xe5, 0xf3, 0x7a,
        0x01, 0xe5, 0x10, 0x4c, 0x4a, 0x7b, 0xfe, 0xab
    };
    static const uint8_t kat_em2_256_expected[32] = {
        0x06, 0x1a, 0x5e, 0x87, 0x82, 0x64, 0x7a, 0x6b,
        0xae, 0xcc, 0x87, 0x72, 0x2d, 0xdf, 0xf3, 0xbe,
        0xab, 0x73, 0x1f, 0x41, 0xcc, 0x40, 0x09, 0x1b,
        0xaf, 0xa6, 0x83, 0xce, 0x5f, 0x80, 0xca, 0x78
    };
    static const uint8_t kat_tem_256_expected[32] = {
        0xde, 0x63, 0x2e, 0x74, 0x54, 0x19, 0xba, 0x1e,
        0xb0, 0xfb, 0x40, 0x00, 0x14, 0xe4, 0xba, 0x88,
        0x31, 0x48, 0x36, 0x53, 0x2f, 0xcb, 0xe6, 0x91,
        0x1a, 0x61, 0x89, 0x61, 0xd6, 0x19, 0x30, 0x5b
    };
    static const uint8_t kat_tem2_256_expected[32] = {
        0x74, 0xde, 0xe4, 0x0d, 0x0a, 0xe8, 0x2e, 0x8f,
        0x0d, 0x62, 0x67, 0x5e, 0xad, 0x6c, 0x54, 0xf4,
        0x97, 0x6c, 0x53, 0x96, 0x29, 0xc2, 0x1a, 0xeb,
        0x29, 0xc2, 0xdb, 0x43, 0x16, 0x40, 0xf9, 0x54
    };

    uint8_t z256[32], s256[32], dm_out[32], soem256_want[32];
    uint8_t k256[64], t256[32], m256[32], c256[32], p256[32];
    uint8_t k256x4[4][64], t256x4[4][32], m256x4[4][32], c256x4[4][32], p256x4[4][32];
    uint8_t rk[11][16], ct[16];
    uint32_t fail = 0U;
    size_t i, lane;

    for (i = 0; i < 32; i++) {
        z256[i] = 0;
        s256[i] = 0;
        soem256_want[i] = (uint8_t)(kat256_p1_zero[i] ^ kat256_p2_zero[i]);
    }
    for (i = 0; i < 64; i++) {
        k256[i] = 0;
    }

    /* Permute256 / InversePermute256 / DM256 */
    areion_dm256(dm_out, z256);
    fail |= selftest_ct_diff(dm_out, kat256_p1_zero, 32);
    areion_permute256(s256);
    fail |= selftest_ct_diff(s256, kat256_p1_zero, 32);
    areion_inverse_permute256(s256);
    fail |= selftest_ct_diff(s256, z256, 32);

    /* Permute256P2 / InversePermute256P2 */
    areion_permute256_p2(s256);
    fail |= selftest_ct_diff(s256, kat256_p2_zero, 32);
    areion_inverse_permute256_p2(s256);
    fail |= selftest_ct_diff(s256, z256, 32);

    /* SoEM256 (zero input & key -> P1(0) ^ P2(0)) */
    areion_soem256(c256, k256, z256);
    fail |= selftest_ct_diff(c256, soem256_want, 32);

    /* AES-128 FIPS 197 KAT */
    areion_expand_key128(aes_key, rk);
    areion_aes128_encrypt_block(ct, aes_pt, rk);
    fail |= selftest_ct_diff(ct, aes_ct_expected, 16);
    areion_wipe_expanded_key128(rk);

    /* 256-bit wide-block EM / EM2 / TEM / TEM2 (single & 4-way) + SoEM256x4 */
    for (i = 0; i < 64; i++) {
        k256[i] = (uint8_t)i;
    }
    for (i = 0; i < 32; i++) {
        t256[i] = (uint8_t)(0x80U + i);
        m256[i] = (uint8_t)(0x40U + i);
    }
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i++) {
            k256x4[lane][i] = k256[i];
        }
        for (i = 0; i < 32; i++) {
            t256x4[lane][i] = t256[i];
            m256x4[lane][i] = m256[i];
        }
    }

    areion_soem256(c256, k256, m256);
    areion_soem256x4(c256x4, k256x4, m256x4);
    for (lane = 0; lane < 4; lane++) {
        fail |= selftest_ct_diff(c256x4[lane], c256, 32);
    }

    areion_em_encrypt256(c256, k256, m256);
    fail |= selftest_ct_diff(c256, kat_em_256_expected, 32);
    areion_em_decrypt256(p256, k256, c256);
    fail |= selftest_ct_diff(p256, m256, 32);
    areion_em_encrypt256x4(c256x4, k256x4, m256x4);
    areion_em_decrypt256x4(p256x4, k256x4, c256x4);
    for (lane = 0; lane < 4; lane++) {
        fail |= selftest_ct_diff(c256x4[lane], kat_em_256_expected, 32);
        fail |= selftest_ct_diff(p256x4[lane], m256, 32);
    }

    areion_em2_encrypt256(c256, k256, m256);
    fail |= selftest_ct_diff(c256, kat_em2_256_expected, 32);
    areion_em2_decrypt256(p256, k256, c256);
    fail |= selftest_ct_diff(p256, m256, 32);
    areion_em2_encrypt256x4(c256x4, k256x4, m256x4);
    areion_em2_decrypt256x4(p256x4, k256x4, c256x4);
    for (lane = 0; lane < 4; lane++) {
        fail |= selftest_ct_diff(c256x4[lane], kat_em2_256_expected, 32);
        fail |= selftest_ct_diff(p256x4[lane], m256, 32);
    }

    areion_tem_encrypt256(c256, k256, t256, m256);
    fail |= selftest_ct_diff(c256, kat_tem_256_expected, 32);
    areion_tem_decrypt256(p256, k256, t256, c256);
    fail |= selftest_ct_diff(p256, m256, 32);
    areion_tem_encrypt256x4(c256x4, k256x4, t256x4, m256x4);
    areion_tem_decrypt256x4(p256x4, k256x4, t256x4, c256x4);
    for (lane = 0; lane < 4; lane++) {
        fail |= selftest_ct_diff(c256x4[lane], kat_tem_256_expected, 32);
        fail |= selftest_ct_diff(p256x4[lane], m256, 32);
    }

    areion_tem2_encrypt256(c256, k256, t256, m256);
    fail |= selftest_ct_diff(c256, kat_tem2_256_expected, 32);
    areion_tem2_decrypt256(p256, k256, t256, c256);
    fail |= selftest_ct_diff(p256, m256, 32);
    areion_tem2_encrypt256x4(c256x4, k256x4, t256x4, m256x4);
    areion_tem2_decrypt256x4(p256x4, k256x4, t256x4, c256x4);
    for (lane = 0; lane < 4; lane++) {
        fail |= selftest_ct_diff(c256x4[lane], kat_tem2_256_expected, 32);
        fail |= selftest_ct_diff(p256x4[lane], m256, 32);
    }

    areion_zeroize(z256, sizeof(z256));
    areion_zeroize(s256, sizeof(s256));
    areion_zeroize(dm_out, sizeof(dm_out));
    areion_zeroize(soem256_want, sizeof(soem256_want));
    areion_zeroize(k256, sizeof(k256));
    areion_zeroize(t256, sizeof(t256));
    areion_zeroize(m256, sizeof(m256));
    areion_zeroize(c256, sizeof(c256));
    areion_zeroize(p256, sizeof(p256));
    areion_zeroize(k256x4, sizeof(k256x4));
    areion_zeroize(t256x4, sizeof(t256x4));
    areion_zeroize(m256x4, sizeof(m256x4));
    areion_zeroize(c256x4, sizeof(c256x4));
    areion_zeroize(p256x4, sizeof(p256x4));
    areion_zeroize(rk, sizeof(rk));
    areion_zeroize(ct, sizeof(ct));

    return fail;
}

static AREION_NOINLINE uint32_t selftest_512(void) {
    static const uint8_t kat512_p1_zero[64] = {
        0xb2, 0xad, 0xb0, 0x4f, 0xa9, 0x1f, 0x90, 0x15,
        0x59, 0x36, 0x71, 0x22, 0xcb, 0x3c, 0x96, 0xa9,
        0x78, 0xcf, 0x3e, 0xe4, 0xb7, 0x3c, 0x6a, 0x54,
        0x3f, 0xe6, 0xdc, 0x85, 0x77, 0x91, 0x02, 0xe7,
        0xe3, 0xf5, 0x50, 0x10, 0x16, 0xce, 0xed, 0x1d,
        0xd2, 0xc4, 0x8d, 0x0b, 0xc2, 0x12, 0xfb, 0x07,
        0xad, 0x16, 0x87, 0x94, 0xbd, 0x96, 0xcf, 0xf3,
        0x59, 0x09, 0xcd, 0xd8, 0xe2, 0x27, 0x49, 0x28
    };
    static const uint8_t kat512_p2_zero[64] = {
        0xea, 0xb2, 0xb6, 0x7d, 0x13, 0xb2, 0x77, 0x25,
        0x1c, 0x1b, 0x37, 0xb2, 0x67, 0xf6, 0xe0, 0x95,
        0xed, 0xe5, 0x03, 0x16, 0xc3, 0x23, 0x46, 0xe2,
        0x7f, 0x92, 0x44, 0xdf, 0x53, 0x1f, 0x91, 0x54,
        0x1d, 0xfe, 0xcd, 0xf5, 0xc6, 0xe4, 0x52, 0x92,
        0xbd, 0x10, 0xb1, 0x2a, 0x07, 0x7e, 0x08, 0x13,
        0x0a, 0xe3, 0x72, 0x6f, 0x1e, 0x23, 0xfd, 0x48,
        0xeb, 0x87, 0xd3, 0x9d, 0xb3, 0x05, 0xee, 0xe8
    };
    static const uint8_t dm512_zero[32] = {
        0x59, 0x36, 0x71, 0x22, 0xcb, 0x3c, 0x96, 0xa9,
        0x3f, 0xe6, 0xdc, 0x85, 0x77, 0x91, 0x02, 0xe7,
        0xe3, 0xf5, 0x50, 0x10, 0x16, 0xce, 0xed, 0x1d,
        0xad, 0x16, 0x87, 0x94, 0xbd, 0x96, 0xcf, 0xf3
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

    uint8_t z512[64], s512[64], dm_out[32], soem512_want[64];
    uint8_t k512[128], t512[64], m512[64], c512[64], p512[64];
    uint8_t k512x4[4][128], t512x4[4][64], m512x4[4][64], c512x4[4][64], p512x4[4][64];
    uint32_t fail = 0U;
    size_t i, lane;

    for (i = 0; i < 64; i++) {
        z512[i] = 0;
        s512[i] = 0;
        soem512_want[i] = (uint8_t)(kat512_p1_zero[i] ^ kat512_p2_zero[i]);
    }
    for (i = 0; i < 128; i++) {
        k512[i] = 0;
    }

    /* Permute512 / InversePermute512 / DM512 */
    areion_dm512(dm_out, z512);
    fail |= selftest_ct_diff(dm_out, dm512_zero, 32);
    areion_permute512(s512);
    fail |= selftest_ct_diff(s512, kat512_p1_zero, 64);
    areion_inverse_permute512(s512);
    fail |= selftest_ct_diff(s512, z512, 64);

    /* Permute512P2 / InversePermute512P2 */
    areion_permute512_p2(s512);
    fail |= selftest_ct_diff(s512, kat512_p2_zero, 64);
    areion_inverse_permute512_p2(s512);
    fail |= selftest_ct_diff(s512, z512, 64);

    /* SoEM512 (zero input & key -> P1(0) ^ P2(0)) */
    areion_soem512(c512, k512, z512);
    fail |= selftest_ct_diff(c512, soem512_want, 64);

    /* 512-bit wide-block EM / EM2 / TEM / TEM2 (single & 4-way) + SoEM512x4 */
    for (i = 0; i < 128; i++) {
        k512[i] = (uint8_t)i;
    }
    for (i = 0; i < 64; i++) {
        t512[i] = (uint8_t)(0x80U + i);
        m512[i] = (uint8_t)(0x40U + i);
    }
    for (lane = 0; lane < 4; lane++) {
        for (i = 0; i < 64; i++) {
            t512x4[lane][i] = t512[i];
            m512x4[lane][i] = m512[i];
        }
        for (i = 0; i < 128; i++) {
            k512x4[lane][i] = k512[i];
        }
    }

    areion_soem512(c512, k512, m512);
    areion_soem512x4(c512x4, k512x4, m512x4);
    for (lane = 0; lane < 4; lane++) {
        fail |= selftest_ct_diff(c512x4[lane], c512, 64);
    }

    areion_em_encrypt512(c512, k512, m512);
    fail |= selftest_ct_diff(c512, kat_em_512_expected, 64);
    areion_em_decrypt512(p512, k512, c512);
    fail |= selftest_ct_diff(p512, m512, 64);
    areion_em_encrypt512x4(c512x4, k512x4, m512x4);
    areion_em_decrypt512x4(p512x4, k512x4, c512x4);
    for (lane = 0; lane < 4; lane++) {
        fail |= selftest_ct_diff(c512x4[lane], kat_em_512_expected, 64);
        fail |= selftest_ct_diff(p512x4[lane], m512, 64);
    }

    areion_em2_encrypt512(c512, k512, m512);
    fail |= selftest_ct_diff(c512, kat_em2_512_expected, 64);
    areion_em2_decrypt512(p512, k512, c512);
    fail |= selftest_ct_diff(p512, m512, 64);
    areion_em2_encrypt512x4(c512x4, k512x4, m512x4);
    areion_em2_decrypt512x4(p512x4, k512x4, c512x4);
    for (lane = 0; lane < 4; lane++) {
        fail |= selftest_ct_diff(c512x4[lane], kat_em2_512_expected, 64);
        fail |= selftest_ct_diff(p512x4[lane], m512, 64);
    }

    areion_tem_encrypt512(c512, k512, t512, m512);
    fail |= selftest_ct_diff(c512, kat_tem_512_expected, 64);
    areion_tem_decrypt512(p512, k512, t512, c512);
    fail |= selftest_ct_diff(p512, m512, 64);
    areion_tem_encrypt512x4(c512x4, k512x4, t512x4, m512x4);
    areion_tem_decrypt512x4(p512x4, k512x4, t512x4, c512x4);
    for (lane = 0; lane < 4; lane++) {
        fail |= selftest_ct_diff(c512x4[lane], kat_tem_512_expected, 64);
        fail |= selftest_ct_diff(p512x4[lane], m512, 64);
    }

    areion_tem2_encrypt512(c512, k512, t512, m512);
    fail |= selftest_ct_diff(c512, kat_tem2_512_expected, 64);
    areion_tem2_decrypt512(p512, k512, t512, c512);
    fail |= selftest_ct_diff(p512, m512, 64);
    areion_tem2_encrypt512x4(c512x4, k512x4, t512x4, m512x4);
    areion_tem2_decrypt512x4(p512x4, k512x4, t512x4, c512x4);
    for (lane = 0; lane < 4; lane++) {
        fail |= selftest_ct_diff(c512x4[lane], kat_tem2_512_expected, 64);
        fail |= selftest_ct_diff(p512x4[lane], m512, 64);
    }

    areion_zeroize(z512, sizeof(z512));
    areion_zeroize(s512, sizeof(s512));
    areion_zeroize(dm_out, sizeof(dm_out));
    areion_zeroize(soem512_want, sizeof(soem512_want));
    areion_zeroize(k512, sizeof(k512));
    areion_zeroize(t512, sizeof(t512));
    areion_zeroize(m512, sizeof(m512));
    areion_zeroize(c512, sizeof(c512));
    areion_zeroize(p512, sizeof(p512));
    areion_zeroize(k512x4, sizeof(k512x4));
    areion_zeroize(t512x4, sizeof(t512x4));
    areion_zeroize(m512x4, sizeof(m512x4));
    areion_zeroize(c512x4, sizeof(c512x4));
    areion_zeroize(p512x4, sizeof(p512x4));

    return fail;
}

int areion_selftest(void) {
    uint32_t fail = selftest_base_and_256();
    fail |= selftest_512();
    areion_wipe_selftest_stack();
    areion_clobber_scratch_gprs();
    return (fail == 0U) ? 0 : -1;
}
