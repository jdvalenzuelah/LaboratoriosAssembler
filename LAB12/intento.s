/*
Universidad dek valle de Guatemala
Laboratorio 12
Marcos Gutierrez 17909
David Valenzuela 171001
*/

.data
.align 2
msj: .asciz "Ingrese un numero entre 0 y 7:\n"
inputFormat: .asciz "%d"
num: .word 0


.text
.align 2
.global main
.extern wiringPiSetup
.extern digitalWrite
.extern pinMode
main:
	stmfd sp!, {lr}	/* SP = R13 link register */

	@show input message
	ldr r0, =msj
	bl printf

	@load input
	ldr r0, =inputFormat
	ldr r1, =num
	bl scanf

	@Get GPIO address
	bl GetGpioAddress

	/*If equals 0*/
	mov r2, #0
	cmp r1, r2

	@Set function on GPIO 16
	mov r0, #16
	mov r1, #1
	bl SetGpioFunction

	@Turn led off
	mov r0, #16
	mov r1, #0
	bl SetGpio


/* exit code */
exit:
	@OS exit
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr

.data
.align 2
.global myloc
myloc: .word 0

