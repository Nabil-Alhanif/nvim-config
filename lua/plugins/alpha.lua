local M = {}

function M.setup()
	local status_ok, alpha = pcall(require, 'alpha')
	if not status_ok then
		return
	end

	local dashboard = require('alpha.themes.dashboard')

	dashboard.section.buttons.val = {
		dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
		dashboard.button('e', '  New file', ':ene <BAR> startinsert<CR>'),
		dashboard.button('b', '  File browser', ':Telescope file_browser<CR>'),
		dashboard.button('p', '  Open project', ':Telescope project<CR>'),
		dashboard.button('s', '  Open session', ':Telescope persisted<CR>'),
		dashboard.button('c', '  Configuration', ':e $MYVIMRC<CR>'),
		dashboard.button('q', '  Quit Neovim', ':qa<CR>'),
	}

	 local footer = function()
		-- Number of plugins
		local total_plugins = require('lazy').stats().count
		local datetime = os.date '%d-%m-%Y  %H:%M:%S'
		local plugins_text = '\t' .. total_plugins .. ' plugins  ' .. datetime

		-- Quote
		local fortune = require('alpha.fortune')
		local quote = table.concat(fortune(), '\n')

		return plugins_text .. '\n' .. quote
	end
	dashboard.section.footer.val = footer()

	alpha.setup(dashboard.opts)
end

return M
