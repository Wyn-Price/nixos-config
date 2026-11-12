
{ config, pkgs, libs, ... }:
{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      stoneslab = {
        hostname = "192.168.69.1";
        forwardAgent = true;
        remoteForwards = [
          {
            bind.address = "/run/user/1000/gnupg/S.gpg-agent";
            host.address = "/run/user/1000/gnupg/S.gpg-agent.extra";
          }
        ];
        extraOptions = {
          StreamLocalBindUnlink = "yes";
        };
      };

      home = {
        hostname = "home.wynprice.com";
        forwardAgent = true;
        remoteForwards = [
          {
            bind.address = "/run/user/1000/gnupg/S.gpg-agent";
            host.address = "/run/user/1000/gnupg/S.gpg-agent.extra";
          }
        ];
        extraOptions = {
          StreamLocalBindUnlink = "yes";
        };
      };

      "home.proxy" = {
        hostname = "home.wynprice.com";
        localForwards = [
          {
            bind.port = 1080;
            host.address = "127.0.0.1";
            host.port = 1080;
          }
        ];
      };
    };
  };
}
