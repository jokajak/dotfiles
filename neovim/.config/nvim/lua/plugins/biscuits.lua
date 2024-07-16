-- https://github.com/code-biscuits/nvim-biscuits
-- Show context of what starts a block

local biscuits = {
  "code-biscuits/nvim-biscuits",
  event = "VeryLazy",
  opts = {
    on_events = { "InsertLeave", "CursorHoldI" },
    cursor_line_only = true,
  },
  keys = {
    {
      "<leader>uzb",
      function()
        require("nvim-biscuits").toggle_biscuits()
      end,
      desc = "Toggle biscuits",
    },
  },
}

return biscuits
