; Copyright (c) 2026 Andrey Kuvshinov
; SPDX-License-Identifier: Apache-2.0 OR MIT

EXTERN roundConstantsP1:BYTE
EXTERN roundConstantsP2:BYTE
EXTERN areionRC4x:BYTE
EXTERN areionRC4x2:BYTE

.code

PUBLIC aesRoundAsm
ALIGN 16
aesRoundAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov r10, rdx
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [r10]
    aesenc xmm0, xmm1
    movdqu XMMWORD PTR [rax], xmm0
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    xor rax, rax
    xor r10, r10
    ret
aesRoundAsm ENDP

PUBLIC aesRoundVexAsm
ALIGN 16
aesRoundVexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov r10, rdx
    vmovdqu xmm0, XMMWORD PTR [rax]
    vaesenc xmm0, xmm0, XMMWORD PTR [r10]
    vmovdqu XMMWORD PTR [rax], xmm0
    vpxor xmm0, xmm0, xmm0
    xor rax, rax
    xor r10, r10
    ret
aesRoundVexAsm ENDP

PUBLIC aesFinalRoundAsm
ALIGN 16
aesFinalRoundAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov r10, rdx
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [r10]
    aesenclast xmm0, xmm1
    movdqu XMMWORD PTR [rax], xmm0
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    xor rax, rax
    xor r10, r10
    ret
aesFinalRoundAsm ENDP

PUBLIC aesFinalRoundVexAsm
ALIGN 16
aesFinalRoundVexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov r10, rdx
    vmovdqu xmm0, XMMWORD PTR [rax]
    vaesenclast xmm0, xmm0, XMMWORD PTR [r10]
    vmovdqu XMMWORD PTR [rax], xmm0
    vpxor xmm0, xmm0, xmm0
    xor rax, rax
    xor r10, r10
    ret
aesFinalRoundVexAsm ENDP

PUBLIC aesRound4ZmmAsm
ALIGN 16
aesRound4ZmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov r10, rdx
    vmovdqu64 zmm0, ZMMWORD PTR [rax]
    vaesenc zmm0, zmm0, ZMMWORD PTR [r10]
    vmovdqu64 ZMMWORD PTR [rax], zmm0
    vpxord xmm0, xmm0, xmm0
    xor rax, rax
    xor r10, r10
    vzeroupper
    ret
aesRound4ZmmAsm ENDP

PUBLIC aesFinalRound4ZmmAsm
ALIGN 16
aesFinalRound4ZmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov r10, rdx
    vmovdqu64 zmm0, ZMMWORD PTR [rax]
    vaesenclast zmm0, zmm0, ZMMWORD PTR [r10]
    vmovdqu64 ZMMWORD PTR [rax], zmm0
    vpxord xmm0, xmm0, xmm0
    xor rax, rax
    xor r10, r10
    vzeroupper
    ret
aesFinalRound4ZmmAsm ENDP

PUBLIC aesRound4YmmAsm
ALIGN 16
aesRound4YmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov r10, rdx
    vmovdqu ymm0, YMMWORD PTR [rax]
    vmovdqu ymm1, YMMWORD PTR [rax + 32]
    vaesenc ymm0, ymm0, YMMWORD PTR [r10]
    vaesenc ymm1, ymm1, YMMWORD PTR [r10 + 32]
    vmovdqu YMMWORD PTR [rax], ymm0
    vmovdqu YMMWORD PTR [rax + 32], ymm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    xor rax, rax
    xor r10, r10
    vzeroupper
    ret
aesRound4YmmAsm ENDP

PUBLIC aesFinalRound4YmmAsm
ALIGN 16
aesFinalRound4YmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov r10, rdx
    vmovdqu ymm0, YMMWORD PTR [rax]
    vmovdqu ymm1, YMMWORD PTR [rax + 32]
    vaesenclast ymm0, ymm0, YMMWORD PTR [r10]
    vaesenclast ymm1, ymm1, YMMWORD PTR [r10 + 32]
    vmovdqu YMMWORD PTR [rax], ymm0
    vmovdqu YMMWORD PTR [rax + 32], ymm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    xor rax, rax
    xor r10, r10
    vzeroupper
    ret
aesFinalRound4YmmAsm ENDP

PUBLIC aesRound4VexAsm
ALIGN 16
aesRound4VexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov r10, rdx
    vmovdqu xmm0, XMMWORD PTR [rax]
    vmovdqu xmm1, XMMWORD PTR [rax + 16]
    vmovdqu xmm2, XMMWORD PTR [rax + 32]
    vmovdqu xmm3, XMMWORD PTR [rax + 48]
    vaesenc xmm0, xmm0, XMMWORD PTR [r10]
    vaesenc xmm1, xmm1, XMMWORD PTR [r10 + 16]
    vaesenc xmm2, xmm2, XMMWORD PTR [r10 + 32]
    vaesenc xmm3, xmm3, XMMWORD PTR [r10 + 48]
    vmovdqu XMMWORD PTR [rax], xmm0
    vmovdqu XMMWORD PTR [rax + 16], xmm1
    vmovdqu XMMWORD PTR [rax + 32], xmm2
    vmovdqu XMMWORD PTR [rax + 48], xmm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    xor rax, rax
    xor r10, r10
    ret
aesRound4VexAsm ENDP

PUBLIC aesFinalRound4VexAsm
ALIGN 16
aesFinalRound4VexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov r10, rdx
    vmovdqu xmm0, XMMWORD PTR [rax]
    vmovdqu xmm1, XMMWORD PTR [rax + 16]
    vmovdqu xmm2, XMMWORD PTR [rax + 32]
    vmovdqu xmm3, XMMWORD PTR [rax + 48]
    vaesenclast xmm0, xmm0, XMMWORD PTR [r10]
    vaesenclast xmm1, xmm1, XMMWORD PTR [r10 + 16]
    vaesenclast xmm2, xmm2, XMMWORD PTR [r10 + 32]
    vaesenclast xmm3, xmm3, XMMWORD PTR [r10 + 48]
    vmovdqu XMMWORD PTR [rax], xmm0
    vmovdqu XMMWORD PTR [rax + 16], xmm1
    vmovdqu XMMWORD PTR [rax + 32], xmm2
    vmovdqu XMMWORD PTR [rax + 48], xmm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    xor rax, rax
    xor r10, r10
    ret
aesFinalRound4VexAsm ENDP

PUBLIC aesRound4AesNiAsm
ALIGN 16
aesRound4AesNiAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 40
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    mov rax, rcx
    mov r10, rdx
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [rax + 16]
    movdqu xmm2, XMMWORD PTR [rax + 32]
    movdqu xmm3, XMMWORD PTR [rax + 48]
    movdqu xmm4, XMMWORD PTR [r10]
    movdqu xmm5, XMMWORD PTR [r10 + 16]
    movdqu xmm6, XMMWORD PTR [r10 + 32]
    movdqu xmm7, XMMWORD PTR [r10 + 48]
    aesenc xmm0, xmm4
    aesenc xmm1, xmm5
    aesenc xmm2, xmm6
    aesenc xmm3, xmm7
    movdqu XMMWORD PTR [rax], xmm0
    movdqu XMMWORD PTR [rax + 16], xmm1
    movdqu XMMWORD PTR [rax + 32], xmm2
    movdqu XMMWORD PTR [rax + 48], xmm3
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    xor rax, rax
    xor r10, r10
    movdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    add rsp, 40
    ret
aesRound4AesNiAsm ENDP

PUBLIC aesFinalRound4AesNiAsm
ALIGN 16
aesFinalRound4AesNiAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 40
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    mov rax, rcx
    mov r10, rdx
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [rax + 16]
    movdqu xmm2, XMMWORD PTR [rax + 32]
    movdqu xmm3, XMMWORD PTR [rax + 48]
    movdqu xmm4, XMMWORD PTR [r10]
    movdqu xmm5, XMMWORD PTR [r10 + 16]
    movdqu xmm6, XMMWORD PTR [r10 + 32]
    movdqu xmm7, XMMWORD PTR [r10 + 48]
    aesenclast xmm0, xmm4
    aesenclast xmm1, xmm5
    aesenclast xmm2, xmm6
    aesenclast xmm3, xmm7
    movdqu XMMWORD PTR [rax], xmm0
    movdqu XMMWORD PTR [rax + 16], xmm1
    movdqu XMMWORD PTR [rax + 32], xmm2
    movdqu XMMWORD PTR [rax + 48], xmm3
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    xor rax, rax
    xor r10, r10
    movdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    add rsp, 40
    ret
aesFinalRound4AesNiAsm ENDP

PUBLIC aes128EncryptBlockAsm
ALIGN 16
aes128EncryptBlockAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov rcx, r8
    movdqu xmm0, XMMWORD PTR [rcx]
    movdqu xmm1, XMMWORD PTR [rax]
    pxor xmm0, xmm1
    movdqu xmm1, XMMWORD PTR [rax + 16]
    aesenc xmm0, xmm1
    movdqu xmm1, XMMWORD PTR [rax + 32]
    aesenc xmm0, xmm1
    movdqu xmm1, XMMWORD PTR [rax + 48]
    aesenc xmm0, xmm1
    movdqu xmm1, XMMWORD PTR [rax + 64]
    aesenc xmm0, xmm1
    movdqu xmm1, XMMWORD PTR [rax + 80]
    aesenc xmm0, xmm1
    movdqu xmm1, XMMWORD PTR [rax + 96]
    aesenc xmm0, xmm1
    movdqu xmm1, XMMWORD PTR [rax + 112]
    aesenc xmm0, xmm1
    movdqu xmm1, XMMWORD PTR [rax + 128]
    aesenc xmm0, xmm1
    movdqu xmm1, XMMWORD PTR [rax + 144]
    aesenc xmm0, xmm1
    movdqu xmm1, XMMWORD PTR [rax + 160]
    aesenclast xmm0, xmm1
    movdqu XMMWORD PTR [rdx], xmm0
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx
    ret
aes128EncryptBlockAsm ENDP

PUBLIC aes128EncryptBlockVexAsm
ALIGN 16
aes128EncryptBlockVexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov rcx, r8
    vmovdqu xmm0, XMMWORD PTR [rcx]
    vpxor xmm0, xmm0, XMMWORD PTR [rax]
    vaesenc xmm0, xmm0, XMMWORD PTR [rax + 16]
    vaesenc xmm0, xmm0, XMMWORD PTR [rax + 32]
    vaesenc xmm0, xmm0, XMMWORD PTR [rax + 48]
    vaesenc xmm0, xmm0, XMMWORD PTR [rax + 64]
    vaesenc xmm0, xmm0, XMMWORD PTR [rax + 80]
    vaesenc xmm0, xmm0, XMMWORD PTR [rax + 96]
    vaesenc xmm0, xmm0, XMMWORD PTR [rax + 112]
    vaesenc xmm0, xmm0, XMMWORD PTR [rax + 128]
    vaesenc xmm0, xmm0, XMMWORD PTR [rax + 144]
    vaesenclast xmm0, xmm0, XMMWORD PTR [rax + 160]
    vmovdqu XMMWORD PTR [rdx], xmm0
    vpxor xmm0, xmm0, xmm0
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx
    ret
aes128EncryptBlockVexAsm ENDP

PUBLIC aes128Encrypt4BlocksZmmAsm
ALIGN 16
aes128Encrypt4BlocksZmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov rcx, r8
    vmovdqu64 zmm0, ZMMWORD PTR [rcx]
    vbroadcasti32x4 zmm1, XMMWORD PTR [rax]
    vpxorq zmm0, zmm0, zmm1
    vbroadcasti32x4 zmm1, XMMWORD PTR [rax + 16]
    vaesenc zmm0, zmm0, zmm1
    vbroadcasti32x4 zmm1, XMMWORD PTR [rax + 32]
    vaesenc zmm0, zmm0, zmm1
    vbroadcasti32x4 zmm1, XMMWORD PTR [rax + 48]
    vaesenc zmm0, zmm0, zmm1
    vbroadcasti32x4 zmm1, XMMWORD PTR [rax + 64]
    vaesenc zmm0, zmm0, zmm1
    vbroadcasti32x4 zmm1, XMMWORD PTR [rax + 80]
    vaesenc zmm0, zmm0, zmm1
    vbroadcasti32x4 zmm1, XMMWORD PTR [rax + 96]
    vaesenc zmm0, zmm0, zmm1
    vbroadcasti32x4 zmm1, XMMWORD PTR [rax + 112]
    vaesenc zmm0, zmm0, zmm1
    vbroadcasti32x4 zmm1, XMMWORD PTR [rax + 128]
    vaesenc zmm0, zmm0, zmm1
    vbroadcasti32x4 zmm1, XMMWORD PTR [rax + 144]
    vaesenc zmm0, zmm0, zmm1
    vbroadcasti32x4 zmm1, XMMWORD PTR [rax + 160]
    vaesenclast zmm0, zmm0, zmm1
    vmovdqu64 ZMMWORD PTR [rdx], zmm0
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx
    vzeroupper
    ret
aes128Encrypt4BlocksZmmAsm ENDP

PUBLIC aes128Encrypt4BlocksYmmAsm
ALIGN 16
aes128Encrypt4BlocksYmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov rcx, r8
    vmovdqu ymm0, YMMWORD PTR [rcx]
    vmovdqu ymm1, YMMWORD PTR [rcx + 32]
    vbroadcasti128 ymm2, XMMWORD PTR [rax]
    vpxor ymm0, ymm0, ymm2
    vpxor ymm1, ymm1, ymm2
    vbroadcasti128 ymm2, XMMWORD PTR [rax + 16]
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm2
    vbroadcasti128 ymm2, XMMWORD PTR [rax + 32]
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm2
    vbroadcasti128 ymm2, XMMWORD PTR [rax + 48]
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm2
    vbroadcasti128 ymm2, XMMWORD PTR [rax + 64]
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm2
    vbroadcasti128 ymm2, XMMWORD PTR [rax + 80]
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm2
    vbroadcasti128 ymm2, XMMWORD PTR [rax + 96]
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm2
    vbroadcasti128 ymm2, XMMWORD PTR [rax + 112]
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm2
    vbroadcasti128 ymm2, XMMWORD PTR [rax + 128]
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm2
    vbroadcasti128 ymm2, XMMWORD PTR [rax + 144]
    vaesenc ymm0, ymm0, ymm2
    vaesenc ymm1, ymm1, ymm2
    vbroadcasti128 ymm2, XMMWORD PTR [rax + 160]
    vaesenclast ymm0, ymm0, ymm2
    vaesenclast ymm1, ymm1, ymm2
    vmovdqu YMMWORD PTR [rdx], ymm0
    vmovdqu YMMWORD PTR [rdx + 32], ymm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx
    vzeroupper
    ret
aes128Encrypt4BlocksYmmAsm ENDP

PUBLIC aes128Encrypt4BlocksVexAsm
ALIGN 16
aes128Encrypt4BlocksVexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov rcx, r8
    vmovdqu xmm0, XMMWORD PTR [rcx]
    vmovdqu xmm1, XMMWORD PTR [rcx + 16]
    vmovdqu xmm2, XMMWORD PTR [rcx + 32]
    vmovdqu xmm3, XMMWORD PTR [rcx + 48]
    vmovdqu xmm4, XMMWORD PTR [rax]
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm4
    vpxor xmm2, xmm2, xmm4
    vpxor xmm3, xmm3, xmm4
    vmovdqu xmm4, XMMWORD PTR [rax + 16]
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm4
    vaesenc xmm2, xmm2, xmm4
    vaesenc xmm3, xmm3, xmm4
    vmovdqu xmm4, XMMWORD PTR [rax + 32]
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm4
    vaesenc xmm2, xmm2, xmm4
    vaesenc xmm3, xmm3, xmm4
    vmovdqu xmm4, XMMWORD PTR [rax + 48]
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm4
    vaesenc xmm2, xmm2, xmm4
    vaesenc xmm3, xmm3, xmm4
    vmovdqu xmm4, XMMWORD PTR [rax + 64]
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm4
    vaesenc xmm2, xmm2, xmm4
    vaesenc xmm3, xmm3, xmm4
    vmovdqu xmm4, XMMWORD PTR [rax + 80]
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm4
    vaesenc xmm2, xmm2, xmm4
    vaesenc xmm3, xmm3, xmm4
    vmovdqu xmm4, XMMWORD PTR [rax + 96]
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm4
    vaesenc xmm2, xmm2, xmm4
    vaesenc xmm3, xmm3, xmm4
    vmovdqu xmm4, XMMWORD PTR [rax + 112]
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm4
    vaesenc xmm2, xmm2, xmm4
    vaesenc xmm3, xmm3, xmm4
    vmovdqu xmm4, XMMWORD PTR [rax + 128]
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm4
    vaesenc xmm2, xmm2, xmm4
    vaesenc xmm3, xmm3, xmm4
    vmovdqu xmm4, XMMWORD PTR [rax + 144]
    vaesenc xmm0, xmm0, xmm4
    vaesenc xmm1, xmm1, xmm4
    vaesenc xmm2, xmm2, xmm4
    vaesenc xmm3, xmm3, xmm4
    vmovdqu xmm4, XMMWORD PTR [rax + 160]
    vaesenclast xmm0, xmm0, xmm4
    vaesenclast xmm1, xmm1, xmm4
    vaesenclast xmm2, xmm2, xmm4
    vaesenclast xmm3, xmm3, xmm4
    vmovdqu XMMWORD PTR [rdx], xmm0
    vmovdqu XMMWORD PTR [rdx + 16], xmm1
    vmovdqu XMMWORD PTR [rdx + 32], xmm2
    vmovdqu XMMWORD PTR [rdx + 48], xmm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx
    ret
aes128Encrypt4BlocksVexAsm ENDP

PUBLIC aes128Encrypt4BlocksAesNiAsm
ALIGN 16
aes128Encrypt4BlocksAesNiAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov rcx, r8
    movdqu xmm0, XMMWORD PTR [rcx]
    movdqu xmm1, XMMWORD PTR [rcx + 16]
    movdqu xmm2, XMMWORD PTR [rcx + 32]
    movdqu xmm3, XMMWORD PTR [rcx + 48]
    movdqu xmm4, XMMWORD PTR [rax]
    pxor xmm0, xmm4
    pxor xmm1, xmm4
    pxor xmm2, xmm4
    pxor xmm3, xmm4
    movdqu xmm4, XMMWORD PTR [rax + 16]
    aesenc xmm0, xmm4
    aesenc xmm1, xmm4
    aesenc xmm2, xmm4
    aesenc xmm3, xmm4
    movdqu xmm4, XMMWORD PTR [rax + 32]
    aesenc xmm0, xmm4
    aesenc xmm1, xmm4
    aesenc xmm2, xmm4
    aesenc xmm3, xmm4
    movdqu xmm4, XMMWORD PTR [rax + 48]
    aesenc xmm0, xmm4
    aesenc xmm1, xmm4
    aesenc xmm2, xmm4
    aesenc xmm3, xmm4
    movdqu xmm4, XMMWORD PTR [rax + 64]
    aesenc xmm0, xmm4
    aesenc xmm1, xmm4
    aesenc xmm2, xmm4
    aesenc xmm3, xmm4
    movdqu xmm4, XMMWORD PTR [rax + 80]
    aesenc xmm0, xmm4
    aesenc xmm1, xmm4
    aesenc xmm2, xmm4
    aesenc xmm3, xmm4
    movdqu xmm4, XMMWORD PTR [rax + 96]
    aesenc xmm0, xmm4
    aesenc xmm1, xmm4
    aesenc xmm2, xmm4
    aesenc xmm3, xmm4
    movdqu xmm4, XMMWORD PTR [rax + 112]
    aesenc xmm0, xmm4
    aesenc xmm1, xmm4
    aesenc xmm2, xmm4
    aesenc xmm3, xmm4
    movdqu xmm4, XMMWORD PTR [rax + 128]
    aesenc xmm0, xmm4
    aesenc xmm1, xmm4
    aesenc xmm2, xmm4
    aesenc xmm3, xmm4
    movdqu xmm4, XMMWORD PTR [rax + 144]
    aesenc xmm0, xmm4
    aesenc xmm1, xmm4
    aesenc xmm2, xmm4
    aesenc xmm3, xmm4
    movdqu xmm4, XMMWORD PTR [rax + 160]
    aesenclast xmm0, xmm4
    aesenclast xmm1, xmm4
    aesenclast xmm2, xmm4
    aesenclast xmm3, xmm4
    movdqu XMMWORD PTR [rdx], xmm0
    movdqu XMMWORD PTR [rdx + 16], xmm1
    movdqu XMMWORD PTR [rdx + 32], xmm2
    movdqu XMMWORD PTR [rdx + 48], xmm3
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx
    ret
