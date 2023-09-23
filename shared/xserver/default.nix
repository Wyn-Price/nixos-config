{ config, pkgs, lib, ... }:

{
  services.xserver = {
    displayManager.startx.enable = true;
    enable = true;
    autorun = false;
  };
}
