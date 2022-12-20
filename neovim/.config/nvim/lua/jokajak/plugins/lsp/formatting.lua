-- LSP formatting configuration

local M = {}

M.autoformat = true

function M.toggle()
  M.autoformat = not M.autoformat
  if M.autoformat then
    print("enabled format on save")
  else
    print("disabled format on save")
  end
end

function M.format()
  if M.autoformat then
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    else
      vim.lsp.buf.formatting_sync()
    end
  end
end

function M.setup(client, buffer)
  local ft = vim.api.nvim_buf_get_option(buffer, "filetype")
  local nls = require("jokajak.plugins.null-ls")

  local enable = false
  if nls and nls.has_formatter(ft) then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end

  if client.name == "tsserver" then
    enable = false
  end

  client.server_capabilities.documentFormattingProvider = enable

  if client.server_capabilities.documentFormattingProvider then
    vim.cmd([[
      augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua require("jokajak.plugins.lsp.formatting").format()
      augroup END
    ]])
  end

end

return M
