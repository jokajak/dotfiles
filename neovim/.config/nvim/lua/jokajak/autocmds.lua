-- Autocommands

-- Source config files on save
local source_config = vim.api.nvim_create_augroup("SourceConfig", {})
vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Automatically source lua config files on save",
  group = source_config,
  pattern = { "*/.config/nvim/**/*.lua" },
  command = "source $MYVIMRC | source %",
})

