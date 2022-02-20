;----------------------------------------------------
;             TASERED IN THE CROTCH
;               BY RICHARD BAYLISS
;           (C) 2022 THE NEW DIMENSION
;----------------------------------------------------

;LEVEL DATA

            
LEVEL1_enemy_select_table
                !byte 0,1,2,0,2,2,1,2,5,1,2,1,0,1,2,0
                !byte 2,1,2,0,2,1,2,2,1,0,2,0,1,2,1,2
                !byte 1,2,1,4,1,0,1,0,1,2,0,1,2,1,1,2
                !byte 2,1,2,1,0,1,1,2,3,1,2,1,0,1,2,1
                !byte 0,1,1,0,1,2,0,1,0,0,1,1,2,1,2,0

LEVEL1_enemy_dir_select_table
                !byte 0,1,1,0,1,0,1,1,0,1,0,1,0,1,0,1
                !byte 0,1,1,0,0,0,1,0,0,1,1,0,0,1,0,0
                !byte 1,0,1,0,1,1,0,1,1,0,1,0,1,0,1,0
                !byte 1,0,0,1,0,1,0,0,0,1,0,1,0,1,0,0
                !byte 0,1,0,1,0,0,1,0,1,0,1,0,1,0,1,1

LEVEL1_enemy_speed_table 
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

LEVEL1_enemy_drag_active_table
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

LEVEL1_enemy_drag_speed_table 
                
                !byte 3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2
                !byte 2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3
                !byte 3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2
                !byte 2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3
                !byte 3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2

LEVEL1_Quota    !byte $30,$32,$30
LEVEL1_Escapee_Count !byte $32,$30


             
LEVEL2_enemy_select_table
                !byte 2,1,0,2,2,1,0,1,0,1,4,0,1,2,1,2
                !byte 0,2,3,1,0,2,3,1,2,2,1,3,0,1,2,2
                !byte 2,3,2,1,1,2,3,1,0,0,0,2,2,2,1,1
                !byte 1,0,0,3,2,3,1,1,2,1,3,2,1,2,3,1
                !byte 2,2,0,1,3,5,2,1,2,3,0,2,1,1,3,1

LEVEL2_enemy_dir_select_table
                !byte 1,0,1,1,0,1,0,1,1,1,0,1,0,1,0,1
                !byte 1,0,0,0,1,1,1,0,1,1,0,1,1,0,1,0
                !byte 0,1,0,1,1,0,1,1,0,1,0,1,0,0,1,0
                !byte 0,1,0,1,0,1,1,0,1,1,0,1,1,0,1,0
                !byte 1,0,1,0,1,0,1,0,1,0,1,0,0,1,0,1

LEVEL2_enemy_speed_table 
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

LEVEL2_enemy_drag_active_table
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

LEVEL2_enemy_drag_speed_table 
                !byte 3,2,2,3,2,2,3,2,2,3,2,2,3,2,2,3
                !byte 2,2,3,2,2,3,2,2,3,2,2,3,2,2,3,2
                !byte 2,3,2,2,3,2,2,3,2,2,3,2,2,3,2,2
                !byte 3,2,2,3,2,2,3,2,2,3,2,2,3,2,2,3
                !byte 2,2,3,2,2,3,2,2,3,2,2,3,2,2,3,2
                

LEVEL2_Quota    !byte $30,$33,$30
LEVEL2_Escapee_Count !byte $31,$35



LEVEL3_enemy_select_table
                !byte 1,0,2,0,1,0,2,0,4,0,2,0,3,0,1,0
                !byte 2,1,0,2,0,1,0,3,0,1,4,0,2,0,1,2
                !byte 3,1,0,2,0,3,0,2,4,0,4,2,3,1,3,2
                !byte 1,3,4,2,5,1,3,4,1,2,1,3,1,2,4,5
                !byte 1,4,3,2,1,0,2,1,0,2,0,3,2,1,4,1
               

LEVEL3_enemy_dir_select_table
                !byte 1,0,1,1,0,1,1,1,0,0,1,0,0,1,0,1
                !byte 1,0,0,0,1,0,1,0,1,1,0,1,1,0,1,1
                !byte 1,0,1,1,1,1,0,1,1,0,0,0,1,1,0,1
                !byte 0,1,0,0,0,1,0,0,1,0,1,0,1,0,0,1
                !byte 1,0,1,1,1,0,1,0,1,1,0,1,1,0,1,0
