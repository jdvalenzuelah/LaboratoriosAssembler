/**********************************************************************
Universidad del Valle de Guatemala
Authors: Josue David Valenzuela 171001
		 Marcos Gutierrez	    17909
Two player connect 4 game developed as part of CC3055 course
File contains subroutines and stores the data for the connect 4 game.
**********************************************************************/

.text
.align 2
/**
 * Promedio de 4 numeros. Parametros de r0 - r4 numeros a sacar el promedio
 * Return: promedio de los cuatro numeros en r0
*/
.global
promedio:
	add r0, r1
	add r0, r2
	add r0, r3
	lsr r0, #2
	mov pc, lr
