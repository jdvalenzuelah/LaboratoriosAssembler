/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
*/

/* ---------------- Datos con lo que se trabajara ---------------- */
.data
.align 2

/* Formatos para ingreso de datos */
menu: .asciz "1. para suma \n	2. para resta \n	3. para multiplicacion \n	3. para mostrar el resultado almacenado \n	4. salir del programa\nIngrese una opcion a trabjar:"
formatoEntrada: .asciz "%d"
/* Valores almacenados */
opcionSeleccionada: .asciz "%d"
prueba: .asciz "\n %d \n"
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



	

	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

/* --------------------------------------------------------------- */