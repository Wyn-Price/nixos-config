{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    p7zip
    wiimms-iso-tools
  ];
}