-- https://github.com/lukas-reineke/indent-blankline.nvim
-- highlight indentation

local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

vim.g.rainbow_delimiters = { highlight = highlight }

local hooks_ret, hooks = pcall(require, "ibl.hooks")
if hooks_ret then
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  end)

  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

  local nodes = {
    lua = {
      "arguments",
      "field",
      "method_index_expression",
      "return_statement",
      "table_constructor",
    },
  }

  local ibl = {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        show_start = true,
        show_end = true,
        highlight = highlight,
        injected_languages = true,
        priority = 1000,
        include = {
          node_type = {
            lua = nodes.lua,
          },
        },
      },
    },
  }

  return ibl
else
  return {}
end
