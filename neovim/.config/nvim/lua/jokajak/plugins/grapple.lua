-- "cbochs/grapple.nvim" configuration
local status_ok, grapple = pcall(require, "grapple")

if not status_ok then
  print("Grapple not available")
  return
end

-- not really needed
grapple.setup({})

vim.keymap.set("n", "<leader>m", require("grapple").toggle, { desc = "Open grapple popup" })
