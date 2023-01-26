local M = {}

function M.setup()
	require('catppuccin').setup({
		flavour = 'mocha',
	})

	vim.cmd.colorscheme 'catppuccin'
end

return M
