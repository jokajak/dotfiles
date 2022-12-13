-- https://github.com/catppuccin/nvim
-- Catppuccin is a community-driven pastel theme that aims to be the middle ground
-- between low and high contrast themes.

local M = {
  "catppuccin/nvim",
  as = "catppuccin",
  cmd = {
    "CatppuccinCompile",
    "Catppuccin",
  },
}

M.config = function()
  local status_ok, catppuccin = pcall(require, "catppuccin")

  if not status_ok then
    return
  end

  local integration_mapping = {
    ["gitsigns.nvim"] = "gitsigns",
    ["mini.nvim"] = "mini",
    ["noice.nvim"] = "noice",
    ["nvim-cmp"] = "cmp",
    ["nvim-tree.lua"] = "nvim_tree",
    ["nvim-treesitter"] = "treesitter",
    ["nvim-treesitter-context"] = "treesitter_context",
    ["nvim-ts-rainbow"] = "ts_rainbow",
    ["telekasten.nvim"] = "telekasten",
    ["telescope.nvim"] = "telescop",
    ["which-key.nvim"] = "Which_key",
  }
  local integrations = {}

  for plugin, _ in packer_plugins do
    integrations[integration_mapping[plugin] or plugin] = true
  end

  catppuccin.setup({
    integrations = integrations,
  })
end

return M
