#!/bin/bash

SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
ln -sf $SCRIPT_DIR/update /usr/bin/update

update

apt install tmux -y
apt install curl -y
apt install git -y
apt install xclip -y
apt install vim-gtk3 -y
apt install pass -y
apt install sqlite3 -y
apt install ripgrep -y
apt install docker.io -y
apt install build-essential -y
apt install libudev-dev -y
apt install pkg-config -y
apt install musl-tools -y
