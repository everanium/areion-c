; Copyright (c) 2026 Andrey Kuvshinov
; SPDX-License-Identifier: Apache-2.0 OR MIT

EXTERN rijndael256Consts:BYTE

.code

PUBLIC rijndael256EncryptBlockAsm
ALIGN 16
rijndael256EncryptBlockAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov rcx, r8
    movdqu xmm0, XMMWORD PTR [rijndael256Consts]
    movdqu xmm4, XMMWORD PTR [rijndael256Consts + 16]
    movdqu xmm1, XMMWORD PTR [rcx]
    movdqu xmm2, XMMWORD PTR [rcx + 16]
    movdqu xmm5, XMMWORD PTR [rax]
    pxor xmm1, xmm5
    movdqu xmm5, XMMWORD PTR [rax + 16]
    pxor xmm2, xmm5
    movdqu xmm3, xmm1
    pblendvb xmm3, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    pshufb xmm3, xmm4
    pshufb xmm2, xmm4
    movdqu xmm5, XMMWORD PTR [rax + 32]
    aesenc xmm3, xmm5
    movdqu xmm5, XMMWORD PTR [rax + 48]
    aesenc xmm2, xmm5
    movdqu xmm1, xmm3
    pblendvb xmm1, xmm2, xmm0
    pblendvb xmm2, xmm3, xmm0
    pshufb xmm1, xmm4
    pshufb xmm2, xmm4
    movdqu xmm5, XMMWORD PTR [rax + 64]
    aesenc xmm1, xmm5
    movdqu xmm5, XMMWORD PTR [rax + 80]
    aesenc xmm2, xmm5
    movdqu xmm3, xmm1
    pblendvb xmm3, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    pshufb xmm3, xmm4
    pshufb xmm2, xmm4
    movdqu xmm5, XMMWORD PTR [rax + 96]
    aesenc xmm3, xmm5
    movdqu xmm5, XMMWORD PTR [rax + 112]
    aesenc xmm2, xmm5
    movdqu xmm1, xmm3
    pblendvb xmm1, xmm2, xmm0
    pblendvb xmm2, xmm3, xmm0
    pshufb xmm1, xmm4
    pshufb xmm2, xmm4
    movdqu xmm5, XMMWORD PTR [rax + 128]
    aesenc xmm1, xmm5
    movdqu xmm5, XMMWORD PTR [rax + 144]
    aesenc xmm2, xmm5
    movdqu xmm3, xmm1
    pblendvb xmm3, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    pshufb xmm3, xmm4
    pshufb xmm2, xmm4
    movdqu xmm5, XMMWORD PTR [rax + 160]
    aesenc xmm3, xmm5
    movdqu xmm5, XMMWORD PTR [rax + 176]
    aesenc xmm2, xmm5
    movdqu xmm1, xmm3
    pblendvb xmm1, xmm2, xmm0
    pblendvb xmm2, xmm3, xmm0
    pshufb xmm1, xmm4
    pshufb xmm2, xmm4
    movdqu xmm5, XMMWORD PTR [rax + 192]
    aesenc xmm1, xmm5
    movdqu xmm5, XMMWORD PTR [rax + 208]
    aesenc xmm2, xmm5
    movdqu xmm3, xmm1
    pblendvb xmm3, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    pshufb xmm3, xmm4
    pshufb xmm2, xmm4
    movdqu xmm5, XMMWORD PTR [rax + 224]
    aesenc xmm3, xmm5
    movdqu xmm5, XMMWORD PTR [rax + 240]
    aesenc xmm2, xmm5
    movdqu xmm1, xmm3
    pblendvb xmm1, xmm2, xmm0
    pblendvb xmm2, xmm3, xmm0
    pshufb xmm1, xmm4
    pshufb xmm2, xmm4
    movdqu xmm5, XMMWORD PTR [rax + 256]
    aesenc xmm1, xmm5
    movdqu xmm5, XMMWORD PTR [rax + 272]
    aesenc xmm2, xmm5
    movdqu xmm3, xmm1
    pblendvb xmm3, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    pshufb xmm3, xmm4
    pshufb xmm2, xmm4
    movdqu xmm5, XMMWORD PTR [rax + 288]
    aesenc xmm3, xmm5
    movdqu xmm5, XMMWORD PTR [rax + 304]
    aesenc xmm2, xmm5
    movdqu xmm1, xmm3
    pblendvb xmm1, xmm2, xmm0
    pblendvb xmm2, xmm3, xmm0
    pshufb xmm1, xmm4
    pshufb xmm2, xmm4
    movdqu xmm5, XMMWORD PTR [rax + 320]
    aesenc xmm1, xmm5
    movdqu xmm5, XMMWORD PTR [rax + 336]
    aesenc xmm2, xmm5
    movdqu xmm3, xmm1
    pblendvb xmm3, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    pshufb xmm3, xmm4
    pshufb xmm2, xmm4
    movdqu xmm5, XMMWORD PTR [rax + 352]
    aesenc xmm3, xmm5
    movdqu xmm5, XMMWORD PTR [rax + 368]
    aesenc xmm2, xmm5
    movdqu xmm1, xmm3
    pblendvb xmm1, xmm2, xmm0
    pblendvb xmm2, xmm3, xmm0
    pshufb xmm1, xmm4
    pshufb xmm2, xmm4
    movdqu xmm5, XMMWORD PTR [rax + 384]
    aesenc xmm1, xmm5
    movdqu xmm5, XMMWORD PTR [rax + 400]
    aesenc xmm2, xmm5
    movdqu xmm3, xmm1
    pblendvb xmm3, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    pshufb xmm3, xmm4
    pshufb xmm2, xmm4
    movdqu xmm5, XMMWORD PTR [rax + 416]
    aesenc xmm3, xmm5
    movdqu xmm5, XMMWORD PTR [rax + 432]
    aesenc xmm2, xmm5
    movdqu xmm1, xmm3
    pblendvb xmm1, xmm2, xmm0
    pblendvb xmm2, xmm3, xmm0
    pshufb xmm1, xmm4
    pshufb xmm2, xmm4
    movdqu xmm5, XMMWORD PTR [rax + 448]
    aesenclast xmm1, xmm5
    movdqu xmm5, XMMWORD PTR [rax + 464]
    aesenclast xmm2, xmm5
    movdqu XMMWORD PTR [rdx], xmm1
    movdqu XMMWORD PTR [rdx + 16], xmm2
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx
    ret
rijndael256EncryptBlockAsm ENDP

