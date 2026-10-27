#!/usr/bin/env python3
"""
Derive and verify SoEM22 P2 round constants (pi words 15..29) and constants.c tables.

Context:
  Instantiation of the SoEM22 construction (Chen, Lambooij, Mennink, CRYPTO 2019)
  over Areion-256 and Areion-512 permutations:
      F(m) = P1(m ^ k1) ^ P2(m ^ k2) ^ k1 ^ k2
  Where:
    - P1 uses the published Areion constants (pi-derived words 0..14; Isobe et al., TCHES 2023,
      Table 1 and Appendix A.1 of the extended version, IACR ePrint 2023/794).
    - P2 is instantiated with the subsequent consecutive 15 128-bit words of pi (words 15..29),
      with RC7 (pi word 22) taking the same one-nibble shift as the published RC7 of P1.
"""

import math
import os
import re
import sys


def compute_pi_fraction_hex(num_hex_digits: int) -> str:
    scale = 16 ** (num_hex_digits + 25)

    def arccot(x: int) -> int:
        x_power = scale // x
        total = x_power
        sign = -1
        k = 3
        while True:
            x_power //= (x * x)
            term = x_power // k
            if term == 0:
                break
            total += sign * term
            sign = -sign
            k += 2
        return total

    pi_val = 4 * (4 * arccot(5) - arccot(239))
    frac_val = pi_val - 3 * scale
    hex_str = hex(frac_val)[2:]
    return hex_str[:num_hex_digits]


def gf2_rank(rows: list) -> int:
    basis = []
    for r in rows:
        val = r
        for b in basis:
            val = min(val, val ^ b)
        if val > 0:
            basis.append(val)
            basis.sort(reverse=True)
    return len(basis)


def to_le_bytes(val: int) -> list:
    return [(val >> (8 * i)) & 0xFF for i in range(16)]


def to_paper_uint32_words(val: int) -> list:
    return [(val >> (32 * (3 - i))) & 0xFFFFFFFF for i in range(4)]


def format_hex128(val: int) -> str:
    return f"0x{val:032x}"


def compute_bs(rc_a: list, rc_b: list) -> list:
    out = []
    for r in range(15):
        bytes_a = to_le_bytes(rc_a[r])
        bytes_b = to_le_bytes(rc_b[r])
        row = []
        for b in range(8):
            word = 0
            for i in range(16):
                aes_row = i % 4
                aes_col = i // 4
                base_pos = 16 * aes_row + 4 * aes_col
                if (bytes_a[i] >> b) & 1:
                    word |= (1 << (base_pos + 0)) | (1 << (base_pos + 2))
                if (bytes_b[i] >> b) & 1:
                    word |= (1 << (base_pos + 1)) | (1 << (base_pos + 3))
            row.append(word)
        out.append(row)
    return out


def verify_constants_c(p1_published: list, p2_words: list) -> bool:
    script_dir = os.path.dirname(os.path.abspath(__file__))
    constants_path = os.path.join(script_dir, "..", "constants.c")
    if not os.path.exists(constants_path):
        print("[!] constants.c not found")
        return False

    with open(constants_path, "r", encoding="utf-8") as f:
        content = f.read()

    def extract_byte_rows(var_name: str, row_len: int) -> list:
        pattern = rf"{var_name}\s*\[15\]\[{row_len}\]\s*=\s*\{{(.*?)\n\}}\s*;"
        m = re.search(pattern, content, re.DOTALL)
        if not m:
            return []
        rows = []
        for line in m.group(1).splitlines():
            vals = [int(x, 16) for x in re.findall(r"0x([0-9a-fA-F]{2})U\b", line)]
            if vals:
                rows.append(vals)
        return rows

    def extract_u64_rows(var_name: str) -> list:
        pattern = rf"{var_name}\s*\[15\]\[8\]\s*=\s*\{{(.*?)\n\}}\s*;"
        m = re.search(pattern, content, re.DOTALL)
        if not m:
            return []
        rows = []
        for line in m.group(1).splitlines():
            vals = [int(x, 16) for x in re.findall(r"0x([0-9a-fA-F]{16})ULL\b", line)]
            if vals:
                rows.append(vals)
        return rows

    p1_c = extract_byte_rows("roundConstantsP1", 16)
    p2_c = extract_byte_rows("roundConstantsP2", 16)
    rc4x_c = extract_byte_rows("areionRC4x", 64)
    rc4x2_c = extract_byte_rows("areionRC4x2", 64)
    p1_bs_c = extract_u64_rows("roundConstantsP1BS")
    p2_bs_c = extract_u64_rows("roundConstantsP2BS")
    p1p2_bs_c = extract_u64_rows("roundConstantsP1P2BS")

    expected_p1_bytes = [to_le_bytes(w) for w in p1_published]
    expected_p2_bytes = [to_le_bytes(w) for w in p2_words]
    expected_rc4x = [row * 4 for row in expected_p1_bytes]
    expected_rc4x2 = [row * 4 for row in expected_p2_bytes]

    return (
        p1_c == expected_p1_bytes
        and p2_c == expected_p2_bytes
        and rc4x_c == expected_rc4x
        and rc4x2_c == expected_rc4x2
        and p1_bs_c == compute_bs(p1_published, p1_published)
        and p2_bs_c == compute_bs(p2_words, p2_words)
        and p1p2_bs_c == compute_bs(p1_published, p2_words)
    )


