local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function(use)

    -- Package Manager
    use 'wbthomason/packer.nvim'       -- Package manager written in lua

    -- Explorer
    use 'kyazdani42/nvim-tree.lua'     -- Lua based file explorer
    use 'kyazdani42/nvim-web-devicons' -- Icons for nvim-tree

    use 'kevinhwang91/rnvimr'          -- Neovim integration with ranger

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'

    -- Auto Complete
    use 'hrsh7th/nvim-compe'

    -- Lua functions
    use 'nvim-lua/plenary.nvim'
    use 'famiu/nvim-reload'

    -- Status Line
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        -- some optional icons
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    -- Theme
    use 'christianchiarulli/nvcode-color-schemes.vim'

end)
