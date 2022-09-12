-- Set colorscheme

local colorscheme = "gruvbox"

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
local luv = vim.loop

local theme_exists = function(theme, bg)
  local theme_file = kitty_themes_path .. theme .. "-" .. bg .. ".conf"
  local stat = luv.fs_stat(theme_file)
  return stat and stat.type == "file" and luv.fs_access(theme_file, "R")
end

local change_kitty_theme = function(theme, bg)
  if not theme_exists(theme, bg) then
    vim.notify("kitty theme "..theme.." can't be found.")
    return
  end
  local theme_file = kitty_themes_path .. theme .. "-" .. bg .. ".conf"
  local command = "kitty @ set-colors " .. theme_file
  local current_theme_file = kitty_themes_path .. "current.conf"

  fn.system(command)
  local success, err = luv.fs_copyfile(theme_file, current_theme_file)
end

local autocmd = vim.api.nvim_create_autocmd
local autogroup = vim.api.nvim_create_augroup
local bg_change = autogroup("BackgroundChange", { clear = true })

autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local bg = vim.o.background
    local colorscheme = vim.g.colors_name
    change_kitty_theme(colorscheme, bg)
  end,
  group = bg_change,
})

-- switch colorscheme based on background
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = function()
    local colorscheme = vim.g.colors_name
    local bg = vim.v.option_new
    if colorscheme == "catppuccin" then
      local flavor = (vim.v.option_new == "light" and "latte" or "mocha")
      vim.cmd("Catppuccin " .. flavor)
      change_kitty_theme("catppuccin", flavor)
    else
      change_kitty_theme(colorscheme, bg)
    end

	end,
  group = bg_change,
})
