-- plug
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local cache_path = fn.stdpath('cache')..'/plugin/packer_compiled.lua'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  print("Installed packer, close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Failed to load packer, cannot install plugins.")
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
packer.startup(function(use)
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" }) -- Useful lua functions used by lots of plugins
	use({ "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" }) -- fun icons
	use({ "kyazdani42/nvim-tree.lua", tag = "nightly" })  -- file navigator
  use { 'lewis6991/impatient.nvim' }                 -- improve startup time
  use { 'ggandor/leap.nvim' }                        -- move within the window
  use { 'lewis6991/gitsigns.nvim' }                  -- git gutter
  use { 'edluffy/specs.nvim' }                       -- highlight cursor jumps

  -- [[ Themes ]] --
  use { 'folke/tokyonight.nvim' }                    -- tokyonight theme

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

require("jokajak.plugins.nvim-tree")
