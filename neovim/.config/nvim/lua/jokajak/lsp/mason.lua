local status_ok, mason = pcall(require, "mason")

if not status_ok then
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
local lspconfig = require("lspconfig")
local handlers = require("jokajak.lsp.handlers")

if not status_ok then
  return
end

-- This makes sure the lspconfig integration is installed, I think.
mason_lspconfig.setup({
    ensure_installed = {
      "sumneko_lua",  -- lua lsp
      "python-lsp-server",  -- python lsp
      "marksman",  -- markdown lsp
      "flake8",  -- python formatter
      "shellcheck",  -- shellcheck
    }
})

mason_lspconfig.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    local opts = {
      on_attach = handlers.on_attach,
      capabilities = handlers.capabilities
    }
    lspconfig[server_name].setup(opts)
  end,
  -- Next, provide targeted overrides for specific servers.
  ["sumneko_lua"] = function(server_name)
    local lsp = lspconfig[server_name]
    local opts = {
      on_attach = handlers.on_attach,
      capabilities = handlers.capabilities
    }
    local sumneko_opts = require("jokajak.lsp.settings.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    if lsp then
      lsp.setup(opts)
    end
  end,
  ["pylsp"] = function(server_name)
    local lsp = lspconfig[server_name]
    local opts = {
      on_attach = handlers.on_attach,
      capabilities = handlers.capabilities
    }
    local pylsp_opts = require("jokajak.lsp.settings.pylsp")
	 	opts = vim.tbl_deep_extend("force", pylsp_opts, opts)
    if lsp then
      lsp.setup(opts)
    end
  end
})

local status_ok, mason_tool_installer = pcall(require, "mason-tool-installer")

if not status_ok then
  return
end

mason_tool_installer.setup({

    -- a list of all tools you want to ensure are installed upon
    -- start; they should be the names Mason uses for each tool
    ensure_installed = {
        -- you can turn off/on auto_update per tool
        -- shell
        { 'bash-language-server', auto_update = false },
        'shellcheck',
        'misspell',
        'shellcheck',
        'shfmt',
        -- python
        'flake8',
        'black',
        'python-lsp-server',
        -- lua
        'lua-language-server',
        'stylua',
        'luacheck',
        -- editorconfig
        'editorconfig-checker',
        -- yaml
        'yamllint',
    },

    -- if set to true this will check each tool for updates. If updates
    -- are available the tool will be updated.
    -- Default: false
    auto_update = false,

    -- automatically install / update on startup. If set to false nothing
    -- will happen on startup. You can use `:MasonToolsUpdate` to install
    -- tools and check for updates.
    -- Default: true
    run_on_start = false
})
