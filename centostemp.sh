# !/bin/bash
## This script shows the current CPU temperature in Celsius and Farenheit degrees for a Raspberry Pi running Linux Centos7.

l=1
while [ l=1 ]
do

## This script reads the CPU temperature in a different way comparing with the script for Debian. It reads the sensor temperature directly from the temp file in /sys/devices/virtual/thermal/thermal_zone0
SENSOR=`cat /sys/devices/virtual/thermal/thermal_zone0/temp`

## For floating point calculation, this script calls awk instead of Python.
TEMPC=`awk "BEGIN {print ${SENSOR}/1000}" | cut -c1-4`
TEMPF=`awk "BEGIN {print ${SENSOR}/1000*1.8+32}" | cut -c1-3`
        clear
        echo "               RASPBERRY PI TEMPERATURE INFORMATION                   "
        echo "##################################################################"
        echo "The current CPU temperature of your Raspberry Pi is $TEMPC°C / $TEMPF°F"
        echo "##################################################################"
        echo "                     Press Crtl + C to exit."
## Refresh time 1 second.
        sleep 1
done
clear
