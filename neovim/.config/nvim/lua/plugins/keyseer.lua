-- https://github.com/jokajak/keyfinder.nvim
-- KeySer

local M = {
  "jokajak/keyseer.nvim",
  cmd = {
    "KeySeer",
  },
  dev = true,
  opts = {
    key_labels = {
      padding = { 1, 1, 1, 1 }, -- padding around keycap labels [top, right, bottom, left]
      highlight_padding = { 0, 1, 0, 1 }, -- how much of the label to highlight
    },
    layout = "dvorak",
  },
}

return M
