local status_ok, nvim_tree = pcall(require, "nvim-tree")

if not status_ok then
  return
end

local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")

if not status_ok then
  return
end

local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")


local function collapse_all()
    require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

local function edit_or_open()
    -- open as vsplit on current node
    local action = "edit"
    local node = lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
        require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
        view.close() -- Close the tree if file was opened

    elseif node.nodes ~= nil then
        lib.expand_or_collapse(node)

    else
        require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
        view.close() -- Close the tree if file was opened
    end

end

local function vsplit_preview()
    -- open as vsplit on current node
    local action = "vsplit"
    local node = lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
        require('nvim-tree.actions.node.open-file').fn(action, node.link_to)

    elseif node.nodes ~= nil then
        lib.expand_or_collapse(node)

    else
        require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)

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
  update_cwd = true,
  -- git_hl = 1,
  -- disable_window_picker = 0,
  -- root_folder_modifier = ":t",
  -- show_icons = {
  --   git = 1,
  --   folders = 1,
  --   files = 1,
  --   folder_arrows = 1,
  --   tree_width = 30,
  -- },
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  -- update_to_buf_dir = {
  --   enable = true,
  --   auto_open = true,
  -- },
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
    height = 30,
    hide_root_folder = false,
    side = "left",
    --adaptive_resize = true,
    mappings = {
      custom_only = false,
      list = {
        { key = "l", action = "edit", action_cb = edit_or_open },
        { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
        { key = "h", action = "close_node" },
        { key = "H", action = "collapse_all", action_cb = collapse_all },
      },
    },
    number = false,
    relativenumber = false,
  },
  filters = { custom = { "^.git$" } }
})
