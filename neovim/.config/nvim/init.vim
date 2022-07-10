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

" Enable LSP (language server protocol) support
Plug 'neovim/nvim-lspconfig'
" nvim-treesitter provides framework for parsing files 
" e.g. make better syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" show context of the current line, e.g. the function name
Plug 'nvim-treesitter/nvim-treesitter-context'
" syntax aware text objects
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" location aware text objects so you can increase the selection from function
" to class
Plug 'RRethy/nvim-treesitter-textsubjects'
" Use syntax aware hints
Plug 'mfussenegger/nvim-ts-hint-textobject'
" Library functions for neovim
Plug 'nvim-lua/plenary.nvim'
" Dim code not being worked on
Plug 'folke/twilight.nvim'
" Highlight TODO comments
Plug 'folke/todo-comments.nvim'
" Create shareable links from code
Plug 'ruifm/gitlinker.nvim'
" Code completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" End plugins
call plug#end()

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if (has("termguicolors"))
  set termguicolors
endif

" Enable hybrid line numbers per https://jeffkreeftmeijer.com/vim-number/
set number

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" Configure treesitter
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}
