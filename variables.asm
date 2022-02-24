;***************************************
;
;        TASERED IN THE CROTCH!
;
;     A fun game by Richard Bayliss
;
;       (C)2022 The New Dimension
;
;***************************************

;VARIABLES

;Music parameters

title_music = 0
game_music = 1
get_ready_jingle = 2
game_over_jingle = 3
mission_complete_jingle = 4
music_init = $9000
music_play = $9003
sfx_play = $9006

game_joystick_speed = 3
dir_left = 0
dir_right = 1
boundary_left = $02
boundary_right = $b2

screen = $0400
colour = $d800
score_char_pos = $0799
lives_char_pos = $07a5
escapees_char_pos = $07ab
escapees_intro_pos = $0581+(2*40)
quota_intro_pos = $053b+(2*40)
level_char_pos = $0411

quota_char_pos = $07b1
hiscore_char_pos = $07b9

;Hi score table name entry 

scorelength = 6
namelength = 9
listlength = 5

;Level screen parameters

LEVEL1_Screen_seg2 = LEVEL1_Screen+$100
LEVEL1_Screen_seg3 = LEVEL1_Screen+$200
LEVEL1_Screen_seg4 = LEVEL1_Screen+$2e8

LEVEL2_Screen_seg2 = LEVEL2_Screen+$100
LEVEL2_Screen_seg3 = LEVEL2_Screen+$200
LEVEL2_Screen_seg4 = LEVEL2_Screen+$2e8

LEVEL3_Screen_seg2 = LEVEL3_Screen+$100
LEVEL3_Screen_seg3 = LEVEL3_Screen+$200
LEVEL3_Screen_seg4 = LEVEL3_Screen+$2e8

LEVEL4_Screen_seg2 = LEVEL4_Screen+$100
LEVEL4_Screen_seg3 = LEVEL4_Screen+$200
LEVEL4_Screen_seg4 = LEVEL4_Screen+$2e8

LEVEL5_Screen_seg2 = LEVEL5_Screen+$100
LEVEL5_Screen_seg3 = LEVEL5_Screen+$200
LEVEL5_Screen_seg4 = LEVEL5_Screen+$2e8

LEVEL6_Screen_seg2 = LEVEL6_Screen+$100
LEVEL6_Screen_seg3 = LEVEL6_Screen+$200
LEVEL6_Screen_seg4 = LEVEL6_Screen+$2e8

LEVEL7_Screen_seg2 = LEVEL7_Screen+$100
LEVEL7_Screen_seg3 = LEVEL7_Screen+$200
LEVEL7_Screen_seg4 = LEVEL7_Screen+$2e8

LEVEL8_Screen_seg2 = LEVEL8_Screen+$100
LEVEL8_Screen_seg3 = LEVEL8_Screen+$200
LEVEL8_Screen_seg4 = LEVEL8_Screen+$2e8
