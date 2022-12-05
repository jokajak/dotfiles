--[[ keys.lua ]]
local M = {}

-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

M.map = map

-- Insert Mode --
-- remap the key used to leave insert mode
map("i", "kj", "", {})

-- [[ Normal mode ]] --
--
-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move cursor to window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Move cursor to window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Move cursor to window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Move cursor to window right" })
map("n", "<leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>", { desc = "Close current buffer" })

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>", {})
map("n", "<C-Down>", ":resize -2<CR>", {})
map("n", "<C-Left>", ":vertical resize -2<CR>", {})
map("n", "<C-Right>", ":vertical resize +2<CR>", {})

-- Toggle nvim-tree
map("n", "<Leader>e", [[:NvimTreeToggle<CR>]], {})

-- Turn off search highlights
map("n", "<Leader><Space>", ":nohlsearch<CR>", { silent = true })

-- show cursor
-- Press <C-b> to call specs!
map("n", "<C-b>", ':lua require("specs").show_specs()<CR>', { silent = true })

-- Bind specs to search jumping
map("n", "n", 'n:lua require("specs").show_specs()<CR>', { silent = true })
map("n", "N", 'N:lua require("specs").show_specs()<CR>', { silent = true })

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", {})
map("n", "<S-h>", ":bprevious<CR>", {})

-- Visual --
-- Stay in indent mode when shifting text
map("v", "<", "<gv", {})
map("v", ">", ">gv", {})

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", {})
map("v", "<A-k>", ":m .-2<CR>==", {})
map("v", "p", '"_dP', {}) -- keep current clipboard contents when pasting over text

-- Visual Block --
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", {})
map("x", "K", ":move '<-2<CR>gv-gv", {})
map("x", "<A-j>", ":move '>+1<CR>gv-gv", {})
map("x", "<A-k>", ":move '<-2<CR>gv-gv", {})

-- Telescope
vim.keymap.set("n", "<leader>?", "<cmd>Telescope oldfiles<cr>", { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", "<cmd>Telescope buffers<cr>", { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<cr>", { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<cr>", { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics<cr>", { desc = "[S]earch [D]iagnostics" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Quick formatting
vim.keymap.set("n", "<Leader>f", function()
	require("jokajak.lsp.formatting").format()
end, { desc = "Format document" })

return M
