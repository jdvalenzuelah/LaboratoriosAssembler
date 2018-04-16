
/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
autor: David Valenzuela				171001
autor: Juan Jose Navas
*/


@Programa1

.data
.align 2

datos:		.word 0,0,0,0,0,0,0,0,0,0
formatoN:	.asciz "%d "
formatoS:	.asciz "%s "

.text
.align 2
.global main
.type main,%function

main:
	stmfd sp!,{lr}
	
	ldr r8,=datos
	
	mov r10,#1	@
	
recorrido:
	ldr r1,[r8]	
	ldr r0,=formatoN
	
	add r8,#1	@conteo normal 
	bl printf

	bne recorrido	
	
	ldr r1,[r8]	
	ldr r0,=formatoS
	subs r8,#1	@emieza en retroceso 
	bl printf

	
	bne recorrido

		
	@Salida
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr
