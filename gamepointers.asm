;***************************************
;
;        TASERED IN THE CROTCH!
;
;     A fun game by Richard Bayliss
;
;       (C)2022 The New Dimension
;
;***************************************

;GAME POINTERS
                
fire_button !byte 0
;Raster timer, to sync with subroutines
rt              !byte 0
;C64 system ID PAL/NTSC
system          !byte 0
;NTSC timer for IRQ music player
ntsc_timer      !byte 0

;Game level pointer 
level_pointer !byte 0

;-----------------------------------
pointers

;Selector data 
select_delay !byte 0
select_pointer !byte 0
taser_x_store !byte 0
taser_launched !byte 0
;Sprite animation pointers
sprite_anim_delay1 !byte 0
sprite_anim_delay2 !byte 0
sprite_anim_delay3 !byte 0
sprite_anim_delay4 !byte 0
sprite_anim_pointer3 !byte 0
sprite_anim_pointer4 !byte 0
arrow_anim_pointer !byte 0
taser_anim_pointer !byte 0
enemy_anim_pointer !byte 0


enemy1_badenemy !byte 0
enemy2_badenemy !byte 0
enemy3_badenemy !byte 0
enemy4_badenemy !byte 0
enemy5_badenemy !byte 0


enemy1_scoretype !byte 0
enemy2_scoretype !byte 0
enemy3_scoretype !byte 0
enemy4_scoretype !byte 0
enemy5_scoretype !byte 0
enemy_set_pointer !byte 0

enemy1_drag_enabled !byte 0
enemy2_drag_enabled !byte 0
enemy3_drag_enabled !byte 0
enemy4_drag_enabled !byte 0
enemy5_drag_enabled !byte 0

enemy1_drag_speed !byte 0
enemy2_drag_speed !byte 0
enemy3_drag_speed !byte 0
enemy4_drag_speed !byte 0
enemy5_drag_speed !byte 0

enemy1_drag_speed_limit !byte 0
enemy2_drag_speed_limit !byte 0
enemy3_drag_speed_limit !byte 0
enemy4_drag_speed_limit !byte 0
enemy5_drag_speed_limit !byte 0

randompointer !byte 0
randx       !byte 0


enemy1_dir !byte 0
enemy2_dir !byte 1
enemy3_dir !byte 0
enemy4_dir !byte 1
enemy5_dir !byte 0



bomb_released !byte 0
bomb_exploding !byte 0

enemy1_speed !byte 1
enemy2_speed !byte 1
enemy3_speed !byte 1
enemy4_speed !byte 1
enemy5_speed !byte 1


taser_dead !byte 0
taser_anim_store !byte 0
siren_flash_pointer !byte 0

pointersend


             !ct scr
level_text   !text "level "
level_no     !text "01"


;----------------------------------

bomb_select_pointer !byte $00
bomb_x_spawn_position !byte $44
bomb_y_spawn_position !byte $94

;Sprite object pointers 

arrow_object !byte $96 ;Arrow animation default
taser_object !byte $80 ;Taser animation default
villain_object1 !byte $83 ;Custom villain 1 animation store pointer
villain_object2 !byte $85 ;Custom villain 2 animation store pointer
villain_object3 !byte $87 ;Custom villain 3 animation store pointer
civilian_object1 !byte $89 ;Custom civilian 1 animation store pointer
civilian_object2 !byte $8b ;Custom civilian 2 animation store pointer
civilian_object3 !byte $8d ;Custom civilian 3 animation store pointer
bomb_object !byte $8f      ;Custom bomb animation store pointer

;Game start position (All tasers and enemies removed from screen)
;only arrow should be available.

;Possible X swap positions for picking police to fire tasers 

;Arrow
; $18 ... $2c ... $40 ... $54 ... $68 ... $7c ... $90 

;Taser
; $20 ... $34 ... $48 ... $5c ... $70 ... $84 ... $98

arrow_select_table !byte $18,$2c,$40,$54,$68,$7c,$90
arrow_select_table_end  !byte 0                 
taser_select_table !byte $20,$34,$48,$5c,$70,$84,$98

