{ config, ... }:
[
  (pkgs: super:
    {
      custom-scripts = {
        wp-screenshot = import ./wp-screenshot.nix { pkgs = pkgs; };
      };
    }
  )
  # Pass nur to pkgs
  (self: super: { nur = config.nur; })
]
