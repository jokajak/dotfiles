-- MeanderingProgrammer/markdown.nvim
-- Markdown renderer

local markdown = {
  "MeanderingProgrammer/markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  opts = {},
  ft = {
    "markdown",
  },
  keys = {
    {
      "<leader>uzm",
      function()
        require("markdown").toggle()
      end,
      desc = "[T]oggle [M]arkdown Renderer",
    },
  },
}

return markdown
