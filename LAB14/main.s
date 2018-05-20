/*
Programa principal del cronometro
*/

.data
.align 2
str1: .asciz "Delay"
str2: .asciz "after delay"
.global myloc
myloc: .word 0

.text
.align 2
.global main
.type main,%function
main:
	stmfd sp!,{lr}

	ldr r0, =str1
	bl printf

	/*mov r0, #10
	bl reloj*/

	ldr r0, =str2
	bl printf

	@OS exit
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr
