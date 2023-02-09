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
		['gd'] = '<cmd>lua vim.lsp.buf.definition()<CR>',
		['gD'] = '<cmd>lua vim.lsp.buf.declaration()<CR>',
		['gr'] = '<cmd>lua vim.lsp.buf.references()<CR>',
		['gi'] = '<cmd>lua vim.lsp.buf.implementation()<CR>',
		['K'] = '<cmd>lua vim.lsp.buf.hover()<CR>',
		['<space>ld'] = '<cmd>lua vim.lsp.buf_signature_help()<CR>',
		['<C-n>'] = '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
		['<C-p>'] = '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',

		-- Movements
		['<C-h>'] = '<C-w><C-h>',
		['<C-j>'] = '<C-w><C-j>',
		['<C-k>'] = '<C-w><C-k>',
		['<C-l>'] = '<C-w><C-l>',

		-- Toggle NeoTree
		['<leader>e'] = ':NeoTreeFocusToggle<CR>',

		-- Cancel search highlighting
		['<Esc>'] = ':nohlsearch<Bar>:echo<CR>',

		-- Open new terminal
		['<leader>n'] = ':split term://$SHELL <Bar> :resize 15<CR>',
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
