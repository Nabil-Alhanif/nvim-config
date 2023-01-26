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

vim.g.mapleader = ' '

local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true}

-- LSP
keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', default_opts)
keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', default_opts)
keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', default_opts)
keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', default_opts)
keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', default_opts)
keymap('n', '<space>ld', '<cmd>lua vim.lsp.buf.signature_help()<CR>', default_opts)
keymap('n', '<C-n>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', default_opts)
keymap('n', '<C-p>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', default_opts)

-- Movements
keymap('n', '<C-h>', '<C-w><C-h>', default_opts)
keymap('n', '<C-j>', '<C-w><C-j>', default_opts)
keymap('n', '<C-k>', '<C-w><C-k>', default_opts)
keymap('n', '<C-l>', '<C-w><C-l>', default_opts)

-- Use leader + tab to toggle Nvim-Tree
keymap({'n', 'v'}, '<leader>e', ':NeoTreeFocusToggle<CR>')

-- Cancel search highlighting witih ESC
keymap('n', '<ESC>', ':nohlsearch<Bar>:echo<CR>', default_opts)

-- Terminals
keymap('t', '<Esc>', '<C-\\><C-n>', default_opts)

vim.cmd([[au BufEnter * if &buftype == 'terminal' | :startinsert | endif]])

keymap('n', '<leader>n', ':split term://$SHELL <BAR> :resize 15<CR>', default_opts)
