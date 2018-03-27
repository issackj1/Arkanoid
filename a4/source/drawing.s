

@ Code section
.section .text

/*
.global	drawImage
drawImage:
		push	{r5-r10, lr}
		
		mov	r10,#0
		
		mov	r5,	#0
		mov	r6,	#0
		mov	r7,	#208
		mov	r8,	#232
		mov	r9,	r2

outerLoop:

		mov	r5, #0			//reset pixels drawn x
		mov	r0, r10		//Re-initialize x -coordinate
		add	r1, r1,	#1		//Add one to y coordinate
		add	r6, r6,	#1		//Add one to pixels drawn y

		cmp	r6, r8			//Pixels drawn y < y bound?
		bge	done1		
	
drawLoop:
		cmp	r5, r7			//Pixels drawn < Length?
		bge	outerLoop		//If yes, branch to done

		ldr	r2, [r9], #4		

		push	{r0, r1, r2}
		bl	DrawPixel
		pop	{r0, r1, r2}			
		
		add	r5,	r5, #1		//Add one to pixels drawn	
		add	r0,	r0, #1		//Add one to the x-coordinat

		b	drawLoop
		
		

done1:
		pop	{r5-r10, lr}
		mov	pc,	lr
		
.global DrawChars
DrawChars:
		push	{r4-r10, lr}
		
		chAdr	.req	r4
		px		.req	r5
		py		.req	r6
		row		.req	r7
		mask	.req	r8
		pxinit	.req	r9
		color	.req	r10
		
		ldr		chAdr,	=font
		add		chAdr,	r3,	lsl #4
		
		mov		color,	r2
		mov		py,		r1
		mov		pxinit,	r0
		
charLoop$:
		mov		px, pxinit		@ init the X coordinate

		mov		mask, #0x01		@ set the bitmask to 1 in the LSB
		
		ldrb	row, [chAdr], #1	@ load the row byte, post increment chAdr

rowLoop$:
		tst		row,	mask		@ test row byte against the bitmask
		beq		noPixel$

		mov		r0, px
		mov		r1, py
		mov		r2, #0x00FF0000		@ red
		bl		DrawPixel		@ draw red pixel at (px, py)

noPixel$:
		add		px, #1			@ increment x coordinate by 1
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

		pop		{r4-r8, pc}
	
		


.global drawMainMenu
drawMainMenu:



.global drawGameState
drawMainMenu:


.global drawGameMenu
drawMainMenu:


@ Data section
.section .data

font:
.incbin	"font.bin"

*/


