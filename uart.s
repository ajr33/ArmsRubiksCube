	.data


menu_message: 	.string 0xC

				.string 0xA, 0xD, "Welcome to Arms Rubiks cube."
				.string 0xA, 0xD
				.string 0xA, 0xD, "CONTROLS: "
				.string 0xA, 0xD, "Use W, A, S, D to move up, left down and right respectively."
				.string 0xA, 0xD, "Use the keys Z, X, C, V to peek left, up, down, and right respectively for one second."
				.string 0xA, 0xD, "Use the SPACEBAR to change to the color your currently on."
				.string 0xA, 0xD
				.string 0xA, 0xD, "Press TAB to pause the game."
				.string 0xA, 0xD
				.string 0xA, 0xD
				.string 0xA, 0xD, "You cannot move onto a square that has your current color."
				.string 0xA, 0xD, "The tiva board will display your current color via the RGB LED."
				.string 0xA, 0xD
				.string 0xA, 0xD, "In this version of the game, there will be an extra red."
				.string 0xA, 0xD
				.string 0xA, 0xD, "Press any key to start.", 0xA, 0xD, 0


board_outline: 	.string 0xC, 27, "[?25l" , 27, "[37;40m"
				.string "----------------------", 0xA, 0xD
                .string "|      |      |      |", 0xA, 0xD
                .string "|      |      |      |", 0xA, 0xD
                .string "|      |      |      |", 0xA, 0xD
                .string "|------|------|------|", 0xA, 0xD
                .string "|      |      |      |", 0xA, 0xD
                .string "|      |      |      |", 0xA, 0xD
                .string "|      |      |      |", 0xA, 0xD
                .string "|------|------|------|", 0xA, 0xD
                .string "|      |      |      |", 0xA, 0xD
                .string "|      |      |      |", 0xA, 0xD
                .string "|      |      |      |", 0xA, 0xD
                .string "|------|------|------|", 0xA, 0xD
                .string 0xA, 0xD
time_moves:     .string 27, "[15;1HTime: 0      Moves: 0   ",0


;the number of moves made
game_moves:		.word	0
;string that holds the number of moves made
print_moves:	.word 	0, 0


win_message:	.string 0xC
				.string 0xA, 0xD, "Congratulations, you have solved the Arm Rubiks Cube."
				.string 0xA, 0xD
				.string 0xA, 0xD, "Press SPACE to play again. Q to quit." , 0xA, 0xD, 0x7, 0 ; 0x7 sounds the bell, indicating that you have won.

pause_menu:		.string 0xC
				.string 0xA, 0xD, "PAUSED"
				.string 0xA, 0xD, "Press 'TAB' to unpause, 'P' to restart or 'Q' to quit.", 0

rotationSelect:			.byte 0 ; 0	- none
								; 1 - counter-clockwise
								; 2 - clockwise

rotation_playerPos:		.byte 9
; Colors to draw
;						color string	cursor down cursor back
red: 		.string 27, "[41m      ", 27, "[1B", 27, "[6D"
			.string 		"      ", 27, "[1B", 27, "[6D"
			.string 		"      ", 27, "[40m", 0

white: 		.string 27, "[107m      ", 27, "[1B", 27, "[6D"
			.string 		"      ", 27, "[1B", 27, "[6D"
			.string 		"      ", 27, "[40m", 0

purple: 	.string 27, "[45m      ", 27, "[1B", 27, "[6D"
			.string 		"      ", 27, "[1B", 27, "[6D"
			.string 		"      ", 27, "[40m", 0

blue: 		.string 27, "[44m      ", 27, "[1B", 27, "[6D"
			.string 		"      ", 27, "[1B", 27, "[6D"
			.string 		"      ", 27, "[40m", 0

green: 		.string 27, "[102m      ", 27, "[1B", 27, "[6D"
			.string 		"      ", 27, "[1B", 27, "[6D"
			.string 		"      ", 27, "[40m", 0

yellow: 	.string 27, "[103m      ", 27, "[1B", 27, "[6D"
			.string 		"      ", 27, "[1B", 27, "[6D"
			.string 		"      ", 27, "[40m", 0



; Faces are designed as follows
;----------------------
;|      |      |      |
;|   1  |   2  |  3   |
;|      |      |      |
;|------|------|------|
;|      |      |      |
;|   8  |   9  |  4   |
;|      |      |      |
;|------|------|------|
;|      |      |      |
;|   7  |  6   |  5   |
;|      |      |      |
;|------|------|------|
;
; colors
;	2 - red,
;	4 - white
;	8 - purple
;	16 - blue
;	32 - green
;	64 - yellow

face_red: 		.equ 0x2 	; color 1
face_white: 	.equ 0x4	; color 2
face_purple: 	.equ 0x8	; color 3
face_blue: 		.equ 0x10	; color 4
face_green:		.equ 0x20	; color 5
face_yellow:	.equ 0x40	; color 6


; These match each face with the same color for testing endgame stuff.

reset_face1: .byte 0x2, 0x2, 0x2, 0x2, 0x2, 0x2, 0x2, 0x2, 0x2
reset_face2: .byte 0x4, 0x4, 0x4, 0x4, 0x4, 0x4, 0x4, 0x4, 0x4
reset_face3: .byte 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8
reset_face4: .byte 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10
reset_face5: .byte 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
reset_face6: .byte 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40

face1: .byte 0x2, 0x2, 0x2, 0x2, 0x2, 0x2, 0x2, 0x2, 0x2
face2: .byte 0x4, 0x4, 0x4, 0x4, 0x4, 0x4, 0x4, 0x4, 0x4
face3: .byte 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8
face4: .byte 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10
face5: .byte 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
face6: .byte 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40


;reset_face1: .byte 0x2, 0x40, 0x8, 0x2, 0x4, 0x40, 0x10, 0x20, 0x40
;reset_face2: .byte 0x10, 0x40, 0x8, 0x2, 0x4, 0x8, 0x2, 0x20, 0x10
;reset_face3: .byte 0x8, 0x4, 0x8, 0x20, 0x4, 0x4, 0x8, 0x20, 0x4
;reset_face4: .byte 0x20, 0x40, 0x10, 0x2, 0x4, 0x10, 0x10, 0x20, 0x40
;reset_face5: .byte 0x2, 0x8, 0x8, 0x2, 0x10, 0x40, 0x10, 0x20, 0x8
;reset_face6: .byte 0x2, 0x10, 0x20, 0x2, 0x4, 0x20, 0x40, 0x4, 0x40


;face1: .byte 0x2, 0x40, 0x8, 0x2, 0x4, 0x40, 0x10, 0x20, 0x40
;face2: .byte 0x10, 0x40, 0x8, 0x2, 0x4, 0x8, 0x2, 0x20, 0x10
;face3: .byte 0x8, 0x4, 0x8, 0x20, 0x4, 0x4, 0x8, 0x20, 0x4
;face4: .byte 0x20, 0x40, 0x10, 0x2, 0x4, 0x10, 0x10, 0x20, 0x40
;face5: .byte 0x2, 0x8, 0x8, 0x2, 0x10, 0x40, 0x10, 0x20, 0x8
;face6: .byte 0x2, 0x10, 0x20, 0x2, 0x4, 0x20, 0x40, 0x4, 0x40


rgbRed:			.equ	0x2
rgbWhite:		.equ	0xE
rgbPurple:		.equ	0x6
rgbBlue:		.equ	0x4
rgbGreen:		.equ	0x8
rgbYellow:		.equ	0xA

countRed:		.byte	0
countWhite:		.byte	0
countPurple:	.byte	0
countBlue:		.byte	0
countGreen:		.byte	0
countYellow:	.byte	0

currentFace:	.byte 1
					;	up, left, down, right, back
faceDirection:	.byte 	5,	4,	6,	2, 3

blankFace:		.byte	0, 0, 0, 0, 0, 0, 0, 0, 0

; UP_OFFSET is 0.
LEFT_OFFSET:	.equ	1
DOWN_OFFSET:	.equ	2
RIGHT_OFFSET:	.equ	3
BACK_OFFSET:	.equ	4

TAB:			.equ	9

; Player data
playerPos: 		.byte 9
playerColor:	.byte 1 ; 1-red, 2-white, 3-purple, 4-blue, 5-green, 6-yellow


; Colors for player
playerRed: 		.string 27 , "[41m    ",  	27, "[40m", 0
playerWhite: 	.string 27 , "[107m    ", 	27, "[40m", 0
playerPurple: 	.string 27 , "[45m    ",  	27, "[40m", 0
playerBlue: 	.string 27 , "[44m    ", 	27, "[40m", 0
playerGreen: 	.string 27 , "[102m    ",	27, "[40m", 0
playerYellow: 	.string 27 , "[103m    ", 	27, "[40m", 0



fill_rotation_face:		.byte 	0, 0, 0, 0, 0, 0, 0, 0, 0
animation_face:			.word	0

movesPlacement:		.equ	0x16

	.text

	.global uart_init
	.global uart_interrupt_init
	.global UART0_Handler	;yes diff
    .global output_string	;yes same
    .global int2string
    .global	illuminate_RGB_LED
    .global	draw_colors
    .global	draw_peek
    .global	quit_game
    .global reset_game_clock
    .global show_player_time
	.global draw_colors
	.global pick_second_rotation
	.global animate_rotation
	.global get_face
	.global	show_home_screen
	.global delay_us

	; rotation sequences
	.global	rotLeftSeq
	.global	rotUpSeq
	.global	rotRightSeq
	.global	rotDownSeq

	; lcd
	.global		lcd_show_home
	.global 	lcd_show_pause
	.global		lcd_show_win
	.global		lcd_data
	.global		lcd_cmd
	.global 	clear_lcd
	.global 	lcd_print_string
	.global		move_lcd_cursor
	.global		lcd_print_time_and_moves
	.global		lcd_clear_top



;menu
ptr_menu_message: 	.word 	menu_message

;win screen
ptr_win_message:	.word	win_message

;pause menu
ptr_pause_menu:		.word	pause_menu

ptr_time_moves:		.word	time_moves

ptr_countRed:		.word	countRed
ptr_countWhite:		.word	countWhite
ptr_countPurple:	.word	countPurple
ptr_countBlue:		.word	countBlue
ptr_countGreen:		.word	countGreen
ptr_countYellow:	.word	countYellow

ptr_rotationSelect:		.word	rotationSelect
ptr_rotation_playerPos:	.word	rotation_playerPos

; pointers to player data
ptr_playerPos: 		.word playerPos
ptr_playerColor:	.word playerColor


; pointers to colors
ptr_red:	.word red
ptr_white:	.word white
ptr_purple:	.word purple
ptr_blue:	.word blue
ptr_green:	.word green
ptr_yellow:	.word yellow

; player colors
ptr_playerRed:		.word playerRed
ptr_playerWhite:	.word playerWhite
ptr_playerPurple:	.word playerPurple
ptr_playerBlue:		.word playerBlue
ptr_playerGreen:	.word playerGreen
ptr_playerYellow:	.word playerYellow







;for reset
ptr_reset_face1:	.word reset_face1
ptr_reset_face2:	.word reset_face2
ptr_reset_face3:	.word reset_face3
ptr_reset_face4:	.word reset_face4
ptr_reset_face5:	.word reset_face5
ptr_reset_face6:	.word reset_face6


ptr_face1:	.word face1
ptr_face2:	.word face2
ptr_face3:	.word face3
ptr_face4:	.word face4
ptr_face5:	.word face5
ptr_face6:	.word face6





