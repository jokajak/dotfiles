" Protect changes between writes. Default values of
" updatecount (200 keystrokes) and updatetime
" (4 seconds) are fine
set swapfile
set directory^=~/.vim/swap//

" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" patch required to honor double slash at end
if has("patch-8.1.0251")
	" consolidate the writebackups -- not a big
	" deal either way, since they usually get deleted
	set backupdir^=~/.vim/backup//
end

" persist the undo tree for each file
set undofile
set undodir^=~/.vim/undo//

if filereadable(expand('$VIMRUNTIME/defaults.vim'))
    source $VIMRUNTIME/defaults.vim
endif
" Remove autocmd 'jump to last known cursor position'
"augroup vimStartup | au! | augroup END

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set nrformats-=octal

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set laststatus=2
set ruler
set wildmenu

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  set shell=/usr/bin/env\ bash
endif

set autoread

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

inoremap <C-U> <C-G>u<C-U>

"new in vim 7.4.1042
let g:word_count=wordcount().words
function WordCount()
    if has_key(wordcount(),'visual_words')
        let g:word_count=wordcount().visual_words."/".wordcount().words " count selected words
    else
        let g:word_count=wordcount().cursor_words."/".wordcount().words " or shows words 'so far'
    endif
    return g:word_count
endfunction

set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v][words:%{WordCount()}]
"              | | | | |  |   |      |  |     |    |
"              | | | | |  |   |      |  |     |    +-- current column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- rodified flag in square brackets
"              +-- full path to file in the buffer

function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/pack/jokajak/start/')

" Make sure you use single quotes around plugin names

" Shorthand notation; fetches https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'

" Ansible syntax support
Plug 'pearofducks/ansible-vim'

" Easily align things
Plug 'junegunn/vim-easy-align'

" Fuzzy find files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Vimwiki
Plug 'vimwiki/vimwiki'

" TaskWiki
Plug 'tools-life/taskwiki'

" Calendar
Plug 'mattn/calendar-vim'

" AnsiEsc to colorize embedde ansi
Plug 'powerman/vim-plugin-AnsiEsc'

Plug 'blindFS/vim-taskwarrior'

" Hybrid line numbers
Plug 'https://github.com/jeffkreeftmeijer/vim-numbertoggle'

" Initialize vim-plug plugin system
call plug#end()

" Remap Escape
inoremap jj <ESC>

au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

let wiki_1 = {}
let wiki_1.path = '~/git/work/notes/'
let wiki_1.html_template = '~/public_html/template.tpl'
let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
let wiki_1.index = 'work'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = 'md'
let wiki_1.auto_tags = 1

let wiki_2 = {}
let wiki_2.path = '~/git/personal/notes/'
let wiki_2.index = 'personal'
let wiki_2.syntax = 'markdown'
let wiki_2.ext = 'md'
let wiki_2.auto_tags = 1

let g:vimwiki_list = [wiki_1, wiki_2]
let g:vimwiki_global_ext = 0

au FileType vimwiki setlocal shiftwidth=2 tabstop=2 expandtab
au FileType vimwiki inoremap <expr> <tab> getline('.') =~# '^\s*\*' ? '<c-t>' : '<tab>'
command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.md VimwikiDiaryGenerateLinks
augroup end

" Make tab shift right
" vim:set ft=vim et sw=2:
