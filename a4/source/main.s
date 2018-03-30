@ CPSC 359 L01 Assignment 4
@ Daniel Nwaroh & Issack John & Steve Khanna

@ASSIGNMENT CHECK LIST[]

@Main Menu Screen	  	[]5
@Draw game State 		[]29
@Draw game menu	  		[]4
@interact with game	  	[]8
@interact with game menu	[]4


@ Code section
.section .text


.global main
main:
		@ ask for the frame buffer information
		ldr		r0, =frameBufferInfo		@frame buffer information structure
		bl		initFbInfo
		
		@bl		initGPIO
		@mov		r0,	#500
		@mov		r1, #500
		@bl		DrawSquare

		//Game_Name

	//Game_Name
	ldr		r0, =0x1F0			// x coordinate
	ldr		r1, =0x6C			// y coordinate
	ldr		r2, =0xF860		// colour
	ldr		r3, =gameName
	bl		Draw_String

	//Creator_Names
	ldr		r0, =0x137			// x coordinate
	ldr		r1, =0x30			// y coordinate
	ldr		r2, =0xF860	
	ldr		r3, =names
	bl		Draw_String

	//Main_Menu
	ldr		r0, =0x196			// x coordinate
	ldr		r1, =0x4E			// y coordinate
	ldr		r2, =0xF860	
	ldr		r3, =mainMenu
	bl		Draw_String

	//Start_Game
	ldr		r0, =0x1DC			// x coordinate
	ldr		r1, =0x180			// y coordinate
	ldr		r2, =0xF860
	ldr		r3, =playGameSelect
	bl		Draw_String

	//Quit_Game
			// prints "QUIT GAME"
	ldr		r0, =0x1E1			// x coordinate
	ldr		r1, =0x19E			// y coordinate
	ldr		r2, =0xF860
	ldr		r3, =quit
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
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

endArray:
.align