PUBLIC rijndael256EncryptBlockVexAsm
ALIGN 16
rijndael256EncryptBlockVexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov rcx, r8
    vmovdqu xmm0, XMMWORD PTR [rcx]
    vmovdqu xmm1, XMMWORD PTR [rcx + 16]
    vmovdqu xmm3, XMMWORD PTR [rijndael256Consts]
    vmovdqu xmm4, XMMWORD PTR [rijndael256Consts + 16]
    vmovdqu xmm5, XMMWORD PTR [rax]
    vpxor xmm0, xmm0, xmm5
    vmovdqu xmm5, XMMWORD PTR [rax + 16]
    vpxor xmm1, xmm1, xmm5
    vpblendvb xmm2, xmm0, xmm1, xmm3
    vpblendvb xmm1, xmm1, xmm0, xmm3
    vpshufb xmm0, xmm2, xmm4
    vpshufb xmm1, xmm1, xmm4
    vmovdqu xmm5, XMMWORD PTR [rax + 32]
    vaesenc xmm0, xmm0, xmm5
    vmovdqu xmm5, XMMWORD PTR [rax + 48]
    vaesenc xmm1, xmm1, xmm5
    vpblendvb xmm2, xmm0, xmm1, xmm3
    vpblendvb xmm1, xmm1, xmm0, xmm3
    vpshufb xmm0, xmm2, xmm4
    vpshufb xmm1, xmm1, xmm4
    vmovdqu xmm5, XMMWORD PTR [rax + 64]
    vaesenc xmm0, xmm0, xmm5
    vmovdqu xmm5, XMMWORD PTR [rax + 80]
    vaesenc xmm1, xmm1, xmm5
    vpblendvb xmm2, xmm0, xmm1, xmm3
    vpblendvb xmm1, xmm1, xmm0, xmm3
    vpshufb xmm0, xmm2, xmm4
    vpshufb xmm1, xmm1, xmm4
    vmovdqu xmm5, XMMWORD PTR [rax + 96]
    vaesenc xmm0, xmm0, xmm5
    vmovdqu xmm5, XMMWORD PTR [rax + 112]
    vaesenc xmm1, xmm1, xmm5
    vpblendvb xmm2, xmm0, xmm1, xmm3
    vpblendvb xmm1, xmm1, xmm0, xmm3
    vpshufb xmm0, xmm2, xmm4
    vpshufb xmm1, xmm1, xmm4
    vmovdqu xmm5, XMMWORD PTR [rax + 128]
    vaesenc xmm0, xmm0, xmm5
    vmovdqu xmm5, XMMWORD PTR [rax + 144]
    vaesenc xmm1, xmm1, xmm5
    vpblendvb xmm2, xmm0, xmm1, xmm3
    vpblendvb xmm1, xmm1, xmm0, xmm3
    vpshufb xmm0, xmm2, xmm4
    vpshufb xmm1, xmm1, xmm4
    vmovdqu xmm5, XMMWORD PTR [rax + 160]
    vaesenc xmm0, xmm0, xmm5
    vmovdqu xmm5, XMMWORD PTR [rax + 176]
    vaesenc xmm1, xmm1, xmm5
    vpblendvb xmm2, xmm0, xmm1, xmm3
    vpblendvb xmm1, xmm1, xmm0, xmm3
    vpshufb xmm0, xmm2, xmm4
    vpshufb xmm1, xmm1, xmm4
    vmovdqu xmm5, XMMWORD PTR [rax + 192]
    vaesenc xmm0, xmm0, xmm5
    vmovdqu xmm5, XMMWORD PTR [rax + 208]
    vaesenc xmm1, xmm1, xmm5
    vpblendvb xmm2, xmm0, xmm1, xmm3
    vpblendvb xmm1, xmm1, xmm0, xmm3
    vpshufb xmm0, xmm2, xmm4
    vpshufb xmm1, xmm1, xmm4
    vmovdqu xmm5, XMMWORD PTR [rax + 224]
    vaesenc xmm0, xmm0, xmm5
    vmovdqu xmm5, XMMWORD PTR [rax + 240]
    vaesenc xmm1, xmm1, xmm5
    vpblendvb xmm2, xmm0, xmm1, xmm3
    vpblendvb xmm1, xmm1, xmm0, xmm3
    vpshufb xmm0, xmm2, xmm4
    vpshufb xmm1, xmm1, xmm4
    vmovdqu xmm5, XMMWORD PTR [rax + 256]
    vaesenc xmm0, xmm0, xmm5
    vmovdqu xmm5, XMMWORD PTR [rax + 272]
    vaesenc xmm1, xmm1, xmm5
    vpblendvb xmm2, xmm0, xmm1, xmm3
    vpblendvb xmm1, xmm1, xmm0, xmm3
    vpshufb xmm0, xmm2, xmm4
    vpshufb xmm1, xmm1, xmm4
    vmovdqu xmm5, XMMWORD PTR [rax + 288]
    vaesenc xmm0, xmm0, xmm5
    vmovdqu xmm5, XMMWORD PTR [rax + 304]
    vaesenc xmm1, xmm1, xmm5
    vpblendvb xmm2, xmm0, xmm1, xmm3
    vpblendvb xmm1, xmm1, xmm0, xmm3
    vpshufb xmm0, xmm2, xmm4
    vpshufb xmm1, xmm1, xmm4
    vmovdqu xmm5, XMMWORD PTR [rax + 320]
    vaesenc xmm0, xmm0, xmm5
    vmovdqu xmm5, XMMWORD PTR [rax + 336]
    vaesenc xmm1, xmm1, xmm5
    vpblendvb xmm2, xmm0, xmm1, xmm3
    vpblendvb xmm1, xmm1, xmm0, xmm3
    vpshufb xmm0, xmm2, xmm4
    vpshufb xmm1, xmm1, xmm4
    vmovdqu xmm5, XMMWORD PTR [rax + 352]
    vaesenc xmm0, xmm0, xmm5
    vmovdqu xmm5, XMMWORD PTR [rax + 368]
    vaesenc xmm1, xmm1, xmm5
    vpblendvb xmm2, xmm0, xmm1, xmm3
    vpblendvb xmm1, xmm1, xmm0, xmm3
    vpshufb xmm0, xmm2, xmm4
    vpshufb xmm1, xmm1, xmm4
    vmovdqu xmm5, XMMWORD PTR [rax + 384]
    vaesenc xmm0, xmm0, xmm5
    vmovdqu xmm5, XMMWORD PTR [rax + 400]
    vaesenc xmm1, xmm1, xmm5
    vpblendvb xmm2, xmm0, xmm1, xmm3
    vpblendvb xmm1, xmm1, xmm0, xmm3
    vpshufb xmm0, xmm2, xmm4
    vpshufb xmm1, xmm1, xmm4
    vmovdqu xmm5, XMMWORD PTR [rax + 416]
    vaesenc xmm0, xmm0, xmm5
    vmovdqu xmm5, XMMWORD PTR [rax + 432]
    vaesenc xmm1, xmm1, xmm5
    vpblendvb xmm2, xmm0, xmm1, xmm3
    vpblendvb xmm1, xmm1, xmm0, xmm3
    vpshufb xmm0, xmm2, xmm4
    vpshufb xmm1, xmm1, xmm4
    vmovdqu xmm5, XMMWORD PTR [rax + 448]
    vaesenclast xmm0, xmm0, xmm5
    vmovdqu xmm5, XMMWORD PTR [rax + 464]
    vaesenclast xmm1, xmm1, xmm5
    vmovdqu XMMWORD PTR [rdx], xmm0
    vmovdqu XMMWORD PTR [rdx + 16], xmm1
    vpxor xmm0, xmm0, xmm0
    vpxor xmm1, xmm1, xmm1
    vpxor xmm2, xmm2, xmm2
    vpxor xmm3, xmm3, xmm3
    vpxor xmm4, xmm4, xmm4
    vpxor xmm5, xmm5, xmm5
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx
    ret
rijndael256EncryptBlockVexAsm ENDP

PUBLIC rijndael256Encrypt4BlocksZmmAsm
ALIGN 16
rijndael256Encrypt4BlocksZmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    mov rax, rcx
    mov rcx, r8
    vmovdqu xmm0, XMMWORD PTR [rcx]
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rcx + 32], 1
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rcx + 64], 2
    vinserti32x4 zmm0, zmm0, XMMWORD PTR [rcx + 96], 3
    vmovdqu xmm1, XMMWORD PTR [rcx + 16]
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rcx + 48], 1
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rcx + 80], 2
    vinserti32x4 zmm1, zmm1, XMMWORD PTR [rcx + 112], 3
    vbroadcasti32x4 zmm4, XMMWORD PTR [rijndael256Consts]
    vbroadcasti32x4 zmm5, XMMWORD PTR [rijndael256Consts + 16]
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax]
    vpxorq zmm0, zmm0, zmm3
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 16]
    vpxorq zmm1, zmm1, zmm3
    vmovdqu64 zmm2, zmm0
    vpternlogq zmm2, zmm4, zmm1, 184
    vpternlogq zmm1, zmm4, zmm0, 184
    vpshufb zmm0, zmm2, zmm5
    vpshufb zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 32]
    vaesenc zmm0, zmm0, zmm3
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 48]
    vaesenc zmm1, zmm1, zmm3
    vmovdqu64 zmm2, zmm0
    vpternlogq zmm2, zmm4, zmm1, 184
    vpternlogq zmm1, zmm4, zmm0, 184
    vpshufb zmm0, zmm2, zmm5
    vpshufb zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 64]
    vaesenc zmm0, zmm0, zmm3
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 80]
    vaesenc zmm1, zmm1, zmm3
    vmovdqu64 zmm2, zmm0
    vpternlogq zmm2, zmm4, zmm1, 184
    vpternlogq zmm1, zmm4, zmm0, 184
    vpshufb zmm0, zmm2, zmm5
    vpshufb zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 96]
    vaesenc zmm0, zmm0, zmm3
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 112]
    vaesenc zmm1, zmm1, zmm3
    vmovdqu64 zmm2, zmm0
    vpternlogq zmm2, zmm4, zmm1, 184
    vpternlogq zmm1, zmm4, zmm0, 184
    vpshufb zmm0, zmm2, zmm5
    vpshufb zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 128]
    vaesenc zmm0, zmm0, zmm3
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 144]
    vaesenc zmm1, zmm1, zmm3
    vmovdqu64 zmm2, zmm0
    vpternlogq zmm2, zmm4, zmm1, 184
    vpternlogq zmm1, zmm4, zmm0, 184
    vpshufb zmm0, zmm2, zmm5
    vpshufb zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 160]
    vaesenc zmm0, zmm0, zmm3
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 176]
    vaesenc zmm1, zmm1, zmm3
    vmovdqu64 zmm2, zmm0
    vpternlogq zmm2, zmm4, zmm1, 184
    vpternlogq zmm1, zmm4, zmm0, 184
    vpshufb zmm0, zmm2, zmm5
    vpshufb zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 192]
    vaesenc zmm0, zmm0, zmm3
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 208]
    vaesenc zmm1, zmm1, zmm3
    vmovdqu64 zmm2, zmm0
    vpternlogq zmm2, zmm4, zmm1, 184
    vpternlogq zmm1, zmm4, zmm0, 184
    vpshufb zmm0, zmm2, zmm5
    vpshufb zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 224]
    vaesenc zmm0, zmm0, zmm3
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 240]
    vaesenc zmm1, zmm1, zmm3
    vmovdqu64 zmm2, zmm0
    vpternlogq zmm2, zmm4, zmm1, 184
    vpternlogq zmm1, zmm4, zmm0, 184
    vpshufb zmm0, zmm2, zmm5
    vpshufb zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 256]
    vaesenc zmm0, zmm0, zmm3
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 272]
    vaesenc zmm1, zmm1, zmm3
    vmovdqu64 zmm2, zmm0
    vpternlogq zmm2, zmm4, zmm1, 184
    vpternlogq zmm1, zmm4, zmm0, 184
    vpshufb zmm0, zmm2, zmm5
    vpshufb zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 288]
    vaesenc zmm0, zmm0, zmm3
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 304]
    vaesenc zmm1, zmm1, zmm3
    vmovdqu64 zmm2, zmm0
    vpternlogq zmm2, zmm4, zmm1, 184
    vpternlogq zmm1, zmm4, zmm0, 184
    vpshufb zmm0, zmm2, zmm5
    vpshufb zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 320]
    vaesenc zmm0, zmm0, zmm3
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 336]
    vaesenc zmm1, zmm1, zmm3
    vmovdqu64 zmm2, zmm0
    vpternlogq zmm2, zmm4, zmm1, 184
    vpternlogq zmm1, zmm4, zmm0, 184
    vpshufb zmm0, zmm2, zmm5
    vpshufb zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 352]
    vaesenc zmm0, zmm0, zmm3
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 368]
    vaesenc zmm1, zmm1, zmm3
    vmovdqu64 zmm2, zmm0
    vpternlogq zmm2, zmm4, zmm1, 184
    vpternlogq zmm1, zmm4, zmm0, 184
    vpshufb zmm0, zmm2, zmm5
    vpshufb zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 384]
    vaesenc zmm0, zmm0, zmm3
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 400]
    vaesenc zmm1, zmm1, zmm3
    vmovdqu64 zmm2, zmm0
    vpternlogq zmm2, zmm4, zmm1, 184
    vpternlogq zmm1, zmm4, zmm0, 184
    vpshufb zmm0, zmm2, zmm5
    vpshufb zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 416]
    vaesenc zmm0, zmm0, zmm3
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 432]
    vaesenc zmm1, zmm1, zmm3
    vmovdqu64 zmm2, zmm0
    vpternlogq zmm2, zmm4, zmm1, 184
    vpternlogq zmm1, zmm4, zmm0, 184
    vpshufb zmm0, zmm2, zmm5
    vpshufb zmm1, zmm1, zmm5
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 448]
    vaesenclast zmm0, zmm0, zmm3
    vbroadcasti32x4 zmm3, XMMWORD PTR [rax + 464]
    vaesenclast zmm1, zmm1, zmm3
    vmovdqu XMMWORD PTR [rdx], xmm0
    vextracti32x4 XMMWORD PTR [rdx + 32], zmm0, 1
    vextracti32x4 XMMWORD PTR [rdx + 64], zmm0, 2
    vextracti32x4 XMMWORD PTR [rdx + 96], zmm0, 3
    vmovdqu XMMWORD PTR [rdx + 16], xmm1
    vextracti32x4 XMMWORD PTR [rdx + 48], zmm1, 1
    vextracti32x4 XMMWORD PTR [rdx + 80], zmm1, 2
    vextracti32x4 XMMWORD PTR [rdx + 112], zmm1, 3
    vpxord xmm0, xmm0, xmm0
    vpxord xmm1, xmm1, xmm1
    vpxord xmm2, xmm2, xmm2
    vpxord xmm3, xmm3, xmm3
    vpxord xmm4, xmm4, xmm4
    vpxord xmm5, xmm5, xmm5
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx
    vzeroupper
    ret
