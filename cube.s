	.data
game_state:		.byte 0	; 	0 - not started
						;	1 - started (no peek)
						;	2 - peeking
						;	3 - waiting for timer to reset

peekData: 		.byte 0 ; 0 - none, Otherwise - face to peek
	.text

	.global cubeGame
	.global timer1_init
	.global uart_init
	.global gpio_interrupt_init

;game state
ptr_gameState:		.word 	game_state
ptr_peekData:		.word	peekData


cubeGame:
	ldr		r7, ptr_peekData
	ldr		r9, ptr_gameState

	; Initialize peripherals
	bl 	timer1_init


	;set r1 to timer 1 base address
	MOV     r1, #0x1000
	MOVT    r1, #0x4003
	;start timer
	LDRB    r0, [r1, #0xC]
	ORR     r0, r0, #0x3		        ; set bit 0 to 1, set bit 1 to 1 to allow debugger to stop timer
	STRB    r0, [r1, #0xC]            ; enable timer 1 (A) for use

	bl	gpio_interrupt_init



	bl 	uart_init


cubeGameLoop:
	; check peek data
	ldrb 	r0, [r7]
	cmp		r0, #0
	beq		cubeGameLoop

	; store new game state
	mov 	r0, #3
	strb	r0, [r9]

	; check if peeking or not
waitForTimer:
	ldrb	r0, [r9]
	cmp		r0, #3
	beq		waitForTimer

waitForPeek:
	ldrb	r0, [r9]
	cmp		r0, #2
	beq		waitForPeek


	; is peeking here, so reset
	mov r0, #0
	strb	r0, [r7]
	strb	r0, [r8]





	b cubeGameLoop









