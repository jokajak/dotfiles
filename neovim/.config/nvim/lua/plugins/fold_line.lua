-- https://github.com/gh-liu/fold_line.nvim
-- include indent line showing fold points

local fold_line = {
  "gh-liu/fold_line.nvim",
  enabled = false,
  event = "VeryLazy",
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
