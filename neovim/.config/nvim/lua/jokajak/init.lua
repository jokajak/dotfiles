-- [[ init.lua ]]

-- IMPORTS
require('jokajak/vars')      -- Variables
require('jokajak/opts')      -- Options
require('jokajak/keys')      -- Keymaps
require('jokajak/plug')      -- Plugins`
require('jokajak/lsp')       -- Language Server Protocol

-- PLUGINS
require('nvim-tree').setup({})
require('nvim-autopairs').setup{}

require('lualine').setup {
  options = {
    theme = 'gruvbox'
  }
}

-- setup completion
require('cmp').setup({
  sources = {
    { name = 'nvim_lsp' }
  }
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- The following example advertise capabilities to `clangd`.
require('lspconfig').clangd.setup({
  capabilities = capabilities,
})

-- Set up lsp installer
require("nvim-lsp-installer").setup({})

-- set up python language server
require('lspconfig').pylsp.setup({})
