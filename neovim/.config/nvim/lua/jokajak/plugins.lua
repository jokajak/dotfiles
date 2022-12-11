-- Plugins
-- Reference: https://github.com/wbthomason/packer.nvim

local M = {}

M.base_plugins = {
  -- packer itself
  { "wbthomason/packer.nvim", opt = false },
  -- fancy icons
  { "kyazdani42/nvim-web-devicons", opt = false },
  -- utility functions
  { "nvim-lua/plenary.nvim", opt = false },
  -- UI component library
  { "MunifTanjim/nui.nvim", event = "UIEnter" },
  -- Calculate startup time
  { "dstein64/vim-startuptime", opt = true, cmd = { "StartupTime" } },
}

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local bootstrap_packer = false

if fn.empty(fn.glob(install_path)) > 0 then
  bootstrap_packer = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installed packer, close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Failed to load packer, cannot install plugins.")
  return
end

function M.load_plugins()
  packer.init({
    profile = { enable = true },
    compile_on_sync = true,
    git = { clone_timeout = 6000 },
    opt_default = true,
    -- make dependencies of optional plugins optional by default
    transitive_opt = true,
    -- disable dependencies of disabled plugins by default
    transitive_disable = true,
    display = {
      working_sym = "ﲊ",
      error_sym = "✗ ",
      done_sym = " ",
      removed_sym = " ",
      moved_sym = "",
      -- Have packer use a popup window
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
    log = {
      level = "info",
    },
  })

  -- table to deduplicate plugins
  local plugins = {}

  -- add base plugins to plugins table
  for _, plugin in ipairs(M.base_plugins) do
    local plugin_name = plugin[1]
    plugins[plugin_name] = vim.tbl_deep_extend("force", plugins[plugin_name] or {}, plugin)
  end

  -- find all plugin configurations
  local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/jokajak/plugins/*.lua", false, true)
  -- Inject lsp file
  table.insert(plugin_files, vim.fn.stdpath("config") .. "/lua/jokajak/lsp/init.lua")
  -- prep all plugin configurations for packer
  for _, file in ipairs(plugin_files) do
    -- convert file path to lua module name
    local modname = file:match("lua/(.*)%.lua"):gsub("/", ".")
    -- load the contents from the file and run it
    local plugin = loadfile(file)
    if plugin then
      plugin = plugin()
      for k, v in pairs(plugin) do
        -- map the plugin definition to packer table entries
        if type(v) == "function" then
          -- filter for packer compatible functions
          if k == "init" or k == "run" or k == "config" then
            plugin[k == "init" and "setup" or k] = ('require("%s").%s()'):format(modname, k)
          else
            plugin[k] = nil
          end
        end
      end
      local req_name_segments = vim.split(plugin[1], "/")
      local plugin_name = req_name_segments[#req_name_segments]
      -- ensure plugins that require this plugin get loaded
      -- Useful when the dependent plugins don't need to be configured
      local dependent_plugins = plugin.dependencies or {}
      for _, dependent_plugin in pairs(dependent_plugins) do
        local new_plugin = {
          opt = plugin.opt or true,
          after = plugin.as or plugin_name,
          disable = plugin.disable or false,
        }
        if type(dependent_plugin) == "string" then
          new_plugin[1] = dependent_plugin
        elseif type(dependent_plugin) == "table" then
          new_plugin = vim.tbl_deep_extend("force", new_plugin, dependent_plugin)
        end
        plugins[new_plugin[1]] = vim.tbl_deep_extend("force", plugins[new_plugin[1]] or {}, new_plugin)
      end
      plugin.dependencies = nil
      -- add the plugin to the basic specifications
      if plugin[1] ~= nil then
        plugins[plugin[1]] = vim.tbl_deep_extend("force", plugins[plugin[1]] or {}, plugin)
      end
    end
  end
  local final_plugins = {}
  -- print(vim.inspect(plugins))
  for _, plugin in pairs(plugins) do
    table.insert(final_plugins, plugin)
  end
  packer.use(final_plugins)
  if bootstrap_packer then
    require("packer").sync()
  end
end

return M
