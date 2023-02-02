-- From https://github.com/LeonHeidelbach/trailblazer.nvim
-- TrailBlazer enables you to seemlessly move through important project marks as
-- quickly and efficiently as possible to make your workflow blazingly fast ™.
local M = {
  "LeonHeidelbach/trailblazer.nvim",
  event = "BufRead",
  lazy = true,
}

M.config = function()
  local status_ok, trailblazer = pcall(require, "trailblazer")

  if not status_ok then
    return
  end

  local config = {}

  trailblazer.setup(config)
end

return M
