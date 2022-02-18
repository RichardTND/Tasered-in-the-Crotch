;***************************************
;
;        TASERED IN THE CROTCH!
;
;     A fun game by Richard Bayliss
;
;       (C)2022 The New Dimension
;
;***************************************

;GAME CODE


;Switch off IRQs from title screen
;and clear SID chip.

               
game_start      sei
                
                ;Initialise level pointer
                
                lda #0
                sta level_pointer 
                
                lda #$81 
                sta $dc0d
                sta $dd0d
                lda #$0b
                sta $d011
                lda #$00
                sta $d015
                sta $d017
                sta $d01d
                sta $d01b
                lda #$00
                sta $d019
                sta $d01a
                sta fire_button
                lda #$30 
                sta level_no 
                lda #$31
                sta level_no+1
                ;Init SID chip
                ldx #$00
init_sid        lda #$00
                sta $d400,x
                inx
                cpx #$18
                bne init_sid 
                
                
                ;Reset score panel
                
                ldx #$00
score_reset     lda #$30
                sta score,x
                inx
                cpx #$06
                bne score_reset
                lda #$30
                sta escapees
                sta escapees+1
                lda #$32
                sta escapeeslimit
                lda #$30
                sta escapeeslimit+1
                lda #$30
                sta quota 
                sta quota+2
                lda #$32
                sta quota+1
                lda #$33
                sta lives
                
;Setup game screen and hardware pointers

                lda #$00
                sta $d020 
                sta $d021
                lda #$18
                sta $d016
                lda #$1e
                sta $d018
                lda #$0b
                sta $d022
                lda #$01
                sta $d023
                
                
            
                
                
                ;Reset speed
                lda #1
                sta enemy1_speed
                sta enemy2_speed 
                sta enemy3_speed
                sta enemy4_speed
                sta enemy5_speed
                lda #0
                sta enemy1_dir
                sta enemy3_dir
                sta enemy5_dir
                lda #1
                sta enemy2_dir
                sta enemy4_dir
                
                lda #$02
                sta enemy1_drag_speed
                sta enemy1_drag_speed
                sta enemy1_drag_speed
                sta enemy1_drag_speed
                sta enemy1_drag_speed
                
                
                ;Initialise and setup IRQ raster interrupts

                sei 
                lda #$fb
                tsx
                ldx #<game_irq
                ldy #>game_irq 
                lda #$7f
                stx $fffe
                sty $ffff
                ldx #<nmi
                ldy #>nmi
                stx $fffa
                sty $fffb
                
                sta $dc0d
                sta $dd0d
                lda #$2e
                sta $d012
                lda #$1b
                sta $d011
                lda #$01
                sta $d019
                sta $d01a
                
                cli
start_next_level   
                jsr initpointers ;Initialise all pointers 
                
                
                lda #get_ready_jingle
                jsr music_init
                lda #0
                sta $d015
                ldx #$00
clearscreen     lda #$20
                sta $0400,x
                sta $0500,x
                sta $0600,x
                sta $06e8,x
                lda #1
                sta $d800,x
                sta $d900,x
                sta $da00,x
                sta $dae8,x
                
                inx
                bne clearscreen
                jsr setuplevels
                jsr mask_panel
                ldx #$00
copy_panel_screen
                lda game_screen+$348,x
                sta $0748,x
                ldy game_screen+$348,x
                lda game_attribs,y
                sta $db48,x
                inx
                cpx #$a0
                bne copy_panel_screen
                
                ldx #$00
copy_message    lda header,x
                sta $04a0+(2*40),x
                lda mline1,x
                sta $04a0+(2*40)+120,x
                lda mline2,x
                sta $04a0+(2*40)+200,x
                lda mline3,x
                sta $04a0+(2*40)+280,x
                lda mline4,x
                sta $04a0+(2*40)+360,x
                inx
                cpx #$28
                bne copy_message
             
                lda #0
                sta fire_button
                
                ldx #$00
get_level_text
                lda level_text,x 
                sta level_char_pos,x 
                inx 
                cpx #8 
                bne get_level_text 
                
                lda level_no 
                sec 
                sbc #2
                sta level_char_pos+6
                lda level_no+1
                sec
                sbc #2 
                sta level_char_pos+7
                
                 lda #$30
                sta escapees
                sta escapees+1
                ldx #$00
