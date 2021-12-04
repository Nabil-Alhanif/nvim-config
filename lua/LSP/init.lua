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

local lsp_installer = require('nvim-lsp-installer')

lsp_installer.on_server_ready(function(server)
    local config = require('LSP/'..server.name..'-lsp')
    config.capabilities = capabilities

    server:setup(config)
end)

--[[
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
]]
