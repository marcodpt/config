#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
fi

apt update
apt upgrade -y
apt autoremove -y
apt install mysql-server -y

# mysql
# UPDATE mysql.user SET host = '%' WHERE user = 'root';
# ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
# exit

# sudo vi /etc/mysql/my.cnf
#
# add the following lines:
# [mysqld]
# bind-address=0.0.0.0
# default_authentication_plugin= mysql_native_password
#
# sudo systemctl restart mysql

# on localserver
# sudo vim /etc/phpmyadmin/config.inc.php

apt install apache2 -y
apt install php -y
apt install php-mysql -y
apt install php-curl -y
apt install php-json -y
apt install php-cgi -y
apt install php-soap -y
apt install php-zip -y
apt install php-xml -y
apt install libapache2-mod-php -y
apt install certbot -y 

if [ ! -f /usr/local/bin/composer ]; then
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
fi

# Add at the end of file: /etc/apache2/apache2.conf
#
# ServerName budi
#
# <Directory /var/www/html>
#         Options Indexes FollowSymLinks
#         AllowOverride All
#         Require all granted
# </Directory>
#
# Then run on terminal:
# sudo service apache2 restart


# echo "<?php phpinfo(); ?>" > /var/www/html/info.php

# certbot --apache
# 0 2 * * 6 certbot renew
# 0 0 * * 0 (apt update && apt upgrade -y && apt autoremove -y && reboot) > /home/ubuntu/update.log
