--[[ init.lua ]]
local util = require("util")

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
vim.g.mapleader = ","
vim.g.localleader = "\\"

-- IMPORTS

local start = vim.loop.hrtime()

require("jokajak")

--[[ require("lazy").setup("config.plugins", {
	defaults = { lazy = true },
	dev = { patterns = { "folke" } },
	install = { colorscheme = { "tokyonight", "habamax" } },
	performance = { cache = { enabled = true } },
	debug = true,
}) ]]

local delta = vim.loop.hrtime() - start

--[[ require("util.dashboard").setup() ]]

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		vim.notify("Lazy took " .. (delta / 1e6) .. "ms")
		--[[ util.require("config.commands") ]]
		util.version()
		--[[ util.require("config.mappings") ]]
	end,
})
