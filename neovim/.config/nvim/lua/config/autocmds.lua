-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Autocommands
local autocmd = vim.api.nvim_create_autocmd

local number_toggle_augroup = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

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

-- go to last loc when opening a buffer: https://this-week-in-neovim.org/2023/Jan/02
-- vim.api.nvim_create_autocmd("BufReadPre", {
--   group = vim.api.nvim_create_augroup("last_loc", { clear = true }),
--   pattern = "*",
--   callback = function()
--     -- create a new oneshot autocmd for FileType that moves the cursor
--     vim.api.nvim_create_autocmd("FileType", {
--       pattern = "<buffer>", -- only for the current buffer
--       once = true,
--       callback = function()
--         local mark = vim.api.nvim_buf_get_mark(0, '"')
--         local lcount = vim.api.nvim_buf_line_count(0)
--         local ftype = vim.bo.filetype
--         if mark[1] > 0 and mark[1] <= lcount then
--           if ftype ~= "gitcommit" then
--             pcall(vim.api.nvim_win_set_cursor, 0, mark)
--           end
--         end
--       end,
--     })
--   end,
-- })
--

local cursorline_group = vim.api.nvim_create_augroup("cursor", { clear = true })
-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  group = cursorline_group,
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  group = cursorline_group,
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

-- vim.api.nvim_create_autocmd("CursorHold", {
--   buffer = bufnr,
--   callback = function()
--     local opts = {
--       focusable = false,
--       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--       border = "rounded",
--       source = "always",
--       prefix = " ",
--       scope = "line",
--       max_width = 70,
--       pad_top = 1,
--       pad_bottom = 1,
--     }
--     vim.diagnostic.open_float(nil, opts)
--   end,
-- })
