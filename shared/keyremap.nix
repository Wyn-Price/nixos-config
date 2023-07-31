{ config, pkgs, libs, ... }:
{
    services.xserver.xkbOptions = "caps:escape";
}