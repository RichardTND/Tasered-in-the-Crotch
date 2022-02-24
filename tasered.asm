;***************************************
;
;        TASERED IN THE CROTCH!
;
;     A fun game by Richard Bayliss
;
;       (C)2022 The New Dimension
;
;***************************************

;MAIN TARGET PROJECT

        !to "tasered.prg",cbm

;Include source code file - VARIABLES. We need those 
;for this project. 

;****************************************
        !source "variables.asm"
        !source "macros.asm"
;****************************************

;cheatlives = 1
           
;Import 1x2 character set data
       
        *  = $0800
        !bin "bin\1x2charset.prg",,2
        
        ;Hi score table code
        * = $1000
        !source "hiscore.asm"
        

;Import music data 
        * = $9000
        !bin "bin\music.prg",,2
       
;Import game map data (Uncompressed, since there is plenty of memory
        *=$a400
LEVEL1_Screen
          !bin "bin\LEVEL1SCREEN.bin"
        *=$a800
LEVEL2_Screen        
          !bin "bin\LEVEL2SCREEN.bin"
        *=$ac00
LEVEL3_Screen
          !bin "bin\LEVEL3SCREEN.bin"
        *=$b000
LEVEL4_Screen
          !bin "bin\LEVEL4SCREEN.bin"
        *=$b400
LEVEL5_Screen
          !bin "bin\LEVEL5SCREEN.bin"
        *=$b800
LEVEL6_Screen
          !bin "bin\LEVEL6SCREEN.bin"
        *=$bc00
LEVEL7_Screen
          !bin "bin\LEVEL7SCREEN.bin"
        *=$c000
LEVEL8_Screen 
          !bin "bin\LEVEL8SCREEN.bin"
          
        
;Import game sprites
        * = $2000
        !bin "bin\gamesprites.bin"

;Import title screen data
        * = $2800
title_screen
        !bin "bin\titlescreen.bin"
;and attributes
        * = $2c00
title_attribs
        !bin "bin\titleattribs.bin"

;Import game screen data 
        * = $3000 
game_screen
        !bin "bin\gamescreen.bin"
;and attributes
        * = $3400
game_attribs
        !bin "bin\gameattribs.bin"
        * = $3400
        !BYTE 7
        * = $3800 
;Game charset
        !bin "bin\charset.bin"
;****************************************
        * = $4000
        jsr pal_ntsc_check
        lda #$35
        sta $01
        !source "titlecode.asm"
        !source "gamecode.asm"
;****************************************