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
salr: .asciz "q"
operando: .asciz "%d"
<<<<<<< HEAD


=======
valor: .word 0
>>>>>>> 6f4ccb39d0e53f52811bb2ea1e9675a61fb9d71d
/*Funcion principal el programa*/
.text
.global main
.align 2
.type main, %function
.extern printf, scanf

main: 
	stmfd sp!, {lr} /*link register*/
entradaNumero: 
	/*
	r2 = almacenamiento de datos
	*/

	@Mostrar el menu
	ldr r0, =menu
	bl printf

	@Entrada de Datos
	ldr r0, =opcion
	ldr r2, =b
	bl scanf

	ldr r1, =suma
	ldr r1, [r1]

	cmp r2, r1




	
	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

suma:
	ldr r4, =a
	ldr r0, [r4]	/*guardamos el valor de a en el registro r4*/
	add r5, r4, r4
	ldr r4, = valor
	str r5, [r4]
