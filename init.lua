-- Plugins
local plugins = require('plugins')
local plugin_loader = require('plugin-loader')
plugin_loader:init()
plugin_loader.load(plugins)

-- COQ
vim.cmd('COQnow -s')

-- Setings
require('settings').setup()

-- LSP
require('lsp'):init()

-- Mappings
require('mappings').load()

-- Autocmd
require('autocmd').setup()
