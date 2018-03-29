
@ Code section
.section .text


.global drawStart
drawStart:
		push	{r4-r8, lr}
		
		@draw game title
		mov		r4,	#0
		mov		r5,	#850
		mov		r6,	#150
		ldr		r7, =gameName
loopTitle:
		ldrb	r0,	[r7, r4]
		mov		r1,	r5
		mov		r2,	r6
		bl		DrawChar
		add		r4,	#1
		add		r5,	#15	
		cmp 	r4,	#8
		blt		loopTitle
			
		@draw creator names
		mov		r7,	#0
		mov		r4,	#0
		mov		r5,	#500
		mov		r6,	#700
		ldr		r7, =names

loopStart:
		ldrb	r0,	[r7, r4]
		mov		r1,	r5
		mov		r2,	r6
		bl		DrawChar
		add		r4,	#1
		add		r5,	#15	
		cmp 	r4,	#56
		blt		loopStart
		
		@draw menu options and option selection
		
		pop		{r4-r8, pc}
	
	
@ Draw the character 'B' to (x,y)
.global DrawChar
DrawChar:
		push		{r4-r9, lr}

		chAdr	.req	r4
		px		.req	r5
		py		.req	r6
		row		.req	r7
		mask	.req	r8
		mov		r9,		r1

		ldr		chAdr, =font		@ load the address of the font map
		add		chAdr,	r0, lsl #4	@ char address = font base + (char * 16)

		mov		py, r2		@ init the Y coordinate (pixel coordinate)

charLoop$:
		mov		px, r9		@ init the X coordinate

		mov		mask, #0x01		@ set the bitmask to 1 in the LSB
		
		ldrb	row, [chAdr], #1	@ load the row byte, post increment chAdr

rowLoop$:
		tst		row,	mask		@ test row byte against the bitmask
		beq		noPixel$

		mov		r0, px
		mov		r1, py
		mov		r2, #0x00FF0000		@ red
		bl		DrawPixel			@ draw red pixel at (px, py)

noPixel$:
		add		px, #1		@ increment x coordinate by 1
		lsl		mask, #1		@ shift bitmask left by 1

		tst		mask,	#0x100		@ test if the bitmask has shifted 8 times (test 9th bit)
		beq		rowLoop$

		add		py, #1			@ increment y coordinate by 1

		tst		chAdr, #0xF
		bne		charLoop$		@ loop back to charLoop$, unless address evenly divisibly by 16 (ie: at the next char)

		.unreq	chAdr
		.unreq	px
		.unreq	py
		.unreq	row
		.unreq	mask

		pop		{r4-r9, pc}
	
.global drawLeftBorder
drawLeftBorder:
		push	{r4-r9, lr}
		x	.req	r4
		y	.req	r5
			
		mov		x,	#494
		mov		y,	#502
		
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
		mov		x,	#494
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
			
		mov		x,	#708
		mov		y,	#502
		
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
		mov		x,	#708
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
			
		mov		x,	#494
		mov		y,	#495
		
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
		mov		x,	#494
		mov		r7, #0
		
		add		r8,	#1
		add		y,	#1
		cmp 	r8, #7
		blt 	loopt
			
		pop		{r4-r9, pc}

.global drawBackGround
drawBackGround:
		push	{r4-r10, lr}
		
		mov	r10, r0
		mov	r5,	#0
		mov	r6,	#0
		ldr	r7, =imageWidth
		ldr	r7, [r7]
		ldr	r8, =imageHeight
		ldr	r8, [r8]
		
		mov	r9,	r2
		
outerLoop:

		mov	r5, #0			//reset pixels drawn x
		mov	r0, r10		//Re-initialize x -coordinate
		add	r1, r1,	#1		//Add one to y coordinate
		add	r6, r6,	#1		//Add one to pixels drawn y

		cmp	r6, r8			//Pixels drawn y < y bound?
		bge	done1		
	
drawLoop1:
		cmp	r5, r7			//Pixels drawn < Length?
		bge	outerLoop		//If yes, branch to done

		ldr	r2, [r9], #4		

		push	{r0, r1, r2}
		bl	DrawPixel
		pop		{r0, r1, r2}			
		
		add	r5,	r5, #1		//Add one to pixels drawn	
		add	r0,	r0, #1		//Add one to the x-coordinat

		b	drawLoop1
done1:
		pop		{r4-r10, pc}
	
	
.global drawBlueBlock	
drawBlueBlock:
		push	{r4-r9, lr}
		x	.req	r4
		y	.req	r5
			
		mov		x,	r0
		mov		y,	r1
		
		ldr		r6,	=blueBlock
		mov		r7,	#0
		mov		r8,	#0
	
loopBlue:
		mov		r0,	x
		mov		r1,	y
		ldr		r2,	[r6]
		bl		DrawPixel
	
		add		x,	#1
		add		r6,	#4
		add		r7,	#1
		
		cmp		r7,	#16
		blt		loopBlue
		mov		x,	#500
		mov		r7, #0
		
		add		r8,	#1
		add		y,	#1
		cmp 	r8, #8
		blt 	loopBlue

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

names:
.asciz	"Created by: Daniel Nwaroh, Issack John and Steve Khanna\n"

gameName:
.asciz	"Arkanoid\n"
