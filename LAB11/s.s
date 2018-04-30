/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
autor: David Valenzuela				171001
*/

/* Informacion utilizada */
.data
.align 2
@Notas
nota1: .float 10
nota2: .float 10
nota3: .float 10
nota4: .float 10
@Nota base para aprovar
base: .float 61
@String para desplegar el resultado
res: .asciz "* *"

/* Funcion main del programa */
.text
.align 2

.global main
.type main,%function
main:
	stmfd sp!, {lr}	/* SP = R13 link register */

	@Cargamos las notas a los registros
	ldr r0, addrNota1
	ldr r1, addrNota2
	ldr r2, addrNota3
	ldr r3, addrNota4

	bl calculoNotaProyecto @Llamamos a la subrutina

	@OS exit
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr

@Direcciones de los puntos flotantes
addrNota1: .word nota1
addrNota2: .word nota2
addrNota3: .word nota3
addrNota4: .word nota4
adbase: .word base
