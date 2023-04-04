-- https://gitlab.com/HiPhish/nvim-ts-rainbow2
-- This Neovim plugin provides alternating syntax highlighting (“rainbow
-- parentheses”) for Neovim, powered by Tree-sitter.

local treesitter_plugin = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "https://gitlab.com/HiPhish/nvim-ts-rainbow2" },
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts, {
      rainbow = {
        enable = true,
        -- Which query to use for finding delimiters
        query = "rainbow-parens",
        -- Highlight just the local context
        strategy = require("ts-rainbow").strategy.global,
      },
    })
  end,
}

local M = {
  "https://gitlab.com/HiPhish/nvim-ts-rainbow2",
  tag = "v2.1.0",
  lazy = true,
}

return {
  treesitter_plugin,
  M,
}
