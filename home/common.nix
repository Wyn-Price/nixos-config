{ config, pkgs, ... }:
{
  nixpkgs = {
    overlays = import ../overlay { config = config; };
    config.allowUnfree = true;
  };

  home.stateVersion = "22.11";

  imports = with pkgs; [
    ./fish
    ./git
    ./gpg
  ];

  home.packages = with pkgs; [
    unzip
    dig
    screen

    mrpack-install
    forge-installer.forge-1-19-2
  ];
}
