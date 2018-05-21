/*
Programa principal del cronometro
*/

.data
.align 2
menu: .asciz "Ingrese una opcion:\n1. Configurar alarma por hardware.\n2. Configurar alarma por sowtfare\n3. Salir\n"
ingresoSecs: .asciz "Ingrese segundos en la alarma (0-60):\n"
errorMessageOpt: .asciz "Error! ingrese una opcion valida."
inputFormat: .asciz "%d"
input: .word 0
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
	ldr r1, =input
	bl scanf

	/* Verify input is valid */
	ldr r0, =input
	ldr r0, =[r0]
	/* Opcion por hardware */
	cmp r0, #1
	beq hardware
	/* Opcion por software */
	cmp r0, #2
	beq software
	/* Salir */
	cmp r0, #3
	@beq salir
	/* Opcion invalida */
	bne errorOpt

/* Opcion invalida ingresada */
errorOpt:
	ldr r0, =errorMessageOpt
	bl printf
	b start

/* Configuracion por hardware */
hardware:
	

/* Configuracion por software */
software:
	ldr r0, =ingresoSecs
	bl printf

	ldr r0, =inputFormat
	ldr r1, =input
	bl scanf 