LEVEL3_enemy_speed_table 
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

LEVEL3_enemy_drag_active_table
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

LEVEL3_enemy_drag_speed_table 
                !byte 1,2,2,1,2,2,2,2,2,1,2,2,2,2,1,2
                !byte 2,1,2,2,2,1,2,2,1,2,2,2,2,1,2,2
                !byte 2,2,1,2,2,2,2,2,2,2,2,1,2,2,2,2
                !byte 2,1,2,2,2,2,2,1,2,2,2,2,2,1,2,2
                !byte 2,2,2,1,2,2,2,1,2,2,1,2,2,2,2,2
                

LEVEL3_Quota    !byte $30,$34,$30
LEVEL3_Escapee_Count !byte $32,$30



LEVEL4_enemy_select_table
                !byte 1,0,1,1,0,1,2,4,1,0,2,0,1,0,1,2
                !byte 2,0,1,5,1,0,1,2,1,2,4,1,0,5,1,2
                !byte 1,5,2,3,1,2,0,1,2,1,0,3,1,2,1,2
                !byte 1,0,2,1,0,1,5,1,0,2,1,0,2,1,0,2
                !byte 3,1,2,1,2,3,1,4,2,1,5,1,2,1,2,1
       

LEVEL4_enemy_dir_select_table
                !byte 1,0,1,1,0,1,1,1,0,0,1,0,0,1,0,1
                !byte 1,0,0,0,1,0,1,0,1,1,0,1,1,0,1,1
                !byte 1,0,1,1,1,1,0,1,1,0,0,0,1,1,0,1
                !byte 0,1,0,0,0,1,0,0,1,0,1,0,1,0,0,1
                !byte 1,0,1,1,1,0,1,0,1,1,0,1,1,0,1,0
LEVEL4_enemy_speed_table 
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

LEVEL4_enemy_drag_active_table
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

LEVEL4_enemy_drag_speed_table 
                !byte 1,2,2,1,2,2,2,2,2,1,2,2,2,2,1,2
                !byte 2,1,2,2,2,1,2,2,1,2,2,2,2,1,2,2
                !byte 2,2,1,2,2,2,2,2,2,2,2,1,2,2,2,2
                !byte 2,1,2,2,2,2,2,1,2,2,2,2,2,1,2,2
                !byte 2,2,2,1,2,2,2,1,2,2,1,2,2,2,2,2
                

LEVEL4_Quota    !byte $30,$33,$30
LEVEL4_Escapee_Count !byte $31,$30

LEVEL5_enemy_select_table
                !byte 1,2,4,3,1,5,1,2,3,1,2,1,3,2,1,2
                !byte 3,1,4,0,1,0,2,0,1,3,1,0,2,1,0,1
                !byte 1,3,1,0,2,3,1,2,0,2,1,3,5,0,1,2
                !byte 1,0,2,3,1,2,1,0,1,0,2,1,2,0,1,2
                !byte 3,1,5,2,4,1,0,2,0,1,4,0,2,1,4,0

LEVEL5_enemy_dir_select_table
                !byte 0,1,0,1,1,0,1,0,1,1,0,1,0,1,0,1
                !byte 1,0,1,0,0,1,0,1,0,0,1,0,1,1,0,0
                !byte 0,1,1,0,1,1,0,0,1,0,1,0,1,1,0,0
                !byte 0,1,0,0,1,0,0,1,0,1,1,1,0,1,0,1
                !byte 0,1,0,0,1,0,0,1,0,1,1,0,1,0,1,0
LEVEL5_enemy_speed_table 
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

LEVEL5_enemy_drag_active_table
                !byte 1,1,1,1,0,1,0,1,1,0,1,1,1,1,1,0
                !byte 1,1,1,1,0,1,1,1,1,0,1,1,1,1,1,0
                !byte 1,0,1,1,0,1,1,1,1,0,1,1,1,0,1,0
                !byte 1,1,1,1,0,1,1,0,1,0,1,1,1,1,1,0
                !byte 1,1,1,1,0,1,1,1,1,0,1,1,1,1,1,0

