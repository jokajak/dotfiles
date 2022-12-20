-- https://github.com/numToStr/Comment.nvim
--

local M = {
  "numToStr/Comment.nvim",
  keys = { "gc", "gb" },
}

M.config = function()
  --[[ Comments ]]
  --
  local status_ok, comment = pcall(require, "Comment")

  if not status_ok then
    return
  end

  local ts_comment_string_ok, _ = pcall(require, "ts_context_commentstring.utis")

  local pre_hook = function() end
  if ts_comment_string_ok then
    -- copy/pasta from nvim-ts-context-commentstring readme
    pre_hook = function(ctx)
      local U = require("Comment.utils")

      local location = nil
      if ctx.ctype == U.ctype.block then
        location = require("ts_context_commentstring.utils").get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require("ts_context_commentstring.utils").get_visual_start_location()
      end

      return require("ts_context_commentstring.internal").calculate_commentstring({
        key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
        location = location,
      })
    end
  end
  comment.setup({
    pre_hook = pre_hook,
  })

  local api = require("Comment.api")
  vim.keymap.set(
    "n",
    "<leader>/",
    api.toggle.linewise.current,
    { silent = true, noremap = true, desc = "Comment line" }
  )
  vim.keymap.set(
    "v",
    "<leader>/",
    api.toggle.blockwise.current,
    { silent = true, noremap = true, desc = "Comment selection" }
  )
end

return M
