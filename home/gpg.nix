{ config, pkgs, libs, ... }:
{
  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ./data/gpg/me.gpg;
        trust = "ultimate";
      }
      {
        source = ./data/gpg/archey.gpg;
        trust = "full";
      }
      {
        source = ./data/gpg/chandler.gpg;
        trust = "full";
      }
      {
        source = ./data/gpg/gpe.gpg;
        trust = "full";
      }
      {
        source = ./data/gpg/hjf.gpg;
        trust = "full";
      }
      {
        source = ./data/gpg/wjb.gpg;
        trust = "full";
      }
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    enableSshSupport = true;
    pinentryFlavor = "qt";
  };
}