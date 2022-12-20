-- custom keymaps per lsp

local M = {}

function M.setup(client, buffer)
  local cap = client.server_capabilities

  local keymap = {
    buffer = buffer
  }
end

return M
