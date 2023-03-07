-- https://github.com/windwp/nvim-autopairs
-- A super powerful autopair plugin for Neovim that supports multiple characters.

local M = {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  lazy = true,
}

M.config = function()
  local status_ok, autopairs = pcall(require, "nvim-autopairs")
  if not status_ok then
    return
  end

  autopairs.setup({
    check_ts = true,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      java = false,
    },
    disable_filetype = { "TelescopePrompt" },
    fast_wrap = {
      map = "<M-e>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      offset = 0, -- Offset from pattern match
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "PmenuSel",
      highlight_grey = "LineNr",
    },
  })

  local cmp_ok, cmp = pcall(require, "cmp")
  if cmp_ok then
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end
end

local mini_pairs = {
  "echasnovski/mini.pairs",
  enabled = false,
}

return {
  M,
  mini_pairs,
}
