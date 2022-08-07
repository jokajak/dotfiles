-- enable new filetype detection
vim.g.do_filetype_lua = 1
-- disable legacy filetype detection
vim.g.did_load_filetypes = 0

-- Add new filetypes
vim.filetype.add({
  pattern = {
    [".*/playbooks/**/*%.ya?ml"] = "ansible",
    ["site%.yml"] = "ansible",
    [".*/roles/.*%.ya?ml"] = "ansible",
    [".*/handlers/.*%.ya?ml"] = "ansible",
    [".*/tasks/.*%.ya?ml"] = "ansible",
  },
})
