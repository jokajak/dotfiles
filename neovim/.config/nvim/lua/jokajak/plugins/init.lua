-- plug
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local cache_path = fn.stdpath('cache')..'/plugin/packer_compiled.lua'

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  print("Installed packer, close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Failed to load packer, cannot install plugins.")
	return
end

-- Have packer use a popup window
packer.init({
  compile_path = cache_path,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
packer.startup(function(use)
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" }) -- Useful lua functions used by lots of plugins
	use({ "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" }) -- fun icons
	use({ "kyazdani42/nvim-tree.lua", tag = "nightly" })  -- file navigator
  use { 'lewis6991/impatient.nvim' }                 -- improve startup time
  use { 'ggandor/leap.nvim' }                        -- move within the window
  use { 'edluffy/specs.nvim' }                      -- highlight cursor jumps
  use { "folke/which-key.nvim" }  -- help with keymaps
  use { "goolord/alpha-nvim" }  -- startup screen
  use { "tjdevries/train.nvim" }  -- train vim movements
  use { "folke/trouble.nvim" }  -- show diagnostics
  use { "renerocksai/telekasten.nvim" }  -- note taking/management
  use { "mattn/calendar-vim" }  -- calendar
  use { "dstein64/vim-startuptime" }  -- measure startup time

  -- [[ editing ]]--
  use { 'windwp/nvim-autopairs' }                    -- automagically manage pairs
  use { "numToStr/Comment.nvim" } -- Easily comment stuff
  use { 'stevearc/aerial.nvim' }  -- code outline window
  use { "kylechui/nvim-surround" } -- easily wrap text in strings
  use { 'anuvyklack/fold-preview.nvim',  -- preview folds
    requires = 'anuvyklack/keymap-amend.nvim'
  }
  use { 'famiu/bufdelete.nvim' }  -- better buffer delete handling

  -- [[ git ]]--
  use { 'lewis6991/gitsigns.nvim' }                  -- git gutter
  use {
    'ruifm/gitlinker.nvim',              -- link to repos
    requires = 'nvim-lua/plenary.nvim',
  }

  -- [[ Themes ]] --
  use { 'folke/tokyonight.nvim' }                    -- tokyonight theme
  use {
    'nvim-lualine/lualine.nvim',                     -- statusline
    requires = {'kyazdani42/nvim-web-devicons',
                opt = true}
  }
  use { "lukas-reineke/indent-blankline.nvim" }  -- indent guides
  use { 'akinsho/bufferline.nvim',  -- tab like buffer list
    tag = "v2.*",
    requires = "kyazdani42/nvim-web-devicons"
  }
  use { 'norcalli/nvim-colorizer.lua' } -- colorize things that look like color

  -- Completion plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"  -- lsp completions
  use "hrsh7th/cmp-nvim-lua"  -- nvim lua completions

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- [[ Language Server Protocol ]] --
  -- Fancy language specific support
  use { "neovim/nvim-lspconfig" } -- lspconfig plugin
  use { "williamboman/mason.nvim" }  -- package manager for lsp, dap, linters, and formatters
  use { "williamboman/mason-lspconfig.nvim" }  -- lspconfig bridge for mason
  use { 'WhoIsSethDaniel/mason-tool-installer.nvim' }  -- mason tool installer
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters

  use { 'nvim-telescope/telescope.nvim' }  -- fuzzy finder

  -- [[ TreeSitter ]]--
  use {
    'nvim-treesitter/nvim-treesitter',               -- lsp enhancer
    run = ':TSUpdate'
  }
  use { "folke/twilight.nvim" } -- dim code
  use {
      'p00f/nvim-ts-rainbow',                        -- rainbow brackets
      requires = { "nvim-treesitter/nvim-treesitter" }
  }
  use {
      'nvim-treesitter/playground',                        -- treesitter playground
      requires = { "nvim-treesitter/nvim-treesitter" }
  }
  use {
      'nvim-treesitter/nvim-treesitter-textobjects',       -- treesitter based text objects
      requires = { "nvim-treesitter/nvim-treesitter" }      -- use something like delete in function
  }
  use {
      'nvim-treesitter/nvim-treesitter-context',       -- show current function/class as float window at the top of the window
      requires = { "nvim-treesitter/nvim-treesitter" }
  }
  use {
    'JoosepAlviste/nvim-ts-context-commentstring',  -- commentstring support
    requires = { "nvim-treesitter/nvim-treesitter" }
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

require("jokajak.plugins.nvim-tree")
require("jokajak.plugins.completions")
require("jokajak.plugins.telescope")
require("jokajak.plugins.autopairs")
require("jokajak.plugins.comment")
require("jokajak.plugins.gitsigns")
require("jokajak.plugins.specs")
require("jokajak.plugins.bufferline")
require("jokajak.plugins.lualine")
require("jokajak.plugins.which-key")
require("jokajak.plugins.gitlinker")
require("jokajak.plugins.indentline")
require("jokajak.plugins.impatient")
require("jokajak.plugins.twilight")
require("jokajak.plugins.alpha")
require("jokajak.plugins.aerial")
require("jokajak.plugins.leap")
require("jokajak.plugins.surround")
require("jokajak.plugins.fold-preview")
require("jokajak.plugins.trouble")
require("jokajak.plugins.telekasten")
