{ config, pkgs, libs, ... }:
{
  programs.git = {
    enable = true;
    signing = {
        signByDefault = true;
        key = "A4086A465ED23C07";
    };
    settings = {
      user = {
        name = "Wyn Price";
        email = "github@wynprice.com";
      };
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
