{ config, pkgs, ... }:
{
  home-manager.users.wp = {
    imports = with pkgs; [
      ./common.nix

      ./alacritty
      ./brightnessctl
      ./discord
      ./email
      ./firefox
      ./fonts
      ./i3
#      ./idea
      ./java
      ./latex
      ./libreoffice
#      ./logseq
      ./minecraft
      ./node
      ./obs-studio
      ./onepassword
      ./rust
      ./screenshot
      ./spotify
      # ./steam
      ./ssh
#      ./uni
      ./vscode
      ./wii
    ];

    home.packages = with pkgs; [
    ];

    services.gpg-agent.pinentry.package = pkgs.pinentry-curses;

  };
}
