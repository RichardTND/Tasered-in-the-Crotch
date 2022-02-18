;***************************************
;
;        TASERED IN THE CROTCH!
;
;     A fun game by Richard Bayliss
;
;       (C)2022 The New Dimension
;
;***************************************

;TITLE SCREEN CODE

titlecode           sei
                      
                    ;Clear out existing IRQ interrupts
                    lda #$81
                    sta $dc0d
                    sta $dd0d
                    lda #$00
                    sta $d019
                    sta $d01a
                    sta $d021
                    lda #0
                    sta $d020
                    
                    sta fire_button
                    lda #$0b
                    sta $d011
                    
                    ldx #$00
tsidout             lda #$00
                    sta $d400,x
                    inx
                    cpx #$18
                    bne tsidout 
                    
                    ldx #$00
tloop               ldy #$00
                    iny
                    bne *-1
                    inx
                    bne tloop
                
                    lda #<scrolltext
                    sta readscr+1
                    lda #>scrolltext
                    sta readscr+2
;Silence SID chip
                    
                    ldx #$00
silence_sid_ts      lda #$00
                    sta $d400,x
                    inx
                    cpx #$18
                    bne silence_sid_ts
                    
;Initialise the hardware settings
                    
                    lda #$00
                    sta $d015
                    sta $d01c
                    lda #2
                    sta $d020
                    
                    lda #$02
                    sta $d022
                    lda #$07
                    sta $d023
                    lda #$18
                    sta $d016
                    lda #$1e
                    sta $d018
                    
;Draw title screen graphics to screen and colour RAM

                    ldx #$00
draw_title          lda title_screen,x
                    sta $0400,x
                    lda title_screen+$100,x
                    sta $0500,x
                    lda title_screen+$200,x
                    sta $0600,x
                    lda title_screen+$2e8,x
                    sta $06e8,x
                    
                    ldy title_screen,x 
                    lda title_attribs,y
                    sta $d800,x
                    ldy title_screen+$100,x
                    lda title_attribs,y 
                    sta $d900,x
                    ldy title_screen+$200,x
                    lda title_attribs,y
                    sta $da00,x
                    ldy title_screen+$2e8,x
                    lda title_attribs,y
                    sta $dae8,x 
                    inx
                    bne draw_title
                    
                    lda #$02
                    sta $d001
                    sta $d003
                    sta $d005
                    sta $d007
                    sta $d009
                    sta $d00b
                    sta $d00d
                    
                    ldx #$00
.wipeArea           lda #$00
                    sta $0d00,x
                    sta $0e00,x
                    inx
                    bne .wipeArea
                    
                    ldx #$00
white               lda #$01
                    sta $d027,x
                    inx
                    cpx #$08
                    bne white
                     ldx #$34
            stx $07f8
            inx
            stx $07f9
            inx
            stx $07fa
            inx 
            stx $07fb
            inx
            stx $07fc
            inx
            stx $07fd
            inx
            stx $07fe
            inx
            stx $07ff
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
                    
                    
                    
                    
                    
;Initialise title screen IRQ

                    ldx #<title_irq
                    ldy #>title_irq
                    lda #$7f
                    stx $fffe
                    sty $ffff
                    sta $dc0d
                    sta $dd0d
                    ldx #<nmi
                    ldy #>nmi
                    stx $fffa
                    sty $fffb
                    
                    lda #$2e
                    sta $d012
                    lda #$1b
                    sta $d011
                    lda #$01
                    sta $d01a
                    sta $d019
                    lda #title_music
                    jsr music_init
                    cli
                    jmp title_loop

;Main title IRQ         
                    
title_irq       
         sta .tsa+1
         stx .tsx+1
         sty .tsy+1
         asl $d019
         lda $dc0d
         sta $dd0d
         lda #$3a
         cmp $d012 
         bne *-3
         lda #$02
         sta $d022
         lda #$07
         sta $d023
        
         lda #$8c
         cmp $d012
         bne *-3
         lda #$0b
         sta $d022
         lda #$01
         sta $d023
         lda #$fa
         cmp $d012
         bne *-3
         lda #$03
         sta $d011
         lda #$fc
         cmp $d012
         bne *-3
         lda #$1b
         sta $d011
         jsr music_player
         jsr title_loop
.tsa     lda #0
.tsx     ldx #0
.tsy     ldy #0
         rti
;Main title screen loop
title_loop          jsr sprite_scroll
                    
                    lda $dc00
                    lsr
                    lsr
                    lsr
                    lsr
                    lsr
                    bit fire_button
                    ror fire_button
                    bmi t_jp1
                    bvc t_jp1
                    jmp game_start
                    
t_jp1               lda $dc01
                    lsr
                    lsr
                    lsr
                    lsr
                    lsr
                    bit fire_button
                    ror fire_button
                    bmi t_jp2
                    bvc t_jp2
                    jmp display_hi_scores
                    
t_jp2               rts               

;The sprite scroll, masked from the scroll routine

sprite_scroll       jsr flashallsprites
                    inc sprp 
                    lda sprp
                    cmp #$08 
                    bne roll_sprites
                    lda #$00
                    sta sprp 
                    jsr char_read 
