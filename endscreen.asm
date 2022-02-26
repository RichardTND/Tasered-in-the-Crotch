;***************************************
;
;        TASERED IN THE CROTCH!
;
;     A fun game by Richard Bayliss
;
;       (C)2022 The New Dimension
;
;***************************************

;--------------------------------------------------------

         ;Switch off all interrupts, just like 
         ;with the game, hi score table, etc.
endscreen         
                    sei
                      
            
                    ;Clear out existing IRQ interrupts
                    lda #$81
                    sta $dc0d
                    sta $dd0d
                    lda #$00
                    sta $d019
                    sta $d01a
                    sta fire_button
                    lda #$0b
                    sta $d011
                    lda #$1e
                    sta $d018
                    
                    ;Clear SID
                    ldx #$00
silenceend          lda #$00
                    sta $d400,x
                    inx
                    cpx #$18
                    bne silenceend 
                    lda #0
                    sta $d020
                    sta $d021
                    ;Temporary delay
                    
                    ldx #$00
endd1               ldy #$00
endd2               iny 
                    bne endd2
                    inx 
                    bne endd1
                    
                    lda #0
                    sta swingpointer
                    sta swingpointer2
                    sta swingstore
                    sta swingstore2
                    sta ypos
                    sta charbit
                    
                    lda #<endscroll
                    sta messread2+1
                    lda #>endscroll
                    sta messread2+2
                    ;Fully clear the entire screen 
                    
                    ldx #$00
full_clear          lda #$00
                    sta $0400,x
                    sta $0500,x
                    sta $0600,x
                    sta $06e8,x
                    lda #$0f
                    sta $d800,x
                    sta $d900,x
                    sta $da00,x
                    sta $dae8,x
                    inx
                    bne full_clear
                    
getlogoattribs      ldx #$00
getloop             lda #$08
                    sta $d800,x
                    sta $d800+(1*40),x
                    sta $d800+(2*40),x
                    sta $d800+(3*40),x
                    sta $d800+(4*40),x
                    sta $d800+(5*50),x
                    sta $d800+(6*40),x
                    sta $d800+(7*40),x
                    sta $d800+(8*40),x
                    sta $d800+(9*40),x 
                    sta $d800+(10*40),x
                    sta $d800+(11*40),x
                    lda #0
                    sta $d800+(12*40),x
                   
                    inx
                    cpx #40
                    bne getloop
                    
                    ;Setup sprites 
                    
                    ldx #$00
square              lda #$30
                    sta $07f8,x
                    lda #0
                    sta $d027,x
                    inx
                    cpx #$08
                    bne square
                    
        
                    lda #$18
                    sta $d000
                    adc #$2f 
                    sta $d002
                    adc #$30
                    sta $d004
                    adc #$30
                    sta $d006
                    adc #$30
                    sta $d008
                    adc #$30
                    sta $d00a
                    adc #$2f
                    sta $d00c 
                    adc #$2f
                    sta $d00e
                    lda #%1111111
                    sta $d015 
                    sta $d01d
                    lda #0
                    sta $d017
                    sta $d01b 
                    lda #%11100000
                    sta $d010
                    lda #$8e
                    sta $d001
                    sta $d003
                    sta $d005
                    sta $d007
                    sta $d009
                    sta $d00b
                    sta $d00d
                    
                    lda #$02
                    sta $d022
                    lda #$07
                    sta $d023
                    
                    
                    
                    ;Setup IRQ raster interrupts for end screen 
                    
                    ldx #<endirq1
                    ldy #>endirq1
                    lda #$7f
                    stx $fffe
                    sty $ffff
                    sta $dc0d
                    sta $dd0d
                    lda #$36
                    sta $d012
                    lda #$1b
                    sta $d011
                    lda #0
                    sta $d020
                    sta $d021
                    lda #$01
                    sta $d019
                    sta $d01a
                    
                    ;Initialise end music 
                    lda #$00
                    jsr end_music_init
                    cli
                    jmp end_screen_loop
       
                    ;IRQ position 1
                    
endirq1             sta esa1+1       
                    stx esx1+1
                    sty esy1+1
                  
                    asl $d019
                    lda $dc0d
                    sta $dd0d
                    lda #$37
                    sta $d012
                   
                    lda #$70
                    ldx #$08
                    ldy #$12
                    sta $d011
                    stx $d016
                    sty $d018
                   
               ;   
                    ldx #<endirq2
                    ldy #>endirq2
                    stx $fffe
                    sty $ffff
esa1                lda #$00 
esx1                ldx #$00
esy1                ldy #$00
                    rti 
       
                    ;IRQ position 2
                    
