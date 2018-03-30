

@ Code section
.section .text

.global	DrawMenuStartSelected
DrawMenuStartSelected:
		push 	{r4-r10,lr}
		
		bl		DrawBlackBackGround
		//Game_Name
		mov		r0,	#920
		mov		r1,	#130
		ldr		r2, =0xFFFF2416			// colour
		ldr		r3, =gameName
		bl		Draw_String

		//Main_Menu
		mov		r0,	#910
		mov		r1,	#250
		ldr		r2, =0xFFFF2416		
		ldr		r3, =mainMenu
		bl		Draw_String

		//Play_Game
		mov		r0,	#900
		mov		r1,	#350
		ldr		r2, =0xFFFF2416	
		ldr		r3, =playGameSelect
		bl		Draw_String

		@prints "QUIT"
		mov		r0,	#900
		mov		r1,	#450
		ldr		r2, =0xFFFF2416	
		ldr		r3, =quit
		bl		Draw_String
		
		//Creator_Names
		mov		r0,	#700
		mov		r1,	#550
		ldr		r2, =0xFFFF2416		
		ldr		r3, =names
		bl		Draw_String
		
		pop	{r4-r10,pc}
		
.global	DrawMenuQuitSelected
DrawMenuQuitSelected:
		push 	{r4-r10,lr}
		
		bl		DrawBlackBackGround
		//Game_Name
		mov		r0,	#920
		mov		r1,	#130
		ldr		r2, =0xFFFF2416			// colour
		ldr		r3, =gameName
		bl		Draw_String

		//Main_Menu
		mov		r0,	#910
		mov		r1,	#250
		ldr		r2, =0xFFFF2416		
		ldr		r3, =mainMenu
		bl		Draw_String

		//Play_Game
		mov		r0,	#900
		mov		r1,	#350
		ldr		r2, =0xFFFF2416	
		ldr		r3, =playGame
		bl		Draw_String

		@prints "QUIT"
		mov		r0,	#900
		mov		r1,	#450
		ldr		r2, =0xFFFF2416	
		ldr		r3, =quitSelect
		bl		Draw_String
		
		//Creator_Names
		mov		r0,	#700
		mov		r1,	#550
		ldr		r2, =0xFFFF2416		
		ldr		r3, =names
		bl		Draw_String
		
		pop	{r4-r10,pc}


@ Data section
.section .data

.global MainMenu
MainMenu:
.asciz	"Main Menu"




