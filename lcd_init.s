; Author: 	Anthony Roberts

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

	.text

	.global 	lcd1502


lcd1502:
	push	{lr}

	bl		lcd_init

loop:
	b 		loop

	pop		{lr}
	mov		pc, lr

; full command to send is in r0
; this subroutine is the startup for sending a command to the lcd
lcd_cmd:
	push	{lr}

	; first we need to send the higher nibble to the display
	push	{r0}
	bic		r0, #0xf		; completely clear the lower nibble
	bl		send_lcd_cmd

	; delay to give lcd time to read upper nibble
	mov		r0, #1000
	bl		delay_us

	; now send the lower nibble
	pop		{r0}
	lsl		r0, #4 			; move the lower nibble up to the upper nibble to send
	bl		send_lcd_cmd

	; delay to give lcd time to read lower nibble
	mov		r0, #1000
	bl		delay_us


	pop		{lr}

	mov 	pc, lr


; full command to send is in r0
; this subroutine is the startup for sending a character to the lcd
lcd_data:
	push	{lr}

	; first we need to send the higher nibble to the display
	push	{r0}
	bic		r0, #0xf		; completely clear the lower nibble
	bl		send_lcd_data

	; delay to give lcd time to read upper nibble
	mov		r0, #1000
	bl		delay_us

	; now send the lower nibble
	pop		{r0}
	lsl		r0, #4			; move the lower nibble up to the upper nibble to send
	bl		send_lcd_data


	; delay to give lcd time to read lower nibble
	mov		r0, #1000
	bl		delay_us

	pop		{lr}

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

	; change the orientation of the bits
	;lsl		r3, r0, #24
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
	bne		delay_us_Loop

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


lcd_init:
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
	bl		unlatch_lcd

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

	; select the prescaler value of 1 (SSICPSR)
	; i.e. 16 mhz/4  = 4mhz
	mov		r0, #4
	strb	r0, [r1, #0x10]

	; set spi2 to 8 bit data (SSICR0)
	ldrb	r0, [r1]
	orr		r0, #0x7
	;mov		r0, #0x7
	strb	r0, [r1]

	; enable the spi2 (SSICR1)
	ldrb	r0, [r1, #0x4]
	orr		r0, #2
	strb	r0, [r1, #0x4]

	bl		latch_lcd

	; lcd display initialization
	; wait approx. 25 ms
	mov		r0, #25000
	bl		delay_us

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

	; display command - display on
	mov		r0, #0xf
	bl		lcd_cmd

	; increment cursor
	mov		r0, #0x6
	bl		lcd_cmd

	; display command - display on
	mov		r0, #0xe
	bl		lcd_cmd

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

	pop		{lr}

	mov		pc, lr


	.end