; grid locations
grid_one:       .string 27, "[2;2H",0
grid_two:       .string 27, "[2;9H",0
grid_three:     .string 27, "[2;16H",0
grid_four:      .string 27, "[6;16H",0
grid_five:      .string 27, "[10;16H",0
grid_six:       .string 27, "[10;9H",0
grid_seven:     .string 27, "[10;2H",0
grid_eight:     .string 27, "[6;2H",0
grid_nine:      .string 27, "[6;9H",0


middle_one:       .string 27, "[3;3H",0
middle_two:       .string 27, "[3;10H",0
middle_three:     .string 27, "[3;17H",0
middle_four:      .string 27, "[7;17H",0
middle_five:      .string 27, "[11;17H",0
middle_six:       .string 27, "[11;10H",0
middle_seven:     .string 27, "[11;3H",0
middle_eight:     .string 27, "[7;3H",0
middle_nine:      .string 27, "[7;10H",0


;oneT:			.string 27, "[2;3H",0
;oneB:			.string 27, "[4;3H",0
;twoT:			.string 27, "[2;10H",0
;twoB:			.string 27, "[4;10H",0
;threeT:			.string 27, "[2;17H",0
;threeB:			.string 27, "[4;17H",0
;fourT:			.string 27, "[6;17H",0
;fourB:			.string 27, "[8;17H",0
;fiveT:			.string 27, "[10;17H",0
;fiveB:			.string 27, "[12;17H",0
;sixT:			.string 27, "[10;10H",0
;sixB:			.string 27, "[12;10H",0
;sevenT:			.string 27, "[10;3H",0
;sevenB:			.string 27, "[12;3H",0
;eightT:			.string 27, "[6;3H",0
;eightB:			.string 27, "[8;3H",0
;nineT:			.string 27, "[6;10H",0
;nineB:			.string 27, "[8;10H",0


movesPosition:		.string 27, "[15;21H", 0

ptr_game_moves:		.word	game_moves
ptr_print_moves:	.word	print_moves


ptr_grid1:	.word grid_one
ptr_grid2:	.word grid_two
ptr_grid3:	.word grid_three
ptr_grid4:	.word grid_four
ptr_grid5:	.word grid_five
ptr_grid6:	.word grid_six
ptr_grid7:	.word grid_seven
ptr_grid8:	.word grid_eight
ptr_grid9:	.word grid_nine




ptr_middle1:	.word middle_one
ptr_middle2:	.word middle_two
ptr_middle3:	.word middle_three
ptr_middle4:	.word middle_four
ptr_middle5:	.word middle_five
ptr_middle6:	.word middle_six
ptr_middle7:	.word middle_seven
ptr_middle8:	.word middle_eight
ptr_middle9:	.word middle_nine

;ptr_nineT:		.word	nineT
;ptr_nineB:		.word	nineB


ptr_movesPosition:	.word movesPosition


ptr_board_outline:	.word	board_outline


ptr_rotationFace:	.word	fill_rotation_face
ptr_animationFace:	.word	animation_face

U0FR: .equ 0x18		;UART0 Flag Register








; UP_OFFSET is 0.
LEFT_OFFSET:	.equ	1
DOWN_OFFSET:	.equ	2
RIGHT_OFFSET:	.equ	3
BACK_OFFSET:	.equ	4




; 0xa1 - rotating left (new face is on the right) - state 1
; 0xa2 - rotating left - state 2
; 0xb1 - rotating up (new face is on the bottom) - state 1
; 0xb2 - rotating up - state 2
; 0xc1 - rotating right - state 1
; 0xc2 - rotating right - state 2
; 0xd1 - rotating down - state 1
; 0xd2 - rotating down - state 2
animate_rotation:
	push	{lr}

	; first we need to check which rotation and state we are on.
	ldrb	r0, [r5]

	; final animation, just load the full current face
	cmp		r0, #3
	itt		eq
	bleq	draw_colors
	beq		animate_rotation_end

	; location of new animation face
	ldr		r1, ptr_rotationFace


	cmp		r0, #0xa1
	beq		rotLeft1

	cmp		r0, #0xa2
	beq		rotLeft2

	cmp		r0, #0xb1
	beq		rotUp1

	cmp		r0, #0xb2
	beq		rotUp2

	cmp		r0, #0xc1
	beq		rotRight1

	cmp		r0, #0xc2
	beq		rotRight2

	cmp		r0, #0xd1
	beq		rotDown1

	cmp		r0, #0xd2
	beq		rotDown2

	b		animate_rotation_end

