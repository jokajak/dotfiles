--[[ gitsigns configuration ]]--
local status_ok, gitsigns = pcall(require, "gitsigns")

if not status_ok then
  return
end

local on_attach_func = function(bufnr)
  local gs = gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end, {expr=true})

  map('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, {expr=true})

  -- Actions
  map({'n', 'v'}, '<leader>gs', gs.stage_hunk, { desc = "Stage hunk" } )
  map({'n', 'v'}, '<leader>gr', gs.reset_hunk, { desc = "Reset hunk" } )
  map('n', '<leader>ghb', function() gs.blame_line{full=true} end, { desc = "Git blame hunk" } )
  map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = "Show git-blame for lines" } )
  map('n', '<leader>ghd', gs.diffthis, { desc = "Git-diff"} )
  map('n', '<leader>gD', function() gs.diffthis('HEAD') end, { desc = "Git-diff HEAD" } )
  map('n', '<leader>gtd', gs.toggle_deleted, { desc = "Toggle deleted" } )
  map('n', '<leader>gj', gs.next_hunk, { desc = "Next hunk" } )
  map('n', '<leader>gk', gs.prev_hunk, { desc = "Previous hunk" } )
  map('n', '<leader>gl', gs.blame_line, { desc = "Blame" } )
  map('n', '<leader>gp', gs.preview_hunk, { desc = "Preview hunk" } )
  map('n', '<leader>gR', gs.reset_buffer, { desc = "Reset buffer" } )
  map('n', '<leader>gS', gs.stage_buffer, { desc = "Stage buffer" } )
  map('n', '<leader>gu', gs.undo_stage_hunk, { desc = "Undo Stage hunk" } )

  -- Text object
  map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select hunk" } )
end

gitsigns.setup {
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
    delay = 10000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
  on_attach = on_attach_func
}
