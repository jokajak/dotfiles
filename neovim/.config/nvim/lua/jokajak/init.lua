-- [[ init.lua ]]

-- IMPORTS
require('jokajak.vars')      -- Variables
require('jokajak.options')      -- Options
require('jokajak.filetypes')      -- Filetypes
require('jokajak.keymaps')      -- Keymaps
require('jokajak.colorscheme') -- colorscheme
require('jokajak.plugins')      -- Plugins`
require('jokajak.lsp')       -- Language Server Protocol
require('jokajak.autocmds')   -- auto commands
local lazy_loader = require('jokajak.lazy_load')  -- lazy load
lazy_loader.git()
