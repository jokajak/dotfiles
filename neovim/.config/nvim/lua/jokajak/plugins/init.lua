-- plugins

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

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
    -- Have packer use a popup window
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
  profile = {
    enable = true,
    threshold = 1,
  }
})

-- Install your plugins here
packer.startup(function(use)
  use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim", }) -- Useful lua functions used by lots of plugins
  use({ "kyazdani42/nvim-web-devicons", }) -- fun icons
  use({ 'MunifTanjim/nui.nvim' }) -- UI component library
  -- make neovim notifications look nice
  use({
    "folke/noice.nvim"
  }) -- look nice
  -- file navigator
  use({ "kyazdani42/nvim-tree.lua", tag = "nightly", })
  use { 'lewis6991/impatient.nvim' } -- improve startup time
  use { 'ggandor/leap.nvim' } -- move within the window
  -- highlight cursor jumps
  use { 'edluffy/specs.nvim',
    opt = true,
    config = function()
      require("jokajak.plugins.specs")
    end,
    setup = function()
      require("jokajak.lazy_load").on_file_open("specs.nvim")
    end
  }

  -- measure startup time
  use({ 'dstein64/vim-startuptime', opt = true, cmd = { "StartupTime" } })

  use({
    "folke/neoconf.nvim",
  })
  -- show keymaps
  use({ "folke/which-key.nvim",
    event = { "BufRead", "BufNewFile" },
    module = "which-key",
    config = function()
      require("jokajak.plugins.which-key")
    end
  })
  -- startup screen
  use { "goolord/alpha-nvim",
    cmd = "Alpha",
    module = "Alpha",
    config = function()
      require("jokajak.plugins.alpha")
    end
  }
  -- practice vim movements
  use({ "tjdevries/train.nvim",
    opt = true,
    cmd = { "TrainWord", "TrainUpDown", "TrainClear", "TrainTextObj" }
  })
  -- show diagnostics
  use { "folke/trouble.nvim",
    opt = true,
    cmd = { "Trouble", "TroubleClose", "TroubleRefresh", "TroubleToggle" },
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
    },
    config = function()
      require("jokajak.plugins.telekasten")
    end,
  }
  -- theme creator
  use { 'rktjmp/lush.nvim', opt = true, cmd = { "Lushify", "LushRunTutorial", "LushRunQuickstart" } }
  -- neovim development

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
  -- code outline window
  use { 'stevearc/aerial.nvim',
    module = "aerial",
    cmd = { "AerialToggle", "AerialOpen", "AerialInfo" },
    config = function()
      require("jokajak.plugins.aerial")
    end,
    after = "neoconf.nvim"
  }
  -- easily wrap text in strings
  use { "kylechui/nvim-surround",
    event = { "InsertEnter" },
    config = function()
      require("jokajak.plugins.surround")
    end
  }
  use { 'anuvyklack/fold-preview.nvim', -- preview folds
    requires = 'anuvyklack/keymap-amend.nvim'
  }
  -- highlight f targets
  use {
    'jinh0/eyeliner.nvim',
    -- event = "BufEnter",
    opt = true,
    config = function()
      require('eyeliner').setup({
        highlight_on_key = false
      })
    end
  }

  -- [[ git ]]--
  -- nicer commits
  use { "rhysd/committia.vim" }
  -- git gutter symbols
  use { 'lewis6991/gitsigns.nvim',
    event = "BufEnter",
    config = function()
      require("jokajak.plugins.gitsigns")
    end
  }
  -- link to repos
  use {
    'ruifm/gitlinker.nvim',
    event = "BufEnter",
    config = function()
      require("jokajak.plugins.gitlinker")
    end,
    requires = 'nvim-lua/plenary.nvim',
  }

  -- [[ Themes ]] --
  use { 'folke/tokyonight.nvim' } -- tokyonight theme
  use { "catppuccin/nvim",
    as = "catppuccin",
    run = ":CatppuccinCompile"
  }
  use { "ellisonleao/gruvbox.nvim" }

  use {
    'nvim-lualine/lualine.nvim', -- statusline
    requires = { 'kyazdani42/nvim-web-devicons',
      opt = true }
  }
  use { "lukas-reineke/indent-blankline.nvim",
    after = "nvim-treesitter",
    config = function()
      require("jokajak.plugins.indentline")
    end
  } -- indent guides
  use { 'akinsho/bufferline.nvim', -- tab like buffer list
    tag = "v2.*",
    requires = "kyazdani42/nvim-web-devicons"
  }
  -- color things that look like colors
  use {
    "norcalli/nvim-colorizer.lua",
    event = { "BufRead", "BufNewFile" },
    config = function()
      local present, colorizer = pcall(require, "nvim-colorizer")
      if present then
        colorizer.setup()
      end
    end
  }

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
  use { "saadparwaiz1/cmp_luasnip",
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
  use({
    "neovim/nvim-lspconfig",
    plugin = "lsp",
  })
  -- package manager for lsp, dap, linters, and formatters
  use({ "williamboman/mason.nvim", config = function() require("jokajak.plugins.mason") end })
  -- lspconfig bridge for mason
  use({ "williamboman/mason-lspconfig.nvim",
    module = "mason-lspconfig",
  })
  -- extra formatting and linting
  use { "jose-elias-alvarez/null-ls.nvim", }

  use({ "folke/neodev.nvim", })

  -- extensible fuzzy finder over lists
  use { 'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    config = function()
      require("jokajak.plugins.telescope")
    end,
  }

  -- [[ TreeSitter ]]--
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = { "BufRead", "BufNewFile" },
    cmd = {
      "TSBufDisable",
      "TSBufEnable",
      "TSDisable",
      "TSDisableAll",
      "TSEnableAll",
      "TSInstallInfo",
      "TSInstall",
      "TSModuleInfo",
      "TSUpdate",
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
    'p00f/nvim-ts-rainbow', -- rainbow brackets
    opt = true,
    requires = { "nvim-treesitter/nvim-treesitter" },
    after = "nvim-treesitter",
  }
  use {
    'nvim-treesitter/playground', -- treesitter playground
    requires = { "nvim-treesitter/nvim-treesitter" },
    opt = true,
    cmd = { "TSPlaygroundToggle" }
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects', -- treesitter based text objects
    opt = true,
    after = "nvim-treesitter",
    requires = { "nvim-treesitter/nvim-treesitter" } -- use something like delete in function
  }
  use {
    'nvim-treesitter/nvim-treesitter-context', -- show current function/class as float window at the top of the window
    opt = true,
    after = "nvim-treesitter",
    requires = { "nvim-treesitter/nvim-treesitter" }
  }
  use {
    'JoosepAlviste/nvim-ts-context-commentstring', -- commentstring support
    opt = true,
    after = "nvim-treesitter",
    requires = { "nvim-treesitter/nvim-treesitter" }
  }
  -- treesitter based hints
  use({
    "mfussenegger/nvim-treehopper",
    config = function()
      vim.cmd [[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
      vim.cmd [[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]
    end,
    after = "nvim-treesitter",
    requires = { "nvim-treesitter/nvim-treesitter" }
  })

  use {
    '~/git/keymaster.nvim',
  }

  -- neotest support
  use({
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim"
    }
  })
  use({
    "nvim-neotest/neotest-plenary",
    requires = {
      "nvim-neotest/neotest",
    }
  })
  use({
    "nvim-neotest/neotest-python",
    requires = {
      "nvim-neotest/neotest",
    }
  })
  use({
    "nvim-neotest/neotest-vim-test",
    requires = {
      "nvim-neotest/neotest",
    }
  })

  -- dap = debugger adapter protocol
  use({
    'mfussenegger/nvim-dap'
  })
  use({
    'mfussenegger/nvim-dap-python',
    require = { "mfussenegger/nvim-dap" }
  })
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

require("jokajak.plugins.bufferline")
require("jokajak.plugins.lualine")
require("jokajak.plugins.impatient")
require("jokajak.plugins.leap")
require("jokajak.plugins.fold-preview")
require("jokajak.plugins.nvim-tree")
require("jokajak.plugins.neotest")
