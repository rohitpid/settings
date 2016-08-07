#!/bin/bash

sudo apt-get install zsh && sudo chsh -s /bin/zsh $USER
cp .zshrc ~/.zshrc
cp .vimrc ~/.vimrc
cp -a .vim ~/.vim
cp .tmux.conf ~/.tmux.conf
cp .gitconfig ~/.gitconfig
cp -a .oh-my-zsh ~/.oh-my-zsh
cp -a bin ~/bin
cp rohit.zsh-theme ~/.oh-my-zsh/themes/