aes128Encrypt4BlocksAesNiAsm ENDP

PUBLIC areion256PermuteRCAsm
ALIGN 16
areion256PermuteRCAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    movdqu XMMWORD PTR [rsp + 0], xmm15
    mov rax, rcx
    mov r10, rdx
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [rax + 16]
    pxor xmm15, xmm15
    movdqu xmm2, XMMWORD PTR [r10]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 16]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 48]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 64]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 80]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 96]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 112]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 128]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 144]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu XMMWORD PTR [rax], xmm0
    movdqu XMMWORD PTR [rax + 16], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    movdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion256PermuteRCAsm ENDP

PUBLIC areion256PermuteVexRCAsm
ALIGN 16
areion256PermuteVexRCAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    vmovdqu XMMWORD PTR [rsp + 0], xmm15
    mov rax, rcx
    mov r10, rdx
    vmovdqu xmm0, XMMWORD PTR [rax]
    vmovdqu xmm1, XMMWORD PTR [rax + 16]
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [r10]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [r10 + 16]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [r10 + 32]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [r10 + 48]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [r10 + 64]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [r10 + 80]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [r10 + 96]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [r10 + 112]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [r10 + 128]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [r10 + 144]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vmovdqu XMMWORD PTR [rax], xmm0
    vmovdqu XMMWORD PTR [rax + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm3, xmm3, xmm3
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    vmovdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion256PermuteVexRCAsm ENDP

PUBLIC areion256InversePermuteRCAsm
ALIGN 16
areion256InversePermuteRCAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    movdqu XMMWORD PTR [rsp + 0], xmm15
    mov rax, rcx
    mov r10, rdx
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [rax + 16]
    pxor xmm15, xmm15
    movdqu xmm2, XMMWORD PTR [r10 + 144]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 128]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 112]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 96]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 80]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 64]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 48]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [r10 + 16]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [r10]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu XMMWORD PTR [rax], xmm0
    movdqu XMMWORD PTR [rax + 16], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    movdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion256InversePermuteRCAsm ENDP

PUBLIC areion256InversePermuteVexRCAsm
ALIGN 16
areion256InversePermuteVexRCAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    vmovdqu XMMWORD PTR [rsp + 0], xmm15
    mov rax, rcx
    mov r10, rdx
    vmovdqu xmm0, XMMWORD PTR [rax]
    vmovdqu xmm1, XMMWORD PTR [rax + 16]
    vpxor xmm15, xmm15, xmm15
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [r10 + 144]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [r10 + 128]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [r10 + 112]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [r10 + 96]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [r10 + 80]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [r10 + 64]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [r10 + 48]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [r10 + 32]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [r10 + 16]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [r10]
    vaesenc xmm1, xmm3, xmm1
    vmovdqu XMMWORD PTR [rax], xmm0
    vmovdqu XMMWORD PTR [rax + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm3, xmm3, xmm3
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    vmovdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion256InversePermuteVexRCAsm ENDP

PUBLIC areion512PermuteRCAsm
ALIGN 16
areion512PermuteRCAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    movdqu XMMWORD PTR [rsp + 0], xmm15
    mov rax, rcx
    mov r10, rdx
    movdqu xmm0, XMMWORD PTR [rax]
    movdqu xmm1, XMMWORD PTR [rax + 16]
    movdqu xmm2, XMMWORD PTR [rax + 32]
    movdqu xmm3, XMMWORD PTR [rax + 48]
    pxor xmm15, xmm15
    movdqu xmm4, XMMWORD PTR [r10]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [r10 + 16]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [r10 + 32]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [r10 + 48]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [r10 + 64]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [r10 + 80]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [r10 + 96]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [r10 + 112]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [r10 + 128]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [r10 + 144]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [r10 + 160]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [r10 + 176]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [r10 + 192]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [r10 + 208]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [r10 + 224]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu XMMWORD PTR [rax], xmm3
    movdqu XMMWORD PTR [rax + 16], xmm0
    movdqu XMMWORD PTR [rax + 32], xmm1
    movdqu XMMWORD PTR [rax + 48], xmm2
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    movdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion512PermuteRCAsm ENDP

PUBLIC areion512PermuteVexRCAsm
ALIGN 16
areion512PermuteVexRCAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    vmovdqu XMMWORD PTR [rsp + 0], xmm15
    mov rax, rcx
    mov r10, rdx
    vmovdqu xmm0, XMMWORD PTR [rax]
    vmovdqu xmm1, XMMWORD PTR [rax + 16]
    vmovdqu xmm2, XMMWORD PTR [rax + 32]
    vmovdqu xmm3, XMMWORD PTR [rax + 48]
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [r10]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [r10 + 16]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [r10 + 32]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [r10 + 48]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [r10 + 64]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [r10 + 80]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [r10 + 96]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [r10 + 112]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [r10 + 128]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [r10 + 144]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [r10 + 160]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [r10 + 176]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [r10 + 192]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [r10 + 208]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [r10 + 224]
    vaesenc xmm0, xmm0, xmm15
    vmovdqu XMMWORD PTR [rax], xmm3
    vmovdqu XMMWORD PTR [rax + 16], xmm0
    vmovdqu XMMWORD PTR [rax + 32], xmm1
    vmovdqu XMMWORD PTR [rax + 48], xmm2
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    vmovdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion512PermuteVexRCAsm ENDP

PUBLIC areion512InversePermuteRCAsm
ALIGN 16
areion512InversePermuteRCAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    movdqu XMMWORD PTR [rsp + 0], xmm15
    mov rax, rcx
    mov r10, rdx
    movdqu xmm0, XMMWORD PTR [rax + 16]
    movdqu xmm1, XMMWORD PTR [rax + 32]
    movdqu xmm2, XMMWORD PTR [rax + 48]
    movdqu xmm3, XMMWORD PTR [rax]
    pxor xmm15, xmm15
    movdqu xmm4, XMMWORD PTR [r10 + 224]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [r10 + 208]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [r10 + 192]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [r10 + 176]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [r10 + 160]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [r10 + 144]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [r10 + 128]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [r10 + 112]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [r10 + 96]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [r10 + 80]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [r10 + 64]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [r10 + 48]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [r10 + 32]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [r10 + 16]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [r10]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu XMMWORD PTR [rax], xmm0
    movdqu XMMWORD PTR [rax + 16], xmm1
    movdqu XMMWORD PTR [rax + 32], xmm2
    movdqu XMMWORD PTR [rax + 48], xmm3
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    movdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion512InversePermuteRCAsm ENDP

PUBLIC areion512InversePermuteVexRCAsm
ALIGN 16
areion512InversePermuteVexRCAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    vmovdqu XMMWORD PTR [rsp + 0], xmm15
    mov rax, rcx
    mov r10, rdx
    vmovdqu xmm0, XMMWORD PTR [rax + 16]
    vmovdqu xmm1, XMMWORD PTR [rax + 32]
    vmovdqu xmm2, XMMWORD PTR [rax + 48]
    vmovdqu xmm3, XMMWORD PTR [rax]
    vpxor xmm15, xmm15, xmm15
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [r10 + 224]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [r10 + 208]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [r10 + 192]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [r10 + 176]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [r10 + 160]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [r10 + 144]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [r10 + 128]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [r10 + 112]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [r10 + 96]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [r10 + 80]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [r10 + 64]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [r10 + 48]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [r10 + 32]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [r10 + 16]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [r10]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vmovdqu XMMWORD PTR [rax], xmm0
    vmovdqu XMMWORD PTR [rax + 16], xmm1
    vmovdqu XMMWORD PTR [rax + 32], xmm2
    vmovdqu XMMWORD PTR [rax + 48], xmm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    vmovdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion512InversePermuteVexRCAsm ENDP

PUBLIC areionSoEM256Asm
ALIGN 16
areionSoEM256Asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 120
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm10
    movdqu XMMWORD PTR [rsp + 80], xmm11
    movdqu XMMWORD PTR [rsp + 96], xmm15
    mov rax, rdx
    mov rdx, rcx
    mov r10, r8
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    movdqa xmm2, xmm0
    movdqa xmm3, xmm1
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    pxor xmm15, xmm15
    movdqu xmm6, XMMWORD PTR [roundConstantsP1]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm2
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm1
    aesenc xmm5, xmm3
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    movdqa xmm1, xmm4
    movdqa xmm3, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 16]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm4, xmm1
    movdqa xmm5, xmm3
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm0
    aesenc xmm5, xmm2
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    movdqa xmm0, xmm4
    movdqa xmm2, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 32]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm2
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm1
    aesenc xmm5, xmm3
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    movdqa xmm1, xmm4
    movdqa xmm3, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 48]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm4, xmm1
    movdqa xmm5, xmm3
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm0
    aesenc xmm5, xmm2
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    movdqa xmm0, xmm4
    movdqa xmm2, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 64]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm2
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm1
    aesenc xmm5, xmm3
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    movdqa xmm1, xmm4
    movdqa xmm3, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 80]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm4, xmm1
    movdqa xmm5, xmm3
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm0
    aesenc xmm5, xmm2
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    movdqa xmm0, xmm4
    movdqa xmm2, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 96]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm2
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm1
    aesenc xmm5, xmm3
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    movdqa xmm1, xmm4
    movdqa xmm3, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 112]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm4, xmm1
    movdqa xmm5, xmm3
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm0
    aesenc xmm5, xmm2
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    movdqa xmm0, xmm4
    movdqa xmm2, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 128]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm2
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm1
    aesenc xmm5, xmm3
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    movdqa xmm1, xmm4
    movdqa xmm3, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 144]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm4, xmm1
    movdqa xmm5, xmm3
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm0
    aesenc xmm5, xmm2
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    movdqa xmm0, xmm4
    movdqa xmm2, xmm5
    pxor xmm0, xmm2
    pxor xmm1, xmm3
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    movdqu XMMWORD PTR [rdx], xmm0
    movdqu XMMWORD PTR [rdx + 16], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    movdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm15, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    add rsp, 120
    ret
areionSoEM256Asm ENDP

PUBLIC areionSoEM256VexAsm
ALIGN 16
areionSoEM256VexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    vmovdqu XMMWORD PTR [rsp + 0], xmm8
    vmovdqu XMMWORD PTR [rsp + 16], xmm9
    vmovdqu XMMWORD PTR [rsp + 32], xmm10
    vmovdqu XMMWORD PTR [rsp + 48], xmm11
    vmovdqu XMMWORD PTR [rsp + 64], xmm15
    mov rax, rdx
    mov rdx, rcx
    mov r10, r8
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm8, XMMWORD PTR [rax]
    vmovdqu xmm9, XMMWORD PTR [rax + 16]
    vmovdqu xmm10, XMMWORD PTR [rax + 32]
    vmovdqu xmm11, XMMWORD PTR [rax + 48]
    vpxor xmm2, xmm0, xmm10
    vpxor xmm3, xmm1, xmm11
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm4, xmm0, XMMWORD PTR [roundConstantsP1]
    vaesenc xmm5, xmm2, XMMWORD PTR [roundConstantsP2]
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm4, xmm1
    vaesenc xmm3, xmm5, xmm3
    vaesenc xmm4, xmm1, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenc xmm5, xmm3, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenc xmm0, xmm4, xmm0
    vaesenc xmm2, xmm5, xmm2
    vaesenc xmm4, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenc xmm5, xmm2, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm4, xmm1
    vaesenc xmm3, xmm5, xmm3
    vaesenc xmm4, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenc xmm5, xmm3, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenc xmm0, xmm4, xmm0
    vaesenc xmm2, xmm5, xmm2
    vaesenc xmm4, xmm0, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenc xmm5, xmm2, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm4, xmm1
    vaesenc xmm3, xmm5, xmm3
    vaesenc xmm4, xmm1, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenc xmm5, xmm3, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenc xmm0, xmm4, xmm0
    vaesenc xmm2, xmm5, xmm2
    vaesenc xmm4, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenc xmm5, xmm2, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm4, xmm1
    vaesenc xmm3, xmm5, xmm3
    vaesenc xmm4, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenc xmm5, xmm3, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenc xmm0, xmm4, xmm0
    vaesenc xmm2, xmm5, xmm2
    vaesenc xmm4, xmm0, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenc xmm5, xmm2, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm4, xmm1
    vaesenc xmm3, xmm5, xmm3
    vaesenc xmm4, xmm1, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenc xmm5, xmm3, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenc xmm0, xmm4, xmm0
    vaesenc xmm2, xmm5, xmm2
    vpxor xmm0, xmm0, xmm2
    vpxor xmm1, xmm1, xmm3
    vpxor xmm8, xmm10, xmm8
    vpxor xmm9, xmm11, xmm9
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vmovdqu XMMWORD PTR [rdx], xmm0
    vmovdqu XMMWORD PTR [rdx + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    vmovdqu xmm8, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    add rsp, 88
    ret
areionSoEM256VexAsm ENDP

PUBLIC areionSoEM512Asm
ALIGN 16
areionSoEM512Asm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm10
    movdqu XMMWORD PTR [rsp + 80], xmm11
    movdqu XMMWORD PTR [rsp + 96], xmm12
    movdqu XMMWORD PTR [rsp + 112], xmm13
    movdqu XMMWORD PTR [rsp + 128], xmm15
    mov rax, rdx
    mov rdx, rcx
    mov r10, r8
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    movdqu xmm3, XMMWORD PTR [r10 + 48]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm1
    movdqa xmm6, xmm2
    movdqa xmm7, xmm3
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 64]
    movdqu xmm9, XMMWORD PTR [rax + 80]
    movdqu xmm10, XMMWORD PTR [rax + 96]
    movdqu xmm11, XMMWORD PTR [rax + 112]
    pxor xmm4, xmm8
    pxor xmm5, xmm9
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    pxor xmm15, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 16]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 32]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 48]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 64]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 80]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 96]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 112]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 128]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 144]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 160]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 160]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 176]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 176]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 192]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 192]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 208]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 208]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 224]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 224]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    pxor xmm3, xmm7
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    pxor xmm2, xmm6
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm3, xmm8
    pxor xmm0, xmm9
    pxor xmm1, xmm10
    pxor xmm2, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 64]
    movdqu xmm9, XMMWORD PTR [rax + 80]
    movdqu xmm10, XMMWORD PTR [rax + 96]
    movdqu xmm11, XMMWORD PTR [rax + 112]
    pxor xmm3, xmm8
    pxor xmm0, xmm9
    pxor xmm1, xmm10
    pxor xmm2, xmm11
    movdqu XMMWORD PTR [rdx], xmm3
    movdqu XMMWORD PTR [rdx + 16], xmm0
    movdqu XMMWORD PTR [rdx + 32], xmm1
    movdqu XMMWORD PTR [rdx + 48], xmm2
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    movdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm12, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm13, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm15, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    add rsp, 152
    ret
areionSoEM512Asm ENDP

PUBLIC areionSoEM512VexAsm
ALIGN 16
areionSoEM512VexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 56
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm15
    mov rax, rdx
    mov rdx, rcx
    mov r10, r8
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm2, XMMWORD PTR [r10 + 32]
    vmovdqu xmm3, XMMWORD PTR [r10 + 48]
    vpxor xmm4, xmm0, XMMWORD PTR [rax + 64]
    vpxor xmm5, xmm1, XMMWORD PTR [rax + 80]
    vpxor xmm6, xmm2, XMMWORD PTR [rax + 96]
    vpxor xmm7, xmm3, XMMWORD PTR [rax + 112]
    vpxor xmm0, xmm0, XMMWORD PTR [rax]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 16]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 32]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 48]
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 160]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 160]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 176]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 176]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 192]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 192]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 208]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 208]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 224]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 224]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vpxor xmm3, xmm3, xmm7
    vpxor xmm0, xmm0, xmm4
    vpxor xmm1, xmm1, xmm5
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, XMMWORD PTR [rax]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 16]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 32]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 48]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 64]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 80]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 96]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 112]
    vmovdqu XMMWORD PTR [rdx], xmm3
    vmovdqu XMMWORD PTR [rdx + 16], xmm0
    vmovdqu XMMWORD PTR [rdx + 32], xmm1
    vmovdqu XMMWORD PTR [rdx + 48], xmm2
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    add rsp, 56
    ret
areionSoEM512VexAsm ENDP

PUBLIC areion256Permutex4RC
ALIGN 16
areion256Permutex4RC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    vmovdqu64 zmm0, ZMMWORD PTR [rax]
    vmovdqu64 zmm1, ZMMWORD PTR [r10]
    vpxord zmm3, zmm3, zmm3
    vaesenc zmm2, zmm0, ZMMWORD PTR [rcx]
    vaesenclast zmm0, zmm0, zmm3
    vaesenc zmm1, zmm2, zmm1
    vaesenc zmm2, zmm1, ZMMWORD PTR [rcx + 64]
    vaesenclast zmm1, zmm1, zmm3
    vaesenc zmm0, zmm2, zmm0
    vaesenc zmm2, zmm0, ZMMWORD PTR [rcx + 128]
    vaesenclast zmm0, zmm0, zmm3
    vaesenc zmm1, zmm2, zmm1
    vaesenc zmm2, zmm1, ZMMWORD PTR [rcx + 192]
    vaesenclast zmm1, zmm1, zmm3
    vaesenc zmm0, zmm2, zmm0
    vaesenc zmm2, zmm0, ZMMWORD PTR [rcx + 256]
    vaesenclast zmm0, zmm0, zmm3
    vaesenc zmm1, zmm2, zmm1
    vaesenc zmm2, zmm1, ZMMWORD PTR [rcx + 320]
    vaesenclast zmm1, zmm1, zmm3
    vaesenc zmm0, zmm2, zmm0
    vaesenc zmm2, zmm0, ZMMWORD PTR [rcx + 384]
    vaesenclast zmm0, zmm0, zmm3
    vaesenc zmm1, zmm2, zmm1
    vaesenc zmm2, zmm1, ZMMWORD PTR [rcx + 448]
    vaesenclast zmm1, zmm1, zmm3
    vaesenc zmm0, zmm2, zmm0
    vaesenc zmm2, zmm0, ZMMWORD PTR [rcx + 512]
    vaesenclast zmm0, zmm0, zmm3
    vaesenc zmm1, zmm2, zmm1
    vaesenc zmm2, zmm1, ZMMWORD PTR [rcx + 576]
    vaesenclast zmm1, zmm1, zmm3
    vaesenc zmm0, zmm2, zmm0
    vmovdqu64 ZMMWORD PTR [rax], zmm0
    vmovdqu64 ZMMWORD PTR [r10], zmm1
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    vzeroupper
    ret
areion256Permutex4RC ENDP

