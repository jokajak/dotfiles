-- [[ Context ]]
vim.opt.colorcolumn = '80' -- str:  Show col for max line length
vim.opt.number = true -- bool: Show line numbers
-- vim.opt.relativenumber = true        -- bool: Show relative line numbers
vim.opt.scrolloff = 4 -- int:  Min num lines of context
vim.opt.signcolumn = "yes" -- str:  Show the sign column
vim.opt.numberwidth = 4 -- int: Number column width
vim.opt.cursorline = true -- bool: Show a line under the cursor
vim.opt.cmdheight = 2 -- int: Space in command line for showing messages
vim.opt.clipboard = "unnamedplus" -- str: Always use system clipboard
vim.opt.scrolloff = 8 -- int: Number of lines to show above or below the cursor
vim.opt.sidescrolloff = 8 -- int: Number of columns to show around cursor
vim.opt.wrap = false -- bool: don't wrap long lines
vim.opt.completeopt = "menu,menuone,noselect" -- str: configure completion menu
vim.opt.foldminlines = 2 -- int: minimum number of lines in a fold
vim.opt.foldlevelstart = 10 -- int: start with folds greater than N folded
vim.opt.exrc = false -- disable built-in local config file support in favor of exrc.nvim

-- [[ Filetypes ]]
vim.opt.encoding = 'utf8' -- str:  String encoding to use
vim.opt.fileencoding = 'utf8' -- str:  File encoding to use

-- [[ Theme ]]
vim.opt.syntax = "ON" -- str:  Allow syntax highlighting
vim.opt.termguicolors = true -- bool: If term supports ui color then enable

-- [[ Search ]]
vim.opt.ignorecase = true -- bool: Ignore case in search patterns
vim.opt.smartcase = true -- bool: Override ignorecase if search contains capitals
vim.opt.incsearch = true -- bool: Use incremental search
vim.opt.hlsearch = true -- bool: Highlight search matches
vim.opt.wildmode = "longest,list,full" -- str: Nice menu when typing :find *.py
vim.opt.wildmenu = true -- bool: enable wildmenu

-- Ignore files
vim.opt.wildignore:append("*.pyc") -- str: ignore compiled python files
vim.opt.wildignore:append("**/.git/*") -- str: ignore git files
vim.opt.wildignore:append("**/coverage/*")
vim.opt.wildignore:append("**/node_modules/*")

-- [[ Whitespace ]]
vim.opt.smartindent = true -- bool: smart indenting
vim.opt.showtabline = 2 -- int: Always show tab line
vim.opt.expandtab = true -- bool: Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- num:  Size of an indent
vim.opt.softtabstop = 2 -- num:  Number of spaces tabs count for in insert mode
vim.opt.tabstop = 2 -- num:  Number of spaces tabs count for
vim.opt.listchars = { -- pairs: show unprintables
  eol = '↲', -- end of line
  tab = '▸ ', -- tab characters
  trail = '·' -- trailing whitespace
}
vim.opt.breakindent = true -- make horizontal indent continue

-- [[ Splits ]]
vim.opt.splitright = true -- bool: Place new window to right of current one
vim.opt.splitbelow = true -- bool: Place new window below the current one

-- [[ Spelling ]]
vim.opt.spelllang = "en" -- str: what languages should be spelled
vim.opt.iskeyword:append("-") -- str: add '-' as being part of a word

-- set background based on time
local now = os.date("*t")

if (6 <= now.hour) and (now.hour <= 20) then
  vim.opt.background = "light"
else
  vim.opt.background = "dark"
end
