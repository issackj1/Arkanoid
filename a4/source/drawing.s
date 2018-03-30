
@ Code section
.section .text

.globl DrawSquare
DrawSquare:
	push		{r4-r11,lr}
	
        mov	 r9,	#32                             //32 is the offset
        
        mul	r10,r0,r9                              
        mul 	r11,r1,r9 

	mov	r4,	r10			//Start X position of your picture
	mov	r5,	r11
	ldr	r6,	=wall			//Address of the picture
	mov	r7,	r4
        add     r7,     #32
	mov	r8,     r5
        add     r8,     #32
drawPictureLoop:
	mov	r0,	r4			//passing x for ro which is used by the Draw pixel function 
	mov	r1,	r5			//passing y for r1 which is used by the Draw pixel formula 
	
	ldrh	r2,	[r6],#2			//setting pixel color by loading it from the data section. We load half word
	bl	DrawPixel
	add	r4,	#1			//increment x position

	cmp	r4,	r7			//compare with image with
	blt	drawPictureLoop

	mov	r4,	r10			//reset x
	add	r5,	#1			//increment Y

	cmp	r5,	r8			//compare y with image height
	blt	drawPictureLoop
	
	pop    {r4-r11,lr}
	mov	pc,	lr			//return


/*
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
		bl		Draw_String
		add		r4,	#1
		add		r5,	#15	
		cmp 	r4,	#8
		blt		loopTitle
			
		@draw PLAY GAME
		mov		r7,	#0
		mov		r4,	#0
		mov		r5,	#850
		mov		r6,	#350
		ldr		r7, =playGame	
loopPlay:
		ldrb	r0,	[r7, r4]
		mov		r1,	r5
		mov		r2,	r6
		bl		Draw_String
		add		r4,	#1
		add		r5,	#15	
		cmp 	r4,	#9
		blt		loopPlay
		
		@draw QUIT
		mov		r7,	#0
		mov		r4,	#0
		mov		r5,	#890
		mov		r6,	#450
		ldr		r7, =quit	
loopQuit:
		ldrb	r0,	[r7, r4]
		mov		r1,	r5
		mov		r2,	r6
		bl		Draw_String
		add		r4,	#1
		add		r5,	#15	
		cmp 	r4,	#4
		blt		loopQuit
			
		@draw creator names
		mov		r7,	#0
		mov		r4,	#0
		mov		r5,	#500
		mov		r6,	#600
		ldr		r7, =names

loopStart:
		ldrb	r0,	[r7, r4]
		mov		r1,	r5
		mov		r2,	r6
		bl		Draw_String
		add		r4,	#1
		add		r5,	#15	
		cmp 	r4,	#56
		blt		loopStart
		
		@draw menu options and option selection
		
		pop		{r4-r8, pc}
*/
	
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

//Draw_String
//Args: R0 = x, R1 = y, R2 = Colour, R3 = address of string
//Return: None
//This function takes in the address of a string in .asciz form and will print it out
//to the screen. It first loads the individual value and will then call the Draw_Char function.
//The function will loop until the /0 character is encountered.
.globl Draw_String
Draw_String:
	push 	{r4-r10, lr}	//*******do we push before or after .req

	senAdr	.req	r4
	px	.req	r5
	py	.req	r6
	colour	.req	r7


	mov	px, r0
	mov	py, r1
	mov	colour, r2
	mov	senAdr, r3

	mov	r8, #0	//index = 0

	ldrb	r9, [senAdr]

Draw_String_Loop:
	mov	r0, px
	mov	r1, py
	mov	r2, colour
	mov	r3, r9
	bl	Draw_Char

	add	r8, #1			//increment index
	add	px, #10			//*******increment spacing for letters*******CHANGE SPACING HERE

	ldrb	r9, [senAdr, r8] 	//load next letter in string
	
	cmp	r9, #0			//compare to /0
	bne	Draw_String_Loop
	
Draw_String_Loop_Done:
	.unreq	senAdr
	.unreq	px
	.unreq	py
	.unreq	colour	

	pop 	{r4-r10, lr}
	mov	pc, lr

//Draw_Char
//Args: R0 = x, R1 = y, R2 = Colour, R3 = Character
//Return: None
//This function is a more general for of DrawCharB and allows for printing at a
//user specified (x,y) and a different Character
.globl Draw_Char
Draw_Char:
	push		{r4-r10, lr}

	chAdr		.req	r4
	px			.req	r5
	py			.req	r6
	row			.req	r7
	mask		.req	r8
	colour		.req	r9
	pxINIT		.req	r10

	ldr			chAdr, 	=font		// load the address of the font map
	add			chAdr, 	r3, lsl #4	// char address = font base + (char * 16)

	mov			colour, r2
	mov			py, 	r1			// init the Y coordinate (pixel coordinate)
	mov			pxINIT,	r0

charLoop$:
	mov			px,		pxINIT			// init the X coordinate

	mov	mask, #0x01						//set the bitmask to 1 in the LSB
	
	ldrb	row, [chAdr], #1	// load the row byte, post increment chAdr

rowLoop$:
	tst	row, mask		// test row byte against the bitmask
	beq	noPixel$

	mov	r0, px
	mov	r1, py
	mov	r2, colour
	bl	DrawPixel		// draw r2 coloured pixel at (px, py)

noPixel$:
	add	px, #1			// increment x coordinate by 1
	lsl	mask, #1			// shift bitmask left by 1

	tst	mask, #0x100		// test if the bitmask has shifted 8 times (test 9th bit)
	beq	rowLoop$

	add	py, #1			// increment y coordinate by 1

	tst	chAdr, #0xF
	bne	charLoop$		// loop back to charLoop$, unless address evenly divisibly by 16 (ie: at the next char)


	.unreq	chAdr
	.unreq	px
	.unreq	py
	.unreq	row
	.unreq	mask
	.unreq	colour
	.unreq	pxINIT

	pop	{r4-r10, lr}
	mov	pc, lr



/*
@ Draw the character to (x,y)
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
*/
	
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

.global wall
wall:
		.byte 1,1,1,1
		.byte 1,1,1,1
		.byte 1,1,1,1
		.byte 1,1,1,1

.global gameName
gameName:
.asciz	"Arkanoid\n"						@size = 8

.global names
names:
.asciz	"Created by: Daniel Nwaroh, Issack John and Steve Khanna\n"	 @size = 56

.global mainMenu
mainMenu:
.asciz	"Main Menu"

.global playGame
playGame:
.asciz "PLAY GAME\n"						@size = 9

.global quit
quit:
.asciz "QUIT\n"								@size = 4

.global playGameSelect
playGameSelect:
.asciz	"> PLAY GAME"						@size = 11

.global quitSelect
quitSelect:
.asciz	"> QUIT"							@size = 6