# Dotfiles

This is a repository of my dotfiles.

## Contents

To install the different files, use stow.
### Fish (fish/)

* setup.sh - Symlinks all fish files to their corresponding location in `~/.config/fish/`
* config.fish - Global fish configuration (.fishrc)
* completions/
  * repo.fish - Contains all repos as completions for the `repo` command
  * repodir.fish - Contains all repos as completions for the `repodir` command
* functions/
  * abbrex.fish - Utility for expanding abbreviations in fish-scripts
  * clear.fish - Clears the screen and shows fish_greeting
  * emptytrash.fish - Empties trash and clears system logs
  * forrepos.fish - Executes a passed command for all repos in `~/repos`
  * ls.fish - Calling ls with parameter --color=auto
  * repo.fish - Finds a repository in `~/repos` and jumps to it
  * repodir.fish - Finds a repository in `~/repos` and prints its path
  * setup.fish - Initial setup for a new fish installation,
  contains abbreviations

### Hammerspoon (hammerspoon/)

* setup.sh - Symlinks all lua and AppleScript files to `~/.hammerspoon/`
* init.lua - Contains the main Hammerspoon config, importing the others
* hyper.lua - Binds the "F18" key to a Hyper mode, which can be used for
global commands
* menuHammerCustomConfig.lua - Customization for the MenuHammer spoon
* shortcuts.lua - Shortcuts using hyper mode
* spectacle.lua - Window management
* spoons.lua - Spoon configurations

### iTerm2 (iterm2/)

* AtomOneLight.itermcolors - AtomOneLight colorscheme

### Karabiner (karabiner/)

* setup.sh - Symlinks Karabiner settings to ~/.config/karabiner
* karabiner.json - Binds the CAPS LOCK key to "F18" to use with hammerspoon

### Kitty (kitty/)

* setup.sh - Symlinks kitty settings to ~/.config/kitty
* kitty.conf - Contains the main kitty configuration.
* colors.conf - Contains the kitty color configuration.

### macOS Preferences (macos/)

* setup.sh - Executes a long list of commands pertaining to macOS Preferences

### Packages (packages/)

* setup.sh - Installs the contents of the .list files and the Brewfile

### VI Improved (vim)

* setup.sh - Symlinks all vim files to `~/`
* .vimrc - Basic Vim configuration

### Visual Studio Code (vscode/)

* setup.sh - Symlinks the settings.json file to `~/Library/Application Support/Code/User`
* settings.json - Contains user settings for Visual Studio Code
