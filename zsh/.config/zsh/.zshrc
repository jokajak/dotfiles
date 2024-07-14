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
export HISTSIZE=50000
export SAVEHIST=50000
export HISTFILE="$HOME/.local/share/zsh/.zsh_history"
# https://martinheinz.dev/blog/110
export HISTORY_IGNORE="(pwd|exit)*"

# https://zsh.sourceforge.io/Doc/Release/Options.html (16.2.4 History)
setopt EXTENDED_HISTORY      # Write the history file in the ':start:elapsed;command' format.
setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
setopt APPEND_HISTORY        # append to history file (Default)
setopt SHARE_HISTORY         # Share history between all sessions.
setopt INC_APPEND_HISTORY    # Write to the history file immediately, not when the shell exits.
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS     # Do not write a duplicate event to the history file.
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from each command line being added to the history.
setopt HIST_NO_STORE         # Don't store history commands
setopt HIST_VERIFY           # Do not execute immediately upon history expansion.

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
export CDPATH=$HOME/git:

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
bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
bindkey "${key[Up]}" history-search-backward
bindkey "${key[Down]}" history-search-forward
bindkey '\e.' insert-last-word
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

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"

[ -f "${HOME}/.config/broot/launcher/bash/br" ] && source "${HOME}/.config/broot/launcher/bash/br"

export ZSH_LOADED=1
