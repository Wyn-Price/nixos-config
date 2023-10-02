{ config, pkgs, libs, ... }:
{
  nixpkgs = {
    overlays = import ../overlay { config = config; };
    config.allowUnfree = true;
  };
  environment.systemPackages = with pkgs; [
    home-manager
    htop
    vim

    networkmanagerapplet
  ];

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  nix.settings.experimental-features = "nix-command flakes";

  programs.fish.enable = true;

  # Find a way to share this with the home manager?
  system.stateVersion = "22.11";

  imports = [
    ./localisation
    ./users
  ];
}