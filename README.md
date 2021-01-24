# gameserver

```apt update && apt upgrade -y```

```apt install git -y && git clone https://github.com/servernauten/gameserver.git && cd gameserver && bash ./install.sh ```

phpmyadmin Login: Melden Sie sich in PuTTY mithilfe des Befehls mysql -u root am MariaDB-Server an und führen Sie daraufhin die Befehle CREATE USER 'username'@'localhost' IDENTIFIED BY 'password'; sowie GRANT ALL PRIVILEGES ON *.* TO 'username'@'localhost' WITH GRANT OPTION; aus. Ersetzen Sie hierbei "username" und "password" durch Ihren gewünschten Benutzernamen und ein Passwort. Beenden Sie die MariaDB-Konsole abschließend mit dem Befehl exit. Danach können Sie sich mit dem neu erstellten Benutzer am MariaDB-Server anmelden (z.B. über phpMyAdmin).
