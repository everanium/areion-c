## Public API Reference (`areion.h`)

Complete C99 / C11 / C++ (`extern "C"`) reference for all exported macros, constants, types, functions, and SUPERCOP wrappers in `libareion` ([`areion.h`](areion.h)).
For architectural details, security proofs, and benchmarks, see [`README.md`](README.md).
Companion Go + Assembly reference library: **[`everanium/areion`](https://github.com/everanium/areion)** ([`API.md`](https://github.com/everanium/areion/blob/main/API.md)).

---

## Table of Contents

1. [Types and Constants](#1-types-and-constants)
2. [Cryptographic Permutations (P1 and P2, Single-Block, Word-Level & 4-Way)](#2-cryptographic-permutations-p1-and-p2-single-block-word-level--4-way)
3. [Davies-Meyer Compression Functions](#3-davies-meyer-compression-functions)
4. [Sum of Even-Mansour (SoEM22) Pseudorandom Functions (PRFs)](#4-sum-of-even-mansour-soem22-pseudorandom-functions-prfs)
5. [Invertible Wide-Block Ciphers (EM, EM2, TEM, TEM2)](#5-invertible-wide-block-ciphers-em-em2-tem-tem2)
6. [Low-Level AES-128 & Round Primitives](#6-low-level-aes-128--round-primitives)
7. [Runtime Dispatch, Self-Test, and Memory Zeroization](#7-runtime-dispatch-self-test-and-memory-zeroization)
8. [Pre-C23 `_Generic` Multi-Dimensional `const` Array Macros](#8-pre-c23-_generic-multi-dimensional-const-array-macros)
9. [SUPERCOP (`eBACS`) C99 Wrappers (`supercop/`)](#9-supercop-ebacs-c99-wrappers-supercop)

---

### 1. Types and Constants

Version macros, block/key/digest size constants (in bytes), and the runtime dispatch tier enumeration `areion_tier_t` defined in [`areion.h`](areion.h).

#### Version & Symbol Visibility Macros

| Macro | Value | Description |
| :--- | :---: | :--- |
| `AREION_VERSION_MAJOR` | `0` | Major version number |
| `AREION_VERSION_MINOR` | `1` | Minor version number |
| `AREION_VERSION_PATCH` | `4` | Patch version number |
| `AREION_VERSION_STRING` | `"0.1.4"` | Null-terminated semantic version string |
| `AREION_API` | platform-specific | Shared-library symbol export attribute (`__attribute__((visibility("default")))` or `__declspec(dllexport)`) |

#### Block, Input, Key, and Digest Size Constants

| Constant Macro | Value (Bytes) | Description |
| :--- | :---: | :--- |
| `AREION_BLOCK_SIZE_256` / `AREION_256_SIZE` | `32` | 256-bit permutation state / cipher block / tweak size |
| `AREION_BLOCK_SIZE_512` / `AREION_512_SIZE` | `64` | 512-bit permutation state / cipher block / tweak size |
| `AREION_DM256_INPUT_SIZE` | `32` | `areion_dm256` input block size |
| `AREION_DM256_SIZE` | `32` | `areion_dm256` output digest size |
| `AREION_DM512_INPUT_SIZE` | `64` | `areion_dm512` input block size |
| `AREION_DM512_SIZE` | `32` | `areion_dm512` output digest size (256-bit truncated) |
| `AREION_SOEM256_KEY_SIZE` | `64` | 512-bit key size `K1 || K2` for `areion_soem256` and 256-bit `EM` / `EM2` / `TEM` / `TEM2` ciphers |
| `AREION_SOEM256_SIZE` | `32` | 256-bit output size for `areion_soem256` |
| `AREION_SOEM512_KEY_SIZE` | `128` | 1024-bit key size `K1 || K2` for `areion_soem512` and 512-bit `EM` / `EM2` / `TEM` / `TEM2` ciphers |
| `AREION_SOEM512_SIZE` | `64` | 512-bit output size for `areion_soem512` |

#### Dispatch Tier Enumeration (`areion_tier_t`)

| Enumerator | Value | Tier Name (`areion_tier()`) | Required ISA Extensions |
| :--- | :---: | :---: | :--- |
| `AREION_TIER_AUTO` | `-1` | *(auto-selected)* | Restores automatic CPU feature detection when passed to `areion_set_tier_override` |
| `AREION_TIER_PUREC` | `0` | `"purec"` | Portable constant-time 64-bit bitsliced software fallback (all architectures) |
| `AREION_TIER_AESNI` | `1` | `"aesni"` | `x86-64` legacy 2-operand SSE `AES-NI` (128-bit XMM) |
| `AREION_TIER_VEX` | `2` | `"vex"` | `x86-64` `AVX + AES-NI` 3-operand VEX-encoded XMM |
| `AREION_TIER_VAESAVX2` | `3` | `"vaesavx2"` | `x86-64` `AVX2 + VAES` (256-bit YMM Vector AES) |
| `AREION_TIER_AVX512` | `4` | `"avx512"` | `x86-64` `AVX-512F + AVX-512VL + VAES` (512-bit ZMM Vector AES) |
| `AREION_TIER_ARM64` | `5` | `"arm64"` | `ARM64` `NEON + ARMv8 Cryptographic Extension` (`AESE` / `AESMC` / `AESD` / `AESIMC`) |

---

### 2. Cryptographic Permutations (P1 and P2, Single-Block, Word-Level & 4-Way)

In-place forward and inverse permutations over 256-bit (32-byte, 10 rounds) and 512-bit (64-byte, 15 rounds) states, 32-bit little-endian word arrays, and 4-way parallel batches.

#### Core Permutations (P1, Table 1 — Isobe et al., TCHES 2023)

| Function | C Prototype (`areion.h`) | State Size | Description |
| :--- | :--- | :---: | :--- |
| `areion_permute256` | `void areion_permute256(uint8_t state[32])` | 32 B | 10-round forward permutation `P1_256` in place |
| `areion_inverse_permute256` | `void areion_inverse_permute256(uint8_t state[32])` | 32 B | 10-round inverse permutation `P1_256⁻¹` in place |
| `areion_permute512` | `void areion_permute512(uint8_t state[64])` | 64 B | 15-round forward permutation `P1_512` in place |
| `areion_inverse_permute512` | `void areion_inverse_permute512(uint8_t state[64])` | 64 B | 15-round inverse permutation `P1_512⁻¹` in place |
| `areion_permute256x4` | `void areion_permute256x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32])` | 4 × 32 B | 4-way parallel in-place forward `P1_256` |
| `areion_inverse_permute256x4` | `void areion_inverse_permute256x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32])` | 4 × 32 B | 4-way parallel in-place inverse `P1_256⁻¹` |
| `areion_permute512x4` | `void areion_permute512x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64])` | 4 × 64 B | 4-way parallel in-place forward `P1_512` |
| `areion_inverse_permute512x4` | `void areion_inverse_permute512x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64])` | 4 × 64 B | 4-way parallel in-place inverse `P1_512⁻¹` |

#### Word-Level Permutations (P1, Little-Endian `uint32_t` Words)

| Function | C Prototype (`areion.h`) | State Size | Description |
| :--- | :--- | :---: | :--- |
| `areion_permute256_words` | `void areion_permute256_words(uint32_t state[8])` | 8 × 32 b | 10-round forward `P1_256` on 8 little-endian `uint32_t` words |
| `areion_inverse_permute256_words` | `void areion_inverse_permute256_words(uint32_t state[8])` | 8 × 32 b | 10-round inverse `P1_256⁻¹` on 8 little-endian `uint32_t` words |
| `areion_permute512_words` | `void areion_permute512_words(uint32_t state[16])` | 16 × 32 b | 15-round forward `P1_512` on 16 little-endian `uint32_t` words |
| `areion_inverse_permute512_words` | `void areion_inverse_permute512_words(uint32_t state[16])` | 16 × 32 b | 15-round inverse `P1_512⁻¹` on 16 little-endian `uint32_t` words |

#### Domain-Separated Second Permutations (P2, Table 2 — π words 15..29)

| Function | C Prototype (`areion.h`) | State Size | Description |
| :--- | :--- | :---: | :--- |
| `areion_permute256_p2` | `void areion_permute256_p2(uint8_t state[32])` | 32 B | 10-round forward permutation `P2_256` in place (Table 2) |
| `areion_inverse_permute256_p2` | `void areion_inverse_permute256_p2(uint8_t state[32])` | 32 B | 10-round inverse permutation `P2_256⁻¹` in place (Table 2) |
| `areion_permute512_p2` | `void areion_permute512_p2(uint8_t state[64])` | 64 B | 15-round forward permutation `P2_512` in place (Table 2) |
| `areion_inverse_permute512_p2` | `void areion_inverse_permute512_p2(uint8_t state[64])` | 64 B | 15-round inverse permutation `P2_512⁻¹` in place (Table 2) |
| `areion_permute256_p2x4` | `void areion_permute256_p2x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32])` | 4 × 32 B | 4-way parallel in-place forward `P2_256` |
| `areion_inverse_permute256_p2x4` | `void areion_inverse_permute256_p2x4(uint8_t b0[32], uint8_t b1[32], uint8_t b2[32], uint8_t b3[32])` | 4 × 32 B | 4-way parallel in-place inverse `P2_256⁻¹` |
| `areion_permute512_p2x4` | `void areion_permute512_p2x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64])` | 4 × 64 B | 4-way parallel in-place forward `P2_512` |
| `areion_inverse_permute512_p2x4` | `void areion_inverse_permute512_p2x4(uint8_t b0[64], uint8_t b1[64], uint8_t b2[64], uint8_t b3[64])` | 4 × 64 B | 4-way parallel in-place inverse `P2_512⁻¹` |

---

### 3. Davies-Meyer Compression Functions

Fixed-input short-message compression functions (`Areion256-DM` and `Areion512-DM`, Section 4.1.1, Eqs. (1)–(3) of [ePrint 2023/794](https://eprint.iacr.org/2023/794)). Safe for in-place operation (`out == in`).

| Function | C Prototype (`areion.h`) | Input | Digest | Construction |
| :--- | :--- | :---: | :---: | :--- |
| `areion_dm256` | `void areion_dm256(uint8_t out[32], const uint8_t in[32])` | 32 B | 32 B | `h = P1_256(m) ⊕ m` |
| `areion_dm512` | `void areion_dm512(uint8_t out[32], const uint8_t in[64])` | 64 B | 32 B | 256-bit truncation of `P1_512(m) ⊕ m` keeping words `x2 \|\| x3 \|\| x6 \|\| x7 \|\| x8 \|\| x9 \|\| x12 \|\| x13` |

---

### 4. Sum of Even-Mansour (SoEM22) Pseudorandom Functions (PRFs)

Beyond-birthday-bound pseudorandom functions (secure up to `2^(2n/3)` queries) over `(P1, P2)` with a `2n`-bit key `K = K1 || K2` ([Chen, Lambooij, and Mennink, CRYPTO 2019](https://eprint.iacr.org/2019/554)). Single-block functions allow arbitrary pointer aliasing (`out == in` or `out == key`).

| Function | C Prototype (`areion.h`) | Input | Key (`K1 \|\| K2`) | Output | Construction |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `areion_soem256` | `void areion_soem256(uint8_t out[32], const uint8_t key[64], const uint8_t in[32])` | 32 B | 64 B | 32 B | `P1_256(m ⊕ K1) ⊕ P2_256(m ⊕ K2) ⊕ K1 ⊕ K2` |
| `areion_soem512` | `void areion_soem512(uint8_t out[64], const uint8_t key[128], const uint8_t in[64])` | 64 B | 128 B | 64 B | `P1_512(m ⊕ K1) ⊕ P2_512(m ⊕ K2) ⊕ K1 ⊕ K2` |
| `areion_soem256x4` | `void areion_soem256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t inputs[4][32])` | 4 × 32 B | 4 × 64 B | 4 × 32 B | 4-way parallel `areion_soem256` |
| `areion_soem512x4` | `void areion_soem512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t inputs[4][64])` | 4 × 64 B | 4 × 128 B | 4 × 64 B | 4-way parallel `areion_soem512` |

---

### 5. Invertible Wide-Block Ciphers (EM, EM2, TEM, TEM2)

Four families of invertible 256-bit (32-byte block, 64-byte key `K = K1 || K2`) and 512-bit (64-byte block, 128-byte key `K = K1 || K2`) wide-block ciphers and tweakable wide-block ciphers. All functions support in-place operation (`out == m`, `out == c`, `out == msgs`, `out == ct`).

#### 5.1 1-Round Even-Mansour (1-EM, Birthday-Bound Strong PRP)

| Function | C Prototype (`areion.h`) | Block | Key (`K1 \|\| K2`) | Construction |
| :--- | :--- | :---: | :---: | :--- |
| `areion_em_encrypt256` | `void areion_em_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t m[32])` | 32 B | 64 B | `C = P1_256(M ⊕ K1) ⊕ K2` |
| `areion_em_decrypt256` | `void areion_em_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t c[32])` | 32 B | 64 B | `M = P1_256⁻¹(C ⊕ K2) ⊕ K1` |
| `areion_em_encrypt512` | `void areion_em_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t m[64])` | 64 B | 128 B | `C = P1_512(M ⊕ K1) ⊕ K2` |
| `areion_em_decrypt512` | `void areion_em_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t c[64])` | 64 B | 128 B | `M = P1_512⁻¹(C ⊕ K2) ⊕ K1` |
| `areion_em_encrypt256x4` | `void areion_em_encrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32])` | 4 × 32 B | 4 × 64 B | 4-way parallel `areion_em_encrypt256` |
| `areion_em_decrypt256x4` | `void areion_em_decrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32])` | 4 × 32 B | 4 × 64 B | 4-way parallel `areion_em_decrypt256` |
| `areion_em_encrypt512x4` | `void areion_em_encrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64])` | 4 × 64 B | 4 × 128 B | 4-way parallel `areion_em_encrypt512` |
| `areion_em_decrypt512x4` | `void areion_em_decrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64])` | 4 × 64 B | 4 × 128 B | 4-way parallel `areion_em_decrypt512` |

#### 5.2 2-Round Independent-Permutation Even-Mansour (2-EM, Beyond-Birthday-Bound Strong PRP)

| Function | C Prototype (`areion.h`) | Block | Key (`K1 \|\| K2`) | Construction |
| :--- | :--- | :---: | :---: | :--- |
| `areion_em2_encrypt256` | `void areion_em2_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t m[32])` | 32 B | 64 B | `C = P2_256(P1_256(M ⊕ K1) ⊕ K2) ⊕ K1 ⊕ K2` |
| `areion_em2_decrypt256` | `void areion_em2_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t c[32])` | 32 B | 64 B | `M = P1_256⁻¹(P2_256⁻¹(C ⊕ K1 ⊕ K2) ⊕ K2) ⊕ K1` |
| `areion_em2_encrypt512` | `void areion_em2_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t m[64])` | 64 B | 128 B | `C = P2_512(P1_512(M ⊕ K1) ⊕ K2) ⊕ K1 ⊕ K2` |
| `areion_em2_decrypt512` | `void areion_em2_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t c[64])` | 64 B | 128 B | `M = P1_512⁻¹(P2_512⁻¹(C ⊕ K1 ⊕ K2) ⊕ K2) ⊕ K1` |
| `areion_em2_encrypt256x4` | `void areion_em2_encrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t msgs[4][32])` | 4 × 32 B | 4 × 64 B | 4-way parallel `areion_em2_encrypt256` |
| `areion_em2_decrypt256x4` | `void areion_em2_decrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t ct[4][32])` | 4 × 32 B | 4 × 64 B | 4-way parallel `areion_em2_decrypt256` |
| `areion_em2_encrypt512x4` | `void areion_em2_encrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t msgs[4][64])` | 4 × 64 B | 4 × 128 B | 4-way parallel `areion_em2_encrypt512` |
| `areion_em2_decrypt512x4` | `void areion_em2_decrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t ct[4][64])` | 4 × 64 B | 4 × 128 B | 4-way parallel `areion_em2_decrypt512` |

#### 5.3 1-Round Tweakable Even-Mansour (1-TEM, Birthday-Bound Strong TPRP)

| Function | C Prototype (`areion.h`) | Block | Key (`K1 \|\| K2`) | Tweak (`T`) | Construction |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `areion_tem_encrypt256` | `void areion_tem_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32])` | 32 B | 64 B | 32 B | `W = P2_256(T ⊕ K2) ⊕ K1`, `C = P1_256(M ⊕ W) ⊕ W` |
| `areion_tem_decrypt256` | `void areion_tem_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32])` | 32 B | 64 B | 32 B | `W = P2_256(T ⊕ K2) ⊕ K1`, `M = P1_256⁻¹(C ⊕ W) ⊕ W` |
| `areion_tem_encrypt512` | `void areion_tem_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64])` | 64 B | 128 B | 64 B | `W = P2_512(T ⊕ K2) ⊕ K1`, `C = P1_512(M ⊕ W) ⊕ W` |
| `areion_tem_decrypt512` | `void areion_tem_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64])` | 64 B | 128 B | 64 B | `W = P2_512(T ⊕ K2) ⊕ K1`, `M = P1_512⁻¹(C ⊕ W) ⊕ W` |
| `areion_tem_encrypt256x4` | `void areion_tem_encrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32])` | 4 × 32 B | 4 × 64 B | 4 × 32 B | 4-way parallel `areion_tem_encrypt256` |
| `areion_tem_decrypt256x4` | `void areion_tem_decrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32])` | 4 × 32 B | 4 × 64 B | 4 × 32 B | 4-way parallel `areion_tem_decrypt256` |
| `areion_tem_encrypt512x4` | `void areion_tem_encrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64])` | 4 × 64 B | 4 × 128 B | 4 × 64 B | 4-way parallel `areion_tem_encrypt512` |
| `areion_tem_decrypt512x4` | `void areion_tem_decrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64])` | 4 × 64 B | 4 × 128 B | 4 × 64 B | 4-way parallel `areion_tem_decrypt512` |

#### 5.4 2-Round BBB Tweakable Even-Mansour (2-TEM, Beyond-Birthday-Bound Strong TPRP)

With per-tweak masks `W1 = P1(T ⊕ K1) ⊕ K1` and `W2 = P2(T ⊕ K2) ⊕ K2`:

| Function | C Prototype (`areion.h`) | Block | Key (`K1 \|\| K2`) | Tweak (`T`) | Construction |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `areion_tem2_encrypt256` | `void areion_tem2_encrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t m[32])` | 32 B | 64 B | 32 B | `C = P2_256(P1_256(M ⊕ W1) ⊕ W2) ⊕ W1 ⊕ W2` |
| `areion_tem2_decrypt256` | `void areion_tem2_decrypt256(uint8_t out[32], const uint8_t k[64], const uint8_t t[32], const uint8_t c[32])` | 32 B | 64 B | 32 B | `M = P1_256⁻¹(P2_256⁻¹(C ⊕ W1 ⊕ W2) ⊕ W2) ⊕ W1` |
| `areion_tem2_encrypt512` | `void areion_tem2_encrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t m[64])` | 64 B | 128 B | 64 B | `C = P2_512(P1_512(M ⊕ W1) ⊕ W2) ⊕ W1 ⊕ W2` |
| `areion_tem2_decrypt512` | `void areion_tem2_decrypt512(uint8_t out[64], const uint8_t k[128], const uint8_t t[64], const uint8_t c[64])` | 64 B | 128 B | 64 B | `M = P1_512⁻¹(P2_512⁻¹(C ⊕ W1 ⊕ W2) ⊕ W2) ⊕ W1` |
| `areion_tem2_encrypt256x4` | `void areion_tem2_encrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t msgs[4][32])` | 4 × 32 B | 4 × 64 B | 4 × 32 B | 4-way parallel `areion_tem2_encrypt256` |
| `areion_tem2_decrypt256x4` | `void areion_tem2_decrypt256x4(uint8_t out[4][32], const uint8_t keys[4][64], const uint8_t tweaks[4][32], const uint8_t ct[4][32])` | 4 × 32 B | 4 × 64 B | 4 × 32 B | 4-way parallel `areion_tem2_decrypt256` |
| `areion_tem2_encrypt512x4` | `void areion_tem2_encrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t msgs[4][64])` | 4 × 64 B | 4 × 128 B | 4 × 64 B | 4-way parallel `areion_tem2_encrypt512` |
| `areion_tem2_decrypt512x4` | `void areion_tem2_decrypt512x4(uint8_t out[4][64], const uint8_t keys[4][128], const uint8_t tweaks[4][64], const uint8_t ct[4][64])` | 4 × 64 B | 4 × 128 B | 4 × 64 B | 4-way parallel `areion_tem2_decrypt512` |

---

### 6. Low-Level AES-128 & Round Primitives

Software word-level round primitives (`uint32_t[4]`), hardware-dispatched unkeyed and keyed 16-byte AES rounds, XOR helpers, and full 10-round AES-128 block encryption.

#### Unkeyed 32-Bit Word-Array Software Primitives (`uint32_t[4]`)

| Function | C Prototype (`areion.h`) | Description |
| :--- | :--- | :--- |
| `areion_round` | `void areion_round(const uint32_t in[4], uint32_t out[4])` | Unkeyed AES round (`SubBytes` → `ShiftRows` → `MixColumns`) in constant-time bitsliced software |
| `areion_final_round` | `void areion_final_round(const uint32_t in[4], uint32_t out[4])` | Unkeyed AES final round (`SubBytes` → `ShiftRows`) in constant-time bitsliced software |
| `areion_inv_round` | `void areion_inv_round(const uint32_t in[4], uint32_t out[4])` | Unkeyed inverse AES round (`InvShiftRows` → `InvSubBytes` → `InvMixColumns`) in software |
| `areion_inv_final_round` | `void areion_inv_final_round(const uint32_t in[4], uint32_t out[4])` | Unkeyed inverse AES final round (`InvShiftRows` → `InvSubBytes`) in software |
| `areion_inv_mix_columns` | `void areion_inv_mix_columns(const uint32_t in[4], uint32_t out[4])` | Standalone `InvMixColumns` linear transformation on 4 little-endian 32-bit words |

#### Hardware-Dispatched 16-Byte Round & Block Primitives

| Function | C Prototype (`areion.h`) | Description |
| :--- | :--- | :--- |
| `areion_round_hw` | `void areion_round_hw(uint8_t block[16])` | In-place unkeyed 16-byte AES round (zero round key) |
| `areion_final_round_hw` | `void areion_final_round_hw(uint8_t block[16])` | In-place unkeyed 16-byte AES final round (no `MixColumns`, zero round key) |
| `areion_round4_hw` | `void areion_round4_hw(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16])` | 4-block parallel in-place unkeyed AES round |
| `areion_final_round4_hw` | `void areion_final_round4_hw(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16])` | 4-block parallel in-place unkeyed AES final round |
| `areion_aes128_round` / `areion_aes_round_hw` | `void areion_aes128_round(uint8_t block[16], const uint8_t rk[16])` | In-place keyed 16-byte AES round (`SubBytes` → `ShiftRows` → `MixColumns` → `AddRoundKey`) |
| `areion_aes128_final_round` / `areion_aes_final_round_hw` | `void areion_aes128_final_round(uint8_t block[16], const uint8_t rk[16])` | In-place keyed 16-byte AES final round (`SubBytes` → `ShiftRows` → `AddRoundKey`) |
| `areion_aes128_round4` / `areion_aes_round4_hw` | `void areion_aes128_round4(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16], const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16])` | 4-block parallel in-place keyed AES round |
| `areion_aes128_final_round4` / `areion_aes_final_round4_hw` | `void areion_aes128_final_round4(uint8_t b0[16], uint8_t b1[16], uint8_t b2[16], uint8_t b3[16], const uint8_t rk0[16], const uint8_t rk1[16], const uint8_t rk2[16], const uint8_t rk3[16])` | 4-block parallel in-place keyed AES final round |
| `areion_xor_block` | `void areion_xor_block(uint8_t dst[16], const uint8_t src[16])` | In-place 16-byte XOR (`dst ^= src`) |
| `areion_xor_block4` | `void areion_xor_block4(uint8_t d0[16], uint8_t d1[16], uint8_t d2[16], uint8_t d3[16], const uint8_t s0[16], const uint8_t s1[16], const uint8_t s2[16], const uint8_t s3[16])` | 4-block 16-byte XOR (`d_i ^= s_i`) |
| `areion_expand_key128` | `void areion_expand_key128(const uint8_t key[16], uint8_t rk[11][16])` | Expands a 16-byte AES-128 key into 11 round keys (`rk[11][16]`) |
| `areion_wipe_expanded_key128` | `void areion_wipe_expanded_key128(uint8_t rk[11][16])` | DSE-resistant zeroization of an expanded AES-128 key schedule |
| `areion_aes128_encrypt_block` | `void areion_aes128_encrypt_block(uint8_t dst[16], const uint8_t src[16], const uint8_t rk[11][16])` | Full 10-round AES-128 single-block encryption (`dst` and `src` may alias) |
| `areion_aes128_encrypt4_blocks` | `void areion_aes128_encrypt4_blocks(uint8_t dst[4][16], const uint8_t src[4][16], const uint8_t rk[11][16])` | Full 10-round AES-128 4-block parallel encryption under shared `rk` |

---

### 7. Runtime Dispatch, Self-Test, and Memory Zeroization

Runtime CPU feature detection and tier override, FIPS 140-3 Known-Answer Self-Test (CAST), and DSE-resistant memory scrubbing.

| Function | C Prototype (`areion.h`) | Description |
| :--- | :--- | :--- |
| `areion_tier` | `const char *areion_tier(void)` | Returns the active dispatch tier name (`"avx512"`, `"vaesavx2"`, `"vex"`, `"aesni"`, `"arm64"`, or `"purec"`) |
| `areion_tier_code` | `areion_tier_t areion_tier_code(void)` | Returns the active `areion_tier_t` enum value |
| `areion_set_tier_override` | `bool areion_set_tier_override(areion_tier_t tier)` | Overrides the active tier by enum (`AREION_TIER_AUTO` restores auto-detection); returns `true` if supported |
| `areion_set_tier` | `bool areion_set_tier(const char *name)` | Overrides the active tier by string name (`"auto"`, `"purec"`, `"purego"`, `"aesni"`, `"vex"`, `"vaesavx2"`, `"avx512"`, `"arm64"`); also configurable via `AREION_FORCE_TIER` |
| `areion_use_hardware_acceleration` | `void areion_use_hardware_acceleration(bool enable)` | Enables (`true`) or disables (`false`, forcing `"purec"`) hardware acceleration |
| `areion_tier_supported` | `bool areion_tier_supported(areion_tier_t tier)` | Returns `true` if `tier` is supported by the current CPU, OS SIMD state, and build |
| `areion_zeroize` | `void areion_zeroize(void *p, size_t n)` | DSE-resistant zeroization of `n` bytes at `p` (safe when `p == NULL` or `n == 0`) |
| `areion_selftest` | `int areion_selftest(void)` | FIPS 140-3 Known-Answer Self-Test (CAST) across all primitives (`0` on pass, `-1` on failure) |

---

### 8. Pre-C23 `_Generic` Multi-Dimensional `const` Array Macros

In ISO C99 / C11 / C17 (prior to C23 N2607), passing a non-`const` 2D array such as `uint8_t keys[4][64]` to a parameter of type `const uint8_t keys[4][64]` (which decays to `const uint8_t (*)[64]`) triggers a pedantic pointer-target qualifier warning under `-Wpedantic`.

To make calling 2D-array functions warning-free under `-std=c99 -Wpedantic` and `-std=c11 -Wpedantic` without sacrificing type safety:
- Under **C11 / C17** (`__STDC_VERSION__ >= 201112L`), [`areion.h`](areion.h) defines type-checked `_Generic` macros (`AREION_CONST_U8_16`, `AREION_CONST_U8_32`, `AREION_CONST_U8_64`, `AREION_CONST_U8_128`) that accept only `uint8_t (*)[N]` or `const uint8_t (*)[N]`.
- Function-like wrapper macros are provided for `areion_soem{256,512}x4`, `areion_{em,em2,tem,tem2}_{encrypt,decrypt}{256,512}x4`, `areion_aes128_encrypt_block`, and `areion_aes128_encrypt4_blocks`.
- Taking the address of any function (e.g., `&areion_soem256x4`) or parenthesizing its name (`(areion_soem256x4)(...)`) bypasses the macro and references the underlying extern function symbol directly.

---

### 9. SUPERCOP (`eBACS`) C99 Wrappers (`supercop/`)

Standard SUPERCOP (`eBACS`) C99 `ref` wrappers (`api.h` + implementation `.c`) are provided in [`supercop/`](supercop/) and verified automatically by `make test`:

| SUPERCOP Directory | SUPERCOP Interface | Underlying `libareion` Entry Point(s) | Key / Tweak / Block Sizes |
| :--- | :--- | :--- | :---: |
| `supercop/crypto_core/areion256/ref/` | `crypto_core` | `areion_permute256` | 0 B / — / 32 B |
| `supercop/crypto_core/areion512/ref/` | `crypto_core` | `areion_permute512` | 0 B / — / 64 B |
| `supercop/crypto_prf/soem256/ref/` | `crypto_prf` | `areion_soem256` | 64 B / — / 32 B |
| `supercop/crypto_prf/soem512/ref/` | `crypto_prf` | `areion_soem512` | 128 B / — / 64 B |
| `supercop/crypto_tbc/em256/ref/` | `crypto_tbc_encrypt` / `decrypt` | `areion_em_encrypt256` / `areion_em_decrypt256` | 64 B / 0 B / 32 B |
| `supercop/crypto_tbc/em512/ref/` | `crypto_tbc_encrypt` / `decrypt` | `areion_em_encrypt512` / `areion_em_decrypt512` | 128 B / 0 B / 64 B |
| `supercop/crypto_tbc/em2256/ref/` | `crypto_tbc_encrypt` / `decrypt` | `areion_em2_encrypt256` / `areion_em2_decrypt256` | 64 B / 0 B / 32 B |
| `supercop/crypto_tbc/em2512/ref/` | `crypto_tbc_encrypt` / `decrypt` | `areion_em2_encrypt512` / `areion_em2_decrypt512` | 128 B / 0 B / 64 B |
| `supercop/crypto_tbc/tem256/ref/` | `crypto_tbc_encrypt` / `decrypt` | `areion_tem_encrypt256` / `areion_tem_decrypt256` | 64 B / 32 B / 32 B |
| `supercop/crypto_tbc/tem512/ref/` | `crypto_tbc_encrypt` / `decrypt` | `areion_tem_encrypt512` / `areion_tem_decrypt512` | 128 B / 64 B / 64 B |
| `supercop/crypto_tbc/tem2256/ref/` | `crypto_tbc_encrypt` / `decrypt` | `areion_tem2_encrypt256` / `areion_tem2_decrypt256` | 64 B / 32 B / 32 B |
| `supercop/crypto_tbc/tem2512/ref/` | `crypto_tbc_encrypt` / `decrypt` | `areion_tem2_encrypt512` / `areion_tem2_decrypt512` | 128 B / 64 B / 64 B |