PUBLIC areion256InversePermutex4RC
ALIGN 16
areion256InversePermutex4RC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    vmovdqu64 zmm0, ZMMWORD PTR [rax]
    vmovdqu64 zmm1, ZMMWORD PTR [r10]
    vpxord zmm3, zmm3, zmm3
    vaesdeclast zmm1, zmm1, zmm3
    vaesenc zmm2, zmm1, ZMMWORD PTR [rcx + 576]
    vaesenc zmm0, zmm2, zmm0
    vaesdeclast zmm0, zmm0, zmm3
    vaesenc zmm2, zmm0, ZMMWORD PTR [rcx + 512]
    vaesenc zmm1, zmm2, zmm1
    vaesdeclast zmm1, zmm1, zmm3
    vaesenc zmm2, zmm1, ZMMWORD PTR [rcx + 448]
    vaesenc zmm0, zmm2, zmm0
    vaesdeclast zmm0, zmm0, zmm3
    vaesenc zmm2, zmm0, ZMMWORD PTR [rcx + 384]
    vaesenc zmm1, zmm2, zmm1
    vaesdeclast zmm1, zmm1, zmm3
    vaesenc zmm2, zmm1, ZMMWORD PTR [rcx + 320]
    vaesenc zmm0, zmm2, zmm0
    vaesdeclast zmm0, zmm0, zmm3
    vaesenc zmm2, zmm0, ZMMWORD PTR [rcx + 256]
    vaesenc zmm1, zmm2, zmm1
    vaesdeclast zmm1, zmm1, zmm3
    vaesenc zmm2, zmm1, ZMMWORD PTR [rcx + 192]
    vaesenc zmm0, zmm2, zmm0
    vaesdeclast zmm0, zmm0, zmm3
    vaesenc zmm2, zmm0, ZMMWORD PTR [rcx + 128]
    vaesenc zmm1, zmm2, zmm1
    vaesdeclast zmm1, zmm1, zmm3
    vaesenc zmm2, zmm1, ZMMWORD PTR [rcx + 64]
    vaesenc zmm0, zmm2, zmm0
    vaesdeclast zmm0, zmm0, zmm3
    vaesenc zmm2, zmm0, ZMMWORD PTR [rcx]
    vaesenc zmm1, zmm2, zmm1
    vmovdqu64 ZMMWORD PTR [rax], zmm0
    vmovdqu64 ZMMWORD PTR [r10], zmm1
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    vzeroupper
    ret
areion256InversePermutex4RC ENDP

PUBLIC areion512Permutex4RC
ALIGN 16
areion512Permutex4RC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 40
    mov QWORD PTR [rsp + 0], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm15
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    mov rdx, r9
    mov rsi, QWORD PTR [rsp + 80]
    vmovdqu64 zmm0, ZMMWORD PTR [rax]
    vmovdqu64 zmm1, ZMMWORD PTR [r10]
    vmovdqu64 zmm2, ZMMWORD PTR [rcx]
    vmovdqu64 zmm3, ZMMWORD PTR [rdx]
    vpxord zmm15, zmm15, zmm15
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm3, zmm2, zmm3
    vaesenclast zmm0, zmm0, zmm15
    vaesenclast zmm2, zmm2, ZMMWORD PTR [rsi]
    vaesenc zmm2, zmm2, zmm15
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm0, zmm3, zmm0
    vaesenclast zmm1, zmm1, zmm15
    vaesenclast zmm3, zmm3, ZMMWORD PTR [rsi + 64]
    vaesenc zmm3, zmm3, zmm15
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm1, zmm0, zmm1
    vaesenclast zmm2, zmm2, zmm15
    vaesenclast zmm0, zmm0, ZMMWORD PTR [rsi + 128]
    vaesenc zmm0, zmm0, zmm15
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm2, zmm1, zmm2
    vaesenclast zmm3, zmm3, zmm15
    vaesenclast zmm1, zmm1, ZMMWORD PTR [rsi + 192]
    vaesenc zmm1, zmm1, zmm15
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm3, zmm2, zmm3
    vaesenclast zmm0, zmm0, zmm15
    vaesenclast zmm2, zmm2, ZMMWORD PTR [rsi + 256]
    vaesenc zmm2, zmm2, zmm15
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm0, zmm3, zmm0
    vaesenclast zmm1, zmm1, zmm15
    vaesenclast zmm3, zmm3, ZMMWORD PTR [rsi + 320]
    vaesenc zmm3, zmm3, zmm15
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm1, zmm0, zmm1
    vaesenclast zmm2, zmm2, zmm15
    vaesenclast zmm0, zmm0, ZMMWORD PTR [rsi + 384]
    vaesenc zmm0, zmm0, zmm15
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm2, zmm1, zmm2
    vaesenclast zmm3, zmm3, zmm15
    vaesenclast zmm1, zmm1, ZMMWORD PTR [rsi + 448]
    vaesenc zmm1, zmm1, zmm15
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm3, zmm2, zmm3
    vaesenclast zmm0, zmm0, zmm15
    vaesenclast zmm2, zmm2, ZMMWORD PTR [rsi + 512]
    vaesenc zmm2, zmm2, zmm15
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm0, zmm3, zmm0
    vaesenclast zmm1, zmm1, zmm15
    vaesenclast zmm3, zmm3, ZMMWORD PTR [rsi + 576]
    vaesenc zmm3, zmm3, zmm15
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm1, zmm0, zmm1
    vaesenclast zmm2, zmm2, zmm15
    vaesenclast zmm0, zmm0, ZMMWORD PTR [rsi + 640]
    vaesenc zmm0, zmm0, zmm15
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm2, zmm1, zmm2
    vaesenclast zmm3, zmm3, zmm15
    vaesenclast zmm1, zmm1, ZMMWORD PTR [rsi + 704]
    vaesenc zmm1, zmm1, zmm15
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm3, zmm2, zmm3
    vaesenclast zmm0, zmm0, zmm15
    vaesenclast zmm2, zmm2, ZMMWORD PTR [rsi + 768]
    vaesenc zmm2, zmm2, zmm15
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm0, zmm3, zmm0
    vaesenclast zmm1, zmm1, zmm15
    vaesenclast zmm3, zmm3, ZMMWORD PTR [rsi + 832]
    vaesenc zmm3, zmm3, zmm15
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm1, zmm0, zmm1
    vaesenclast zmm2, zmm2, zmm15
    vaesenclast zmm0, zmm0, ZMMWORD PTR [rsi + 896]
    vaesenc zmm0, zmm0, zmm15
    vmovdqu64 ZMMWORD PTR [rax], zmm3
    vmovdqu64 ZMMWORD PTR [r10], zmm0
    vmovdqu64 ZMMWORD PTR [rcx], zmm1
    vmovdqu64 ZMMWORD PTR [rdx], zmm2
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    xor rsi, rsi
    xor r11, r11
    vmovdqu xmm15, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    add rsp, 40
    vzeroupper
    ret
areion512Permutex4RC ENDP

PUBLIC areion512InversePermutex4RC
ALIGN 16
areion512InversePermutex4RC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 72
    mov QWORD PTR [rsp + 0], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm15
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    mov rdx, r9
    mov rsi, QWORD PTR [rsp + 112]
    vmovdqu64 zmm0, ZMMWORD PTR [r10]
    vmovdqu64 zmm1, ZMMWORD PTR [rcx]
    vmovdqu64 zmm2, ZMMWORD PTR [rdx]
    vmovdqu64 zmm3, ZMMWORD PTR [rax]
    vpxord zmm15, zmm15, zmm15
    vaesdeclast zmm2, zmm2, zmm15
    vextracti32x4 xmm5, zmm0, 1
    vextracti32x4 xmm6, zmm0, 2
    vextracti32x4 xmm7, zmm0, 3
    vaesimc xmm0, xmm0
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vinserti32x4 zmm0, zmm0, xmm5, 1
    vinserti32x4 zmm0, zmm0, xmm6, 2
    vinserti32x4 zmm0, zmm0, xmm7, 3
    vaesdeclast zmm0, zmm0, ZMMWORD PTR [rsi + 896]
    vaesdeclast zmm0, zmm0, zmm15
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm1, zmm0, zmm1
    vaesdeclast zmm1, zmm1, zmm15
    vextracti32x4 xmm5, zmm3, 1
    vextracti32x4 xmm6, zmm3, 2
    vextracti32x4 xmm7, zmm3, 3
    vaesimc xmm3, xmm3
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vinserti32x4 zmm3, zmm3, xmm5, 1
    vinserti32x4 zmm3, zmm3, xmm6, 2
    vinserti32x4 zmm3, zmm3, xmm7, 3
    vaesdeclast zmm3, zmm3, ZMMWORD PTR [rsi + 832]
    vaesdeclast zmm3, zmm3, zmm15
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm0, zmm3, zmm0
    vaesdeclast zmm0, zmm0, zmm15
    vextracti32x4 xmm5, zmm2, 1
    vextracti32x4 xmm6, zmm2, 2
    vextracti32x4 xmm7, zmm2, 3
    vaesimc xmm2, xmm2
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vinserti32x4 zmm2, zmm2, xmm5, 1
    vinserti32x4 zmm2, zmm2, xmm6, 2
    vinserti32x4 zmm2, zmm2, xmm7, 3
    vaesdeclast zmm2, zmm2, ZMMWORD PTR [rsi + 768]
    vaesdeclast zmm2, zmm2, zmm15
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm3, zmm2, zmm3
    vaesdeclast zmm3, zmm3, zmm15
    vextracti32x4 xmm5, zmm1, 1
    vextracti32x4 xmm6, zmm1, 2
    vextracti32x4 xmm7, zmm1, 3
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vinserti32x4 zmm1, zmm1, xmm5, 1
    vinserti32x4 zmm1, zmm1, xmm6, 2
    vinserti32x4 zmm1, zmm1, xmm7, 3
    vaesdeclast zmm1, zmm1, ZMMWORD PTR [rsi + 704]
    vaesdeclast zmm1, zmm1, zmm15
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm2, zmm1, zmm2
    vaesdeclast zmm2, zmm2, zmm15
    vextracti32x4 xmm5, zmm0, 1
    vextracti32x4 xmm6, zmm0, 2
    vextracti32x4 xmm7, zmm0, 3
    vaesimc xmm0, xmm0
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vinserti32x4 zmm0, zmm0, xmm5, 1
    vinserti32x4 zmm0, zmm0, xmm6, 2
    vinserti32x4 zmm0, zmm0, xmm7, 3
    vaesdeclast zmm0, zmm0, ZMMWORD PTR [rsi + 640]
    vaesdeclast zmm0, zmm0, zmm15
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm1, zmm0, zmm1
    vaesdeclast zmm1, zmm1, zmm15
    vextracti32x4 xmm5, zmm3, 1
    vextracti32x4 xmm6, zmm3, 2
    vextracti32x4 xmm7, zmm3, 3
    vaesimc xmm3, xmm3
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vinserti32x4 zmm3, zmm3, xmm5, 1
    vinserti32x4 zmm3, zmm3, xmm6, 2
    vinserti32x4 zmm3, zmm3, xmm7, 3
    vaesdeclast zmm3, zmm3, ZMMWORD PTR [rsi + 576]
    vaesdeclast zmm3, zmm3, zmm15
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm0, zmm3, zmm0
    vaesdeclast zmm0, zmm0, zmm15
    vextracti32x4 xmm5, zmm2, 1
    vextracti32x4 xmm6, zmm2, 2
    vextracti32x4 xmm7, zmm2, 3
    vaesimc xmm2, xmm2
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vinserti32x4 zmm2, zmm2, xmm5, 1
    vinserti32x4 zmm2, zmm2, xmm6, 2
    vinserti32x4 zmm2, zmm2, xmm7, 3
    vaesdeclast zmm2, zmm2, ZMMWORD PTR [rsi + 512]
    vaesdeclast zmm2, zmm2, zmm15
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm3, zmm2, zmm3
    vaesdeclast zmm3, zmm3, zmm15
    vextracti32x4 xmm5, zmm1, 1
    vextracti32x4 xmm6, zmm1, 2
    vextracti32x4 xmm7, zmm1, 3
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vinserti32x4 zmm1, zmm1, xmm5, 1
    vinserti32x4 zmm1, zmm1, xmm6, 2
    vinserti32x4 zmm1, zmm1, xmm7, 3
    vaesdeclast zmm1, zmm1, ZMMWORD PTR [rsi + 448]
    vaesdeclast zmm1, zmm1, zmm15
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm2, zmm1, zmm2
    vaesdeclast zmm2, zmm2, zmm15
    vextracti32x4 xmm5, zmm0, 1
    vextracti32x4 xmm6, zmm0, 2
    vextracti32x4 xmm7, zmm0, 3
    vaesimc xmm0, xmm0
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vinserti32x4 zmm0, zmm0, xmm5, 1
    vinserti32x4 zmm0, zmm0, xmm6, 2
    vinserti32x4 zmm0, zmm0, xmm7, 3
    vaesdeclast zmm0, zmm0, ZMMWORD PTR [rsi + 384]
    vaesdeclast zmm0, zmm0, zmm15
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm1, zmm0, zmm1
    vaesdeclast zmm1, zmm1, zmm15
    vextracti32x4 xmm5, zmm3, 1
    vextracti32x4 xmm6, zmm3, 2
    vextracti32x4 xmm7, zmm3, 3
    vaesimc xmm3, xmm3
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vinserti32x4 zmm3, zmm3, xmm5, 1
    vinserti32x4 zmm3, zmm3, xmm6, 2
    vinserti32x4 zmm3, zmm3, xmm7, 3
    vaesdeclast zmm3, zmm3, ZMMWORD PTR [rsi + 320]
    vaesdeclast zmm3, zmm3, zmm15
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm0, zmm3, zmm0
    vaesdeclast zmm0, zmm0, zmm15
    vextracti32x4 xmm5, zmm2, 1
    vextracti32x4 xmm6, zmm2, 2
    vextracti32x4 xmm7, zmm2, 3
    vaesimc xmm2, xmm2
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vinserti32x4 zmm2, zmm2, xmm5, 1
    vinserti32x4 zmm2, zmm2, xmm6, 2
    vinserti32x4 zmm2, zmm2, xmm7, 3
    vaesdeclast zmm2, zmm2, ZMMWORD PTR [rsi + 256]
    vaesdeclast zmm2, zmm2, zmm15
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm3, zmm2, zmm3
    vaesdeclast zmm3, zmm3, zmm15
    vextracti32x4 xmm5, zmm1, 1
    vextracti32x4 xmm6, zmm1, 2
    vextracti32x4 xmm7, zmm1, 3
    vaesimc xmm1, xmm1
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vinserti32x4 zmm1, zmm1, xmm5, 1
    vinserti32x4 zmm1, zmm1, xmm6, 2
    vinserti32x4 zmm1, zmm1, xmm7, 3
    vaesdeclast zmm1, zmm1, ZMMWORD PTR [rsi + 192]
    vaesdeclast zmm1, zmm1, zmm15
    vaesenc zmm0, zmm3, zmm0
    vaesenc zmm2, zmm1, zmm2
    vaesdeclast zmm2, zmm2, zmm15
    vextracti32x4 xmm5, zmm0, 1
    vextracti32x4 xmm6, zmm0, 2
    vextracti32x4 xmm7, zmm0, 3
    vaesimc xmm0, xmm0
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vinserti32x4 zmm0, zmm0, xmm5, 1
    vinserti32x4 zmm0, zmm0, xmm6, 2
    vinserti32x4 zmm0, zmm0, xmm7, 3
    vaesdeclast zmm0, zmm0, ZMMWORD PTR [rsi + 128]
    vaesdeclast zmm0, zmm0, zmm15
    vaesenc zmm3, zmm2, zmm3
    vaesenc zmm1, zmm0, zmm1
    vaesdeclast zmm1, zmm1, zmm15
    vextracti32x4 xmm5, zmm3, 1
    vextracti32x4 xmm6, zmm3, 2
    vextracti32x4 xmm7, zmm3, 3
    vaesimc xmm3, xmm3
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vinserti32x4 zmm3, zmm3, xmm5, 1
    vinserti32x4 zmm3, zmm3, xmm6, 2
    vinserti32x4 zmm3, zmm3, xmm7, 3
    vaesdeclast zmm3, zmm3, ZMMWORD PTR [rsi + 64]
    vaesdeclast zmm3, zmm3, zmm15
    vaesenc zmm2, zmm1, zmm2
    vaesenc zmm0, zmm3, zmm0
    vaesdeclast zmm0, zmm0, zmm15
    vextracti32x4 xmm5, zmm2, 1
    vextracti32x4 xmm6, zmm2, 2
    vextracti32x4 xmm7, zmm2, 3
    vaesimc xmm2, xmm2
    vaesimc xmm5, xmm5
    vaesimc xmm6, xmm6
    vaesimc xmm7, xmm7
    vinserti32x4 zmm2, zmm2, xmm5, 1
    vinserti32x4 zmm2, zmm2, xmm6, 2
    vinserti32x4 zmm2, zmm2, xmm7, 3
    vaesdeclast zmm2, zmm2, ZMMWORD PTR [rsi]
    vaesdeclast zmm2, zmm2, zmm15
    vaesenc zmm1, zmm0, zmm1
    vaesenc zmm3, zmm2, zmm3
    vmovdqu64 ZMMWORD PTR [rax], zmm0
    vmovdqu64 ZMMWORD PTR [r10], zmm1
    vmovdqu64 ZMMWORD PTR [rcx], zmm2
    vmovdqu64 ZMMWORD PTR [rdx], zmm3
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm5, xmm5, xmm5
    vpxord xmm6, xmm6, xmm6
    vpxord xmm7, xmm7, xmm7
    vpxord xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    xor rsi, rsi
    xor r11, r11
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    add rsp, 72
    vzeroupper
    ret
areion512InversePermutex4RC ENDP

PUBLIC areion256Permutex4Avx2RC
ALIGN 16
areion256Permutex4Avx2RC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 40
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm15
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    vmovdqu ymm0, YMMWORD PTR [rax]
    vmovdqu ymm1, YMMWORD PTR [rax + 32]
    vmovdqu ymm2, YMMWORD PTR [r10]
    vmovdqu ymm3, YMMWORD PTR [r10 + 32]
    vpxor ymm15, ymm15, ymm15
    vmovdqu ymm6, YMMWORD PTR [rcx]
    vaesenc ymm4, ymm0, ymm6
    vaesenc ymm5, ymm1, ymm6
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm1, ymm1, ymm15
    vaesenc ymm2, ymm4, ymm2
    vaesenc ymm3, ymm5, ymm3
    vmovdqu ymm6, YMMWORD PTR [rcx + 64]
    vaesenc ymm4, ymm2, ymm6
    vaesenc ymm5, ymm3, ymm6
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm1, ymm5, ymm1
    vmovdqu ymm6, YMMWORD PTR [rcx + 128]
    vaesenc ymm4, ymm0, ymm6
    vaesenc ymm5, ymm1, ymm6
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm1, ymm1, ymm15
    vaesenc ymm2, ymm4, ymm2
    vaesenc ymm3, ymm5, ymm3
    vmovdqu ymm6, YMMWORD PTR [rcx + 192]
    vaesenc ymm4, ymm2, ymm6
    vaesenc ymm5, ymm3, ymm6
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm1, ymm5, ymm1
    vmovdqu ymm6, YMMWORD PTR [rcx + 256]
    vaesenc ymm4, ymm0, ymm6
    vaesenc ymm5, ymm1, ymm6
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm1, ymm1, ymm15
    vaesenc ymm2, ymm4, ymm2
    vaesenc ymm3, ymm5, ymm3
    vmovdqu ymm6, YMMWORD PTR [rcx + 320]
    vaesenc ymm4, ymm2, ymm6
    vaesenc ymm5, ymm3, ymm6
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm1, ymm5, ymm1
    vmovdqu ymm6, YMMWORD PTR [rcx + 384]
    vaesenc ymm4, ymm0, ymm6
    vaesenc ymm5, ymm1, ymm6
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm1, ymm1, ymm15
    vaesenc ymm2, ymm4, ymm2
    vaesenc ymm3, ymm5, ymm3
    vmovdqu ymm6, YMMWORD PTR [rcx + 448]
    vaesenc ymm4, ymm2, ymm6
    vaesenc ymm5, ymm3, ymm6
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm1, ymm5, ymm1
    vmovdqu ymm6, YMMWORD PTR [rcx + 512]
    vaesenc ymm4, ymm0, ymm6
    vaesenc ymm5, ymm1, ymm6
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm1, ymm1, ymm15
    vaesenc ymm2, ymm4, ymm2
    vaesenc ymm3, ymm5, ymm3
    vmovdqu ymm6, YMMWORD PTR [rcx + 576]
    vaesenc ymm4, ymm2, ymm6
    vaesenc ymm5, ymm3, ymm6
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm1, ymm5, ymm1
    vmovdqu YMMWORD PTR [rax], ymm0
    vmovdqu YMMWORD PTR [rax + 32], ymm1
    vmovdqu YMMWORD PTR [r10], ymm2
    vmovdqu YMMWORD PTR [r10 + 32], ymm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    add rsp, 40
    vzeroupper
    ret
