{ config, pkgs, lib, ... }:
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+Return" = "exec alacritty";
      };
    };
  };

  programs.i3status-rust = {
    enable = true;
  };
}