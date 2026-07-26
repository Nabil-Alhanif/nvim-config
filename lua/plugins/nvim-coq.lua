local M = {}

function M.setup()
	vim.g.coq_settings = {
		keymap = {
			recommended = true,
			pre_select = false,
			manual_complete = "<C-space>",
		},
		completion = {
			always = true,
			sticky_manual = true,
			skip_after = {},
		},
		display = {
			ghost_text = {
				enabled = true,
				highlight_group = "Comment",
			},
			pum = {
				ellipsis = "…",
				source_context = { "「", "」" },
			},
			preview = {
				enabled = true,
				x_max_len = 88,
				border = "rounded",
			},
			icons = {
				mode = "long",
				spacing = 1,
			},
		},
		clients = {
			lsp = {
				resolve_timeout = 0.09,
			},
			paths = {
				resolution = { "cwd", "file" },
				preview_lines = 6,
			},
			buffers = {
				same_filetype = false,
			},
		},
		limits = {
			idle_timeout = 1.88,
		},
	}

	local status_ok, coq_3p = pcall(require, "coq_3p")
	if status_ok then
		coq_3p({
			{ src = "nvimlua", short_name = "nLUA" },
			{ src = "repl", short_name = "SHELL" },
			{ src = "bc", short_name = "MATH" },
		})
	end
end

return M
