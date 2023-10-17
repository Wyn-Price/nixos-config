{ config, pkgs, ... }:
{
  home-manager.users.wp = {
    nixpkgs = {
      overlays = import ../overlay { config = config; };
      config.allowUnfree = true;
    };

    imports = with pkgs; [
      ./common.nix

      ./alacritty
      ./brightnessctl
      ./discord
      ./email
      ./firefox
      ./i3
      ./idea
      ./java
      ./latex
      ./libreoffice
      ./logseq
      ./minecraft
      ./node
      ./obs-studio
      ./onepassword
      ./rust
      ./screenshot
      ./spotify
      ./ssh
      ./vscode
    ];

    home.packages = with pkgs; [
      #
    ];
  };
}
