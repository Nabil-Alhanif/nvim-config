{
	description = "Flake exporting a configured neovim package";

	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
	inputs.wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
	inputs.wrappers.inputs.nixpkgs.follows = "nixpkgs";
	inputs.telescope-zotero = {
		url = "github:jmbuhr/telescope-zotero.nvim";
		flake = false;
	};
	inputs.sqlite-lua = {
		url = "github:kkharji/sqlite.lua";
		flake = false;
	};

	outputs =
		{
			self,
			nixpkgs,
			wrappers,
			...
		}@inputs:
		let
			forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.all;
			module = nixpkgs.lib.modules.importApply ./module.nix inputs;
			wrapper = wrappers.lib.evalModule module;
		in
		{
			packages = forAllSystems (
				system:
				let
					pkgs = import nixpkgs {
						inherit system;
						config.allowUnfree = true;
						overlays = [
							(final: prev: {
								nixfmt = prev.nixfmt.overrideAttrs (old: {
									patches = (old.patches or [ ]) ++ [ ./patches/nixfmt-tabs.patch ];
								});
							})
						];
					};
				in
				{
					neovim = wrapper.config.wrap { inherit pkgs; };
					default = self.packages.${system}.neovim;
				}
			);
			overlays = {
				neovim = final: prev: { neovim = self.packages.${prev.system}.neovim; };
				default = self.overlays.neovim;
			};
		};
}
