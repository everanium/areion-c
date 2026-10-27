#!/usr/bin/env python3
# Copyright (c) 2026 Andrey Kuvshinov
# Dual-licensed under Apache-2.0 OR MIT.
"""Cross-language tier-by-tier KAT parity harness comparing Go (areion) and C (areion-c)."""

import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

C_REPO = Path(__file__).resolve().parent.parent


def _resolve_go_repo() -> Path:
    env_dir = os.environ.get("AREION_GO_DIR")
    if env_dir:
        return Path(env_dir).resolve()
    for rel in (
        "../areion", "../../areion", "../../go/src/areion", "../../../go/src/areion",
    ):
        cand = (C_REPO / rel).resolve()
        if (cand / "go.mod").exists():
            return cand
    return (C_REPO / "../areion").resolve()


GO_REPO = _resolve_go_repo()

GO_DUMPER_SRC = r"""package main

import (
	"encoding/binary"
	"encoding/hex"
	"fmt"
	"os"

	"github.com/everanium/areion"
)

func fillPattern(buf []byte, seed byte) {
	for i := range buf {
		buf[i] = byte((uint(i)*37 + uint(seed)*13 + 0x5a) & 0xFF)
	}
}

func printHex(label string, b []byte) {
	fmt.Printf("%s=%s\n", label, hex.EncodeToString(b))
}

func main() {
	if len(os.Args) >= 2 {
		tier := os.Args[1]
		if tier == "purec" {
			tier = "purego"
		}
		if err := areion.SetTier(tier); err != nil {
			fmt.Fprintf(os.Stderr, "Unsupported tier: %s (%v)\n", tier, err)
			os.Exit(2)
		}
	}

	var s256 [32]byte
	var s512 [64]byte
	var key256 [64]byte
	var key512 [128]byte

	fillPattern(s256[:], 0x01)
	areion.Permute256(&s256)
	printHex("Permute256", s256[:])

	fillPattern(s256[:], 0x02)
	areion.InversePermute256(&s256)
	printHex("InversePermute256", s256[:])

	fillPattern(s512[:], 0x03)
	areion.Permute512(&s512)
	printHex("Permute512", s512[:])

	fillPattern(s512[:], 0x04)
	areion.InversePermute512(&s512)
	printHex("InversePermute512", s512[:])

	fillPattern(s256[:], 0x05)
	areion.Permute256P2(&s256)
	printHex("Permute256P2", s256[:])

	fillPattern(s256[:], 0x06)
	areion.InversePermute256P2(&s256)
	printHex("InversePermute256P2", s256[:])

	fillPattern(s512[:], 0x07)
	areion.Permute512P2(&s512)
	printHex("Permute512P2", s512[:])

	fillPattern(s512[:], 0x08)
	areion.InversePermute512P2(&s512)
	printHex("InversePermute512P2", s512[:])

	fillPattern(s256[:], 0x01)
	areion.Permute256(&s256)
	printHex("Permute256Words", s256[:])

	fillPattern(s256[:], 0x02)
	areion.InversePermute256(&s256)
	printHex("InversePermute256Words", s256[:])

	fillPattern(s512[:], 0x03)
	areion.Permute512(&s512)
	printHex("Permute512Words", s512[:])

	fillPattern(s512[:], 0x04)
	areion.InversePermute512(&s512)
	printHex("InversePermute512Words", s512[:])

	fillPattern(s256[:], 0x09)
	out256 := areion.DM256(&s256)
	printHex("DM256", out256[:])

	fillPattern(s512[:], 0x0A)
	out256 = areion.DM512(&s512)
	printHex("DM512", out256[:])

	fillPattern(key256[:], 0x0B)
	fillPattern(s256[:], 0x0C)
	out256 = areion.SoEM256(&key256, &s256)
	printHex("SoEM256", out256[:])

	fillPattern(key512[:], 0x0D)
	fillPattern(s512[:], 0x0E)
	out512 := areion.SoEM512(&key512, &s512)
	printHex("SoEM512", out512[:])

	var keys256x4 [4][64]byte
	var keys512x4 [4][128]byte
	var in256x4 [4][32]byte
	var in512x4 [4][64]byte
	for m := 0; m < 4; m++ {
		fillPattern(keys256x4[m][:], byte(0x10+m))
		fillPattern(keys512x4[m][:], byte(0x18+m))
		fillPattern(in256x4[m][:], byte(0x20+m))
		fillPattern(in512x4[m][:], byte(0x30+m))
	}
	out256x4 := areion.SoEM256x4(&keys256x4, &in256x4)
	var flat128 [128]byte
	for m := 0; m < 4; m++ {
		copy(flat128[m*32:(m+1)*32], out256x4[m][:])
	}
	printHex("SoEM256x4", flat128[:])

	out512x4 := areion.SoEM512x4(&keys512x4, &in512x4)
	var flat256 [256]byte
	for m := 0; m < 4; m++ {
		copy(flat256[m*64:(m+1)*64], out512x4[m][:])
	}
	printHex("SoEM512x4", flat256[:])

	var b256 [4][32]byte
	for m := 0; m < 4; m++ {
		fillPattern(b256[m][:], byte(0x40+m))
	}
	areion.Permute256x4(&b256)
	for m := 0; m < 4; m++ {
		copy(flat128[m*32:(m+1)*32], b256[m][:])
	}
	printHex("Permute256x4", flat128[:])

	for m := 0; m < 4; m++ {
		fillPattern(b256[m][:], byte(0x44+m))
	}
	areion.Permute256P2x4(&b256)
	for m := 0; m < 4; m++ {
		copy(flat128[m*32:(m+1)*32], b256[m][:])
	}
	printHex("Permute256P2x4", flat128[:])

	for m := 0; m < 4; m++ {
		fillPattern(b256[m][:], byte(0x48+m))
	}
	areion.InversePermute256x4(&b256)
	for m := 0; m < 4; m++ {
		copy(flat128[m*32:(m+1)*32], b256[m][:])
	}
	printHex("InversePermute256x4", flat128[:])

	for m := 0; m < 4; m++ {
		fillPattern(b256[m][:], byte(0x4C+m))
	}
	areion.InversePermute256P2x4(&b256)
	for m := 0; m < 4; m++ {
		copy(flat128[m*32:(m+1)*32], b256[m][:])
	}
	printHex("InversePermute256P2x4", flat128[:])

	var b512 [4][64]byte
	for m := 0; m < 4; m++ {
		fillPattern(b512[m][:], byte(0x50+m))
	}
	areion.Permute512x4(&b512)
	for m := 0; m < 4; m++ {
		copy(flat256[m*64:(m+1)*64], b512[m][:])
	}
	printHex("Permute512x4", flat256[:])

	for m := 0; m < 4; m++ {
		fillPattern(b512[m][:], byte(0x54+m))
	}
	areion.Permute512P2x4(&b512)
	for m := 0; m < 4; m++ {
		copy(flat256[m*64:(m+1)*64], b512[m][:])
	}
	printHex("Permute512P2x4", flat256[:])

	for m := 0; m < 4; m++ {
		fillPattern(b512[m][:], byte(0x58+m))
	}
	areion.InversePermute512x4(&b512)
	for m := 0; m < 4; m++ {
		copy(flat256[m*64:(m+1)*64], b512[m][:])
	}
	printHex("InversePermute512x4", flat256[:])

	for m := 0; m < 4; m++ {
		fillPattern(b512[m][:], byte(0x5C+m))
	}
	areion.InversePermute512P2x4(&b512)
	for m := 0; m < 4; m++ {
		copy(flat256[m*64:(m+1)*64], b512[m][:])
	}
	printHex("InversePermute512P2x4", flat256[:])

	rwIn := [4]uint32{0x01234567, 0x89abcdef, 0xfedcba98, 0x76543210}
	var rwBlk, zeroRk [16]byte
	for i := 0; i < 4; i++ {
		binary.LittleEndian.PutUint32(rwBlk[i*4:], rwIn[i])
	}
	blk := rwBlk
	areion.Round(&blk, &zeroRk)
	printHex("Round", blk[:])

	blk = rwBlk
	areion.FinalRound(&blk, &zeroRk)
	printHex("FinalRound", blk[:])

	var ab, ark [16]byte
	var ab4, ark4, zeroRk4 [64]byte

	fillPattern(ab[:], 0x5C)
	areion.RoundHW(&ab, &zeroRk)
	printHex("RoundHW", ab[:])

	fillPattern(ab[:], 0x5D)
	areion.FinalRoundHW(&ab, &zeroRk)
	printHex("FinalRoundHW", ab[:])

	for m := 0; m < 4; m++ {
		fillPattern(ab4[m*16:(m+1)*16], byte(0x50+m))
	}
	areion.Round4HW(&ab4, &zeroRk4)
	printHex("Round4HW", ab4[:])

	for m := 0; m < 4; m++ {
		fillPattern(ab4[m*16:(m+1)*16], byte(0x54+m))
	}
	areion.FinalRound4HW(&ab4, &zeroRk4)
	printHex("FinalRound4HW", ab4[:])

	fillPattern(ab[:], 0x5E)
	fillPattern(ark[:], 0x6E)
	areion.AES128Round(&ab, &ark)
	printHex("AESRoundHW", ab[:])
	printHex("AES128Round", ab[:])

	fillPattern(ab[:], 0x5F)
	fillPattern(ark[:], 0x6F)
	areion.AES128FinalRound(&ab, &ark)
	printHex("AESFinalRoundHW", ab[:])
	printHex("AES128FinalRound", ab[:])

	for m := 0; m < 4; m++ {
		fillPattern(ab4[m*16:(m+1)*16], byte(0x60+m))
		fillPattern(ark4[m*16:(m+1)*16], byte(0x70+m))
	}
	areion.AES128Round4(&ab4, &ark4)
	printHex("AESRound4HW", ab4[:])
	printHex("AES128Round4", ab4[:])

	for m := 0; m < 4; m++ {
		fillPattern(ab4[m*16:(m+1)*16], byte(0x64+m))
	}
	areion.AES128FinalRound4(&ab4, &ark4)
	printHex("AESFinalRound4HW", ab4[:])
	printHex("AES128FinalRound4", ab4[:])

	fillPattern(ab[:], 0x68)
	copy(ark[:], ark4[0:16])
	areion.XorBlock(&ab, &ab, &ark)
	printHex("XorBlock", ab[:])

	for m := 0; m < 4; m++ {
		fillPattern(ab4[m*16:(m+1)*16], byte(0x68+m))
	}
	areion.XorBlock4(&ab4, &ab4, &ark4)
	printHex("XorBlock4", ab4[:])

	var rk [11][16]byte
	var rk0 [16]byte
	copy(rk0[:], ark4[0:16])
	areion.ExpandKey128(&rk0, &rk)
	var flatRk [176]byte
	for r := 0; r < 11; r++ {
		copy(flatRk[r*16:(r+1)*16], rk[r][:])
	}
	printHex("ExpandKey128", flatRk[:])

	var ct [16]byte
	var pt0 [16]byte
	fillPattern(pt0[:], 0x7C)
	areion.AES128EncryptBlock(&rk, &ct, &pt0)
	printHex("AES128EncryptBlock", ct[:])

	for m := 0; m < 4; m++ {
		fillPattern(ab4[m*16:(m+1)*16], byte(0x80+m))
	}
	var ct4 [64]byte
	areion.AES128Encrypt4Blocks(&rk, &ct4, &ab4)
	printHex("AES128Encrypt4Blocks", ct4[:])

	var tw256 [32]byte
	var tw512 [64]byte
	var tw256x4 [4][32]byte
	var tw512x4 [4][64]byte

	fillPattern(key256[:], 0x90)
	fillPattern(s256[:], 0x91)
	out256 = areion.EMEncrypt256(&key256, &s256)
	printHex("EMEncrypt256", out256[:])
	fillPattern(s256[:], 0x92)
	out256 = areion.EMDecrypt256(&key256, &s256)
	printHex("EMDecrypt256", out256[:])

	fillPattern(key512[:], 0x93)
	fillPattern(s512[:], 0x94)
	out512 = areion.EMEncrypt512(&key512, &s512)
	printHex("EMEncrypt512", out512[:])
	fillPattern(s512[:], 0x95)
	out512 = areion.EMDecrypt512(&key512, &s512)
	printHex("EMDecrypt512", out512[:])

	fillPattern(key256[:], 0x96)
	fillPattern(s256[:], 0x97)
	out256 = areion.EM2Encrypt256(&key256, &s256)
	printHex("EM2Encrypt256", out256[:])
	fillPattern(s256[:], 0x98)
	out256 = areion.EM2Decrypt256(&key256, &s256)
	printHex("EM2Decrypt256", out256[:])

	fillPattern(key512[:], 0x99)
	fillPattern(s512[:], 0x9A)
	out512 = areion.EM2Encrypt512(&key512, &s512)
	printHex("EM2Encrypt512", out512[:])
	fillPattern(s512[:], 0x9B)
	out512 = areion.EM2Decrypt512(&key512, &s512)
	printHex("EM2Decrypt512", out512[:])

	fillPattern(key256[:], 0x9C)
	fillPattern(tw256[:], 0x9D)
	fillPattern(s256[:], 0x9E)
	out256 = areion.TEMEncrypt256(&key256, &tw256, &s256)
	printHex("TEMEncrypt256", out256[:])
	fillPattern(s256[:], 0x9F)
	out256 = areion.TEMDecrypt256(&key256, &tw256, &s256)
	printHex("TEMDecrypt256", out256[:])

	fillPattern(key512[:], 0xA0)
	fillPattern(tw512[:], 0xA1)
	fillPattern(s512[:], 0xA2)
	out512 = areion.TEMEncrypt512(&key512, &tw512, &s512)
	printHex("TEMEncrypt512", out512[:])
	fillPattern(s512[:], 0xA3)
	out512 = areion.TEMDecrypt512(&key512, &tw512, &s512)
	printHex("TEMDecrypt512", out512[:])

	fillPattern(key256[:], 0xA4)
	fillPattern(tw256[:], 0xA5)
	fillPattern(s256[:], 0xA6)
	out256 = areion.TEM2Encrypt256(&key256, &tw256, &s256)
	printHex("TEM2Encrypt256", out256[:])
	fillPattern(s256[:], 0xA7)
	out256 = areion.TEM2Decrypt256(&key256, &tw256, &s256)
	printHex("TEM2Decrypt256", out256[:])

	fillPattern(key512[:], 0xA8)
	fillPattern(tw512[:], 0xA9)
	fillPattern(s512[:], 0xAA)
	out512 = areion.TEM2Encrypt512(&key512, &tw512, &s512)
	printHex("TEM2Encrypt512", out512[:])
	fillPattern(s512[:], 0xAB)
	out512 = areion.TEM2Decrypt512(&key512, &tw512, &s512)
	printHex("TEM2Decrypt512", out512[:])

	for m := 0; m < 4; m++ {
		fillPattern(keys256x4[m][:], byte(0xB0+m))
		fillPattern(keys512x4[m][:], byte(0xB4+m))
		fillPattern(tw256x4[m][:], byte(0xB8+m))
		fillPattern(tw512x4[m][:], byte(0xBC+m))
		fillPattern(in256x4[m][:], byte(0xC0+m))
		fillPattern(in512x4[m][:], byte(0xC4+m))
	}

	out256x4 = areion.EMEncrypt256x4(&keys256x4, &in256x4)
	for m := 0; m < 4; m++ {
		copy(flat128[m*32:(m+1)*32], out256x4[m][:])
	}
	printHex("EMEncrypt256x4", flat128[:])

	out256x4 = areion.EMDecrypt256x4(&keys256x4, &in256x4)
	for m := 0; m < 4; m++ {
		copy(flat128[m*32:(m+1)*32], out256x4[m][:])
	}
	printHex("EMDecrypt256x4", flat128[:])

	out512x4 = areion.EMEncrypt512x4(&keys512x4, &in512x4)
	for m := 0; m < 4; m++ {
		copy(flat256[m*64:(m+1)*64], out512x4[m][:])
	}
	printHex("EMEncrypt512x4", flat256[:])

	out512x4 = areion.EMDecrypt512x4(&keys512x4, &in512x4)
	for m := 0; m < 4; m++ {
		copy(flat256[m*64:(m+1)*64], out512x4[m][:])
	}
	printHex("EMDecrypt512x4", flat256[:])

	out256x4 = areion.EM2Encrypt256x4(&keys256x4, &in256x4)
	for m := 0; m < 4; m++ {
		copy(flat128[m*32:(m+1)*32], out256x4[m][:])
	}
	printHex("EM2Encrypt256x4", flat128[:])

	out256x4 = areion.EM2Decrypt256x4(&keys256x4, &in256x4)
	for m := 0; m < 4; m++ {
		copy(flat128[m*32:(m+1)*32], out256x4[m][:])
	}
	printHex("EM2Decrypt256x4", flat128[:])

	out512x4 = areion.EM2Encrypt512x4(&keys512x4, &in512x4)
	for m := 0; m < 4; m++ {
		copy(flat256[m*64:(m+1)*64], out512x4[m][:])
	}
	printHex("EM2Encrypt512x4", flat256[:])

	out512x4 = areion.EM2Decrypt512x4(&keys512x4, &in512x4)
	for m := 0; m < 4; m++ {
		copy(flat256[m*64:(m+1)*64], out512x4[m][:])
	}
	printHex("EM2Decrypt512x4", flat256[:])

	out256x4 = areion.TEMEncrypt256x4(&keys256x4, &tw256x4, &in256x4)
	for m := 0; m < 4; m++ {
		copy(flat128[m*32:(m+1)*32], out256x4[m][:])
	}
	printHex("TEMEncrypt256x4", flat128[:])

	out256x4 = areion.TEMDecrypt256x4(&keys256x4, &tw256x4, &in256x4)
	for m := 0; m < 4; m++ {
		copy(flat128[m*32:(m+1)*32], out256x4[m][:])
	}
	printHex("TEMDecrypt256x4", flat128[:])

	out512x4 = areion.TEMEncrypt512x4(&keys512x4, &tw512x4, &in512x4)
	for m := 0; m < 4; m++ {
		copy(flat256[m*64:(m+1)*64], out512x4[m][:])
	}
	printHex("TEMEncrypt512x4", flat256[:])

	out512x4 = areion.TEMDecrypt512x4(&keys512x4, &tw512x4, &in512x4)
	for m := 0; m < 4; m++ {
		copy(flat256[m*64:(m+1)*64], out512x4[m][:])
	}
	printHex("TEMDecrypt512x4", flat256[:])

	out256x4 = areion.TEM2Encrypt256x4(&keys256x4, &tw256x4, &in256x4)
	for m := 0; m < 4; m++ {
		copy(flat128[m*32:(m+1)*32], out256x4[m][:])
	}
	printHex("TEM2Encrypt256x4", flat128[:])

	out256x4 = areion.TEM2Decrypt256x4(&keys256x4, &tw256x4, &in256x4)
	for m := 0; m < 4; m++ {
		copy(flat128[m*32:(m+1)*32], out256x4[m][:])
	}
	printHex("TEM2Decrypt256x4", flat128[:])

	out512x4 = areion.TEM2Encrypt512x4(&keys512x4, &tw512x4, &in512x4)
	for m := 0; m < 4; m++ {
		copy(flat256[m*64:(m+1)*64], out512x4[m][:])
	}
	printHex("TEM2Encrypt512x4", flat256[:])

	out512x4 = areion.TEM2Decrypt512x4(&keys512x4, &tw512x4, &in512x4)
	for m := 0; m < 4; m++ {
		copy(flat256[m*64:(m+1)*64], out512x4[m][:])
	}
	printHex("TEM2Decrypt512x4", flat256[:])

	var soa256 [2]areion.Block4
	var u256 [4][32]byte
	var soa512 [4]areion.Block4
	var u512 [4][64]byte
	for m := 0; m < 4; m++ {
		fillPattern(b256[m][:], byte(0xD0+m))
		fillPattern(b512[m][:], byte(0xD4+m))
		copy(soa256[0][m*16:(m+1)*16], b256[m][0:16])
		copy(soa256[1][m*16:(m+1)*16], b256[m][16:32])
		copy(soa512[0][m*16:(m+1)*16], b512[m][0:16])
		copy(soa512[1][m*16:(m+1)*16], b512[m][16:32])
		copy(soa512[2][m*16:(m+1)*16], b512[m][32:48])
		copy(soa512[3][m*16:(m+1)*16], b512[m][48:64])
	}
	copy(flat128[0:64], soa256[0][:])
	copy(flat128[64:128], soa256[1][:])
	printHex("Pack256x4SoA", flat128[:])
	for m := 0; m < 4; m++ {
		copy(u256[m][0:16], soa256[0][m*16:(m+1)*16])
		copy(u256[m][16:32], soa256[1][m*16:(m+1)*16])
		copy(flat128[m*32:(m+1)*32], u256[m][:])
	}
	printHex("Unpack256x4SoA", flat128[:])
	for b := 0; b < 4; b++ {
		copy(flat256[b*64:(b+1)*64], soa512[b][:])
	}
	printHex("Pack512x4SoA", flat256[:])
	for m := 0; m < 4; m++ {
		copy(u512[m][0:16], soa512[0][m*16:(m+1)*16])
		copy(u512[m][16:32], soa512[1][m*16:(m+1)*16])
		copy(u512[m][32:48], soa512[2][m*16:(m+1)*16])
		copy(u512[m][48:64], soa512[3][m*16:(m+1)*16])
		copy(flat256[m*64:(m+1)*64], u512[m][:])
	}
	printHex("Unpack512x4SoA", flat256[:])

	useHW := 0
	if areion.UseHardwareAcceleration() {
		useHW = 1
	}
	fmt.Printf("_meta_tier=%s\n", areion.Tier())
	fmt.Printf("_meta_tier_code=%d\n", areion.TierCode())
	fmt.Printf("_meta_use_hw=%d\n", useHW)
}
"""