endirq2             sta esa2+1
                    stx esx2+1
                    sty esy2+1
                    asl $d019
                    lda #$5f
                    sta $d012
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    
                    lda #$10
                    ldx swingstore
                    ldy #$1e
                    sta $d011
                    stx $d016
                    sty $d018
                    ldx #$02
                    ldy #$07
                    stx $d022
                    sty $d023
              ;      lda #1
              ;      sta $d020
                    ldx #<endirq3
                    ldy #>endirq3
                    stx $fffe
                    sty $ffff
esa2                lda #$00
esx2                ldx #$00
esy2                ldy #$00
                    rti
                    
                    ;IRQ position 3
                    
endirq3             sta esa3+1
                    stx esx3+1
                    sty esy3+1
                    asl $d019
                    lda #$8e
                    sta $d012
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    
                    ldx swingstore2
                    stx $d016
              ;      lda #2
              ;      sta $d020
                    ldx #<endirq4
                    ldy #>endirq4
                    stx $fffe
                    sty $ffff
esa3                lda #$00
esx3                ldx #$00
esy3                ldy #$00
                    rti 
                    
                    ;Irq position 4
endirq4             sta esa4+1
                    stx esx4+1
                    sty esy4+1
                    asl $d019
                    lda #$9a
                    sta $d012
                    
                    lda #$70
                    ldx #$18
                    ldy #$14
                    sta $d011
                    stx $d016
                    sty $d018
                    
                    ldx #$09
                    ldy #$08
                    stx $d022
                    sty $d023
             ;       lda #3
             ;       sta $d020
                    
                    ldx #<endirq5
                    ldy #>endirq5
                    stx $fffe
                    sty $ffff
esa4                lda #$00
esx4                ldx #$00
esy4                ldy #$00
                    rti
                    
                    ;Irq position 5
                    
endirq5             sta esa5+1
                    stx esx5+1
                    sty esy5+1
                    asl $d019
                    lda #$f2
                    sta $d012
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    
                    lda ypos
                    ora #$10
                    sta $d011
                    ldx #$18
                    ldy #$12
                    stx $d016
                    sty $d018
                    ldx #$09
                    ldy #$08
                    stx $d022
                    sty $d023
              ;      lda #4
             ;       sta $d020
                   
                    ldx #<endirq6
                    ldy #>endirq6
                    stx $fffe
                    sty $ffff
esa5                lda #$00
esx5                ldx #$00
esy5                ldy #$00
                    rti
                    
                    ;irq6 
endirq6             sta esa6+1
                    stx esx6+1
                    sty esy6+1
                    asl $d019 
                    lda #$fa
                    sta $d012
                    lda #$7b
                    ldx #$18
                    ldy #$14
                    sta $d011
                    stx $d016
                    sty $d018
                    lda #2
                    sta $d022
                    lda #7
                    sta $d023
                  ;  lda #5
                  ;  sta $d020
                    lda #1
                    sta rt
                    jsr end_music_player
                    ldx #<endirq1
                    ldy #>endirq1
                    stx $fffe
                    sty $ffff
esa6                lda #$00
esx6                ldx #$00
esy6                ldy #$00
                    rti
                    
end_music_player    lda system
                    bne end_pal
                    inc ntsc_timer
                    lda ntsc_timer
                    cmp #6
                    beq end_reset_timer
end_pal             jsr end_music_play
                    rts
end_reset_timer     lda #0
                    sta ntsc_timer
                    rts

end_screen_loop 
                    lda #0
                    sta rt 
                    cmp rt 
                    beq *-3
                    jsr swing1
                    jsr swing2
                    jsr upscroll
                   ; jsr getattribs
                    lda $dc00
                    lsr
                    lsr
                    lsr
                    lsr
                    lsr
                    bit fire_button
                    ror fire_button
                    bmi end_spc
                    
                    jmp continue_playing_game 
end_spc             lda $dc01
                    lsr
                    lsr
                    lsr
                    lsr
                    lsr
                    bit fire_button
                    ror fire_button 
                    bmi end_screen_loop
                    bvc end_screen_loop
                    
                    jmp check_hi_score
                    
swing1              lda #$ff
                    sec
                    ldx swingpointer 
                    sbc SINUS,x 
                    lsr
                    lsr
                    lsr
                    tax
                    ldy #$00
swingscreen         ;lda end_logo_matrix,x
                    ;sta $0400,y
                    lda end_logo_matrix,x
                    sta $0400+(1*40),y 
                    lda end_logo_matrix+(1*80),x
                    sta $0400+(2*40),y
                    lda end_logo_matrix+(2*80),x
                    sta $0400+(3*40),y
                    lda end_logo_matrix+(3*80),x
                    sta $0400+(4*40),y
                    lda end_logo_matrix+(4*80),x
                    sta $0400+(5*40),y
                    inx
                    iny
                    cpy #$28
                    bne swingscreen
                    ldx swingpointer
                    lda SINUS,x 
                    and #$07
                    ora #$10
                    sta swingstore
                    inc swingpointer
                    rts
                    
