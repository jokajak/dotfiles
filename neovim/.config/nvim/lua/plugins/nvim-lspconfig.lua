local M = {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      ansiblels = {},
      bashls = {},
      dockerls = {},
      marksman = {},
      pylsp = {},
      yamlls = {},
      terraformls = {},
      vimls = {},
    },
  },
}

return M
