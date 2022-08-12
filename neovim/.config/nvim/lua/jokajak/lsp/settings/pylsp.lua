-- python-lsp-server lsp settings
return {
	settings = {
		pylsp = {
      configurationSources = { 'flake8' },
      plugins = {
        flake8 = { enabled = true },
        pycodestyle = { enabled = false }
      }
		},
	},
}
