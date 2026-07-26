local M = {}

function M.setup()
	require("nvim-treesitter").setup()

	vim.api.nvim_create_autocmd("FileType", {
		callback = function(args)
			pcall(vim.treesitter.start, args.buf)
		end,
	})
end

return M
