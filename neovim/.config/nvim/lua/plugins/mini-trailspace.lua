-- https://github.com/echasnovski/mini.trailspace/
-- Work with trailing whitespace

local M = {
  "echasnovski/mini.trailspace",
  event = "BufReadPost",
  config = function(_, opts)
    require("mini.trailspace").setup(opts)
  end,
}

return M
