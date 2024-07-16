-- https://github.com/code-biscuits/nvim-biscuits
-- Show context of what starts a block

local biscuits = {
  "code-biscuits/nvim-biscuits",
  event = "VeryLazy",
  opts = {
    on_events = { "InsertLeave", "CursorHoldI" },
    cursor_line_only = true,
    show_on_start = true,
  },
  keys = {
    {
      "<leader>uzb",
      function()
        local nvim_biscuits = require("nvim_biscuits")
        nvim_biscuits.toggle_biscuits()
      end,
      desc = "Toggle biscuits",
      mode = "n",
    },
  },
}

return biscuits
