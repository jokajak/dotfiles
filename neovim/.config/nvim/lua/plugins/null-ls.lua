-- https://github.com/jose-elias-alvarez/null-ls.nvim

local M = {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function()
    local nls = require("null-ls")
    return {
      sources = {
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.fish_indent,
        nls.builtins.formatting.shfmt,
        nls.builtins.diagnostics.markdownlint,
        nls.builtins.formatting.black,
      },
    }
  end,
}

return M
