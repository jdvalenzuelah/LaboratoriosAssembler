/*--------------------------------
Universidad del Valle de Guatemala
Manuel Valenzuela 15072
Juan Carlos Solis 15564
principal.s
Laboratorio 2 
--------------------------------*/


.text
 .align 2
 .global main
main:
	@@utilizando la biblioteca GPIO (gpio0_2.s)
	bl GetGpioAddress 

/*-----------------------------------
Configuracion de puertos de Entrada
------------------------------------*/
	
	@@--------------------Salidas/Escrituras--------------------

	@Display 1
	@@GPIO para escritura puerto 2
	mov r0,#2
	mov r1,#1
	bl SetGpioFunction
	@@GPIO para escritura puerto 3
	mov r0,#3
	mov r1,#1
	bl SetGpioFunction
	@@GPIO para escritura puerto 4
	mov r0,#4
	mov r1,#1
	bl SetGpioFunction	
	@@GPIO para escritura puerto 17
	mov r0,#17
	mov r1,#1
	bl SetGpioFunction

	@Display 2---------
	@@GPIO para escritura puerto 22
	mov r0,#22
	mov r1,#1
	bl SetGpioFunction
	@@GPIO para escritura puerto 10
	mov r0,#10
	mov r1,#1
	bl SetGpioFunction
	@@GPIO para escritura puerto 9
	mov r0,#9
	mov r1,#1
	bl SetGpioFunction
	@@GPIO para escritura puerto 11
	mov r0,#11
	mov r1,#1
	bl SetGpioFunction
	@Led indicador de hora ---
	@@GPIO para escritura puerto 21
	mov r0,#21
	mov r1,#1
	bl SetGpioFunction

	
	@@Led inidicador de tiempo 1
	mov r0,#21		@Puerto 20 , como salida 
	mov r1,#1
	bl SetGpioFunction	

	@@Led inidicador de tiempo 2
	mov r0,#20		@Puerto 20 , como salida 
	mov r1,#1
	bl SetGpioFunction
		
	@@led indicador de alarma
	mov r0,#16		@Puerto 16 , como salida 
	mov r1,#1
	bl SetGpioFunction	
	
	@@led indicador de configuracion de alarma 
	mov r0,#18		@Puerto 16 , como salida 
	mov r1,#1
	bl SetGpioFunction	
	
	@@BUzzer
	mov r0,#12		@Puerto 12 , como salida 
	mov r1,#1
	bl SetGpioFunction

	


	@ 	--------------------Configuracion de puertos de Entradas/lectura--------------------------

	@Button subir 
	mov r0,#5  	@Puerto 5 como entrada 
	mov r1,#0 
	bl SetGpioFunction

	@@Button Bajar
	mov r0,#6	@Puerto 6 como entrada 
	mov r1,#0
	bl SetGpioFunction 

	@@Button alternar el tiempo(segundos/minutos)
	mov r0,#13 	@Puerto 13 como entrada
	mov r1,#0
	bl SetGpioFunction 
	
	@@Button Inicio/Stop 
	mov r0,#19	@Puerto 19 como entrada
	mov r1,#0
	bl SetGpioFunction 
	
	
	
	


	@Fin de configuracion de puertos 
	@-=========================================================================================================





	@			Inicio del programa 
	
	@@////////////////////////////////////////////--Tiempo 1 PARA EL RELOJ --///////////////////////////////////////////////////////
	mov r4,#0      @regristro del contador general 
	loop: @(loop para el tiempo en segundos)
		@@Encendemos el indicador de tiempo 1
		mov r0,#21
		mov r1,#1
		bl SetGpio
		@Apagamos  el indicador de tiempo 2 
		mov r0,#20
		mov r1,#0
		bl SetGpio
		@@Apagamos el led indicador de alarma 
		mov r0,#16
		mov r1,#0
		bl SetGpio
		@@Apagamos el led indicador de configuracion de alarma 
		mov r0,#18
		mov r1,#0
		bl SetGpio
		@Descativamos el buzzer 
		mov r0,#12
		mov r1,#0
		bl SetGpio
	
		@Iniciamos el contador en cero
		ldr r6,=cont
		str r4,[r6]




		@@============ control de cotador =================================
		@@Auemtnar el contor Boton subia ---------------------------------
		@r5 lleva el numero de veces que ha pasado por el ciclo, cuando se presiona el boton de subida  

		mov r0,#5	    @Leer el estado del puerto 6 input 
		push {r4,r5,r7}
		bl GetGpio2	    @Subrutina que devuelve el estado del puerto 
		pop {r4,r5,r7}

		cmp r0,#1   	    @ 1 si esta presionado 0 si no esta presioando 
		addeq r5,r5,#1      @ si se presiono entonces que sume en 1 
		movne r5,#0	    @si no esta presionado que  r5 tiene 5 

		cmp r5,#4000	   @800(puede ser una canitdad menor que 1500,para evitar el efecto de rebote del boton 
					@se le coloca una cantidad en medio de ese valor
				   @@con 4000 queda solucionado el problema del error de lectura de push button
		addeq r4,r4,#1     @@que sume 1 si r5 es igula 800
		cmp r4,#61	   @@limite superior,hasta 60 	#####################################################
		moveq r4,#0	   @Si el contador esta en 25, se qeuda en 25 
		ldr r6,=cont		
		str r4,[r6]	   @Guarde el numero presionado en la variable
		@-----------------------------------------------------------------
		

		@Disminuir el contador de boton bajda------------------------------------
		@r7 lleva el numero de veces que ha pasado por el ciclo,cuando se presioan el boton de bajada 
		mov r0,#6	    @Leer el estado del puerto 6 input 
		push {r4,r5,r7}
		bl GetGpio2	    @Subrutina que devuelve el estado del puerto 
		pop {r4,r5,r7}

		cmp r0,#1   	    @@ 1 si esta presionado 0 si no esta presioando 
		addeq r7,r7,#1      @ si se presiono entonces que sume  1 al contador de ciclo 
		movne r7,#0	    @si no esta presionado que  r5 tiene 5 

		cmp r7,#4000	    @800(puede ser una canitdad menor que 1500,para evitar el efecto de rebote del boton 
				    @se le coloca una cantidad en medio de ese valor 
			            @@con 4000 queda solucionado el problema del error de lectura de push button
		subeq r4,r4,#1      @@que sume 1 si r5 es igula 800
		cmp r4,#0	    @@limite inferior	
		movlt r4,#60	    @@si llega  acero the next nums is more bi(60)########################################
		ldr r6,=cont		
		str r4,[r6]	    @Guarde el numero presionado en la variable

		@==============================================================================================================

		@@---------------Mostramos los numeros en los display --------------------------------
		
		@@Separamos el numero del contador en unidades y decenas -----------
		ldr r6,=cont
		ldr r6,[r6]
		mov r0,r6	   @El numero que quearmos separar
		mov r1,#10	   @@ como solo trabajamos hasta decenas 
		bl dividir
		mov r8,r1	   @r1 tiene el numero de la UNIDAD 
		mov r9,r0	   @r0 tiene el numero de la DECENA 

		@Mostramos los numeros en los displays--------------------------------
		push {r4,r5,r7,lr}
		mov r1,r9	   @Valor para el display 2 (decena )
		mov r0,r8	   @Valor para el display 1 (unidad )	
		bl Numeros
		pop {r4,r5,r7,lr}
		


		@Si se presiona el boton alternar ------------------------------------------
		mov r0,#13	   @Leer el estado del puerto 13 input,boton alternar
		push {r4,r5,r7}
		bl GetGpio2	   @Subrutina que devuelve el estado del puerto 
		pop {r4,r5,r7}
		cmp r0,#1
	
		@si se presiona el boton alternar que aguarde el valor en la variable TH1(TIEMPO De horas en segundos)
		ldreq r6,=cont
		ldreq r6,[r6]
		ldreq r8,=th1
		streq r6,[r8]      @se guarda el valor del numero selecionado en la variable t1
		@Inicializamos el contador en cero 
		moveq r4,#0
		beq loop2	   @@si esta presionado que vaya a loop2 
		
	b loop 










	@@////////////////////////////////////////////--Tiempo 2 para el RELOJ--///////////////////////////////////////////////////////

	
	loop2: @@tiempo 2(el tiempo de minutos)
	
		@@Encendemos el indicador de tiempo 2 
		mov r0,#20
		mov r1,#1
		push {r4,r5,r7}
		bl SetGpio
		pop {r4,r5,r7}
		@@Apagamos el indicador de tiempo 1
		mov r0,#21
		mov r1,#0
		push {r4,r5,r7}
		bl SetGpio
		pop {r4,r5,r7}


		
		@@============ control de cotador =================================
		@@Auemtnar el contor Boton subia ---------------------------------
		@r5 lleva el numero de veces que ha pasado por el ciclo, cuando se presiona el boton de subida  

		mov r0,#5	    @Leer el estado del puerto 6 input 
		push {r4,r5,r7}
		bl GetGpio2	    @Subrutina que devuelve el estado del puerto 
		pop {r4,r5,r7}

		cmp r0,#1   	    @ 1 si esta presionado 0 si no esta presioando 
		addeq r5,r5,#1      @ si se presiono entonces que sume en 1 
		movne r5,#0	    @si no esta presionado que  r5 tiene 5 

		cmp r5,#4000	   @800(puede ser una canitdad menor que 1500,para evitar el efecto de rebote del boton 
					@se le coloca una cantidad en medio de ese valor
				   @@con 4000 queda solucionado el problema del error de lectura de push button
		addeq r4,r4,#1     @@que sume 1 si r5 es igula 800
		cmp r4,#25	   @@limite superior,hasta 24	#####################################################
		moveq r4,#0	   @Si el contador esta en 24, se qeuda en 24 
		ldr r6,=cont		
		str r4,[r6]	   @Guarde el numero del contador  presionado en la variable
		@-----------------------------------------------------------------
		

		@Disminuir el contador de boton bajda------------------------------------
		@r7 lleva el numero de veces que ha pasado por el ciclo,cuando se presioan el boton de bajada 
		mov r0,#6	    @Leer el estado del puerto 6 input 
		push {r4,r5,r7}
		bl GetGpio2	    @Subrutina que devuelve el estado del puerto 
		pop {r4,r5,r7}

		cmp r0,#1   	    @@ 1 si esta presionado 0 si no esta presioando 
		addeq r7,r7,#1      @ si se presiono entonces que sume  1 al contador de ciclo 
		movne r7,#0	    @si no esta presionado que  r5 tiene 5 

		cmp r7,#4000	    @800(puede ser una canitdad menor que 1500,para evitar el efecto de rebote del boton 
				    @se le coloca una cantidad en medio de ese valor 
			            @@con 4000 queda solucionado el problema del error de lectura de push button
		subeq r4,r4,#1      @@que sume 1 si r5 es igula 800
		cmp r4,#0	    @@limite inferior	
		movlt r4,#24	    @@si llega  acero the next nums is more bi(24)########################################
		ldr r6,=cont		
		str r4,[r6]	    @Guarde el numero presionado en la variable

		@==============================================================================================================

		@@---------------Mostramos los numeros en los display --------------------------------
		
		@@Separamos el numero del contador en unidades y decenas -----------
		ldr r6,=cont
		ldr r6,[r6]
		mov r0,r6	   @El numero que quearmos separar
		mov r1,#10	   @@ como solo trabajamos hasta decenas 
		bl dividir
		mov r8,r1	   @r1 tiene el numero de la UNIDAD 
		mov r9,r0	   @r0 tiene el numero de la DECENA 

		@Mostramos los numeros en los displays--------------------------------
		push {r4,r5,r7,lr}
		mov r1,r9	   @Valor para el display 2 (decena )
		mov r0,r8	   @Valor para el display 1 (unidad )	
		bl Numeros
		pop {r4,r5,r7,lr}
		
		@------------	-------------------------


		@@Si se presiona el boton inicio
		@Guarda el valor del tiempo 2 en tH2,
		mov r0,#19	   @Leer el estado del puerto 19input,boton inicio/stop
		push {r4,r5,r7}
		bl GetGpio2	   @Subrutina que devuelve el estado del puerto 
		pop {r4,r5,r7}
		cmp r0,#1
		@Si se presiona el boton stop/inicio entonces que guarde el tiempo2 en th2
		ldreq r6,=cont
		ldreq r6,[r6]
		ldreq r8,=th2
		streq r6,[r8]      @se guarda el valor del numero selecionado  en tiempo 2 en la variable th2
		@Inicializamos el contador en cero 
		moveq r4,#0
		beq configurarAlarma 
	b loop2



















	@#@##############################################################################################
	@################################################################################################
	@####################################################################################

	configurarAlarma:
		@@Encendemos el indicador de tiempo 1
		mov r0,#21
		mov r1,#1
		bl SetGpio
		@@Encendemos el indicador de configuracion de alarma 
		mov r0,#18
		mov r1,#1
		bl SetGpio
		
		@Apagamos  el indicador de tiempo 2 
		mov r0,#20
		mov r1,#0
		bl SetGpio
		@@Apagamos el led indicador de alarma 
		mov r0,#16
		mov r1,#0
		bl SetGpio
		@Descativamos el buzzer 
		mov r0,#12
		mov r1,#0
		bl SetGpio
	
		@Iniciamos el contador en cero
		ldr r6,=cont
		str r4,[r6]



	
		@@============ control de cotador =================================
	

		@@Auemtnar el contor Boton subia ---------------------------------
		@r5 lleva el numero de veces que ha pasado por el ciclo, cuando se presiona el boton de subida  

		mov r0,#5	    @Leer el estado del puerto 6 input 
		push {r4,r5,r7}
		bl GetGpio2	    @Subrutina que devuelve el estado del puerto 
		pop {r4,r5,r7}

		cmp r0,#1   	    @ 1 si esta presionado 0 si no esta presioando 
		addeq r5,r5,#1      @ si se presiono entonces que sume en 1 
		movne r5,#0	    @si no esta presionado que  r5 tiene 5 

		cmp r5,#4000	   @800(puede ser una canitdad menor que 1500,para evitar el efecto de rebote del boton 
					@se le coloca una cantidad en medio de ese valor
				   @@con 4000 queda solucionado el problema del error de lectura de push button
		addeq r4,r4,#1     @@que sume 1 si r5 es igula 800
		cmp r4,#61	   @@limite superior,hasta 60 	#####################################################
		moveq r4,#0	   @Si el contador esta en 25, se qeuda en 25 
		ldr r6,=cont		
		str r4,[r6]	   @Guarde el numero presionado en la variable
		@-----------------------------------------------------------------
		

		@Disminuir el contador de boton bajda------------------------------------
		@r7 lleva el numero de veces que ha pasado por el ciclo,cuando se presioan el boton de bajada 
		mov r0,#6	    @Leer el estado del puerto 6 input 
		push {r4,r5,r7}
		bl GetGpio2	    @Subrutina que devuelve el estado del puerto 
		pop {r4,r5,r7}

		cmp r0,#1   	    @@ 1 si esta presionado 0 si no esta presioando 
		addeq r7,r7,#1      @ si se presiono entonces que sume  1 al contador de ciclo 
		movne r7,#0	    @si no esta presionado que  r5 tiene 5 

		cmp r7,#4000	    @800(puede ser una canitdad menor que 1500,para evitar el efecto de rebote del boton 
				    @se le coloca una cantidad en medio de ese valor 
			            @@con 4000 queda solucionado el problema del error de lectura de push button
		subeq r4,r4,#1      @@que sume 1 si r5 es igula 800
		cmp r4,#0	    @@limite inferior	
		movlt r4,#60	    @@si llega  acero the next nums is more bi(60)########################################
		ldr r6,=cont		
		str r4,[r6]	    @Guarde el numero presionado en la variable

		@==============================================================================================================

		@@---------------Mostramos los numeros en los display --------------------------------
		
		@@Separamos el numero del contador en unidades y decenas -----------
		ldr r6,=cont
		ldr r6,[r6]
		mov r0,r6	   @El numero que quearmos separar
		mov r1,#10	   @@ como solo trabajamos hasta decenas 
		bl dividir
		mov r8,r1	   @r1 tiene el numero de la UNIDAD 
		mov r9,r0	   @r0 tiene el numero de la DECENA 

		@Mostramos los numeros en los displays--------------------------------
		push {r4,r5,r7,lr}
		mov r1,r9	   @Valor para el display 2 (decena )
		mov r0,r8	   @Valor para el display 1 (unidad )	
		bl Numeros
		pop {r4,r5,r7,lr}
		


		@Si se presiona el boton alternar ------------------------------------------
		mov r0,#13	   @Leer el estado del puerto 13 input,boton alternar
		push {r4,r5,r7}
		bl GetGpio2	   @Subrutina que devuelve el estado del puerto 
		pop {r4,r5,r7}
		cmp r0,#1
		@si se presiona el boton alternar que aguarde el valor en la variable t1(tiempo en segundos)
		ldreq r6,=cont
		ldreq r6,[r6]
		ldreq r8,=t1
		streq r6,[r8]      @se guarda el valor del numero selecionado en la variable t1
		@Inicializamos el contador en cero 
		moveq r4,#0
		beq loopCA2	   @@si esta presionado que vaya a loop2 
			
		
		
		
	b configurarAlarma







	@@////////////////////////////////////////////--Tiempo 2- para la alarma -///////////////////////////////////////////////////////

	
	loopCA2: @@tiempo 2(el tiempo de minutos)
		
	
		@@Encendemos el indicador de tiempo 2 
		mov r0,#20
		mov r1,#1
		push {r4,r5,r7}
		bl SetGpio
		pop {r4,r5,r7}
		@@Apagamos el indicador de tiempo 1
		mov r0,#21
		mov r1,#0
		push {r4,r5,r7}
		bl SetGpio
		pop {r4,r5,r7}


		
		@@============ control de cotador =================================
		@@Auemtnar el contor Boton subia ---------------------------------
		@r5 lleva el numero de veces que ha pasado por el ciclo, cuando se presiona el boton de subida  

		mov r0,#5	    @Leer el estado del puerto 6 input 
		push {r4,r5,r7}
		bl GetGpio2	    @Subrutina que devuelve el estado del puerto 
		pop {r4,r5,r7}

		cmp r0,#1   	    @ 1 si esta presionado 0 si no esta presioando 
		addeq r5,r5,#1      @ si se presiono entonces que sume en 1 
		movne r5,#0	    @si no esta presionado que  r5 tiene 5 

		cmp r5,#4000	   @800(puede ser una canitdad menor que 1500,para evitar el efecto de rebote del boton 
					@se le coloca una cantidad en medio de ese valor
				   @@con 4000 queda solucionado el problema del error de lectura de push button
		addeq r4,r4,#1     @@que sume 1 si r5 es igula 800
		cmp r4,#25	   @@limite superior,hasta 24	#####################################################
		moveq r4,#0	   @Si el contador esta en 24, se qeuda en 24 
		ldr r6,=cont		
		str r4,[r6]	   @Guarde el numero del contador  presionado en la variable
		@-----------------------------------------------------------------
		

		@Disminuir el contador de boton bajda------------------------------------
		@r7 lleva el numero de veces que ha pasado por el ciclo,cuando se presioan el boton de bajada 
		mov r0,#6	    @Leer el estado del puerto 6 input 
		push {r4,r5,r7}
		bl GetGpio2	    @Subrutina que devuelve el estado del puerto 
		pop {r4,r5,r7}

		cmp r0,#1   	    @@ 1 si esta presionado 0 si no esta presioando 
		addeq r7,r7,#1      @ si se presiono entonces que sume  1 al contador de ciclo 
		movne r7,#0	    @si no esta presionado que  r5 tiene 5 

		cmp r7,#4000	    @800(puede ser una canitdad menor que 1500,para evitar el efecto de rebote del boton 
				    @se le coloca una cantidad en medio de ese valor 
			            @@con 4000 queda solucionado el problema del error de lectura de push button
		subeq r4,r4,#1      @@que sume 1 si r5 es igula 800
		cmp r4,#0	    @@limite inferior	
		movlt r4,#24	    @@si llega  acero the next nums is more bi(24)########################################
		ldr r6,=cont		
		str r4,[r6]	    @Guarde el numero presionado en la variable

		@==============================================================================================================

		@@---------------Mostramos los numeros en los display --------------------------------
		
		@@Separamos el numero del contador en unidades y decenas -----------
		ldr r6,=cont
		ldr r6,[r6]
		mov r0,r6	   @El numero que quearmos separar
		mov r1,#10	   @@ como solo trabajamos hasta decenas 
		bl dividir
		mov r8,r1	   @r1 tiene el numero de la UNIDAD 
		mov r9,r0	   @r0 tiene el numero de la DECENA 

		@Mostramos los numeros en los displays--------------------------------
		push {r4,r5,r7,lr}
		mov r1,r9	   @Valor para el display 2 (decena )
		mov r0,r8	   @Valor para el display 1 (unidad )	
		bl Numeros
		pop {r4,r5,r7,lr}
		
		@------------	-------------------------


		@@Si se presiona el boton inicio
		@Guarda el valor del tiempo 2 en t2
		mov r0,#19	   @Leer el estado del puerto 19input,boton inicio/stop
		push {r4,r5,r7}
		bl GetGpio2	   @Subrutina que devuelve el estado del puerto 
		pop {r4,r5,r7}
		cmp r0,#1
		@Si se presiona el boton stop/inicio entonces que guarde el tiempo2 en t2
		ldreq r6,=cont
		ldreq r6,[r6]
		ldreq r8,=t2
		streq r6,[r8]      @se guarda el valor del numero selecionado  en tiempo 2 en la variable t2
		@Inicializamos el contador en cero 
		moveq r4,#0
		beq ejecutarReloj

	b loopCA2

	
	
	















       @---------------------------------Ejecutar Reloj------------------------------------------!!!!!!!!!!!!!!!!
	ejecutarReloj:
		@@Apagamos el led  indicador de configuracion de alarma 
		mov r0,#18
		mov r1,#0
		bl SetGpio
	
		@@si se toca el boton subir o bajar,no pasa nada
		@@ si se presiona el boton alternar, muestra el tiempo1 o t2
		@Al presionar el boton alternar cambia de opccion  de minutos/segundos------------------------------
		mov r0,#13	   @Leer el estado del puerto 13 input,boton alternar
		push {r4,r5,r7}
		bl GetGpio2	   @Subrutina que devuelve el estado del puerto 
		pop {r4,r5,r7}
		cmp r0,#1
		ldr r6,=opcionAlternar
		str r0,[r6]      @@guardamos el valor del boton en la opccion alternar 

		ldr r6,=opcionAlternar
		ldr r6,[r6]
		cmp r6,#0
		beq tiempo1		@@Si opccion altener es igual a cero,entonces que muestre el th2
		cmp r6,#1
		beq tiempo2		@@Si opccion altener es igual a 1,entonces que muestre el th1

	b ejecutarReloj

	tiempo1:
		@Imprimimos de prueba prueba ---------------
		push {r4,r5}
		ldr r0,=formato
		ldr r1,=th1
		ldr r1,[r1]
		bl printf
		pop {r4,r5}
		@@Encendemos el indicador de tiempo 1
		mov r0,#21
		mov r1,#1
		bl SetGpio
		@Apagamos  el indicador de tiempo 2 
		mov r0,#20
		mov r1,#0
		bl SetGpio
		
		@@Separamos el numero del contador en unidades y decenas --------
		ldr r6,=th1
		ldr r6,[r6]
		mov r0,r6	   @El numero que quearmos separar
		mov r1,#10	   @@ como solo trabajamos hasta decenas 
		bl dividir
		mov r8,r1	   @r1 tiene el numero de la UNIDAD 
		mov r9,r0	   @r0 tiene el numero de la DECENA 
		@Mostramos los numeros en los displays--------------------------------
		push {r4,r5,r7,lr}
		mov r1,r9	   @Valor para el display 2 (decena )
		mov r0,r8	   @Valor para el display 1 (unidad )	
		bl Numeros
		pop {r4,r5,r7,lr}
	
		@@DEALY ----------------------------------------------@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		
		@@Delay para Th1  (Unidad)
		push {r4,r5,r7,lr}
		mov r0,#1    @magnitud del tiempo	
		mov r1,#0    @@Opccion de  segundos
		bl Esperar 
		pop {r4,r5,r7,lr}
		
		ldr r6,=th1
		ldr r6,[r6]
		ldr r9,=th2
		ldr r9,[r9]
		cmp r6,#60
		addlt r6,r6,#1  @va sumar 1 al th1,hasta el numero 60
		moveq r6,#0	@si llega a 60 que inicie t1 inicie de nuevo @###################################base t1 
		addeq r9,r9,#1  @@si las unidades es 60 entonces le suma la decena 
		
		@r6,tiene th1 (unidades)
		@r9,tiene th2 (decena)

		@@Empieza en la hora 1:00, si 
		@@ th1 llega a 60(unidades) y th2(decenas) a 24 entonces 
		cmp r6,#60
		cmpeq r9,#24
		moveq r6,#0
		moveq r9,#1



		@@Verificamos si el tiempo actual es igual al tiempo configurado de la alarma 
		ldr r8,=t1 
		ldr r8,[r8]
		ldr r10,=t2
		ldr r10,[r10]
		@@r8 --->(Unidades de la alarma)
		@@r10----. Decena de la alarma 
		cmp r6,r8
		cmpeq r9,r10
		bleq alarma

		@@guardamos los valores acuales de los tiempos
		ldr r8,=th1
		str r6,[r8]	@Guardamos el valor en th1(segndos)en su variable 
		ldr r10,=th2
		str r9,[r10]	@Guardamos el valor de th2(minutos) en su varaible
			
		@----------------------------------------------@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		b ejecutarReloj
	

	tiempo2:
		@@Encendemos el indicador de tiempo 2 
		mov r0,#20
		mov r1,#1
		push {r4,r5,r7}
		bl SetGpio
		pop {r4,r5,r7}
		@@Apagamos el indicador de tiempo 1
		mov r0,#21
		mov r1,#0
		push {r4,r5,r7}
		bl SetGpio
		pop {r4,r5,r7}
		@@Separamos el numero del contador en unidades y decenas --------
		ldr r6,=th2
		ldr r6,[r6]
		mov r0,r6	   @El numero que quearmos separar
		mov r1,#10	   @@ como solo trabajamos hasta decenas 
		bl dividir
		mov r8,r1	   @r1 tiene el numero de la UNIDAD 
		mov r9,r0	   @r0 tiene el numero de la DECENA 
		@Mostramos los numeros en los displays--------------------------------
		push {r4,r5,r7,lr}
		mov r1,r9	   @Valor para el display 2 (decena )
		mov r0,r8	   @Valor para el display 1 (unidad )	
		bl Numeros
		pop {r4,r5,r7,lr}
	
		@@DEALY ----------------------------------------------@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		
		@@Delay para Th1  (Unidad)
		push {r4,r5,r7,lr}
		mov r0,#1    @magnitud del tiempo	
		mov r1,#0    @@Opccion de  segundos
		bl Esperar 
		pop {r4,r5,r7,lr}
		
		ldr r6,=th1
		ldr r6,[r6]
		ldr r9,=th2
		ldr r9,[r9]
		cmp r6,#60
		addlt r6,r6,#1  @va sumar 1 al th1,hasta el numero 60
		moveq r6,#0	@si llega a 60 que inicie t1 inicie de nuevo @###################################base t1 
		addeq r9,r9,#1  @@si las unidades es 60 entonces le suma la decena 
		
		@r6,tiene th1 (unidades)
		@r9,tiene th2 (decena)

		@@Empieza en la hora 1:00, si 
		@@ th1 llega a 60(unidades) y th2(decenas) a 24 entonces 
		cmp r6,#60
		cmpeq r9,#24
		moveq r6,#0
		moveq r9,#1


		@@Verificamos si el tiempo actual es igual al tiempo configurado de la alarma 
		ldr r8,=t1 
		ldr r8,[r8]
		ldr r10,=t2
		ldr r10,[r10]
		@@r8 --->(Unidades de la alarma)
		@@r10----. Decena de la alarma 
		cmp r6,r8
		cmpeq r9,r10
		beq alarma
		

		@@guardamos los valores acuales de los tiempos
		ldr r8,=th1
		str r6,[r8]	@Guardamos el valor en th1(segndos)en su variable 
		ldr r10,=th2
		str r9,[r10]	@Guardamos el valor de th2(minutos) en su varaible
			
		@----------------------------------------------@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		b ejecutarReloj
			
	
		


	alarma:
		@@Apagamos el indicador de tiempo 1
		push {lr}
		mov r0,#21
		mov r1,#0
		bl SetGpio
		@Apagamos  el indicador de tiempo 2 
		mov r0,#20
		mov r1,#0
		bl SetGpio
		
		
		@@encendemos led indicador de alarma 
		mov r0,#16
		mov r1,#1
		bl SetGpio

		@@encendemos led indicador de configuracion de alarma 
		mov r0,#18
		mov r1,#1
		bl SetGpio
		
		@Acitivamos el buzzer 
		mov r0,#12
		mov r1,#1
		bl SetGpio

		@@se desactiva la alarma hasta que se presione el boton inicio/stop
		mov r0,#19	   @Leer el estado del puerto 19input,boton inicio/stop
		bl GetGpio2	   @Subrutina que devuelve el estado del puerto 
		cmp r0,#1
		beq loop





		pop {lr}
		b alarma 
			
































.data
.align 2
.global myloc
myloc: .word 0


cont:       .word 0 
Unidad: .word 0 
Decena: .word 0 
t1:   .word 0  	@(tiempo  del temporizador en segundos )
t2:   .word 0 	@(tiempo del temporizador  en minutos)
th1:  .word 0	@Tiempo del reloj en segundos
th2:  .word 0 	@Tiempo del reloj en minutos
opcionAlternar: .word 0



formato: .asciz "%d\n"
.end