
{ config, pkgs, libs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    arandr
    dunst
    libnotify
    pulsemixer
  ];

  virtualisation.virtualbox.host.enable = true;

  imports = [
    ./common.nix
    ./audio
    ./bluetooth
    ./i3
  ];
}
