/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
*/

/* Datos con lo que se trabajara */
.data
.align 2

a: .word 0

/* Formatos para ingreso de datos */
menu: .asciz "Ingrese una opcion a trabjar: \n	+ para suma \n	- para resta \n	* para multiplicacion \n	= para mostrar el resultado almacenado \n	q salir del programa\n"
opcion: .asciz "%s"
suma: .asciz "+"
resta: .asciz "-"
multiplicacion: .asciz "*"
salir: .asciz "q"
operando: .asciz "%d"
valor: .word 0

/*Funcion principal el programa*/
.text
.global main
.align 2
.type main, %function
.extern printf, scanf



main: 
	stmfd sp!, {lr} /*link register*/

/* Funcion para suma de datos*/
sumar:
	ldr r4, =a
	ldr r0, [r4]	/*guardamos el valor de a en el registro r4*/
	add r5, r4, r4
	ldr r4, = valor
	str r5, [r4]

	/*
	r2 = almacenamiento de datos
	*/

	@Mostrar el menu
	ldr r0, =menu
	bl printf

	@Seleccion de opcion del programa
	ldr r0, =opcion
	ldr r1, =b
	bl scanf

	/* Opcion para salir */
	ldr r0, =salir
	ldr r1, [r1]
	cmp r1, r0
	beq salida @Salir del programa

	/* Opcion para suma */
	ldr r0, =suma
	ldr r1, =b
	bl scanf
	cmp r1, r0
	beq sumar





	
salida:
	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

