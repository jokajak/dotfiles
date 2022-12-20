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
util.require("jokajak.filetypes")

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("VeryLazy", {}),
  pattern = "VeryLazy",
  callback = function()
    vim.notify("Lazy took " .. (require("jokajak.lazy").delta / 1e6) .. "ms")
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local status_ok, plugins = util.require("jokajak.lazy")
if status_ok then
  plugins.load_plugins()
  plugins.delta = vim.loop.hrtime() - start
end

-- load colorschemes after plugins have been initialized
-- this way colorschemes can require modules
util.require("jokajak.colorscheme")

-- load very lazy plugins in 1000 ms (1s)
vim.defer_fn(function()
  vim.cmd("do User VeryLazy")
end, 1000)
