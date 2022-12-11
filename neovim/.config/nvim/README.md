# Neovim configuration

This directory holds my neovim configuration.

The goals of my configuration are:

* fast startup. I get really frustrated when I wait to do work
    * My work laptop has a lot of on-access scanning which slows down disk
      reads. Therefore I want to lazy load functionality so that reads are
      spread out.
* I want a dashboard alongside a tree view when I start up. I know some people
  say don't use the tree view but it can be convenient when working with
  codebases to understand the structure of the project. Especially when the
  structure isn't well defined.
* LSP and DAP support for my main languages:
    * ansible
    * python
    * lua (for neovim)
    * shell
    * markdown
* I want to be able to easily add new plugins with their configuration in one
  place.

## Inspiration/Sources

* [folke](https://github.com/folke/dot/tree/master/config/nvim)
* [cbochs dotfiles](https://github.com/cbochs/dotfiles)
