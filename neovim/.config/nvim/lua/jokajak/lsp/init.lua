-- [[ Language Server Protocol ]]--
local M = {
  event = "BufReadPre",
}

function M.config()
  require("neodev").setup({

  })
  require("mason")
  require("jokajak.lsp.diagnostics").setup()
  require("neoconf").setup()

  local function on_attach(client, bufnr)
    require("jokajak.lsp.formatting").setup(client, bufnr)
    require("jokajak.lsp.keys").setup(client, bufnr)
  end

  local servers = {
    ansiblels = {},
    bashls = {},
    dockerls = {},
    marksman = {},
    pyright = {},
    yamlls = {},
    sumneko_lua = {
      single_file_support = true,
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            workspaceWord = true,
            callSnippet = "Replace",
          },
          diagnostics = {
            unusedLocalExclude = { "_*" },
          }
        },
        format = {
          enable = false,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
            continuation_indent_size = "2",
          }
        }
      }
    },
    vimls = {},
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local cmp_present, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if cmp_present then
    M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  else
    M.capabilities = capabilities
  end
  M.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  ---@type _.lspconfig.options
  local options = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }

  local lspconfig_ok, lspconfig = pcall(require, "lspconfig")

  for server, opts in pairs(servers) do
    opts = vim.tbl_deep_extend("force", {}, options, opts or {})
    if servers == "tsserver" then
      require("typescript").setup({ server = opts })
    else
      if lspconfig then
        lspconfig[server].setup(opts)
      end
    end
  end

  require("jokajak.plugins.null-ls").setup(options)
end

M.config()

return M
