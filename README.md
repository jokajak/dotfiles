# Dotfiles

This is a repository of my dotfiles.


## Contents

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

### macOS Preferences (macos/)
* setup.sh - Executes a long list of commands pertaining to macOS Preferences

### Packages (packages/)
* setup.sh - Installs the contents of the .list files and the Brewfile
