local M = {}

function M.setup()
	local opts = {
		shade_terminals = false,
		float_opts = {
			border = 'curved',
		},
	}

	require('toggleterm').setup(opts)
end

return M
