--[[ keys.lua ]]

-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Insert Mode --
-- remap the key used to leave insert mode
map('i', 'kj', '', {})

-- [[ Normal mode ]] --
-- Better window navigation
map("n", "<C-h>", "<C-w>h", {})
map("n", "<C-j>", "<C-w>j", {})
map("n", "<C-k>", "<C-w>k", {})
map("n", "<C-l>", "<C-w>l", {})

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>", {})
map("n", "<C-Down>", ":resize -2<CR>", {})
map("n", "<C-Left>", ":vertical resize -2<CR>", {})
map("n", "<C-Right>", ":vertical resize +2<CR>", {})

-- Toggle nvim-tree
map('n', '<Leader>e', [[:NvimTreeToggle<CR>]], {})

-- Toggle IndentLines
map('n', '<Leader>l', [[:IndentLinesToggle<CR>]], {})

-- Toggle Tagbar
map('n', '<Leader>t', [[:TagbarToggle<CR>]], {})

-- Toggle undotree
map('n', '<Leader>u', [[:UndotreeToggle<CR>]], {})

-- Turn off search highlights
map("n", "<Leader><Space>", ":nohlsearch<CR>", { silent = true })

-- show cursor
-- Press <C-b> to call specs!
map('n', '<C-b>', ':lua require("specs").show_specs()<CR>', { silent = true })

-- Bind specs to search jumping
map('n', 'n', 'n:lua require("specs").show_specs()<CR>', { silent = true })
map('n', 'N', 'N:lua require("specs").show_specs()<CR>', { silent = true })

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
map('n', '<Leader>ff', [[:Telescope find_files<CR>]], {})
--map("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", {})
map("n", "<c-t>", "<cmd>Telescope live_grep<cr>", {})

-- Quick formatting
map("n", "<Leader>f", [[:Format<CR>]])
