-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Add ansible filetype
vim.filetype.add({
  pattern = {
    [".*/playbooks/**/*%.ya?ml"] = "yaml.ansible",
    ["site%.yml"] = "yaml.ansible",
    [".*/roles/.*%.ya?ml"] = "yaml.ansible",
    [".*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/tasks/.*%.ya?ml"] = "yaml.ansible",
  },
})

-- add helm filetype
vim.filetype.add({
  pattern = {
    ["*/chart/templates/*%.ya?ml"] = "yaml.helm",
  },
})
