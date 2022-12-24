-- small plugins to be loaded by lazy.nvim
local M = {
  -- utility functions
  "nvim-lua/plenary.nvim",
  -- UI component library
  "MunifTanjim/nui.nvim",
  -- Calculate startup time
  { "dstein64/vim-startuptime", lazy = true, cmd = { "StartupTime" } },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  },
}

return M
