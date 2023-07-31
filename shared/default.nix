
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
    ./docker
    ./audio
    ./bluetooth
    ./i3
  ];
}
