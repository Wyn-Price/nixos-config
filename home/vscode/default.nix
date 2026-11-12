{ config, pkgs, libs, ... }:
{
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        bbenoist.nix
        shardulm94.trailing-spaces
        eamodio.gitlens
      ];
      keybindings = with builtins; fromJSON (readFile ./keybinds.json);
      userSettings = with builtins; fromJSON (readFile ./settings.json);
    };
  };
}
