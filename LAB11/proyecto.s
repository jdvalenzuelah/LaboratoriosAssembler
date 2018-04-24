/**********************************************************************
Universidad del Valle de Guatemala
Autores:
**********************************************************************/
.data
.align 2
girarDadosStr: .asciz "Presione cualquier tecla y enter para girar los dados:\n"
prueba: .asciz "%s"
ganador: .asciz "El ganador es: Jugador %d\n"
jugador1: .word 0
jugador2: .word 0


/* Main del programa */
.text
.align 2
.global main
.type main,%function
main:
	stmfd sp!,{lr}

	@Mostrar instrucciones
	ldr r0, =girarDadosStr
	bl printf

	@Girar los dados
	ldr r0, =prueba
	ldr r1, =prueba
	bl scanf
jugar:
	mov r0, #6
	bl rand
	add r0, #1
	ldr r1, =jugador1
	str r0, [r1]

	mov r0, #6
	bl rand
	add r0, #1
	ldr r1, =jugador2
	str r0, [r1]

	ldr r2, =jugador1
	ldr r2, [r2]
	ldr r3, =jugador2
	ldr r3, [r3]
	cmp r2, r3
	movgt r1, #1
	movlt r1, #2
	beq jugar

	ldr r0, =ganador
	bl printf
	
exit:
	@UN LINK variables
	.unreq winner
	.unreq cont
	@OS exit
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr

