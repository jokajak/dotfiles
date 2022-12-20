-- https://github.com/williamboman/mason-lspconfig.nvim
-- lspconfig bridge for mason

local M = {
  "williamboman/mason-lspconfig.nvim",
  module = "mason-lspconfig",
  lazy = false,
  dependencies = {
    "williamboman/mason.nvim",
  },
}

return M
