local M = {}

function M.setup()
	local opts = {
		formatters_by_ft = {
			cpp = { "clang_format" },
			hpp = { "clang_format" },
			c = { "clang_format" },
			h = { "clang_format" },
			lua = { "stylua" },
			python = { "black" },
			cmake = { "cmake_format" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
	}

	require("conform").setup(opts)
end

return M
