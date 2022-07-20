-- [[ plug.lua ]]
local fn = vim.fn
local install_path = fn.stdpath('config')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- [[ Plugins Go Here ]]
  use { 'lewis6991/impatient.nvim' }                 -- improve startup time
  use { 'wbthomason/packer.nvim'}                    -- packer can manage itself
  use {                                              -- filesystem navigation
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'        -- filesystem icons
  }
  use { 'tpope/vim-commentary' }                     -- comment out lines
  use { 'mbbill/undotree' }                          -- persistent undo
  use { 'tpope/vim-surround' }                       -- easily change quote types
  use { 'vimwiki/vimwiki' }                          -- text based wiki
  use { 'ggandor/leap.nvim' }                        -- move within the window
  use { 'tpope/vim-repeat' }                         -- use dot repeating more
  use { 'tpope/vim-fugitive' }                       -- Git utilities
  use { 'lewis6991/gitsigns.nvim' }                  -- git gutter
  use { 'rhysd/git-messenger.vim' }                  -- see git commits
  use { 'jeffkreeftmeijer/vim-numbertoggle' }        -- fancy hybrid lines
  use { 'stevearc/dressing.nvim' }                   -- fancy displays

  -- [[ Theme ]]
  use { 'mhinz/vim-startify' }                       -- start screen
  use {
      'edluffy/specs.nvim',                       -- highlight cursor jumps
      config = function()
        require("specs").setup({})
    end
  }
  use { "ellisonleao/gruvbox.nvim" }                 -- gruvbox theme in lua
  use {
    'nvim-lualine/lualine.nvim',                     -- statusline
    requires = {'kyazdani42/nvim-web-devicons',
                opt = true}
  }

  -- [[ Dev ]]
  use {
    'nvim-telescope/telescope.nvim',                 -- fuzzy finder
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { 'majutsushi/tagbar' }                        -- code structure
  use { 'Yggdroot/indentLine' }                      -- see indentation
  use { 'junegunn/gv.vim' }                          -- commit history
  use { 'windwp/nvim-autopairs' }                    -- close pairs
  use { "sbdchd/neoformat" }                         -- code formatter
  use { 'folke/lua-dev.nvim' }                       -- lua support

  -- [[ Treesitter ]]
  use {
    'nvim-treesitter/nvim-treesitter',               -- lsp enhancer
    run = ':TSUpdate'
  }
  use {
    "folke/twilight.nvim",                           -- dim code
      config = function()
        require("twilight").setup({ })
    end
  }

  use {
      'p00f/nvim-ts-rainbow',                        -- rainbow brackets
      requires = { "nvim-treesitter/nvim-treesitter"}
  }

  -- [[ Language Server Protocol Plugins ]]
  use {
    "williamboman/nvim-lsp-installer",               -- lsp installer
    "neovim/nvim-lspconfig",                         -- configurations for nvim lsp
  }
  use { 'hrsh7th/cmp-nvim-lsp' }                     -- cmp source for language server clients
  use { 'hrsh7th/cmp-buffer' }                       -- cmp source for buffer words
  use { 'hrsh7th/cmp-path' }                         -- cmp source for filesystem paths
  use { 'hrsh7th/cmp-cmdline' }                      -- cmp source for vim's cmdline
  use { 'hrsh7th/nvim-cmp' }                         -- completion engine
  use { 'mfussenegger/nvim-dap' }                    -- debugger
  use {
    "rcarriga/nvim-dap-ui",                          -- debugger ui
    requires = { "mfussenegger/nvim-dap" }
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
