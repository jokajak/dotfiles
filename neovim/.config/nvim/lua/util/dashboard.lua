-- taken from https://github.com/folke/dot/blob/master/config/nvim/lua/util/dashboard/init.lua
local M = {}

function M.dont_show()
	if #vim.v.argv > 1 then
		return true
	end

	-- taken from mini.starter
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
	if #lines > 1 or (#lines == 1 and lines[1]:len() > 0) then
		return true
	end

	-- - Several buffers are listed (like session with placeholder buffers). That
	--   means unlisted buffers (like from `nvim-tree`) don't affect decision.
	local listed_buffers = vim.tbl_filter(function(buf_id)
		return vim.fn.buflisted(buf_id) == 1
	end, vim.api.nvim_list_bufs())
	if #listed_buffers > 1 then
		return true
	end

	-- - There are files in arguments (like `nvim foo.txt` with new file).
	if vim.fn.argc() > 0 then
		return true
	end

	return false
end
return M
