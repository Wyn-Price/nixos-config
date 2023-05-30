{ config, ... }:
[
  (pkgs: super:
    {
      custom-scripts = {
        wp-screenshot = import ./wp-screenshot.nix { pkgs = pkgs; };
      };

      mrpack-install = pkgs.callPackage ./packages/mrpack-install {};
    }
  )
  # Pass nur to pkgs
  (self: super: { nur = config.nur; })
]
