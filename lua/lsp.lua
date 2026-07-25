local nixInfo = require(vim.g.nix_info_plugin_name or "nix-info")
local servers = nixInfo({}, "info", "lspServers")
local capabilities = vim.lsp.protocol.make_client_capabilities()

for _, name in ipairs(servers) do
	local loaded, mod = pcall(require, "lsp." .. name)
	if loaded then
		vim.lsp.config(name, vim.tbl_deep_extend("force", { capabilities = capabilities }, mod))
	end
	pcall(vim.lsp.enable, name)
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local opts = { buffer = bufnr, silent = true }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	end,
})
