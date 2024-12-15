local wezterm = require("wezterm")
local M = {}
local name = "Iosevka Term"

M.init = function()
  return name
end

M.activate = function(config)
  config.font = wezterm.font({
    family = name,
    stretch = "Expanded",
  })
  config.line_height = 1.0
  config.font_size = 14.0
  config.font_rules = {}
  config.harfbuzz_features = {}
end

return M
