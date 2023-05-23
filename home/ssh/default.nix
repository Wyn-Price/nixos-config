
{ config, pkgs, libs, ... }:
{
  programs.ssh = {
    enable = true;

    matchBlocks = {

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
