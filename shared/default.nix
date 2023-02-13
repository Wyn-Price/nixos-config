
{ config, pkgs, libs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    home-manager
  ];

  nix.settings.experimental-features = "nix-command flakes";

  # Find a way to share this with the home manager?
  system.stateVersion = "22.11";

  imports = [
    ./i3.nix
    ./localisation.nix
    ./users.nix
  ];
}