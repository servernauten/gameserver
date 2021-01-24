# gameserver

```apt update && apt upgrade -y```

```apt install git -y && git clone https://github.com/servernauten/gameserver.git && cd gameserver && bash ./install.sh ```

Maria DB

Bei der ersten Abfrage des aktuellen Passworts müssen Sie nichts eingeben, sondern einfach die Enter-Taste drücken. Bestätigen Sie die nächste Frage bzgl. der Änderung des Root-Passworts mit Enter. Nun müssen Sie ein Passwort für den Root-Benutzer des MariaDB-Servers vergeben. Während der Eingabe erscheinen keine Zeichen, das ist jedoch normal. Bestätigen Sie alle darauffolgenden Fragen (Löschung des anonymen Benutzers, Verbieten des externen Root-Logins aus Sicherheitsgründen, Entfernen der Testdatenbank und Aktualisieren der Rechte) ebenfalls mit Enter. Danach ist der MariaDB-Server fertig installiert und konfiguriert.

phpmyadmin Login: 

Melden Sie sich in PuTTY mithilfe des Befehls 

```mysql -u root```

am MariaDB-Server an und führen Sie daraufhin die Befehle 

```CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';``` 

sowie 

```GRANT ALL PRIVILEGES ON *.* TO 'username'@'localhost' WITH GRANT OPTION;```

aus. Ersetzen Sie hierbei "username" und "password" durch Ihren gewünschten Benutzernamen und ein Passwort. Beenden Sie die MariaDB-Konsole abschließend mit dem Befehl exit. Danach können Sie sich mit dem neu erstellten Benutzer am MariaDB-Server anmelden (z.B. über phpMyAdmin).