LEVEL5_enemy_drag_speed_table 
                !byte 1,2,2,1,0,2,2,2,2,0,2,2,2,2,1,0
                !byte 2,1,2,2,0,1,2,2,1,0,2,2,2,1,2,0
                !byte 2,2,1,2,0,2,2,2,2,0,2,1,2,2,2,0
                !byte 2,1,2,2,0,2,2,1,2,0,2,2,2,1,2,0
                !byte 2,2,2,1,0,2,2,1,2,0,1,2,2,2,2,0
                
                

LEVEL5_Quota    !byte $30,$33,$30
LEVEL5_Escapee_Count !byte $33,$30


LEVEL6_enemy_select_table
                !byte 2,5,1,4,3,2,0,4,2,3,0,1,0,2,4,3
                !byte 2,0,1,3,1,2,4,5,2,3,1,5,2,4,1,0
                !byte 3,1,4,2,3,1,5,2,0,4,1,2,3,1,4,1
                !byte 2,4,1,5,1,3,1,0,2,4,3,1,5,1,2,0
                !byte 1,3,1,2,4,1,5,0,5,1,2,4,0,1,5,0
LEVEL6_enemy_dir_select_table
                !byte 1,0,0,1,0,1,1,1,0,1,1,0,0,1,1,0
                !byte 0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,0
                !byte 1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,0
                !byte 0,1,0,1,1,0,1,1,1,0,1,1,0,1,0,1
                !byte 1,0,0,0,1,0,0,1,0,1,0,0,1,0,1,0
                
LEVEL6_enemy_speed_table 
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

LEVEL6_enemy_drag_active_table
                !byte 1,0,1,1,0,1,0,1,1,0,1,1,0,1,1,0
                !byte 1,1,0,1,0,1,1,0,1,0,1,1,1,1,1,0
                !byte 1,0,1,1,0,1,0,1,1,0,1,0,1,0,1,0
                !byte 1,1,0,1,0,1,1,0,1,0,1,1,1,1,1,0
                !byte 1,1,1,1,0,1,0,1,1,0,1,1,0,1,1,0

LEVEL6_enemy_drag_speed_table 
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                
LEVEL6_Quota    !byte $30,$34,$30
LEVEL6_Escapee_Count !byte $32,$30


LEVEL7_enemy_select_table
                !byte 1,0,2,4,3,2,0,1,5,0,1,3,1,2,0,2
                !byte 3,0,5,1,2,0,3,4,1,3,5,2,4,3,1,2
                !byte 0,1,3,2,5,1,0,2,3,1,2,2,1,1,0,2
                !byte 3,1,2,2,1,2,1,0,2,1,3,1,2,0,1,2
                !byte 3,1,2,3,1,2,4,1,2,0,3,1,5,1,2,0
LEVEL7_enemy_dir_select_table
                !byte 1,1,0,1,1,0,0,1,0,1,1,0,0,1,0,1
                !byte 1,0,1,1,0,1,0,0,1,1,0,1,0,0,1,1
                !byte 1,1,0,0,1,1,1,0,1,1,0,1,1,0,1,0
                !byte 0,1,1,0,1,1,0,1,1,0,1,0,0,1,1,0
                !byte 1,0,1,1,0,1,1,0,1,0,1,0,0,1,0,1
                
LEVEL7_enemy_speed_table 
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

LEVEL7_enemy_drag_active_table
                !byte 1,0,1,0,0,1,0,1,0,0,0,1,0,1,0,0
                !byte 0,1,0,1,0,1,0,0,1,0,1,0,0,0,1,0
                !byte 1,0,1,1,0,0,0,1,0,0,1,0,1,0,1,0
                !byte 1,1,0,1,0,1,0,0,1,0,1,0,1,0,1,0
                !byte 1,0,1,0,0,1,0,1,1,0,1,1,0,1,1,0

LEVEL7_enemy_drag_speed_table 
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                
LEVEL7_Quota    !byte $30,$34,$30
LEVEL7_Escapee_Count !byte $32,$35



LEVEL8_enemy_select_table
                !byte 1,0,2,4,3,2,0,1,5,0,1,3,1,2,0,2
                !byte 3,0,5,1,2,0,3,4,1,3,5,2,4,3,1,2
                !byte 0,1,3,2,5,1,0,2,3,1,2,2,1,1,0,2
                !byte 3,1,2,2,1,2,1,0,2,1,3,1,2,0,1,2
                !byte 3,1,2,3,1,2,4,1,2,0,3,1,5,1,2,0
