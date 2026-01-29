local M = {
    -- | Plugin Manager |
    {
        "folke/lazy.nvim",
    },

    -- | Utilities |
    { -- Lua functions
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    { -- Which key
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("plugins.which-key").setup()
        end,
    },
    { -- Toggleterm
        "akinsho/toggleterm.nvim",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("plugins.toggleterm").setup()
        end,
    },
    { -- Session manager
        "olimorris/persisted.nvim",
        lazy = false, -- Sessions usually need to load immediately
        opts = {},
    },
    { -- Treesitter
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        -- Playground is removed; use built-in :InspectTree instead
        config = function()
            require("plugins.nvim-treesitter").setup()
        end,
    },

    -- | UI |
    { -- Colorscheme
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000, -- Ensure it loads first
        config = function()
            require("plugins.catppuccin").setup()
        end,
    },
    { -- Icons
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },
    { -- Start screen
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("plugins.alpha").setup()
        end,
    },
    { -- Notification
        "rcarriga/nvim-notify",
        config = function()
            require("plugins.nvim-notify").setup()
        end,
    },
    { -- Indentation guide
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl", -- Standard for v3
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("plugins.indent-blankline").setup()
        end,
    },

    -- | File Explorer |
    { -- Tree
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x", -- Updated from v2.x
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("plugins.neo-tree").setup()
        end,
    },

    -- | Programming |
    { -- Modern LSP (0.11+)
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        -- We no longer call .setup() in a loop; 
        -- logic should be moved to your lsp init or here
        config = function()
             -- Reference your new lsp.lua file's init function here
             require("lsp").init()
        end,
    },
    { -- Formatter
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        config = function()
            require("plugins.conform").setup()
        end,
    },
	{ -- Code completion & Snippet engine
        "ms-jpq/coq_nvim",
        build = ":COQdeps",
        dependencies = {
            "ms-jpq/coq.artifacts",
            "ms-jpq/coq.thirdparty",
        },
        config = function()
            require("plugins.nvim-coq").setup()
        end,
    },
    { -- Indentation engine
        "nmac427/guess-indent.nvim",
        config = function()
            require("guess-indent").setup({})
        end,
    },
    { -- Typst preview
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        version = "1.*",
        build = function() require("typst-preview").update() end,
    },

    -- | Telescope |
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-project.nvim",
        },
        config = function()
            require("plugins.telescope").setup()
        end,
    },
}

return M
