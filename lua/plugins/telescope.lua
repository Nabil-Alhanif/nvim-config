local M = {}

function M.setup()
	require('telescope').load_extension('file_browser')
	require('telescope').load_extension('persisted')
	require('telescope').load_extension('project')
end

return M
