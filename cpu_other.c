/*
 * Copyright (c) 2026 Andrey Kuvshinov
 *
 * Dual-licensed under Apache-2.0 OR MIT.
 * See LICENSE-APACHE and LICENSE-MIT for details.
 */

#include "areion_internal.h"

#if defined(AREION_FORCE_PORTABLE) || (!defined(__x86_64__) && !defined(_M_X64) && !defined(__aarch64__) && !defined(_M_ARM64))

areion_tier_t areion_detect_hardware_tier(void) {
    return AREION_TIER_PUREC;
}

bool areion_check_tier_supported(areion_tier_t tier) {
    return tier == AREION_TIER_PUREC;
}

#else
typedef int areion_cpu_other_unused_t;
#endif
