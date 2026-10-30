## Areion, Areion-SoEM-256/512 & Wide-Block Even-Mansour (EM / EM2 / TEM / TEM2), ASURA C + Assembly Reference Library

C99 + Assembly reference implementation of the **Areion** cryptographic permutation family, **Davies-Meyer** short-input compression, the **SoEM22** pseudorandom function (PRF), four families of **256-bit and 512-bit wide-block Even-Mansour and Tweakable Even-Mansour ciphers (`EM`, `EM2`, `TEM`, `TEM2`)**, and the **ASURA 256-bit tweakable block cipher** (INDOCRYPT 2024).
Companion Go + Assembly reference library: **[`everanium/areion`](https://github.com/everanium/areion)**.

[![C Standard: C99 / C11](https://img.shields.io/badge/C-C99_%2F_C11-blue.svg)](areion.h)
[![static-analysis: passing](https://img.shields.io/badge/static--analysis-passing-green)](Makefile)
[![Coverage](https://img.shields.io/badge/coverage-99%25-brightgreen)](https://github.com/everanium/areion-c)
[![License: Apache-2.0 / MIT](https://img.shields.io/badge/License-Apache_2.0_OR_MIT-blue.svg)](#license)

---

## Overview

Areion (Isobe et al., [TCHES 2023](https://doi.org/10.46586/tches.v2023.i2.115-154); extended version [ePrint 2023/794](https://eprint.iacr.org/2023/794)) is a family of 256-bit (10-round) and 512-bit (15-round) cryptographic permutations built from hardware AES round instructions (`AESENC` / `AESE`).

- **Permutations (`P1` and `P2`, Forward & Inverse)**: 256-bit and 512-bit forward and inverse permutations `P1 / P1⁻¹` (Table 1, π words `0..14`) and domain-separated second permutations `P2 / P2⁻¹` (Table 2, π words `15..29`; see [`scripts/verify_p2_table.py`](scripts/README.md)).
- **Davies-Meyer Short-Input Compression (`areion_dm256`, `areion_dm512`)**: Fixed-input compression functions producing a 256-bit (32-byte) digest from a 32-byte or 64-byte block (Section 4.1.1 of [ePrint 2023/794](https://eprint.iacr.org/2023/794)).
- **Beyond-Birthday-Bound PRFs (`SoEM22`)**: 256-bit and 512-bit Sum of Even-Mansour pseudorandom functions `P1(M ⊕ K1) ⊕ P2(M ⊕ K2) ⊕ K1 ⊕ K2` ([Chen, Lambooij, and Mennink, CRYPTO 2019](https://eprint.iacr.org/2019/554)), secure up to `2^(2n/3)` queries in the ideal-permutation model.
- **Invertible Wide-Block Ciphers (`EM`, `EM2`, `TEM`, `TEM2`)**: Four 256-bit and 512-bit wide-block cipher families — 1-round Even-Mansour (`EM`, birthday-bound PRP), 2-round Even-Mansour (`EM2`, BBB `2^(2n/3)` PRP), 1-round Tweakable Even-Mansour (`TEM`, birthday-bound TPRP), and 2-round Tweakable Even-Mansour (`TEM2`, BBB `2^(2n/3)` TPRP).
- **`ASURA` 256-Bit Tweakable Block Cipher** ([Isobe et al., INDOCRYPT 2024, LNCS vol. 15495](https://doi.org/10.1007/978-3-031-80308-6_7)): 256-bit (32 B) block, 256-bit (32 B) key, 128-bit (16 B) tweak, 12 rounds + final half-round, provided in three operating modes: pre-expanded round tweakeys (`areion_asura_expand_tweakey`, `areion_wipe_asura_tweakey`, `areion_asura_encrypt`, `areion_asura_decrypt`, `areion_asura_encryptx4`, `areion_asura_decryptx4`), pre-expanded session key with on-the-fly tweak (`areion_asura_expand_key`, `areion_wipe_asura_key`, `areion_asura_encrypt_rk`, `areion_asura_decrypt_rk`, `areion_asura_encryptx4_rk`, `areion_asura_decryptx4_rk`), and zero-RAM-state full on-the-fly (`OTF`) mode (`areion_asura_encrypt_otf`, `areion_asura_decrypt_otf`, `areion_asura_encryptx4_otf`, `areion_asura_decryptx4_otf`).
- **4-Way Parallel SIMD Batching (`×4`)**: Batched `×4` entry points across all permutations, `SoEM22` PRFs, `EM / EM2 / TEM / TEM2` wide-block ciphers, and `ASURA`.
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
| **[`ASURA` Tweakable Block Cipher](API.md#6-asura-256-bit-tweakable-block-cipher-indocrypt-2024)** | `areion_asura_expand_{tweakey,key}`, `areion_wipe_asura_{tweakey,key}`, `areion_asura_{encrypt,decrypt}{,x4}{,_rk,_otf}` | 32 / 128 B | 32 B | 16 B | 12-round 256-bit tweakable block cipher (INDOCRYPT 2024) in pre-expanded `rtk[13][32]`, hybrid `rk[13][32]` + OTF tweak (`_rk`), and zero-RAM-state (`_otf`) modes (single-block & 4-way batches) |
| **[AES-128 & Rounds](API.md#7-low-level-aes-128--round-primitives)** | `areion_{inv_,}{,final_}round{,_hw,4_hw}`, `areion_inv_mix_columns`, `areion_aes{128,}_{,final_}round{,4}{,_hw}`, `areion_xor_block{,4}`, `areion_{expand,wipe_expanded}_key128`, `areion_aes128_encrypt{_block,4_blocks}` | 16 / 64 B | 16 B | — | Word-level and byte-level hardware-dispatched / software AES-128 round primitives, key schedule expansion/wipe, and block encryption |
| **[Runtime, CAST & Zeroize](API.md#8-runtime-dispatch-self-test-and-memory-zeroization)** | `areion_tier{,_code,_supported}`, `areion_set_tier{,_override}`, `areion_use_hardware_acceleration`, `areion_selftest`, `areion_zeroize` | — | — | — | Runtime tier introspection/override, FIPS 140-3 Known-Answer Self-Test (CAST), and DSE-safe zeroization |

> **Pre-C23 `const` 2D-Array Ergonomics & SUPERCOP Wrappers:** [`areion.h`](areion.h) provides C11 `_Generic` wrapper macros (`AREION_CONST_U8_{16,32,64,128}`) so callers can pass non-`const` 2D arrays (such as `uint8_t keys[4][64]` or `uint8_t rtk[13][32]`) to `×4` batch and `ASURA` functions without `-Wpedantic` diagnostics in C99 / C11 / C17 while keeping `&func` function-pointer expressions intact. See [Section 9](API.md#9-pre-c23-_generic-multi-dimensional-const-array-macros) and [Section 10 (`supercop/`)](API.md#10-supercop-ebacs-c99-wrappers-supercop) of [`API.md`](API.md) for details.

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

### Round Constants (`P1` and `P2`)
Table 2 (`P2`) is proposed by Andrey Kuvshinov and derived by [`scripts/verify_p2_table.py`](scripts/README.md). Following the Nothing-Up-My-Sleeve (NUMS) methodology of the original Areion paper, it continues the same stream of π words:
- **Table 1 (`P1`)**: Words 0..14 of the fractional part of π (Table 1 and Appendix A.1 of ePrint 2023/794); RC7 is kept as published, `0x801f2e2858efc16636920d871574e690`, a one-nibble shift from π word 7.
- **Table 2 (`P2`)**: Words 15..29 of the fractional part of π (15 consecutive 128-bit words); RC7, π word 22, takes the same one-nibble shift, `0xf6d6ff383f442392e0b4482a48420040`, in agreement with the Areion authors. Words 7 and 22 are the only words among 0..29 that begin with a zero nibble, so the shift falls on RC7 in both tables. The shift is a matter of consistency with Table 1: every claim of [`everanium/areion/analysis/`](https://github.com/everanium/areion/blob/main/analysis/README.md) holds for both forms of this word.

The 15 hexadecimal entries of Table 1 (`P1`) and Table 2 (`P2`) (each stored in memory as 16 little-endian bytes; e.g., round 0 of `P1` begins with bytes `44 73 70 03` and round 0 of `P2` begins with bytes `93 e9 72 7c`; Areion-256 uses rounds 0..9 and Areion-512 uses rounds 0..14):

| Round | Hexadecimal constant (`P1`) | Hexadecimal constant (`P2`) |
| ---: | :--- | :--- |
| 0 | `243f6a8885a308d313198a2e03707344` | `b4cc5c341141e8cea15486af7c72e993` |
| 1 | `a4093822299f31d0082efa98ec4e6c89` | `b3ee1411636fbc2a2ba9c55d741831f6` |
| 2 | `452821e638d01377be5466cf34e90c6c` | `ce5c3e169b87931eafd6ba336c24cf5c` |
| 3 | `c0ac29b7c97c50dd3f84d5b5b5470917` | `7a325381289586773b8f48986b4bb9af` |
| 4 | `9216d5d98979fb1bd1310ba698dfb5ac` | `c4bfe81b6628219361d809ccfb21a991` |
| 5 | `2ffd72dbd01adfb7b8e1afed6a267e96` | `487cac605dec8032ef845d5de98575b1` |
| 6 | `ba7c9045f12c7f9924a19947b3916cf7` | `dc262302eb651b8823893e81d396acc5` |
| 7 | `801f2e2858efc16636920d871574e690` | `f6d6ff383f442392e0b4482a48420040` |
| 8 | `a458fea3f4933d7e0d95748f728eb658` | `69c8f04a9e1f9b5e21c66842f6e96c9a` |
| 9 | `718bcd5882154aee7b54a41dc25a59b5` | `670c9c61abd388f06a51a0d2d8542f68` |
| 10 | `9c30d5392af26013c5d1b023286085f0` | `960fa728ab5133a36eef0b6c137a3be4` |
| 11 | `ca417918b8db38ef8e79dcb0603a180e` | `ba3bf0507efb2a98a1f1651d39af0176` |
| 12 | `6c9e0e8bb01e8a3ed71577c1bd314b27` | `66ca593e82430e888cee8619456f9fb4` |
| 13 | `78af2fda55605c60e65525f3aa55ab94` | `7d84a5c33b8b5ebee06f75d885c12073` |
| 14 | `5748986263e8144055ca396a2aab10b6` | `401a449f56c16aa64ed3aa62363f7706` |

[`scripts/verify_p2_table.py`](scripts/README.md) checks:
- All 30 constants are distinct: `|P1 ∩ P2| = 0`.
- Combined matrix `[P1; P2]` has full rank 30 over `GF(2)`.
- Hamming distance between `P1[i]` and `P2[j]` over all 225 pairs: min 50, mean 63.73.
- RC7 of both tables is the π word shifted by one nibble.
- No `P2` word has two equal 32-bit columns.

See [`everanium/areion/analysis/README.md`](https://github.com/everanium/areion/blob/main/analysis/README.md) for the complete SAT/MILP/algebraic cryptanalysis suite evaluating structure tying `P2` to `P1` beyond these constant checks: related-constant differential bounds (at least 154 active S-boxes over 10 rounds of Areion-256 and 240 over 15 rounds of Areion-512 across all key differences `δ = k1 ⊕ k2` in `GF(2)^128`), linear trail bounds (at least 65 and 101 active S-boxes per permutation, or 164 bits on Areion-512 with the two-S-box chain in `F3` weighted at its exact maximum), boomerang estimates, byte-structured symmetries and affine equivalences, BCLR invariant subspaces and weak cosets, impossible differentials, integral sums to order 5, an 11-level perturbation dissolution ladder (`L0..L4p`), forward-backward cross-composition `P2⁻¹ ∘ P1` and turnaround conservation laws, and state-clearing overhead measurements.

### ASURA 256-Bit Tweakable Block Cipher (INDOCRYPT 2024)

**`ASURA`** ([Tanaka, Shiba, Sakamoto, Rahman, Shiraya, and Isobe, INDOCRYPT 2024, LNCS vol. 15495](https://doi.org/10.1007/978-3-031-80308-6_7)) is a 256-bit (32-byte) tweakable block cipher parameterized by a 256-bit (32-byte) secret key `K = k0 || k1` and a 128-bit (16-byte) public tweak `T`, operating over 12 rounds (`6` double-round steps plus a final half-round):

- **2-Branch Round Structure (`F_gamma` and `F_delta`)**: The 256-bit state `X = x0 || x1` (`|x0| = |x1| = 128` bits) is processed in 6 double-round steps (`r = 0..5`). Each step applies two 128-bit AES rounds per branch:
  - Branch 0 (`x0`, `F_gamma`): `R_core(R_core(x0 ⊕ rtk[2r][0:16]) ⊕ rtk[2r+1][0:16])`, where `R_core = InvMixColumns ∘ ShiftRows ∘ SubBytes` (`AESDECLAST` + `AESIMC` on x86-64; `AESE` + `AESIMC` on ARM64) and the second sub-round is a standard forward AES round `MixColumns ∘ ShiftRows ∘ SubBytes` (`AESENC` / `AESE` + `AESMC`).
  - Branch 1 (`x1`, `F_delta`): `R_core(R_core(x1 ⊕ rtk[2r][16:32]) ⊕ rtk[2r+1][16:32])`, applying `R_core` in both sub-rounds.
  - After steps `r = 0..4`, the two 128-bit branches are mixed by the 32-byte byte-unzipping permutation `perm256` (`(x0', x1') = (even_bytes(x0 || x1), odd_bytes(x0 || x1))`, mapped directly to `UZP1.16B` / `UZP2.16B` on ARM64 and `VPSHUFB` + `VPUNPCKLQDQ` / `VPUNPCKHQDQ` on x86-64), and its inverse byte-zipping permutation `perm256⁻¹` (`ZIP1.16B` / `ZIP2.16B` on ARM64; `VPUNPCKLBW` / `VPUNPCKHBW` on x86-64) during decryption. Step `r = 5` omits `perm256` and finishes with final whitening `x0 ⊕ rtk[12][0:16] || x1 ⊕ rtk[12][16:32]`.
- **Tweakey Schedule (`theta` + `kappa` and `RC[0..12]`)**: The 13 256-bit round tweakeys `rtk[0..12]` (`uint8_t rtk[13][32]`, 416 bytes) are derived as `rtk[j] = (T_j ⊕ K_j[0:16] ⊕ RC[j]) || (T_j ⊕ K_j[16:32])` for `j = 0..12`, where `RC[0..12]` are the first 13 128-bit Haraka v2 round constants (stored in little-endian byte order), `theta` updates the 16-byte tweak state via one unkeyed AES encryption round (`T_{j+1} = AESENC(T_j, 0)`), and `kappa` permutes the 32 key bytes via `areion_asura_kappa_perm` followed by byte-wise `GF(2^8)` multiplication by `0x02` (`xtime`, polynomial `x^8 + x^4 + x^3 + x + 1`, `0x1b`; inverted via `areion_asura_inv_kappa_perm` and multiplication by `0x8d` when needed).
- **Equivalent Inverse Cipher Decryption & In-Register Tweakey Processing**: On `F_delta⁻¹` (`x1`), two consecutive `(SubBytes⁻¹ ∘ ShiftRows⁻¹ ∘ MixColumns)` layers separated by `⊕ k_odd` are collapsed via the Equivalent Inverse Cipher identity `MixColumns(x1) ⊕ k_odd = MixColumns(x1 ⊕ InvMixColumns(k_odd))`, folding `MixColumns` (`MC`) into the odd-round tweakeys (`AESDECLAST` + `AESENC` on x86-64; `AESMC` on ARM64). In on-the-fly decryption (`areion_asura_decrypt_otf`, `areion_asura_decryptx4_otf`, `areion_asura_decrypt_rk`, `areion_asura_decryptx4_rk`), all round tweakeys and per-block tweak states are held strictly in SIMD/GPR registers (`0`-byte stack frame on SysV `x86-64` and `arm64`) across the 6 decryption steps and wiped before returning.

#### ASURA Operating Modes (`rtk`, `rk + OTF-Tweak`, and `OTF`)

Because the `ASURA` tweakey schedule is linear over `GF(2)` with respect to the key schedule (`kappa`, `RC`) and the tweak schedule (`theta`), `rtk[j]` decomposes into a tweak-independent session key schedule `rk[j] = (K_j[0:16] ⊕ RC[j]) || K_j[16:32]` and an on-the-fly tweak stream `T_j = theta^j(T)`:

| Mode | Exported Functions (`areion.h`) | Pre-Expanded State | Per-Call Schedule Work | Target Workload |
| :--- | :--- | :---: | :--- | :--- |
| **1. Pre-Expanded Tweakey (`rtk`)** | `areion_asura_expand_tweakey`, `areion_wipe_asura_tweakey`, `areion_asura_{encrypt,decrypt}{,x4}` | `uint8_t rtk[13][32]` (`416 B` per `(key, tweak)`) | None (`0` `theta`, `0` `kappa`) | Multiple blocks sharing an identical `(key, tweak)` pair |
| **2. Hybrid Session Key + OTF Tweak (`rk`)** | `areion_asura_expand_key`, `areion_wipe_asura_key`, `areion_asura_{encrypt,decrypt}{,x4}_rk` | `uint8_t rk[13][32]` (`416 B` per session `key`) | `12` `theta` (`AESENC`) steps (`0` `kappa`) | Fixed session key where the 128-bit `tweak` (nonce/counter/sector) changes every block (including 4 independent `tweaks[4][16]` in `×4` batches) |
| **3. Full On-The-Fly (`OTF`)** | `areion_asura_{encrypt,decrypt}{,x4}_otf` | `0 B` in RAM | `12` `theta` + `12` `kappa` steps in registers | Stateless single-shot calls or memory-constrained environments where both `key` and `tweak` / `tweaks[4][16]` vary |

Callers using Mode 1 (`rtk`) or Mode 2 (`rk`) should scrub the expanded schedule via `areion_wipe_asura_tweakey(rtk)` or `areion_wipe_asura_key(rk)` when the session or tweak context ends.

### Comparison with 128-bit Block Cipher PRP-as-PRF Bounds
Standard AES-128 and AES-256 operate on 128-bit blocks as pseudorandom permutations (PRPs); used directly as a PRF, any 128-bit permutation is distinguishable from a random function after about `2^64` distinct queries via birthday non-collision. The `areion_soem256` and `areion_soem512` interfaces instead accept 256-bit and 512-bit inputs with 512-bit and 1024-bit keys (`2n` bits), providing `2n/3`-bit ideal-permutation PRF bounds (up to `2^170.7` and `2^341.3` queries) while executing directly on native hardware AES round instructions.

---

## Hardware Acceleration & ABI Support

`libareion` automatically detects host CPU features and OS SIMD context support (`CPUID` + `XGETBV` on `x86-64`, `getauxval(AT_HWCAP)` / `sysctlbyname` on `arm64`):

| Tier | Architectures | Instructions Used | Register Width (`×4` functions) |
| :--- | :--- | :--- | :--- |
| **`avx512`** | Intel Ice Lake, Tiger Lake, Rocket Lake, Xeon Ice Lake-SP+; AMD Zen 4+ (`AVX-512F + AVX-512DQ + AVX-512BW + AVX-512VL + VAES`) | `VAESENC`, `VAESENCLAST`, `VAESDEC`, `VAESDECLAST`, `VPXORD`, `VSHUFI64X2`, `VINSERTI64X4`, `VEXTRACTI64X4` (2-instruction `VAESENCLAST` + `VAESDEC` 512-bit `InvMixColumns`) | 512-bit ZMM (4 AES blocks) |
| **`vaesavx2`** | Intel Alder Lake+ (no AVX-512); AMD Zen 3 (`AVX2 + VAES`) | `VAESENC`, `VAESENCLAST`, `VAESDEC`, `VAESDECLAST`, `VPXOR`, `VPERM2I128`, `VINSERTI128` (2-instruction `VAESENCLAST` + `VAESDEC` 256-bit `InvMixColumns`) | 256-bit YMM (2 AES blocks / reg, up to 4 lanes in `ymm0..ymm7`) |
| **`vex`** | Intel Sandy Bridge+, AMD Bulldozer+ (`AVX + AES-NI`) | 3-operand VEX XMM `VAESENC`, `VAESENCLAST`, `VAESDECLAST`, `VAESIMC`, `VAESKEYGENASSIST`, `VPXOR`, `VPUNPCKLQDQ`, `VPUNPCKHQDQ`, `VPSHUFD` | 128-bit XMM (3-operand VEX) |
| **`aesni`** | Intel Westmere+ (`AES-NI` without `AVX`) | Legacy SSE `AESENC`, `AESENCLAST`, `AESDECLAST`, `AESIMC`, `AESKEYGENASSIST`, `PXOR`, `PUNPCKLQDQ`, `PUNPCKHQDQ`, `PSHUFD` | 128-bit XMM (2-operand SSE) |
| **`arm64`** | ARMv8 with Cryptographic Extension, Apple Silicon, Graviton (`NEON + AES`) | `AESE`, `AESMC`, `AESD`, `AESIMC`, `EOR`, `TRN1`, `TRN2` | 128-bit NEON (up to 4 lanes in `v0..v31`) |
| **`purec`** | All architectures — verified across 9 `qemu-*-static` targets (`aarch64`, `riscv64`, `s390x` 64-bit BE, `ppc64le`, `arm` 32-bit, `i386` 32-bit, `mips64` 64-bit BE, `mips` 32-bit BE, `loongarch64`) plus native `x86-64` | Constant-time 64-bit bitsliced Boyar–Peralta forward/inverse S-boxes & maskless linear layer | 64-bit bitsliced software (up to 4 blocks/word) |

> **Note on single-block and 4-way fused execution:** Single-block primitives (`areion_permute*`, `areion_dm*`, `areion_soem*`, `areion_em_*`, `areion_em2_*`, `areion_tem_*`, `areion_tem2_*`, `areion_asura_*`) operate on 128-bit XMM registers (`x86-64`) or 128-bit NEON registers (`arm64`); on `x86-64` systems with AVX (`vex`, `vaesavx2`, `avx512`), they use 3-operand VEX instructions (`VAESENC`) to eliminate `MOVAPS` register-copy overhead, falling back to 2-operand `AESENC` only on Westmere (`aesni`). Both single-block and 4-way batched (`×4`) primitives (`SoEM22`, `EM`, `EM2`, `TEM`, `TEM2`, `ASURA`) execute inside dedicated fused assembly kernels (`areion_amd64.S`, `areion_soem256_amd64.S`, `areion_soem512_amd64.S`, `areion_soem_aesni_amd64.S`, `asura_amd64.S`, `areion_arm64.S`, `asura_arm64.S`, `msvc/*.asm`) without intermediate stack round-trips or redundant Structure-of-Arrays (SoA) transpositions.

> **Cross-OS & Cross-Assembler Support:**
> - **GNU GAS / Clang Integrated Assembler (`.S`)**: Supports Linux ELF (`x86_64`, `aarch64`), macOS Mach-O (`x86_64`, `arm64`), and Windows MinGW-w64 COFF (`x86_64`) via `asm_abi.h` (including automatic Windows x64 `XMM6..XMM15` non-volatile save/restore and parameter register remapping).
> - **Microsoft Visual Studio (`msvc/*.asm`)**: Pre-generated MASM (`ml64.exe`) and ARMASM64 (`armasm64.exe`) sources selected automatically by `CMakeLists.txt` when building with MSVC.

> **Register and stack zeroization:** All hardware assembly kernels (both single-block and `×4` batch functions) execute directly in registers with zero secret stack spills (zero-byte stack frame on SysV `x86-64` and `arm64`, no intermediate AoS↔SoA stack buffers) and clear all touched vector registers (`PXOR` / `VPXOR` / `VPXORD` on `X0..X30` plus `VZEROUPPER` on `x86-64`; `VEOR` on `V0..V31` on `arm64`) and scratch general-purpose registers before returning. On `purec` fallback paths, C routines scrub local buffers via DSE-resistant `areion_secure_wipe` (`volatile uint8_t *` + compiler barrier), scrub their software stack frame (`areion_wipe_software_stack`), and clobber volatile scratch GPRs (`areion_clobber_scratch_gprs`). Verified across all tiers by `areion_zeroize_test.c` (with mandatory negative controls); see [`everanium/areion/analysis/README.md` (Section L)](https://github.com/everanium/areion/blob/main/analysis/README.md#l-register-and-stack-clearing-cost) for instruction-count and cycle-per-byte overhead measurements.

---

## Benchmarks

### 1. Intel® Core™ i7-11700K @ 3.60GHz (Rocket Lake, x86-64)

3-run averaged throughput and latency comparison across all 5 execution tiers on the same physical CPU (generated via `python3 scripts/run_bench.py`; reference cycles per byte `c = f · t / B` at `f = 3.60 GHz` reach `0.32 c/B` on `areion_permute512x4` / `areion_permute512_p2x4`, `0.58 c/B` on `areion_inverse_permute512x4` / `areion_inverse_permute512_p2x4`, `0.45` / `0.56 c/B` on `areion_soem256x4` / `areion_soem512x4`, and `0.26 c/B` on `areion_em_encrypt256x4` / `areion_em_encrypt512x4`):

#### Core Permutations, Davies-Meyer, SoEM22 & AES-128 Primitives (MB/s, ns/op)

| Operation | `purec` | `aesni` | `vex` | `vaesavx2` | `avx512` | `c/B` (best) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **`areion_permute256`** | 37.3 (858.86 ns) | 2,087.3 (15.33 ns) | 2,127.9 (15.04 ns) | 2,131.8 (15.01 ns) | 2,135.9 (14.98 ns) | 1.69 |
| **`areion_permute512`** | 51.4 (1,245.90 ns) | 4,064.1 (15.75 ns) | 4,043.5 (15.83 ns) | 4,035.2 (15.86 ns) | 4,054.6 (15.78 ns) | 0.89 |
| **`areion_inverse_permute256`** | 39.9 (802.29 ns) | 1,471.0 (21.75 ns) | 1,478.6 (21.64 ns) | 1,468.4 (21.79 ns) | 1,474.4 (21.70 ns) | 2.43 |
| **`areion_inverse_permute512`** | 39.2 (1,634.09 ns) | 1,733.0 (36.93 ns) | 1,736.9 (36.85 ns) | 1,730.2 (36.99 ns) | 1,734.4 (36.90 ns) | 2.07 |
| **`areion_permute256_p2`** | 36.9 (867.75 ns) | 2,085.3 (15.34 ns) | 2,130.6 (15.02 ns) | 2,125.1 (15.06 ns) | 2,131.3 (15.01 ns) | 1.69 |
| **`areion_permute512_p2`** | 49.8 (1,287.39 ns) | 4,093.1 (15.64 ns) | 4,068.2 (15.73 ns) | 4,066.8 (15.74 ns) | 4,064.5 (15.75 ns) | 0.88 |
| **`areion_inverse_permute256_p2`** | 39.7 (809.17 ns) | 1,478.5 (21.64 ns) | 1,475.9 (21.68 ns) | 1,477.9 (21.65 ns) | 1,473.9 (21.71 ns) | 2.43 |
| **`areion_inverse_permute512_p2`** | 38.1 (1,679.73 ns) | 1,725.8 (37.09 ns) | 1,736.7 (36.85 ns) | 1,729.0 (37.02 ns) | 1,730.9 (36.98 ns) | 2.07 |
| **`areion_dm256`** | 37.7 (850.89 ns) | 5,512.9 (5.81 ns) | 5,638.8 (5.89 ns) | 5,852.8 (5.53 ns) | 6,048.6 (5.32 ns) | 0.60 |
| **`areion_dm512`** | 52.7 (1,216.78 ns) | 5,247.0 (12.32 ns) | 5,564.2 (11.53 ns) | 5,764.0 (11.11 ns) | 5,621.4 (11.39 ns) | 0.62 |
| **`areion_soem256`** | 35.6 (898.71 ns) | 2,910.7 (11.00 ns) | 3,025.0 (10.60 ns) | 3,028.5 (10.58 ns) | 3,057.5 (10.47 ns) | 1.18 |
| **`areion_soem512`** | 46.6 (1,382.82 ns) | 2,923.8 (21.93 ns) | 2,944.1 (21.75 ns) | 2,994.4 (21.40 ns) | 3,140.5 (20.38 ns) | 1.15 |
| **`areion_permute256x4`** | 141.7 (904.08 ns) | 7,052.1 (18.21 ns) | 6,873.1 (18.63 ns) | 7,395.5 (17.31 ns) | 6,732.1 (19.01 ns) | 0.49 |
| **`areion_permute512x4`** | 153.9 (1,664.74 ns) | 6,697.2 (38.36 ns) | 6,985.7 (36.66 ns) | 10,918.7 (23.54 ns) | 11,154.2 (22.96 ns) | 0.32 |
| **`areion_inverse_permute256x4`** | 141.4 (907.85 ns) | 5,425.1 (23.61 ns) | 5,549.9 (23.07 ns) | 5,339.5 (23.97 ns) | 5,054.8 (25.32 ns) | 0.65 |
| **`areion_inverse_permute512x4`** | 127.4 (2,010.35 ns) | 3,644.3 (70.26 ns) | 3,826.4 (66.92 ns) | 5,385.0 (47.94 ns) | 6,248.6 (40.97 ns) | 0.58 |
| **`areion_permute256_p2x4`** | 137.8 (930.42 ns) | 6,899.5 (18.60 ns) | 6,579.0 (19.48 ns) | 7,428.6 (17.23 ns) | 6,732.5 (19.01 ns) | 0.48 |
| **`areion_permute512_p2x4`** | 144.3 (1,776.67 ns) | 6,636.7 (38.59 ns) | 7,111.2 (36.02 ns) | 10,977.3 (23.33 ns) | 11,291.1 (22.67 ns) | 0.32 |
| **`areion_inverse_permute256_p2x4`** | 151.9 (843.20 ns) | 5,355.0 (23.92 ns) | 5,522.9 (23.18 ns) | 5,338.3 (23.98 ns) | 5,082.5 (25.19 ns) | 0.65 |
| **`areion_inverse_permute512_p2x4`** | 121.7 (2,104.11 ns) | 3,660.2 (69.97 ns) | 3,836.5 (66.73 ns) | 5,728.2 (44.76 ns) | 6,253.9 (40.93 ns) | 0.58 |
| **`areion_soem256x4`** | 72.5 (1,766.66 ns) | 3,797.9 (33.86 ns) | 3,967.2 (32.27 ns) | 6,142.5 (20.93 ns) | 7,952.7 (16.14 ns) | 0.45 |
| **`areion_soem512x4`** | 72.3 (3,566.48 ns) | 2,604.4 (98.45 ns) | 3,155.3 (81.27 ns) | 5,843.3 (43.86 ns) | 6,425.2 (39.87 ns) | 0.56 |
| **`areion_aes128_round`** | 116.1 (139.15 ns) | 6,067.3 (2.65 ns) | 6,455.7 (2.48 ns) | 6,126.4 (2.62 ns) | 6,299.4 (2.54 ns) | 0.56 |
| **`areion_aes128_round4`** | 398.2 (160.72 ns) | 12,548.4 (5.10 ns) | 12,770.3 (5.02 ns) | 12,710.3 (5.04 ns) | 13,259.2 (4.83 ns) | 0.27 |
| **`areion_expand_key128`** | 594.4 (296.60 ns) | 4,721.8 (37.30 ns) | 4,830.2 (36.45 ns) | 4,779.6 (36.86 ns) | 4,629.7 (38.04 ns) | 0.75 |
| **`areion_aes128_encrypt_block`** | 30.0 (534.05 ns) | 1,903.2 (8.41 ns) | 1,898.5 (8.43 ns) | 1,911.9 (8.37 ns) | 1,899.6 (8.42 ns) | 1.88 |
| **`areion_aes128_encrypt4_blocks`** | 126.5 (506.04 ns) | 7,291.1 (8.78 ns) | 7,105.3 (9.01 ns) | 7,353.3 (8.70 ns) | 7,383.8 (8.67 ns) | 0.49 |

#### Wide-Block Ciphers (`EM`, `EM2`, `TEM`, `TEM2`) & `ASURA` vs. `Rijndael-256` & `Vistrutah-256/512` (MB/s, ns/op)

| Operation | `purec` | `aesni` | `vex` | `vaesavx2` | `avx512` | `c/B` (best) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **`areion_em_encrypt256`** | 36.6 (874.59 ns) | 4,548.9 (7.14 ns) | 5,136.7 (6.30 ns) | 5,695.4 (5.68 ns) | 5,744.7 (5.58 ns) | 0.63 |
| **`areion_em_decrypt256`** | 37.6 (853.52 ns) | 3,979.9 (8.05 ns) | 4,441.0 (7.25 ns) | 4,310.0 (7.44 ns) | 4,385.0 (7.31 ns) | 0.82 |
| **`areion_em_encrypt512`** | 51.2 (1,251.40 ns) | 5,039.2 (12.72 ns) | 5,114.4 (12.54 ns) | 5,518.5 (11.61 ns) | 5,588.2 (11.46 ns) | 0.64 |
| **`areion_em_decrypt512`** | 37.3 (1,722.77 ns) | 2,765.6 (23.16 ns) | 2,811.3 (22.79 ns) | 2,755.4 (23.24 ns) | 2,875.5 (22.27 ns) | 1.25 |
| **`areion_em2_encrypt256`** | 19.5 (1,640.20 ns) | 2,130.7 (15.03 ns) | 2,185.0 (14.68 ns) | 2,220.7 (14.47 ns) | 2,265.7 (14.13 ns) | 1.59 |
| **`areion_em2_decrypt256`** | 20.7 (1,552.37 ns) | 1,627.3 (19.69 ns) | 1,598.6 (20.04 ns) | 1,664.5 (19.23 ns) | 1,608.0 (19.95 ns) | 2.16 |
| **`areion_em2_encrypt512`** | 26.5 (2,424.97 ns) | 2,382.2 (26.87 ns) | 2,417.6 (26.47 ns) | 2,360.6 (27.13 ns) | 2,312.8 (27.68 ns) | 1.49 |
| **`areion_em2_decrypt512`** | 19.8 (3,236.17 ns) | 1,031.9 (62.02 ns) | 1,082.6 (59.12 ns) | 1,065.9 (60.06 ns) | 1,082.7 (59.15 ns) | 3.33 |
| **`areion_tem_encrypt256`** | 19.2 (1,662.21 ns) | 2,188.9 (14.62 ns) | 2,318.2 (13.81 ns) | 2,216.4 (14.45 ns) | 2,192.3 (14.64 ns) | 1.55 |
| **`areion_tem_decrypt256`** | 19.3 (1,660.74 ns) | 1,935.1 (16.58 ns) | 2,011.1 (15.96 ns) | 1,970.4 (16.27 ns) | 2,045.4 (15.65 ns) | 1.76 |
| **`areion_tem_encrypt512`** | 26.6 (2,416.33 ns) | 2,279.7 (28.15 ns) | 2,328.7 (27.48 ns) | 2,257.2 (28.37 ns) | 2,305.7 (27.77 ns) | 1.55 |
| **`areion_tem_decrypt512`** | 22.7 (2,832.90 ns) | 1,580.2 (40.53 ns) | 1,612.7 (39.72 ns) | 1,607.5 (39.82 ns) | 1,586.1 (40.38 ns) | 2.23 |
| **`areion_tem2_encrypt256`** | 12.6 (2,537.32 ns) | 1,118.5 (28.61 ns) | 1,112.2 (28.83 ns) | 1,153.0 (27.76 ns) | 1,111.1 (28.82 ns) | 3.12 |
| **`areion_tem2_decrypt256`** | 13.8 (2,322.53 ns) | 861.5 (37.23 ns) | 841.6 (38.12 ns) | 859.4 (37.33 ns) | 857.0 (37.42 ns) | 4.19 |
| **`areion_tem2_encrypt512`** | 18.0 (3,565.41 ns) | 1,302.5 (49.20 ns) | 1,332.3 (48.05 ns) | 1,362.9 (46.96 ns) | 1,302.0 (49.16 ns) | 2.64 |
| **`areion_tem2_decrypt512`** | 13.4 (4,799.69 ns) | 765.6 (83.60 ns) | 768.5 (83.28 ns) | 761.0 (84.11 ns) | 769.0 (83.24 ns) | 4.68 |
| **`areion_em_encrypt256x4`** | 136.4 (940.35 ns) | 7,092.2 (18.14 ns) | 7,692.6 (16.65 ns) | 10,818.6 (11.90 ns) | 13,961.2 (9.29 ns) | 0.26 |
| **`areion_em_decrypt256x4`** | 144.2 (888.27 ns) | 6,283.4 (20.38 ns) | 6,526.6 (19.63 ns) | 8,950.4 (14.34 ns) | 11,907.6 (10.80 ns) | 0.30 |
| **`areion_em_encrypt512x4`** | 150.2 (1,707.56 ns) | 6,224.5 (41.14 ns) | 6,830.9 (37.49 ns) | 10,745.0 (23.85 ns) | 13,952.4 (18.37 ns) | 0.26 |
| **`areion_em_decrypt512x4`** | 120.0 (2,135.47 ns) | 3,556.1 (71.99 ns) | 3,696.0 (69.26 ns) | 6,406.7 (39.96 ns) | 8,134.3 (31.48 ns) | 0.44 |
| **`areion_em2_encrypt256x4`** | 73.0 (1,757.36 ns) | 3,561.1 (36.17 ns) | 3,632.3 (35.27 ns) | 4,152.0 (30.86 ns) | 6,354.7 (20.17 ns) | 0.57 |
| **`areion_em2_decrypt256x4`** | 80.7 (1,585.94 ns) | 2,929.5 (43.70 ns) | 3,051.5 (41.95 ns) | 3,207.4 (39.91 ns) | 5,585.0 (22.94 ns) | 0.65 |
| **`areion_em2_encrypt512x4`** | 75.5 (3,392.27 ns) | 2,820.5 (90.96 ns) | 3,318.5 (77.17 ns) | 4,611.5 (55.53 ns) | 6,752.2 (37.99 ns) | 0.53 |
| **`areion_em2_decrypt512x4`** | 61.8 (4,161.17 ns) | 1,666.7 (153.64 ns) | 1,723.0 (148.59 ns) | 2,140.1 (119.66 ns) | 3,670.7 (69.75 ns) | 0.98 |
| **`areion_tem_encrypt256x4`** | 73.8 (1,735.93 ns) | 3,557.8 (35.99 ns) | 3,618.2 (35.43 ns) | 4,274.9 (30.01 ns) | 6,322.2 (20.33 ns) | 0.57 |
| **`areion_tem_decrypt256x4`** | 76.0 (1,685.89 ns) | 2,980.0 (43.11 ns) | 3,034.3 (42.19 ns) | 3,823.9 (33.48 ns) | 5,779.2 (22.36 ns) | 0.63 |
| **`areion_tem_encrypt512x4`** | 77.0 (3,335.02 ns) | 2,944.8 (87.89 ns) | 3,251.5 (78.75 ns) | 4,628.3 (55.35 ns) | 6,901.7 (37.13 ns) | 0.52 |
| **`areion_tem_decrypt512x4`** | 69.2 (3,699.74 ns) | 2,216.1 (115.52 ns) | 2,272.7 (112.65 ns) | 3,168.1 (80.83 ns) | 4,934.7 (51.88 ns) | 0.73 |
| **`areion_tem2_encrypt256x4`** | 36.6 (3,496.08 ns) | 1,562.6 (81.93 ns) | 1,545.1 (82.84 ns) | 2,126.2 (60.23 ns) | 3,442.5 (37.21 ns) | 1.05 |
| **`areion_tem2_decrypt256x4`** | 39.3 (3,253.62 ns) | 1,218.5 (105.06 ns) | 1,304.6 (98.16 ns) | 1,697.2 (75.44 ns) | 3,014.9 (42.50 ns) | 1.20 |
| **`areion_tem2_encrypt512x4`** | 39.1 (6,585.59 ns) | 1,280.9 (199.96 ns) | 1,344.3 (190.44 ns) | 2,621.6 (97.68 ns) | 3,531.1 (72.62 ns) | 1.02 |
| **`areion_tem2_decrypt512x4`** | 35.2 (7,289.47 ns) | 743.0 (344.69 ns) | 766.7 (333.97 ns) | 1,460.3 (175.32 ns) | 2,404.3 (106.49 ns) | 1.50 |
| **`areion_asura_expand_tweakey`** | 42.4 (755.34 ns) | 1,428.9 (22.48 ns) | 1,518.9 (21.07 ns) | 1,518.6 (21.08 ns) | 1,461.2 (21.92 ns) | 2.37 |
| **`areion_asura_encrypt`** | 23.1 (1,392.58 ns) | 3,929.3 (8.15 ns) | 3,920.0 (8.16 ns) | 3,856.4 (8.31 ns) | 3,863.4 (8.29 ns) | 0.92 |
| **`areion_asura_decrypt`** | 23.3 (1,378.16 ns) | 2,216.7 (14.50 ns) | 2,219.0 (14.45 ns) | 2,323.3 (13.78 ns) | 2,282.0 (14.02 ns) | 1.55 |
| **`areion_asura_encryptx4`** | 55.9 (2,298.69 ns) | 5,451.3 (23.49 ns) | 5,024.8 (25.50 ns) | 7,291.4 (17.59 ns) | 10,686.1 (11.98 ns) | 0.34 |
| **`areion_asura_decryptx4`** | 61.9 (2,068.39 ns) | 3,750.4 (34.13 ns) | 3,752.6 (34.12 ns) | 5,118.5 (25.02 ns) | 7,258.9 (17.64 ns) | 0.50 |
| **`areion_asura_encrypt_otf`** | 16.2 (1,973.49 ns) | 1,096.4 (29.25 ns) | 1,157.4 (27.66 ns) | 1,147.3 (27.89 ns) | 1,168.6 (27.39 ns) | 3.08 |
| **`areion_asura_decrypt_otf`** | 11.4 (2,810.51 ns) | 523.1 (61.41 ns) | 705.7 (45.35 ns) | 706.5 (45.29 ns) | 700.8 (45.66 ns) | 5.10 |
| **`areion_asura_encryptx4_otf`** | 42.2 (3,035.16 ns) | 2,323.8 (55.10 ns) | 2,401.4 (53.30 ns) | 3,418.3 (37.45 ns) | 2,860.6 (44.75 ns) | 1.05 |
| **`areion_asura_decryptx4_otf`** | 34.8 (3,671.59 ns) | 1,307.1 (97.94 ns) | 1,322.8 (96.81 ns) | 1,786.6 (71.65 ns) | 2,327.5 (55.00 ns) | 1.55 |
| **`areion_asura_expand_key`** | 78.0 (410.37 ns) | 1,562.8 (20.50 ns) | 1,667.4 (19.20 ns) | 1,696.3 (18.86 ns) | 1,717.8 (18.63 ns) | 2.10 |
| **`areion_asura_encrypt_rk`** | 16.7 (1,922.59 ns) | 2,822.8 (11.35 ns) | 2,717.4 (11.78 ns) | 2,638.5 (12.13 ns) | 2,780.7 (11.51 ns) | 1.28 |
| **`areion_asura_decrypt_rk`** | 18.5 (1,736.12 ns) | 1,484.0 (21.56 ns) | 1,479.4 (21.63 ns) | 1,467.8 (21.81 ns) | 1,501.8 (21.31 ns) | 2.40 |
| **`areion_asura_encryptx4_rk`** | 44.0 (2,913.79 ns) | 3,845.9 (33.33 ns) | 3,931.7 (32.58 ns) | 6,214.7 (20.60 ns) | 8,946.1 (14.31 ns) | 0.40 |
| **`areion_asura_decryptx4_rk`** | 38.2 (3,351.39 ns) | 1,942.1 (65.91 ns) | 2,003.3 (63.90 ns) | 3,006.5 (42.58 ns) | 5,476.4 (23.37 ns) | 0.66 |
| **`Rijndael-256`** | 47.7 (670.96 ns) | 2,265.5 (14.13 ns) | 1,864.1 (17.17 ns) | 1,873.7 (17.08 ns) | 1,852.2 (17.32 ns) | 1.59 |
| **`Rijndael-256x4`** | 115.4 (1,116.96 ns) | 3,764.2 (34.01 ns) | 3,230.7 (39.70 ns) | 4,491.0 (28.52 ns) | 7,546.5 (16.96 ns) | 0.48 |
| **`Vistrutah-256 (10r)`** | 45.8 (698.62 ns) | 4,372.2 (7.33 ns) | 4,483.9 (7.13 ns) | 6,504.4 (4.93 ns) | 6,218.7 (5.18 ns) | 0.55 |
| **`Vistrutah-256 (14r)`** | 34.3 (933.42 ns) | 2,944.1 (10.88 ns) | 2,823.5 (11.34 ns) | 3,852.4 (8.32 ns) | 3,759.3 (8.69 ns) | 0.94 |
| **`Vistrutah-256x4 (10r)`** | 97.0 (1,319.94 ns) | 6,778.3 (18.90 ns) | 6,430.3 (19.98 ns) | 10,168.4 (12.60 ns) | 13,198.3 (9.72 ns) | 0.27 |
| **`Vistrutah-256x4 (14r)`** | 69.5 (1,842.56 ns) | 4,576.6 (28.00 ns) | 4,451.3 (28.79 ns) | 6,598.4 (19.40 ns) | 8,970.8 (14.27 ns) | 0.40 |
| **`Vistrutah-512-256 (10r)`** | 96.5 (663.78 ns) | 4,413.6 (14.53 ns) | 4,752.4 (13.47 ns) | 5,488.8 (11.68 ns) | 4,636.2 (13.84 ns) | 0.66 |
| **`Vistrutah-512-256 (14r)`** | 73.4 (871.72 ns) | 3,086.1 (20.74 ns) | 3,005.4 (21.31 ns) | 3,626.2 (17.71 ns) | 2,786.0 (22.98 ns) | 1.00 |
| **`Vistrutah-512-256 (18r)`** | 61.0 (1,048.87 ns) | 2,242.3 (28.54 ns) | 2,272.8 (28.17 ns) | 2,613.4 (24.50 ns) | 2,068.7 (30.95 ns) | 1.38 |
| **`Vistrutah-512-512 (12r)`** | 84.5 (757.31 ns) | 3,668.5 (17.47 ns) | 3,661.9 (17.48 ns) | 4,434.9 (14.43 ns) | 3,893.3 (16.45 ns) | 0.81 |
| **`Vistrutah-512-512 (18r)`** | 60.5 (1,057.85 ns) | 2,308.4 (27.73 ns) | 2,293.1 (27.91 ns) | 2,655.2 (24.11 ns) | 2,178.8 (29.37 ns) | 1.36 |
| **`Vistrutah-512-256x4 (10r)`** | 107.3 (2,392.92 ns) | 5,156.4 (49.69 ns) | 5,325.0 (48.11 ns) | 9,505.0 (26.99 ns) | 10,781.0 (23.74 ns) | 0.33 |
| **`Vistrutah-512-256x4 (14r)`** | 78.6 (3,266.50 ns) | 3,300.9 (77.58 ns) | 3,369.9 (76.01 ns) | 7,001.9 (36.57 ns) | 7,771.6 (32.94 ns) | 0.46 |
| **`Vistrutah-512-256x4 (18r)`** | 64.0 (4,005.00 ns) | 2,344.1 (109.21 ns) | 2,416.8 (106.14 ns) | 5,423.2 (47.21 ns) | 5,940.7 (43.09 ns) | 0.61 |
| **`Vistrutah-512-512x4 (12r)`** | 96.5 (2,654.03 ns) | 4,133.6 (61.95 ns) | 4,266.4 (60.02 ns) | 8,008.0 (31.98 ns) | 9,639.8 (26.59 ns) | 0.37 |
| **`Vistrutah-512-512x4 (18r)`** | 64.2 (3,990.44 ns) | 2,420.5 (105.79 ns) | 2,453.6 (104.36 ns) | 5,308.4 (48.30 ns) | 6,198.2 (41.30 ns) | 0.58 |

All operations: 0 B/op, 0 allocs/op.

### 2. AWS Graviton 4 (`c8g.4xlarge`, Neoverse-V2, 16 vCPUs, ARM64)

3-run averaged throughput measured on AWS Graviton 4 (`purec` bitsliced fallback vs `arm64` ARMv8 Cryptographic Extension; reference cycles per byte `c = f · t / B` at `f = 2.80 GHz` reach `0.50 c/B` on `areion_permute512x4` / `areion_permute512_p2x4`, `0.57 c/B` on `areion_inverse_permute256x4` / `areion_inverse_permute256_p2x4`, `0.90` / `1.04 c/B` on `areion_soem256x4` / `areion_soem512x4`, and `0.57 c/B` on `areion_em_encrypt512x4`):

#### Core Permutations, Davies-Meyer, SoEM22 & AES-128 Primitives (MB/s, ns/op)

| Operation | `purec` | `arm64` | `c/B` (`arm64`) |
| :--- | :---: | :---: | :---: |
| **`areion_permute256`** | 30.1 (1,064.12 ns) | 1,031.0 (31.04 ns) | 2.72 |
| **`areion_permute512`** | 41.8 (1,531.90 ns) | 1,852.1 (34.56 ns) | 1.51 |
| **`areion_inverse_permute256`** | 31.7 (1,008.97 ns) | 1,342.5 (23.84 ns) | 2.09 |
| **`areion_inverse_permute512`** | 33.1 (1,931.69 ns) | 1,590.4 (40.24 ns) | 1.76 |
| **`areion_permute256_p2`** | 30.1 (1,061.40 ns) | 1,031.0 (31.04 ns) | 2.72 |
| **`areion_permute512_p2`** | 41.8 (1,531.18 ns) | 1,852.4 (34.55 ns) | 1.51 |
| **`areion_inverse_permute256_p2`** | 31.7 (1,009.38 ns) | 1,341.6 (23.85 ns) | 2.09 |
| **`areion_inverse_permute512_p2`** | 33.2 (1,930.67 ns) | 1,590.2 (40.25 ns) | 1.76 |
| **`areion_dm256`** | 30.2 (1,059.85 ns) | 2,442.2 (13.10 ns) | 1.15 |
| **`areion_dm512`** | 40.5 (1,583.42 ns) | 2,351.8 (27.22 ns) | 1.19 |
| **`areion_soem256`** | 29.2 (1,094.47 ns) | 1,167.0 (27.42 ns) | 2.40 |
| **`areion_soem512`** | 40.2 (1,591.39 ns) | 1,628.2 (39.31 ns) | 1.72 |
| **`areion_permute256x4`** | 115.0 (1,113.65 ns) | 4,060.1 (31.53 ns) | 0.69 |
| **`areion_permute512x4`** | 131.5 (1,947.34 ns) | 5,550.7 (46.13 ns) | 0.50 |
| **`areion_inverse_permute256x4`** | 120.3 (1,064.10 ns) | 4,898.3 (26.13 ns) | 0.57 |
| **`areion_inverse_permute512x4`** | 109.4 (2,339.22 ns) | 3,971.9 (64.46 ns) | 0.71 |
| **`areion_permute256_p2x4`** | 114.9 (1,113.63 ns) | 4,058.9 (31.54 ns) | 0.69 |
| **`areion_permute512_p2x4`** | 131.5 (1,947.36 ns) | 5,552.4 (46.11 ns) | 0.50 |
| **`areion_inverse_permute256_p2x4`** | 120.4 (1,062.97 ns) | 4,901.0 (26.12 ns) | 0.57 |
| **`areion_inverse_permute512_p2x4`** | 109.4 (2,339.99 ns) | 3,968.0 (64.52 ns) | 0.71 |
| **`areion_soem256x4`** | 62.6 (2,044.60 ns) | 3,104.2 (41.24 ns) | 0.90 |
| **`areion_soem512x4`** | 69.4 (3,688.64 ns) | 2,680.6 (95.50 ns) | 1.04 |
| **`areion_aes128_round`** | 63.5 (251.87 ns) | 4,278.3 (3.75 ns) | 0.66 |
| **`areion_aes128_round4`** | 203.9 (313.91 ns) | 9,160.7 (6.99 ns) | 0.31 |
| **`areion_expand_key128`** | 356.5 (493.68 ns) | 6,510.1 (27.03 ns) | 0.43 |
| **`areion_aes128_encrypt_block`** | 24.5 (654.34 ns) | 1,576.3 (10.15 ns) | 1.78 |
| **`areion_aes128_encrypt4_blocks`** | 94.0 (680.94 ns) | 5,981.0 (10.70 ns) | 0.47 |

#### Wide-Block Ciphers (`EM`, `EM2`, `TEM`, `TEM2`) & `ASURA` vs. `Rijndael-256` & `Vistrutah-256/512` (MB/s, ns/op)

| Operation | `purec` | `arm64` | `c/B` (`arm64`) |
| :--- | :---: | :---: | :---: |
| **`areion_em_encrypt256`** | 30.2 (1,060.84 ns) | 2,352.7 (13.60 ns) | 1.19 |
| **`areion_em_decrypt256`** | 31.6 (1,011.90 ns) | 2,411.5 (13.27 ns) | 1.16 |
| **`areion_em_encrypt512`** | 40.5 (1,583.35 ns) | 2,290.8 (27.94 ns) | 1.22 |
| **`areion_em_decrypt512`** | 32.1 (1,995.42 ns) | 1,867.9 (34.26 ns) | 1.50 |
| **`areion_em2_encrypt256`** | 16.6 (1,932.00 ns) | 993.5 (32.21 ns) | 2.82 |
| **`areion_em2_decrypt256`** | 17.5 (1,830.81 ns) | 1,133.6 (28.23 ns) | 2.47 |
| **`areion_em2_encrypt512`** | 22.3 (2,864.45 ns) | 1,048.4 (61.05 ns) | 2.67 |
| **`areion_em2_decrypt512`** | 17.4 (3,664.38 ns) | 871.7 (73.43 ns) | 3.21 |
| **`areion_tem_encrypt256`** | 16.6 (1,928.98 ns) | 970.2 (32.98 ns) | 2.89 |
| **`areion_tem_decrypt256`** | 17.0 (1,879.59 ns) | 935.6 (34.20 ns) | 2.99 |
| **`areion_tem_encrypt512`** | 22.3 (2,869.21 ns) | 1,036.7 (61.73 ns) | 2.70 |
| **`areion_tem_decrypt512`** | 19.6 (3,267.97 ns) | 941.4 (67.99 ns) | 2.97 |
| **`areion_tem2_encrypt256`** | 11.4 (2,808.15 ns) | 451.9 (70.82 ns) | 6.20 |
| **`areion_tem2_decrypt256`** | 11.8 (2,720.42 ns) | 494.6 (64.70 ns) | 5.66 |
| **`areion_tem2_encrypt512`** | 15.1 (4,240.72 ns) | 641.6 (99.75 ns) | 4.36 |
| **`areion_tem2_decrypt512`** | 12.7 (5,023.74 ns) | 571.7 (111.95 ns) | 4.90 |
| **`areion_em_encrypt256x4`** | 114.1 (1,121.75 ns) | 3,890.1 (32.91 ns) | 0.72 |
| **`areion_em_decrypt256x4`** | 119.5 (1,070.85 ns) | 4,383.9 (29.20 ns) | 0.64 |
| **`areion_em_encrypt512x4`** | 132.0 (1,938.95 ns) | 4,882.2 (52.44 ns) | 0.57 |
| **`areion_em_decrypt512x4`** | 108.4 (2,361.57 ns) | 3,762.5 (68.04 ns) | 0.74 |
| **`areion_em2_encrypt256x4`** | 62.7 (2,040.92 ns) | 2,038.8 (62.78 ns) | 1.37 |
| **`areion_em2_decrypt256x4`** | 65.7 (1,947.62 ns) | 2,374.2 (53.92 ns) | 1.18 |
| **`areion_em2_encrypt512x4`** | 69.6 (3,675.52 ns) | 2,677.0 (95.63 ns) | 1.05 |
| **`areion_em2_decrypt512x4`** | 56.7 (4,513.54 ns) | 1,867.9 (137.05 ns) | 1.50 |
| **`areion_tem_encrypt256x4`** | 62.7 (2,040.69 ns) | 2,012.7 (63.60 ns) | 1.39 |
| **`areion_tem_decrypt256x4`** | 64.1 (1,996.94 ns) | 2,174.8 (58.86 ns) | 1.29 |
| **`areion_tem_encrypt512x4`** | 69.4 (3,685.99 ns) | 1,819.5 (140.71 ns) | 1.54 |
| **`areion_tem_decrypt512x4`** | 62.4 (4,104.38 ns) | 1,639.1 (156.18 ns) | 1.71 |
| **`areion_tem2_encrypt256x4`** | 32.3 (3,968.45 ns) | 1,034.6 (123.71 ns) | 2.71 |
| **`areion_tem2_decrypt256x4`** | 33.2 (3,856.62 ns) | 1,108.3 (115.50 ns) | 2.53 |
| **`areion_tem2_encrypt512x4`** | 35.7 (7,173.24 ns) | 916.9 (279.20 ns) | 3.05 |
| **`areion_tem2_decrypt512x4`** | 32.0 (8,000.73 ns) | 819.9 (312.22 ns) | 3.41 |
| **`areion_asura_expand_tweakey`** | 40.3 (794.11 ns) | 861.2 (37.16 ns) | 3.25 |
| **`areion_asura_encrypt`** | 21.0 (1,526.38 ns) | 3,417.0 (9.37 ns) | 0.82 |
| **`areion_asura_decrypt`** | 18.1 (1,771.49 ns) | 1,811.7 (17.66 ns) | 1.55 |
| **`areion_asura_encryptx4`** | 54.8 (2,335.42 ns) | 5,797.9 (22.08 ns) | 0.48 |
| **`areion_asura_decryptx4`** | 57.4 (2,229.64 ns) | 3,564.0 (35.91 ns) | 0.79 |
| **`areion_asura_encrypt_otf`** | 15.4 (2,084.65 ns) | 786.1 (40.71 ns) | 3.56 |
| **`areion_asura_decrypt_otf`** | 11.3 (2,824.29 ns) | 484.4 (66.06 ns) | 5.78 |
| **`areion_asura_encryptx4_otf`** | 47.1 (2,716.54 ns) | 2,008.3 (63.74 ns) | 1.39 |
| **`areion_asura_decryptx4_otf`** | 38.5 (3,326.72 ns) | 1,002.6 (127.67 ns) | 2.79 |
| **`areion_asura_expand_key`** | 79.1 (404.73 ns) | 917.5 (34.88 ns) | 3.05 |
| **`areion_asura_encrypt_rk`** | 16.8 (1,906.40 ns) | 2,463.8 (12.99 ns) | 1.14 |
| **`areion_asura_decrypt_rk`** | 16.0 (2,003.06 ns) | 771.6 (41.48 ns) | 3.63 |
| **`areion_asura_encryptx4_rk`** | 49.4 (2,590.17 ns) | 3,751.8 (34.12 ns) | 0.75 |
| **`areion_asura_decryptx4_rk`** | 41.7 (3,068.81 ns) | 1,825.7 (70.11 ns) | 1.53 |
| **`Rijndael-256`** | 37.5 (853.25 ns) | 1,411.8 (22.67 ns) | 1.98 |
| **`Rijndael-256x4`** | 115.5 (1,108.64 ns) | 2,741.4 (46.69 ns) | 1.02 |
| **`Vistrutah-256 (10r)`** | 38.2 (837.01 ns) | 3,890.4 (8.23 ns) | 0.72 |
| **`Vistrutah-256 (14r)`** | 29.3 (1,092.47 ns) | 2,622.0 (12.20 ns) | 1.07 |
| **`Vistrutah-256x4 (10r)`** | 92.7 (1,381.24 ns) | 6,379.3 (20.06 ns) | 0.44 |
| **`Vistrutah-256x4 (14r)`** | 68.6 (1,864.48 ns) | 4,634.8 (27.62 ns) | 0.60 |
| **`Vistrutah-512-256 (10r)`** | 65.0 (984.46 ns) | 4,036.9 (15.86 ns) | 0.69 |
| **`Vistrutah-512-256 (14r)`** | 48.9 (1,309.35 ns) | 2,703.9 (23.67 ns) | 1.04 |
| **`Vistrutah-512-256 (18r)`** | 39.2 (1,633.82 ns) | 2,034.6 (31.45 ns) | 1.38 |
| **`Vistrutah-512-512 (12r)`** | 56.2 (1,139.01 ns) | 3,360.8 (19.04 ns) | 0.83 |
| **`Vistrutah-512-512 (18r)`** | 39.4 (1,625.76 ns) | 2,079.4 (30.78 ns) | 1.35 |
| **`Vistrutah-512-256x4 (10r)`** | 77.0 (3,325.14 ns) | 5,836.3 (43.86 ns) | 0.48 |
| **`Vistrutah-512-256x4 (14r)`** | 55.4 (4,620.56 ns) | 4,191.1 (61.08 ns) | 0.67 |
| **`Vistrutah-512-256x4 (18r)`** | 43.2 (5,926.72 ns) | 3,262.1 (78.48 ns) | 0.86 |
| **`Vistrutah-512-512x4 (12r)`** | 64.6 (3,964.05 ns) | 4,939.4 (51.83 ns) | 0.57 |
| **`Vistrutah-512-512x4 (18r)`** | 43.2 (5,920.69 ns) | 3,284.0 (77.96 ns) | 0.85 |

All operations: 0 B/op, 0 allocs/op.

### 3. Comparison with `Rijndael-256` (`NIST SP 800-197`), `Vistrutah-256/512` ([ePrint 2025/976](https://eprint.iacr.org/2025/976)) & `ASURA` (`INDOCRYPT 2024`) (MB/s, ns/op)

- **`Rijndael-256`** (14 rounds, 256-bit block, 256-bit key, `ShiftRows` offsets `(0, 1, 3, 4)` across an `8 × 4` byte matrix) requires a cross-128-bit-half byte permutation `InvShiftRows_AES128` ∘ `ShiftRows_R256(0,1,3,4)` (`PSHUFB`/`VPSHUFB` + `PBLENDVB`/`VPBLENDVB` on x86-64, `VTBL2` on ARM64) before every round and 480 bytes (`15 × 32 B`) of pre-expanded round keys in RAM.
- **`Vistrutah-256`** (`10` or `14` rounds, 256-bit block, 256-bit key) and **`Vistrutah-512`** (`10`, `14`, or `18` rounds with 256-bit key; `12` or `18` rounds with 512-bit key) alternate pairs of parallel 128-bit AES rounds with a cross-slice `mixSlice` byte shuffle (`PUNPCK*` + `PALIGNR`/`PSHUFB` on x86-64, `VZIP1`/`VZIP2` + `VTBL` on ARM64) every two rounds and an on-the-fly key permutation `ρ`.
- **`ASURA`** (`12` rounds = `6` double-rounds + final half-round, 256-bit block, 256-bit key, 128-bit tweak, INDOCRYPT 2024) couples two 128-bit AES lanes via a 32-byte permutation `perm256` mapped natively to `UZP1` / `UZP2` (encryption) and `ZIP1` / `ZIP2` (decryption) on ARM64 (or `VPSHUFB` + `VPUNPCKLQDQ`/`VPUNPCKHQDQ` on x86-64). Because `ASURA` applies `MixColumns` in its final half-round and uses forward `AESENC` inside `R_core` during decryption, decryption requires additional AES instructions per sub-round (`AESMC` + `AESE` on ARM64, `VAESDECLAST` + `VAESENC` on x86-64, even after collapsing the `F_delta` inverse branch via the Equivalent Inverse Cipher identity) — making `ASURA` decryption ~1.5–1.9× slower than encryption (`1,811.7` vs `3,417.0 MB/s` on Graviton 4; `2,323.3` vs `3,929.3 MB/s` on Intel i7-11700K). `ASURA` supports three tweakey modes: (1) **pre-expanded round tweakeys in RAM** (`areion_asura_expand_tweakey`, `416 B` per `(key, tweak)`), (2) **hybrid pre-expanded session key + on-the-fly tweak** (`areion_asura_expand_key` + `areion_asura_*_rk`, `416 B` per session key with 12 `theta` AES rounds per call), reaching `2,822.8` / `1,501.8 MB/s` (`enc_rk`/`dec_rk`, `8,946.1` / `5,476.4 MB/s` `×4`) on Intel i7-11700K and `2,463.8` / `771.6 MB/s` (`3,751.8` / `1,825.7 MB/s` `×4`) on Graviton 4, and (3) **zero-RAM-state full on-the-fly (`OTF`)** (`areion_asura_*_otf`, 12 `theta` + 12 `kappa` steps per call with in-register tweakey processing during decryption), yielding single-block `OTF` throughput of `786.1` / `484.4 MB/s` (`Enc`/`Dec`) on Graviton 4 and `1,168.6` / `706.5 MB/s` on Intel i7-11700K.
- **`Areion-256` / `Areion-512`** use a 2-branch / 4-branch Feistel/SPN structure built natively from 128-bit AES rounds with **zero byte shuffles (`PSHUFB`/`VTBL`)** on the data path, symmetric encryption/decryption cost, and **zero persistent round-key state in RAM** (`EM`, `EM2`, `TEM`, `TEM2` hold keys and tweaks strictly in volatile registers and wipe them before returning):

| Wide-Block Cipher Primitive | Intel Core i7-11700K (Best HW Tier) | AWS Graviton 4 (`arm64`) | Block / Key / RAM Key State & Security |
| :--- | :---: | :---: | :--- |
| **`areion_em_encrypt256`** | **5,744.7** (5.58 ns) | **2,352.7** (13.60 ns) | 256b / 512b key, 0 B RAM RK (2^128 PRP) |
| **`areion_em_decrypt256`** | **4,441.0** (7.25 ns) | **2,411.5** (13.27 ns) | 256b / 512b key, 0 B RAM RK (2^128 PRP) |
| **`areion_em_encrypt512`** | **5,588.2** (11.46 ns) | **2,290.8** (27.94 ns) | 512b / 1024b key, 0 B RAM RK (2^256 PRP) |
| **`areion_em2_encrypt256`** | **2,265.7** (14.13 ns) | **993.5** (32.21 ns) | 256b / 512b key, 0 B RAM RK (2^170.7 BBB PRP) |
| **`areion_em2_encrypt512`** | **2,417.6** (26.47 ns) | **1,048.4** (61.05 ns) | 512b / 1024b key, 0 B RAM RK (2^341.3 BBB PRP) |
| **`areion_tem_encrypt256`** | **2,318.2** (13.81 ns) | **970.2** (32.98 ns) | 256b / 512b + 256b tweak, 0 B RAM RK (2^128 TPRP) |
| **`areion_tem_decrypt256`** | **2,045.4** (15.65 ns) | **935.6** (34.20 ns) | 256b / 512b + 256b tweak, 0 B RAM RK (2^128 TPRP) |
| **`areion_tem_encrypt512`** | **2,328.7** (27.48 ns) | **1,036.7** (61.73 ns) | 512b / 1024b + 512b tweak, 0 B RAM RK (2^256 TPRP) |
| **`areion_tem2_encrypt256`** | **1,153.0** (27.76 ns) | **451.9** (70.82 ns) | 256b / 512b + 256b tweak, 0 B RAM RK (2^170.7 BBB TPRP) |
| **`areion_tem2_encrypt512`** | **1,362.9** (46.96 ns) | **641.6** (99.75 ns) | 512b / 1024b + 512b tweak, 0 B RAM RK (2^341.3 BBB TPRP) |
| **`areion_em_encrypt256x4`** | **13,961.2** (2.32 ns/blk) | **3,890.1** (8.23 ns/blk) | 4×256b, 0 B RAM RK (2^128 PRP) |
| **`areion_em_decrypt256x4`** | **11,907.6** (2.70 ns/blk) | **4,383.9** (7.30 ns/blk) | 4×256b, 0 B RAM RK (2^128 PRP) |
| **`areion_em_encrypt512x4`** | **13,952.4** (4.59 ns/blk) | **4,882.2** (13.11 ns/blk) | 4×512b, 0 B RAM RK (2^256 PRP) |
| **`areion_em2_encrypt256x4`** | **6,354.7** (5.04 ns/blk) | **2,038.8** (15.70 ns/blk) | 4×256b, 0 B RAM RK (2^170.7 BBB PRP) |
| **`areion_em2_encrypt512x4`** | **6,752.2** (9.50 ns/blk) | **2,677.0** (23.91 ns/blk) | 4×512b, 0 B RAM RK (2^341.3 BBB PRP) |
| **`areion_tem_encrypt256x4`** | **6,322.2** (5.08 ns/blk) | **2,012.7** (15.90 ns/blk) | 4×256b + tweaks, 0 B RAM RK (2^128 TPRP) |
| **`areion_tem_decrypt256x4`** | **5,779.2** (5.59 ns/blk) | **2,174.8** (14.72 ns/blk) | 4×256b + tweaks, 0 B RAM RK (2^128 TPRP) |
| **`areion_tem_encrypt512x4`** | **6,901.7** (9.28 ns/blk) | **1,819.5** (35.18 ns/blk) | 4×512b + tweaks, 0 B RAM RK (2^256 TPRP) |
| **`areion_tem2_encrypt256x4`** | **3,442.5** (9.30 ns/blk) | **1,034.6** (30.93 ns/blk) | 4×256b + tweaks, 0 B RAM RK (2^170.7 BBB TPRP) |
| **`areion_tem2_encrypt512x4`** | **3,531.1** (18.16 ns/blk) | **916.9** (69.80 ns/blk) | 4×512b + tweaks, 0 B RAM RK (2^341.3 BBB TPRP) |
| **`areion_asura_encrypt / areion_asura_decrypt`** | 3,929.3 / 2,323.3 (8.15 / 13.78 ns) | 3,417.0 / 1,811.7 (9.37 / 17.66 ns) | 256b / 256b + 128b tweak, **416 B RAM RTK** (INDOCRYPT 2024) |
| **`areion_asura_encryptx4 / areion_asura_decryptx4`** | 10,686.1 / 7,258.9 (3.00 / 4.41 ns/blk) | 5,797.9 / 3,564.0 (5.52 / 8.98 ns/blk) | 4×256b + tweak, **416 B RAM RTK** (INDOCRYPT 2024) |
| **`areion_asura_encrypt_rk / areion_asura_decrypt_rk`** | 2,822.8 / 1,501.8 (11.35 / 21.31 ns) | 2,463.8 / 771.6 (12.99 / 41.48 ns) | 256b / 256b + OTF 128b tweak, **416 B RAM RK** (INDOCRYPT 2024) |
| **`areion_asura_encryptx4_rk / areion_asura_decryptx4_rk`** | 8,946.1 / 5,476.4 (3.58 / 5.84 ns/blk) | 3,751.8 / 1,825.7 (8.53 / 17.53 ns/blk) | 4×256b + OTF tweaks, **416 B RAM RK** (INDOCRYPT 2024) |
| **`areion_asura_encrypt_otf / areion_asura_decrypt_otf`** | 1,168.6 / 706.5 (27.39 / 45.29 ns) | 786.1 / 484.4 (40.71 / 66.06 ns) | 256b / 256b + 128b tweak, 0 B RAM RK (INDOCRYPT 2024) |
| **`areion_asura_encryptx4_otf / areion_asura_decryptx4_otf`** | 3,418.3 / 2,327.5 (9.36 / 13.75 ns/blk) | 2,008.3 / 1,002.6 (15.93 / 31.92 ns/blk) | 4×256b + tweaks, 0 B RAM RK (INDOCRYPT 2024) |
| **`Rijndael-256 (14r)`** | 2,265.5 (14.13 ns) | 1,411.8 (22.67 ns) | 256b / 256b key, **480 B RAM RK** (SP 800-197) |
| **`Rijndael-256x4 (14r)`** | 7,546.5 (4.24 ns/blk) | 2,741.4 (11.67 ns/blk) | 4×256b, **480 B RAM RK** (SP 800-197) |
| **`Vistrutah-256 (10r / 14r)`** | 6,504.4 / 3,852.4 (4.93 / 8.32 ns) | 3,890.4 / 2,622.0 (8.23 / 12.20 ns) | 256b / 256b key, 0 B RAM RK (ePrint 2025/976) |
| **`Vistrutah-256x4 (10r / 14r)`** | 13,198.3 / 8,970.8 (2.43 / 3.57 ns/blk) | 6,379.3 / 4,634.8 (5.02 / 6.91 ns/blk) | 4×256b, 0 B RAM RK (ePrint 2025/976) |
| **`Vistrutah-512-256 (10r / 14r / 18r)`** | 5,488.8 / 3,626.2 / 2,613.4 | 4,036.9 / 2,703.9 / 2,034.6 | 512b / 256b key, 0 B RAM RK (ePrint 2025/976) |
| **`Vistrutah-512-512 (12r / 18r)`** | 4,434.9 / 2,655.2 | 3,360.8 / 2,079.4 | 512b / 512b key, 0 B RAM RK (ePrint 2025/976) |
| **`Vistrutah-512-256x4 (10r / 14r / 18r)`** | 10,781.0 / 7,771.6 / 5,940.7 | 5,836.3 / 4,191.1 / 3,262.1 | 4×512b / 256b key, 0 B RAM RK (ePrint 2025/976) |
| **`Vistrutah-512-512x4 (12r / 18r)`** | 9,639.8 / 6,198.2 | 4,939.4 / 3,284.0 | 4×512b / 512b key, 0 B RAM RK (ePrint 2025/976) |

On Intel Core i7-11700K, `areion_em_encrypt256` (`5,744.7 MB/s`, `5.58 ns/op`, `0.63 c/B`) and `areion_em_encrypt256x4` (`13,961.2 MB/s`, `9.29 ns/op`, `0.26 c/B`) outperform 14-round `Rijndael-256` (`2,265.5 MB/s` single-block, `7,546.5 MB/s` 4-block — `2.5×` and `1.9×` faster), 14r `Vistrutah-256` (`3,852.4 MB/s` single-block, `8,970.8 MB/s` 4-block — `1.5×` and `1.6×` faster) and 10r `Vistrutah-256x4` (`13,198.3 MB/s` — `1.1×` faster), and 12-round `ASURA` with pre-expanded tweakeys (`3,929.3 MB/s` single-block, `10,686.1 MB/s` 4-block — `1.5×` and `1.3×` faster), while `areion_em_decrypt256` (`4,441.0 MB/s`) and `areion_em_decrypt256x4` (`11,907.6 MB/s`) are `1.9×` and `1.6×` faster than `areion_asura_decrypt` (`2,323.3 MB/s`) and `areion_asura_decryptx4` (`7,258.9 MB/s`). In zero-RAM-state tweakable operation (where the tweak changes per block), `areion_tem_encrypt256` (`2,318.2 MB/s`) and `areion_tem_decrypt256` (`2,045.4 MB/s`) outperform `areion_asura_encrypt_otf` (`1,168.6 MB/s`, `2.0×`) and `areion_asura_decrypt_otf` (`706.5 MB/s`, `2.9×`) on Intel Core i7-11700K, and `areion_tem_encrypt256` (`970.2 MB/s`) and `areion_tem_decrypt256` (`935.6 MB/s`) outperform `areion_asura_encrypt_otf` (`786.1 MB/s`, `1.2×`) and `areion_asura_decrypt_otf` (`484.4 MB/s`, `1.9×`) on AWS Graviton 4 (`arm64`), where `areion_em_decrypt256` (`2,411.5 MB/s`) and `areion_em_decrypt256x4` (`4,383.9 MB/s`) also outperform pre-expanded `areion_asura_decrypt` (`1,811.7 MB/s`, `1.3×`) and `areion_asura_decryptx4` (`3,564.0 MB/s`, `1.2×`).

> **Pre-expanded (`rtk`), Hybrid (`rk` + OTF tweak), and On-the-Fly (`OTF`) tweakey processing:**
> - **Pre-expanded / fixed-tweakey mode (`rtk`):** `areion_asura_encrypt` / `areion_asura_decrypt` (and `x4`, `416 B` `rtk` expanded via `areion_asura_expand_tweakey`), `Rijndael-256` (`480 B` `rk`), and `areion_aes128_encrypt_block` (`176 B` `rk`) benchmark the cipher core with round keys/tweakeys precomputed in RAM (comparable to fixed-key `areion_em_*`, `areion_em2_*`, and `Vistrutah-*`).
> - **Hybrid pre-expanded session key + on-the-fly tweak mode (`rk`):** `areion_asura_encrypt_rk` / `areion_asura_decrypt_rk` (and `x4`, `416 B` `rk` expanded once per session key via `areion_asura_expand_key`) precompute the 12 `kappa` key schedule steps and `RC` additions once per key and evaluate only the 12 `theta` (`AESENC`) tweak rounds per call when the 128-bit tweak changes every block or `×4` batch.
> - **On-the-fly (`OTF`) per-block tweakey mode (`0 B` RAM state):** `areion_asura_encrypt_otf` / `areion_asura_decrypt_otf` (and `x4`), `areion_tem_*`, and `areion_tem2_*` accept raw keys and tweaks on every call and compute all round tweakeys/masks on-the-fly in SIMD registers.

> **Benchmark methodology note:** `areion_permute*`, `areion_inverse_permute*`, `areion_aes128_round*`, and `areion_aes128_encrypt*` overwrite their state buffer in-place (`dst == src`), measuring serial dependency-chain latency across iterations (`areion_aes128_encrypt*`, `Rijndael256Encrypt*`, and `areion_asura_{encrypt,decrypt}{,x4}` time the cipher core with pre-expanded round keys/tweakeys in RAM, whereas `areion_{em,em2,tem,tem2}_*`, `Vistrutah*`, and `areion_asura_*_otf` take raw keys/tweaks and expand/apply round keys on-the-fly in registers). `areion_soem*`, `areion_dm*`, `areion_{em,em2,tem,tem2}_*`, `areion_asura_*`, `Rijndael256Encrypt*`, and `Vistrutah*` evaluate fixed input, tweak, and key buffers across iterations, allowing out-of-order execution to overlap independent calls. See [`everanium/areion/analysis/README.md` (Section L)](https://github.com/everanium/areion/blob/main/analysis/README.md#l-register-and-stack-clearing-cost) for interleaved single-core cycle-per-byte measurements including epilogue register and stack clearing.

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
- `supercop/crypto_tbc/asura256/ref/` (`crypto_tbc_encrypt` / `crypto_tbc_decrypt` → `areion_asura_encrypt_otf` / `areion_asura_decrypt_otf`)

---

## Reproduce

### 1. Build & Run Complete Test Suite (`make`)
```bash
# Build static/shared libraries and run unit + SUPERCOP + pairwise tier matrix + zeroization + constant-derivation + ASURA KAT + ELF security (GNU_STACK, CET/BTI, nm) tests:
make test
python3 scripts/verify_p2_table.py
python3 scripts/verify_asura_kat.py

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
The environment variable `AREION_FORCE_TIER` (or `ASURA_FORCE_TIER`, or `areion_set_tier()`) forces the execution tier:
```bash
# Test individual tiers:
AREION_FORCE_TIER=purec    ./areion_test && AREION_FORCE_TIER=purec    ./areion_zeroize_test
AREION_FORCE_TIER=aesni    ./areion_test && AREION_FORCE_TIER=aesni    ./areion_zeroize_test
AREION_FORCE_TIER=vex      ./areion_test && AREION_FORCE_TIER=vex      ./areion_zeroize_test
AREION_FORCE_TIER=vaesavx2 ./areion_test && AREION_FORCE_TIER=vaesavx2 ./areion_zeroize_test
AREION_FORCE_TIER=avx512   ./areion_test && AREION_FORCE_TIER=avx512   ./areion_zeroize_test
AREION_FORCE_TIER=arm64    ./areion_test && AREION_FORCE_TIER=arm64    ./areion_zeroize_test

# Benchmark individual tiers (via positional argument or AREION_FORCE_TIER / ASURA_FORCE_TIER):
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
    uint8_t asura_key[AREION_ASURA_KEY_SIZE] = {0};
    uint8_t asura_tweak[AREION_ASURA_TWEAK_SIZE] = {0};
    uint8_t asura_rtk[13][32];
    uint8_t asura_rk[13][32];
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

    /* 5. ASURA 256-bit tweakable block cipher (rtk, rk + OTF-Tweak, and OTF) */
    areion_asura_expand_tweakey(asura_rtk, asura_key, asura_tweak);
    areion_asura_encrypt(ct, msg, asura_rtk);
    areion_asura_decrypt(pt, ct, asura_rtk);
    areion_wipe_asura_tweakey(asura_rtk);
    areion_asura_expand_key(asura_rk, asura_key);
    areion_asura_encrypt_rk(ct, msg, asura_rk, asura_tweak);
    areion_asura_decrypt_rk(pt, ct, asura_rk, asura_tweak);
    areion_wipe_asura_key(asura_rk);
    areion_asura_encrypt_otf(ct, msg, asura_key, asura_tweak);
    areion_asura_decrypt_otf(pt, ct, asura_key, asura_tweak);

    /* 6. Scrub sensitive key and plaintext buffers before returning */
    areion_zeroize(key, sizeof(key));
    areion_zeroize(asura_key, sizeof(asura_key));
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

9. **Vistrutah: Extremely Fast 256 and 512-bit Block Ciphers Strategy for Modern CPUs**
   Roberto Avanzi, Subhadeep Banik, Orr Dunkelman, Shibam Ghosh, Marcel Nageler.
   *IACR Cryptology ePrint Archive*, Paper 2025/976 (2025), [IACR ePrint 2025/976](https://eprint.iacr.org/2025/976).

10. **ASURA: An Efficient Large-State Tweakable Block Cipher for ARM Environment**
    Atsushi Tanaka, Rentaro Shiba, Kosei Sakamoto, Mostafizar Rahman, Takuro Shiraya, Takanori Isobe.
    *Progress in Cryptology — INDOCRYPT 2024*, Lecture Notes in Computer Science, vol. 15495, pp. 143–164, Springer (2025), [doi:10.1007/978-3-031-80308-6_7](https://doi.org/10.1007/978-3-031-80308-6_7).

---

## License

Dual-licensed under either:
- [Apache License, Version 2.0](LICENSE-APACHE)
- [MIT License](LICENSE-MIT)

Copyright (c) 2026 Andrey Kuvshinov.
