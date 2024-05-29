#!/bin/bash

echo "***** UPDATE *****" > /home/ubuntu/update.log

/home/ubuntu/config/scripts/backup.sh -c -d /home/ubuntu/backup db03 /home/ubuntu/backup/.mysql >> /home/ubuntu/update.log
/home/ubuntu/config/scripts/clean.sh -m 5 -d /home/ubuntu/backup db03 >> /home/ubuntu/update.log

apt update >> /home/ubuntu/update.log
apt upgrade -y >> /home/ubuntu/update.log
apt autoremove -y >> /home/ubuntu/update.log

reboot
