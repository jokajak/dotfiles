-- https://github.com/folke/neodev.nvim
-- Neovim setup for init.lua and plugin development with full signature help,
-- docs and completion for the nvim lua API.
local M = {
  "folke/neodev.nvim",
  event = "VimEnter",
  module = "neodev",
}

-- TODO: Make this only load for nvim
M.config = function()
  -- neodev configuration
  local neodev_status, neodev = pcall(require, "neodev")

  if not neodev_status then
    return
  end

  neodev.setup({
    library = {
      plugins = { "neotest" },
      types = true,
    },
  })
end

return M
