-- https://github.com/edluffy/specs.nvim
-- Show where your cursor moves when jumping large distances (e.g between windows).
-- Fast and lightweight, written completely in Lua.

local M = { "edluffy/specs.nvim" }
local Keymap = require("util.keymap")
M.event = { "BufRead" }
M.opt = true

M.config = function()
  local status_ok, specs = pcall(require, "specs")

  if not status_ok then
    return
  end

  specs.setup({
    show_jumps = true,
    min_jump = 10,
    popup = {
      blend = 5, -- starting blend
      winhl = "Cursor", -- highlight using cursor color
    },
  })
  -- show cursor
  -- Press <C-b> to call specs!
  Keymap.nnoremap("<C-b>", function()
    specs.show_specs()
  end, { silent = true, desc = "Highlight cursor location" })

  -- Bind specs to search jumping
  Keymap.nnoremap("n", 'n:lua require("specs").show_specs()<CR>', { silent = true, desc = "Repeat the last search" })
  Keymap.nnoremap(
    "N",
    'N:lua require("specs").show_specs()<CR>',
    { silent = true, desc = "Repeat the last search in the opposite direction" }
  )
end

return M
