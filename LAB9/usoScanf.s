@  x = (a + b) - c
@  entrada de datos con scanf

	@@ codigo de assembler: se coloca en la seccion .text
	.text
	.align		2
	@@ etiqueta "main" llama a la funcion global
	.global		main
	.type		main, %function
main:
	@@ grabar registro de enlace en la pila
	stmfd	sp!, {lr}

	ldr r0,=mensaje_ingreso
	bl puts
	
	@ ingreso de datos
	@ r0 contiene formato de ingreso
	@ r1 contiene direccion donde almacena dato leido
	ldr r0,=entrada
	ldr r1,=a
	bl scanf
	
	@ imprime lo que recibio
	ldr r0,=entrada
	ldr r1,=a
	ldr r1,[r1]
	bl printf
	
	@@ calculos
	ldr r4,=a
	ldr r0,[r4]		/* direccion y valor de a en R0*/
	ldr r4,=b
	ldr r1,[r4]		/* direccion y valor de b en R1*/
	add r3,r0,r1	/* r3 <- a + b */
	ldr r4,=c
	ldr r0,[r4]		/* direccion y valor de c */
	sub r3,r3,r0	/* r3 <- r3 - c */
	ldr r4,=x
	str r3,[r4]		/* guarda resultado en x */
	
	@@ carga resultado y lo muestra
	ldr r0,=Lmessage
	bl printf
	ldr r4,=x
	ldr r1,[r4]		/* direccion y valor de x */
	ldr r0,=formato
	bl printf
	
	@@ r0, r3 <- 0 como sennal de no error al sistema operativo
	mov	r3, #0
	mov	r0, r3

	@ colocar registro de enlace para desactivar la pila y retorna al SO
	ldmfd	sp!, {lr}
	bx	lr
.data
.align 2

a:	.word 0
b:	.word 6
c:	.word 1
x: 	.word 0

Lmessage:
	.asciz "Calculo de x=(a+b)-c --> "
formato:
	.asciz " %d\n"
entrada:
	.asciz " %d"
mensaje_ingreso:
	.asciz "Ingrese dato: "
