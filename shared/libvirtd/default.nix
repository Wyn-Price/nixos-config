{ config, pkgs, libs, ... }:
{
  virtualisation.libvirtd.enable = true;
  users.users.wp.extraGroups = [ "libvirtd" ];
    environment.systemPackages = with pkgs; [
      virt-manager
    ];
}