-- [[ Language Server Protocol ]]--
local present, _ = pcall(require, "lspconfig")

if not present then
  return
end

require("jokajak.lsp.mason")
require("jokajak.lsp.handlers").setup()
require("jokajak.lsp.null-ls")
