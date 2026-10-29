# Copyright (c) 2026 Andrey Kuvshinov
# Dual-licensed under Apache-2.0 OR MIT.

CC      ?= gcc
AR      ?= ar
WARN_FLAGS := -Wpedantic -Wall -Wextra -Wconversion -Wsign-conversion -Wshadow -Wvla \
              -Wstrict-prototypes -Wmissing-prototypes -Wold-style-definition \
              -Wcast-qual -Wcast-align -Wundef -Wformat=2 \
              -fstrict-aliasing -Wstrict-aliasing=2 -Werror
CFI_FLAGS := $(shell if $(CC) -Werror -fcf-protection=full -x c -c /dev/null -o /dev/null 2>/dev/null; then echo -fcf-protection=full; elif $(CC) -Werror -mbranch-protection=standard -x c -c /dev/null -o /dev/null 2>/dev/null; then echo -mbranch-protection=standard; fi)
CFLAGS  ?= -std=c99 $(WARN_FLAGS) -O3 -fPIC -fvisibility=hidden $(CFI_FLAGS)
ASFLAGS ?= $(CFLAGS)
LDFLAGS ?=
SO_LDFLAGS := $(shell if [ "$$(uname -s)" = "Linux" ]; then echo "-Wl,-soname,libareion.so.0 -Wl,-z,relro -Wl,-z,now -Wl,-z,noexecstack"; fi)

LIB_C_SRCS := \
	constants.c \
	cpu.c \
	cpu_amd64.c \
	cpu_arm64.c \
	cpu_other.c \
	areion_purec.c \
	areion_amd64.c \
	areion_arm64.c \
	areion_other.c \
	rijndael_purec.c \
	rijndael_amd64.c \
	rijndael_arm64.c \
	rijndael_other.c \
	vistrutah_purec.c \
	vistrutah_amd64.c \
	vistrutah_arm64.c \
	vistrutah_other.c \
	asura_purec.c \
	asura_amd64.c \
	asura_arm64.c \
	asura_other.c

LIB_ASM_SRCS := \
	areion_amd64.S \
	areion_soem256_amd64.S \
	areion_soem512_amd64.S \
	areion_soem_aesni_amd64.S \
	areion_arm64.S \
	rijndael_amd64.S \
	rijndael_arm64.S \
	vistrutah_amd64.S \
	vistrutah_arm64.S \
	asura_amd64.S \
	asura_arm64.S

LIB_OBJS := $(LIB_C_SRCS:.c=.o) $(LIB_ASM_SRCS:.S=.S.o)

SUPERCOP_SRCS := \
	supercop/crypto_core/areion256/ref/core.c \
	supercop/crypto_core/areion512/ref/core.c \
	supercop/crypto_prf/soem256/ref/prf.c \
	supercop/crypto_prf/soem512/ref/prf.c \
	supercop/crypto_tbc/em256/ref/tbc.c \
	supercop/crypto_tbc/em512/ref/tbc.c \
	supercop/crypto_tbc/em2256/ref/tbc.c \
	supercop/crypto_tbc/em2512/ref/tbc.c \
	supercop/crypto_tbc/tem256/ref/tbc.c \
	supercop/crypto_tbc/tem512/ref/tbc.c \
	supercop/crypto_tbc/tem2256/ref/tbc.c \
	supercop/crypto_tbc/tem2512/ref/tbc.c

.PHONY: all test test-supercop bench cross-kat lint static-check test-sanitizers test-qemu clean

all: libareion.a libareion.so areion_test areion_zeroize_test

%.o: %.c areion.h areion_internal.h
	$(CC) $(CFLAGS) -c $< -o $@

%.S.o: %.S asm_abi.h
	$(CC) $(ASFLAGS) -c $< -o $@

libareion.a: $(LIB_OBJS)
	$(AR) rcs $@ $(LIB_OBJS)

libareion.so: $(LIB_OBJS)
	$(CC) $(CFLAGS) -shared $(SO_LDFLAGS) $(LDFLAGS) -o $@ $(LIB_OBJS)

areion_test.o: areion_test.c areion.h areion_internal.h
	$(CC) $(CFLAGS) -pthread -c $< -o $@

areion_test: areion_test.o libareion.a
	$(CC) $(CFLAGS) -pthread $(LDFLAGS) -o $@ areion_test.o libareion.a

areion_zeroize_test: areion_zeroize_test.o libareion.a
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ areion_zeroize_test.o libareion.a

test-supercop:
	@for src in $(SUPERCOP_SRCS); do \
		$(CC) $(CFLAGS) -c $$src -o /dev/null || exit 1; \
	done

