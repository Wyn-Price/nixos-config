
{ config, pkgs, libs, ... }:
{

  nixpkgs.config.allowUnfree = true;
  environment.pathsToLink = [ "/libexec" ];
  environment.systemPackages = with pkgs; [ vim ];

  # Find a way to share this with the home manager?
  system.stateVersion = "22.11";

  imports = with pkgs; [
    ../misc

    ./i3.nix
    ./users.nix
  ];
}