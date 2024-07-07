-- https://git.sr.ht/~swaits/colorsaver.nvim
-- save and synchronize colorscheme
local colorsaver = {
  -- tell LazyVim to stop messing with colorschemes
  { "catppuccin/nvim", name = "catppuccin", enabled = false },
  { "folke/tokyonight.nvim", enabled = false },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "default", -- just some random built-in scheme
    },
  },

  -- load/save our last used colorscheme automatically
  {
    "https://git.sr.ht/~swaits/colorsaver.nvim",
    event = "VimEnter",
    opts = {},
    dependencies = {
      -- load colorschemes as a dependency of colorsaver
      { "EdenEast/nightfox.nvim" },
      { "folke/tokyonight.nvim", enabled = true },
      { "ellisonleao/gruvbox.nvim" },
      { "projekt0n/caret.nvim" },
      { "catppuccin/nvim", name = "catppuccin", enabled = true },
    },
  },
}

return colorsaver
