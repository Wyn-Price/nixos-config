{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    rustup
    gcc
    libiconv
    openssl
    pkgconfig

    # Move to elsewhere?
    hotspot
    linuxKernel.packages.linux_6_1.perf
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    rust-lang.rust-analyzer
  ];

  home.sessionVariables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };
}
