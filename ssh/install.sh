apt install openssh-server -y

mkdir -p .ssh
wget --no-check-certificate https://192.168.0.5/index.php/download/authorized_keys
mv authorized_keys .ssh
