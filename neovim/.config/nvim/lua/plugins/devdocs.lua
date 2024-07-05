-- https://github.com/luckasRanarison/nvim-devdocs
-- nvim-devdocs is a plugin which brings DevDocs documentations into neovim.
local devdocs = {
  "luckasRanarison/nvim-devdocs",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {},
  cmd = {
    "DevdocsFetch", -- Fetch DevDocs metadata.
    "DevdocsInstall", -- Install documentation, 0-n args.
    "DevdocsUninstall", -- Uninstall documentation, 0-n args.
    "DevdocsOpen", -- Open documentation in a normal buffer, 0 or 1 arg.
    "DevdocsOpenFloat", -- Open documentation in a floating window, 0 or 1 arg.
    "DevdocsUpdate", -- Update documentation, 0-n args.
    "DevdocsUpdateAll", -- Update all documentations.
  },
}

return devdocs
