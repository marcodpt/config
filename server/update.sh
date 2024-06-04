#!/bin/bash

echo "***** UPDATE *****" > /home/ubuntu/update.log

certbot renew
apt update >> /home/ubuntu/update.log
apt upgrade -y >> /home/ubuntu/update.log
apt autoremove -y >> /home/ubuntu/update.log

reboot
