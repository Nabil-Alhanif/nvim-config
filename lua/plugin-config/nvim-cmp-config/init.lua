vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

local cmp = require('cmp')

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<C-CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = 'buffer' },     -- Buffer as completion source
        { name = 'nvim_lsp' },   -- LSP as completion source
        { name = 'nvim_lua' },   -- Lua as completion source
        { name = 'path' },       -- System path as completion source
        { name = 'vsnip' },      -- Vsnip as completion source
        { name = 'cmdline' },    -- Command line as completion source
        { name = 'calc' },       -- Math calculation as completion source
        { name = 'look',         -- English word recommendation
            keyword_length = 2,
            option = {
                convert_case = true,
                loud = true
            },
        },
        { name = 'spell' },      -- Spelling
    }),
    completion = {
        completeopt = 'menu,menuone,noinsert',
        --autocomplete = false,
    }
})
