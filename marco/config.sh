#!/bin/bash

if [[ $EUID -eq 0 ]]; then
  echo "You must be a non root user" 2>&1
  exit 1
fi

TARGET="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ln -sf "$TARGET/tmux.conf" ~/.tmux.conf
ln -sf "$TARGET/vimrc" ~/.vimrc

mkdir -p ~/.vim/swapfiles
mkdir -p ~/.vim/session

LINE=$(head -1 "$TARGET/bashrc")
if ! grep -qF "$LINE" ~/.bashrc; then
  cat "$TARGET/bashrc" >> ~/.bashrc
fi

if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +PlugInstall +PlugUpdate +PlugClean! +qall

git config --global user.email "marcodpt@protonmail.com"
git config --global user.name "Marco Di Pillo Tomic"
git config --global push.default simple
