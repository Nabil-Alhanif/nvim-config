do
  local ok = pcall(require, vim.g.nix_info_plugin_name or "nix-info")
  if not ok then
    package.loaded[vim.g.nix_info_plugin_name or "nix-info"] = setmetatable({}, {
      __call = function(_, default)
        return default
      end,
    })
  end
end

require("plugins.catppuccin").setup()
require("plugins.alpha").setup()
require("plugins.nvim-notify").setup()
require("plugins.indent-blankline").setup()
require("plugins.neo-tree").setup()
require("plugins.which-key").setup()
require("plugins.toggleterm").setup()
require("plugins.nvim-coq").setup()
require("plugins.conform").setup()
require("plugins.nvim-treesitter").setup()
require("plugins.telescope").setup()
require("plugins.typst-preview").setup()

require("lsp")
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

require("settings").setup()
require("mappings").load()
require("autocmd").setup()
