/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
*/

/* Datos con lo que se trabajara */
.data
.align 2

a: .asciz "%s"
b: .asciz "%d"

/* Formatos para ingreso de datos */
menu: .asciz "Ingrese una opcion a trabjar: \n	+ para suma \n	- para resta \n	* para multiplicacion \n	= para mostrar el resultado almacenado \n	q salir del programa\n"
opcion: .asciz "%s"
operando: .string "%d"
/* Operandos */
suma: .string "+"
resta: .string "-"
multiplicacion: .string "*"
salir: .string "q"

valor: .word 0

/*Funcion principal el programa*/
.text
.global main
.align 2
.type main, %function
.extern printf, scanf


/* Funcion para suma de datos*/
sumar:
	ldr r4, adrvalor
	ldr r4, [r4]
	add r6, r4, r5
	str r4, [r6]
	b main


main: 
	stmfd sp!, {lr} /*link register*/

	ldr r0, =menu
	bl printf

	@Seleccion de opcion del programa
	ldr r0, =a
	ldr r1, =opcion
	bl scanf

	/* cargamos la opcion */
	ldr r0, =opcion
	bl printf

	ldr r0, =suma
	ldr r0, [r0]
	ldr r1, =opcion
	ldr r1, [r1]

	/* Opcion de suma */
	cmp r0, r1
	ldreq r0, =menu
	bleq printf

salida:
	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

adrvalor: .word valor
