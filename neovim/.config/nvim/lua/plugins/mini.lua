-- https://github.com/echasnovski/mini.nvim
-- so many wondeful plugins

local mini = {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    -- git integration
    require("mini.git").setup({})

    -- https://github.com/echasnovski/mini.trailspace/
    -- Work with trailing whitespace
    require("mini.trailspace").setup({})
  end,
}

return mini
