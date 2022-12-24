-- https://github.com/cbochs/portal.nvim
-- Look at you, sailing through the [jumplist] majestically, like an eagle... piloting a blimp.

local M = {
  "cbochs/portal.nvim",
}

M.config = function()
  local status_ok, portal = pcall(require, "portal")

  local grapple_ok, _ = pcall(require, "grapple")

  if not status_ok then
    return
  end

  portal.setup({
    integrations = {
      grapple = grapple_ok,
    },
  })
end

M.init = function()
  vim.keymap.set("n", "<leader>o", require("portal").jump_backward, { desc = "[Portal] Jump background" })
  vim.keymap.set("n", "<leader>i", require("portal").jump_forward, { desc = "[Portal] Jump forward" })
end

return M
