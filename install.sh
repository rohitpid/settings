#!/bin/bash

if [[ $(echo $SHELL) != "/bin/zsh" ]]; then
    sudo apt-get install zsh && sudo chsh -s /bin/zsh $USER
fi
cp .zshrc ~/.zshrc
cp .vimrc ~/.vimrc
cp -a .vim ~/.vim
cp .tmux.conf ~/.tmux.conf
cp .gitconfig ~/.gitconfig
cp -a .oh-my-zsh ~/.oh-my-zsh
cp -a bin ~/
cp rohit.zsh-theme ~/.oh-my-zsh/themes/
cp .zsh_profile_remote ~/.zsh_profile_remote
tmux attach -t main || tmux new -s main
