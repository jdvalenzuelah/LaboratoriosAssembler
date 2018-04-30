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
nota2: .float 15
nota3: .float 15
nota4: .float 15
@Nota base para aprovar
base: .float 61
result: .word 0
@String para desplegar el resultado
string1 .asciz "La nota a obtener en el proyecto es de: %f% \n"

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
	vldr s0, [r0]
	vcvt.F64.F32 d3, s0
	vmov r2, r3, d3
	@Imprimimos el resultado
	ldr r0, =string1
	bl printf

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


/**
 * r0 - r3 contiene la direccion del valor float
 * Retorna direccion del valor en r0
*/
.global calculoNotaProyecto
calculoNotaProyecto:
	/* Cargar los valores punto flotante y convertirlos a B64 */
	@Cargamos las notas
	vldr s0, [r0]
	vcvt.F64.F32 d5, s0
	vldr s1, [r1]
	vcvt.F64.F32 d6, s1
	vldr s2, [r2]
	vcvt.F64.F32 d7, s2
	vldr s3, [r3]
	vcvt.F64.F32 d8, s3
	@Cargamos la base
	ldr r5, adbase
	vldr s10, [r5]
	vcvt.F64.F32 d9, s10
	/* Sumamos todos los valores */ 
	vadd.F64 d5, d5, d6
	vadd.F64 d5, d5, d7
	vadd.F64 d5, d5, d8
	/* Encontramos cuanto falta para llegar a 61 */
	vsub.F64 d4, d9, d5
	/* Guardamos el resultado en el puntero de r0*/
	ldr r0, =result
	vstr d4, [r0]
	@Guardamos el resultado en la direccion de r0
	mov pc, lr @Return r0
