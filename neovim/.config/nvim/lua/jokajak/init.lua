require("jokajak.lsp")
require("nvim-treesitter.configs").setup(
	{ highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}
)
require('lspconfig').pylsp.setup(config())
