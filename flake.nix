
{
  description = "Wyn Price NixOS configuration";

  inputs = {
    nur = {
      url = "github:nix-community/NUR";
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

    mkHost = modules: nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./modules
        nur.modules.nixos.default
        home-manager.nixosModules.home-manager
      ] ++ modules;
    };

  in {
    nixosConfigurations = {
      furnace = mkHost [
        ./machines/furnace
        ./shared
        ./home
      ];

      bookshelf = mkHost [
        ./machines/bookshelf
        ./shared
        ./home

        {
          # Needed for Vivado
          programs.nix-ld.enable = true;
        }
      ];

      stoneslab = mkHost [
        ./machines/stoneslab
        ./shared/headless.nix
        ./home/headless.nix

        # Not necessarily needed anymore
        "${nixpkgs}/nixos/modules/profiles/headless.nix"
      ];
    };
  };
}
