--[[ nvim-autopairs ]]--
local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

autopairs.setup {
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
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
}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local status_ok, cmp = pcall(require, "cmp")
if status_ok then
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end
