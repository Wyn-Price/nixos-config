{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];

  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
    james-yu.latex-workshop
    streetsidesoftware.code-spell-checker
  ];
}
