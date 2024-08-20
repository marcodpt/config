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

#PROJECTS
sync () {
  if [ $2 == "" ]; then
    2="github"
  fi
  if [ $3 == "" ]; then
    3="Desktop/$1" 
  fi

  echo "******* $2@$1 $3 *********"

  if [ ! -d $FOLDER ]; then
    git clone git@$2.com:marcodpt/$1.git $HOME/$3
  else
    cd $FOLDER
    git pull
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
sync apitest
sync rest gitlab
sync auto gitlab
sync pass gitlab .password-store

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

if [ $0 != "bash" ]; then
  vim +PlugInstall +PlugUpdate +PlugClean! +qall
fi