LEVEL8_enemy_dir_select_table
                !byte 1,1,0,1,1,0,0,1,0,1,1,0,0,1,0,1
                !byte 1,0,1,1,0,1,0,0,1,1,0,1,0,0,1,1
                !byte 1,1,0,0,1,1,1,0,1,1,0,1,1,0,1,0
                !byte 0,1,1,0,1,1,0,1,1,0,1,0,0,1,1,0
                !byte 1,0,1,1,0,1,1,0,1,0,1,0,0,1,0,1
                
LEVEL8_enemy_speed_table 
                !byte 1,1,1,1,1,1,2,1,1,1,1,1,2,1,1,1
                !byte 1,1,2,1,1,1,1,1,2,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,2,1,1,1,1,2,1,1,1,1,1
                !byte 1,1,1,2,1,1,1,2,1,1,1,1,1,2,1,1
                !byte 1,2,1,1,1,1,2,1,1,1,1,2,1,1,1,1

LEVEL8_enemy_drag_active_table
                !byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                !byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                !byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                !byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                !byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

LEVEL8_enemy_drag_speed_table 
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                !byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                
LEVEL8_Quota    !byte $30,$35,$30
LEVEL8_Escapee_Count !byte $35,$30


;----------------------------------------------------
;     Low and Hi Bytes for level selfmod data
;----------------------------------------------------
;!align $ff,0

level_enemy_select_table_lo
                !byte <LEVEL1_enemy_select_table ;1
                !byte <LEVEL2_enemy_select_table ;2
                !byte <LEVEL3_enemy_select_table ;3
                !byte <LEVEL4_enemy_select_table ;4
                !byte <LEVEL5_enemy_select_table ;5
                !byte <LEVEL6_enemy_select_table ;6
                !byte <LEVEL7_enemy_select_table ;7
                !byte <LEVEL8_enemy_select_table ;8
                
level_enemy_select_table_hi                
                !byte >LEVEL1_enemy_select_table ;1
                !byte >LEVEL2_enemy_select_table ;2
                !byte >LEVEL3_enemy_select_table ;3
                !byte >LEVEL4_enemy_select_table ;4
                !byte >LEVEL5_enemy_select_table ;5
                !byte >LEVEL6_enemy_select_table ;6
                !byte >LEVEL7_enemy_select_table ;7
                !byte >LEVEL8_enemy_select_table ;8
                
level_enemy_dir_select_table_lo
                !byte <LEVEL1_enemy_dir_select_table ;1
                !byte <LEVEL2_enemy_dir_select_table ;2 
                !byte <LEVEL3_enemy_dir_select_table ;3
                !byte <LEVEL4_enemy_dir_select_table ;4
                !byte <LEVEL5_enemy_dir_select_table ;5
                !byte <LEVEL6_enemy_dir_select_table ;6
                !byte <LEVEL7_enemy_dir_select_table ;7
                !byte <LEVEL8_enemy_dir_select_table ;8
                
level_enemy_dir_select_table_hi

                !byte >LEVEL1_enemy_dir_select_table ;1
                !byte >LEVEL2_enemy_dir_select_table ;2
                !byte >LEVEL3_enemy_dir_select_table ;3
                !byte >LEVEL4_enemy_dir_select_table ;4
                !byte >LEVEL5_enemy_dir_select_table ;5
                !byte >LEVEL6_enemy_dir_select_table ;6
                !byte >LEVEL7_enemy_dir_select_table ;7
                !byte >LEVEL8_enemy_dir_select_table ;8
                
level_enemy_speed_table_lo 
                !byte <LEVEL1_enemy_speed_table ;1
                !byte <LEVEL2_enemy_speed_table ;2
                !byte <LEVEL3_enemy_speed_table ;3
                !byte <LEVEL4_enemy_speed_table ;4
                !byte <LEVEL5_enemy_speed_table ;5
                !byte <LEVEL6_enemy_speed_table ;6
                !byte <LEVEL7_enemy_speed_table ;7
                !byte <LEVEL8_enemy_speed_table ;8
                
level_enemy_speed_table_hi 
                !byte >LEVEL1_enemy_speed_table ;1
                !byte >LEVEL2_enemy_speed_table ;2
                !byte >LEVEL3_enemy_speed_table ;3
                !byte >LEVEL4_enemy_speed_table ;4
                !byte >LEVEL5_enemy_speed_table ;5
                !byte >LEVEL6_enemy_speed_table ;6
                !byte >LEVEL7_enemy_speed_table ;7
                !byte >LEVEL8_enemy_speed_table ;8
                
