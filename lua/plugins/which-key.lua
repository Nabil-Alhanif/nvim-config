local M = {}

function M.setup()
	local wk = require("which-key")

	wk.setup({
		-- 1. Modern Presets (Optional)
		-- Options: "classic", "modern", "helix"
		preset = "modern",

		-- 2. New Window/Layout Config
		win = {
			border = "rounded", -- 'none', 'single', 'double', 'shadow', 'rounded'
			-- Padding and margin are now part of the window (win) or layout spec
			padding = { 1, 2 }, -- [top/bottom, right/left]
			title = true,
			title_pos = "center",
			zindex = 1000,
		},

		layout = {
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
		},

		-- 3. Icons (Now integrates natively with mini.icons or nvim-web-devicons)
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
		},
	})
end

return M
