-- ----------------------------
-- | Language Server Protocol |
-- ----------------------------

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentaion',
        'detail',
        'additionalTextEdits',
    }
}

local function setup_servers()
    require('lspinstall').setup()

    -- Get all installed servers
    local servers = require('lspinstall').installed_servers()

    for _, server in pairs(servers) do
        local config = require('LSP/'..server..'-lsp')
        config.capabilities = capabilities

        require('lspconfig')[server].setup(config)
    end
end

setup_servers()

require('lspinstall').post_install_hook = function ()
    setup_servers()
    vim.cmd('bufdo e')
end