fetch_quotas                
                lda quota,x 
                sec
                sbc #2
                sta quota_intro_pos,x
                inx
                cpx #3
                bne fetch_quotas
                
                lda escapeeslimit
                sec
                sbc #2
                sta escapees_intro_pos
                lda escapeeslimit+1 
                sec
                sbc #2
                sta escapees_intro_pos+1
                ldx #$00
grloop1         ldy #$00
                iny
                bne *-1
                inx
                bne grloop1
                
                jsr mask_panel
                
                
get_ready_loop                
                lda $dc00
                lsr
                lsr
                lsr
                lsr
                lsr
                bit fire_button
                ror fire_button
                bmi get_ready_loop 
                bvc get_ready_loop
                lda #0
                sta fire_button
                lda #game_music
                jsr music_init
                
                
                jsr initenemy
                jsr randombomb
                jmp drawgame
                
                
initenemy       jsr animate_and_move_enemy1+$42
                jsr animate_and_move_enemy2+$42
                jsr animate_and_move_enemy3+$42
                jsr animate_and_move_enemy4+$42
                jsr animate_and_move_enemy5+$45
                rts
                
;Zero fill all game pointers
            
initpointers    ldx #00
zeroptloop      lda #$00
                sta pointers,x
                inx
                cpx #pointersend-pointers
                bne zeroptloop
                rts
                
drawgame                

;Draw main game screen to screen RAM
;($0400-$07e8) 

                ldx #$00
draw_screen     lda game_screen,x
                sta $0400,x
                lda game_screen+$100,x
                sta $0500,x
                lda game_screen+$200,x
                sta $0600,x
                lda game_screen+$2e8,x
                sta $06e8,x
               
                ;Include attributes
        
                ldy game_screen,x
                lda game_attribs,y 
                sta $d800,x
                ldy game_screen+$100,x
                lda game_attribs,y
                sta $d900,x
                ldy game_screen+$200,x
                lda game_attribs,y 
                sta $da00,x
                ldy game_screen+$2e8,x
                lda game_attribs,y
                sta $dae8,x

                inx
                bne draw_screen
                jsr mask_panel

;Initialise sprite position and frame objects 

                ldx #$00
initspritepos   lda starttable,x
                sta objpos,x
                inx
                cpx #$10
                bne initspritepos

                lda #$00
                sta $d025
                lda #$0a
                sta $d026

                lda #1
                sta $d027
                lda #7
                sta $d028

                lda arrow_object
                sta $07f8
                lda taser_object
                sta $07f9
                
                
                lda #$ff
                sta $d015 
                sta $d01c
                lda #1
                sta enemy1_speed
                sta enemy2_speed
                sta enemy3_speed 
                sta enemy4_speed
                sta enemy5_speed 
                lda #$20 
                sta taser_x_store
hold            jmp gameloop

;Main IRQ raster interrupt player for game_restart

game_irq        sta gsa+1
                stx gsx+1
                sty gsy+1
                asl $d019
                lda $dc0d
                sta $dd0d
                lda #$fa
                sta $d012
                lda #1
                sta rt
                jsr music_player
gsa             lda #0
gsx             ldx #0
gsy             ldy #0              
nmi             rti

;PAL/NTSC music player system

music_player    lda system
                cmp #1
                beq pal_system
                inc ntsc_timer
                lda ntsc_timer
                cmp #6
                beq ntsc_reset
pal_system      jsr music_play
                rts 
ntsc_reset      lda #0
                sta ntsc_timer 
                rts

;PAL/NTSC detect routine ($D012 check on startup)

pal_ntsc_check  lda $d012
pn_loop         cmp $d012
                beq pn_loop 
                bmi pal_ntsc_check 
                cmp #$20 
                bcc system_ntsc 
                lda #$01
                sta system ;PAL detected
                rts 
system_ntsc     lda #$00   ;NTSC detected      
                sta system 
                rts

;Main gameloop
gameloop        jsr synctimer
                jsr sprite_animation
                jsr select_officer
                jsr test_taser
                jsr test_enemies_and_bomb
                jsr test_collision
                jmp gameloop 

;Synchronise timer and expand sprites 
synctimer       lda #0
                sta rt
                cmp rt 
                beq *-3
                ldx #$00
