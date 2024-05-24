{ config, pkgs, libs, ... }:
{
  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ./keys/me.gpg;
        trust = "ultimate";
      }
      {
        source = ./keys/archey.gpg;
        trust = "full";
      }
      {
        source = ./keys/chandler.gpg;
        trust = "full";
      }
      {
        source = ./keys/gpe.gpg;
        trust = "full";
      }
      {
        source = ./keys/hjf.gpg;
        trust = "full";
      }
      {
        source = ./keys/wjb.gpg;
        trust = "full";
      }
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    enableSshSupport = true;
    enableExtraSocket = true;
  };
}
