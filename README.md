## Synopsis

This is Rohit's personal repository of scripts, settings and plugins for setting up a new system. This includes installing my settings for iterm2, zsh, vim, git, tmux as well as installing appropriate packages for either Ubuntu or macOS. Additionally we place some helper scripts in ~/bin/

## Motivation

This project exists because it is a pain to set up a new system every time you switch machines. This saves a days worth of work.

## Detailed List of Tools and customizations

+ vim plugins
 + Vundle to allow installation of other plugins
 + Syntastic for to lint code directly in vim
 + ctrl-p fuzzy finder for vim
 + vim-airline for colorful status bar
 + NERDTree for file browser capability
 + supertab for better tab completion
+ Scripts in ~/bin/
 + ss, a custom ssh which rsync's your zsh, git, vim settings and opens (or reconnects to) tmux on remote machine. e.g. ss 10.23.16.19
 + my ls-ec2 which displays a list of ec2 instances and associated information in a nice table
 + colourchart which shows you the color codes for theming in oh-my-zsh
 + my du which does a du and sorts the results. e.g. my du /var/log/\*
 + my ls-sqs which lists sqs queue
+ tmux configuration in tmux.conf
+ gitconfig - Please change this file if you use this repository
+ zsh - Make zsh the default shell and installs oh-my-zsh with my personal theme
![My Shell](https://raw.githubusercontent.com/rohitpid/settings/master/images/overview.png)
+ Detect if Debian/Ubuntu/LinuxMint or MacOSX and Install packages
 + Install PPAs and packages (See UbuntuPPA and UbuntuPackages file to see what is installed)
 + Install relevant packages for MacOSX (Read Brewfile to see what is installed)
 + MacOSX doesn't have a package for powerline fonts so install them manually
+ iterm2 configuration which can be loaded easily

## Installation

1. git clone --recursive https://github.com/rohitpid/settings.git
2. Review packages to be installed in Brewfile or UbuntuPackages and add/remove packages you want installed.
3. Edit .gitconfig with your own email and username for git
4. MacOS only: Install powerline fonts from https://github.com/powerline/fonts
5. Run ./install.sh
6. Open vim (ignore the errors on startup the first time) and run :PluginInstall
7. Open iterm2 and go to preferences->general->"Load Preferences from a custom file or folder" and select the folder as ~/settings/iterm2_profile/
![iterm2 settings](https://raw.githubusercontent.com/rohitpid/settings/master/images/iterm2.png)

## Usage

+ When using zsh you can: export MY_LABEL='labelname' to get an extra red segment to label your terminal for special hosts
![MY_LABEL](https://raw.githubusercontent.com/rohitpid/settings/master/images/label.png)
+ Use ss <ip> instead of ssh to get your settings rsynced to the remote host and start tmux or reconnect to existing tmux session.

## Contributors

Rohit Pidaparthi and special thanks to Oleg Selivanov for the basis and ideas for the scripts in ~/bin/

## License

MIT
