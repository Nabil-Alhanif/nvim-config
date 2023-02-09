-- ----------------------------
-- | Language Server Protocol |
-- ----------------------------

local M = {}

function M:init()
	require('mason').setup()
	require('mason-lspconfig').setup()

	local capabilities = vim.lsp.protocol.make_client_capabilities()

	local lsp_servers = require('mason-lspconfig').get_installed_servers()

	for _, server in pairs(lsp_servers) do
		local config = require('lsp/'..server..'-lsp')
		config.capabilities = capabilities

		require('lspconfig')[server].setup(config)
	end
end

return M
