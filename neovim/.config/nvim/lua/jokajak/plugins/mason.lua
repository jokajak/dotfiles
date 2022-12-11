-- https://github.com/williamboman/mason.nvim
-- Portable package manager for Neovim that runs everywhere Neovim runs.

local M = {
  "williamboman/mason.nvim",
  opt = true,
  module = "mason",
  cmd = {
    "Mason",
    "MasonInstall",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
    "MasonInstallAll", -- custom command
  },
}

M.tools = {
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
}

function M.check()
  local mr = require("mason-registry")
  for _, tool in ipairs(M.tools) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end

M.config = function()
  local status_ok, mason = pcall(require, "mason")

  if not status_ok then
    return
  end

  local options = {
    -- not supported by mason, just convenient
    ensure_installed = {},
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  }

  mason.setup(options)
  M.check()

  vim.api.nvim_create_user_command("MasonInstallAll", function()
    vim.cmd("MasonInstall " .. table.concat(M.tools, " "))
  end, {})

  local mlspconfig_status, mlspconfig = pcall(require, "mason-lspconfig")

  if mlspconfig_status then
    mlspconfig.setup({
      automatic_installation = true,
    })
  end
end

return M
