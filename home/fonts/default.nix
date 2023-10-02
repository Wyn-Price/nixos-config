{ config, pkgs, libs, ... }:
{
  fonts.fontconfig.enable = true;

  # Add font awesome for i3bar stuff
  home.packages = with pkgs; [
    font-awesome
  ];
}