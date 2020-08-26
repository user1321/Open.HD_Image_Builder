#!/usr/bin/python

import RPi.GPIO as GPIO
import os
import time
import sys
import subprocess

GPIO.setmode(GPIO.BCM)
GPIO.setup(23, GPIO.IN, pull_up_down=GPIO.PUD_UP)

# True = not connected, False = connected to GND
while True:
    if GPIO.input(23) == False:
        print ('RPi shutdown....')
        command = "/usr/bin/sudo /sbin/shutdown -h now"
        subprocess.Popen(command.split(), stdout=subprocess.PIPE)
        sys.exit(0)
    time.sleep(1)
