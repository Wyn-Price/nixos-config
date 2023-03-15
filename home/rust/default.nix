{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    rustup
    gcc
    libiconv
    openssl
    pkgconfig
  ];

  home.sessionVariables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };
}
