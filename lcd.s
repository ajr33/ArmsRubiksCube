;   Author: 	Anthony Roberts

; 	Pinouts:
;		DS 		- serial data input
;		ST_CP	- storage register clock input
;		SH_CP	- shift register clock input
;
;
;
;
;	U6
;		SER 	= PB7
;		RCLK	= PC6
;		SRCLK 	= PB4
;
;		595 pin config
;		LCD - rs = q0 = bit 0
;		LCD - enable = q1 = bit 1
;		LCD D4-7 = q4-q7


	.data

home_screen_lcd:		.string "Arms Rubiks Cube", 0
						.string "Space to start!", 0

pause_screen_lcd:		.string "     PAUSED     ", 0

win_screen_lcd:			.string "    YOU WON!    ", 0

quit_screen_lcd:		.string "Thanks for      ", 0xA
						.string "playing! Goodbye", 0

time_and_moves_text:	.string "     Moves:     ", 0

sixteen_spaces:			.string "                ",0


	.text

	.global 	init_lcd
	.global		lcd_cmd
	.global		lcd_data
	.global		lcd_show_home
	.global 	lcd_show_pause
	.global		lcd_show_win
	.global		lcd_show_quit
	.global		clear_lcd
	.global		lcd_line_2
	.global		lcd_print_string
	.global		move_lcd_cursor
	.global		lcd_print_time_and_moves
	.global		lcd_clear_top
	.global		delay_us

;	.global uart_init
;	.global uart_interrupt_init


ptr_home_lcd:		.word	home_screen_lcd
ptr_pause_lcd:		.word 	pause_screen_lcd
ptr_win_lcd:		.word	win_screen_lcd
ptr_quit_lcd:		.word	quit_screen_lcd

ptr_time_moves: 	.word	time_and_moves_text
ptr_16_spaces:		.word	sixteen_spaces


lcd_print_time_and_moves:
	push	{lr}
	mov		r1, #0
	bl		move_lcd_cursor

	ldr		r3, ptr_time_moves

tm1:
	ldrb	r0, [r3], #1
	cmp		r0, #0
	beq		time_move_done
	bl		lcd_data
	b		tm1

time_move_done:
	pop		{lr}
	mov		pc, lr



; r0 holds the address of the string to print.
; note lcd can display 16 characters in one line
; 	r1 holds the position to start at LCD
;	upper nibble of r1 determines the line to print on
;		0 - first line
;		1 - second line
;	lower nibble determines where to start on the display
;		i.e. 0x1A = second line 10th position
lcd_print_string:
	push	{lr}
	push	{r0}

	; use r1 to determine where cursor should be
	bl		move_lcd_cursor

	pop		{r0} 	; retrieve the address
	mov		r1, r0
print_lcd_char:
	ldrb	r0, [r1], #1
	cmp		r0, #0
	beq		print_lcd_done
	bl		lcd_data
	b		print_lcd_char

print_lcd_done:
	pop		{lr}
	mov		pc, lr



lcd_clear_top:
	push	{lr}
	mov		r1, #0
	bl		move_lcd_cursor

	ldr		r3, ptr_16_spaces

clear_top:
	ldrb	r0, [r3], #1
	cmp		r0, #0
	beq		clear_top_done
	bl		lcd_data
	b		clear_top

clear_top_done:
	pop		{lr}
	mov		pc, lr



; r1 holds the position to start at LCD
;	upper nibble of r1 determines the line to print on
;		0 - first line
;		1 - second line
;	lower nibble determines where to start on the display
;		i.e. 0x1A = second line 10th position
move_lcd_cursor:
	push	{lr}

	; determine the line based on the upper nibble of r1
	push	{r1}
	lsr		r1, #4

	cmp		r1, #0
	ite		eq
	moveq	r0, #0x80	; force cursor to line 1 column 1 command
	movne	r0, #0xc0	; force cursor to line 2 column 1 command

	bl		lcd_cmd

	pop		{r1}
	and		r1, #0xf	; keep lower nibble

	; shift cursor position to the right

shift_cursor_to_right:
	cmp		r1, #0
	ble		move_lcd_cursor_done
	mov		r0, #0x14		; shift cursor to right command
	bl		lcd_cmd
	sub		r1, #1
	b		shift_cursor_to_right

