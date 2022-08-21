-- Set colorscheme

local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- Inspired by https://github.com/shaun-mathew/Kitty-Neovim-Background-Changer/blob/main/change_background.lua
-- Automatically change the kitty terminal background
local home = vim.fn.fnamemodify("~", ":p")
local kitty_themes_path = home .. "/.config/kitty/themes/"
local fn = vim.fn

local change_background = function(color)
  local arg = kitty_themes_path .. color .. ".conf"
  local command = "kitty @ set-colors " .. arg

  print("Settings colors")
  print(command)
  fn.system(command)
end

local autocmd = vim.api.nvim_create_autocmd
local autogroup = vim.api.nvim_create_augroup
local bg_change = autogroup("BackgroundChange", { clear = true })

autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local bg = vim.o.background
    change_background(bg)
  end,
  group = bg_change,
})
