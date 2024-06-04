#!/bin/bash

echo "***** UPDATE *****" > /home/ubuntu/update.log

certbot renew
apt update >> /home/ubuntu/update.log
apt upgrade -q -y >> /home/ubuntu/update.log
apt autoremove -q -y >> /home/ubuntu/update.log

reboot
