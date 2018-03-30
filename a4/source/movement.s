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

		ldr		r7,	=gameState
		@ldr	r8,	=imageArray
		
		mov		r4,	r0			#y
		mov		r5,	r1			#velocity y

		@ldrb	r9,	[r8, r4]

		add		r6,	r4,	r5
		cmp		r6,	#7
		bgt		noHit
		mov		r1,	#1

		strb	r1,	[r4, #6]
		@increment score
noHit:
		
		pop		{r4-r11, pc}
		
@NEEDS TO BE IMPLEMENTED
@return 1 if in bounds
@return 0 if out of bounds
.global checkBounds
checkBounds:
		push	{r4-r11, lr}
		
		mov		r4,	r0		@x
		mov		r5,	r1		@y
		mov		r6,	r2		@offset x
		mov		r7,	r3		@offset y
		
		ldr		r6,	=gameState
		ldrb	r8,	[r6, r2]
		ldrb	r9,	[r6, r3]
		
		pop		{r4-r11, pc}

@ Data section
.section .data


