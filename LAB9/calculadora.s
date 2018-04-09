/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
*/

/* Datos con lo que se trabajara */
.data
.align 2

a: .asciz "%s"
b: .asciz "%d"

/* Formatos para ingreso de datos */
menu: .asciz "Ingrese una opcion a trabjar: \n	+ para suma \n	- para resta \n	* para multiplicacion \n	= para mostrar el resultado almacenado \n	q salir del programa\n"
opcion: .asciz "%s"
operando: .asciz "%d"
prueba: .asciz "Igual"
/* Operandos */
suma: .asciz "+"
resta: .asciz "-"
multiplicacion: .asciz "*"
salir: .asciz "q"

valor: .word 0

/*Funcion principal el programa*/
.text
.global main
.align 2
.type main, %function
.extern printf, scanf


/* Funcion para suma de datos*/
sumar:
	ldr r4, adrvalor
	ldr r4, [r4]
	add r6, r4, r5
	str r4, [r6]
	b main


main: 
	stmfd sp!, {lr} /*link register*/

	ldr r0, =menu
	bl printf

	@Seleccion de opcion del programa
	ldr r0, =a
	ldr r1, =opcion
	bl scanf

<<<<<<< HEAD
	ldr r0, =opcion
	bl printf
	
=======
	ldr r1, =operando

	ldr r0, =suma
	cmp r0, r1
	ldreq r0, =menu
	bleq printf

>>>>>>> f80c8b0578eeb1a83c5745d2c53abe494ce0e790
	/* Opcion para salir */
	ldr r0, =salir
	cmp r1, r0
	ldreq r0, =prueba
	bleq printf
	@beq salida @Salir del programa

	/* Opcion para suma */
	ldr r0, =sum
	cmp r1, r0
	ldreq r0, =prueba
	bleq printf

	/*
	ldreq r0, =operando
	ldreq r5, =b
	bleq scanf
	beq sumar*/
<<<<<<< HEAD

=======
	
>>>>>>> f80c8b0578eeb1a83c5745d2c53abe494ce0e790
salida:
	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

adrvalor: .word valor