expandmsb       lda objpos+1,x
                sta $d001,x
                lda objpos,x
                asl
                ror $d010
                sta $d000,x
                inx
                inx
                cpx #$10
                bne expandmsb
              
                rts

;Complete sprite animation 

sprite_animation
                jsr animate_player_objects
                jsr animate_enemy_objects
              
                rts 
                
;Animate player objects (Taser and Arrow cursor) 

animate_player_objects
                lda sprite_anim_delay1
                cmp #4
                beq do_sprite_anim_plr
                inc sprite_anim_delay1
                rts
do_sprite_anim_plr
                lda #0
                sta sprite_anim_delay1
                jsr anim_arrow_rout
                jsr anim_taser_rout
                rts 
anim_arrow_rout
                ldx arrow_anim_pointer
                lda arrow_anim,x
                sta $07f8;Arrow is always sprite 0
                inx
                cpx #arrow_animlength-arrow_anim
                beq loop_arrow_anim
                inc arrow_anim_pointer
                rts
loop_arrow_anim
                ldx #$00
                stx arrow_anim_pointer
                rts
                
anim_taser_rout 
                ldx taser_anim_pointer
                lda taser_anim,x
                sta taser_anim_store ;Taser is sprite 1. This is because 
                          ;enemies killed will have their own 
                          ;animation.
                inx
                cpx #taser_animlength-taser_anim
                beq loop_taser_anim
                inc taser_anim_pointer 
                rts 
loop_taser_anim
                ldx #$00
                stx taser_anim_pointer 
                rts 
                
;Animate enemy objects

animate_enemy_objects
                lda sprite_anim_delay2
                cmp #8
                beq twoframeanim
                inc sprite_anim_delay2
                rts
twoframeanim    lda #0
                sta sprite_anim_delay2
                ldx enemy_anim_pointer
                lda villain1_anim,x
                sta villain_object1
                lda villain2_anim,x
                sta villain_object2
                lda villain3_anim,x
                sta villain_object3
                lda civilian1_anim,x
                sta civilian_object1
                lda civilian2_anim,x
                sta civilian_object2
                lda civilian3_anim,x
                sta civilian_object3
                lda bomb_anim,x
                sta bomb_object
                inx
                cpx #2
                beq loop_enemy_anim
                inc enemy_anim_pointer
                rts
loop_enemy_anim
                ldx #0
                stx enemy_anim_pointer
                rts
            
                
                

;Routine to cycle the arrow across the officers 

select_officer  jsr trigger_fire_taser
                lda select_delay 
                cmp #8
                beq select_switch
                inc select_delay
                rts 
select_switch   lda #0
                sta select_delay 
                
                lda #8 ;Direction right
                bit $dc00
                bne joy_right
                inc select_pointer 
                lda select_pointer 
                cmp #7
                bne selectok1
                lda #6
                sta select_pointer
selectok1       jmp setup_officer
skip_dir        
                rts

joy_right       lda #4 ;Direction left
                bit $dc00
                bne skip_dir
                dec select_pointer 
                lda select_pointer
                bpl selectok2
                lda #0
                sta select_pointer
selectok2       
setup_officer
                ldx select_pointer
                lda arrow_select_table,x 
                sta objpos
                lda taser_select_table,x
                sta taser_x_store 
                
                rts

                                
                
trigger_fire_taser
                lda $dc00
                lsr
                lsr
                lsr
                lsr
                lsr
                bit fire_button
                ror fire_button
                bmi fire_jp1
                bvc fire_jp1
                lda #0
                sta fire_button 
                jmp test_taser_fire_active
test_taser_fire_active
                lda taser_launched
                beq launch_taser
fire_jp1             
                rts
launch_taser    lda #$b8 ;Y pos for taser
                sta objpos+3
                lda taser_x_store
                sta objpos+2
                lda #1
                sta taser_launched
                lda #<taser_fire_sfx 
                ldy #>taser_fire_sfx
                ldx #7
                jsr sfx_play
               
fire_jp2        rts
                
                
                

;Test taser, for launching

test_taser      lda taser_dead
                cmp #1
                beq taser_effect
                
                lda taser_launched 
                cmp #1 
                beq taser_fired
                lda taser_anim_store
                sta $07f9
                lda #7
                sta $d028
                lda #1
                sta $d027
                lda taser_x_store
                sta objpos+2
                lda #$b8
                sta objpos+3
                rts 
