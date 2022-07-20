--[[ opts.lua ]]
local opt = vim.opt
local cmd = vim.api.nvim_command

-- [[ Context ]]
opt.colorcolumn = '80'           -- str:  Show col for max line length
opt.number = true                -- bool: Show line numbers
opt.relativenumber = true        -- bool: Show relative line numbers
opt.scrolloff = 4                -- int:  Min num lines of context
opt.signcolumn = "yes"           -- str:  Show the sign column

-- [[ Filetypes ]]
opt.encoding = 'utf8'            -- str:  String encoding to use
opt.fileencoding = 'utf8'        -- str:  File encoding to use

-- [[ Theme ]]
opt.syntax = "ON"                -- str:  Allow syntax highlighting
opt.termguicolors = true         -- bool: If term supports ui color then enable
cmd([[colorscheme gruvbox]])     -- cmd: Set the colorscheme to gruvbox

-- [[ Search ]]
opt.ignorecase = true               -- bool: Ignore case in search patterns
opt.smartcase = true                -- bool: Override ignorecase if search contains capitals
opt.incsearch = true                -- bool: Use incremental search
opt.hlsearch = false                -- bool: Highlight search matches
opt.wildmode = "longest,list,full"  -- str: Nice menu when typing :find *.py
opt.wildmenu = true                 -- bool: enable wildmenu
-- Ignore files
opt.wildignore:append("*.pyc")      -- str: ignore compiled python files
opt.wildignore:append("**/.git/*")  -- str: ignore git files
-- set wildignore+=**/coverage/*
-- set wildignore+=**/node_modules/*

-- [[ Whitespace ]]
opt.expandtab = true             -- bool: Use spaces instead of tabs
opt.shiftwidth = 4               -- num:  Size of an indent
opt.softtabstop = 4              -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 4                  -- num:  Number of spaces tabs count for
opt.listchars = {                -- pairs: show unprintables
    eol = '↲',                   -- end of line
    tab = '▸ ',                  -- tab characters
    trail = '·'                  -- trailing whitespace
}

-- [[ Splits ]]
opt.splitright = true            -- bool: Place new window to right of current one
opt.splitbelow = true            -- bool: Place new window below the current one

-- [[ Spelling ]]

opt.spelllang = en                  -- list: what languages should be spelled
