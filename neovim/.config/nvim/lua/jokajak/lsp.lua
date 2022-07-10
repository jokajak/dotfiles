-- Setup nvim-cmp.
local cmp = require("cmp")

local function config(_config)
	return vim.tbl_deep_extend("force", {}, _config or {})
end

require('lspconfig').pylsp.setup(config())
