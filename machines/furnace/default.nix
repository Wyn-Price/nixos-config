
{ pkgs, config, lib, ... }:

{
  imports = with pkgs; [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
  ];

  service.mrpack-server = {
    enable = true;
    eula = true;

    servers.test = {
      enable = true;
      additionalInstallCommand = "${pkgs.forge-installer.forge-1-19-2}/bin/minecraftforge-installer-1.19.2";
      mrpack = ./create_vanilla.mrpack;
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
