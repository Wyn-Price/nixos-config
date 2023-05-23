{ config, pkgs, libs, ... }:
{

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wp = {
    isNormalUser = true;
    description = "Wyn Price";
    uid = 1000;
    group = "wp";
    extraGroups = [ "audio" "networkmanager" "wheel" "vboxusers" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
    openssh.authorizedKeys.keyFiles = [
      ./wp.ssh.key
    ];
  };

  users.groups.wp = {
    name = "wp";
    gid = 1000;
  };
}
