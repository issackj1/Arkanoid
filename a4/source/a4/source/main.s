@ CPSC 359 L01 Assignment 4
@ Daniel Nwaroh & Issack John & Steve Khanna

@ASSIGNMENT CHECK LIST[]

@Main Menu Screen	  		[done]5
@Draw game State 			[]29		@missing 11 marsk
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

		mov		r5, #-1
		str 	r5,	[r4, #9]			@ ball velocity y

		mov		r5, #1
		str 	r5,	[r4, #5]			@ ball velocity x
		
		mov		r5,	#0
		strb	r5,	[r4, #17]


GameLoopTop:
		
		ldr		r4,	=gameState
		
		ldrb	r5,	[r4, #4]
		
		bl		checkCollision
		
		ldr 	r6,	[r4, #9]			@ ball velocity y
		
		add		r5,	r6					@ apply change
		strb	r5,	[r4, #4]			@ store
		
		ldrb	r5,	[r4, #3]
		ldr 	r6,	[r4, #5]			@ ball velocity x
		
		add		r5,	r6					@ apply change
		strb	r5,	[r4, #3]			@ store
		
		bl		DrawGameState			@ Draws the ball and paddel	
		
		ldrb	r5,	[r4, #4]
		
		ldrb	r6,	[r4, #13]
		cmp		r5,	#20
		subeq	r6, #1	
		bleq	reset
		
		strb	r6,	[r4, #13]
		
		ldrb	r6,	[r4, #13]
		cmp		r6,	#0
		beq		youLost	
				
		bl		checkButtons			@check input
		mov		r8, r0

		@bl		ClearBallAndPaddel
		
		ldr		r1,	=0xFDFF				@left pressed
		cmp		r8,	r1
		bleq	moveLeft
		
		ldr		r1,	=0xFEFF	
		cmp		r8,	r1					@right pressed
		bleq	moveRight
		
		ldr		r1,	=0xEFFF
		cmp		r8,	r1
		bleq	pauseMenu
		
		ldr		r1,	=0x7FFF
		cmp		r8,	r1
		beq		GameLoop$

		@mov		r0,	#20000
		@bl		delayMicroseconds
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
		
		@ if they press b go to start game state
		ldr		r1,	=0xFF7F
		cmp		r8,	r1
		beq		startGame
		
		b		MainMenuTop
		
MainMenuQuit:
		bl		DrawMenuQuitSelected @ Draws the menu with Quit selected
		
MainMenuQuitTop:
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
		
		b		MainMenuQuitTop
		
startGame:
		@bl		DrawGrid				@ Draws the grid on the screen
		bl		ClearBallAndPaddel
		
		bl		DrawGameState

startGameTop:

		bl		checkButtons			@ checks input

		@ if they press a then launch the ball and start the game
		mov		r8,	r0
		ldr		r1,	=0x7FFF
		cmp		r8,	r1
		beq		GameLoop$

		ldr		r1,	=0xFDFF				@left pressed
		cmp		r8,	r1
		bleq	moveLeft

		ldr		r1,	=0xFEFF	
		cmp		r8,	r1					@right pressed
		bleq	moveRight
		
		ldr		r1,	=0xEFFF
		cmp		r8,	r1
		bleq	pauseMenu

		b		startGameTop

youLost:
		ldr		r4,	=gameState
		
		@ DRAW YOU LOST IMAGE
		bl		DrawBlackBackGround
		bl		DrawYouLose
		
		b		haltLoop$
		
reset:
		push	{r4-r7, lr}
		
		ldr		r4,	=gameState
		
		mov		r5,	#1
		strb	r5,	[r4, #17]
		
		mov		r5, #29
		strb	r5,	[r4, #3]			@ reset ball x
		
		mov		r5, #0					@ reset ball xvelocity
		str 	r5,	[r4, #5]
		
		mov		r5, #19
		strb	r5,	[r4, #4]			@ reset ball y
		
		mov		r5, #0					@ reset ball yvelocity
		str		r5,	[r4, #9]
		
		mov		r5, #28
		strb	r5,	[r4, #0]			@ reset paddel
		
		mov		r5, #29
		strb	r5,	[r4, #1]			@ reset paddel
		
		mov		r5, #30
		strb	r5,	[r4, #2]			@ reset paddel
		
		mov		r5,	#1
		strb	r5,	[r4, #17]
		
		pop		{r4-r7, pc}

pauseMenu:

		push	{r4-r7, lr}
		
pauseMenuTop:
		mov	r0,	#672
		mov	r1,	#200
		ldr	r8, =imageWidth
		mov	r7, #576
		str	r7, [r8]
		ldr	r8, =imageHeight
		mov	r6, #324
		str	r6, [r8]
		ldr	r2, =restart
		bl	drawImage
		bl	checkButtons
		
		mov		r8,	r0
		
		//ldr		r1,	=0xF7FF     //Up or down 
		//cmp		r8,	r1
		//beq		restartQuitSelected
		
		ldr		r1, =0xFBFF
		cmp		r8, r1
		beq		restartQuitSelected
		
		ldr		r1, =0xEFFF		//start
		cmp		r8, r1
		beq		resumeGame
		
		ldr		r1, =0xFF7F		@ a
		cmp		r8, r1
		beq		haltLoop$		@ has to be implemented
		
		b		pauseMenuTop
		
restartQuitSelected:
		mov	r0,	#672
		mov	r1,	#200
		ldr	r8, =imageWidth
		mov	r7, #576
		str	r7, [r8]
		ldr	r8, =imageHeight
		mov	r6, #324
		str	r6, [r8]
		ldr	r2, =restartQuit
		bl	drawImage
		bl	checkButtons
		
		mov		r8,	r0
		ldr		r1,	=0xF7FF     //Up or down 
		cmp		r8,	r1
		beq		pauseMenuTop
		//ldr		r1, =0xFBFF
		//cmp		r8, r1
		//beq		pauseMenuTop
		ldr		r1, =0xEFFF		//start
		cmp		r8, r1
		beq		resumeGame
		
		ldr		r1, =0xFF7F
		cmp		r8, r1
		beq		MainMenuStart
		
		b		restartQuitSelected

resumeGame:
		pop		{r4-r7, pc}

QuitState:
		bl		DrawBlackBackGround
		mov		r0,	#900
		mov		r1,	#350
		ldr		r2, =0xFFFF2416			// colour
		ldr		r3,	=gameOver
		bl		Draw_String
	
	haltLoop$:

		b	haltLoop$
			

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
@ 13 = Lives
@ 14 = Score
@ 15 = Level
@ 16 = Win / Lose Flag
@ 17 = reset flag

.global gameState
gameState:
.byte		28,29,30		@ paddel x coord
.byte		29, 19			@ Ball x Coord, y coord,
.int		0 				@ Velocity x
.int		0				@ Velocity y
.byte		3				@ Lives
.byte		0				@ score
.byte		0				@ Level
.byte		0				@ Win / Lose
.byte		1				@ reset condition flag


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
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
.byte		1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1

endArray:
.align






