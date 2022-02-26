﻿;***************************************
;
;        TASERED IN THE CROTCH!
;
;     A fun game by Richard Bayliss
;
;       (C)2022 The New Dimension
;
;***************************************

;PICTURE LINKER
vid = $3f40
col = $4328

    !to "tasered_disk.prg",cbm 
    
    * = $0810
    sei
    lda #$00
    sta $d020
    sta $d021
    lda #$3b
    sta $d011
    lda #$18
    sta $d018
    sta $d016
   
    ldx #$00
drawpic
    lda vid,x
    sta $0400,x
    lda vid+$100,x
    sta $0500,x
    lda vid+$200,x
    sta $0600,x
    lda vid+$2e8,x
    sta $06e8,x
    lda col,x
    sta $d800,x
    lda col+$100,x
    sta $d900,x
    lda col+$200,x
    sta $da00,x
    lda col+$2e8,x
    sta $dae8,x
    inx
    bne drawpic
keyloop    
    lda #16
    bit $dc00
    bne .f1
    jmp .exit
.f1 lda #16
    bit $dc01
    bne .f2
    jmp .exit
.f2 jmp keyloop    
.exit 
    lda #$1b
    sta $d011
    lda #$14
    sta $d018
    lda #$08
    sta $d016
    lda #$03
    sta $dd00
    lda #0
    sta $d020
    sta $d021
    ldx #$00
.zap    
    lda #0
    sta $d800,x
    sta $d900,x
    sta $da00,x
    sta $dae8,x
    lda reloc,x
    sta $0100,x
    inx
    bne .zap
    lda #$00
    sta $0800
    jmp $0100
    
reloc
    sei
    lda #$34
    sta $01
mv1 ldx #$00
mv2 lda $4800,x
    sta $0801,x
    inx
    bne mv2
    inc $0109
    inc $010c
    lda $0109
    bne mv1
    lda #$37
    sta $01
    cli
    jsr $a659
    jmp $a7ae
    
 
    

    
    *=$2000
    !bin "bin\tasered.kla",,2

    *=$4800
    !bin "tasered.prg",,2