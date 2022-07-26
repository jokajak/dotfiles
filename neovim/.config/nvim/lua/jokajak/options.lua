--[[ opts.lua ]]
local opt = vim.opt

-- [[ Context ]]
opt.colorcolumn = '80'           -- str:  Show col for max line length
opt.number = true                -- bool: Show line numbers
opt.relativenumber = true        -- bool: Show relative line numbers
opt.scrolloff = 4                -- int:  Min num lines of context
opt.signcolumn = "yes"           -- str:  Show the sign column
opt.numberwidth = 4              -- int: Number column width
opt.cursorline = true            -- bool: Show a line under the cursor
opt.cmdheight = 2                -- int: Space in command line for showing messages
opt.clipboard = "unnamedplus"    -- str: Always use system clipboard
opt.scrolloff = 8                -- int: Number of lines to show above or below the cursor
opt.sidescrolloff = 8            -- int: Number of columns to show around cursor
opt.wrap = false                 -- bool: don't wrap long lines
opt.completeopt = "menu,menuone,noselect" -- str: configure completion menu

-- [[ Filetypes ]]
opt.encoding = 'utf8'            -- str:  String encoding to use
opt.fileencoding = 'utf8'        -- str:  File encoding to use

-- [[ Theme ]]
opt.syntax = "ON"                -- str:  Allow syntax highlighting
opt.termguicolors = true         -- bool: If term supports ui color then enable

-- [[ Search ]]
opt.ignorecase = true               -- bool: Ignore case in search patterns
opt.smartcase = true                -- bool: Override ignorecase if search contains capitals
opt.incsearch = true                -- bool: Use incremental search
opt.hlsearch = true                 -- bool: Highlight search matches
opt.wildmode = "longest,list,full"  -- str: Nice menu when typing :find *.py
opt.wildmenu = true                 -- bool: enable wildmenu

-- Ignore files
opt.wildignore:append("*.pyc")      -- str: ignore compiled python files
opt.wildignore:append("**/.git/*")  -- str: ignore git files
opt.wildignore:append("**/coverage/*")
opt.wildignore:append("**/node_modules/*")

-- [[ Whitespace ]]
opt.smartindent = true           -- bool: smart indenting
opt.showtabline = 2              -- int: Always show tab line 
opt.expandtab = true             -- bool: Use spaces instead of tabs
opt.shiftwidth = 2               -- num:  Size of an indent
opt.softtabstop = 2              -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 2                  -- num:  Number of spaces tabs count for
opt.listchars = {                -- pairs: show unprintables
    eol = '↲',                   -- end of line
    tab = '▸ ',                  -- tab characters
    trail = '·'                  -- trailing whitespace
}

-- [[ Splits ]]
opt.splitright = true            -- bool: Place new window to right of current one
opt.splitbelow = true            -- bool: Place new window below the current one

-- [[ Spelling ]]
opt.spelllang = "en"                -- str: what languages should be spelled
opt.iskeyword:append("-")           -- str: add '-' as being part of a word
