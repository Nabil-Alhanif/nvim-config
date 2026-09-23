local M = {}

function M.setup()
	local opts = {
		formatters = {
			typstyle_tabs = {
				command = "bash",
				args = {
					"-c",
					"set -o pipefail; typstyle --indent-width 4 | sed -e ':a' -e 's/^\\(\\t*\\)    /\\1\\t/' -e 'ta'",
					"typstyle-tabs",
				},
				stdin = true,
			},
		},
		formatters_by_ft = {
			cpp = { "clang_format" },
			hpp = { "clang_format" },
			c = { "clang_format" },
			h = { "clang_format" },
			lua = { "stylua" },
			python = { "black" },
			cmake = { "cmake_format" },
			typst = { "typstyle_tabs" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
	}

	require("conform").setup(opts)
end

return M
