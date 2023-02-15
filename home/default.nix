{ config, pkgs, ... }:
{
  home-manager.users.wp = {
    nixpkgs = {
      overlays = import ../overlay { config = config; };
      config.allowUnfree = true;
    };
    home.stateVersion = "22.11";

    imports = with pkgs; [
      ./alacritty
      ./firefox
      ./fish
      ./git
      ./gpg
      ./i3
      ./screenshot
      ./vscode
    ];
  };
}