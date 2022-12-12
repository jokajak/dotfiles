-- https://github.com/nvim-tree/nvim-tree.lua
-- A File Explorer For Neovim Written In Lua

local M = {
  "nvim-tree/nvim-tree.lua",
  tag = "nightly",
  cmd = {
    "NvimTreeToggle",
    "NvimTreeFocus",
    "NvimTreeFindFile",
    "NvimTreeCollapse",
  },
  module = "nvim-tree",
}

local Keymap = require("util.keymap")

local function collapse_all()
  require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

M.config = function()
  local status_ok, nvim_tree = pcall(require, "nvim-tree")

  if not status_ok then
    return
  end

  local lib = require("nvim-tree.lib")
  local view = require("nvim-tree.view")
  local nvim_tree_status, open_file = pcall(require, "nvim-tree.actions.node.open-file")

  if not nvim_tree_status then
    -- use default if actions can't be found
    nvim_tree.setup({})
  end

  local function edit_or_open()
    -- open as vsplit on current node
    local action = "edit"
    local node = lib.get_node_at_cursor()

    if not node then
      return
    end
    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
      open_file.fn(action, node.link_to)
    elseif node.nodes ~= nil then
      lib.expand_or_collapse(node)
    else
      open_file.fn(action, node.absolute_path)
    end
  end

  local function vsplit_preview()
    -- open as vsplit on current node
    local action = "vsplit"
    local node = lib.get_node_at_cursor()

    if not node then
      return
    end

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
      open_file.fn(action, node.link_to)
    elseif node.nodes ~= nil then
      lib.expand_or_collapse(node)
    else
      open_file.fn(action, node.absolute_path)
    end

    -- Finally refocus on tree if it was lost
    view.focus()
  end

  nvim_tree.setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    open_on_tab = false,
    hijack_cursor = false,
    sync_root_with_cwd = true,
    ignore_ft_on_setup = {
      "startify",
      "dashboard",
      "alpha",
    },
    diagnostics = {
      enable = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },
    view = {
      width = 30,
      hide_root_folder = false,
      side = "left",
      mappings = {
        custom_only = false,
        list = {
          { key = "l", action = "edit", action_cb = edit_or_open },
          { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
          { key = "h", action = "close_node" },
          { key = "H", action = "collapse_all", action_cb = collapse_all },
          { key = "<C-t>", action = "Live grep" },
        },
      },
      number = false,
      relativenumber = false,
    },
    filters = { custom = { "^.git$" } },
  })
  -- Toggle nvim-tree
end

M.init = function()
  Keymap.nnoremap("<Leader>e", function()
    require("nvim-tree.api").tree.toggle(false, true)
  end, { silent = true, desc = "Open tree view" })
end

return M
