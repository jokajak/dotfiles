local M = {
  { "kyazdani42/nvim-web-devicons", lazy = false },
  -- utility functions
  { "nvim-lua/plenary.nvim", lazy = false },
  -- UI component library
  { "MunifTanjim/nui.nvim", event = "UIEnter" },
  -- Calculate startup time
  { "dstein64/vim-startuptime", lazy = true, cmd = { "StartupTime" } },
}

return M
