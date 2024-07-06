-- nvim-telescope/telescope.nvim
-- fancy picker

local focus_preview = function(prompt_bufnr)
  local action_state = require("telescope.actions.state")
  local actions = require("telescope.actions")
  local picker = action_state.get_current_picker(prompt_bufnr)
  local prompt_win = picker.prompt_win
  local previewer = picker.previewer
  local winid = previewer.state.winid
  local bufnr = previewer.state.bufnr
  vim.keymap.set("n", "<Tab>", function()
    vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", prompt_win))
  end, { buffer = bufnr })
  vim.keymap.set("n", "q", function()
    actions.close(prompt_bufnr)
  end, { buffer = bufnr })
  vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", winid))
  -- api.nvim_set_current_win(winid)
end
local telescope = {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    opts.defaults = vim.tbl_extend("force", opts.defaults or {}, {
      mappings = {
        n = {
          ["<Tab>"] = focus_preview,
        },
      },
    })
  end,
}
return telescope
