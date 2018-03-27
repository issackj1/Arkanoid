@ CPSC 359 L01 Assignment 4
@ Daniel Nwaroh & Issack John & Steve Khanna

@ASSIGNMENT CHECK LIST[]

@Main Menu Screen	  	[]5
@Draw game State 		[]29
@Draw game menu	  		[]4
@interact with game	  	[]8
@interact with game menu	[]4



@ Code section
.section .text


.global main
main:
	@ ask for the frame buffer information
	ldr		r0, =frameBufferInfo		@frame buffer information structure
	bl		initFbInfo
	
	mov		r4,	#0
	mov		r0,	#600
	mov		r1,	#600
	//bl		drawLoop
	b		looper
drawLoop:
	cmp		r4,	#300
	bge		done
	mov		r8, r0
	mov		r9, r1
	ldr		r2,	=0xFF0000	
	
	bl		DrawPixel
		
	add		r4,	#1
	add		r8,	#1
	mov		r0, r8
	mov		r1, r9
	bl		drawLoop
	bx		lr
done:
	mov		pc,	lr
looper:	
	mov		r0, #200
	mov		r1, #100
	bl		drawImage
	mov		r4,	#0
	mov		r0,	#600
	mov		r1,	#600
	bl		drawLoop
haltLoop$:
		b	haltLoop$
		
@ Draw Pixel
@ r0 - x
@ r1 - y
@ r2 - color		

.global DrawPixel
DrawPixel:
	push	{r4, r5}
	
	

	offset	.req	r4
		
	ldr	r5,	=frameBufferInfo
	
	ldr	r3,	[r5, #4]
	mul	r1,	r3
	add	offset,	r0,	r1

	lsl		offset, #2

	ldr	r0,	[r5]
	str	r2,	[r0, offset]

	pop		{r4, r5}
	bx		lr
/*	
.global Draw
Draw:
	push		{r4-r9, lr}
	mov r5, #0	// r5 is count x
	mov r8, #0	// r8 is count y
	
	ldr	r4, =background
	mov r6, #500	// x is r6
	mov r7, #500	// y is r7

loopcol:

	
looprow:
	mov r0, r6
	mov r1, r7
	ldr	r2, [r4]
	//mov	r2, #0x00FF0000	
	bl DrawPixel
	
	add r5, #1
	add r6, #1
	//add r7, r8
	add r4, #4
	cmp	r5, #15
	ble	looprow
	mov r6, #500
	mov	r5, #0
	
	cmp r8, #15
	addlt r8, #1
	addlt r7, #1
	blt loopcol

	pop		{r4-r9, pc}
*/









.global	drawImage
drawImage:
		push	{r5-r10, lr}
		
		mov	r10, r0
		//mov	r10,#200
		
		mov	r5,	#0
		mov	r6,	#0
		mov	r7,	#1080
		mov	r8,	#675
		ldr	r2, =background
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
		pop	{r0, r1, r2}			
		
		add	r5,	r5, #1		//Add one to pixels drawn	
		add	r0,	r0, #1		//Add one to the x-coordinat

		b	drawLoop1

done1:		
		pop	{r5-r10, lr}
		mov	pc, lr











		
		

@ Data section
.section .data

.align
.global frameBufferInfo
frameBufferInfo:
.int	0
.int	0
.int	0

.global	FrameBuffer
FrameBuffer:
.int	0
.int	0
.int	0

@For drawing ASCII TEXT
.align 4
font:	.incbin "font.bin"





