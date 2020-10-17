#!/bin/bash

clear

echo
echo -e "\t\033[1;34m ================================= \033[0m"
echo -e "\t\033[1;34m servernauten Install Script V 1.0 \033[0m"
echo -e "\t\033[1;34m ================================= \033[0m"
echo
echo -e "\t\033[1;32m # \033[0m Was möchten Sie installieren? \033[0m \c"
echo
echo -e "\t\033[1;32m # \033[0m Webinterface\033[1;32m[1]\033[0m Gameserver\033[1;32m[2]\033[0m \c"

read installOptions

if [[ "$installOptions" = "1" ]]; then

# # # Install Webinterface # # #

clear
echo
echo -e "\t\033[1;34m ======================================= \033[0m"
echo -e "\t\033[1;34m servernauten Install Webinterface V 1.0 \033[0m"
echo -e "\t\033[1;34m ======================================= \033[0m"
echo

elif [[ "$installOptions" = "2" ]]; then

clear
echo
echo -e "\t\033[1;34m ===================================== \033[0m"
echo -e "\t\033[1;34m servernauten Install Gameserver V 1.0 \033[0m"
echo -e "\t\033[1;34m ===================================== \033[0m"
echo

# # # Install Sudo # # #
apt install sudo -y

# # # Create User servernauten with random password # # #

# Declare local variables, generate random password.

newuser="servernauten"
randompw=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)

# Create new user and assign random password.

useradd -m $newuser
echo $newuser:$randompw | chpasswd
echo $newuser $randompw > superuser.txt
usermod -aG sudo servernauten

fi