taser_fired     lda taser_anim_store
                sta $07f9
                lda #$07
                sta $d028
                lda #2
                sta $d027
                lda objpos+3
                sec
                sbc #4
                cmp #$2e
                bcs taser_update_y
                lda #0
                sta objpos+2
                sta objpos+3
                lda #1
                sta $d027
                lda #0
                sta taser_launched
                rts
taser_update_y  sta objpos+3
                rts
                
;The taser hit an enemy so, it should be doing a different animation 

taser_effect    lda sprite_anim_delay3
                cmp #2
                beq anim_death
                inc sprite_anim_delay3
                rts 
anim_death      lda #0
                sta sprite_anim_delay3
                ldx sprite_anim_pointer3
taser_sm        lda taseredbad_anim,x
                sta $07f9
                lda #$01
                sta $d028
                inx
                cpx #taseredlength-tasered100_anim
                beq respawn_taser
                inc sprite_anim_pointer3
                rts
respawn_taser                
                ldx #0
                stx sprite_anim_pointer3
               
                lda #0
                sta objpos+2
                sta objpos+3
                sta taser_dead
                sta taser_launched
                rts
                
;Test enemy objects 
test_enemies_and_bomb
                jsr animate_and_move_enemy1
                jsr animate_and_move_enemy2
                jsr animate_and_move_enemy3
                jsr animate_and_move_enemy4
                jsr animate_and_move_enemy5
                jsr test_bomb
                rts
                
;--------------------------------------------------------------------------------
;Animate enemy 1 and also set its colour. Then check direction it is
;allowed to move. Afterwards move the enemy that direction until it reaches
;the stop boundary.

animate_and_move_enemy1
enemy1_framesm  lda villain_object1
                sta $07fa
enemy1_coloursm lda #1
                sta $d029
                +enemy_properties enemy1_drag_enabled, enemy1_drag_speed, enemy1_dir, objpos+4, objpos+5, enemy1_speed, enemy1_badenemy, enemy1_framesm, enemy1_coloursm, enemy1_scoretype  
                rts
;--------------------------------------------------------------------------------

;Animate enemy 2 and also set its colour. Then check direction it is
;allowed to move. Afterwards move the enemy that direction until it reaches
;the stop boundary.

animate_and_move_enemy2
enemy2_framesm  lda villain_object1
                sta $07fb
enemy2_coloursm lda #1
                sta $d02a
                +enemy_properties enemy2_drag_enabled, enemy2_drag_speed, enemy2_dir, objpos+6, objpos+7, enemy2_speed, enemy2_badenemy, enemy2_framesm, enemy2_coloursm, enemy2_scoretype
                rts
;--------------------------------------------------------------------------------
;Animate enemy 3 and also set its colour. Then check direction it is
;allowed to move. Afterwards move the enemy that direction until it reaches
;the stop boundary.

animate_and_move_enemy3
enemy3_framesm  lda villain_object1
                sta $07fc
enemy3_coloursm lda #1
                sta $d02b
                +enemy_properties enemy3_drag_enabled, enemy3_drag_speed, enemy3_dir, objpos+8, objpos+9, enemy3_speed, enemy3_badenemy, enemy3_framesm, enemy3_coloursm, enemy3_scoretype  
                rts
;--------------------------------------------------------------------------------                
;--------------------------------------------------------------------------------
;Animate enemy 4 and also set its colour. Then check direction it is
;allowed to move. Afterwards move the enemy that direction until it reaches
;the stop boundary.

animate_and_move_enemy4
enemy4_framesm  lda villain_object1
                sta $07fd
enemy4_coloursm lda #1
                sta $d02c
                +enemy_properties enemy4_drag_enabled, enemy4_drag_speed, enemy4_dir, objpos+10, objpos+11, enemy4_speed, enemy4_badenemy, enemy4_framesm, enemy4_coloursm, enemy4_scoretype  
                rts
;--------------------------------------------------------------------------------                
;--------------------------------------------------------------------------------
;Animate enemy 5 and also set its colour. Then check direction it is
;allowed to move. Afterwards move the enemy that direction until it reaches
;the stop boundary.

