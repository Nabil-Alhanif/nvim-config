local M = {}

function M.setup()
	local opts = {
		ensure_installed = { 'lua' },
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = {
			enable = false,
		},
	}

	require('nvim-treesitter.configs').setup(opts)
end

return M
