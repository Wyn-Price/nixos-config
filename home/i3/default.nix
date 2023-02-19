{ config, pkgs, lib, ... }:
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
        left = "h";
        right = "l";
        up = "k";
        down = "j";
      in lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "Print" = "exec ${pkgs.custom-scripts.wp-screenshot}/bin/wp-screenshot";

        "${modifier}+${left}" = "focus left";
        "${modifier}+${right}" = "focus right";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${down}" = "focus down";

        "${modifier}+Shift+${left}" = "move left";
        "${modifier}+Shift+${right}" = "move right";
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${down}" = "move down";
      };
    };
    extraConfig = ''
      exec ${pkgs.xautolock}/bin/xautolock -time 2 -locker '${pkgs.lightdm}/bin/dm-tool lock' -detectsleep
    '';
  };

  home.packages = with pkgs; [
    xautolock
  ];

  programs.i3status = {
    enable = true;
    general = {
      interval = 1;
    };
  };

}