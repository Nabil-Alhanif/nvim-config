local function find_project_config()
	local dir = vim.fn.getcwd()
	while dir ~= "/" do
		local path = dir .. "/alejandra.toml"
		if vim.fn.filereadable(path) == 1 then
			return path
		end
		dir = vim.fn.fnamemodify(dir, ":h") -- :h strips last path component, like dirname
	end
	return nil
end

local config_path = find_project_config() or vim.fn.stdpath("config") .. "/formatter/alejandra.toml"

local M = {
	settings = {
		nixd = {
			formatting = {
				command = { "alejandra", "--experimental-config", config_path },
			},
		},
	},
}

return M
