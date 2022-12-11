-- https://github.com/mattn/calendar-vim
-- calendar.vim creates a calendar window you can use within vim.

local M = { "mattn/calendar-vim", opt = true, cmd = {
  "Calendar",
  "CalendarH",
  "CalendarT",
} }

M.config = function()
  require("jokajak.plugins.telekasten").config()
end

return M
