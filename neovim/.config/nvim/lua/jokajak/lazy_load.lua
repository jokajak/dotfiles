-- This adds helpers for lazy loading.
-- Mostly copied from https://github.com/NvChad/NvChad/blob/main/lua/core/lazy_load.lua

local M = {}
local autocmd = vim.api.nvim_create_autocmd  -- shortcut for function

M.packer_cmds = {
  "PackerSnapshot",
  "PackerSnapshotRollback",
  "PackerSnapshotDelete",
  "PackerInstall",
  "PackerUpdate",
  "PackerSync",
  "PackerClean",
  "PackerCompile",
  "PackerStatus",
  "PackerProfile",
  "PackerLoad",
}

M.treesitter_cmds = {
  "TSInstall",
  "TSBufEnable",
  "TSBufDisable",
  "TSEnable",
  "TSDisable",
  "TSModuleInfo",
}

M.mason_cmds = {
  "Mason",
  "MasonInstall",
  "MasonInstallAll",
  "MasonUninstall",
  "MasonUninstallAll",
  "MasonLog",
}

local plugins_ok, plugins = pcall(require, "jokajak.plugins")
local packer_ok, packer = pcall(require, "packer")
M.git = function()
  autocmd({ "BufRead" }, {
    callback = function()
      if not (plugins_ok and packer_ok) or plugins["git"] == nil then
        return
      end
      vim.fn.system("git rev-parse " .. vim.fn.expand "%:p:h")
      local file_in_git = vim.v.shell_error == 0
      if file_in_git then
        vim.schedule(function()
          for _, plugin in pairs(plugins["git"]) do
            packer.loader(plugin)
          end
        end)
      end
    end,
  })
end

return M
