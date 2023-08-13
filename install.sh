#!/bin/bash

GREEN='\033[0;32m'
CYAN='\033[0;94m'
NC='\033[0m'
cols=$(tput cols)

function print_section_header () {
    COLUMNS=$(tput cols) 
    title=$1
    printf "${GREEN}#%.0s${NC}" {1..80}
    printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"
    printf '\n'
    # echo -e "$1"
    # # printf '#%.0s' {1..80}
    # printf '\n'

}

function print_help () {
    echo "Set up a new machine with dotfiles and common repos and programs such as"
    echo "vim, curl, chrome, tmux, zsh as well as oh-my-zsh themes and flatpaks for"
    echo "vscode, spotify and dropbox."
    echo "On macOS, we install brew and all these packages listed above using brew."

    echo ""
    echo "Options:"
    echo "  -a | --all installs all applications possible for OS"
    echo "  -z | --zsh installs zsh, sets it as default shell and installs themes"
    echo "  -nf| --no-flatpak skips installation of spotify, dropbox, vscode flatpaks"
    echo "  -v | --vim-plugins enables installation of vim plugins"
    echo "  -h | --help prints this message"
}

function install_flatpaks () {
    print_section_header "Installing flatpaks"
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    xargs -a <(awk '/^\s*[^#]/' "flatpaks") -r -- sudo flatpak -y install
}

function setup_linux () {
    print_section_header "Detected Ubuntu. Installing ubuntu packages"

    ./ubuntu_ppas
    sudo apt-get update
    xargs -a <(awk '/^\s*[^#]/' "ubuntu_packages") -r -- sudo apt-get install -y

    if  [[ ! ${FLATPAKS} == "NO" ]]; then
        install_flatpaks
    fi
}

function setup_macos () {
    print_section_header "Detected Apple OSX. Installing brew packages in Brewfile"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew bundle
}

function setup_zsh () {
    print_section_header "Setting shell to zsh and copying .zshrc"

    sudo chsh -s /bin/zsh $USER
    cp .zshrc ~/.zshrc
}

function setup_vim () {
    print_section_header "Setting up vim plugins and vimrc"
    if [ ! -f ~/.vimrc ]; then
        cp .vimrc ~/.vimrc
    else
        echo ".vimrc already exists, skipping"
    fi
    if [ ! -d ~/.vim ]; then
        cp -a .vim ~/.vim
    else
        echo ".vim directory already exists, skipping"
    fi
}

function setup_rohit_specific () {
    print_section_header "Copying gitconfig"
    if [ ! -f ~/.gitconfig ]; then
        cp .gitconfig ~/.gitconfig
    else
        echo ".gitconfig already exists, skipping"
    fi
}

function convenience_scripts () {
    print_section_header "Copying convenience scripts to ~/bin/"
    if [ ! -d ~/bin ]; then
        cp -a bin ~/
    else
        echo "~/bin/ exists so skipping copying convenience scripts"
       
    fi
}

function setup_zsh_themes () {

    print_section_header "Setting up oh-my-zsh theme and powerlevel10k"

    cp -a .oh-my-zsh ~/.oh-my-zsh
    cp rohit.zsh-theme ~/.oh-my-zsh/themes/
    cp -a powerlevel10k ~/.oh-my-zsh/themes/
    cp .zsh_profile_remote ~/.zsh_profile_remote
}

function setup_tmux_config () {
    print_section_header "Setting up tmux.conf"

    if [ ! -f ~/.tmux.conf ]; then
        cp .tmux.conf ~/.tmux.conf
    else
        echo ".tmux.conf already exists, skipping"
    fi
}


POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -a|--all)
      ALL=YES
      shift # past argument
      ;;
    -z|--zsh)
      ZSH=YES
      shift # past argument
      ;;
    -nf|--no-flatpak)
      FLATPAKS=NO
      shift # past argument
      ;;
    -v|--vim-plugins)
      VIM_PLUGINS=YES
      shift # past argument
      ;;
    -h|--help)
      print_help
      exit 0
      ;;
    -*|--*)
      echo "Unknown option $1"
      print_help
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters


if  [[ $(uname -s) == "Linux" ]] && [[ $(lsb_release -i | awk '{print $3}') == "Ubuntu" ]]; then
    setup_linux
fi


if  [[ $(uname -s) == "Darwin" ]]; then
    setup_macos
    cp .zshrc_mac ~/.zshrc_mac
fi

if  [[ ${ZSH} == "YES" ]] || [[ $ALL == "YES" ]]; then
    setup_zsh
    setup_zsh_themes
fi


if  [[ ${VIM} == "YES" ]] || [[ $ALL == "YES" ]]; then
    setup_vim
fi

convenience_scripts


if [ $USER == "rohit" ];
then
    setup_rohit_specific
fi


setup_tmux_config
