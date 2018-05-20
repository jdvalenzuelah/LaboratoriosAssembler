/*
Programa contiene las subrutinas necesarias para el funcionamiento de la alarma
*/

.text
.align 2

/* 
Subrutina para controlar los displays de 7 segmentos
Pines display 1 utilizando BCD:
	GPIO 02 --> 1000 A
	GPIO 03 --> 0100 B
	GPIO 04 --> 0010 C
	GPIO 17 --> 0001 D
Pines display 2 utilizando BCD:
	GPIO 22 --> 1000 A
	GPIO 10 --> 0100 B
	GPIO 09 --> 0010 C
	GPIO 11 --> 0001 D

Args:
	r0: Numero en display 1 (Unidades)
	r1: Numero en display 2 (Decenas)

*/
.global numeros
numeros:
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

/*
Subrutina es un delay para n cantidad de segundos
	
	Args:
		r0: n cantidad de segundos a esperar
*/
.global reloj
reloj:
	@Cargamos numero grande (un segundo)
	ldr r8, =delayReg
	ldr r8, [r8]
	@Contador de repeticiones
	mov r10, #0
	/* Ciclo tarda aproximadamente un segundo */
	cicloSegundos:
		mov r7, #0
		b comparar
		/* while(r7 != 596700000){ r7++ }*/
		loop:
			add r7, #1
		comparar:
			cmp r7, r8
			bne loop
		add r10, r10, #1 @r10++
		/* if(r10 != r0) { cicloSegundos } else { terminarEspera } */
		cmp r10, r0
		bne cicloSegundos
		b terminarEspera
	terminarEspera:
		mov pc,lr

	

.data
.balign 4
delayReg:.word 596700000 @Un Segundo



