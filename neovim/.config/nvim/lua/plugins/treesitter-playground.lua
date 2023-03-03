-- https://github.com/nvim-treesitter/playground
-- View treesitter information directly in neovim!

local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/playground" },
  opts = {
    playground = {
      enable = true,
      updatetime = 25, -- debounced time for highlighting nodes in the playground from source code
      persist_queries = false,
    },
  },
}

local playground = {
  "nvim-treesitter/playground",
  lazy = true,
  cmd = {
    "TSHighlightCapturesUnderCursor",
    "TSNodeUnderCursor",
    "TSPlayground",
  },
}

return {
  treesitter,
  playground,
}
