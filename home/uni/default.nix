{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # For parallel
    mpi

    # For dissertation, converting ppm to png
    imagemagick
  ];
}