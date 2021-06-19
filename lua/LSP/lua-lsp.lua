-- Install path
local sumneko_root_path = vim.fn.stdpath('data')..'/lspinstall/lua'
local sumneko_binary = sumneko_root_path..'/sumneko-lua-language-server'

return {
    cmd = {sumneko_binary, '-E', sumneko_root_path..'/main.lua'};
    settings = {
        Lua = {
            runtime = {
                -- Tell the server which version of Lua you're using
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the 'vim' global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
            -- Do not send telemetry data
            telemetry = {
                enable = false,
            },
        },
    },
}
