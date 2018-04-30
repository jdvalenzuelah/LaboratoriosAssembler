/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
autor: David Valenzuela				171001
*/

/* Informacion utilizada */
.data
.align 2
nota1: .float 15
nota2: .float 15
nota3: .float 15
nota4: .float 15
string: .asciz "La nota a obtener en el proyecto es de: %d % \n"

/* Funcion main del programa */
.text
.global main
main:
	stmfd sp!, {lr}	/* SP = R13 link register */

	@Cargamos las notas a los registros
	ldr r0, =addrNota1
	ldr r1, =addrNota2
	ldr r2, =addrNota3
	ldr r3, =addrNota4

	ldr r0, =string
	bl printf

	bl CalculoNotaProyecto @Llamamos a la subrutina
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

/**
 * r0 - r3 contiene la direccion del valor float
*/
.global CalculoNotaProyecto
CalculoNotaProyecto:
	@Cargar los valores punto flotante
	vldr s0, [r0]
	vldr s1, [r1]
	vldr s2, [r2]
	vldr s3, [r3]
	mov r5, #61
	@S4 se usa para guardar la suma de las notas
	vadd.F32 s4, s0, s1 @s4 = s0 + s1
	vadd.F32 s4, s4, s2 @s4 = s4 + s2
	vadd.F32 s4, s4, s3 @s4 = s4 + s3
	@busca32lo restante para llegar a 61
	vmov.F64 s5, r5 @d5 = 61
	vsub.F32 s4, s5, s4 @d4 = d5 - d4
	@Guardar la direccion en r0
	vstr d5, [r0]
	mov pc, lr @Return r0
