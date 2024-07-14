-- https://git.sr.ht/~swaits/colorsaver.nvim
-- save and synchronize colorscheme
local colorsaver = {
  -- load/save our last used colorscheme automatically
  {
    "https://git.sr.ht/~swaits/colorsaver.nvim",
    -- event = "VimEnter",
    enabled = false,
    opts = {},
    dependencies = {
      -- load colorschemes as a dependency of colorsaver
      { "EdenEast/nightfox.nvim" },
      { "folke/tokyonight.nvim", enabled = true },
      { "ellisonleao/gruvbox.nvim" },
      { "catppuccin/nvim", name = "catppuccin", enabled = true },
    },
  },
}

return colorsaver
