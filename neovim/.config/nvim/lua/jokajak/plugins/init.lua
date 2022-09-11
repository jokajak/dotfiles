  -- plugins

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local compile_path = fn.stdpath('data')..'/packer_compiled.lua'

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
  auto_clean = true,
  compile_on_sync = true,
  git = { clone_timeout = 6000 },
  display = {
    working_sym = "ﲊ",
    error_sym = "✗ ",
    done_sym = " ",
    removed_sym = " ",
    moved_sym = "",
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
})

-- Install your plugins here
packer.startup(function(use)
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim", }) -- Useful lua functions used by lots of plugins
	use({ "kyazdani42/nvim-web-devicons", }) -- fun icons
  -- file navigator
	use({ "kyazdani42/nvim-tree.lua", tag = "nightly", })
  use { 'lewis6991/impatient.nvim' }                 -- improve startup time
  use { 'ggandor/leap.nvim' }                        -- move within the window
  -- highlight cursor jumps
  use { 'edluffy/specs.nvim',
    opt = true,
    config = function()
      require("jokajak.plugins.specs")
    end,
    setup = function()
      require("jokajak.lazy_load").on_file_open("specs.nvim")
    end
  }                      -- highlight cursor jumps
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
  -- calendar, useful with telekasten
  use { "mattn/calendar-vim",
    opt = true,
    cmd = {
      "Calendar",
      "CalendarH",
      "CalendarT",
    }
  }
  -- theme creator
  use {'rktjmp/lush.nvim', opt = true, cmd = {"Lushify", "LushRunTutorial", "LushRunQuickstart"}}

  -- [[ editing ]]--
  -- manage pairs of characters
  use { 'windwp/nvim-autopairs',
    opt = true,
    after = "nvim-cmp",
    config = function()
      require("jokajak.plugins.autopairs")
    end
  }
  -- easily comment stuff
  use { "numToStr/Comment.nvim",
    opt = true,
    keys = { "gc", "gb" },
    module = "Comment",
    config = function()
      require("jokajak.plugins.comment")
    end,
  }
  use { 'stevearc/aerial.nvim' }  -- code outline window
  use { "kylechui/nvim-surround" } -- easily wrap text in strings
  use { 'anuvyklack/fold-preview.nvim',  -- preview folds
    requires = 'anuvyklack/keymap-amend.nvim'
  }
  -- highlight f targets
  use {
  'jinh0/eyeliner.nvim',
  config = function()
    require'eyeliner'.setup {
      highlight_on_key = false
    }
  end
}

  -- [[ git ]]--
  use { 'lewis6991/gitsigns.nvim' }                  -- git gutter
  use {
    'ruifm/gitlinker.nvim',              -- link to repos
    requires = 'nvim-lua/plenary.nvim',
  }

  -- [[ Themes ]] --
  use { 'folke/tokyonight.nvim' }                    -- tokyonight theme
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "ellisonleao/gruvbox.nvim" }
  use {
    'nvim-lualine/lualine.nvim',                     -- statusline
    requires = {'kyazdani42/nvim-web-devicons',
                opt = true}
  }
  use { "lukas-reineke/indent-blankline.nvim",
    after = "nvim-treesitter",
    config = function()
      require("jokajak.plugins.indentline")
    end
  }  -- indent guides
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
  use { "neovim/nvim-lspconfig",
    opt = false,
    setup = function()
      require("jokajak.lazy_load").on_file_open("nvim-lspconfig")
    end,
  }
  -- package manager for lsp, dap, linters, and formatters
  use { "williamboman/mason.nvim",
    opt = false,
    config = function()
      require("jokajak.plugins.mason")
    end,
  }
  -- lspconfig bridge for mason
  use { "williamboman/mason-lspconfig.nvim",
    opt = false,
    after = "mason.nvim"
  }
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters

  -- extensible fuzzy finder over lists
  use { 'nvim-telescope/telescope.nvim',
    opt = true,
    cmd = "Telescope",
    config = function()
      require("jokajak.plugins.telescope")
    end,
  }

  -- [[ TreeSitter ]]--
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    module = "nvim-treesitter",
    cmd = {
      "TSInstall",
      "TSBufEnable",
      "TSBufDisable",
      "TSEnable",
      "TSDisable",
      "TSModuleInfo",
    },
    config = function()
      require("jokajak.plugins.treesitter")
    end,
  }
  use { "folke/twilight.nvim",
    opt = true,
    config = function()
      require("jokajak.plugins.twilight")
    end,
    cmd = {
      "Twilight",
      "TwilightDisable",
      "TwilightEnable",
    }
  } -- dim code
  use {
      'p00f/nvim-ts-rainbow',                        -- rainbow brackets
      opt = true,
      requires = { "nvim-treesitter/nvim-treesitter" },
      after = "nvim-treesitter",
  }
  use {
      'nvim-treesitter/playground',                        -- treesitter playground
      requires = { "nvim-treesitter/nvim-treesitter" },
      opt = true,
      cmd = { "TSPlaygroundToggle" }
  }
  use {
      'nvim-treesitter/nvim-treesitter-textobjects',       -- treesitter based text objects
      opt = true,
      after = "nvim-treesitter",
      requires = { "nvim-treesitter/nvim-treesitter" }      -- use something like delete in function
  }
  use {
      'nvim-treesitter/nvim-treesitter-context',       -- show current function/class as float window at the top of the window
      opt = true,
      after = "nvim-treesitter",
      requires = { "nvim-treesitter/nvim-treesitter" }
  }
  use {
      'JoosepAlviste/nvim-ts-context-commentstring',  -- commentstring support
      opt = true,
      after = "nvim-treesitter",
      requires = { "nvim-treesitter/nvim-treesitter" }
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

require("jokajak.plugins.gitsigns")
require("jokajak.plugins.bufferline")
require("jokajak.plugins.lualine")
require("jokajak.plugins.which-key")
require("jokajak.plugins.gitlinker")
require("jokajak.plugins.impatient")
require("jokajak.plugins.alpha")
require("jokajak.plugins.aerial")
require("jokajak.plugins.leap")
require("jokajak.plugins.surround")
require("jokajak.plugins.fold-preview")
require("jokajak.plugins.nvim-tree")
