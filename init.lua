vim.cmd([[runtime! archlinux.vim]])

-- Settings
require('settings')
require('mappings')
require('modules/command')

-- Theme
require('theme')

-- LSP
require('LSP')

-- Plugins
require('plugins')
require('plugin-config')
