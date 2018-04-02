.global MainMenuStart
MainMenuStart:
		mov	r0,	#300
		mov	r1,	#100
		ldr	r8, =imageWidth
		mov	r7, #1280
		str	r7, [r8]
		ldr	r8, =imageHeight
		mov	r6, #720
		str	r6, [r8]
		ldr	r2, =start
		bl	drawImage
		bl	SNESmain
		b	StartChecker


StartQuit:
		mov	r0,	#300
		mov	r1,	#100
		ldr	r8, =imageWidth
		mov	r7, #1280
		str	r7, [r8]
		ldr	r8, =imageHeight
		mov	r6, #720
		str	r6, [r8]
		ldr	r2, =startQuit
		bl	drawImage
		bl	SNESmain
		b	QuitChecker
		
		
StartChecker:
		
		ldr	r1, =0xF7FF
		cmp	r6, r1
		beq	StartQuit
		ldr	r1, =0xFBFF
		cmp	r6, r1
		beq	StartQuit
		ldr	r1, =0xFF7F
		cmp	r6, r1
		beq	StartGame
		bl	SNESmain
		b	StartChecker
		
QuitChecker:
		ldr	r1, =0xF7FF
		cmp	r6, r1
		beq	MainMenuStart
		ldr	r1, =0xFBFF
		cmp	r6, r1
		beq	MainMenuStart
		ldr	r1, =0xFF7F
		cmp	r6, r1
		beq	haltLoop$
		bl	SNESmain
		b	QuitChecker
