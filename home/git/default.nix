{ config, pkgs, libs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Wyn Price";
    userEmail = "github@wynprice.com";
    signing = {
        signByDefault = true;
        key = "A4086A465ED23C07";
    };
    extraConfig = {
      init.defaultBranch = "main";
      core.whitespace = "trailing-space,space-before-tab";
      apply.whitespace = "fix";
      push.autoSetupRemote = true;
    };
  };
  home.packages = with pkgs; [
    git-crypt
  ];
}