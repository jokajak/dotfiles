-- cbochs/portal.nvim configuration
local status_ok, portal = pcall(require, "portal")

local grapple_ok, _ = pcall(require, "grapple")

if not status_ok then
  return
end

portal.setup({
  integrations = {
    grapple = grapple_ok
  }
})

vim.keymap.set("n", "<leader>o", require("portal").jump_backward, { desc = "[Portal] Jump background" })
vim.keymap.set("n", "<leader>i", require("portal").jump_forward, { desc = "[Portal] Jump forward" })
