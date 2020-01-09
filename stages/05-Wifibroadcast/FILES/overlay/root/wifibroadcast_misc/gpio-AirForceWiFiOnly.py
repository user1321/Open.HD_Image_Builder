#!/usr/bin/python

import RPi.GPIO as GPIO
import sys

GPIO.setmode(GPIO.BCM)
GPIO.setup(5, GPIO.IN, pull_up_down=GPIO.PUD_UP)

input_state0 = GPIO.input(5)

# True = not connected, False = connected to GND
if (input_state0 == False):
    print ('Force to boot to WiFi only mode via GPIO5')
    sys.exit(1)
else:
    sys.exit(0)
