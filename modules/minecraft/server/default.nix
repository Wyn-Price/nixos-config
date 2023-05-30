{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.service.mrpack-server;

  forgeOpts = { config, ... }: {
    url = mkOption {
      type = types.string;
      example = "https://maven.minecraftforge.net/net/minecraftforge/forge/1.19.2-43.2.12/forge-1.19.2-43.2.12-installer.jar";
      description = lib.mdDoc ''
        The download url for the forge jar
      '';
    };

    hash = mkOption {
      type = types.string;
      description = lib.mdDoc ''
        The hash of the download url
      '';
    };
  };

  # TODO: whitelist?
  serverOpts = { name, config, ... }: {
    options = {
      enable = mkEnableOption "Minecraft server service";

      mrpack = mkOption {
        type = types.path;
        description = lib.mdDoc ''
          The location of the mrpack file to run the server on.
        '';
      };

      java = mkOption {
        type = types.package;
        default = with pkgs; openjdk17;
        description = lib.mdDoc ''
          The java package to use. Defaults to java 17
        '';
      };

      entrypoint = mkOption {
        types = types.string;
        default = "./run.sh";
        description = lib.mdDoc ''
          The command to run to start the server. Defaults to ./start
        '';
      };

      serverProperties = mkOption {
        type = with types; attrsOf (oneOf [ bool int str ]);
        default = {};
        description = lib.mdDoc ''
          Server properties to override
        '';
      };

      forge = mkOption {
        type = types.submodule forgeOpts;
        description = lib.mdDoc ''
          Config for, the forge version to install, if any.
        '';
      };
    };
  };
in
{
  options = {
    service.mrpack-server = {
      enable = mkEnableOption "Whether the services is enabled at all";

      baseDir = mkOption {
        type = types.string;
        default = "/var/lib/minecraft";
        description = lib.mdDoc ''
          The base directory for all minecraft servers
        '';
      };

      servers = mkOption {
        type = with types; attrsOf (submodule serverOpts);
        default = {};
        description = lib.mdDoc ''
          mr-pack controlled minecraft server
        '';
      };
    };
  };


  # TODO: service that
  # Installs forge if needed
  # Runs mrpack-install on the mrpack
  # Also replaces the server.properties

  config = mkIf cfg.enable {
    users.users.minecraft = {
      description     = "Minecraft server service user";
      home            = cfg.baseDir;
      createHome      = true;
      isSystemUser    = true;
      group           = "minecraft";
    };
    users.groups.minecraft = {};

    systemd.services = concatMapAttrs (name: server: {
      ${name} = mkIf server.enable {
        enable = true;
      };
    }) cfg.servers;
  };
}