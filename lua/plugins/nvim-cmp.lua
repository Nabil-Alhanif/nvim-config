local cmp = require('cmp')
local luasnip = require('luasnip')

local M = {}

function M.setup()
	local opts = {
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { 'i', 's' }),

			['<S-Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { 'i', 's' }),

			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{ name = 'luasnip' },    -- Snippet engine
			{ name = 'nvim_lsp' },   -- LSP as completion source
			{ name = 'buffer' },     -- Buffer as completion source
			{ name = 'nvim_lua' },   -- Lua as completion source
			{ name = 'path' },       -- System path as completion source
			{ name = 'cmdline' },    -- Command line as completion source
			{ name = 'calc' },       -- Math calculation as completion source
		}),
	}

	cmp.setup(opts)
end

return M
