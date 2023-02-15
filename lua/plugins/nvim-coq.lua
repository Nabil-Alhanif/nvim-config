local M = {}

function M.setup()
	vim.g.coq_settings = {
		keymap = {
			bigger_preview = nil,
			jump_to_mark = '<C-t>',
		},
	}

	require('coq_3p') {
		{ src = 'nvimlua', short_name = 'nLUA' },
	}
end

return M
