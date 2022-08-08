# Enable starship for prompt
eval "$(starship init zsh)"

# enable vi mode
bindkey -v

# because I can't stop typing vim
alias vim=nvim

alias ls='ls --color -F'

# set common configuration directory
export XDG_CONFIG_HOME=$HOME/.config

VIM="nvim"
# Set git editor to vim
export GIT_EDITOR=$VIM

export PATH=$PATH:~/.local/bin/
