-- OXY2DEV/markview.nvim
-- Markdown view improvements

local markview = {
  "OXY2DEV/markview.nvim",
  -- Pending https://github.com/OXY2DEV/markview.nvim/issues/58
  enabled = false,
  dependencies = {
    -- You may not need this if you don't lazy load
    -- Or if the parsers are in your $RUNTIMEPATH
    "nvim-treesitter/nvim-treesitter",

    "nvim-tree/nvim-web-devicons",
  },
  ft = {
    "markdown",
  },
}
return markview
