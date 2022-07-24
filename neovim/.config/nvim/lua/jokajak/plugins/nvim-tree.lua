local status_ok, nvim_tree = pcall(require, "nvim-tree")

if not status_ok then
  vim.notify("nvim-tree not available, aborting.")
  return
end

nvim_tree.setup({
  view = {
    adaptive_size = true,
    side = "left"
  }
})
