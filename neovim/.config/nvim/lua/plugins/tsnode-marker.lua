-- https://github.com/atusy/tsnode-marker.nvim
-- Mark treesitter node to enhance context changes in your buffer.
-- E.g. use different background for code blocks in markdown
local M = {
  "atusy/tsnode-marker.nvim",
  lazy = true,
  ft = {
    "markdown",
    "lua",
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("tsnode-marker-markdown", {}),
      pattern = "markdown",
      callback = function(ctx)
        require("tsnode-marker").set_automark(ctx.buf, {
          target = { "code_fence_content" }, -- list of target node types
          hl_group = "CursorLine", -- highlight group
        })
      end,
    })
  end,
}

return M
