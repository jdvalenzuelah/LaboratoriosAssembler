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
display1: .word 0
display2: .word 0
displayActual: .word 1
.global myloc
myloc: .word 0

.text
.align 2
.global main
.type main,%function
main:
	stmfd sp!,{lr}
	b start
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
	Pin boton iniciar alarma:
		GPIO 16
*/
	bl GetGpioAddress
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
	@Iniciamos buzzer/Ledapagado
	mov r0, #12
	mov r1, #0
	bl SetGpio
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
	botones:
		/* Boton aumentar digito */
		mov r0, #5
		bl GetGpio2
		cmp r0, #1
		beq aumentarDigito
		/* Boton cambiar unidades/decenas */
		mov r0, #6
		bl GetGpio2
		cmp r0, #1
		beq cambiarDisplay
		/* Boton reset */
		mov r0, #13
		bl GetGpio2
		cmp r0, #1
		beq reset
		/* boton iniciar alarma */
		mov r0, #16
		bl GetGpio2
		cmp r0, #1
		beq comienzoH

	comienzoH:
		/* alarma, contador, display1 (r5) y display2 (r6) */
		alarma .req r10
		cont .req r9
		ldr r5, =display1
		ldr r6, =display2
		ldr r5, [r5]
		ldr r6, [r6]
		mov r7, #10 @r7 = 10
		/* Display2 decenas, multiplizamos por 10 */
		mul r6, r7
		mov alarma, #0 @Alarma = 0
		add alarma, r5, r6 @Alarma = (display2 * 10) + display1
		mov cont, #0 @cont = 0
		b cronometro @Comenzamos alarma

	reset:
		/*  Poner todo en 0 */
		mov r0, #0
		mov r1, #0
		ldr r2, =display1
		ldr r3, =display2
		str r0, [r2]
		str r1, [r3]
		bl numeros
		b botones

	cambiarDisplay:
		/* Obtenemos el display actual */
		ldr r5, =displayActual
		ldr r5, [r5]
		/* Si esta en display 1 cambiamos al 2 y viceversa */
		cmp r5, #1
		moveq r5, #2
		cmp r5, #2
		moveq r5, #1
		/* Guardamos el nuevo display actual */
		ldr r6, =displayActual
		str r5, [r6]
		b botones

	aumentarDigito:
		/* Cargamos los valores actuales del display, y el display que se configura */
		ldr r4, =displayActual
		ldr r4, [r4]
		ldr r3, =display1
		ldr r3, [r3]
		ldr r2, =display2
		ldr r2, [r2]
		/* Configuracion display 1 */
		cmp r4, #1
		addeq r3, #1 @r3++
		/* Configuracion display 2 */
		cmp r4, #2
		addeq r2, #1 @r2++
		/* Guardamos los valores de los displays */
		ldr r5, =display1
		str r3, [r5]
		ldr r6, =display2
		str r2, [r6]
		/* Mostramos los valores */
		mov r0, r3
		mov r1, r2
		bl numeros
		b botones


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
	add cont, #1
	cmp cont, alarma
	ble cronometro
	.unreq cont
	.unreq alarma
	b alerta

alerta:
	/* Encendemos el indicador de la alarma */
	/* Alerta: 
	Enciende 2 segundos, apaga un segundo, se enciende 2 segundos se apaga de nuevo */
	mov r0, #12 @GPIO 12
	mov r1, #1 @High
	bl SetGpio
	mov r0, #2
	bl segundos
	mov r0, #12 @GPIO 12
	mov r1, #0 @Low
	bl SetGpio
	mov r0, #1
	bl segundos
	mov r0, #12 @GPIO 12
	mov r1, #1 @High
	bl SetGpio
	mov r0, #2
	bl segundos
	mov r0, #12 @GPIO 12
	mov r1, #1 @low
	bl SetGpio
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
