  -- plugins

local M = {}

M.plugins = {
  git = {  -- these plugins should be loaded for git repositories
    'lewis6991/gitsigns.nvim',  -- show git stuff in the sidebar
    'ruifm/gitlinker.nvim',              -- link to repos
  }
}

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
-- Plugins that are just `use` are loaded at startup which increases nvim startup time
packer.startup(function(use)
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim", }) -- Useful lua functions used by lots of plugins
	use({ "kyazdani42/nvim-web-devicons", }) -- fun icons
	use({ "kyazdani42/nvim-tree.lua", tag = "nightly" })  -- file navigator
  use { 'lewis6991/impatient.nvim' }                 -- improve startup time
  use { 'ggandor/leap.nvim' }                        -- move within the window
  use { 'edluffy/specs.nvim' }                      -- highlight cursor jumps
  -- measure startup time
  use { 'dstein64/vim-startuptime', opt = true, cmd = { "StartupTime" }}
  use { "folke/which-key.nvim" }  -- help with keymaps
  use { "goolord/alpha-nvim" }  -- startup screen
  use { "tjdevries/train.nvim", opt=true, cmd = {"TrainWord", "TrainUpDown", "TrainClear", "TrainTextObj"} }  -- train vim movements
  -- show diagnostics
  use { "folke/trouble.nvim",
    opt = true,
    cmd = {"Trouble", "TroubleClose", "TroubleRefresh", "TroubleToggle"},
    config = function()
      require("jokajak.plugins.trouble")
    end
  }
  -- note taking
  use { "renerocksai/telekasten.nvim",
    opt = true,
    cmd = {
      "Telekasten",
    },
    config = function()
      require("jokajak.plugins.telekasten")
    end,
  }
  use { "mattn/calendar-vim" }  -- calendar
  use {'rktjmp/lush.nvim', opt = true, cmd = {"Lushify", "LushRunTutorial", "LushRunQuickstart"}}

  -- [[ editing ]]--
  use { 'windwp/nvim-autopairs',
    opt = true,
    after = "nvim-cmp",
    config = function()
      require("jokajak.plugins.autopairs")
    end
  }                    -- automagically manage pairs
  use { "numToStr/Comment.nvim" } -- Easily comment stuff
  use { 'stevearc/aerial.nvim' }  -- code outline window
  use { "kylechui/nvim-surround" } -- easily wrap text in strings
  use { 'anuvyklack/fold-preview.nvim',  -- preview folds
    requires = 'anuvyklack/keymap-amend.nvim'
  }

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
  -- The completion plugin,
  use { "hrsh7th/nvim-cmp",
    after = "friendly-snippets",
    config = function()
      require("jokajak.plugins.completions")
    end,
  }

-- nvim lua completions
  use { "hrsh7th/cmp-nvim-lua",
    after = "cmp_luasnip"
  }

-- lsp completions
  use { "hrsh7th/cmp-nvim-lsp",
    after = "cmp-nvim-lua"
  }
  -- buffer completions
  use { "hrsh7th/cmp-buffer",
    after = "cmp-nvim-lsp"
  }
  -- path completions
  use { "hrsh7th/cmp-path",
    after = "cmp-buffer"
  }
  -- cmdline completions
  use { "hrsh7th/cmp-cmdline",
    after = "cmp-path"
  }
  -- snippet completions
  use  { "saadparwaiz1/cmp_luasnip",
    after = "LuaSnip"
  }

  -- snippets
  --snippet engine
  use { "L3MON4D3/LuaSnip",
    opt = true,
    after = "nvim-cmp",
    config = function()
      require("jokajak.plugins.luasnip")
    end
  }
  -- a bunch of snippets
  use { "rafamadriz/friendly-snippets",
    opt = true,
    module = { "cmp", "cmp_nvim_lsp" },
    event = "InsertEnter"
  }

  -- [[ Language Server Protocol ]] --
  -- Fancy language specific support
  use { "neovim/nvim-lspconfig" } -- lspconfig plugin
  use { "williamboman/mason.nvim",
    opt = true,
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonInstallAll",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    config = function()
      require("jokajak.plugins.mason")
    end,
  }  -- package manager for lsp, dap, linters, and formatters
  use { "williamboman/mason-lspconfig.nvim" }  -- lspconfig bridge for mason
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
require("jokajak.plugins.telescope")
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
