{ config, pkgs, libs, ... }:
{
  virtualisation.virtualbox.host.enable = true;
  users.users.wp.extraGroups = [ "vboxusers" ];
}