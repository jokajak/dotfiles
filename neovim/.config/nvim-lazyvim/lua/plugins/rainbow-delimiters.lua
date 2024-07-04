-- https://gitlab.com/HiPhish/rainbow-delimiters.nvim
-- This Neovim plugin provides alternating syntax highlighting (“rainbow
-- parentheses”) for Neovim, powered by Tree-sitter.

local rainbow_delimiters = {
  "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
  lazy = true,
  event = "BufRead",
  config = function(_, opts)
    local rainbow_delimiters = require("rainbow-delimiters")
    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        vim = rainbow_delimiters.strategy["local"],
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
      },
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
    }
  end,
}

return rainbow_delimiters
