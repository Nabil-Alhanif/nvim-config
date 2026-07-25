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

	options.nvim-lib.neovimPlugins = lib.mkOption {
		readOnly = true;
		type = lib.types.attrsOf wlib.types.stringable;
		default = config.nvim-lib.pluginsFromPrefix "plugins-" inputs;
	};

	options.nvim-lib.pluginsFromPrefix = lib.mkOption {
		type = lib.types.raw;
		readOnly = true;
		default =
			prefix: inputs:
			lib.pipe inputs [
				builtins.attrNames
				(builtins.filter (s: lib.hasPrefix prefix s))
				(map (
					input:
					let
						name = lib.removePrefix prefix input;
					in
					{
						inherit name;
						value = config.nvim-lib.mkPlugin name inputs.${input};
					}
				))
				builtins.listToAttrs
			];
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
			# Tools
			lazygit
			tree-sitter
		];
		data = let vp = pkgs.vimPlugins; in [
			vp."catppuccin-nvim"
			vp."alpha-nvim"
			vp."nvim-notify"
			vp."indent-blankline-nvim"
			vp."neo-tree-nvim"
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
			# Treesitter + grammars
			(vp."nvim-treesitter".withPlugins (
				plugins: with plugins; [
					nix lua c cpp python javascript typescript tsx
					html css json bash markdown regex yaml toml
					go rust sql typst vue scss php cmake
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
			(config.nvim-lib.mkPlugin "sqlite.lua" inputs.sqlite-lua)
			(config.nvim-lib.mkPlugin "telescope-zotero.nvim" inputs.telescope-zotero)
		];
	};

	# LSP server names passed to neovim via info plugin
	config.info.lspServers = [
		"lua_ls"
		"tinymist"
		"clangd"
		"pyright"
		"nixd"
		"tsserver"
		"vls"
		"html"
		"cssls"
		"jsonls"
		"eslint"
	];

	config.specMods =
		{
			parentSpec ? null,
			parentOpts ? null,
			parentName ? null,
			config,
			...
		}:
		{
			options.runtimePkgs = options.runtimePkgs // {
				description = ''
					A runtimePkgs spec field to put packages on the PATH
					If the spec is disabled, this value will not be included in the resulting neovim derivation
				'';
			};
		};
	config.runtimePkgs = config.specCollect (acc: v: acc ++ (v.runtimePkgs or [ ])) [ ];
}
