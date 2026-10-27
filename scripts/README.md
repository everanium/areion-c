# Areion Auxiliary Scripts

This directory contains standalone verification and code-generation tooling for `areion-c`.

## Tools

### 1. `verify_p2_table.py`

Python 3 verification script for the Areion-SoEM22 round constants (standard library only).

`verify_p2_table.py` computes and reports:
1. **Arbitrary-precision derivation**: Computes hexadecimal digits of $\pi$ directly from Machin's formula ($\pi/4 = 4 \arctan(1/5) - \arctan(1/239)$) using pure integer arithmetic (zero external dependencies).
2. **Byte-level layout**: Confirms byte alignment matching Areion's C reference implementation (`_mm_setr_epi32`).
3. **RC7 shift**: Confirms that RC7 of both tables is the $\pi$ word shifted by one nibble, and that words 7 and 22 are the only words among 0..29 that begin with a zero nibble.
4. **Distinctness**: Validates that all 15 constants in Table 2 are pairwise distinct and disjoint from Table 1.
5. **Weight distributions**: Reports Hamming-weight statistics (vs $B(128, 0.5)$).
6. **Linear independence and difference space**: Verifies that the $15 \times 128$ matrices of Table 1, Table 2, and $\Delta_r = \mathrm{RC}_1[r] \oplus \mathrm{RC}_2[r]$ have rank 15 and the combined $30 \times 128$ matrix has full rank 30 over $\mathrm{GF}(2)$.
7. **Cross-table distinctness**: Evaluates all $15 \times 15 = 225$ cross-permutation differences $\Delta_{i,j} = \mathrm{RC}_1[i] \oplus \mathrm{RC}_2[j]$, confirming no identical pairs (min Hamming distance 50).
8. **AES column symmetry**: Confirms zero 32-bit column duplicates in Table 2.
9. **Library constant verification**: Parses `constants.c` and verifies that its literal arrays match the derived Table 1 and Table 2 bit-for-bit.
10. **C table emission**: Emits ready-to-use C declarations.

```bash
python3 scripts/verify_p2_table.py
```

### 2. `verify_cross_kat.py`

Cross-language tier-by-tier and full Cartesian product (`Go[tier_A] × C[tier_B]`) KAT parity harness comparing Go ([`everanium/areion`](https://github.com/everanium/areion)) and C (`everanium/areion-c`) across all exported data-transforming primitives, SoA pack/unpack helpers, and tier introspection functions across all execution tiers (`purego` $\leftrightarrow$ `purec`, `aesni`, `vex`, `vaesavx2`, `avx512` on `x86-64`, `purec` and `arm64` under `qemu-aarch64-static -cpu max`, and Big-Endian `s390x` under `qemu-s390x-static`), asserting 100% bit-for-bit equality. Looks up the Go repository via `AREION_GO_DIR` or adjacent relative paths (`../areion`).

```bash
AREION_GO_DIR=../areion python3 scripts/verify_cross_kat.py
```

### 3. `run_bench.py`

Automated multi-tier benchmark runner that executes `./areion_test --bench` across all supported hardware dispatch tiers on the current host (`purec`, `aesni`, `vex`, `vaesavx2`, `avx512` on `x86-64`; `purec`, `arm64` on `aarch64`) and outputs a consolidated Markdown table with throughput (`MB/s`) and latency (`ns/op`), including `Rijndael256EncryptBlockHW` and `Rijndael256Encrypt4BlocksHW` (`NIST SP 800-197`).

```bash
python3 scripts/run_bench.py
```

### 4. `gen_msvc_asm.py`

Translates the canonical Go Plan 9 assembly kernels (from `AREION_GO_DIR` or `../areion`) into:
- GNU GAS / Clang integrated assembler files (`areion_amd64.S`, `areion_soem256_amd64.S`, `areion_soem512_amd64.S`, `areion_soem_aesni_amd64.S`, `areion_arm64.S`)
- Microsoft MASM (`ml64.exe`) and ARMASM64 (`armasm64.exe`) files (`msvc/*.asm`)

```bash
AREION_GO_DIR=../areion python3 scripts/gen_msvc_asm.py
```

### 5. `audit_asm_epilogues.py`

Static and disassembly (`objdump -d`) auditor for Go Plan 9 (`.s`), GNU GAS (`.S`), Microsoft MASM / ARMASM64 (`msvc/*.asm`), and compiled object files (`.o`). Verifies 100% epilogue vector/GPR zeroization, zero secret stack spills, Windows x64 (`_WIN64`) non-volatile register (`XMM6..XMM15`, `RSI`, `RDI`) save/restore and stack-slot wiping, `vzeroupper` placement, and ARM64 AAPCS64 (`d8..d15`) callee-saved register preservation and 16-byte `sp` alignment.

```bash
python3 scripts/audit_asm_epilogues.py
```