bombx_select_table ;!byte $20,$34,$48,$5c,$70,$84

                   !byte $84,$34,$5c,$70,$48,$20,$84,$70,$34,$84
                   !byte $70,$34,$5c,$84,$20,$84,$70,$48,$5c,$70
                   !byte $5c,$70,$84,$98,$20,$34,$48,$5c,$70,$84
                   !byte $34,$48,$5c,$84,$7c,$34,$20,$48,$70,$20
                   !byte $5c,$84,$70,$48,$34,$20,$70,$84,$34,$20
                   
                   !byte $70,$34,$5c,$84,$20,$84,$70,$48,$5c,$70
                   !byte $5c,$70,$84,$98,$20,$34,$48,$5c,$70,$84
                   !byte $70,$34,$5c,$84,$20,$84,$70,$48,$5c,$70
                   !byte $5c,$70,$84,$98,$20,$34,$48,$5c,$70,$84
                   !byte $34,$48,$5c,$84,$7c,$34,$20,$48,$70,$20
                   
bomby_select_table                    
                   !byte $44,$6c,$94,$6c,$44,$94,$6c,$94,$44,$6c
                   !byte $94,$6c,$44,$94,$6c,$44,$6c,$94,$44,$44
                   !byte $94,$44,$6c,$94,$6c,$44,$94,$6c,$44,$44
                   !byte $6c,$6c,$94,$44,$94,$6c,$44,$9c,$44,$6c
                   !byte $94,$44,$6c,$44,$6c,$94,$44,$6c,$44,$44
                   
                   !byte $44,$94,$6c,$44,$94,$6c,$44,$94,$6c,$44
                   !byte $6c,$44,$94,$44,$6c,$44,$94,$6c,$44,$44
                   !byte $6c,$94,$44,$6c,$44,$94,$6c,$6c,$94,$94
                   !byte $44,$6c,$44,$44,$94,$6c,$44,$6c,$94,$6c
                   !byte $94,$44,$6c,$44,$94,$94,$94,$44,$6c,$44
                   

;Possibile Y position for enemies
;$44, $6c, $94

starttable      !byte $18,$a8
                !byte $20,$b8
                !byte $60,$00
                !byte $90,$00
                !byte $b0,$00
                !byte $e0,$00
                !byte $20,$00
                !byte $00,$00
                
;Object position table (Player)
objpos          
                !byte $00,$00 ;Arrow 
                !byte $00,$00 ;Taser 
                !byte $00,$00 ;Enemy 1
                !byte $00,$00 ;Enemy 2
                !byte $00,$00 ;Enemy 3
                !byte $00,$00 ;Enemy 4
                !byte $00,$00 ;Enemy 5           
                !byte $00,$00 ;Enemy bomb (dropped to kill civilian)
    
;Collision table 
collision_table
                !byte $00,$00,$00,$00,$00,$00,$00,$00
;Taser (which is fired by selected police person)
taser_anim      !byte $80,$81,$82
taser_animlength

;Villain 1 (Male)
villain1_anim   !byte $83,$84
;Villain 2 (Female)
villain2_anim   !byte $85,$86
;Villain 3 (Old man)
villain3_anim   !byte $87,$88
;Innocent civillian (Male)
civilian1_anim !byte $89,$8a 
;Innocent civillian (Female dark hair)
civilian2_anim !byte $8b,$8c 
;Innocent civilian (Female blonde )
civilian3_anim !byte $8d,$8e
;Bomb 
bomb_anim       !byte $8f,$90
;Victim tasered in the crotch - 100 points bonus
tasered100_anim !byte $91,$92,$91,$92,$91,$92,$91,$92,$93,$93,$93,$93 
taseredlength
;Victim tasered in the crotch - 200 points bonus
tasered200_anim !byte $91,$92,$91,$92,$91,$92,$91,$92,$94,$94,$94,$94
;Victim tasered in the crotch - 500 points bonus
tasered500_anim !byte $91,$92,$91,$92,$91,$92,$91,$92,$95,$95,$95,$95
;Victim tasered in the crotch - civillian (no bonus)
taseredbad_anim !byte $91,$92,$91,$92,$91,$92,$91,$92,$91,$92,$91,$92
;Arrow animation 
arrow_anim      !byte $96,$97,$98,$97,$99
arrow_animlength
;Explosion animation 
exploder_anim   !byte $9a,$9b,$9c,$9d,$9e,$9f
exploder_animlength


;Sound effects

taser_fire_sfx   !byte $0A,$AA,$88,$A4,$41,$B4,$B2,$b0,$ae,$ac,$aa,$11,$00
scream1_sfx      !byte $0A,$88,$11,$BC,$41,$BB,$BA,$BB,$BA,$BB,$BA,$BB,$B9,$B8,$B9,$B8
                 !byte $B7,$B6,$B7,$B6,$B5,$B4,$B5,$B4,$B5,$B4,$B3,$B2,$B3,$B2,$B1,$B0
                 !byte $91,$11,$00 
         