level_enemy_drag_active_table_lo                
                !byte <LEVEL1_enemy_drag_active_table ;1
                !byte <LEVEL2_enemy_drag_active_table ;2 
                !byte <LEVEL3_enemy_drag_active_table ;3
                !byte <LEVEL4_enemy_drag_active_table ;4
                !byte <LEVEL5_enemy_drag_active_table ;5
                !byte <LEVEL6_enemy_drag_active_table ;6
                !byte <LEVEL7_enemy_drag_active_table ;7
                !byte <LEVEL8_enemy_drag_active_table ;8
                
level_enemy_drag_active_table_hi 
                !byte >LEVEL1_enemy_drag_active_table ;1
                !byte >LEVEL2_enemy_drag_active_table ;2
                !byte >LEVEL3_enemy_drag_active_table ;3
                !byte >LEVEL4_enemy_drag_active_table ;4
                !byte >LEVEL5_enemy_drag_active_table ;5
                !byte >LEVEL6_enemy_drag_active_table ;6
                !byte >LEVEL7_enemy_drag_active_table ;7 
                !byte >LEVEL8_enemy_drag_active_table ;8

level_enemy_drag_speed_table_lo
                !byte <LEVEL1_enemy_drag_speed_table ;1
                !byte <LEVEL2_enemy_drag_speed_table ;2
                !byte <LEVEL3_enemy_drag_speed_table ;3
                !byte <LEVEL4_enemy_drag_speed_table ;4
                !byte <LEVEL5_enemy_drag_speed_table ;5
                !byte <LEVEL6_enemy_drag_speed_table ;6 
                !byte <LEVEL7_enemy_drag_speed_table ;7
                !byte <LEVEL8_enemy_drag_speed_table ;8
                
level_enemy_drag_speed_table_hi
                !byte >LEVEL1_enemy_drag_speed_table ;1
                !byte >LEVEL2_enemy_drag_speed_table ;2
                !byte >LEVEL3_enemy_drag_speed_table ;3
                !byte >LEVEL4_enemy_drag_speed_table ;4
                !byte >LEVEL5_enemy_drag_speed_table ;5
                !byte >LEVEL6_enemy_drag_speed_table ;6
                !byte >LEVEL7_enemy_drag_speed_table ;7
                !byte >LEVEL8_enemy_drag_speed_table ;8
                
level_quota_lo  !byte <LEVEL1_Quota ;1
                !byte <LEVEL2_Quota ;2
                !byte <LEVEL3_Quota ;3
                !byte <LEVEL4_Quota ;4
                !byte <LEVEL5_Quota ;5
                !byte <LEVEL6_Quota ;6
                !byte <LEVEL7_Quota ;7
                !byte <LEVEL8_Quota ;8
                
level_quota_hi 
                !byte >LEVEL1_Quota ;1
                !byte >LEVEL2_Quota ;2
                !byte >LEVEL3_Quota ;3
                !byte >LEVEL4_Quota ;4
                !byte >LEVEL5_Quota ;5
                !byte >LEVEL6_Quota ;6
                !byte >LEVEL7_Quota ;7
                !byte >LEVEL8_Quota ;8
                
level_Escapee_Count_lo
                
                !byte <LEVEL1_Escapee_Count ;1
                !byte <LEVEL2_Escapee_Count ;2
                !byte <LEVEL3_Escapee_Count ;3
                !byte <LEVEL4_Escapee_Count ;4
                !byte <LEVEL5_Escapee_Count ;5
                !byte <LEVEL6_Escapee_Count ;6
                !byte <LEVEL7_Escapee_Count ;7
                !byte <LEVEL8_Escapee_Count ;8
                
level_Escapee_Count_hi 

                !byte >LEVEL1_Escapee_Count ;1
                !byte >LEVEL2_Escapee_Count ;2
                !byte >LEVEL3_Escapee_Count ;3
                !byte >LEVEL4_Escapee_Count ;4
                !byte >LEVEL5_Escapee_Count ;5
                !byte >LEVEL6_Escapee_Count ;6
                !byte >LEVEL7_Escapee_Count ;7
                !byte >LEVEL8_Escapee_Count ;8
                
      