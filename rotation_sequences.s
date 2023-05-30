	.text

	.global	rotLeftSeq
	.global	rotUpSeq
	.global	rotRightSeq
	.global	rotDownSeq
; first move the previous face's rows of colors
	; 2, 9, 6 	to
	; 1, 8, 7 	(note: SUBTRACT BY 1 TO GET INDEX)
	;
	;
	; 3, 4, 5 to
	; 2, 9, 6
rotLeftSeq:
	; move 2 -> 1
	ldrb	r0, [r4, #1]
	strb	r0, [r1]

	; move 9 -> 8
	ldrb	r0, [r4, #8]
	strb	r0, [r1, #7]

	; move 6 -> 7
	ldrb	r0, [r4, #5]
	strb	r0, [r1, #6]

	; move 3 -> 2
	ldrb	r0, [r4, #2]
	strb	r0, [r1, #1]

	; move 4 -> 9
	ldrb	r0, [r4, #3]
	strb	r0, [r1, #8]

	; move 5 -> 6
	ldrb	r0, [r4, #4]
	strb	r0, [r1, #5]


	mov		pc, lr



rotUpSeq:
	; first move the previous face's rows of colors
	; 8, 9, 4 	to
	; 1, 2, 3 	(note: SUBTRACT BY 1 TO GET INDEX)
	;
	;
	; 7, 6, 5 to
	; 8, 9, 4


	; move 8 -> 1
	ldrb	r0, [r4, #1]
	strb	r0, [r1]

	; move 9 -> 2
	ldrb	r0, [r4, #8]
	strb	r0, [r1, #1]

	; move 4 -> 3
	ldrb	r0, [r4, #3]
	strb	r0, [r1, #2]

	; move 7 -> 8
	ldrb	r0, [r4, #6]
	strb	r0, [r1, #7]

	; move 6 -> 9
	ldrb	r0, [r4, #5]
	strb	r0, [r1, #8]

	; move 5 -> 4
	ldrb	r0, [r4, #4]
	strb	r0, [r1, #3]

	mov		pc, lr

rotRightSeq:
	; first move the previous face's rows of colors
	; 2, 9, 6 	to
	; 3, 4, 5 	(note: SUBTRACT BY 1 TO GET INDEX)
	;
	;
	; 1, 8, 7 to
	; 2, 9, 6


	; move 2 -> 3
	ldrb	r0, [r4, #1]
	strb	r0, [r1, #2]

	; move 9 -> 4
	ldrb	r0, [r4, #8]
	strb	r0, [r1, #3]

	; move 6 -> 5
	ldrb	r0, [r4, #5]
	strb	r0, [r1, #4]

	; move 1 -> 2
	ldrb	r0, [r4]
	strb	r0, [r1, #1]

	; move 8 -> 9
	ldrb	r0, [r4, #7]
	strb	r0, [r1, #8]

	; move 7 -> 6
	ldrb	r0, [r4, #6]
	strb	r0, [r1, #5]

	mov		pc, lr

rotDownSeq:
	; first move the previous face's rows of colors
	; 8, 9, 4 	to
	; 7, 6, 5 	(note: SUBTRACT BY 1 TO GET INDEX)
	;
	;
	; 1, 2, 3 to
	; 8, 9, 4


	; move 8 -> 7
	ldrb	r0, [r4, #7]
	strb	r0, [r1, #6]

	; move 9 -> 6
	ldrb	r0, [r4, #8]
	strb	r0, [r1, #5]

	; move 4 -> 5
	ldrb	r0, [r4, #3]
	strb	r0, [r1, #4]

	; move 1 -> 8
	ldrb	r0, [r4]
	strb	r0, [r1, #7]

	; move 2 -> 9
	ldrb	r0, [r4, #1]
	strb	r0, [r1, #8]

	; move 3 -> 4
	ldrb	r0, [r4, #2]
	strb	r0, [r1, #3]


	mov		pc, lr

	.end
