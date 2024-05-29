#!/bin/bash

apt update -y
apt upgrade -y
apt autoremove -y
apt install openssh-server -y

if [[ ! -e .ssh/authorized_keys ]]; then
  mkdir -p .ssh
  wget --no-check-certificate https://192.168.0.5/index.php/download/authorized_keys
  mv authorized_keys .ssh
fi

if [[ ! -e  /usr/bin/serialscale ]]; then
  wget https://github.com/marcodpt/serialscale/releases/download/0.1.2/serialscale-x86_64-unknown-linux-musl
  mv serialscale-x86_64-unknown-linux-musl /usr/bin/serialscale
  chmod ugo+x /usr/bin/serialscale
fi

if [[ ! -e /usr/bin/rawprinter ]]; then
  wget https://github.com/marcodpt/rawprinter/releases/download/0.1.2/rawprinter-x86_64-linux
  mv rawprinter-x86_64-linux /usr/bin/rawprinter
  chmod ugo+x /usr/bin/rawprinter
fi

if [[ ! -e /usr/bin/minirps ]]; then
wget https://github.com/marcodpt/minirps/releases/download/0.1.1/minirps-x86_64-unknown-linux-musl
mv minirps-x86_64-unknown-linux-musl /usr/bin/minirps
chmod ugo+x /usr/bin/minirps
fi

mkdir -p /etc/iot

if [[ ! -e /etc/iot/config.toml ]]; then
  wget https://raw.githubusercontent.com/marcodpt/config/main/iot/config.toml
  mv config.toml /etc/iot/
fi

if [[ ! -e /etc/iot/ssl.crt ]]; then
  wget --no-check-certificate https://192.168.0.5/index.php/download/iot_cert
  mv iot_cert /etc/iot/ssl.crt
fi

if [[ ! -e /etc/iot/ssl.key ]]; then
  wget --no-check-certificate https://192.168.0.5/index.php/download/iot_key
  mv iot_key /etc/iot/ssl.key
fi

if [[ ! -e /etc/rc.local ]]; then
  wget https://raw.githubusercontent.com/marcodpt/config/main/iot/rc.local
  mv "rc.local" "/etc/rc.local"
  chmod ugo+x "/etc/rc.local"
fi

/etc/rc.local &

IP=$(hostname -I)
echo "IP LOCAL: $IP"
