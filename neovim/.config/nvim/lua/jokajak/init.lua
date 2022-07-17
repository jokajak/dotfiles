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

-- set up leap
require('leap').set_default_keymaps()

-- set up treesitter
require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all"
  ensure_installed = {
      "lua",
      "python",
      "yaml",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- rainbow bracket configs
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  }
})

-- Setup gitsigns
require('gitsigns').setup({
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
})
