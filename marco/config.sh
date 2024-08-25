#!/bin/bash

#GIT
git config --global user.email "marcodpt@protonmail.com"
git config --global user.name "Marco Di Pillo Tomic"
git config --global push.default simple
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_rsa.pub
git config --global commit.gpgsign true

#PROJECTS
sync () {
  if [ -z $2 ]; then
    HOST=github
  else
    HOST=$2
  fi

  if [ -z $3 ]; then
    FOLDER=Desktop/$1
  else
    FOLDER=$3
  fi
  FOLDER=$HOME/$FOLDER

  echo "******* $HOST@$1 $FOLDER *********"

  if [ ! -d $FOLDER ]; then
    git clone git@$HOST.com:marcodpt/$1.git $FOLDER
  else
    cd $FOLDER && git pull
  fi
}

sync config
sync minirps
sync rawprinter
sync serialscale
sync tint
sync paw
sync hippo
sync respect
sync rest gitlab
sync auto gitlab
sync pass gitlab .password-store

#TMUX
wget -q -O ~/.tmux.conf \
  https://raw.githubusercontent.com/marcodpt/config/main/marco/tmux.conf

#BASH
LINE="# personal configuration"
if ! grep -qF "$LINE" ~/.bashrc; then
  echo $LINE >> ~/.bashrc
  wget -q -O - \
    https://raw.githubusercontent.com/marcodpt/config/main/marco/bashrc \
    >> ~/.bashrc
fi

#VIM
wget -q -O ~/.vimrc \
  https://raw.githubusercontent.com/marcodpt/config/main/marco/vimrc

mkdir -p ~/.vim/swapfiles
mkdir -p ~/.vim/session

if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ $0 != "bash" ]; then
  vim +PlugInstall +PlugUpdate +PlugClean! +qall
fi

#RUST
if [ ! -d ~/.rustup ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup target add x86_64-unknown-linux-musl
fi

#DENO
if [ ! -d ~/.deno ]; then
  curl -fsSL https://deno.land/install.sh | sh
  echo 'export PATH="$HOME/.deno/bin:$PATH"' >> ~/.bashrc
fi
