import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(16, GPIO.OUT)
GPIO.setup(20, GPIO.OUT)
GPIO.setup(21, GPIO.OUT)

num = input("Ingrese un numero entre 0 y 7")

if(num == 0):
	GPIO.output(16, GPIO.HIGH)
	GPIO.output(20, GPIO.HIGH)
	GPIO.output(21, GPIO.HIGH)
elif(num == 1):
	GPIO.output(16, GPIO.HIGH)
	GPIO.output(20, GPIO.HIGH)
	GPIO.output(21, GPIO.LOW)
elif(num == 2):
	GPIO.output(16, GPIO.HIGH)
	GPIO.output(20, GPIO.LOW)
	GPIO.output(21, GPIO.HIGH)
elif(num == 3):
	GPIO.output(16, GPIO.LOW)
	GPIO.output(20, GPIO.LOW)
	GPIO.output(21, GPIO.HIGH)
elif(num == 4):
	GPIO.output(16, GPIO.LOW)
	GPIO.output(20, GPIO.HIGH)
	GPIO.output(21, GPIO.HIGH)
elif(num == 5):
	GPIO.output(16, GPIO.LOW)
	GPIO.output(20, GPIO.HIGH)
	GPIO.output(21, GPIO.LOW)
elif(num == 6):
	GPIO.output(16, GPIO.LOW)
	GPIO.output(20, GPIO.LOW)
	GPIO.output(21, GPIO.HIGH)
elif(num == 7):
	GPIO.output(16, GPIO.LOW)
	GPIO.output(20, GPIO.LOW)
	GPIO.output(21, GPIO.LOW)

time.sleep(2)
GPIO.output(16, GPIO.HIGH)
GPIO.output(20, GPIO.HIGH)
GPIO.output(21, GPIO.HIGH)
