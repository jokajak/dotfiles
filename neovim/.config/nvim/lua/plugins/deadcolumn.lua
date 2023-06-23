-- https://github.com/Bekaboo/deadcolumn.nvim
-- Display a column for textwidth

local plugin = {
  "Bekaboo/deadcolumn.nvim",
  event = "BufRead",
  opts = {
    modes = {
      "n", -- display in normal mode too
      "i",
      "ic",
      "ix",
      "R",
      "Rc",
      "Rx",
      "Rv",
      "Rvc",
      "Rvx",
    },
    extra = {
      follow_tw = "+1",
    },
  },
}

return plugin