rijndael256Encrypt4BlocksZmmAsm ENDP

PUBLIC rijndael256Encrypt4BlocksYmmAsm
ALIGN 16
rijndael256Encrypt4BlocksYmmAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 72
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm8
    vmovdqu XMMWORD PTR [rsp + 48], xmm9
    mov rax, rcx
    mov rcx, r8
    vmovdqu xmm0, XMMWORD PTR [rcx]
    vinserti128 ymm0, ymm0, XMMWORD PTR [rcx + 32], 1
    vmovdqu xmm1, XMMWORD PTR [rcx + 16]
    vinserti128 ymm1, ymm1, XMMWORD PTR [rcx + 48], 1
    vmovdqu xmm2, XMMWORD PTR [rcx + 64]
    vinserti128 ymm2, ymm2, XMMWORD PTR [rcx + 96], 1
    vmovdqu xmm3, XMMWORD PTR [rcx + 80]
    vinserti128 ymm3, ymm3, XMMWORD PTR [rcx + 112], 1
    vbroadcasti128 ymm8, XMMWORD PTR [rijndael256Consts]
    vbroadcasti128 ymm9, XMMWORD PTR [rijndael256Consts + 16]
    vbroadcasti128 ymm4, XMMWORD PTR [rax]
    vbroadcasti128 ymm5, XMMWORD PTR [rax + 16]
    vpxor ymm0, ymm0, ymm4
    vpxor ymm1, ymm1, ymm5
    vpxor ymm2, ymm2, ymm4
    vpxor ymm3, ymm3, ymm5
    vbroadcasti128 ymm4, XMMWORD PTR [rax + 32]
    vbroadcasti128 ymm5, XMMWORD PTR [rax + 48]
    vpblendvb ymm6, ymm0, ymm1, ymm8
    vpblendvb ymm1, ymm1, ymm0, ymm8
    vpblendvb ymm7, ymm2, ymm3, ymm8
    vpblendvb ymm3, ymm3, ymm2, ymm8
    vpshufb ymm0, ymm6, ymm9
    vpshufb ymm1, ymm1, ymm9
    vpshufb ymm2, ymm7, ymm9
    vpshufb ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm5
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm5
    vbroadcasti128 ymm4, XMMWORD PTR [rax + 64]
    vbroadcasti128 ymm5, XMMWORD PTR [rax + 80]
    vpblendvb ymm6, ymm0, ymm1, ymm8
    vpblendvb ymm1, ymm1, ymm0, ymm8
    vpblendvb ymm7, ymm2, ymm3, ymm8
    vpblendvb ymm3, ymm3, ymm2, ymm8
    vpshufb ymm0, ymm6, ymm9
    vpshufb ymm1, ymm1, ymm9
    vpshufb ymm2, ymm7, ymm9
    vpshufb ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm5
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm5
    vbroadcasti128 ymm4, XMMWORD PTR [rax + 96]
    vbroadcasti128 ymm5, XMMWORD PTR [rax + 112]
    vpblendvb ymm6, ymm0, ymm1, ymm8
    vpblendvb ymm1, ymm1, ymm0, ymm8
    vpblendvb ymm7, ymm2, ymm3, ymm8
    vpblendvb ymm3, ymm3, ymm2, ymm8
    vpshufb ymm0, ymm6, ymm9
    vpshufb ymm1, ymm1, ymm9
    vpshufb ymm2, ymm7, ymm9
    vpshufb ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm5
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm5
    vbroadcasti128 ymm4, XMMWORD PTR [rax + 128]
    vbroadcasti128 ymm5, XMMWORD PTR [rax + 144]
    vpblendvb ymm6, ymm0, ymm1, ymm8
    vpblendvb ymm1, ymm1, ymm0, ymm8
    vpblendvb ymm7, ymm2, ymm3, ymm8
    vpblendvb ymm3, ymm3, ymm2, ymm8
    vpshufb ymm0, ymm6, ymm9
    vpshufb ymm1, ymm1, ymm9
    vpshufb ymm2, ymm7, ymm9
    vpshufb ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm5
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm5
    vbroadcasti128 ymm4, XMMWORD PTR [rax + 160]
    vbroadcasti128 ymm5, XMMWORD PTR [rax + 176]
    vpblendvb ymm6, ymm0, ymm1, ymm8
    vpblendvb ymm1, ymm1, ymm0, ymm8
    vpblendvb ymm7, ymm2, ymm3, ymm8
    vpblendvb ymm3, ymm3, ymm2, ymm8
    vpshufb ymm0, ymm6, ymm9
    vpshufb ymm1, ymm1, ymm9
    vpshufb ymm2, ymm7, ymm9
    vpshufb ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm5
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm5
    vbroadcasti128 ymm4, XMMWORD PTR [rax + 192]
    vbroadcasti128 ymm5, XMMWORD PTR [rax + 208]
    vpblendvb ymm6, ymm0, ymm1, ymm8
    vpblendvb ymm1, ymm1, ymm0, ymm8
    vpblendvb ymm7, ymm2, ymm3, ymm8
    vpblendvb ymm3, ymm3, ymm2, ymm8
    vpshufb ymm0, ymm6, ymm9
    vpshufb ymm1, ymm1, ymm9
    vpshufb ymm2, ymm7, ymm9
    vpshufb ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm5
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm5
    vbroadcasti128 ymm4, XMMWORD PTR [rax + 224]
    vbroadcasti128 ymm5, XMMWORD PTR [rax + 240]
    vpblendvb ymm6, ymm0, ymm1, ymm8
    vpblendvb ymm1, ymm1, ymm0, ymm8
    vpblendvb ymm7, ymm2, ymm3, ymm8
    vpblendvb ymm3, ymm3, ymm2, ymm8
    vpshufb ymm0, ymm6, ymm9
    vpshufb ymm1, ymm1, ymm9
    vpshufb ymm2, ymm7, ymm9
    vpshufb ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm5
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm5
    vbroadcasti128 ymm4, XMMWORD PTR [rax + 256]
    vbroadcasti128 ymm5, XMMWORD PTR [rax + 272]
    vpblendvb ymm6, ymm0, ymm1, ymm8
    vpblendvb ymm1, ymm1, ymm0, ymm8
    vpblendvb ymm7, ymm2, ymm3, ymm8
    vpblendvb ymm3, ymm3, ymm2, ymm8
    vpshufb ymm0, ymm6, ymm9
    vpshufb ymm1, ymm1, ymm9
    vpshufb ymm2, ymm7, ymm9
    vpshufb ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm5
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm5
    vbroadcasti128 ymm4, XMMWORD PTR [rax + 288]
    vbroadcasti128 ymm5, XMMWORD PTR [rax + 304]
    vpblendvb ymm6, ymm0, ymm1, ymm8
    vpblendvb ymm1, ymm1, ymm0, ymm8
    vpblendvb ymm7, ymm2, ymm3, ymm8
    vpblendvb ymm3, ymm3, ymm2, ymm8
    vpshufb ymm0, ymm6, ymm9
    vpshufb ymm1, ymm1, ymm9
    vpshufb ymm2, ymm7, ymm9
    vpshufb ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm5
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm5
    vbroadcasti128 ymm4, XMMWORD PTR [rax + 320]
    vbroadcasti128 ymm5, XMMWORD PTR [rax + 336]
    vpblendvb ymm6, ymm0, ymm1, ymm8
    vpblendvb ymm1, ymm1, ymm0, ymm8
    vpblendvb ymm7, ymm2, ymm3, ymm8
    vpblendvb ymm3, ymm3, ymm2, ymm8
    vpshufb ymm0, ymm6, ymm9
    vpshufb ymm1, ymm1, ymm9
    vpshufb ymm2, ymm7, ymm9
    vpshufb ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm5
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm5
    vbroadcasti128 ymm4, XMMWORD PTR [rax + 352]
    vbroadcasti128 ymm5, XMMWORD PTR [rax + 368]
    vpblendvb ymm6, ymm0, ymm1, ymm8
    vpblendvb ymm1, ymm1, ymm0, ymm8
    vpblendvb ymm7, ymm2, ymm3, ymm8
    vpblendvb ymm3, ymm3, ymm2, ymm8
    vpshufb ymm0, ymm6, ymm9
    vpshufb ymm1, ymm1, ymm9
    vpshufb ymm2, ymm7, ymm9
    vpshufb ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm5
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm5
    vbroadcasti128 ymm4, XMMWORD PTR [rax + 384]
    vbroadcasti128 ymm5, XMMWORD PTR [rax + 400]
    vpblendvb ymm6, ymm0, ymm1, ymm8
    vpblendvb ymm1, ymm1, ymm0, ymm8
    vpblendvb ymm7, ymm2, ymm3, ymm8
    vpblendvb ymm3, ymm3, ymm2, ymm8
    vpshufb ymm0, ymm6, ymm9
    vpshufb ymm1, ymm1, ymm9
    vpshufb ymm2, ymm7, ymm9
    vpshufb ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm5
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm5
    vbroadcasti128 ymm4, XMMWORD PTR [rax + 416]
    vbroadcasti128 ymm5, XMMWORD PTR [rax + 432]
    vpblendvb ymm6, ymm0, ymm1, ymm8
    vpblendvb ymm1, ymm1, ymm0, ymm8
    vpblendvb ymm7, ymm2, ymm3, ymm8
    vpblendvb ymm3, ymm3, ymm2, ymm8
    vpshufb ymm0, ymm6, ymm9
    vpshufb ymm1, ymm1, ymm9
    vpshufb ymm2, ymm7, ymm9
    vpshufb ymm3, ymm3, ymm9
    vaesenc ymm0, ymm0, ymm4
    vaesenc ymm1, ymm1, ymm5
    vaesenc ymm2, ymm2, ymm4
    vaesenc ymm3, ymm3, ymm5
    vbroadcasti128 ymm4, XMMWORD PTR [rax + 448]
    vbroadcasti128 ymm5, XMMWORD PTR [rax + 464]
    vpblendvb ymm6, ymm0, ymm1, ymm8
    vpblendvb ymm1, ymm1, ymm0, ymm8
    vpblendvb ymm7, ymm2, ymm3, ymm8
    vpblendvb ymm3, ymm3, ymm2, ymm8
    vpshufb ymm0, ymm6, ymm9
    vpshufb ymm1, ymm1, ymm9
    vpshufb ymm2, ymm7, ymm9
    vpshufb ymm3, ymm3, ymm9
    vaesenclast ymm0, ymm0, ymm4
    vaesenclast ymm1, ymm1, ymm5
    vaesenclast ymm2, ymm2, ymm4
    vaesenclast ymm3, ymm3, ymm5
    vmovdqu XMMWORD PTR [rdx], xmm0
    vextracti128 XMMWORD PTR [rdx + 32], ymm0, 1
    vmovdqu XMMWORD PTR [rdx + 16], xmm1
    vextracti128 XMMWORD PTR [rdx + 48], ymm1, 1
    vmovdqu XMMWORD PTR [rdx + 64], xmm2
    vextracti128 XMMWORD PTR [rdx + 96], ymm2, 1
    vmovdqu XMMWORD PTR [rdx + 80], xmm3
    vextracti128 XMMWORD PTR [rdx + 112], ymm3, 1
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
    xor rax, rax
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
    add rsp, 72
    vzeroupper
    ret
