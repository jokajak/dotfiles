-- Plugins
-- Reference: https://github.com/folke/lazy.nvim

local M = {}

function M.load_plugins()
  require("lazy").setup("jokajak.plugins", {
    defaults = { lazy = true },
    install = { colorscheme = { "tokyonight" } },
    checker = { performance = true },
  })
end

return M
