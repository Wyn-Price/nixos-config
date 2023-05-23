{ config, pkgs, libs, ... }:
{
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      bbenoist.nix
      shardulm94.trailing-spaces
      rust-lang.rust-analyzer
    ];
    keybindings = with builtins; fromJSON (readFile ./keybinds.json);
    userSettings = with builtins; fromJSON (readFile ./settings.json);
  };
}
