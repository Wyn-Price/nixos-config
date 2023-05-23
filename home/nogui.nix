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
      ./java
      ./i3
      ./minecraft
      ./onepassword
      ./rust
      ./screenshot
      ./vscode
    ];

    home.packages = with pkgs; [
      spotify
      discord
      unetbootin
    ];
  };
}
