local M = {}

function M:init()
	local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'https://github.com/folke/lazy.nvim.git',
			'--branch=stable',
			lazypath,
		})
	end

	vim.opt.rtp:prepend(lazypath)
end

function M.load(plugins)
	local lazy_ok, lazy = pcall(require, 'lazy')
	if not lazy_ok then
		return
	end

	local status = pcall(function()
		local opts = {}
		lazy.setup(plugins, opts)
	end)

	if not status then
		return
	end
end

return M
