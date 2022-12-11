-- https://github.com/jose-elias-alvarez/null-ls.nvim

local M = {
  "jose-elias-alvarez/null-ls.nvim",
  module = "null-ls",
}

function M.setup(options)
  local status_ok, nls = pcall(require, "null-ls")

  if not status_ok then
    return
  end

  local default_options = {
    on_attach = require("jokajak.lsp").on_attach
  }
  options = options or default_options
  nls.setup({
    debounce = 150,
    save_after_format = false,
    sources = {
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.fish_indent,
      nls.builtins.formatting.shfmt,
      nls.builtins.diagnostics.markdownlint,
      nls.builtins.formatting.isort,
      nls.builtins.formatting.black,
      nls.builtins.diagnostics.flake8,
    },
    on_attach = options.on_attach,
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
  })
end

function M.has_formatter(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
