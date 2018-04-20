/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
autor: David Valenzuela				171001
autor: Juan Jose Navas
*/

.data
.align 2
mensaje: .asciz "Ingrese nombre en minusculas (Maximo 10 caracteres, y sin espacios en blaco)\n"
formatoEntrada: .string "%s"
nombre: .string "%s"
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

	/* Recorrido de el string*/
	mov r7, #0
	mov r8, #32
	ldr r5, =nombre
ciclo:
	ldr r6, [r5, r7]
	subs r6, r6, r8 @Cambio a mayuscula
	ldr r9, =resultado
	str r6, [r9]
	add r7, r7, #1
	cmp r7, #5
	bne ciclo

	/* Imprimimos el resultado */
	ldr r0, =formatoEntrada
	ldr r1, =resultado
	bl printf


	

	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

