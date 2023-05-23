{ config, pkgs, ... }:
{
  home-manager.users.wp = {
    nixpkgs = {
      overlays = import ../overlay { config = config; };
      config.allowUnfree = true;
    };

    home.stateVersion = "22.11";

    imports = with pkgs; [
      ./alacritty
      ./discord
      ./email
      ./firefox
      ./fish
      ./git
      ./gpg
      ./i3
      ./idea
      ./java
      ./minecraft
      ./onepassword
      ./rust
      ./screenshot
      ./ssh
      ./vscode
    ];

    home.packages = with pkgs; [
      spotify
      discord
      unetbootin
    ];
  };
}
