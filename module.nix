inputs:
{
	config,
	wlib,
	lib,
	pkgs,
	options,
	...
}:
{
	imports = [ wlib.wrapperModules.neovim ];

	config.specMods = { config, ... }: {
		options.runtimePkgs = options.runtimePkgs // {
			description =
			/*nixfmt:disable*/
			''
				Packages to prepend to PATH so Neovim can find LSP servers,
				formatters, and other tools at runtime.
			'';
			/*nixfmt:enable*/
		};
	};

	config.settings.config_directory = ./.;

	config.specs.general = {
		runtimePkgs = with pkgs; [
			# LSP servers
			lua-language-server
			tinymist
			clang-tools
			pyright
			nixd
			typescript-language-server
			vscode-langservers-extracted
			vue-language-server
			eslint_d
			# Formatters
			stylua
			python3Packages.black
			cmake-format
			prettierd
			typstyle
			nixfmt
			# Tools
			wl-clipboard
			lazygit
			tree-sitter
			# Required by zotcite
			sqlite
		];
		data =
			let
				vp = pkgs.vimPlugins;
			in
			[
				vp."catppuccin-nvim"
				vp."alpha-nvim"
				vp."nvim-notify"
				vp."indent-blankline-nvim"
				vp."neo-tree-nvim"
				vp."gitsigns-nvim"
				vp."nui-nvim"
				vp."plenary-nvim"
				vp."nvim-web-devicons"
				vp."which-key-nvim"
				vp."toggleterm-nvim"
				vp."persisted-nvim"
				vp."guess-indent-nvim"
				vp."nvim-lspconfig"
				vp."conform-nvim"
				vp."fidget-nvim"
				vp."nvim-treesitter-textobjects"
				vp."telescope-nvim"
				vp."telescope-file-browser-nvim"
				vp."telescope-project-nvim"
				vp."typst-preview-nvim"
				vp."img-clip-nvim"
				vp."nvim-origami"
				# Treesitter + grammars
				(vp."nvim-treesitter".withPlugins (
					plugins: with plugins; [
						nix
						lua
						c
						cpp
						python
						javascript
						typescript
						tsx
						html
						css
						json
						bash
						markdown
						regex
						yaml
						toml
						go
						rust
						sql
						typst
						vue
						scss
						php
						cmake
					]
				))
				# Completion
				vp."coq_nvim"
				vp."coq-artifacts"
				vp."coq-thirdparty"
			];
	};

	# External plugins not in nixpkgs
	config.specs.external = {
		data = [
			(config.nvim-lib.mkPlugin "zotcite" inputs.zotcite)
		];
	};

	# LSP server names passed to neovim via info plugin
	config.info.lspServers = [
		"lua_ls"
		"tinymist"
		"clangd"
		"pyright"
		"nixd"
		"ts_ls"
		"vls"
		"html"
		"cssls"
		"jsonls"
		"eslint"
	];

	config.runtimePkgs = config.specCollect (acc: v: acc ++ (v.runtimePkgs or [ ])) [ ];
}
