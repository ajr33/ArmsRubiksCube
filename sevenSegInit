sevenSegInit:
	push 	{lr}
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

	; set pb4 & pb7 to alternate function
	ldrb	r0, [r1, #0x420]
	orr		r0, #0x90
	strb	r0, [r1, #0x420]

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

	; set pc7 as output
	ldrb	r0, [r1, #0x400]
	orr		r0, #0x80
	strb	r0, [r1, #0x400]

	; set pc7 as digital
	ldrb	r0, [r1, #0x51c]
	orr		r0, #0x80
	strb	r0, [r1, #0x51c]

	; for now, keep output pc7 high
	bl		latch7Seg

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
	mov		r0, #250
	strb	r0, [r1, #0x10]

	; set spi2 to 8 bit data (SSICR0)
	;ldrh	r0, [r1]
	;orr		r0, #0x7
	mov		r0, #0xf
	strh	r0, [r1]

	; enable the spi2 (SSICR1)
	ldrb	r0, [r1, #0x4]
	orr		r0, #2
	strb	r0, [r1, #0x4]



	pop 	{lr}
	mov 	pc, lr
