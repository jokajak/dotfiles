local M = {}

-- set background based on time
local now = os.date("*t")

if (6 <= now.hour) and (now.hour < 20) then
	M.color_scheme = "tokyonight-day"
else
	M.color_scheme = "tokyonight-storm"
end

return M
