local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
local lspconfig = require("lspconfig")
local handlers = require("jokajak.lsp.handlers")

if not status_ok then
  return
end

-- This makes sure the lspconfig integration is installed, I think.
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
