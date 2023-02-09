local indent = 4
local default = {
	opt = {
		shiftwidth = indent,
		tabstop = indent,
		autoindent = true,
		smartindent = true,
		smarttab = true,

		ignorecase = true,
		smartcase = true,
		hlsearch = true,
		incsearch = true,

		showcmd = true,
		termguicolors = true,
		number = true,
		wrap = true,

		splitbelow = true,
		splitright = true,

		mouse = 'inv',
	},
	g = {
		mapleader = ' ',
	},
}

local M = {}

function M.set(options)
	for scope, table in pairs(options) do
		for setting, value in pairs(table) do
			vim[scope][setting] = value
		end
	end
end

function M.setup()
	M.set(default)
end

return M
