/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
*/

/* Datos con lo que se trabajara */
.data
.align 2
menu: .asciz "Ingrese una opcion a trabjar. \n	+ para suma \n	- para resta \n	* para multiplicacion \n	= para mostrar el resultado almacenado \n	q salir del programa"

/*Funcion principal el programa*/
.text
.global main
.align , %function
.extern
.type main, printf

main: 
	stmfd sp!, {lr} /*link register*/

	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr
