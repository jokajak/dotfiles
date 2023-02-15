local wezterm = require("wezterm")
local M = {}

M.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	{ family = "Iosevka", stretch = "Expanded" },
	"Fira Code",
})

M.font_size = "12.0"
return M
