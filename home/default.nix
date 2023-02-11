{ config, pkgs, ... }:
{
    programs.home-manager.enable = true;
    home.stateVersion = "22.11";
    nixpkgs.config.allowUnfree = true;
    imports = with pkgs; [
      ./i3.nix
      ./alacritty.nix
      ./firefox.nix
      ./fish.nix
      ./git.nix
      ./gpg.nix
      ./vscode.nix
    ];
  # home-manager.users.wp = {
  #   # Match the configuration.nix state version
  #   # Need to find a way to properly abstract this to
  #   # the same file as configuration.nix
  #
  #

  #   # ...
  # };
}