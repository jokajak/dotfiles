local wezterm = require("wezterm")

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Light"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "tokyonight-storm"
	-- return 'Builtin Solarized Dark'
	else
		return "tokyonight-day"
		-- return 'Builtin Solarized Light'
	end
end

return {
	color_scheme = scheme_for_appearance(get_appearance()),
}
