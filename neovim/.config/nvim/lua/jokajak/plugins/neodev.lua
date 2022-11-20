-- neodev configuration
local neodev_status, neodev = pcall(require, "neodev")

if not neodev_status then
  return
end

neodev.setup({
  library = {
    plugins = { "neotest" },
    types = true
  },
})
