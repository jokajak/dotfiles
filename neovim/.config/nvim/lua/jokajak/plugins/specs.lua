--[[ specs configuration ]]--
local status_ok, specs = pcall(require, "specs")

if not status_ok then
  return
end

specs.setup({
  show_jumps = true,
  min_jump = 10,
})
