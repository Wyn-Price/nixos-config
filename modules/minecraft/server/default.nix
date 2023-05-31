{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.service.mrpack-server;

  forgeOpts = { config, ... }: {
    url = mkOption {
      type = types.str;
      example = "https://maven.minecraftforge.net/net/minecraftforge/forge/1.19.2-43.2.12/forge-1.19.2-43.2.12-installer.jar";
      description = lib.mdDoc ''
        The download url for the forge jar
      '';
    };

    hash = mkOption {
      type = types.str;
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
        type = types.str;
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

   stopScript = pkgs.writeShellScript "minecraft-server-stop" ''
      echo stop > $1

      # Wait for the PID of the minecraft server to disappear before
      # returning, so systemd doesn't attempt to SIGKILL it.
      while kill -0 "$2" 2> /dev/null; do
        sleep 1s
      done
    '';
in
{
  options = {
    service.mrpack-server = {
      enable = mkEnableOption "Whether the services is enabled at all";

      baseDir = mkOption {
        type = types.str;
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
  #  - Installs forge if needed
  #  - Runs mrpack-install on the mrpack
  #  - Also replaces the server.properties
  #  - Whitelist?

  config = mkIf cfg.enable {
    users.users.minecraft = {
      description     = "Minecraft server service user";
      home            = cfg.baseDir;
      createHome      = true;
      isSystemUser    = true;
      group           = "minecraft";
    };
    users.groups.minecraft = {};

    systemd = mkMerge (mapAttrsToList (name: server:
      let
        service-name = "minecraft-server-mrpack-${name}";
        directory = "${cfg.baseDir}/${name}";
        forgeInstaller = mkIf (server?forge) (fetchurl {
          src = server.forge.url;
          sha256 = server.forge.hash;
        }) // "";
      in
      mkIf server.enable {
        sockets.minecraft-server = {
          bindsTo = [ "${service-name}.service" ];
          socketConfig = {
            ListenFIFO = "/run/minecraft-servers/${service-name}.stdin";
            SocketMode = "0660";
            SocketUser = "minecraft";
            SocketGroup = "minecraft";
            RemoveOnStop = true;
            FlushPending = true;
          };
        };

        services.${service-name} = {
          enable = true;

          description   = "Minecraft Server Service ${name}";
          wantedBy      = [ "multi-user.target" ];
          requires      = [ "${service-name}.socket" ];
          after         = [ "network.target" "${service-name}.socket" ];

          serviceConfig = {
            ExecStart = "PATH=${server.java}/bin:${pkgs.bash}/bin ";
            ExecStop = "${stopScript} ${name} $MAINPID";
            Restart = "always";
            User = "minecraft";
            WorkingDirectory = directory;

            StandardInput = "socket";
            StandardOutput = "journal";
            StandardError = "journal";

            # Hardening
            CapabilityBoundingSet = [ "" ];
            DeviceAllow = [ "" ];
            LockPersonality = true;
            PrivateDevices = true;
            PrivateTmp = true;
            PrivateUsers = true;
            ProtectClock = true;
            ProtectControlGroups = true;
            ProtectHome = true;
            ProtectHostname = true;
            ProtectKernelLogs = true;
            ProtectKernelModules = true;
            ProtectKernelTunables = true;
            ProtectProc = "invisible";
            RestrictAddressFamilies = [ "AF_INET" "AF_INET6" ];
            RestrictNamespaces = true;
            RestrictRealtime = true;
            RestrictSUIDSGID = true;
            SystemCallArchitectures = "native";
            UMask = "0077";
          };

          preStart =''
            echo ${forgeInstaller}
          '';
        };
      }
    ) cfg.servers);

      # systemd.services = concatMapAttrs (name: server: {
      #   "mincraft-server-mrpack-${name}" = mkIf server.enable {
      #     enable = true;
      #     # TODO HERE
      #   };
      # }) cfg.servers;
  };
}