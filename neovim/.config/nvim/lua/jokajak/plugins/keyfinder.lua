-- https://github.com/jokajak/keyfinder.nvim
-- Keyfinder

local M = {
  "jokajak/keyfinder.nvim",
  cmd = {
    "Keyfinder",
  },
}

M.config = function()
  local status_ok, keyfinder = pcall(require, "keyfinder")

  if not status_ok then
    return
  end

  keyfinder.setup({
    key_labels = {
      padding = { 0, 1, 0, 1 }, -- padding around keycap labels [top, right, bottom, left]
      highlight_padding = { 0, 1, 0, 1 }, -- how much of the label to highlight
    },
    layout = "dvorak",
  })
end

return M
