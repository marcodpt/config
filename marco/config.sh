#!/bin/bash

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

#GIT
git config --global user.email "marcodpt@protonmail.com"
git config --global user.name "Marco Di Pillo Tomic"
git config --global push.default simple

#RUST
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

#DENO
curl -fsSL https://deno.land/install.sh | sh

#VIM
wget -q -O ~/.vimrc \
  https://raw.githubusercontent.com/marcodpt/config/main/marco/vimrc

mkdir -p ~/.vim/swapfiles
mkdir -p ~/.vim/session

if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +PlugInstall +PlugUpdate +PlugClean! +qall