def main():
    print("=" * 86)
    print("   AREION-SoEM22 ROUND CONSTANT DERIVATION & CHECKS")
    print("   Reference: Chen, Lambooij, Mennink (CRYPTO 2019) & Isobe et al. (TCHES 2023 / ePrint 2023/794)")
    print("=" * 86)

    failures = 0

    total_words = 30
    total_hex = total_words * 32
    print(f"\n[+] Deriving {total_words * 128} bits ({total_hex} hex digits) of fractional pi (Machin series)...")
    pi_hex = compute_pi_fraction_hex(total_hex)

    raw_words = [int(pi_hex[i * 32 : (i + 1) * 32], 16) for i in range(total_words)]

    p1_pi = raw_words[:15]
    p1_published = list(p1_pi)
    p1_published[7] = 0x801f2e2858efc16636920d871574e690

    p2_pi = raw_words[15:30]
    p2_words = list(p2_pi)
    p2_words[7] = 0xf6d6ff383f442392e0b4482a48420040

    def shift_nibble(w):
        return (w << 4) & ((1 << 128) - 1)

    leading_zero = [i for i, w in enumerate(raw_words) if w >> 124 == 0]
    if leading_zero == [7, 22] and p1_published[7] == shift_nibble(p1_pi[7]) and p2_words[7] == shift_nibble(p2_pi[7]):
        print("[PASS] RC7 of both tables: the pi word shifted by one nibble; words 7 and 22 are the only")
        print("       words among 0..29 that begin with a zero nibble.")
    else:
        print(f"[FAIL] RC7 shift check: words with a leading zero nibble {leading_zero}")
        failures += 1

    if verify_constants_c(p1_published, p2_words):
        print("[PASS] Table 1, Table 2, 4x broadcast, and bitsliced tables match constants.c bit-for-bit.")
    else:
        print("[FAIL] constants.c tables do not match derived values!")
        failures += 1

    deltas = [p1_published[r] ^ p2_words[r] for r in range(15)]

    if len(set(p1_published)) == 15 and len(set(p2_words)) == 15 and len(set(p1_published).intersection(set(p2_words))) == 0:
        print("[PASS] Internal and cross-table distinctness verified (30 / 30 unique 128-bit words).")
    else:
        print("[FAIL] Distinctness check failed!")
        failures += 1

    if gf2_rank(p1_published) == 15 and gf2_rank(p2_words) == 15 and gf2_rank(p1_published + p2_words) == 30 and gf2_rank(deltas) == 15:
        print("[PASS] GF(2) linear independence verified: rank(P1)=15, rank(P2)=15, rank([P1;P2])=30, rank(Deltas)=15.")
    else:
        print("[FAIL] GF(2) rank check failed!")
        failures += 1

    print("=" * 86)
    if failures == 0:
        print(" [+] All mathematical and structural checks PASSED.")
        print("=" * 86)
        sys.exit(0)
    else:
        print(f" [!] FAILED: {failures} check(s) failed.")
        print("=" * 86)
        sys.exit(1)


if __name__ == "__main__":
    main()
