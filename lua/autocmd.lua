vim.cmd("com -bar W exe 'w !sudo tee >/dev/null %:p:S' | setl nomod")

local autocmd = {
	{
		{ 'BufEnter' },
		{
			callback = function(args)
				local buftype = vim.api.nvim_get_option_value('buftype', { buf = args.buf })
				if buftype == 'terminal' then
					vim.cmd('startinsert')
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
		vim.api.nvim_create_autocmd(event, opts)
	end
end

function M.setup()
	M.load_autocmd(autocmd)
end

return M
