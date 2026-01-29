local M = {}

function M.setup()
    -- Change: use 'nvim-treesitter' directly instead of '.configs'
    local ts = require('nvim-treesitter')

    -- In the new v1.0+ version, configuration is handled differently.
    -- If you want to keep it simple and similar to before:
    ts.setup({
        ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        auto_install = true,
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
    })
end

return M
