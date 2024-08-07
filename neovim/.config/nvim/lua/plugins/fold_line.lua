-- https://github.com/gh-liu/fold_line.nvim
-- include indent line showing fold points

local fold_line = {
  "gh-liu/fold_line.nvim",
  enabled = false,
  event = "VeryLazy",
  init = function()
    -- change the char of the line, see the `Appearance` section
    vim.g.fold_line_char_open_start = "╭"
    vim.g.fold_line_char_open_end = "╰"
  end,
  keys = {
    {
      "<leader>uzf",
      function()
        vim.g.fold_line_disable = not vim.g.fold_line_disable
      end,
      desc = "Disable Fold indicator (Global)",
    },
    {
      "<leader>uzF",
      function()
        vim.g.fold_line_disable = not vim.g.fold_line_disable
      end,
      desc = "Disable Fold indicator (Buffer)",
    },
  },
}

return fold_line
