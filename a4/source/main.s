@ CPSC 359 L01 Assignment 4
@ Daniel Nwaroh & Issack John & Steve Khanna

@ASSIGNMENT CHECK LIST[]

@Main Menu Screen	  		[done]5
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

		ldr		r0,	=backGround			@clear ball
		bl		DrawBall

		mov		r5, #-1
		str 	r5,	[r4, #7]			@ ball velocity y

		mov		r5, #1
		str 	r5,	[r4, #5]			@ ball velocity x


GameLoopTop:
		
		ldr		r4,	=gameState
		
		ldr		r0,	=backGround			@clear ball
		bl		DrawBall

		bl		checkCollision

		ldrb	r5,	[r4, #4]
		ldr 	r6,	[r4, #7]			@ ball velocity y
		
		add		r5,	r6					@ apply change
		strb	r5,	[r4, #4]			@ store
		
		ldrb	r5,	[r4, #3]
		ldr 	r6,	[r4, #5]			@ ball velocity x
		
		add		r5,	r6					@ apply change
		strb	r5,	[r4, #3]			@ store
		
		bl		DrawGameState			@ Draws the ball and paddel		
				
		bl		checkButtons			@check input
		mov		r8, r0

		bl		ClearBallAndPaddel
		
		ldr		r1,	=0xFDFF				@left pressed
		cmp		r8,	r1
		bleq	moveLeft
		
		ldr		r1,	=0xFEFF	
		cmp		r8,	r1					@right pressed
		bleq	moveRight

		@ implement pause	
		
		b		GameLoopTop
		
MainMenuStart:
		bl		DrawMenuStartSelected	@ Draws the menu with start selected

MainMenuTop:
		bl		checkButtons			@ get input
		mov		r8,	r0

		@ if they press down go to main menu quit selected state
		ldr		r1,	=0xFBFF	
		cmp		r8,	r1
		beq		MainMenuQuit
		
		@ if they press a go to start game state
		ldr		r1,	=0xFF7F
		cmp		r8,	r1
		beq		startGame
		
		b		MainMenuTop
		
MainMenuQuit:
		bl		DrawMenuQuitSelected @ Draws the menu with Quit selected
		
		bl		checkButtons
		mov		r8,	r0

		@ if the press up go to main menu play selected
		ldr		r1,	=0xF7FF
		cmp		r8,	r1
		beq		MainMenuStart
		
		@ if they press a then go to the quit game state
		ldr		r1,	=0xFF7F
		cmp		r8,	r1
		beq		QuitState
		
		b		MainMenuQuit
		
startGame:
		bl		DrawGrid				@ Draws the grid on the screen

startGameTop:
		bl		ClearBallAndPaddel
		bl		DrawGameState

		bl		checkButtons			@ checks input

		@ if they press a then launch the ball and start the game
		mov		r8,	r0
		ldr		r1,	=0xFF7F
		cmp		r8,	r1
		beq		GameLoop$

		ldr		r1,	=0xFDFF				@left pressed
		cmp		r8,	r1
		bleq	moveLeft

		ldr		r1,	=0xFEFF	
		cmp		r8,	r1					@right pressed
		bleq	moveRight

		b		startGameTop

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
@ 9 = velocity y
@ 13 = score
@ 14 = Level
@ 15 = Win / Lose Flag
@ 16 = minimum x
@ 17 = maximum x
@ 18 = minimum y
@ 19 = maximum y

.global gameState
gameState:
.byte		28,29,30		@ paddel x coord
.byte		29, 19			@ Ball x Coord, y coord,
.int		0 				@ Velocity x
.int		0				@ Velocity y

@.byte		0				@ score
@.byte		0				@ Level
@.byte		0				@ Win / Lose
@.byte		20,	40			@ mix x, max x
@.byte		2,	22			@ min y, max y


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






