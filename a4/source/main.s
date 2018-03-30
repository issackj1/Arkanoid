@ CPSC 359 L01 Assignment 4
@ Daniel Nwaroh & Issack John & Steve Khanna

@ASSIGNMENT CHECK LIST[]

@Main Menu Screen	  		[]5
@Draw game State 			[]29
@Draw game menu	  			[]4
@interact with game	  		[]8
@interact with game menu	[]4


@ Code section
.section .text


.global main
main:
		@ ask for the frame buffer information
		ldr		r0, =frameBufferInfo		@frame buffer information structure
		bl		initFbInfo
		
		@bl		initGPIO
		bl		DrawGrid
		

		//Game_Name
		mov		r0,	#920
		mov		r1,	#130
		ldr		r2, =0xFFFF2416			// colour
		ldr		r3, =gameName
		bl		Draw_String

		//Main_Menu
		mov		r0,	#910
		mov		r1,	#250
		ldr		r2, =0xFFFF2416		
		ldr		r3, =mainMenu
		bl		Draw_String

		//Play_Game
		mov		r0,	#900
		mov		r1,	#350
		ldr		r2, =0xFFFF2416	
		ldr		r3, =playGameSelect
		bl		Draw_String

		@prints "QUIT"
		mov		r0,	#940
		mov		r1,	#450
		ldr		r2, =0xFFFF2416	
		ldr		r3, =quit
		bl		Draw_String
		
		//Creator_Names
		mov		r0,	#700
		mov		r1,	#550
		ldr		r2, =0xFFFF2416		
		ldr		r3, =names
		bl		Draw_String
	
	haltLoop$:

		b	haltLoop$
			

@ Data section
.section .data

.align
.global frameBufferInfo
frameBufferInfo:
.int	0
.int	0
.int	0

@For drawing ASCII TEXT
.global font
.align 4
font:	.incbin "font.bin"

.global imageWidth
imageWidth:
.int	0

.global imageHeight
imageHeight:
.int	0

.global imageArray
imageArray:
.byte		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,1
.byte		1,0,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,0,1
.byte		1,0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,5,5,5,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1

endArray:
.align






