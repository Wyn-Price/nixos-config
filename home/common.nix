{ config, pkgs, ... }:
{
  nixpkgs = {
    overlays = import ../overlay { config = config; };
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-27.3.11" # For logseq
      ];
    };
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
  ];
}
