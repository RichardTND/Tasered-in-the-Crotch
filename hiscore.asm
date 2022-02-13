

check_hi_score
;Hi score table routine 

display_hi_scores

            sei
            lda #$81
            sta $dc0d
            sta $dd0d
            lda #$00
            sta $d019
            sta $d01a
            lda #$00
            sta $d011
            ldx #$00
clearsidh   lda #$00
            sta $d400,x
            inx 
            cpx #$18
            bne clearsidh
            
            ldx #$00
clearwholes lda #$20
            sta screen,x
            sta screen+$100,x
            sta screen+$200,x
            sta screen+$2e8,x
            lda #$0f
            sta colour,x
            sta colour+$100,x
            sta colour+$200,x
            sta colour+$2e8,x
            inx
            bne clearwholes
            
            ;Display the hi score list 
            
            ldx #$00
setdisplay
            lda hof,x 
            sta screen+(1*40),x
            eor #$40
            sta screen+(2*40),x 
            lda hof+40,x 
            sta screen+(4*40),x
            eor #$40
            sta screen+(5*40),x 
            lda rank1,x
            sta screen+(8*40),x
            eor #$40
            sta screen+(9*40),x 
            lda rank2,x
            sta screen+(11*40),x
            eor #$40
            sta screen+(12*40),x
            lda rank3,x
            sta screen+(14*40),x
            eor #$40
            sta screen+(15*40),x
            lda rank4,x
            sta screen+(17*40),x
            eor #$40
            sta screen+(18*40),x
            lda rank5,x
            sta screen+(20*40),x
            eor #$40
            sta screen+(21*40),x
            inx
            cpx #$28
            bne setdisplay
            
            lda #$18
            sta $d016
            lda #$12
            sta $d018
            lda #$09
            sta $d022
            lda #$08
            sta $d023
            ldx #<single_irq
            ldy #>single_irq
            lda #$7f
            stx $fffe
            sty $ffff
            sta $dc0d
            sta $dd0d
            lda #$2e
            sta $d012
            lda #$1b
            sta $d011
            lda #0
            sta $d020
            sta $d021
            lda #$01
            sta $d01a
            sta $d019 
            lda #game_music
            jsr music_init
            lda #0
            sta fire_button
            cli
waithiexit            
            lda $dc00
            lsr
            lsr
            lsr
            lsr
            lsr 
            bit fire_button
            ror fire_button 
            bmi waithiexit2
            bvc waithiexit2
            lda #0
            sta fire_button
            jmp titlecode
            
waithiexit2
            lda $dc01
            lsr
            lsr
            lsr
            lsr
            lsr
            bit fire_button
            ror fire_button
            bmi waithiexit
            bvc waithiexit
            lda #0
            sta fire_button
            jmp titlecode
            
single_irq 
            sta hsa+1
            stx hsx+1
            sty hsy+1
            asl $d019
            lda $dc0d
            sta $dd0d
            lda #$fa
            sta $d012
            jsr music_player
            lda #1
            sta rt
hsa         lda #0
hsx         ldx #0
hsy         ldy #0            
            rti