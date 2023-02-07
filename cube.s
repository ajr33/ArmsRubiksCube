	.data

	.text

	.global cubeGame
	.global uart_init
	.global gpio_interrupt_init



cubeGame:

	; Initialize peripherals
	bl	gpio_interrupt_init
	bl 	uart_init



	b cubeGameLoop

cubeGameLoop:

	b cubeGameLoop
