-- Autocommands
local autocmd = vim.api.nvim_create_autocmd

-- Source config files on save
local source_config = vim.api.nvim_create_augroup("SourceConfig", {})
autocmd("BufWritePost", {
  desc = "Automatically source lua config files on save",
  group = source_config,
  pattern = { "*/.config/nvim/**/*.lua" },
  command = "source $MYVIMRC | source %",
})

autocmd("BufWritePost", {
  desc = "Automatically update plugins on save",
  group = source_config,
  pattern = { "*/.config/nvim/**/plugins/init.lua" },
  command = "source <afile> | PackerSync",
})
---WORKAROUND
autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod     = 'expr'
    vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
  end
})
---ENDWORKAROUND

-- highlight text when you yank it
autocmd('TextYankPost', {
  pattern = "*",
  callback = function() vim.highlight.on_yank() end,
  desc = "Highlight yank",
})
