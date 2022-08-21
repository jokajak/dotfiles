--[[ trouble.nvim configuration ]] --
local status_ok, trouble = pcall(require, "trouble")

if not status_ok then
  return
end

trouble.setup()

-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<leader>xx", "<cmd>Trouble<cr>", { desc = "Show Trouble" } )
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { desc = "Toggle workspace diagnostics" } )
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { desc = "Toggle document diagnostics" } )
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { desc = "Trouble location list" } )
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { desc = "Trouble quickfix" } )
map("n", "gR", "<cmd>Trouble lsp_references<cr>", { desc = "Trouble LSP References" } )
