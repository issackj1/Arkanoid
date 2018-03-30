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
		
		b		MainMenuStart
		
GameLoop$:	
		
		ldr		r4,	=gameState
		ldrb	r5,	[r4, #4]			@ball y
		ldrb	r6,	[r4, #6]			@ball veloccity y
		sub		r5,	r6					@apply
		strb	r5,	[r4, #4]			@store
		
		b		DrawGameState
		
GameLoopTop:		
		bl		checkButtons		@wait for input 
		mov		r8, r0
		
		ldr		r0,	=backGround		@clear paddel
		bl		DrawPaddel
		
		ldr		r0,	=backGround		@clear ball
		bl		DrawBall
		
		@go see what was pressed
		
		ldr		r1,	=0xFDFF			@left pressed
		cmp		r8,	r1
		beq		mvl
		
		ldr		r1,	=0xFEFF	
		cmp		r8,	r1				@right pressed
		beq		mvr
		
		@bl		boundsCheck
		
		@check for colision
		
		@increment score in colision
		
		b		GameLoop$
mvl:
		bl		moveLeft
		b		GameLoop$
mvr:
		bl		moveRight
		b		GameLoop$
		
MainMenuStart:
		bl		DrawMenuStartSelected
		bl		checkButtons	
		mov		r8,	r0
		ldr		r1,	=0xFBFF
		cmp		r8,	r1
		beq		MainMenuQuit
		
		ldr		r1,	=0xFF7F
		cmp		r8,	r1
		beq		startGame
		b		MainMenuStart
		
startGame:
		bl		DrawGrid
		b		GameLoop$
		
		
MainMenuQuit:
		bl		DrawMenuQuitSelected
		
		bl		checkButtons
		mov		r8,	r0
		ldr		r1,	=0xF7FF
		cmp		r8,	r1
		beq		MainMenuStart
		
		ldr		r1,	=0xFF7F
		cmp		r8,	r1
		beq		QuitState
		
		b		MainMenuQuit

DrawGameState:
		
		ldr		r0,	=padel
		bl		DrawPaddel
		ldr		r0,	=ball
		bl		DrawBall
		
		b		GameLoopTop

QuitState:
		bl		DrawBlackBackGround
		mov		r0,	#900
		mov		r1,	#350
		ldr		r2, =0xFFFF2416			// colour
		ldr		r3,	=gameOver
		bl		Draw_String
	
	haltLoop$:

		b	GameLoop$
			

@ Data section
.section .data

@ offsets
@ 0 = paddel left corner
@ 1 = paddel middle
@ 2 = paddel right corner
@ 3 = ball x
@ 4 = ball y
@ 5 = velocity x
@ 6 = velocity y
@ 7 = score
@ 8 = Level
@ 9 = Win / Lose Flag

.global gameState
gameState:
.byte		28,29,30		@paddel x coord
.byte		29, 19			@Ball x Coord, y coord,
.byte		0, 1			@Velocity x, Velocity y
.byte		0				@score
.byte		0				@Level
.byte		0				@ Win / Lose


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
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1

endArray:
.align






