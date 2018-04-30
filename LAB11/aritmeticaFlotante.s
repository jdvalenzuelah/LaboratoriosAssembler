/* aritmeticaFlotante.s Operaciones aritmeticas con float */
/* Autor: Martha L. Naranjo 18/07/2016*/
	
	.global main
	.func main
main:
	
	LDR R1, addr_value1		@ Get addr of value1
	VLDR S14, [R1]			@ Move value1 into S14
	VCVT.F64.F32 D5, S14	@ Convert to B64
	
	LDR R1, addr_value2		@ Get addr of value1
	VLDR S15, [R1]			@ Move value1 into S14
	VCVT.F64.F32 D6, S15	@ Convert to B64
	
	VADD.F64 D0,D5,D6		@ Add: result in D0
	VSUB.F64 D1,D5,D6		@ Sub: result in D1
	VDIV.F64 D2,D5,D6		@ Div: result in D2
	VMUL.F64 D3,D5,D6		@ Mul: result in D3

	LDR R0, =suma			@ point R0 to suma
	VMOV R2, R3, D0			@ Load value
	BL printf				@ call function
	
	LDR R0, =rest			@ point R0 to add
	VMOV R2, R3, D1			@ Load value
	BL printf				@ call function
	
	LDR R0, =mult			@ point R0 to mult
	VMOV R2, R3, D3			@ Load value
	BL printf				@ call function
	
	LDR R0, =divi			@ point R0 to divi
	VMOV R2, R3, D2			@ Load value
	BL printf				@ call function
	
	MOV R7, #1				@ Exit Syscall
	SWI 0

addr_value1:  
	.word value1
addr_value2:
	.word value2

	.data
value1:	.float 1.54321
value2: .float 7.89434
string:	.asciz "Floating point value is: %f\n"
fnum:	.asciz "%f"
men:	.asciz "\nIngrese numero: "
suma:	.asciz "\n**Suma: %f **\n"
rest:	.asciz "\n**Resta: %f **\n"
mult:	.asciz "\n**Mult: %f **\n"
divi:	.asciz "\n**Division: %f **\n"

