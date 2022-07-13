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
