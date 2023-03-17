	.text

    .global GameClock_Handler	;yes diff
    .global Timer_Handler		;yes diff
    .global timer0_interrupt_init	;yes same
	.global timer1_init				;yes same as above
	.global draw_colors
	.global	draw_peek


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
timer0_interrupt_init:
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


;***************************************************************************************************
; Function name: Timer_Handler
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
Timer_Handler:
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

	cmp 	r0, #2
	beq		stop_peeking

	cmp		r0, #3
	beq 	can_start_peek

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

Timer_Handler_return:
    ; Regardless, need to update score and time on board
    ;bl      print_time_score

    pop     {r4-r11, lr}
    bx      lr



    .end
