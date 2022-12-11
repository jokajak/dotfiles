-- https://github.com/L3MON4D3/LuaSnip
--

local M = {
  "L3MON4D3/LuaSnip",
  module = "luasnip",
  wants = "friendly-snippets",
}

M.config = function()
  local status_ok, luasnip = pcall(require, "luasnip")

  if not status_ok then
    return
  end

  luasnip.config.setup({
    history = true,
    enable_autosnippets = true,
    -- Update more often, :h events for more info.
    -- updateevents = "TextChanged,TextChangedI",
  })

  local lsl_status_ok, lsl = pcall(require, "luasnip.loaders.from_lua")

  if lsl_status_ok then
    local snippet_path = vim.fn.stdpath("config") .. "/lua/jokajak/snippets"
    lsl.lazy_load({ paths = snippet_path })
  end
  require("luasnip.loaders.from_vscode").lazy_load()
end

return M
