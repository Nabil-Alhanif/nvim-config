local M = {}
local initialized = false

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local opts = { buffer = bufnr, silent = true }

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K',  vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    end,
})

function M:init()
    if initialized then return end
    initialized = true

    require('mason').setup()
    require('mason-lspconfig').setup()

    local mason_lspconfig = require('mason-lspconfig')
    local installed_servers = mason_lspconfig.get_installed_servers()

    for _, server_name in ipairs(installed_servers) do
        local custom_opts = self:get_config(server_name)
        local config = vim.tbl_deep_extend("force", {
            cmd = { server_name, "--stdio" },
            filetypes = {},
            root_markers = { ".git", "package.json", "pyproject.toml" },
        }, custom_opts)

        vim.lsp.config(server_name, config)
        vim.lsp.enable(server_name)
    end
end

function M:get_config(server)
    local server_conf_mod = 'lsp.' .. server
    local status_ok, conf = pcall(require, server_conf_mod)
    
    if not status_ok then
        -- Optional: Logic to create missing config files as you had before
        return {}
    end
    return conf
end

return M
