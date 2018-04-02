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
		
movePaddelLeftAgain:		
		ldrb	r5,	[r4, r7]
		cmp		r5,	#21
		ble		dontMoveLeft
		sub		r5,	#1
		strb	r5,	[r4, r7]
		
		add		r7,	#1
		cmp		r7,	#3
		blt		movePaddelLeftAgain
dontMoveLeft:
		
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
		mov		r9, #20	
		cmp		r7,	r9
		beq		hitPaddel

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
		
hitPaddel:
		mov		r1,	#-1
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
		@bl		checkHitBlock
		
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

		mov		r7, #20
		@mul	r7, r7,	r8
		add		r7, r9
		
		ldrb	r8,	[r5, r7]
		cmp		r8, #2
		beq		hitRed

		ldrb	r8,	[r5, r7]
		cmp		r8, #3
		beq		hitYellow

		ldrb	r8,	[r5, r7]
		cmp		r8, #3
		beq		hitPink

		b		doneCheckHit

hitRed:
		mov		r9,	#3
		strb	r9,	[r5, r7]

		@mov		r9,	#1
		@str		r9, [r4, #9]

		@mov		r9,	#1
		@str		r9, [r4, #5]

		b		doneCheckHit

hitYellow:
		mov		r9,	#4
		strb	r9,	[r5, r7]

		@mov		r9,	#1
		@str		r9, [r4, #9]

		@mov		r9,	#-1
		@str		r9, [r4, #5]

		b		doneCheckHit

hitPink:
		mov		r9,	#0
		strb	r9,	[r5, r7]

		@mov		r9,	#1
		@str		r9, [r4, #9]

		@mov		r9,	#-1
		@str		r9, [r4, #5]

doneCheckHit:			
		
		pop		{r4-r11, pc}

@ Data section
.section .data
