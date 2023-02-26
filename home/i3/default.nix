{ config, pkgs, lib, ... }:
{
  xsession.windowManager.i3 = {
    enable = true;
    config = let
      modifier = "Mod4";
      alt = "Mod1";
      left = "h";
      right = "l";
      up = "k";
      down = "j";
    in {
      modifier = modifier;
      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "Print" = "exec ${pkgs.custom-scripts.wp-screenshot}/bin/wp-screenshot";
        "${modifier}+${alt}+l" = "exec ${pkgs.lightdm}/bin/dm-tool lock";

        "${modifier}+${left}" = "focus left";
        "${modifier}+${right}" = "focus right";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${down}" = "focus down";

        "${modifier}+Shift+${left}" = "move left";
        "${modifier}+Shift+${right}" = "move right";
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${down}" = "move down";
      };
      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs";
        }
      ];
    };
    extraConfig = ''
      exec ${pkgs.xautolock}/bin/xautolock \
           -time 2 \
           -corners -000 \
           -notify 30 \
           -notifier "${pkgs.libnotify}/bin/notify-send -u critical -t 30000 -- 'LOCKING screen in 30 seconds'" \
           -locker '${pkgs.i3lock}/bin/i3lock -c 450041 -e' \
           -detectsleep \
           &
    '';
  };

  home.packages = with pkgs; [
    i3lock
    xautolock
  ];

  programs.i3status-rust = {
    enable = true;
  };

}