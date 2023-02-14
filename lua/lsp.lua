-- ----------------------------
-- | Language Server Protocol |
-- ----------------------------

local M = {}

M.title = 'LSP Initialisation'

function M:init()
	require('mason').setup()
	require('mason-lspconfig').setup()

	local lspconfig = require('lspconfig')

	local capabilities = vim.lsp.protocol.make_client_capabilities()

	local lsp_servers = require('mason-lspconfig').get_installed_servers()

	for _, server in pairs(lsp_servers) do
		local config = self:get_config('lsp.'..server..'-lsp')
		config.capabilities = capabilities

		lspconfig[server].setup(config)
	end
end

function M:get_config(module)
	local config = nil
	local config_path = vim.fn.stdpath('config')..'/lua/'..module:gsub('%.', '/')..'.lua'

	if vim.fn.filereadable(config_path) == 1 then
		config = require(module)
	else
		vim.notify('Configuration for '..module..' doesn\'t exist!\n\nCreating a new config file...', 'warn', {
			title = self.title,
			on_open = function()
				local file, error = assert(io.open(config_path, 'w'))
				if not file then
					vim.notify(error, 'error', { title = self.title })
				else
					file:write('local M = {}\n\nreturn M')
					file:close()
					vim.notify('Config file created in'..config_path, 'info', { title = self.title })
				end
			end
		})

		config = {}
	end

	return config
end

return M
