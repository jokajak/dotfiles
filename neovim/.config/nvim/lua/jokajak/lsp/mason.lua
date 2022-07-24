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

local status_ok, lspconfig = pcall(require, "mason-lspconfig")

if not status_ok then
  return
end

local status_ok, _ = pcall(require, "lspconfig")

if not status_ok then
  return
end

lspconfig.setup({
    ensure_installed = {
      "sumneko_lua",  -- lua
      "python-lsp-server",  -- python support
      "marksman",  -- markdown
    }
})

lspconfig.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  -- Next, provide targeted overrides for specific servers.
  ["sumneko_lua"] = function ()
    local lsp = lspconfig[lsp]
    if lsp then
      lsp.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      })
    end
  end,
})
