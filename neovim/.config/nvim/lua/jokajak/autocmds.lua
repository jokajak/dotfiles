-- Autocommands
local autocmd = vim.api.nvim_create_autocmd

local number_toggle_augroup = vim.api.nvim_create_augroup("numbertoggle", {})

autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
	desc = "Enable relative line numbers",
	group = number_toggle_augroup,
	pattern = "*",
	callback = function()
		if vim.opt.number:get() and vim.api.nvim_get_mode().mode ~= "i" then
			vim.opt.relativenumber = true
		end
	end,
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
	desc = "Disable relative line numbers",
	group = number_toggle_augroup,
	pattern = "*",
	callback = function()
		if vim.opt.number:get() then
			vim.opt.relativenumber = false
		end
	end,
})

-- highlight text when you yank it
autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Highlight yank",
})

-- trim trailing whitespace

local trim_patterns = {
	markdown = {
		[[%s/\s\+$//e]], -- remove unwanted spaces
		[[%s/\($\n\s*\)\+\%$//]], -- trim last line
		[[%s/\%^\n\+//]], -- trim first line
	},
	python = {
		[[%s/\s\+$//e]], -- remove unwanted spaces
		[[%s/\($\n\s*\)\+\%$//]], -- trim last line
		[[%s/\%^\n\+//]], -- trim first line
	},
}

trim_patterns["*"] = {
	[[%s/\s\+$//e]], -- remove unwanted spaces
	[[%s/\($\n\s*\)\+\%$//]], -- trim last line
	[[%s/\%^\n\+//]], -- trim first line
	[[%s/\(\n\n\)\n\+/\1/]], -- replace multiple blank lines with a single line
}

vim.api.nvim_create_augroup("Trim", { clear = true })
autocmd("BufWritePre", {
	desc = "Automatically trim trailing whitespace",
	group = "Trim",
	pattern = "*",
	callback = function()
		local patterns = trim_patterns[vim.bo.filetype] or trim_patterns["*"]
		for _, pattern in pairs(patterns) do
			vim.api.nvim_exec(string.format("keepjumps keeppatterns silent! :%s", pattern), false)
		end
	end,
})

-- create directories when needed, when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
	callback = function(event)
		local file = vim.loop.fs_realpath(event.match) or event.match

		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
		local backup = vim.fn.fnamemodify(file, ":p:~:h")
		backup = backup:gsub("/", "%%")
		vim.go.backupext = backup
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPre", {
	pattern = "*",
	callback = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "<buffer>",
			once = true,
			callback = function()
				vim.cmd(
					[[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
				)
			end,
		})
	end,
})
