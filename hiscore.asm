;***************************************
;
;        TASERED IN THE CROTCH!
;
;     A fun game by Richard Bayliss
;
;       (C)2022 The New Dimension
;
;***************************************

;HI SCORE DATA

hslo       !byte <hiscore1,<hiscore2,<hiscore3,<hiscore4,<hiscore5
hshi       !byte >hiscore1,>hiscore2,>hiscore3,>hiscore4,>hiscore5
nmlo       !byte <name1,<name2,<name3,<name4,<name5
nmhi       !byte >name1,>name2,>name3,>name4,>name5


check_hi_score

            sei
            lda #$81
            sta $dc0d
            sta $dd0d
            lda #$00
            sta $d019
            sta $d01a
            sta $d015
            lda #$00
            sta $d011
            
            lda #1
            sta letter_char 
            lda #0
            sta name_finished 
            
            ldx #$00
clearsidh   lda #$00
            sta $d400,x
            inx 
            cpx #$18
            bne clearsidh
            ldx #$00
waith1      ldy #$00
waith2      iny 
            bne waith2
            inx
            bne waith1
            
            ldx #$00
next_one    lda hslo,x 
            sta $c1 
            lda hshi,x 
            sta $c2 
            
            ldy #$00
score_get   lda score,y
score_cmp   cmp ($c1),y 
            bcc pos_down 
            beq next_digit
            bcs pos_found 
next_digit  iny 
            cpy #scorelength 
            bne score_get
            beq pos_found 
pos_down    inx 
            cpx #listlength
            bne next_one 
            beq no_hiscore 
pos_found   stx $02 
            cpx #listlength-1
            beq last_score 
            
            ldx #listlength-1
copy_next   lda hslo,x 
            sta $c1
            lda hshi,x 
            sta $c2 
            lda nmlo,x
            sta $d1
            lda nmhi,x
            sta $d2
            dex 
            lda hslo,x
            sta $c3
            lda hshi,x
            sta $c4
            lda nmlo,x
            sta $d3
            lda nmhi,x
            sta $d4
            
            ldy #scorelength-1
copy_score  lda ($c3),y 
            sta ($c1),y 
            dey 
            bpl copy_score 
            
            ldy #namelength+1
copy_name   lda ($d3),y
            sta ($d1),y 
            dey 
            bpl copy_name 
            cpx $02
            bne copy_next
            
last_score  ldx $02
            lda hslo,x
            sta $c1
            lda hshi,x
            sta $c2
            lda nmlo,x
            sta $d1
            lda nmhi,x
            sta $d2 
            jsr make_list
            jmp name_entry 
            
place_new_score
            ldy #scorelength-1
put_score   lda score,y
            sta ($c1),y
            dey 
            bpl put_score 
            
            ldy #namelength-1
put_name    lda name,y
            sta ($d1),y
            dey 
            bpl put_name
           
no_hiscore  jmp display_hi_scores

;Name entry routine

name_entry
              ldx #$00
put_hi_message 
              lda hitext,x
              sta screen+(23*40),x
              eor #$40
              sta screen+(24*40),x 
              inx
              cpx #40
              bne put_hi_message
              
              ;Clear out player name
              
              ldx #$00
clear_name    lda #$20
              sta name,x
              inx
              cpx #9
              bne clear_name 
              
              lda #<name 
              sta namesm+1
              lda #>name 
              sta namesm+2 
              
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
              lda #$01
              sta $d019
              sta $d01a
              lda #$12
              sta $d018
              lda #$18
              sta $d016 
              lda #$0a
              sta $d022
              lda #$07
              sta $d023
              lda #mission_complete_jingle
              jsr music_init
              cli
              
;Main name entry loop routine 
name_entry_loop 
              lda 0
              sta rt
              cmp rt
              beq *-3 
              
              ;Display name on screen
              ldx #$00
show_name     lda name,x 
              sta screen+(23*40)+30,x
              eor #$40
              sta screen+(24*40)+30,x
              inx
              cpx #$09
              bne show_name 
              
              lda name_finished
              bne stop_name_entry
              jsr joycheck 
              jmp name_entry_loop
              
stop_name_entry
                
              jmp place_new_score 
              
;Joystick control name entry check routine

joycheck      lda letter_char
namesm        sta name 
              lda joy_delay 
              cmp #5
              beq joy_hi_ok
              inc joy_delay
              rts 
              
joy_hi_ok     lda #0
              sta joy_delay 
              
              ;Check joystick direction up  
hi_up         lda #1
              bit $dc00
              bne hi_down
              jmp letter_up
hi_down       lda #2
              bit $dc00
              bne hi_fire 
              jmp letter_down
hi_fire       lda $dc00 
              lsr
              lsr
              lsr
              lsr
              lsr
              bit fire_button
              ror fire_button
              bmi no_hi_joy
              bvc no_hi_joy 
              lda #0
              sta fire_button
              lda #<alarm_sfx
              ldy #>alarm_sfx 
              ldx #14
              jsr sfx_play
              jmp char_selected
              
