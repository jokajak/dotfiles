local M = {}

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- enable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    width = 60,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    width = 60,
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  local present, illuminate = pcall(require, "illuminate")
  if not present then
    return
  end
  illuminate.on_attach(client)
  -- end
end

local buf_keymap = function(bufnr, mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true, buffer=bufnr }
  if opts then
      options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

local function lsp_keymaps(bufnr)
  buf_keymap(bufnr, "n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
  buf_keymap(bufnr, "n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
  buf_keymap(bufnr, "n", "K", vim.lsp.buf.hover, { desc = "Hover [LSP]" })
  buf_keymap(bufnr, "n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
  buf_keymap(bufnr, "n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_keymap(bufnr, "n", "gr", vim.lsp.buf.references, { desc = "Get references" })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_keymap(bufnr, "n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
  buf_keymap( bufnr, "n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics" })
  buf_keymap(bufnr, "n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
  buf_keymap(bufnr, "n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set location list" })
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

local server_configs = {
  disable_formatter = {
    "pylsp",
    "tsserver",
  }
}

M.on_attach = function(client, bufnr)
  local vim_version = vim.version().minor
  if vim_version == 8 then
    -- 0.8
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  elseif vim_version == 7 then
    -- 0.7
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
  local aerial_available, aerial = pcall(require, "aerial")
  if aerial_available then
    aerial.on_attach(client, bufnr)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_present, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_present then
  M.capabilities = cmp_nvim_lsp.default_capabilities()
else
  M.capabilities = capabilities
end

return M
