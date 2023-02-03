-- https://github.com/edluffy/specs.nvim
-- Show where your cursor moves when jumping large distances (e.g between windows).
-- Fast and lightweight, written completely in Lua.

local M = {
  "edluffy/specs.nvim",
  event = "BufRead",
  lazy = true,
  keys = {
    {
      "<C-b>",
      function()
        require("specs").show_specs()
      end,
      desc = "Highlight cursor location",
      silent = true,
    },
    { "n", 'n:lua require("specs").show_specs()<CR>', desc = "Repeat the last search", silent = true },
    {
      "N",
      'N:lua require("specs").show_specs()<CR>',
      desc = "Repeat the last search in the opposite direction",
      silent = true,
    },
  },
}
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
end

return M
