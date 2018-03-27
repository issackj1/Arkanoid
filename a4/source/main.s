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

PrintBackground:
	
	mov		r0, #350
	mov		r1, #100
	ldr		r7, =imageWidth
	mov		r4, #1080
	str		r4, [r7]
	ldr		r8, =imageHeight
	mov		r4, #675
	str		r4, [r8]
	ldr		r2, =background
	bl		drawImage


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

.global	FrameBuffer
FrameBuffer:
.int	0
.int	0
.int	0

@For drawing ASCII TEXT
.align 4
font:	.incbin "font.bin"

.global imageWidth
imageWidth:
.int	0
.global	imageHeight
imageHeight:
.int	0






