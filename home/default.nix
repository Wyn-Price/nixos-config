{ config, pkgs, ... }:
{
  nixpkgs.overlays = [
    (import ./scripts)
  ];
  home = {
    stateVersion = "22.11";
    username = "wp";
    homeDirectory = "/home/wp";
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
}