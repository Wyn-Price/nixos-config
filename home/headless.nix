{ config, pkgs, ... }:
{
  home-manager.users.wp = {
    nixpkgs = {
      overlays = import ../overlay { config = config; };
      config.allowUnfree = true;
    };

    imports = with pkgs; [
      ./common.nix
    ];

    # mc-terminal to manage minecraft servers
    home.pkgs = [
        custom-scripts.mc-terminal
    ]
  };
}
