/*
Universidad del Valle de Guatemala
Organizacion de computadoras y assembler
autor: David Valenzuela				171001
autor: Marcos Gutierrez				17909
*/

/* ---------------- Datos con lo que se trabajara ---------------- */
.data
.align 2

/* Formatos para ingreso y salida de datos */
menu: .asciz "	1. para suma \n	2. para resta \n	3. para multiplicacion \n	3. para mostrar el resultado almacenado \n	4. Mostrar resultado. \n	5. salir del programa\nIngrese una opcion a trabjar: "
mensajeOperando: .asciz "Ingrese un numero: "
mensajeResultado: .asciz "El resultado es: %d\n\n"
mensajeOpcionInvalida: .asciz "Ingrese una opcion valida\n\n"
formatoEntrada: .asciz "%d"


/* Valores almacenados */
opcionSeleccionada: .word 0
valor: .word 0
operando: .word 0

/* --------------------------------------------------------------- */

/*  ------------------ Funcion main del programa ----------------- */
.text
.global main
.extern printf @printf de la libreria de c para imprimir

@Funcion de suma
suma:
	ldr r5, =opcionSeleccionada @Cargamos direccion de opcionSeleccionada
	mov r6, #0 @Iniciamos r6 en 0
	str r6, [r5] @Reseteamos el valor de opcionSeleccionada

	ldr r0, =valor @Direccion del valor
	ldr r1, [r0] @Cargamos valor a r1
	ldr r2, =operando @Cargamos direccion de operando a r2
	ldr r2, [r2] @Cargamos valor a r2
	add r1, r1, r2 @r1 = r1 + r2
	str r1, [r0] @valor = r1
	b resultado @regresmaos al main

@Funcion de resta
resta:
	ldr r5, =opcionSeleccionada @Cargamos direccion de opcionSeleccionada
	mov r6, #0 @Iniciamos r6 en 0
	str r6, [r5] @Reseteamos el valor de opcionSeleccionada

	/* Aca va la resta*/
	ldr r0, = valor /*direccionamos el valor al r0*/
	ldr r1, [r0] @Cargamos valor a r1
	ldr r2, =operando /*Cargamos direccion de operando a r2*/ 
	ldr r2, [r2] /*cargamos el valor de r2*/
	cmp r2, r1 /*ciclo para evitar numeros negativos*/    
	rsb r1, r2, r1 /*r1 = r1-r2*/
	str r1, [r0]
	b resultado @Mostramos el resultado

@Funcion para la multiplicacion
multiplicacion:
	ldr r5, =opcionSeleccionada @Cargamos direccion de opcionSeleccionada
	mov r6, #0 @Iniciamos r6 en 0
	str r6, [r5] @Reseteamos el valor de opcionSeleccionada

	/* Aca va la multiplicacion*/
	ldr r0, = valor /*direccionamos el valor al r0*/
	ldr r1, [r0] @Cargamos valor a r1
	ldr r2, =operando /*Cargamos direccion de operando al r2*/
	ldr r2, [r2] @Cargamos el valor del operando
	mul r1, r2, r1 /* r1 = r2 * r1 */
	str r1, [r0] /*valor de r1*/
	b resultado @Mostramos el resultado

@Funcion para mostrar el resultado
resultado:
	ldr r5, =opcionSeleccionada @Cargamos direccion de opcionSeleccionada
	mov r6, #0 @Iniciamos r6 en 0
	str r6, [r5] @Reseteamos el valor de opcionSeleccionada
	ldr r0, =mensajeResultado @Mensaje de Resultado
	ldr r1, =valor @Cargamos valor
	ldr r1, [r1]
	bl printf @Imprimimos el valor
	b main @Mostramos el resultado

@Funcion de opcion invalida
invalida:
	ldr r5, =opcionSeleccionada @Cargamos direccion de opcionSeleccionada
	mov r6, #0 @Iniciamos r6 en 0
	str r6, [r5] @Reseteamos el valor de opcionSeleccionada
	ldr r0, =mensajeOpcionInvalida
	bl printf
	b main

main:
	stmfd sp!, {lr}	/* SP = R13 link register */


	/* Imprimimos el menu */
	ldr r0, =menu @Cargamos el menu a r0
	bl printf @Imprimimos el menu

	/* Pedimos la opcion al usuario */
	ldr r0, =formatoEntrada @Formato de ingreso
	ldr r1, =opcionSeleccionada @Guardamos la opcion en memoria
	bl scanf

	/* Cargamos la opcion seleccionada */
	ldr r0, =opcionSeleccionada
	ldr r0, [r0]

	/* Opcion de suma */
	cmp r0, #1 @Comparacion con opcion
	@Pedimos Operando
	ldreq r0, =mensajeOperando
	bleq printf @Imprimimos mensaje
	ldreq r0, =formatoEntrada
	ldreq r1, =operando
	bleq scanf @Guardamos el valor
	beq suma @Vamos a la funcion ingresada

	/* Opcion de resta */
	cmp r0, #2 @Comparacion con opcion
	@Pedimos Operando
	ldreq r0, =mensajeOperando
	bleq printf @Imprimimos mensaje
	ldreq r0, =formatoEntrada
	ldreq r1, =operando
	bleq scanf @Guardamos el valor
	beq resta @Vamos a la funcion ingresada

	/* Opcion de multiplicacion */
	cmp r0, #3 @Comparacion con opcion
	@Pedimos Operando
	ldreq r0, =mensajeOperando
	bleq printf @Imprimimos mensaje
	ldreq r0, =formatoEntrada
	ldreq r1, =operando
	bleq scanf @Guardamos el valor
	beq multiplicacion @Vamos a la funcion ingresada

	/* Mostrar el resultado */
	cmp r0, #4
	beq resultado

	/* Salir */
	cmp r0, #5
	bne invalida

	popeq {ip, pc} @pop del ip y pc al stac

/* --------------------------------------------------------------- */