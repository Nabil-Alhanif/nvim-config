local indent = 4 -- Standard indentation level

local M = {} -- Module table

M.default_options = {
	opt = { -- Neovim options
		completeopt = "menu,menuone,noinsert", -- Completion menu behavior

		shiftwidth = indent, -- Indent width for commands
		tabstop = indent, -- Visual width of tabs
		softtabstop = indent, -- <Tab> key behavior
		expandtab = false, -- Use tabs, not spaces

		autoindent = true, -- Auto-indent new lines
		smartindent = true, -- Context-aware indenting
		smarttab = true, -- Smart tab insertion at line start

		ignorecase = true, -- Case-insensitive search
		smartcase = true, -- Case-sensitive search if uppercase
		hlsearch = true, -- Highlight search matches
		incsearch = true, -- Show matches while typing

		showcmd = true, -- Display incomplete commands
		termguicolors = true, -- Enable true color

		-- --- Line Numbering Section ---
		number = true, -- Disable absolute line numbers
		relativenumber = true, -- Enable relative numbers (shows 0 on current line)
		-- ------------------------------

		wrap = true, -- Wrap long lines

		splitbelow = true, -- New splits below
		splitright = true, -- New splits to the right

		mouse = "inv", -- Enable mouse (except in insert mode)
	},
	g = { -- Global variables
		mapleader = " ", -- Leader key for mappings
	},
}

function M.set(options) -- Apply options from a table
	for scope, table in pairs(options) do
		for setting, value in pairs(table) do
			vim[scope][setting] = value
		end
	end
end

function M.setup() -- Apply default options
	M.set(M.default_options)
end

return M