animate_and_move_enemy5
enemy5_framesm  lda villain_object1
                sta $07fe
enemy5_coloursm lda #1
                sta $d02d
                +enemy_properties enemy5_drag_enabled, enemy5_drag_speed, enemy5_dir, objpos+12, objpos+13, enemy5_speed, enemy5_badenemy, enemy5_framesm, enemy5_coloursm, enemy5_scoretype  
                rts
;--------------------------------------------------------------------------------
;Test enemy bomb. If the bomb is launched, it should move downwards, otherwise 
;the bomb is not enabled.
;--------------------------------------------------------------------------------

test_bomb      
                lda bomb_exploding
                cmp #1
                beq cannot_move_bomb
                lda bomb_released
                cmp #1
                beq move_bomb
                jmp enemy_ranges
                
move_bomb       jmp animate_and_move_bomb
       
cannot_move_bomb
                lda sprite_anim_delay4
                cmp #2
                beq animate_explosion
                inc sprite_anim_delay4
              
               
                rts
animate_explosion
                lda #7
                sta $d02e
                lda #0
                sta sprite_anim_delay4
                ldx sprite_anim_pointer4
                lda exploder_anim,x
                sta $07ff
                inx
                cpx #exploder_animlength-exploder_anim
                beq finished_exploding_bomb
                inc sprite_anim_pointer4
                rts
finished_exploding_bomb 
                lda #0
                sta sprite_anim_delay4
                sta sprite_anim_pointer4
                lda #0
                sta objpos+14
                sta objpos+15
                sta bomb_exploding
                jsr randombomb
                sta bomb_select_pointer
                ldx bomb_select_pointer
                lda bombx_select_table,x
                sta bomb_x_spawn_position
                lda bomby_select_table,x
                sta bomb_y_spawn_position
                ;inx
                ;cpx #100
                ;beq reset_bomb_table
                
                rts
                
                
reset_bomb_table        
                ldx #0
                stx bomb_select_pointer
                
animate_not_active                
                rts
                
                
randombomb      lda randompointer
                beq doeor 
                clc
                asl 
                beq noeor
                bcc noeor 
doeor           eor #$1d 
noeor           sta randompointer 
                tax 
                lda randomtable,x 
                rts
                
animate_and_move_bomb
                
                lda bomb_object
                sta $07ff
                lda #1
                sta $d02e
                lda objpos+15
                clc
                adc #2
                cmp #$c8
                bcc update_bomb_y
                lda #0
                sta sprite_anim_delay4
                sta sprite_anim_pointer4
                
!ifdef cheatlives {
} else {                
                jsr deduct_lives
}                
                lda #<bomb_explode_sfx
                ldy #>bomb_explode_sfx 
                ldx #7
                jsr sfx_play
                
                lda #<alarm_sfx
                ldy #>alarm_sfx 
                ldx #14
                jsr sfx_play
                
                lda #0
                sta bomb_released
                lda #1
                sta bomb_exploding
                rts
update_bomb_y   sta objpos+15
                rts
                
enemy_ranges    jsr enemy1_to_bomb
                jsr enemy2_to_bomb
                jsr enemy3_to_bomb
                jsr enemy4_to_bomb
                jsr enemy5_to_bomb
                rts
                
enemy1_to_bomb  +enemy_bomb_arm objpos+4, objpos+5, enemy1_badenemy
enemy2_to_bomb  +enemy_bomb_arm objpos+6, objpos+7, enemy2_badenemy
enemy3_to_bomb  +enemy_bomb_arm objpos+8, objpos+9, enemy3_badenemy
enemy4_to_bomb  +enemy_bomb_arm objpos+10, objpos+11, enemy4_badenemy
enemy5_to_bomb  +enemy_bomb_arm objpos+12, objpos+13, enemy5_badenemy               
               
                

;--------------------------------------------------------------------------------                

;Taser to enemy collision 

test_collision  lda taser_dead
                cmp #1
                beq do_no_collision
                lda objpos+2
                sec
                sbc #$06
                sta collision_table
                clc
                adc #$0c
                sta collision_table+1
                lda objpos+3
                sec
                sbc #$0c
                sta collision_table+2
                clc
                adc #$18
                sta collision_table+3
                
                jsr test_collider_enemy1
                jsr test_collider_enemy2
                jsr test_collider_enemy3
                jsr test_collider_enemy4
                jsr test_collider_enemy5
                jsr test_collider_bomb
