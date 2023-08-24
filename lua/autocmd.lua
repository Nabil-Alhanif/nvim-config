vim.cmd("com -bar W exe 'w !sudo tee >/dev/null %:p:S' | setl nomod")

local autocmd = {
	{
		{ 'BufEnter' },
		{ -- Start terminal on insert mode
			group = '_terminal',
			callback = function(args)
				local buftype = vim.api.nvim_get_option_value('buftype', { buf = args.buf })
				if buftype == 'terminal' then
					vim.cmd('startinsert')
				end
			end,
		}
	},
	{
		{ 'BufEnter' },
		{
			group = '_buffer',
			callback = function(args)
				if vim.bo[args.buf].filetype == 'vue' or vim.bo[args.buf].filetype == 'html' then
					vim.cmd('setlocal tabstop=2 shiftwidth=2')
				end
			end,
		}
	},
}

local M = {}

function M.load_autocmd(definitions)
	for _, entry in ipairs(definitions) do
		local event = entry[1]
		local opts = entry[2]
		if type(opts.group) == 'string' and opts.group ~= '' then
			local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group})
			if not exists then
				vim.api.nvim_create_augroup(opts.group, {})
			end
		end
		vim.api.nvim_create_autocmd(event, opts)
	end
end

function M.setup()
	M.load_autocmd(autocmd)
end

return M
