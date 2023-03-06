-- https://github.com/echasnovski/mini.bracketed/
-- Go forward/backward with square brackets

local M = {
  "echasnovski/mini.bracketed",
  version = false,
  event = "VeryLazy",
  config = function(_, opts)
    require("mini.bracketed").setup(opts)
  end,
}

return M
