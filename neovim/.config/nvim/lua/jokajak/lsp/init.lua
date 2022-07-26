-- [[ Language Server Protocol ]]--
local status_ok, _ = pcall(require, "lspconfig")

if not status_ok then
  return
end

require("jokajak.lsp.mason")
require("jokajak.lsp.handlers").setup()
require("jokajak.lsp.null-ls")