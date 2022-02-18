﻿;***************************************
;
;        TASERED IN THE CROTCH!
;
;     A fun game by Richard Bayliss
;
;       (C)2022 The New Dimension
;
;***************************************

;MACRO CODE (FOR LINKING TO ENEMY PROPERTIES)

;--------------------------------------------
;Enemy properties. 

!macro enemy_properties _drag_enabled, _drag_speed, _enemy_dir, _spritex, _spritey, _enemy_speed, _enemy_badenemy, _enemy_framesm, _enemy_coloursm, _enemy_scoretype  {
                
                ;Check drag status 
                
                lda _drag_enabled
                cmp #1
                beq .half_speed
                jmp .skip_enemy_drag
                
.half_speed
                lda _drag_speed
                cmp #3
                beq .drag_ok
                inc _drag_speed
                rts
.drag_ok
                lda #0
                sta _drag_speed
.skip_enemy_drag
                
                ;Check direction enemy can move 
                
                lda _enemy_dir
                cmp #1
                beq .shift_right
                
                ;Move enemy to the left until reach boundary point 
                
                lda _spritex
                sec
                sbc _enemy_speed
                cmp #boundary_left 
                bcs .update_x
               
                ;lda #0
                ;sta objpos+5
                
                jsr .select_next_enemy
                
                rts
.update_x 
                sta _spritex
                rts
       
                ;Move enemy to the right until reach boundary point
                
.shift_right
                lda _spritex
                clc
                adc _enemy_speed
                cmp #boundary_right
                bcc .update_x
                jmp .select_next_enemy
                
                ;First random pointer to select enemy objects
                
.select_next_enemy

                ;Enemy escaping. 
                
                ;First check if enemy Y position is offset
                ;before perform check of enemy 
                
                lda _spritey
                beq .just_select_next_enemy
                
                ;Now test if enemy that has left the screen
                ;is in fact a villain. If so, add 1 to the 
                ;escapee list and then run the select next
                ;enemy routine.
                
                lda _enemy_badenemy
                beq .just_select_next_enemy
                
                ;Enemy has escaped, so do an enemy escaped 
                ;subroutine.
                
                jsr an_enemy_has_escaped
               
.just_select_next_enemy

                ldx randompointer
                lda enemy_select_table,x
                sta enemy_set_pointer
                
                lda enemy_dir_select_table,x
                sta _enemy_dir
                
                lda enemy_drag_speed_table,x
                sta _drag_speed
                lda enemy_drag_active_table,x
                sta _drag_enabled
                lda enemy_y_pos_table,x
                sta _spritey
                inx
                cpx #enemy_select_table_end-enemy_select_table
                beq .loop
                inc randompointer
                jmp .pick_new_enemy
.loop           ldx #0
                stx randompointer
                
                
                ;Second random pointer to store the new properties 
                
.pick_new_enemy
                ldy enemy_set_pointer
                lda enemy_type_lo,y
                sta _enemy_framesm+1
                lda enemy_type_hi,y
                sta _enemy_framesm+2
                lda enemy_colour_table,y
                sta _enemy_coloursm+1
                lda enemy_bad_table,y
                sta _enemy_badenemy
                lda enemy_score_table,y
                sta _enemy_scoretype
                lda enemy_drag_speed_table,y 
                sta _drag_speed
                lda enemy_y_pos_table,y 
                sta _spritey
                lda _enemy_dir
                beq .store_enemy_left
              
                
                lda #$00
                sta _spritex
                rts
                
.store_enemy_left
                lda #$b2
                sta _spritex
               
                rts
}
;--------------------------------------------------------------------------------
;Bomb launch properties
;--------------------------------------------------------------------------------

!macro enemy_bomb_arm enemyx, enemyy, enemytype {
                
                lda enemyx
                cmp bomb_x_spawn_position
                beq .checky
                rts
.checky        
                lda enemyy
                cmp bomb_y_spawn_position
                beq .checktype
                rts
.checktype      lda enemytype
                cmp #1 ;1 = bad enemies 
                beq .launchbomb
                rts 
.launchbomb     lda enemyx
                sta objpos+14
                lda enemyy
                sta objpos+15
                lda #1
                sta bomb_released
                lda #<bomb_throw_sfx 
                ldy #>bomb_throw_sfx
                ldx #14
                jsr sfx_play
                
              
                rts
}                
