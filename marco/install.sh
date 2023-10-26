#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
fi

apt update
apt upgrade -y
apt autoremove -y
apt install tmux -y
apt install curl -y
apt install git -y
apt install xclip -y
apt install vim-gtk -y
apt install pass -y
apt install sqlite3 -y
apt install make -y