areion256Permutex4Avx2RC ENDP

PUBLIC areion256InversePermutex4Avx2RC
ALIGN 16
areion256InversePermutex4Avx2RC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 40
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm15
    mov rax, rcx
    mov r10, rdx
    mov rcx, r8
    vmovdqu ymm0, YMMWORD PTR [rax]
    vmovdqu ymm1, YMMWORD PTR [rax + 32]
    vmovdqu ymm2, YMMWORD PTR [r10]
    vmovdqu ymm3, YMMWORD PTR [r10 + 32]
    vpxor ymm15, ymm15, ymm15
    vmovdqu ymm6, YMMWORD PTR [rcx + 576]
    vaesdeclast ymm2, ymm2, ymm15
    vaesdeclast ymm3, ymm3, ymm15
    vaesenc ymm4, ymm2, ymm6
    vaesenc ymm5, ymm3, ymm6
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm1, ymm5, ymm1
    vmovdqu ymm6, YMMWORD PTR [rcx + 512]
    vaesdeclast ymm0, ymm0, ymm15
    vaesdeclast ymm1, ymm1, ymm15
    vaesenc ymm4, ymm0, ymm6
    vaesenc ymm5, ymm1, ymm6
    vaesenc ymm2, ymm4, ymm2
    vaesenc ymm3, ymm5, ymm3
    vmovdqu ymm6, YMMWORD PTR [rcx + 448]
    vaesdeclast ymm2, ymm2, ymm15
    vaesdeclast ymm3, ymm3, ymm15
    vaesenc ymm4, ymm2, ymm6
    vaesenc ymm5, ymm3, ymm6
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm1, ymm5, ymm1
    vmovdqu ymm6, YMMWORD PTR [rcx + 384]
    vaesdeclast ymm0, ymm0, ymm15
    vaesdeclast ymm1, ymm1, ymm15
    vaesenc ymm4, ymm0, ymm6
    vaesenc ymm5, ymm1, ymm6
    vaesenc ymm2, ymm4, ymm2
    vaesenc ymm3, ymm5, ymm3
    vmovdqu ymm6, YMMWORD PTR [rcx + 320]
    vaesdeclast ymm2, ymm2, ymm15
    vaesdeclast ymm3, ymm3, ymm15
    vaesenc ymm4, ymm2, ymm6
    vaesenc ymm5, ymm3, ymm6
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm1, ymm5, ymm1
    vmovdqu ymm6, YMMWORD PTR [rcx + 256]
    vaesdeclast ymm0, ymm0, ymm15
    vaesdeclast ymm1, ymm1, ymm15
    vaesenc ymm4, ymm0, ymm6
    vaesenc ymm5, ymm1, ymm6
    vaesenc ymm2, ymm4, ymm2
    vaesenc ymm3, ymm5, ymm3
    vmovdqu ymm6, YMMWORD PTR [rcx + 192]
    vaesdeclast ymm2, ymm2, ymm15
    vaesdeclast ymm3, ymm3, ymm15
    vaesenc ymm4, ymm2, ymm6
    vaesenc ymm5, ymm3, ymm6
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm1, ymm5, ymm1
    vmovdqu ymm6, YMMWORD PTR [rcx + 128]
    vaesdeclast ymm0, ymm0, ymm15
    vaesdeclast ymm1, ymm1, ymm15
    vaesenc ymm4, ymm0, ymm6
    vaesenc ymm5, ymm1, ymm6
    vaesenc ymm2, ymm4, ymm2
    vaesenc ymm3, ymm5, ymm3
    vmovdqu ymm6, YMMWORD PTR [rcx + 64]
    vaesdeclast ymm2, ymm2, ymm15
    vaesdeclast ymm3, ymm3, ymm15
    vaesenc ymm4, ymm2, ymm6
    vaesenc ymm5, ymm3, ymm6
    vaesenc ymm0, ymm4, ymm0
    vaesenc ymm1, ymm5, ymm1
    vmovdqu ymm6, YMMWORD PTR [rcx]
    vaesdeclast ymm0, ymm0, ymm15
    vaesdeclast ymm1, ymm1, ymm15
    vaesenc ymm4, ymm0, ymm6
    vaesenc ymm5, ymm1, ymm6
    vaesenc ymm2, ymm4, ymm2
    vaesenc ymm3, ymm5, ymm3
    vmovdqu YMMWORD PTR [rax], ymm0
    vmovdqu YMMWORD PTR [rax + 32], ymm1
    vmovdqu YMMWORD PTR [r10], ymm2
    vmovdqu YMMWORD PTR [r10 + 32], ymm3
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    add rsp, 40
    vzeroupper
    ret
areion256InversePermutex4Avx2RC ENDP

PUBLIC areion512Permutex4Avx2RC
ALIGN 16
areion512Permutex4Avx2RC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    mov QWORD PTR [rsp + 0], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm12
    vmovdqu XMMWORD PTR [rsp + 64], xmm15
    mov rax, rcx
    mov r10, rdx
    mov rdx, r8
    mov rsi, r9
    mov rcx, QWORD PTR [rsp + 128]
    vmovdqu ymm0, YMMWORD PTR [rax]
    vmovdqu ymm1, YMMWORD PTR [rax + 32]
    vmovdqu ymm2, YMMWORD PTR [r10]
    vmovdqu ymm3, YMMWORD PTR [r10 + 32]
    vmovdqu ymm4, YMMWORD PTR [rdx]
    vmovdqu ymm5, YMMWORD PTR [rdx + 32]
    vmovdqu ymm6, YMMWORD PTR [rsi]
    vmovdqu ymm7, YMMWORD PTR [rsi + 32]
    vpxor ymm15, ymm15, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx]
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesenc ymm4, ymm4, ymm15
    vaesenc ymm5, ymm5, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx + 64]
    vaesenc ymm4, ymm2, ymm4
    vaesenc ymm5, ymm3, ymm5
    vaesenc ymm0, ymm6, ymm0
    vaesenc ymm1, ymm7, ymm1
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenclast ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesenc ymm6, ymm6, ymm15
    vaesenc ymm7, ymm7, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx + 128]
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenclast ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesenc ymm0, ymm0, ymm15
    vaesenc ymm1, ymm1, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx + 192]
    vaesenc ymm0, ymm6, ymm0
    vaesenc ymm1, ymm7, ymm1
    vaesenc ymm4, ymm2, ymm4
    vaesenc ymm5, ymm3, ymm5
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm7, ymm7, ymm15
    vaesenclast ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesenc ymm2, ymm2, ymm15
    vaesenc ymm3, ymm3, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx + 256]
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesenc ymm4, ymm4, ymm15
    vaesenc ymm5, ymm5, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx + 320]
    vaesenc ymm4, ymm2, ymm4
    vaesenc ymm5, ymm3, ymm5
    vaesenc ymm0, ymm6, ymm0
    vaesenc ymm1, ymm7, ymm1
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenclast ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesenc ymm6, ymm6, ymm15
    vaesenc ymm7, ymm7, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx + 384]
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenclast ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesenc ymm0, ymm0, ymm15
    vaesenc ymm1, ymm1, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx + 448]
    vaesenc ymm0, ymm6, ymm0
    vaesenc ymm1, ymm7, ymm1
    vaesenc ymm4, ymm2, ymm4
    vaesenc ymm5, ymm3, ymm5
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm7, ymm7, ymm15
    vaesenclast ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesenc ymm2, ymm2, ymm15
    vaesenc ymm3, ymm3, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx + 512]
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesenc ymm4, ymm4, ymm15
    vaesenc ymm5, ymm5, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx + 576]
    vaesenc ymm4, ymm2, ymm4
    vaesenc ymm5, ymm3, ymm5
    vaesenc ymm0, ymm6, ymm0
    vaesenc ymm1, ymm7, ymm1
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenclast ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesenc ymm6, ymm6, ymm15
    vaesenc ymm7, ymm7, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx + 640]
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenclast ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesenc ymm0, ymm0, ymm15
    vaesenc ymm1, ymm1, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx + 704]
    vaesenc ymm0, ymm6, ymm0
    vaesenc ymm1, ymm7, ymm1
    vaesenc ymm4, ymm2, ymm4
    vaesenc ymm5, ymm3, ymm5
    vaesenclast ymm6, ymm6, ymm15
    vaesenclast ymm7, ymm7, ymm15
    vaesenclast ymm2, ymm2, ymm12
    vaesenclast ymm3, ymm3, ymm12
    vaesenc ymm2, ymm2, ymm15
    vaesenc ymm3, ymm3, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx + 768]
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vaesenclast ymm0, ymm0, ymm15
    vaesenclast ymm1, ymm1, ymm15
    vaesenclast ymm4, ymm4, ymm12
    vaesenclast ymm5, ymm5, ymm12
    vaesenc ymm4, ymm4, ymm15
    vaesenc ymm5, ymm5, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx + 832]
    vaesenc ymm4, ymm2, ymm4
    vaesenc ymm5, ymm3, ymm5
    vaesenc ymm0, ymm6, ymm0
    vaesenc ymm1, ymm7, ymm1
    vaesenclast ymm2, ymm2, ymm15
    vaesenclast ymm3, ymm3, ymm15
    vaesenclast ymm6, ymm6, ymm12
    vaesenclast ymm7, ymm7, ymm12
    vaesenc ymm6, ymm6, ymm15
    vaesenc ymm7, ymm7, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx + 896]
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vaesenclast ymm4, ymm4, ymm15
    vaesenclast ymm5, ymm5, ymm15
    vaesenclast ymm0, ymm0, ymm12
    vaesenclast ymm1, ymm1, ymm12
    vaesenc ymm0, ymm0, ymm15
    vaesenc ymm1, ymm1, ymm15
    vmovdqu YMMWORD PTR [rax], ymm6
    vmovdqu YMMWORD PTR [rax + 32], ymm7
    vmovdqu YMMWORD PTR [r10], ymm0
    vmovdqu YMMWORD PTR [r10 + 32], ymm1
    vmovdqu YMMWORD PTR [rdx], ymm2
    vmovdqu YMMWORD PTR [rdx + 32], ymm3
    vmovdqu YMMWORD PTR [rsi], ymm4
    vmovdqu YMMWORD PTR [rsi + 32], ymm5
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm12, xmm12, xmm12
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    xor rsi, rsi
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    add rsp, 88
    vzeroupper
    ret
areion512Permutex4Avx2RC ENDP

PUBLIC areion512InversePermutex4Avx2RC
ALIGN 16
areion512InversePermutex4Avx2RC PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 120
    mov QWORD PTR [rsp + 0], rsi
    vmovdqu XMMWORD PTR [rsp + 16], xmm6
    vmovdqu XMMWORD PTR [rsp + 32], xmm7
    vmovdqu XMMWORD PTR [rsp + 48], xmm8
    vmovdqu XMMWORD PTR [rsp + 64], xmm9
    vmovdqu XMMWORD PTR [rsp + 80], xmm12
    vmovdqu XMMWORD PTR [rsp + 96], xmm15
    mov rax, rcx
    mov r10, rdx
    mov rdx, r8
    mov rsi, r9
    mov rcx, QWORD PTR [rsp + 160]
    vmovdqu ymm0, YMMWORD PTR [r10]
    vmovdqu ymm1, YMMWORD PTR [r10 + 32]
    vmovdqu ymm2, YMMWORD PTR [rdx]
    vmovdqu ymm3, YMMWORD PTR [rdx + 32]
    vmovdqu ymm4, YMMWORD PTR [rsi]
    vmovdqu ymm5, YMMWORD PTR [rsi + 32]
    vmovdqu ymm6, YMMWORD PTR [rax]
    vmovdqu ymm7, YMMWORD PTR [rax + 32]
    vpxor ymm15, ymm15, ymm15
    vmovdqu ymm12, YMMWORD PTR [rcx + 896]
    vaesdeclast ymm4, ymm4, ymm15
    vaesdeclast ymm5, ymm5, ymm15
    vextracti128 xmm8, ymm0, 1
    vextracti128 xmm9, ymm1, 1
    vaesimc xmm0, xmm0
    vaesimc xmm8, xmm8
    vaesimc xmm1, xmm1
    vaesimc xmm9, xmm9
    vinserti128 ymm0, ymm0, xmm8, 1
    vinserti128 ymm1, ymm1, xmm9, 1
    vaesdeclast ymm0, ymm0, ymm12
    vaesdeclast ymm1, ymm1, ymm12
    vaesdeclast ymm0, ymm0, ymm15
    vaesdeclast ymm1, ymm1, ymm15
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vmovdqu ymm12, YMMWORD PTR [rcx + 832]
    vaesdeclast ymm2, ymm2, ymm15
    vaesdeclast ymm3, ymm3, ymm15
    vextracti128 xmm8, ymm6, 1
    vextracti128 xmm9, ymm7, 1
    vaesimc xmm6, xmm6
    vaesimc xmm8, xmm8
    vaesimc xmm7, xmm7
    vaesimc xmm9, xmm9
    vinserti128 ymm6, ymm6, xmm8, 1
    vinserti128 ymm7, ymm7, xmm9, 1
    vaesdeclast ymm6, ymm6, ymm12
    vaesdeclast ymm7, ymm7, ymm12
    vaesdeclast ymm6, ymm6, ymm15
    vaesdeclast ymm7, ymm7, ymm15
    vaesenc ymm4, ymm2, ymm4
    vaesenc ymm5, ymm3, ymm5
    vaesenc ymm0, ymm6, ymm0
    vaesenc ymm1, ymm7, ymm1
    vmovdqu ymm12, YMMWORD PTR [rcx + 768]
    vaesdeclast ymm0, ymm0, ymm15
    vaesdeclast ymm1, ymm1, ymm15
    vextracti128 xmm8, ymm4, 1
    vextracti128 xmm9, ymm5, 1
    vaesimc xmm4, xmm4
    vaesimc xmm8, xmm8
    vaesimc xmm5, xmm5
    vaesimc xmm9, xmm9
    vinserti128 ymm4, ymm4, xmm8, 1
    vinserti128 ymm5, ymm5, xmm9, 1
    vaesdeclast ymm4, ymm4, ymm12
    vaesdeclast ymm5, ymm5, ymm12
    vaesdeclast ymm4, ymm4, ymm15
    vaesdeclast ymm5, ymm5, ymm15
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vmovdqu ymm12, YMMWORD PTR [rcx + 704]
    vaesdeclast ymm6, ymm6, ymm15
    vaesdeclast ymm7, ymm7, ymm15
    vextracti128 xmm8, ymm2, 1
    vextracti128 xmm9, ymm3, 1
    vaesimc xmm2, xmm2
    vaesimc xmm8, xmm8
    vaesimc xmm3, xmm3
    vaesimc xmm9, xmm9
    vinserti128 ymm2, ymm2, xmm8, 1
    vinserti128 ymm3, ymm3, xmm9, 1
    vaesdeclast ymm2, ymm2, ymm12
    vaesdeclast ymm3, ymm3, ymm12
    vaesdeclast ymm2, ymm2, ymm15
    vaesdeclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm6, ymm0
    vaesenc ymm1, ymm7, ymm1
    vaesenc ymm4, ymm2, ymm4
    vaesenc ymm5, ymm3, ymm5
    vmovdqu ymm12, YMMWORD PTR [rcx + 640]
    vaesdeclast ymm4, ymm4, ymm15
    vaesdeclast ymm5, ymm5, ymm15
    vextracti128 xmm8, ymm0, 1
    vextracti128 xmm9, ymm1, 1
    vaesimc xmm0, xmm0
    vaesimc xmm8, xmm8
    vaesimc xmm1, xmm1
    vaesimc xmm9, xmm9
    vinserti128 ymm0, ymm0, xmm8, 1
    vinserti128 ymm1, ymm1, xmm9, 1
    vaesdeclast ymm0, ymm0, ymm12
    vaesdeclast ymm1, ymm1, ymm12
    vaesdeclast ymm0, ymm0, ymm15
    vaesdeclast ymm1, ymm1, ymm15
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vmovdqu ymm12, YMMWORD PTR [rcx + 576]
    vaesdeclast ymm2, ymm2, ymm15
    vaesdeclast ymm3, ymm3, ymm15
    vextracti128 xmm8, ymm6, 1
    vextracti128 xmm9, ymm7, 1
    vaesimc xmm6, xmm6
    vaesimc xmm8, xmm8
    vaesimc xmm7, xmm7
    vaesimc xmm9, xmm9
    vinserti128 ymm6, ymm6, xmm8, 1
    vinserti128 ymm7, ymm7, xmm9, 1
    vaesdeclast ymm6, ymm6, ymm12
    vaesdeclast ymm7, ymm7, ymm12
    vaesdeclast ymm6, ymm6, ymm15
    vaesdeclast ymm7, ymm7, ymm15
    vaesenc ymm4, ymm2, ymm4
    vaesenc ymm5, ymm3, ymm5
    vaesenc ymm0, ymm6, ymm0
    vaesenc ymm1, ymm7, ymm1
    vmovdqu ymm12, YMMWORD PTR [rcx + 512]
    vaesdeclast ymm0, ymm0, ymm15
    vaesdeclast ymm1, ymm1, ymm15
    vextracti128 xmm8, ymm4, 1
    vextracti128 xmm9, ymm5, 1
    vaesimc xmm4, xmm4
    vaesimc xmm8, xmm8
    vaesimc xmm5, xmm5
    vaesimc xmm9, xmm9
    vinserti128 ymm4, ymm4, xmm8, 1
    vinserti128 ymm5, ymm5, xmm9, 1
    vaesdeclast ymm4, ymm4, ymm12
    vaesdeclast ymm5, ymm5, ymm12
    vaesdeclast ymm4, ymm4, ymm15
    vaesdeclast ymm5, ymm5, ymm15
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vmovdqu ymm12, YMMWORD PTR [rcx + 448]
    vaesdeclast ymm6, ymm6, ymm15
    vaesdeclast ymm7, ymm7, ymm15
    vextracti128 xmm8, ymm2, 1
    vextracti128 xmm9, ymm3, 1
    vaesimc xmm2, xmm2
    vaesimc xmm8, xmm8
    vaesimc xmm3, xmm3
    vaesimc xmm9, xmm9
    vinserti128 ymm2, ymm2, xmm8, 1
    vinserti128 ymm3, ymm3, xmm9, 1
    vaesdeclast ymm2, ymm2, ymm12
    vaesdeclast ymm3, ymm3, ymm12
    vaesdeclast ymm2, ymm2, ymm15
    vaesdeclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm6, ymm0
    vaesenc ymm1, ymm7, ymm1
    vaesenc ymm4, ymm2, ymm4
    vaesenc ymm5, ymm3, ymm5
    vmovdqu ymm12, YMMWORD PTR [rcx + 384]
    vaesdeclast ymm4, ymm4, ymm15
    vaesdeclast ymm5, ymm5, ymm15
    vextracti128 xmm8, ymm0, 1
    vextracti128 xmm9, ymm1, 1
    vaesimc xmm0, xmm0
    vaesimc xmm8, xmm8
    vaesimc xmm1, xmm1
    vaesimc xmm9, xmm9
    vinserti128 ymm0, ymm0, xmm8, 1
    vinserti128 ymm1, ymm1, xmm9, 1
    vaesdeclast ymm0, ymm0, ymm12
    vaesdeclast ymm1, ymm1, ymm12
    vaesdeclast ymm0, ymm0, ymm15
    vaesdeclast ymm1, ymm1, ymm15
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vmovdqu ymm12, YMMWORD PTR [rcx + 320]
    vaesdeclast ymm2, ymm2, ymm15
    vaesdeclast ymm3, ymm3, ymm15
    vextracti128 xmm8, ymm6, 1
    vextracti128 xmm9, ymm7, 1
    vaesimc xmm6, xmm6
    vaesimc xmm8, xmm8
    vaesimc xmm7, xmm7
    vaesimc xmm9, xmm9
    vinserti128 ymm6, ymm6, xmm8, 1
    vinserti128 ymm7, ymm7, xmm9, 1
    vaesdeclast ymm6, ymm6, ymm12
    vaesdeclast ymm7, ymm7, ymm12
    vaesdeclast ymm6, ymm6, ymm15
    vaesdeclast ymm7, ymm7, ymm15
    vaesenc ymm4, ymm2, ymm4
    vaesenc ymm5, ymm3, ymm5
    vaesenc ymm0, ymm6, ymm0
    vaesenc ymm1, ymm7, ymm1
    vmovdqu ymm12, YMMWORD PTR [rcx + 256]
    vaesdeclast ymm0, ymm0, ymm15
    vaesdeclast ymm1, ymm1, ymm15
    vextracti128 xmm8, ymm4, 1
    vextracti128 xmm9, ymm5, 1
    vaesimc xmm4, xmm4
    vaesimc xmm8, xmm8
    vaesimc xmm5, xmm5
    vaesimc xmm9, xmm9
    vinserti128 ymm4, ymm4, xmm8, 1
    vinserti128 ymm5, ymm5, xmm9, 1
    vaesdeclast ymm4, ymm4, ymm12
    vaesdeclast ymm5, ymm5, ymm12
    vaesdeclast ymm4, ymm4, ymm15
    vaesdeclast ymm5, ymm5, ymm15
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vmovdqu ymm12, YMMWORD PTR [rcx + 192]
    vaesdeclast ymm6, ymm6, ymm15
    vaesdeclast ymm7, ymm7, ymm15
    vextracti128 xmm8, ymm2, 1
    vextracti128 xmm9, ymm3, 1
    vaesimc xmm2, xmm2
    vaesimc xmm8, xmm8
    vaesimc xmm3, xmm3
    vaesimc xmm9, xmm9
    vinserti128 ymm2, ymm2, xmm8, 1
    vinserti128 ymm3, ymm3, xmm9, 1
    vaesdeclast ymm2, ymm2, ymm12
    vaesdeclast ymm3, ymm3, ymm12
    vaesdeclast ymm2, ymm2, ymm15
    vaesdeclast ymm3, ymm3, ymm15
    vaesenc ymm0, ymm6, ymm0
    vaesenc ymm1, ymm7, ymm1
    vaesenc ymm4, ymm2, ymm4
    vaesenc ymm5, ymm3, ymm5
    vmovdqu ymm12, YMMWORD PTR [rcx + 128]
    vaesdeclast ymm4, ymm4, ymm15
    vaesdeclast ymm5, ymm5, ymm15
    vextracti128 xmm8, ymm0, 1
    vextracti128 xmm9, ymm1, 1
    vaesimc xmm0, xmm0
    vaesimc xmm8, xmm8
    vaesimc xmm1, xmm1
    vaesimc xmm9, xmm9
    vinserti128 ymm0, ymm0, xmm8, 1
    vinserti128 ymm1, ymm1, xmm9, 1
    vaesdeclast ymm0, ymm0, ymm12
    vaesdeclast ymm1, ymm1, ymm12
    vaesdeclast ymm0, ymm0, ymm15
    vaesdeclast ymm1, ymm1, ymm15
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vmovdqu ymm12, YMMWORD PTR [rcx + 64]
    vaesdeclast ymm2, ymm2, ymm15
    vaesdeclast ymm3, ymm3, ymm15
    vextracti128 xmm8, ymm6, 1
    vextracti128 xmm9, ymm7, 1
    vaesimc xmm6, xmm6
    vaesimc xmm8, xmm8
    vaesimc xmm7, xmm7
    vaesimc xmm9, xmm9
    vinserti128 ymm6, ymm6, xmm8, 1
    vinserti128 ymm7, ymm7, xmm9, 1
    vaesdeclast ymm6, ymm6, ymm12
    vaesdeclast ymm7, ymm7, ymm12
    vaesdeclast ymm6, ymm6, ymm15
    vaesdeclast ymm7, ymm7, ymm15
    vaesenc ymm4, ymm2, ymm4
    vaesenc ymm5, ymm3, ymm5
    vaesenc ymm0, ymm6, ymm0
    vaesenc ymm1, ymm7, ymm1
    vmovdqu ymm12, YMMWORD PTR [rcx]
    vaesdeclast ymm0, ymm0, ymm15
    vaesdeclast ymm1, ymm1, ymm15
    vextracti128 xmm8, ymm4, 1
    vextracti128 xmm9, ymm5, 1
    vaesimc xmm4, xmm4
    vaesimc xmm8, xmm8
    vaesimc xmm5, xmm5
    vaesimc xmm9, xmm9
    vinserti128 ymm4, ymm4, xmm8, 1
    vinserti128 ymm5, ymm5, xmm9, 1
    vaesdeclast ymm4, ymm4, ymm12
    vaesdeclast ymm5, ymm5, ymm12
    vaesdeclast ymm4, ymm4, ymm15
    vaesdeclast ymm5, ymm5, ymm15
    vaesenc ymm2, ymm0, ymm2
    vaesenc ymm3, ymm1, ymm3
    vaesenc ymm6, ymm4, ymm6
    vaesenc ymm7, ymm5, ymm7
    vmovdqu YMMWORD PTR [rax], ymm0
    vmovdqu YMMWORD PTR [rax + 32], ymm1
    vmovdqu YMMWORD PTR [r10], ymm2
    vmovdqu YMMWORD PTR [r10 + 32], ymm3
    vmovdqu YMMWORD PTR [rdx], ymm4
    vmovdqu YMMWORD PTR [rdx + 32], ymm5
    vmovdqu YMMWORD PTR [rsi], ymm6
    vmovdqu YMMWORD PTR [rsi + 32], ymm7
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm12, xmm12, xmm12
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    xor rsi, rsi
    vmovdqu xmm6, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    mov rsi, QWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    add rsp, 120
    vzeroupper
    ret
