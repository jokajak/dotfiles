-- https://github.com/folke/trouble.nvim
-- A pretty list for showing diagnostics, references, telescope results,
-- quickfix and location lists to help you solve all the trouble your code is
-- causing.

local M = {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  config = function()
    require("trouble").setup({
      auto_open = false,
      use_diagnostic_signs = true,
    })
  end,
}

M.init = function()
  local map = require("jokajak.keymaps").map
  map("n", "<leader>ot", "<cmd>Trouble<cr>", { desc = "[O]pen [T]rouble" })
  map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { desc = "Toggle workspace diagnostics" })
  map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { desc = "Toggle document diagnostics" })
  map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { desc = "Trouble location list" })
  map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { desc = "Trouble quickfix" })
  map("n", "gR", "<cmd>Trouble lsp_references<cr>", { desc = "Trouble LSP References" })
end

return M
