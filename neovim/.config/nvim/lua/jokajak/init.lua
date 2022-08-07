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

-- PLUGINS

-- local open_in_nvim_tree = function(prompt_bufnr)
--     -- Open a telescope result in nvim-tree
--     local action_state = require("telescope.actions.state")
--     local Path = require("plenary.path")
--     local actions = require("telescope.actions")
-- 
--     local entry = action_state.get_selected_entry()[1]
--     local entry_path = Path:new(entry):parent():absolute()
--     actions._close(prompt_bufnr, true)
--     entry_path = Path:new(entry):parent():absolute() 
--     entry_path = entry_path:gsub("\\", "\\\\")
-- 
--     vim.cmd("NvimTreeClose")
--     vim.cmd("NvimTreeOpen " .. entry_path)
-- 
--     file_name = nil
--     for s in string.gmatch(entry, "[^/]+") do
--         file_name = s
--     end
-- 
--     vim.cmd("/" .. file_name)
-- end
