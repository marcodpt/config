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

#PASS
STORE="$HOME/.password-store"
if [ ! -d $STORE ]; then
  git clone git@gitlab.com:marcodpt/pass.git $STORE
fi

#RUST
if [ ! -d ~/.rustup ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

#DENO
if [ ! -d ~/.deno ]; then
  curl -fsSL https://deno.land/install.sh | sh
  echo 'export PATH="$HOME/.deno/bin:$PATH"' >> ~/.bashrc
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

vim +PlugInstall +PlugUpdate +PlugClean! +qall > /dev/null
