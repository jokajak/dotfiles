--[[ fold-preview configuration ]]--
local status_ok, fpreview = pcall(require, "fold-preview")

if not status_ok then
  return
end

fpreview.setup({
  default_keybindings = false
})

-- fold preview keymap-amend wasn't working
-- use my own remaps

local fn = vim.fn

-- Copy/paste of 
local preview_fold = function()
  local current_line_folded = fn.foldclosed('.') ~= -1
  if current_line_folded then
    fpreview.show_preview()
  else

  end
end
vim.keymap.set("n", "zp", preview_fold, { silent = true, noremap= true, desc = "Preview fold" })
