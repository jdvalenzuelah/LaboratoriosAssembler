/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
*/

/* Datos con lo que se trabajara */
.data
.align 2

a: .word 0

menu: .asciz "Ingrese una opcion a trabjar: \n	+ para suma \n	- para resta \n	* para multiplicacion \n	= para mostrar el resultado almacenado \n	q salir del programa\n"
opcion: .asciz "%s"
operando: .asciz "%d"
/*Funcion principal el programa*/
.text
.global main
.align 2
.type main, %function
.extern printf, scanf

main: 
	stmfd sp!, {lr} /*link register*/

	@Mostrar el menu
	ldr r0, =menu
	bl printf

	@Entrada de Datos
	ldr r0, =opcion
	ldr r1, =a
	bl scanf

	@imprime lo recibido
	ldr r0, = opcion
	ldr r1, = a
	ldr r1, [r1]
	bl printf






	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr
