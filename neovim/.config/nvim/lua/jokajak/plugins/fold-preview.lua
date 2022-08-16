--[[ fold-preview configuration ]]--
local status_ok, fpreview = pcall(require, "fold-preview")

if not status_ok then
  return
end

fpreview.setup()
