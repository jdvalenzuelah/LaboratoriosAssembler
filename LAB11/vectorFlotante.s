/* Printing a floating point number */
	
	.global main
	.func main
main:
	
	ldr r0,=fnum	@ingresa numero 1
	ldr r1,=num1
	bl scanf

	ldr r0,=fnum	@ingresa numero 1
	ldr r1,=num1	
	add r1,r1,#4
	bl scanf

	ldr r1,=num1
	ldr r1,[r1]
	vmov s15,r1
	vcvt.f64.f32 d5,s15
	vmov r2,r3,d5
	ldr r0,=string
	bl printf

	ldr r1,=num1
	add r1,r1,#4
	ldr r1,[r1]
	vmov s15,r1
	vcvt.f64.f32 d5,s15
	vmov r2,r3,d5
	ldr r0,=string
	bl printf
	
	MOV R7, #1		@ Exit Syscall
	SWI 0

addr_value1:  
	.word value1

	.data
value1:	.float 1.54321
string:	.asciz "Floating point value is: %f\n"
fnum:	.asciz "%f"
num1: 	.word 0, 0

