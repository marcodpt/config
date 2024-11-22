#!/bin/bash

#GIT
git config --global user.email "marcodpt@protonmail.com"
git config --global user.name "Marco Di Pillo Tomic"
git config --global push.default simple
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_rsa.pub
git config --global commit.gpgsign true

SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

#TMUX
ln -sf $SCRIPT_DIR/tmux.conf $HOME/.tmux.conf

#BASH
LINE="# personal configuration"
if ! grep -qF "$LINE" ~/.bashrc; then
  echo $LINE >> ~/.bashrc
  cat $SCRIPT_DIR/bashrc >> $HOME/.bashrc
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

#DENO
#if [ ! -d ~/.deno ]; then
  #curl -fsSL https://deno.land/install.sh | sh
  #echo 'export PATH="$HOME/.deno/bin:$PATH"' >> ~/.bashrc
#fi

#PHP AND SCRIPTS
if [ ! -d $HOME/bin ]; then
  mkdir $HOME/bin 
  ln -sf $SCRIPT_DIR/php $HOME/bin/php
  ln -sf $SCRIPT_DIR/update $HOME/bin/update
  curl https://frankenphp.dev/install.sh | sh
  mv frankenphp $HOME/bin/fphp
  curl -sS https://getcomposer.org/installer > /tmp/installer.php
  $HOME/bin/php /tmp/installer.php --install-dir=$HOME/bin --filename=composer
  rm /tmp/installer.php
fi
