{ config, pkgs, libs, ... }:
{
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      bbenoist.nix
      shardulm94.trailing-spaces
    ];
    keybindings = with builtins; fromJSON (readFile ./data/vscode/keybinds.json);
    userSettings = with builtins; fromJSON (readFile ./data/vscode/settings.json);
  };
}