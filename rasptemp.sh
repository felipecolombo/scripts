# !/bin/bash

#Read the CPU temperature and voltage of a Raspberry Pi every second, and sends an e-mail by CPU overheating.

clear
n=1

#Message colours
RED='\033[0;31m'
BLUE='\033[1;34m'
NC='\033[0m'

#While loop
while [ n=1 ]
do
	#Read the CPU temperature, cutting of the unnecessary text and returning only the numeric value.
	TEMPC=$(vcgencmd measure_temp | cut -c6-9)
	
	#Read the system date and time.
	DATE=$(date)
	
	#Converts Celsius to Farenheit degrees, using python.
	TEMPF=$(python -c "print $TEMPC*1.8+32" | cut -c1-3)

	#Read CPU voltage.
	VOLT=$(vcgencmd measure_volts | cut -c6-8)

	#Shows system uptime.
	UPTIME=$(uptime -p)
	echo "CPU temperature is $TEMPC°C / $TEMPF°F"
	echo "CPU voltage is $VOLT volts"
	echo "The system is $UPTIME long"

	#Shows a warning message on the screen and sends an e-mail to a given address, through a sSMTP relay.
	if [ "$TEMPF" -gt 121 ] #Modify the value after "-gt" in order to change the temperature (Farenheit degrees).
	then 
		printf "${RED}!!!!! WARNING - CPU OVERHEATING !!!!!${NC}\n"
		echo "CPU Temperature $TEMPC°C / $TEMPF°F, please check the CPU usage and running applications. System time $DATE." | mail -s "CPU OVERHEATING" some_address@example.com
	fi
	
	echo "----------------------"
	printf "${BLUE}Press Ctrl + C to exit${NC}\n"

#Modify the sleep time to change the update frequency; very frequent updates may cause overheating
sleep 1
clear
done
