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

function map(mode, lhs, rhs, opts)
    local options = {}
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function noremap(mode, lhs, rhs, opts)
    local options = {noremap = true,}
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
