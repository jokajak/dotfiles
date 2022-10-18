-- Add new filetypes
vim.filetype.add({
  pattern = {
    [".*/playbooks/**/*%.ya?ml"] = "yaml.ansible",
    ["site%.yml"] = "yaml.ansible",
    [".*/roles/.*%.ya?ml"] = "yaml.ansible",
    [".*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/tasks/.*%.ya?ml"] = "yaml.ansible",
  },
})