swing2              lda #$ff
                    sec
                    ldx swingpointer2
                    sbc SINUS,x 
                    lsr
                    lsr
                    lsr
                    tax
                    ldy #$00
swingscreen2       
                    lda end_logo_matrix+(5*80),x
                    sta $0400+(6*40),y
                    lda end_logo_matrix+(6*80),x
                    sta $0400+(7*40),y
                    lda end_logo_matrix+(7*80),x
                    sta $0400+(8*40),y
                    lda end_logo_matrix+(8*80),x
                    sta $0400+(9*40),y
                    lda end_logo_matrix+(9*80),x
                    sta $0400+(10*40),y
                    lda end_logo_matrix+(10*64),x
                    sta $0400,y
                    
                    inx
                    iny
                    cpy #$28
                    bne swingscreen2
                    ldx swingpointer2
                    lda SINUS,x
                    and #$07
                    ora #$10
                    sta swingstore2
                    dec swingpointer2
                    rts
                    
;1x2 charset text upscroll routine
skipshift           rts
upscroll            lda ydelay
                    cmp #2
                    beq scrollit
                    inc ydelay
                    rts
scrollit            lda #0
                    sta ydelay 
                    lda ypos
                    sec
                    sbc #1
                    and #$07
                    sta ypos
                    bcs skipshift 
                    ora #$10
                    sta ypos2
                    ldx #$27
shiftrows           lda $0400+(13*40),x
                    sta $0400+(12*40),x
                    lda $0400+(14*40),x
                    sta $0400+(13*40),x
                    lda $0400+(15*40),x
                    sta $0400+(14*40),x
                    lda $0400+(16*40),x
                    sta $0400+(15*40),x
                    lda $0400+(17*40),x
                    sta $0400+(16*40),x
                    lda $0400+(18*40),x
                    sta $0400+(17*40),x
                    lda $0400+(19*40),x
                    sta $0400+(18*40),x
                    lda $0400+(20*40),x
                    sta $0400+(19*40),x
                    lda $0400+(21*40),x
                    sta $0400+(20*40),x
                    lda $0400+(22*40),x
                    sta $0400+(21*40),x
                    lda $0400+(23*40),x
                    sta $0400+(22*40),x
                    lda $0400+(24*40),x
                    sta $0400+(23*40),x
                    dex
                    bpl shiftrows
                    ldx #$00
messread2           lda endscroll,x
                    sta ystore,x
                    cmp #$00
                    beq wraptext
                    inx
                    cpx #40
                    bne messread2
                    jmp endstore
wraptext            lda #<endscroll
                    sta messread2+1
                    lda #>endscroll
                    sta messread2+2
                    jmp messread2
endstore            lda charbit 
                    cmp #1
                    beq lowerend
                    cmp #2
                    beq spaceend
                    
upperend            ldx #$00
upperloop           lda ystore,x
                    sta $0400+(24*40),x
                    inx
                    cpx #$28
                    bne upperloop
                    lda #1
                    sta charbit
                    rts
lowerend            ldx #$00
lowerloop           lda ystore,x
                    eor #$40
                    sta $0400+(24*40),x
                    inx
                    cpx #$28
                    bne lowerloop
                    lda #2
                    sta charbit
                    rts
spaceend            ldx #$00
spaceloop           lda #$20
                    sta $0400+(24*40),x
                    inx
                    cpx #$28
                    bne spaceloop
                    lda #0
                    sta charbit
                    lda messread2+1
                    clc
                    adc #$28
                    sta messread2+1
                    lda messread2+2
                    adc #$00
                    sta messread2+2
                    bcs skip
skip                rts

continue_playing_game
                    lda #0
                    sta fire_button
                    sei
                    lda #$81
                    sta $dc0d
                    sta $dd0d
                    lda #$00
                    sta $d019
                    sta $d01a
                    lda #$0b
                    sta $d011
                    ldx #$00
sidout4             lda #$00
                    sta $d400,x
                    inx
                    cpx #$18
                    bne sidout4
                    ldx #$00
outend1             ldy #$00
outend2             iny
                    bne outend2
                    inx
                    bne outend1
                    jmp restart_from_ending
                    
                    

                    
