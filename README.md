# config

Meus arquivos de configurações e scripts

## iot
Install 
```
wget -q -O - https://raw.githubusercontent.com/marcodpt/config/main/iot/install.sh | sudo bash
```

 - `install.sh` é um script para inicializar um terminal com balança e impressora.
 - `rc.local` é usado por esse script para iniciar o servidor ao ser ligado.
 - `config.toml` são as configurações do servidor.

## marco
Minhas configurações pessoais
 - `install.sh` instala os pacotes que uso para trabalhar
 - `config.sh` configura minhas preferências
 - `bashrc` coloca o `vim` como editor default e sempre usa `tmux` no terminal 
 - `vimrc` são minhas configurações do `vim`
 - `tmux.conf` são minhas configurações do `tmux`

## Rodar scripts em máquinas remotas
Como usuário
```
ssh {user}@{ip} 'bash -s' < script.sh
```

Como root
```
ssh {user}@{ip} 'echo "{rootpass}" | sudo -Sv && bash -s' < script.sh
```