areion512InversePermutex4Avx2RC ENDP

PUBLIC dumpSIMDRegs
ALIGN 16
dumpSIMDRegs PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov QWORD PTR [rcx + 512], rax
    mov QWORD PTR [rcx + 520], 0
    mov QWORD PTR [rcx + 528], 0
    mov QWORD PTR [rcx + 536], 0
    mov QWORD PTR [rcx + 544], r8
    mov QWORD PTR [rcx + 552], r9
    mov QWORD PTR [rcx + 560], r10
    mov QWORD PTR [rcx + 568], r11
    mov QWORD PTR [rcx + 576], 0
    mov QWORD PTR [rcx + 584], 0
    mov QWORD PTR [rcx + 592], 0
    mov rax, rcx
    mov ecx, edx
    movdqu XMMWORD PTR [rax + 0], xmm0
    movdqu XMMWORD PTR [rax + 16], xmm1
    movdqu XMMWORD PTR [rax + 32], xmm2
    movdqu XMMWORD PTR [rax + 48], xmm3
    movdqu XMMWORD PTR [rax + 64], xmm4
    movdqu XMMWORD PTR [rax + 80], xmm5
    movdqu XMMWORD PTR [rax + 96], xmm6
    movdqu XMMWORD PTR [rax + 112], xmm7
    movdqu XMMWORD PTR [rax + 128], xmm8
    movdqu XMMWORD PTR [rax + 144], xmm9
    movdqu XMMWORD PTR [rax + 160], xmm10
    movdqu XMMWORD PTR [rax + 176], xmm11
    movdqu XMMWORD PTR [rax + 192], xmm12
    movdqu XMMWORD PTR [rax + 208], xmm13
    movdqu XMMWORD PTR [rax + 224], xmm14
    movdqu XMMWORD PTR [rax + 240], xmm15
    test ecx, ecx
    jz dumpDone
    vmovdqu64 XMMWORD PTR [rax + 256], xmm16
    vmovdqu64 XMMWORD PTR [rax + 272], xmm17
    vmovdqu64 XMMWORD PTR [rax + 288], xmm18
    vmovdqu64 XMMWORD PTR [rax + 304], xmm19
    vmovdqu64 XMMWORD PTR [rax + 320], xmm20
    vmovdqu64 XMMWORD PTR [rax + 336], xmm21
    vmovdqu64 XMMWORD PTR [rax + 352], xmm22
    vmovdqu64 XMMWORD PTR [rax + 368], xmm23
    vmovdqu64 XMMWORD PTR [rax + 384], xmm24
    vmovdqu64 XMMWORD PTR [rax + 400], xmm25
    vmovdqu64 XMMWORD PTR [rax + 416], xmm26
    vmovdqu64 XMMWORD PTR [rax + 432], xmm27
    vmovdqu64 XMMWORD PTR [rax + 448], xmm28
    vmovdqu64 XMMWORD PTR [rax + 464], xmm29
    vmovdqu64 XMMWORD PTR [rax + 480], xmm30
    vmovdqu64 XMMWORD PTR [rax + 496], xmm31
    vpxord xmm16, xmm16, xmm16
    vpxord xmm17, xmm17, xmm17
    vpxord xmm18, xmm18, xmm18
    vpxord xmm19, xmm19, xmm19
    vpxord xmm20, xmm20, xmm20
    vpxord xmm21, xmm21, xmm21
    vpxord xmm22, xmm22, xmm22
    vpxord xmm23, xmm23, xmm23
    vpxord xmm24, xmm24, xmm24
    vpxord xmm25, xmm25, xmm25
    vpxord xmm26, xmm26, xmm26
    vpxord xmm27, xmm27, xmm27
    vpxord xmm28, xmm28, xmm28
    vpxord xmm29, xmm29, xmm29
    vpxord xmm30, xmm30, xmm30
    vpxord xmm31, xmm31, xmm31
    vzeroupper
dumpDone:
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    xor r10, r10
    xor r11, r11
    ret
dumpSIMDRegs ENDP

PUBLIC clobberScratchGPRs
ALIGN 16
clobberScratchGPRs PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    xor r10, r10
    xor r11, r11
    ret
clobberScratchGPRs ENDP

PUBLIC dirtySIMDRegForTest
ALIGN 16
dirtySIMDRegForTest PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov r10, rcx
    mov rax, 05555555555555555h
    xor r10, rax
    movq xmm2, r10
    xor rax, rax
    ret
dirtySIMDRegForTest ENDP

PUBLIC areion256EMEncryptAESNI
ALIGN 16
areion256EMEncryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    movdqu XMMWORD PTR [rsp + 0], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [rax]
    movdqu xmm3, XMMWORD PTR [rax + 16]
    pxor xmm0, xmm2
    pxor xmm1, xmm3
    pxor xmm15, xmm15
    movdqu xmm2, XMMWORD PTR [roundConstantsP1]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 16]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 32]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 48]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 80]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 96]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 112]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 144]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [rax + 32]
    movdqu xmm3, XMMWORD PTR [rax + 48]
    pxor xmm0, xmm2
    pxor xmm1, xmm3
    movdqu XMMWORD PTR [rdx], xmm0
    movdqu XMMWORD PTR [rdx + 16], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    movdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion256EMEncryptAESNI ENDP

PUBLIC areion256EMEncryptVEX
ALIGN 16
areion256EMEncryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    vmovdqu XMMWORD PTR [rsp + 0], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vpxor xmm0, xmm0, XMMWORD PTR [rax]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 16]
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 32]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 48]
    vmovdqu XMMWORD PTR [rdx], xmm0
    vmovdqu XMMWORD PTR [rdx + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm3, xmm3, xmm3
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    vmovdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion256EMEncryptVEX ENDP

PUBLIC areion256EMDecryptAESNI
ALIGN 16
areion256EMDecryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    movdqu XMMWORD PTR [rsp + 0], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [rax + 32]
    movdqu xmm3, XMMWORD PTR [rax + 48]
    pxor xmm0, xmm2
    pxor xmm1, xmm3
    pxor xmm15, xmm15
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 144]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 112]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 96]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 80]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 48]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 32]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 16]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [rax]
    movdqu xmm3, XMMWORD PTR [rax + 16]
    pxor xmm0, xmm2
    pxor xmm1, xmm3
    movdqu XMMWORD PTR [rdx], xmm0
    movdqu XMMWORD PTR [rdx + 16], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    movdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion256EMDecryptAESNI ENDP

PUBLIC areion256EMDecryptVEX
ALIGN 16
areion256EMDecryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    vmovdqu XMMWORD PTR [rsp + 0], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 32]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 48]
    vpxor xmm15, xmm15, xmm15
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1]
    vaesenc xmm1, xmm3, xmm1
    vpxor xmm0, xmm0, XMMWORD PTR [rax]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 16]
    vmovdqu XMMWORD PTR [rdx], xmm0
    vmovdqu XMMWORD PTR [rdx + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm3, xmm3, xmm3
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    vmovdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion256EMDecryptVEX ENDP

PUBLIC areion512EMEncryptAESNI
ALIGN 16
areion512EMEncryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    movdqu XMMWORD PTR [rsp + 0], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    movdqu xmm3, XMMWORD PTR [r10 + 48]
    movdqu xmm4, XMMWORD PTR [rax]
    movdqu xmm5, XMMWORD PTR [rax + 16]
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [rax + 32]
    movdqu xmm5, XMMWORD PTR [rax + 48]
    pxor xmm2, xmm4
    pxor xmm3, xmm5
    pxor xmm15, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 16]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 32]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 48]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 64]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 80]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 96]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 112]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 128]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 144]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 160]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 176]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 192]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 208]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 224]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [rax + 64]
    movdqu xmm5, XMMWORD PTR [rax + 80]
    pxor xmm3, xmm4
    pxor xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [rax + 96]
    movdqu xmm5, XMMWORD PTR [rax + 112]
    pxor xmm1, xmm4
    pxor xmm2, xmm5
    movdqu XMMWORD PTR [rdx], xmm3
    movdqu XMMWORD PTR [rdx + 16], xmm0
    movdqu XMMWORD PTR [rdx + 32], xmm1
    movdqu XMMWORD PTR [rdx + 48], xmm2
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    movdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion512EMEncryptAESNI ENDP

PUBLIC areion512EMEncryptVEX
ALIGN 16
areion512EMEncryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    vmovdqu XMMWORD PTR [rsp + 0], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm2, XMMWORD PTR [r10 + 32]
    vmovdqu xmm3, XMMWORD PTR [r10 + 48]
    vpxor xmm0, xmm0, XMMWORD PTR [rax]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 16]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 32]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 48]
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 160]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 176]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 192]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 208]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 224]
    vaesenc xmm0, xmm0, xmm15
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 64]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 80]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 96]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 112]
    vmovdqu XMMWORD PTR [rdx], xmm3
    vmovdqu XMMWORD PTR [rdx + 16], xmm0
    vmovdqu XMMWORD PTR [rdx + 32], xmm1
    vmovdqu XMMWORD PTR [rdx + 48], xmm2
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    vmovdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion512EMEncryptVEX ENDP

PUBLIC areion512EMDecryptAESNI
ALIGN 16
areion512EMDecryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    movdqu XMMWORD PTR [rsp + 0], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    movdqu xmm3, XMMWORD PTR [r10 + 48]
    movdqu xmm4, XMMWORD PTR [rax + 64]
    movdqu xmm5, XMMWORD PTR [rax + 80]
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [rax + 96]
    movdqu xmm5, XMMWORD PTR [rax + 112]
    pxor xmm2, xmm4
    pxor xmm3, xmm5
    pxor xmm15, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 224]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 208]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 192]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 176]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 160]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 144]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 128]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 112]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 96]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 80]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 64]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 48]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 32]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 16]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [rax]
    movdqu xmm5, XMMWORD PTR [rax + 16]
    pxor xmm1, xmm4
    pxor xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [rax + 32]
    movdqu xmm5, XMMWORD PTR [rax + 48]
    pxor xmm3, xmm4
    pxor xmm0, xmm5
    movdqu XMMWORD PTR [rdx], xmm1
    movdqu XMMWORD PTR [rdx + 16], xmm2
    movdqu XMMWORD PTR [rdx + 32], xmm3
    movdqu XMMWORD PTR [rdx + 48], xmm0
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    movdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion512EMDecryptAESNI ENDP

PUBLIC areion512EMDecryptVEX
ALIGN 16
areion512EMDecryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 24
    vmovdqu XMMWORD PTR [rsp + 0], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm2, XMMWORD PTR [r10 + 32]
    vmovdqu xmm3, XMMWORD PTR [r10 + 48]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 64]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 80]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 96]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 112]
    vpxor xmm15, xmm15, xmm15
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 224]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 208]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 192]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 176]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 160]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 144]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 128]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 112]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 96]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 80]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 64]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 48]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 32]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 16]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vpxor xmm1, xmm1, XMMWORD PTR [rax]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 16]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 32]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 48]
    vmovdqu XMMWORD PTR [rdx], xmm1
    vmovdqu XMMWORD PTR [rdx + 16], xmm2
    vmovdqu XMMWORD PTR [rdx + 32], xmm3
    vmovdqu XMMWORD PTR [rdx + 48], xmm0
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    vmovdqu xmm15, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    add rsp, 24
    ret
areion512EMDecryptVEX ENDP

PUBLIC areion256EM2EncryptAESNI
ALIGN 16
areion256EM2EncryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    movdqu XMMWORD PTR [rsp + 0], xmm8
    movdqu XMMWORD PTR [rsp + 16], xmm9
    movdqu XMMWORD PTR [rsp + 32], xmm10
    movdqu XMMWORD PTR [rsp + 48], xmm11
    movdqu XMMWORD PTR [rsp + 64], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm15, xmm15
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    movdqu xmm2, XMMWORD PTR [roundConstantsP1]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 16]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 32]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 48]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 80]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 96]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 112]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 144]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    movdqu xmm2, XMMWORD PTR [roundConstantsP2]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    pxor xmm8, xmm10
    pxor xmm9, xmm11
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    movdqu XMMWORD PTR [rdx], xmm0
    movdqu XMMWORD PTR [rdx + 16], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    movdqu xmm8, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm9, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm10, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm11, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm15, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    add rsp, 88
    ret
areion256EM2EncryptAESNI ENDP

