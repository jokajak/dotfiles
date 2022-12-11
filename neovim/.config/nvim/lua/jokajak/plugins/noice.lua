-- https://github.com/folke/noice.nvim
-- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.

local M = {
  "folke/noice.nvim",
  event = "UIEnter",
  module = "noice",
  requires = {
    "MunifTanjim/nui.nvim",
  },
}

M.__enabled = true

M.config = function()
  if not M.__enabled then
    return
  end

  local status_ok, noice = pcall(require, "noice")
  if not status_ok then
    return
  end
  noice.setup({
    debug = false,
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      cmdline_output_to_split = false,
    },
    commands = {
      all = {
        -- options for the message history that you get with `:Noice`
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {},
      },
    },
    routes = {
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
    },
  })

  vim.keymap.set("n", "<leader>nl", function()
    require("noice").cmd("last")
  end, { desc = "[N]oice [L]ast Message" })

  vim.keymap.set("n", "<leader>nh", function()
    require("noice").cmd("history")
  end, { desc = "[N]oice [H]istory" })

  vim.keymap.set("n", "<leader>na", function()
    require("noice").cmd("all")
  end, { desc = "[N]oice [A]ll" })
end

return M
