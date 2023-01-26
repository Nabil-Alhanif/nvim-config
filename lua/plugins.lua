local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{
		'nvim-lua/plenary.nvim',
	},
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		config = function()
			require('plugins.catppuccin').setup()
		end,
	},
	{
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v2.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
		},
		config = function()
			require('plugins.neo-tree').setup()
		end,
	},
	{
		'folke/which-key.nvim',
		config = function()
			require('plugins.which-key').setup()
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require('plugins.nvim-treesitter').setup()
		end,
	},
    {
        'neovim/nvim-lspconfig',
    },
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
        },
    },
})
