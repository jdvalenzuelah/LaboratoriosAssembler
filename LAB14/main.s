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
	/* Mostramos el menu */
	ldr r0, =menu
	bl printf

	/* Obtenemos la opcion ingresada */
	ldr r0, =inputFormat
	ldr r1, =opt
	bl scanf

	/* Verificamos que el input sea valido */
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
	/* Mpstramos mensaje */
	ldr r0, =ingresoSecs
	bl printf
	/* Obtenemos el valor ingresado */
	ldr r0, =inputFormat
	ldr r1, =secs
	bl scanf
	/* Validamos ingreso valido (0-60)*/
	ldr r0, =secs
	ldr r0, [r0]
	cmp r0, #0
	blt errorRj
	cmp r0, #60
	bgt errorRj
	/* Cargamos la alarma e inicializamos un contador  */
	alarma .req r10
	cont .req r9
	mov alarma, r0
	mov cont, #0
	/* Iniciamos la alarma */
	b cronometro

cronometro:
	@Guardar el valor de la alarma y el contador
	push {cont, alarma}
	@Obtenemos los digitos
	mov r0, cont
	bl getDigits
	@Mostramos los digitos en los displays
	bl numeros
	@Esperamos por un segundo
	mov r0, #1
	bl segundos
	pop {cont, alarma}
	add r9, #1
	cmp r9, r10
	ble cronometro
	.unreq cont
	.unreq alarma
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
