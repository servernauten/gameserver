#!/bin/bash

NORMAL='\033[0;39m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'

clear

echo
echo -e "\t$BLUE ================================= "
echo -e "\t$BLUE servernauten Install Script V 1.0 "
echo -e "\t$BLUE ================================= "
echo
echo -e "\t$GREEN # Was möchten Sie installieren? "
echo
echo -e "\t$GREEN #$NORMAL Webinterface $GREEN [1] $NORMAL Gameserver $GREEN [2] $NORMAL \c"

read installOptions

if [[ "$installOptions" = "1" ]]; then

# # # Install Webinterface # # #

clear
echo
echo -e "\t$BLUE ======================================= "
echo -e "\t$BLUE servernauten Install Webinterface V 1.0 "
echo -e "\t$BLUE ======================================= $NORMAL"
echo

elif [[ "$installOptions" = "2" ]]; then

clear
echo
echo -e "\t$BLUE ===================================== "
echo -e "\t$BLUE servernauten Install Gameserver V 1.0 "
echo -e "\t$BLUE ===================================== $NORMAL"
echo

# # # Install Sudo # # #
apt install sudo -y

# # # Create User servernauten with random password # # #

# Declare local variables, generate random password.
## Adding sbin to path ##
export PATH="$PATH:/sbin:/usr/sbin:usr/local/sbin"

newuser="servernauten"
randompw=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)

# Create new user and assign random password.

useradd -m $newuser
echo $newuser:$randompw | chpasswd
echo $newuser $randompw > ../superuser.txt
usermod -aG sudo $newuser

clear
echo
echo -e "\t$BLUE Die Superuser Zugangsdaten finden Sie unter $RED /superuser.txt $BLUE - bitte speichern Sie sich die Zugangsdaten lokal ab und löschen Sie die Datei $RED /superuser.txt $BLUE auf dem Server! $NORMAL "
echo

cd /root
rm -rf gameserver
exec bash

fi