def parse_kv(output: str) -> dict[str, str]:
    res = {}
    for line in output.splitlines():
        line = line.strip()
        if "=" in line:
            k, v = line.split("=", 1)
            res[k] = v
    return res


def check_introspection(label: str, tier: str, go_map: dict[str, str], c_map: dict[str, str]) -> bool:
    exp_go_tier = "purego" if tier == "purec" else tier
    exp_c_tier = tier
    exp_hw = "0" if tier == "purec" else "1"
    if go_map.get("_meta_tier") != exp_go_tier or c_map.get("_meta_tier") != exp_c_tier:
        print(f"FAIL [{label}] Tier introspection mismatch: Go={go_map.get('_meta_tier')} C={c_map.get('_meta_tier')}", file=sys.stderr)
        return False
    if go_map.get("_meta_use_hw") != exp_hw or c_map.get("_meta_use_hw") != exp_hw:
        print(f"FAIL [{label}] UseHardwareAcceleration mismatch: Go={go_map.get('_meta_use_hw')} C={c_map.get('_meta_use_hw')}", file=sys.stderr)
        return False
    if "_meta_tier_code" not in go_map or "_meta_tier_code" not in c_map:
        print(f"FAIL [{label}] TierCode missing", file=sys.stderr)
        return False
    return True


