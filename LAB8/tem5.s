/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
Archivo: tem5.s
Autor: David Valenzuela 171001
*/

@Datos
.data
string: .asciz "EL resultado es: %d\n"
num1: .word 7
num2: .word -1
num3: .word -5 

/* Funcion main del programa*/
.text
.global main
.extern printf @printf de la libreria de c para imprimir
main:
	

        push {ip, lr} @ip y lr son añadidos al stack

        /*Cargamos los datos*/
        ldr r0, =string
        ldr r2, adrn1 @num1
        ldr r3, adrn2 @num2
        ldr r4, adrn3 @num3
        ldr r2, [r2] @num1
        ldr r3, [r3] @num2
        ldr r4, [r4] @num3
        mov r1, #0 @Contador numeros negativos
        mov r5, #0 @Numero actual

        /*Operaciones*/

        cmp r2, #0 @if (r2 <= 0)
        movle r5, #1 @ r5 = 1
        movgt r5, #0 @ else: r5 = 0
        add r1, r1, r5 @ r1 = r1 + r5

        cmp r3, #0 @if (r3 <= 0)
        movle r5, #1 @r5 = 1
        movgt r5, #0 @else: r5 = 0
        add r1, r5 @r1 = r1 + r5

        cmp r4, #0 @if(r4 <= 0)
        movle r5, #1@r5 = 1
        movgt r5, #0 @else: r5 = 0
        add r1, r5 @r1 = r1 +r5

        bl printf @Imprimir el resultado

        pop {ip, pc} @pop del ip y pc al stack

/* Direcciones de los datos*/
adrn1: .word num1
adrn2: .word num2
adrn3: .word num3
