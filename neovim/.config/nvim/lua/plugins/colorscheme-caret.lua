-- https://github.com/projekt0n/caret.nvim
local caret = {
  "projekt0n/caret.nvim",
  lazy = true, -- make sure we load this during startup if it is your main colorscheme
  config = function()
    require("caret").setup({})
  end,
}

return caret