move_lcd_cursor_done:
	pop		{lr}
	mov		pc, lr



lcd_show_win:
	push	{lr}
	mov		r1, #0
	bl		move_lcd_cursor

	ldr		r3, ptr_win_lcd

win1:
	ldrb	r0, [r3], #1
	cmp		r0, #0
	beq		lcd_show_win_done
	bl		lcd_data
	b		win1

lcd_show_win_done:
	pop		{lr}
	mov		pc, lr



lcd_show_quit:
	push	{lr}
	mov		r1, #0
	bl		move_lcd_cursor

	ldr		r3, ptr_quit_lcd

quit1:
	ldrb	r0, [r3], #1
	cmp		r0, #0xa

	; if 0xA is present, go to the next line.
	ittt		eq
	moveq	r0, #0xc0
	bleq	lcd_cmd
	beq		quit1

	cmp		r0, #0
	beq		quit_done

	bl		lcd_data
	b		quit1

quit_done:
	pop		{lr}
	mov		pc, lr



; show the home screen text for LCD
lcd_show_home:
	push	{lr}
	ldr		r3, ptr_home_lcd

home1:
	ldrb	r0, [r3], #1
	cmp		r0, #0
	beq		home2Init
	bl		lcd_data
	b		home1

home2Init:
	bl		lcd_line_2
home2:
	ldrb	r0, [r3], #1
	cmp		r0, #0
	beq		home_end
	bl		lcd_data
	b		home2

home_end:
	pop		{lr}
	mov		pc, lr



; show the pause screen text for LCD
lcd_show_pause:
	push	{lr}

	; beginning of lcd screen
	mov		r1, #0
	bl		move_lcd_cursor

	ldr		r3, ptr_pause_lcd

pause1:
	ldrb	r0, [r3], #1
	cmp		r0, #0
	beq		pause_end
	bl		lcd_data
	b		pause1

pause_end:
	pop		{lr}
	mov		pc, lr


; clears the lcd display
clear_lcd:
	push	{lr}

	mov		r0, #1
	bl		lcd_cmd

	pop		{lr}
	mov		pc, lr


lcd_line_2:
	push	{lr}
	; move to beginning of second row on the lcd
	mov		r0, #0xc0
	bl		lcd_cmd
	pop		{lr}
	mov		pc, lr


init_lcd:
	push	{lr}

	bl		spi2_init
	bl		lcd_4bit_init

	pop		{lr}
	mov		pc, lr

; full command to send is in r0
; this subroutine is the startup for sending a command to the lcd
lcd_cmd:
	push	{r1, lr}

	; first we need to send the higher nibble to the display
	push	{r0}
	bic		r0, #0xf		; completely clear the lower nibble
	bl		send_lcd_cmd

	; delay to give lcd time to read upper nibble
	mov		r0, #5000
	bl		delay_us

	; now send the lower nibble
	pop		{r0}
	lsl		r0, #4 			; move the lower nibble up to the upper nibble to send
	bl		send_lcd_cmd

	; delay to give lcd time to read lower nibble
	mov		r0, #5000
	bl		delay_us


	pop		{r1, lr}

	mov 	pc, lr


; full command to send is in r0
; this subroutine is the startup for sending a character to the lcd
lcd_data:
	push	{r1, lr}

	; first we need to send the higher nibble to the display
	push	{r0}
	bic		r0, #0xf		; completely clear the lower nibble
	bl		send_lcd_data

	; delay to give lcd time to read upper nibble
	mov		r0, #5000
	bl		delay_us

	; now send the lower nibble
	pop		{r0}
	lsl		r0, #4			; move the lower nibble up to the upper nibble to send
	bl		send_lcd_data


	; delay to give lcd time to read lower nibble
	mov		r0, #5000
	bl		delay_us

	pop		{r1, lr}

	mov 	pc, lr