rijndael256Encrypt4BlocksYmmAsm ENDP

PUBLIC rijndael256Encrypt4BlocksVexAsm
ALIGN 16
rijndael256Encrypt4BlocksVexAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 136
    vmovdqu XMMWORD PTR [rsp + 0], xmm6
    vmovdqu XMMWORD PTR [rsp + 16], xmm7
    vmovdqu XMMWORD PTR [rsp + 32], xmm8
    vmovdqu XMMWORD PTR [rsp + 48], xmm9
    vmovdqu XMMWORD PTR [rsp + 64], xmm10
    vmovdqu XMMWORD PTR [rsp + 80], xmm11
    vmovdqu XMMWORD PTR [rsp + 96], xmm12
    vmovdqu XMMWORD PTR [rsp + 112], xmm13
    mov rax, rcx
    mov rcx, r8
    vmovdqu xmm0, XMMWORD PTR [rcx]
    vmovdqu xmm1, XMMWORD PTR [rcx + 16]
    vmovdqu xmm2, XMMWORD PTR [rcx + 32]
    vmovdqu xmm3, XMMWORD PTR [rcx + 48]
    vmovdqu xmm4, XMMWORD PTR [rcx + 64]
    vmovdqu xmm5, XMMWORD PTR [rcx + 80]
    vmovdqu xmm6, XMMWORD PTR [rcx + 96]
    vmovdqu xmm7, XMMWORD PTR [rcx + 112]
    vmovdqu xmm8, XMMWORD PTR [rijndael256Consts]
    vmovdqu xmm9, XMMWORD PTR [rijndael256Consts + 16]
    vmovdqu xmm10, XMMWORD PTR [rax]
    vmovdqu xmm11, XMMWORD PTR [rax + 16]
    vpxor xmm0, xmm0, xmm10
    vpxor xmm1, xmm1, xmm11
    vpxor xmm2, xmm2, xmm10
    vpxor xmm3, xmm3, xmm11
    vpxor xmm4, xmm4, xmm10
    vpxor xmm5, xmm5, xmm11
    vpxor xmm6, xmm6, xmm10
    vpxor xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rax + 32]
    vmovdqu xmm11, XMMWORD PTR [rax + 48]
    vpblendvb xmm12, xmm0, xmm1, xmm8
    vpblendvb xmm1, xmm1, xmm0, xmm8
    vpblendvb xmm13, xmm2, xmm3, xmm8
    vpblendvb xmm3, xmm3, xmm2, xmm8
    vpshufb xmm0, xmm12, xmm9
    vpshufb xmm1, xmm1, xmm9
    vpshufb xmm2, xmm13, xmm9
    vpshufb xmm3, xmm3, xmm9
    vaesenc xmm0, xmm0, xmm10
    vaesenc xmm1, xmm1, xmm11
    vaesenc xmm2, xmm2, xmm10
    vaesenc xmm3, xmm3, xmm11
    vpblendvb xmm12, xmm4, xmm5, xmm8
    vpblendvb xmm5, xmm5, xmm4, xmm8
    vpblendvb xmm13, xmm6, xmm7, xmm8
    vpblendvb xmm7, xmm7, xmm6, xmm8
    vpshufb xmm4, xmm12, xmm9
    vpshufb xmm5, xmm5, xmm9
    vpshufb xmm6, xmm13, xmm9
    vpshufb xmm7, xmm7, xmm9
    vaesenc xmm4, xmm4, xmm10
    vaesenc xmm5, xmm5, xmm11
    vaesenc xmm6, xmm6, xmm10
    vaesenc xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rax + 64]
    vmovdqu xmm11, XMMWORD PTR [rax + 80]
    vpblendvb xmm12, xmm0, xmm1, xmm8
    vpblendvb xmm1, xmm1, xmm0, xmm8
    vpblendvb xmm13, xmm2, xmm3, xmm8
    vpblendvb xmm3, xmm3, xmm2, xmm8
    vpshufb xmm0, xmm12, xmm9
    vpshufb xmm1, xmm1, xmm9
    vpshufb xmm2, xmm13, xmm9
    vpshufb xmm3, xmm3, xmm9
    vaesenc xmm0, xmm0, xmm10
    vaesenc xmm1, xmm1, xmm11
    vaesenc xmm2, xmm2, xmm10
    vaesenc xmm3, xmm3, xmm11
    vpblendvb xmm12, xmm4, xmm5, xmm8
    vpblendvb xmm5, xmm5, xmm4, xmm8
    vpblendvb xmm13, xmm6, xmm7, xmm8
    vpblendvb xmm7, xmm7, xmm6, xmm8
    vpshufb xmm4, xmm12, xmm9
    vpshufb xmm5, xmm5, xmm9
    vpshufb xmm6, xmm13, xmm9
    vpshufb xmm7, xmm7, xmm9
    vaesenc xmm4, xmm4, xmm10
    vaesenc xmm5, xmm5, xmm11
    vaesenc xmm6, xmm6, xmm10
    vaesenc xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rax + 96]
    vmovdqu xmm11, XMMWORD PTR [rax + 112]
    vpblendvb xmm12, xmm0, xmm1, xmm8
    vpblendvb xmm1, xmm1, xmm0, xmm8
    vpblendvb xmm13, xmm2, xmm3, xmm8
    vpblendvb xmm3, xmm3, xmm2, xmm8
    vpshufb xmm0, xmm12, xmm9
    vpshufb xmm1, xmm1, xmm9
    vpshufb xmm2, xmm13, xmm9
    vpshufb xmm3, xmm3, xmm9
    vaesenc xmm0, xmm0, xmm10
    vaesenc xmm1, xmm1, xmm11
    vaesenc xmm2, xmm2, xmm10
    vaesenc xmm3, xmm3, xmm11
    vpblendvb xmm12, xmm4, xmm5, xmm8
    vpblendvb xmm5, xmm5, xmm4, xmm8
    vpblendvb xmm13, xmm6, xmm7, xmm8
    vpblendvb xmm7, xmm7, xmm6, xmm8
    vpshufb xmm4, xmm12, xmm9
    vpshufb xmm5, xmm5, xmm9
    vpshufb xmm6, xmm13, xmm9
    vpshufb xmm7, xmm7, xmm9
    vaesenc xmm4, xmm4, xmm10
    vaesenc xmm5, xmm5, xmm11
    vaesenc xmm6, xmm6, xmm10
    vaesenc xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rax + 128]
    vmovdqu xmm11, XMMWORD PTR [rax + 144]
    vpblendvb xmm12, xmm0, xmm1, xmm8
    vpblendvb xmm1, xmm1, xmm0, xmm8
    vpblendvb xmm13, xmm2, xmm3, xmm8
    vpblendvb xmm3, xmm3, xmm2, xmm8
    vpshufb xmm0, xmm12, xmm9
    vpshufb xmm1, xmm1, xmm9
    vpshufb xmm2, xmm13, xmm9
    vpshufb xmm3, xmm3, xmm9
    vaesenc xmm0, xmm0, xmm10
    vaesenc xmm1, xmm1, xmm11
    vaesenc xmm2, xmm2, xmm10
    vaesenc xmm3, xmm3, xmm11
    vpblendvb xmm12, xmm4, xmm5, xmm8
    vpblendvb xmm5, xmm5, xmm4, xmm8
    vpblendvb xmm13, xmm6, xmm7, xmm8
    vpblendvb xmm7, xmm7, xmm6, xmm8
    vpshufb xmm4, xmm12, xmm9
    vpshufb xmm5, xmm5, xmm9
    vpshufb xmm6, xmm13, xmm9
    vpshufb xmm7, xmm7, xmm9
    vaesenc xmm4, xmm4, xmm10
    vaesenc xmm5, xmm5, xmm11
    vaesenc xmm6, xmm6, xmm10
    vaesenc xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rax + 160]
    vmovdqu xmm11, XMMWORD PTR [rax + 176]
    vpblendvb xmm12, xmm0, xmm1, xmm8
    vpblendvb xmm1, xmm1, xmm0, xmm8
    vpblendvb xmm13, xmm2, xmm3, xmm8
    vpblendvb xmm3, xmm3, xmm2, xmm8
    vpshufb xmm0, xmm12, xmm9
    vpshufb xmm1, xmm1, xmm9
    vpshufb xmm2, xmm13, xmm9
    vpshufb xmm3, xmm3, xmm9
    vaesenc xmm0, xmm0, xmm10
    vaesenc xmm1, xmm1, xmm11
    vaesenc xmm2, xmm2, xmm10
    vaesenc xmm3, xmm3, xmm11
    vpblendvb xmm12, xmm4, xmm5, xmm8
    vpblendvb xmm5, xmm5, xmm4, xmm8
    vpblendvb xmm13, xmm6, xmm7, xmm8
    vpblendvb xmm7, xmm7, xmm6, xmm8
    vpshufb xmm4, xmm12, xmm9
    vpshufb xmm5, xmm5, xmm9
    vpshufb xmm6, xmm13, xmm9
    vpshufb xmm7, xmm7, xmm9
    vaesenc xmm4, xmm4, xmm10
    vaesenc xmm5, xmm5, xmm11
    vaesenc xmm6, xmm6, xmm10
    vaesenc xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rax + 192]
    vmovdqu xmm11, XMMWORD PTR [rax + 208]
    vpblendvb xmm12, xmm0, xmm1, xmm8
    vpblendvb xmm1, xmm1, xmm0, xmm8
    vpblendvb xmm13, xmm2, xmm3, xmm8
    vpblendvb xmm3, xmm3, xmm2, xmm8
    vpshufb xmm0, xmm12, xmm9
    vpshufb xmm1, xmm1, xmm9
    vpshufb xmm2, xmm13, xmm9
    vpshufb xmm3, xmm3, xmm9
    vaesenc xmm0, xmm0, xmm10
    vaesenc xmm1, xmm1, xmm11
    vaesenc xmm2, xmm2, xmm10
    vaesenc xmm3, xmm3, xmm11
    vpblendvb xmm12, xmm4, xmm5, xmm8
    vpblendvb xmm5, xmm5, xmm4, xmm8
    vpblendvb xmm13, xmm6, xmm7, xmm8
    vpblendvb xmm7, xmm7, xmm6, xmm8
    vpshufb xmm4, xmm12, xmm9
    vpshufb xmm5, xmm5, xmm9
    vpshufb xmm6, xmm13, xmm9
    vpshufb xmm7, xmm7, xmm9
    vaesenc xmm4, xmm4, xmm10
    vaesenc xmm5, xmm5, xmm11
    vaesenc xmm6, xmm6, xmm10
    vaesenc xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rax + 224]
    vmovdqu xmm11, XMMWORD PTR [rax + 240]
    vpblendvb xmm12, xmm0, xmm1, xmm8
    vpblendvb xmm1, xmm1, xmm0, xmm8
    vpblendvb xmm13, xmm2, xmm3, xmm8
    vpblendvb xmm3, xmm3, xmm2, xmm8
    vpshufb xmm0, xmm12, xmm9
    vpshufb xmm1, xmm1, xmm9
    vpshufb xmm2, xmm13, xmm9
    vpshufb xmm3, xmm3, xmm9
    vaesenc xmm0, xmm0, xmm10
    vaesenc xmm1, xmm1, xmm11
    vaesenc xmm2, xmm2, xmm10
    vaesenc xmm3, xmm3, xmm11
    vpblendvb xmm12, xmm4, xmm5, xmm8
    vpblendvb xmm5, xmm5, xmm4, xmm8
    vpblendvb xmm13, xmm6, xmm7, xmm8
    vpblendvb xmm7, xmm7, xmm6, xmm8
    vpshufb xmm4, xmm12, xmm9
    vpshufb xmm5, xmm5, xmm9
    vpshufb xmm6, xmm13, xmm9
    vpshufb xmm7, xmm7, xmm9
    vaesenc xmm4, xmm4, xmm10
    vaesenc xmm5, xmm5, xmm11
    vaesenc xmm6, xmm6, xmm10
    vaesenc xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rax + 256]
    vmovdqu xmm11, XMMWORD PTR [rax + 272]
    vpblendvb xmm12, xmm0, xmm1, xmm8
    vpblendvb xmm1, xmm1, xmm0, xmm8
    vpblendvb xmm13, xmm2, xmm3, xmm8
    vpblendvb xmm3, xmm3, xmm2, xmm8
    vpshufb xmm0, xmm12, xmm9
    vpshufb xmm1, xmm1, xmm9
    vpshufb xmm2, xmm13, xmm9
    vpshufb xmm3, xmm3, xmm9
    vaesenc xmm0, xmm0, xmm10
    vaesenc xmm1, xmm1, xmm11
    vaesenc xmm2, xmm2, xmm10
    vaesenc xmm3, xmm3, xmm11
    vpblendvb xmm12, xmm4, xmm5, xmm8
    vpblendvb xmm5, xmm5, xmm4, xmm8
    vpblendvb xmm13, xmm6, xmm7, xmm8
    vpblendvb xmm7, xmm7, xmm6, xmm8
    vpshufb xmm4, xmm12, xmm9
    vpshufb xmm5, xmm5, xmm9
    vpshufb xmm6, xmm13, xmm9
    vpshufb xmm7, xmm7, xmm9
    vaesenc xmm4, xmm4, xmm10
    vaesenc xmm5, xmm5, xmm11
    vaesenc xmm6, xmm6, xmm10
    vaesenc xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rax + 288]
    vmovdqu xmm11, XMMWORD PTR [rax + 304]
    vpblendvb xmm12, xmm0, xmm1, xmm8
    vpblendvb xmm1, xmm1, xmm0, xmm8
    vpblendvb xmm13, xmm2, xmm3, xmm8
    vpblendvb xmm3, xmm3, xmm2, xmm8
    vpshufb xmm0, xmm12, xmm9
    vpshufb xmm1, xmm1, xmm9
    vpshufb xmm2, xmm13, xmm9
    vpshufb xmm3, xmm3, xmm9
    vaesenc xmm0, xmm0, xmm10
    vaesenc xmm1, xmm1, xmm11
    vaesenc xmm2, xmm2, xmm10
    vaesenc xmm3, xmm3, xmm11
    vpblendvb xmm12, xmm4, xmm5, xmm8
    vpblendvb xmm5, xmm5, xmm4, xmm8
    vpblendvb xmm13, xmm6, xmm7, xmm8
    vpblendvb xmm7, xmm7, xmm6, xmm8
    vpshufb xmm4, xmm12, xmm9
    vpshufb xmm5, xmm5, xmm9
    vpshufb xmm6, xmm13, xmm9
    vpshufb xmm7, xmm7, xmm9
    vaesenc xmm4, xmm4, xmm10
    vaesenc xmm5, xmm5, xmm11
    vaesenc xmm6, xmm6, xmm10
    vaesenc xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rax + 320]
    vmovdqu xmm11, XMMWORD PTR [rax + 336]
    vpblendvb xmm12, xmm0, xmm1, xmm8
    vpblendvb xmm1, xmm1, xmm0, xmm8
    vpblendvb xmm13, xmm2, xmm3, xmm8
    vpblendvb xmm3, xmm3, xmm2, xmm8
    vpshufb xmm0, xmm12, xmm9
    vpshufb xmm1, xmm1, xmm9
    vpshufb xmm2, xmm13, xmm9
    vpshufb xmm3, xmm3, xmm9
    vaesenc xmm0, xmm0, xmm10
    vaesenc xmm1, xmm1, xmm11
    vaesenc xmm2, xmm2, xmm10
    vaesenc xmm3, xmm3, xmm11
    vpblendvb xmm12, xmm4, xmm5, xmm8
    vpblendvb xmm5, xmm5, xmm4, xmm8
    vpblendvb xmm13, xmm6, xmm7, xmm8
    vpblendvb xmm7, xmm7, xmm6, xmm8
    vpshufb xmm4, xmm12, xmm9
    vpshufb xmm5, xmm5, xmm9
    vpshufb xmm6, xmm13, xmm9
    vpshufb xmm7, xmm7, xmm9
    vaesenc xmm4, xmm4, xmm10
    vaesenc xmm5, xmm5, xmm11
    vaesenc xmm6, xmm6, xmm10
    vaesenc xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rax + 352]
    vmovdqu xmm11, XMMWORD PTR [rax + 368]
    vpblendvb xmm12, xmm0, xmm1, xmm8
    vpblendvb xmm1, xmm1, xmm0, xmm8
    vpblendvb xmm13, xmm2, xmm3, xmm8
    vpblendvb xmm3, xmm3, xmm2, xmm8
    vpshufb xmm0, xmm12, xmm9
    vpshufb xmm1, xmm1, xmm9
    vpshufb xmm2, xmm13, xmm9
    vpshufb xmm3, xmm3, xmm9
    vaesenc xmm0, xmm0, xmm10
    vaesenc xmm1, xmm1, xmm11
    vaesenc xmm2, xmm2, xmm10
    vaesenc xmm3, xmm3, xmm11
    vpblendvb xmm12, xmm4, xmm5, xmm8
    vpblendvb xmm5, xmm5, xmm4, xmm8
    vpblendvb xmm13, xmm6, xmm7, xmm8
    vpblendvb xmm7, xmm7, xmm6, xmm8
    vpshufb xmm4, xmm12, xmm9
    vpshufb xmm5, xmm5, xmm9
    vpshufb xmm6, xmm13, xmm9
    vpshufb xmm7, xmm7, xmm9
    vaesenc xmm4, xmm4, xmm10
    vaesenc xmm5, xmm5, xmm11
    vaesenc xmm6, xmm6, xmm10
    vaesenc xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rax + 384]
    vmovdqu xmm11, XMMWORD PTR [rax + 400]
    vpblendvb xmm12, xmm0, xmm1, xmm8
    vpblendvb xmm1, xmm1, xmm0, xmm8
    vpblendvb xmm13, xmm2, xmm3, xmm8
    vpblendvb xmm3, xmm3, xmm2, xmm8
    vpshufb xmm0, xmm12, xmm9
    vpshufb xmm1, xmm1, xmm9
    vpshufb xmm2, xmm13, xmm9
    vpshufb xmm3, xmm3, xmm9
    vaesenc xmm0, xmm0, xmm10
    vaesenc xmm1, xmm1, xmm11
    vaesenc xmm2, xmm2, xmm10
    vaesenc xmm3, xmm3, xmm11
    vpblendvb xmm12, xmm4, xmm5, xmm8
    vpblendvb xmm5, xmm5, xmm4, xmm8
    vpblendvb xmm13, xmm6, xmm7, xmm8
    vpblendvb xmm7, xmm7, xmm6, xmm8
    vpshufb xmm4, xmm12, xmm9
    vpshufb xmm5, xmm5, xmm9
    vpshufb xmm6, xmm13, xmm9
    vpshufb xmm7, xmm7, xmm9
    vaesenc xmm4, xmm4, xmm10
    vaesenc xmm5, xmm5, xmm11
    vaesenc xmm6, xmm6, xmm10
    vaesenc xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rax + 416]
    vmovdqu xmm11, XMMWORD PTR [rax + 432]
    vpblendvb xmm12, xmm0, xmm1, xmm8
    vpblendvb xmm1, xmm1, xmm0, xmm8
    vpblendvb xmm13, xmm2, xmm3, xmm8
    vpblendvb xmm3, xmm3, xmm2, xmm8
    vpshufb xmm0, xmm12, xmm9
    vpshufb xmm1, xmm1, xmm9
    vpshufb xmm2, xmm13, xmm9
    vpshufb xmm3, xmm3, xmm9
    vaesenc xmm0, xmm0, xmm10
    vaesenc xmm1, xmm1, xmm11
    vaesenc xmm2, xmm2, xmm10
    vaesenc xmm3, xmm3, xmm11
    vpblendvb xmm12, xmm4, xmm5, xmm8
    vpblendvb xmm5, xmm5, xmm4, xmm8
    vpblendvb xmm13, xmm6, xmm7, xmm8
    vpblendvb xmm7, xmm7, xmm6, xmm8
    vpshufb xmm4, xmm12, xmm9
    vpshufb xmm5, xmm5, xmm9
    vpshufb xmm6, xmm13, xmm9
    vpshufb xmm7, xmm7, xmm9
    vaesenc xmm4, xmm4, xmm10
    vaesenc xmm5, xmm5, xmm11
    vaesenc xmm6, xmm6, xmm10
    vaesenc xmm7, xmm7, xmm11
    vmovdqu xmm10, XMMWORD PTR [rax + 448]
    vmovdqu xmm11, XMMWORD PTR [rax + 464]
    vpblendvb xmm12, xmm0, xmm1, xmm8
    vpblendvb xmm1, xmm1, xmm0, xmm8
    vpblendvb xmm13, xmm2, xmm3, xmm8
    vpblendvb xmm3, xmm3, xmm2, xmm8
    vpshufb xmm0, xmm12, xmm9
    vpshufb xmm1, xmm1, xmm9
    vpshufb xmm2, xmm13, xmm9
    vpshufb xmm3, xmm3, xmm9
    vaesenclast xmm0, xmm0, xmm10
    vaesenclast xmm1, xmm1, xmm11
    vaesenclast xmm2, xmm2, xmm10
    vaesenclast xmm3, xmm3, xmm11
    vpblendvb xmm12, xmm4, xmm5, xmm8
    vpblendvb xmm5, xmm5, xmm4, xmm8
    vpblendvb xmm13, xmm6, xmm7, xmm8
    vpblendvb xmm7, xmm7, xmm6, xmm8
    vpshufb xmm4, xmm12, xmm9
    vpshufb xmm5, xmm5, xmm9
    vpshufb xmm6, xmm13, xmm9
    vpshufb xmm7, xmm7, xmm9
    vaesenclast xmm4, xmm4, xmm10
    vaesenclast xmm5, xmm5, xmm11
    vaesenclast xmm6, xmm6, xmm10
    vaesenclast xmm7, xmm7, xmm11
    vmovdqu XMMWORD PTR [rdx], xmm0
    vmovdqu XMMWORD PTR [rdx + 16], xmm1
    vmovdqu XMMWORD PTR [rdx + 32], xmm2
    vmovdqu XMMWORD PTR [rdx + 48], xmm3
    vmovdqu XMMWORD PTR [rdx + 64], xmm4
    vmovdqu XMMWORD PTR [rdx + 80], xmm5
    vmovdqu XMMWORD PTR [rdx + 96], xmm6
    vmovdqu XMMWORD PTR [rdx + 112], xmm7
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
    xor rax, rax
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
    add rsp, 136
    ret
