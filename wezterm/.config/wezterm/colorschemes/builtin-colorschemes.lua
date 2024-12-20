local wezterm = require("wezterm")
local M = {}

-- stylua: ignore
local colorschemes = {
  { label = "Ayu Dark",          value = "Ayu Dark (Gogh)" , background = "dark"},
  { label = "Tokyo Night Moon",  value = "Tokyo Night Moon", background="dark" },
  { label = "Tokyo Night Day",   value = "Tokyo Night Day", background="light" },
  { label = "Catppuccin Mocha",  value = "Catppuccin Mocha", background="dark" },
  { label = "Catppuccin Latte",  value = "Catppuccin Latte", background="light" },
  { label = "Oxocarbon Dark",    value = "Oxocarbon Dark (Gogh)" , background="dark" },
  { label = "Gruvbox Material",  value = "Gruvbox Material (Gogh)" , background="dark" },
  { label = "Sonokai",           value = "Sonokai (Gogh)" , background="dark" },
  { label = "Edge Dark",         value = "Edge Dark (base16)" , background="dark" },
  { label = "Matrix",            value = "matrix" , background="dark" },
}

local cache_path = os.getenv("HOME") .. "/.local/cache/wezterm/"
local file_path = cache_path .. "background.lua"

-- Function to write "dark" or "light" based on the active scheme
local function write_background_type(active_scheme)
  -- Find the scheme in the list and get its type

  local background_type = ""
  for _, scheme in ipairs(colorschemes) do
    if scheme.value == active_scheme then
      background_type = scheme.background
      break
    end
  end

  os.execute("mkdir -p " .. cache_path)

  if background_type ~= "dark" and background_type ~= "light" then
    return
  end

  wezterm.log_info("Setting background to: " .. background_type .. " for " .. active_scheme)
  -- Open the file for writing
  local file, err = io.open(file_path, "w")
  if not file or file == nil then
    wezterm.log_error("Failed to open file: " .. err)
    return
  end

  -- Write "dark" or "light" to the file
  file:write("TERM_BACKGROUND=" .. background_type .. "\n")
  file:close()
end

M.init = function()
  return colorschemes
end

M.activate = function(config, _, value)
  config.color_scheme = value
end

wezterm.on("window-config-reloaded", function(window, _)
  local config = window:get_config_overrides() or {}
  if config.color_scheme ~= nil then
    write_background_type(config.color_scheme)
  end
end)

return M
