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

 - `install.sh` install the packages I use to work.
 - `config.sh` set my preferences.
 - `bashrc` put `vim` as the default editor and always use `tmux` in the terminal.
 - `vimrc` these are my `vim` settings.
 - `tmux.conf` these are my `tmux` settings.
