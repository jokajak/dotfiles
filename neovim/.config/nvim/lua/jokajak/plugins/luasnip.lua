--[[ luasnip config ]]--
local status_ok, ls = pcall(require, "luasnip")

if not status_ok then
  return
end

local lsl_status_ok, lsl = pcall(require, "luasnip.loaders.from_lua")

if lsl_status_ok then
  local snippet_path = vim.fn.stdpath('config') .. '/lua/jokajak/snippets'
  lsl.load({paths = snippet_path})
end
