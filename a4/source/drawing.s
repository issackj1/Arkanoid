

@ Code section
.section .text


.global drawLeftBorder
drawLeftBorder:
	push	{r4-r9, lr}
	x	.req	r4
	y	.req	r5
		
	mov		x,	#500
	mov		y,	#500
	
	ldr		r6,	=leftBorder
	mov		r7,	#0
	mov		r8,	#0
	
loop:
	mov		r0,	x
	mov		r1,	y
	ldr		r2,	[r6]
	bl		DrawPixel
	
	add		x,	#1
	add		r6,	#4
	add		r7,	#1
	
	cmp		r7,	#6
	blt		loop
	mov		x,	#500
	mov		r7, #0
	
	add		r8,	#1
	add		y,	#1
	cmp 	r8, #230
	blt 	loop

	pop		{r4-r9, pc}


.global drawRightBorder
drawRightBorder:
	push	{r4-r9, lr}
	x	.req	r4
	y	.req	r5
		
	mov		x,	#714
	mov		y,	#500
	
	ldr		r6,	=rightBorder
	mov		r7,	#0
	mov		r8,	#0
	
loopr:
	mov		r0,	x
	mov		r1,	y
	ldr		r2,	[r6]
	bl		DrawPixel
	
	add		x,	#1
	add		r6,	#4
	add		r7,	#1
	
	cmp		r7,	#6
	blt		loopr
	mov		x,	#714
	mov		r7, #0
	
	add		r8,	#1
	add		y,	#1
	cmp 	r8, #230
	blt 	loopr

	pop		{r4-r9, pc}


.global drawTopBorder
drawTopBorder:
	push	{r4-r9, lr}
	x	.req	r4
	y	.req	r5
		
	mov		x,	#500
	mov		y,	#500
	
	ldr		r6,	=topBorder
	mov		r7,	#0
	mov		r8,	#0
	
loopt:
	mov		r0,	x
	mov		r1,	y
	ldr		r2,	[r6]
	bl		DrawPixel
	
	add		x,	#1
	add		r6,	#4
	add		r7,	#1
	
	cmp		r7,	#220
	blt		loopt
	mov		x,	#500
	mov		r7, #0
	
	add		r8,	#1
	add		y,	#1
	cmp 	r8, #7
	blt 	loopt

	pop		{r4-r9, pc}


.global drawBackGround
drawBackGround:
	push		{r4-r9, lr}
	mov 	r5, #0	// r5 is count x
	mov 	r8, #0	// r8 is count y
	
	ldr		r4, =background
	mov 	r6, #500	// x is r6
	mov 	r7, #500	// y is r7

loopcol:

	
looprow:
	mov 	r0, r6
	mov 	r1, r7
	ldr		r2, [r4]
	//mov	r2, #0x00FF0000	
	bl 		DrawPixel
	
	add 	r5, #1
	add 	r6, #1
	//add r7, r8
	add 	r4, #4
	cmp		r5, #208
	blt		looprow
	mov 	r6, #500
	mov		r5, #0
	
	cmp 	r8, #232
	addlt 	r8, #1
	addlt 	r7, #1
	blt 	loopcol

	pop		{r4-r9, pc}
	
@ Draw Pixel
@ r0 - x
@ r1 - y
@ r2 - color		
.global DrawPixel		
DrawPixel:
		push	{r4,r5}
		offset	.req	r4

		ldr		r5, =frameBufferInfo
	
		@offset = (y * width) + x
	
		ldr		r3, [r5, #4]			@ r3 = width
		mul		r1, r3
		add		offset, r0, r1
		
		@ offset *= 4 (32 bits per pixel/8 = 4 bytes per pixel)
		lsl		offset, #2
		
		@ store the color (word) at frame buffer pointer + offset
		ldr		r0, [r5]				@ r0 = frame buffer pointer
		str		r2, [r0, offset]
		
		pop		{r4, r5}
		bx		lr

@ Data section
.section .data




