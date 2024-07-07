-- https://github.com/HampusHauffman/block.nvim
-- Highlight block context changes
local block_plugin = {
  "HampusHauffman/block.nvim",
  opts = {},
  cmd = {
    "Block",
    "BlockOn",
    "BlockOff",
  },
  keys = {
    { "<leader>zb", "<cmd>Block<CR>", desc = "Toggle Block indicator" },
  },
}

return block_plugin
