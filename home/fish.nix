{ config, pkgs, libs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set fish_prompt_pwd_dir_length 20
      set -x EDITOR vim
      fish_vi_key_bindings
    '';
    plugins = [
      {
        name = "wp-theme";
        src = ./data/fish/wp-theme;
      }
    ];
  };
}