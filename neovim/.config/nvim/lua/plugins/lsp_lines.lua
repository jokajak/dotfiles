-- https://git.sr.ht/~whynothugo/lsp_lines.nvim
-- lsp_lines is a simple neovim plugin that renders diagnostics using virtual lines on top of the real line of code.

-- for example:
--[[
1: some line of bad code
   |-- Syntax error
2: Good code
]]
--
local lsp_lines = {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    vim.diagnostic.config({ virtual_lines = false })
    require("lsp_lines").setup()
  end,
  event = "LspAttach",
  keys = {
    {
      "<leader>uL",
      function()
        if vim.diagnostic.config().virtual_lines then
          vim.diagnostic.config({ virtual_lines = false })
        else
          vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
        end
      end,
      desc = "Toggle lsp_lines",
    },
  },
}

return lsp_lines
