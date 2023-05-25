{ config, pkgs, ... }:
{
  imports = with pkgs; [
    ./cfdyndns-wp
  ];
}

