local wezterm = require("wezterm")
local M = {}
local name = "Iosevka Term"

M.init = function()
  return name
end

M.activate = function(config)
  config.font = wezterm.font(name)
  config.font_size = 14.0
  config.line_height = 1.0
  config.harfbuzz_features = {}
  config.font_rules = {}
  config.font.weight = "Expanded"
end

return M
