{ config, pkgs, libs, ... }:
{
  programs.gpg = {
    enable = true;
    publicKeys = [
        {
            source = ./data/public_key.gpg;
            trust = "ultimate";
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