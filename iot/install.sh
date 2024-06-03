#!/bin/bash

apt update -y
apt upgrade -y
apt autoremove -y
apt install openssh-server -y
apt install chromium-browser -y

mkdir -p .ssh
wget --no-check-certificate https://192.168.0.5/index.php/download/authorized_keys
mv authorized_keys .ssh/
sed -i 's/#PasswordAuthentication no/PasswordAuthentication no/g' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
service ssh restart

wget https://github.com/marcodpt/serialscale/releases/download/0.1.2/serialscale-x86_64-unknown-linux-musl
mv serialscale-x86_64-unknown-linux-musl /usr/bin/serialscale
chmod ugo+x /usr/bin/serialscale

wget https://github.com/marcodpt/rawprinter/releases/download/0.1.2/rawprinter-x86_64-linux
mv rawprinter-x86_64-linux /usr/bin/rawprinter
chmod ugo+x /usr/bin/rawprinter

wget https://github.com/marcodpt/minirps/releases/download/0.1.1/minirps-x86_64-unknown-linux-musl
mv minirps-x86_64-unknown-linux-musl /usr/bin/minirps
chmod ugo+x /usr/bin/minirps

mkdir -p /etc/iot

wget https://raw.githubusercontent.com/marcodpt/config/main/iot/config.toml
mv config.toml /etc/iot/

wget --no-check-certificate https://192.168.0.5/index.php/download/iot_cert
mv iot_cert /etc/iot/ssl.crt

wget --no-check-certificate https://192.168.0.5/index.php/download/iot_key
mv iot_key /etc/iot/ssl.key

wget https://raw.githubusercontent.com/marcodpt/config/main/iot/startup.sh
mv "startup.sh" "/etc/iot/startup.sh"
chmod ugo+x "/etc/iot/startup.sh"

wget https://raw.githubusercontent.com/marcodpt/config/main/iot/rc.local
mv "rc.local" "/etc/rc.local"
chmod ugo+x "/etc/rc.local"

/etc/iot/startup.sh

IP=$(hostname -I)
echo "IP LOCAL: ssh {user}@$IP"
echo "IOT LOGS REBOOT: cat /etc/iot/startup.log"
