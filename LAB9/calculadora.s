/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
*/

/* ---------------- Datos con lo que se trabajara ---------------- */
.data
.align 2

/* Formatos para ingreso de datos */
menu: .asciz "Ingrese una opcion a trabjar: \n	+ para suma \n	- para resta \n	* para multiplicacion \n	= para mostrar el resultado almacenado \n	q salir del programa\n"
formatoEntrada: .asciz "%s"

/* Valores almacenados */
opcionSeleccionada: .asciz "%s"
prueba: .asciz "Succesful"
/* --------------------------------------------------------------- */

/*  ------------------ Funcion main del programa ----------------- */
.text
.global main
.extern printf @printf de la libreria de c para imprimir
main:
	stmfd sp!, {lr}	/* SP = R13 link register */

	/* Imprimimos el menu */
	ldr r0, =menu @Cargamos el menu a r0
	bl printf @Imprimimos el menu

	/* Pedimos la opcion al usuario */
	ldr r0, =formatoEntrada @Formato de ingreso
	ldr r1, =opcionSeleccionada @Guardamos la opcion en memoria
	bl scanf

	/* Opcion suma */
	ldr r0, =opcionSeleccionada
	ldr r0, [r0]
	cmp r0, #'+'
	ldreq r0, =prueba
	bleq printf



	

	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

/* --------------------------------------------------------------- */