; r0 stores what to send
send_lcd_data:
	push	{lr}

	; ssi2 base address
	mov		r2, #0xA000
	movt	r2, #0x4000

	; unlatch
	bl		unlatch_lcd

	; wait for tx fifo to be empty
	bl	ssiTxWait


	; set rs
	orr		r0, #0x01
	; set enable
	orr		r0, #0x02

	; send data
	strb	r0, [r2, #0x8]


	; wait for transmission to complete
	bl		ssiTxCompWait

	; latch to update new output
	bl		latch_lcd

	push	{r0}
	mov		r0, #25000
	bl		delay_us
	pop		{r0}

	; we need to send the same data this time
	; with enable set low.

	; unlatch
	bl		unlatch_lcd

	; wait for tx fifo to be empty
	bl	ssiTxWait


	; reset enable
	bic		r0, #0x2	; this is the second bit because
						; remember the tiva sends the data from left to right so
						; 0000 0010 will output 0100 0000 on the shift register

	; send data
	strb	r0, [r2, #0x8]


	; wait for transmission to complete
	bl		ssiTxCompWait

	; latch to update new output
	bl		latch_lcd


	pop		{lr}
	mov		pc, lr





; r0 stores what to send
send_lcd_cmd:
	push	{lr}

	; ssi2 base address
	mov		r2, #0xA000
	movt	r2, #0x4000

	; unlatch
	bl		unlatch_lcd

	; wait for tx fifo to be empty
	bl	ssiTxWait

	; set rs
	bic		r0, #0x01
	; set enable
	orr		r0, #0x02

	; change the orientation of the bits
	;lsl	r3, r0, #24
	;rbit	r0, r3

	; send data
	strb	r0, [r2, #0x8]

	; wait for transmission to complete
	bl		ssiTxCompWait

	; latch to update new output
	bl		latch_lcd

	push	{r0}
	mov		r0, #25000
	bl		delay_us
	pop		{r0}
	; we need to send the same data this time
	; with enable set low.

	; unlatch
	bl		unlatch_lcd

	; wait for tx fifo to be empty
	bl	ssiTxWait


	; reset enable
	bic		r0, #0x2	; this is the second bit because
						; remember the tiva sends the data from left to right so
						; 0000 00[1]0 will output 0100 00[0]0 on the shift register


	; send data
	strb	r0, [r2, #0x8]


	; wait for transmission to complete
	bl		ssiTxCompWait

	; latch to update new output
	bl		latch_lcd


	pop		{lr}
	mov		pc, lr





unlatch_lcd:
	push	{r0, r1}
	; gpio port c base address
	mov 	r1, #0x6000
	movt	r1, #0x4000

	; set low to unlatch
	mov		r0, #0x00
	strb	r0, [r1, #0x100] 	; 0x100 says to only set the 6th bit since
								; addressing is done with bits 9:2 (i.e. bit 9 is set only)
	pop		{r0, r1}
	mov		pc, lr



latch_lcd:
	push	{r0, r1}
	; gpio port c base address
	mov 	r1, #0x6000
	movt	r1, #0x4000

	; set high to latch
	mov		r0, #0x40
	strb	r0, [r1, #0x100] 	; 0x100 says to only set the 6th bit since
								; addressing is done with bits 9:2 (i.e. bit 9 is set only)
	pop		{r0, r1}
	mov		pc, lr




; r0 holds amount to delay for in microseconds
; Note: this is an approx. calculation
delay_us:
	push 	{r1}
	mov		r1, #0

delay_us_Loop:
	add		r1, #1
	cmp		r0, r1
	bgt		delay_us_Loop

	pop		{r1}
	mov		pc, lr



; wait for tx fifo to be not full
ssiTxWait:
	ldrb	r1, [r2, #0xc]
	and		r1, #2
	cmp		r1, #0
	beq		ssiTxWait
	mov		pc, lr


; wait for transmit to complete
ssiTxCompWait:
	ldrb	r1, [r2, #0xc]
	and		r1, #0x10
	cmp		r1, #0x10
	beq		ssiTxCompWait
	mov		pc,	lr


spi2_init:
	push	{lr}

	; base address
	mov 	r1, #0xe000
	movt	r1, #0x400f


	; enable spi2 clock
	ldrb	r0, [r1, #0x61c]
	orr		r0, #0x4
	strb	r0, [r1, #0x61c]


	; enable gpio ports b, c
	ldrb	r0, [r1, #0x608]
	orr		r0, #0x6
	strb	r0, [r1, #0x608]


	; gpio port b base address
	mov 	r1, #0x5000
	movt	r1, #0x4000

	; disable analog functionality for pb4 & pb7
	ldrb	r0, [r1, #0x528]
	bic		r0, #0x90
	strb	r0, [r1, #0x528]

	; set pb4 & pb7 to digital
	ldrb	r0, [r1, #0x51c]
	orr		r0, #0x90
	strb	r0, [r1, #0x51c]

	; set pb4 & pb7 to alternate function (GPIOAFSEL)
	ldrb	r0, [r1, #0x420]
	orr		r0, #0x90
	strb	r0, [r1, #0x420]

	; 0xf00f.0000 is to set up alternate function for pin 7 and pin 4
	; check GPIOPCTRL of documentation &
	; section 23.4 GPIO Pins and Alternate Functions
	; table 23-5
	mov		r2, #0
	movt	r2, #0xf00f
	; set pb4 & pb7 to spi2
	; first clear all bits
	ldr		r0, [r1, #0x52c]
	bic		r0, r2
	str		r0, [r1, #0x52c]

	; now set the alternate function
	mov		r2, #0
	movt	r2, #0x2002
	ldr		r0, [r1, #0x52c]
	orr		r0, r2
	str		r0, [r1, #0x52c]


	; gpio port c base address
	mov 	r1, #0x6000
	movt	r1, #0x4000

	; set pc6 as output for latch
	ldrb	r0, [r1, #0x400]
	orr		r0, #0x40
	strb	r0, [r1, #0x400]

	; set pc6 as digital
	ldrb	r0, [r1, #0x51c]
	orr		r0, #0x40
	strb	r0, [r1, #0x51c]

	; for now, keep output pc7 high
	bl		latch_lcd

	; set spi2 as master, POL = 0, PHA = 0, clock = 4 mhz, 8 bit data

	; ssi2 base address
	mov		r1, #0xA000
	movt	r1, #0x4000

	; disable spi2 & configure it has master (SSICR1)
	ldrb	r0, [r1, #0x4]
	bic		r0, #6
	strb	r0, [r1, #0x4]

	; enable the system clock option to use (SCICC)
	ldrb	r0, [r1, #0xfc8]
	bic		r0, #1
	strb	r0, [r1, #0xfc8]

	; select the prescaler value of 4 (SSICPSR)
	; i.e. 16 mhz/4  = 4mhz
	mov		r0, #4
	strb	r0, [r1, #0x10]

	; set spi2 to 8 bit data (SSICR0)
	ldrb	r0, [r1]
	bic		r0, #0x0f		; clear any previous value.
	orr		r0, #0x7
	strb	r0, [r1]

	; enable the spi2 (SSICR1)
	ldrb	r0, [r1, #0x4]
	orr		r0, #2
	strb	r0, [r1, #0x4]

	; lcd display initialization
	; wait approx. 25 ms
	mov		r0, #25000
	bl		delay_us


	pop		{lr}
	mov		pc,	lr





lcd_4bit_init:
	push	{lr}
	; 4 bit mode
	mov		r0, #0x33
	bl		lcd_cmd
	mov		r0, #0x32
	bl		lcd_cmd

	; 2 lines and 5x8 dots
	mov		r0, #0x28
	bl		lcd_cmd

	; clear display
	mov		r0, #0x1
	bl		lcd_cmd

	; display command - display on; cursor blinking
	mov		r0, #0xf
	bl		lcd_cmd

	; increment cursor
	mov		r0, #0x6
	bl		lcd_cmd

	; display command - display on; no cursor blinking
	mov		r0, #0xe
	bl		lcd_cmd

	; you can move these two lines towards the end to test printing characters to the lcd
	pop		{lr}
	mov		pc, lr







	.end

	; these lines of code are for testing characters printing
	; to the screen. we can omit them in actual initialization code.
	; but nice to have to make sure that the initialization is done
	; correctly.
	mov		r0, #'H'
	bl		lcd_data

	mov		r0, #'e'
	bl		lcd_data

	mov		r0, #'l'
	bl		lcd_data

	mov		r0, #'l'
	bl		lcd_data

	mov		r0, #'o'
	bl		lcd_data

	mov		r0, #' '
	bl		lcd_data

	mov		r0, #'E'
	bl		lcd_data

	mov		r0, #'r'
	bl		lcd_data

	mov		r0, #'i'
	bl		lcd_data

	mov		r0, #'c'
	bl		lcd_data

	mov		r0, #'!'
	bl		lcd_data

	mov		r0, #'!'
	bl		lcd_data



