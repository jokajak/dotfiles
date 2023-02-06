-- https://github.com/mattn/calendar-vim
-- calendar.vim creates a calendar window you can use within vim.

local M = {
  "mattn/calendar-vim",
  lazy = true,
  cmd = {
    "Calendar",
    "CalendarH",
    "CalendarT",
  },
  dependencies = {
    "renerocksai/telekasten.nvim",
  },
}

return M
