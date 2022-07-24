-- [[ init.lua ]]

-- IMPORTS
require('jokajak.vars')      -- Variables
require('jokajak.options')      -- Options
require('jokajak.keys')      -- Keymaps
require('jokajak.colorscheme') -- colorscheme
require('jokajak.plugins')      -- Plugins`
require('jokajak.lsp')       -- Language Server Protocol
require('jokajak.autocmds')   -- auto commands

-- PLUGINS
-- -- set up leap
-- require('leap').set_default_keymaps()
-- 
-- -- set up treesitter
-- require('nvim-treesitter.configs').setup({
--   -- A list of parser names, or "all"
--   ensure_installed = {
--       "lua",
--       "markdown",
--       "python",
--       "yaml",
--   },
-- 
--   -- Install parsers synchronously (only applied to `ensure_installed`)
--   sync_install = false,
-- 
--   -- Automatically install missing parsers when entering buffer
--   auto_install = true,
-- 
--   -- List of parsers to ignore installing (for "all")
--   ignore_install = { "javascript" },
-- 
--   highlight = {
--     -- `false` will disable the whole extension
--     enable = true,
-- 
--     -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
--     -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
--     -- the name of the parser)
--     -- list of language that will be disabled
--     disable = { },
-- 
--     -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--     -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--     -- Using this option may slow down your editor, and you may see some duplicate highlights.
--     -- Instead of true it can also be a list of languages
--     additional_vim_regex_highlighting = false,
--   },
--   -- rainbow bracket configs
--   rainbow = {
--     enable = true,
--     -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
--     extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
--     max_file_lines = nil, -- Do not enable for files with more than n lines, int
--   }
-- })
-- 
-- -- Setup gitsigns
-- require('gitsigns').setup({
--   current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
-- })
-- 
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
-- 
-- -- Setup telescope
-- require('telescope').setup({
--     defaults = {
--         mappings = {
--             i = {
--                 ["<c-s>"] = open_in_nvim_tree,
--             },
--             n = {
--                 ["<c-s>"] = open_in_nvim_tree,
--             },
--         },
--     },
-- })
