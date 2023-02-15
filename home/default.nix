{ config, pkgs, ... }:
{
  home-manager.users.wp = {
    nixpkgs = {
      overlays = import ../overlay { config = config; };
      config.allowUnfree = true;
    };
    home = {
      stateVersion = "22.11";
    };

    imports = with pkgs; [
      ./alacritty.nix
      ./firefox.nix
      ./fish.nix
      ./git.nix
      ./gpg.nix
      ./i3.nix
      ./screenshot.nix
      ./vscode.nix
    ];
  };
}