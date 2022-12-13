-- Set colorscheme
local state = require("jokajak.state")

state.setup()

local colorscheme = state.get("colorscheme")

if colorscheme == "catppuccin" then
  local catppuccin_ok, _ = pcall(require, "catppuccin")
  if not catppuccin_ok then
    colorscheme = "tokyonight"
  end
end
-- make sure it's a valid colorscheme
local valid_schemes = vim.fn.getcompletion("", "color")
if not vim.tbl_contains(valid_schemes, colorscheme) then
  vim.notify(("Non-existent colorscheme %s"):format(colorscheme), vim.log.levels.DEBUG)
  return nil
end

vim.cmd("colorscheme " .. colorscheme)

-- Inspired by https://github.com/shaun-mathew/Kitty-Neovim-Background-Changer/blob/main/change_background.lua
-- Automatically change the kitty terminal background
local home = vim.fn.fnamemodify("~", ":p")
local kitty_themes_path = home .. "/.config/kitty/themes/"
local tmux_themes_path = home .. "/.tmux/themes/"
local fn = vim.fn
local luv = vim.loop

local theme_exists = function(theme, bg, themes_path)
  local theme_file = themes_path .. theme .. "-" .. bg .. ".conf"
  local stat = luv.fs_stat(theme_file)
  return stat and stat.type == "file" and luv.fs_access(theme_file, "R")
end

local change_kitty_theme = function(theme, bg)
  if not theme_exists(theme, bg, kitty_themes_path) then
    vim.notify("kitty theme " .. theme .. "(" .. bg .. ") can't be found.")
    return
  end
  local theme_file = kitty_themes_path .. theme .. "-" .. bg .. ".conf"
  local command = "kitty @ set-colors " .. theme_file
  local current_theme_file = kitty_themes_path .. "current.conf"

  fn.system(command)
  local success, _ = luv.fs_copyfile(theme_file, current_theme_file)
  if success then
    vim.notify("kitty theme updated to " .. theme)
  end
end

local change_tmux_theme = function(theme, bg)
  if not theme_exists(theme, bg, tmux_themes_path) then
    vim.notify("tmux theme " .. theme .. "(" .. bg .. ") can't be found.")
    return
  end
  local theme_file = tmux_themes_path .. theme .. "-" .. bg .. ".conf"
  local command = "tmux source-file " .. theme_file
  local current_theme_file = tmux_themes_path .. "current.conf"

  fn.system(command)
  local success, _ = luv.fs_copyfile(theme_file, current_theme_file)
  if success then
    vim.notify("tmux theme updated to " .. theme)
  end
end

local autogroup = vim.api.nvim_create_augroup
local bg_change = autogroup("BackgroundChange", { clear = true })

local update_external_theme = function(theme, bg)
  if not (theme and bg) then
    vim.notify("Bad execution of change_theme: theme=" .. vim.inspect(theme) .. " bg=" .. vim.inspect(bg))
    return
  end
  change_kitty_theme(theme, bg)
  change_tmux_theme(theme, bg)
end

--[[ local autocmd = vim.api.nvim_create_autocmd
autocmd("ColorScheme", {
  pattern = "*",
  desc = "Sync colorscheme with external apps and disk",
  callback = function(info)
    local bg = vim.o.background
    local new_colorscheme = info.match
    -- make sure it's a valid colorscheme
    local valid_schemes = vim.fn.getcompletion("", "color")
    if not vim.tbl_contains(valid_schemes, new_colorscheme) then
      vim.notify(("Non-existent colorscheme %s"):format(new_colorscheme), vim.log.levels.DEBUG)
      return nil
    end
    if new_colorscheme == "catppuccin" then
      local flavor = (bg == "light" and "latte" or "mocha")
      vim.notify("catppuccin: "..vim.inspect(flavor))
      vim.cmd("Catppuccin " .. flavor)
      bg = flavor
    end
    update_external_theme(new_colorscheme, bg)
  end,
  group = bg_change,
}) ]]

-- switch colorscheme based on background
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    local current_colorscheme = vim.g.colors_name
    local bg = vim.v.option_new
    if current_colorscheme then
      state.set("colorscheme", current_colorscheme)
    end
    if bg then
      state.set("background", bg)
    end
  end,
  group = bg_change,
})

vim.api.nvim_create_user_command("SyncThemes", function()
  local current_colorscheme = vim.g.colors_name
  local bg = vim.v.option_new
  update_external_theme(current_colorscheme, bg)
end, {})
