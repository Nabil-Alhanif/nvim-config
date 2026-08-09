local M = {}

function M.setup()
	require("origami").setup({
		useLspFoldsWithTreesitterFallback = {
			enabled = true,
			foldmethodIfNeitherIsAvailable = "indent",
		},
		pauseFoldsOnSearch = true,
		foldtext = {
			enabled = true,
			padding = {
				character = " ",
				width = 3,
				hlgroup = nil,
			},
			lineCount = {
				template = "%d  asdkfjaslkdfj;salkdjflk;asjfl;ksadjfl;ksfjda;lj lines",
				hlgroup = "Comment",
			},
			diagnosticsCount = true,
			gitsignsCount = true,
		},
		autoFold = {
			enabled = false,
			kinds = { "comment", "imports" },
		},
		foldKeymaps = {
			setup = true, -- modifies `h`, `l`, `^`, and `$`
			closeOnlyOnFirstColumn = false, -- `h` and `^` only fold in the 1st column
			scrollLeftOnCaret = false, -- `^` should scroll left (basically mapped to `0^`)
		},
	})

	-- Disable vim autofolding
	vim.opt.foldlevel = 99
	vim.opt.foldlevelstart = 99
end

return M
