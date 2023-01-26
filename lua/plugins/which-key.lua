local M = {}

function M.setup()
	local wk = require('which-key')

	local opts = {
		window = {
			border = 'rounded',
			padding = { 2, 2, 2, 2 },
		},
	}

	local mappings = {
	}

	wk.setup(opts)
	wk.register(mappings)
end

return M
