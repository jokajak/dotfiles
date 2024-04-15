#!/bin/sh

[ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
export ZDOTDIR="$HOME/.config/zsh"
export _Z_DATA="$HOME/.local/share/z/z"
