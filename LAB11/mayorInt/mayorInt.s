/**********************************************************************
Universidad del Valle de Guatemala
Authors: Josue David Valenzuela 171001
		 Marcos Gutierrez	    17909
**********************************************************************/

.text
.align 2
/**
 * Calcular el numero mayor de tres numeros
 * Param: r0 - r2 numeros enteros de 32 bits
 * Return: El numero mayor en r0
*/
.global mayorInt
mayorInt:
	cmp r0, r1 @Compare num1 and num2
	@Mov the bigger number to r5
	movgt r5, r0
	movlt r5, r1
	moveq r5, r0
	cmp r5, r2 @Compare r5 with num3
	movgt r5, r2 @Only if it is biger r5 value changes
	mov r0, r5 @Move the max value to r0
	mov pc, lr