local M = {
	{ -- Lua functions
		'nvim-lua/plenary.nvim',
	},
	{ -- Colorscheme
		'catppuccin/nvim',
		name = 'catppuccin',
		config = function()
			require('plugins.catppuccin').setup()
		end,
	},
	{ -- Tree
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
	{ -- Which key
		'folke/which-key.nvim',
		config = function()
			require('plugins.which-key').setup()
		end,
	},
	{ -- Treesitter
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require('plugins.nvim-treesitter').setup()
		end,
	},
    { -- Lspconfig
        'neovim/nvim-lspconfig',
    },
    { -- Automatic lsp setup
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
        },
    },
	{ -- Code comletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			'L3MON4D3/LuaSnip', -- For snippet engine
			'hrsh7th/cmp-nvim-lsp',
		},
		config = function()
			require('plugins.nvim-cmp').setup()
		end,
	},
	{ -- Snippet engine
		'L3MON4D3/LuaSnip',
		build = 'make install_jsregexp',
		dependencies = {
			'saadparwaiz1/cmp_luasnip', -- Integration with nvim-cmp
		},
	},
}

return M
