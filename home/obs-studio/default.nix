{ config, pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    plugins = [];
  };
}
