local map = require("jokajak.keymaps").map
map("n", "<leader>xx", "<cmd>Trouble<cr>", { desc = "Show Trouble" })
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { desc = "Toggle workspace diagnostics" })
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { desc = "Toggle document diagnostics" })
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { desc = "Trouble location list" })
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { desc = "Trouble quickfix" })
map("n", "gR", "<cmd>Trouble lsp_references<cr>", { desc = "Trouble LSP References" })
