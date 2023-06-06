{ config, pkgs, libs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    home-manager
    htop
    vim
  ];

  nix.settings.experimental-features = "nix-command flakes";

  programs.fish.enable = true;

  # Find a way to share this with the home manager?
  system.stateVersion = "22.11";

  imports = [
    ./localisation
    ./users
  ];
}