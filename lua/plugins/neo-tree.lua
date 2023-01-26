local M = {}

function M.setup()
	vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

	local opts = {
		close_if_last_window = true,
		window = {
			width = 35,
		},
	}

	require('neo-tree').setup(opts)
end

return M
