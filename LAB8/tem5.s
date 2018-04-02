/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
Archivo: multiplicacion.s
Programa toma dos numeros en memoria (num1 y num2), multiplica ambos
numeros y muestra el resultado en pantalla.
Autor: David Valenzuela 171001
*/

@Datos
.data
string: .asciz "El resultado es: %d\n" @String a imprimir

/* Funcion main del programa*/
.text
.global main
.extern printf @printf de la libreria de c para imprimir
main:
        push {ip, lr} @ip y lr son añadidos al stack

        ldr r1, =string
        mov r0, pc
        add r0, r0, #0
        bl printf

       /* ldr r0, =x3030
        ldr r1, =x3031
        ldr r2, =x3032*/

        pop {ip, pc} @pop del ip y pc al stack

