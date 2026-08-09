local M = {}

function M.setup()
	-- default settings
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
				template = "%d lines",
				hlgroup = "Comment",
			},
			diagnosticsCount = true,
			gitsignsCount = true,
		},
		autoFold = {
			enabled = true,
			kinds = { "comment", "imports" },
		},
		foldKeymaps = {
			setup = true, -- modifies `h`, `l`, `^`, and `$`
			closeOnlyOnFirstColumn = false, -- `h` and `^` only fold in the 1st column
			scrollLeftOnCaret = false, -- `^` should scroll left (basically mapped to `0^`)
		},
	})
end

return M
