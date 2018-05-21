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
confPin:
/*
Configuracion de pines:
	Pines display 1 utilizando BCD:
		GPIO 02 --> 1000 A
		GPIO 03 --> 0100 B
		GPIO 04 --> 0010 C
		GPIO 17 --> 0001 D
	Pines display 2 utilizando BCD:
		GPIO 22 --> 1000 A
		GPIO 10 --> 0100 B
		GPIO 09 --> 0010 C
		GPIO 11 --> 0001 D
	Pin LED/Buzzer alarma:
		GPIO 12
	Pin Boton aumentar digito:
		GPIO 5
	Pin Boton cambiar unidades/decenas:
		GPIO 6
	Pin Boton reset:
		GPIO 13
*/
	@bl GetGpioAddress
	/* ---- Configurar pines entrada/salida ---- */
	/* Salidas */
	@Display 1
	@@GPIO para escritura puerto 2
	mov r0,#2
	mov r1,#1
	bl SetGpioFunction
	@@GPIO para escritura puerto 3
	mov r0,#3
	mov r1,#1
	bl SetGpioFunction
	@@GPIO para escritura puerto 4
	mov r0,#4
	mov r1,#1
	bl SetGpioFunction	
	@@GPIO para escritura puerto 17
	mov r0,#17
	mov r1,#1
	bl SetGpioFunction
	@Display 2---------
	@@GPIO para escritura puerto 22
	mov r0,#22
	mov r1,#1
	bl SetGpioFunction
	@@GPIO para escritura puerto 10
	mov r0,#10
	mov r1,#1
	bl SetGpioFunction
	@@GPIO para escritura puerto 9
	mov r0,#9
	mov r1,#1
	bl SetGpioFunction
	@@GPIO para escritura puerto 11
	mov r0,#11
	mov r1,#1
	bl SetGpioFunction
	@@Indicador de alarma (Buzzer/LED)
	mov r0,#12		@Puerto 12 , como salida 
	mov r1,#1
	bl SetGpioFunction
	/* Entradas */
	@Button subir 
	mov r0,#5  	@Puerto 5 como entrada 
	mov r1,#0 
	bl SetGpioFunction
	@@Button cambiar digito
	mov r0,#6	@Puerto 6 como entrada 
	mov r1,#0
	bl SetGpioFunction 
	@@Button reset (Empezar alarma en 0)
	mov r0,#13 	@Puerto 13 como entrada
	mov r1,#0
	bl SetGpioFunction


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
