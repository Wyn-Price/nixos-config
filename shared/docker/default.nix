{ config, pkgs, libs, ... }:
{
  virtualisation.docker.enable = true;
  users.users.wp.extraGroups = [ "docker" ];
}