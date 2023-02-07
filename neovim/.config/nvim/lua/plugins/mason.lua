-- https://github.com/williamboman/mason.nvim
-- Portable package manager for Neovim that runs everywhere Neovim runs.

local M = {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "prettierd",
      "selene",
      "misspell",
      -- editorconfig
      "editorconfig-checker",
      -- lua
      "lua-language-server",
      "stylua",
      "luacheck",
      -- markdown
      "marksman", -- markdown lsp
      -- python
      "flake8",
      "black",
      "isort",
      "python-lsp-server", -- python lsp
      -- shell
      "bash-language-server",
      "shellcheck", -- shellcheck
      "shfmt",
      -- yaml
      "yamllint",
    },
  },
}

return M
