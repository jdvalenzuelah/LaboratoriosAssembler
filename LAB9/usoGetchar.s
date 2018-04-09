@   Uso de getchar

	@@ codigo de assembler: se coloca en la seccion .text
	.text
	.align		2
	@@ etiqueta "main" llama a la funcion global
	.global		main
	.type		main, %function
main:
	@@ grabar registro de enlace en la pila
	stmfd	sp!, {lr}

	@ Muestra cadena de ingreso
	ldr r0,=Lmessage
	bl puts
	
	@ lee caracter en R0, se graba en car1
	bl getchar
	ldr r1,=car1
	str r0,[r1]
	
	@ Muestra caracter ingresado
	ldr r0,=letra
	ldr r4,=car1
	ldr r1,[r4]
	bl printf

	@@ r0, r3 <- 0 como sennal de no error al sistema operativo
	mov	r3, #0
	mov	r0, r3

	@ colocar registro de enlace para desactivar la pila y retorna al SO
	ldmfd	sp!, {lr}
	bx	lr
.data
.align 2

car1:	.byte ' '

Lmessage:
	.asciz "Ingrese un caracter:"
letra:
	.asciz "Caracter ingresado: %c\n"

