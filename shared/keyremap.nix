{ config, pkgs, libs, ... }:
{
    services.xserver.xkb.options = "caps:escape";
}