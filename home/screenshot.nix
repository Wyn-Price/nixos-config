{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    scrot
    xclip
    custom-scripts.wp-screenshot
  ];
}