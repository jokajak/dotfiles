-- https://github.com/cbochs/grapple.nvim
-- Grapple is a plugin that aims to provide immediate navigation to important files
-- (and its last known cursor location) by means of persistent file tags within a
-- project scope.

local M = {
  "cbochs/grapple.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  enabled = false,
}

M.config = function()
  local status_ok, grapple = pcall(require, "grapple")

  if not status_ok then
    print("Grapple not available")
    return
  end

  -- not really needed
  grapple.setup({})
end

M.init = function()
  vim.keymap.set("n", "<leader>m", require("grapple").toggle, { desc = "[M]ark graple location" })
  vim.keymap.set("n", "<leader>j", function()
    require("grapple").select({ key = "{name}" })
  end, { desc = "Select grapple mark" })

  vim.keymap.set("n", "<leader>J", function()
    require("grapple").toggle({ key = "{name}" })
  end, { desc = "Toggle named grapple mark" })
end

return M
