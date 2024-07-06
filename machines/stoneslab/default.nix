# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  service.mrpack-server = {
    enable = true;
    eula = true;

    servers.create_vanilla = {
      enable = false;
      additionalInstallCommand = "${pkgs.forge-installer.forge-1-19-2}/bin/minecraftforge-installer-1.19.2";
      mrpack = ./mrpacks/create_vanilla.mrpack;
    };

    servers.after_uni = {
      enable = false;
      additionalInstallCommand = "${pkgs.forge-installer.forge-1-20-1}/bin/minecraftforge-installer-1.20.1";
      mrpack = ./mrpacks/okay_this_is_epic.mrpack;
    };

    servers.crash_landing = {
      enable = false;
      java = pkgs.jdk8;
      modInstallCommand = "
        ${pkgs.unzip}/bin/unzip ${./mrpacks/crashlanding.zip} -d .tmp_extract

        cd .tmp_extract

        # Fully declarative, shold be replaced every time
        ${pkgs.coreutils}/bin/cp -rf config FTBServer-1.6.4-965.jar libraries mods server.properties ServerStart.sh ../

        # Only copy world if it doesnt exist
        if [ ! -d ../world ]; then
          ${pkgs.coreutils}/bin/cp -r world ../
        fi

        cd ..
        ${pkgs.coreutils}/bin/rm -r .tmp_extract

        ${pkgs.coreutils}/bin/ln -fs ServerStart.sh run.sh
        ${pkgs.coreutils}/bin/chmod +x run.sh

        ${pkgs.coreutils}/bin/rm -f banned-players.txt
      ";
    };


    servers.project_ozone_3 = {
      enable = true;
      java = pkgs.jdk8;
      modInstallCommand = let
        po3_server_zip = builtins.fetchzip {
            url = "https://edge.forgecdn.net/files/4345/112/PO3 - 3.4.11Fserver.zip";
            hash = "";
        };
      in
      "
        ${pkgs.coreutils}/bin/cp -rf ${po3_server_zip}/* .
        ${pkgs.coreutils}/bin/chmod +x run.sh

        # run.sh will be ran with the correct version of java
        echo java -Xmx6144M -Xms1024M -jar forge-1.12.2-14.23.5.2860.jar nogui > run.sh
        chmod +x run.sh
      ";
    };
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];

  services.cfdyndns = {
    enable = true;
    records = [ "home.wynprice.com" ];
    apiTokenFile = "/var/lib/wp/cfdyndns-api.key"; # Currently just has to be set after initilising machine, not great. TODO: secrets
  };

  services._3proxy = {
    enable = true;
    services = [
      {
        type = "socks";
        auth = [ "none" ];
        bindAddress = "127.0.0.1";
      }
    ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "stoneslab"; # Define your hostname.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     firefox
  #     thunderbird
  #   ];
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

