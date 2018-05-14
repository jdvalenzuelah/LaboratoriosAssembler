#import RPi.GPIO as GPIO

#Configurar los pines como saldia
#GPIO.setmode(GPIO.BCM)
#GPIO.setwarnings(False)
#GPIO.setup(16, GPIO.OUT)
#GPIO.setup(20, GPIO.OUT)
#GPIO.setup(21, GPIO.OUT)

#Comenzamos con todos apagados
#GPIO.output(16, GPIO.LOW)
#GPIO.output(20, GPIO.LOW)
#GPIO.output(21, GPIO.LOW)

#Inciamos un contador
cont = 0

while(cont < 4):
	#Simulamos el presionar un boton
	input("Presione una tecla")
	cont += 1
	if(cont == 1):
		#GPIO.output(16, GPIO.HIGH)
		#GPIO.output(20, GPIO.LOW)
		#GPIO.output(21, GPIO.LOW)
		print("100")
	if(cont == 2):
		#GPIO.output(16, GPIO.LOW)
		#GPIO.output(20, GPIO.HIGH)
		#GPIO.output(21, GPIO.LOW)
		print("010")
	if(cont == 3):
		#GPIO.output(16, GPIO.LOW)
		#GPIO.output(20, GPIO.HIGH)
		#GPIO.output(21, GPIO.LOW)
		print("001")
		cont = 0

