	.data

	.text


	.global illuminate_RGB_LED		;yes same
    .global gpio_interrupt_init		;yes same
    .global Switch_Handler

;GPIO Register OFFSETS
DIR: .equ 0x400		;port direction register
DEN: .equ 0x51C		;port digital enable
DATA: .equ 0x3FC	;gpio data offset
PUR: .equ 0x510		;pull-up resistor offset


    ;***************************************************************************************************
; Function name: illuminate_RGB_LED
; Function behavior: Takes in an even value between 0x00 and 0x0e. Uses parameter value to set pins
; for red, green, or blue. Pin 1 (bit 2) controls red, pin 2 (bit 3) controls green, pin 3 (bit 4)
; controls blue light.
;
; Function inputs:
; r0 : value to set pins to
;
; Function returns: none
;
; Registers used:
; r4 : Holds 0x4002.5000, address of PORTF data
;
; Subroutines called: none
;
;
; REMINDER: Push used registers r4-r11 to stack if used *PUSH/POP {r4, r5} or PUSH/POP {r4-r11})
; REMINDER: If calling another function from inside, PUSH/POP {lr}. To return from function MOV pc, lr
;***************************************************************************************************
illuminate_RGB_LED:
	PUSH	{lr}

	; Push registers used by this routine
    push	{r4}

	; Set address in r4 to PORT F data address - 0x4002.53fc
	movw	r4, #0x53fc					; Load lower half of base address
	movt 	r4, #0x4002					; Load upper half of base address

	; Stores value parameter in r0 to memory
	strb 	r0, [r4]

	; Pop used registers
	pop 	{r4}

	POP 	{lr}
	MOV 	pc, lr



gpio_interrupt_init:
	PUSH 	{lr}

	; Push registers used in function to stack
    push 	{r4, r5, r6}

	; To share clock with PORT F we need to set bit 6 at address 0x400fe608
	movw	r4, #0xe608					; Load lower half of address
	movt	r4, #0x400f					; Load upper half of address
	ldrb    r5, [r4]                    ; Load current port selections
    orr 	r5,	#0x20					; Set bit 6 - 0b0010.0000 - 0x20
	strb	r5, [r4]					; Load bit set into memory

	; The above instruction needs 3 clock cycles to complete clock share

	; Set address in r4 to PORT F base address - 0x4002.5000
	movw	r4, #0x5000					; Load lower half of base address (clock cycle 1)
	movt 	r4, #0x4002					; Load upper half of base address (clock cycle 2)

	; All of the below will use offset immediates to access register.

	; Set control of PORTF pins 1-4 (bits 2-5) to digital. Pin 0 (bit 1) is the lower right button
	; Pin 1-3 control RGB and Pin 4 controls the lower left button. GPIODEN is at offset: 0x51c
	movw	r5, #0x1e					; Set bits 1-3 - 0b0000.1110 - 0x1E (clock cycle 3)
	; Clock share has been completed with above instruction
	strb 	r5, [r4, #DEN]			; Load bit set into memory

	; Set pin direction. Pin 4 is input, pins 1-3 are outputs.  If flagged with 1 will be output,
	; flagged at 0 will be input. GPIODIR is at offset: 0x400
	movw	r5, #0x0e					; Set bit mask: 0b0000.0000 - 0x10
	strb 	r5, [r4, #DIR]			; Load bit set into memory

	; Set pull up resistor on switch. GPIOPUR is at offset: 0x510
	movw	r5, #0x10					; Set bit mask: 0b0001.0000 - 0x10
	strb 	r5, [r4, #PUR]			; Load bit set into memory

	;************************* LAB 5 CHANGE START ******************************;
	; Set pins to detect a falling edge and send an interrupt signal using GIIOIEV
	; Setting a pin high sets it to detect on a rising edge.
	; Note for myself, we want falling edge since it starts at high it will detect
	; initial change. Leave unchanged, removing instruction
	; Register offset: 0x40c   Set to detect push button: 0x10
	; strb 	r5, [r4, #0x40c]			; Instruction removed, want to detect falling edge

	; Unmask pin 4 (SW1) to allow board to detect interrupt on press.
	; Register offset: 0x410  Set to detect push button: 0x10 -
	strb r5, [r4, #0x410]

	; Set bit 31 in processor config. Bit 31 (0x4000.0000) in EOOOE100 to recognize
	; that switch has been pressed.
	movw 	r4, #0xe100
	movt 	r4, #0xe000
	; Using orr and str method to make sure we don't overwrite any other pins that
	; have already been set.
	ldr 	r5, [r4]
	movw 	r6, #0x0000					; Set lower value of bit mask
	movt	r6, #0x4000					; Set upper value
	orr		r5, r5, r6					; Update bitmask
	str		r5, [r4]					; Push updated bit mask
	;************************** LAB 5 CHANGE END *******************************;


	; Pop registers for return
	pop 	{r4, r5, r6}

	POP 	{lr}
	MOV 	pc, lr



Switch_Handler:




	.end
