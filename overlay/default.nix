{ config, ... }:
[
  (pkgs: super:
    {
      custom-scripts = {
        wp-screenshot = import ./wp-screenshot.nix { pkgs = pkgs; };
        mc-terminal = import ./mc-terminal.nix { pkgs = pkgs; };
      };

      mrpack-install = pkgs.callPackage ./packages/mrpack-install {};
      wp-i3status-conf-rs = pkgs.callPackage ./packages/wp-i3status-conf-rs {};

      forge-installer = {
        forge-1-19-2 = pkgs.callPackage ./packages/minecraftforge-install {
          forge = {
            mc-version = "1.19.2";
            forge-version = "43.2.12";
            installer-sha256 = "sERrFPDcJm5L6OVS80lOMH8Qm5YH6yPM/jVgdoKSAeo=";
          };
        };
        forge-1-20-1 = pkgs.callPackage ./packages/minecraftforge-install {
          forge = {
            mc-version = "1.20.1";
            forge-version = "47.2.32";
            installer-sha256 = "a2IQc8rGmvDjVbrEUxxP+xHtA+2FgPlq9lDd4K+N+0Y=";
          };
        };
        forge-1-16-5 = pkgs.callPackage ./packages/minecraftforge-install {
          forge = {
            mc-version = "1.16.5";
            forge-version = "36.2.26";
            installer-sha256 = "yXVtSlcdUWqsAnTK3w18HTFX++MTkxA3Pgmx4iyEJ/s=";
          };
        };
      };
    }
  )
  # Pass nur to pkgs
  (self: super: { nur = config.nur; })
]