rotLeft1:
	; this subroutine will eventually load the right face in the end.
	; get the left face since we're rotating to the left
	; subroutine adjust_rotation updates all the faces
	; in the background so we have to backtrack to load
	; in the correct data.
	; The left face was the face that we were previously on.
	ldr		r3, ptr_faceDirection
	ldrb	r3, [r3, #LEFT_OFFSET]
	bl		get_face
	; r4 now contains the face we should load from

	; do rotating left sequence
	bl		rotLeftSeq

	; rotation for last row/column
	; 1, 8, 7 of new face
	; 3, 4, 5 of old face
	; (note: SUBTRACT BY 1 TO GET INDEX)

	; now we should the colors of the new face to the last row/column
	ldr		r0, ptr_currentFace
	ldrb	r3,	[r0]	; load current face number
	bl		get_face

	; move 1 -> 3
	ldrb	r0, [r4]
	strb	r0, [r1, #2]

	; move 8 -> 4
	ldrb	r0, [r4, #7]
	strb	r0, [r1, #3]

	; move 7 -> 5
	ldrb	r0, [r4, #6]
	strb	r0, [r1, #4]

	; draw this new board & save the address of this new board to memory
	mov		r4, r1
	ldr		r0, ptr_animationFace
	str		r4, [r0]
	bl		start_drawing

	; change to rotation state 2
	mov		r0, #0xa2
	strb	r0, [r5]

	b		no_reset_animation


rotLeft2:
	; this subroutine will eventually load the right face in the end.
	; The animation face was the face that we were previously on
	; from the previous animation
	ldr		r3, ptr_animationFace
	ldr		r4, [r3]
	; r4 now contains the face we should load from


	; do rotating left sequence
	bl		rotLeftSeq

	; now we should the colors of the new face to the last row/column
	ldr		r0, ptr_currentFace
	ldrb	r3,	[r0]	; load current face number
	bl		get_face

	; NOTE: This is the second iteration of the animation
	; rotation for last row/column
	; 2, 9, 6 of new face
	; 3, 4, 5 of old face
	; (note: SUBTRACT BY 1 TO GET INDEX)

	; move 2 -> 3
	ldrb	r0, [r4, #1]
	strb	r0, [r1, #2]

	; move 9 -> 4
	ldrb	r0, [r4, #8]
	strb	r0, [r1, #3]

	; move 6 -> 5
	ldrb	r0, [r4, #5]
	strb	r0, [r1, #4]

	; draw this new board
	mov		r4, r1

	; may not need
	;ldr		r0, ptr_animationFace
	;str		r4, [r0]

	bl		start_drawing

	; change to final rotation state
	mov		r0, #0x3
	strb	r0, [r5]

	b		no_reset_animation



rotUp1:
	; this subroutine will eventually load the bottom face in the end.
	; get the top face since we're rotating to the top
	; subroutine adjust_rotation updates all the faces
	; in the background so we have to backtrack to load
	; in the correct data.
	; The top face was the face that we were previously on.
	ldr		r3, ptr_faceDirection
	ldrb	r3, [r3]	; up offset is 0
	bl		get_face
	; r4 now contains the face we should load from

	; do the rotating up sequence
	bl		rotUpSeq

	; now we should the colors of the new face to the last row/column
	ldr		r0, ptr_currentFace
	ldrb	r3,	[r0]	; load current face number
	bl		get_face

	; rotation for last row/column
	; 1, 2, 3 of new face
	; 7, 6, 5 of old face
	; (note: SUBTRACT BY 1 TO GET INDEX)

	; move 1 -> 7
	ldrb	r0, [r4]
	strb	r0, [r1, #6]

	; move 2 -> 6
	ldrb	r0, [r4, #1]
	strb	r0, [r1, #5]

	; move 3 -> 5
	ldrb	r0, [r4, #2]
	strb	r0, [r1, #4]

	; draw this new board & save the address of this new board to memory
	mov		r4, r1
	ldr		r0, ptr_animationFace
	str		r4, [r0]
	bl		start_drawing

	; change to rotation state 2
	mov		r0, #0xb2
	strb	r0, [r5]

	b		no_reset_animation



rotUp2:
	; this subroutine will eventually load the bottom face in the end.
	; The animation face was the face that we were previously on
	; from the previous animation.
	ldr		r3, ptr_animationFace
	ldr		r4, [r3]
	; r4 now contains the face we should load from

	; do the rotating up sequence
	bl		rotUpSeq

	; now we should the colors of the new face to the last row/column
	ldr		r0, ptr_currentFace
	ldrb	r3,	[r0]	; load current face number
	bl		get_face

	; rotation for last row/column
	; 8, 9, 4 of new face
	; 7, 6, 5 of old face
	; (note: SUBTRACT BY 1 TO GET INDEX)

	; move 8 -> 7
	ldrb	r0, [r4, #7]
	strb	r0, [r1, #6]

	; move 9 -> 6
	ldrb	r0, [r4, #8]
	strb	r0, [r1, #5]

	; move 4 -> 5
	ldrb	r0, [r4, #3]
	strb	r0, [r1, #4]

	; draw this new board & save the address of this new board to memory
	mov		r4, r1
;	ldr		r0, ptr_animationFace
;	str		r4, [r0]
	bl		start_drawing

	; change to final rotation state
	mov		r0, #0x3
	strb	r0, [r5]

	b		no_reset_animation


rotRight1:
	; this subroutine will eventually load the left face in the end.
	; get the right face since we're rotating to the right
	; subroutine adjust_rotation updates all the faces
	; in the background so we have to backtrack to load
	; in the correct data.
	; The top face was the face that we were previously on.
	ldr		r3, ptr_faceDirection
	ldrb	r3, [r3, #RIGHT_OFFSET]
	bl		get_face
	; r4 now contains the face we should load from

	; do the rotating up sequence
	bl		rotRightSeq

	; now we should the colors of the new face to the last row/column
	ldr		r0, ptr_currentFace
	ldrb	r3,	[r0]	; load current face number
	bl		get_face

	; rotation for last row/column
	; 3, 4, 5 of new face
	; 1, 8, 7 of old face
	; (note: SUBTRACT BY 1 TO GET INDEX)

	; move 3 -> 1
	ldrb	r0, [r4, #2]
	strb	r0, [r1]

	; move 4 -> 8
	ldrb	r0, [r4, #3]
	strb	r0, [r1, #7]

	; move 5 -> 7
	ldrb	r0, [r4, #4]
	strb	r0, [r1, #6]

	; draw this new board & save the address of this new board to memory
	mov		r4, r1
	ldr		r0, ptr_animationFace
	str		r4, [r0]
	bl		start_drawing

	; change to rotation state 2
	mov		r0, #0xc2
	strb	r0, [r5]

	b		no_reset_animation

rotRight2:
	; this subroutine will eventually load the left face in the end.
	; The animation face was the face that we were previously on
	; from the previous animation
	ldr		r3, ptr_animationFace
	ldr		r4, [r3]
	; r4 now contains the face we should load from

	; do the rotating up sequence
	bl		rotRightSeq

	; now we should the colors of the new face to the last row/column
	ldr		r0, ptr_currentFace
	ldrb	r3,	[r0]	; load current face number
	bl		get_face

	; rotation for last row/column
	; 2, 9, 6 of new face
	; 1, 8, 7 of old face
	; (note: SUBTRACT BY 1 TO GET INDEX)

	; move 2 -> 1
	ldrb	r0, [r4, #1]
	strb	r0, [r1]

	; move 9 -> 8
	ldrb	r0, [r4, #8]
	strb	r0, [r1, #7]

	; move 6 -> 7
	ldrb	r0, [r4, #5]
	strb	r0, [r1, #6]

	; draw this new board & save the address of this new board to memory
	mov		r4, r1
;	ldr		r0, ptr_animationFace
;	str		r4, [r0]
	bl		start_drawing

	; change to final rotation state
	mov		r0, #3
	strb	r0, [r5]

	b		no_reset_animation

rotDown1:
	; this subroutine will eventually load the top face in the end.
	; get the bottom face since we're rotating to the bottom
	; subroutine adjust_rotation updates all the faces
	; in the background so we have to backtrack to load
	; in the correct data.
	; The top face was the face that we were previously on.
	ldr		r3, ptr_faceDirection
	ldrb	r3, [r3, #DOWN_OFFSET]	; up offset is 0
	bl		get_face
	; r4 now contains the face we should load from

	; do the rotating up sequence
	bl		rotDownSeq

	; now we should the colors of the new face to the last row/column
	ldr		r0, ptr_currentFace
	ldrb	r3,	[r0]	; load current face number
	bl		get_face

	; rotation for last row/column
	; 7, 6, 5 of new face
	; 1, 2, 3 of old face
	; (note: SUBTRACT BY 1 TO GET INDEX)

	; move 7 -> 1
	ldrb	r0, [r4, #6]
	strb	r0, [r1]

	; move 6 -> 2
	ldrb	r0, [r4, #5]
	strb	r0, [r1, #1]

	; move 5 -> 3
	ldrb	r0, [r4, #4]
	strb	r0, [r1, #2]

	; draw this new board & save the address of this new board to memory
	mov		r4, r1
	ldr		r0, ptr_animationFace
	str		r4, [r0]
	bl		start_drawing

	; change to rotation state 2
	mov		r0, #0xd2
	strb	r0, [r5]

	b		no_reset_animation



rotDown2:
	; this subroutine will eventually load the top face in the end.
	; The animation face was the face that we were previously on
	; from the previous animation
	ldr		r3, ptr_animationFace
	ldr		r4, [r3]
	; r4 now contains the face we should load from

	; do the rotating up sequence
	bl		rotDownSeq

	; now we should the colors of the new face to the last row/column
	ldr		r0, ptr_currentFace
	ldrb	r3,	[r0]	; load current face number
	bl		get_face

	; rotation for last row/column
	; 8, 9, 4 of new face
	; 1, 2, 3 of old face
	; (note: SUBTRACT BY 1 TO GET INDEX)

	; move 8 -> 1
	ldrb	r0, [r4, #7]
	strb	r0, [r1]

	; move 9 -> 2
	ldrb	r0, [r4, #8]
	strb	r0, [r1, #1]

	; move 4 -> 3
	ldrb	r0, [r4, #3]
	strb	r0, [r1, #2]

	; draw this new board & save the address of this new board to memory
	mov		r4, r1
;	ldr		r0, ptr_animationFace
;	str		r4, [r0]
	bl		start_drawing

	; change to final rotation state
	mov		r0, #3
	strb	r0, [r5]

	b		no_reset_animation


animate_rotation_end:
	; if we just did the final animation, reset rotation state
	; first we need to check which rotation and state we are on.
	ldrb	r0, [r5]
	cmp		r0, #3
	bne		no_reset_animation
	mov		r0, #0
	strb	r0, [r5]

no_reset_animation:
	pop		{lr}
	mov		pc, lr






; NOTE: FOR SPACE OF INSTRUCTIONS THIS POINTER NEEDS TO BE CLOSE TO
;		INSTRUCTIONS THAT USE IT. HENCE WHY IT IS DOWN SO FAR IN THE TEXT.
ptr_faceDirection:	.word faceDirection
; pointers to faces
ptr_currentFace:	.word currentFace
ptr_blankFace:		.word blankFace


check_if_valid_move:
	push 	{r0, r2, lr}
	; r1 should store the square the player wants to go to and the square that should be checked if it is valid
	sub 	r1, #1	;for indexing sub by 1

	; get the player's current color
	ldr 	r0, ptr_playerColor
	ldrb	r2, [r0]

	;ldr		r0, ptr_currentFace
	;ldrb	r3, [r0]
	;bl		get_face ; stores face in r4

; r4 should already have face to check against loaded

	ldrb	r3, [r4, r1]

	; shift left by player's color
	mov 	r0, #1
	lsl 	r0, r0, r2




	cmp		r0, r3
	bne		is_valid
	pop 	{r0, r2, lr}
	b		finish_player_move


is_valid:
	add		r1, #1
	pop 	{r0, r2, lr}
	mov		pc, lr


check_if_valid_rotation:
	; r1 should store the square the player wants to go to and the square that should be checked if it is valid
	sub 	r1, #1	;for indexing sub by 1

	; get the player's current color
	ldr 	r0, ptr_playerColor
	ldrb	r2, [r0]

	;ldr		r0, ptr_currentFace
	;ldrb	r3, [r0]
	;bl		get_face ; stores face in r4

; r4 should already have face to check against loaded

	ldrb	r3, [r4, r1]

	; shift left by player's color
	mov 	r0, #1
	lsl 	r0, r0, r2




	cmp		r0, r3
	bne		is_valid_rotation
	pop		{lr}
	b		actual_end


is_valid_rotation:
	add		r1, #1
	mov		pc, lr




draw_peek:
	push	{r4, lr}

	; face should be loaded into r3
	bl		get_face
	; face pointer is now in r4

	; goto location of grid 1
	ldr 	r0, ptr_grid1
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid2
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid3
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid4
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid5
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid6
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid7
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid8
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid9
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string



	pop		{r4, lr}
	mov 	pc, lr
draw_colors:
	push  	{lr}

	; skip getting the face if rotating the current face
	ldrb	r0, [r9]
	cmp		r0, #1
	bne		start_drawing

	; load face
	ldr		r2, ptr_currentFace
	ldrb	r3, [r2]

	bl 		get_face

	pop		{lr}


start_drawing:
	push	{lr}
	; goto location of grid 1
	ldr 	r0, ptr_grid1
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid2
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid3
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid4
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid5
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid6
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid7
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid8
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string

	ldr 	r0, ptr_grid9
	bl 		output_string
	ldrb 	r0, [r4], #1
	bl 		get_color
	bl 		output_string


	; if in the middle of an animation for rotations
	; do not draw the player
	ldrb	r0, [r5]
	cmp		r0, #0
	beq		normal_playerPos

	cmp		r0, #3
	beq		normal_playerPos

	b		draw_end

	;ldrb	r0, [r9]
	;cmp		r0, #8
	;beq		pre_rotation_return


	;cmp		r0, #9
	;beq		get_rotation_playerPos
	;b		normal_playerPos

;pre_rotation_return:
;	pop		{lr}
;	b		rotation_return

;get_rotation_playerPos:
	; draw player location
;	ldr		r0, ptr_rotation_playerPos;
;	ldrb	r1, [r0]
;	b		checkPlayerPos


normal_playerPos:
	ldr		r0,	ptr_playerPos
	ldrb	r1, [r0]

checkPlayerPos:
	cmp		r1, #1
	bne		checkPos2
	ldr 	r0, ptr_middle1
	b 		draw_player

checkPos2:
	cmp		r1, #2
	bne		checkPos3
	ldr 	r0, ptr_middle2
	b 		draw_player

checkPos3:
	cmp		r1, #3
	bne		checkPos4
	ldr 	r0, ptr_middle3
	b 		draw_player

checkPos4:
	cmp		r1, #4
	bne		checkPos5
	ldr 	r0, ptr_middle4
	b 		draw_player

checkPos5:
	cmp		r1, #5
	bne		checkPos6
	ldr 	r0, ptr_middle5
	b 		draw_player

checkPos6:
	cmp		r1, #6
	bne		checkPos7
	ldr 	r0, ptr_middle6
	b 		draw_player

checkPos7:
	cmp		r1, #7
	bne		checkPos8
	ldr 	r0, ptr_middle7
	b 		draw_player

checkPos8:
	cmp		r1, #8
	bne		checkPos9
	ldr 	r0, ptr_middle8
	b 		draw_player

checkPos9:
	cmp		r1, #9
	bne		draw_end
	ldr 	r0, ptr_middle9
	b 		draw_player

draw_player:
	bl 		output_string

	;get player color
	ldr 	r0, ptr_playerColor
	ldrb	r1,	[r0]

	cmp 	r1, #1
	beq		set_player_red

	cmp 	r1, #2
	beq		set_player_white

	cmp 	r1, #3
	beq		set_player_purple

	cmp 	r1, #4
	beq		set_player_blue

	cmp 	r1, #5
	beq		set_player_green

	cmp 	r1, #6
	beq		set_player_yellow

	; if invalid color, default to red
	b		set_player_red

set_player_red:
	mov		r0, #rgbRed
	bl		illuminate_RGB_LED
	ldr 	r0, ptr_playerRed
	bl		output_string
	b		draw_end

set_player_white:
	mov		r0, #rgbWhite
	bl		illuminate_RGB_LED
	ldr 	r0, ptr_playerWhite
	bl		output_string
	b		draw_end

set_player_purple:
	mov		r0, #rgbPurple
	bl		illuminate_RGB_LED
	ldr 	r0, ptr_playerPurple
	bl		output_string
	b		draw_end

set_player_blue:
	mov		r0, #rgbBlue
	bl		illuminate_RGB_LED
	ldr 	r0, ptr_playerBlue
	bl		output_string
	b		draw_end

set_player_green:
	mov		r0, #rgbGreen
	bl		illuminate_RGB_LED
	ldr 	r0, ptr_playerGreen
	bl		output_string
	b		draw_end

set_player_yellow:
	mov		r0, #rgbYellow
	bl		illuminate_RGB_LED
	ldr 	r0, ptr_playerYellow
	bl		output_string

draw_end:
	;bl		countColors
	pop 	{lr}  						; Restore lr from stack
rotation_return:
	mov 	pc, lr




; will save found color into r0
get_color:

	cmp r0, #face_red
	bne	get_color_white
	ldr r0, ptr_red
	b	get_color_end


get_color_white:
	cmp r0, #face_white
	bne	get_color_purple
	ldr r0, ptr_white
	b	get_color_end


get_color_purple:
	cmp r0, #face_purple
	bne	get_color_blue
	ldr r0, ptr_purple
	b	get_color_end

get_color_blue:
	cmp r0, #face_blue
	bne	get_color_green
	ldr r0, ptr_blue
	b	get_color_end


get_color_green:
	cmp r0, #face_green
	bne	get_color_yellow
	ldr r0, ptr_green
	b	get_color_end

get_color_yellow:
	cmp r0, #face_yellow
	bne	get_color_end
	ldr r0, ptr_yellow

get_color_end:
	mov pc, lr


; checks which face pointer to load based on value stored in r3
; loads face pointer into r4
get_face:
	cmp		r3, #1
	bne		get_face2
	ldr		r4, ptr_face1
	b		get_face_end

get_face2:
	cmp		r3, #2
	bne		get_face3
	ldr		r4, ptr_face2
	b		get_face_end

get_face3:
	cmp		r3, #3
	bne		get_face4
	ldr		r4, ptr_face3
	b		get_face_end

get_face4:
	cmp		r3, #4
	bne		get_face5
	ldr		r4, ptr_face4
	b		get_face_end

get_face5:
	cmp		r3, #5
	bne		get_face6
	ldr		r4, ptr_face5
	b		get_face_end

get_face6:
	cmp		r3, #6
	bne		draw_end
	ldr		r4, ptr_face6

get_face_end:
	mov pc, lr



uart_init:
	PUSH	{lr}   						; Store register lr on stack

	; Push used registers to stack
	push 	{r0, r4, r5}

	; The following sets flags manually with integer values
	; Initialize clock to UART0 to 1, address 0x400FE618
	mov 	r4, #0xe618
	movt	r4,	#0x400f
	ldrb	r5, [r4]
	orr		r5, #1
	strb	r5, [r4]

	; Initialize clock to PortA to 1, address 0x400FE608
	mov		r4, #0xe608
	movt	r4,	#0x400f
	ldrb	r5, [r4]
	orr		r5, #1
	strb 	r5, [r4]

	; The above clock set needs 3 cycles to complete
	; Set base address of UART 0, 0x4000.c000
	movw 	r4, #0xc000 				; Instruction 1
	movt	r4, #0x4000					; Instruction 2


	; Set UART0 Control to 0, address 0x4000C030
	movw	r5, #0						; Instruction 3, can now write to register
	str 	r5, [r4, #0x30]

	; Set UART0_IBRD_R for 115,200 baud, address 0x4000C024
	movw	r5, #8
	str 	r5, [r4, #0x24]

	; Set UART0_FBRD_R for 115,200 baud, address 0x4000C028
	movw	r5,	#44
	str 	r5, [r4, #0x28]

	; Use system clock, address	0x4000CFC8
	movw	r5,	#0
	str 	r5, [r4, #0xfc8]

	; Use 8-bit word length, 1 stop bit, no parity, address 0x4000C02C
	movw	r5,	#0x60
	str 	r5, [r4, #0x2c]

	; Enable UART0 Control, address 0x4000C030
	movw	r5,	#0x301
	str 	r5, [r4, #0x30]


	; The following uses bit masking 'or' to set the desired bits while retaining any initial
	; values

	; Mark PA0 and PA1 as Digital Ports, address 0x4000451C
	mov		r4, #0x451c
	movt	r4, #0x4000
	ldrb	r5, [r4]
	orr		r5, r5, #0x03
	strb	r5, [r4]

	; Change PA0,PA1 to Use an Alternate Function, address 0x40004420
	mov 	r4, #0x4420
	movt	r4, #0x4000
	ldrb	r5, [r4]
	orr		r5, r5, #0x03
	strb	r5, [r4]

	; Configure PA0 and PA1 for UART, address 0x4000452C
	mov 	r4, #0x452c
	movt	r4, #0x4000
	ldrb	r5, [r4]
	orr		r5, r5, #0x11
	strb	r5, [r4]

	bl		uart_interrupt_init
	; Pop used registers from stack


	pop 	{r0, r4, r5}
	pop 	{lr}  						; Restore lr from stack
	mov 	pc, lr

show_home_screen:
	push	{lr}
	ldr 	r0, ptr_menu_message
	bl 		output_string
	bl		lcd_show_home


wait_for_space:
	bl		simple_read_character
	cmp 	r0, #0
	beq		wait_for_space



	bl		restart_game

	pop 	{lr}  						; Restore lr from stack
	mov 	pc, lr


restart_game:
	push	{lr}

	bl		clear_lcd

	; print time and moves text on lcd
	;bl		lcd_print_time_and_moves

;	mov		r1, #0x11	; move cursor to row 2 column 1
;	bl		move_lcd_cursor
;	mov		r0, #'T'
;	bl		lcd_data
;	mov		r0, #':'
;	bl		lcd_data

	; print initial time on lcd
;	mov		r1, #0x13	; move cursor to row 2 column 3
;	bl		move_lcd_cursor
;	mov		r0, #'0'
;	bl		lcd_data

	; print moves on lcd
;	mov		r1, #0x19	; move cursor to row 2 column 9
;	bl		move_lcd_cursor
;	mov		r0, #'M'
;	bl		lcd_data
;	mov		r0, #':'
;	bl		lcd_data

	bl		lcd_print_time_and_moves
	; print initial moves on lcd
	mov		r1, #movesPlacement	; move cursor to row 2 column 8
	bl		move_lcd_cursor
	mov		r0, #'0'
	bl		lcd_data


	; set the game state
	mov		r0, #1
	strb	r0, [r9]

	; copy reset faces to faces
	bl		copy_reset_faces

	; set number of moves to 0
	mov		r0, #0
	ldr 	r1, ptr_game_moves
	str		r0, [r1]

	; set player position to the middle square
	mov		r0, #9
	ldr		r1,	ptr_playerPos
	strb	r0, [r1]

	; set player color back to red
	mov		r0, #1
	ldr		r1,	ptr_playerColor
	strb	r0, [r1]

	; Draw the board outline
	ldr 	r0, ptr_board_outline
	bl		output_string

	bl 		scramble_cube
	bl 		draw_colors

	pop		{lr}
	mov		pc, lr



copy_reset_faces:
	mov		r0, #0	;counter

	ldr 	r2, ptr_reset_face1
	ldr		r3, ptr_face1

reset_square_color:
	ldrb	r1, [r2], #1 	; color to reset to
	strb	r1, [r3], #1	; storing color
	add		r0, #1
	cmp		r0, #54
	blt		reset_square_color

	mov		pc, lr



scramble_cube:
	push	{r5}
	mov r0, #0
	ldr r1, ptr_face1

    ; Load address of timer 1 counter. Uses register GPTMTAV (0x050) which shows the free running value
    ; of Timer 1A. This will be used with the modulus formula as a random number generator. Timer is always
    ; running
    movw    r6, #0x1050
    MOVT    r6, #0x4003
    mov 	r4, #6

	; get mod of 6 from timer
    ldr 	r2, [r6] ; load timer1 current value
    add		r2, #3
    udiv 	r3, r2, r4 ; floor of timer value/6
    mul		r3, r3, r4	; closest value to timer value without going over
    sub		r5, r2, r3	; mod value




	; load current face
	ldr 	r1, ptr_currentFace
	ldrb	r2, [r1]	; r2 now has the current face.

	; check if current face = the face to set.
	cmp 	r2, r5
	beq		set_face_end	; face is already set done.

	cmp 	r5, #1
	beq		set_face1

	cmp 	r5, #2
	beq		set_face2

	cmp 	r5, #3
	beq		set_face3

	cmp 	r5, #4
	beq		set_face4

	cmp 	r5, #5
	beq		set_face5

    b		set_face6

set_face1:
	mov 	r0, #1
	strb	r0, [r1]
	b 		replace_old_face

set_face2:
	mov 	r0, #2
	strb	r0, [r1]
	b 		replace_old_face

set_face3:
	mov 	r0, #3
	strb	r0, [r1]
	b 		replace_old_face

set_face4:
	mov 	r0, #4
	strb	r0, [r1]
	b 		replace_old_face

set_face5:
	mov 	r0, #5
	strb	r0, [r1]
	b 		replace_old_face

set_face6:
	mov 	r0, #6
	strb	r0, [r1]

replace_old_face:
	ldr		r4, ptr_faceDirection
	mov 	r3, #0
checkForFace:
	ldrb 	r1, [r4, r3]
	add		r3, #1

	; if checked all end (should never branch)
	cmp 	r3, #5
	bgt		set_face_end

	cmp		r0, r1
	bne		checkForFace

	; replace face with the previous current face
	sub		r3, #1
	strb	r2, [r4, r3]


set_face_end:
	pop		{r5}
	mov		pc, lr





try_scramble_red:
 	cmp 	r5, #0
    bne		try_scramble_white

	ldr		r3, ptr_countRed
	ldrb	r2, [r3]
	cmp		r2, #9
	itte	ge
	movge	r5, #1
	bge		try_scramble_white
	blt		set_red


try_scramble_white:
    cmp 	r5, #1
   	bne		try_scramble_purple

	ldr		r3, ptr_countWhite
	ldrb	r2, [r3]
	cmp		r2, #9
	itte	ge
	movge	r5, #2
	bge		try_scramble_purple
	blt		set_white



try_scramble_purple:
    cmp 	r5, #2
   	bne		try_scramble_blue

	ldr		r3, ptr_countPurple
	ldrb	r2, [r3]
	cmp		r2, #9
	itte	ge
	movge	r5, #3
	bge		try_scramble_blue
	blt		set_purple

try_scramble_blue:
 	cmp 	r5, #3
   	bne		try_scramble_green

	ldr		r3, ptr_countBlue
	ldrb	r2, [r3]
	cmp		r2, #9
	itte	ge
	movge	r5, #4
	bge		try_scramble_green
	blt		set_blue

try_scramble_green:
	cmp 	r5, #4
   	bne		try_scramble_yellow

	ldr		r3, ptr_countGreen
	ldrb	r2, [r3]
	cmp		r2, #9
	itte	ge
	movge	r5, #5
	bge		try_scramble_yellow
	blt		set_green

try_scramble_yellow:
	cmp 	r5, #5
   	bne		stop_scrambling

	ldr		r3, ptr_countYellow
	ldrb	r2, [r3]
	cmp		r2, #9
	itte	ge
	movge	r5, #0
	bge		try_scramble_red
	blt		set_yellow

    b stop_scrambling


set_red:
	add 	r2, #1
	strb	r2, [r3]
	mov 	r2, #face_red
	b		set_scramble_color

set_white:
	add 	r2, #1
	strb	r2, [r3]
	mov 	r2, #face_white
	b		set_scramble_color

set_purple:
	add 	r2, #1
	strb	r2, [r3]
	mov 	r2, #face_purple
	b		set_scramble_color

set_blue:
	add 	r2, #1
	strb	r2, [r3]
	mov 	r2, #face_blue
	b		set_scramble_color

set_green:
	add 	r2, #1
	strb	r2, [r3]
	mov 	r2, #face_green
	b		set_scramble_color

set_yellow:
	add 	r2, #1
	strb	r2, [r3]
	mov 	r2, #face_yellow


set_scramble_color:
	nop
	nop
	strb 	r2, [r1], #1
	add 	r0, #1
	nop
	nop

	cmp 	r0, #54
	;blt 	keep_scrambling

stop_scrambling:
	mov pc, lr






uart_interrupt_init:
	push 	{lr}
	; Push registers used in function
	push 	{r4, r5}

	;ldr 	r1, ptr_to_shared_ptr
	;str		r0, [r1]

	; Set the Receive Interrupt bit (RXIM - bit 5) in UART Interrupt mask register. Other
	; bits in register may have already been set, so we load value and use or to set mask bit.
	; 1 unmasks bit to allow bit to be used as an interrupt.

	; Load UART0 base address
	movw 	r4, #0xC000
	movt 	r4, #0x4000

	; Offset - #0x38  Mask - 0x10
	ldrb 	r5, [r4, #0x38]
	orr 	r5, r5, #0x10
	strb	r5, [r4, #0x38]

	; Configure processor to allow UART0 to interrupt operation. Bit 5 needs to be set in
	; enable register at base register - #0xE000.E000 offset - #0x100, bit 6 - #0x20
	movw 	r4, #0xE100
	movt	r4, #0xE000

	; Load current values so we don't overwrite anything previously set and orr with 0x40,
	; then store again.
	ldr 	r5, [r4]
	orr		r5, r5, #0x20
	str		r5, [r4]

	; Pop used registers
	pop 	{r4, r5}

	pop		{lr}
	mov 	pc, lr







UART0_Handler:
	;bx	lr
	push 	{lr}
	; Push registers 4 - 11 to preserve values
	push 	{r4-r11}

	; Load address of UART interrupt clear register (UARTICR): #0x4000.C044
	; Load value from register and clear bit 5, RXIC, using exclusive or
	movw 	r0, #0xc044
	movt	r0, #0x4000
	ldrb	r1, [r0]
	eor 	r1, r1, #0x10
	strb	r1, [r0]

	; Call simple_read_character. Need to load address where we'll be storing value read in
	; saves read character into r0
	bl 		simple_read_character

	; r9 has pointer to game state from cube.s
	ldrb	r1, [r9]

	cmp		r1, #6
	beq		check_pause_actions

	; set to started if game not started.
	cmp 	r1, #0
	itt		eq
	moveq	r1, #1
	beq		store_game_state

	cmp		r1, #4
	beq		check_key

	; if peeking, don't do anything so player cannot move.
	cmp		r1, #2
	beq		actual_end
	cmp		r1, #3
	beq		actual_end

check_key:

	;pause the game
	cmp		r0, #TAB
	beq		pause_game

	cmp 	r0, #' '
	beq		pickColor

;	cmp		r0, #'m'
;	beq		clockwise_rotation
;	cmp		r0, #'M'
;	beq		clockwise_rotation
;
;	cmp		r0, #'n'
;	beq		counterclockwise_rotation
;	cmp		r0, #'N'
;	beq		counterclockwise_rotation

	cmp		r0, #'q'
	beq		quit_rubiks
	cmp		r0, #'Q'
	beq		quit_rubiks


	cmp		r0, #'w'
	beq		moveUp
	cmp		r0, #'W'
	beq		moveUp

	cmp		r0, #'a'
	beq		moveLeft
	cmp		r0, #'A'
	beq		moveLeft

	cmp		r0, #'s'
	beq		moveDown
	cmp		r0, #'S'
	beq		moveDown

	cmp		r0, #'d'
	beq		moveRight
	cmp		r0, #'D'
	beq		moveRight

	ldr		r2, ptr_faceDirection
	; Peeks
	cmp		r0, #'z'
	beq		peekLeft
	cmp		r0, #'Z'
	beq		peekLeft


	cmp		r0, #'x'
	beq		peekUp
	cmp		r0, #'X'
	beq		peekUp


	cmp		r0, #'c'
	beq		peekDown
	cmp		r0, #'C'
	beq		peekDown


	cmp		r0, #'v'
	beq		peekRight
	cmp		r0, #'V'
	beq		peekRight



	b		actual_end	;if anything else end...


	; r7 is address for peekData in cube.s

peekLeft:
	ldrb	r0, [r2, #1] ; r2 should have pointer to face directions
	strb	r0, [r7]
	;bl 		draw_peek
	b		actual_end


peekUp:
	ldrb	r0, [r2] ; r2 should have pointer to face directions
	strb	r0, [r7]
	;bl 		draw_peek
	b		actual_end


peekDown:
	ldrb	r0, [r2, #2] ; r2 should have pointer to face directions
	strb	r0, [r7]
	;bl 		draw_peek
	b		actual_end

peekRight:
	ldrb	r0, [r2, #3] ; r2 should have pointer to face directions
	strb	r0, [r7]
	;bl 		draw_peek
	b		actual_end




store_game_state:
	strb 	r1, [r9]
	b		actual_end

moveUp:
	mov 	r0, #1
	b 		update_position

moveLeft:
	mov 	r0, #2
	b 		update_position

moveDown:
	mov 	r0, #4
	b 		update_position

moveRight:
	mov 	r0, #8
	b 		update_position





pickColor:
	; check if the player won the game and wants to replay.
	cmp		r1, #4
	bne		not_replay
	bl		restart_game
	b		actual_end

not_replay:
	ldr		r0, ptr_playerPos
	ldrb	r1,	[r0]
	sub		r1, #1

	ldr		r0, ptr_currentFace
	ldrb	r3, [r0]
	bl		get_face	;resulting face in r4

	ldrb	r2, [r4, r1] ; get square color of current face

	mov		r0, #0
swap_color_check:
	add		r0, #1
	lsr		r2, r2, #1
	cmp		r2, #1
	bgt		swap_color_check

	; store the player's new color
	ldr 	r2, ptr_playerColor
	ldrb	r3,	[r2]
	strb	r0, [r2]



	mov		r0, #1
	lsl		r0, r0, r3

	strb	r0,	[r4, r1] ; store player color on sqaure

	mov 	r10, #0x5A	; load arbitrary value to check if player has won the game



finish_player_move:
	; check if rotating to a new cube.
	ldrb	r0, [r5]
	cmp		r0, #0
	it		eq
	bleq 	draw_colors 	; only draw if on the same face and not rotating to a new cube.


	; update move count
	ldr		r0, ptr_movesPosition
	bl		output_string

	ldr		r1, ptr_game_moves
	ldr		r0, [r1]
	add		r0, #1
	str		r0, [r1]
	ldr		r1, ptr_print_moves
	bl		int2string
	mov		r0, r1
	push	{r0}
	bl		output_string
	pop		{r0}

	mov		r1, #movesPlacement	; row 2 column 6 start printing
	bl		lcd_print_string

	; only check for wins on color switch
	cmp		r10, #0x5A	; 0x5A is set if the player has changed their color
	it		eq
	bleq	check_win
	b		actual_end


check_pause_actions:
	cmp		r0, #TAB
	beq		pause_game

	cmp		r0, #'p'
	beq		restart_from_pause
	cmp		r0, #'P'
	beq		restart_from_pause

	cmp		r0, #'q'
	beq		quit_from_pause
	cmp		r0, #'Q'
	beq		quit_from_pause

	b		actual_end


restart_from_pause:
	bl		reset_game_clock
	bl		restart_game
	b		actual_end

quit_from_pause:
	; set 'quit' state
	mov		r0, #5
	strb	r0, [r9]
	b		actual_end

pause_game:
	; check if game is already paused or not
	cmp		r1, #6 ; if paused, unpause
	beq		unpause_game

	; pause the game
	mov		r0, #6
	strb	r0, [r9]

	; show pause menu
	ldr		r0, ptr_pause_menu
	bl		output_string

	bl		lcd_show_pause

	b		actual_end

unpause_game:
	; restore normal 'started' state
	mov		r0, #1
	strb	r0, [r9]

	; Redraw the board outline
	ldr 	r0, ptr_board_outline
	bl		output_string
	bl 		draw_colors

	bl		lcd_print_time_and_moves


	b		actual_end

quit_rubiks:
	cmp 	r1, #4
	bne		actual_end
	mov		r0, #5
	strb	r0, [r9]

actual_end:

	; Restore registers
	pop 	{r4-r11}
	pop 	{lr}

	BX 		lr       					; Return













check_win:
	push 	{r0, r1, lr}
	mov		r0, #0 ;counter for number of sides
	ldr 	r6, ptr_face1

load_first_color:
	add		r0, #1
	cmp		r0, #6
	bgt		has_won
	; load the first color
	ldrb	r4, [r6], #1
	mov		r1, #1	;set counter for number of squares
	b		check_matches

has_won:
	; win logic here
	mov		r0, #4
	strb	r0, [r9] ; store win state

	; show win message
	ldr		r0, ptr_win_message
	bl		output_string

	; show move count
	ldr		r0, ptr_time_moves
	bl		output_string

	; go to move location on screen
	ldr		r0, ptr_movesPosition
	bl		output_string

	; output the number of moves made.
	ldr		r0, ptr_print_moves
	bl		output_string

	; show the player time
	bl		show_player_time

	; output on lcd win message
	bl		lcd_show_win

	b 		end_win_check

check_matches:
	; if checked each of the sqaures of this face,
	; load the next face
	cmp 	r1, #9
	beq		load_first_color

	add		r1, #1	; increment counter

	ldrb	r5, [r6], #1
	cmp 	r4, r5
	beq		check_matches


end_win_check:
	pop		{r0, r1, lr}
	mov		pc, lr

; Update the position in memory of the player
update_position:
	ldr 	r2, ptr_playerPos
	ldrb	r1, [r2]

	cmp		r1, #1
	beq		update_from_1

	cmp		r1, #2
	beq		update_from_2

	cmp		r1, #3
	beq		update_from_3

	cmp		r1, #4
	beq		update_from_4

	cmp		r1, #5
	beq		update_from_5

	cmp		r1, #6
	beq		update_from_6

	cmp		r1, #7
	beq		update_from_7

	cmp		r1, #8
	beq		update_from_8

	cmp		r1, #9
	beq		update_from_9

	b		actual_end




; r0 = 1 for up
; r0 = 2 for left
; r0 = 4 for down
; r0 = 8 for right

update_from_1:
	; going up
	cmp 	r0, #1
	bne		left_1

	ldr		r1,	ptr_faceDirection
	ldrb	r3, [r1]	; up offset
	bl		get_face	; stored in r4

	mov		r1,	#7
	bl		check_if_valid_move
	bl		adjust_rotation

	; update the rotation data
	mov		r0, #0xd1
	strb	r0, [r5]

	strb	r1, [r2]
	b		finish_player_move

left_1:
	;going left
	cmp 	r0, #2
	bne		down_1

	ldr		r1,	ptr_faceDirection
	ldrb	r3, [r1, #LEFT_OFFSET]
	bl		get_face	; stored in r4

	mov		r1,	#3
	bl		check_if_valid_move
	bl		adjust_rotation

	; update the rotation data
	mov		r0, #0xc1
	strb	r0, [r5]

	strb	r1, [r2]
	b		finish_player_move

down_1:
	;going down
	cmp 	r0, #4
	bne		right_1

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#8
	bl		check_if_valid_move
	strb	r1, [r2]
	b 		finish_player_move

right_1:
	;going right
	cmp 	r0, #8
	bne		actual_end

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#2
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move



update_from_2:
	; going up
	cmp 	r0, #1
	bne		left_2


	ldr		r1,	ptr_faceDirection
	ldrb	r3, [r1]	; up offset
	bl		get_face	; stored in r4

	mov		r1,	#6
	bl		check_if_valid_move
	bl		adjust_rotation

	; update the rotation data
	mov		r0, #0xd1
	strb	r0, [r5]

	strb	r1, [r2]
	b		finish_player_move

left_2:
	;going left
	cmp 	r0, #2
	bne		down_2

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#1
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move

down_2:
	;going down
	cmp 	r0, #4
	bne		right_2

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#9
	bl		check_if_valid_move
	strb	r1, [r2]
	b 		finish_player_move

right_2:
	;going right
	cmp 	r0, #8
	bne		actual_end

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#3
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move




update_from_3:
	; going up
	cmp 	r0, #1
	bne		left_3

	ldr		r1,	ptr_faceDirection
	ldrb	r3, [r1]	; up offset
	bl		get_face	; stored in r4

	mov		r1,	#5
	bl		check_if_valid_move
	bl		adjust_rotation

	; update the rotation data
	mov		r0, #0xd1
	strb	r0, [r5]

	strb	r1, [r2]
	b		finish_player_move

left_3:
	;going left
	cmp 	r0, #2
	bne		down_3

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#2
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move

down_3:
	;going down
	cmp 	r0, #4
	bne		right_3

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#4
	bl		check_if_valid_move
	strb	r1, [r2]
	b 		finish_player_move

right_3:
	;going right
	cmp 	r0, #8
	bne		actual_end

	ldr		r1,	ptr_faceDirection
	ldrb	r3, [r1, #RIGHT_OFFSET]
	bl		get_face	; stored in r4

	mov		r1,	#1
	bl		check_if_valid_move
	bl		adjust_rotation

	; update the rotation data
	mov		r0, #0xa1
	strb	r0, [r5]


	strb	r1, [r2]
	b		finish_player_move




update_from_4:
	; going up
	cmp 	r0, #1
	bne		left_4

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#3
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move

left_4:
	;going left
	cmp 	r0, #2
	bne		down_4

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#9
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move

down_4:
	;going down
	cmp 	r0, #4
	bne		right_4

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#5
	bl		check_if_valid_move
	strb	r1, [r2]
	b 		finish_player_move

right_4:
	;going right
	cmp 	r0, #8
	bne		actual_end

	ldr		r1,	ptr_faceDirection
	ldrb	r3, [r1, #RIGHT_OFFSET]
	bl		get_face	; stored in r4

	mov		r1,	#8
	bl		check_if_valid_move
	bl		adjust_rotation

	; update the rotation data
	mov		r0, #0xa1
	strb	r0, [r5]

	strb	r1, [r2]
	b		finish_player_move




update_from_5:
	; going up
	cmp 	r0, #1
	bne		left_5

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#4
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move

left_5:
	;going left
	cmp 	r0, #2
	bne		down_5

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#6
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move

down_5:
	;going down
	cmp 	r0, #4
	bne		right_5

	ldr		r1,	ptr_faceDirection
	ldrb	r3, [r1, #DOWN_OFFSET]
	bl		get_face	; stored in r4

	mov		r1,	#3
	bl		check_if_valid_move
	bl		adjust_rotation

	; update the rotation data
	mov		r0, #0xb1
	strb	r0, [r5]

	strb	r1, [r2]
	b 		finish_player_move

right_5:
	;going right
	cmp 	r0, #8
	bne		actual_end

	ldr		r1,	ptr_faceDirection
	ldrb	r3, [r1, #RIGHT_OFFSET]
	bl		get_face	; stored in r4

	mov		r1,	#7
	bl		check_if_valid_move
	bl		adjust_rotation

	; update the rotation data
	mov		r0, #0xa1
	strb	r0, [r5]

	strb	r1, [r2]
	b		finish_player_move




update_from_6:
	; going up
	cmp 	r0, #1
	bne		left_6

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#9
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move

left_6:
	;going left
	cmp 	r0, #2
	bne		down_6

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#7
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move

down_6:
	;going down
	cmp 	r0, #4
	bne		right_6

	ldr		r1,	ptr_faceDirection
	ldrb	r3, [r1, #DOWN_OFFSET]
	bl		get_face	; stored in r4

	mov		r1,	#2
	bl		check_if_valid_move
	bl		adjust_rotation

	; update the rotation data
	mov		r0, #0xb1
	strb	r0, [r5]

	strb	r1, [r2]
	b 		finish_player_move

right_6:
	;going right
	cmp 	r0, #8
	bne		actual_end

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#5
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move




update_from_7:
	; going up
	cmp 	r0, #1
	bne		left_7

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#8
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move

left_7:
	;going left
	cmp 	r0, #2
	bne		down_7

	ldr		r1,	ptr_faceDirection
	ldrb	r3, [r1, #LEFT_OFFSET]
	bl		get_face	; stored in r4

	mov		r1,	#5
	bl		check_if_valid_move
	bl		adjust_rotation

	; update the rotation data
	mov		r0, #0xc1
	strb	r0, [r5]

	strb	r1, [r2]
	b		finish_player_move

down_7:
	;going down
	cmp 	r0, #4
	bne		right_7

	ldr		r1,	ptr_faceDirection
	ldrb	r3, [r1, #DOWN_OFFSET]
	bl		get_face	; stored in r4

	mov		r1,	#1
	bl		check_if_valid_move
	bl		adjust_rotation

	; update the rotation data
	mov		r0, #0xb1
	strb	r0, [r5]

	strb	r1, [r2]
	b 		finish_player_move

right_7:
	;going right
	cmp 	r0, #8
	bne		actual_end

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#6
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move




update_from_8:
	; going up
	cmp 	r0, #1
	bne		left_8

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#1
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move

left_8:
	;going left
	cmp 	r0, #2
	bne		down_8

	ldr		r1,	ptr_faceDirection
	ldrb	r3, [r1, #LEFT_OFFSET]
	bl		get_face	; stored in r4

	mov		r1,	#4
	bl		check_if_valid_move
	bl		adjust_rotation

	; update the rotation data
	mov		r0, #0xc1
	strb	r0, [r5]

	strb	r1, [r2]
	b		finish_player_move

down_8:
	;going down
	cmp 	r0, #4
	bne		right_8

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#7
	bl		check_if_valid_move
	strb	r1, [r2]
	b 		finish_player_move

right_8:
	;going right
	cmp 	r0, #8
	bne		actual_end

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#9
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move




update_from_9:
	; going up
	cmp 	r0, #1
	bne		left_9

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#2
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move

left_9:
	;going left
	cmp 	r0, #2
	bne		down_9

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#8
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move

down_9:
	;going down
	cmp 	r0, #4
	bne		right_9

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#6
	bl		check_if_valid_move
	strb	r1, [r2]
	b 		finish_player_move

right_9:
	;going right
	cmp 	r0, #8
	bne		actual_end

	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	mov		r1,	#4
	bl		check_if_valid_move
	strb	r1, [r2]
	b		finish_player_move


; r0 = 1 for up
; r0 = 2 for left
; r0 = 4 for down
; r0 = 8 for right
adjust_rotation:
	push	{r1-r2, lr}
	ldr		r1, ptr_faceDirection

	; check which rotation
	cmp 	r0, #1
	beq 	rotate_up

	cmp 	r0, #2
	beq 	rotate_left

	cmp 	r0, #4
	beq 	rotate_down

	cmp 	r0, #8
	beq 	rotate_right

	b		rotate_end

rotate_up:
	bl		rotate_parallel_sides


	ldrb	r2, [r1]	; load 'up' face number
	ldr		r0, ptr_currentFace
	ldrb	r3,	[r0]	; load current face number
	strb	r2, [r0]	; set new current face

	ldrb	r4, [r1, #DOWN_OFFSET] ; get current down face

	strb	r3, [r1, #DOWN_OFFSET]	; store current face number on the down direction


	ldrb	r2, [r1, #BACK_OFFSET]
	strb	r2,	[r1]	; set back face to new top face
	strb	r4, [r1, #BACK_OFFSET]	; store current top to back face

	b		rotate_end

rotate_left:
	bl		rotate_parallel_sides

	ldrb	r2, [r1, #LEFT_OFFSET]	; load 'left' face number
	ldr		r0, ptr_currentFace
	ldrb	r3,	[r0]	; load current face number
	strb	r2, [r0]	; set new current face

	ldrb	r4, [r1, #RIGHT_OFFSET] ; get current right face

	strb	r3, [r1, #RIGHT_OFFSET]	; store current face number on the right direction


	ldrb	r2, [r1, #BACK_OFFSET]
	strb	r2,	[r1, #LEFT_OFFSET]	; set back face to new left face
	strb	r4, [r1, #BACK_OFFSET]	; store current left to back face


	b		rotate_end

rotate_down:
	bl		rotate_parallel_sides

	ldrb	r2, [r1, #DOWN_OFFSET]	; load 'down' face number
	ldr		r0, ptr_currentFace
	ldrb	r3,	[r0]	; load current face number
	strb	r2, [r0]	; set new current face

	ldrb	r4, [r1] 	; get current up face

	strb	r3, [r1]	; store current face number on the up direction


	ldrb	r2, [r1, #BACK_OFFSET]
	strb	r2,	[r1, #DOWN_OFFSET]	; set back face to new down face
	strb	r4, [r1, #BACK_OFFSET]	; store current down to back face


	b		rotate_end

rotate_right:
	bl		rotate_parallel_sides


	ldrb	r2, [r1, #RIGHT_OFFSET]	; load 'right' face number
	ldr		r0, ptr_currentFace
	ldrb	r3,	[r0]	; load current face number
	strb	r2, [r0]	; set new current face

	ldrb	r4, [r1, #LEFT_OFFSET] ; get current left face

	strb	r3, [r1, #LEFT_OFFSET]	; store current face number on the left direction


	ldrb	r2, [r1, #BACK_OFFSET]
	strb	r2,	[r1, #RIGHT_OFFSET]	; set back face to new right face
	strb	r4, [r1, #BACK_OFFSET]	; store current right to back face


	b		rotate_end


rotate_end:
	pop {r1-r2, lr}
 	mov pc, lr




; r0 contains which way the player went
; r1 contains address of face directions
rotate_parallel_sides:
	push	{r0-r4, lr}

	ldr		r2, ptr_blankFace

	cmp		r0, #1
	beq		parallel_up

	cmp		r0, #2
	beq		parallel_left

	cmp		r0, #4
	beq		parallel_down

	cmp		r0, #8
	beq		parallel_right

	b 		parallel_end

parallel_up:
	ldrb	r3, [r1, #LEFT_OFFSET]
	; load value into r3, result comes in r4
	bl		get_face

	mov 	r1, #0
pU_left_rotate:
	; copy face to empty face in updated order
	ldrb	r3, [r4, r1]

	; update r0 accordingly
	bl 		decrement_parallel_sides

	strb	r3, [r2, r0]

	add		r1, #1
	cmp		r1, #8
	blt		pU_left_rotate	; may need to update

	bl		update_parallel_faces

	ldr		r1, ptr_faceDirection
	ldrb	r3, [r1, #RIGHT_OFFSET]
	bl		get_face

	mov		r1, #0
pU_right_rotate:
	; copy face to empty face in updated order
	ldrb	r3, [r4, r1]

	; update r0 accordingly
	bl 		increment_parallel_sides

	strb	r3, [r2, r0]

	add		r1, #1
	cmp		r1, #8
	blt		pU_right_rotate	; may need to update

	bl		update_parallel_faces

	b		parallel_end

parallel_left:
	ldrb	r3, [r1]
	; load value into r3, result comes in r4
	bl		get_face

	mov 	r1, #0
pL_up_rotate:
	; copy face to empty face in updated order
	ldrb	r3, [r4, r1]

	; update r0 accordingly
	bl 		decrement_parallel_sides

	strb	r3, [r2, r0]

	add		r1, #1
	cmp		r1, #8
	blt		pL_up_rotate	; may need to update

	bl		update_parallel_faces

	ldr		r1, ptr_faceDirection
	ldrb	r3, [r1, #DOWN_OFFSET]
	bl		get_face

	mov		r1, #0
pL_down_rotate:
	; copy face to empty face in updated order
	ldrb	r3, [r4, r1]

	; update r0 accordingly
	bl 		increment_parallel_sides

	strb	r3, [r2, r0]

	add		r1, #1
	cmp		r1, #8
	blt		pL_down_rotate	; may need to update

	bl		update_parallel_faces

	b		parallel_end



parallel_down:
	ldrb	r3, [r1, #LEFT_OFFSET]
	; load value into r3, result comes in r4
	bl		get_face

	mov 	r1, #0
pD_left_rotate:
	; copy face to empty face in updated order
	ldrb	r3, [r4, r1]

	; update r0 accordingly
	bl 		increment_parallel_sides

	strb	r3, [r2, r0]

	add		r1, #1
	cmp		r1, #8
	blt		pD_left_rotate	; may need to update

	bl		update_parallel_faces

	ldr		r1, ptr_faceDirection
	ldrb	r3, [r1, #RIGHT_OFFSET]
	bl		get_face

	mov		r1, #0
pD_right_rotate:
	; copy face to empty face in updated order
	ldrb	r3, [r4, r1]

	; update r0 accordingly
	bl 		decrement_parallel_sides

	strb	r3, [r2, r0]

	add		r1, #1
	cmp		r1, #8
	blt		pD_right_rotate	; may need to update

	bl		update_parallel_faces

	b		parallel_end

parallel_right:
	ldrb	r3, [r1]
	; load value into r3, result comes in r4
	bl		get_face

	mov 	r1, #0
pR_up_rotate:
	; copy face to empty face in updated order
	ldrb	r3, [r4, r1]

	; update r0 accordingly
	bl 		increment_parallel_sides

	strb	r3, [r2, r0]

	add		r1, #1
	cmp		r1, #8
	blt		pR_up_rotate	; may need to update

	bl		update_parallel_faces

	ldr		r1, ptr_faceDirection
	ldrb	r3, [r1, #DOWN_OFFSET]
	bl		get_face

	mov		r1, #0
pR_down_rotate:
	; copy face to empty face in updated order
	ldrb	r3, [r4, r1]

	; update r0 accordingly
	bl 		decrement_parallel_sides

	strb	r3, [r2, r0]

	add		r1, #1
	cmp		r1, #8
	blt		pR_down_rotate	; may need to update

	bl		update_parallel_faces


parallel_end:

	pop 	{r0-r4, lr}
	mov 	pc, lr



increment_parallel_sides:
	push	{lr}

	cmp		r1,	#6
	beq		inc_to_0

	cmp		r1,	#7
	beq		inc_to_1

	add		r0, r1, #2
	b 		increment_end

inc_to_0:
	mov 	r0, #0
	b 		increment_end

inc_to_1:
	mov		r0, #1

	b 		increment_end

increment_end:
	pop 	{lr}
	mov		pc, lr


; zero-index based
decrement_parallel_sides:
	push	{lr}

	cmp		r1,	#0
	beq		dec_to_6

	cmp		r1,	#1
	beq		dec_to_7

	cmp 	r1, #2
	beq		dec_to_0

	sub		r0, r1, #2
	b 		decrement_end

dec_to_6:
	mov 	r0, #6
	b 		decrement_end

dec_to_7:
	mov		r0, #7
	b 		decrement_end

dec_to_0:
	mov		r0, #0

decrement_end:
	pop 	{lr}
	mov		pc, lr


; 	r2 contains empty face
;	r4 contains actual face
update_parallel_faces:
	push 	{r0-r2, r3}

	mov		r0, #0
copy_face:

	ldrb 	r1, [r2], #1	; load the 'empty' face (contains updated values)
	strb	r1,	[r4, r0]	; copy to actual face

	add		r0, #1
	cmp		r0, #8
	blt		copy_face

update_parallel_faces_done:
	pop		{r0-r2, r3}
	mov		pc, lr






simple_read_character:
	; Load address of UART0 data segment, 0x4000.c000
	movw 	r1, #0xc000
	movt 	r1, #0x4000

	ldrb	r0, [r1]

	MOV 	PC,LR      	; Return

;**************************************************************************************************
; Function name: output_character
; Function behavior: Transmits a character along UART0 for display in console
;
; Function inputs:
; r0 - holds the character to be transmitted
;
; Function returns:
; nothing
;
; Registers used
; r4 : Holds address of data for UART - 0x4000c000
; r5 : Holds address of UART Flags - 0x4000c018
; r6 : Reads in flags, uses AND comparison to check transmission flag (TxFF - bit 5 (16))
;
;
; REMINDER: Push used registers r4-r11 to stack if used *PUSH/POP {r4, r5} or PUSH/POP {r4-r11})
; REMINDER: If calling another function from inside, PUSH/POP lr. To return from function MOV pc, lr
;**************************************************************************************************
output_character:
	PUSH {lr}   ; Store register lr on stack
	; Your code to output a character to be displayed in PuTTy
	; is placed here.  The character to be displayed is passed
	; into the routine in r0.

	;**********PUSH YOUR REGISTERS*******************
	push {r4-r6}

	; Store address of data in r4
	mov		r4, #0xc000
	movt	r4, #0x4000
	; Store address of flags in r5
	add		r5,	r4, #U0FR 	;adds uart 0 flag register

	; Load flag register for comparison. Bit flag is 16 decimal for TxFF (Bit 5). Loop continues until
	; flag for transmit is 0.
WAITONTRANSMIT:
		ldrb	r6, [r5]				; Load Flag register, only need first 8bits
		and 	r6, r6, #32				; Flag mask, checking bit 6, TxFF, if 1, repeat loop
		cmp		r6, #0
		bne		WAITONTRANSMIT			; If flag is not zero, continue waiting

	; Store character to be transmitted from r0 into UART data byte
	strb	r0, [r4]

	;**********POP YOUR REGISTERS********************
	pop {r4-r6}

	POP {lr}
	mov pc, lr

;***************************************************************************************************
; Function name: output_string
; Function behavior: Transmits string via UART0 to be written to screen. On new line will reset
; to first column of new write row
;
; Function inputs:
; r0 : contains the address of the first byte of the string to be written
;
; Function returns: None
;
; Registers used:
; r4 : Holds the offset address of the string
; r5 : Holds the write loop counter, used as offset when loading byte to be written
;
; Subroutines called:
; output_character | escape_sequences
;
; REMINDER: 13 is the number for 'enter' and the number for carriage return
; REMINDER: Push used registers r4-r11 to stack if used *PUSH/POP {r4, r5} or PUSH/POP {r4-r11})
; REMINDER: If calling another function from inside, PUSH/POP {lr}. To return from function MOV pc, lr
;***************************************************************************************************
output_string:
	PUSH	{r4-r5, lr}   						; Store register lr on stack

	mov		r4, r0						; Moving address of string into register
	movw	r5, #0						; Setting loop counter to 0

	movw	r0, #0						; Zero out the r0 register for use in output character
										; subroutine

	; Following loops through the string until NULL character is detected. For each character
	; calls the output_character function to display character on screen. If '\n'(10 dec) is detected,
	; transmits carriage return character (13 decimal) to place pointer at proper spot on screen.
output_string_main_loop:
	ldrb	r0, [r4, r5]				; Get character at string address + offset
	cmp		r0, #0						; Check if character is null character
	beq		output_string_main_loop_end ; If null character, end loop
	; Checks if character is '\', if so, pulls next digit from string and calls escape sequence check
	cmp 	r0, #0x5c					; Check against ascii code for '\'
	bne		end_escape_sequence_check
	add		r5, #1						; Increments counter to get next character
	ldrb	r0, [r4, r5]				; Get character at string address + offset
	; Check for null character escape sequence '\0'
	cmp		r0, #0						; Check if character is null character
	beq		output_string_main_loop_end ; If null character, end loop
	bl 		escape_sequences			; Call subroutine to get ASCII code for sequence

end_escape_sequence_check:
	bl		output_character			; Print character
	cmp		r0, #10						; Check if new line character
	bne 	output_string_inc_and_loop	; If not \n,  increment in loop
	movw	r0, #13						; Otherwise, load character return
	bl		output_character			; Print carriage return
output_string_inc_and_loop:
	add		r5, #1						; Increment offset by 1 byte
	b 		output_string_main_loop
output_string_main_loop_end:

	; Restoring used registers via pop

	POP 	{r4-r5, lr}  						; Restore lr from stack
	mov		pc, lr

;***************************************************************************************************
; Function name: escape_sequences
; Function behavior: Switch statement to determine the ascii value of the escape sequence used.
; Isolated into own subfuntion for readibility and to prevent confusion in main string output routine.
; Escapes sequences: \a, \b, \f, \n, \r, \t, \v, \\, \', \", \?
; SPECIAL NOTE: This is unneccesary if .cstring direct is used {?}
;
; Function inputs:
; r0 : second escape sequence character
; Function returns:
; r0 : ascii character to be printed next
; Registers used:
;
;
; Subroutines called:
; output_character
;
; REMINDER: Push used registers r4-r11 to stack if used *PUSH/POP {r4, r5} or PUSH/POP {r4-r11})
; REMINDER: If calling another function from inside, PUSH/POP {lr}. To return from function MOV pc, lr
;***************************************************************************************************
escape_sequences:
	PUSH	{lr}   						; Store register lr on stack

	; Switch to determine escape sequence used. It will load r0 with ascii value to be printed, except
	; in default case. Default is indicated by escape sequence not listed above. In default it will
	; print '\' and return the character passed in by the subroutine call.
	; Case '\a' 97 -> 7
	cmp		r0, #97
	bne		switch_case_b
	movw	r0, #7
	b	end_and_return_escape_sequences ; end switch
switch_case_b:							; Case '\b' 98-> 8
	cmp 	r0, #98
	bne		switch_case_f
	movw	r0, #8
	b	end_and_return_escape_sequences ; end switch
switch_case_f:							; Case '\f' 102-> 12
	cmp		r0, #102
	bne 	switch_case_n
	movw	r0, #12
	b	end_and_return_escape_sequences ; end switch
switch_case_n:							; Case '\n' 110-> 10
	cmp		r0, #110
	bne 	switch_case_r
	movw	r0, #10
	b	end_and_return_escape_sequences ; end switch
switch_case_r:							; Case '\r' 114-> 13
	cmp 	r0, #114
	bne		switch_case_t
	movw	r0, #13
	b	end_and_return_escape_sequences ; end switch
switch_case_t:							; Case '\t' 116-> 9
	cmp 	r0, #116
	bne		switch_case_v
	movw	r0, #9
	b	end_and_return_escape_sequences ; end switch
switch_case_v:							; Case '\v' 118-> 11
	cmp 	r0, #118
	bne switch_case_slash
	movw	r0, #11
	b	end_and_return_escape_sequences ; end switch
switch_case_slash:						; Case '\\' 92-> 92
	cmp 	r0, #92
	beq	end_and_return_escape_sequences ; end switch
switch_case_quote:						; Case '\'' 39-> 39
	cmp		r0, #39
	beq	end_and_return_escape_sequences ; end switch
switch_case_quotes:						; Case '\"' 34-> 34
	cmp 	r0, #34
	beq	end_and_return_escape_sequences ; end switch
switch_case_quest:						; Case '\?' 63-> 63
	cmp 	r0, #63
	beq	end_and_return_escape_sequences ; end switch
	; Default case. If not one of the recognized escape sequences, will print a '\' and return with
	; passed in value.
switch_case_default:
	push 	{r0}						; Store current character to print
	movw	r0, #0x5c					; Ascii code for '\'
	bl		output_character			; Print '\n'
	pop		{r0}						; Restore r0
end_and_return_escape_sequences:

	POP 	{lr}  						; Restore lr from stack
	mov		pc, lr

;***************************************************************************************************
; Function name: int2string
; Function behavior: Converts an integer to a string. First counts number of digits in the string by
; dividing by 10. Then reverse iterates string to correctly place digits. Uses formula for remainder
; to iterate get decimal place value at each junction n mod 10 = n - (10*floor (n/10)). Stores in
; string index, divides number by 10 and loops again.
; SPECIAL CASE: Passed integer is 0, store '0' and \0
;
; Function inputs:
; r0 : integer for conversion
; r1 : Address of string storage
;
; Function returns: none
;
; Registers used:
; r4 : Holds copy of integer for digit count/remainder to store in string
; r5 : digit counter/loop counter/string offset
; r6 : holds 10 for division and multiplication
;
; Subroutines called:
; none
;
; REMINDER: Push used registers r4-r11 to stack if used *PUSH/POP {r4, r5} or PUSH/POP {r4-r11})
; REMINDER: If calling another function from inside, PUSH/POP {lr}. To return from function MOV pc, lr
;***************************************************************************************************
int2string:
	PUSH	{r4-r6, lr}   						; Store registers on stack


	movw 	r6, #10						; Load decimal 10 into r6 for div/mul

	; Use division do determine number of places in digit.
	mov		r4, r0						; Load integer into r4
	movw	r5, #0						; Load 0 for use as counter/offset

digit_count_begin:
	cmp		r4, #0						; If r4 == 0
	beq		digit_count_end				; Stop counting digits
	; Otherwise, divide integer by 10 and increment counter
	sdiv 	r4, r4, r6					; r4/10
	add		r5, #1						; Increment counter
	b 		digit_count_begin			; Restart loop

digit_count_end:
	; Special case, number entered is 0
	cmp 	r5, #0						; r5 != 0?
	bne		int2string_null_char		; skip next step
	movw	r4, #'0'					; Load ASCII '0'
	strb	r4, [r1]					; Store ASCII '0'
	strb	r5,	[r1, #1]				; Store null character
	b 		int2string_finish_and_return; Finish and return

	; Store the null character at size string index.
int2string_null_char:
	movw	r4, #0						; Load \0 character
	strb	r4, [r1, r5]				; Store null terminator
	add 	r5, #-1						; Decrement counter

	; For each string index, get the value of int mod 10 and store at index, then reduce
	; integer by power of 10 with division until all digits have been stringified
int2string_main_loop:

	; Begin modulus formula
	sdiv 	r4, r0, r6  				; floor (n/10)
	mul		r4, r4, r6					; 10 * floor(n/10)
	sub		r4, r0, r4					; n - 10*floor(n/10)

	; Convert to ascii character and store
	add 	r4, #'0'					; Int + ASCII '0' to get ASCII value
	strb	r4, [r1, r5]				; Store character at address + offset

	; Decrease int by power of 10
	sdiv 	r0, r0, r6					; int / 10

	; Decrement and compare
	add 	r5, #-1						; Decrement
	cmp		r5, #-1						; If r5 != -1
	bne		int2string_main_loop		; Loop again


int2string_finish_and_return:

	; Pop used registers

	POP 	{r4-r6, lr}  						; Restore lr from stack
	mov 	pc, lr

;***************************************************************************************************
; Function name: return_stored_character
; Function behavior: Gets the character from my data and returns to caller. Used when polling from
; main menu when program starts.
;
; Function inputs: none
;
; Function returns:
; r0 : value stored in mydata
;
; Registers used:
; r0 : dereferences pointer and returns value
;
; Subroutines called:
;
;
; REMINDER: Push used registers r4-r11 to stack if used *PUSH/POP {r4, r5} or PUSH/POP {r4-r11})
; REMINDER: If calling another function from inside, PUSH/POP {lr}. To return from function MOV pc, lr
;***************************************************************************************************
return_stored_character:
	;ldr 	r0, ptr_to_mydata
	ldrb	r0, [r0]

	mov 	pc, lr



UART_number:
	PUSH {lr}

	;load uart data register
	MOV r1, #0xC000
	MOVT r1, #0x4000

checkReceive: 					;this loop will continue until new data in found in the data register
	LDRB r2, [r1, #0x018]		;load the flag register
	AND r2, r2, #0x10 			;Bitwise AND with location 4 TxFE
	CMP r2, #0x10				;compare and check if the location is 1 (no data)
	BEQ checkReceive			;or 0 (new data)

 	LDRB r0, [r1]					;once data is received, load the data into r0 register
	CMP r0, #'1'		;check if number is character 1 or greater
	BLT invalidNumber

	CMP r0, #'4'		;check if number is character 4 or smaller
	BGT invalidNumber

	B endUART_number


invalidNumber:
	MOV r0, #0

endUART_number:
	POP {lr}
	MOV PC, LR


	.end


countColors:
	push	{r0-r4, lr}

	mov		r1, #0

	;reset all back to 0
	ldr		r0, ptr_countRed
	strb	r1,	[r0]

	ldr		r0, ptr_countWhite
	strb	r1,	[r0]

	ldr		r0, ptr_countPurple
	strb	r1,	[r0]

	ldr		r0, ptr_countBlue
	strb	r1,	[r0]

	ldr		r0, ptr_countGreen
	strb	r1,	[r0]

	ldr		r0, ptr_countYellow
	strb	r1,	[r0]




	mov		r5, #0
	ldr		r4, ptr_face1
incrementColorCount:
	cmp		r5, #54
	bge		colorCountEnd

	add		r5, #1


	ldrb	r2,	[r4], #1

	cmp 	r2, #face_red
	beq		incRed

	cmp 	r2, #face_white
	beq		incWhite

	cmp 	r2, #face_purple
	beq		incPurple

	cmp 	r2, #face_blue
	beq		incBlue

	cmp 	r2, #face_green
	beq		incGreen

	cmp 	r2, #face_yellow
	beq		incYellow


incRed:
	ldr		r0, ptr_countRed
	ldrb	r3, [r0]
	add		r3, #1
	strb	r3, [r0]
	b		incrementColorCount

incWhite:
	ldr		r0, ptr_countWhite
	ldrb	r3, [r0]
	add		r3, #1
	strb	r3, [r0]
	b		incrementColorCount

incPurple:
	ldr		r0, ptr_countPurple
	ldrb	r3, [r0]
	add		r3, #1
	strb	r3, [r0]
	b		incrementColorCount

incBlue:
	ldr		r0, ptr_countBlue
	ldrb	r3, [r0]
	add		r3, #1
	strb	r3, [r0]
	b		incrementColorCount


incGreen:
	ldr		r0, ptr_countGreen
	ldrb	r3, [r0]
	add		r3, #1
	strb	r3, [r0]
	b		incrementColorCount

incYellow:
	ldr		r0, ptr_countYellow
	ldrb	r3, [r0]
	add		r3, #1
	strb	r3, [r0]
	b		incrementColorCount

colorCountEnd:
	pop 	{r0-r4, lr}
	mov 	pc, lr



	pick_second_rotation:
	push	{lr}

	ldr 	r1, ptr_rotationSelect
	ldrb	r0, [r1]

	cmp		r0, #1
	beq		ccw_valid

	cmp		r0, #2
	beq		cw_valid

	pop		{lr}
	mov		pc, lr



clockwise_rotation:
	push	{lr}

	; first check if end result is a valid move
	ldr		r1, ptr_playerPos
	ldrb	r0, [r1]

	cmp		r0, #9
	beq		cw_valid

	; square 2 case
	cmp		r0, #2
	it		eq
	moveq 	r1, #10

	; square 1 case
	cmp		r0, #1
	it		eq
	moveq	r1, #9

	sub		r1, r0, #2 	; the square to check
	ldr		r2, ptr_currentFace
	ldrb	r3, [r2]
	bl		get_face
	bl		check_if_valid_rotation

cw_valid:

	;store rotation
	ldr		r1, ptr_rotationSelect
	mov		r0, #2
	strb	r0, [r1]

	; get the current face
	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	ldr		r5, ptr_blankFace

	mov 	r3, #0	;offset counter

	;check state
	ldrb	r1, [r9]

	cmp		r1, #1
	beq		cw_first_rotation

	cmp		r1, #7
	beq		cw_second_rotation

	b		cw_face_rotation1_end

cw_first_rotation:
	mov		r0, #8
	strb	r0, [r9]

cw_first_turn:
	ldrb	r0, [r4, r3]
	add		r3, #1
	strb	r0, [r5, r3]

	cmp		r3, #7
	blt		cw_first_turn

	; sqaure 8 case
	ldrb	r0, [r4, #7]
	strb	r0, [r5]

	;square 9 is the same
	ldrb	r0, [r4, #8]
	strb	r0, [r5, #8]

	;save into addr_rotation from cube.s
	str		r5, [r8]

	b		cw_face_rotation1_end


cw_second_rotation:

	mov		r0, #1
	strb	r0, [r9]
cw_second_turn:
	ldrb	r0, [r4, r3]
	add		r3, #2
	strb	r0, [r5, r3]

	sub		r3, #1
	cmp		r3, #6
	blt		cw_second_turn

	; square 7 case
	ldrb	r0, [r4, #6]
	strb	r0, [r5]

	; sqaure 8 case
	ldrb	r0, [r4, #7]
	strb	r0, [r5, #1]

	;square 9 is the same
	ldrb	r0, [r4, #8]
	strb	r0, [r5, #8]

	;save into addr_rotation from cube.s
	str		r5, [r8]

	; save the blank face as the real face.
	mov		r0, #0
cw_saveToCurrentFace:
	ldrb	r1, [r5], #1
	strb	r1, [r4], #1
	add		r0, #1
	cmp		r0, #9
	blt		cw_saveToCurrentFace

	; save state
	mov		r0, #9
	strb	r0, [r9]

	; reset rotation
	ldr		r1, ptr_rotationSelect
	mov		r0, #0
	strb	r0, [r1]



	pop		{lr}
	mov		pc, lr

cw_face_rotation1_end:
	pop 	{lr}
	b		actual_end



counterclockwise_rotation:
	push	{lr}

	; first check if end result is a valid move
	ldr		r1, ptr_playerPos
	ldrb	r0, [r1]

	cmp		r0, #9
	beq		ccw_valid

	; square 7 case
	cmp		r0, #7
	it		eq
	moveq 	r1, #-1

	; square 8 case
	cmp		r0, #8
	it		eq
	moveq	r1, #0

	add		r1, r0, #2 	; the square to check
	ldr		r2, ptr_currentFace
	ldrb	r3, [r2]
	bl		get_face
	bl		check_if_valid_rotation

ccw_valid:
	;store rotation
	ldr		r1, ptr_rotationSelect
	mov		r0, #1
	strb	r0, [r1]

	; get the current face
	ldr		r1,	ptr_currentFace
	ldrb	r3, [r1]
	bl		get_face	; stored in r4

	ldr		r5, ptr_blankFace

	mov 	r3, #7	;offset counter

	;check state
	ldrb	r1, [r9]

	cmp		r1, #1
	beq		ccw_first_rotation

	cmp		r1, #7
	beq		ccw_second_rotation

	b		ccw_face_rotation1_end

ccw_first_rotation:
	mov		r0, #8
	strb	r0, [r9]

ccw_first_turn:
	ldrb	r0, [r4, r3]
	sub		r3, #1
	strb	r0, [r5, r3]

	cmp		r3, #0
	bgt		ccw_first_turn

	; sqaure 1 case
	ldrb	r0, [r4]
	strb	r0, [r5, #7]

	;square 9 is the same
	ldrb	r0, [r4, #8]
	strb	r0, [r5, #8]

	;save into addr_rotation from cube.s
	str		r5, [r8]

	b		ccw_face_rotation1_end


ccw_second_rotation:

	mov		r0, #1
	strb	r0, [r9]
ccw_second_turn:
	ldrb	r0, [r4, r3]
	sub		r3, #2
	strb	r0, [r5, r3]

	add		r3, #1
	cmp		r3, #1
	bgt		ccw_second_turn

	; square 2 case
	ldrb	r0, [r4, #1]
	strb	r0, [r5, #7]

	; sqaure 1 case
	ldrb	r0, [r4]
	strb	r0, [r5, #6]

	;square 9 is the same
	ldrb	r0, [r4, #8]
	strb	r0, [r5, #8]

	;save into addr_rotation from cube.s
	str		r5, [r8]

	; save the blank face as the real face.
	mov		r0, #0
ccw_saveToCurrentFace:
	ldrb	r1, [r5], #1
	strb	r1, [r4], #1
	add		r0, #1
	cmp		r0, #9
	blt		ccw_saveToCurrentFace

	; save state
	mov		r0, #9
	strb	r0, [r9]

	; reset rotation
	ldr		r1, ptr_rotationSelect
	mov		r0, #0
	strb	r0, [r1]

	pop		{lr}
	mov		pc, lr

ccw_face_rotation1_end:
	pop 	{lr}
	b		actual_end

