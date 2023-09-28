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
      ./libreoffice
      ./logseq
      ./minecraft
      ./node
      ./onepassword
      ./rust
      ./screenshot
      ./ssh
      ./vscode
    ];

    home.packages = with pkgs; [
      spotify
      discord
    ];
  };
}
