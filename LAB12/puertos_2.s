@ Raspberry 2 probando el ledOK puerto 47
@ Funciona con cualquier puerto, utilizando biblioteca gpio0_2.s

 .text
 .align 2
 .global main
main:
	@utilizando la biblioteca GPIO (gpio0.s)
	bl GetGpioAddress @solo se llama una vez
		
	@GPIO para escritura puerto 47
	mov r0,#16
	mov r1,#1
	bl SetGpioFunction
loop:
	@GPIO 47 apaga el led (apaga puerto> directa)
	mov r0,#16
	mov r1,#0
	bl SetGpio
		
	bl wait
	
	@GPIO 47 enciende el led (enciende puerto> directa)
	mov r0,#47
	mov r1,#0
	bl SetGpio
	
	bl wait
	
	b loop

@ brief pause routine
wait:
 mov r0, #0x4000000 @ big number
sleepLoop:
 subs r0,#1
 bne sleepLoop @ loop delay
 mov pc,lr

 .data
 .align 2
.global myloc
myloc: .word 0

 .end

