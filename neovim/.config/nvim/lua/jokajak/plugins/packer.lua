-- [[ plug.lua ]]

-- return require('packer').startup(function(use)
--   -- [[ Plugins Go Here ]]
--   use { 'mbbill/undotree' }                          -- persistent undo
--   use { 'tpope/vim-repeat' }                         -- use dot repeating more
--   use { 'rhysd/git-messenger.vim' }                  -- see git commits
--   use { 'jeffkreeftmeijer/vim-numbertoggle' }        -- fancy hybrid lines
--   use { 'stevearc/dressing.nvim' }                   -- fancy displays
-- 
--   -- [[ Theme ]]
--   use { 'mhinz/vim-startify' }                       -- start screen
-- 
--   -- [[ Dev ]]
--   use { 'majutsushi/tagbar' }                        -- code structure
--   use { 'junegunn/gv.vim' }                          -- commit history
--   use { "sbdchd/neoformat" }                         -- code formatter
--   use { 'folke/lua-dev.nvim' }                       -- lua support
-- 
--   -- [[ Language Server Protocol Plugins ]]
--   use { 'mfussenegger/nvim-dap' }                    -- debugger
--   use {
--     "rcarriga/nvim-dap-ui",                          -- debugger ui
--     requires = { "mfussenegger/nvim-dap" }
--   }
-- 
--   if packer_bootstrap then
--     require('packer').sync()
--   end
-- end)