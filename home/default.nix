{ config, pkgs, libs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.wp = {
    # Match the configuration.nix state version
    # Need to find a way to properly abstract this to
    # the same file as configuration.nix
    home.stateVersion = "22.11";
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };
    
    imports = with pkgs; [
      ./i3.nix
      ./alacritty.nix
      ./firefox.nix
      ./fish.nix
      ./git.nix
      ./gpg.nix
      ./vscode.nix
    ];
  };
}