@ CPSC 359 L01 Assignment 4
@ Daniel Nwaroh & Issack John & Steve Khanna

@ASSIGNMENT CHECK LIST[]

@Main Menu Screen	  		[]5
@Draw game State 		    []29
@Draw game menu	  			[]4
@interact with game	  		[]8
@interact with game menu	[]4



@ Code section
.section .text


.global main
main:

	ldr		r0, =frameBufferInfo
	bl		initFbInfo
	
	
	
	

	haltLoop$:
		b	haltLoop$

@ Data section
.section .data
frameBufferInfo:
.int 0			@ frame buffer pointer
.int 0			@ screen width
.int 0			@ screen height


