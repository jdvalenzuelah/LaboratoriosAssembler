/*
Universidad del Valle de Guatemala
Autores:
	Fernando Hengstenberg 17909
	David Valenzuela 171001
Corrimiento de bit utilizando LEDS en el puerto 16, 20, 21. Boton conectado al pin 22
*/

.data
.align 2
.global myloc
myloc: .word 0

.text
.align 2
.global main
main:
	stmfd sp!, {lr}

	/* Get GPIO address */
	bl GetGpioAddress

	/* Set function on GPIO 16, 20, 21, 22 */
	@pin 16 como salida
	mov r0, #16
	mov r1, #1
	bl SetGpioFunction
	@pin 20 como salida
	mov r0, #20
	mov r1, #1
	bl SetGpioFunction
	@pin 21 como salida
	mov r0, #21
	mov r1, #1
	bl SetGpioFunction
	@pin 22 como entrada
	mov r0, #22
	mov r1, #0
	bl SetGpioFunction

	@Variables a usar durante el programa
	cont .req r4
	boton .req r5
	@Iniciamos el contador con 0
	mov cont, #0
loop:
	@Obtenemos el valor del Boton
	mov r0, #22
	bl GetGpio2
	@Movemos el resultado al boton
	mov boton, r0
	cmp boton, #1 @if(boton.isPresionado())
	addeq cont, cont, #1 @cont += 1
	beq leds @Go to LEDS
leds:
	cmp cont, #1 @if(cont == 1)
	beq case1 @Go to case1
	cmp cont, #2
	beq case2
	cmp cont, #3
	beq case3


case1:
	@Encendemos LED en pin 16, y apagamos el resto
	mov r0, #16
	mov r1, #1
	bl SetGpio
	mov r0, #20
	mov r1, #0
	bl SetGpio
	mov r0, #21
	mov r1, #0
	bl SetGpio
	b loop @Regresamos al loop principal
case2:
	@Encendemos LED en pin 20, y apagamos el resto
	mov r0, #16
	mov r1, #0
	bl SetGpio
	mov r0, #20
	mov r1, #1
	bl SetGpio
	mov r0, #21
	mov r1, #0
	bl SetGpio
	b loop @Regresamos al loop principal
case3:
	@Encendemos LED en pin 21, y apagamos el resto
	mov r0, #16
	mov r1, #0
	bl SetGpio
	mov r0, #20
	mov r1, #0
	bl SetGpio
	mov r0, #21
	mov r1, #1
	mov cont, #0
	bl SetGpio
	b loop @Regresamos al loop principal
salida:
	.unreq boton
	.unreq cont
	@OS exit
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr
	