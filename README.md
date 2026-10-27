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
| **`avx512`** | Intel Ice Lake, Tiger Lake, Rocket Lake, Xeon Ice Lake-SP+; AMD Zen 4+ (`AVX-512F + AVX-512VL + VAES`) | `VAESENC`, `VAESENCLAST`, `VAESDECLAST`, `VPXORD`, `VPXORQ`, `VBROADCASTI32X4`, plus `VEXTRACTI32X4` / 128-bit `VAESIMC` / `VINSERTI32X4` | 512-bit ZMM (4 AES blocks) |
| **`vaesavx2`** | Intel Alder Lake+ (no AVX-512); AMD Zen 3 (`AVX2 + VAES`) | `VAESENC`, `VAESENCLAST`, `VAESDECLAST`, `VPXOR`, `VBROADCASTI128`, plus `VEXTRACTI128` / 128-bit `VAESIMC` / `VINSERTI128` | 256-bit YMM (2 AES blocks) |
| **`vex`** | Intel Sandy Bridge+, AMD Bulldozer+ (`AVX + AES-NI`) | 3-operand VEX XMM `VAESENC`, `VAESENCLAST`, `VAESDECLAST`, `VAESIMC`, `VPXOR` | 128-bit XMM (3-operand VEX) |
| **`aesni`** | Intel Westmere+ (`AES-NI` without `AVX`) | Legacy SSE `AESENC`, `AESENCLAST`, `AESDECLAST`, `AESIMC`, `PXOR` | 128-bit XMM (2-operand SSE) |
| **`arm64`** | ARMv8 with Cryptographic Extension, Apple Silicon, Graviton (`NEON + AES`) | `AESE`, `AESMC`, `AESD`, `AESIMC`, `VEOR` | 128-bit NEON |
| **`purec`** | All architectures — verified across 9 `qemu-*-static` targets (`aarch64`, `riscv64`, `s390x` 64-bit BE, `ppc64le`, `arm` 32-bit, `i386` 32-bit, `mips64` 64-bit BE, `mips` 32-bit BE, `loongarch64`) plus native `x86-64` | Constant-time 64-bit bitsliced Boyar–Peralta forward/inverse S-boxes & maskless linear layer | 64-bit bitsliced software (up to 4 blocks/word) |

> **Note on single-block and 4-way fused execution:** Single-block primitives (`areion_permute*`, `areion_dm*`, `areion_soem*`, `areion_em_*`, `areion_em2_*`, `areion_tem_*`, `areion_tem2_*`) operate on 128-bit XMM registers (`x86-64`) or 128-bit NEON registers (`arm64`); on `x86-64` systems with AVX (`vex`, `vaesavx2`, `avx512`), they use 3-operand VEX instructions (`VAESENC`) to eliminate `MOVAPS` register-copy overhead, falling back to 2-operand `AESENC` only on Westmere (`aesni`). Both single-block and 4-way batched (`×4`) primitives (`SoEM22`, `EM`, `EM2`, `TEM`, `TEM2`) execute inside dedicated fused assembly kernels (`areion_amd64.S`, `areion_soem256_amd64.S`, `areion_soem512_amd64.S`, `areion_soem_aesni_amd64.S`, `areion_arm64.S`, `msvc/*.asm`) without intermediate stack round-trips or redundant Structure-of-Arrays (SoA) transpositions.

> **Cross-OS & Cross-Assembler Support:**
> - **GNU GAS / Clang Integrated Assembler (`.S`)**: Supports Linux ELF (`x86_64`, `aarch64`), macOS Mach-O (`x86_64`, `arm64`), and Windows MinGW-w64 COFF (`x86_64`) via `asm_abi.h` (including automatic Windows x64 `XMM6..XMM15` non-volatile save/restore and parameter register remapping).
> - **Microsoft Visual Studio (`msvc/*.asm`)**: Pre-generated MASM (`ml64.exe`) and ARMASM64 (`armasm64.exe`) sources selected automatically by `CMakeLists.txt` when building with MSVC.

