-- jokajak/virt-column.nvim
-- display a character as a column

local virt_column = {
  "jokajak/virt-column.nvim",
  branch = "feat/toggle",
  event = "VeryLazy",
  opts = function()
    vim.keymap.set("n", "<leader>uv", function()
      require("virt-column").toggle_buffer(0)
    end, { desc = "Toggle [V]irtual Column" })

    return {
      -- char = { "", "┃" },
      char = { "", "┃" },
      virtcolumn = "80, 120",
      highlight = { "NonText", "WarningMsg" },
      exclude = {
        filetypes = {
          "dashboard",
          "lspinfo",
          "packer",
          "checkhealth",
          "help",
          "man",
          "gitcommit",
          "TelescopePrompt",
          "TelescopeResults",
        },
        buftypes = {
          "terminal",
          "nofile",
          "quickfix",
          "prompt",
        },
      },
    }
  end,
}

return virt_column
