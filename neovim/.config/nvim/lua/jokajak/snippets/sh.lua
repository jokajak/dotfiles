--[[ snippets for shell files ]] --
local status_ok, ls = pcall(require, "luasnip")

if not status_ok then
  return
end

local s = ls.snippet
local t = ls.text_node

local snippets = {}

table.insert(snippets,
  -- trigger is #strictmode
  s({
    trig = "#strictmode",
    name ="Bash strict mode",
    dscr = "Bash strict mode boilerplate",
    wordTrig = true,

  }, {
    t(
      {
        "# From http://redsymbol.net/articles/unofficial-bash-strict-mode/",
        "set -euo pipefail",
        "IFS=$'\\n\\t'",
        "",
      }
      )
  })
)

return snippets
