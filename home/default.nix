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
      ./fonts
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
      # ./steam
      ./ssh
      ./uni
      ./vscode
    ];

    home.packages = with pkgs; [
    ];

    services.gpg-agent.pinentryPackage = pkgs.pinentry;
  };
}
