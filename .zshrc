# Path needs to go first to find starship
export PATH=~/bin:~/.local/bin:$PATH

# POWERLEVEL10k
ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Starship
# eval "$(starship init zsh)"

# ohmyposh
#eval "$(oh-my-posh init zsh --config /home/rohit/.mytheme.omp.json)"


################## PYENV
#export PYENV_ROOT="$HOME/.pyenv"
#[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
##############################

# fzf ctrl+r
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/rohit/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/rohit/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/rohit/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/rohit/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

