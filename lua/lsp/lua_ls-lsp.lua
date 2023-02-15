local M = {
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
					vim.api.nvim_get_runtime_file("", true),
                },
            },
            -- Do not send telemetry data
            telemetry = {
                enable = false,
            },
        },
    },
}

return M
