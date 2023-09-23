
{ config, pkgs, libs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    arandr
    dunst
    libnotify
    pulsemixer
  ];

  imports = [
    ./common.nix
    ./keyremap.nix
    ./docker
    ./audio
    ./bluetooth
    ./xserver
  ];
}