scream2_sfx      !byte $0A,$88,$88,$CC,$41,$CB,$CA,$CB,$CA,$CB,$CA,$CB,$C9,$C8,$C9,$C8
                 !byte $C7,$C6,$C7,$C6,$C5,$C4,$C5,$C4,$C5,$C4,$C3,$C2,$C3,$C2,$C1,$C0
                 !byte $91,$11,$00        
                 
scream3_sfx      !byte $0A,$88,$88,$AC,$41,$AB,$AA,$AB,$AA,$AB,$AA,$AB,$A9,$A8,$A9,$A8
                 !byte $A7,$A6,$A7,$A6,$A5,$A4,$A5,$A4,$A5,$A4,$A3,$A2,$A3,$A2,$A1,$A0
                 !byte $91,$11,$00                         

alarm_sfx        
                 !byte $0A,$AA,$88,$C0,$41,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB
                 !byte $CC,$C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$C0,$C1,$C2
                 !byte $C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$C0,$C1,$C2,$C3,$C4,$C5,$C6
                 !byte $C7,$C8,$C9,$CA,$CB,$C1,$11,$00
                 
extralife_sfx    !byte $0A,$AA,$88,$C0,$41,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB
                 !byte $BC,$BC,$BC,$BC,$BC,$BC,$BC,$BC,$BC,$11,$00
                 
bomb_throw_sfx   !byte $88,$88,$88,$CC,$11,$CC,$CB,$CA,$C9,$C8,$C7,$C6,$C5,$C4,$C3,$C2
                 !BYTE $C1,$C0,$BF,$BE,$BD,$BC,$BB,$BA,$B9,$B8,$B7,$B6,$B5,$B4,$B3,$B2
                 !BYTE $B1,$B0,$AF,$AE,$AD,$AC,$AA,$A9,$A8,00

bomb_explode_sfx
                 !byte $0E,$EA,$88,$aa,$41,$cc,$81,$a8,$41,$a4,$82,$81,$cc,$cc,$cc,$cc,$cc
                 !byte $cc,$cc,$00
;Tables of enemy type (These will be read via value of sequence pointers)
                   
enemy_type_lo    !byte <villain_object1
                 !byte <villain_object2
                 !byte <villain_object3
                 !byte <civilian_object1
                 !byte <civilian_object2
                 !byte <civilian_object3
                 
enemy_type_hi    !byte >villain_object1
                 !byte >villain_object2 
                 !byte >villain_object3
                 !byte >civilian_object1
                 !byte >civilian_object2
                 !byte >civilian_object3
                 
                
enemy_bad_table  ;0 = good, 1 = bad
                 !byte 1
                 !byte 1
                 !byte 1
                 !byte 0
                 !byte 0
                 !byte 0
                 
enemy_score_table ;1 = 100 points, 2 = 200 points, 3 = 500 points, 4 = lose a life 
                 !byte 1
                 !byte 2
                 !byte 3
                 !byte 4
                 !byte 4
                 !byte 4
enemy_score_table_end                 

enemy_colour_table
                  !byte $01,$07,$04,$06,$02,$08,$07,$0a,$02,$01
                  !byte $05,$08,$02,$01,$0f,$07,$06,$04,$02,$05
                  !byte $04,$06,$01,$02,$04,$08,$05,$02,$06,$09
                  !byte $01,$06,$07,$04,$01,$02,$08,$09,$04,$06
                  !byte $02,$08,$05,$09,$01,$05,$02,$08,$02,$04
                  !byte $01,$07,$04,$06,$02,$08,$07,$0a,$02,$01
                  !byte $05,$08,$02,$01,$0f,$07,$06,$04,$02,$05
                  !byte $04,$06,$01,$02,$04,$08,$05,$02,$06,$09
                  !byte $01,$06,$07,$04,$01,$02,$08,$09,$04,$06
                  !byte $02,$08,$05,$09,$01,$05,$02,$08,$02,$04
enemy_colour_table_end                  
                  
!align $ff,$00

randomtable       !bin "bin\randomtable.prg",,2

;Counters for status panel.

score           !byte $30,$30,$30,$30,$30,$30
virtualscore    !byte $30,$30,$30,$30,$30,$30
escapees        !byte $30,$30
escapeeslimit   !byte $39,$39
quota           !byte $31,$30,$30 
hiscore         !byte $30,$30,$30,$30,$30,$30
lives           !byte $33
;Level pointers (Each level should have mostly bad enemies, but also)
;some good enemies. Later levels should have more good enemies. There
;are 6 labels in total. Each table can be built with 100 bytes 
;in total. A sub routine can decide which direction the enemy can 
;move when spawning. No table required direction mode.

