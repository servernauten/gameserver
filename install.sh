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
echo -e "\t$GREEN #$NORMAL Webinterface $GREEN [1] $NORMAL Gameserver $GREEN [2] $NORMAL Imageserver $GREEN [3] $NORMAL \c"

read installOptions

if [[ "$installOptions" = "1" ]]; then

# # # Install Webinterface # # #

clear
echo
echo -e "\t$BLUE ======================================= "
echo -e "\t$BLUE servernauten Install Webinterface V 1.0 "
echo -e "\t$BLUE ======================================= $NORMAL"
echo

# # # Install Software # # #
apt update -y
apt upgrade -y
apt install ca-certificates apt-transport-https lsb-release gnupg curl nano unzip -y
apt install software-properties-common -y
add-apt-repository ppa:ondrej/php -y
apt update -y
apt install apache2 -y
apt install php7.4 php7.4-cli php7.4-common php7.4-curl php7.4-gd php7.4-intl php7.4-json php7.4-mbstring php7.4-mysql php7.4-opcache php7.4-readline php7.4-xml php7.4-xsl php7.4-zip php7.4-bz2 libapache2-mod-php7.4 php7.4-fpm php7.4-ssh2 -y
apt install mariadb-server mariadb-client -y
mysql_secure_installation
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip
unzip phpMyAdmin-latest-all-languages.zip
rm phpMyAdmin-latest-all-languages.zip
mv phpMyAdmin-* /usr/share/phpmyadmin/
chmod -R 0755 /usr/share/phpmyadmin
cp phpmyadmin.conf /etc/apache2/conf-available/phpmyadmin.conf
a2enconf phpmyadmin
a2enconf php7.4-fpm
systemctl reload apache2
mkdir /usr/share/phpmyadmin/tmp/
chown -R www-data:www-data /usr/share/phpmyadmin/tmp/
chown -R www-data:www-data /var/www/html/


cd /root
rm -rf gameserver 
exec bash
    
elif [[ "$installOptions" = "2" ]]; then

clear
echo
echo -e "\t$BLUE ===================================== "
echo -e "\t$BLUE servernauten Install Gameserver V 1.0 "
echo -e "\t$BLUE ===================================== $NORMAL"
echo

# # # Install Software # # #
apt update -y
apt install sudo -y
apt install openjdk-11-jre-headless -y
apt-get install screen –y
apt-get install rsync

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
chsh -s /bin/bash servernauten

# Create Folder #

mkdir /home/servernauten/gameserver && chown -cR servernauten:servernauten /home/servernauten/gameserver
mkdir /home/servernauten/mods && chown -cR servernauten:servernauten /home/servernauten/mods
mkdir /home/servernauten/images && chown -cR servernauten:servernauten /home/servernauten/images

clear
echo
echo -e "\t$NORMAL[$GREEN✓$NORMAL] openjdk-11-jre-headless "
echo -e "\t$NORMAL[$GREEN✓$NORMAL] screen "
echo
echo -e "\t$BLUE Die Superuser Zugangsdaten finden Sie unter $RED superuser.txt $BLUE - bitte speichern Sie sich die Zugangsdaten lokal ab und löschen Sie die Datei $RED superuser.txt $BLUE auf dem Server! $NORMAL "
echo

cd /root
rm -rf gameserver 
exec bash

elif [[ "$installOptions" = "3" ]]; then

# # # Install Webinterface # # #

clear
echo
echo -e "\t$BLUE ======================================= "
echo -e "\t$BLUE servernauten Install Imageserver V 1.0 "
echo -e "\t$BLUE ======================================= $NORMAL"
echo

# # # Install Software # # #
apt update -y
apt install sudo -y
apt-get install rsync

# # # Create User imageserver with random password # # #

# Declare local variables, generate random password.
## Adding sbin to path ##
export PATH="$PATH:/sbin:/usr/sbin:usr/local/sbin"

newuser="imageserver"
randompw=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)

# Create new user and assign random password.

useradd -m $newuser
echo $newuser:$randompw | chpasswd
echo $newuser $randompw > ../imageserver.txt
usermod -aG sudo $newuser
chsh -s /bin/bash imageserver

# Read User #
useradd -g imageserver -s /bin/false -d /home/imageserver imageuser

# Copy rsyncd.conf in /etc/rsyncd.conf #

cp rsyncd.conf /etc/rsyncd.conf

# Rsync Restart #

/etc/init.d/rsync restart

# Create imageserver Folder #

mkdir /home/imageserver/masteraddons/
mkdir /home/imageserver/mastermaps/
mkdir /home/imageserver/masterserver/
find /home/imageserver/mastermaps/ /home/imageserver/masteraddons/ -type f -exec chmod 640 {} \;
find /home/imageserver/mastermaps/ /home/imageserver/masteraddons/ -type d -exec chmod 750 {} \;
find /home/imageserver/masterserver/ -type d -exec chmod 750 {} \;
find /home/imageserver/masterserver/ -type f -name "srcds_*" -o -name "hlds_*" -o -name "*.run" -o -name "*.sh" -exec chmod 750 {} \;
find /home/imageserver/masterserver/ -type f ! -perm -750 ! -perm -755 -exec chmod 640 {} \;
chown -cR imageserver:imageserver /home/imageserver/masteraddons/
chown -cR imageserver:imageserver /home/imageserver/mastermaps/
chown -cR imageserver:imageserver /home/imageserver/masterserver/

fi
