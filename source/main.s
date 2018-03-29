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
	mov		r9, #675	//y
	mov		r6, #1080	//x
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
	ldr		r2, =background
	bl		drawImage
	

	add		r6, #1
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

/*printPaddle:
	mov		r0, #850
	mov 	r1, #600
	ldr		r7, =imageWidth
	mov		r4, #100
	str		r4, [r7]
	ldr		r8, =imageHeight
	mov		r4, #21
	str		r4, [r8]
	ldr		r2, =paddle
	bl		drawImage

printBall:
	mov		r0, #890
	mov 	r1, #580
	ldr		r7, =imageWidth
	mov		r4, #20
	str		r4, [r7]
	ldr		r8, =imageHeight
	mov		r4, #20
	str		r4, [r8]
	ldr		r2, =ball
	bl		drawImage
	
callSNES:
	bl		SNESmain
*/
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


imageArray:
.byte		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
endArray:
.align