> **Register and stack zeroization:** All hardware assembly kernels execute with zero secret stack spills and clear all touched vector registers (`PXOR` / `VPXOR` / `VPXORD` on `X0..X30` plus `VZEROUPPER` on `x86-64`; `VEOR` on `V0..V31` on `arm64`) and scratch general-purpose registers before returning. C wrappers additionally zero temporary stack staging buffers via DSE-resistant `areion_secure_wipe` (`volatile uint8_t *` + compiler barrier) and clobber volatile scratch GPRs (`areion_clobber_scratch_gprs`), while `purec` routines scrub their software stack frame (`areion_wipe_software_stack`). Verified across all tiers by `areion_zeroize_test.c` (with mandatory negative controls); see [`everanium/areion/analysis/README.md` (Section L)](https://github.com/everanium/areion/blob/main/analysis/README.md#l-register-and-stack-clearing-cost) for instruction-count and cycle-per-byte overhead measurements.

---

## Benchmarks

### 1. Intel® Core™ i7-11700K @ 3.60GHz (Rocket Lake, x86-64)

Throughput and latency comparison across all 5 execution tiers on the same physical CPU (generated via `python3 scripts/run_bench.py`):

#### Core Permutations, Davies-Meyer, SoEM22 & AES-128 Primitives

| Operation | `purec` (Bitsliced) | `aesni` (128-bit SSE) | `vex` (128-bit VEX) | `vaesavx2` (256-bit YMM) | `avx512` (512-bit ZMM) |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **`areion_permute256`** | 38.5 MB/s (831.0 ns) | 2,092.1 MB/s (15.30 ns) | 2,130.1 MB/s (15.02 ns) | 2,122.4 MB/s (15.08 ns) | 2,120.1 MB/s (15.09 ns) |
| **`areion_permute512`** | 51.9 MB/s (1,234.3 ns) | 3,969.6 MB/s (16.12 ns) | 4,017.1 MB/s (15.93 ns) | 3,942.0 MB/s (16.24 ns) | 4,037.0 MB/s (15.85 ns) |
| **`areion_inverse_permute256`** | 32.5 MB/s (983.2 ns) | 1,472.4 MB/s (21.73 ns) | 1,484.2 MB/s (21.56 ns) | 1,476.7 MB/s (21.67 ns) | 1,478.6 MB/s (21.64 ns) |
| **`areion_inverse_permute512`** | 37.6 MB/s (1,700.5 ns) | 1,739.6 MB/s (36.79 ns) | 1,738.7 MB/s (36.81 ns) | 1,733.3 MB/s (36.92 ns) | 1,742.6 MB/s (36.73 ns) |
| **`areion_dm256`** | 36.5 MB/s (877.0 ns) | 3,236.2 MB/s (9.89 ns) | 3,044.0 MB/s (10.51 ns) | 3,444.8 MB/s (9.29 ns) | 2,881.7 MB/s (11.10 ns) |
| **`areion_dm512`** | 52.6 MB/s (1,217.4 ns) | 3,753.0 MB/s (17.05 ns) | 4,260.6 MB/s (15.02 ns) | 4,493.3 MB/s (14.24 ns) | 4,191.8 MB/s (15.27 ns) |
| **`areion_soem256`** | 36.5 MB/s (877.8 ns) | 2,513.3 MB/s (12.73 ns) | 2,656.3 MB/s (12.05 ns) | 2,621.8 MB/s (12.21 ns) | 2,394.8 MB/s (13.36 ns) |
| **`areion_soem512`** | 50.1 MB/s (1,277.1 ns) | 2,704.1 MB/s (23.67 ns) | 2,562.1 MB/s (24.98 ns) | 2,739.8 MB/s (23.36 ns) | 2,542.8 MB/s (25.17 ns) |
| **`areion_permute256x4`** | 145.2 MB/s (881.6 ns) | 5,820.4 MB/s (21.99 ns) | 6,230.4 MB/s (20.54 ns) | 4,832.9 MB/s (26.48 ns) | 4,804.2 MB/s (26.64 ns) |
| **`areion_permute512x4`** | 153.5 MB/s (1,667.4 ns) | 4,891.5 MB/s (52.34 ns) | 5,901.0 MB/s (43.38 ns) | 6,976.2 MB/s (36.70 ns) | 7,637.0 MB/s (33.52 ns) |
| **`areion_inverse_permute256x4`** | 142.3 MB/s (899.3 ns) | 4,691.4 MB/s (27.28 ns) | 5,196.4 MB/s (24.63 ns) | 3,965.2 MB/s (32.28 ns) | 3,846.7 MB/s (33.28 ns) |
| **`areion_inverse_permute512x4`** | 123.7 MB/s (2,070.3 ns) | 3,099.3 MB/s (82.60 ns) | 3,333.4 MB/s (76.80 ns) | 3,469.3 MB/s (73.79 ns) | 2,721.4 MB/s (94.07 ns) |
| **`areion_soem256x4`** | 72.5 MB/s (1,765.5 ns) | 3,188.9 MB/s (40.14 ns) | 3,058.4 MB/s (41.85 ns) | 4,033.3 MB/s (31.74 ns) | 3,770.3 MB/s (33.95 ns) |
| **`areion_soem512x4`** | 79.8 MB/s (3,209.0 ns) | 1,967.6 MB/s (130.11 ns) | 2,648.8 MB/s (96.65 ns) | 4,395.3 MB/s (58.24 ns) | 4,020.3 MB/s (63.68 ns) |
| **`areion_aes128_round`** | 129.0 MB/s (123.99 ns) | 6,407.7 MB/s (2.50 ns) | 6,512.0 MB/s (2.46 ns) | 6,133.0 MB/s (2.61 ns) | 6,273.6 MB/s (2.55 ns) |
| **`areion_aes128_round4`** | 406.7 MB/s (157.37 ns) | 5,058.9 MB/s (12.65 ns) | 4,955.7 MB/s (12.91 ns) | 4,424.0 MB/s (14.47 ns) | 4,136.6 MB/s (15.47 ns) |
| **`areion_expand_key128`** | 641.2 MB/s (274.48 ns) | 1,684.9 MB/s (104.46 ns) | 1,774.7 MB/s (99.17 ns) | 1,753.8 MB/s (100.36 ns) | 1,756.0 MB/s (100.23 ns) |
| **`areion_aes128_encrypt_block`** | 33.0 MB/s (484.78 ns) | 1,919.8 MB/s (8.33 ns) | 1,900.0 MB/s (8.42 ns) | 1,910.7 MB/s (8.37 ns) | 1,892.9 MB/s (8.45 ns) |
| **`areion_aes128_encrypt4_blocks`** | 134.0 MB/s (477.51 ns) | 7,362.9 MB/s (8.69 ns) | 7,187.3 MB/s (8.90 ns) | 7,472.6 MB/s (8.56 ns) | 7,423.2 MB/s (8.62 ns) |

#### Wide-Block Ciphers (`EM`, `EM2`, `TEM`, `TEM2`) vs. `Rijndael-256` (NIST SP 800-197)

| Operation | `purec` (Bitsliced) | `aesni` (128-bit SSE) | `vex` (128-bit VEX) | `vaesavx2` (256-bit YMM) | `avx512` (512-bit ZMM) |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **`areion_em_encrypt256`** | 36.7 MB/s (872.9 ns) | 2,766.7 MB/s (11.57 ns) | 3,241.9 MB/s (9.87 ns) | 3,436.7 MB/s (9.31 ns) | 3,268.1 MB/s (9.79 ns) |
| **`areion_em_decrypt256`** | 37.6 MB/s (850.9 ns) | 2,697.7 MB/s (11.86 ns) | 2,587.7 MB/s (12.37 ns) | 2,730.0 MB/s (11.72 ns) | 2,118.1 MB/s (15.11 ns) |
| **`areion_em_encrypt512`** | 50.1 MB/s (1,278.6 ns) | 3,820.1 MB/s (16.75 ns) | 4,415.3 MB/s (14.50 ns) | 4,726.2 MB/s (13.54 ns) | 4,394.4 MB/s (14.56 ns) |
| **`areion_em_decrypt512`** | 34.7 MB/s (1,842.7 ns) | 2,422.2 MB/s (26.42 ns) | 2,525.1 MB/s (25.35 ns) | 2,522.0 MB/s (25.38 ns) | 2,426.9 MB/s (26.37 ns) |
| **`areion_em2_encrypt256`** | 20.0 MB/s (1,600.3 ns) | 1,663.6 MB/s (19.24 ns) | 1,645.4 MB/s (19.45 ns) | 1,904.8 MB/s (16.80 ns) | 1,754.1 MB/s (18.24 ns) |
| **`areion_em2_decrypt256`** | 21.2 MB/s (1,509.7 ns) | 1,172.2 MB/s (27.30 ns) | 1,165.3 MB/s (27.46 ns) | 1,229.7 MB/s (26.02 ns) | 1,275.7 MB/s (25.08 ns) |
| **`areion_em2_encrypt512`** | 27.3 MB/s (2,342.3 ns) | 2,122.1 MB/s (30.16 ns) | 2,163.8 MB/s (29.58 ns) | 2,220.4 MB/s (28.82 ns) | 2,168.8 MB/s (29.51 ns) |
| **`areion_em2_decrypt512`** | 19.3 MB/s (3,314.5 ns) | 991.6 MB/s (64.54 ns) | 989.4 MB/s (64.68 ns) | 997.0 MB/s (64.19 ns) | 993.0 MB/s (64.45 ns) |
| **`areion_tem_encrypt256`** | 20.2 MB/s (1,587.5 ns) | 1,360.5 MB/s (23.52 ns) | 1,713.6 MB/s (18.67 ns) | 1,860.8 MB/s (17.20 ns) | 1,673.9 MB/s (19.12 ns) |
| **`areion_tem_decrypt256`** | 19.9 MB/s (1,606.3 ns) | 1,476.1 MB/s (21.68 ns) | 1,590.3 MB/s (20.12 ns) | 1,565.3 MB/s (20.44 ns) | 1,444.2 MB/s (22.16 ns) |
| **`areion_tem_encrypt512`** | 28.0 MB/s (2,281.8 ns) | 1,914.8 MB/s (33.42 ns) | 2,079.0 MB/s (30.78 ns) | 2,175.6 MB/s (29.42 ns) | 2,066.9 MB/s (30.96 ns) |
| **`areion_tem_decrypt512`** | 22.2 MB/s (2,885.0 ns) | 1,497.9 MB/s (42.73 ns) | 1,485.9 MB/s (43.07 ns) | 1,481.0 MB/s (43.21 ns) | 1,453.9 MB/s (44.02 ns) |
| **`areion_tem2_encrypt256`** | 10.4 MB/s (3,073.7 ns) | 994.3 MB/s (32.18 ns) | 1,003.5 MB/s (31.89 ns) | 1,079.9 MB/s (29.63 ns) | 998.8 MB/s (32.04 ns) |
| **`areion_tem2_decrypt256`** | 10.3 MB/s (3,118.7 ns) | 741.0 MB/s (43.18 ns) | 774.9 MB/s (41.30 ns) | 837.5 MB/s (38.21 ns) | 882.3 MB/s (36.27 ns) |
| **`areion_tem2_encrypt512`** | 12.6 MB/s (5,094.6 ns) | 1,222.0 MB/s (52.37 ns) | 1,274.7 MB/s (50.21 ns) | 1,293.1 MB/s (49.49 ns) | 1,233.9 MB/s (51.87 ns) |
| **`areion_tem2_decrypt512`** | 11.3 MB/s (5,686.7 ns) | 717.6 MB/s (89.18 ns) | 744.2 MB/s (86.00 ns) | 745.0 MB/s (85.91 ns) | 733.6 MB/s (87.24 ns) |
| **`areion_em_encrypt256x4`** | 145.4 MB/s (880.1 ns) | 5,354.4 MB/s (23.91 ns) | 5,398.2 MB/s (23.71 ns) | 4,648.9 MB/s (27.53 ns) | 4,125.3 MB/s (31.03 ns) |
| **`areion_em_decrypt256x4`** | 156.9 MB/s (815.6 ns) | 4,603.6 MB/s (27.80 ns) | 4,880.8 MB/s (26.23 ns) | 3,662.7 MB/s (34.95 ns) | 3,684.4 MB/s (34.74 ns) |
| **`areion_em_encrypt512x4`** | 138.1 MB/s (1,853.5 ns) | 4,310.9 MB/s (59.38 ns) | 5,288.1 MB/s (48.41 ns) | 6,548.7 MB/s (39.09 ns) | 5,600.8 MB/s (45.71 ns) |
| **`areion_em_decrypt512x4`** | 128.4 MB/s (1,993.1 ns) | 3,116.8 MB/s (82.14 ns) | 3,047.0 MB/s (84.02 ns) | 3,293.9 MB/s (77.72 ns) | 2,459.4 MB/s (104.09 ns) |
| **`areion_em2_encrypt256x4`** | 76.0 MB/s (1,684.4 ns) | 2,761.1 MB/s (46.36 ns) | 3,040.8 MB/s (42.09 ns) | 2,524.5 MB/s (50.70 ns) | 2,451.5 MB/s (52.21 ns) |
| **`areion_em2_decrypt256x4`** | 82.1 MB/s (1,559.3 ns) | 2,455.3 MB/s (52.13 ns) | 2,486.4 MB/s (51.48 ns) | 2,014.3 MB/s (63.55 ns) | 2,029.6 MB/s (63.07 ns) |
| **`areion_em2_encrypt512x4`** | 71.8 MB/s (3,566.3 ns) | 2,591.2 MB/s (98.80 ns) | 2,680.3 MB/s (95.51 ns) | 3,746.9 MB/s (68.32 ns) | 3,139.8 MB/s (81.53 ns) |
| **`areion_em2_decrypt512x4`** | 64.8 MB/s (3,952.6 ns) | 1,624.4 MB/s (157.60 ns) | 1,615.6 MB/s (158.46 ns) | 1,802.6 MB/s (142.02 ns) | 1,263.2 MB/s (202.66 ns) |
| **`areion_tem_encrypt256x4`** | 74.3 MB/s (1,723.7 ns) | 2,894.9 MB/s (44.22 ns) | 2,937.7 MB/s (43.57 ns) | 2,538.6 MB/s (50.42 ns) | 2,016.3 MB/s (63.48 ns) |
| **`areion_tem_decrypt256x4`** | 74.6 MB/s (1,716.2 ns) | 2,709.1 MB/s (47.25 ns) | 2,507.9 MB/s (51.04 ns) | 2,250.6 MB/s (56.87 ns) | 1,795.3 MB/s (71.30 ns) |
| **`areion_tem_encrypt512x4`** | 76.2 MB/s (3,361.4 ns) | 2,829.5 MB/s (90.47 ns) | 2,543.1 MB/s (100.67 ns) | 3,648.4 MB/s (70.17 ns) | 3,391.0 MB/s (75.49 ns) |
| **`areion_tem_decrypt512x4`** | 72.0 MB/s (3,554.7 ns) | 1,866.1 MB/s (137.18 ns) | 1,981.0 MB/s (129.22 ns) | 2,397.1 MB/s (106.80 ns) | 1,908.3 MB/s (134.15 ns) |
| **`areion_tem2_encrypt256x4`** | 38.7 MB/s (3,305.4 ns) | 1,668.9 MB/s (76.70 ns) | 1,609.6 MB/s (79.52 ns) | 1,533.3 MB/s (83.48 ns) | 1,505.3 MB/s (85.04 ns) |
| **`areion_tem2_decrypt256x4`** | 37.2 MB/s (3,437.0 ns) | 1,418.9 MB/s (90.21 ns) | 1,260.5 MB/s (101.55 ns) | 1,393.4 MB/s (91.86 ns) | 1,332.8 MB/s (96.04 ns) |
| **`areion_tem2_encrypt512x4`** | 41.3 MB/s (6,193.3 ns) | 1,373.9 MB/s (186.33 ns) | 1,376.8 MB/s (185.94 ns) | 2,075.5 MB/s (123.35 ns) | 1,946.5 MB/s (131.52 ns) |
| **`areion_tem2_decrypt512x4`** | 37.0 MB/s (6,921.5 ns) | 874.8 MB/s (292.65 ns) | 1,039.8 MB/s (246.20 ns) | 1,271.4 MB/s (201.35 ns) | 1,043.9 MB/s (245.23 ns) |
| **`Rijndael-256`** | 7.8 MB/s (4,128.1 ns) | 203.0 MB/s (157.65 ns) | 208.1 MB/s (153.78 ns) | 205.6 MB/s (155.63 ns) | 213.5 MB/s (149.90 ns) |
| **`Rijndael-256x4`** | 23.2 MB/s (5,507.1 ns) | 228.2 MB/s (560.81 ns) | 220.9 MB/s (579.51 ns) | 224.7 MB/s (569.71 ns) | 225.8 MB/s (566.99 ns) |

All operations: 0 B/op, 0 allocs/op.

### 2. AWS Graviton 4 (`c8g.4xlarge`, Neoverse-V2, 16 vCPUs, ARM64)

Measured on AWS Graviton 4 (`purec` bitsliced fallback vs `arm64` ARMv8 Cryptographic Extension):

#### Core Permutations, Davies-Meyer, SoEM22 & AES-128 Primitives

| Operation | `purec` (Bitsliced) | `arm64` (128-bit NEON) |
| :--- | :---: | :---: |
| **`areion_permute256`** | 30.4 MB/s (1,051.30 ns) | 920.2 MB/s (34.77 ns) |
| **`areion_permute512`** | 42.3 MB/s (1,511.57 ns) | 1,569.2 MB/s (40.79 ns) |
| **`areion_inverse_permute256`** | 32.1 MB/s (996.35 ns) | 769.0 MB/s (41.61 ns) |
| **`areion_inverse_permute512`** | 33.9 MB/s (1,888.99 ns) | 1,029.2 MB/s (62.19 ns) |
| **`areion_dm256`** | 30.4 MB/s (1,053.76 ns) | 1,237.9 MB/s (25.85 ns) |
| **`areion_dm512`** | 42.3 MB/s (1,514.21 ns) | 1,497.8 MB/s (42.73 ns) |
| **`areion_soem256`** | 29.4 MB/s (1,088.49 ns) | 680.9 MB/s (47.00 ns) |
| **`areion_soem512`** | 40.9 MB/s (1,564.70 ns) | 1,038.5 MB/s (61.63 ns) |
| **`areion_permute256x4`** | 115.6 MB/s (1,106.94 ns) | 2,967.8 MB/s (43.13 ns) |
| **`areion_permute512x4`** | 136.4 MB/s (1,876.27 ns) | 3,600.7 MB/s (71.10 ns) |
| **`areion_inverse_permute256x4`** | 122.1 MB/s (1,048.24 ns) | 2,500.6 MB/s (51.19 ns) |
| **`areion_inverse_permute512x4`** | 111.3 MB/s (2,299.22 ns) | 2,759.6 MB/s (92.77 ns) |
| **`areion_soem256x4`** | 63.0 MB/s (2,032.09 ns) | 2,035.7 MB/s (62.88 ns) |
| **`areion_soem512x4`** | 69.6 MB/s (3,677.25 ns) | 1,492.5 MB/s (171.52 ns) |
| **`areion_aes128_round`** | 64.0 MB/s (249.84 ns) | 4,454.4 MB/s (3.59 ns) |
| **`areion_aes128_round4`** | 206.5 MB/s (309.99 ns) | 2,446.5 MB/s (26.16 ns) |
| **`areion_expand_key128`** | 358.2 MB/s (491.40 ns) | 636.2 MB/s (276.63 ns) |
| **`areion_aes128_encrypt_block`** | 24.8 MB/s (645.42 ns) | 1,592.6 MB/s (10.05 ns) |
| **`areion_aes128_encrypt4_blocks`** | 94.6 MB/s (676.48 ns) | 6,032.3 MB/s (10.61 ns) |

#### Wide-Block Ciphers (`EM`, `EM2`, `TEM`, `TEM2`) vs. `Rijndael-256` (NIST SP 800-197)

| Operation | `purec` (Bitsliced) | `arm64` (128-bit NEON) |
| :--- | :---: | :---: |
| **`areion_em_encrypt256`** | 30.3 MB/s (1,056.97 ns) | 1,233.5 MB/s (25.94 ns) |
| **`areion_em_decrypt256`** | 31.9 MB/s (1,003.22 ns) | 1,060.8 MB/s (30.17 ns) |
| **`areion_em_encrypt512`** | 42.1 MB/s (1,518.52 ns) | 1,500.3 MB/s (42.66 ns) |
| **`areion_em_decrypt512`** | 33.8 MB/s (1,896.12 ns) | 998.0 MB/s (64.13 ns) |
| **`areion_em2_encrypt256`** | 16.7 MB/s (1,919.88 ns) | 627.4 MB/s (51.01 ns) |
| **`areion_em2_decrypt256`** | 17.7 MB/s (1,808.61 ns) | 512.7 MB/s (62.42 ns) |
| **`areion_em2_encrypt512`** | 22.4 MB/s (2,852.72 ns) | 784.9 MB/s (81.53 ns) |
| **`areion_em2_decrypt512`** | 17.8 MB/s (3,600.56 ns) | 512.4 MB/s (124.90 ns) |
| **`areion_tem_encrypt256`** | 16.7 MB/s (1,918.03 ns) | 614.8 MB/s (52.05 ns) |
| **`areion_tem_decrypt256`** | 17.2 MB/s (1,865.07 ns) | 598.8 MB/s (53.44 ns) |
| **`areion_tem_encrypt512`** | 22.5 MB/s (2,843.48 ns) | 774.7 MB/s (82.62 ns) |
| **`areion_tem_decrypt512`** | 19.8 MB/s (3,225.22 ns) | 624.2 MB/s (102.54 ns) |
| **`areion_tem2_encrypt256`** | 8.8 MB/s (3,635.10 ns) | 317.5 MB/s (100.78 ns) |
| **`areion_tem2_decrypt256`** | 9.0 MB/s (3,541.87 ns) | 292.5 MB/s (109.41 ns) |
| **`areion_tem2_encrypt512`** | 11.6 MB/s (5,497.44 ns) | 471.6 MB/s (135.72 ns) |
| **`areion_tem2_decrypt512`** | 10.2 MB/s (6,247.62 ns) | 361.3 MB/s (177.12 ns) |
| **`areion_em_encrypt256x4`** | 114.7 MB/s (1,116.13 ns) | 2,616.4 MB/s (48.92 ns) |
| **`areion_em_decrypt256x4`** | 121.1 MB/s (1,057.27 ns) | 2,279.7 MB/s (56.15 ns) |
| **`areion_em_encrypt512x4`** | 129.5 MB/s (1,976.53 ns) | 3,225.8 MB/s (79.36 ns) |
| **`areion_em_decrypt512x4`** | 107.6 MB/s (2,379.29 ns) | 2,537.8 MB/s (100.87 ns) |
| **`areion_em2_encrypt256x4`** | 62.8 MB/s (2,037.14 ns) | 1,460.8 MB/s (87.62 ns) |
| **`areion_em2_decrypt256x4`** | 66.6 MB/s (1,922.82 ns) | 1,251.7 MB/s (102.26 ns) |
| **`areion_em2_encrypt512x4`** | 68.4 MB/s (3,740.97 ns) | 1,835.9 MB/s (139.44 ns) |
| **`areion_em2_decrypt512x4`** | 56.1 MB/s (4,566.44 ns) | 1,396.8 MB/s (183.28 ns) |
| **`areion_tem_encrypt256x4`** | 62.8 MB/s (2,039.79 ns) | 1,385.5 MB/s (92.39 ns) |
| **`areion_tem_decrypt256x4`** | 64.7 MB/s (1,978.85 ns) | 1,299.0 MB/s (98.54 ns) |
| **`areion_tem_encrypt512x4`** | 67.6 MB/s (3,787.02 ns) | 1,719.5 MB/s (148.88 ns) |
| **`areion_tem_decrypt512x4`** | 60.8 MB/s (4,207.82 ns) | 1,504.6 MB/s (170.14 ns) |
| **`areion_tem2_encrypt256x4`** | 33.1 MB/s (3,872.80 ns) | 768.8 MB/s (166.49 ns) |
| **`areion_tem2_decrypt256x4`** | 34.1 MB/s (3,752.93 ns) | 714.4 MB/s (179.18 ns) |
| **`areion_tem2_encrypt512x4`** | 34.9 MB/s (7,336.00 ns) | 918.6 MB/s (278.68 ns) |
| **`areion_tem2_decrypt512x4`** | 31.4 MB/s (8,142.94 ns) | 797.3 MB/s (321.06 ns) |
| **`Rijndael-256`** | 4.6 MB/s (7,019.78 ns) | 216.3 MB/s (147.95 ns) |
| **`Rijndael-256x4`** | 14.6 MB/s (8,737.92 ns) | 268.6 MB/s (476.48 ns) |

All operations: 0 B/op, 0 allocs/op.

### 3. Comparison with `Rijndael-256` (`NIST SP 800-197`)

`Rijndael-256` (14 rounds, 256-bit block, 256-bit key, `ShiftRows` offsets `(0, 1, 3, 4)` across an `8 × 4` byte matrix) cannot execute directly on 128-bit `AESENC`/`AESE` instructions without applying the cross-128-bit-half byte permutation `InvShiftRows_AES128` ∘ `ShiftRows_R256(0,1,3,4)` before every round (`rijndael256_pre_permute` in `areion_test.c`). By contrast, Areion-256 uses a 2-branch Feistel/SPN structure built natively from 128-bit AES rounds with zero cross-half byte shuffles:

| 256-Bit Block Cipher Primitive | Intel Core i7-11700K (Best HW Tier) | AWS Graviton 4 (`arm64`) | Security Bound |
| :--- | :---: | :---: | :--- |
| **`areion_em_encrypt256`** | **3,436.7 MB/s** (`9.31 ns/op`) | **1,233.5 MB/s** (`25.94 ns/op`) | `2^128` queries (birthday PRP) |
| **`areion_em2_encrypt256`** | **1,904.8 MB/s** (`16.80 ns/op`) | **627.4 MB/s** (`51.01 ns/op`) | `2^170.7` queries (BBB PRP) |
| **`areion_tem_encrypt256`** | **1,860.8 MB/s** (`17.20 ns/op`) | **614.8 MB/s** (`52.05 ns/op`) | `2^128` queries (tweakable PRP) |
| **`areion_tem2_encrypt256`** | **1,079.9 MB/s** (`29.63 ns/op`) | **317.5 MB/s** (`100.78 ns/op`) | `2^170.7` queries (BBB TPRP) |
| **`areion_em_encrypt256x4`** | **5,398.2 MB/s** (`5.93 ns/block`) | **2,616.4 MB/s** (`12.23 ns/block`) | `2^128` queries (birthday PRP) |
| **`areion_em2_encrypt256x4`** | **3,040.8 MB/s** (`10.52 ns/block`) | **1,460.8 MB/s** (`21.91 ns/block`) | `2^170.7` queries (BBB PRP) |
| **`areion_tem_encrypt256x4`** | **2,937.7 MB/s** (`10.89 ns/block`) | **1,385.5 MB/s** (`23.10 ns/block`) | `2^128` queries (tweakable PRP) |
| **`areion_tem2_encrypt256x4`** | **1,668.9 MB/s** (`19.18 ns/block`) | **768.8 MB/s** (`41.62 ns/block`) | `2^170.7` queries (BBB TPRP) |
| **`Rijndael-256`** | 213.5 MB/s (`149.90 ns/op`) | 216.3 MB/s (`147.95 ns/op`) | 256-bit block cipher (`SP 800-197`) |
| **`Rijndael-256x4`** | 228.2 MB/s (`140.20 ns/block`) | 268.6 MB/s (`119.12 ns/block`) | 256-bit block cipher (`SP 800-197`) |

On Intel Core i7-11700K, `areion_em_encrypt256` is **16.1× faster** (and `areion_em_encrypt256x4` is **23.7× faster**) than hardware-assisted `Rijndael-256`; even the 2-round beyond-birthday-bound tweakable cipher `areion_tem2_encrypt256` (`29.63 ns/op`) is **5.1× faster** than single-block `Rijndael-256` (`149.90 ns/op`).

> **Benchmark methodology note:** `areion_permute*`, `areion_inverse_permute*`, `areion_aes128_round*`, and `areion_aes128_encrypt*` overwrite their state buffer in-place (`dst == src`), measuring serial dependency-chain latency across iterations (`areion_aes128_encrypt*` and `Rijndael256Encrypt*` time the encryption core with pre-expanded round keys). `areion_soem*`, `areion_dm*`, and `areion_{em,em2,tem,tem2}_*` evaluate fixed input, tweak, and key buffers across iterations, allowing out-of-order execution to overlap independent calls. See [`everanium/areion/analysis/README.md` (Section L)](https://github.com/everanium/areion/blob/main/analysis/README.md#l-register-and-stack-clearing-cost) for interleaved single-core cycle-per-byte measurements including epilogue register and stack clearing.

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

# Benchmark individual tiers:
AREION_FORCE_TIER=purec    ./areion_test --bench
AREION_FORCE_TIER=aesni    ./areion_test --bench
AREION_FORCE_TIER=vex      ./areion_test --bench
AREION_FORCE_TIER=vaesavx2 ./areion_test --bench
AREION_FORCE_TIER=avx512   ./areion_test --bench
AREION_FORCE_TIER=arm64    ./areion_test --bench
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
