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
apt install claws-mail -y
apt install ripgrep -y

RC="/etc/rc.local"
echo "#!/bin/bash" > $RC
echo "apt update" >> $RC
echo "apt upgrade -y" >> $RC
echo "apt autoremove -y" >> $RC
echo "exit 0" >> $RC
