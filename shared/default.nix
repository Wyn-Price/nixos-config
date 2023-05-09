
{ config, pkgs, libs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    arandr
    dunst
    home-manager
    htop
    libnotify
    pulsemixer
    vim
  ];

  nix.settings.experimental-features = "nix-command flakes";

  # Find a way to share this with the home manager?
  system.stateVersion = "22.11";

  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./i3.nix
    ./localisation.nix
    ./users.nix
  ];
}
