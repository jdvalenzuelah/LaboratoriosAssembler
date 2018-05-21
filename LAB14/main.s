/*
Programa principal del cronometro
*/

.data
.align 2
menu: .asciz "Ingrese una opcion:\n1. Configurar alarma por hardware.\n2. Configurar alarma por sowtfare\n3. Salir\n"
ingresoSecs: .asciz "Ingrese segundos en la alarma (0-60):\n"
errorMessageOpt: .asciz "Error! ingrese una opcion valida.\n"
errorMessageRj: .asciz "Valor invalido! Ingrese un valir entre 0 y 60.\n"
inputFormat: .asciz "%d"
testStr: .asciz "Secs: %d\n"
opt: .word 0
secs: .word 0
.global myloc
myloc: .word 0

.text
.align 2
.global main
.type main,%function
main:
	stmfd sp!,{lr}

start:
	/* Show the menu */
	ldr r0, =menu
	bl printf

	/* Get the selected option */
	ldr r0, =inputFormat
	ldr r1, =opt
	bl scanf

	/* Verify input is valid */
	ldr r0, =opt
	ldr r0, [r0]
	/* Opcion por hardware */
	cmp r0, #1
	beq hardware
	/* Opcion por software */
	cmp r0, #2
	beq software
	/* Salir */
	cmp r0, #3
	beq salir
	/* Opcion invalida */
	bne errorOpt



/* Configuracion por hardware */
hardware:
	mov r0, #0

/* Configuracion por software */
software:
	/* Show message */
	ldr r0, =ingresoSecs
	bl printf
	/* Get the input value */
	ldr r0, =inputFormat
	ldr r1, =secs
	bl scanf
	/* Verify valid input (0-60)*/
	ldr r0, =secs
	ldr r0, [r0]
	cmp r0, #0
	blt errorRj
	cmp r0, #60
	bgt errorRj
	mov r10, r0
	mov r9, #0
	b cronometro

cronometro:
	push {r9, r10}
	ldr r0, =testStr
	mov r1, r10
	bl printf
	mov r0, #1
	bl segundos
	pop {r9, r10}
	add r9, #1
	cmp r9, r10
	bne cronometro
	b start

/* Opcion invalida ingresada */
errorOpt:
	ldr r0, =errorMessageOpt
	bl printf
	b start

/* Valor invalido ingresado */
errorRj:
	ldr r0, =errorMessageRj
	bl printf
	b software

salir:
	@OS exit
	mov r0, #0
	mov r3, #0
	ldmfd sp!,{lr}
	bx lr
