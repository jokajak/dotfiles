-- https://github.com/lukas-reineke/indent-blankline.nvim
-- This plugin adds indentation guides to all lines (including empty lines).

local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
}

--[[ indentline configuration ]]
M.config = function()
  local status_ok, indentline = pcall(require, "indent_blankline")

  if not status_ok then
    return
  end

  local filetype_excludes = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "NvimTree",
    "neo-tree",
    "Trouble",
  }

  vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
  vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
  vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
  vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
  vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
  vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

  vim.opt.list = true
  vim.opt.listchars:append("space:⋅")
  vim.opt.listchars:append("eol:↴")
  -- use a character with no gaps on the left
  vim.g.indent_blankline_char = "▏"

  local setup = {
    space_char_blankline = " ",
    show_current_context = false, -- highlight current indentation based on treesitter
    show_current_context_start = true,
    char_highlight_list = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
      "IndentBlanklineIndent3",
      "IndentBlanklineIndent4",
      "IndentBlanklineIndent5",
      "IndentBlanklineIndent6",
    },
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = filetype_excludes,
  }

  indentline.setup(setup)
end

return M
