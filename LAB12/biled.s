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
input:
	@show input message
	ldr r0, =msj
	bl printf

	@get input
	ldr r0, =inputFormat
	ldr r1, =num
	bl scanf

	@Load input value
	valor .req r5
	ldr valor, =num
	ldr valor, [valor]

	/* Comapre all the possible values */
	@load pin variables
	pin16 .req r6
	pin20 .req r7
	pin21 .req r8
	@Case 0
	cmp valor, #0
	moveq pin16, #1
	moveq pin20, #1
	moveq pin21, #1
	beq encenderLEDS
	@Case 1
	cmp valor, #1
	moveq pin16, #1
	moveq pin20, #1
	moveq pin21, #0
	beq encenderLEDS
	@case 2
	cmp valor, #2
	moveq pin16, #1
	moveq pin20, #0
	moveq pin21, #1
	beq encenderLEDS
	@case 3
	cmp valor, #3
	moveq pin16, #1
	moveq pin20, #0
	moveq pin21, #0
	beq encenderLEDS
	@case 4
	cmp valor, #4
	moveq pin16, #0
	moveq pin20, #1
	moveq pin21, #1
	beq encenderLEDS
	@case 5
	cmp valor, #5
	moveq pin16, #0
	moveq pin20, #1
	moveq pin21, #0
	beq encenderLEDS
	@case 6
	cmp valor, #6
	moveq pin16, #0
	moveq pin20, #0
	moveq pin21, #1
	beq encenderLEDS
	@case 7
	cmp valor, #7
	moveq pin16, #0
	moveq pin20, #0
	moveq pin21, #0
	beq encenderLEDS

encenderLEDS:
	@Get GPIO address
	bl GetGpioAddress

	@Set function on GPIO 16, 20, 21
	mov r0, #16
	mov r1, #1
	bl SetGpioFunction
	mov r0, #20
	mov r1, #1
	bl SetGpioFunction
	mov r0, #21
	mov r1, #1
	bl SetGpioFunction

	@Turn LEDS on
	mov r0, #16
	mov r1, pin16
	bl SetGpio
	mov r0, #20
	mov r1, pin20
	bl SetGpio
	mov r0, #21
	mov r1, pin21
	bl SetGpio




/* exit code */
exit:
	.unreq pin16
	.unreq pin20
	.unreq pin21
	@OS exit
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr

.data
.align 2
.global myloc
myloc: .word 0
