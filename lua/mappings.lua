-- ╔════════════════════════════════╦═════════════════════════════════════════╗
-- ║            COMMANDS            ║                                         ║
-- ╠═════════╦════════════╦═════════╣                                         ║
-- ║Add      ║Add         ║Remove   ║                 MODES                   ║
-- ║(or list)║Non-Recurs. ║Mapping  ║               IT WORKS                  ║
-- ║Mapping  ║Mapping     ║         ║                                         ║
-- ╠═════════╬════════════╬═════════╬═════════════════════════════════════════╣
-- ║:map     ║:noremap    ║:unmap   ║ Normal, Visual, Select, Operator-pending║
-- ║:nmap    ║:nnoremap   ║:nunmap  ║ Normal                                  ║
-- ║:vmap    ║:vnoremap   ║:vunmap  ║ Visual and Select                       ║
-- ║:smap    ║:snoremap   ║:sunmap  ║ Select                                  ║
-- ║:xmap    ║:xnoremap   ║:xunmap  ║ Visual                                  ║
-- ║:omap    ║:onoremap   ║:ounmap  ║ Operator-pending                        ║
-- ║:map!    ║:noremap!   ║:unmap!  ║ Insert and Command-line                 ║
-- ║:imap    ║:inoremap   ║:iunmap  ║ Insert                                  ║
-- ║:lmap    ║:lnoremap   ║:lunmap  ║ Insert, Command-line, Lang-Arg          ║
-- ║:cmap    ║:cnoremap   ║:cunmap  ║ Command-line                            ║
-- ║:tmap    ║:tnoremap   ║:tunmap  ║ Terminal-Job                            ║
-- ╚═════════╩════════════╩═════════╩═════════════════════════════════════════╝

local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true}

local mode_adapters = {
	insert_mode = 'i',
	normal_mode = 'n',
	term_mode = 't',
	visual_mode = 'v',
	visual_block_mode = 'x',
	command_mode = 'c',
	operator_pending_mode = 'o',
}

local defaults = {
	insert_mode = {},
	normal_mode = {
		-- LSP
		-- Some mappings are defined in lua/lsp.lua
		['<C-n>'] = ':lua vim.lsp.diagnostic.goto_next()<CR>',
		['<C-p>'] = ':lua vim.lsp.diagnostic.goto_prev()<CR>',

		-- Movements
		['<C-h>'] = '<C-w><C-h>',
		['<C-j>'] = '<C-w><C-j>',
		['<C-k>'] = '<C-w><C-k>',
		['<C-l>'] = '<C-w><C-l>',

		-- Toggle NeoTree
		['<leader>e'] = ':NeoTreeFocusToggle<CR>',

		-- Cancel search highlighting
		['<Esc>'] = ':nohlsearch | :echo<CR>',

		-- Telescope
		['<leader>ff'] = ':Telescope find_files<CR>',
		['<leader>fg'] = ':Telescope live_grep<CR>',
		['<leader>fb'] = ':Telescope buffers<CR>',
		['<leader>fh'] = ':Telescope help_tags<CR>',
		['<leader>fe'] = ':Telescope file_browser<CR>',
		['<leader>fp'] = ':Telescope project<CR>',
		['<leader>fs'] = ':Telescope persisted<CR>',

		['<leader>gg'] = ':lua require("utils.lazygit"):toggle()<CR>',

		-- Open new terminal
		--['<leader>n'] = ':split term://$SHELL | :resize 15<CR>',
		['<leader>n'] = ':ToggleTerm size=15 direction=horizontal<CR>',
		['<C-t>']     = ':ToggleTerm direction=float<CR>',
	},
	term_mode = {
		['<Esc>'] = '<C-\\><C-n>',
	},
	visual_mode = {
		-- Copy to system clipboard
		['<leader>Y'] = '"+y',
	},
	visual_block_mode = {},
	command_mode = {},
	operator_pending_mode = {},
}

local M = {}

function M.set_keymap(mode, key, val)
	local opt = default_opts
	if type(val) == 'table' then
		opt = val[2]
		val = val[1]
	end
	if val then
		vim.keymap.set(mode, key, val, opt)
	end
end

function M.load_mode(mode, keymaps)
	mode = mode_adapters[mode] or mode
	for k, v in pairs(keymaps) do
		M.set_keymap(mode, k, v)
	end
end

function M.load()
	for mode, mapping in pairs(defaults) do
		M.load_mode(mode, mapping)
	end
end

return M
