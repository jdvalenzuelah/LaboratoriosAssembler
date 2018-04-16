/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
autor: David Valenzuela				171001
autor: Juan Jose Navas
*/

/*.data
.align 2
mensaje: .asciz "Ingrese nombre en minusculas (Maximo 10 caracteres, y sin espacios en blaco)\n"
formatoEntrada: .string "%s"
nombre: .string "%s"
resultado: .asciz " "

.text
.global main
.extern printf

main:
	stmfd sp!, {lr}	/* SP = R13 link register */

	/* Imprimimos inicio del porgrama */
	/*ldr r0, =mensaje
	bl printf

	/* Entrada de datos */
	/*ldr r0, =formatoEntrada
	ldr r1, =nombre
	bl scanf


	ldr r5, =nombre
	ldr r0, =formatoEntrada
	ldrb r1, [r5], #1
	bl printf */








	/* salida correcta */
	/*mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	/* bx lr */

	

You're working with bytes; there are NO alignment issues. You're also forgetting to increment your counter and comparing with the wrong register. Here's a working solution:

;   r0  is a pointer to msg1  
;   r1  used to store the value of val  
;   r2  used to compare a character in msg1  
;   r3  counter for the number of comparisons  

.text  
.global _start  
_start:  
        ldr r1, =val  
        ldr r0, =msg  
        ldrb r1, [r1]  
        mov r3, #0  

loop:   ldrb r2, [r0],#1  
        cmp r2, #0  
        beq done  
        cmp r2, r1  
        addeq r3,r3,#1  
        b loop  
done:  
        swi 0x11  

.data  
msg:    .asciz  "How many 'a's are in this string?"  
val:    .byte   'a'  
.end  



