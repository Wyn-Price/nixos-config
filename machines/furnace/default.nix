
{ pkgs, config, lib, ... }:

{
  imports = with pkgs; [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
  ];

  service.mrpack-server = {
    enable = true;

    servers.test = {
      enable = true;
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "furnace";
  networking.networkmanager.enable = true;
}
