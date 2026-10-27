/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

#if (defined(__x86_64__) || defined(_M_X64)) && !defined(AREION_FORCE_PORTABLE)

#if defined(_MSC_VER)
#include <intrin.h>
#endif

#if defined(__APPLE__)
#include <sys/sysctl.h>
#endif

static void cpuid_count(uint32_t leaf, uint32_t subleaf,
                        uint32_t *eax, uint32_t *ebx,
                        uint32_t *ecx, uint32_t *edx) {
#if defined(_MSC_VER)
    int regs[4];
    __cpuidex(regs, (int)leaf, (int)subleaf);
    *eax = (uint32_t)regs[0];
    *ebx = (uint32_t)regs[1];
    *ecx = (uint32_t)regs[2];
    *edx = (uint32_t)regs[3];
#else
    *eax = 0U;
    *ebx = 0U;
    *ecx = 0U;
    *edx = 0U;
    __asm__ __volatile__(
        "cpuid"
        : "=a"(*eax), "=b"(*ebx), "=c"(*ecx), "=d"(*edx)
        : "a"(leaf), "c"(subleaf));
#endif
}

static uint64_t xgetbv_xcr0(void) {
#if defined(_MSC_VER)
    return _xgetbv(0);
#else
    uint32_t eax, edx;
    __asm__ __volatile__(
        ".byte 0x0f, 0x01, 0xd0" /* xgetbv */
        : "=a"(eax), "=d"(edx)
        : "c"(0U));
    return ((uint64_t)edx << 32U) | (uint64_t)eax;
#endif
}

typedef struct {
    bool has_aesni;
    bool has_vex;
    bool has_vaes_avx2;
    bool has_avx512;
} x86_features_t;

static x86_features_t query_x86_features(void) {
    x86_features_t feat = {false, false, false, false};
    uint32_t max_leaf = 0, eax = 0, ebx = 0, ecx = 0, edx = 0;

    cpuid_count(0U, 0U, &max_leaf, &ebx, &ecx, &edx);
    if (max_leaf < 1U) {
        return feat;
    }

    cpuid_count(1U, 0U, &eax, &ebx, &ecx, &edx);
    bool aesni = (ecx & (1U << 25U)) != 0U;
    bool osxsave = (ecx & (1U << 27U)) != 0U;
    bool avx = (ecx & (1U << 28U)) != 0U;

    feat.has_aesni = aesni;
    if (!aesni || !osxsave || !avx) {
        return feat;
    }

    uint64_t xcr0 = xgetbv_xcr0();
    bool os_avx = (xcr0 & 0x06ULL) == 0x06ULL;
    if (!os_avx) {
        return feat;
    }
    feat.has_vex = true;

    if (max_leaf < 7U) {
        return feat;
    }

    cpuid_count(7U, 0U, &eax, &ebx, &ecx, &edx);
    bool avx2 = (ebx & (1U << 5U)) != 0U;
    bool vaes = (ecx & (1U << 9U)) != 0U;
    if (avx2 && vaes) {
        feat.has_vaes_avx2 = true;
    }

    bool os_avx512 = (xcr0 & 0xE6ULL) == 0xE6ULL;
#if defined(__APPLE__)
    if (!os_avx512 && os_avx) {
        int avx512f = 0;
        size_t len = sizeof(avx512f);
        if (sysctlbyname("hw.optional.avx512f", &avx512f, &len, NULL, 0) == 0 && avx512f == 1) {
            os_avx512 = true;
        }
    }
#endif
    uint32_t avx512_mask = (1U << 16U) | (1U << 17U) | (1U << 30U) | (1U << 31U);
    bool avx512_isa = (ebx & avx512_mask) == avx512_mask;
    if (feat.has_vaes_avx2 && os_avx512 && avx512_isa) {
        feat.has_avx512 = true;
    }

    return feat;
}

areion_tier_t areion_detect_hardware_tier(void) {
    x86_features_t feat = query_x86_features();
    if (feat.has_avx512) {
        return AREION_TIER_AVX512;
    }
    if (feat.has_vaes_avx2) {
        return AREION_TIER_VAESAVX2;
    }
    if (feat.has_vex) {
        return AREION_TIER_VEX;
    }
    if (feat.has_aesni) {
        return AREION_TIER_AESNI;
    }
    return AREION_TIER_PUREC;
}

bool areion_check_tier_supported(areion_tier_t tier) {
    x86_features_t feat = query_x86_features();
    switch (tier) {
        case AREION_TIER_PUREC:
            return true;
        case AREION_TIER_AESNI:
            return feat.has_aesni;
        case AREION_TIER_VEX:
            return feat.has_vex;
        case AREION_TIER_VAESAVX2:
            return feat.has_vaes_avx2;
        case AREION_TIER_AVX512:
            return feat.has_avx512;
        case AREION_TIER_ARM64:
        case AREION_TIER_AUTO:
        default:
            return false;
    }
}

#else
typedef int areion_cpu_amd64_unused_t;
#endif
