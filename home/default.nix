{ config, pkgs, ... }:
{
  home = {
    stateVersion = "22.11";
    username = "wp";
    homeDirectory = "/home/wp";
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
}