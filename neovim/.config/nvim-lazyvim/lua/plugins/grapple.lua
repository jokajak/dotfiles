-- https://github.com/cbochs/grapple.nvim
-- Grapple is a plugin that aims to provide immediate navigation to important files
-- (and its last known cursor location) by means of persistent file tags within a
-- project scope.

local M = {
  "cbochs/grapple.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>m",
      function()
        require("grapple").toggle()
      end,
      desc = "Toggle grapple [m]ark",
    },
  },
}

return M
