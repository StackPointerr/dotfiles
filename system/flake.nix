{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;

	config = {
          allowUnfree = true;
	};
      };
    in
    {
      nixosConfigurations.mcos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };

	modules = [
	  inputs.stylix.nixosModules.stylix
          ./nixos/configuration.nix
	];
      };
    };
}
