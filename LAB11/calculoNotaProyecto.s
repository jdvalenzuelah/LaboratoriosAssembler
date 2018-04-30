
.data
.align 2
test: .asciz "Prueba: %f\n"

/**
 * r0 - r3 contiene la direccion del valor float
*/
.text
.global calculoNotaProyecto
calculoNotaProyecto:
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
	@mov r5, #61
	@vmov s4, r5
	vcvt.F64.F32 d9, #61
	@Sumamos todos los valores
	vadd.F64 d5, d5, d6
	vadd.F64 d5, d5, d7
	vadd.F64 d5, d5, d8
	@Encontramos cuanto falta para llegar a 61
	vsub.F64 d4, d9, d5
	ldr r0, =test
	vmov r2, r3, d9
	bl printf
	
	
	@Guardamos el resultado en la direccion de r0
	pop {lr}
	mov pc, lr @Return r0