PUBLIC areion256EM2EncryptVEX
ALIGN 16
areion256EM2EncryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    vmovdqu XMMWORD PTR [rsp + 0], xmm8
    vmovdqu XMMWORD PTR [rsp + 16], xmm9
    vmovdqu XMMWORD PTR [rsp + 32], xmm10
    vmovdqu XMMWORD PTR [rsp + 48], xmm11
    vmovdqu XMMWORD PTR [rsp + 64], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm8, XMMWORD PTR [rax]
    vmovdqu xmm9, XMMWORD PTR [rax + 16]
    vmovdqu xmm10, XMMWORD PTR [rax + 32]
    vmovdqu xmm11, XMMWORD PTR [rax + 48]
    vpxor xmm15, xmm15, xmm15
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vpxor xmm8, xmm8, xmm10
    vpxor xmm9, xmm9, xmm11
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vmovdqu XMMWORD PTR [rdx], xmm0
    vmovdqu XMMWORD PTR [rdx + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm3, xmm3, xmm3
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    vmovdqu xmm8, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    add rsp, 88
    ret
areion256EM2EncryptVEX ENDP

PUBLIC areion256EM2DecryptAESNI
ALIGN 16
areion256EM2DecryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    movdqu XMMWORD PTR [rsp + 0], xmm8
    movdqu XMMWORD PTR [rsp + 16], xmm9
    movdqu XMMWORD PTR [rsp + 32], xmm10
    movdqu XMMWORD PTR [rsp + 48], xmm11
    movdqu XMMWORD PTR [rsp + 64], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm15, xmm15
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 144]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 128]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 112]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 96]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 80]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 64]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 48]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 32]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 16]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 144]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 112]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 96]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 80]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 48]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 32]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 16]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    movdqu XMMWORD PTR [rdx], xmm0
    movdqu XMMWORD PTR [rdx + 16], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    movdqu xmm8, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm9, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm10, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm11, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm15, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    add rsp, 88
    ret
areion256EM2DecryptAESNI ENDP

PUBLIC areion256EM2DecryptVEX
ALIGN 16
areion256EM2DecryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    vmovdqu XMMWORD PTR [rsp + 0], xmm8
    vmovdqu XMMWORD PTR [rsp + 16], xmm9
    vmovdqu XMMWORD PTR [rsp + 32], xmm10
    vmovdqu XMMWORD PTR [rsp + 48], xmm11
    vmovdqu XMMWORD PTR [rsp + 64], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm8, XMMWORD PTR [rax]
    vmovdqu xmm9, XMMWORD PTR [rax + 16]
    vmovdqu xmm10, XMMWORD PTR [rax + 32]
    vmovdqu xmm11, XMMWORD PTR [rax + 48]
    vpxor xmm15, xmm15, xmm15
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2]
    vaesenc xmm1, xmm3, xmm1
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1]
    vaesenc xmm1, xmm3, xmm1
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vmovdqu XMMWORD PTR [rdx], xmm0
    vmovdqu XMMWORD PTR [rdx + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm3, xmm3, xmm3
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    vmovdqu xmm8, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    add rsp, 88
    ret
areion256EM2DecryptVEX ENDP

PUBLIC areion512EM2EncryptAESNI
ALIGN 16
areion512EM2EncryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm10
    movdqu XMMWORD PTR [rsp + 80], xmm11
    movdqu XMMWORD PTR [rsp + 96], xmm12
    movdqu XMMWORD PTR [rsp + 112], xmm13
    movdqu XMMWORD PTR [rsp + 128], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    movdqu xmm3, XMMWORD PTR [r10 + 48]
    movdqu xmm6, XMMWORD PTR [rax]
    movdqu xmm7, XMMWORD PTR [rax + 16]
    movdqu xmm8, XMMWORD PTR [rax + 32]
    movdqu xmm9, XMMWORD PTR [rax + 48]
    movdqu xmm10, XMMWORD PTR [rax + 64]
    movdqu xmm11, XMMWORD PTR [rax + 80]
    movdqu xmm12, XMMWORD PTR [rax + 96]
    movdqu xmm13, XMMWORD PTR [rax + 112]
    pxor xmm15, xmm15
    pxor xmm0, xmm6
    pxor xmm1, xmm7
    pxor xmm2, xmm8
    pxor xmm3, xmm9
    movdqu xmm4, XMMWORD PTR [roundConstantsP1]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 16]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 32]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 48]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 64]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 80]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 96]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 112]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 128]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 144]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 160]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 176]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 192]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 208]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 224]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    pxor xmm3, xmm10
    pxor xmm0, xmm11
    pxor xmm1, xmm12
    pxor xmm2, xmm13
    movdqu xmm4, XMMWORD PTR [roundConstantsP2]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 160]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 176]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 192]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 208]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 224]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    pxor xmm8, xmm12
    pxor xmm9, xmm13
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    movdqu XMMWORD PTR [rdx], xmm2
    movdqu XMMWORD PTR [rdx + 16], xmm3
    movdqu XMMWORD PTR [rdx + 32], xmm0
    movdqu XMMWORD PTR [rdx + 48], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    movdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm12, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm13, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm15, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    add rsp, 152
    ret
areion512EM2EncryptAESNI ENDP

PUBLIC areion512EM2EncryptVEX
ALIGN 16
areion512EM2EncryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm8
    vmovdqu XMMWORD PTR [rsp + 48], xmm9
    vmovdqu XMMWORD PTR [rsp + 64], xmm10
    vmovdqu XMMWORD PTR [rsp + 80], xmm11
    vmovdqu XMMWORD PTR [rsp + 96], xmm12
    vmovdqu XMMWORD PTR [rsp + 112], xmm13
    vmovdqu XMMWORD PTR [rsp + 128], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm2, XMMWORD PTR [r10 + 32]
    vmovdqu xmm3, XMMWORD PTR [r10 + 48]
    vmovdqu xmm6, XMMWORD PTR [rax]
    vmovdqu xmm7, XMMWORD PTR [rax + 16]
    vmovdqu xmm8, XMMWORD PTR [rax + 32]
    vmovdqu xmm9, XMMWORD PTR [rax + 48]
    vmovdqu xmm10, XMMWORD PTR [rax + 64]
    vmovdqu xmm11, XMMWORD PTR [rax + 80]
    vmovdqu xmm12, XMMWORD PTR [rax + 96]
    vmovdqu xmm13, XMMWORD PTR [rax + 112]
    vpxor xmm15, xmm15, xmm15
    vpxor xmm0, xmm0, xmm6
    vpxor xmm1, xmm1, xmm7
    vpxor xmm2, xmm2, xmm8
    vpxor xmm3, xmm3, xmm9
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 160]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 176]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 192]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 208]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 224]
    vaesenc xmm0, xmm0, xmm15
    vpxor xmm3, xmm3, xmm10
    vpxor xmm0, xmm0, xmm11
    vpxor xmm1, xmm1, xmm12
    vpxor xmm2, xmm2, xmm13
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 160]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 176]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 192]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 208]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 224]
    vaesenc xmm3, xmm3, xmm15
    vpxor xmm6, xmm6, xmm10
    vpxor xmm7, xmm7, xmm11
    vpxor xmm8, xmm8, xmm12
    vpxor xmm9, xmm9, xmm13
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vmovdqu XMMWORD PTR [rdx], xmm2
    vmovdqu XMMWORD PTR [rdx + 16], xmm3
    vmovdqu XMMWORD PTR [rdx + 32], xmm0
    vmovdqu XMMWORD PTR [rdx + 48], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    add rsp, 152
    ret
areion512EM2EncryptVEX ENDP

PUBLIC areion512EM2DecryptAESNI
ALIGN 16
areion512EM2DecryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm10
    movdqu XMMWORD PTR [rsp + 80], xmm11
    movdqu XMMWORD PTR [rsp + 96], xmm12
    movdqu XMMWORD PTR [rsp + 112], xmm13
    movdqu XMMWORD PTR [rsp + 128], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    movdqu xmm3, XMMWORD PTR [r10 + 48]
    movdqu xmm6, XMMWORD PTR [rax]
    movdqu xmm7, XMMWORD PTR [rax + 16]
    movdqu xmm8, XMMWORD PTR [rax + 32]
    movdqu xmm9, XMMWORD PTR [rax + 48]
    movdqu xmm10, XMMWORD PTR [rax + 64]
    movdqu xmm11, XMMWORD PTR [rax + 80]
    movdqu xmm12, XMMWORD PTR [rax + 96]
    movdqu xmm13, XMMWORD PTR [rax + 112]
    pxor xmm15, xmm15
    pxor xmm0, xmm6
    pxor xmm1, xmm7
    pxor xmm2, xmm8
    pxor xmm3, xmm9
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    pxor xmm2, xmm12
    pxor xmm3, xmm13
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 224]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 208]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 192]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 176]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 160]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 144]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 128]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 112]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 96]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 80]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 64]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 48]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 32]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 16]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    pxor xmm1, xmm10
    pxor xmm2, xmm11
    pxor xmm3, xmm12
    pxor xmm0, xmm13
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 224]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 208]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 192]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 176]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 160]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 144]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 128]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 112]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 96]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 80]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 64]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 48]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 32]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 16]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    movdqu XMMWORD PTR [rdx], xmm2
    movdqu XMMWORD PTR [rdx + 16], xmm3
    movdqu XMMWORD PTR [rdx + 32], xmm0
    movdqu XMMWORD PTR [rdx + 48], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    movdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm12, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm13, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm15, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    add rsp, 152
    ret
areion512EM2DecryptAESNI ENDP

PUBLIC areion512EM2DecryptVEX
ALIGN 16
areion512EM2DecryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm8
    vmovdqu XMMWORD PTR [rsp + 48], xmm9
    vmovdqu XMMWORD PTR [rsp + 64], xmm10
    vmovdqu XMMWORD PTR [rsp + 80], xmm11
    vmovdqu XMMWORD PTR [rsp + 96], xmm12
    vmovdqu XMMWORD PTR [rsp + 112], xmm13
    vmovdqu XMMWORD PTR [rsp + 128], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm2, XMMWORD PTR [r10 + 32]
    vmovdqu xmm3, XMMWORD PTR [r10 + 48]
    vmovdqu xmm6, XMMWORD PTR [rax]
    vmovdqu xmm7, XMMWORD PTR [rax + 16]
    vmovdqu xmm8, XMMWORD PTR [rax + 32]
    vmovdqu xmm9, XMMWORD PTR [rax + 48]
    vmovdqu xmm10, XMMWORD PTR [rax + 64]
    vmovdqu xmm11, XMMWORD PTR [rax + 80]
    vmovdqu xmm12, XMMWORD PTR [rax + 96]
    vmovdqu xmm13, XMMWORD PTR [rax + 112]
    vpxor xmm15, xmm15, xmm15
    vpxor xmm0, xmm0, xmm6
    vpxor xmm1, xmm1, xmm7
    vpxor xmm2, xmm2, xmm8
    vpxor xmm3, xmm3, xmm9
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm12
    vpxor xmm3, xmm3, xmm13
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 224]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 208]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 192]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 176]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 160]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 144]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 128]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 112]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 96]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 80]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 64]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 48]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 32]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 16]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vpxor xmm1, xmm1, xmm10
    vpxor xmm2, xmm2, xmm11
    vpxor xmm3, xmm3, xmm12
    vpxor xmm0, xmm0, xmm13
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 224]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 208]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 192]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 176]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 160]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 144]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 128]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 112]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 96]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 80]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 64]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 48]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 32]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 16]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vmovdqu XMMWORD PTR [rdx], xmm2
    vmovdqu XMMWORD PTR [rdx + 16], xmm3
    vmovdqu XMMWORD PTR [rdx + 32], xmm0
    vmovdqu XMMWORD PTR [rdx + 48], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rdx, rdx
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    add rsp, 152
    ret
areion512EM2DecryptVEX ENDP

PUBLIC areion256TEMEncryptAESNI
ALIGN 16
areion256TEMEncryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 56
    movdqu XMMWORD PTR [rsp + 0], xmm8
    movdqu XMMWORD PTR [rsp + 16], xmm9
    movdqu XMMWORD PTR [rsp + 32], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    movdqu xmm0, XMMWORD PTR [rcx]
    movdqu xmm1, XMMWORD PTR [rcx + 16]
    movdqu xmm2, XMMWORD PTR [rax + 32]
    movdqu xmm3, XMMWORD PTR [rax + 48]
    pxor xmm0, xmm2
    pxor xmm1, xmm3
    pxor xmm15, xmm15
    movdqu xmm2, XMMWORD PTR [roundConstantsP2]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    pxor xmm8, xmm0
    pxor xmm9, xmm1
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    movdqu xmm2, XMMWORD PTR [roundConstantsP1]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 16]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 32]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 48]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 80]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 96]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 112]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 144]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    movdqu XMMWORD PTR [rdx], xmm0
    movdqu XMMWORD PTR [rdx + 16], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    movdqu xmm8, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm9, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm15, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    add rsp, 56
    ret
areion256TEMEncryptAESNI ENDP

PUBLIC areion256TEMEncryptVEX
ALIGN 16
areion256TEMEncryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 56
    vmovdqu XMMWORD PTR [rsp + 0], xmm8
    vmovdqu XMMWORD PTR [rsp + 16], xmm9
    vmovdqu XMMWORD PTR [rsp + 32], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rcx]
    vmovdqu xmm1, XMMWORD PTR [rcx + 16]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 32]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 48]
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vpxor xmm8, xmm0, XMMWORD PTR [rax]
    vpxor xmm9, xmm1, XMMWORD PTR [rax + 16]
    vpxor xmm0, xmm8, XMMWORD PTR [r10]
    vpxor xmm1, xmm9, XMMWORD PTR [r10 + 16]
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vmovdqu XMMWORD PTR [rdx], xmm0
    vmovdqu XMMWORD PTR [rdx + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm3, xmm3, xmm3
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    vmovdqu xmm8, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    add rsp, 56
    ret
areion256TEMEncryptVEX ENDP

PUBLIC areion256TEMDecryptAESNI
ALIGN 16
areion256TEMDecryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 56
    movdqu XMMWORD PTR [rsp + 0], xmm8
    movdqu XMMWORD PTR [rsp + 16], xmm9
    movdqu XMMWORD PTR [rsp + 32], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    movdqu xmm0, XMMWORD PTR [rcx]
    movdqu xmm1, XMMWORD PTR [rcx + 16]
    movdqu xmm2, XMMWORD PTR [rax + 32]
    movdqu xmm3, XMMWORD PTR [rax + 48]
    pxor xmm0, xmm2
    pxor xmm1, xmm3
    pxor xmm15, xmm15
    movdqu xmm2, XMMWORD PTR [roundConstantsP2]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    pxor xmm8, xmm0
    pxor xmm9, xmm1
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 144]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 112]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 96]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 80]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 48]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 32]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 16]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    movdqu XMMWORD PTR [rdx], xmm0
    movdqu XMMWORD PTR [rdx + 16], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    movdqu xmm8, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm9, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm15, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    add rsp, 56
    ret
areion256TEMDecryptAESNI ENDP

PUBLIC areion256TEMDecryptVEX
ALIGN 16
areion256TEMDecryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 56
    vmovdqu XMMWORD PTR [rsp + 0], xmm8
    vmovdqu XMMWORD PTR [rsp + 16], xmm9
    vmovdqu XMMWORD PTR [rsp + 32], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rcx]
    vmovdqu xmm1, XMMWORD PTR [rcx + 16]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 32]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 48]
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vpxor xmm8, xmm0, XMMWORD PTR [rax]
    vpxor xmm9, xmm1, XMMWORD PTR [rax + 16]
    vpxor xmm0, xmm8, XMMWORD PTR [r10]
    vpxor xmm1, xmm9, XMMWORD PTR [r10 + 16]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1]
    vaesenc xmm1, xmm3, xmm1
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vmovdqu XMMWORD PTR [rdx], xmm0
    vmovdqu XMMWORD PTR [rdx + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm3, xmm3, xmm3
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    vmovdqu xmm8, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    add rsp, 56
    ret
areion256TEMDecryptVEX ENDP

PUBLIC areion512TEMEncryptAESNI
ALIGN 16
areion512TEMEncryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    movdqu xmm0, XMMWORD PTR [rcx]
    movdqu xmm1, XMMWORD PTR [rcx + 16]
    movdqu xmm2, XMMWORD PTR [rcx + 32]
    movdqu xmm3, XMMWORD PTR [rcx + 48]
    movdqu xmm4, XMMWORD PTR [rax + 64]
    movdqu xmm5, XMMWORD PTR [rax + 80]
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [rax + 96]
    movdqu xmm5, XMMWORD PTR [rax + 112]
    pxor xmm2, xmm4
    pxor xmm3, xmm5
    pxor xmm15, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 160]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 176]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 192]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 208]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 224]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm6, XMMWORD PTR [rax]
    movdqu xmm7, XMMWORD PTR [rax + 16]
    movdqu xmm8, XMMWORD PTR [rax + 32]
    movdqu xmm9, XMMWORD PTR [rax + 48]
    pxor xmm6, xmm3
    pxor xmm7, xmm0
    pxor xmm8, xmm1
    pxor xmm9, xmm2
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    movdqu xmm3, XMMWORD PTR [r10 + 48]
    pxor xmm0, xmm6
    pxor xmm1, xmm7
    pxor xmm2, xmm8
    pxor xmm3, xmm9
    movdqu xmm4, XMMWORD PTR [roundConstantsP1]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 16]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 32]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 48]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 64]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 80]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 96]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 112]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 128]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 144]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 160]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 176]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 192]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 208]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 224]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    pxor xmm3, xmm6
    pxor xmm0, xmm7
    pxor xmm1, xmm8
    pxor xmm2, xmm9
    movdqu XMMWORD PTR [rdx], xmm3
    movdqu XMMWORD PTR [rdx + 16], xmm0
    movdqu XMMWORD PTR [rdx + 32], xmm1
    movdqu XMMWORD PTR [rdx + 48], xmm2
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    movdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm15, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    add rsp, 88
    ret
areion512TEMEncryptAESNI ENDP

PUBLIC areion512TEMEncryptVEX
ALIGN 16
areion512TEMEncryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm8
    vmovdqu XMMWORD PTR [rsp + 48], xmm9
    vmovdqu XMMWORD PTR [rsp + 64], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rcx]
    vmovdqu xmm1, XMMWORD PTR [rcx + 16]
    vmovdqu xmm2, XMMWORD PTR [rcx + 32]
    vmovdqu xmm3, XMMWORD PTR [rcx + 48]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 64]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 80]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 96]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 112]
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 160]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 176]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 192]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 208]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 224]
    vaesenc xmm0, xmm0, xmm15
    vpxor xmm6, xmm3, XMMWORD PTR [rax]
    vpxor xmm7, xmm0, XMMWORD PTR [rax + 16]
    vpxor xmm8, xmm1, XMMWORD PTR [rax + 32]
    vpxor xmm9, xmm2, XMMWORD PTR [rax + 48]
    vpxor xmm0, xmm6, XMMWORD PTR [r10]
    vpxor xmm1, xmm7, XMMWORD PTR [r10 + 16]
    vpxor xmm2, xmm8, XMMWORD PTR [r10 + 32]
    vpxor xmm3, xmm9, XMMWORD PTR [r10 + 48]
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 160]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 176]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 192]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 208]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 224]
    vaesenc xmm0, xmm0, xmm15
    vpxor xmm3, xmm3, xmm6
    vpxor xmm0, xmm0, xmm7
    vpxor xmm1, xmm1, xmm8
    vpxor xmm2, xmm2, xmm9
    vmovdqu XMMWORD PTR [rdx], xmm3
    vmovdqu XMMWORD PTR [rdx + 16], xmm0
    vmovdqu XMMWORD PTR [rdx + 32], xmm1
    vmovdqu XMMWORD PTR [rdx + 48], xmm2
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    add rsp, 88
    ret
