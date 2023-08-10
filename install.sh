#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'
cols=$(tput cols)

if  [[ $(uname -s) == "Linux" ]] && [[ $(lsb_release -i | awk '{print $3}') == "Ubuntu" ]]; then
    printf '#%.0s' {1..80}
    printf '\n'
    echo -e "${GREEN}Detected Ubuntu. Installing PPAs and packages from UbuntuPackages file${NC}"
    printf '#%.0s' {1..80}
    printf '\n'
    ./ubuntu_ppas
    sudo apt-get update
    xargs -a <(awk '/^\s*[^#]/' "ubuntu_packages") -r -- sudo apt-get install -y
    printf '#%.0s' {1..80}
    printf '\n'
    echo -e "${GREEN}Installing flatpaks${NC}"
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    xargs -a <(awk '/^\s*[^#]/' "flatpaks") -r -- sudo flatpak -y install
    printf '#%.0s' {1..80}
    printf '\n'
fi

#if [[ $(uname -s) == "Linux" ]] && $(echo $SHELL) != "/bin/zsh" ]]; then
#    sudo apt-get install zsh
#fi

if  [[ $(uname -s) == "Darwin" ]]; then
    printf '#%.0s' {1..80}
    printf '\n'
    echo -e "${GREEN}Detected Apple OSX. Installing brew packages in Brewfile${NC}" 
    printf '#%.0s' {1..80}
    printf '\n'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew bundle
fi

printf '#%.0s' {1..80}
printf '\n'
echo -e "${GREEN}Setting shell to zsh and copying .zshrc${NC}"
printf '#%.0s' {1..80}
printf '\n'
sudo chsh -s /bin/zsh $USER
cp .zshrc ~/.zshrc

# printf '#%.0s' {1..80}
# printf '\n'
# echo -e "${GREEN}Setting up vim plugins and vimrc${NC}"
# printf '#%.0s' {1..80}
# printf '\n'
# cp .vimrc ~/.vimrc
# cp -a .vim ~/.vim

if [ $USER == "rohit" ];
then
    printf '#%.0s' {1..80}
    printf '\n'
    echo -e "${GREEN}Copying gitconfig ${NC}"
    printf '#%.0s' {1..80}
    printf '\n'
    cp .gitconfig ~/.gitconfig
fi

printf '#%.0s' {1..80}
printf '\n'
echo -e "${GREEN}Copying convenience scripts to ~/bin/ ${NC}"
printf '#%.0s' {1..80}
printf '\n'
cp -a bin ~/

printf '#%.0s' {1..80}
printf '\n'
echo -e "${GREEN}Setting up oh-my-zsh theme and powerlevel10k${NC}"
printf '#%.0s' {1..80}
printf '\n'
cp -a .oh-my-zsh ~/.oh-my-zsh
cp rohit.zsh-theme ~/.oh-my-zsh/themes/
cp -a powerlevel10k ~/.oh-my-zsh/themes/
cp .zsh_profile_remote ~/.zsh_profile_remote
cp .zshrc_mac ~/.zshrc_mac

printf '#%.0s' {1..80}
printf '\n'
echo -e "${GREEN}Setting up tmux.conf  then starting tmux${NC}"
printf '#%.0s' {1..80}
printf '\n'
cp .tmux.conf ~/.tmux.conf
