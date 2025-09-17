#!/bin/bash

if [[ $(id -u) -eq 0 ]]; then
  echo "Must be run as non-root user!"
  exit 1
fi

mkdir -p $HOME/bin 
mkdir -p $HOME/dev

#GIT
git config --global user.email "marcodpt@protonmail.com"
git config --global user.name "Marco Di Pillo Tomic"
git config --global push.default simple
#git config --global gpg.format ssh
#git config --global user.signingkey ~/.ssh/id_rsa.pub
#git config --global commit.gpgsign true

SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

#BASH
LINE="source $SCRIPT_DIR/bashrc"
if ! grep -qF "$LINE" ~/.bashrc; then
  echo $LINE >> $HOME/.bashrc
fi

#VIM
ln -sf $SCRIPT_DIR/vimrc $HOME/.vimrc

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
