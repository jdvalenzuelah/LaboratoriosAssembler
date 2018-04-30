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
.global main
main:
	stmfd sp!, {lr}	/* SP = R13 link register */

	@Cargamos las notas a los registros
	ldr r0, addrNota1
	ldr r1, addrNota2
	ldr r2, addrNota3
	ldr r3, addrNota4

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
	push {lr}
	@Cargar los valores punto flotante y convertirlos a B64
	vldr s0, [r0]
	vcvt.F64.F32 d5, s0
	vldr s1, [r1]
	vcvt.F64.F32 d6, s1
	vldr s2, [r2]
	vcvt.F64.F32 d7, s2
	vldr s3, [r3]
	vcvt.F64.F32 d8, s3
	mov r5, #61
	vmov s4, r5
	vcvt.F64.F32 d9, s4
	@Sumamos todos los valores
	vadd.F64 d5, d5, d6
	vadd.F64 d5, d5, d7
	vadd.F64 d5, d5, d8
	@Encontramos cuanto falta para llegar a 61
	vsub.F64 d5, d9, d5
	ldr r0, =test
	vmov r2, r3, d5
	@Guardamos el resultado en la direccion de r0
	pop {lr}
	mov pc, lr @Return r0
