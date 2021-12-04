vim.cmd('syntax enable')        -- Enable syntax highlighting

-- Completion
vim.opt.completeopt = "menu,menuone,noselect"

-- Indentation
local indent = 4
vim.opt.expandtab     = true    -- Insert space rather than tab
vim.opt.shiftwidth    = indent  -- Set indent size
vim.opt.tabstop       = indent  -- Set tab width
vim.opt.autoindent    = true    -- Auto indentation
vim.opt.smartindent   = true    -- IDK, dianya pinter mungkin
vim.opt.smarttab      = true

-- Search
vim.opt.hlsearch      = true    -- Highlight search
vim.opt.incsearch     = true    -- Search as you type

-- TUI settings
vim.opt.showcmd       = true    -- Show current command
vim.opt.termguicolors = true    -- True color support
vim.opt.number        = true    -- Show line number
vim.opt.wrap          = true    -- Show long line as multiple line

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

-- Split panes
vim.opt.splitbelow    = true    -- Open new split panes to the bottom
vim.opt.splitright    = true    -- Open new split panes to the right

-- Folding
vim.opt_local.foldmethod = "indent" -- Set folding on indent
vim.opt.foldenable       = false    -- No fold enable
vim.opt.foldlevel        = 99       -- IDK