test: libareion.so areion_test areion_zeroize_test test-supercop
	./areion_test
	./areion_zeroize_test
	python3 scripts/verify_p2_table.py
	python3 scripts/verify_asura_kat.py
	python3 scripts/audit_asm_epilogues.py
	@if command -v readelf >/dev/null 2>&1 && [ -f libareion.so ]; then \
		readelf -lW libareion.so | grep -q "GNU_STACK" && ! readelf -lW libareion.so | grep "GNU_STACK" | grep -q "RWE" || { echo "FAIL: executable stack in libareion.so"; exit 1; }; \
		if uname -m | grep -Eq '^(x86_64|amd64)$$'; then \
			for obj in areion_amd64.S.o rijndael_amd64.S.o vistrutah_amd64.S.o asura_amd64.S.o; do \
				readelf -n $$obj | grep -q "IBT" && readelf -n $$obj | grep -q "SHSTK" || { echo "FAIL: missing CET IBT/SHSTK in $$obj"; exit 1; }; \
			done; \
		elif uname -m | grep -Eq '^(aarch64|arm64)$$'; then \
			for obj in areion_arm64.S.o rijndael_arm64.S.o vistrutah_arm64.S.o asura_arm64.S.o; do \
				readelf -n $$obj | grep -q "BTI" || { echo "FAIL: missing BTI in $$obj"; exit 1; }; \
			done; \
		fi; \
	fi
	@if command -v nm >/dev/null 2>&1 && [ -f libareion.so ]; then \
		if [ "$$(uname -s)" = "Darwin" ]; then \
			bad_syms=$$(nm -gU libareion.so | awk '$$2 ~ /^[TWBDRV]$$/ {sub(/^_/, "", $$3); if ($$3 !~ /^_?areion_/) print $$3}'); \
		else \
			bad_syms=$$(nm -D --defined-only libareion.so | awk '$$2 ~ /^[TWBDRV]$$/ && $$3 !~ /^_?areion_/ && $$3 !~ /^(_init|_fini|__bss_start|_edata|_end)$$/ {print $$3}'); \
		fi; \
		if [ -n "$$bad_syms" ]; then echo "FAIL: unexpected exported symbols in libareion.so: $$bad_syms"; exit 1; fi; \
	fi

bench: areion_test
	./areion_test --bench

cross-kat:
	python3 scripts/verify_cross_kat.py

LINT_SRCS := $(LIB_C_SRCS) areion_test.c areion_zeroize_test.c
TIDY_CHECKS := -*,bugprone-*,cert-*,clang-analyzer-*,misc-*,performance-*,portability-*,security-*,-misc-include-cleaner,-bugprone-easily-swappable-parameters,-cert-msc32-c,-cert-msc51-cpp,-portability-no-assembler

lint static-check:
	gcc -std=c99 $(WARN_FLAGS) -O2 -fanalyzer -fsyntax-only $(LINT_SRCS)
	clang-tidy --checks="$(TIDY_CHECKS)" --warnings-as-errors="*" $(LINT_SRCS) -- -std=c99 $(WARN_FLAGS) -I.
	cppcheck --force --enable=all --inconclusive --std=c99 --error-exitcode=1 \
		--suppress=missingIncludeSystem --suppress=unusedFunction \
		--suppress=unmatchedSuppression --suppress=normalCheckLevelMaxBranches \
		--suppress=checkLevelNormal --suppress=checkersReport .
	flawfinder --error-level=4 .
	scan-build --status-bugs $(MAKE) clean all test

ALL_SRCS := $(LIB_C_SRCS) $(LIB_ASM_SRCS)

test-sanitizers:
	@mkdir -p build/san
	gcc -std=c99 $(WARN_FLAGS) -O2 -fsanitize=address,undefined -fno-sanitize-recover=all -fno-omit-frame-pointer $(ALL_SRCS) areion_test.c -o build/san/test_gcc_asan && ./build/san/test_gcc_asan
	gcc -std=c99 $(WARN_FLAGS) -O2 -fsanitize=address,undefined -fno-sanitize-recover=all -fno-omit-frame-pointer $(ALL_SRCS) areion_zeroize_test.c -o build/san/zero_gcc_asan && ./build/san/zero_gcc_asan
	clang -std=c99 $(WARN_FLAGS) -O2 -fsanitize=address,undefined -fno-sanitize-recover=all -fno-omit-frame-pointer $(ALL_SRCS) areion_test.c -o build/san/test_clang_asan && ./build/san/test_clang_asan
	clang -std=c99 $(WARN_FLAGS) -O2 -fsanitize=address,undefined -fno-sanitize-recover=all -fno-omit-frame-pointer $(ALL_SRCS) areion_zeroize_test.c -o build/san/zero_clang_asan && ./build/san/zero_clang_asan
	clang -std=c99 $(WARN_FLAGS) -O2 -fsanitize=undefined -fno-sanitize-recover=all -fno-omit-frame-pointer $(ALL_SRCS) areion_zeroize_test.c -o build/san/zero_clang_ubsan && ./build/san/zero_clang_ubsan
	clang -std=c99 $(WARN_FLAGS) -O2 -fsanitize=memory -fno-omit-frame-pointer $(ALL_SRCS) areion_test.c -o build/san/test_clang_msan && ./build/san/test_clang_msan
	clang -std=c99 $(WARN_FLAGS) -O2 -fsanitize=memory -fno-omit-frame-pointer $(ALL_SRCS) areion_zeroize_test.c -o build/san/zero_clang_msan && ./build/san/zero_clang_msan
	clang -std=c99 $(WARN_FLAGS) -O2 -fsanitize=thread -pthread $(ALL_SRCS) areion_test.c -o build/san/test_clang_tsan && ./build/san/test_clang_tsan
	gcc -std=c99 $(WARN_FLAGS) -O2 -pthread $(ALL_SRCS) areion_test.c -o build/san/test_pthread
	valgrind --tool=helgrind --error-exitcode=1 ./build/san/test_pthread
	valgrind --tool=drd --error-exitcode=1 ./build/san/test_pthread
	gcc -std=c99 $(WARN_FLAGS) -O2 $(ALL_SRCS) areion_test.c -o build/san/test_vg
	gcc -std=c99 $(WARN_FLAGS) -O2 $(ALL_SRCS) areion_zeroize_test.c -o build/san/zero_vg
	valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes --error-exitcode=1 ./build/san/test_vg
	valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes --error-exitcode=1 ./build/san/zero_vg
	@rm -rf build/san

