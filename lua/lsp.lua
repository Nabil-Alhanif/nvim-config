-- ----------------------------
-- | Language Server Protocol |
-- ----------------------------

local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
	vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', bufopts)
	vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', bufopts)
	vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', bufopts)
	vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', bufopts)
	vim.keymap.set('n', '<space>ld', '<cmd>lua vim.lsp.buf.signature_help()<CR>', bufopts)
end

local custom_server = { 'ccls' }

local M = {}

M.title = 'LSP Initialisation'

function M:init()
	require('mason').setup()
	require('mason-lspconfig').setup()

	local lspconfig = require('lspconfig')
	local coq = require('coq')

	local capabilities = vim.lsp.protocol.make_client_capabilities()

	local lsp_servers = require('mason-lspconfig').get_installed_servers()
	for i = 1, #custom_server do
		lsp_servers[#lsp_servers + i] = custom_server[i]
	end

	for _, server in pairs(lsp_servers) do
		local config = self:get_config(server)
		config.on_attach = on_attach
		config.capabilities = capabilities

		lspconfig[server].setup(coq.lsp_ensure_capabilities(config))
	end
end

function M:get_config(server)
	local server_conf = 'lsp.'..server..'-lsp'

	local config = nil
	local config_path = vim.fn.stdpath('config')..'/lua/'..server_conf:gsub('%.', '/')..'.lua'

	if vim.fn.filereadable(config_path) == 1 then
		config = require(server_conf)
	else
		vim.notify('Configuration for '..server..' doesn\'t exist!\n\nCreating a new config file...', 'warn', {
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
