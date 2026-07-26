do
	local ok = pcall(require, vim.g.nix_info_plugin_name or "nix-info")
	if not ok then
		package.loaded[vim.g.nix_info_plugin_name or "nix-info"] = setmetatable({}, {
			__call = function(_, default)
				return default
			end,
		})
	end
end

require("plugins.catppuccin").setup()
require("plugins.alpha").setup()
require("plugins.nvim-notify").setup()
require("plugins.indent-blankline").setup()
require("plugins.neo-tree").setup()
require("plugins.which-key").setup()
require("plugins.toggleterm").setup()
require("plugins.nvim-coq").setup()
require("plugins.conform").setup()
require("plugins.gitsigns").setup()
require("plugins.nvim-treesitter").setup()
require("plugins.telescope").setup()
require("plugins.typst-preview").setup()
