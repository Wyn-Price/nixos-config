{
  description = "NixOS configuration";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  inputs.nur.url = github:nix-community/NUR;

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nur, home-manager }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  rec {
    nixosConfigurations.furnace = nixpkgs.lib.nixosSystem {
      modules = [
        nur.nixosModules.nur
        ./machines/furnace
        ./shared
      ];
    };

    homeConfigurations.wp = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };
      modules = [ ./home ];
    };
  };
}