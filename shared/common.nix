{ config, pkgs, libs, inputs, ... }:
{
  nixpkgs = {
    overlays =
      [ inputs.nur.overlays.default ]
      ++ import ../overlay;
    config.allowUnfree = true;
  };

  home-manager.extraSpecialArgs = {
    inherit inputs;
  };

  environment.systemPackages = with pkgs; [
    home-manager
    htop
    vim

    # TODO: move networking stuff to own file?
    networkmanagerapplet
    openconnect
  ];

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = ["nix-command flakes"];

  programs.fish.enable = true;

  # Find a way to share this with the home manager?
  system.stateVersion = "22.11";

  imports = [
    ./localisation
    ./users
  ];
}
