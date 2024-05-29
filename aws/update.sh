#!/bin/bash

echo "***** UPDATE *****" > /home/ubuntu/update.log

for DB in "$@"
do
  /home/ubuntu/config/scripts/backup.sh -d /home/ubuntu/backup $DB /home/ubuntu/backup/.mysql >> /home/ubuntu/daily.log
  /home/ubuntu/config/scripts/clean.sh -m 5 -d /home/ubuntu/backup $DB >> /home/ubuntu/daily.log
done

apt update >> /home/ubuntu/update.log
apt upgrade -y >> /home/ubuntu/update.log
apt autoremove -y >> /home/ubuntu/update.log

reboot
