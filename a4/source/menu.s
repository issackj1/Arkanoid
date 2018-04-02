@ CPSC 359 L01 Assignment 4
@ Author Issack John
@ Code section
.section .text

.global	DrawMenuStartSelected
DrawMenuStartSelected:
		push 	{lr}
		
		bl		DrawBlackBackGround

		@ Draws game name string
		mov		r0,	#920			@ x
		mov		r1,	#130			@ y
		ldr		r2, =0xFFFF2416		@ colour
		ldr		r3, =gameName
		bl		Draw_String

		@ Draws main menu string
		mov		r0,	#910			@ x
		mov		r1,	#250			@ y
		ldr		r2, =0xFFFF2416		@ colour
		ldr		r3, =mainMenu
		bl		Draw_String

		@ Draws play game is selected string
		mov		r0,	#900			@ x
		mov		r1,	#350			@ y
		ldr		r2, =0xFFFF2416		@ colour
		ldr		r3, =playGameSelect
		bl		Draw_String

		@ Draws quit string
		mov		r0,	#900			@ x
		mov		r1,	#450			@ y
		ldr		r2, =0xFFFF2416		@ colour
		ldr		r3, =quit
		bl		Draw_String
		
		@ Draws the creator names string
		mov		r0,	#700			@ x
		mov		r1,	#550			@ y
		ldr		r2, =0xFFFF2416		@ colour
		ldr		r3, =names
		bl		Draw_String
		
		pop	{pc}
		
.global	DrawMenuQuitSelected
DrawMenuQuitSelected:
		push 	{lr}
		
		bl		DrawBlackBackGround

		@ Draws game name string
		mov		r0,	#920			@ x
		mov		r1,	#130			@ y
		ldr		r2, =0xFFFF2416		@ colour
		ldr		r3, =gameName
		bl		Draw_String

		@ Draws main menu string
		mov		r0,	#910
		mov		r1,	#250
		ldr		r2, =0xFFFF2416		
		ldr		r3, =mainMenu
		bl		Draw_String

		@ Draws play game string
		mov		r0,	#900
		mov		r1,	#350
		ldr		r2, =0xFFFF2416	
		ldr		r3, =playGame
		bl		Draw_String

		@Draw quit is selected string
		mov		r0,	#900
		mov		r1,	#450
		ldr		r2, =0xFFFF2416	
		ldr		r3, =quitSelect
		bl		Draw_String
		
		@ Draws the creator names string
		mov		r0,	#700
		mov		r1,	#550
		ldr		r2, =0xFFFF2416		
		ldr		r3, =names
		bl		Draw_String
		
		pop	{pc}


@ Data section
.section .data
