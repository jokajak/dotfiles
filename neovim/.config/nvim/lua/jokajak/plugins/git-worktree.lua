-- https://github.com/jokajak/git-worktree.nvim.git
-- forked from https://github.com/ThePrimeagen/git-worktree.nvim.git
-- A simple wrapper around git worktree operations, create, switch, and delete.

local M = {
  "jokajak/git-worktree.nvim",
  module = "git-worktree",
  after = "nvim-treesitter",
}

local util = require("util")

M.config = function()
  local status_ok, gwt = pcall(require, "git-worktree")
  if not status_ok then
    return
  end

  local config = {}

  gwt.setup(config)

  -- local telescope_ok, telescope = pcall(require, "telescope")
  -- if not telescope_ok then
  --   return
  -- end
  --
  -- telescope.load_extension("git_worktree")
end

local function telescope_prompt()
  local telescope_ok, telescope = util.require("telescope")
  if not telescope_ok then
    return
  end

  telescope.load_extension("git_worktree")
  telescope.extensions.git_worktree.git_worktrees()
end

M.init = function()
  vim.keymap.set("n", "<leader>gwc", function()
    require("telescope").extensions.git_worktree.create_git_worktree()
  end, { desc = "[G]it [W]orktree [C]reate" })
  vim.keymap.set("n", "<leader>gws", function()
    require("telescope").extensions.git_worktree.git_worktree()
  end, { desc = "[G]it [W]orktree [S]witch" })
  -- make sure to pass the reference to the function rather than an invocation
  -- which means do not include ()
  vim.keymap.set("n", "<leader>sW", telescope_prompt, { desc = "[S]earch [W]orktrees" })
end

return M
