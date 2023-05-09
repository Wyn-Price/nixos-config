{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    openjdk8
    jetbrains.idea-ultimate
  ];
}
