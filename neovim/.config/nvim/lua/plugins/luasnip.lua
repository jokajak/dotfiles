-- https://github.com/L3MON4D3/LuaSnip
--

local M = {
  "L3MON4D3/LuaSnip",
  -- disable luasnip keys to enable supertab functionality (tab for completion and snippets)
  keys = function()
    return {}
  end,
}

M.config = function()
  local status_ok, luasnip = pcall(require, "luasnip")

  if not status_ok then
    return
  end

  luasnip.config.setup({
    history = true,
    enable_autosnippets = true,
  })

  require("luasnip.loaders.from_vscode").lazy_load()
  local snippet_path = vim.fn.stdpath("config") .. "/lua/snippets"
  require("luasnip.loaders.from_lua").load({ paths = snippet_path })
end

return M