areion512TEMEncryptVEX ENDP

PUBLIC areion512TEMDecryptAESNI
ALIGN 16
areion512TEMDecryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    movdqu xmm0, XMMWORD PTR [rcx]
    movdqu xmm1, XMMWORD PTR [rcx + 16]
    movdqu xmm2, XMMWORD PTR [rcx + 32]
    movdqu xmm3, XMMWORD PTR [rcx + 48]
    movdqu xmm4, XMMWORD PTR [rax + 64]
    movdqu xmm5, XMMWORD PTR [rax + 80]
    pxor xmm0, xmm4
    pxor xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [rax + 96]
    movdqu xmm5, XMMWORD PTR [rax + 112]
    pxor xmm2, xmm4
    pxor xmm3, xmm5
    pxor xmm15, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 160]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 176]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 192]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 208]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 224]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm6, XMMWORD PTR [rax]
    movdqu xmm7, XMMWORD PTR [rax + 16]
    movdqu xmm8, XMMWORD PTR [rax + 32]
    movdqu xmm9, XMMWORD PTR [rax + 48]
    pxor xmm6, xmm3
    pxor xmm7, xmm0
    pxor xmm8, xmm1
    pxor xmm9, xmm2
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    movdqu xmm3, XMMWORD PTR [r10 + 48]
    pxor xmm0, xmm6
    pxor xmm1, xmm7
    pxor xmm2, xmm8
    pxor xmm3, xmm9
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 224]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 208]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 192]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 176]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 160]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 144]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 128]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 112]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 96]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 80]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 64]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 48]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 32]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 16]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    pxor xmm1, xmm6
    pxor xmm2, xmm7
    pxor xmm3, xmm8
    pxor xmm0, xmm9
    movdqu XMMWORD PTR [rdx], xmm1
    movdqu XMMWORD PTR [rdx + 16], xmm2
    movdqu XMMWORD PTR [rdx + 32], xmm3
    movdqu XMMWORD PTR [rdx + 48], xmm0
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    movdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm15, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    add rsp, 88
    ret
areion512TEMDecryptAESNI ENDP

PUBLIC areion512TEMDecryptVEX
ALIGN 16
areion512TEMDecryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm8
    vmovdqu XMMWORD PTR [rsp + 48], xmm9
    vmovdqu XMMWORD PTR [rsp + 64], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rcx]
    vmovdqu xmm1, XMMWORD PTR [rcx + 16]
    vmovdqu xmm2, XMMWORD PTR [rcx + 32]
    vmovdqu xmm3, XMMWORD PTR [rcx + 48]
    vpxor xmm0, xmm0, XMMWORD PTR [rax + 64]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 80]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 96]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 112]
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 160]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 176]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 192]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 208]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 224]
    vaesenc xmm0, xmm0, xmm15
    vpxor xmm6, xmm3, XMMWORD PTR [rax]
    vpxor xmm7, xmm0, XMMWORD PTR [rax + 16]
    vpxor xmm8, xmm1, XMMWORD PTR [rax + 32]
    vpxor xmm9, xmm2, XMMWORD PTR [rax + 48]
    vpxor xmm0, xmm6, XMMWORD PTR [r10]
    vpxor xmm1, xmm7, XMMWORD PTR [r10 + 16]
    vpxor xmm2, xmm8, XMMWORD PTR [r10 + 32]
    vpxor xmm3, xmm9, XMMWORD PTR [r10 + 48]
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 224]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 208]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 192]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 176]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 160]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 144]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 128]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 112]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 96]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 80]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 64]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 48]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 32]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 16]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vpxor xmm1, xmm1, xmm6
    vpxor xmm2, xmm2, xmm7
    vpxor xmm3, xmm3, xmm8
    vpxor xmm0, xmm0, xmm9
    vmovdqu XMMWORD PTR [rdx], xmm1
    vmovdqu XMMWORD PTR [rdx + 16], xmm2
    vmovdqu XMMWORD PTR [rdx + 32], xmm3
    vmovdqu XMMWORD PTR [rdx + 48], xmm0
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    add rsp, 88
    ret
areion512TEMDecryptVEX ENDP

PUBLIC areion256TEM2EncryptAESNI
ALIGN 16
areion256TEM2EncryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 120
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm10
    movdqu XMMWORD PTR [rsp + 80], xmm11
    movdqu XMMWORD PTR [rsp + 96], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    movdqu xmm0, XMMWORD PTR [rcx]
    movdqu xmm1, XMMWORD PTR [rcx + 16]
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    movdqa xmm2, xmm0
    movdqa xmm3, xmm1
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    pxor xmm15, xmm15
    movdqu xmm6, XMMWORD PTR [roundConstantsP1]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm2
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm1
    aesenc xmm5, xmm3
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    movdqa xmm1, xmm4
    movdqa xmm3, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 16]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm4, xmm1
    movdqa xmm5, xmm3
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm0
    aesenc xmm5, xmm2
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    movdqa xmm0, xmm4
    movdqa xmm2, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 32]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm2
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm1
    aesenc xmm5, xmm3
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    movdqa xmm1, xmm4
    movdqa xmm3, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 48]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm4, xmm1
    movdqa xmm5, xmm3
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm0
    aesenc xmm5, xmm2
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    movdqa xmm0, xmm4
    movdqa xmm2, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 64]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm2
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm1
    aesenc xmm5, xmm3
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    movdqa xmm1, xmm4
    movdqa xmm3, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 80]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm4, xmm1
    movdqa xmm5, xmm3
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm0
    aesenc xmm5, xmm2
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    movdqa xmm0, xmm4
    movdqa xmm2, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 96]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm2
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm1
    aesenc xmm5, xmm3
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    movdqa xmm1, xmm4
    movdqa xmm3, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 112]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm4, xmm1
    movdqa xmm5, xmm3
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm0
    aesenc xmm5, xmm2
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    movdqa xmm0, xmm4
    movdqa xmm2, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 128]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm2
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm1
    aesenc xmm5, xmm3
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    movdqa xmm1, xmm4
    movdqa xmm3, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 144]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm4, xmm1
    movdqa xmm5, xmm3
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm0
    aesenc xmm5, xmm2
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    movdqa xmm0, xmm4
    movdqa xmm2, xmm5
    pxor xmm8, xmm0
    pxor xmm9, xmm1
    pxor xmm10, xmm2
    pxor xmm11, xmm3
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    movdqu xmm2, XMMWORD PTR [roundConstantsP1]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 16]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 32]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 48]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 80]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 96]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 112]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 144]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    movdqu xmm2, XMMWORD PTR [roundConstantsP2]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    aesenclast xmm0, xmm15
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    aesenclast xmm1, xmm15
    movdqa xmm0, xmm3
    pxor xmm8, xmm10
    pxor xmm9, xmm11
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    movdqu XMMWORD PTR [rdx], xmm0
    movdqu XMMWORD PTR [rdx + 16], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    movdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm15, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    add rsp, 120
    ret
areion256TEM2EncryptAESNI ENDP

PUBLIC areion256TEM2EncryptVEX
ALIGN 16
areion256TEM2EncryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    vmovdqu XMMWORD PTR [rsp + 0], xmm8
    vmovdqu XMMWORD PTR [rsp + 16], xmm9
    vmovdqu XMMWORD PTR [rsp + 32], xmm10
    vmovdqu XMMWORD PTR [rsp + 48], xmm11
    vmovdqu XMMWORD PTR [rsp + 64], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rcx]
    vmovdqu xmm1, XMMWORD PTR [rcx + 16]
    vmovdqu xmm8, XMMWORD PTR [rax]
    vmovdqu xmm9, XMMWORD PTR [rax + 16]
    vmovdqu xmm10, XMMWORD PTR [rax + 32]
    vmovdqu xmm11, XMMWORD PTR [rax + 48]
    vpxor xmm2, xmm0, xmm10
    vpxor xmm3, xmm1, xmm11
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm4, xmm0, XMMWORD PTR [roundConstantsP1]
    vaesenc xmm5, xmm2, XMMWORD PTR [roundConstantsP2]
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm4, xmm1
    vaesenc xmm3, xmm5, xmm3
    vaesenc xmm4, xmm1, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenc xmm5, xmm3, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenc xmm0, xmm4, xmm0
    vaesenc xmm2, xmm5, xmm2
    vaesenc xmm4, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenc xmm5, xmm2, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm4, xmm1
    vaesenc xmm3, xmm5, xmm3
    vaesenc xmm4, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenc xmm5, xmm3, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenc xmm0, xmm4, xmm0
    vaesenc xmm2, xmm5, xmm2
    vaesenc xmm4, xmm0, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenc xmm5, xmm2, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm4, xmm1
    vaesenc xmm3, xmm5, xmm3
    vaesenc xmm4, xmm1, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenc xmm5, xmm3, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenc xmm0, xmm4, xmm0
    vaesenc xmm2, xmm5, xmm2
    vaesenc xmm4, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenc xmm5, xmm2, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm4, xmm1
    vaesenc xmm3, xmm5, xmm3
    vaesenc xmm4, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenc xmm5, xmm3, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenc xmm0, xmm4, xmm0
    vaesenc xmm2, xmm5, xmm2
    vaesenc xmm4, xmm0, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenc xmm5, xmm2, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm4, xmm1
    vaesenc xmm3, xmm5, xmm3
    vaesenc xmm4, xmm1, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenc xmm5, xmm3, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenc xmm0, xmm4, xmm0
    vaesenc xmm2, xmm5, xmm2
    vpxor xmm8, xmm8, xmm0
    vpxor xmm9, xmm9, xmm1
    vpxor xmm10, xmm10, xmm2
    vpxor xmm11, xmm11, xmm3
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenclast xmm0, xmm0, xmm15
    vaesenc xmm1, xmm3, xmm1
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vpxor xmm8, xmm8, xmm10
    vpxor xmm9, xmm9, xmm11
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vmovdqu XMMWORD PTR [rdx], xmm0
    vmovdqu XMMWORD PTR [rdx + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    vmovdqu xmm8, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    add rsp, 88
    ret
areion256TEM2EncryptVEX ENDP

PUBLIC areion256TEM2DecryptAESNI
ALIGN 16
areion256TEM2DecryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 120
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm10
    movdqu XMMWORD PTR [rsp + 80], xmm11
    movdqu XMMWORD PTR [rsp + 96], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    movdqu xmm0, XMMWORD PTR [rcx]
    movdqu xmm1, XMMWORD PTR [rcx + 16]
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    movdqa xmm2, xmm0
    movdqa xmm3, xmm1
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    pxor xmm15, xmm15
    movdqu xmm6, XMMWORD PTR [roundConstantsP1]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm2
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm1
    aesenc xmm5, xmm3
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    movdqa xmm1, xmm4
    movdqa xmm3, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 16]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm4, xmm1
    movdqa xmm5, xmm3
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm0
    aesenc xmm5, xmm2
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    movdqa xmm0, xmm4
    movdqa xmm2, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 32]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm2
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm1
    aesenc xmm5, xmm3
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    movdqa xmm1, xmm4
    movdqa xmm3, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 48]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm4, xmm1
    movdqa xmm5, xmm3
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm0
    aesenc xmm5, xmm2
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    movdqa xmm0, xmm4
    movdqa xmm2, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 64]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm2
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm1
    aesenc xmm5, xmm3
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    movdqa xmm1, xmm4
    movdqa xmm3, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 80]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm4, xmm1
    movdqa xmm5, xmm3
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm0
    aesenc xmm5, xmm2
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    movdqa xmm0, xmm4
    movdqa xmm2, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 96]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm2
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm1
    aesenc xmm5, xmm3
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    movdqa xmm1, xmm4
    movdqa xmm3, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 112]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm4, xmm1
    movdqa xmm5, xmm3
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm0
    aesenc xmm5, xmm2
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    movdqa xmm0, xmm4
    movdqa xmm2, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 128]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm2
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm1
    aesenc xmm5, xmm3
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm15
    movdqa xmm1, xmm4
    movdqa xmm3, xmm5
    movdqu xmm6, XMMWORD PTR [roundConstantsP1 + 144]
    movdqu xmm7, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm4, xmm1
    movdqa xmm5, xmm3
    aesenc xmm4, xmm6
    aesenc xmm5, xmm7
    aesenc xmm4, xmm0
    aesenc xmm5, xmm2
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm15
    movdqa xmm0, xmm4
    movdqa xmm2, xmm5
    pxor xmm8, xmm0
    pxor xmm9, xmm1
    pxor xmm10, xmm2
    pxor xmm11, xmm3
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 144]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 128]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 112]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 96]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 80]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 64]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 48]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 32]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2 + 16]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP2]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 144]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 112]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 96]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 80]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 48]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 32]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1 + 16]
    aesdeclast xmm1, xmm15
    movdqa xmm3, xmm1
    aesenc xmm3, xmm2
    aesenc xmm3, xmm0
    movdqa xmm0, xmm3
    movdqu xmm2, XMMWORD PTR [roundConstantsP1]
    aesdeclast xmm0, xmm15
    movdqa xmm3, xmm0
    aesenc xmm3, xmm2
    aesenc xmm3, xmm1
    movdqa xmm1, xmm3
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    movdqu XMMWORD PTR [rdx], xmm0
    movdqu XMMWORD PTR [rdx + 16], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    movdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm15, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    add rsp, 120
    ret
areion256TEM2DecryptAESNI ENDP

PUBLIC areion256TEM2DecryptVEX
ALIGN 16
areion256TEM2DecryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 88
    vmovdqu XMMWORD PTR [rsp + 0], xmm8
    vmovdqu XMMWORD PTR [rsp + 16], xmm9
    vmovdqu XMMWORD PTR [rsp + 32], xmm10
    vmovdqu XMMWORD PTR [rsp + 48], xmm11
    vmovdqu XMMWORD PTR [rsp + 64], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rcx]
    vmovdqu xmm1, XMMWORD PTR [rcx + 16]
    vmovdqu xmm8, XMMWORD PTR [rax]
    vmovdqu xmm9, XMMWORD PTR [rax + 16]
    vmovdqu xmm10, XMMWORD PTR [rax + 32]
    vmovdqu xmm11, XMMWORD PTR [rax + 48]
    vpxor xmm2, xmm0, xmm10
    vpxor xmm3, xmm1, xmm11
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm4, xmm0, XMMWORD PTR [roundConstantsP1]
    vaesenc xmm5, xmm2, XMMWORD PTR [roundConstantsP2]
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm4, xmm1
    vaesenc xmm3, xmm5, xmm3
    vaesenc xmm4, xmm1, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenc xmm5, xmm3, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenc xmm0, xmm4, xmm0
    vaesenc xmm2, xmm5, xmm2
    vaesenc xmm4, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenc xmm5, xmm2, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm4, xmm1
    vaesenc xmm3, xmm5, xmm3
    vaesenc xmm4, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenc xmm5, xmm3, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenc xmm0, xmm4, xmm0
    vaesenc xmm2, xmm5, xmm2
    vaesenc xmm4, xmm0, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenc xmm5, xmm2, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm4, xmm1
    vaesenc xmm3, xmm5, xmm3
    vaesenc xmm4, xmm1, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenc xmm5, xmm3, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenc xmm0, xmm4, xmm0
    vaesenc xmm2, xmm5, xmm2
    vaesenc xmm4, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenc xmm5, xmm2, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm4, xmm1
    vaesenc xmm3, xmm5, xmm3
    vaesenc xmm4, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenc xmm5, xmm3, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenc xmm0, xmm4, xmm0
    vaesenc xmm2, xmm5, xmm2
    vaesenc xmm4, xmm0, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenc xmm5, xmm2, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm4, xmm1
    vaesenc xmm3, xmm5, xmm3
    vaesenc xmm4, xmm1, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenc xmm5, xmm3, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, xmm15
    vaesenc xmm0, xmm4, xmm0
    vaesenc xmm2, xmm5, xmm2
    vpxor xmm8, xmm8, xmm0
    vpxor xmm9, xmm9, xmm1
    vpxor xmm10, xmm10, xmm2
    vpxor xmm11, xmm11, xmm3
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP2]
    vaesenc xmm1, xmm3, xmm1
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenc xmm1, xmm3, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm3, xmm1, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm0, XMMWORD PTR [roundConstantsP1]
    vaesenc xmm1, xmm3, xmm1
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vmovdqu XMMWORD PTR [rdx], xmm0
    vmovdqu XMMWORD PTR [rdx + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    vmovdqu xmm8, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    add rsp, 88
    ret
areion256TEM2DecryptVEX ENDP

PUBLIC areion512TEM2EncryptAESNI
ALIGN 16
areion512TEM2EncryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm10
    movdqu XMMWORD PTR [rsp + 80], xmm11
    movdqu XMMWORD PTR [rsp + 96], xmm12
    movdqu XMMWORD PTR [rsp + 112], xmm13
    movdqu XMMWORD PTR [rsp + 128], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    movdqu xmm0, XMMWORD PTR [rcx]
    movdqu xmm1, XMMWORD PTR [rcx + 16]
    movdqu xmm2, XMMWORD PTR [rcx + 32]
    movdqu xmm3, XMMWORD PTR [rcx + 48]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm1
    movdqa xmm6, xmm2
    movdqa xmm7, xmm3
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 64]
    movdqu xmm9, XMMWORD PTR [rax + 80]
    movdqu xmm10, XMMWORD PTR [rax + 96]
    movdqu xmm11, XMMWORD PTR [rax + 112]
    pxor xmm4, xmm8
    pxor xmm5, xmm9
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    pxor xmm15, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 16]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 32]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 48]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 64]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 80]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 96]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 112]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 128]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 144]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 160]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 160]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 176]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 176]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 192]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 192]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 208]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 208]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 224]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 224]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm10, XMMWORD PTR [rax + 64]
    movdqu xmm11, XMMWORD PTR [rax + 80]
    movdqu xmm12, XMMWORD PTR [rax + 96]
    movdqu xmm13, XMMWORD PTR [rax + 112]
    pxor xmm10, xmm7
    pxor xmm11, xmm4
    pxor xmm12, xmm5
    pxor xmm13, xmm6
    movdqu xmm6, XMMWORD PTR [rax]
    movdqu xmm7, XMMWORD PTR [rax + 16]
    movdqu xmm8, XMMWORD PTR [rax + 32]
    movdqu xmm9, XMMWORD PTR [rax + 48]
    pxor xmm6, xmm3
    pxor xmm7, xmm0
    pxor xmm8, xmm1
    pxor xmm9, xmm2
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    movdqu xmm3, XMMWORD PTR [r10 + 48]
    pxor xmm0, xmm6
    pxor xmm1, xmm7
    pxor xmm2, xmm8
    pxor xmm3, xmm9
    movdqu xmm4, XMMWORD PTR [roundConstantsP1]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 16]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 32]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 48]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 64]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 80]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 96]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 112]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 128]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 144]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 160]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 176]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 192]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 208]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 224]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    pxor xmm3, xmm10
    pxor xmm0, xmm11
    pxor xmm1, xmm12
    pxor xmm2, xmm13
    movdqu xmm4, XMMWORD PTR [roundConstantsP2]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 160]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 176]
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    aesenclast xmm2, xmm15
    aesenclast xmm0, xmm4
    aesenc xmm0, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 192]
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    aesenclast xmm3, xmm15
    aesenclast xmm1, xmm4
    aesenc xmm1, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 208]
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    aesenclast xmm0, xmm15
    aesenclast xmm2, xmm4
    aesenc xmm2, xmm15
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 224]
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    aesenclast xmm1, xmm15
    aesenclast xmm3, xmm4
    aesenc xmm3, xmm15
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    pxor xmm8, xmm12
    pxor xmm9, xmm13
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    movdqu XMMWORD PTR [rdx], xmm2
    movdqu XMMWORD PTR [rdx + 16], xmm3
    movdqu XMMWORD PTR [rdx + 32], xmm0
    movdqu XMMWORD PTR [rdx + 48], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    movdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm12, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm13, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm15, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    add rsp, 152
    ret
