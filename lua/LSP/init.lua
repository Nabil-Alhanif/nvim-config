-- ----------------------------
-- | Language Server Protocol |
-- ----------------------------

require('mason').setup()
require('mason-lspconfig').setup()


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

--local lsp_installer_servers = require('nvim-lsp-installer.servers')
local lsp_servers = require('mason-lspconfig').get_installed_servers()

for _, server in pairs(lsp_servers) do
    local config = require('LSP/'..server..'-lsp')
    config.capabilities = capabilities

    require('lspconfig')[server].setup(config)
    --server:setup(config)
end

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
