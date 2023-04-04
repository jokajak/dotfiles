-- https://github.com/jokajak/git-worktree.nvim.git
-- forked from https://github.com/ThePrimeagen/git-worktree.nvim.git
-- A simple wrapper around git worktree operations, create, switch, and delete.

local M = {
  "jokajak/git-worktree.nvim",
  module = "git-worktree",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    {
      "<leader>gwc",
      function()
        require("telescope").extensions.git_worktree.create_git_worktree()
      end,
      desc = "[G]it [W]orktree [C]reate",
    },
    {
      "<leader>gws",
      function()
        require("telescope").extensions.git_worktree.git_worktree()
      end,
      desc = "[G]it [W]orktree [S]witch",
    },
  },
}

M.config = function()
  local status_ok, gwt = pcall(require, "git-worktree")
  if not status_ok then
    return
  end

  local config = {}

  gwt.setup(config)
  require("telescope").load_extension("git_worktree")
end

return M
