--[[ init.lua ]]

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
vim.g.mapleader = ","
vim.g.localleader = " "

-- IMPORTS

local start = vim.loop.hrtime()

local util = require("util")

util.require("jokajak.options")
util.require("jokajak.autocmds")
util.require("jokajak.keymaps")
util.require("jokajak.colorscheme")
util.require("jokajak.filetypes")

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("VeryLazy", {}),
  pattern = "VeryLazy",
  callback = function()
    vim.notify("Lazy took " .. (require("jokajak.plugins").delta / 1e6) .. "ms")
  end,
})

local status_ok, plugins = util.require("jokajak.plugins")
if status_ok then
  plugins.load_plugins()
  plugins.delta = vim.loop.hrtime() - start
end

-- load very lazy plugins in 1000 ms (1s)
vim.defer_fn(function()
  vim.cmd("do User VeryLazy")
end, 1000)
