{
  description = "Home Manager configuration of krzysztof";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
	inherit system;
	config = {
	  android_sdk.accept_license = true;
	};
      };
    in {
      homeConfigurations."krzysztof" = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ inputs.nix-index-database.hmModules.nix-index inputs.stylix.homeManagerModules.stylix ./home.nix ];
      };
    };
}
