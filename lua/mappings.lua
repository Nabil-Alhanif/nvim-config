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
    insert_mode = {
        -- Snippet jump forward (replaces coq.nvim's removed jump_to_mark)
        ['<C-y>'] = function() vim.snippet.jump(1) end,
    },
    normal_mode = {
        -- --- LSP Diagnostics (Modern API) ---
        ['<C-n>'] = vim.diagnostic.goto_next,
        ['<C-p>'] = vim.diagnostic.goto_prev,

        -- --- Window Movements ---
        ['<C-h>'] = '<C-w>h',
        ['<C-j>'] = '<C-w>j',
        ['<C-k>'] = '<C-w>k',
        ['<C-l>'] = '<C-w>l',

        -- --- File Explorer (NeoTree) ---
        ['<leader>e'] = '<cmd>Neotree focus toggle<cr>',

        -- --- Utility ---
        -- Clear search highlight and clear command line
        ['<Esc>'] = function()
            vim.cmd("nohlsearch")
            vim.msg = "" 
        end,

        -- --- Telescope (Built-in + Extensions) ---
        ['<leader>ff'] = '<cmd>Telescope find_files<cr>',
        ['<leader>fg'] = '<cmd>Telescope live_grep<cr>',
        ['<leader>fb'] = '<cmd>Telescope buffers<cr>',
        ['<leader>fh'] = '<cmd>Telescope help_tags<cr>',
        ['<leader>fe'] = '<cmd>Telescope file_browser<cr>',
        ['<leader>fp'] = '<cmd>Telescope project<cr>',
        ['<leader>fs'] = '<cmd>Telescope persisted<cr>',

        -- --- Git ---
        ['<leader>gg'] = function() require("utils.lazygit"):toggle() end,

        -- --- Terminal (ToggleTerm) ---
        ['<leader>n'] = '<cmd>ToggleTerm size=15 direction=horizontal<cr>',
        ['<C-t>']     = '<cmd>ToggleTerm direction=float<cr>',
    },
    term_mode = {
        -- Escape terminal mode easily
        ['<Esc>'] = [[<C-\><C-n>]],
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

--- Set a single keymap
function M.set_keymap(mode, key, val)
    local opt = default_opts
    if type(val) == 'table' then
        opt = val[2]
        val = val[1]
    end
    if val then
        -- vim.keymap.set is the modern preferred way over vim.api.nvim_set_keymap
        vim.keymap.set(mode, key, val, opt)
    end
end

--- Load a specific mode table
function M.load_mode(mode, keymaps)
    mode = mode_adapters[mode] or mode
    for k, v in pairs(keymaps) do
        M.set_keymap(mode, k, v)
    end
end

--- Initialize all mappings
function M.load()
    for mode, mapping in pairs(defaults) do
        M.load_mode(mode, mapping)
    end
end

return M
