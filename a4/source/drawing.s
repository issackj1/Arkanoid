
@ Code section
.section .text



@ Draws the paddle on the screen
.global DrawPaddel
DrawPaddel:
		push	{r4-r11, lr}
		
		mov		r8,	r0
		ldr		r4,	=gameState
		mov		r7,	#0
		
drawPaddelAgain:		
		ldrb	r5,	[r4], #1
		
		mov		r0,	r5
		mov		r1,	#20
		mov		r3,	r8
		bl		DrawSquare
		
		add		r7,	#1
		cmp		r7,	#3
		blt		drawPaddelAgain
		
		pop	{r4-r11, pc}

@ Draws the ball on the screen
.global DrawBall
DrawBall:
		push	{r4-r11, lr}
		ldr		r4,	=gameState
		mov		r7, #0
		
		mov		r8,	r0
		ldrb	r0,	[r4, #3]
		ldrb	r1,	[r4, #4]
		mov		r3,	r8
		bl		DrawSquare
		
		pop	{r4-r11, pc}

@ Draws the black background on the screen, floor tiles
.global	DrawBlackBackGround
DrawBlackBackGround:
		push	{r4-r11, lr}
		mov		r4,	#20
		mov		r5,	#2
		b		loopblackrow
nextb:
		mov		r4,	#20	
		
loopblackrow:
		mov		r0,	r4
		mov		r1,	r5		
		
		ldr		r3,	=backGround
		bl		DrawSquare
		
		add		r4,	#1
		cmp		r4,	#40
		blt		loopblackrow
		add		r5,	#1
		cmp		r5,	#22
		blt		nextb
		pop		{r4-r11, pc}

Draws the grid on the screen, blocks and wall
.global DrawGrid
DrawGrid:
		push 	{r4-r11, lr}
		mov		r4,	#20
		mov		r5,	#2
		ldr		r6,	=imageArray
		b		loopdrow
next:
		mov		r4,	#20	
		
loopdrow:
		mov		r0,	r4
		mov		r1,	r5		
		
		ldrb	r7,	[r6], #1
		cmp		r7,	#0
		ldreq	r3,	=backGround
		
		cmp		r7,	#1
		ldreq	r3,	=wall
		
		cmp		r7,	#2
		ldreq	r3,	=red
		
		cmp		r7, #3
		ldreq	r3,	=yellow
		
		cmp		r7,	#4
		ldreq	r3,	=pink
		
		cmp		r7,	#5
		ldreq	r3,	=padel
		
		bl		DrawSquare
		
		add		r4,	#1
		cmp		r4,	#40
		blt		loopdrow
		add		r5,	#1
		cmp		r5,	#22
		blt		next
		
		pop	{r4-r11, pc}

@ Draw a sqaure on the screen
@ Takes in the address of the pciture in r3
.globl DrawSquare
DrawSquare:
		push		{r4-r11,lr}
		
		mov	 	r9,	#32             //32 is the offset
			
		lsl		r10,r0, #5                              
		lsl 	r11,r1, #5 

		mov		r4,	r10				//Start X position of your picture
		mov		r5,	r11
		mov		r6,	r3				//Address of the picture
		mov		r7,	r4
		add     r7, #32
		mov		r8, r5
		add     r8, #32
drawPictureLoop:
		mov		r0,	r4				//passing x for r0 which is used by the Draw pixel function 
		mov		r1,	r5				//passing y for r1 which is used by the Draw pixel formula 
		
		ldr		r2,	[r6],#4 		//setting pixel color by loading it from the data section. We load half word
		push	{r3}
		bl		DrawPixel
		pop		{r3}
		add		r4,	#1				//increment x position

		cmp		r4,	r7				//compare with image with
		blt		drawPictureLoop

		mov		r4,	r10				//reset x
		add		r5,	#1				//increment Y

		cmp		r5,	r8				//compare y with image height
		blt		drawPictureLoop
		
		pop    {r4-r11,lr}
		mov		pc,	lr				//return



		@DEPRECATED
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


@ Draws a string at the given x and y
@ r0 = x
@ r1 = y
@ r2 = color
@ r3 = adress for the string
.globl Draw_String
Draw_String:
	push 	{r4-r10, lr}	

	senAdr	.req	r4
	px		.req	r5
	py		.req	r6
	colour	.req	r7


	mov		px, r0
	mov		py, r1
	mov		colour, r2
	mov		senAdr, r3

	mov		r8, #0	//index = 0

	ldrb	r9, [senAdr]

Draw_String_Loop:
	mov		r0, px
	mov		r1, py
	mov		r2, colour
	mov		r3, r9
	bl		Draw_Char

	add		r8, #1			//increment index
	add		px, #10			//*******increment spacing for letters*******CHANGE SPACING HERE

	ldrb	r9, [senAdr, r8] 	//load next letter in string
	
	cmp		r9, #0			//compare to /0
	bne		Draw_String_Loop
	
Draw_String_Loop_Done:
	.unreq	senAdr
	.unreq	px
	.unreq	py
	.unreq	colour	

	pop 	{r4-r10, lr}
	mov	pc, lr

@ Draw the character to (x,y)
.globl Draw_Char
Draw_Char:
	push	{r4-r10, lr}

	chAdr	.req	r4
	px		.req	r5
	py		.req	r6
	row		.req	r7
	mask	.req	r8
	colour	.req	r9
	pxINIT	.req	r10

	ldr		chAdr, 	=font		// load the address of the font map
	add		chAdr, 	r3, lsl #4	// char address = font base + (char * 16)

	mov		colour, r2
	mov		py, 	r1			// init the Y coordinate (pixel coordinate)
	mov		pxINIT,	r0

charLoop$:
	mov		px,		pxINIT			// init the X coordinate

	mov		mask, #0x01						//set the bitmask to 1 in the LSB
	
	ldrb	row, [chAdr], #1	// load the row byte, post increment chAdr

rowLoop$:
	tst		row, mask		// test row byte against the bitmask
	beq		noPixel$

	mov		r0, px
	mov		r1, py
	mov		r2, colour
	bl		DrawPixel		// draw r2 coloured pixel at (px, py)

noPixel$:
	add		px, #1			// increment x coordinate by 1
	lsl		mask, #1			// shift bitmask left by 1

	tst		mask, #0x100		// test if the bitmask has shifted 8 times (test 9th bit)
	beq		rowLoop$

	add		py, #1			// increment y coordinate by 1

	tst		chAdr, #0xF
	bne		charLoop$		// loop back to charLoop$, unless address evenly divisibly by 16 (ie: at the next char)


	.unreq	chAdr
	.unreq	px
	.unreq	py
	.unreq	row
	.unreq	mask
	.unreq	colour
	.unreq	pxINIT

	pop		{r4-r10, lr}
	mov		pc, lr



/**
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
**/
	
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

.global gameName
gameName:
.asciz	"Arkanoid\n"							@size = 8

.global names
names:
.asciz	"Created by: Daniel Nwaroh, Issack John and Steve Khanna\n"	 @size = 56

.global mainMenu
mainMenu:
.asciz	"Main Menu"

.global playGame
playGame:
.asciz "Play Game\n"							@size = 9

.global quit
quit:
.asciz "Quit Game\n"							@size = 4

.global playGameSelect
playGameSelect:
.asciz	"> Play Game"							@size = 11

.global quitSelect
quitSelect:
.asciz	"> Quit Game"							@size = 6

.global gameOver
gameOver:
.asciz "CYA NERD"