enemy_select_table
                !byte 0,1,2,0,2,2,1,2,0,1,2,1,0,1,2,0
                !byte 3,1,2,0,2,1,2,2,1,0,2,0,1,2,1,2
                !byte 2,3,1,2,1,0,1,4,1,2,0,1,2,1,1,2
                !byte 5,1,2,1,0,1,1,2,1,1,2,1,0,1,2,1
                !byte 0,1,1,3,1,2,0,1,4,0,1,1,2,1,2,0
enemy_select_table_end


enemy_dir_select_table
                !byte 0,1,1,0,1,0,1,1,0,1,0,1,0,1,0,1
                !byte 0,1,1,0,0,0,1,0,0,1,1,0,0,1,0,0
                !byte 1,0,1,0,1,1,0,1,1,0,1,0,1,0,1,0
                !byte 1,0,0,1,0,1,0,0,0,1,0,1,0,1,0,0
                !byte 0,1,0,1,0,0,1,0,1,0,1,0,1,0,1,1
enemy_dir_select_table_end

enemy_speed_table 
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
enemy_speed_table_end                

enemy_drag_active_table
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
enemy_drag_active_table_end

enemy_drag_speed_table 
                !byte 3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2
                !byte 2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3
                !byte 3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2
                !byte 2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3
                !byte 3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2
enemy_drag_speed_table_end                


enemy_y_pos_table
                !byte $94,$44,$6c,$44,$94,$6c,$44,$6c,$44,$6c
                !byte $94,$6c,$44,$6c,$6c,$94,$44,$44,$6c,$94
                !byte $6c,$44,$44,$6c,$94,$44,$6c,$44,$94,$6c
                !byte $44,$6c,$94,$94,$6c,$44,$44,$94,$6c,$44
                !byte $44,$94,$44,$6c,$94,$6c,$44,$44,$94,$6c
                
                !byte $94,$44,$6c,$44,$94,$6c,$44,$44,$94,$94
                !byte $6c,$6c,$44,$94,$6c,$44,$44,$94,$44,$94
                !byte $44,$6c,$94,$44,$94,$6c,$94,$44,$44,$6c
                !byte $94,$44,$6c,$94,$6c,$44,$6c,$94,$6c,$44
                !byte $94,$6c,$44,$44,$94,$6c,$6c,$44,$6c,$94
enemy_y_pos_table_end   

sirenflashtable 
                !byte $06,$06,$03,$03,$01
                !byte $01,$03,$03,$06,$06
                !byte $02,$02,$07,$07,$01
                !byte $01,$07,$07,$02,$02
                !byte $06,$06,$03,$03,$01
                !byte $01,$03,$03,$06,$06
                !byte $02,$02,$07,$07,$01
                !byte $01,$07,$07,$02,$02
                !byte $06,$06,$03,$03,$01
                !byte $01,$03,$03,$06,$06
                !byte $02,$02,$07,$07,$01
                !byte $01,$07,$07,$02,$02
                !byte $06,$06,$03,$03,$01
                !byte $01,$03,$03,$06,$06
                !byte $02,$02,$07,$07,$01
                !byte $01,$07,$07,$02,$02
                
sirenflashtableend                
                !byte $06,$06,$03,$03,$01
                !byte $01,$03,$03,$06,$06
                !byte $06
                          
                !align $ff,0
                
!ct scr         ;0123456789012345678901234567890123456789

header    !text "  chief commander supt, tracey cisco,  " 
mline1    !text " your officers will need to arrest 000 "
mline2    !text "     robbers and not let 00 escape,    "
mline3    !text "  try to avoid citizens while you can, "
mline4    !text "               good luck,              "
          
failm1     !text "           you bumbling fool,          "
failm2     !text " you have made too many discrepancies, "
failm3     !text "  you are not fit to serve the public, "
failm4     !text "  therefore you are demoted to office, "

complete1  !text "     congratulations tracey cisco,     "
complete2  !text "  you and your team have done a great  "
complete3  !text " job clearing this zone from villains, "
complete4  !text "                                       "
complete5  !text "         press fire to continue        "
hiscoretxt !text " you have also acheived a new hi score "


;----------------------------------------------------------

!align $ff,0   ;Level tables
!source "levels.asm"
 