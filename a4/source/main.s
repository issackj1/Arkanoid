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
	
	
	haltLoop$:
		b	haltLoop$
		
@ Draw Pixel
@ r0 - x
@ r1 - y
@ r2 - color		
		
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

.align
.global frameBufferInfo
frameBufferInfo:
.int 0			@ frame buffer pointer
.int 0			@ screen width
.int 0			@ screen height

@For drawing ASCII TEXT
.align 4
font:	.incbin "font.bin"


