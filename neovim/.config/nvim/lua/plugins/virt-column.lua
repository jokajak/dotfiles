-- jokajak/virt-column.nvim
-- display a character as a column

local virt_column = {
  "jokajak/virt-column",
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
    }
  end,
}

return virt_column
