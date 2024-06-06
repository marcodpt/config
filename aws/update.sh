#!/bin/bash

echo "***** UPDATE *****"

for DB in "$@"
do
  /home/ubuntu/config/scripts/backup.sh -c -d /home/ubuntu/backup $DB /home/ubuntu/backup/.mysql
  /home/ubuntu/config/scripts/clean.sh -m 2 -d /home/ubuntu/backup $DB
done

certbot renew
apt update
apt upgrade -y
apt autoremove -y

reboot
