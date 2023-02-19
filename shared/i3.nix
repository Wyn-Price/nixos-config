{ config, pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = lib.mkForce "none+i3";
    };
    displayManager.lightdm = {
      background = "#080808";
      greeters.mini =  {
        enable = true;
        user = "wp";
        extraConfig = ''
          window-color = "#1B1D1E"
          text-color = "#F8F8F0"
          password-border-width = 0px
          font-weight = normal
        '';
      };
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu i3lock
      ];
    };
  };
}
