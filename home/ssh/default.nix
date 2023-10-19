
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
        proxyJump = "uni.linux";
      };

      stoneslab = {
        hostname = "192.168.0.110";
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

    };

  };
}
