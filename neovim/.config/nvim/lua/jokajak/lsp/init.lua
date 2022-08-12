-- [[ Language Server Protocol ]]--
local status_ok, _ = pcall(require, "lspconfig")

if not status_ok then
  return
end

vim.lsp.set_log_level("debug")
require("jokajak.lsp.mason")
require("jokajak.lsp.handlers").setup()
require("jokajak.lsp.null-ls")
