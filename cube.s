	.data
game_state:		.byte 0	; 	0 	- not started
						;	1 	- started (no peek)
						;	2 	- peeking
						;	3 	- waiting for timer to reset
						;	4 	- won
						;	5	- quit
						;	6 	- paused
						;	7	- rotating face 2
						;	8	- rotating face 1
						;	9	- waiting for timer 0 for rotation 2


; status of the rotation of the cube
rotate_cube:	.byte	0 		; 0 - not rotating
								; 0xa1 - rotating left (new face is on the right) - state 1
								; 0xa2 - rotating left - state 2
								; 0xb1 - rotating up (new face is on the bottom) - state 1
								; 0xb2 - rotating up - state 2
								; 0xc1 - rotating right (new face is on the left) - state 1
								; 0xc2 - rotating right - state 2
								; 0xd1 - rotating down (new face is on the top) - state 1
								; 0xd2 - rotating down - state 2



addr_rotation:	.word	0

peekData: 		.byte 0 ; 0 - none, Otherwise - face to peek


quit_message:	.string 0xC
				.string 0xA, 0xD, "Quitting...", 0x7, 0

	.text

	.global 	cubeGame

	.global 	output_string
	.global		timer0_init
	.global 	timer1_init
	.global 	uart_init
	.global 	gpio_interrupt_init
	.global		quit_game
	.global 	illuminate_RGB_LED
	.global		show_home_screen

	; lcd
	.global 	init_lcd
	.global		lcd_cmd
	.global		lcd_data
	.global		lcd_show_home
	.global 	lcd_show_pause
	.global		lcd_show_quit
	.global		clear_lcd

;game state
ptr_gameState:		.word 	game_state
ptr_peekData:		.word	peekData

; rotation data
ptr_rotData:		.word	rotate_cube

ptr_addr_rotation:	.word	addr_rotation

;quit message
ptr_quit_message:	.word	quit_message

cubeGame:
 	push	{lr}

	ldr		r5, ptr_rotData
	ldr		r7, ptr_peekData
	ldr		r8, ptr_addr_rotation
	ldr		r9, ptr_gameState

	; Initialize peripherals
	bl		timer0_init
	bl 		timer1_init


	;set r1 to timer 1 base address
	MOV     r1, #0x1000
	MOVT    r1, #0x4003
	;start timer
	LDRB    r0, [r1, #0xC]
	ORR     r0, r0, #0x3		        ; set bit 0 to 1, set bit 1 to 1 to allow debugger to stop timer
	STRB    r0, [r1, #0xC]            ; enable timer 1 (A) for use

	bl		gpio_interrupt_init

	bl 		uart_init

	bl		init_lcd

	bl		show_home_screen


cubeGameLoop:
	;check for quit
	ldrb	r0, [r9]
	cmp		r0, #5
	beq		quit_game



	b cubeGameLoop



quit_game:
	ldr		r0, ptr_quit_message
	bl		output_string

	bl		lcd_show_quit

	; turn off the rgb led upon quitting.
	mov		r0, #0
	bl		illuminate_RGB_LED

	pop		{lr}
	mov		pc, lr


	.end

; wait for timer to interrupt and process code.
; use r5 since it has the blank face filled.
wait_for_rotation1:
	ldrb	r0, [r9]
	cmp		r0, #8
	beq		wait_for_rotation1

	cmp		r0, #7
	it		eq
	bleq	pick_second_rotation

wait_for_rotation2:
	ldrb	r0, [r9]
	cmp		r0, #7
	beq		wait_for_rotation2

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


	b cubeGameLoop


