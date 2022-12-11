-- plugins

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
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
      return require("packer.util").float({ border = "single" })
    end,
  },
  profile = {
    enable = true,
    threshold = 1,
  },
})

-- Install your plugins here
packer.startup(function(use)
  -- make neovim notifications look nice
  -- file navigator
  use({ "lewis6991/impatient.nvim" }) -- improve startup time
  use({ "ggandor/leap.nvim" }) -- move within the window
  -- smarter jumplist navigation
  use({
    "cbochs/portal.nvim",
    config = function()
      require("jokajak.plugins.portal")
    end,
    requires = {
      "cbochs/grapple.nvim", -- Optional: provides the "grapple" query item
    },
  })
  -- quick mark based navigation
  use({
    "cbochs/grapple.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("jokajak.plugins.grapple")
    end,
  })
  -- project local custom lua
  use({
    "MunifTanjim/exrc.nvim",
  })

  -- startup screen
  use({
    "goolord/alpha-nvim",
    cmd = "Alpha",
    module = "Alpha",
    config = function()
      require("jokajak.plugins.alpha")
    end,
  })
  -- practice vim movements
  use({
    "tjdevries/train.nvim",
    opt = true,
    cmd = { "TrainWord", "TrainUpDown", "TrainClear", "TrainTextObj" },
  })
  -- show diagnostics
  use({
    "folke/trouble.nvim",
    opt = true,
    cmd = { "Trouble", "TroubleClose", "TroubleRefresh", "TroubleToggle" },
    config = function()
      require("jokajak.plugins.trouble")
    end,
  })
  -- [[ editing ]]--
  -- code outline window
  use({
    "stevearc/aerial.nvim",
    module = "aerial",
    cmd = { "AerialToggle", "AerialOpen", "AerialInfo" },
    config = function()
      require("jokajak.plugins.aerial")
    end,
    after = "neoconf.nvim",
  })
  use({
    "anuvyklack/fold-preview.nvim", -- preview folds
    requires = "anuvyklack/keymap-amend.nvim",
  })
  -- highlight f targets
  use({
    "jinh0/eyeliner.nvim",
    -- event = "BufEnter",
    opt = true,
    config = function()
      require("eyeliner").setup({
        highlight_on_key = false,
      })
    end,
  })

  -- [[ git ]]--
  -- [[ Themes ]] --
  use({ "catppuccin/nvim", as = "catppuccin", run = ":CatppuccinCompile" })
  use({ "ellisonleao/gruvbox.nvim" })

  -- color things that look like colors
  use({
    "norcalli/nvim-colorizer.lua",
    event = { "BufRead", "BufNewFile" },
    config = function()
      local present, colorizer = pcall(require, "nvim-colorizer")
      if present then
        colorizer.setup()
      end
    end,
  })

  -- [[ Language Server Protocol ]] --

  -- treesitter based hints
  use({
    "mfussenegger/nvim-treehopper",
    config = function()
      vim.cmd([[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]])
      vim.cmd([[vnoremap <silent> m :lua require('tsht').nodes()<CR>]])
    end,
    after = "nvim-treesitter",
    requires = { "nvim-treesitter/nvim-treesitter" },
  })

  -- neotest support
  use({
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
  })
  use({
    "nvim-neotest/neotest-plenary",
    requires = {
      "nvim-neotest/neotest",
    },
  })
  use({
    "nvim-neotest/neotest-python",
    requires = {
      "nvim-neotest/neotest",
    },
  })
  use({
    "nvim-neotest/neotest-vim-test",
    requires = {
      "nvim-neotest/neotest",
    },
  })

  -- dap = debugger adapter protocol
  use({
    "mfussenegger/nvim-dap",
  })
  use({
    "mfussenegger/nvim-dap-python",
    require = { "mfussenegger/nvim-dap" },
  })
  use({ "jbyuki/one-small-step-for-vimkind", require = { "mfussenegger/nvim-dap" } })
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
