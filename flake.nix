{
	description = "Flake exporting a configured neovim package";

	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
	inputs.wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
	inputs.wrappers.inputs.nixpkgs.follows = "nixpkgs";
	inputs.zotcite = {
		url = "github:jalvesaq/zotcite";
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
								# The nixpkgs hash for 6.0.2's pnpm store is stale.
								typescript-language-server =
									if prev.typescript-language-server.version == "6.0.2" then
										prev.typescript-language-server.overrideAttrs (
										finalAttrs: _: {
											pnpmDeps = prev.fetchPnpmDeps {
												inherit (finalAttrs) pname version src;
												pnpm = prev.pnpm_12;
												fetcherVersion = 4;
												hash = "sha256-xR/EF60lVBsITKgH7wCM2wHM46PFQevD51KfCENSUH4=";
											};
										}
										)
									else
										prev.typescript-language-server;
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
