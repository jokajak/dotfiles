-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- disable lazygit
vim.keymap.del("n", "<leader>gg")
vim.keymap.del("n", "<leader>gG")
