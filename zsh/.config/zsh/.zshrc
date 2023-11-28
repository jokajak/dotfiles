#!/bin/zsh

# Basic exports
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM="xterm-256color"

source "$ZDOTDIR/exports"

# zsh settings
export DISABLE_AUTO_TITLE="true"
export COMPLETION_WAITING_DOTS="false"
export HIST_STAMPS="yyyy.mm.dd"
export HISTSIZE=5000
export SAVEHIST=5000
export HISTFILE="$HOME/.local/share/zsh/.zsh_history"
setopt HIST_IGNORE_SPACE
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# cd-ing settings
setopt auto_cd                                         # automatically cd if folder name and no command found
setopt auto_list                                       # automatically list choices on ambiguous completion
setopt auto_menu                                       # automatically use menu completion
setopt always_to_end                                   # move cursor to end if word had one match
setopt interactive_comments                            # allow comments in interactive shells
zstyle ':completion:*' menu select                     # select completions with arrow keys
zstyle ':completion:*' group-name ''                   # group results by category
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # non case sensitive complete
zstyle ':completion:*' list-colors "$LS_COLORS"
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# autocompletions
autoload -Uz compinit
zmodload zsh/complist
compinit

# autosuggestions settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC="true"

export EDITOR='nvim'
export BROWSER= # do not set browser

# Source aliases
source "$ZDOTDIR/aliases"
source "$ZDOTDIR/functions"

# source dir hashes
[ -f "$HOME/.local/share/zsh/.zsh_dir_hashes" ] && source "$HOME/.local/share/zsh/.zsh_dir_hashes"

# Source colors for ls (trapd00r/LS_COLORS)
[ "$(uname -s)" = "Darwin" ] &&
    eval $(gdircolors -b "$ZDOTDIR/dircolors" 2>/dev/null) ||
        eval $(dircolors -b "$ZDOTDIR/dircolors")

# Use vim mode in zsh
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -v
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^H' backward-kill-word # ctrl+bspc
# bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
bindkey "${key[Up]}" history-search-backward
bindkey "${key[Down]}" history-search-forward
export KEYTIMEOUT=1

# setup direnv
eval "$(direnv hook zsh)"
copy_function() {
	test -n "$(declare -f "$1")" || return
	eval "${_/$1/$2}"
}

copy_function _direnv_hook _direnv_hook__old

_direnv_hook() {
	_direnv_hook__old "$@" 2> >(grep -vE '^direnv: export')
}

source <(pkgx --shellcode)  #docs.pkgx.sh/shellcode

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"

source /Users/josh/.config/broot/launcher/bash/br

export ZSH_LOADED=1
