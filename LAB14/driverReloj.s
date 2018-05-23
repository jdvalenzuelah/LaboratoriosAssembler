/*
Programa contiene las subrutinas necesarias para el funcionamiento de la alarma
David Valenzuela 171001
Fernando Hengstenber 17699
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
.global segundos
segundos:
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

/*
Subrutina para la division de dos numeros enteros de la forma A/B

	Args:
		r0: numero A
		r1: numero B

	Returns:
		r0: Resultado de A/B
		r1: Residuo de A/B
*/
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

/*
Subrutinas para obtener el digito de decenas y unidades de un numero entre 0 y 99

Args:
	r0: numero entre 0 y 99

Returns:
	r0: Digito de las unidades entre 0 y 9
	r1: Digito de las decenas entre 0 y 9
	** En caso de numero invalido se retorna 0 en ambos registros **
*/
.global getDigits
getDigits:
	/* Obtenemos los casos posibles */
	cmp r0, #0
	ble ceros
	cmp r0, #9
	ble underTen
	cmp r0, #99
	ble digits
	/* 9 < n < 99 */
	digits:
		push {lr}
		mov r1, #10
		bl dividir
		/* r1 tiene numero de la unidad, r0 el de la decena. Los cambiamos */
		mov r9, r0 @r9 = r0
		mov r0, r1 @r0, = r1
		mov r1, r9 @r1 = r9
		pop {lr}
		b exit
	/* Numero menor a 10 */
	underTen:
		@r0 ya tiene las unidades, decenas = 0
		mov r1, #0
		b exit
	/* Error unidadees y decenas = 0 */
	ceros:
		mov r0, #0
		mov r1, #0
		b exit
	exit:
		mov pc, lr



/******************************************************************************
*	gpio.s
*	 by Alex Chadwick
*
*	A sample assembly code implementation of the ok04 operating system.
*	See main.s for details.
*
*	gpio.s contains the rountines for manipulation of the GPIO ports.
******************************************************************************/

/* NEW
* According to the EABI, all method calls should use r0-r3 for passing
* parameters, should preserve registers r4-r8,r10-r11,sp between calls, and 
* should return values in r0 (and r1 if needed). 
* It does also stipulate many things about how methods should use the registers
* and stack during calls, but we're using hand coded assembly. All we need to 
* do is obey the start and end conditions, and if all our methods do this, they
* would all work from C.
*/

/* NEW
* GetGpioAddress returns the base address of the GPIO region as a physical address
* in register r0.
* C++ Signature: void* GetGpioAddress()
*/
.global GetGpioAddress
GetGpioAddress:
	gpioAddr .req r0
	push {lr}
	@ldr gpioAddr,=0x20200000
	ldr gpioAddr,=0x3F200000 @GPIO base para raspberry 2
	@modificaciones para utilizar la memoria virtual
	bl phys_to_virt
 	mov r7, r0  @ r7 points to that physical page
 	ldr r6, =myloc
 	str r7, [r6] @ save this 
	pop {pc}
	.unreq gpioAddr

/* NEW
* SetGpioFunction sets the function of the GPIO register addressed by r0 to the
* low  3 bits of r1.
* C++ Signature: void SetGpioFunction(u32 gpioRegister, u32 function)
*/
.global SetGpioFunction
SetGpioFunction:
    pinNum .req r0
    pinFunc .req r1
	cmp pinNum,#53
	cmpls pinFunc,#7
	movhi pc,lr

	push {lr}
	mov r2,pinNum
	.unreq pinNum
	pinNum .req r2
	@bl GetGpioAddress no se llama la funcion sino
	ldr r6, =myloc
 	ldr r0, [r6] @ obtener direccion 	
	gpioAddr .req r0

	functionLoop$:
		cmp pinNum,#9
		subhi pinNum,#10
		addhi gpioAddr,#4
		bhi functionLoop$

	add pinNum, pinNum,lsl #1
	lsl pinFunc,pinNum

	mask .req r3
	mov mask,#7					/* r3 = 111 in binary */
	lsl mask,pinNum				/* r3 = 11100..00 where the 111 is in the same position as the function in r1 */
	.unreq pinNum

	mvn mask,mask				/* r3 = 11..1100011..11 where the 000 is in the same poisiont as the function in r1 */
	oldFunc .req r2
	ldr oldFunc,[gpioAddr]		/* r2 = existing code */
	and oldFunc,mask			/* r2 = existing code with bits for this pin all 0 */
	.unreq mask

	orr pinFunc,oldFunc			/* r1 = existing code with correct bits set */
	.unreq oldFunc

	str pinFunc,[gpioAddr]
	.unreq pinFunc
	.unreq gpioAddr
	pop {pc}

/* NEW
* SetGpio sets the GPIO pin addressed by register r0 high if r1 != 0 and low
* otherwise. 
* C++ Signature: void SetGpio(u32 gpioRegister, u32 value)
*/
.global SetGpio
SetGpio:	
    pinNum .req r0
    pinVal .req r1

	cmp pinNum,#53
	movhi pc,lr
	push {lr}
	mov r2,pinNum	
    .unreq pinNum	
    pinNum .req r2
	@bl GetGpioAddress no se llama la funcion sino
	ldr r6, =myloc
 	ldr r0, [r6] @ obtener direccion 
    gpioAddr .req r0

	pinBank .req r3
	lsr pinBank,pinNum,#5
	lsl pinBank,#2
	add gpioAddr,pinBank
	.unreq pinBank

	and pinNum,#31
	setBit .req r3
	mov setBit,#1
	lsl setBit,pinNum
	.unreq pinNum

	teq pinVal,#0
	.unreq pinVal
	streq setBit,[gpioAddr,#40]
	strne setBit,[gpioAddr,#28]
	.unreq setBit
	.unreq gpioAddr
	pop {pc}

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

.data
.balign 4
delayReg:.word 596700000 @Un Segundo



