{ config, pkgs, ... }:
{
  home-manager.users.wp = {
    imports = [
      ./common.nix
    ];

    # mc-terminal to manage minecraft servers
    home.packages = with pkgs; [
        custom-scripts.mc-terminal
    ];
  };
}
