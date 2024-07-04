-- https://github.com/edluffy/specs.nvim
-- Show where your cursor moves when jumping large distances (e.g between windows).
-- Fast and lightweight, written completely in Lua.

local specs = {
  "jokajak/specs.nvim",
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
  opts = {
    show_jumps = true,
    min_jump = 10,
    popup = {
      blend = 5, -- starting blend
      winhl = "Cursor", -- highlight using cursor color
    },
  },
}

return specs
