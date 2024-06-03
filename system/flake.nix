{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations.mcos = nixpkgs.lib.nixosSystem {
      modules = [
        inputs.stylix.nixosModules.stylix
        ./nixos/hardware-configuration.nix
        ./nixos/configuration.nix
      ];
    };
  };
}
