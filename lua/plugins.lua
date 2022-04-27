local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function(use)

    -- Package Manager
    use 'wbthomason/packer.nvim'       -- Package manager written in lua

    -- TreeSitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    -- Explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
    }
    use 'kyazdani42/nvim-web-devicons' -- Icons for nvim-tree

    use 'kevinhwang91/rnvimr'          -- Neovim integration with ranger

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
        }
    }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'jakewvincent/texmagic.nvim'   -- Latex stuff

    -- Snippet
    use 'hrsh7th/vim-vsnip'

    -- Auto Complete
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',    -- Buffer as completion source
            'hrsh7th/cmp-calc',      -- Math calculation as completion source
            'hrsh7th/cmp-cmdline',   -- Command line as completion source
            'hrsh7th/cmp-nvim-lsp',  -- LSP as completion source
            'hrsh7th/cmp-nvim-lua',  -- Lua as completion source
            'hrsh7th/cmp-path',      -- System path as completion source
            'hrsh7th/cmp-vsnip',     -- Vsnip as completion source

            -- This two isn't that important for programming,
            -- but as I'll be using neovim as my default text editor,
            -- and thus will be using it a lot for school work,
            -- I decide to include it as well.
            'f3fora/cmp-spell',      -- Spelling
            'octaltree/cmp-look',    -- English word recommendation
        }
    }
    use 'b3nj5m1n/kommentary'

    -- Lua functions
    use 'nvim-lua/plenary.nvim'
    use 'famiu/nvim-reload'

    -- Status Line
    use {
        'NTBBloodbath/galaxyline.nvim',
        branch = 'main',
        -- some optional icons
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- Theme
    use 'christianchiarulli/nvcode-color-schemes.vim'
    use 'folke/tokyonight.nvim'
    use 'lukas-reineke/indent-blankline.nvim'

    if packer_bootstrap then
        require('packer').sync()
    end

end)
