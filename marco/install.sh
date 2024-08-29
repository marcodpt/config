#!/bin/bash

apt update
apt upgrade -y
apt autoremove -y
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

UPDATE="/usr/local/bin/update"
echo "#!/bin/bash" > $UPDATE
echo "sudo apt update" >> $UPDATE
echo "sudo apt upgrade -y" >> $UPDATE
echo "sudo apt autoremove -y" >> $UPDATE
echo "exit 0" >> $UPDATE
chmod ugo+x $UPDATE
