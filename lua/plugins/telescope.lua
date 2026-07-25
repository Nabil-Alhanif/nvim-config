local M = {}

function M.setup()
	local actions = require("telescope.actions")

	require("telescope").setup({
		defaults = {
			file_ignore_patterns = { ".git/", "node_modules", "__pycache__", "target/", "result" },
			mappings = {
				i = { ["<Esc>"] = actions.close },
			},
		},
		pickers = {
			find_files = { hidden = true },
		},
		extensions = {
			file_browser = { hidden = true, grouped = true },
			project = { base_dirs = { "~/dev", "~" } },
		},
	})

	require("telescope").load_extension("file_browser")
	require("telescope").load_extension("persisted")
	require("telescope").load_extension("project")
	pcall(function() require("telescope").load_extension("zotero") end)
end

return M
