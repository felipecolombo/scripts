# !/bin/bash
## This is a very simple shell script wich has no practical use, just for learning reasons. It checks if an username and password input matches with an available user-password .txt file.
clear
echo " Welcome to SYSNET, your Service Provider"
echo "-------------------------------------------"
echo '(Press "q" to abort or any key to continue)'

## Now the script tests if the variable KEY is equal to "q" or "Q". Being true, the program closes.
read KEY
[ "$KEY" = "q" ] || [ "$KEY" = "Q" ] && echo "Goodbye." && exit
clear

## Here I clear the content of the variable KEY, in order to use it later, and to avoid unnecessary data remaining in the memory.
unset $KEY

## Now I put another value inside the same variable KEY.
echo 'Type "no"'" if you don't agree with our Terms and Conditions (available on www.blablablablabla.co.uk),"
echo "or press any key to accept and continue."
read KEY
[ "$KEY" = "no" ] || [ "$KEY" = "No" ] || [ "$KEY" = "NO" ] || [ "$KEY" = "nO" ] && clear && echo "Access denied. You can't log in without accepting the Terms and Conditions." && exit
unset $KEY
clear
echo "Thank you very much for accepting our Terms and Conditions. You have chosen the best Internet Service Provider of the United Kingdom."
echo "We are very glad to have you as customer."
echo "Please type your username: "
read USERNAME
echo "Please type your password: "

## Hides user input by using the option -s for the read command.
read -s PASSWORD
clear

## Puts the username and password inside the variable CHECK, in order to compare it with an available user-password file. The usernames and passwords are in the "username-password" format.
CHECK="$USERNAME-$PASSWORD"

## Clear both variables.
unset $USERNAME
unset $PASSWORD

## The variable RESULT reads the userpass.txt file and compares the given username and password from the customer.
RESULT=$(grep $CHECK userpass.txt)
[ "$CHECK" != "$RESULT" ] && echo "Unfortunately you are not able to access the system. Please check your username and password. Goodbye." && exit
clear
echo "CONGRATULATIONS, IT WORKS!!"
exit
