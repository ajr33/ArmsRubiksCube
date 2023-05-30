	.data

;the gameclock
game_time:		.word	0
print_time:		.word	0, 0

;rgb data after winning
rgb_data:	.byte	2 	; 2 - red
					  	; 4 - blue
					  	; 6 - purple
					  	; 8 - green
					  	; A - yellow
					  	; C - cyan
					  	; E - white



	.text

    .global GameClock_Handler	;yes diff
    .global Timer0_Handler
    .global Timer1_Handler		;yes diff
    .global timer0_init	;yes same
	.global timer1_init				;yes same as above
	.global draw_colors
	.global	draw_peek
	.global output_string	;yes same
    .global int2string
    .global	reset_game_clock
    .global illuminate_RGB_LED
    .global show_player_time
    .global draw_colors
    .global animate_rotation

	.global		lcd_cmd
	.global		lcd_data
	.global 	lcd_show_pause
	.global		clear_lcd
	.global		lcd_line_2
	.global		lcd_print_string

;rgb constants
rgbRed:			.equ	0x2
rgbWhite:		.equ	0xE
rgbPurple:		.equ	0x6
rgbBlue:		.equ	0x4
rgbGreen:		.equ	0x8
rgbYellow:		.equ	0xA

; time location on screen
timePosition:		.string 27, "[15;7H", 0
ptr_timePosition:	.word timePosition

; raw time in memory
ptr_game_time:		.word	game_time
ptr_print_time:		.word	print_time

;rgb data
ptr_rgb:			.word	rgb_data


;TIMER OFFSETS
RCGCTIMER: 	    .equ 0x604 	            ;Timer Run Mode Clock Gating Control
GPTMCTL:	    .equ 0x00C 	            ;Timer Control Register
GPTMTAMR: 	    .equ 0x004	            ;Timer A Mode Register
GPTMTAILR:	    .equ 0x028	            ;Timer Interval Load Register
GPTMIMR:	    .equ 0x018	            ;Timer Interrupt Mask Register
GPTMICR:	    .equ 0x024      	    ;Timer Interrupt Clear Register
EN0: 		    .equ 0x100	            ;NVIC Interrupt Enable Register

