local M = {

	-- } Plugin Manager |
	{
		'folke/lazy.nvim',
	},


	-- | Utilities |
	{ -- Lua functions
		'nvim-lua/plenary.nvim',
		lazy = true,
	},
	{ -- Which key
		'folke/which-key.nvim',
		config = function()
			require('plugins.which-key').setup()
		end,
	},
	{ -- Toggleterm
		'akinsho/toggleterm.nvim',
		version = '*',
		event = 'VeryLazy',
		config = function()
			require('plugins.toggleterm').setup()
		end,
	},
	{ -- Session manager
		'olimorris/persisted.nvim',
		config = true,
	},
	{ -- Treesitter
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		event = { 'BufReadPost', 'BufNewFile', },
		config = function()
			require('plugins.nvim-treesitter').setup()
		end,
	},


	-- | UI |
	{ -- Colorscheme
		'catppuccin/nvim',
		name = 'catppuccin',
		config = function()
			require('plugins.catppuccin').setup()
		end,
	},
	{ -- Icons
		'nvim-tree/nvim-web-devicons',
		lazy = true,
	},
	{ -- Start screen
		'goolord/alpha-nvim',
		event = 'VimEnter',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			require('plugins.alpha').setup()
		end,
	},
	{ -- Notification
		'rcarriga/nvim-notify',
		config = function()
			require('plugins.nvim-notify').setup()
		end,
	},
	{ -- Indentation guide
		'lukas-reineke/indent-blankline.nvim',
		config = function()
			require('plugins.indent-blankline').setup()
		end,
	},


	-- | File Explorer |
	{ -- Tree
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v2.x',
		cmd = { 'NeoTreeFocusToggle', 'NeoTreeFloatToggle', 'NeoTreeShow'},
		event = 'User DirOpened',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
		},
		config = function()
			require('plugins.neo-tree').setup()
		end,
	},


	-- | Programming |
    { -- Lspconfig
        'neovim/nvim-lspconfig',
    },
    { -- Automatic lsp setup
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
        },
    },
	{ -- Code completion & Snippet engine
		'ms-jpq/coq_nvim',
		build = ':COQdeps',
		dependencies = {
			'ms-jpq/coq.artifacts',
			'ms-jpq/coq.thirdparty',
		},
		config = function()
			require('plugins.nvim-coq').setup()
		end,
	},


	-- | Telescope |
	{ -- Telescope
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		config = function()
			require('plugins.telescope').setup()
		end,
	},
	{ -- File Browser
		'nvim-telescope/telescope-file-browser.nvim', -- File explorer
		cmd = 'Telescope file_browser',
		dependencies = {
			'nvim-telescope/telescope.nvim',
		},
	},
	{ -- Projects
		'nvim-telescope/telescope-project.nvim', -- Project manager
		cmd = 'Telescope project',
		dependencies = {
			'nvim-telescope/telescope.nvim',
		},
	},
}

return M
