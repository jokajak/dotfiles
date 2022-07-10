" nvim configuration file

" search recursively in the current directory for files
set path+=**

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

" Set up plugins
call plug#begin('~/.vim/plugged')

" vim game for movements
Plug 'theprimeagen/vim-be-good'

" gruvbox theme
Plug 'gruvbox-community/gruvbox'

" End plugins
call plug#end()

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if (has("termguicolors"))
  set termguicolors
endif