test-qemu:
	@mkdir -p build/qemu
	aarch64-linux-gnu-gcc -std=c99 $(WARN_FLAGS) -O3 -march=armv8-a+crypto -static $(LIB_C_SRCS) areion_arm64.S rijndael_arm64.S vistrutah_arm64.S asura_arm64.S areion_test.c -o build/qemu/test_aarch64 && qemu-aarch64-static -cpu max ./build/qemu/test_aarch64
	aarch64-linux-gnu-gcc -std=c99 $(WARN_FLAGS) -O3 -march=armv8-a+crypto -static $(LIB_C_SRCS) areion_arm64.S rijndael_arm64.S vistrutah_arm64.S asura_arm64.S areion_zeroize_test.c -o build/qemu/zero_aarch64 && qemu-aarch64-static -cpu max ./build/qemu/zero_aarch64
	zig cc -target riscv64-linux-musl -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_test.c -o build/qemu/test_riscv64 && qemu-riscv64-static ./build/qemu/test_riscv64
	zig cc -target riscv64-linux-musl -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_zeroize_test.c -o build/qemu/zero_riscv64 && qemu-riscv64-static ./build/qemu/zero_riscv64
	zig cc -target s390x-linux-musl -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_test.c -o build/qemu/test_s390x && qemu-s390x-static ./build/qemu/test_s390x
	zig cc -target s390x-linux-musl -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_zeroize_test.c -o build/qemu/zero_s390x && qemu-s390x-static ./build/qemu/zero_s390x
	zig cc -target powerpc64le-linux-musl -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_test.c -o build/qemu/test_ppc64le && qemu-ppc64le-static ./build/qemu/test_ppc64le
	zig cc -target powerpc64le-linux-musl -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_zeroize_test.c -o build/qemu/zero_ppc64le && qemu-ppc64le-static ./build/qemu/zero_ppc64le
	zig cc -target arm-linux-musleabihf -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_test.c -o build/qemu/test_arm && qemu-arm-static ./build/qemu/test_arm
	zig cc -target arm-linux-musleabihf -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_zeroize_test.c -o build/qemu/zero_arm && qemu-arm-static ./build/qemu/zero_arm
	zig cc -target x86-linux-musl -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_test.c -o build/qemu/test_i386 && qemu-i386-static ./build/qemu/test_i386
	zig cc -target x86-linux-musl -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_zeroize_test.c -o build/qemu/zero_i386 && qemu-i386-static ./build/qemu/zero_i386
	zig cc -target mips64-linux-muslabi64 -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_test.c -o build/qemu/test_mips64 && qemu-mips64-static ./build/qemu/test_mips64
	zig cc -target mips64-linux-muslabi64 -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_zeroize_test.c -o build/qemu/zero_mips64 && qemu-mips64-static ./build/qemu/zero_mips64
	zig cc -target mips-linux-musleabi -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_test.c -o build/qemu/test_mips && qemu-mips-static ./build/qemu/test_mips
	zig cc -target mips-linux-musleabi -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_zeroize_test.c -o build/qemu/zero_mips && qemu-mips-static ./build/qemu/zero_mips
	zig cc -target loongarch64-linux-musl -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_test.c -o build/qemu/test_loongarch64 && qemu-loongarch64-static ./build/qemu/test_loongarch64
	zig cc -target loongarch64-linux-musl -std=c99 $(WARN_FLAGS) -Wno-option-ignored -O2 -static $(LIB_C_SRCS) areion_zeroize_test.c -o build/qemu/zero_loongarch64 && qemu-loongarch64-static ./build/qemu/zero_loongarch64
	@rm -rf build/qemu

clean:
	rm -f $(LIB_OBJS) areion_test.o areion_zeroize_test.o \
	      libareion.a libareion.so areion_test areion_zeroize_test \
	      *.exe *.gcda *.gcno *.gcov coverage.info
	rm -rf build
