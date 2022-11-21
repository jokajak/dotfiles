local status_ok, mason = pcall(require, "mason")

if not status_ok then
  return
end

local options = {
  -- not supported by mason, just convenient
  ensure_installed = {
    'misspell',
    -- editorconfig
    'editorconfig-checker',
    -- lua
    'lua-language-server',
    'stylua',
    'luacheck',
    "sumneko_lua",  -- lua lsp
    -- markdown
    "marksman",  -- markdown lsp
    -- python
    'flake8',
    'black',
    "python-lsp-server",  -- python lsp
    -- shell
    'bash-language-server',
    "shellcheck",  -- shellcheck
    'shfmt',
    -- yaml
    'yamllint',
  },
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
}

vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
end, {})

mason.setup(options)

local mlspconfig_status, mlspconfig = pcall(require, "mason-lspconfig")

if mlspconfig_status then
  mlspconfig.setup({
    automatic_installation = true
  })
end
