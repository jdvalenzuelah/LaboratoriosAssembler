/**********************************************************************
Universidad del Valle de Guatemala
Authors: Josue David Valenzuela 171001
		 Marcos Gutierrez	    17909
Two player connect 4 game developed as part of CC3055 course
File contains subroutines and stores the data for the connect 4 game.
**********************************************************************/
.data
inputFormat: .asciz "%d"
inputMessage: .asciz "Ingrese un numero:\n"
menPromedio: .asciz "El promedio es: %d\n"
num1: .word 0
num2: .word 0
num3: .word 0
num4: .word 0

/* main function */
.text
.align 2
.global main
.type main,%function
main:
	stmfd sp!,{lr}

	ldr r0, =inputMessage
	bl printf
	ldr r0, =inputFormat
	ldr r1, =num1
	bl scanf

	ldr r0, =inputMessage
	bl printf
	ldr r0, =inputFormat
	ldr r1, =num2
	bl scanf

	ldr r0, =inputMessage
	bl printf
	ldr r0, =inputFormat
	ldr r1, =num3
	bl scanf

	ldr r0, =inputMessage
	bl printf
	ldr r0, =inputFormat
	ldr r1, =num4
	bl scanf

	ldr r0, =num1
	ldr r0, [r0]

	ldr r1, =num2
	ldr r1, [r1]

	ldr r2, =num3
	ldr r2, [r2]

	ldr r3, =num4
	ldr r3, [r3]
	bl promedio

	mov r1, r0
	ldr r0, =menPromedio
	bl printf

/* exit code */
exit:	
	@OS exit
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr
