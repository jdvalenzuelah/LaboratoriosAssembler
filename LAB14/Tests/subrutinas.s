/*--------------------------------
Universidad del Valle de Guatemala
Manuel Valenzuela 15072
Juan Carlos Solis 15564
subrutinas.s
Laboratorio 2 
--------------------------------*/

/*
Subrutina Numeros
Descripcion: Coloca los numeros en los displays
Entradas:
@r0 ---> numero display 1 (unidades)
@@r1---> numero display 2 (decenas

Registros:
r10 --> bit 3 1000
r9  --> bit 2 0100
r8  --> bit 1 0010
r7	--> bit 0 0001
*/
.global Numeros

Numeros:
	mov r10,#0
	mov r9,#0
	mov r8,#0
	mov r7,#0
	mov r5,#0

	
@Miramos que numero se ingreso para el display 1 
@Comparamos si es 0
cmp r0,#0
beq cero
@Comparamos si es 1
cmp r0,#1
beq uno
@Comparamos si es 2
cmp r0,#2
beq dos
@Comparamos si es 3
cmp r0,#3
beq tres
@Comparamos si es 4
cmp r0,#4
beq cuatro
@Comparamos si es 5
cmp r0,#5
beq cinco
@Comparamos si es 6
cmp r0,#6
beq seis
@Comparamos si es 7
cmp r0,#7
beq siete
@Comparamos si es 8
cmp r0,#8
beq ocho
@Comparamos si es 9
cmp r0,#9
beq nueve

cero:
mov r10,#0
mov r9, #0
mov r8, #0
mov r7, #0
cmp r5,#0
beq dis1
bne dis2 

uno:
mov r10,#0
mov r9, #0
mov r8, #0
mov r7, #1
cmp r5,#0
beq dis1
bne dis2 



dos:
mov r10,#0
mov r9, #0
mov r8, #1
mov r7, #0
cmp r5,#0
beq dis1
bne dis2 


tres:
mov r10,#0
mov r9, #0
mov r8, #1
mov r7, #1
cmp r5,#0
beq dis1
bne dis2 



cuatro:
mov r10,#0
mov r9, #1
mov r8, #0
mov r7, #0
cmp r5,#0
beq dis1
bne dis2 


 
cinco:
mov r10,#0
mov r9, #1
mov r8, #0
mov r7, #1
cmp r5,#0
beq dis1
bne dis2 

 
seis:
mov r10,#0
mov r9, #1
mov r8, #1
mov r7, #0
cmp r5,#0
beq dis1
bne dis2 

 
siete:
mov r10,#0
mov r9, #1
mov r8, #1
mov r7, #1
cmp r5,#0
beq dis1
bne dis2 


 
ocho:
mov r10,#1
mov r9, #0
mov r8, #0
mov r7, #0
cmp r5,#0
beq dis1
bne dis2 

 
nueve:
mov r10,#1
mov r9, #0
mov r8, #0
mov r7, #1
cmp r5,#0
beq dis1
bne dis2 


@Vemos el numero de Display
@cmp r0,#2
@beq dis2
 
dis1:
	/*-----------------------------
	Encendemos Display 1 (Unidades)
	Pines:
	GPIO 02 --> 1000 A
	GPIO 03 --> 0100 B
	GPIO 04 --> 0010 C
	GPIO 17 --> 0001 D
	-----------------------------*/
	push {r0,r1,r7,r8,r9,r10,lr}
	mov r0,#2
	mov r1,r7
	bl SetGpio
	pop {r0,r1,r7,r8,r9,r10,lr}
	
	push {r0,r1,r7,r8,r9,r10,lr}
	mov r0,#3
	mov r1,r8
	bl SetGpio
	pop {r0,r1,r7,r8,r9,r10,lr}
	
	push {r0,r1,r7,r8,r9,r10,lr}
	mov r0,#4
	mov r1,r9
	bl SetGpio
	pop {r0,r1,r7,r8,r9,r10,lr}
	
	push {r0,r1,r7,r8,r9,r10,lr}
	mov r0,#17
	mov r1,r10
	bl SetGpio
	pop {r0,r1,r7,r8,r9,r10,lr}

	mov r5,#1

	b decena




decena:	
	mov r10,#0
	mov r9,#0
	mov r8,#0
	mov r7,#0
	
	
	
	@Miramos que numero se ingreso para el display 2
	@Comparamos si es 0
	cmp r1,#0
	beq cero
	@Comparamos si es 1
	cmp r1,#1
	beq uno
	@Comparamos si es 2
	cmp r1,#2
	beq dos

	@Comparamos si es 3
	cmp r1,#3
	beq tres
	@Comparamos si es 4
	cmp r1,#4
	beq cuatro
	@Comparamos si es 5
	cmp r1,#5
	beq cinco
	@Comparamos si es 6
	cmp r1,#6
	beq seis
	@Comparamos si es 7
	cmp r1,#7
	beq siete
	@Comparamos si es 8
	cmp r1,#8
	beq ocho
	@Comparamos si es 9
	cmp r1,#9
	beq nueve




