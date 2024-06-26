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
    nixosConfigurations = {
      furnace = nixpkgs.lib.nixosSystem {
        modules = [
          ./modules
          nur.nixosModules.nur
          home-manager.nixosModules.home-manager

          ./machines/furnace
          ./shared
          ./home
        ];
      };

      bookshelf = nixpkgs.lib.nixosSystem {
        modules = [
          ./modules
          nur.nixosModules.nur
          home-manager.nixosModules.home-manager

          ./machines/bookshelf
          ./shared
          ./home
          {
            # Needed for vivado
            programs.nix-ld.enable = true;
          }
        ];
      };

      stoneslab = nixpkgs.lib.nixosSystem {
        modules = [
          ./modules
          nur.nixosModules.nur
          home-manager.nixosModules.home-manager

          ./machines/stoneslab
          ./shared/headless.nix
          ./home/headless.nix

          # Not neccessarily needed anymore
          "${nixpkgs}/nixos/modules/profiles/headless.nix"
        ];
      };
    };
  };
}