do_no_collision                
                rts
                
!macro collision_test enemyx, enemyy, enemyscoretype {

                ;Collision size check (all in one)
                
                lda enemyx
                cmp collision_table
                bcc .nocollision
                cmp collision_table+1
                bcs .nocollision
                lda enemyy
                cmp collision_table+2
                bcc .nocollision
                cmp collision_table+3
                bcs .nocollision
                
                ;Accurate position for tasered death anim
                
                lda enemyx
                sta objpos+2
                lda enemyy
                sta objpos+3
                lda #0
                sta enemyy
                lda #0
                sta sprite_anim_delay3
                sta sprite_anim_pointer3
                
                lda #1
                sta taser_dead
                lda enemyscoretype 
                cmp #1
                beq .villain1
                cmp #2
                beq .villain2
                cmp #3
                beq .villain3
                jmp .tasered_a_civilian
.nocollision    rts

.villain1       lda #<scream1_sfx
                ldy #>scream1_sfx
                ldx #14
                jsr sfx_play
                
                lda #<tasered100_anim
                sta taser_sm+1
                lda #>tasered100_anim
                sta taser_sm+2
                jsr deduct_quota
                jmp score_100_points
                
.villain2       lda #<scream2_sfx
                ldy #>scream2_sfx
                ldx #14
                jsr sfx_play 
                
                lda #<tasered200_anim
                sta taser_sm+1
                lda #>tasered200_anim
                sta taser_sm+2
                jsr deduct_quota
                jmp score_200_points
                
.villain3       lda #<scream3_sfx
                ldy #>scream3_sfx
                ldx #14
                jsr sfx_play  
  
                lda #<tasered500_anim
                sta taser_sm+1
                lda #>tasered500_anim
                sta taser_sm+2  
                jsr deduct_quota
                jmp score_500_points
                
.tasered_a_civilian
                
                lda #<taseredbad_anim
                sta taser_sm+1
                lda #>taseredbad_anim
                sta taser_sm+2
                lda #<alarm_sfx
                ldy #>alarm_sfx
                ldx #14
                jsr sfx_play
                jsr deduct_lives
                rts
}
test_collider_enemy1
                +collision_test objpos+4, objpos+5, enemy1_scoretype
test_collider_enemy2
                +collision_test objpos+6, objpos+7, enemy2_scoretype
test_collider_enemy3
                +collision_test objpos+8, objpos+9, enemy3_scoretype
test_collider_enemy4
                +collision_test objpos+10, objpos+11, enemy4_scoretype
test_collider_enemy5
                +collision_test objpos+12, objpos+13, enemy5_scoretype
                
test_collider_bomb 
                ;Tasering a bomb will award you 3 points 
                lda bomb_exploding
                cmp #1
                beq skip_bomb_collision
                lda objpos+14
                cmp collision_table
                bcc nobombhit
                cmp collision_table+1
                bcs nobombhit
                lda objpos+15
                cmp collision_table+2
                bcc nobombhit 
                cmp collision_table+3
                bcc nobombhit
                
                lda #0
                sta objpos+2
                ;sta objpos+3
                
                ;sta taser_fired
                sta sprite_anim_delay4
                sta sprite_anim_pointer4
                lda #0
                sta bomb_released
                lda #1
                sta bomb_exploding
                jsr score_200_points
                lda #<bomb_explode_sfx
                ldy #>bomb_explode_sfx
                ldx #7
                jsr sfx_play
nobombhit       
skip_bomb_collision
                rts
;--------------------------------------------------------------------------------
;Deduct quota counter, for every enemy that has been white

deduct_quota    
                dec quota+2
                ldx #2
subtractQ       lda quota,x
                cmp #$2f
                bne quotaok
                lda #$39
                sta quota,x
                dec quota-1,x
quotaok         dex
                bne subtractQ
                jsr mask_panel
                jsr check_quota_all_zero
                rts
                
check_quota_all_zero           
                  
                lda quota 
                cmp #$30
                beq zero1
                rts
zero1           lda quota+1
                cmp #$30
                beq zero2
                rts
