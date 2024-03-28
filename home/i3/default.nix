{ config, pkgs, lib, ... }:
let
  blocksConfig = import ./i3blocks { config = config; pkgs = pkgs; };
in {
  # start x
  programs.fish.loginShellInit = "exec startx";

  # .xinitrc
  home.file.".xinitrc".source = ./.xinitrc;

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
        "${modifier}+${alt}+l" = "exec ${pkgs.i3lock}/bin/i3lock -c 450041 -e";
        "${modifier}+${alt}+0" = "exec ${pkgs.xdotool}/bin/xdotool mousemove 0 0";

        "${modifier}+${left}" = "focus left";
        "${modifier}+${right}" = "focus right";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${down}" = "focus down";

        "${modifier}+Shift+${left}" = "move left";
        "${modifier}+Shift+${right}" = "move right";
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${down}" = "move down";

        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play";
        "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        "XF86AudioRaiseVolume" = "exec ${pkgs.pulsemixer}/bin/pulsemixer --change-volume +5";
        "XF86AudioLowerVolume" = "exec ${pkgs.pulsemixer}/bin/pulsemixer --change-volume -5";
        "XF86AudioMute" = "exec ${pkgs.pulsemixer}/bin/pulsemixer --toggle-mute";
      };
      bars = [
        {
          fonts.names = [ "DejaVu Sans Mono" "Font Awesome 6 Free" ];
          position = "bottom";
          statusCommand = "${pkgs.i3blocks}/bin/i3blocks -c ${blocksConfig}";
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
    i3blocks
    xautolock
    playerctl
  ];

}