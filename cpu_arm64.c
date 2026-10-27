/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

#if (defined(__aarch64__) || defined(_M_ARM64)) && !defined(AREION_FORCE_PORTABLE)

#if defined(__linux__)
#include <sys/auxv.h>
#ifndef AT_HWCAP
#define AT_HWCAP 16
#endif
#ifndef HWCAP_AES
#define HWCAP_AES (1UL << 3U)
#endif
#elif defined(_WIN32)
#include <windows.h>
#ifndef PF_ARM_V8_CRYPTO_INSTRUCTIONS_AVAILABLE
#define PF_ARM_V8_CRYPTO_INSTRUCTIONS_AVAILABLE 30
#endif
#endif

#if defined(__linux__) || defined(_WIN32)
static bool query_arm64_aes(void) {
#if defined(__linux__)
    unsigned long hwcap = getauxval(AT_HWCAP);
    return (hwcap & HWCAP_AES) != 0UL;
#else
    return IsProcessorFeaturePresent(PF_ARM_V8_CRYPTO_INSTRUCTIONS_AVAILABLE) != 0;
#endif
}
#endif

areion_tier_t areion_detect_hardware_tier(void) {
#if defined(__linux__) || defined(_WIN32)
    if (query_arm64_aes()) {
        return AREION_TIER_ARM64;
    }
    return AREION_TIER_PUREC;
#elif defined(__APPLE__) || defined(__ARM_FEATURE_CRYPTO) || defined(__ARM_FEATURE_AES)
    return AREION_TIER_ARM64;
#else
    return AREION_TIER_PUREC;
#endif
}

bool areion_check_tier_supported(areion_tier_t tier) {
    if (tier == AREION_TIER_PUREC) {
        return true;
    }
    if (tier == AREION_TIER_ARM64) {
#if defined(__linux__) || defined(_WIN32)
        return query_arm64_aes();
#elif defined(__APPLE__) || defined(__ARM_FEATURE_CRYPTO) || defined(__ARM_FEATURE_AES)
        return true;
#else
        return false;
#endif
    }
    return false;
}

#else
typedef int areion_cpu_arm64_unused_t;
#endif
