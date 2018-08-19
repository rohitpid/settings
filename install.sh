#!/bin/bash

if  [[ $(uname -s) == "Linux" ]] && [[ $(lsb_release -i | awk '{print $3}') == "Ubuntu" ]]; then
    sudo apt-get install curl
    ./UbuntuPPA
    sudo apt-get update
    xargs -a <(awk '/^\s*[^#]/' "UbuntuPackages") -r -- sudo apt-get install -y
fi

#if [[ $(uname -s) == "Linux" ]] && $(echo $SHELL) != "/bin/zsh" ]]; then
#    sudo apt-get install zsh
#fi

if  [[ $(uname -s) == "Darwin" ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew bundle
fi
sudo chsh -s /bin/zsh $USER
cp .zshrc ~/.zshrc
cp .vimrc ~/.vimrc
cp -a .vim ~/.vim
cp .tmux.conf ~/.tmux.conf
cp .gitconfig ~/.gitconfig
cp -a .oh-my-zsh ~/.oh-my-zsh
cp -a bin ~/
cp rohit.zsh-theme ~/.oh-my-zsh/themes/
cp -a powerlevel9k ~/.oh-my-zsh/themes/
cp .zsh_profile_remote ~/.zsh_profile_remote
cp .zshrc_mac ~/.zshrc_mac
sudo snap install slack --classic
tmux attach -t main || tmux new -s main
