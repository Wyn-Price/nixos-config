
{ config, pkgs, libs, ... }:
{
  # Headless specific stuff
  imports = [
    ./common.nix
    ./sshd
  ];
}
