/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
*/

/* ---------------- Datos con lo que se trabajara ---------------- */
.data
.align 2

/* Formatos para ingreso de datos */
menu: .asciz "	1. para suma \n	2. para resta \n	3. para multiplicacion \n	3. para mostrar el resultado almacenado \n	4. Mostrar resultado. \n	5. salir del programa\nIngrese una opcion a trabjar: "
mensajeOperando: .asciz "\nIngrese un numero: "
formatoEntrada: .asciz "%d"


/* Valores almacenados */
opcionSeleccionada: .word 0
valor: .word 0
operando: .word 0

/* --------------------------------------------------------------- */

/*  ------------------ Funcion main del programa ----------------- */
.text
.global main
.extern printf @printf de la libreria de c para imprimir

suma:
	ldr r5, =opcionSeleccionada @Cargamos direccion de opcionSeleccionada
	mov r6, #0 @Iniciamos r6 en 0
	str r6, [r5] @Reseteamos el valor de opcionSeleccionada

	ldr r0, =valor @Direccion del valor
	ldr r1, [r0] @Cargamos valor a r1
	ldr r2, =operando @Cargamos direccion de operando a r2
	ldr r2, [r2] @Cargamos valor a r2
	add r1, r1, r2 @r1 = r1 + r2
	str r1, [r0] @valor = r1
	b main


main:
	stmfd sp!, {lr}	/* SP = R13 link register */


	/* Imprimimos el menu */
	ldr r0, =menu @Cargamos el menu a r0
	bl printf @Imprimimos el menu

	/* Pedimos la opcion al usuario */
	ldr r0, =formatoEntrada @Formato de ingreso
	ldr r1, =opcionSeleccionada @Guardamos la opcion en memoria
	bl scanf

	/* Opcion de suma */
	ldr r0, =opcionSeleccionada
	ldr r0, [r0]
	cmp r0, #1
	
	ldreq r0, =mensajeOperando
	bleq printf
	ldreq r0, =formatoEntrada
	ldreq r1, =operando
	bleq scanf
	beq suma



	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

/* --------------------------------------------------------------- */