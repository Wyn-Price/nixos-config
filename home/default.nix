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
      ./email
      ./firefox
      ./fish
      ./git
      ./gpg
      ./i3
      ./onepassword
      ./rust
      ./screenshot
      ./spotify
      ./vscode
    ];
  };
}