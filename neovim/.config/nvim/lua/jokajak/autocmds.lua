-- Autocommands
local autocmd = vim.api.nvim_create_autocmd

-- Source config files on save
--[[ local source_config = vim.api.nvim_create_augroup("SourceConfig", {})
autocmd("BufWritePost", {
  desc = "Automatically source lua config files on save",
  group = source_config,
  pattern = { "*/.config/nvim/**/*.lua" },
  command = "source $MYVIMRC | source %",
})]]

--[[ autocmd("BufWritePost", {
  desc = "Automatically update plugins on save",
  group = source_config,
  pattern = { "*/.config/nvim/**/plugins/init.lua" },
  command = "source <afile> | PackerSync",
})]]

local number_toggle_augroup = vim.api.nvim_create_augroup("numbertoggle", {})

autocmd({"BufEnter", "FocusGained", "InsertLeave", "WinEnter"}, {
  desc = "Enable relative line numbers",
  group = number_toggle_augroup,
  pattern = "*",
  callback = function()
    if vim.opt.number:get() and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt.relativenumber = true
    end
  end
})

autocmd({"BufLeave", "FocusLost", "InsertEnter", "WinLeave"}, {
  desc = "Disable relative line numbers" ,
  group = number_toggle_augroup,
  pattern = "*",
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = false
    end
  end
})

--- TreeSitter folding WORKAROUND
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

-- trim trailing whitespace

local trim_patterns = {
  markdown = {
    [[%s/\s\+$//e]],           -- remove unwanted spaces
    [[%s/\($\n\s*\)\+\%$//]],  -- trim last line
    [[%s/\%^\n\+//]],          -- trim first line
  },
  python = {
    [[%s/\s\+$//e]],           -- remove unwanted spaces
    [[%s/\($\n\s*\)\+\%$//]],  -- trim last line
    [[%s/\%^\n\+//]],          -- trim first line
  }
}

trim_patterns["*"] = {
  [[%s/\s\+$//e]],           -- remove unwanted spaces
  [[%s/\($\n\s*\)\+\%$//]],  -- trim last line
  [[%s/\%^\n\+//]],          -- trim first line
  [[%s/\(\n\n\)\n\+/\1/]],   -- replace multiple blank lines with a single line
}

vim.api.nvim_create_augroup('Trim', { clear = true })
autocmd("BufWritePre", {
  desc = "Automatically trim trailing whitespace",
  group = 'Trim',
  pattern = '*',
  callback = function()
    local patterns = trim_patterns[vim.bo.filetype] or trim_patterns["*"]
    for _, pattern in pairs(patterns) do
      vim.api.nvim_exec(string.format("keepjumps keeppatterns silent! :%s", pattern), false)
    end
  end,
})

---@author kikito
---@see https://codereview.stackexchange.com/questions/268130/get-list-of-buffers-from-current-neovim-instance
local function get_listed_buffers()
  local buffers = {}
  local len = 0
  for buffer = 1, vim.fn.bufnr('$') do
    if vim.fn.buflisted(buffer) == 1 then
      len = len + 1
      buffers[len] = buffer
    end
  end

  return buffers
end

vim.api.nvim_create_augroup('alpha_on_empty', { clear = true })
vim.api.nvim_create_autocmd('User', {
  pattern = 'BDeletePre',
  group = 'alpha_on_empty',
  callback = function(event)
    local found_non_empty_buffer = false
    local buffers = get_listed_buffers()

    for _, bufnr in ipairs(buffers) do
      if not found_non_empty_buffer then
        local name = vim.api.nvim_buf_get_name(bufnr)
        local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')

        if bufnr ~= event.buf and name ~= '' and ft ~= 'Alpha' then
          found_non_empty_buffer = true
        end
      end
    end

    if not found_non_empty_buffer then
      local nt_api_status, nt_api = pcall(require, "nvim-tree.api")
      if not nt_api_status then
        return
      end
      nt_api.close()
      vim.cmd [[:Alpha]]
    end
  end,
})
