---
-- Treesitter is a new parser generator tool that we can use in Neovim to power faster and more accurate syntax highlighting.
local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "html", -- for devdocs
    },
  },
}

return treesitter
