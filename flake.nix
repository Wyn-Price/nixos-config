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
          nur.nixosModules.nur
          home-manager.nixosModules.home-manager

          ./machines/furnace
          ./shared
          ./home
        ];
      };

      stoneslab = nixpkgs.lib.nixosSystem {
        modules = [
          nur.nixosModules.nur
          home-manager.nixosModules.home-manager

          ./machines/stoneslab
          ./shared
          ./home/nogui.nix
        ];
      };
  };
}