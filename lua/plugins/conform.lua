local M = {}

function M.setup()
	local opts = {
		formatters = {
			typstyle = {
				command = "typstyle",
				args = { "--indent-width", "4" },
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
			typst = { "typstyle" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
	}

	require("conform").setup(opts)
end

return M
