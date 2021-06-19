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

-- How to add mappings:
-- vim.api.nvim_set_keymap('mode', 'new mapping', 'stuff to do', 'options')

-- Example:
-- nnoremap <Space>h <C-w>h
-- vim.api.nvim_set_keymap('mode',  '<Space>h', '<C-w>h', {noremap = true})

vim.g.mapleader = ' '

-- Helper function for mapping
require('modules/keymap')

-- ----------------------
-- | Clipboard Mappings |
-- ----------------------

noremap('v', '<leader>y', '"+y')
noremap('v', '<leader>Y', '"+y')

-- ----------------
-- | Key Mappings |
-- ----------------

-- Use leader + vr to reload vim config
noremap('n', '<leader>vr', ':Reload<CR>')

-- ----------------
-- | LSP Mappings |
-- ----------------

noremap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {silent = true})
noremap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {silent = true})
noremap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {silent = true})
noremap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {silent = true})
noremap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {silent = true})
noremap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {silent = true})
noremap('n', '<C-n>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {silent = true})
noremap('n', '<C-p>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {silent = true})

-- ------------
-- | Movement |
-- ------------

-- Use space + hjkl to move between panels
noremap('n', '<Space>h', '<C-w>h')
noremap('n', '<Space>j', '<C-w>j')
noremap('n', '<Space>k', '<C-w>k')
noremap('n', '<Space>l', '<C-w>l')

-- -----------------------
-- | Nvim-Compe Mappings |
-- -----------------------

noremap('i', '<C-Space>', 'compe#complete()', {silent = true, expr = true})
noremap('i', '<CR>', 'compe#confirm("<CR>")', {silent = true, expr = true})
noremap('i', '<C-e>', 'compe#close("<C-e>")', {silent = true, expr = true})

-- ----------------------
-- | Nvim-Tree Mappings |
-- ----------------------

-- Use leader + tab to toggle Nvim-Tree
noremap('n', '<leader><Tab>', ':NvimTreeToggle<CR>')

-- -------------------
-- | Rnvimr Mappings |
-- -------------------

noremap('t', ',i', '<C-\\><C-n>:RnvimrResize<CR>', {silent = true})
noremap('n', ',r', ':RnvimrToggle<CR>', {silent = true})
noremap('t', ',r', '<C-\\><C-n>:RnvimrToggle<CR>', {silent = true})

-- ---------------------
-- | Terminal Mappings |
-- ---------------------

noremap('t', '<Esc>', '<C-\\><C-n>')

vim.cmd([[au BufEnter * if &buftype == 'terminal' | :startinsert | endif]])

noremap('n', '<leader>n', ':split term://$SHELL <BAR> :resize 15<CR>')
