/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler

*/

/* Datos con los que se trabajara */
.data
stringH: .asciz "Numero de hombres: %d\n"
stringM: .asciz "Numero de Mujeres: %d\n"
persona1: .word 1
persona2: .word 2
persona3: .word 2


/* FUNCION PRINCIPAL DEL PROGRAMA */
.text
.global main
.extern printf
main:
	stmfd sp!, {lr}	/* SP = R13 link register */

	/* Inicializacion de registros */
	ldr r0, =stringH @Formato a imprimir
	mov r1, #0 @Contador de genero
	ldr r2, dirp1 @persona1
	ldr r3, dirp2 @persona2
	ldr r4, dirp3 @persona3
	ldr r3, [r3]
	ldr r4, [r4]
	ldr r2, [r2] 
	mov r5, #0

	/* Contador de hombres */
	cmp r2, #2 @Si r2 es hombre (r2 == 2)
	moveq r5, #1 @Sumamos 1 al contador
	add r1, r5 @Sumamos uno al conteo de hombres
	mov r5, #0 @Reseteamos el contador

	cmp r3, #2 @Si r2 es hombre (r3 == 2)
	moveq r5, #1 @Sumamos 1 al contador
	add r1, r5 @Sumamos uno al conteo de hombres
	mov r5, #0 @Reseteamos el contador

	cmp r4, #2 @Si r2 es hombre (r4 == 2)
	moveq r5, #1 @Sumamos 1 al contador
	add r1, r5 @Sumamos uno al conteo de hombres
	mov r5, #0 @Reseteamos el contador
	bl printf @Imprimimos numero de hombres

	ldr r0, =stringM
	rsb r1, r1, #3 @Numero de mujeres = 3 - numero de hombres
	bl printf @Imprimimos numero de mujeres


	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

.dirp1: .word persona1
.dirp2: .word persona2
.dirp3: .word persona3
