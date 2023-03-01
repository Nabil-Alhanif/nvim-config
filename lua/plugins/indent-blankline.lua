local M = {}

function M.setup()
	vim.opt.list = true
	vim.opt.listchars:append('eol:↴')

	local opts = {
		space_char_blankline = ' ',
		show_current_context = true,
		show_current_context_start = true,
		show_end_of_line = true,
	}

	require('indent_blankline').setup(opts)
end

return M
