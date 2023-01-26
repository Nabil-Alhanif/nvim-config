vim.cmd('syntax enable')        -- Enable syntax highlighting

-- Completion
vim.opt.completeopt = "menu,menuone,noselect"

-- Indentation
local indent = 4
vim.opt.shiftwidth    = indent  -- Set indent size
vim.opt.tabstop       = indent  -- Set tab width
vim.opt.autoindent    = true    -- Auto indentation
vim.opt.smartindent   = true    -- IDK, dianya pinter mungkin
vim.opt.smarttab      = true

-- Search
vim.opt.ignorecase    = true
vim.opt.smartcase     = true
vim.opt.hlsearch      = true    -- Highlight search
vim.opt.incsearch     = true    -- Search as you type

-- TUI settings
vim.opt.showcmd       = true    -- Show current command
vim.opt.termguicolors = true    -- True color support
vim.opt.number        = true    -- Show line number
vim.opt.wrap          = true    -- Show long line as multiple line

-- Split panes
vim.opt.splitbelow    = true    -- Open new split panes to the bottom
vim.opt.splitright    = true    -- Open new split panes to the right

-- Mouse
vim.opt.mouse = "inv"

vim.cmd("com -bar W exe 'w !sudo tee >/dev/null %:p:S' | setl nomod")
