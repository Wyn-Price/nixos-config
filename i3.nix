{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in {
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = lib.mkForce "none+i3";
    };
    windowManager.i3 = {
      enable=true;
      extraPackages = with pkgs; [
        dmenu i3status i3lock
      ];
    };
  };
}
