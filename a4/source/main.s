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
		mov		r9,	#675
		mov		r6,	#1080
		b		array1
	
PrintBackground:

		mov		r0, r10
		mov		r1, r11
		ldr		r7, =imageWidth
		mov		r3, #64
		str		r3, [r7]
		ldr		r8, =imageHeight
		mov		r3, #32
		str		r3, [r8]
		ldr		r2, =backGround
		bl		drawBackGround
		bl		drawStart
		add		r6,	#1
		add		r9, #1
		b		loop
	
array1:
		ldr		r0, =endArray
		ldr		r1, =imageArray
		mov		r6, #1		//counter
		mov		r5, #21		//col to count
		mov		r10, #236
		mov		r11, #100
		mov		r4, r0
		mov		r9, r1
loop:
		cmp		r9, r4
		beq		haltLoop$
		cmp		r6, r5	
		beq		changeBoth

onlyX:
		add		r10, r10, #64
		b		PrintBackground
	
changeBoth:
		add		r5, #20
		add		r11, r11, #31
		mov		r10, #236
		b		onlyX
		
		
		@bl		drawBackGround
		@bl		drawLeftBorder
		@bl		drawRightBorder
		@bl		drawTopBorder
		
		mov		r0,	#500
		mov		r1,	#510
		@bl		drawBlueBlock
	
	
	
	haltLoop$:

		b	haltLoop$
			

@ Data section
.section .data

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
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

endArray:
.align






