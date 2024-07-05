-- https://github.com/cbochs/portal.nvim
-- Look at you, sailing through the [jumplist] majestically, like an eagle... piloting a blimp.

local M = {
  "cbochs/portal.nvim",
  dependencies = { "cbochs/grapple.nvim" },
  lazy = true,
  keys = {
    {
      "[p",
      "<cmd>Portal jumplist backward<cr>",
      desc = "Prev [p]ortal jump",
    },
    {
      "]p",
      "<cmd>Portal jumplist forward<cr>",
      desc = "Next [p]ortal jump",
    },
  },
}

return M
