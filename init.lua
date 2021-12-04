vim.cmd([[runtime! archlinux.vim]])

require('settings')

-- Plugins
require('plugins')
require('plugin-config')

-- Settings
require('mappings')
require('modules/command')

-- LSP
require('LSP')

-- Theme
require('theme')
