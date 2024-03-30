{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # For parallel
    mpi

    # For dissertation, converting ppm to png
    netpbm

    # For dissertation, backup makefile
    gnumake
  ];
}