;Letter up (unless spotschar not wanted)

letter_up     inc letter_char 
              lda letter_char
              cmp #29
              beq auto_space 
              cmp #33
              beq a_char 
              rts 
auto_space    lda #32
              sta letter_char 
              rts 
a_char        lda #1
              sta letter_char 
              rts
letter_down   dec letter_char
              lda letter_char
              beq space_char
              lda letter_char 
              cmp #29 
              beq end_char 
              rts
space_char    lda #32
              sta letter_char
              rts
end_char      lda #28
              sta letter_char
no_hi_joy     rts
              
;Char selected, check for delete or 
;end character. Or switch to new char 
;until last position. 

char_selected lda letter_char 
check_delete_char
              cmp #27 
              bne check_end_char 
              lda namesm+1
              cmp #<name 
              beq do_not_go_back
              dec namesm+1
              jsr name_housekeep
do_not_go_back
              rts 
              ;Check end character
check_end_char
              cmp #28
              bne char_is_ok 
              lda #32
              sta letter_char 
              jmp finished_now 
              
char_is_ok    inc namesm+1
              lda namesm+1
              cmp #<name+9
              beq finished_now 
hi_no_fire    rts

finished_now  jsr name_housekeep
              lda #1
              sta name_finished
              rts
              
;Name house keeping. Clear any symbol chars
;from the name_finished

name_housekeep    
              ldx #$00
clearcharsn   lda name,x
              cmp #27
              beq cleanup
              cmp #28
              beq cleanup
              jmp skip_cleanup
cleanup       lda #$20
              sta name,x
skip_cleanup  inx
              cpx #9
              bne clearcharsn
              rts
              
                
              
              
              

  
              
              

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
            lda #$12
            sta $d018
            lda #$18
            sta $d016 
            lda #$0a
            sta $d022
            lda #$07
            sta $d023
            ldx #$00
clearsidh0  lda #$00
            sta $d400,x
            inx 
            cpx #$18
            bne clearsidh0
   
            ldx #$00
wait001     ldy #$00
wait002     iny 
            bne wait002
            inx
            bne wait001
            ;Display the hi score list 
            
            jsr make_list
            
            ldx #$00
setfiretxt  lda hifire,x
            sta screen+(23*40),x
            eor #$40
            sta screen+(24*40),x
            inx
            cpx #$28
            bne setfiretxt
            
            lda #$18
            sta $d016
            lda #$12
            sta $d018
            lda #$0e
            sta $d022
            lda #$03
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
            
;Main hi score list 
make_list            
         
            ldx #$00
clearwholes lda #$20
            sta screen,x
            sta screen+$100,x
            sta screen+$200,x
            sta screen+$2e8,x
            lda #$09
            sta colour,x
            sta colour+$100,x
            sta colour+$200,x
            sta colour+$2e8,x
            inx
            bne clearwholes
            
            ldx #$00
setdisplay
            lda hof,x 
            sta screen+(0*40),x
            eor #$40
            sta screen+(1*40),x 
            lda hof+40,x 
            sta screen+(3*40),x
            eor #$40
            sta screen+(4*40),x 
            lda rank1,x
            sta screen+(7*40),x
            eor #$40
            sta screen+(8*40),x 
            lda rank2,x
            sta screen+(10*40),x
            eor #$40
            sta screen+(11*40),x
            lda rank3,x
            sta screen+(13*40),x
            eor #$40
            sta screen+(14*40),x
            lda rank4,x
            sta screen+(16*40),x
            eor #$40
            sta screen+(17*40),x
            lda rank5,x
            sta screen+(19*40),x
            eor #$40
            sta screen+(20*40),x
            inx
            cpx #$28
            bne setdisplay
            rts

name_finished !byte 0
joy_delay !byte 0
letter_char !byte 0

name !text "richard b"
hiscorestart
!ct scr
rank1      !text "  1. "
name1      !text "richard b"
           !text " ................. "
hiscore1   !text "000000 "
rank2      !text "  2. "
name2      !text "richard b"
           !text " ................. "
hiscore2   !text "000000 "
rank3      !text "  3. "
name3      !text "richard b"
           !text " ................. "
hiscore3   !text "000000 "
rank4      !text "  4. "
name4      !text "richard b"
           !text " ................. "
hiscore4   !text "000000 "
rank5      !text "  5. "
name5      !text "richard b"
           !text " ................. "
hiscore5   !text "000000 "
hiscoreend

          ;!text "0123456789012345678901234567890123456789"
hof        !text "         tasered in the crotch          "
           !text "       top five chief commanders        "

hitext     !text "please enter your name:                 "
hifire     !text "press space bar or fire for title screen"
          
