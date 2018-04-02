

@ Code section
.section .text

.global	DrawMenuStartSelected
DrawMenuStartSelected:
		push 	{lr}
	
		mov	r0,	#640
		mov	r1,	#100
		ldr	r8, =imageWidth
		mov	r7, #640
		str	r7, [r8]
		ldr	r8, =imageHeight
		mov	r6, #360
		str	r6, [r8]
		ldr	r2, =startScreen
		bl	drawImage
		//bl	SNESmain
		//b	StartChecker
		
		pop	{pc}
		mov	pc,	lr
		
.global	DrawMenuQuitSelected
DrawMenuQuitSelected:
		push 	{lr}
	
		mov	r0,	#640
		mov	r1,	#100
		ldr	r8, =imageWidth
		mov	r7, #640
		str	r7, [r8]
		ldr	r8, =imageHeight
		mov	r6, #360
		str	r6, [r8]
		ldr	r2, =startQuit
		bl	drawImage
		//bl	SNESmain
		//b	StartChecker
		
		pop	{pc}
		mov	pc,	lr


@ Data section
.section .data

.global MainMenu
MainMenu:
.asciz	"Main Menu"




