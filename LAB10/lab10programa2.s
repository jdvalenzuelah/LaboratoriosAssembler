/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
autor: David Valenzuela				171001
autor: Juan Jose Navas
*/

.data
.align 2
mensaje: .asciz "Ingrese nombre en minusculas (Maximo 10 caracteres, y sin espacios en blaco)\n"
formatoEntrada: .asciz "%s"
nombre: .asciz "%s"
letrasMinusculas: .byte 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' 
letrasMayusculas: .byte 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
resultado: .asciz " "

.text
.global main
.extern printf

main:
	stmfd sp!, {lr}	/* SP = R13 link register */

	/* Imprimimos inicio del porgrama */
	ldr r0, =mensaje
	bl printf

	/* Entrada de datos */
	ldr r0, =formatoEntrada
	ldr r1, =nombre
	bl scanf

	/* Recorrer el vector */
	ldr r2, =letrasMinusculas @Letras Mayuculas
	ldr r3, =letrasMayusculas @Letras minusculas
	ldr r4, =nombre @Nombre Ingresado

	ldr r0, =nombre
	ldr r0, [r0, #1]
	bl printf




	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