;***************************************************************************************************
; Function name: timer0_interrupt_init
; Function behavior: Initializes timer 0 for 32-bit mode, half second intervals. Sets address of
; shared variable from lab7.s
;
; Function inputs:
; r0 : Address of local variable from main
;
; Function returns: none
;
; Registers used:
; r0: value manipulation
; r1: holds base address of timer 0
;
; Subroutines called: none
;
;
; REMINDER: Push used registers r4-r11 to stack if used *PUSH/POP {r4, r5} or PUSH/POP {r4-r11})
; REMINDER: If calling another function from inside, PUSH/POP {lr}. To return from function MOV pc, lr
;***************************************************************************************************
timer0_init:
	PUSH    {lr}


	;set r1 to clock settings base address
	MOV     r1, #0xE000
	MOVT    r1, #0x400F

	;load in current value of the timer clock settings
	LDRB    r0, [r1, #RCGCTIMER]
	ORR     r0, r0, #0x1
	STRB    r0, [r1, #RCGCTIMER]        ;enable clock for timer 0 (A)

	;TIMER SETUP

	;set r1 to timer 0 base address
	MOV     r1, #0x0000
	MOVT    r1, #0x4003

	;Disable the timer
	;load current status
	LDRB    r0, [r1, #GPTMCTL]
	AND     r0, r0, #0x0		        ;set bit 0 to 1
	STRB    r0, [r1, #GPTMCTL]          ;disable timer 0 (A) for setup

	;set 32-bit mode
	;GPTMCFG: 	.equ 0x000 ;General Purpose Timer Configuration Register
	;load current status
	LDRB    r0, [r1]
	AND     r0, r0, #0x0	            ;set bit 0 to 1
	STRB    r0, [r1] 		            ;set configuration 32-bit for 16/32 bit timer

	;set periodic mode
	;load current status
	LDRB    r0, [r1, #GPTMTAMR]
	ORR     r0, r0, #0x2			    ;set 2 to r0
	STRB    r0, [r1, #GPTMTAMR]         ;set periodic mode for timer A

	;set interval period
	;load current status
	LDR     r0, [r1, #GPTMTAILR]
	MOV     r0, #0x1200				    ;set r2 to 8 million
	MOVT    r0, #0x007A			        ;for 2 timer interrupts a second
	STR     r0, [r1, #GPTMTAILR] 	    ;set interval period for timer A

	;set up to interrupt processor
	;load current status
	LDR     r0, [r1, #GPTMIMR]
	ORR     r0, r0, #0x1		        ;set bit 0 to 1
	STR     r0, [r1, #GPTMIMR] 	        ;enable interrupts for timer A

	;Allow Timer to Interrupt Processor
	;set r1 to EN0 base address
	MOV     r1, #0xE000
	MOVT    r1, #0xE000

	;load current status
	LDR     r0, [r1, #EN0]
	ORR     r0, r0, #0x80000		    ;set timer 0 to be able to interrupt processor
	STR     r0, [r1, #EN0]

	;set r1 to timer 0 base address
	MOV     r1, #0x0000
	MOVT    r1, #0x4003
	;start timer
	LDRB    r0, [r1, #0xC]
	ORR     r0, r0, #0x3		        ; set bit 0 to 1, set bit 1 to 1 to allow debugger to stop timer
	STRB    r0, [r1, #0xC]            	; enable timer 0 (A) for use

	POP     {lr}
	MOV     pc, lr

;***************************************************************************************************
; Function name: timer1_init
; Function behavior: Initializes the timer to be continuous. Timer is used as a seed for random
; number generator.
;
; Function inputs: none
;
; Function returns: none
;
; Registers used:
; r0: value manipulation
; r1: holds base address of timer 0
;
; Subroutines called:
;
;
; REMINDER: Push used registers r4-r11 to stack if used *PUSH/POP {r4, r5} or PUSH/POP {r4-r11})
; REMINDER: If calling another function from inside, PUSH/POP {lr}. To return from function MOV pc, lr
;***************************************************************************************************
timer1_init:
	PUSH    {lr}

	;set r1 to clock settings base address
	MOV     r1, #0xE000
	MOVT    r1, #0x400F

	;load in current value of the timer clock settings
	LDRB    r0, [r1, #RCGCTIMER]
	ORR     r0, r0, #0x2
	STRB    r0, [r1, #RCGCTIMER]        ;enable clock for timer 1 (A)

	;TIMER SETUP

	;set r1 to timer 1 base address
	MOV     r1, #0x1000
	MOVT    r1, #0x4003

	;Disable the timer
	;load current status
	LDRB    r0, [r1, #GPTMCTL]
	AND     r0, r0, #0x0		        ;set bit 0 to 1
	STRB    r0, [r1, #GPTMCTL]          ;disable timer 1 (A) for setup

	;set 32-bit mode
	;GPTMCFG: 	.equ 0x000 ;General Purpose Timer Configuration Register
	;load current status
	LDRB    r0, [r1]
	AND     r0, r0, #0x0	            ;set bit 0 to 1
	STRB    r0, [r1] 		            ;set configuration 32-bit for 16/32 bit timer

	;set periodic mode
	;load current status
	LDRB    r0, [r1, #GPTMTAMR]
	ORR     r0, r0, #0x2			    ;set 2 to r0
	STRB    r0, [r1, #GPTMTAMR]         ;set periodic mode for timer A

	;set interval period
	;load current status
	LDR     r0, [r1, #GPTMTAILR]
	MOV     r0, #0x2400				    ;set r2 to 16 million
	MOVT    r0, #0x00F4			        ;for 1 timer interrupt a second
	STR     r0, [r1, #GPTMTAILR] 	    ;set interval period for timer A



	;set up to interrupt processor
	;load current status
	LDR     r0, [r1, #GPTMIMR]
	ORR     r0, r0, #0x1		        ;set bit 0 to 1
	STR     r0, [r1, #GPTMIMR] 	        ;enable interrupts for timer A

	;Allow Timer to Interrupt Processor
	;set r1 to EN0 base address
	MOV     r1, #0xE000
	MOVT    r1, #0xE000

	;load current status
	LDR     r0, [r1, #EN0]
	ORR     r0, r0, #0x200000		    ;set timer 1 to be able to interrupt processor
	STR     r0, [r1, #EN0]



	POP     {lr}
	MOV     pc, lr


Timer0_Handler:
    push    {r4-r11, lr}

    ;CLEAR INTERRUPT
	;load timer 1 base address
	MOV     r1, #0x0000
	MOVT    r1, #0x4003

	;set 1 to clear the interrupt
	LDR     r0, [r1, #GPTMICR]
	ORR     r0, r0, #0x01
	STR     r0, [r1, #GPTMICR]

	; if rotation needs to happen
	ldrb	r0, [r5]	; r5 holds address of rotation state of the cube (from cube.s)
	cmp		r0, #0
	itt		ne
	blne	animate_rotation
	bne		timer0_end

	b		timer0_end


	; check if we should rotate the face or not
	ldrb	r0, [r9]

	cmp		r0, #9
	beq		rotate_2

	cmp		r0, #8
	beq		rotate_1

	b		timer0_end

rotate_2:
	; load the face to draw into r4
	ldr		r4, [r8]
	bl 		draw_colors
	; reset game state
	mov		r0, #1
	strb	r0, [r9]
	b		timer0_end

rotate_1:
	; load the face to draw into r4
	ldr		r4, [r8]
	bl 		draw_colors
	; set game state for second rotation
	mov		r0, #7
	strb	r0, [r9]

timer0_end:
	pop    {r4-r11, lr}
	bx		lr

;***************************************************************************************************
; Function name: Timer1_Handler
; Function behavior: Main gameplay loop. Updates the board state based on the direction variable.
; Uses remaining board spaces and score to determine if game is ended and whether game was won/lost.
;
; Function inputs: none
;
; Function returns: none
;
; Registers used:
;
;
; Subroutines called:
;
;
; REMINDER: Push used registers r4-r11 to stack if used *PUSH/POP {r4, r5} or PUSH/POP {r4-r11})
; REMINDER: If calling another function from inside, PUSH/POP {lr}. To return from function MOV pc, lr
;***************************************************************************************************
Timer1_Handler:
    push    {r4-r11, lr}

    ;CLEAR INTERRUPT
	;load timer 1 base address
	MOV     r1, #0x1000
	MOVT    r1, #0x4003

	;set 1 to clear the interrupt
	LDR     r0, [r1, #GPTMICR]
	ORR     r0, r0, #0x01
	STR     r0, [r1, #GPTMICR]

	; check game state (r9 has pointer to game state from cube.s)
	ldrb	r0, [r9]
	;game didn't start yet
	cmp		r0, #0
	beq		Timer_Handler_return

	;if game has quit or is paused, return
	cmp		r0, #5
	bge		Timer_Handler_return


	; game won, return
	cmp		r0, #4
	beq		rgb_win


	;increment game clock
	ldr		r0, ptr_timePosition
	bl		output_string

	ldr		r1, ptr_game_time
	ldr		r0, [r1]
	add		r0, #1			;increment the gameclock by 1
	str		r0, [r1]
	ldr		r1, ptr_print_time
	bl		int2string

	mov		r0, r1
;	push	{r0}
	bl		output_string
;	pop		{r0}

;	mov		r1, #0x13		; row 2 column 3 start printing
;	bl		lcd_print_string

	b		Timer_Handler_return








stop_peeking:
	mov 	r0, #1
	strb	r0, [r9]
	bl 		draw_colors
	b		Timer_Handler_return


can_start_peek:
	; peek
	ldrb	r3, [r7]
	bl		draw_peek
	mov		r0, #2
	strb	r0, [r9]
	b		Timer_Handler_return



; 2 - red
					  	; 4 - blue
					  	; 6 - purple
					  	; 8 - green
					  	; A - yellow
					  	; C - cyan
					  	; E - white



rgb_win:
	ldr		r1, ptr_rgb
	ldrb	r0, [r1]
	bl		illuminate_RGB_LED

	cmp		r0, #0x2
	beq		win_blue

	cmp		r0, #0x4
	beq		win_purple


	cmp		r0, #0x6
	beq		win_green


	cmp		r0, #0x8
	beq		win_yellow


	cmp		r0, #0xA
	beq		win_white

	;win_red
	mov		r0, #0x2
	strb	r0, [r1]
	b		Timer_Handler_return


win_blue:
	mov		r0, #0x4
	strb	r0, [r1]
	b		Timer_Handler_return

win_purple:
	mov		r0, #0x6
	strb	r0, [r1]
	b		Timer_Handler_return

win_green:
	mov		r0, #0x8
	strb	r0, [r1]
	b		Timer_Handler_return

win_yellow:
	mov		r0, #0xA
	strb	r0, [r1]
	b		Timer_Handler_return

win_white:
	mov		r0, #0xE
	strb	r0, [r1]
	b		Timer_Handler_return


Timer_Handler_return:
    ; Regardless, need to update score and time on board
    ;bl      print_time_score

    pop     {r4-r11, lr}
    bx      lr







reset_game_clock:
	mov		r0, #0
	ldr		r1, ptr_game_time
	str		r0, [r1]
	mov		pc, lr

show_player_time:
	push 	{lr}
	; go to position on screen
	ldr		r0, ptr_timePosition
	bl		output_string

	; show the time that the player won at
	ldr		r0, ptr_print_time
	bl		output_string



	pop		{lr}
	mov		pc, lr


    .end
