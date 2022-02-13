;***************************************
;
;        TASERED IN THE CROTCH!
;
;     A fun game by Richard Bayliss
;
;       (C)2022 The New Dimension
;
;***************************************

;cheatlives = 1
;MAIN TARGET PROJECT

        !to "tasered.prg",cbm

;Include source code file - VARIABLES. We need those 
;for this project. 

;****************************************
        !source "variables.asm"
;****************************************


           
;Import 1x2 character set data
       
        *  = $0800
        !bin "bin\1x2charset.prg",,2
        
        ;Hi score table code
        * = $1000
        !source "hiscore.asm"
        

;Import music data 
        * = $9000
        !bin "bin\music.prg",,2
       

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