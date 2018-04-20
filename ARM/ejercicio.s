.data
.align 2
salida: .asciz "Promedio es: %d\n"

.text
.align 2
.global main
.type main,%function

main:
	stmfd sp!,{lr}

	mov r0, #1
	mov r1, #2
	bl promedio


	@Salida
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr

/* Promedio de 2 numeros */
.global promedio
promedio:
	add r0, r0, r1 @Sumamos todos los numeros
	lsr r0, #1 @Dividimos dentro de 2
	push {r0, lr} @Push del resultado y el lr
	mov r1, r0 @Trasladamos el resultado a r1
	ldr r0, =salida @Cargamos en r0 el formaro de salida
	bl printf @Imprimimos el resultado
	pop {r0, lr} @Restauramos los valores de r0 y lr
	mov pc, lr @Retornamos

