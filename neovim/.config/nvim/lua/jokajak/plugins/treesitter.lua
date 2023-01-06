-- https://github.com/nvim-treesitter/nvim-treesitter
-- Interface with treesitter for enhanced code parsing

--[[ TreeSitter Configuration ]]
--
local M = {
  "nvim-treesitter/nvim-treesitter",
  as = "nvim-treesitter",
  run = ":TSUpdate",
  event = { "BufReadPost" },
  cmd = {
    "TSBufDisable",
    "TSBufEnable",
    "TSDisable",
    "TSDisableAll",
    "TSEnableAll",
    "TSInstallInfo",
    "TSInstall",
    "TSModuleInfo",
    "TSUpdate",
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring", -- commentstring support
    "nvim-treesitter/nvim-treesitter-context", -- show current function/class as float window at the top of the window
    "RRethy/nvim-treesitter-textsubjects",
    "p00f/nvim-ts-rainbow", -- rainbow brackets
    "mfussenegger/nvim-treehopper",
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  },
}

M.config = function()
  local status_ok, configs = pcall(require, "nvim-treesitter.configs")

  if not status_ok then
    return
  end

  configs.setup({
    ensure_installed = {
      "bash", -- per noice
      "dockerfile",
      "fish",
      "help", -- for vim help
      "hocon",
      "json",
      "jsonc",
      "lua", -- per noice
      "markdown", -- per noice
      "markdown_inline", -- per noice
      "python",
      "regex", -- per noice
      "toml",
      "vim", -- per noice, for vim command mode
      "yaml",
    },
    sync_install = false,
    ignore_install = { "" }, -- List of parsers to ignore installing
    autopairs = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false, -- disable CursorHold per context_commentstring
    },
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "" }, -- list of language that will be disabled
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true, disable = { "yaml", "python" } },
  })

  local status_ok, tscontext = pcall(require, "treesitter-context")

  if status_ok then
    -- mostly defaults
    local configuration = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    }
    tscontext.setup(configuration)
  end
end

return M
