local M = {}

-- stylua: ignore
local colorschemes = {
  { label = "Sweetie Dark",  value = "sweetie_dark" },
  { label = "Sweetie Light", value = "sweetie_light" },
}

M.init = function()
  return colorschemes
end

M.activate = function(config, _, value)
  config.color_scheme = value
end

return M
