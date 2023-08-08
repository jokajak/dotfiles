local wezterm = require("wezterm")
local colors = require("colors")
local fonts = require("fonts")
local config = {}

config.color_scheme = colors.color_scheme

for k, v in pairs(fonts) do
	if k == "font" then
		config.font = wezterm.font_with_fallback(v)
	else
		config[k] = v
	end
end

return config
