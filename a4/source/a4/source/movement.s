@ CPSC 359 L01 Assignment 4
@ Author Issack John

@BOARD VALID BOUNDS IS X = 22 -38
@BOARD VALID BOUNDS IS Y = 2 - 22

@ Code section
.section .text


.global moveLeft
moveLeft:
		push	{r4-r7, lr}
		
		ldr		r4,	=gameState
		mov		r7,	#0
		
		ldrb	r5,	[r4, r7]
		cmp		r5,	#21
		ble		dontMoveLeft
		
movePaddelLeftAgain:
		ldrb	r5,	[r4, r7]
		add		r5,	#-1
		strb	r5,	[r4, r7]

		add		r7,	#1
		cmp		r7,	#3
		blt		movePaddelLeftAgain
dontMoveLeft:

		ldrb	r6,	[r4, #17]
		cmp		r6,	#1
		bne		resetFalse
		ldrb	r8,	[r4, #3]
		cmp		r8,	#22
		ble		resetFalse
		add		r8,	#-1
		strb	r8,	[r4, #3]
resetFalse:	

		bl		ClearBallAndPaddel
		bl		DrawGameState
		
		pop		{r4-r7, pc}

.global	moveRight
moveRight:
		push	{r4-r9, lr}
		
		ldr		r4,	=gameState
		mov		r7,	#0
		
		ldrb	r8,	[r4, #2]
		cmp		r8,	#38
		bge		dontMoveRight		
movePaddelRightAgain:		
		ldrb	r5,	[r4, r7]
		add		r5,	#1
		strb	r5,	[r4, r7]
		
		add		r7,	#1
		cmp		r7,	#3
		blt		movePaddelRightAgain
dontMoveRight:

		ldrb	r6,	[r4, #17]
		cmp		r6,	#1
		bne		resetFalse2
		ldrb	r8,	[r4, #3]
		cmp		r8,	#37
		bge		resetFalse2
		add		r8,	#1
		strb	r8,	[r4, #3]
resetFalse2:

		bl		ClearBallAndPaddel
		bl		DrawGameState
		pop		{r4-r9, pc}

@NEEDS TO BE IMPLEMENTED
.global checkCollision
checkCollision:
		push	{r4-r11, lr}

		ldr		r4,	=gameState
		ldr		r10, =imageArray
		
		ldrb	r5,	[r4, #4]			@ ball y
		ldr		r6,	[r4, #9]			@ ball velocity y

		add		r7,	r5,	r6				@the calculated next ball coordinate

		mov		r9, #2	
		cmp		r7,	r9
		ble		hitCeil

		@needs to be IMPLEMENTED PROPERLY
		
		mov		r0,	r7
		cmp		r7,	#20
		@check where it hit the paddel
		bleq	checkPaddelCollision
				
		bl		checkX
		

@loop to check if you hit any of the objects

checkX:

		ldrb	r5,	[r4, #3]			@ ball x
		ldr		r6,	[r4, #5]			@ ball velocity x
		add		r7,	r5,	r6
		
		mov		r9,	#20
		cmp		r7,	r9
		beq		hitLeftWall

		mov		r9,	#39
		cmp		r7,	r9
		beq		hitRightWall
		@increment score
		b		done
		
hitCeil:
		mov		r1,	#1
		str		r1,	[r4, #9]
		b		checkX

hitLeftWall:
		mov		r1,	#1
		str		r1,	[r4, #5]
		b		done

hitRightWall:
		mov		r1,	#-1
		str		r1,	[r4, #5]
		b		done
		
done:
		bl		checkHitBlock
		
		pop		{r4-r11, pc}



		
@NEEDS TO BE IMPLEMENTED
.global checkHitBlock
checkHitBlock:
		push	{r4-r11, lr}
		
		ldr		r4,	=gameState
		ldr		r5, =imageArray

		ldrb	r6,	[r4, #3]		@ x
		ldr		r7,	[r4, #5]		@ velocity x
		add		r8,	r6, r7			@ calculated coordinate
		sub		r8,	#20
		

		ldrb	r6,	[r4, #4]		@ y
		ldr		r7,	[r4, #9]		@ velocity y
		add		r9,	r6, r7			@ calculated coordinate
		sub		r9,	#2
		
		b		checkDiag

checkTop:

		ldr		r4,	=gameState
		ldr		r5, =imageArray

		ldrb	r6,	[r4, #3]		@ x
		ldr		r7,	[r4, #5]		@ velocity x
		add		r8,	r6, r7			@ calculated coordinate
		sub		r8,	#21
		

		ldrb	r6,	[r4, #4]		@ y
		ldr		r7,	[r4, #9]		@ velocity y
		add		r9,	r6, r7			@ calculated coordinate
		sub		r9,	#2
		
		mov		r7, #20
		mul	    r7,	r9
		add		r8, r7
		
		ldrb	r9,	[r5, r8]
		cmp		r9, #2
		beq		hitRed

		ldrb	r9,	[r5, r8]
		cmp		r9, #3
		beq		hitYellow

		ldrb	r9,	[r5, r8]
		cmp		r9, #4
		beq		hitPink	
		
		b		doneCheckHit

checkDiag:
		mov		r7, #20
		mul	    r7,	r9
		add		r8, r7
		
		ldrb	r9,	[r5, r8]
		cmp		r9, #2
		beq		hitRed

		ldrb	r9,	[r5, r8]
		cmp		r9, #3
		beq		hitYellow

		ldrb	r9,	[r5, r8]
		cmp		r9, #4
		beq		hitPink
		
		b		checkTop
		

hitRed:
		mov		r9,	#3
		strb	r9,	[r5, r8]
		
		@bl		pixelHit

		mov		r10, #-1
		ldr		r9,	[r4, #9]
		
		mul		r9,	r10
		str		r9,	[r4, #9]

		b		doneCheckHit


hitYellow:
		mov		r9,	#4
		strb	r9,	[r5, r8]
		
		@bl		pixelHit

		mov		r10, #-1
		ldr		r9,	[r4, #9]
		mul		r9,	r10
		str		r9,	[r4, #9]

		b		doneCheckHit

hitPink:
		mov		r9,	#0
		strb	r9,	[r5, r8]
		
		@bl		pixelHit

		mov		r10, #-1
		ldr		r9,	[r4, #9]
		
		mul		r9,	r10
		str		r9,	[r4, #9]

		@mov		r9,	#-1
		@str		r9, [r4, #5]

doneCheckHit:			
		
		pop		{r4-r11, pc}
		

@ 0 = slope decreasing
@ 1 = slope increasing		
calculateSlope:
		push	{r4-r11, lr}
		
		ldr		r4,	=gameState
		
		ldrb	r5,	[r4, #3]		@ x
		ldr		r6,	[r4, #5]		@ velocity x
		add		r6,	r5,	r6			@ next x

		ldrb	r6,	[r4, #4]		@ y
		ldr		r7,	[r4, #9]		@ velocity y
		add		r7,	r6,	r7			@ next y
		
		@ r6 - r5 / r7 - r6
		sub		r6,	r6,	r5			@ x slope
		sub		r7,	r7,	r6			@ y slope
		sdiv	r7, r7, r6
		
		cmp		r7,	#0
		movlt	r0,	#0
		
		cmp		r7,	#0
		movgt	r0,	#1
			
		pop		{r4-r11, pc}
		
		
pixelHit:
		push	{r4-r11, lr}
		mov		r4,	r0		@ x
		mov		r5,	r1		@ y
		
		add		r6,	#64		@ counter x
		add		r7,	#64		@ counter y
loopcol:
		
looprow:

		
		add		r4,	#1
		cmp		r4,	r6
		blt		looprow
		
		add		r5,	#1
		blt		loopcol
		
		
		pop		{r4-r11, pc}
		
		
checkPaddelCollision:
		push	{r4-r11, lr}
		ldr		r4,	=gameState
		
		ldrb	r8,	[r4, #3]
				
		ldrb	r5,	[r4, #0]	@ paddel left position
		ldrb	r6,	[r4, #1]	@ paddel middle position
		ldrb	r7,	[r4, #2]	@ paddel right position
		
		cmp		r8,	r5	
		beq		paddleLeft
		
		cmp		r8,	r6	
		beq		paddleMiddle
		
		cmp		r8,	r7	
		beq		paddleRight
		
		b		paddleDone
		
paddleLeft:
		mov		r9,	#-1
		str		r9,	[r4, #5]
		
		mov		r9,	#-1
		str		r9,	[r4, #9]
		b		paddleDone
		
paddleMiddle:
		mov		r9,	#0
		str		r9,	[r4, #5]
		
		mov		r9,	#-1
		str		r9,	[r4, #9]
		
		b		paddleDone
		
paddleRight:
		mov		r9,	#1
		str		r9,	[r4, #5]
		
		mov		r9,	#-1
		str		r9,	[r4, #9]
		
paddleDone:
		
		pop		{r4-r11, pc}

@ Data section
.section .data
