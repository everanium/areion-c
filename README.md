## Areion, Areion-SoEM-256/512 & Wide-Block Even-Mansour (EM / EM2 / TEM / TEM2) C + Assembly Reference Library

C99 + Assembly reference implementation of the **Areion** cryptographic permutation family, **Davies-Meyer** short-input compression, the **SoEM22** pseudorandom function (PRF), and four families of **256-bit and 512-bit wide-block Even-Mansour and Tweakable Even-Mansour ciphers (`EM`, `EM2`, `TEM`, `TEM2`)**.
Companion Go + Assembly reference library: **[`everanium/areion`](https://github.com/everanium/areion)**.

[![C Standard: C99 / C11](https://img.shields.io/badge/C-C99_%2F_C11-blue.svg)](areion.h)
[![static-analysis: passing](https://img.shields.io/badge/static--analysis-passing-green)](Makefile)
[![Coverage](https://img.shields.io/badge/coverage-99.4%25-brightgreen)](https://github.com/everanium/areion-c)
[![License: Apache-2.0 / MIT](https://img.shields.io/badge/License-Apache_2.0_OR_MIT-blue.svg)](#license)

---

## Overview

Areion (Isobe et al., [TCHES 2023](https://doi.org/10.46586/tches.v2023.i2.115-154); extended version [ePrint 2023/794](https://eprint.iacr.org/2023/794)) is a family of 256-bit (10-round) and 512-bit (15-round) cryptographic permutations built from hardware AES round instructions (`AESENC` / `AESE`).

- **Permutations (`P1` and `P2`, Forward & Inverse)**: 256-bit and 512-bit forward and inverse permutations `P1 / P1⁻¹` (Table 1, π words `0..14`) and domain-separated second permutations `P2 / P2⁻¹` (Table 2, π words `15..29`; see [`scripts/verify_p2_table.py`](scripts/README.md)).
- **Davies-Meyer Short-Input Compression (`areion_dm256`, `areion_dm512`)**: Fixed-input compression functions producing a 256-bit (32-byte) digest from a 32-byte or 64-byte block (Section 4.1.1 of [ePrint 2023/794](https://eprint.iacr.org/2023/794)).
- **Beyond-Birthday-Bound PRFs (`SoEM22`)**: 256-bit and 512-bit Sum of Even-Mansour pseudorandom functions `P1(M ⊕ K1) ⊕ P2(M ⊕ K2) ⊕ K1 ⊕ K2` ([Chen, Lambooij, and Mennink, CRYPTO 2019](https://eprint.iacr.org/2019/554)), secure up to `2^(2n/3)` queries in the ideal-permutation model.
- **Invertible Wide-Block Ciphers (`EM`, `EM2`, `TEM`, `TEM2`)**: Four 256-bit and 512-bit wide-block cipher families — 1-round Even-Mansour (`EM`, birthday-bound PRP), 2-round Even-Mansour (`EM2`, BBB `2^(2n/3)` PRP), 1-round Tweakable Even-Mansour (`TEM`, birthday-bound TPRP), and 2-round Tweakable Even-Mansour (`TEM2`, BBB `2^(2n/3)` TPRP).
- **4-Way Parallel SIMD Batching (`×4`)**: Batched `×4` entry points across all permutations, `SoEM22` PRFs, and `EM / EM2 / TEM / TEM2` wide-block ciphers.
- **Multi-Tier Hardware Dispatch & Portable Fallback**: Automatic runtime selection across `AVX-512 VAES`, `AVX2 + VAES`, `AVX + AES-NI (VEX)`, legacy `AES-NI`, `ARMv8 Crypto`, and a constant-time 64-bit bitsliced software fallback (`purec`), verified at startup by a FIPS 140-3 Known-Answer Self-Test (`areion_selftest`).
- **Constant-Time & Zeroization Hardening**: Zero external dependencies, strict ISO C99 / C11 / C++ (`extern "C"`), zero secret-dependent branches or table lookups, zero heap allocations (`0 B/op`, `malloc`/`free` never invoked), Intel CET `endbr64` + ARM64 `bti c` landing pads, and automatic scrubbing of temporary stack frames, SIMD vector registers (`XMM`/`YMM`/`ZMM`/`v0–v31`), and scratch GPRs before every return.

---

## Public API (`areion.h`)

**See [`API.md`](API.md) for the complete function-by-function specification, C prototypes, macro definitions, and parameter sizes.**

| Category | Exported Symbols (`areion.h`) | Block / State | Key (`K1 \|\| K2`) | Tweak (`T`) | Summary |
| :--- | :--- | :---: | :---: | :---: | :--- |
| **[Types & Constants](API.md#1-types-and-constants)** | `AREION_VERSION_*`, `AREION_*_SIZE`, `areion_tier_t` (`AREION_TIER_AUTO`..`AREION_TIER_ARM64`) | 16–64 B | — | — | Version macros, block/key/digest size constants in bytes, and hardware dispatch tier enum |
| **[Permutations (P1)](API.md#2-cryptographic-permutations-p1-and-p2-single-block-word-level--4-way)** | `areion_permute{256,512}{,_words,x4}`, `areion_inverse_permute{256,512}{,_words,x4}` | 32 / 64 B | — | — | 10-round Areion-256 and 15-round Areion-512 forward/inverse permutations (Table 1), word-level & 4-way batches |
| **[Permutations (P2)](API.md#2-cryptographic-permutations-p1-and-p2-single-block-word-level--4-way)** | `areion_permute{256,512}_p2{,x4}`, `areion_inverse_permute{256,512}_p2{,x4}` | 32 / 64 B | — | — | Domain-separated second permutations `P2 / P2⁻¹` (Table 2, π words 15..29) & 4-way batches |
| **[Davies-Meyer](API.md#3-davies-meyer-compression-functions)** | `areion_dm256`, `areion_dm512` | 32 / 64 B | — | — | Short-input compression functions writing a 32-byte digest: `P1(m) ⊕ m` and its 256-bit truncation |
| **[`SoEM22` PRFs](API.md#4-sum-of-even-mansour-soem22-pseudorandom-functions-prfs)** | `areion_soem{256,512}`, `areion_soem{256,512}x4` | 32 / 64 B | 64 / 128 B | — | Beyond-birthday-bound PRFs (secure up to `2^(2n/3)` queries) over `(P1, P2)` (single-block & 4-way batches) |
| **[`1-EM` & `2-EM` Ciphers](API.md#5-invertible-wide-block-ciphers-em-em2-tem-tem2)** | `areion_em{,2}_encrypt{256,512}{,x4}`, `areion_em{,2}_decrypt{256,512}{,x4}` | 32 / 64 B | 64 / 128 B | — | Invertible wide-block Even-Mansour ciphers: `1-EM` (birthday `2^(n/2)` PRP) and `2-EM` (BBB `2^(2n/3)` PRP) |
| **[`1-TEM` & `2-TEM` Ciphers](API.md#5-invertible-wide-block-ciphers-em-em2-tem-tem2)** | `areion_tem{,2}_encrypt{256,512}{,x4}`, `areion_tem{,2}_decrypt{256,512}{,x4}` | 32 / 64 B | 64 / 128 B | 32 / 64 B | Tweakable wide-block Even-Mansour ciphers: `1-TEM` (birthday `2^(n/2)` TPRP) and `2-TEM` (BBB `2^(2n/3)` TPRP) |
| **[AES-128 & Rounds](API.md#6-low-level-aes-128--round-primitives)** | `areion_{inv_,}{,final_}round{,_hw,4_hw}`, `areion_inv_mix_columns`, `areion_aes128_{,final_}round{,4}`, `areion_xor_block{,4}`, `areion_{expand,wipe_expanded}_key128`, `areion_aes128_encrypt{_block,4_blocks}` | 16 / 64 B | 16 B | — | Software word-level and hardware-dispatched AES-128 round primitives, key schedule expansion/wipe, and block encryption |
| **[Runtime, CAST & Zeroize](API.md#7-runtime-dispatch-self-test-and-memory-zeroization)** | `areion_tier{,_code,_supported}`, `areion_set_tier{,_override}`, `areion_use_hardware_acceleration`, `areion_selftest`, `areion_zeroize` | — | — | — | Runtime tier introspection/override, FIPS 140-3 Known-Answer Self-Test (CAST), and DSE-safe zeroization |

> **Pre-C23 `const` 2D-Array Ergonomics & SUPERCOP Wrappers:** [`areion.h`](areion.h) provides C11 `_Generic` wrapper macros (`AREION_CONST_U8_{16,32,64,128}`) so callers can pass non-`const` 2D arrays (such as `uint8_t keys[4][64]`) to `×4` batch functions without `-Wpedantic` diagnostics in C99 / C11 / C17 while keeping `&func` function-pointer expressions intact. See [Section 8](API.md#8-pre-c23-_generic-multi-dimensional-const-array-macros) and [Section 9 (`supercop/`)](API.md#9-supercop-ebacs-c99-wrappers-supercop) of [`API.md`](API.md) for details.

---

## Security & Cryptographic Constructions

### Shift Symmetry in Single-Permutation SoEM
A construction attempting to build SoEM from a single permutation `P` with a constant difference `d`:

```text
F(m) = P(m ⊕ k1) ⊕ P(m ⊕ k2 ⊕ d)
```

has a shift symmetry: for any input `m`, letting `m' = m ⊕ k1 ⊕ k2 ⊕ d` yields:

```text
F(m') = P(m' ⊕ k1) ⊕ P(m' ⊕ k2 ⊕ d) = P(m ⊕ k2 ⊕ d) ⊕ P(m ⊕ k1) = F(m)
```

The shift `k1 ⊕ k2 ⊕ d` is secret, but an adversary finds a colliding pair among about `2^(n/2)` queries and then confirms it on a second pair at the same offset, so security does not exceed the birthday bound. This is the attack on SoEM1 where `π1 = π2` in Section 4.1 of Chen, Lambooij, and Mennink, with the offset `d` added.

### SoEM22
[Chen, Lambooij, and Mennink (CRYPTO 2019)](https://eprint.iacr.org/2019/554) prove SoEM22 secure up to about `2^(2n/3)` queries (Theorem 1) when `P1` and `P2` are two independent random permutations and `k1`, `k2` are independent random keys:

```text
F(k1, k2, m) = P1(m ⊕ k1) ⊕ P2(m ⊕ k2) ⊕ k1 ⊕ k2
```

This library instantiates `P1` and `P2` as the Areion permutation under two different round-constant tables. Treating the two as independent permutations is an assumption about this instantiation, not a proven property. Stated in standard terms: if the round-constant table is regarded as the key of a block cipher, `P1` and `P2` are that cipher under two fixed, related keys, and the assumption is that this pair cannot be distinguished from two independent random permutations — a related-key assumption on Areion, not a consequence of the two tables being distinct.

### Even-Mansour (`EM`, `EM2`) and Tweakable Even-Mansour (`TEM`, `TEM2`) Wide-Block Ciphers

Whereas `areion_soem256` and `areion_soem512` are non-invertible PRFs, many wide-block applications (full-disk / storage encryption, wide-block AEAD, format-preserving encryption, and NIST wide-block accordion modes) require an **invertible wide-block cipher (PRP)** or **tweakable wide-block cipher (TPRP)** on `n ∈ {256, 512}` bits.

All four families split a `2n`-bit key `K = K1 || K2` into two `n`-bit subkeys `K1, K2 ∈ {0,1}^n` (64-byte key for `n = 256`, 128-byte key for `n = 512`):

1. **1-Round Even-Mansour (`1-EM`: `areion_em_encrypt256` / `areion_em_decrypt256`, `areion_em_encrypt512` / `areion_em_decrypt512`, and `×4` batches)**:
   ```text
   C = P1(M ⊕ K1) ⊕ K2
   M = P1⁻¹(C ⊕ K2) ⊕ K1
   ```
   By Even and Mansour ([ASIACRYPT 1991 / J. Cryptology 1997](https://doi.org/10.1007/s001459900025)), for an `n`-bit ideal permutation `P1`, any adversary making `q` construction queries and `p` permutation queries has distinguishing advantage bounded by `O(p·q / 2^n)`, giving **`n/2`-bit security** (`2^128` for `EM-256` and `2^256` for `EM-512`) at the cost of a single permutation call per block.

2. **2-Round Independent-Permutation Even-Mansour (`2-EM`: `areion_em2_encrypt256` / `areion_em2_decrypt256`, `areion_em2_encrypt512` / `areion_em2_decrypt512`, and `×4` batches)**:
   ```text
   C = P2(P1(M ⊕ K1) ⊕ K2) ⊕ K1 ⊕ K2
   M = P1⁻¹(P2⁻¹(C ⊕ K1 ⊕ K2) ⊕ K2) ⊕ K1
   ```
   By Bogdanov et al. ([EUROCRYPT 2012](https://doi.org/10.1007/978-3-642-29011-4_5)) and Chen and Steinberger ([EUROCRYPT 2014](https://doi.org/10.1007/978-3-642-55220-5_33)), 2-round iterated Even-Mansour with two independent permutations `(P1, P2)` and pairwise-independent round keys `(K1, K2, K1 ⊕ K2)` achieves **Beyond-Birthday-Bound (BBB) strong PRP security** up to `2^(2n/3)` queries (approximately `2^170.7` for `EM2-256` and `2^341.3` for `EM2-512`).

3. **1-Round Tweakable Even-Mansour (`1-TEM`: `areion_tem_encrypt256` / `areion_tem_decrypt256`, `areion_tem_encrypt512` / `areion_tem_decrypt512`, and `×4` batches)**:
   ```text
   W = P2(T ⊕ K2) ⊕ K1
   C = P1(M ⊕ W) ⊕ W
   M = P1⁻¹(C ⊕ W) ⊕ W
   ```
   Because `P2(T ⊕ K2) ⊕ K1` is a nonlinear Even-Mansour mask on the tweak `T` using the domain-separated permutation `P2` ([Lampe and Seurin, FSE 2013](https://doi.org/10.1007/978-3-662-43933-3_15); [Mennink, CRYPTO 2015](https://doi.org/10.1007/978-3-662-47989-6_30)), `TEM` provides **`n/2`-bit tweakable strong PRP security** (`2^128` for `TEM-256` and `2^256` for `TEM-512`) with full `n`-bit tweaks.

4. **2-Round BBB Tweakable Even-Mansour (`2-TEM`: `areion_tem2_encrypt256` / `areion_tem2_decrypt256`, `areion_tem2_encrypt512` / `areion_tem2_decrypt512`, and `×4` batches)**:
   ```text
   W1 = P1(T ⊕ K1) ⊕ K1,   W2 = P2(T ⊕ K2) ⊕ K2
   C  = P2(P1(M ⊕ W1) ⊕ W2) ⊕ W1 ⊕ W2
   M  = P1⁻¹(P2⁻¹(C ⊕ W1 ⊕ W2) ⊕ W2) ⊕ W1
   ```
   By Cogliati, Lampe, and Seurin ([CRYPTO 2015](https://doi.org/10.1007/978-3-662-47989-6_29)) and Dutta ([ASIACRYPT 2020](https://doi.org/10.1007/978-3-030-64837-4_19)), cascading two non-linearly tweaked Even-Mansour rounds with independent permutations `(P1, P2)` achieves **Beyond-Birthday-Bound (BBB) tweakable strong PRP security** up to `2^(2n/3)` queries (approximately `2^170.7` for `TEM2-256` and `2^341.3` for `TEM2-512`). Note that the outer whitening mask `W1 ⊕ W2 = P1(T ⊕ K1) ⊕ P2(T ⊕ K2) ⊕ K1 ⊕ K2` equals the `SoEM22` PRF evaluation on the tweak `T`, and computing `(W1, W2)` executes `P1(T ⊕ K1)` and `P2(T ⊕ K2)` in parallel using the same dual-pipeline interleaving as `SoEM22`.

### Table 2 Round Constants (`P2`)
Table 2 is proposed by Andrey Kuvshinov and derived by [`scripts/verify_p2_table.py`](scripts/README.md). Following the Nothing-Up-My-Sleeve (NUMS) methodology of the original Areion paper, it continues the same stream of π words:
- **Table 1 (`P1`)**: Words 0..14 of the fractional part of π (Table 1 and Appendix A.1 of ePrint 2023/794); RC7 is kept as published, `0x801f2e2858efc16636920d871574e690`, a one-nibble shift from π word 7.
- **Table 2 (`P2`)**: Words 15..29 of the fractional part of π (15 consecutive 128-bit words); RC7, π word 22, takes the same one-nibble shift, `0xf6d6ff383f442392e0b4482a48420040`, in agreement with the Areion authors. Words 7 and 22 are the only words among 0..29 that begin with a zero nibble, so the shift falls on RC7 in both tables. The shift is a matter of consistency with Table 1: every claim of [`everanium/areion/analysis/`](https://github.com/everanium/areion/blob/main/analysis/README.md) holds for both forms of this word.

The 15 hexadecimal entries of Table 2 (each stored in memory as 16 little-endian bytes; e.g., round 0 begins with bytes `93 e9 72 7c`; Areion-256 uses rounds 0..9 and Areion-512 uses rounds 0..14):

| Round | Hexadecimal constant (`P2`) |
| ---: | :--- |
| 0 | `b4cc5c341141e8cea15486af7c72e993` |
| 1 | `b3ee1411636fbc2a2ba9c55d741831f6` |
| 2 | `ce5c3e169b87931eafd6ba336c24cf5c` |
| 3 | `7a325381289586773b8f48986b4bb9af` |
| 4 | `c4bfe81b6628219361d809ccfb21a991` |
| 5 | `487cac605dec8032ef845d5de98575b1` |
| 6 | `dc262302eb651b8823893e81d396acc5` |
| 7 | `f6d6ff383f442392e0b4482a48420040` |
| 8 | `69c8f04a9e1f9b5e21c66842f6e96c9a` |
| 9 | `670c9c61abd388f06a51a0d2d8542f68` |
| 10 | `960fa728ab5133a36eef0b6c137a3be4` |
| 11 | `ba3bf0507efb2a98a1f1651d39af0176` |
| 12 | `66ca593e82430e888cee8619456f9fb4` |
| 13 | `7d84a5c33b8b5ebee06f75d885c12073` |
| 14 | `401a449f56c16aa64ed3aa62363f7706` |

[`scripts/verify_p2_table.py`](scripts/README.md) checks:
- All 30 constants are distinct: `|P1 ∩ P2| = 0`.
- Combined matrix `[P1; P2]` has full rank 30 over `GF(2)`.
- Hamming distance between `P1[i]` and `P2[j]` over all 225 pairs: min 50, mean 63.73.
- RC7 of both tables is the π word shifted by one nibble.
- No `P2` word has two equal 32-bit columns.

See [`everanium/areion/analysis/README.md`](https://github.com/everanium/areion/blob/main/analysis/README.md) for the complete SAT/MILP/algebraic cryptanalysis suite evaluating structure tying `P2` to `P1` beyond these constant checks: related-constant differential bounds (at least 154 active S-boxes over 10 rounds of Areion-256 and 240 over 15 rounds of Areion-512 across all key differences `δ = k1 ⊕ k2` in `GF(2)^128`), linear trail bounds (at least 65 and 101 active S-boxes per permutation, or 164 bits on Areion-512 with the two-S-box chain in `F3` weighted at its exact maximum), boomerang estimates, byte-structured symmetries and affine equivalences, BCLR invariant subspaces and weak cosets, impossible differentials, integral sums to order 5, an 11-level perturbation dissolution ladder (`L0..L4p`), forward-backward cross-composition `P2⁻¹ ∘ P1` and turnaround conservation laws, and state-clearing overhead measurements.

### Comparison with 128-bit Block Cipher PRP-as-PRF Bounds
Standard AES-128 and AES-256 operate on 128-bit blocks as pseudorandom permutations (PRPs); used directly as a PRF, any 128-bit permutation is distinguishable from a random function after about `2^64` distinct queries via birthday non-collision. The `areion_soem256` and `areion_soem512` interfaces instead accept 256-bit and 512-bit inputs with 512-bit and 1024-bit keys (`2n` bits), providing `2n/3`-bit ideal-permutation PRF bounds (up to `2^170.7` and `2^341.3` queries) while executing directly on native hardware AES round instructions.

---

## Hardware Acceleration & ABI Support

`libareion` automatically detects host CPU features and OS SIMD context support (`CPUID` + `XGETBV` on `x86-64`, `getauxval(AT_HWCAP)` / `sysctlbyname` on `arm64`):

| Tier | Architectures | Instructions Used | Register Width (`×4` functions) |
| :--- | :--- | :--- | :--- |
| **`avx512`** | Intel Ice Lake, Tiger Lake, Rocket Lake, Xeon Ice Lake-SP+; AMD Zen 4+ (`AVX-512F + AVX-512VL + VAES`) | `VAESENC`, `VAESENCLAST`, `VAESDEC`, `VAESDECLAST`, `VPXORD`, `VPXORQ`, `VBROADCASTI32X4` (2-instruction `VAESENCLAST` + `VAESDEC` 512-bit `InvMixColumns`) | 512-bit ZMM (4 AES blocks) |
| **`vaesavx2`** | Intel Alder Lake+ (no AVX-512); AMD Zen 3 (`AVX2 + VAES`) | `VAESENC`, `VAESENCLAST`, `VAESDEC`, `VAESDECLAST`, `VPXOR`, `VBROADCASTI128` (2-instruction `VAESENCLAST` + `VAESDEC` 256-bit `InvMixColumns`) | 256-bit YMM (2 AES blocks) |
| **`vex`** | Intel Sandy Bridge+, AMD Bulldozer+ (`AVX + AES-NI`) | 3-operand VEX XMM `VAESENC`, `VAESENCLAST`, `VAESDECLAST`, `VAESIMC`, `VPXOR` | 128-bit XMM (3-operand VEX) |
| **`aesni`** | Intel Westmere+ (`AES-NI` without `AVX`) | Legacy SSE `AESENC`, `AESENCLAST`, `AESDECLAST`, `AESIMC`, `PXOR` | 128-bit XMM (2-operand SSE) |
| **`arm64`** | ARMv8 with Cryptographic Extension, Apple Silicon, Graviton (`NEON + AES`) | `AESE`, `AESMC`, `AESD`, `AESIMC`, `VEOR` | 128-bit NEON |
| **`purec`** | All architectures — verified across 9 `qemu-*-static` targets (`aarch64`, `riscv64`, `s390x` 64-bit BE, `ppc64le`, `arm` 32-bit, `i386` 32-bit, `mips64` 64-bit BE, `mips` 32-bit BE, `loongarch64`) plus native `x86-64` | Constant-time 64-bit bitsliced Boyar–Peralta forward/inverse S-boxes & maskless linear layer | 64-bit bitsliced software (up to 4 blocks/word) |

> **Note on single-block and 4-way fused execution:** Single-block primitives (`areion_permute*`, `areion_dm*`, `areion_soem*`, `areion_em_*`, `areion_em2_*`, `areion_tem_*`, `areion_tem2_*`) operate on 128-bit XMM registers (`x86-64`) or 128-bit NEON registers (`arm64`); on `x86-64` systems with AVX (`vex`, `vaesavx2`, `avx512`), they use 3-operand VEX instructions (`VAESENC`) to eliminate `MOVAPS` register-copy overhead, falling back to 2-operand `AESENC` only on Westmere (`aesni`). Both single-block and 4-way batched (`×4`) primitives (`SoEM22`, `EM`, `EM2`, `TEM`, `TEM2`) execute inside dedicated fused assembly kernels (`areion_amd64.S`, `areion_soem256_amd64.S`, `areion_soem512_amd64.S`, `areion_soem_aesni_amd64.S`, `areion_arm64.S`, `msvc/*.asm`) without intermediate stack round-trips or redundant Structure-of-Arrays (SoA) transpositions.

> **Cross-OS & Cross-Assembler Support:**
> - **GNU GAS / Clang Integrated Assembler (`.S`)**: Supports Linux ELF (`x86_64`, `aarch64`), macOS Mach-O (`x86_64`, `arm64`), and Windows MinGW-w64 COFF (`x86_64`) via `asm_abi.h` (including automatic Windows x64 `XMM6..XMM15` non-volatile save/restore and parameter register remapping).
> - **Microsoft Visual Studio (`msvc/*.asm`)**: Pre-generated MASM (`ml64.exe`) and ARMASM64 (`armasm64.exe`) sources selected automatically by `CMakeLists.txt` when building with MSVC.

> **Register and stack zeroization:** All hardware assembly kernels (both single-block and `×4` batch functions) execute directly in registers with zero secret stack spills (zero-byte stack frame on SysV `x86-64` and `arm64`, no intermediate AoS↔SoA stack buffers) and clear all touched vector registers (`PXOR` / `VPXOR` / `VPXORD` on `X0..X30` plus `VZEROUPPER` on `x86-64`; `VEOR` on `V0..V31` on `arm64`) and scratch general-purpose registers before returning. On `purec` fallback paths, C routines scrub local buffers via DSE-resistant `areion_secure_wipe` (`volatile uint8_t *` + compiler barrier), scrub their software stack frame (`areion_wipe_software_stack`), and clobber volatile scratch GPRs (`areion_clobber_scratch_gprs`). Verified across all tiers by `areion_zeroize_test.c` (with mandatory negative controls); see [`everanium/areion/analysis/README.md` (Section L)](https://github.com/everanium/areion/blob/main/analysis/README.md#l-register-and-stack-clearing-cost) for instruction-count and cycle-per-byte overhead measurements.

---

## Benchmarks

### 1. Intel® Core™ i7-11700K @ 3.60GHz (Rocket Lake, x86-64)

3-run averaged throughput and latency comparison across all 5 execution tiers on the same physical CPU (generated via `python3 scripts/run_bench.py`; reference cycles per byte `c = f · t / B` at `f = 3.60 GHz` reach `0.32 c/B` on `areion_permute512x4` / `areion_permute512_p2x4`, `0.58 c/B` on `areion_inverse_permute512x4` / `areion_inverse_permute512_p2x4`, `0.45` / `0.56 c/B` on `areion_soem256x4` / `areion_soem512x4`, and `0.26 c/B` on `areion_em_encrypt256x4` / `areion_em_encrypt512x4`):

#### Core Permutations, Davies-Meyer, SoEM22 & AES-128 Primitives

| Operation | `purec` (Bitsliced) | `aesni` (128-bit SSE) | `vex` (128-bit VEX) | `vaesavx2` (256-bit YMM) | `avx512` (512-bit ZMM) | Speedup vs `purec` | Cycles/Byte (best tier) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **`areion_permute256`** | 37.3 MB/s (858.86 ns) | 2,087.3 MB/s (15.33 ns) | 2,127.9 MB/s (15.04 ns) | 2,131.8 MB/s (15.01 ns) | 2,135.9 MB/s (14.98 ns) | 57.3× | 1.69 c/B |
| **`areion_permute512`** | 51.4 MB/s (1,245.90 ns) | 4,064.1 MB/s (15.75 ns) | 4,043.5 MB/s (15.83 ns) | 4,035.2 MB/s (15.86 ns) | 4,054.6 MB/s (15.78 ns) | 79.1× | 0.89 c/B |
| **`areion_inverse_permute256`** | 39.9 MB/s (802.29 ns) | 1,471.0 MB/s (21.75 ns) | 1,478.6 MB/s (21.64 ns) | 1,468.4 MB/s (21.79 ns) | 1,474.4 MB/s (21.70 ns) | 37.1× | 2.43 c/B |
| **`areion_inverse_permute512`** | 39.2 MB/s (1,634.09 ns) | 1,733.0 MB/s (36.93 ns) | 1,736.9 MB/s (36.85 ns) | 1,730.2 MB/s (36.99 ns) | 1,734.4 MB/s (36.90 ns) | 44.3× | 2.07 c/B |
| **`areion_permute256_p2`** | 36.9 MB/s (867.75 ns) | 2,085.3 MB/s (15.34 ns) | 2,130.6 MB/s (15.02 ns) | 2,125.1 MB/s (15.06 ns) | 2,131.3 MB/s (15.01 ns) | 57.8× | 1.69 c/B |
| **`areion_permute512_p2`** | 49.8 MB/s (1,287.39 ns) | 4,093.1 MB/s (15.64 ns) | 4,068.2 MB/s (15.73 ns) | 4,066.8 MB/s (15.74 ns) | 4,064.5 MB/s (15.75 ns) | 82.2× | 0.88 c/B |
| **`areion_inverse_permute256_p2`** | 39.7 MB/s (809.17 ns) | 1,478.5 MB/s (21.64 ns) | 1,475.9 MB/s (21.68 ns) | 1,477.9 MB/s (21.65 ns) | 1,473.9 MB/s (21.71 ns) | 37.2× | 2.43 c/B |
| **`areion_inverse_permute512_p2`** | 38.1 MB/s (1,679.73 ns) | 1,725.8 MB/s (37.09 ns) | 1,736.7 MB/s (36.85 ns) | 1,729.0 MB/s (37.02 ns) | 1,730.9 MB/s (36.98 ns) | 45.6× | 2.07 c/B |
| **`areion_dm256`** | 37.7 MB/s (850.89 ns) | 5,512.9 MB/s (5.81 ns) | 5,638.8 MB/s (5.89 ns) | 5,852.8 MB/s (5.53 ns) | 6,048.6 MB/s (5.32 ns) | 160.4× | 0.60 c/B |
| **`areion_dm512`** | 52.7 MB/s (1,216.78 ns) | 5,247.0 MB/s (12.32 ns) | 5,564.2 MB/s (11.53 ns) | 5,764.0 MB/s (11.11 ns) | 5,621.4 MB/s (11.39 ns) | 109.4× | 0.62 c/B |
| **`areion_soem256`** | 35.6 MB/s (898.71 ns) | 2,910.7 MB/s (11.00 ns) | 3,025.0 MB/s (10.60 ns) | 3,028.5 MB/s (10.58 ns) | 3,057.5 MB/s (10.47 ns) | 85.9× | 1.18 c/B |
| **`areion_soem512`** | 46.6 MB/s (1,382.82 ns) | 2,923.8 MB/s (21.93 ns) | 2,944.1 MB/s (21.75 ns) | 2,994.4 MB/s (21.40 ns) | 3,140.5 MB/s (20.38 ns) | 67.4× | 1.15 c/B |
| **`areion_permute256x4`** | 141.7 MB/s (904.08 ns) | 7,052.1 MB/s (18.21 ns) | 6,873.1 MB/s (18.63 ns) | 7,395.5 MB/s (17.31 ns) | 6,732.1 MB/s (19.01 ns) | 52.2× | 0.49 c/B |
| **`areion_permute512x4`** | 153.9 MB/s (1,664.74 ns) | 6,697.2 MB/s (38.36 ns) | 6,985.7 MB/s (36.66 ns) | 10,918.7 MB/s (23.54 ns) | 11,154.2 MB/s (22.96 ns) | 72.5× | 0.32 c/B |
| **`areion_inverse_permute256x4`** | 141.4 MB/s (907.85 ns) | 5,425.1 MB/s (23.61 ns) | 5,549.9 MB/s (23.07 ns) | 5,339.5 MB/s (23.97 ns) | 5,054.8 MB/s (25.32 ns) | 39.2× | 0.65 c/B |
| **`areion_inverse_permute512x4`** | 127.4 MB/s (2,010.35 ns) | 3,644.3 MB/s (70.26 ns) | 3,826.4 MB/s (66.92 ns) | 5,385.0 MB/s (47.94 ns) | 6,248.6 MB/s (40.97 ns) | 49.0× | 0.58 c/B |
| **`areion_permute256_p2x4`** | 137.8 MB/s (930.42 ns) | 6,899.5 MB/s (18.60 ns) | 6,579.0 MB/s (19.48 ns) | 7,428.6 MB/s (17.23 ns) | 6,732.5 MB/s (19.01 ns) | 53.9× | 0.48 c/B |
| **`areion_permute512_p2x4`** | 144.3 MB/s (1,776.67 ns) | 6,636.7 MB/s (38.59 ns) | 7,111.2 MB/s (36.02 ns) | 10,977.3 MB/s (23.33 ns) | 11,291.1 MB/s (22.67 ns) | 78.2× | 0.32 c/B |
| **`areion_inverse_permute256_p2x4`** | 151.9 MB/s (843.20 ns) | 5,355.0 MB/s (23.92 ns) | 5,522.9 MB/s (23.18 ns) | 5,338.3 MB/s (23.98 ns) | 5,082.5 MB/s (25.19 ns) | 36.4× | 0.65 c/B |
| **`areion_inverse_permute512_p2x4`** | 121.7 MB/s (2,104.11 ns) | 3,660.2 MB/s (69.97 ns) | 3,836.5 MB/s (66.73 ns) | 5,728.2 MB/s (44.76 ns) | 6,253.9 MB/s (40.93 ns) | 51.4× | 0.58 c/B |
| **`areion_soem256x4`** | 72.5 MB/s (1,766.66 ns) | 3,797.9 MB/s (33.86 ns) | 3,967.2 MB/s (32.27 ns) | 6,142.5 MB/s (20.93 ns) | 7,952.7 MB/s (16.14 ns) | 109.7× | 0.45 c/B |
| **`areion_soem512x4`** | 72.3 MB/s (3,566.48 ns) | 2,604.4 MB/s (98.45 ns) | 3,155.3 MB/s (81.27 ns) | 5,843.3 MB/s (43.86 ns) | 6,425.2 MB/s (39.87 ns) | 88.9× | 0.56 c/B |
| **`areion_aes128_round`** | 116.1 MB/s (139.15 ns) | 6,067.3 MB/s (2.65 ns) | 6,455.7 MB/s (2.48 ns) | 6,126.4 MB/s (2.62 ns) | 6,299.4 MB/s (2.54 ns) | 55.6× | 0.56 c/B |
| **`areion_aes128_round4`** | 398.2 MB/s (160.72 ns) | 12,548.4 MB/s (5.10 ns) | 12,770.3 MB/s (5.02 ns) | 12,710.3 MB/s (5.04 ns) | 13,259.2 MB/s (4.83 ns) | 33.3× | 0.27 c/B |
| **`areion_expand_key128`** | 594.4 MB/s (296.60 ns) | 4,721.8 MB/s (37.30 ns) | 4,830.2 MB/s (36.45 ns) | 4,779.6 MB/s (36.86 ns) | 4,629.7 MB/s (38.04 ns) | 8.1× | 0.75 c/B |
| **`areion_aes128_encrypt_block`** | 30.0 MB/s (534.05 ns) | 1,903.2 MB/s (8.41 ns) | 1,898.5 MB/s (8.43 ns) | 1,911.9 MB/s (8.37 ns) | 1,899.6 MB/s (8.42 ns) | 63.7× | 1.88 c/B |
| **`areion_aes128_encrypt4_blocks`** | 126.5 MB/s (506.04 ns) | 7,291.1 MB/s (8.78 ns) | 7,105.3 MB/s (9.01 ns) | 7,353.3 MB/s (8.70 ns) | 7,383.8 MB/s (8.67 ns) | 58.4× | 0.49 c/B |

#### Wide-Block Ciphers (`EM`, `EM2`, `TEM`, `TEM2`) vs. `Rijndael-256` & `Vistrutah-256/512`

| Operation | `purec` (Bitsliced) | `aesni` (128-bit SSE) | `vex` (128-bit VEX) | `vaesavx2` (256-bit YMM) | `avx512` (512-bit ZMM) | Speedup vs `purec` | Cycles/Byte (best tier) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **`areion_em_encrypt256`** | 36.6 MB/s (874.59 ns) | 4,548.9 MB/s (7.14 ns) | 5,136.7 MB/s (6.30 ns) | 5,695.4 MB/s (5.68 ns) | 5,744.7 MB/s (5.58 ns) | 157.0× | 0.63 c/B |
| **`areion_em_decrypt256`** | 37.6 MB/s (853.52 ns) | 3,979.9 MB/s (8.05 ns) | 4,441.0 MB/s (7.25 ns) | 4,310.0 MB/s (7.44 ns) | 4,385.0 MB/s (7.31 ns) | 118.1× | 0.82 c/B |
| **`areion_em_encrypt512`** | 51.2 MB/s (1,251.40 ns) | 5,039.2 MB/s (12.72 ns) | 5,114.4 MB/s (12.54 ns) | 5,518.5 MB/s (11.61 ns) | 5,588.2 MB/s (11.46 ns) | 109.1× | 0.64 c/B |
| **`areion_em_decrypt512`** | 37.3 MB/s (1,722.77 ns) | 2,765.6 MB/s (23.16 ns) | 2,811.3 MB/s (22.79 ns) | 2,755.4 MB/s (23.24 ns) | 2,875.5 MB/s (22.27 ns) | 77.1× | 1.25 c/B |
| **`areion_em2_encrypt256`** | 19.5 MB/s (1,640.20 ns) | 2,130.7 MB/s (15.03 ns) | 2,185.0 MB/s (14.68 ns) | 2,220.7 MB/s (14.47 ns) | 2,265.7 MB/s (14.13 ns) | 116.2× | 1.59 c/B |
| **`areion_em2_decrypt256`** | 20.7 MB/s (1,552.37 ns) | 1,627.3 MB/s (19.69 ns) | 1,598.6 MB/s (20.04 ns) | 1,664.5 MB/s (19.23 ns) | 1,608.0 MB/s (19.95 ns) | 80.4× | 2.16 c/B |
| **`areion_em2_encrypt512`** | 26.5 MB/s (2,424.97 ns) | 2,382.2 MB/s (26.87 ns) | 2,417.6 MB/s (26.47 ns) | 2,360.6 MB/s (27.13 ns) | 2,312.8 MB/s (27.68 ns) | 91.2× | 1.49 c/B |
| **`areion_em2_decrypt512`** | 19.8 MB/s (3,236.17 ns) | 1,031.9 MB/s (62.02 ns) | 1,082.6 MB/s (59.12 ns) | 1,065.9 MB/s (60.06 ns) | 1,082.7 MB/s (59.15 ns) | 54.7× | 3.33 c/B |
| **`areion_tem_encrypt256`** | 19.2 MB/s (1,662.21 ns) | 2,188.9 MB/s (14.62 ns) | 2,318.2 MB/s (13.81 ns) | 2,216.4 MB/s (14.45 ns) | 2,192.3 MB/s (14.64 ns) | 120.7× | 1.55 c/B |
| **`areion_tem_decrypt256`** | 19.3 MB/s (1,660.74 ns) | 1,935.1 MB/s (16.58 ns) | 2,011.1 MB/s (15.96 ns) | 1,970.4 MB/s (16.27 ns) | 2,045.4 MB/s (15.65 ns) | 106.0× | 1.76 c/B |
| **`areion_tem_encrypt512`** | 26.6 MB/s (2,416.33 ns) | 2,279.7 MB/s (28.15 ns) | 2,328.7 MB/s (27.48 ns) | 2,257.2 MB/s (28.37 ns) | 2,305.7 MB/s (27.77 ns) | 87.5× | 1.55 c/B |
| **`areion_tem_decrypt512`** | 22.7 MB/s (2,832.90 ns) | 1,580.2 MB/s (40.53 ns) | 1,612.7 MB/s (39.72 ns) | 1,607.5 MB/s (39.82 ns) | 1,586.1 MB/s (40.38 ns) | 71.0× | 2.23 c/B |
| **`areion_tem2_encrypt256`** | 12.6 MB/s (2,537.32 ns) | 1,118.5 MB/s (28.61 ns) | 1,112.2 MB/s (28.83 ns) | 1,153.0 MB/s (27.76 ns) | 1,111.1 MB/s (28.82 ns) | 91.5× | 3.12 c/B |
| **`areion_tem2_decrypt256`** | 13.8 MB/s (2,322.53 ns) | 861.5 MB/s (37.23 ns) | 841.6 MB/s (38.12 ns) | 859.4 MB/s (37.33 ns) | 857.0 MB/s (37.42 ns) | 62.4× | 4.19 c/B |
| **`areion_tem2_encrypt512`** | 18.0 MB/s (3,565.41 ns) | 1,302.5 MB/s (49.20 ns) | 1,332.3 MB/s (48.05 ns) | 1,362.9 MB/s (46.96 ns) | 1,302.0 MB/s (49.16 ns) | 75.7× | 2.64 c/B |
| **`areion_tem2_decrypt512`** | 13.4 MB/s (4,799.69 ns) | 765.6 MB/s (83.60 ns) | 768.5 MB/s (83.28 ns) | 761.0 MB/s (84.11 ns) | 769.0 MB/s (83.24 ns) | 57.4× | 4.68 c/B |
| **`areion_em_encrypt256x4`** | 136.4 MB/s (940.35 ns) | 7,092.2 MB/s (18.14 ns) | 7,692.6 MB/s (16.65 ns) | 10,818.6 MB/s (11.90 ns) | 13,961.2 MB/s (9.29 ns) | 102.4× | 0.26 c/B |
| **`areion_em_decrypt256x4`** | 144.2 MB/s (888.27 ns) | 6,283.4 MB/s (20.38 ns) | 6,526.6 MB/s (19.63 ns) | 8,950.4 MB/s (14.34 ns) | 11,907.6 MB/s (10.80 ns) | 82.6× | 0.30 c/B |
| **`areion_em_encrypt512x4`** | 150.2 MB/s (1,707.56 ns) | 6,224.5 MB/s (41.14 ns) | 6,830.9 MB/s (37.49 ns) | 10,745.0 MB/s (23.85 ns) | 13,952.4 MB/s (18.37 ns) | 92.9× | 0.26 c/B |
| **`areion_em_decrypt512x4`** | 120.0 MB/s (2,135.47 ns) | 3,556.1 MB/s (71.99 ns) | 3,696.0 MB/s (69.26 ns) | 6,406.7 MB/s (39.96 ns) | 8,134.3 MB/s (31.48 ns) | 67.8× | 0.44 c/B |
| **`areion_em2_encrypt256x4`** | 73.0 MB/s (1,757.36 ns) | 3,561.1 MB/s (36.17 ns) | 3,632.3 MB/s (35.27 ns) | 4,152.0 MB/s (30.86 ns) | 6,354.7 MB/s (20.17 ns) | 87.1× | 0.57 c/B |
| **`areion_em2_decrypt256x4`** | 80.7 MB/s (1,585.94 ns) | 2,929.5 MB/s (43.70 ns) | 3,051.5 MB/s (41.95 ns) | 3,207.4 MB/s (39.91 ns) | 5,585.0 MB/s (22.94 ns) | 69.2× | 0.65 c/B |
| **`areion_em2_encrypt512x4`** | 75.5 MB/s (3,392.27 ns) | 2,820.5 MB/s (90.96 ns) | 3,318.5 MB/s (77.17 ns) | 4,611.5 MB/s (55.53 ns) | 6,752.2 MB/s (37.99 ns) | 89.4× | 0.53 c/B |
| **`areion_em2_decrypt512x4`** | 61.8 MB/s (4,161.17 ns) | 1,666.7 MB/s (153.64 ns) | 1,723.0 MB/s (148.59 ns) | 2,140.1 MB/s (119.66 ns) | 3,670.7 MB/s (69.75 ns) | 59.4× | 0.98 c/B |
| **`areion_tem_encrypt256x4`** | 73.8 MB/s (1,735.93 ns) | 3,557.8 MB/s (35.99 ns) | 3,618.2 MB/s (35.43 ns) | 4,274.9 MB/s (30.01 ns) | 6,322.2 MB/s (20.33 ns) | 85.7× | 0.57 c/B |
| **`areion_tem_decrypt256x4`** | 76.0 MB/s (1,685.89 ns) | 2,980.0 MB/s (43.11 ns) | 3,034.3 MB/s (42.19 ns) | 3,823.9 MB/s (33.48 ns) | 5,779.2 MB/s (22.36 ns) | 76.0× | 0.63 c/B |
| **`areion_tem_encrypt512x4`** | 77.0 MB/s (3,335.02 ns) | 2,944.8 MB/s (87.89 ns) | 3,251.5 MB/s (78.75 ns) | 4,628.3 MB/s (55.35 ns) | 6,901.7 MB/s (37.13 ns) | 89.6× | 0.52 c/B |
| **`areion_tem_decrypt512x4`** | 69.2 MB/s (3,699.74 ns) | 2,216.1 MB/s (115.52 ns) | 2,272.7 MB/s (112.65 ns) | 3,168.1 MB/s (80.83 ns) | 4,934.7 MB/s (51.88 ns) | 71.3× | 0.73 c/B |
| **`areion_tem2_encrypt256x4`** | 36.6 MB/s (3,496.08 ns) | 1,562.6 MB/s (81.93 ns) | 1,545.1 MB/s (82.84 ns) | 2,126.2 MB/s (60.23 ns) | 3,442.5 MB/s (37.21 ns) | 94.1× | 1.05 c/B |
| **`areion_tem2_decrypt256x4`** | 39.3 MB/s (3,253.62 ns) | 1,218.5 MB/s (105.06 ns) | 1,304.6 MB/s (98.16 ns) | 1,697.2 MB/s (75.44 ns) | 3,014.9 MB/s (42.50 ns) | 76.7× | 1.20 c/B |
| **`areion_tem2_encrypt512x4`** | 39.1 MB/s (6,585.59 ns) | 1,280.9 MB/s (199.96 ns) | 1,344.3 MB/s (190.44 ns) | 2,621.6 MB/s (97.68 ns) | 3,531.1 MB/s (72.62 ns) | 90.3× | 1.02 c/B |
| **`areion_tem2_decrypt512x4`** | 35.2 MB/s (7,289.47 ns) | 743.0 MB/s (344.69 ns) | 766.7 MB/s (333.97 ns) | 1,460.3 MB/s (175.32 ns) | 2,404.3 MB/s (106.49 ns) | 68.3× | 1.50 c/B |
| **`Rijndael-256`** | 44.5 MB/s (720.13 ns) | 2,155.0 MB/s (14.85 ns) | 1,672.0 MB/s (19.14 ns) | 1,641.8 MB/s (19.52 ns) | 1,702.5 MB/s (18.81 ns) | 48.4× | 1.67 c/B |
| **`Rijndael-256x4`** | 117.1 MB/s (1,095.58 ns) | 3,344.6 MB/s (38.45 ns) | 2,924.2 MB/s (44.20 ns) | 3,979.7 MB/s (32.21 ns) | 7,112.1 MB/s (18.00 ns) | 60.7× | 0.51 c/B |
| **`Vistrutah-256 (10r)`** | 47.6 MB/s (672.43 ns) | 3,389.4 MB/s (9.47 ns) | 3,512.6 MB/s (9.14 ns) | 4,811.8 MB/s (6.69 ns) | 4,782.5 MB/s (6.70 ns) | 101.1× | 0.75 c/B |
| **`Vistrutah-256 (14r)`** | 35.6 MB/s (898.58 ns) | 2,404.8 MB/s (13.31 ns) | 2,432.2 MB/s (13.19 ns) | 3,284.4 MB/s (9.75 ns) | 3,127.6 MB/s (10.26 ns) | 92.3× | 1.10 c/B |
| **`Vistrutah-256x4 (10r)`** | 96.9 MB/s (1,328.58 ns) | 5,835.4 MB/s (22.10 ns) | 5,774.6 MB/s (22.22 ns) | 8,536.2 MB/s (15.01 ns) | 11,430.7 MB/s (11.20 ns) | 118.0× | 0.32 c/B |
| **`Vistrutah-256x4 (14r)`** | 76.9 MB/s (1,663.98 ns) | 4,230.1 MB/s (30.33 ns) | 4,260.4 MB/s (30.05 ns) | 6,203.8 MB/s (20.66 ns) | 7,814.1 MB/s (16.41 ns) | 101.6× | 0.46 c/B |
| **`Vistrutah-512-256 (10r)`** | 88.4 MB/s (724.89 ns) | 3,986.6 MB/s (16.07 ns) | 3,971.8 MB/s (16.41 ns) | 4,615.3 MB/s (13.89 ns) | 4,045.9 MB/s (15.83 ns) | 52.2× | 0.78 c/B |
| **`Vistrutah-512-256 (14r)`** | 67.2 MB/s (954.45 ns) | 2,771.9 MB/s (23.15 ns) | 2,813.6 MB/s (22.92 ns) | 3,232.0 MB/s (19.81 ns) | 2,651.2 MB/s (24.18 ns) | 48.1× | 1.11 c/B |
| **`Vistrutah-512-256 (18r)`** | 52.4 MB/s (1,224.42 ns) | 2,143.0 MB/s (29.87 ns) | 2,078.9 MB/s (30.87 ns) | 2,376.7 MB/s (26.93 ns) | 1,958.7 MB/s (32.72 ns) | 45.4× | 1.51 c/B |
| **`Vistrutah-512-512 (12r)`** | 78.5 MB/s (815.18 ns) | 3,241.8 MB/s (19.80 ns) | 3,366.9 MB/s (19.14 ns) | 3,971.4 MB/s (16.12 ns) | 3,525.8 MB/s (18.19 ns) | 50.6× | 0.91 c/B |
| **`Vistrutah-512-512 (18r)`** | 54.5 MB/s (1,173.59 ns) | 2,104.5 MB/s (30.44 ns) | 2,109.8 MB/s (30.41 ns) | 2,495.6 MB/s (25.67 ns) | 2,101.7 MB/s (30.47 ns) | 45.8× | 1.44 c/B |
| **`Vistrutah-512-256x4 (10r)`** | 100.0 MB/s (2,560.82 ns) | 5,015.2 MB/s (51.07 ns) | 5,064.5 MB/s (50.59 ns) | 8,544.6 MB/s (29.98 ns) | 10,102.5 MB/s (25.39 ns) | 101.0× | 0.36 c/B |
| **`Vistrutah-512-256x4 (14r)`** | 67.8 MB/s (3,779.39 ns) | 3,119.7 MB/s (82.08 ns) | 3,240.3 MB/s (79.16 ns) | 6,370.9 MB/s (40.26 ns) | 7,156.3 MB/s (35.78 ns) | 105.6× | 0.50 c/B |
| **`Vistrutah-512-256x4 (18r)`** | 55.7 MB/s (4,598.71 ns) | 2,408.0 MB/s (106.32 ns) | 2,428.5 MB/s (105.53 ns) | 5,221.2 MB/s (49.06 ns) | 5,586.2 MB/s (45.83 ns) | 100.3× | 0.64 c/B |
| **`Vistrutah-512-512x4 (12r)`** | 82.5 MB/s (3,105.41 ns) | 3,957.2 MB/s (64.71 ns) | 4,206.2 MB/s (60.88 ns) | 7,395.3 MB/s (34.64 ns) | 9,037.5 MB/s (28.34 ns) | 109.5× | 0.40 c/B |
| **`Vistrutah-512-512x4 (18r)`** | 54.5 MB/s (4,737.90 ns) | 2,344.8 MB/s (109.18 ns) | 2,432.3 MB/s (105.27 ns) | 5,110.8 MB/s (50.24 ns) | 5,891.4 MB/s (43.48 ns) | 108.1× | 0.61 c/B |

All operations: 0 B/op, 0 allocs/op.

### 2. AWS Graviton 4 (`c8g.4xlarge`, Neoverse-V2, 16 vCPUs, ARM64)

3-run averaged throughput measured on AWS Graviton 4 (`purec` bitsliced fallback vs `arm64` ARMv8 Cryptographic Extension; reference cycles per byte `c = f · t / B` at `f = 2.80 GHz` reach `0.50 c/B` on `areion_permute512x4` / `areion_permute512_p2x4`, `0.57 c/B` on `areion_inverse_permute256x4` / `areion_inverse_permute256_p2x4`, `0.90` / `1.04 c/B` on `areion_soem256x4` / `areion_soem512x4`, and `0.57 c/B` on `areion_em_encrypt512x4`):

#### Core Permutations, Davies-Meyer, SoEM22 & AES-128 Primitives

| Operation | `purec` (Bitsliced) | `arm64` (128-bit NEON) | Speedup vs `purec` | Cycles/Byte (`arm64`) |
| :--- | :---: | :---: | :---: | :---: |
| **`areion_permute256`** | 30.1 MB/s (1,064.12 ns) | 1,031.0 MB/s (31.04 ns) | 34.3× | 2.72 c/B |
| **`areion_permute512`** | 41.8 MB/s (1,531.90 ns) | 1,852.1 MB/s (34.56 ns) | 44.3× | 1.51 c/B |
| **`areion_inverse_permute256`** | 31.7 MB/s (1,008.97 ns) | 1,342.5 MB/s (23.84 ns) | 42.4× | 2.09 c/B |
| **`areion_inverse_permute512`** | 33.1 MB/s (1,931.69 ns) | 1,590.4 MB/s (40.24 ns) | 48.0× | 1.76 c/B |
| **`areion_permute256_p2`** | 30.1 MB/s (1,061.40 ns) | 1,031.0 MB/s (31.04 ns) | 34.3× | 2.72 c/B |
| **`areion_permute512_p2`** | 41.8 MB/s (1,531.18 ns) | 1,852.4 MB/s (34.55 ns) | 44.3× | 1.51 c/B |
| **`areion_inverse_permute256_p2`** | 31.7 MB/s (1,009.38 ns) | 1,341.6 MB/s (23.85 ns) | 42.3× | 2.09 c/B |
| **`areion_inverse_permute512_p2`** | 33.2 MB/s (1,930.67 ns) | 1,590.2 MB/s (40.25 ns) | 47.9× | 1.76 c/B |
| **`areion_dm256`** | 30.2 MB/s (1,059.85 ns) | 2,442.2 MB/s (13.10 ns) | 80.9× | 1.15 c/B |
| **`areion_dm512`** | 40.5 MB/s (1,583.42 ns) | 2,351.8 MB/s (27.22 ns) | 58.1× | 1.19 c/B |
| **`areion_soem256`** | 29.2 MB/s (1,094.47 ns) | 1,167.0 MB/s (27.42 ns) | 40.0× | 2.40 c/B |
| **`areion_soem512`** | 40.2 MB/s (1,591.39 ns) | 1,628.2 MB/s (39.31 ns) | 40.5× | 1.72 c/B |
| **`areion_permute256x4`** | 115.0 MB/s (1,113.65 ns) | 4,060.1 MB/s (31.53 ns) | 35.3× | 0.69 c/B |
| **`areion_permute512x4`** | 131.5 MB/s (1,947.34 ns) | 5,550.7 MB/s (46.13 ns) | 42.2× | 0.50 c/B |
| **`areion_inverse_permute256x4`** | 120.3 MB/s (1,064.10 ns) | 4,898.3 MB/s (26.13 ns) | 40.7× | 0.57 c/B |
| **`areion_inverse_permute512x4`** | 109.4 MB/s (2,339.22 ns) | 3,971.9 MB/s (64.46 ns) | 36.3× | 0.71 c/B |
| **`areion_permute256_p2x4`** | 114.9 MB/s (1,113.63 ns) | 4,058.9 MB/s (31.54 ns) | 35.3× | 0.69 c/B |
| **`areion_permute512_p2x4`** | 131.5 MB/s (1,947.36 ns) | 5,552.4 MB/s (46.11 ns) | 42.2× | 0.50 c/B |
| **`areion_inverse_permute256_p2x4`** | 120.4 MB/s (1,062.97 ns) | 4,901.0 MB/s (26.12 ns) | 40.7× | 0.57 c/B |
| **`areion_inverse_permute512_p2x4`** | 109.4 MB/s (2,339.99 ns) | 3,968.0 MB/s (64.52 ns) | 36.3× | 0.71 c/B |
| **`areion_soem256x4`** | 62.6 MB/s (2,044.60 ns) | 3,104.2 MB/s (41.24 ns) | 49.6× | 0.90 c/B |
| **`areion_soem512x4`** | 69.4 MB/s (3,688.64 ns) | 2,680.6 MB/s (95.50 ns) | 38.6× | 1.04 c/B |
| **`areion_aes128_round`** | 63.5 MB/s (251.87 ns) | 4,278.3 MB/s (3.75 ns) | 67.4× | 0.66 c/B |
| **`areion_aes128_round4`** | 203.9 MB/s (313.91 ns) | 9,160.7 MB/s (6.99 ns) | 44.9× | 0.31 c/B |
| **`areion_expand_key128`** | 356.5 MB/s (493.68 ns) | 6,510.1 MB/s (27.03 ns) | 18.3× | 0.43 c/B |
| **`areion_aes128_encrypt_block`** | 24.5 MB/s (654.34 ns) | 1,576.3 MB/s (10.15 ns) | 64.3× | 1.78 c/B |
| **`areion_aes128_encrypt4_blocks`** | 94.0 MB/s (680.94 ns) | 5,981.0 MB/s (10.70 ns) | 63.6× | 0.47 c/B |

#### Wide-Block Ciphers (`EM`, `EM2`, `TEM`, `TEM2`) vs. `Rijndael-256` & `Vistrutah-256/512`

| Operation | `purec` (Bitsliced) | `arm64` (128-bit NEON) | Speedup vs `purec` | Cycles/Byte (`arm64`) |
| :--- | :---: | :---: | :---: | :---: |
| **`areion_em_encrypt256`** | 30.2 MB/s (1,060.84 ns) | 2,352.7 MB/s (13.60 ns) | 77.9× | 1.19 c/B |
| **`areion_em_decrypt256`** | 31.6 MB/s (1,011.90 ns) | 2,411.5 MB/s (13.27 ns) | 76.3× | 1.16 c/B |
| **`areion_em_encrypt512`** | 40.5 MB/s (1,583.35 ns) | 2,290.8 MB/s (27.94 ns) | 56.6× | 1.22 c/B |
| **`areion_em_decrypt512`** | 32.1 MB/s (1,995.42 ns) | 1,867.9 MB/s (34.26 ns) | 58.2× | 1.50 c/B |
| **`areion_em2_encrypt256`** | 16.6 MB/s (1,932.00 ns) | 993.5 MB/s (32.21 ns) | 59.8× | 2.82 c/B |
| **`areion_em2_decrypt256`** | 17.5 MB/s (1,830.81 ns) | 1,133.6 MB/s (28.23 ns) | 64.8× | 2.47 c/B |
| **`areion_em2_encrypt512`** | 22.3 MB/s (2,864.45 ns) | 1,048.4 MB/s (61.05 ns) | 47.0× | 2.67 c/B |
| **`areion_em2_decrypt512`** | 17.4 MB/s (3,664.38 ns) | 871.7 MB/s (73.43 ns) | 50.1× | 3.21 c/B |
| **`areion_tem_encrypt256`** | 16.6 MB/s (1,928.98 ns) | 970.2 MB/s (32.98 ns) | 58.4× | 2.89 c/B |
| **`areion_tem_decrypt256`** | 17.0 MB/s (1,879.59 ns) | 935.6 MB/s (34.20 ns) | 55.0× | 2.99 c/B |
| **`areion_tem_encrypt512`** | 22.3 MB/s (2,869.21 ns) | 1,036.7 MB/s (61.73 ns) | 46.5× | 2.70 c/B |
| **`areion_tem_decrypt512`** | 19.6 MB/s (3,267.97 ns) | 941.4 MB/s (67.99 ns) | 48.0× | 2.97 c/B |
| **`areion_tem2_encrypt256`** | 11.4 MB/s (2,808.15 ns) | 451.9 MB/s (70.82 ns) | 39.6× | 6.20 c/B |
| **`areion_tem2_decrypt256`** | 11.8 MB/s (2,720.42 ns) | 494.6 MB/s (64.70 ns) | 41.9× | 5.66 c/B |
| **`areion_tem2_encrypt512`** | 15.1 MB/s (4,240.72 ns) | 641.6 MB/s (99.75 ns) | 42.5× | 4.36 c/B |
| **`areion_tem2_decrypt512`** | 12.7 MB/s (5,023.74 ns) | 571.7 MB/s (111.95 ns) | 45.0× | 4.90 c/B |
| **`areion_em_encrypt256x4`** | 114.1 MB/s (1,121.75 ns) | 3,890.1 MB/s (32.91 ns) | 34.1× | 0.72 c/B |
| **`areion_em_decrypt256x4`** | 119.5 MB/s (1,070.85 ns) | 4,383.9 MB/s (29.20 ns) | 36.7× | 0.64 c/B |
| **`areion_em_encrypt512x4`** | 132.0 MB/s (1,938.95 ns) | 4,882.2 MB/s (52.44 ns) | 37.0× | 0.57 c/B |
| **`areion_em_decrypt512x4`** | 108.4 MB/s (2,361.57 ns) | 3,762.5 MB/s (68.04 ns) | 34.7× | 0.74 c/B |
| **`areion_em2_encrypt256x4`** | 62.7 MB/s (2,040.92 ns) | 2,038.8 MB/s (62.78 ns) | 32.5× | 1.37 c/B |
| **`areion_em2_decrypt256x4`** | 65.7 MB/s (1,947.62 ns) | 2,374.2 MB/s (53.92 ns) | 36.1× | 1.18 c/B |
| **`areion_em2_encrypt512x4`** | 69.6 MB/s (3,675.52 ns) | 2,677.0 MB/s (95.63 ns) | 38.5× | 1.05 c/B |
| **`areion_em2_decrypt512x4`** | 56.7 MB/s (4,513.54 ns) | 1,867.9 MB/s (137.05 ns) | 32.9× | 1.50 c/B |
| **`areion_tem_encrypt256x4`** | 62.7 MB/s (2,040.69 ns) | 2,012.7 MB/s (63.60 ns) | 32.1× | 1.39 c/B |
| **`areion_tem_decrypt256x4`** | 64.1 MB/s (1,996.94 ns) | 2,174.8 MB/s (58.86 ns) | 33.9× | 1.29 c/B |
| **`areion_tem_encrypt512x4`** | 69.4 MB/s (3,685.99 ns) | 1,819.5 MB/s (140.71 ns) | 26.2× | 1.54 c/B |
| **`areion_tem_decrypt512x4`** | 62.4 MB/s (4,104.38 ns) | 1,639.1 MB/s (156.18 ns) | 26.3× | 1.71 c/B |
| **`areion_tem2_encrypt256x4`** | 32.3 MB/s (3,968.45 ns) | 1,034.6 MB/s (123.71 ns) | 32.0× | 2.71 c/B |
| **`areion_tem2_decrypt256x4`** | 33.2 MB/s (3,856.62 ns) | 1,108.3 MB/s (115.50 ns) | 33.4× | 2.53 c/B |
| **`areion_tem2_encrypt512x4`** | 35.7 MB/s (7,173.24 ns) | 916.9 MB/s (279.20 ns) | 25.7× | 3.05 c/B |
| **`areion_tem2_decrypt512x4`** | 32.0 MB/s (8,000.73 ns) | 819.9 MB/s (312.22 ns) | 25.6× | 3.41 c/B |
| **`Rijndael-256`** | 36.9 MB/s (866.17 ns) | 1,363.1 MB/s (23.48 ns) | 36.9× | 2.05 c/B |
| **`Rijndael-256x4`** | 106.0 MB/s (1,207.75 ns) | 2,656.9 MB/s (48.18 ns) | 25.1× | 1.05 c/B |
| **`Vistrutah-256 (10r)`** | 37.0 MB/s (865.81 ns) | 3,469.4 MB/s (9.22 ns) | 93.8× | 0.81 c/B |
| **`Vistrutah-256 (14r)`** | 28.2 MB/s (1,134.46 ns) | 2,308.6 MB/s (13.86 ns) | 81.9× | 1.21 c/B |
| **`Vistrutah-256x4 (10r)`** | 93.7 MB/s (1,365.80 ns) | 5,693.0 MB/s (22.51 ns) | 60.8× | 0.49 c/B |
| **`Vistrutah-256x4 (14r)`** | 69.5 MB/s (1,842.65 ns) | 4,334.2 MB/s (29.53 ns) | 62.4× | 0.65 c/B |
| **`Vistrutah-512-256 (10r)`** | 62.9 MB/s (1,017.44 ns) | 3,555.9 MB/s (18.00 ns) | 56.5× | 0.79 c/B |
| **`Vistrutah-512-256 (14r)`** | 47.6 MB/s (1,344.20 ns) | 2,497.6 MB/s (25.63 ns) | 52.5× | 1.12 c/B |
| **`Vistrutah-512-256 (18r)`** | 38.1 MB/s (1,678.15 ns) | 1,911.2 MB/s (33.49 ns) | 50.2× | 1.47 c/B |
| **`Vistrutah-512-512 (12r)`** | 54.5 MB/s (1,174.67 ns) | 3,023.4 MB/s (21.17 ns) | 55.5× | 0.93 c/B |
| **`Vistrutah-512-512 (18r)`** | 38.5 MB/s (1,661.90 ns) | 1,941.3 MB/s (32.97 ns) | 50.4× | 1.44 c/B |
| **`Vistrutah-512-256x4 (10r)`** | 74.3 MB/s (3,443.45 ns) | 5,444.4 MB/s (47.02 ns) | 73.3× | 0.51 c/B |
| **`Vistrutah-512-256x4 (14r)`** | 53.8 MB/s (4,759.57 ns) | 4,067.0 MB/s (62.95 ns) | 75.6× | 0.69 c/B |
| **`Vistrutah-512-256x4 (18r)`** | 42.2 MB/s (6,067.12 ns) | 3,202.7 MB/s (79.93 ns) | 75.9× | 0.87 c/B |
| **`Vistrutah-512-512x4 (12r)`** | 62.4 MB/s (4,099.41 ns) | 4,773.7 MB/s (53.63 ns) | 76.5× | 0.59 c/B |
| **`Vistrutah-512-512x4 (18r)`** | 42.2 MB/s (6,060.61 ns) | 3,215.7 MB/s (79.61 ns) | 76.2× | 0.87 c/B |

All operations: 0 B/op, 0 allocs/op.

### 3. Comparison with `Rijndael-256` (`NIST SP 800-197`) and `Vistrutah-256/512` ([ePrint 2025/976](https://eprint.iacr.org/2025/976))

- **`Rijndael-256`** (14 rounds, 256-bit block, 256-bit key, `ShiftRows` offsets `(0, 1, 3, 4)` across an `8 × 4` byte matrix) requires a cross-128-bit-half byte permutation `InvShiftRows_AES128` ∘ `ShiftRows_R256(0,1,3,4)` (`PSHUFB`/`VPSHUFB` + `PBLENDVB`/`VPBLENDVB` on x86-64, `VTBL2` on ARM64) before every round and 480 bytes (`15 × 32 B`) of pre-expanded round keys in RAM.
- **`Vistrutah-256`** (`10` or `14` rounds, 256-bit block, 256-bit key) and **`Vistrutah-512`** (`10`, `14`, or `18` rounds with 256-bit key; `12` or `18` rounds with 512-bit key) alternate pairs of parallel 128-bit AES rounds with a cross-slice `mixSlice` byte shuffle (`PUNPCK*` + `PALIGNR`/`PSHUFB` on x86-64, `VZIP1`/`VZIP2` + `VTBL` on ARM64) every two rounds and an on-the-fly key permutation `ρ`.
- **`Areion-256` / `Areion-512`** use a 2-branch / 4-branch Feistel/SPN structure built natively from 128-bit AES rounds with **zero byte shuffles (`PSHUFB`/`VTBL`)** on the data path and **zero persistent round-key state in RAM** (`EM`, `EM2`, `TEM`, `TEM2` hold keys strictly in volatile registers and wipe them before returning):

| Wide-Block Cipher Primitive | Intel Core i7-11700K (Best HW Tier) | AWS Graviton 4 (`arm64`) | Block / Key / RAM Key State & Security |
| :--- | :---: | :---: | :--- |
| **`areion_em_encrypt256`** | **5,744.7 MB/s** (`5.58 ns/op`) | **2,352.7 MB/s** (`13.60 ns/op`) | 256b / 512b key, `0 B` RAM RK (`2^128` PRP) |
| **`areion_em2_encrypt256`** | **2,265.7 MB/s** (`14.13 ns/op`) | **993.5 MB/s** (`32.21 ns/op`) | 256b / 512b key, `0 B` RAM RK (`2^170.7` BBB PRP) |
| **`areion_tem_encrypt256`** | **2,318.2 MB/s** (`13.81 ns/op`) | **970.2 MB/s** (`32.98 ns/op`) | 256b / 512b + 256b tweak, `0 B` RAM RK (`2^128` TPRP) |
| **`areion_tem2_encrypt256`** | **1,153.0 MB/s** (`27.76 ns/op`) | **451.9 MB/s** (`70.82 ns/op`) | 256b / 512b + 256b tweak, `0 B` RAM RK (`2^170.7` BBB TPRP) |
| **`areion_em_encrypt256x4`** | **13,961.2 MB/s** (`2.32 ns/block`) | **3,890.1 MB/s** (`8.23 ns/block`) | 4×256b, `0 B` RAM RK (`2^128` PRP) |
| **`areion_em2_encrypt256x4`** | **6,354.7 MB/s** (`5.04 ns/block`) | **2,038.8 MB/s** (`15.70 ns/block`) | 4×256b, `0 B` RAM RK (`2^170.7` BBB PRP) |
| **`areion_tem_encrypt256x4`** | **6,322.2 MB/s** (`5.08 ns/block`) | **2,012.7 MB/s** (`15.90 ns/block`) | 4×256b + tweaks, `0 B` RAM RK (`2^128` TPRP) |
| **`areion_tem2_encrypt256x4`** | **3,442.5 MB/s** (`9.30 ns/block`) | **1,034.6 MB/s** (`30.93 ns/block`) | 4×256b + tweaks, `0 B` RAM RK (`2^170.7` BBB TPRP) |
| **`Rijndael-256 (14r)`** | 2,155.0 MB/s (`14.85 ns/op`) | 1,363.1 MB/s (`23.48 ns/op`) | 256b / 256b key, **`480 B` RAM RK** (`SP 800-197`) |
| **`Rijndael-256x4 (14r)`** | 7,112.1 MB/s (`4.50 ns/block`) | 2,656.9 MB/s (`12.04 ns/block`) | 4×256b, **`480 B` RAM RK** (`SP 800-197`) |
| **`Vistrutah-256 (10r / 14r)`** | 4,811.8 / 3,284.4 MB/s (`6.69` / `9.75 ns`) | 3,469.4 / 2,308.6 MB/s (`9.22` / `13.86 ns`) | 256b / 256b key, `0 B` RAM RK (`ePrint 2025/976`) |
| **`Vistrutah-256x4 (10r / 14r)`** | 11,430.7 / 7,814.1 MB/s (`2.80` / `4.10 ns/blk`) | 5,693.0 / 4,334.2 MB/s (`5.63` / `7.38 ns/blk`) | 4×256b, `0 B` RAM RK (`ePrint 2025/976`) |
| **`areion_em_encrypt512`** | **5,588.2 MB/s** (`11.46 ns/op`) | **2,290.8 MB/s** (`27.94 ns/op`) | 512b / 1024b key, `0 B` RAM RK (`2^256` PRP) |
| **`areion_em_encrypt512x4`** | **13,952.4 MB/s** (`4.59 ns/block`) | **4,882.2 MB/s** (`13.11 ns/block`) | 4×512b, `0 B` RAM RK (`2^256` PRP) |
| **`Vistrutah-512-256 (10r / 14r / 18r)`** | 4,615.3 / 3,232.0 / 2,376.7 MB/s | 3,555.9 / 2,497.6 / 1,911.2 MB/s | 512b / 256b key, `0 B` RAM RK (`ePrint 2025/976`) |
| **`Vistrutah-512-512 (12r / 18r)`** | 3,971.4 / 2,495.6 MB/s | 3,023.4 / 1,941.3 MB/s | 512b / 512b key, `0 B` RAM RK (`ePrint 2025/976`) |
| **`Vistrutah-512-256x4 (10r / 14r / 18r)`** | 10,102.5 / 7,156.3 / 5,586.2 MB/s | 5,444.4 / 4,067.0 / 3,202.7 MB/s | 4×512b / 256b key, `0 B` RAM RK (`ePrint 2025/976`) |
| **`Vistrutah-512-512x4 (12r / 18r)`** | 9,037.5 / 5,891.4 MB/s | 4,773.7 / 3,215.7 MB/s | 4×512b / 512b key, `0 B` RAM RK (`ePrint 2025/976`) |

On Intel Core i7-11700K, `areion_em_encrypt256` (`5,744.7 MB/s`, `5.58 ns/op`, `0.63 c/B`) and `areion_em_encrypt256x4` (`13,961.2 MB/s`, `9.29 ns/op`, `0.26 c/B`) outperform both 14-round `Rijndael-256` (`2,155.0 MB/s` single-block, `7,112.1 MB/s` 4-block — `2.7×` and `2.0×` faster) and 10r/14r `Vistrutah-256` (`4,811.8` / `3,284.4 MB/s` single-block, `11,430.7` / `7,814.1 MB/s` 4-block — `1.2×`/`1.7×` and `1.2×`/`1.8×` faster), while `areion_em_encrypt512` (`5,588.2 MB/s`, `11.46 ns/op`, `0.64 c/B`) and `areion_em_encrypt512x4` (`13,952.4 MB/s`, `18.37 ns/op`, `0.26 c/B`) outperform all `Vistrutah-512` variants (`10r`, `12r`, `14r`, `18r` — `1.2×` to `2.5×` faster). On AWS Graviton 4 (`arm64`), `areion_em_encrypt256` (`2,352.7 MB/s`, `13.60 ns/op`, `1.19 c/B`) and `areion_em_encrypt256x4` (`3,890.1 MB/s`, `32.91 ns/op`, `0.72 c/B`) outperform 14-round `Rijndael-256` (`1,363.1 MB/s` single-block, `2,656.9 MB/s` 4-block — `1.7×` and `1.5×` faster) and 14-round `Vistrutah-256` single-block (`2,308.6 MB/s`), while `areion_em_encrypt512x4` (`4,882.2 MB/s`, `52.44 ns/op`, `0.57 c/B`) outperforms 14r/18r `Vistrutah-512-256x4` (`4,067.0` / `3,202.7 MB/s`) and 12r/18r `Vistrutah-512-512x4` (`4,773.7` / `3,215.7 MB/s`).

> **Benchmark methodology note:** `areion_permute*`, `areion_inverse_permute*`, `areion_aes128_round*`, and `areion_aes128_encrypt*` overwrite their state buffer in-place (`dst == src`), measuring serial dependency-chain latency across iterations (`areion_aes128_encrypt*` and `Rijndael256Encrypt*` time the encryption core with pre-expanded round keys in RAM, whereas `areion_{em,em2,tem,tem2}_*` and `Vistrutah*` take raw keys and expand/apply round keys on-the-fly in registers). `areion_soem*`, `areion_dm*`, `areion_{em,em2,tem,tem2}_*`, `Rijndael256Encrypt*`, and `Vistrutah*` evaluate fixed input, tweak, and key buffers across iterations, allowing out-of-order execution to overlap independent calls. See [`everanium/areion/analysis/README.md` (Section L)](https://github.com/everanium/areion/blob/main/analysis/README.md#l-register-and-stack-clearing-cost) for interleaved single-core cycle-per-byte measurements including epilogue register and stack clearing.

---

## SUPERCOP (`eBACS`) C99 Wrappers (`supercop/`)

Standard SUPERCOP (`eBACS`) C99 `ref` wrappers (`api.h` + implementation `.c`) are provided in [`supercop/`](supercop/) and tested automatically during `make test` (`make test-supercop` and `test_supercop_wrappers()` in `areion_test.c`):

- `supercop/crypto_core/areion256/ref/` (`crypto_core` → `areion_permute256`)
- `supercop/crypto_core/areion512/ref/` (`crypto_core` → `areion_permute512`)
- `supercop/crypto_prf/soem256/ref/` (`crypto_prf` → `areion_soem256`)
- `supercop/crypto_prf/soem512/ref/` (`crypto_prf` → `areion_soem512`)
- `supercop/crypto_tbc/em256/ref/` (`crypto_tbc_encrypt` / `crypto_tbc_decrypt` → `areion_em_encrypt256` / `areion_em_decrypt256`, `CRYPTO_TWEAKBYTES 0`)
- `supercop/crypto_tbc/em512/ref/` (`crypto_tbc_encrypt` / `crypto_tbc_decrypt` → `areion_em_encrypt512` / `areion_em_decrypt512`, `CRYPTO_TWEAKBYTES 0`)
- `supercop/crypto_tbc/em2256/ref/` (`crypto_tbc_encrypt` / `crypto_tbc_decrypt` → `areion_em2_encrypt256` / `areion_em2_decrypt256`, `CRYPTO_TWEAKBYTES 0`)
- `supercop/crypto_tbc/em2512/ref/` (`crypto_tbc_encrypt` / `crypto_tbc_decrypt` → `areion_em2_encrypt512` / `areion_em2_decrypt512`, `CRYPTO_TWEAKBYTES 0`)
- `supercop/crypto_tbc/tem256/ref/` (`crypto_tbc_encrypt` / `crypto_tbc_decrypt` → `areion_tem_encrypt256` / `areion_tem_decrypt256`)
- `supercop/crypto_tbc/tem512/ref/` (`crypto_tbc_encrypt` / `crypto_tbc_decrypt` → `areion_tem_encrypt512` / `areion_tem_decrypt512`)
- `supercop/crypto_tbc/tem2256/ref/` (`crypto_tbc_encrypt` / `crypto_tbc_decrypt` → `areion_tem2_encrypt256` / `areion_tem2_decrypt256`)
- `supercop/crypto_tbc/tem2512/ref/` (`crypto_tbc_encrypt` / `crypto_tbc_decrypt` → `areion_tem2_encrypt512` / `areion_tem2_decrypt512`)

---

## Reproduce

### 1. Build & Run Complete Test Suite (`make`)
```bash
# Build static/shared libraries and run unit + SUPERCOP + pairwise tier matrix + zeroization + constant-derivation + ELF security (GNU_STACK, CET/BTI, nm -D) tests:
make test

# Run extended dudect Welch's t-test constant-time timing verification:
./areion_test --dudect

# Run active tier benchmark or multi-tier Markdown summary table:
make bench
python3 scripts/run_bench.py

# Run live Go <-> C tier-by-tier and full Cartesian product (Go[tier_A] x C[tier_B]) KAT cross-verification:
make cross-kat

# Run static analysis suite (gcc -fanalyzer, clang-tidy, cppcheck, flawfinder, scan-build):
make lint

# Run dynamic sanitizers (ASan, UBSan, MSan, TSan with -fno-sanitize-recover=all) and Valgrind (memcheck/TIMECOP, helgrind, drd):
make test-sanitizers

# Run cross-architecture verification across 9 qemu-*-static targets:
make test-qemu
```

### 2. Test & Benchmark Specific Execution Tiers
The environment variable `AREION_FORCE_TIER` (or `areion_set_tier()`) forces the execution tier:
```bash
# Test individual tiers:
AREION_FORCE_TIER=purec    ./areion_test && AREION_FORCE_TIER=purec    ./areion_zeroize_test
AREION_FORCE_TIER=aesni    ./areion_test && AREION_FORCE_TIER=aesni    ./areion_zeroize_test
AREION_FORCE_TIER=vex      ./areion_test && AREION_FORCE_TIER=vex      ./areion_zeroize_test
AREION_FORCE_TIER=vaesavx2 ./areion_test && AREION_FORCE_TIER=vaesavx2 ./areion_zeroize_test
AREION_FORCE_TIER=avx512   ./areion_test && AREION_FORCE_TIER=avx512   ./areion_zeroize_test
AREION_FORCE_TIER=arm64    ./areion_test && AREION_FORCE_TIER=arm64    ./areion_zeroize_test

# Benchmark individual tiers (via positional argument or AREION_FORCE_TIER):
./areion_test --bench purec
./areion_test --bench aesni
./areion_test --bench vex
./areion_test --bench vaesavx2
./areion_test --bench avx512
./areion_test --bench arm64
```

### 3. Build & Test with CMake
```bash
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build
ctest --test-dir build --output-on-failure
```

---

## Usage Example

```c
#include "areion.h"
#include <stdio.h>

int main(void) {
    uint8_t state[AREION_256_SIZE] = {0};
    uint8_t msg[AREION_DM256_INPUT_SIZE] = {0};
    uint8_t tweak[AREION_256_SIZE] = {0};
    uint8_t digest[AREION_DM256_SIZE];
    uint8_t key[AREION_SOEM256_KEY_SIZE] = {0};
    uint8_t prf[AREION_SOEM256_SIZE];
    uint8_t ct[AREION_256_SIZE], pt[AREION_256_SIZE];
    size_t i;

    /* 0. Optional FIPS 140-3 Cryptographic Algorithm Self-Test (CAST) */
    if (areion_selftest() != 0) {
        return 1;
    }

    /* 1. Single-block permutation P1 */
    areion_permute256(state);

    /* 2. Davies-Meyer short-input hash */
    areion_dm256(digest, msg);

    /* 3. SoEM22 beyond-birthday-bound PRF */
    areion_soem256(prf, key, msg);

    /* 4. TEM2-256 beyond-birthday-bound tweakable wide-block cipher */
    areion_tem2_encrypt256(ct, key, tweak, msg);
    areion_tem2_decrypt256(pt, key, tweak, ct);

    /* 5. Scrub sensitive key and plaintext buffers before returning */
    areion_zeroize(key, sizeof(key));
    areion_zeroize(pt, sizeof(pt));

    printf("Active tier: %s\nSoEM256 PRF: ", areion_tier());
    for (i = 0; i < AREION_SOEM256_SIZE; i++) {
        printf("%02x", prf[i]);
    }
    printf("\n");
    return 0;
}
```

---

## References

1. **Areion: Highly-Efficient Permutations and Its Applications to Hash Functions for Short Input**
   Takanori Isobe, Ryoma Ito, Fukang Liu, Kazuhiko Minematsu, Motoki Nakahashi, Kosei Sakamoto, Rentaro Shiba.
   *IACR Transactions on Cryptographic Hardware and Embedded Systems (TCHES)*, Volume 2023, Issue 2, pp. 115–154, [doi:10.46586/tches.v2023.i2.115-154](https://doi.org/10.46586/tches.v2023.i2.115-154).
   Extended version: **Areion: Highly-Efficient Permutations and Its Applications (Extended Version)**, [IACR ePrint 2023/794](https://eprint.iacr.org/2023/794). Section, table, equation, and appendix numbers in this repository refer to the extended version.

2. **How to Build Pseudorandom Functions from Public Random Permutations**
   Yu Long Chen, Eran Lambooij, Bart Mennink.
   *CRYPTO 2019*, Part I, Lecture Notes in Computer Science, vol. 11692, pp. 266–293, [doi:10.1007/978-3-030-26948-7_10](https://doi.org/10.1007/978-3-030-26948-7_10), [IACR ePrint 2019/554](https://eprint.iacr.org/2019/554).

3. **A Construction of a Cipher From a Single Pseudorandom Permutation**
   Shimon Even, Yishay Mansour.
   *ASIACRYPT 1991*, Lecture Notes in Computer Science, vol. 739, pp. 210–224; *Journal of Cryptology*, vol. 10, no. 3, pp. 151–162 (1997), [doi:10.1007/s001459900025](https://doi.org/10.1007/s001459900025).

4. **Key-Alternating Ciphers in a Provable Setting: Encryption Using a Small Number of Public Permutations**
   Andrey Bogdanov, Lars R. Knudsen, Gregor Leander, François-Xavier Standaert, John Steinberger, Elmar Tischhauser.
   *EUROCRYPT 2012*, Lecture Notes in Computer Science, vol. 7237, pp. 45–62, [doi:10.1007/978-3-642-29011-4_5](https://doi.org/10.1007/978-3-642-29011-4_5).

5. **Tight Security Bounds for Key-Alternating Ciphers**
   Shan Chen, John Steinberger.
   *EUROCRYPT 2014*, Lecture Notes in Computer Science, vol. 8441, pp. 327–350, [doi:10.1007/978-3-642-55220-5_33](https://doi.org/10.1007/978-3-642-55220-5_33).

6. **Tweakable Even-Mansour Ciphers**
   Rodolphe Lampe, Yannick Seurin.
   *FSE 2013*, Lecture Notes in Computer Science, vol. 8424, pp. 245–264, [doi:10.1007/978-3-662-43933-3_15](https://doi.org/10.1007/978-3-662-43933-3_15); and Bart Mennink, **Optimally Secure Tweakable Blockciphers**, *CRYPTO 2015*, Part I, LNCS vol. 9215, pp. 428–448, [doi:10.1007/978-3-662-47989-6_30](https://doi.org/10.1007/978-3-662-47989-6_30).

7. **Tweaking Even-Mansour Ciphers**
   Benoît Cogliati, Rodolphe Lampe, Yannick Seurin.
   *CRYPTO 2015*, Part I, Lecture Notes in Computer Science, vol. 9215, pp. 189–208, [doi:10.1007/978-3-662-47989-6_29](https://doi.org/10.1007/978-3-662-47989-6_29); and Avijit Dutta, **Minimizing the Two-Round Tweakable Even-Mansour Cipher**, *ASIACRYPT 2020*, Part I, LNCS vol. 12491, pp. 601–629, [doi:10.1007/978-3-030-64837-4_19](https://doi.org/10.1007/978-3-030-64837-4_19).

8. **Recommendation for Existing Application-Specific Key Derivation Functions / Wide-Block Rijndael-256**
   Joan Daemen, Vincent Rijmen, *The Design of Rijndael: AES — The Advanced Encryption Standard*, Springer (2002); NIST Special Publication 800-197 (Draft / Reference specification for 256-bit block Rijndael with ShiftRows offsets `(0, 1, 3, 4)`).

---

## License

Dual-licensed under either:
- [Apache License, Version 2.0](LICENSE-APACHE)
- [MIT License](LICENSE-MIT)

Copyright (c) 2026 Andrey Kuvshinov.
