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
		bl		initGPIO
		
		b		startState
		
GameLoop$:		
		
startState:
		bl		DrawMenuStartSelected
		bl		checkButtons	
		mov		r8,	r0
		ldr		r1,	=0xFBFF
		cmp		r8,	r1
		beq		QuitState
		
		ldr		r1,	=0xFF7F
		cmp		r8,	r1
		beq		playState

		b		startState
		
		
QuitState:
		bl		DrawMenuQuitSelected
		
		bl		checkButtons
		mov		r8,	r0
		ldr		r1,	=0xF7FF
		cmp		r8,	r1
		beq		startState
		
		b		QuitState

playState:
		bl		DrawGrid
	
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