def strip_meta(kv: dict[str, str]) -> dict[str, str]:
    return {k: v for k, v in kv.items() if not k.startswith("_meta_")}


def main() -> int:
    if not GO_REPO.exists():
        print(f"SKIP: Go reference repo {GO_REPO} not found.")
        return 0

    go_runs: dict[str, dict[str, str]] = {}
    c_runs: dict[str, dict[str, str]] = {}

    with tempfile.TemporaryDirectory() as tmpdir:
        tmp = Path(tmpdir)
        c_sources = [
            "constants.c", "cpu.c", "cpu_amd64.c", "cpu_arm64.c", "cpu_other.c",
            "areion_purec.c", "areion_amd64.c", "areion_arm64.c", "areion_other.c",
            "areion_amd64.S", "areion_soem256_amd64.S", "areion_soem512_amd64.S",
            "areion_soem_aesni_amd64.S", "areion_arm64.S", "areion_test.c",
        ]
        c_only_sources = [
            "constants.c", "cpu.c", "cpu_amd64.c", "cpu_arm64.c", "cpu_other.c",
            "areion_purec.c", "areion_amd64.c", "areion_arm64.c", "areion_other.c",
            "areion_test.c",
        ]

        c_bin_x86 = tmp / "areion_test_x86"
        subprocess.run(
            ["gcc", "-std=c99", "-O3", *[str(C_REPO / s) for s in c_sources], "-o", str(c_bin_x86)],
            check=True,
        )

        go_mod_dir = tmp / "godump"
        go_mod_dir.mkdir()
        (go_mod_dir / "go.mod").write_text(
            f"module godump\n\ngo 1.22\n\n"
            f"require (\n"
            f"\tgithub.com/everanium/areion v0.0.0\n"
            f"\tgolang.org/x/sys v0.49.0 // indirect\n"
            f")\n\n"
            f"replace github.com/everanium/areion => {GO_REPO}\n",
            encoding="utf-8",
        )
        shutil.copy(GO_REPO / "go.sum", go_mod_dir / "go.sum")
        (go_mod_dir / "main.go").write_text(GO_DUMPER_SRC, encoding="utf-8")

        subprocess.run(["go", "mod", "tidy"], cwd=go_mod_dir, check=True)
        go_bin_x86 = tmp / "godump_x86"
        subprocess.run(["go", "build", "-o", str(go_bin_x86), "."], cwd=go_mod_dir, check=True)

        x86_tiers = ["purec", "aesni", "vex", "vaesavx2", "avx512"]
        for tier in x86_tiers:
            c_proc = subprocess.run([str(c_bin_x86), "--dump-kat", tier], capture_output=True, text=True)
            if c_proc.returncode == 2:
                print(f"SKIP tier {tier} (not supported on current CPU)")
                continue
            assert c_proc.returncode == 0, c_proc.stderr
            go_proc = subprocess.run([str(go_bin_x86), tier], capture_output=True, text=True, check=True)

            c_raw = parse_kv(c_proc.stdout)
            go_raw = parse_kv(go_proc.stdout)
            if not check_introspection(f"x86_64/{tier}", tier, go_raw, c_raw):
                return 1
            c_map = strip_meta(c_raw)
            go_map = strip_meta(go_raw)
            for k, go_val in go_map.items():
                c_val = c_map.get(k)
                if c_val != go_val:
                    print(f"FAIL [{tier}] {k}:\n  Go = {go_val}\n  C  = {c_val}", file=sys.stderr)
                    return 1
            go_label = f"x86_64/{'purego' if tier == 'purec' else tier}"
            c_label = f"x86_64/{tier}"
            go_runs[go_label] = go_map
            c_runs[c_label] = c_map
            print(f"PASS [x86_64 tier={tier:8s}]: {len(go_map)} data functions + 3 introspection checks 100% identical")

        if shutil.which("aarch64-linux-gnu-gcc") and shutil.which("qemu-aarch64-static"):
            c_bin_arm64 = tmp / "areion_test_arm64"
            subprocess.run(
                [
                    "aarch64-linux-gnu-gcc", "-std=c99", "-O3", "-march=armv8-a+crypto", "-static",
                    *[str(C_REPO / s) for s in c_sources], "-o", str(c_bin_arm64),
                ],
                check=True,
            )
            go_bin_arm64 = tmp / "godump_arm64"
            env = dict(**subprocess.os.environ, GOOS="linux", GOARCH="arm64", CGO_ENABLED="0")
            subprocess.run(["go", "build", "-o", str(go_bin_arm64), "."], cwd=go_mod_dir, env=env, check=True)

            for tier in ["purec", "arm64"]:
                c_proc = subprocess.run(
                    ["qemu-aarch64-static", "-cpu", "max", str(c_bin_arm64), "--dump-kat", tier],
                    capture_output=True, text=True, check=True,
                )
                go_proc = subprocess.run(
                    ["qemu-aarch64-static", "-cpu", "max", str(go_bin_arm64), tier],
                    capture_output=True, text=True, check=True,
                )
                c_raw = parse_kv(c_proc.stdout)
                go_raw = parse_kv(go_proc.stdout)
                if not check_introspection(f"aarch64/{tier}", tier, go_raw, c_raw):
                    return 1
                c_map = strip_meta(c_raw)
                go_map = strip_meta(go_raw)
                for k, go_val in go_map.items():
                    c_val = c_map.get(k)
                    if c_val != go_val:
                        print(f"FAIL [arm64/{tier}] {k}:\n  Go = {go_val}\n  C  = {c_val}", file=sys.stderr)
                        return 1
                go_label = f"aarch64/{'purego' if tier == 'purec' else tier}"
                c_label = f"aarch64/{tier}"
                go_runs[go_label] = go_map
                c_runs[c_label] = c_map
                print(f"PASS [aarch64 tier={tier:8s}]: {len(go_map)} data functions + 3 introspection checks 100% identical")

        s390x_cc = None
        if shutil.which("s390x-linux-gnu-gcc"):
            s390x_cc = ["s390x-linux-gnu-gcc", "-std=c99", "-O2", "-static"]
        elif shutil.which("zig"):
            s390x_cc = ["zig", "cc", "-target", "s390x-linux-musl", "-std=c99", "-O2", "-static"]

        if s390x_cc is not None and shutil.which("qemu-s390x-static"):
            c_bin_s390x = tmp / "areion_test_s390x"
            subprocess.run(
                [*s390x_cc, *[str(C_REPO / s) for s in c_only_sources], "-o", str(c_bin_s390x)],
                check=True,
            )
            go_bin_s390x = tmp / "godump_s390x"
            env = dict(**subprocess.os.environ, GOOS="linux", GOARCH="s390x", CGO_ENABLED="0")
            subprocess.run(["go", "build", "-o", str(go_bin_s390x), "."], cwd=go_mod_dir, env=env, check=True)

            c_proc = subprocess.run(
                ["qemu-s390x-static", str(c_bin_s390x), "--dump-kat", "purec"],
                capture_output=True, text=True, check=True,
            )
            go_proc = subprocess.run(
                ["qemu-s390x-static", str(go_bin_s390x), "purec"],
                capture_output=True, text=True, check=True,
            )
            c_raw = parse_kv(c_proc.stdout)
            go_raw = parse_kv(go_proc.stdout)
            if not check_introspection("s390x/purec", "purec", go_raw, c_raw):
                return 1
            c_map = strip_meta(c_raw)
            go_map = strip_meta(go_raw)
            for k, go_val in go_map.items():
                c_val = c_map.get(k)
                if c_val != go_val:
                    print(f"FAIL [s390x/purec] {k}:\n  Go = {go_val}\n  C  = {c_val}", file=sys.stderr)
                    return 1
            go_runs["s390x/purego"] = go_map
            c_runs["s390x/purec"] = c_map
            print(f"PASS [s390x   tier=purec   ]: {len(go_map)} data functions + 3 introspection checks 100% identical (Big-Endian)")

    print("\n--- Cross-Language Cartesian Product Matrix Check: Go[tier_A] x C[tier_B] ---")
    pairs_checked = 0
    for go_label, go_map in go_runs.items():
        for c_label, c_map in c_runs.items():
            for k, go_val in go_map.items():
                c_val = c_map.get(k)
                if c_val != go_val:
                    print(f"FAIL Matrix [Go[{go_label}] <-> C[{c_label}]] on {k}:\n  Go = {go_val}\n  C  = {c_val}", file=sys.stderr)
                    return 1
            pairs_checked += 1
            print(f"PASS Matrix Pair [{pairs_checked:2d}]: Go[{go_label:16s}] <-> C[{c_label:16s}] ({len(go_map)} functions + 3 introspection)")

    print(
        f"\nALL CROSS-LANGUAGE GO <-> C KAT CHECKS PASSED "
        f"({len(go_runs)} Go tiers x {len(c_runs)} C tiers = {pairs_checked} matrix pairs)."
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
