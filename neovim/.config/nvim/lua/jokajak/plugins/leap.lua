-- https://github.com/ggandor/leap.nvim
--[[ leap configuration ]]

local M = { "ggandor/leap.nvim", event = "BufEnter" }
--

M.config = function()
  local status_ok, leap = pcall(require, "leap")

  if not status_ok then
    return
  end

  leap:set_default_keymaps()
end

return M
