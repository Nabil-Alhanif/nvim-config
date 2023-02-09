local M = {
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
}

return M
