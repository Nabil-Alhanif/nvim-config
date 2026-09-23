local M = {}

function M.setup()
	local Input = require("nui.input")
	local event = require("nui.utils.autocmd").event

	require("img-clip").setup({
		default = {
			dir_path = "Assets",
			prompt_for_file_name = false,
			use_absolute_path = false,
			relative_template_path = true,
		},
	})

	vim.api.nvim_create_user_command("PasteImageWithPrompt", function()
		local input = Input({
			position = "50%",
			size = {
				width = 50,
			},
			border = {
				style = "rounded",
				text = {
					top = " Image filename ",
				},
			},
		}, {
			prompt = "> ",
			default_value = "image",
		})

		local function close()
			input:unmount()
		end

		input:map("i", "<CR>", function()
			local prompt = vim.fn.prompt_getprompt(input.bufnr)
			local line = vim.api.nvim_buf_get_lines(input.bufnr, 0, 1, false)[1] or ""
			local file_name = line:sub(#prompt + 1)
			close()
			if file_name == "" then
				return
			end

			require("img-clip").paste_image({
				file_name = file_name,
				prompt_for_file_name = false,
			})
		end, { noremap = true })
		input:map("i", "<Esc>", close, { noremap = true })
		input:on(event.BufLeave, close)
		input:mount()
		input:map("n", "q", close, { noremap = true })
		vim.cmd("startinsert")
	end, {})
end

return M