swingpointer !byte 0
swingpointer2 !byte 0
swingstore !byte 0
swingstore2 !byte 0         
ydelay !byte 0   
ypos !byte 0
ypos2 !byte 0
charbit !byte 0
!align $ff,0
ystore !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20      
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    
                    
                    
!align $ff,0
SINUS !byte 128,134,140,146,152,158
      !byte 165,170,176,182,188,193
      !byte 198,203,208,213,218,222
      !byte 226,230,234,237,240,243
      !byte 245,248,250,251,253,254
      !byte 254,255,255,255,254,254
      !byte 253,251,250,248,245,243
      !byte 240,237,234,230,226,222
      !byte 218,213,208,203,198,193
      !byte 188,182,176,170,165,158
      !byte 152,146,140,134,127,121
      !byte 115,109,103,97,90,85
      !byte 79,73,67,62,57,52
      !byte 47,42,37,33,29,25
      !byte 21,18,15,12,10,7
      !byte 5,4,2,1,1,0
      !byte 0,0,1,1,2,4
      !byte 5,7,10,12,15,18
      !byte 21,25,29,33,37,42
      !byte 47,52,57,62,67,73
      !byte 79,85,90,97,103,109
      !byte 115,121,128,134,140,146
      !byte 152,158,165,170,176,182
      !byte 188,193,198,203,208,213
      !byte 218,222,226,230,234,237
      !byte 240,243,245,248,250,251
      !byte 253,254,254,255,255,255
      !byte 254,254,253,251,250,248
      !byte 245,243,240,237,234,230
      !byte 226,222,218,213,208,203
      !byte 198,193,188,182,176,170
      !byte 165,158,152,146,140,134
      !byte 127,121,115,109,103,97
      !byte 90,85,79,73,67,62
      !byte 57,52,47,42,37,33
      !byte 29,25,21,18,15,12
      !byte 10,7,5,4,2,1
      !byte 1,0,0,0,1,1
      !byte 2,4,5,7,10,12
      !byte 15,18,21,25,29,33
      !byte 37,42,47,52,57,62
      !byte 67,73,79,85,90,97
      !byte 103,109,115,121                   
                    
         
;--------------------------------------------------------
         *=$e000 
         !ct scr
         
endscroll !scr "congratulations tracey cisco,           "
          !scr "                                        "
          !scr "you and your team of fearless officers  "
          !scr "have successfully completed all of your "
          !scr "assignments.                            "
          !scr "                                        " 
          !scr "the chief crime commissioner is very    "
          !scr "pleased with all of the hard work which "
          !scr "you and your team have done.            "
          !scr "                                        "
          !scr "the chief crime commisioner has decided "
          !scr "to take early retirement, and has now   "
          !scr "promoted you to his position.           "
          !scr "                                        "
          !scr "congratulations!                        "
          !scr "                                        "
          !scr "as for those dirty criminal scumbags,   "
          !scr "they have been ordered very long term   "
          !scr "jail sentences. to put it another way,  "
          !scr "they get what they deserve ...          "
          !scr "                                        "
          !scr "you have been playing:                  "
          !scr "                                        "
          !scr "         tasered in the crotch!         "
          !scr "                                        "
          !scr "   a silly game inspired by commodore   "
          !scr "      format's funny twitter poll       "
          !scr "                                        "
          !scr "  code, game design, gfx and sound by   "
          !scr "          - richard bayliss -           "
          !scr "                                        "
          !scr "loading bitmap and title screen logo by "
          !scr "             - alf yngve -              "
          !scr "                                        "
          !scr " tape loading system source provided by "
          !scr "            - martin piper -            "
          !scr "(that is if you played the tape version)"
          !scr "                                        "
          !scr "  copyright (c) 2022 the new dimension  "
          !scr "                                        "
          !scr "               - warning -              "
          !scr "                                        "
          !scr "tasered in the crotch was downloaded for"
          !scr "free from - the new dimension - and     "
          !scr "richard.tnd.itch-io.                    "
          !scr "                                        "
          !scr "this production is freeware, which means"
          !scr "you are welcome to copy, improve, modify"
          !scr "this production. however you are not    "
          !scr "allowed to sell any part of this        "
          !scr "production in digital or physical form  "
          !scr "without written permission from the game"
          !scr "author.                                 "
          !scr "                                        "
          !scr "if anyone would like to make a cool     "
          !scr "sequel to this production, please feel  "
          !scr "free to do so, as long you credit the   "
          !scr "author for the original game idea.      "
          !scr "                                        " 
          !scr "press fire to play on with current score"
          !scr "and lives, or press spacebar to exit.   "
          !scr "                                        " 
          !scr "                                        " 
          !scr "                                        " 
          !scr "                                        " 
          !byte 0
          

;--------------------------------------------------------          
          ;Import end logo matrix
          *=$ec00
end_logo_matrix
          
          !bin"bin\end_logo_matrix.bin"

;--------------------------------------------------------          