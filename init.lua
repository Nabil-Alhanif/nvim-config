vim.cmd([[runtime! archlinux.vim]])

-- Plugins
require('plugins')
require('plugin-config')

-- Settings
require('settings')
require('mappings')
require('modules/command')

-- LSP
require('LSP')

-- Theme
require('theme')