zero2           lda quota+2
                cmp #$30
                beq level_complete
                rts

;Either all lives or too many prisoners have escaped, enforce
;the game to be over.

level_complete  lda #0
                sta $d015
                ldx #$00
clear_screen_l  lda #$20
                sta $0400,x
                sta $0500,x
                sta $0600,x
                sta $06e8-160,x
                lda #$01
                sta $d800,x
                sta $d900,x
                sta $da00,x
                sta $dae8-160,x
                inx
                bne clear_screen_l
                
                ldx #$00
put_level_comp  lda complete1,x
                sta $04a0,x
                lda complete2,x
                sta $04a0+120,x
                lda complete3,x
                sta $04a0+200,x
                lda complete4,x
                sta $04a0+280,x
                lda complete5,x
                sta $04a0+360,x
                inx 
                cpx #$28
                bne put_level_comp
                
                lda #mission_complete_jingle
                jsr music_init
                ldx #$00
wait2           ldy #$00
                iny
                bne *-1
                inx
                bne wait2
                lda #0
                sta fire_button
wait_level_complete                
                lda $dc00
                lsr
                lsr
                lsr
                lsr
                lsr
                bit fire_button
                ror fire_button
                bmi wait_level_complete
                bvc wait_level_complete
                
                ldx #$00
wait2b          ldy #$00
                iny
                bne *-1
                inx
                bne wait2b
                ;setup_level_properties
                inc level_no+1
                lda level_no+1
                cmp #$3a 
                bne levok
                lda #$30
                sta level_no+1
                inc level_no
              
                
levok           
                
                jmp start_next_level
                
;-------------------------------------------------------------------------
;Setup the levels accordingly, before displaying 
;the GET READY message.
;-------------------------------------------------------------------------

setuplevels     ldx level_pointer
                lda level_enemy_select_table_lo,x
                sta levelsm1+1
                lda level_enemy_select_table_hi,x
                sta levelsm1+2
                lda level_enemy_dir_select_table_lo,x
                sta levelsm2+1
                lda level_enemy_dir_select_table_hi,x 
                sta levelsm2+2
                lda level_enemy_speed_table_lo,x
                sta levelsm3+1
                lda level_enemy_speed_table_hi,x
                sta levelsm3+2
                lda level_enemy_drag_active_table_lo,x
                sta levelsm4+1
                lda level_enemy_drag_active_table_hi,x 
                sta levelsm4+2
                lda level_enemy_drag_speed_table_lo,x
                sta levelsm5+1
                lda level_enemy_drag_speed_table_hi,x 
                sta levelsm5+2
                lda level_quota_lo,x
                sta levelsm6+1
                lda level_quota_hi,x 
                sta levelsm6+2
                lda level_Escapee_Count_lo,x
                sta levelsm7+1
                lda level_Escapee_Count_hi,x
                sta levelsm7+2
                inx
                cpx #8
                beq loop_to_level_1
                inc level_pointer
                jmp makelevel
                rts
loop_to_level_1
                ldx #$00
                stx level_pointer 
                jmp setuplevels
                
makelevel       ldx #$00
levelsm1        lda LEVEL1_enemy_select_table,x
                sta enemy_select_table,x
levelsm2        lda LEVEL1_enemy_dir_select_table,x
                sta enemy_dir_select_table,x
levelsm3        lda LEVEL1_enemy_speed_table,x 
                sta enemy_speed_table,x 
levelsm4        lda LEVEL1_enemy_drag_active_table,x
                sta enemy_drag_active_table,x
levelsm5        lda LEVEL1_enemy_drag_speed_table,x
                sta enemy_drag_speed_table,x
                inx 
                cpx #enemy_select_table_end-enemy_select_table
                bne levelsm1
                
                
                ldx #$00
levelsm6        lda LEVEL1_Quota,x
                sta quota,x
                inx
                cpx #3
                bne levelsm6
                
                ldx #$00
levelsm7        lda LEVEL1_Escapee_Count,x
                sta escapeeslimit,x
                inx
                cpx #$02
                bne levelsm7
                rts                   
                
;--------------------------------------------------------------------------------

;An enemy escapes the crimescene. Add one to the value of
;escapees. Then refresh the score panel with the new 
;value.

