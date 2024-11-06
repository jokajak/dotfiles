-- https://github.com/EvWilson/spelunk.nvim
-- Navigate through bookmarks
local spelunk = {
  "EvWilson/spelunk.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- For window drawing utilities
    "nvim-telescope/telescope.nvim", -- Optional: for fuzzy search capabilities
  },
  config = function()
    require("spelunk").setup({
      enable_persist = true,
    })
  end,
}
return spelunk
