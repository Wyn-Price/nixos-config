{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    openjdk8
  ];

  home.file."jdks/jdk8".source = pkgs.openjdk8;
  home.file."jdks/jdk11".source = pkgs.openjdk11;
}
