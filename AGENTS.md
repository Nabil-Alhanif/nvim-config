# AGENTS.md — Neovim Config

## Build

```sh
nix build .#neovim       # produces self-contained neovim binary in result/
```

Overlay also exported for system/home-manager consumption. `result` is gitignored.

## Architecture

| Layer | Location | Notes |
|---|---|---|
| Entrypoint | `init.lua` | Requires 5 modules directly. No lazy loading. |
| Plugin setup | `lua/plugins/init.lua` | Calls each plugin's `setup()` in order. |
| LSP server list | `module.nix:121` `config.info.lspServers` | Defined in Nix, read at runtime by `lua/lsp.lua` via Nix info plugin. |
| Per-server config | `lua/lsp/<name>.lua` | File name must match entry in `info.lspServers`. |
| Plugins, LSPs, formatters | `module.nix` `runtimePkgs` + `data` | All provisioned through Nix, **not** Mason or lazy.nvim. |
| LD_LIBRARY_PATH | `module.nix:24` | sqlite lib added for telescope-zotero. |

## Config quirks (non-default)

- **Tabs, not spaces**: `expandtab = false`, shiftwidth 4.
- **Leader**: `<Space>`.
- **`:W`**: writes file with `sudo tee` (`autocmd.lua:1`).
- **Completion**: coq\_nvim (not nvim-cmp). Manual trigger: `<C-space>`.
- **Formatter on save**: conform.nvim, 500ms timeout, LSP as fallback.
- **Telescope ignore patterns**: `.git/`, `node_modules`, `__pycache__`, `target/`, `result`.
- **Alpha dashboard**: wrapped in `pcall` — no-ops gracefully if plugin absent.
- **Tinymist**: formatter = `typstyle`, export PDF on type, no semantic tokens.

## Keymaps

| Keys | Action |
|---|---|
| `<leader>e` | Neo-tree toggle |
| `<leader>ff/fg/fb/fh/fe/fp/fs/fz` | Telescope: files, grep, buffers, help, file\_browser, project, persisted, zotero |
| `<leader>f./fc/fk` | Telescope: oldfiles, commands, keymaps |
| `<leader>gg` | lazygit (float) |
| `<leader>hs/hr/hS/hR/hu/hp/hb/hd/hB/ht` | Gitsigns: stage/reset hunks, blame, diff, toggle |
| `]h` / `[h` | Gitsigns next/prev hunk |
| `<leader>n` / `<C-t>` | Horizontal / floating terminal |
| `gd` / `gr` / `K` / `<leader>rn` | LSP: definition, references, hover, rename |
| `<C-n>` / `<C-p>` | Next / prev diagnostic |
| `<C-h/j/k/l>` | Window navigation |
| `<Esc>` | Clear search highlight |

## Nix module structure

- `flake.nix` inputs: `nix-wrapper-modules` + flake-less `telescope-zotero` + `sqlite.lua`.
- Treesitter grammars: nix, lua, c, cpp, python, js, ts, tsx, html, css, json, bash, markdown, regex, yaml, toml, go, rust, sql, typst, vue, scss, php, cmake.
- Formatters: stylua, black, cmake-format, prettierd, typstyle.
- LSP servers: lua\_ls, tinymist, clangd, pyright, nil, tsserver, vls, html, cssls, jsonls, eslint.

## Rules

- **Do not** install plugins via lazy.nvim/packer — everything comes from Nix.
- **Do not** use Mason — LSP/formatter binaries are in `runtimePkgs`.
- **Do not** flip `expandtab` to true unless intentional — tabs are the repo default.
- **Do not** update `flake.lock` unless explicitly asked.
