
{ config, pkgs, libs, ... }:
{
# TODO: mix with default.nix
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    home-manager
    htop
    vim
  ];

  virtualisation.virtualbox.host.enable = true;

  nix.settings.experimental-features = "nix-command flakes";

  # Find a way to share this with the home manager?
  system.stateVersion = "22.11";

  imports = [
    ./localisation.nix
    ./sshd
    ./users
  ];
}
