#This file contains the two functions needed for moving the servo
import RPi.GPIO as GPIO
import time

def lockDoor():
    GPIO.setmode(GPIO.BOARD)
    GPIO.setup(11,GPIO.OUT)
    servo = GPIO.PWM(11,50)
    
    servo.start(0)
    
    servo.ChangeDutyCycle(12)
    time.sleep(0.5)
    servo.ChangeDutyCycle(0)
    
    servo.stop()
    GPIO.cleanup()

def unlockDoor():
    GPIO.setmode(GPIO.BOARD)
    GPIO.setup(11,GPIO.OUT)
    servo = GPIO.PWM(11,50)
    
    servo.start(0)
    
    servo.ChangeDutyCycle(2)
    time.sleep(0.5)
    servo.ChangeDutyCycle(0)
    
    servo.stop()
    GPIO.cleanup()