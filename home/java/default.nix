{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ openjdk8 ];
}