roll_sprites        ldx #$00
move_text_spr       clc 
                    rol $0ec2,x
                    rol $0ec1,x
                    rol $0ec0,x
                    rol $0e82,x
                    rol $0e81,x
                    rol $0e80,x
                    rol $0e42,x
                    rol $0e41,x
                    rol $0e40,x 
                    rol $0e02,x
                    rol $0e01,x
                    rol $0e00,x
                    rol $0dc2,x
                    rol $0dc1,x
                    rol $0dc0,x 
                    rol $0d82,x
                    rol $0d81,x
                    rol $0d80,x
                    rol $0d42,x
                    rol $0d41,x
                    rol $0d40,x
                    rol $0d02,x
                    rol $0d01,x
                    rol $0d00,x
                    inx
                    inx
                    inx
                    cpx #$18
                    bne move_text_spr
                    rts
char_read           inc readscr+1
                    lda readscr+1
                    bne readscr
                    inc readscr+2
readscr             lda $d000
                    bne upper 
                    lda #<scrolltext
                    sta readscr+1
                    lda #>scrolltext
                    sta readscr+2
                    jmp readscr 
upper               cmp #$20
                    bpl lower
                    asl
                    asl
                    asl
                    tax
                    lda $3800,x
                    sta $0ec2
                    lda $3801,x
                    sta $0ec5
                    lda $3802,x
                    sta $0ec8
                    lda $3803,x
                    sta $0ecb
                    lda $3804,x
                    sta $0ece
                    lda $3805,x
                    sta $0ed1
                    lda $3806,x
                    sta $0ed4
                    lda $3807,x
                    sta $0ed7
                    rts 
lower               sbc #$20                    
                    asl
                    asl
                    asl
                    tax 
                    lda $3900,x
                    sta $0ec2
                    lda $3901,x
                    sta $0ec5
                    lda $3902,x
                    sta $0ec8
                    lda $3903,x
                    sta $0ecb
                    lda $3904,x
                    sta $0ece
                    lda $3905,x
                    sta $0ed1
                    lda $3906,x
                    sta $0ed4
                    lda $3907,x
                    sta $0ed7
                    rts
;Flashing sprite colours 

flashallsprites     lda tflashdelay
                    cmp #3
                    beq tflashok
                    inc tflashdelay 
                    rts 
tflashok            lda #0
                    sta tflashdelay
                    ldx tflashpointer
                    lda tflashcolour,x
                    sta $d027
                    sta $d028
                    sta $d029
                    sta $d02a
                    sta $d02b
                    sta $d02c
                    sta $d02d
                    sta $d02e
                    ldy #$00
.loop_t                    
                    lda gflashcolour,x
                    sta $daf8,y
                    lda gflashcolour2,x 
                    sta $daf8-80,y
                    lda $d9e0,y 
                    eor #6
                    sta $d9e0,y
                    iny
                    cpy #40
                    bne .loop_t
                    
                    inx 
                    cpx #tflashcolourend-tflashcolour
                    beq resettflash
                    inc tflashpointer
                    rts
resettflash         ldx #0
                    stx tflashpointer
                    rts 
                    
sprp                !byte 0
tflashdelay !byte 0
tflashpointer !byte 0
tflashcolour !byte $09,$02,$08,$0a,$07,$01,$07,$0a,$08,$02,$09
             !byte $06,$04,$0e,$03,$0d,$01,$0d,$03,$0e,$04,$06
tflashcolourend             
gflashcolour !byte $01,$07,$04,$02,$02,$02,$02,$02,$02,$04,$07
             !byte $01,$03,$05,$06,$06,$06,$06,$06,$06,$05,$03
gflashcolour2             
             !byte $01,$03,$05,$06,$06,$06,$06,$06,$06,$05,$03
             !byte $01,$07,$04,$02,$02,$02,$02,$02,$02,$04,$07
                    !align $ff,$00
                    !ct scr
scrolltext          !text "          ,,, tasered in the crotch ,,,    code, design and music by richard bayliss ,,,   graphics and design by alf yngve ,,,   "
                    !byte $1e,$20,$30,$2e,$30,$30 
                    !text " the new dimension ,,,   "
                    !text "this game is played using a joystick in port 0 ,,,   "
                    !text "you are chief commander supt, tracey cisco ,,,   "
                    !text "you and a team of the best officers have been sent "
                    !text "to various destinations where crime scenes are taking place ,,,   "
                    !text "your team are armed with the state of the art detatchable "
                    !text "wireless tasers ,,,   your mission is to command the officers "
                    !text "to fire their tasers at the robbers and arrest them ,,,   you will "
                    !text "have a set quota before your mission is complete ,,,   your job will also "
                    !text "be to protect and serve the civilians and most definitely not taser them ,,,   robbers will also "
                    !text "attempt to distract your officers by taking out a smoke bomb and attempt to throw them at members of the squad ,,,   "
                    !text "lives are lost if you "
                    !text "taser a civilian or a smoke bomb hits one of your officers ,,,   "
                    !text "the game is over if you let too many robbers escape or you lose "
                    !text "all of your lives ,,,   i hope you have fun playing this game ,,,   "
                    !text "press fire to play ,,,                                              "
                    
                    !text "                                    "
                    
                    !byte 0
                  
                    
                    
                    
                    
                    
                    
                    