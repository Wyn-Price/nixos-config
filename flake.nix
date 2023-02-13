{
  description = "Wyn Price NixOS configuration";

  inputs = {
    nur = {
      url = github:nix-community/NUR;
    };
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nur, home-manager }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.furnace = nixpkgs.lib.nixosSystem {
      modules = [
        nur.nixosModules.nur
        ./machines/furnace
        ./shared
      ];
    };

    homeConfigurations.wp = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      extraSpecialArgs = { inherit inputs; };
      modules = [
        nur.nixosModules.nur
        ./home
      ];
    };
  };
}