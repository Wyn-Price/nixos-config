{ config, pkgs, libs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      bbenoist.nix
      shardulm94.trailing-spaces
    ];
  };
}