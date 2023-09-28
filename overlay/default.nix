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
        forge-1-19-2 = pkgs.callPackage ./packages/minecraftforge-install/1.19.2.nix {};
      };
    }
  )
  # Pass nur to pkgs
  (self: super: { nur = config.nur; })
]