rijndael256Encrypt4BlocksVexAsm ENDP

PUBLIC rijndael256Encrypt4BlocksAesNiAsm
ALIGN 16
rijndael256Encrypt4BlocksAesNiAsm PROC
    db 0F3h, 00Fh, 01Eh, 0FAh ; endbr64
    sub rsp, 136
    movdqu XMMWORD PTR [rsp + 0], xmm6
    movdqu XMMWORD PTR [rsp + 16], xmm7
    movdqu XMMWORD PTR [rsp + 32], xmm8
    movdqu XMMWORD PTR [rsp + 48], xmm9
    movdqu XMMWORD PTR [rsp + 64], xmm10
    movdqu XMMWORD PTR [rsp + 80], xmm11
    movdqu XMMWORD PTR [rsp + 96], xmm12
    movdqu XMMWORD PTR [rsp + 112], xmm13
    mov rax, rcx
    mov rcx, r8
    movdqu xmm0, XMMWORD PTR [rijndael256Consts]
    movdqu xmm9, XMMWORD PTR [rijndael256Consts + 16]
    movdqu xmm1, XMMWORD PTR [rcx]
    movdqu xmm2, XMMWORD PTR [rcx + 16]
    movdqu xmm3, XMMWORD PTR [rcx + 32]
    movdqu xmm4, XMMWORD PTR [rcx + 48]
    movdqu xmm5, XMMWORD PTR [rcx + 64]
    movdqu xmm6, XMMWORD PTR [rcx + 80]
    movdqu xmm7, XMMWORD PTR [rcx + 96]
    movdqu xmm8, XMMWORD PTR [rcx + 112]
    movdqu xmm10, XMMWORD PTR [rax]
    movdqu xmm11, XMMWORD PTR [rax + 16]
    pxor xmm1, xmm10
    pxor xmm2, xmm11
    pxor xmm3, xmm10
    pxor xmm4, xmm11
    pxor xmm5, xmm10
    pxor xmm6, xmm11
    pxor xmm7, xmm10
    pxor xmm8, xmm11
    movdqu xmm10, XMMWORD PTR [rax + 32]
    movdqu xmm11, XMMWORD PTR [rax + 48]
    movdqu xmm12, xmm1
    pblendvb xmm12, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    movdqu xmm13, xmm3
    pblendvb xmm13, xmm4, xmm0
    pblendvb xmm4, xmm3, xmm0
    pshufb xmm12, xmm9
    pshufb xmm2, xmm9
    pshufb xmm13, xmm9
    pshufb xmm4, xmm9
    movdqu xmm1, xmm12
    movdqu xmm3, xmm13
    aesenc xmm1, xmm10
    aesenc xmm2, xmm11
    aesenc xmm3, xmm10
    aesenc xmm4, xmm11
    movdqu xmm12, xmm5
    pblendvb xmm12, xmm6, xmm0
    pblendvb xmm6, xmm5, xmm0
    movdqu xmm13, xmm7
    pblendvb xmm13, xmm8, xmm0
    pblendvb xmm8, xmm7, xmm0
    pshufb xmm12, xmm9
    pshufb xmm6, xmm9
    pshufb xmm13, xmm9
    pshufb xmm8, xmm9
    movdqu xmm5, xmm12
    movdqu xmm7, xmm13
    aesenc xmm5, xmm10
    aesenc xmm6, xmm11
    aesenc xmm7, xmm10
    aesenc xmm8, xmm11
    movdqu xmm10, XMMWORD PTR [rax + 64]
    movdqu xmm11, XMMWORD PTR [rax + 80]
    movdqu xmm12, xmm1
    pblendvb xmm12, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    movdqu xmm13, xmm3
    pblendvb xmm13, xmm4, xmm0
    pblendvb xmm4, xmm3, xmm0
    pshufb xmm12, xmm9
    pshufb xmm2, xmm9
    pshufb xmm13, xmm9
    pshufb xmm4, xmm9
    movdqu xmm1, xmm12
    movdqu xmm3, xmm13
    aesenc xmm1, xmm10
    aesenc xmm2, xmm11
    aesenc xmm3, xmm10
    aesenc xmm4, xmm11
    movdqu xmm12, xmm5
    pblendvb xmm12, xmm6, xmm0
    pblendvb xmm6, xmm5, xmm0
    movdqu xmm13, xmm7
    pblendvb xmm13, xmm8, xmm0
    pblendvb xmm8, xmm7, xmm0
    pshufb xmm12, xmm9
    pshufb xmm6, xmm9
    pshufb xmm13, xmm9
    pshufb xmm8, xmm9
    movdqu xmm5, xmm12
    movdqu xmm7, xmm13
    aesenc xmm5, xmm10
    aesenc xmm6, xmm11
    aesenc xmm7, xmm10
    aesenc xmm8, xmm11
    movdqu xmm10, XMMWORD PTR [rax + 96]
    movdqu xmm11, XMMWORD PTR [rax + 112]
    movdqu xmm12, xmm1
    pblendvb xmm12, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    movdqu xmm13, xmm3
    pblendvb xmm13, xmm4, xmm0
    pblendvb xmm4, xmm3, xmm0
    pshufb xmm12, xmm9
    pshufb xmm2, xmm9
    pshufb xmm13, xmm9
    pshufb xmm4, xmm9
    movdqu xmm1, xmm12
    movdqu xmm3, xmm13
    aesenc xmm1, xmm10
    aesenc xmm2, xmm11
    aesenc xmm3, xmm10
    aesenc xmm4, xmm11
    movdqu xmm12, xmm5
    pblendvb xmm12, xmm6, xmm0
    pblendvb xmm6, xmm5, xmm0
    movdqu xmm13, xmm7
    pblendvb xmm13, xmm8, xmm0
    pblendvb xmm8, xmm7, xmm0
    pshufb xmm12, xmm9
    pshufb xmm6, xmm9
    pshufb xmm13, xmm9
    pshufb xmm8, xmm9
    movdqu xmm5, xmm12
    movdqu xmm7, xmm13
    aesenc xmm5, xmm10
    aesenc xmm6, xmm11
    aesenc xmm7, xmm10
    aesenc xmm8, xmm11
    movdqu xmm10, XMMWORD PTR [rax + 128]
    movdqu xmm11, XMMWORD PTR [rax + 144]
    movdqu xmm12, xmm1
    pblendvb xmm12, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    movdqu xmm13, xmm3
    pblendvb xmm13, xmm4, xmm0
    pblendvb xmm4, xmm3, xmm0
    pshufb xmm12, xmm9
    pshufb xmm2, xmm9
    pshufb xmm13, xmm9
    pshufb xmm4, xmm9
    movdqu xmm1, xmm12
    movdqu xmm3, xmm13
    aesenc xmm1, xmm10
    aesenc xmm2, xmm11
    aesenc xmm3, xmm10
    aesenc xmm4, xmm11
    movdqu xmm12, xmm5
    pblendvb xmm12, xmm6, xmm0
    pblendvb xmm6, xmm5, xmm0
    movdqu xmm13, xmm7
    pblendvb xmm13, xmm8, xmm0
    pblendvb xmm8, xmm7, xmm0
    pshufb xmm12, xmm9
    pshufb xmm6, xmm9
    pshufb xmm13, xmm9
    pshufb xmm8, xmm9
    movdqu xmm5, xmm12
    movdqu xmm7, xmm13
    aesenc xmm5, xmm10
    aesenc xmm6, xmm11
    aesenc xmm7, xmm10
    aesenc xmm8, xmm11
    movdqu xmm10, XMMWORD PTR [rax + 160]
    movdqu xmm11, XMMWORD PTR [rax + 176]
    movdqu xmm12, xmm1
    pblendvb xmm12, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    movdqu xmm13, xmm3
    pblendvb xmm13, xmm4, xmm0
    pblendvb xmm4, xmm3, xmm0
    pshufb xmm12, xmm9
    pshufb xmm2, xmm9
    pshufb xmm13, xmm9
    pshufb xmm4, xmm9
    movdqu xmm1, xmm12
    movdqu xmm3, xmm13
    aesenc xmm1, xmm10
    aesenc xmm2, xmm11
    aesenc xmm3, xmm10
    aesenc xmm4, xmm11
    movdqu xmm12, xmm5
    pblendvb xmm12, xmm6, xmm0
    pblendvb xmm6, xmm5, xmm0
    movdqu xmm13, xmm7
    pblendvb xmm13, xmm8, xmm0
    pblendvb xmm8, xmm7, xmm0
    pshufb xmm12, xmm9
    pshufb xmm6, xmm9
    pshufb xmm13, xmm9
    pshufb xmm8, xmm9
    movdqu xmm5, xmm12
    movdqu xmm7, xmm13
    aesenc xmm5, xmm10
    aesenc xmm6, xmm11
    aesenc xmm7, xmm10
    aesenc xmm8, xmm11
    movdqu xmm10, XMMWORD PTR [rax + 192]
    movdqu xmm11, XMMWORD PTR [rax + 208]
    movdqu xmm12, xmm1
    pblendvb xmm12, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    movdqu xmm13, xmm3
    pblendvb xmm13, xmm4, xmm0
    pblendvb xmm4, xmm3, xmm0
    pshufb xmm12, xmm9
    pshufb xmm2, xmm9
    pshufb xmm13, xmm9
    pshufb xmm4, xmm9
    movdqu xmm1, xmm12
    movdqu xmm3, xmm13
    aesenc xmm1, xmm10
    aesenc xmm2, xmm11
    aesenc xmm3, xmm10
    aesenc xmm4, xmm11
    movdqu xmm12, xmm5
    pblendvb xmm12, xmm6, xmm0
    pblendvb xmm6, xmm5, xmm0
    movdqu xmm13, xmm7
    pblendvb xmm13, xmm8, xmm0
    pblendvb xmm8, xmm7, xmm0
    pshufb xmm12, xmm9
    pshufb xmm6, xmm9
    pshufb xmm13, xmm9
    pshufb xmm8, xmm9
    movdqu xmm5, xmm12
    movdqu xmm7, xmm13
    aesenc xmm5, xmm10
    aesenc xmm6, xmm11
    aesenc xmm7, xmm10
    aesenc xmm8, xmm11
    movdqu xmm10, XMMWORD PTR [rax + 224]
    movdqu xmm11, XMMWORD PTR [rax + 240]
    movdqu xmm12, xmm1
    pblendvb xmm12, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    movdqu xmm13, xmm3
    pblendvb xmm13, xmm4, xmm0
    pblendvb xmm4, xmm3, xmm0
    pshufb xmm12, xmm9
    pshufb xmm2, xmm9
    pshufb xmm13, xmm9
    pshufb xmm4, xmm9
    movdqu xmm1, xmm12
    movdqu xmm3, xmm13
    aesenc xmm1, xmm10
    aesenc xmm2, xmm11
    aesenc xmm3, xmm10
    aesenc xmm4, xmm11
    movdqu xmm12, xmm5
    pblendvb xmm12, xmm6, xmm0
    pblendvb xmm6, xmm5, xmm0
    movdqu xmm13, xmm7
    pblendvb xmm13, xmm8, xmm0
    pblendvb xmm8, xmm7, xmm0
    pshufb xmm12, xmm9
    pshufb xmm6, xmm9
    pshufb xmm13, xmm9
    pshufb xmm8, xmm9
    movdqu xmm5, xmm12
    movdqu xmm7, xmm13
    aesenc xmm5, xmm10
    aesenc xmm6, xmm11
    aesenc xmm7, xmm10
    aesenc xmm8, xmm11
    movdqu xmm10, XMMWORD PTR [rax + 256]
    movdqu xmm11, XMMWORD PTR [rax + 272]
    movdqu xmm12, xmm1
    pblendvb xmm12, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    movdqu xmm13, xmm3
    pblendvb xmm13, xmm4, xmm0
    pblendvb xmm4, xmm3, xmm0
    pshufb xmm12, xmm9
    pshufb xmm2, xmm9
    pshufb xmm13, xmm9
    pshufb xmm4, xmm9
    movdqu xmm1, xmm12
    movdqu xmm3, xmm13
    aesenc xmm1, xmm10
    aesenc xmm2, xmm11
    aesenc xmm3, xmm10
    aesenc xmm4, xmm11
    movdqu xmm12, xmm5
    pblendvb xmm12, xmm6, xmm0
    pblendvb xmm6, xmm5, xmm0
    movdqu xmm13, xmm7
    pblendvb xmm13, xmm8, xmm0
    pblendvb xmm8, xmm7, xmm0
    pshufb xmm12, xmm9
    pshufb xmm6, xmm9
    pshufb xmm13, xmm9
    pshufb xmm8, xmm9
    movdqu xmm5, xmm12
    movdqu xmm7, xmm13
    aesenc xmm5, xmm10
    aesenc xmm6, xmm11
    aesenc xmm7, xmm10
    aesenc xmm8, xmm11
    movdqu xmm10, XMMWORD PTR [rax + 288]
    movdqu xmm11, XMMWORD PTR [rax + 304]
    movdqu xmm12, xmm1
    pblendvb xmm12, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    movdqu xmm13, xmm3
    pblendvb xmm13, xmm4, xmm0
    pblendvb xmm4, xmm3, xmm0
    pshufb xmm12, xmm9
    pshufb xmm2, xmm9
    pshufb xmm13, xmm9
    pshufb xmm4, xmm9
    movdqu xmm1, xmm12
    movdqu xmm3, xmm13
    aesenc xmm1, xmm10
    aesenc xmm2, xmm11
    aesenc xmm3, xmm10
    aesenc xmm4, xmm11
    movdqu xmm12, xmm5
    pblendvb xmm12, xmm6, xmm0
    pblendvb xmm6, xmm5, xmm0
    movdqu xmm13, xmm7
    pblendvb xmm13, xmm8, xmm0
    pblendvb xmm8, xmm7, xmm0
    pshufb xmm12, xmm9
    pshufb xmm6, xmm9
    pshufb xmm13, xmm9
    pshufb xmm8, xmm9
    movdqu xmm5, xmm12
    movdqu xmm7, xmm13
    aesenc xmm5, xmm10
    aesenc xmm6, xmm11
    aesenc xmm7, xmm10
    aesenc xmm8, xmm11
    movdqu xmm10, XMMWORD PTR [rax + 320]
    movdqu xmm11, XMMWORD PTR [rax + 336]
    movdqu xmm12, xmm1
    pblendvb xmm12, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    movdqu xmm13, xmm3
    pblendvb xmm13, xmm4, xmm0
    pblendvb xmm4, xmm3, xmm0
    pshufb xmm12, xmm9
    pshufb xmm2, xmm9
    pshufb xmm13, xmm9
    pshufb xmm4, xmm9
    movdqu xmm1, xmm12
    movdqu xmm3, xmm13
    aesenc xmm1, xmm10
    aesenc xmm2, xmm11
    aesenc xmm3, xmm10
    aesenc xmm4, xmm11
    movdqu xmm12, xmm5
    pblendvb xmm12, xmm6, xmm0
    pblendvb xmm6, xmm5, xmm0
    movdqu xmm13, xmm7
    pblendvb xmm13, xmm8, xmm0
    pblendvb xmm8, xmm7, xmm0
    pshufb xmm12, xmm9
    pshufb xmm6, xmm9
    pshufb xmm13, xmm9
    pshufb xmm8, xmm9
    movdqu xmm5, xmm12
    movdqu xmm7, xmm13
    aesenc xmm5, xmm10
    aesenc xmm6, xmm11
    aesenc xmm7, xmm10
    aesenc xmm8, xmm11
    movdqu xmm10, XMMWORD PTR [rax + 352]
    movdqu xmm11, XMMWORD PTR [rax + 368]
    movdqu xmm12, xmm1
    pblendvb xmm12, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    movdqu xmm13, xmm3
    pblendvb xmm13, xmm4, xmm0
    pblendvb xmm4, xmm3, xmm0
    pshufb xmm12, xmm9
    pshufb xmm2, xmm9
    pshufb xmm13, xmm9
    pshufb xmm4, xmm9
    movdqu xmm1, xmm12
    movdqu xmm3, xmm13
    aesenc xmm1, xmm10
    aesenc xmm2, xmm11
    aesenc xmm3, xmm10
    aesenc xmm4, xmm11
    movdqu xmm12, xmm5
    pblendvb xmm12, xmm6, xmm0
    pblendvb xmm6, xmm5, xmm0
    movdqu xmm13, xmm7
    pblendvb xmm13, xmm8, xmm0
    pblendvb xmm8, xmm7, xmm0
    pshufb xmm12, xmm9
    pshufb xmm6, xmm9
    pshufb xmm13, xmm9
    pshufb xmm8, xmm9
    movdqu xmm5, xmm12
    movdqu xmm7, xmm13
    aesenc xmm5, xmm10
    aesenc xmm6, xmm11
    aesenc xmm7, xmm10
    aesenc xmm8, xmm11
    movdqu xmm10, XMMWORD PTR [rax + 384]
    movdqu xmm11, XMMWORD PTR [rax + 400]
    movdqu xmm12, xmm1
    pblendvb xmm12, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    movdqu xmm13, xmm3
    pblendvb xmm13, xmm4, xmm0
    pblendvb xmm4, xmm3, xmm0
    pshufb xmm12, xmm9
    pshufb xmm2, xmm9
    pshufb xmm13, xmm9
    pshufb xmm4, xmm9
    movdqu xmm1, xmm12
    movdqu xmm3, xmm13
    aesenc xmm1, xmm10
    aesenc xmm2, xmm11
    aesenc xmm3, xmm10
    aesenc xmm4, xmm11
    movdqu xmm12, xmm5
    pblendvb xmm12, xmm6, xmm0
    pblendvb xmm6, xmm5, xmm0
    movdqu xmm13, xmm7
    pblendvb xmm13, xmm8, xmm0
    pblendvb xmm8, xmm7, xmm0
    pshufb xmm12, xmm9
    pshufb xmm6, xmm9
    pshufb xmm13, xmm9
    pshufb xmm8, xmm9
    movdqu xmm5, xmm12
    movdqu xmm7, xmm13
    aesenc xmm5, xmm10
    aesenc xmm6, xmm11
    aesenc xmm7, xmm10
    aesenc xmm8, xmm11
    movdqu xmm10, XMMWORD PTR [rax + 416]
    movdqu xmm11, XMMWORD PTR [rax + 432]
    movdqu xmm12, xmm1
    pblendvb xmm12, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    movdqu xmm13, xmm3
    pblendvb xmm13, xmm4, xmm0
    pblendvb xmm4, xmm3, xmm0
    pshufb xmm12, xmm9
    pshufb xmm2, xmm9
    pshufb xmm13, xmm9
    pshufb xmm4, xmm9
    movdqu xmm1, xmm12
    movdqu xmm3, xmm13
    aesenc xmm1, xmm10
    aesenc xmm2, xmm11
    aesenc xmm3, xmm10
    aesenc xmm4, xmm11
    movdqu xmm12, xmm5
    pblendvb xmm12, xmm6, xmm0
    pblendvb xmm6, xmm5, xmm0
    movdqu xmm13, xmm7
    pblendvb xmm13, xmm8, xmm0
    pblendvb xmm8, xmm7, xmm0
    pshufb xmm12, xmm9
    pshufb xmm6, xmm9
    pshufb xmm13, xmm9
    pshufb xmm8, xmm9
    movdqu xmm5, xmm12
    movdqu xmm7, xmm13
    aesenc xmm5, xmm10
    aesenc xmm6, xmm11
    aesenc xmm7, xmm10
    aesenc xmm8, xmm11
    movdqu xmm10, XMMWORD PTR [rax + 448]
    movdqu xmm11, XMMWORD PTR [rax + 464]
    movdqu xmm12, xmm1
    pblendvb xmm12, xmm2, xmm0
    pblendvb xmm2, xmm1, xmm0
    movdqu xmm13, xmm3
    pblendvb xmm13, xmm4, xmm0
    pblendvb xmm4, xmm3, xmm0
    pshufb xmm12, xmm9
    pshufb xmm2, xmm9
    pshufb xmm13, xmm9
    pshufb xmm4, xmm9
    movdqu xmm1, xmm12
    movdqu xmm3, xmm13
    aesenclast xmm1, xmm10
    aesenclast xmm2, xmm11
    aesenclast xmm3, xmm10
    aesenclast xmm4, xmm11
    movdqu xmm12, xmm5
    pblendvb xmm12, xmm6, xmm0
    pblendvb xmm6, xmm5, xmm0
    movdqu xmm13, xmm7
    pblendvb xmm13, xmm8, xmm0
    pblendvb xmm8, xmm7, xmm0
    pshufb xmm12, xmm9
    pshufb xmm6, xmm9
    pshufb xmm13, xmm9
    pshufb xmm8, xmm9
    movdqu xmm5, xmm12
    movdqu xmm7, xmm13
    aesenclast xmm5, xmm10
    aesenclast xmm6, xmm11
    aesenclast xmm7, xmm10
    aesenclast xmm8, xmm11
    movdqu XMMWORD PTR [rdx], xmm1
    movdqu XMMWORD PTR [rdx + 16], xmm2
    movdqu XMMWORD PTR [rdx + 32], xmm3
    movdqu XMMWORD PTR [rdx + 48], xmm4
    movdqu XMMWORD PTR [rdx + 64], xmm5
    movdqu XMMWORD PTR [rdx + 80], xmm6
    movdqu XMMWORD PTR [rdx + 96], xmm7
    movdqu XMMWORD PTR [rdx + 112], xmm8
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
    xor rax, rax
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
    add rsp, 136
    ret
rijndael256Encrypt4BlocksAesNiAsm ENDP

END
