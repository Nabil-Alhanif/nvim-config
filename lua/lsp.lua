-- ----------------------------
-- | Language Server Protocol |
-- ----------------------------

local M = {}

-- Modern Autocmd for Keymaps (The 0.11+ way)
-- We use an autocmd instead of a function passed to setup
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
    require('mason').setup()
    require('mason-lspconfig').setup()

    -- In 0.11+, we use the new core configuration system
    -- This replaces the old lspconfig[server].setup() loops
    local lsp_config = vim.lsp.config
    local mason_lspconfig = require('mason-lspconfig')

    -- Get all servers Mason has installed
    local installed_servers = mason_lspconfig.get_installed_servers()

    for _, server_name in ipairs(installed_servers) do
        -- 1. Fetch any local custom settings from your lua/lsp/ folder
        local custom_opts = self:get_config(server_name)

        -- 2. Define the declarative config
        -- Instead of .setup(), we add to the vim.lsp.config table
        lsp_config[server_name] = vim.tbl_deep_extend("force", {
            cmd = { server_name, "--stdio" }, -- Default CMD, masonry usually handles pathing
            filetypes = {},                  -- Core will infer these from the server
            root_markers = { ".git", "package.json", "pyproject.toml" },
        }, custom_opts)

        -- 3. Enable the server
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
