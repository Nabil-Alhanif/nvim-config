local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
	cmd = 'lazygit',
	dir = 'git_dir',
	direction = 'float',
	float_opts = {
		border = 'double',
	},
	on_open = function(term)
		vim.cmd('startinsert!')
		vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', ':close<CR>', { noremap = true, silent = true })
	end,
	on_close = function(term)
		vim.cmd('startinsert!')
	end,
})

return lazygit
