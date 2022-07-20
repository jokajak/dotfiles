--[[ keys.lua ]]

-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- remap the key used to leave insert mode
map('i', 'jk', '', {})

-- Toggle nvim-tree
map('n', '<Leader>n', [[:NvimTreeToggle<CR>]], { silent = true })

-- Toggle IntentLines
map('n', '<Leader>l', [[:IndentLinesToggle<CR>]], { silent = true })

-- Toggle Tagbar
map('n', '<Leader>t', [[:TagbarToggle<CR>]], {})

-- Toggle telescope
map('n', '<Leader>ff', [[:Telescope find_files<CR>]], {})

-- Toggle undotree
map('n', '<Leader>u', [[:UndotreeToggle<CR>]], {})

-- Turn off search highlights
map("n", "<Leader><Space>", ":nohlsearch<CR>", { silent = true })

-- show cursor
-- Press <C-b> to call specs!
map('n', '<C-b>', ':lua require("specs").show_specs()<CR>', { silent = true })

-- You can even bind it to search jumping and more, example:
map('n', 'n', 'n:lua require("specs").show_specs()<CR>', { silent = true })
map('n', 'N', 'N:lua require("specs").show_specs()<CR>', { silent = true })
