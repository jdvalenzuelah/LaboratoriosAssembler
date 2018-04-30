/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
autor: David Valenzuela				171001
*/

/* Informacion utilizada */
.data
.align 2
nota1: .float 10
nota2: .float 15
nota3: .float 15
nota4: .float 15
string: .asciz "La nota a obtener en el proyecto es de: %f% \n"
test: .asciz "Prueba: %f"

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

	@valor de retorno esta en r0, lo movemos a r1
	ldr r1, [r0]
	@Imprimimos el resultado
	ldr r0, =string
	bl printf



	@OS exit
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr

addrNota1: .word nota1
addrNota2: .word nota2
addrNota3: .word nota3
addrNota4: .word nota4