an_enemy_has_escaped
               
                inc escapees+1
                lda escapees+1
                cmp #$3a
                bne just_refresh_panel
                lda #$30
                sta escapees+1
                inc escapees
just_refresh_panel                
                lda escapees
                cmp #$3a
                beq escapees_default
                jsr mask_panel
                rts
escapees_default
                lda #$30
                sta escapees
                sta escapees+1
                jsr mask_panel
                rts                
                
;--------------------------------------------------------------------------------
;Three civilians have been wrongfully tasered, or a bomb hits the police force. 
;If this happens, a life is lost.

deduct_lives   
!ifdef cheatlives {
} else {
                dec lives
}
                jsr mask_panel
                lda lives
                cmp #$30
                beq game_over 
                rts
                
;--------------------------------------------------------------------------------
;The game is over. Remove all of the game sprites and prompt bad ending text 

game_over       lda #0
                sta fire_button
              
                lda #0
                sta $d015
                ldx #$00
make_game_over
                lda #$20
                sta $0400,x
                sta $0500,x
                sta $0600,x
                sta $06e8-160,x
                inx
                bne make_game_over
                ldx #$00
wait            ldy #$00
                iny
                bne *-1
                inx
                bne wait 
                
                
                ldx #$00
setup_fail_text                 
                lda header,x
                sta $04a0,x 
                lda failm1,x 
                sta $04a0+120,x
                lda failm2,x
                sta $04a0+200,x
                lda failm3,x
                sta $04a0+280,x
                lda failm4,x
                sta $04a0+360,x
                lda #1
                sta $d8a0,x
                sta $d8a0+120,x
                sta $d8a0+200,x
                sta $d8a0+280,x
                sta $d8a0+360,x
                inx
                cpx #$28
                bne setup_fail_text
                jsr mask_panel
                
                ;Check if current score is a new hi score
                lda score 
                sec
                lda hiscore+5
                sbc score+5
                lda hiscore+4
                sbc score+4
                lda hiscore+3
                sbc score+3
                lda hiscore+2
                sbc score+2
                lda hiscore+1
                sbc score+1
                lda hiscore 
                sbc score 
                bpl no_hiscore_recorded
                
                ldx #$00
make_new_hi     lda score,x
                sta hiscore,x
                inx
                cpx #$06
                bne make_new_hi
                jsr mask_panel
                
                ldx #$00
new_hi_message  lda hiscoretxt,x
                sta $04a0+480,x
                lda #5
                sta $d8a0+480,x
                inx
                cpx #40
                bne new_hi_message
                
                ;Play GAME OVER jingle
                
no_hiscore_recorded
                lda #game_over_jingle
                jsr music_init
game_over_loop                
                lda $dc00
                lsr
                lsr
                lsr
                lsr
                lsr
                bit fire_button
                ror fire_button
                bmi game_over_loop
                bvc game_over_loop
                lda #0
                sta fire_button
                jmp check_hi_score
                
                
                
;--------------------------------------------------------------------------------                

;--------------------------------------------------------------------------------

;An enemy has been hit, award the player points 

score_500_points
                jsr calculate_score
                jsr calculate_score
                jsr calculate_score
score_200_points 
                jsr calculate_score
score_100_points
                jsr calculate_score
                jsr mask_panel
                rts 
      
calculate_score
               inc score+3
               ldx #3
addit          lda score,x
               cmp #$3a
               bne scoreok
               lda #$30
               sta score,x
               inc score-1,x
scoreok        dex
               bne addit
               rts 
               
;Mask status panel 

mask_panel      ldx #$00
putscore        lda score,x
                sec
                sbc #2
                sta score_char_pos,x
                lda hiscore,x
                sec
                sbc #2
                sta hiscore_char_pos,x
                inx
                cpx #$06
                bne putscore
                ldx #$00
putescape       lda escapees,x
                sec
                sbc #2
                sta escapees_char_pos,x
                inx
                cpx #$02
                bne putescape 
                ldx #$00
puttarget       lda quota,x
                sec
                sbc #2
                sta quota_char_pos,x
                inx
                cpx #$03
                bne puttarget
                lda lives 
                sec
                sbc #2
                sta lives_char_pos
                rts
                
;Initialise enemies
                
                
                
;-----------------------------------------------------------------                
                !source "gamepointers.asm"


                