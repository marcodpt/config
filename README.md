# Config

My settings files and automation scripts.

## iot
Installation

```
wget -q -O - https://raw.githubusercontent.com/marcodpt/config/main/iot/install.sh | sudo bash
```

 - `install.sh` is a script to initialize a terminal with scale and printer.
 - `rc.local` is used by this script to start the server when powered on.
 - `startup.sh` restarts servers and is used by `install.sh` and `rc.local`.
 - `config.toml` are the server settings.

Restart server

```
sudo /etc/iot/startup.sh
```

## marco
My personal settings.

```
wget -q -O - https://raw.githubusercontent.com/marcodpt/config/main/marco/install.sh | sudo bash
```

```
ssh-add
wget -q -O - https://raw.githubusercontent.com/marcodpt/config/main/marco/config.sh | bash
```

 - `install.sh` install the packages I use to work.
 - `config.sh` set my preferences.
 - `bashrc` put `vim` as the default editor
 - `vimrc` these are my `vim` settings.

## SSH
### Import private key 
```
mkdir -p ~/.ssh
cp path/to/key ~/.ssh/id_rsa
chmod go-rw ~/.ssh/id_rsa
ssh-keygen -f ~/.ssh/id_rsa -y > ~/.ssh/id_rsa.pub
```

### Generate new key
```
ssh-keygen -t rsa -b 4096 -C "user@email.com" -f ~/.ssh/id_rsa
```

## GPG

### Import key (public or private)
```
gpg --import path/to/key
gpg --edit-key user@email.com
trust
5
quit
```

### Export public key
```
gpg --armor --export user@email.com > pub.asc
```

### Export private key
```
gpg --armor --export-secret-key user@email.com > key.asc
```

### List public keys
```
gpg -k
```

### List private keys
```
gpg -K
```

### Generate new key
```
sudo rngd -r /dev/urandom
gpg --gen-key
```

## Docker

### List all images
```
docker images
```

### List all process
```
docker ps -a
```

### Create a process from a image
```
docker run --name {name} -p 8080:80 -v .:/data/{name} -it ubuntu:24.04 /bin/bash
```

### commit container
```
docker commit {name}
```

### reconnet
```
docker restart {name}
docker attach {name}
```

### Remove image
```
docker rmi [image]
```
