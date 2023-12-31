#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Necessario ser usuario root" 2>&1
  exit 1
fi

apt update -y
apt upgrade -y
apt autoremove -y

wget https://github.com/marcodpt/toledo/releases/download/0.1.1/toledo-x86_64-unknown-linux-musl
mv toledo-x86_64-unknown-linux-musl /usr/bin/toledo
chmod ugo+x /usr/bin/toledo

wget https://github.com/marcodpt/rawprinter/releases/download/0.1.2/rawprinter-x86_64-linux
mv rawprinter-x86_64-linux /usr/bin/rawprinter
chmod ugo+x /usr/bin/rawprinter

wget https://github.com/marcodpt/minirps/releases/download/0.1.1/minirps-x86_64-unknown-linux-musl
mv minirps-x86_64-unknown-linux-musl /usr/bin/minirps
chmod ugo+x /usr/bin/minirps

mkdir -p /opt/iot

wget https://raw.githubusercontent.com/marcodpt/config/main/iot/config.toml
mv config.toml /opt/iot/

wget --no-check-certificate https://192.168.0.5/index.php/download/iot_cert
mv iot_cert /opt/iot/ssl.crt

wget --no-check-certificate https://192.168.0.5/index.php/download/iot_key
mv iot_key /opt/iot/ssl.key

wget https://raw.githubusercontent.com/marcodpt/config/main/iot/rc.local
mv "rc.local" "/etc/rc.local"
chmod ugo+x "/etc/rc.local"

rawprinter --vendor-id 0x0a5f --device-id 0x000a &
toledo /dev/ttyUSB0 --lang pt --unit Kg --min-weight 0.01 &
minirps -f /opt/iot/config.toml &
