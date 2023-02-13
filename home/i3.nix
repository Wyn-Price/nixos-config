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
        "Print" = "exec wp-screenshot";
      };
    };
  };

  programs.i3status-rust = {
    enable = true;
  };
}