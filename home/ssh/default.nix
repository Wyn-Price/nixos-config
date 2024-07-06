
{ config, pkgs, libs, ... }:
{
  programs.ssh = {
    enable = true;

    matchBlocks = {

      "uni.linux" = {
        hostname = "linux.bath.ac.uk";
        user = "wap24";
        forwardAgent = true;
      };

      "uni.parallel" = {
        hostname = "cm30225.hpc.bath.ac.uk";
        user = "wap24";
        forwardAgent = true;
      };

      stoneslab = {
        hostname = "192.168.1.87";
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

      pynq = {
        hostname = "192.168.0.114";
        forwardAgent = true;
        user = "xilinx";
      };

      "pynq-ext" = {
        hostname = "192.168.0.114";
        forwardAgent = true;
        proxyJump = "home.wynprice.com";
        user = "xilinx";
      };

    };

  };
}