dis2:
	/*
	Encendemos Display 2 (Decenas)
	Pines:
	GPIO 22 --> 1000 A
	GPIO 10 --> 0100 B
	GPIO 09 --> 0010 C
	GPIO 11 --> 0001 D
	*/
	
	mov r0,#22
	mov r1,r7
	push {lr}
	bl SetGpio
	pop {lr}
	
	mov r0,#10
	mov r1,r8
	push {lr}
	bl SetGpio
	pop {lr}
	
	mov r0,#9
	mov r1,r9
	push {lr}
	bl SetGpio
	pop {lr}

	mov r0,#11
	mov r1,r10
	push {lr}
	bl SetGpio
	pop {lr}

	b terminar


terminar:
mov pc,lr









@**************************************************************************
@**************************************************************************
@**************************************************************************

/*-----------------------------------------
Subrutina GetGpio
Entradas: 
r0 --> numero de puerto
Salidas:
r0 = 1 si el puerto esta en High
r0 = 0 si el puerto esta en Low

Nota: Se utiliza la variable global myloc
------------------------------------------*/

.global GetGpio

GetGpio:
@Recibimos en r0 el numero de pin

/*-------------------------------------
Revisamos si el pin esta en High o Low
--------------------------------------*/
ldr r6, =myloc
ldr r6,[r6] @obtener direccion
ldr r5,[r6,#0x34]
mov r7,#1
lsl r7,r0 	@ponemos 1 en el bit del puerto que queremos comparar
@Comparamos
and r5,r7 
teq r5,#0
movne r0,#1 @Si el pin esta en High regresamos un 1
moveq r0,#0 @Si el pin esta en Low  regresamos un 0

mov pc,lr 


.global GetGpio2
@@/////////////////Subrutina prueba getGPIO
GetGpio2:
	@R0 recibe el numero de puerto	
	@R1,devuelve el estado del puerto 
	mov r1,r0
        ldr r6, =myloc
 	ldr r0, [r6] @ obtener direccion 
	ldr r5,[r0,#0x34]
	mov r7,#1
	@lsl r7,#5
	lsl r7,r1
	and r5,r7 

	teq r5,#0
	moveq r0,#0
	movne r0,#1
	
	mov pc,lr






















@-----------------------------------------------------------------------
@********************************************************
@ division.s
@ Autor: Martin L. Guzman
@ Fecha: 30/07/2015
@ Curso: CC4010 Taller de Assembler
@ Contiene rutina para division
@********************************************************


@ *************************************************************
@Subrutina que realiza una division entre 2 numeros (A/B)
@Parametros:
@  r0: numero 1 (A)
@  r1: numero 2 (B)
@Retorna:
@  r0: resultado
@  r1: residuo
@ *************************************************************
.global dividir
dividir:
    push {lr}

    @ reiniciamos los valores de los registros donde iran los resultados
    mov r2, #0
    mov r3, r0 @asignamos el residuo como A
    
    inicio_div:
        cmp r3,r1
        blt fin_div     @terminar ya que B es mas grande que el residuo
        sub r3,r3,r1    @residuo = residuo-B 
        add r2,r2,#1    @resultado = resultado+1
        b inicio_div
    fin_div:

    mov r0, r2
    mov r1, r3

    pop {pc}
    




/*----------------------#############################################################
Subrutina para esperar
Entradas: 
r0 --> valor
r1 = 0 segundos
r1 = 1 minutos
r1 = 2 horas
Registros:
r8  --> Numero Grande (1 segundo Aprox.)
r10 --> contador
----------------------*/
.global Esperar
Esperar:

ldr r8,=delayReg
ldr r8,[r8]

@Vemos si debemos esperar segundos, minutos u horas
cmp r1,#0
beq segundos
cmp r1,#1
beq minutos
cmp r1,#2
beq horas

segundos:
	mov r10,#0
	cicloSegundos:

	mov r7,#0
    	b compare
	loop:
    	add r7,#1     //r7++
	compare:
    	cmp r7,r8     //test r7 == r0
   		bne loop

   	add r10,r10,#1
   	cmp r10,r0
   	bne cicloSegundos
b terminarEspera

minutos:
	mov r10,#0
	ldr r9,=sesenta
	ldr r9,[r9]
	mul r0,r0,r9
	cicloMinutos:

	mov r7,#0
    	b compare1
	loop1:
    	add r7,#1     //r7++
	compare1:
    	cmp r7,r8     //test r7 == r0
   		bne loop1

   	add r10,r10,#1
   	cmp r10,r0
   	bne cicloMinutos
b terminarEspera


horas:
	mov r10,#0
	ldr r9,=dosmil
	ldr r9,[r9]
	mul r0,r0,r9
	cicloHoras:

	mov r7,#0
    	b compare2
	loop2:
    	add r7,#1     //r7++
	compare2:
    	cmp r7,r8     //test r7 == r0
   		bne loop2

   	add r10,r10,#1
   	cmp r10,r0
   	bne cicloHoras

terminarEspera:
mov pc,lr

.data
.balign 4
delayReg:.word 596700000 @Un Segundo
sesenta: .word 60	@Para tardar minutos
dosmil:	 .word 2400 @Para tardar horas

