local M = {}

function M.setup()
	local wk = require('which-key')

	local opts = {
		window = {
			border = 'rounded',
			padding = { 2, 2, 2, 2 },
		},
	}

	wk.setup(opts)
end

return M
