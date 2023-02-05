	.data

	.text

	.global cubeGame
	.global uart_init



cubeGame:

	; Initialize peripherals
	bl uart_init

	b cubeGameLoop

cubeGameLoop:

	b cubeGameLoop