areion512TEM2EncryptAESNI ENDP

PUBLIC areion512TEM2EncryptVEX
ALIGN 16
areion512TEM2EncryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm8
    vmovdqu XMMWORD PTR [rsp + 48], xmm9
    vmovdqu XMMWORD PTR [rsp + 64], xmm10
    vmovdqu XMMWORD PTR [rsp + 80], xmm11
    vmovdqu XMMWORD PTR [rsp + 96], xmm12
    vmovdqu XMMWORD PTR [rsp + 112], xmm13
    vmovdqu XMMWORD PTR [rsp + 128], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rcx]
    vmovdqu xmm1, XMMWORD PTR [rcx + 16]
    vmovdqu xmm2, XMMWORD PTR [rcx + 32]
    vmovdqu xmm3, XMMWORD PTR [rcx + 48]
    vpxor xmm4, xmm0, XMMWORD PTR [rax + 64]
    vpxor xmm5, xmm1, XMMWORD PTR [rax + 80]
    vpxor xmm6, xmm2, XMMWORD PTR [rax + 96]
    vpxor xmm7, xmm3, XMMWORD PTR [rax + 112]
    vpxor xmm0, xmm0, XMMWORD PTR [rax]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 16]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 32]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 48]
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 160]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 160]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 176]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 176]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 192]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 192]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 208]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 208]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 224]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 224]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vpxor xmm10, xmm7, XMMWORD PTR [rax + 64]
    vpxor xmm11, xmm4, XMMWORD PTR [rax + 80]
    vpxor xmm12, xmm5, XMMWORD PTR [rax + 96]
    vpxor xmm13, xmm6, XMMWORD PTR [rax + 112]
    vpxor xmm6, xmm3, XMMWORD PTR [rax]
    vpxor xmm7, xmm0, XMMWORD PTR [rax + 16]
    vpxor xmm8, xmm1, XMMWORD PTR [rax + 32]
    vpxor xmm9, xmm2, XMMWORD PTR [rax + 48]
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm2, XMMWORD PTR [r10 + 32]
    vmovdqu xmm3, XMMWORD PTR [r10 + 48]
    vpxor xmm0, xmm0, xmm6
    vpxor xmm1, xmm1, xmm7
    vpxor xmm2, xmm2, xmm8
    vpxor xmm3, xmm3, xmm9
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 160]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 176]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 192]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 208]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 224]
    vaesenc xmm0, xmm0, xmm15
    vpxor xmm3, xmm3, xmm10
    vpxor xmm0, xmm0, xmm11
    vpxor xmm1, xmm1, xmm12
    vpxor xmm2, xmm2, xmm13
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 160]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 176]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 192]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 208]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 224]
    vaesenc xmm3, xmm3, xmm15
    vpxor xmm6, xmm6, xmm10
    vpxor xmm7, xmm7, xmm11
    vpxor xmm8, xmm8, xmm12
    vpxor xmm9, xmm9, xmm13
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vmovdqu XMMWORD PTR [rdx], xmm2
    vmovdqu XMMWORD PTR [rdx + 16], xmm3
    vmovdqu XMMWORD PTR [rdx + 32], xmm0
    vmovdqu XMMWORD PTR [rdx + 48], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    add rsp, 152
    ret
areion512TEM2EncryptVEX ENDP

PUBLIC areion512TEM2DecryptAESNI
ALIGN 16
areion512TEM2DecryptAESNI PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm10
    movdqu XMMWORD PTR [rsp + 80], xmm11
    movdqu XMMWORD PTR [rsp + 96], xmm12
    movdqu XMMWORD PTR [rsp + 112], xmm13
    movdqu XMMWORD PTR [rsp + 128], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    movdqu xmm0, XMMWORD PTR [rcx]
    movdqu xmm1, XMMWORD PTR [rcx + 16]
    movdqu xmm2, XMMWORD PTR [rcx + 32]
    movdqu xmm3, XMMWORD PTR [rcx + 48]
    movdqa xmm4, xmm0
    movdqa xmm5, xmm1
    movdqa xmm6, xmm2
    movdqa xmm7, xmm3
    movdqu xmm8, XMMWORD PTR [rax]
    movdqu xmm9, XMMWORD PTR [rax + 16]
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    pxor xmm2, xmm10
    pxor xmm3, xmm11
    movdqu xmm8, XMMWORD PTR [rax + 64]
    movdqu xmm9, XMMWORD PTR [rax + 80]
    movdqu xmm10, XMMWORD PTR [rax + 96]
    movdqu xmm11, XMMWORD PTR [rax + 112]
    pxor xmm4, xmm8
    pxor xmm5, xmm9
    pxor xmm6, xmm10
    pxor xmm7, xmm11
    pxor xmm15, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 16]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 16]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 32]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 32]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 48]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 48]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 64]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 64]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 80]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 80]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 96]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 96]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 112]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 112]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 128]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 128]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 144]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 144]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 160]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 160]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 176]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 176]
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    aesenclast xmm3, xmm15
    aesenclast xmm7, xmm15
    aesenclast xmm1, xmm12
    aesenclast xmm5, xmm13
    aesenc xmm1, xmm15
    aesenc xmm5, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 192]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 192]
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    aesenclast xmm0, xmm15
    aesenclast xmm4, xmm15
    aesenclast xmm2, xmm12
    aesenclast xmm6, xmm13
    aesenc xmm2, xmm15
    aesenc xmm6, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 208]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 208]
    movdqa xmm8, xmm1
    movdqa xmm9, xmm5
    aesenc xmm8, xmm2
    aesenc xmm9, xmm6
    movdqa xmm2, xmm8
    movdqa xmm6, xmm9
    movdqa xmm8, xmm3
    movdqa xmm9, xmm7
    aesenc xmm8, xmm0
    aesenc xmm9, xmm4
    movdqa xmm0, xmm8
    movdqa xmm4, xmm9
    aesenclast xmm1, xmm15
    aesenclast xmm5, xmm15
    aesenclast xmm3, xmm12
    aesenclast xmm7, xmm13
    aesenc xmm3, xmm15
    aesenc xmm7, xmm15
    movdqu xmm12, XMMWORD PTR [roundConstantsP1 + 224]
    movdqu xmm13, XMMWORD PTR [roundConstantsP2 + 224]
    movdqa xmm8, xmm2
    movdqa xmm9, xmm6
    aesenc xmm8, xmm3
    aesenc xmm9, xmm7
    movdqa xmm3, xmm8
    movdqa xmm7, xmm9
    movdqa xmm8, xmm0
    movdqa xmm9, xmm4
    aesenc xmm8, xmm1
    aesenc xmm9, xmm5
    movdqa xmm1, xmm8
    movdqa xmm5, xmm9
    aesenclast xmm2, xmm15
    aesenclast xmm6, xmm15
    aesenclast xmm0, xmm12
    aesenclast xmm4, xmm13
    aesenc xmm0, xmm15
    aesenc xmm4, xmm15
    movdqu xmm10, XMMWORD PTR [rax + 64]
    movdqu xmm11, XMMWORD PTR [rax + 80]
    movdqu xmm12, XMMWORD PTR [rax + 96]
    movdqu xmm13, XMMWORD PTR [rax + 112]
    pxor xmm10, xmm7
    pxor xmm11, xmm4
    pxor xmm12, xmm5
    pxor xmm13, xmm6
    movdqu xmm6, XMMWORD PTR [rax]
    movdqu xmm7, XMMWORD PTR [rax + 16]
    movdqu xmm8, XMMWORD PTR [rax + 32]
    movdqu xmm9, XMMWORD PTR [rax + 48]
    pxor xmm6, xmm3
    pxor xmm7, xmm0
    pxor xmm8, xmm1
    pxor xmm9, xmm2
    movdqu xmm0, XMMWORD PTR [r10]
    movdqu xmm1, XMMWORD PTR [r10 + 16]
    movdqu xmm2, XMMWORD PTR [r10 + 32]
    movdqu xmm3, XMMWORD PTR [r10 + 48]
    pxor xmm0, xmm6
    pxor xmm1, xmm7
    pxor xmm2, xmm8
    pxor xmm3, xmm9
    pxor xmm0, xmm10
    pxor xmm1, xmm11
    pxor xmm2, xmm12
    pxor xmm3, xmm13
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 224]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 208]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 192]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 176]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 160]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 144]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 128]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 112]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 96]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 80]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 64]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 48]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 32]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2 + 16]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP2]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    pxor xmm1, xmm10
    pxor xmm2, xmm11
    pxor xmm3, xmm12
    pxor xmm0, xmm13
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 224]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 208]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 192]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 176]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 160]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 144]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 128]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 112]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 96]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 80]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 64]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 48]
    aesdeclast xmm1, xmm15
    aesimc xmm3, xmm3
    aesdeclast xmm3, xmm4
    aesdeclast xmm3, xmm15
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 32]
    aesdeclast xmm0, xmm15
    aesimc xmm2, xmm2
    aesdeclast xmm2, xmm4
    aesdeclast xmm2, xmm15
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1 + 16]
    aesdeclast xmm3, xmm15
    aesimc xmm1, xmm1
    aesdeclast xmm1, xmm4
    aesdeclast xmm1, xmm15
    movdqa xmm5, xmm3
    aesenc xmm5, xmm0
    movdqa xmm0, xmm5
    movdqa xmm5, xmm1
    aesenc xmm5, xmm2
    movdqa xmm2, xmm5
    movdqu xmm4, XMMWORD PTR [roundConstantsP1]
    aesdeclast xmm2, xmm15
    aesimc xmm0, xmm0
    aesdeclast xmm0, xmm4
    aesdeclast xmm0, xmm15
    movdqa xmm5, xmm2
    aesenc xmm5, xmm3
    movdqa xmm3, xmm5
    movdqa xmm5, xmm0
    aesenc xmm5, xmm1
    movdqa xmm1, xmm5
    pxor xmm2, xmm6
    pxor xmm3, xmm7
    pxor xmm0, xmm8
    pxor xmm1, xmm9
    movdqu XMMWORD PTR [rdx], xmm2
    movdqu XMMWORD PTR [rdx + 16], xmm3
    movdqu XMMWORD PTR [rdx + 32], xmm0
    movdqu XMMWORD PTR [rdx + 48], xmm1
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
    pxor xmm10, xmm10
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13
    pxor xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    movdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    movdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    movdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    movdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    movdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    movdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    movdqu xmm12, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    movdqu xmm13, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    movdqu xmm15, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    add rsp, 152
    ret
areion512TEM2DecryptAESNI ENDP

PUBLIC areion512TEM2DecryptVEX
ALIGN 16
areion512TEM2DecryptVEX PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 152
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm8
    vmovdqu XMMWORD PTR [rsp + 48], xmm9
    vmovdqu XMMWORD PTR [rsp + 64], xmm10
    vmovdqu XMMWORD PTR [rsp + 80], xmm11
    vmovdqu XMMWORD PTR [rsp + 96], xmm12
    vmovdqu XMMWORD PTR [rsp + 112], xmm13
    vmovdqu XMMWORD PTR [rsp + 128], xmm15
    mov r10, rdx
    mov rdx, rcx
    mov rax, r8
    mov rcx, r9
    vmovdqu xmm0, XMMWORD PTR [rcx]
    vmovdqu xmm1, XMMWORD PTR [rcx + 16]
    vmovdqu xmm2, XMMWORD PTR [rcx + 32]
    vmovdqu xmm3, XMMWORD PTR [rcx + 48]
    vpxor xmm4, xmm0, XMMWORD PTR [rax + 64]
    vpxor xmm5, xmm1, XMMWORD PTR [rax + 80]
    vpxor xmm6, xmm2, XMMWORD PTR [rax + 96]
    vpxor xmm7, xmm3, XMMWORD PTR [rax + 112]
    vpxor xmm0, xmm0, XMMWORD PTR [rax]
    vpxor xmm1, xmm1, XMMWORD PTR [rax + 16]
    vpxor xmm2, xmm2, XMMWORD PTR [rax + 32]
    vpxor xmm3, xmm3, XMMWORD PTR [rax + 48]
    vpxor xmm15, xmm15, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 16]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 16]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 32]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 32]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 48]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 48]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 64]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 64]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 80]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 80]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 96]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 96]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 112]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 112]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 128]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 128]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 144]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 144]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 160]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 160]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenclast xmm3, xmm3, xmm15
    vaesenclast xmm7, xmm7, xmm15
    vaesenclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 176]
    vaesenclast xmm5, xmm5, XMMWORD PTR [roundConstantsP2 + 176]
    vaesenc xmm1, xmm1, xmm15
    vaesenc xmm5, xmm5, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenclast xmm0, xmm0, xmm15
    vaesenclast xmm4, xmm4, xmm15
    vaesenclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 192]
    vaesenclast xmm6, xmm6, XMMWORD PTR [roundConstantsP2 + 192]
    vaesenc xmm2, xmm2, xmm15
    vaesenc xmm6, xmm6, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm6, xmm5, xmm6
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm4, xmm7, xmm4
    vaesenclast xmm1, xmm1, xmm15
    vaesenclast xmm5, xmm5, xmm15
    vaesenclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 208]
    vaesenclast xmm7, xmm7, XMMWORD PTR [roundConstantsP2 + 208]
    vaesenc xmm3, xmm3, xmm15
    vaesenc xmm7, xmm7, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm7, xmm6, xmm7
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm5, xmm4, xmm5
    vaesenclast xmm2, xmm2, xmm15
    vaesenclast xmm6, xmm6, xmm15
    vaesenclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 224]
    vaesenclast xmm4, xmm4, XMMWORD PTR [roundConstantsP2 + 224]
    vaesenc xmm0, xmm0, xmm15
    vaesenc xmm4, xmm4, xmm15
    vpxor xmm10, xmm7, XMMWORD PTR [rax + 64]
    vpxor xmm11, xmm4, XMMWORD PTR [rax + 80]
    vpxor xmm12, xmm5, XMMWORD PTR [rax + 96]
    vpxor xmm13, xmm6, XMMWORD PTR [rax + 112]
    vpxor xmm6, xmm3, XMMWORD PTR [rax]
    vpxor xmm7, xmm0, XMMWORD PTR [rax + 16]
    vpxor xmm8, xmm1, XMMWORD PTR [rax + 32]
    vpxor xmm9, xmm2, XMMWORD PTR [rax + 48]
    vmovdqu xmm0, XMMWORD PTR [r10]
    vmovdqu xmm1, XMMWORD PTR [r10 + 16]
    vmovdqu xmm2, XMMWORD PTR [r10 + 32]
    vmovdqu xmm3, XMMWORD PTR [r10 + 48]
    vpxor xmm0, xmm0, xmm6
    vpxor xmm1, xmm1, xmm7
    vpxor xmm2, xmm2, xmm8
    vpxor xmm3, xmm3, xmm9
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm12
    vpxor xmm3, xmm3, xmm13
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 224]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 208]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 192]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 176]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 160]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 144]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 128]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 112]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 96]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 80]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2 + 64]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP2 + 48]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP2 + 32]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP2 + 16]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP2]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vpxor xmm1, xmm1, xmm10
    vpxor xmm2, xmm2, xmm11
    vpxor xmm3, xmm3, xmm12
    vpxor xmm0, xmm0, xmm13
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 224]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 208]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 192]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 176]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 160]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 144]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 128]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 112]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 96]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 80]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1 + 64]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vaesdeclast xmm1, xmm1, xmm15
    vaesimc xmm3, xmm3
    vaesdeclast xmm3, xmm3, XMMWORD PTR [roundConstantsP1 + 48]
    vaesdeclast xmm3, xmm3, xmm15
    vaesenc xmm2, xmm1, xmm2
    vaesenc xmm0, xmm3, xmm0
    vaesdeclast xmm0, xmm0, xmm15
    vaesimc xmm2, xmm2
    vaesdeclast xmm2, xmm2, XMMWORD PTR [roundConstantsP1 + 32]
    vaesdeclast xmm2, xmm2, xmm15
    vaesenc xmm1, xmm0, xmm1
    vaesenc xmm3, xmm2, xmm3
    vaesdeclast xmm3, xmm3, xmm15
    vaesimc xmm1, xmm1
    vaesdeclast xmm1, xmm1, XMMWORD PTR [roundConstantsP1 + 16]
    vaesdeclast xmm1, xmm1, xmm15
    vaesenc xmm0, xmm3, xmm0
    vaesenc xmm2, xmm1, xmm2
    vaesdeclast xmm2, xmm2, xmm15
    vaesimc xmm0, xmm0
    vaesdeclast xmm0, xmm0, XMMWORD PTR [roundConstantsP1]
    vaesdeclast xmm0, xmm0, xmm15
    vaesenc xmm3, xmm2, xmm3
    vaesenc xmm1, xmm0, xmm1
    vpxor xmm2, xmm2, xmm6
    vpxor xmm3, xmm3, xmm7
    vpxor xmm0, xmm0, xmm8
    vpxor xmm1, xmm1, xmm9
    vmovdqu XMMWORD PTR [rdx], xmm2
    vmovdqu XMMWORD PTR [rdx + 16], xmm3
    vmovdqu XMMWORD PTR [rdx + 32], xmm0
    vmovdqu XMMWORD PTR [rdx + 48], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    vpxor xmm6, xmm6, xmm6
    vpxor xmm7, xmm7, xmm7
    vpxor xmm8, xmm8, xmm8
    vpxor xmm9, xmm9, xmm9
    vpxor xmm10, xmm10, xmm10
    vpxor xmm11, xmm11, xmm11
    vpxor xmm12, xmm12, xmm12
    vpxor xmm13, xmm13, xmm13
    vpxor xmm15, xmm15, xmm15
    xor rax, rax
    xor r10, r10
    xor rcx, rcx
    xor rdx, rdx
    vmovdqu xmm6, XMMWORD PTR [rsp + 0]
    mov QWORD PTR [rsp + 0], 0
    mov QWORD PTR [rsp + 8], 0
    vmovdqu xmm7, XMMWORD PTR [rsp + 16]
    mov QWORD PTR [rsp + 16], 0
    mov QWORD PTR [rsp + 24], 0
    vmovdqu xmm8, XMMWORD PTR [rsp + 32]
    mov QWORD PTR [rsp + 32], 0
    mov QWORD PTR [rsp + 40], 0
    vmovdqu xmm9, XMMWORD PTR [rsp + 48]
    mov QWORD PTR [rsp + 48], 0
    mov QWORD PTR [rsp + 56], 0
    vmovdqu xmm10, XMMWORD PTR [rsp + 64]
    mov QWORD PTR [rsp + 64], 0
    mov QWORD PTR [rsp + 72], 0
    vmovdqu xmm11, XMMWORD PTR [rsp + 80]
    mov QWORD PTR [rsp + 80], 0
    mov QWORD PTR [rsp + 88], 0
    vmovdqu xmm12, XMMWORD PTR [rsp + 96]
    mov QWORD PTR [rsp + 96], 0
    mov QWORD PTR [rsp + 104], 0
    vmovdqu xmm13, XMMWORD PTR [rsp + 112]
    mov QWORD PTR [rsp + 112], 0
    mov QWORD PTR [rsp + 120], 0
    vmovdqu xmm15, XMMWORD PTR [rsp + 128]
    mov QWORD PTR [rsp + 128], 0
    mov QWORD PTR [rsp + 136], 0
    add rsp, 152
    ret
areion512TEM2DecryptVEX ENDP

END
