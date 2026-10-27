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

> **Register and stack zeroization:** All hardware assembly kernels (both single-block and `×4` batch functions) execute directly in registers with zero secret stack spills (zero-byte stack frame on SysV `x86-64` and `arm64`, no intermediate AoS↔SoA stack buffers) and clear all touched vector registers (`PXOR` / `VPXOR` / `VPXORD` on `X0..X30` plus `VZEROUPPER` on `x86-64`; `VEOR` on `V0..V31` on `arm64`) and scratch general-purpose registers before returning. On `purec` fallback paths, C routines scrub local buffers via DSE-resistant `areion_secure_wipe` (`volatile uint8_t *` + compiler barrier), scrub their software stack frame (`areion_wipe_software_stack`), and clobber volatile scratch GPRs (`areion_clobber_scratch_gprs`). Verified across all tiers by `areion_zeroize_test.c` (with mandatory negative controls); see [`everanium/areion/analysis/README.md` (Section L)](https://github.com/everanium/areion/blob/main/analysis/README.md#l-register-and-stack-clearing-cost) for instruction-count and cycle-per-byte overhead measurements.

---

## Benchmarks

### 1. Intel® Core™ i7-11700K @ 3.60GHz (Rocket Lake, x86-64)

3-run averaged throughput and latency comparison across all 5 execution tiers on the same physical CPU (generated via `python3 scripts/run_bench.py`):

#### Core Permutations, Davies-Meyer, SoEM22 & AES-128 Primitives

| Operation | `purec` (Bitsliced) | `aesni` (128-bit SSE) | `vex` (128-bit VEX) | `vaesavx2` (256-bit YMM) | `avx512` (512-bit ZMM) |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **`areion_permute256`** | 37.3 MB/s (859.1 ns) | 2,080.7 MB/s (15.38 ns) | 2,129.1 MB/s (15.03 ns) | 2,136.6 MB/s (14.97 ns) | 2,132.4 MB/s (15.01 ns) |
| **`areion_permute512`** | 49.8 MB/s (1,294.4 ns) | 4,079.6 MB/s (15.69 ns) | 4,013.3 MB/s (15.95 ns) | 4,035.7 MB/s (15.86 ns) | 4,062.7 MB/s (15.76 ns) |
| **`areion_inverse_permute256`** | 39.1 MB/s (818.4 ns) | 1,477.5 MB/s (21.66 ns) | 1,464.3 MB/s (21.86 ns) | 1,477.4 MB/s (21.66 ns) | 1,478.9 MB/s (21.64 ns) |
| **`areion_inverse_permute512`** | 38.4 MB/s (1,666.2 ns) | 1,734.3 MB/s (36.90 ns) | 1,735.3 MB/s (36.88 ns) | 1,738.9 MB/s (36.80 ns) | 1,731.1 MB/s (36.97 ns) |
| **`areion_dm256`** | 36.1 MB/s (888.0 ns) | 5,557.4 MB/s (5.76 ns) | 5,990.0 MB/s (5.38 ns) | 5,810.3 MB/s (5.71 ns) | 6,251.6 MB/s (5.15 ns) |
| **`areion_dm512`** | 51.1 MB/s (1,251.9 ns) | 5,332.6 MB/s (12.01 ns) | 5,419.8 MB/s (11.81 ns) | 5,583.1 MB/s (11.49 ns) | 5,604.4 MB/s (11.44 ns) |
| **`areion_soem256`** | 36.9 MB/s (868.5 ns) | 2,845.0 MB/s (11.26 ns) | 2,933.7 MB/s (10.91 ns) | 3,022.4 MB/s (10.60 ns) | 2,908.4 MB/s (11.05 ns) |
| **`areion_soem512`** | 45.7 MB/s (1,407.1 ns) | 3,011.2 MB/s (21.27 ns) | 3,001.8 MB/s (21.35 ns) | 3,029.9 MB/s (21.15 ns) | 2,955.0 MB/s (21.67 ns) |
| **`areion_permute256x4`** | 143.2 MB/s (894.0 ns) | 7,465.8 MB/s (17.15 ns) | 6,759.1 MB/s (18.95 ns) | 7,411.4 MB/s (17.27 ns) | 6,764.5 MB/s (18.92 ns) |
| **`areion_permute512x4`** | 150.7 MB/s (1,702.0 ns) | 6,384.4 MB/s (40.17 ns) | 7,193.4 MB/s (35.59 ns) | 11,319.0 MB/s (22.62 ns) | 11,121.4 MB/s (23.02 ns) |
| **`areion_inverse_permute256x4`** | 149.1 MB/s (859.4 ns) | 5,520.8 MB/s (23.19 ns) | 5,558.2 MB/s (23.03 ns) | 5,332.4 MB/s (24.01 ns) | 5,058.3 MB/s (25.30 ns) |
| **`areion_inverse_permute512x4`** | 127.2 MB/s (2,012.3 ns) | 3,658.0 MB/s (69.99 ns) | 3,805.7 MB/s (67.28 ns) | 3,316.0 MB/s (77.20 ns) | 3,326.5 MB/s (76.97 ns) |
| **`areion_soem256x4`** | 72.0 MB/s (1,779.9 ns) | 3,938.0 MB/s (32.51 ns) | 3,988.1 MB/s (32.11 ns) | 6,063.0 MB/s (21.12 ns) | 8,558.3 MB/s (14.97 ns) |
| **`areion_soem512x4`** | 76.1 MB/s (3,378.6 ns) | 2,524.0 MB/s (101.87 ns) | 3,435.9 MB/s (74.63 ns) | 5,719.8 MB/s (44.80 ns) | 6,373.3 MB/s (40.21 ns) |
| **`areion_aes128_round`** | 126.9 MB/s (126.22 ns) | 5,810.0 MB/s (2.77 ns) | 6,085.9 MB/s (2.64 ns) | 5,909.7 MB/s (2.71 ns) | 5,867.6 MB/s (2.74 ns) |
| **`areion_aes128_round4`** | 399.0 MB/s (160.41 ns) | 12,615.1 MB/s (5.08 ns) | 12,730.6 MB/s (5.03 ns) | 10,935.2 MB/s (5.91 ns) | 11,980.9 MB/s (5.38 ns) |
| **`areion_expand_key128`** | 580.4 MB/s (304.40 ns) | 4,660.0 MB/s (37.78 ns) | 4,768.8 MB/s (36.94 ns) | 4,633.4 MB/s (38.02 ns) | 4,650.0 MB/s (37.89 ns) |
| **`areion_aes128_encrypt_block`** | 32.2 MB/s (497.04 ns) | 1,907.9 MB/s (8.39 ns) | 1,912.0 MB/s (8.37 ns) | 1,904.4 MB/s (8.40 ns) | 1,905.6 MB/s (8.40 ns) |
| **`areion_aes128_encrypt4_blocks`** | 126.4 MB/s (506.66 ns) | 7,187.8 MB/s (8.91 ns) | 6,898.5 MB/s (9.28 ns) | 6,154.2 MB/s (11.63 ns) | 7,445.8 MB/s (8.60 ns) |

#### Wide-Block Ciphers (`EM`, `EM2`, `TEM`, `TEM2`) vs. `Rijndael-256` & `Vistrutah-256/512`

| Operation | `purec` (Bitsliced) | `aesni` (128-bit SSE) | `vex` (128-bit VEX) | `vaesavx2` (256-bit YMM) | `avx512` (512-bit ZMM) |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **`areion_em_encrypt256`** | 37.7 MB/s (848.6 ns) | 4,922.2 MB/s (6.50 ns) | 5,415.2 MB/s (5.95 ns) | 4,991.6 MB/s (6.42 ns) | 5,883.0 MB/s (5.46 ns) |
| **`areion_em_decrypt256`** | 39.5 MB/s (811.8 ns) | 3,583.6 MB/s (8.97 ns) | 4,349.9 MB/s (7.37 ns) | 4,108.2 MB/s (7.85 ns) | 4,398.9 MB/s (7.30 ns) |
| **`areion_em_encrypt512`** | 52.0 MB/s (1,231.5 ns) | 5,134.1 MB/s (12.48 ns) | 5,226.8 MB/s (12.27 ns) | 5,438.0 MB/s (11.78 ns) | 5,298.8 MB/s (12.11 ns) |
| **`areion_em_decrypt512`** | 36.8 MB/s (1,743.5 ns) | 2,647.0 MB/s (24.18 ns) | 2,721.5 MB/s (23.54 ns) | 2,788.7 MB/s (23.01 ns) | 2,865.2 MB/s (22.34 ns) |
| **`areion_em2_encrypt256`** | 18.4 MB/s (1,738.0 ns) | 2,190.6 MB/s (14.62 ns) | 2,297.7 MB/s (13.93 ns) | 2,144.0 MB/s (14.94 ns) | 2,221.7 MB/s (14.43 ns) |
| **`areion_em2_decrypt256`** | 20.5 MB/s (1,564.4 ns) | 1,627.7 MB/s (19.73 ns) | 1,616.3 MB/s (19.91 ns) | 1,669.5 MB/s (19.19 ns) | 1,614.6 MB/s (19.84 ns) |
| **`areion_em2_encrypt512`** | 25.6 MB/s (2,500.4 ns) | 2,352.9 MB/s (27.21 ns) | 2,329.5 MB/s (27.51 ns) | 2,370.2 MB/s (27.01 ns) | 2,401.4 MB/s (26.65 ns) |
| **`areion_em2_decrypt512`** | 18.7 MB/s (3,429.7 ns) | 1,040.2 MB/s (61.55 ns) | 1,085.1 MB/s (58.99 ns) | 1,029.2 MB/s (62.23 ns) | 1,069.9 MB/s (59.82 ns) |
| **`areion_tem_encrypt256`** | 20.0 MB/s (1,599.5 ns) | 2,003.7 MB/s (16.10 ns) | 2,242.0 MB/s (14.28 ns) | 2,227.0 MB/s (14.39 ns) | 2,157.3 MB/s (14.94 ns) |
| **`areion_tem_decrypt256`** | 20.5 MB/s (1,562.2 ns) | 1,887.4 MB/s (17.08 ns) | 1,931.2 MB/s (16.59 ns) | 1,968.1 MB/s (16.30 ns) | 1,980.5 MB/s (16.25 ns) |
| **`areion_tem_encrypt512`** | 26.7 MB/s (2,396.2 ns) | 2,309.2 MB/s (27.73 ns) | 2,321.0 MB/s (27.58 ns) | 2,322.5 MB/s (27.56 ns) | 2,324.0 MB/s (27.55 ns) |
| **`areion_tem_decrypt512`** | 22.1 MB/s (2,896.6 ns) | 1,546.8 MB/s (41.48 ns) | 1,601.8 MB/s (39.99 ns) | 1,573.0 MB/s (40.74 ns) | 1,610.8 MB/s (39.74 ns) |
| **`areion_tem2_encrypt256`** | 10.0 MB/s (3,189.0 ns) | 1,081.9 MB/s (29.61 ns) | 1,145.7 MB/s (27.93 ns) | 1,133.3 MB/s (28.25 ns) | 1,120.6 MB/s (28.63 ns) |
| **`areion_tem2_decrypt256`** | 10.2 MB/s (3,146.7 ns) | 876.0 MB/s (36.58 ns) | 840.1 MB/s (38.12 ns) | 875.8 MB/s (36.58 ns) | 862.3 MB/s (37.18 ns) |
| **`areion_tem2_encrypt512`** | 12.9 MB/s (4,969.1 ns) | 1,343.8 MB/s (47.65 ns) | 1,331.0 MB/s (48.09 ns) | 1,347.0 MB/s (47.52 ns) | 1,329.6 MB/s (48.14 ns) |
| **`areion_tem2_decrypt512`** | 11.3 MB/s (5,688.7 ns) | 742.7 MB/s (86.22 ns) | 773.1 MB/s (82.79 ns) | 757.7 MB/s (84.47 ns) | 754.6 MB/s (84.86 ns) |
| **`areion_em_encrypt256x4`** | 133.1 MB/s (965.3 ns) | 7,195.2 MB/s (17.88 ns) | 7,424.9 MB/s (17.28 ns) | 9,143.2 MB/s (14.00 ns) | 13,402.4 MB/s (9.59 ns) |
| **`areion_em_decrypt256x4`** | 143.5 MB/s (894.7 ns) | 6,188.8 MB/s (20.73 ns) | 6,372.9 MB/s (20.11 ns) | 6,705.5 MB/s (19.21 ns) | 11,668.5 MB/s (11.01 ns) |
| **`areion_em_encrypt512x4`** | 148.4 MB/s (1,729.6 ns) | 6,405.6 MB/s (39.98 ns) | 6,747.2 MB/s (37.96 ns) | 9,688.9 MB/s (26.48 ns) | 13,708.3 MB/s (18.72 ns) |
| **`areion_em_decrypt512x4`** | 125.4 MB/s (2,042.1 ns) | 3,498.5 MB/s (73.20 ns) | 3,599.3 MB/s (71.15 ns) | 3,144.6 MB/s (81.43 ns) | 3,635.5 MB/s (70.42 ns) |
| **`areion_em2_encrypt256x4`** | 73.8 MB/s (1,735.9 ns) | 3,647.6 MB/s (35.37 ns) | 3,682.5 MB/s (34.77 ns) | 4,260.1 MB/s (30.18 ns) | 6,798.4 MB/s (18.86 ns) |
| **`areion_em2_decrypt256x4`** | 76.2 MB/s (1,684.5 ns) | 2,872.0 MB/s (44.61 ns) | 2,966.1 MB/s (43.19 ns) | 3,178.7 MB/s (40.40 ns) | 5,152.9 MB/s (24.87 ns) |
| **`areion_em2_encrypt512x4`** | 78.4 MB/s (3,270.8 ns) | 3,060.5 MB/s (84.14 ns) | 3,223.7 MB/s (79.48 ns) | 4,621.9 MB/s (55.39 ns) | 7,014.7 MB/s (36.52 ns) |
| **`areion_em2_decrypt512x4`** | 65.5 MB/s (3,911.7 ns) | 1,658.7 MB/s (154.39 ns) | 1,724.2 MB/s (148.48 ns) | 1,338.2 MB/s (191.31 ns) | 1,775.6 MB/s (144.18 ns) |
| **`areion_tem_encrypt256x4`** | 75.9 MB/s (1,685.0 ns) | 3,356.0 MB/s (38.36 ns) | 3,565.1 MB/s (35.92 ns) | 4,185.5 MB/s (30.64 ns) | 6,178.7 MB/s (20.85 ns) |
| **`areion_tem_decrypt256x4`** | 75.7 MB/s (1,693.8 ns) | 3,028.6 MB/s (42.49 ns) | 3,141.2 MB/s (40.88 ns) | 3,504.9 MB/s (36.55 ns) | 5,722.3 MB/s (22.60 ns) |
| **`areion_tem_encrypt512x4`** | 80.4 MB/s (3,185.3 ns) | 3,048.2 MB/s (84.09 ns) | 3,108.6 MB/s (82.51 ns) | 4,557.2 MB/s (56.24 ns) | 6,934.3 MB/s (36.94 ns) |
| **`areion_tem_decrypt512x4`** | 68.4 MB/s (3,747.9 ns) | 1,880.4 MB/s (136.18 ns) | 2,004.2 MB/s (127.76 ns) | 2,191.9 MB/s (116.81 ns) | 2,850.9 MB/s (89.81 ns) |
| **`areion_tem2_encrypt256x4`** | 37.3 MB/s (3,437.7 ns) | 1,525.9 MB/s (83.89 ns) | 1,522.0 MB/s (84.17 ns) | 2,175.6 MB/s (58.87 ns) | 3,545.1 MB/s (36.12 ns) |
| **`areion_tem2_decrypt256x4`** | 38.4 MB/s (3,340.2 ns) | 1,302.5 MB/s (98.28 ns) | 1,300.5 MB/s (98.46 ns) | 1,657.5 MB/s (77.25 ns) | 2,991.1 MB/s (42.82 ns) |
| **`areion_tem2_encrypt512x4`** | 41.4 MB/s (6,179.2 ns) | 1,291.4 MB/s (198.31 ns) | 1,355.8 MB/s (188.97 ns) | 2,682.4 MB/s (95.44 ns) | 3,467.7 MB/s (73.98 ns) |
| **`areion_tem2_decrypt512x4`** | 35.2 MB/s (7,290.1 ns) | 758.5 MB/s (337.66 ns) | 768.7 MB/s (333.11 ns) | 1,036.6 MB/s (246.98 ns) | 1,405.3 MB/s (182.24 ns) |
| **`Rijndael-256`** | 42.2 MB/s (761.9 ns) | 2,018.2 MB/s (15.86 ns) | 1,815.3 MB/s (17.64 ns) | 1,671.1 MB/s (19.17 ns) | 1,574.2 MB/s (20.44 ns) |
| **`Rijndael-256x4`** | 112.1 MB/s (1,155.4 ns) | 3,500.6 MB/s (36.67 ns) | 3,261.6 MB/s (39.25 ns) | 4,325.1 MB/s (29.63 ns) | 6,596.4 MB/s (19.54 ns) |
| **`Vistrutah-256 (10r)`** | 41.2 MB/s (776.0 ns) | 3,256.0 MB/s (9.99 ns) | 3,364.1 MB/s (9.54 ns) | 4,984.0 MB/s (6.43 ns) | 5,040.0 MB/s (6.37 ns) |
| **`Vistrutah-256 (14r)`** | 30.0 MB/s (1,068.4 ns) | 2,430.5 MB/s (13.18 ns) | 2,353.7 MB/s (13.61 ns) | 3,325.6 MB/s (9.62 ns) | 3,292.1 MB/s (9.78 ns) |
| **`Vistrutah-256x4 (10r)`** | 45.6 MB/s (2,808.9 ns) | 6,328.2 MB/s (20.23 ns) | 6,070.6 MB/s (21.10 ns) | 9,091.1 MB/s (14.09 ns) | 12,002.0 MB/s (10.69 ns) |
| **`Vistrutah-256x4 (14r)`** | 32.5 MB/s (3,935.7 ns) | 4,391.9 MB/s (29.22 ns) | 4,150.4 MB/s (30.86 ns) | 6,412.1 MB/s (19.97 ns) | 8,005.7 MB/s (15.99 ns) |
| **`Vistrutah-512-256 (10r)`** | 61.3 MB/s (1,044.6 ns) | 4,182.4 MB/s (15.31 ns) | 4,175.8 MB/s (15.38 ns) | 5,269.5 MB/s (12.16 ns) | 4,516.6 MB/s (14.18 ns) |
| **`Vistrutah-512-256 (14r)`** | 46.1 MB/s (1,389.3 ns) | 2,751.3 MB/s (23.30 ns) | 2,778.0 MB/s (23.05 ns) | 3,273.4 MB/s (19.56 ns) | 2,686.7 MB/s (23.86 ns) |
| **`Vistrutah-512-256 (18r)`** | 36.5 MB/s (1,755.6 ns) | 2,081.0 MB/s (30.76 ns) | 2,172.2 MB/s (29.46 ns) | 2,501.4 MB/s (25.60 ns) | 2,061.4 MB/s (31.05 ns) |
| **`Vistrutah-512-512 (12r)`** | 51.6 MB/s (1,243.4 ns) | 3,122.5 MB/s (20.67 ns) | 3,513.9 MB/s (18.22 ns) | 4,010.4 MB/s (15.97 ns) | 3,714.6 MB/s (17.24 ns) |
| **`Vistrutah-512-512 (18r)`** | 33.1 MB/s (1,936.1 ns) | 2,055.8 MB/s (31.13 ns) | 2,169.8 MB/s (29.50 ns) | 2,442.2 MB/s (26.23 ns) | 2,090.8 MB/s (30.61 ns) |
| **`Vistrutah-512-256x4 (10r)`** | 67.9 MB/s (3,771.5 ns) | 4,956.6 MB/s (51.66 ns) | 5,226.8 MB/s (48.99 ns) | 8,518.0 MB/s (30.22 ns) | 10,000.0 MB/s (25.68 ns) |
| **`Vistrutah-512-256x4 (14r)`** | 47.4 MB/s (5,406.7 ns) | 3,175.7 MB/s (80.69 ns) | 3,375.4 MB/s (75.87 ns) | 6,279.2 MB/s (40.81 ns) | 7,138.1 MB/s (35.89 ns) |
| **`Vistrutah-512-256x4 (18r)`** | 36.0 MB/s (7,165.3 ns) | 2,380.3 MB/s (107.57 ns) | 2,438.5 MB/s (105.00 ns) | 4,946.3 MB/s (51.79 ns) | 5,723.9 MB/s (44.74 ns) |
| **`Vistrutah-512-512x4 (12r)`** | 53.1 MB/s (4,828.9 ns) | 3,779.7 MB/s (67.90 ns) | 4,094.9 MB/s (62.55 ns) | 7,588.0 MB/s (33.76 ns) | 9,094.5 MB/s (28.20 ns) |
| **`Vistrutah-512-512x4 (18r)`** | 35.5 MB/s (7,236.3 ns) | 2,381.9 MB/s (107.51 ns) | 2,459.0 MB/s (104.11 ns) | 5,159.5 MB/s (49.65 ns) | 5,969.2 MB/s (42.92 ns) |

All operations: 0 B/op, 0 allocs/op.

### 2. AWS Graviton 4 (`c8g.4xlarge`, Neoverse-V2, 16 vCPUs, ARM64)

3-run averaged throughput measured on AWS Graviton 4 (`purec` bitsliced fallback vs `arm64` ARMv8 Cryptographic Extension):

#### Core Permutations, Davies-Meyer, SoEM22 & AES-128 Primitives

| Operation | `purec` (Bitsliced) | `arm64` (128-bit NEON) |
| :--- | :---: | :---: |
| **`areion_permute256`** | 32.4 MB/s (987.98 ns) | 917.5 MB/s (34.88 ns) |
| **`areion_permute512`** | 44.0 MB/s (1,456.67 ns) | 1,578.6 MB/s (40.55 ns) |
| **`areion_inverse_permute256`** | 34.3 MB/s (931.87 ns) | 766.8 MB/s (41.73 ns) |
| **`areion_inverse_permute512`** | 34.7 MB/s (1,847.39 ns) | 1,026.0 MB/s (62.38 ns) |
| **`areion_dm256`** | 32.3 MB/s (991.27 ns) | 1,987.2 MB/s (16.10 ns) |
| **`areion_dm512`** | 43.9 MB/s (1,458.58 ns) | 1,919.0 MB/s (33.35 ns) |
| **`areion_soem256`** | 31.4 MB/s (1,018.53 ns) | 815.8 MB/s (39.23 ns) |
| **`areion_soem512`** | 42.9 MB/s (1,490.21 ns) | 1,154.2 MB/s (55.46 ns) |
| **`areion_permute256x4`** | 124.9 MB/s (1,025.16 ns) | 3,591.7 MB/s (35.64 ns) |
| **`areion_permute512x4`** | 143.7 MB/s (1,781.58 ns) | 3,182.9 MB/s (80.43 ns) |
| **`areion_inverse_permute256x4`** | 129.8 MB/s (986.25 ns) | 2,991.2 MB/s (42.79 ns) |
| **`areion_inverse_permute512x4`** | 117.3 MB/s (2,182.66 ns) | 2,161.1 MB/s (118.46 ns) |
| **`areion_soem256x4`** | 68.8 MB/s (1,861.63 ns) | 1,877.2 MB/s (68.19 ns) |
| **`areion_soem512x4`** | 76.0 MB/s (3,370.82 ns) | 1,203.4 MB/s (212.73 ns) |
| **`areion_aes128_round`** | 64.5 MB/s (247.92 ns) | 4,325.4 MB/s (3.71 ns) |
| **`areion_aes128_round4`** | 214.2 MB/s (298.84 ns) | 11,910.0 MB/s (5.37 ns) |
| **`areion_expand_key128`** | 358.7 MB/s (490.57 ns) | 6,547.5 MB/s (26.88 ns) |
| **`areion_aes128_encrypt_block`** | 25.8 MB/s (620.19 ns) | 1,577.0 MB/s (10.15 ns) |
| **`areion_aes128_encrypt4_blocks`** | 99.6 MB/s (642.29 ns) | 5,964.7 MB/s (10.73 ns) |

#### Wide-Block Ciphers (`EM`, `EM2`, `TEM`, `TEM2`) vs. `Rijndael-256` & `Vistrutah-256/512`

| Operation | `purec` (Bitsliced) | `arm64` (128-bit NEON) |
| :--- | :---: | :---: |
| **`areion_em_encrypt256`** | 32.2 MB/s (993.96 ns) | 1,913.4 MB/s (16.73 ns) |
| **`areion_em_decrypt256`** | 34.0 MB/s (941.10 ns) | 1,546.3 MB/s (20.69 ns) |
| **`areion_em_encrypt512`** | 43.8 MB/s (1,461.76 ns) | 1,874.7 MB/s (34.14 ns) |
| **`areion_em_decrypt512`** | 34.5 MB/s (1,853.41 ns) | 1,226.7 MB/s (52.17 ns) |
| **`areion_em2_encrypt256`** | 17.7 MB/s (1,808.96 ns) | 757.4 MB/s (42.25 ns) |
| **`areion_em2_decrypt256`** | 19.0 MB/s (1,685.89 ns) | 607.2 MB/s (52.71 ns) |
| **`areion_em2_encrypt512`** | 23.3 MB/s (2,745.70 ns) | 877.2 MB/s (72.96 ns) |
| **`areion_em2_decrypt512`** | 18.3 MB/s (3,498.94 ns) | 564.7 MB/s (113.33 ns) |
| **`areion_tem_encrypt256`** | 17.9 MB/s (1,790.73 ns) | 743.3 MB/s (43.05 ns) |
| **`areion_tem_decrypt256`** | 18.4 MB/s (1,737.08 ns) | 713.1 MB/s (44.88 ns) |
| **`areion_tem_encrypt512`** | 23.8 MB/s (2,693.46 ns) | 867.9 MB/s (73.74 ns) |
| **`areion_tem_decrypt512`** | 20.4 MB/s (3,135.84 ns) | 706.6 MB/s (90.58 ns) |
| **`areion_tem2_encrypt256`** | 9.5 MB/s (3,377.75 ns) | 347.6 MB/s (92.07 ns) |
| **`areion_tem2_decrypt256`** | 9.8 MB/s (3,276.69 ns) | 317.9 MB/s (100.67 ns) |
| **`areion_tem2_encrypt512`** | 12.3 MB/s (5,205.00 ns) | 497.9 MB/s (128.54 ns) |
| **`areion_tem2_decrypt512`** | 10.7 MB/s (5,950.64 ns) | 380.0 MB/s (168.44 ns) |
| **`areion_em_encrypt256x4`** | 124.0 MB/s (1,032.06 ns) | 3,508.7 MB/s (36.48 ns) |
| **`areion_em_decrypt256x4`** | 128.9 MB/s (993.12 ns) | 2,961.2 MB/s (43.23 ns) |
| **`areion_em_encrypt512x4`** | 143.5 MB/s (1,783.87 ns) | 2,960.4 MB/s (86.48 ns) |
| **`areion_em_decrypt512x4`** | 116.4 MB/s (2,199.65 ns) | 2,030.9 MB/s (126.05 ns) |
| **`areion_em2_encrypt256x4`** | 67.8 MB/s (1,889.64 ns) | 1,833.8 MB/s (69.80 ns) |
| **`areion_em2_decrypt256x4`** | 71.0 MB/s (1,802.98 ns) | 1,514.5 MB/s (84.52 ns) |
| **`areion_em2_encrypt512x4`** | 76.0 MB/s (3,369.71 ns) | 1,510.8 MB/s (169.44 ns) |
| **`areion_em2_decrypt512x4`** | 61.2 MB/s (4,186.26 ns) | 1,010.4 MB/s (253.37 ns) |
| **`areion_tem_encrypt256x4`** | 68.6 MB/s (1,865.37 ns) | 1,805.2 MB/s (70.91 ns) |
| **`areion_tem_decrypt256x4`** | 70.0 MB/s (1,828.57 ns) | 1,661.6 MB/s (77.03 ns) |
| **`areion_tem_encrypt512x4`** | 76.0 MB/s (3,368.74 ns) | 1,473.0 MB/s (173.79 ns) |
| **`areion_tem_decrypt512x4`** | 67.6 MB/s (3,788.27 ns) | 1,215.1 MB/s (210.68 ns) |
| **`areion_tem2_encrypt256x4`** | 36.2 MB/s (3,534.60 ns) | 915.4 MB/s (139.83 ns) |
| **`areion_tem2_decrypt256x4`** | 37.1 MB/s (3,450.37 ns) | 831.5 MB/s (153.94 ns) |
| **`areion_tem2_encrypt512x4`** | 39.1 MB/s (6,543.23 ns) | 746.8 MB/s (342.81 ns) |
| **`areion_tem2_decrypt512x4`** | 34.8 MB/s (7,362.18 ns) | 602.4 MB/s (424.99 ns) |
| **`Rijndael-256`** | 39.2 MB/s (815.64 ns) | 1,383.1 MB/s (23.14 ns) |
| **`Rijndael-256x4`** | 114.5 MB/s (1,117.73 ns) | 2,676.3 MB/s (47.83 ns) |
| **`Vistrutah-256 (10r)`** | 32.8 MB/s (975.11 ns) | 3,504.3 MB/s (9.13 ns) |
| **`Vistrutah-256 (14r)`** | 24.7 MB/s (1,296.06 ns) | 2,349.7 MB/s (13.62 ns) |
| **`Vistrutah-256x4 (10r)`** | 38.9 MB/s (3,286.53 ns) | 5,580.7 MB/s (22.94 ns) |
| **`Vistrutah-256x4 (14r)`** | 28.0 MB/s (4,568.49 ns) | 4,382.6 MB/s (29.21 ns) |
| **`Vistrutah-512-256 (10r)`** | 48.5 MB/s (1,320.57 ns) | 3,496.2 MB/s (18.31 ns) |
| **`Vistrutah-512-256 (14r)`** | 36.0 MB/s (1,779.26 ns) | 2,463.4 MB/s (25.98 ns) |
| **`Vistrutah-512-256 (18r)`** | 28.6 MB/s (2,243.40 ns) | 1,876.6 MB/s (34.10 ns) |
| **`Vistrutah-512-512 (12r)`** | 41.5 MB/s (1,543.33 ns) | 3,050.8 MB/s (20.98 ns) |
| **`Vistrutah-512-512 (18r)`** | 28.6 MB/s (2,236.22 ns) | 1,936.4 MB/s (33.05 ns) |
| **`Vistrutah-512-256x4 (10r)`** | 54.4 MB/s (4,706.59 ns) | 5,561.0 MB/s (46.05 ns) |
| **`Vistrutah-512-256x4 (14r)`** | 39.1 MB/s (6,540.29 ns) | 4,086.8 MB/s (62.64 ns) |
| **`Vistrutah-512-256x4 (18r)`** | 30.5 MB/s (8,398.13 ns) | 3,203.1 MB/s (79.92 ns) |
| **`Vistrutah-512-512x4 (12r)`** | 45.9 MB/s (5,575.95 ns) | 4,801.3 MB/s (53.32 ns) |
| **`Vistrutah-512-512x4 (18r)`** | 30.7 MB/s (8,339.25 ns) | 3,218.0 MB/s (79.55 ns) |

All operations: 0 B/op, 0 allocs/op.

### 3. Comparison with `Rijndael-256` (`NIST SP 800-197`) and `Vistrutah-256/512` ([ePrint 2025/976](https://eprint.iacr.org/2025/976))

- **`Rijndael-256`** (14 rounds, 256-bit block, 256-bit key, `ShiftRows` offsets `(0, 1, 3, 4)` across an `8 × 4` byte matrix) requires a cross-128-bit-half byte permutation `InvShiftRows_AES128` ∘ `ShiftRows_R256(0,1,3,4)` (`PSHUFB`/`VPSHUFB` + `PBLENDVB`/`VPBLENDVB` on x86-64, `VTBL2` on ARM64) before every round and 480 bytes (`15 × 32 B`) of pre-expanded round keys in RAM.
- **`Vistrutah-256`** (`10` or `14` rounds, 256-bit block, 256-bit key) and **`Vistrutah-512`** (`10`, `14`, or `18` rounds with 256-bit key; `12` or `18` rounds with 512-bit key) alternate pairs of parallel 128-bit AES rounds with a cross-slice `mixSlice` byte shuffle (`PUNPCK*` + `PALIGNR`/`PSHUFB` on x86-64, `VZIP1`/`VZIP2` + `VTBL` on ARM64) every two rounds and an on-the-fly key permutation `ρ`.
- **`Areion-256` / `Areion-512`** use a 2-branch / 4-branch Feistel/SPN structure built natively from 128-bit AES rounds with **zero byte shuffles (`PSHUFB`/`VTBL`)** on the data path and **zero persistent round-key state in RAM** (`EM`, `EM2`, `TEM`, `TEM2` hold keys strictly in volatile registers and wipe them before returning):

| Wide-Block Cipher Primitive | Intel Core i7-11700K (Best HW Tier) | AWS Graviton 4 (`arm64`) | Block / Key / RAM Key State & Security |
| :--- | :---: | :---: | :--- |
| **`areion_em_encrypt256`** | **5,883.0 MB/s** (`5.46 ns/op`) | **1,913.4 MB/s** (`16.73 ns/op`) | 256b / 512b key, `0 B` RAM RK (`2^128` PRP) |
| **`areion_em2_encrypt256`** | **2,297.7 MB/s** (`13.93 ns/op`) | **757.4 MB/s** (`42.25 ns/op`) | 256b / 512b key, `0 B` RAM RK (`2^170.7` BBB PRP) |
| **`areion_tem_encrypt256`** | **2,242.0 MB/s** (`14.28 ns/op`) | **743.3 MB/s** (`43.05 ns/op`) | 256b / 512b + 256b tweak, `0 B` RAM RK (`2^128` TPRP) |
| **`areion_tem2_encrypt256`** | **1,145.7 MB/s** (`27.93 ns/op`) | **347.6 MB/s** (`92.07 ns/op`) | 256b / 512b + 256b tweak, `0 B` RAM RK (`2^170.7` BBB TPRP) |
| **`areion_em_encrypt256x4`** | **13,402.4 MB/s** (`2.40 ns/block`) | **3,508.7 MB/s** (`9.12 ns/block`) | 4×256b, `0 B` RAM RK (`2^128` PRP) |
| **`areion_em2_encrypt256x4`** | **6,798.4 MB/s** (`4.72 ns/block`) | **1,833.8 MB/s** (`17.45 ns/block`) | 4×256b, `0 B` RAM RK (`2^170.7` BBB PRP) |
| **`areion_tem_encrypt256x4`** | **6,178.7 MB/s** (`5.21 ns/block`) | **1,805.2 MB/s** (`17.73 ns/block`) | 4×256b + tweaks, `0 B` RAM RK (`2^128` TPRP) |
| **`areion_tem2_encrypt256x4`** | **3,545.1 MB/s** (`9.03 ns/block`) | **915.4 MB/s** (`34.96 ns/block`) | 4×256b + tweaks, `0 B` RAM RK (`2^170.7` BBB TPRP) |
| **`Rijndael-256 (14r)`** | 2,018.2 MB/s (`15.86 ns/op`) | 1,383.1 MB/s (`23.14 ns/op`) | 256b / 256b key, **`480 B` RAM RK** (`SP 800-197`) |
| **`Rijndael-256x4 (14r)`** | 6,596.4 MB/s (`4.89 ns/block`) | 2,676.3 MB/s (`11.96 ns/block`) | 4×256b, **`480 B` RAM RK** (`SP 800-197`) |
| **`Vistrutah-256 (10r / 14r)`** | 5,040.0 / 3,325.6 MB/s (`6.37` / `9.62 ns`) | 3,504.3 / 2,349.7 MB/s (`9.13` / `13.62 ns`) | 256b / 256b key, `0 B` RAM RK (`ePrint 2025/976`) |
| **`Vistrutah-256x4 (10r / 14r)`** | 12,002.0 / 8,005.7 MB/s (`2.67` / `4.00 ns/blk`) | 5,580.7 / 4,382.6 MB/s (`5.74` / `7.30 ns/blk`) | 4×256b, `0 B` RAM RK (`ePrint 2025/976`) |
| **`areion_em_encrypt512`** | **5,438.0 MB/s** (`11.78 ns/op`) | **1,874.7 MB/s** (`34.14 ns/op`) | 512b / 1024b key, `0 B` RAM RK (`2^256` PRP) |
| **`areion_em_encrypt512x4`** | **13,708.3 MB/s** (`4.68 ns/block`) | **2,960.4 MB/s** (`21.62 ns/block`) | 4×512b, `0 B` RAM RK (`2^256` PRP) |
| **`Vistrutah-512-256 (10r / 14r / 18r)`** | 5,269.5 / 3,273.4 / 2,501.4 MB/s | 3,496.2 / 2,463.4 / 1,876.6 MB/s | 512b / 256b key, `0 B` RAM RK (`ePrint 2025/976`) |
| **`Vistrutah-512-512 (12r / 18r)`** | 4,010.4 / 2,442.2 MB/s | 3,050.8 / 1,936.4 MB/s | 512b / 512b key, `0 B` RAM RK (`ePrint 2025/976`) |
| **`Vistrutah-512-256x4 (10r / 14r / 18r)`** | 10,000.0 / 7,138.1 / 5,723.9 MB/s | 5,561.0 / 4,086.8 / 3,203.1 MB/s | 4×512b / 256b key, `0 B` RAM RK (`ePrint 2025/976`) |
| **`Vistrutah-512-512x4 (12r / 18r)`** | 9,094.5 / 5,969.2 MB/s | 4,801.3 / 3,218.0 MB/s | 4×512b / 512b key, `0 B` RAM RK (`ePrint 2025/976`) |

On Intel Core i7-11700K, `areion_em_encrypt256` (`5,883.0 MB/s`, `5.46 ns/op`) and `areion_em_encrypt256x4` (`13,402.4 MB/s`, `9.59 ns/op`) outperform both 14-round `Rijndael-256` (`2,018.2 MB/s` single-block, `6,596.4 MB/s` 4-block) and 10r/14r `Vistrutah-256` (`5,040.0` / `3,325.6 MB/s` single-block, `12,002.0` / `8,005.7 MB/s` 4-block), while `areion_em_encrypt512` (`5,438.0 MB/s`) and `areion_em_encrypt512x4` (`13,708.3 MB/s`) outperform all `Vistrutah-512` variants (`10r`, `12r`, `14r`, `18r`).

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
